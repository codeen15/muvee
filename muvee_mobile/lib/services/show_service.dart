import 'package:flutter/material.dart';

import '../controllers/show_controller.dart';
import '../models/show.dart';

class ShowService extends ChangeNotifier {
  List<Show> shows = [];
  bool isSearching = false;
  bool isNotFound = false;

  ShowService();

  Future<void> searchShow({
    required String query,
  }) async {
    if (query.isEmpty) {
      shows = [];
      isSearching = false;
      isNotFound = false;
      notifyListeners();
    } else {
      isSearching = true;
      isNotFound = false;
      notifyListeners();

      List<dynamic>? data = await ShowController.searchShows(query: query);

      if (data != null && data.isNotEmpty) {
        shows = data.map((s) => Show.fromMap(s['show'])).toList();
        isSearching = false;
        notifyListeners();
      } else {
        isSearching = false;
        isNotFound = true;
        notifyListeners();
      }
    }
  }
}
