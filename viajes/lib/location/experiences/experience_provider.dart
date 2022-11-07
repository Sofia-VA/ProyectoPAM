import 'package:flutter/material.dart';

class ExperienceProvider with ChangeNotifier {
  bool _isLiked = false;
  bool get getIsLiked => _isLiked;

  bool getLikedStatus(experienceID) {
    try {
      // TODO: Search if experience is liked by user
      notifyListeners();
      return getIsLiked;
    } catch (e) {
      notifyListeners();
      return getIsLiked;
    }
  }

  likeExperience(experienceID) {
    _isLiked = true;
    // TODO: Add to user liked experiences
    // TODO: Add count to experience likes
    notifyListeners();
  }
}
