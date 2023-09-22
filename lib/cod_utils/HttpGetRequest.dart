import 'dart:async';
import 'dart:convert';
import 'dart:io';

class HttpGetRequest {
  final HttpClient client = HttpClient();

  Future<String?> fetchUrl(String url, {int timeoutSeconds = 2}) async {
    try {
      final HttpClientRequest request = await client.getUrl(Uri.parse(url));

      final HttpClientResponse response = await request.close().timeout(
        Duration(seconds: timeoutSeconds),
      );

      if (response.statusCode == HttpStatus.ok) {
        final String responseBody =
        await response.transform(utf8.decoder).join();
        return responseBody;
      } else {
        return null;
      }
    } on TimeoutException {//Termina el tiempo de espera
      return "1";
    } catch (e) {
      // Manejar otras excepciones aquí
      return null;
    } finally {
      client.close(); // Cierra el cliente
    }
  }
}
