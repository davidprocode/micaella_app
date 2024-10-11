import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micaella_app/src/pages/client_mode_page.dart';
import 'package:micaella_app/src/pages/server_mode_page.dart';
import 'package:window_manager/window_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
      });

      if (_counter == 0) {
        _timer?.cancel();
        _fecharJanela();
      }
    });
  }

  void _fecharJanela() {
    windowManager.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Contagem: $_counter',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const Text('Aguarde...'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: const ButtonStyle(),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ClientModePage())),
                    child: const Text("Cliente"),
                  ),
                  TextButton(
                    style: const ButtonStyle(),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServerModePage())),
                    child: const Text("Servidor"),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
