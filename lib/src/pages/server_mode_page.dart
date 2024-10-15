import 'package:flutter/material.dart';

class ServerModePage extends StatefulWidget {
  const ServerModePage({super.key});

  @override
  State<ServerModePage> createState() => _ServerModePageState();
}

class _ServerModePageState extends State<ServerModePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Server mode selected'),
          ],
        ),
      ),
      floatingActionButton: BackButton(
        color: Color.fromRGBO(255, 0, 0, 1),
      ),
    );
  }
}
