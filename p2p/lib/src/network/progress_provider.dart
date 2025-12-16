import 'package:refena_flutter/refena_flutter.dart';

final progressProvider =
    NotifierProvider<P2PProgressNotifier, Map<String, Map<String, double>>>(
        (ref) {
  return P2PProgressNotifier();
});

class P2PProgressNotifier extends Notifier<Map<String, Map<String, double>>> {
  @override
  Map<String, Map<String, double>> init() {
    return {};
  }

  void setProgress({
    required String sessionId,
    required String fileId,
    required double progress,
  }) {
    state = {
      ...state,
      sessionId: {
        ...?state[sessionId],
        fileId: progress,
      },
    };
  }

  void removeSession(String sessionId) {
    state = {...state}..remove(sessionId);
  }

  void removeAllSessions() {
    state = {};
  }
}
