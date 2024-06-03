import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class BirdAnimationScreen extends StatefulWidget {
  const BirdAnimationScreen({super.key});

  @override
  State<BirdAnimationScreen> createState() => _BirdAnimationScreenState();
}

class _BirdAnimationScreenState extends State<BirdAnimationScreen> {
  //! In this example, I'm gonna cache the file to make it faster to load
  // RiveFile? _file;
  Artboard? _artboard;

  //! Rive SMI Variables
  SMITrigger? doesLookUp;
  SMIBool? isDancing;

  Future<void> preLoad() async {
    rootBundle
        .load('assets/rive/dash_flutter_muscot.riv')
        .then((ByteData data) async {
      // Load the rive file from the binary data
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      final controller = StateMachineController.fromArtboard(artboard, 'birb');

      if (controller != null) {
        artboard.addController(controller);
        doesLookUp = controller.findSMI('look up');
        isDancing = controller.findSMI('dance');
      }

      setState(() => _artboard = artboard);
    });
  }

  void toggleIsDancing(bool value) {
    setState(() {
      isDancing?.value = value;
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
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show Flutter Dash
            _artboard != null
                ? SizedBox(
                    height: 400,
                    child: Rive(
                      artboard: _artboard!,
                    ),
                  )
                : const SizedBox.shrink(),
        
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                doesLookUp?.value = true;
              },
              child: const Text('Look up'),
            ),
            const SizedBox(height: 20),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is Dancing'),
                Switch(
                  value: isDancing?.value ?? false,
                  onChanged: toggleIsDancing,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
