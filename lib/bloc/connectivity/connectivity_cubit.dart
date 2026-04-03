// import 'dart:async';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:http/http.dart' as http;

// part 'connectivity_state.dart';

// class ConnectivityCubit extends Cubit<ConnectivityState> {
//   final Connectivity _connectivity = Connectivity();
//   StreamSubscription? _subscription;

//   ConnectivityCubit() : super(ConnectivityInitial()) {
//     _initConnectivity();
//   }

//   Future<void> _initConnectivity() async {
//     final result = await _connectivity.checkConnectivity();
//     await _updateStatus(result);

//     _subscription = _connectivity.onConnectivityChanged
//         .listen((ConnectivityResult result) async {
//       await _updateStatus(result);
//     });
//   }

//   Future<void> _updateStatus(ConnectivityResult result) async {
//     final bool isConnected = await _canReachServer();
//     emit(ConnectivityChanged(result: result, isConnected: isConnected));
//   }

//   Future<bool> _canReachServer() async {
//     try {
//       final response = await http
//           .get(Uri.parse('https://google.com'))
//           .timeout(Duration(seconds: 3));
//       return response.statusCode == 200;
//     } catch (_) {
//       return false;
//     }
//   }

//   @override
//   Future<void> close() {
//     _subscription?.cancel();
//     return super.close();
//   }
// }
