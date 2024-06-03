import 'package:rive/rive.dart';

class RiveModel {
  final String src, artboard, stateMachineName;
  late SMIBool? status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

final List<RiveModel> riveAnimations = [
  RiveModel(
    src: 'assets/rive/dash_flutter_muscot.riv',
    artboard: 'birb',
    stateMachineName: 'tileBird',
  ),
  RiveModel(
    src: 'assets/rive/pes.riv',
    artboard: 'Pes Animace',
    stateMachineName: 'State Machine 1',
  ),
  RiveModel(
    src: 'assets/rive/maotouying.riv',
    artboard: 'Maotouying',
    stateMachineName: 'State Machine 1',
  ),
  RiveModel(
    src: 'assets/rive/animated_login_character.riv',
    artboard: 'Teddy',
    stateMachineName: 'Login Machine',
  ),
];
