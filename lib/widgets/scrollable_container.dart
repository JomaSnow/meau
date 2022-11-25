import 'package:app/util/design.dart';
import 'package:flutter/material.dart';

class ScrollableContainer extends StatelessWidget {
  const ScrollableContainer({
    super.key,
    required this.child,
    this.horizontalPadding = 15,
  });

  final Widget child;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Design.white1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
