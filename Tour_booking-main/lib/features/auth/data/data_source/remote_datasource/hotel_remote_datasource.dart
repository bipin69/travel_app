import 'package:dio/dio.dart';
import 'package:hotel_booking/app/constants/api_endpoints.dart';
import 'package:hotel_booking/features/auth/data/model/hotel_api_model.dart';


class VenueRemoteDataSource {
  final Dio dio;

  VenueRemoteDataSource(this.dio);

  Future<List<VenueApiModel>> fetchVenues() async {
    try {
      final response =
          await dio.get('${ApiEndpoints.baseUrl}${ApiEndpoints.getAllVenue}');

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => VenueApiModel.fromJson(json))
            .toList();
      } else {
        throw Exception("Failed to load venues");
      }
    } catch (e) {
      throw Exception("Error fetching venues: $e");
    }
  }
}
