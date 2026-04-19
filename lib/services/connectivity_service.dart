import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'sync_service.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  void start() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        print("📡 Internet voltou, rodando sync...");

        SyncService().syncFamilias();
      }
    });
  }

  void stop() {
    _subscription?.cancel();
  }
}