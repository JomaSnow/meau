import 'package:flutter/widgets.dart';

void dismissFocus(BuildContext context) {
  // FocusScopeNode currentFocus = FocusScope.of(context);

  // if (!currentFocus.hasPrimaryFocus) {
  //   currentFocus.unfocus();
  // }

  FocusScope.of(context).requestFocus(FocusNode());
}
