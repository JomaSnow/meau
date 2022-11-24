import 'package:app/util/design.dart';
import 'package:flutter/widgets.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Text(
        title,
        style: const TextStyle(
            color: Design.primaryYellow, fontSize: 64, fontFamily: "Courgette"),
      ),
    );
  }
}
