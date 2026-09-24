import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';

class SearchLocations {
  const SearchLocations(this._repository);

  final LocationRepository _repository;

  Future<List<Location>> call({
    required String query,
    required String language,
    RequestCancellation? cancellation,
  }) {
    return _repository.search(
      query,
      language: language,
      cancellation: cancellation,
    );
  }
}
