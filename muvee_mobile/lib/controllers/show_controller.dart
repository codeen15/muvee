import 'dart:convert';

import 'package:http/http.dart';

import '../configs/hosts.dart';

class ShowController {
  static Future<List<dynamic>?> searchShows({
    required String query,
  }) async {
    String url = '$tvmazeHost/search/shows?q=$query';

    Response response = await get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    }

    return null;
  }

  static Future<Map<String, dynamic>?> getShowByID({
    required int id,
  }) async {
    String url = '$tvmazeHost/shows/$id';

    Response response = await get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}
