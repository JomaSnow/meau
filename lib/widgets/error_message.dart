import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key, this.errorMessage = ""});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return errorMessage.isNotEmpty
        ? Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            padding: const EdgeInsets.all(10),
            child: Text(
              errorMessage,
              style: const TextStyle(
                  color: Colors.redAccent, fontSize: 14, fontFamily: "Roboto"),
            ),
          )
        : Container();
  }
}
