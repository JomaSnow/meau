import 'package:app/widgets/custom_app_bar.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/scrollable_container.dart';
import 'package:flutter/material.dart';

class AdoptFormScreen extends StatelessWidget {
  const AdoptFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: "Termo de Adoção",
      ),
      drawer: const CustomDrawer(),
      body: ScrollableContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [],
        ),
      ),
    );
  }
}