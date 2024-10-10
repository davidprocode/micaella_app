import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket_manager.dart';
import 'package:provider/provider.dart';
import 'src/my_app.dart';

void main() async {
  WebSocketServerManager webSocketServerManager = WebSocketServerManager();
  webSocketServerManager.start();

  runApp(ChangeNotifierProvider(
    create: (context) => webSocketServerManager,
    child: const MyApp(),
  ));
}
