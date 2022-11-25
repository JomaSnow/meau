import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  const ScrollableContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Design.white1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
