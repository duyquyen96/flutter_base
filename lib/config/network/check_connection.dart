import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

Future<bool> getConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

checkConnection(Function f) async {
  //NOTE tempt for pass connection in the simulator
  // if (await getConnection()
  //     .timeout(const Duration(seconds: 3), onTimeout: () => false)) {
  return f();
  // } else {
  //   printError('--------------------connection error ----------------------');
  //   return null;
  // }
}

class Network {
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult _result;
  StreamSubscription? _connectivitySubscription;
  static Network? _network;

  factory Network() {
    _network = Network._();
    return _network!;
  }

  Network._();

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Networt $e");
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _result = result;
    print(result.toString());
  }

  ConnectivityResult getNetwork() {
    return _result;
  }

  listenConnect() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  closeStreamNetwork() {
    _connectivitySubscription?.cancel();
  }
}

Network Connect = Network();
