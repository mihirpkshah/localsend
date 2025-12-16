import 'package:localsend_app/model/log_entry.dart';
import 'package:logging/logging.dart';
import 'package:p2p/p2p.dart' as p2p;
import 'package:refena_flutter/refena_flutter.dart';

final _logger = Logger('Discovery');

/// Contains the discovery logs for debugging purposes.
final discoveryLoggerProvider = NotifierProvider<DiscoveryLogger, List<LogEntry>>((ref) {
  return DiscoveryLogger();
});

class DiscoveryLogger extends Notifier<List<LogEntry>> implements p2p.DiscoveryLogger {
  DiscoveryLogger();

  @override
  List<LogEntry> init() {
    return [];
  }

  @override
  void addLog(String log) {
    _logger.info(log);
    state = [
      ...state,
      LogEntry(timestamp: DateTime.now(), log: log),
    ].take(200).toList();
  }

  @override
  void clear() {
    state = [];
  }
}
