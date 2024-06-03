import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SimpleAnimationScreen extends StatefulWidget {
  const SimpleAnimationScreen({super.key});

  @override
  State<SimpleAnimationScreen> createState() => _SimpleAnimationScreenState();
}

class _SimpleAnimationScreenState extends State<SimpleAnimationScreen> {
  //! In this example, I'm gonna cache the file to make it faster to load
  RiveFile? _file;

  Future<void> preLoad() async {
    rootBundle.load('assets/rive/thumbs_up.riv').then((ByteData data) async {
      // Load the rive file from the binary data
      setState(() {
        _file = RiveFile.import(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    preLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _file != null ? RiveAnimation.direct(
          _file!,
        ) : const SizedBox.shrink(),
      ),
    );
  }
}
