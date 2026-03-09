import 'package:kena/app/network/base_api_services.dart';
import 'package:kena/app/network/network_api_services.dart';
import 'package:kena/app/utils/app_url.dart';

class UserHomeRepository {
  final BaseApiServices _apiServices = NetworkApiService();

  //Get notifications (for both user and vendor)
  Future<Map<String, dynamic>> getNotifications() async {
    return _apiServices.get(url: AppUrl.getNotifications);
  }

  Future<Map<String, dynamic>> getNearbyVendors({String query = ''}) async {
    return _apiServices.get(url: '${AppUrl.getNearbyVendors}?$query');
  }

  Future<Map<String, dynamic>> getVendorDetails({
    required String vendorId,
  }) async {
    return _apiServices.get(url: AppUrl.getVendorDetails(vendorId));
  }

  //get reviews
  Future<Map<String, dynamic>> getVendorReviews({
    String query = '',
    required String vendorId,
  }) async {
    return _apiServices.get(
      url: '${AppUrl.getVendorReviewsById(vendorId)}?$query',
    );
  }

  // get User Review that he will get from vendors
  Future<Map<String, dynamic>> getUserReviews() async {
    return _apiServices.get(url: AppUrl.getUserReviews);
  }

  //add to favorites
  Future<Map<String, dynamic>> addToFavorites({
    required String vendorId,
  }) async {
    final data = {'vendorId': vendorId};
    return _apiServices.post(url: AppUrl.addToFavorites, data: data);
  }

  //decrement meetup requests remaining
  Future<Map<String, dynamic>> decrementRequests() async {
    return _apiServices.put(url: AppUrl.decrementRequests, data: {});
  }
}
