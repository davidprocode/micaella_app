import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebSocketServerManager _webSocketServerManager;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _webSocketServerManager = WebSocketServerManager();
    _webSocketServerManager.start();
  }

  @override
  void dispose() {
    _webSocketServerManager.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<String>(
              stream: _webSocketServerManager.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.active) {
                  return Center(child: Text('OK'));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('Sem dados'));
                } else {
                  return Center(child: Text('Recebido: ${snapshot.data}'));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enviar mensagem',
              ),
              onSubmitted: (text) {
                _webSocketServerManager.send(text);
                _controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
