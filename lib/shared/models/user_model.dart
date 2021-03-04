import 'dart:convert' as convert;

import 'package:blood_learning/shared/utils/prefs.dart';

class AppUser {
  int id;
  String name;
  int isTutorialCompleted = 0;
  int isIntroductionViewed = 0;
  int isAuthenticated = 0;

  AppUser({this.name, this.isTutorialCompleted, isIntroductionViewed});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'ID': id,
      'USR_NAME': name,
      'USR_ISTUTORIALCOMPLETED': isTutorialCompleted,
      'USR_ISINTRODUCTIONVIEWED': isIntroductionViewed,
      'USR_ISAUTHENTICATED': isAuthenticated
    };
    return map;
  }

  AppUser.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    name = map['USR_NAME'];
    isTutorialCompleted = map['USR_ISTUTORIALCOMPLETED'];
    isIntroductionViewed = map['USR_ISINTRODUCTIONVIEWED'];
    isAuthenticated = map['USR_ISAUTHENTICATED'];
  }

  
  @override
  String toString() {
    return 'User{name: $name}';
  }
}
