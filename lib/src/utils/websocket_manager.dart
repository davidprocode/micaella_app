import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class WebSocketServerManager with ChangeNotifier {
  final _controller = StreamController<String>();
  late HttpServer _server;
  final List<WebSocket> _clients = [];

  late final Future<String> _address = getIpAddres();
  late final int _port = 4040;

  Stream<String> get stream => _controller.stream;

  get address => _address;
  get port => _port;

  Future<String> getIpAddres() async {
    try {
      for (var interface in await NetworkInterface.list(
          includeLinkLocal: false,
          includeLoopback: false,
          type: InternetAddressType.IPv4)) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4 && !addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (e) {
      print('Erro ao obter IP: $e');
    }
    return 'Falha ao obter IP';
  }

  Future start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, _port);

    _server.listen((HttpRequest request) async {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        var websocket = await WebSocketTransformer.upgrade(request);
        _clients.add(websocket);
        _listenToClient(websocket);
      } else {
        request.response
          ..statusCode = HttpStatus.forbidden
          ..write('Esta é a resposta do servidor WebSocket.')
          ..close();
      }
    });
    notifyListeners();
  }

  void _listenToClient(WebSocket client) {
    client.listen(
      (data) {
        _controller.add(data);
        _broadcast('Comando recebido: $data');
      },
      onDone: () {
        _clients.remove(client);
        log('Cliente desconectado.');
      },
      onError: (error) {
        _controller.addError(error);
      },
    );
  }

  void _broadcast(String message) {
    for (var client in _clients) {
      client.add(message);
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var client in _clients) {
      client.close();
    }
    _server.close();
    _controller.close();
  }

  void send(String text) {
    for (var client in _clients) {
      client.add(text);
    }
  }
}
