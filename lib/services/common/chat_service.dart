// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kena/app/utils/extensions/flush_bar_extension.dart';
// import 'package:kena/model/chat/chat_model.dart';
// // TODO: Enable when push notifications are ready\n// import 'package:kena/services/common/notifications_service.dart';

// class LiveChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String _collection = 'chats';
//   // TODO: Enable when push notifications are ready\n  // final NotificationsService _notificationsService = NotificationsService();

//   // Helper method to ensure chat document exists (MANDATORY ADDITION)

//   Future<void> ensureChatExists(
//     BuildContext context,
//     String chatId,
//     String yourId,
//     String yourName,
//     String receiverId, { // ← removed initialMessage parameter
//     String? userImage,
//     double userAverageRating = 0.0,
//   }) async {
//     try {
//       final chatDoc = _firestore.collection(_collection).doc(chatId);

//       final docSnapshot = await chatDoc.get();

//       if (!docSnapshot.exists) {
//         // Create EMPTY chat document – NO initial message
//         await chatDoc.set({
//           'participants': [yourId, receiverId],
//           'userId': yourId,
//           'userName': yourName,
//           'userImage': userImage ?? '',
//           'userAverageRating': userAverageRating,
//           'vendorId': receiverId,
//           'createdAt': FieldValue.serverTimestamp(),
//           'lastMessageAt': FieldValue.serverTimestamp(),
//           'status': 'active',
//           'unreadCount': 0, // ← good to initialize explicitly
//         }, SetOptions(merge: true));

//         debugPrint('New EMPTY chat document created for $chatId');
//       } else {
//         // Chat already exists → just update user info if needed
//         final existingData = docSnapshot.data()!;
//         if (existingData['userId'] == yourId) {
//           final updates = <String, dynamic>{};

//           if (existingData['userName'] != yourName && yourName.isNotEmpty) {
//             updates['userName'] = yourName;
//           }
//           if (userImage != null &&
//               userImage.isNotEmpty &&
//               existingData['userImage'] != userImage) {
//             updates['userImage'] = userImage;
//           }
//           if (userAverageRating > 0 &&
//               existingData['userAverageRating'] != userAverageRating) {
//             updates['userAverageRating'] = userAverageRating;
//           }

//           if (updates.isNotEmpty) {
//             await chatDoc.update(updates);
//           }
//         }
//         debugPrint('Chat already exists for $chatId');
//       }

//       // Optional: You can keep or remove the placeholder '_init' document
//       // Modern Firestore doesn't require subcollections to be pre-created
//       // So you can safely remove this part if you want:
//       /*
//     final messagesColl = chatDoc.collection('messages');
//     final messagesSnapshot = await messagesColl.limit(1).get();
//     if (messagesSnapshot.docs.isEmpty) {
//       await messagesColl.doc('_init').set({
//         'type': 'init',
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//     */
//     } catch (e, st) {
//       debugPrint('Error ensuring chat exists: $e\n$st');
//       // We still let the app continue — message sending will create collections
//     }
//   }

//   // Send a message (MODIFIED)
//   Future<void> addMessageToFirestore(String chatId, ChatMessage message) async {
//     try {
//       final chatRef = _firestore.collection(_collection).doc(chatId);

//       // Get chat document to check vendorId
//       final chatDoc = await chatRef.get();
//       if (!chatDoc.exists) {
//         debugPrint('Chat document not found for $chatId');
//         // If chat doesn't exist, we can't reliably determine vendorId to update unreadCount
//         // But we should still try to add the message
//       }

//       final data = chatDoc.data();
//       final vendorId = data?['vendorId'] as String?;

//       final updates = <String, dynamic>{'lastMessageAt': Timestamp.now()};

//       // Increment unread count only if sender is NOT the vendor
//       // (This implies the user is sending, so vendor has a new unread message)
//       if (vendorId != null && message.senderId != vendorId) {
//         updates['unreadCount'] = FieldValue.increment(1);
//       } else if (vendorId == null) {
//         // Fallback: if we can't determine vendorId, maybe default to increment?
//         // Or safer to skip increment to avoid vendor seeing ghost unread messages.
//         // Given ensureChatExists sets vendorId, this should rarely happen for valid chats.
//       }

//       // Add the message to subcollection
//       await chatRef.collection('messages').add(message.toMap());

//       // Update chat document
//       await chatRef.update(updates);
//     } catch (e) {
//       throw Exception('Failed to send message: $e');
//     }
//   }

//   // Get messages stream (real-time)
//   Stream<List<ChatMessage>> getMessages(String chatId) {
//     debugPrint('GET Chat ID: $chatId');
//     return _firestore
//         .collection(_collection)
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.docs.map(ChatMessage.fromFirestore).toList(),
//         );
//   }

//   //format date / time
//   static String formatChatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);

//     // Case 0: Just now (<1 minute)
//     if (difference.inMinutes < 1) {
//       return 'Just now';
//     }

//     // Case 1: Less than 1 hour → show minutes
//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes} min ago';
//     }

//     // Normalize dates to midnight for comparison
//     final today = DateTime(now.year, now.month, now.day);
//     final msgDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
//     final dayDiff = today.difference(msgDate).inDays;

//     // Case 2: Today → show "Today" with time (e.g., Today, 5:34 PM)
//     if (dayDiff == 0) {
//       return 'Today, ${DateFormat.jm().format(timestamp)}';
//     }

//     // Case 3: Yesterday → show "Yesterday" with time (e.g., Yesterday, 5:34 PM)
//     if (dayDiff == 1) {
//       return 'Yesterday, ${DateFormat.jm().format(timestamp)}';
//     }

//     // Case 4: Within the past week → show day of the week with time (e.g., Monday, 2:30 PM)
//     if (dayDiff < 7) {
//       return '${DateFormat.EEEE().format(timestamp)}, ${DateFormat.jm().format(timestamp)}';
//     }

//     // Case 5: Older → show date (locale-aware, e.g., 12/09/24 or 12 Sep 2024)
//     final format = now.year == timestamp.year ? 'd MMM' : 'd MMM yyyy';
//     return DateFormat(format).format(timestamp);
//   }

//   //Generate Message Id
//   String generateMessageId() {
//     final millis = DateTime.now().microsecondsSinceEpoch;
//     final random = Random().nextInt(99999); // up to 5-digit random
//     return 'msg$millis$random';
//   }

//   Future<void> sendMessage(
//     BuildContext context,
//     String chatId,
//     String messageBody,
//     String yourId,
//     String yourName,
//     String receiverId,
//   ) async {
//     if (messageBody.isEmpty) return;

//     final message = ChatMessage(
//       id: generateMessageId(),
//       text: messageBody,
//       senderId: yourId,
//       senderName: yourName,
//       timestamp: DateTime.now(),
//     );
//     debugPrint('MESSAGE TO SEND: ${message.toJson()}');

//     try {
//       await addMessageToFirestore(chatId, message);
//       debugPrint('MESSAGE SENT SUCCESSFULLY');
//       // TODO: Enable push notifications when ready
//       // try {
//       //   await _notificationsService.pushNotification(
//       //     // ignore: use_build_context_synchronously
//       //     context,
//       //     receiverId,
//       //     yourName,
//       //     messageBody,
//       //   );
//       // } catch (e) {
//       //   debugPrint('Failed to send notification: $e');
//       // }
//     } catch (e) {
//       // Handle error
//       if (context.mounted) {
//         context.flushBarErrorMessage(message: 'Failed to send message');
//       }
//       debugPrint('Failed to send message with ERROR: $e');
//     }
//   }

//   // Close/end the chat session between user and vendor
//   Future<void> closeChat(BuildContext context, String chatId) async {
//     try {
//       // Update chat status to closed
//       await _firestore.collection(_collection).doc(chatId).update({
//         'status': 'closed',
//         'closedAt': FieldValue.serverTimestamp(),
//       });
//       if (context.mounted) {
//         Navigator.of(context).pop();
//       }
//     } catch (e) {
//       if (context.mounted) {
//         debugPrint('Failed to end chat: $e');
//         context.flushBarErrorMessage(message: 'Failed to end chat...');
//       }
//     }
//   }

//   // Mark chat as read (reset unread count)
//   Future<void> markChatAsRead(String chatId) async {
//     try {
//       await _firestore.collection(_collection).doc(chatId).update({
//         'unreadCount': 0,
//       });
//       debugPrint('Chat marked as read: $chatId');
//     } catch (e) {
//       debugPrint('Failed to mark chat as read: $e');
//     }
//   }

//   /// Get total unread count for a vendor (includes unread messages + pending meetup requests)
//   Stream<int> getTotalUnreadCountForVendor(String vendorId) {
//     return _firestore
//         .collection(_collection)
//         .where('vendorId', isEqualTo: vendorId)
//         .snapshots()
//         .map((snapshot) {
//           int totalUnread = 0;

//           // Count unread messages and pending meetups from chat documents
//           for (final doc in snapshot.docs) {
//             final data = doc.data();
//             final messageCount = (data['unreadCount'] ?? 0) as int;
//             final meetupCount = (data['pendingMeetupCount'] ?? 0) as int;

//             totalUnread += messageCount + meetupCount;
//           }

//           if (totalUnread > 0) {
//             debugPrint('🔴 Badge Total: $totalUnread');
//           }
//           return totalUnread;
//         });
//   }

//   /// Update user's average rating in a specific chat document
//   Future<void> updateUserAverageRating(
//     String chatId,
//     double averageRating,
//   ) async {
//     try {
//       await _firestore.collection(_collection).doc(chatId).update({
//         'userAverageRating': averageRating,
//       });
//       debugPrint('User average rating updated in chat: $chatId');
//     } catch (e) {
//       debugPrint('Failed to update user average rating: $e');
//     }
//   }

//   // Get all chats for a vendor (streams real-time updates)
//   Stream<List<ChatSummary>> getVendorChats(String vendorId) {
//     debugPrint('getVendorChats called with vendorId: $vendorId');

//     // Use vendorId field for simpler query (no composite index needed)
//     return _firestore
//         .collection(_collection)
//         .where('vendorId', isEqualTo: vendorId)
//         .snapshots()
//         .handleError((error) {
//           debugPrint('Firestore error in getVendorChats: $error');
//         })
//         .asyncMap((snapshot) async {
//           debugPrint(
//             'getVendorChats - Found ${snapshot.docs.length} chat documents',
//           );
//           final List<ChatSummary> chats = [];

//           // Collect all user IDs for bulk presence check
//           final userIds = snapshot.docs
//               .map((doc) => doc.data()['userId'] as String?)
//               .where((id) => id != null)
//               .cast<String>()
//               .toList();

//           for (final doc in snapshot.docs) {
//             final data = doc.data();
//             final chatId = doc.id;

//             // Get the last message from the messages subcollection
//             final messagesSnapshot = await _firestore
//                 .collection(_collection)
//                 .doc(chatId)
//                 .collection('messages')
//                 .orderBy('timestamp', descending: true)
//                 .limit(1)
//                 .get();

//             String lastMessage = '';
//             DateTime? lastMessageTime;
//             String lastSenderId = '';

//             if (messagesSnapshot.docs.isNotEmpty) {
//               final msgData = messagesSnapshot.docs.first.data();
//               lastMessage = msgData['text'] ?? '';
//               lastSenderId = msgData['senderId'] ?? '';
//               if (msgData['timestamp'] != null) {
//                 lastMessageTime = (msgData['timestamp'] as Timestamp).toDate();
//               }
//             }

//             // Get user info from the chat document
//             final userName = data['userName'] ?? 'User';
//             final userImage = data['userImage'] ?? '';
//             final userId = data['userId'] ?? '';
//             final status = data['status'] ?? 'active';
//             final unreadCount = (data['unreadCount'] as num?)?.toInt() ?? 0;

//             final userAverageRating =
//                 (data['userAverageRating'] as num?)?.toDouble() ?? 0.0;

//             chats.add(
//               ChatSummary(
//                 chatId: chatId,
//                 userName: userName,
//                 userImage: userImage,
//                 userId: userId,
//                 lastMessage: lastMessage,
//                 lastMessageTime: lastMessageTime ?? DateTime.now(),
//                 lastSenderId: lastSenderId,
//                 status: status,
//                 unreadCount: unreadCount,
//                 userAverageRating: userAverageRating,
//               ),
//             );
//           }

//           return chats;
//         });
//   }

//   // ============= MEETUP REQUEST METHODS =============

//   /// Generate a random 6-digit verification code
//   String generateVerificationCode() {
//     final random = Random();
//     return (100000 + random.nextInt(900000)).toString(); // 6-digit code
//   }

//   /// Generate a unique meetup request ID
//   String generateMeetupRequestId() {
//     final millis = DateTime.now().microsecondsSinceEpoch;
//     final random = Random().nextInt(99999);
//     return 'mr_$millis$random';
//   }

//   /// Create a new meetup request in Firebase
//   Future<MeetupRequest?> createMeetupRequest({
//     required String chatId,
//     required String userId,
//     required String vendorId,
//   }) async {
//     try {
//       final requestId = generateMeetupRequestId();
//       final verificationCode = generateVerificationCode();

//       final request = MeetupRequest(
//         requestId: requestId,
//         chatId: chatId,
//         userId: userId,
//         vendorId: vendorId,
//         verificationCode: verificationCode,
//         status: MeetupStatus.pending,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );

//       await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .set(request.toMap());

//       // Increment pending meetup count in main chat document
//       // This triggers the badge stream to update
//       await _firestore.collection(_collection).doc(chatId).update({
//         'pendingMeetupCount': FieldValue.increment(1),
//       });

//       debugPrint(
//         'Meetup request created: $requestId with code: $verificationCode',
//       );
//       return request;
//     } catch (e) {
//       debugPrint('Failed to create meetup request: $e');
//       return null;
//     }
//   }

//   /// Get stream of meetup requests for a chat
//   Stream<List<MeetupRequest>> getMeetupRequests(String chatId) {
//     return _firestore
//         .collection(_collection)
//         .doc(chatId)
//         .collection('meetup_requests')
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map(
//           (snapshot) => snapshot.docs
//               .map((doc) => MeetupRequest.fromMap(doc.data()))
//               .toList(),
//         );
//   }

//   /// Get the latest meetup request for a chat
//   Stream<MeetupRequest?> getLatestMeetupRequest(String chatId) {
//     return _firestore
//         .collection(_collection)
//         .doc(chatId)
//         .collection('meetup_requests')
//         .orderBy('createdAt', descending: true)
//         .limit(1)
//         .snapshots()
//         .map((snapshot) {
//           if (snapshot.docs.isEmpty) return null;
//           return MeetupRequest.fromMap(snapshot.docs.first.data());
//         });
//   }

//   /// Accept a meetup request (Vendor action)
//   Future<bool> acceptMeetupRequest(String chatId, String requestId) async {
//     try {
//       await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .update({'status': 'accepted', 'updatedAt': Timestamp.now()});
//       debugPrint('Meetup request accepted: $requestId');
//       return true;
//     } catch (e) {
//       debugPrint('Failed to accept meetup request: $e');
//       return false;
//     }
//   }

//   /// Reject a meetup request
//   Future<bool> rejectMeetupRequest(
//     String chatId,
//     String requestId,
//     String rejectedBy, // 'user' or 'vendor'
//   ) async {
//     try {
//       await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .update({
//             'status': 'rejected',
//             'updatedAt': Timestamp.now(),
//             'rejectedBy': rejectedBy,
//           });
//       debugPrint('Meetup request rejected by $rejectedBy: $requestId');
//       return true;
//     } catch (e) {
//       debugPrint('Failed to reject meetup request: $e');
//       return false;
//     }
//   }

//   /// Verify the meetup code entered by user
//   Future<bool> verifyMeetupCode(
//     String chatId,
//     String requestId,
//     String enteredCode,
//   ) async {
//     try {
//       final doc = await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .get();

//       if (!doc.exists) {
//         debugPrint('Meetup request not found: $requestId');
//         return false;
//       }

//       final request = MeetupRequest.fromMap(doc.data()!);

//       if (request.verificationCode == enteredCode) {
//         await _firestore
//             .collection(_collection)
//             .doc(chatId)
//             .collection('meetup_requests')
//             .doc(requestId)
//             .update({
//               'status': 'completed',
//               'updatedAt': Timestamp.now(),
//               'completedAt': Timestamp.now(),
//             });
//         debugPrint('Meetup request verified and completed: $requestId');
//         return true;
//       } else {
//         debugPrint('Invalid verification code entered');
//         return false;
//       }
//     } catch (e) {
//       debugPrint('Failed to verify meetup code: $e');
//       return false;
//     }
//   }

//   /// Mark meetup as reviewed by vendor (to prevent showing review sheet again)
//   Future<void> markMeetupAsVendorReviewed(
//     String chatId,
//     String requestId,
//   ) async {
//     try {
//       await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .update({'vendorReviewed': true});
//       debugPrint('Meetup marked as vendor reviewed: $requestId');
//     } catch (e) {
//       debugPrint('Failed to mark meetup as vendor reviewed: $e');
//     }
//   }

//   /// Mark meetup as reviewed by user (to prevent showing review sheet again)
//   Future<void> markMeetupAsUserReviewed(String chatId, String requestId) async {
//     try {
//       await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .doc(requestId)
//           .update({'userReviewed': true});
//       debugPrint('Meetup marked as user reviewed: $requestId');
//     } catch (e) {
//       debugPrint('Failed to mark meetup as user reviewed: $e');
//     }
//   }

//   /// Mark all pending meetup requests in a chat as viewed by vendor
//   Future<void> markPendingMeetupsAsViewed(String chatId) async {
//     try {
//       // Get ALL pending requests in this chat
//       final pendingRequests = await _firestore
//           .collection(_collection)
//           .doc(chatId)
//           .collection('meetup_requests')
//           .where('status', isEqualTo: 'pending')
//           .get();

//       int updatedCount = 0;
//       int remainingUnviewedCount = 0;

//       for (final doc in pendingRequests.docs) {
//         final data = doc.data();
//         final alreadyViewed = data['vendorViewed'] ?? false;

//         // Only update if not already viewed
//         if (!alreadyViewed) {
//           await doc.reference.update({'vendorViewed': true});
//           updatedCount++;
//         } else {
//           // Count requests that remain unviewed (shouldn't happen but handle it)
//           remainingUnviewedCount++;
//         }
//       }

//       // Set pendingMeetupCount to the number of remaining unviewed requests
//       // When vendor opens chat, this will mark all as viewed, so count becomes 0
//       // But if somehow some remain unviewed, the count will reflect that
//       await _firestore.collection(_collection).doc(chatId).update({
//         'pendingMeetupCount': remainingUnviewedCount,
//       });

//       // Log results
//       if (updatedCount > 0) {
//         debugPrint(
//           '✅ Marked $updatedCount pending meetup${updatedCount > 1 ? 's' : ''} as viewed',
//         );
//       }

//       debugPrint(
//         '✅ Set pendingMeetupCount to $remainingUnviewedCount for chat $chatId',
//       );
//     } catch (e) {
//       debugPrint('❌ Failed to mark pending meetups as viewed: $e');
//     }
//   }
// }

// // ============= MODELS =============

// /// Meetup request status enum
// enum MeetupStatus { pending, accepted, rejected, completed }

// /// Model for meetup request
// class MeetupRequest {
//   final String requestId;
//   final String chatId;
//   final String userId;
//   final String vendorId;
//   final String verificationCode;
//   final MeetupStatus status;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? completedAt;
//   final bool vendorReviewed;
//   final bool userReviewed;
//   final bool vendorViewed; // Track if vendor has seen the request
//   final String? rejectedBy; // 'user' or 'vendor'

//   MeetupRequest({
//     required this.requestId,
//     required this.chatId,
//     required this.userId,
//     required this.vendorId,
//     required this.verificationCode,
//     required this.status,
//     required this.createdAt,
//     required this.updatedAt,
//     this.completedAt,
//     this.vendorReviewed = false,
//     this.userReviewed = false,
//     this.vendorViewed = false,
//     this.rejectedBy,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'requestId': requestId,
//       'chatId': chatId,
//       'userId': userId,
//       'vendorId': vendorId,
//       'verificationCode': verificationCode,
//       'status': status.name,
//       'createdAt': Timestamp.fromDate(createdAt),
//       'updatedAt': Timestamp.fromDate(updatedAt),
//       'completedAt': completedAt != null
//           ? Timestamp.fromDate(completedAt!)
//           : null,
//       'vendorReviewed': vendorReviewed,
//       'userReviewed': userReviewed,
//       'vendorViewed': vendorViewed,
//       'rejectedBy': rejectedBy,
//     };
//   }

//   factory MeetupRequest.fromMap(Map<String, dynamic> map) {
//     return MeetupRequest(
//       requestId: map['requestId'] ?? '',
//       chatId: map['chatId'] ?? '',
//       userId: map['userId'] ?? '',
//       vendorId: map['vendorId'] ?? '',
//       verificationCode: map['verificationCode'] ?? '',
//       status: MeetupStatus.values.firstWhere(
//         (e) => e.name == map['status'],
//         orElse: () => MeetupStatus.pending,
//       ),
//       createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       completedAt: (map['completedAt'] as Timestamp?)?.toDate(),
//       vendorReviewed: map['vendorReviewed'] ?? false,
//       userReviewed: map['userReviewed'] ?? false,
//       vendorViewed: map['vendorViewed'] ?? false,
//       rejectedBy: map['rejectedBy'] as String?,
//     );
//   }
// }

// // Model for chat summary in the list
// class ChatSummary {
//   final String chatId;
//   final String userName;
//   final String userImage;
//   final String userId;
//   final String lastMessage;
//   final DateTime lastMessageTime;
//   final String lastSenderId;
//   final String status;
//   final int unreadCount;
//   final double userAverageRating;
//   final bool isUserOnline;
//   final DateTime? lastSeen;

//   ChatSummary({
//     required this.chatId,
//     required this.userName,
//     required this.userImage,
//     required this.userId,
//     required this.lastMessage,
//     required this.lastMessageTime,
//     required this.lastSenderId,
//     required this.status,
//     required this.unreadCount,
//     this.userAverageRating = 0.0,
//     this.isUserOnline = false,
//     this.lastSeen,
//   });
// }
