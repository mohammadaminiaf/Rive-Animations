import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class OwlAnimationScreen extends StatefulWidget {
  const OwlAnimationScreen({super.key});

  @override
  State<OwlAnimationScreen> createState() => _OwlAnimationScreenState();
}

class _OwlAnimationScreenState extends State<OwlAnimationScreen> {
  Artboard? _artboard;

  //! Variables
  bool isDarkMode = false;
  SMITrigger? clickDarkMode;
  SMITrigger? clickLightMode;
  SMITrigger? rightClick;
  SMITrigger? leftClick;

  SMIBool? allHover;
  SMIBool? rightHover;
  SMIBool? leftHover;

  void _preload() {
    rootBundle.load('assets/rive/maotouying.riv').then((data) {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;

        final controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');

        if (controller != null) {
          artboard.addController(controller);
          clickDarkMode = controller.findSMI('Moon Click');
          clickLightMode = controller.findSMI('Sun Click');
          allHover = controller.findSMI('All Hover');
          leftHover = controller.findSMI('Left Hover');
          rightHover = controller.findSMI('Right Hover');
          rightClick = controller.findSMI('Right Click');
          leftClick = controller.findSMI('Left Click');
        }

        setState(() => _artboard = artboard);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  void onThemeChanged(bool value) {
    setState(() => isDarkMode = value);
    if (value == true) {
      clickDarkMode?.value = true;
    } else {
      clickLightMode?.value = true;
    }
  }

  void onLeftHoverChanged(bool value) {
    setState(() => leftHover?.value = value);
  }

  void onRightHoverChanged(bool value) {
    setState(() => rightHover?.value = value);
  }

  void onAllHoverChanged(bool value) {
    setState(() => allHover?.value = value);
  }

  void onRightClick() {
    setState(() => rightClick?.value = true);
  }
  void onLeftClick() {
    setState(() => leftClick?.value = true);
  }

  @override
  void initState() {
    super.initState();
    _preload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 48.0,
        ),
        child: Column(
          children: [
            _artboard == null
                ? const SizedBox.shrink()
                : Expanded(
                    child: GestureDetector(
                      onHorizontalDragStart: (details) {
                        rightHover?.value = true;
                      },
                      child: Rive(
                        artboard: _artboard!,
                      ),
                    ),
                  ),

            //! Dark Mode Switch
            SwitchListTile(
              title: const Text('Dark Theme'),
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),

            //! All Hover Switch
            SwitchListTile(
              title: const Text('All Hover'),
              value: allHover?.value ?? false,
              onChanged: onAllHoverChanged,
            ),

            //! Left Hover Switch
            SwitchListTile(
              title: const Text('Left Hover'),
              value: leftHover?.value ?? false,
              onChanged: onLeftHoverChanged,
            ),
            //! Right Hover Switch
            SwitchListTile(
              title: const Text('Right Hover'),
              value: rightHover?.value ?? false,
              onChanged: onRightHoverChanged,
            ),

            //! Right Click Button
            ElevatedButton(onPressed: onRightClick, child: const Text('Right Click')),
            
            const SizedBox(height: 20),
            
            //! Left Click Button
            ElevatedButton(onPressed: onLeftClick, child: const Text('Left Click')),
          ],
        ),
      ),
    );
  }
}
