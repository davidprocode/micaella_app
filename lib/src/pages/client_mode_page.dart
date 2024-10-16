import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket.dart';
import 'package:provider/provider.dart';

class ClientModePage extends StatefulWidget {
  const ClientModePage({super.key});

  @override
  State createState() => _ClientModeState();
}

class _ClientModeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<WebsocketService>(
              builder: (context, manager, child) {
                return TextButton(
                    onPressed: () => _handlerSerndButton(manager),
                    child: const Text('Send Command'));
              },
            )
          ],
        ),
      ),
      floatingActionButton: const BackButton(
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    );
  }

  _handlerSerndButton(WebsocketService manager) {
    manager.sendCommand();
    log('Send comand button');
  }
}
