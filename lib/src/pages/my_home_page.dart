import 'package:flutter/material.dart';
import 'package:micaella_app/src/pages/client_mode_page.dart';
import 'package:micaella_app/src/pages/server_mode_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              const Text('Escolha o modo:'),
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
