import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grindly/features/auth/presentation/widgets/continue_with_google.dart';
import 'package:grindly/features/auth/presentation/widgets/text_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          switch (state) {
            case AuthInitial():
              return SingleChildScrollView(
                child: SizedBox(
                  width: width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: width * 0.05,
                            top: height * 0.23,
                          ),
                          child: Text(
                            'Welcome back:)',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                        SizedBox(height: height * 0.12),
                        Center(
                          child: TField(
                            widthFactor: 0.85,
                            labelText: 'email',
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            controller: emailController,
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
                          ),
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: TField(
                            widthFactor: 0.85,
                            labelText: 'password',
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: passwordController,
                            validator: null,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: width * 0.05),
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.04),
                        Center(
                          child: SizedBox(
                            height: height * 0.05,
                            width: width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                context
                                    .read<AuthCubit>()
                                    .signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text,
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.onPrimary,
                              ),
                              child: Text('Login'),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        ContinueWithGoogle(),
                        SizedBox(height: height * 0.05),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Haven\'t registered yet?',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go(Routes.signUp);
                              },
                              child: Text(
                                'Signup',
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
                ),
              );

            case AuthLoading():
              return Center(child: CircularProgressIndicator());
            case AuthSuccess():
              return Center(child: Text('Welcome ${state.user.user!.email}'));
            case AuthFailure():
              return SnackBar(content: Text('Error: ${state.message}'));
          }
        },
      ),
    );
  }
}
