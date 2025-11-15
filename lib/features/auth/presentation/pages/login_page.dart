/* 
          LOGIN PAGE 
 On this page, an existing user can login with their:

 -email
 -pw

 -------------------------------------------------------------------------------

 Once the user successfully logs in, they will  be redirected to home page. 

 If user doesn't have an account yet, they can go to register page from here to 
 create one.
 
 */

import 'package:convey/features/auth/presentation/components/my_button.dart';
import 'package:convey/features/auth/presentation/components/my_textfield.dart';
import 'package:convey/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text Controller
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  // login button pressed
  void login() {
    // prepare email and password
    final String email = emailController.text;
    final String pw = pwController.text;

    // auth cubit
    final authCubit = context.read<AuthCubit>();

    //ensure that the email & pw fields are not empty
    if (email.isNotEmpty && pw.isNotEmpty) {
      // login
      authCubit.login(email, pw);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both Email and Password')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.lock_open_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),

                const SizedBox(height: 50),
                // Welcome back
                Text(
                  "Welcome back, you've been missed.!!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 50),
                // Email Textfield
                MyTextField(
                  controller: emailController,
                  hinText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                // Password Textfield
                MyTextField(
                  controller: pwController,
                  hinText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 30),
                //Login Button
                MyButton(onTap: login, text: "Login"),

                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Memeber ? ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // Not a Memeber ? Register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
