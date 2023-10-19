import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class APIRequests {
  Future<String?> imageRequest({
    required String url,
    required Object payload,
  }) async {
    final uri = Uri.parse(url);
    final res = await http.post(
      uri,
      body: payload,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    if (res.statusCode >= 200 && res.statusCode <= 208) {
      final json = res.body;
      return json;
    }

    return null;
  }

  Future<String?> saveData({
    required String url,
    required Map<String, dynamic> payload,
  }) async {
    final uri = Uri.parse(url);

    final image = await http.get(Uri.parse(payload["image"]));
    final req = http.MultipartRequest("POST", uri);

    req.fields["first_name"] = payload["first_name"]!;
    req.fields["last_name"] = payload["last_name"]!;
    req.fields["email"] = payload["email"]!;
    req.fields["phone"] = payload["phone"]!;

    req.files.add(http.MultipartFile.fromBytes(
      "user_image",
      image.bodyBytes,
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpg'),
    ));

    final res = await req.send();

    if (res.statusCode >= 200 && res.statusCode <= 208) {
      final completer = Completer<String?>();

      res.stream.listen((value) {
        final output = String.fromCharCodes(value);
        completer.complete(output);
      });

      return completer.future;
    }

    return null;
  }
}
