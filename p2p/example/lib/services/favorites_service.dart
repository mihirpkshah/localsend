import 'package:p2p/p2p.dart';
import 'package:p2p/src/model/favorite_device.dart';

/// An in-memory implementation of [FavoritesService].
///
/// In a real app, this would persist favorite devices (IP, alias, fingerprint) to disk.
class ExampleFavoritesService extends FavoritesService {
  @override
  List<FavoriteDevice> init() {
    // Start with an empty list of favorites.
    return [];
  }
}
