import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'sync_service.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  void startListening() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        print("🌐 Internet voltou → sincronizando...");
        SyncService().syncVisitas();
      }
    });
  }

  void stop() {
    _subscription?.cancel();
  }
}