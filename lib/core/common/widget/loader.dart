import 'package:flutter/material.dart';

class CircularLoader extends StatefulWidget {
  const CircularLoader({super.key});

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
