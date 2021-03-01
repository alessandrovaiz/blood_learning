import 'dart:convert' as convert;

import 'package:blood_learning/shared/utils/prefs.dart';

class AppUser {
  String name;
  bool isTutorialCompleted = false;
  bool isIntroductionViewed = false;
  bool isAuthenticated = false;

  AppUser(this.name, this.isTutorialCompleted, isIntroductionViewed);

  static void clearClientUsr() {
    Prefs.setString("name_user.prefs", null);
    Prefs.setBool("isTutorialCompleted_user.prefs", null);
    Prefs.setBool("isIntroductionViewed_user.prefs", null);
    Prefs.setBool("isAuthenticated_user.prefs", false);
  }

  void saveUserData(
      {String name, bool isTutorialCompleted, bool isIntroductionViewed}) {
    Prefs.setString("name_user.prefs", name);
    Prefs.setBool("isTutorialCompleted_user.prefs", isTutorialCompleted);
    Prefs.setBool("isIntroductionViewed_user.prefs", isIntroductionViewed);
    Prefs.setBool("isAuthenticated", true);
  }

  void saveModule() {
    Prefs.setString("name_user.prefs", name);
    Prefs.setBool("isTutorialCompleted_user.prefs", isTutorialCompleted);
    Prefs.setBool("isIntroductionViewed_user.prefs", isIntroductionViewed);
    Prefs.setBool("isAuthenticated", true);
  }

  static Future<AppUser> getClientUsr() async {
    String name = await Prefs.getString("name_user.prefs");
    bool isTutorialCompleted =
        await Prefs.getBool("isTutorialCompleted_user.prefs");
    bool isIntroductionViewed =
        await Prefs.getBool("isIntroductionViewed_user.prefs");

    if (name.isEmpty) {
      return null;
    }

    AppUser user = new AppUser(name, isTutorialCompleted, isIntroductionViewed);

    return user;
  }

  static Future<bool> getUserAuthentication() async {
    if (await Prefs.getBool("isAuthenticated_user.prefs")) {
      return true;
    } else {
      return false;
    }
  }

  bool setUserAuthentiction(value) {
    isAuthenticated = value;
  }

  @override
  String toString() {
    return 'User{name: $name}';
  }
}
