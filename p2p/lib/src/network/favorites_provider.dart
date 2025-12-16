import 'package:p2p/src/model/favorite_device.dart';
import 'package:refena_flutter/refena_flutter.dart';

final favoritesProvider =
    ReduxProvider<FavoritesService, List<FavoriteDevice>>((ref) {
  throw UnimplementedError('Override favoritesProvider');
});

abstract class FavoritesService extends ReduxNotifier<List<FavoriteDevice>> {}

class UpdateFavoriteAction
    extends ReduxAction<FavoritesService, List<FavoriteDevice>> {
  final FavoriteDevice device;

  UpdateFavoriteAction(this.device);

  @override
  List<FavoriteDevice> reduce() {
    return state
        .map((e) => e.fingerprint == device.fingerprint ? device : e)
        .toList();
  }
}
