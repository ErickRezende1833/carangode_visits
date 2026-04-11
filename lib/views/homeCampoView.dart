import 'package:flutter/material.dart';
import 'widgets.dart';

class HomeCampoView extends StatefulWidget {
  const HomeCampoView({Key? key}) : super(key: key);

  @override
  State<HomeCampoView> createState() => _HomeCampoViewState();
}

class _HomeCampoViewState extends State<HomeCampoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Campo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              

            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}



