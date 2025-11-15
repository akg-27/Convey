import 'package:convey/features/auth/presentation/components/my_button.dart';
import 'package:convey/features/auth/presentation/components/my_textfield.dart';
import 'package:convey/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Text Controller
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  // register button pressed
  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmPw = confirmPwController.text;

    // auth Cubit
    final authCubit = context.read<AuthCubit>();

    // ensure the fields are not empty
    if (email.isNotEmpty &&
        name.isNotEmpty &&
        pw.isNotEmpty &&
        confirmPw.isNotEmpty) {
      // password match
      if (pw == confirmPw) {
        authCubit.register(name, email, pw);
      }

      // password don't match
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password is incorrect..!")),
        );
      }
    }
    // fields are empty -> display error
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    confirmPwController.dispose();
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
                // Create an Account
                Text(
                  "Lets create an account for you..",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                // name controller
                const SizedBox(height: 50),
                MyTextField(
                  controller: nameController,
                  hinText: "Name",
                  obscureText: false,
                ),

                const SizedBox(height: 10),
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

                const SizedBox(height: 10),
                // Confirm Password Textfield
                MyTextField(
                  controller: confirmPwController,
                  hinText: "Confirm Password",
                  obscureText: true,
                ),

                const SizedBox(height: 30),
                //Register  Button
                MyButton(onTap: register, text: "Register"),

                const SizedBox(height: 50),
                // Already a Memeber ? Login now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a Memeber ? ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        'Login now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
