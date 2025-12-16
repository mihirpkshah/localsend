import 'package:common/isolate.dart';
import 'package:common/model/stored_security_context.dart';
import 'package:p2p/src/util/security_helper.dart';
import 'package:refena_flutter/refena_flutter.dart';

final persistenceProvider = Provider<PersistenceService>((ref) {
  throw 'PersistenceService not initialized. Override persistenceProvider.';
});

abstract class PersistenceService {
  StoredSecurityContext getSecurityContext();
  Future<void> setSecurityContext(StoredSecurityContext context);
  List<String>? getSignalingServers();
  List<String>? getStunServers();
}

/// This provider manages the [StoredSecurityContext].
/// It contains all the security related data for HTTPS communication.
final securityProvider = ReduxProvider<SecurityService, StoredSecurityContext>(
  (ref) {
    return SecurityService(ref.read(persistenceProvider));
  },
  onChanged: (_, next, ref) {
    ref
        .redux(parentIsolateProvider)
        .dispatch(IsolateSyncSecurityContextAction(securityContext: next));
  },
);

class SecurityService extends ReduxNotifier<StoredSecurityContext> {
  final PersistenceService _persistence;

  SecurityService(this._persistence);

  @override
  StoredSecurityContext init() {
    return _persistence.getSecurityContext();
  }
}

/// Generates a new [StoredSecurityContext] and persists it.
class ResetSecurityContextAction
    extends AsyncReduxAction<SecurityService, StoredSecurityContext> {
  @override
  Future<StoredSecurityContext> reduce() async {
    final securityContext = generateSecurityContext();
    await notifier._persistence.setSecurityContext(securityContext);
    return securityContext;
  }
}
