// ignore_for_file: avoid_print, constant_identifier_names

//import 'package:band_names/services/sockets_service.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  final IO.Socket _socket = IO.io('http://10.0.2.2:3000/', {
    'transports': ['websocket'],
    'autoConnect': true,
  });

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket get socket => _socket;

  Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
  }

  void _initConfig() {
    _socket.onConnect((_) {
      // print('connect');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    _socket.on('nuevo-mensaje', (data) {
      print('nuevo mensaje: $data');
    });
  }
}
