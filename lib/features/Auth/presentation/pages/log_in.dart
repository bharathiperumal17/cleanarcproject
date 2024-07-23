import 'package:cleanarcproject/core/common/utils/show_snack_bar.dart';
import 'package:cleanarcproject/core/common/widget/loader.dart';
import 'package:cleanarcproject/core/theme/app_pallete.dart';
import 'package:cleanarcproject/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cleanarcproject/features/Auth/presentation/widgets/auth_field.dart';
import 'package:cleanarcproject/features/Auth/presentation/widgets/auth_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final formKey = GlobalKey<FormState>();
  final userId = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'home', (route) => false);
            showSnackBar(context, 'loged in successfully');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const CircularLoader();
          }
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AuthField(
                    hintText: 'UserId',
                    controller: userId,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthField(
                    hintText: 'password',
                    isObscureText: true,
                    controller: password,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthGradientButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignIn(
                            email: userId.text.trim(),
                            password: password.text.trim()));
                      }
                    },
                    btnName: 'Log In',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'signup'),
                    child: RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                          TextSpan(
                            text: ' Sign Up ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold),
                          )
                        ])),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    userId.dispose();
    password.dispose();
    super.dispose();
  }
}
