import 'package:cleanarcproject/core/common/utils/show_snack_bar.dart';
import 'package:cleanarcproject/core/common/widget/loader.dart';
import 'package:cleanarcproject/core/theme/app_pallete.dart';
import 'package:cleanarcproject/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:cleanarcproject/features/Auth/presentation/widgets/auth_field.dart';
import 'package:cleanarcproject/features/Auth/presentation/widgets/auth_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  // OverlayEntry? _overlayEntry;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showPersistentSnackbar();
  //   });
  // }

  // void _showPersistentSnackbar() {
  //   if (_overlayEntry != null) return;

  //   _overlayEntry = OverlayEntry(
  //     builder: (context) => Positioned(
  //       bottom: 20,
  //       left: MediaQuery.of(context).size.width * 0.1,
  //       right: MediaQuery.of(context).size.width * 0.1,
  //       child: CustomSnackbar(
  //         message: 'No network connection',
  //         onRetry: () {
  //           _hidePersistentSnackbar();
  //         },
  //       ),
  //     ),
  //   );

  //   Overlay.of(context)!.insert(_overlayEntry!);
  // }

  // void _hidePersistentSnackbar() {
  //   if (_overlayEntry != null) {
  //     _overlayEntry!.remove();
  //     _overlayEntry = null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(
                  context, 'User enter something Invalid ${state.message}');
            } else if (state is AuthSuccess) {
              Navigator.pushNamed(context, '/');
              showSnackBar(context, ' Successfully Signed Up  ');
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const CircularLoader();
            }
            return Form(
              key: formKey,
              child: Center(
                child: ListView(
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(
                      hintText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: 'Email',
                      controller: emailController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AuthField(
                      hintText: 'password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AuthGradientButton(
                      btnName: 'Sign up',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(AuthSignUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              name: nameController.text.trim()));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/'),
                      child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                            TextSpan(
                              text: ' Log In ',
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
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// class CustomSnackbar extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;

//   const CustomSnackbar({
//     super.key,
//     required this.message,
//     required this.onRetry,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Container(
//         width: double.infinity,
//         // margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         decoration: BoxDecoration(
//           color: Colors.black87,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 message,
//                 style: const TextStyle(color: Colors.white),
//               ),
//             ),
//             TextButton(
//               onPressed: onRetry,
//               child: const Text('Retry', style: TextStyle(color: Colors.blue)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
