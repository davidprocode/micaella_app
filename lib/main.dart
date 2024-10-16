import 'package:flutter/material.dart';
import 'package:micaella_app/src/utils/websocket.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(300, 300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    alwaysOnTop: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  WebsocketService server = WebsocketService();
  server.start();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<WebsocketService>(create: (_) => server)
    ],
    child: const MyApp(),
  ));
}
