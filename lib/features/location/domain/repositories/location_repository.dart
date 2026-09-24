import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';

abstract interface class LocationRepository {
  Future<List<Location>> search(
    String query, {
    required String language,
    RequestCancellation? cancellation,
  });
}
