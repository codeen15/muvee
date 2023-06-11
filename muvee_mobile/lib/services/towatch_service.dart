import 'dart:developer';

import 'package:flutter/material.dart';

import '../controllers/show_controller.dart';
import '../controllers/towatch_controller.dart';
import '../models/show.dart';

class ToWatchService extends ChangeNotifier {
  List<int>? toWatchIDs;
  List<Show?> cachedShows = [];

  ToWatchService() {
    getAllToWatch();
  }

  Future<String?> addShowToToWatch({
    required int showID,
  }) async {
    try {
      Map<String, dynamic>? data =
          await ToWatchController.addShowToToWatch(showID: showID);

      if (data != null && toWatchIDs != null) {
        toWatchIDs!.add(data['show_id']);
        notifyListeners();
        return null;
      }

      return 'Error adding the show to to-watch list';
    } catch (e) {
      log(e.toString());
      return 'Error adding the show to to-watch list';
    }
  }

  Future<String?> removeFromToWatch({
    required int showID,
  }) async {
    try {
      bool data = await ToWatchController.removeShowFromToWatch(showID: showID);

      if (data) {
        toWatchIDs!.remove(showID);
        cachedShows.removeWhere((show) => show!.id == showID);
        notifyListeners();
        return null;
      }

      return 'Error deleting the show from to-watch list';
    } catch (e) {
      log(e.toString());
      return 'Error deleting the show from to-watch list';
    }
  }

  Future<String?> getAllToWatch() async {
    try {
      List<dynamic>? data = await ToWatchController.getAllToWatch();

      if (data != null) {
        toWatchIDs = data.map((t) => t['show_id'] as int).toList();
        notifyListeners();
        return null;
      }

      return 'Error adding the show to to-watch list';
    } catch (e) {
      log(e.toString());
      return 'Error adding the show to to-watch list';
    }
  }

  Future<Show?> getShowByID({
    required int id,
  }) async {
    Show? show = cachedShows.firstWhere(
      (show) => show!.id == id,
      orElse: () => null,
    );

    if (show == null) {
      Map<String, dynamic>? data = await ShowController.getShowByID(id: id);

      if (data != null) {
        Show s = Show.fromMap(data);
        cachedShows.add(s);
        return s;
      }
    } else {
      return show;
    }

    return null;
  }
}
