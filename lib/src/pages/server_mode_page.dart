import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket_manager.dart';
import 'package:provider/provider.dart';

class ServerModePage extends StatefulWidget {
  const ServerModePage({super.key});

  @override
  State createState() => _ServerModeState();
}

class _ServerModeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<WebSocketServerManager>(
              builder: (context, value, child) {
                return const Text('Server mode selected');
              },
            )
          ],
        ),
      ),
    );
  }
}
