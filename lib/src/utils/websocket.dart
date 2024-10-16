import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class WebsocketService with ChangeNotifier {
  String? address;
  int? port;

  void start() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 4040);

    address = server.address.address;
    port = server.port;

    await for (HttpRequest request in server) {
      handleRequest(request);
    }

    log('Server Started at: $address:$port');
    notifyListeners();
  }

  void handleRequest(HttpRequest request) {
    if (request.method == 'GET') {
      request.response
        ..headers.contentType = ContentType.text
        ..write('Received a GET request!')
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write('Unsupported request: ${request.method}.')
        ..close();
    }
  }

  void sendCommand() async {
    var url = Uri.parse('http://localhost:4040');
    var request = await HttpClient().getUrl(url);
    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      response.transform(utf8.decoder).listen((contents) {
        log('Response: $contents');
      });
    } else {
      log('Request failed with status: ${response.statusCode}');
    }
  }
}
