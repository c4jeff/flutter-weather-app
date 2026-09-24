import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/core/cancellation/request_cancellation.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/domain/repositories/location_repository.dart';
import 'package:weather_app/features/location/domain/use_cases/search_locations.dart';

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => throw UnimplementedError(),
);

final searchLocationsProvider = Provider<SearchLocations>(
  (ref) => SearchLocations(ref.watch(locationRepositoryProvider)),
);

final locationSearchProvider = FutureProvider.autoDispose
    .family<List<Location>, ({String query, String language})>((ref, request) {
      final cancellation = RequestCancellation();
      ref.onDispose(cancellation.cancel);
      return ref
          .watch(searchLocationsProvider)
          .call(
            query: request.query,
            language: request.language,
            cancellation: cancellation,
          );
    });

class SelectedLocationNotifier extends Notifier<Location?> {
  @override
  Location? build() => null;

  void select(Location location) => state = location;
}

final selectedLocationProvider =
    NotifierProvider<SelectedLocationNotifier, Location?>(
      SelectedLocationNotifier.new,
    );
