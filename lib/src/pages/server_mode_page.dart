import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket_manager.dart';
import 'package:provider/provider.dart';

class ServerModePage extends StatefulWidget {
  const ServerModePage({super.key});

  @override
  State<ServerModePage> createState() => _ServerModePageState();
}

class _ServerModePageState extends State<ServerModePage> {
  String address = 'Obtendo IP...';
  String port = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final manager = Provider.of<WebSocketServerManager>(context);
    setState(() {
      address = manager.getIpAddres() as String;
      port = manager.port;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Server mode selected'),
            Text('ws://$address:$port'),
            const BackButton(
              color: Color.fromRGBO(255, 0, 0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
