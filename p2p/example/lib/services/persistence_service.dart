import 'package:common/model/stored_security_context.dart';
import 'package:p2p/p2p.dart';

/// An in-memory implementation of [PersistenceService] for demonstration purposes.
///
/// In a real app (like LocalSend), this would interact with secure storage
/// to persist the private key and certificate.
class ExamplePersistenceService implements PersistenceService {
  StoredSecurityContext? _cachedContext;

  @override
  StoredSecurityContext getSecurityContext() {
    if (_cachedContext == null) {
      // Generate a new context on every app restart.
      // This means the device identity change every time you kill the app.
      _cachedContext = generateSecurityContext();
    }
    return _cachedContext!;
  }

  @override
  Future<void> setSecurityContext(StoredSecurityContext context) async {
    _cachedContext = context;
  }

  @override
  List<String>? getSignalingServers() {
    return null; // Use defaults
  }

  @override
  List<String>? getStunServers() {
    return null; // Use defaults
  }
}
