import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '/constants/app_colors.dart';
import '/models/rive_model.dart';
import '/utils/validators.dart';

final _formKey = GlobalKey<FormState>();

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({super.key});

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation> {
  //! Define controllers
  final FocusNode _emailFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();

  //! State Variables
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  SMITrigger? trigSuccess;
  SMITrigger? trigFail;
  SMINumber? numLook;

  @override
  void initState() {
    _emailFocusNode.addListener(_emailFocus);
    _passwordFocusNode.addListener(_passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailFocusNode.removeListener(_emailFocus);
    _passwordFocusNode.removeListener(_passwordFocus);
    super.dispose();
  }

  void _onInit(
    Artboard artboard, {
    required String stateMachineName,
  }) {
    final controller = StateMachineController.fromArtboard(
      artboard,
      stateMachineName,
    );

    if (controller != null) {
      artboard.addController(controller);
      isChecking = controller.findSMI('isChecking');
      isHandsUp = controller.findSMI('isHandsUp');
      trigSuccess = controller.findSMI('trigSuccess');
      trigFail = controller.findSMI('trigFail');
      numLook = controller.findSMI('numLook');
    }
  }

  //! Focus Node methods
  void _emailFocus() {
    isChecking?.change(_emailFocusNode.hasFocus);
  }

  void _passwordFocus() {
    isHandsUp?.change(_passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 400,
                  child: RiveAnimation.asset(
                    'assets/rive/animated_login_character.riv',
                    fit: BoxFit.cover,
                    onInit: (artboard) => _onInit(
                      artboard,
                      stateMachineName: riveAnimations[3].stateMachineName,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: Validators.validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: Validators.validatePassword,
                ),

                const SizedBox(height: 20),

                //! Login Button
                InkWell(
                  onTap: login,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.buttonColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      isHandsUp?.change(false);
      trigSuccess?.fire();
    } else {
      isHandsUp?.change(false);
      trigFail?.fire();
    }
  }
}
