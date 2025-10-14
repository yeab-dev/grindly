import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';
import 'package:grindly/features/auth/presentation/widgets/continue_with_google.dart';
import 'package:grindly/features/auth/presentation/widgets/text_field.dart';
import 'package:grindly/features/auth/presentation/widgets/grindly_logo.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.status == SignUpStatus.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.failure!.message)));
          }
          if (state.status == SignUpStatus.loading) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: MediaQuery.sizeOf(context).width * 0.01),
                      Text('Signing you up'),
                    ],
                  ),
                );
              },
            );
          }
          if (state.status != SignUpStatus.loading) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state.status == SignUpStatus.success) {
            context.go(Routes.verify);
          }
        },
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final formKey = GlobalKey<FormState>();
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 60.0),
              child: Text(
                'Welcome to',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: GrindlyLogo(),
            ),
            SizedBox(height: height * 0.1),
            Padding(
              padding: EdgeInsets.only(left: width * 0.08),
              child: Row(
                children: [
                  TField(
                    validator: null,
                    controller: firstNameController,
                    labelText: 'First Name',
                    widthFactor: 0.4,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                  SizedBox(width: width * 0.05),
                  TField(
                    validator: null,
                    controller: lastNameController,
                    labelText: 'Last Name',
                    widthFactor: 0.4,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 33.0),
              child: TField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                controller: emailController,
                labelText: 'Email',
                widthFactor: 0.85,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 33.0),
              child: TField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: passwordController,
                labelText: 'Password',
                widthFactor: 0.85,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.only(left: 33.0),
              child: TField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: confirmPasswordController,
                labelText: 'Confirm Password',
                widthFactor: 0.85,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
            ),
            SizedBox(height: height * 0.04),
            Center(
              child: SizedBox(
                width: width * 0.8,
                height: height * 0.055,
                child: ElevatedButton(
                  onPressed: () {
                    final displayName =
                        "${firstNameController.text} ${lastNameController.text}";
                    if (!formKey.currentState!.validate()) return;
                    context.read<SignUpCubit>().signUpWithEmailAndPassword(
                      emailController.text,
                      passwordController.text,
                      displayName,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            BlocListener<SignInCubit, SignInState>(
              listener: (context, state) {
                if (state.status == SignInStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.failure!.message)),
                  );
                }
                if (state.status == SignInStatus.loading) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Row(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.01,
                            ),
                            Text('Signing you in'),
                          ],
                        ),
                      );
                    },
                  );
                }
                if (state.status != SignInStatus.loading) {
                  Navigator.of(context, rootNavigator: true).pop();
                }
                if (state.status == SignInStatus.success) {
                  context.go(Routes.wakatimeAuth);
                }
              },
              child: ContinueWithGoogle(),
            ),
            SizedBox(height: height * 0.04),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an account already ?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.go(Routes.login);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
