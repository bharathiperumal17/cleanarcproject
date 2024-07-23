import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, 'newBlog'),
              icon: const Icon(CupertinoIcons.add_circled))
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
