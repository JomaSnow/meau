import 'dart:developer';

import 'package:app/util/local_storage.dart';

bool isLoggedIn() {
  if (LocalStorage.getUserId() != null) {
    return true;
  }
  return false;
}

Future signIn() async {
  const userId = "abc123";

  if (isLoggedIn()) {
    log("there's an user already signed in");
  } else {
    await LocalStorage.storeUserId(userId);
    log("signed in user id: $userId");
  }
}

Future signOff() async {
  if (!isLoggedIn()) {
    log("no user logged to sign off");
  } else {
    await LocalStorage.deleteUserId();
    log("signed off");
  }
}
