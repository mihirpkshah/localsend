import 'package:localsend_app/provider/persistence_provider.dart';
import 'package:p2p/p2p.dart'
    hide FavoritesService, favoritesProvider, UpdateFavoriteAction, PersistenceService, persistenceProvider, securityProvider;
import 'package:p2p/p2p.dart' as p2p;
import 'package:refena_flutter/refena_flutter.dart';

/// This provider stores the list of favorite devices.
/// It automatically saves the list to the device's storage.
final favoritesProvider = ReduxProvider<FavoritesService, List<FavoriteDevice>>(
  (ref) {
    return FavoritesService(ref.read(persistenceProvider));
  },
  onChanged: (_, next, ref) {
    ref.read(persistenceProvider).setFavorites(next);
  },
);

class FavoritesService extends p2p.FavoritesService {
  final PersistenceService _persistence;

  FavoritesService(this._persistence);

  @override
  List<FavoriteDevice> init() => _persistence.getFavorites();
}

/// Adds a favorite device.
class AddFavoriteAction extends ReduxAction<FavoritesService, List<FavoriteDevice>> {
  final FavoriteDevice device;

  AddFavoriteAction(this.device);

  @override
  List<FavoriteDevice> reduce() {
    return [
      ...state,
      device,
    ];
  }
}

/// Updates a favorite device.
class UpdateFavoriteAction extends ReduxAction<FavoritesService, List<FavoriteDevice>> {
  final FavoriteDevice device;

  UpdateFavoriteAction(this.device);

  @override
  List<FavoriteDevice> reduce() {
    final index = state.indexWhere((e) => e.id == device.id);
    if (index == -1) {
      return state;
    }
    return List<FavoriteDevice>.from(state)..[index] = device;
  }
}

/// Removes a favorite device.
class RemoveFavoriteAction extends ReduxAction<FavoritesService, List<FavoriteDevice>> {
  final String deviceFingerprint;

  RemoveFavoriteAction({
    required this.deviceFingerprint,
  });

  @override
  List<FavoriteDevice> reduce() {
    return state.where((e) => e.fingerprint != deviceFingerprint).toList();
  }
}
