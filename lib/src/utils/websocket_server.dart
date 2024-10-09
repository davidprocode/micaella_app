import 'dart:developer';
import 'dart:io';

Future<HttpServer> startWebSocketServer() async {
  // Cria o servidor WebSocket
  final server = await HttpServer.bind(InternetAddress.anyIPv4, 4040);
  log('Servidor WebSocket iniciado em ws://${server.address.address}:${server.port}');

  // Escuta as conexões de entrada
  await for (HttpRequest request in server) {
    if (request.uri.path == '/ws') {
      // Aceita o protocolo WebSocket
      var websocket = await WebSocketTransformer.upgrade(request);

      // Escuta as mensagens recebidas
      websocket.listen(
        (message) {
          log('Mensagem recebida: $message');
          websocket.add('Resposta do servidor: $message');
        },
        onDone: () {
          log('Cliente desconectado.');
        },
        onError: (error) {
          log('Erro: $error');
        },
      );
    } else {
      // Responde a requisições HTTP normais
      request.response
        ..statusCode = HttpStatus.forbidden
        ..write('Este é um servidor WebSocket.')
        ..close();
    }
  }
  return server;
}
