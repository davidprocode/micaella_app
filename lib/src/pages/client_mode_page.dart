import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket_manager.dart';
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
            Consumer<WebSocketServerManager>(
              builder: (context, value, child) {
                return const Text('Client mode selected');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const BackButton(
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    );
  }
}
