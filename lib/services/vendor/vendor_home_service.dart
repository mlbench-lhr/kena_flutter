class VendorHomeService {
  // String tag = '[Vendor Home Service]';
  // final _vendorAuthRepo = VendorAuthRepository();
  // static void gotoVendorProfile(BuildContext context) {
  //   Navigator.pushNamed(context, RoutesName.vendorProfile);
  // }

  // static void gotoReviews(BuildContext context, {bool isVendor = true}) {
  //   Navigator.pushNamed(
  //     context,
  //     arguments: {'isVendor': isVendor},
  //     RoutesName.reviews,
  //   );
  // }

  // static void gotoChat(BuildContext context) {
  //   Navigator.pushNamed(context, RoutesName.vendorChatScreen);
  // }

  // Future<Map<String, dynamic>> getVendorReviews(
  //   BuildContext context, {
  //   required String productId,
  // }) async {
  //   try {
  //     final response = await _vendorAuthRepo.getReviews();
  //     return response;
  //   } catch (e) {
  //     if (context.mounted) ErrorHandler.handle(context, e, serviceName: tag);
  //     return {};
  //   }
  // }
  // Future<ReviewsModel?> getVendorReviews({
  //   required BuildContext context,
  //   int page = 1,
  //   int limit = 50,
  // }) async {
  //   try {
  //     final response = await _vendorAuthRepo.getReviews(
  //       query: '?page=$page&limit=$limit',
  //     );
  //     return ReviewsModel.fromJson(response);
  //   } catch (e) {
  //     if (context.mounted) {
  //       ErrorHandler.handle(context, e, serviceName: tag);
  //     }
  //     return null;
  //   }
  // }

  /// Submit a review for a user (Vendor action after meetup)
  // Future<bool> submitUserReview({
  //   required BuildContext context,
  //   required String message,
  //   required String userId,
  //   required int rating,
  // }) async {
  //   try {
  //     final data = {'message': message, 'rating': rating, 'userId': userId};
  //     await _vendorAuthRepo.addVendorReview(data);
  //     return true;
  //   } catch (e) {
  //     if (context.mounted) {
  //       ErrorHandler.handle(context, e, serviceName: tag);
  //     }
  //     return false;
  //   }
  // }

  ///
  ///getVendorWorkingHoursToday
  ///Returns a String of working hours of vendor "Today"
  ///
  // static String getVendorWorkingHoursToday({
  //   HoursModel? vendorHours,
  //   bool? isUserSide,
  // }) {
  //   debugPrint('🕐 [getVendorWorkingHoursToday] Called with:');
  //   debugPrint('   - vendorHours: ${vendorHours != null ? "Present" : "NULL"}');
  //   debugPrint('   - isUserSide: $isUserSide');

  //   final weekday = DateTime.now().weekday;
  //   debugPrint('   - Today is weekday: $weekday (1=Mon, 7=Sun)');

  //   late final HoursModel? hours;

  //   if (vendorHours != null) {
  //     hours = vendorHours;
  //     debugPrint('   ✓ Using provided vendorHours');
  //   } else if (isUserSide != null && isUserSide == true) {
  //     debugPrint('   ❌ No vendorHours + isUserSide=true → returning "0 hours"');
  //     return '0 hours';
  //   } else {
  //     final VendorModel vendor = SessionController().vendor!;
  //     hours = vendor.hours;
  //     debugPrint('   ✓ Using session vendor hours');
  //   }

  //   if (hours == null) {
  //     debugPrint('   ❌ Hours is NULL → returning "0 hours"');
  //     return '0 hours';
  //   }

  //   final day = switch (weekday) {
  //     DateTime.monday => hours.days.monday,
  //     DateTime.tuesday => hours.days.tuesday,
  //     DateTime.wednesday => hours.days.wednesday,
  //     DateTime.thursday => hours.days.thursday,
  //     DateTime.friday => hours.days.friday,
  //     DateTime.saturday => hours.days.saturday,
  //     DateTime.sunday => hours.days.sunday,
  //     _ => null,
  //   };

  //   debugPrint('   - Day object: ${day != null ? "Found" : "NULL"}');
  //   if (day != null) {
  //     debugPrint('   - Day enabled: ${day.enabled}');
  //     debugPrint('   - Day start: ${day.start}');
  //     debugPrint('   - Day end: ${day.end}');
  //   }

  //   // if (day == null || !day.enabled) return "Off";
  //   if (day == null || !day.enabled) {
  //     debugPrint('   ❌ Day is null or not enabled → returning "0 hours"');
  //     return "0 hours";
  //   }

  //   try {
  //     final s = day.start.split(":");
  //     final e = day.end.split(":");

  //     final startMinutes = int.parse(s[0]) * 60 + int.parse(s[1]);
  //     final endMinutes = int.parse(e[0]) * 60 + int.parse(e[1]);

  //     debugPrint('   - Start minutes: $startMinutes');
  //     debugPrint('   - End minutes: $endMinutes');

  //     // if (endMinutes <= startMinutes) return "Off";
  //     if (endMinutes <= startMinutes) {
  //       debugPrint('   ❌ End <= Start → returning "0 hours"');
  //       return "0 hours";
  //     }

  //     final diffMinutes = endMinutes - startMinutes;

  //     final hoursPart = diffMinutes ~/ 60; // integer hours
  //     final minutesPart = diffMinutes % 60; // remaining minutes

  //     debugPrint('   - Calculated hours: $hoursPart, minutes: $minutesPart');

  //     if (hoursPart > 0 && minutesPart > 0) {
  //       final result = "$hoursPart hours $minutesPart mins";
  //       debugPrint('   ✅ Returning: $result');
  //       return result;
  //     } else if (hoursPart > 0) {
  //       final result = "$hoursPart hours";
  //       debugPrint('   ✅ Returning: $result');
  //       return result;
  //     } else {
  //       final result = "$minutesPart mins";
  //       debugPrint('   ✅ Returning: $result');
  //       return result;
  //     }
  //   } catch (e) {
  //     debugPrint('   ❌ Exception during calculation: $e → returning "0 hours"');
  //     // return "Off";
  //     return "0 hours";
  //   }
  // }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:kena/app/routes/routes_name.dart';
// import 'package:kena/app/utils/service_error_handler.dart';
// import 'package:kena/model/vendor/vendor_model.dart';
// import 'package:kena/repository/vendor_auth_repo.dart';
// import 'package:kena/services/common/session_manager/session_controller.dart';

// class VendorHomeService {
//   static const String tag = '[VendorHomeService]';
//   static final _vendorAuthRepo = VendorAuthRepository();
//   static final _session = SessionController();

//   // ──────────────────────────────────────────────
//   // Navigation Helpers
//   // ──────────────────────────────────────────────

//   static void gotoVendorProfile(BuildContext context) {
//     debugPrint('$tag → Navigating to Vendor Profile');
//     Navigator.pushNamed(context, RoutesName.vendorProfile);
//   }

//   static void gotoReviews(BuildContext context, {bool isVendor = true}) {
//     debugPrint('$tag → Navigating to Reviews (isVendor: $isVendor)');
//     Navigator.pushNamed(
//       context,
//       RoutesName.reviews,
//       arguments: {'isVendor': isVendor},
//     );
//   }

//   static void gotoChat(BuildContext context) {
//     debugPrint('$tag → Navigating to Vendor Chat Screen');
//     Navigator.pushNamed(context, RoutesName.vendorChatScreen);
//   }

//   // ──────────────────────────────────────────────
//   // Fetch Vendor Reviews
//   // ──────────────────────────────────────────────

//   Future<ReviewsModel?> getVendorReviews({
//     required BuildContext context,
//     int page = 1,
//     int limit = 50,
//   }) async {
//     try {
//       final response = await _vendorAuthRepo.getReviews(
//         query: '?page=$page&limit=$limit',
//       );
//       return ReviewsModel.fromJson(response);
//     } catch (e) {
//       if (context.mounted) {
//         ErrorHandler.handle(context, e, serviceName: tag);
//       }
//       return null;
//     }
//   }

//   // ──────────────────────────────────────────────
//   // Submit User Review (Vendor → User)
//   // ──────────────────────────────────────────────

//   /// Submit a review for a user (Vendor action after meetup)
//   Future<bool> submitUserReview({
//     required BuildContext context,
//     required String message,
//     required String userId,
//     required int rating,
//   }) async {
//     try {
//       final data = {'message': message, 'rating': rating, 'userId': userId};
//       await _vendorAuthRepo.addVendorReview(data);
//       return true;
//     } catch (e) {
//       if (context.mounted) {
//         ErrorHandler.handle(context, e, serviceName: tag);
//       }
//       return false;
//     }
//   }

//   // ──────────────────────────────────────────────
//   // Get Vendor Working Hours Today (Improved + Debug)
//   // ──────────────────────────────────────────────

//   static String getVendorWorkingHoursToday({
//     HoursModel? vendorHours,
//     bool? isUserSide,
//   }) {
//     debugPrint('┌──────────────────────────────────────');
//     debugPrint('│ $tag → getVendorWorkingHoursToday()');
//     debugPrint('├──────────────────────────────────────');

//     final now = DateTime.now();
//     final weekday = now.weekday;
//     debugPrint(
//       '│ Today: ${now.toString().substring(0, 10)} (weekday: $weekday)',
//     );

//     late final HoursModel? hours;

//     if (vendorHours != null) {
//       hours = vendorHours;
//       debugPrint('│ ✓ Using provided vendorHours');
//     } else if (isUserSide == true) {
//       debugPrint('│ ✗ No vendorHours + isUserSide=true → returning "0 hours"');
//       debugPrint('└──────────────────────────────────────');
//       return '0 hours';
//     } else {
//       final vendor = _session.vendor;
//       hours = vendor?.hours;
//       debugPrint(
//         '│ ✓ Using session vendor hours (vendor exists: ${vendor != null})',
//       );
//     }

//     if (hours == null) {
//       debugPrint('│ ✗ Hours is NULL → returning "0 hours"');
//       debugPrint('└──────────────────────────────────────');
//       return '0 hours';
//     }

//     final day = switch (weekday) {
//       DateTime.monday => hours.days.monday,
//       DateTime.tuesday => hours.days.tuesday,
//       DateTime.wednesday => hours.days.wednesday,
//       DateTime.thursday => hours.days.thursday,
//       DateTime.friday => hours.days.friday,
//       DateTime.saturday => hours.days.saturday,
//       DateTime.sunday => hours.days.sunday,
//       _ => null,
//     };

//     debugPrint('│ Day object found: ${day != null}');

//     if (day == null || !day.enabled || day.start.isEmpty || day.end.isEmpty) {
//       debugPrint('│ ✗ Day invalid / disabled / empty → returning "0 hours"');
//       debugPrint('└──────────────────────────────────────');
//       return '0 hours';
//     }

//     debugPrint('│ Raw start: "${day.start}"');
//     debugPrint('│ Raw end:   "${day.end}"');

//     try {
//       // Try 12-hour format first (most common in pickers)
//       final format12 = DateFormat('h:mm a');
//       DateTime startTime;
//       DateTime endTime;

//       try {
//         startTime = format12.parse(day.start.trim());
//         endTime = format12.parse(day.end.trim());
//         debugPrint('│ ✓ Parsed as 12-hour format (AM/PM)');
//       } catch (_) {
//         // Fallback to 24-hour
//         final format24 = DateFormat('HH:mm');
//         startTime = format24.parse(day.start.trim());
//         endTime = format24.parse(day.end.trim());
//         debugPrint('│ ✓ Parsed as 24-hour format');
//       }

//       int startMinutes = startTime.hour * 60 + startTime.minute;
//       int endMinutes = endTime.hour * 60 + endTime.minute;

//       debugPrint('│ Start minutes: $startMinutes');
//       debugPrint('│ End minutes:   $endMinutes');

//       int diffMinutes = endMinutes - startMinutes;

//       // Handle overnight shift
//       if (diffMinutes <= 0) {
//         diffMinutes += 24 * 60;
//         debugPrint('│ → Detected overnight shift (+24h)');
//       }

//       final hoursPart = diffMinutes ~/ 60;
//       final minutesPart = diffMinutes % 60;

//       debugPrint('│ Calculated: $hoursPart h $minutesPart min');

//       String result;
//       if (hoursPart > 0 && minutesPart > 0) {
//         result = "$hoursPart hours $minutesPart mins";
//       } else if (hoursPart > 0) {
//         result = "$hoursPart hours";
//       } else if (minutesPart > 0) {
//         result = "$minutesPart mins";
//       } else {
//         result = "0 hours";
//       }

//       debugPrint('│ Final result: "$result"');
//       debugPrint('└──────────────────────────────────────');
//       return result;
//     } catch (e, stack) {
//       debugPrint('│ ✗ Failed to parse time: $e');
//       debugPrint('│ Stack: $stack');
//       debugPrint('└──────────────────────────────────────');
//       return "0 hours";
//     }
//   }
// }
