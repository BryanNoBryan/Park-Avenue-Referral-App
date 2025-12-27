import 'package:flutter/material.dart';

class PostOpInstructionsView extends StatefulWidget {
  const PostOpInstructionsView({super.key});

  @override
  State<PostOpInstructionsView> createState() => _PostOpInstructionsViewState();
}

class _PostOpInstructionsViewState extends State<PostOpInstructionsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (child: Text("PostOpInstructionsView"),),
    );
  }
}
