import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasConnection() async {
  bool connectionStatus =
      await Connectivity().checkConnectivity() == ConnectivityResult.none;
  return connectionStatus;
}
