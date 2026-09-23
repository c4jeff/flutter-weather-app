import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/json_api_client.dart';
import '../data/location_repository.dart';
import '../domain/location.dart';

final apiClientProvider = Provider<JsonApiClient>((ref) => JsonApiClient());

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepository(ref.watch(apiClientProvider)),
);

final locationSearchProvider = FutureProvider.autoDispose
    .family<List<Location>, String>((ref, query) {
      return ref.watch(locationRepositoryProvider).search(query);
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
