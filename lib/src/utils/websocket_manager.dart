import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class WebSocketServerManager with ChangeNotifier {
  final _controller = StreamController<String>();
  late HttpServer _server;
  final List<WebSocket> _clients = [];

  Stream<String> get stream => _controller.stream;

  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 4040);
    log('Servidor WebSocket iniciado em ws://${_server.address.address}:${_server.port}');

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
