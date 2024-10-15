import 'dart:async';
import 'package:flutter/material.dart';
import 'package:micaella_app/src/pages/client_mode_page.dart';
import 'package:micaella_app/src/pages/server_mode_page.dart';
import 'package:window_manager/window_manager.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String title = "Micaella App";
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

  void _handleButtonClientMode() {
    _timer?.cancel();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ClientModePage(),
      ),
    );
  }

  void _handleButtonServerMode() {
    _timer?.cancel();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ServerModePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Aguarde',
                style: TextStyle(fontSize: 24),
              ),
              Center(
                child: Text(
                  'Fechando automaticamente em: $_counter',
                  style: const TextStyle(fontSize: 9),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: const ButtonStyle(),
                      onPressed: () => _handleButtonClientMode(),
                      child: const Text("Client Mode")),
                  TextButton(
                      style: const ButtonStyle(),
                      onPressed: () => _handleButtonServerMode(),
                      child: const Text("Server Mode")),
                ],
              ),
            ],
          ),
        ));
  }
}
