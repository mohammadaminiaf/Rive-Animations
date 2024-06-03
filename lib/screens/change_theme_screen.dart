import 'package:example_3/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rive/rive.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  SMIBool? isDark;

  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    initRive();
  }

  void initRive() {
    rootBundle.load('assets/rive/dark_light_switch.riv').then((data) {
      try {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        final controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');

        if (controller != null) {
          artboard.addController(controller);
          isDark = controller.findSMI('isDark');
        }

        setState(() => _artboard = artboard);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          return InkWell(
            onTap: () {
              isDark?.value = !isDark!.value;
              setState(() {});
              ref.read(themeProvider.notifier).toggleTheme();
            },
            child: _artboard != null
                ? Rive(
                    artboard: _artboard!,
                  )
                : const SizedBox.shrink(),
          );
        }),
      ),
    );
  }
}
