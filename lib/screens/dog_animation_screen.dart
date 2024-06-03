import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '/models/rive_model.dart';

class DogAnimationScreen extends StatefulWidget {
  const DogAnimationScreen({super.key});

  @override
  State<DogAnimationScreen> createState() => _DogAnimationScreenState();
}

class _DogAnimationScreenState extends State<DogAnimationScreen> {
  RiveFile? _file;
  bool isLoading = false;

  //! Rive inputs
  SMIBool? isListening;
  SMIBool? isProcessing;
  SMIBool? hasVoice;
  SMITrigger? shake;
  SMITrigger? maximize;
  SMITrigger? minimize;

  void toggleIsProcessing(bool value) =>
      setState(() => isProcessing?.value = value);

  void toggleIsListening(bool value) =>
      setState(() => isListening?.value = value);

  void toggleHasVoice(bool value) => setState(() => hasVoice?.value = value);

  Future<void> initRive() async {
    setState(() => isLoading = true);
    _file = await RiveFile.asset('assets/rive/pes.riv');
    setState(() => isLoading = false);
  }

  void _onInit(artboard) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      riveAnimations[1].stateMachineName,
    );

    if (controller != null) {
      artboard.addController(controller);
      isProcessing = controller.findSMI('Processing');
      isListening = controller.findSMI('Listening');
      hasVoice = controller.findSMI('Voice');
      shake = controller.findSMI('Shake');
      maximize = controller.findSMI('Maximize');
      minimize = controller.findSMI('Minimize');
    }
  }

  @override
  void initState() {
    initRive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pes = riveAnimations[1];
    if (isLoading == false) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 48,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _file != null
                    ? RiveAnimation.direct(
                        //* Dog animation
                        _file!,
                        // pes.src,
                        artboard: pes.artboard,
                        onInit: (artboard) => _onInit(artboard),
                      )
                    : const SizedBox.shrink(),
              ),
              //! Shake Button
              ElevatedButton(
                onPressed: () {
                  shake?.value = true;
                },
                child: const Text('Shake'),
              ),
              //! Maximize
              ElevatedButton(
                onPressed: () {
                  maximize?.value = true;
                },
                child: const Text('Maximize'),
              ),
              //! Minimize
              ElevatedButton(
                onPressed: () {
                  minimize?.value = true;
                },
                child: const Text('Minimize'),
              ),
              //! Processing
              SwitchListTile(
                title: const Text('is processing'),
                value: isProcessing?.value ?? false,
                onChanged: toggleIsProcessing,
              ),
              //! Listening
              SwitchListTile(
                title: const Text('is listening'),
                value: isListening?.value ?? false,
                onChanged: toggleIsListening,
              ),
              //! Voice
              SwitchListTile(
                title: const Text('Has Voice'),
                value: hasVoice?.value ?? false,
                onChanged: toggleHasVoice,
              ),
            ],
          ),
        ),
      );
    } else {
      return const Placeholder();
    }
  }
}
