import 'package:flutter/material.dart';

class IndexTemplateSmall extends StatefulWidget {
  const IndexTemplateSmall({super.key});

  @override
  State<IndexTemplateSmall> createState() => _IndexTemplateSmallState();
}

class _IndexTemplateSmallState extends State<IndexTemplateSmall> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('iPhone'),
    );
  }
}