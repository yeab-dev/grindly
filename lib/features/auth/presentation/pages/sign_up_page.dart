import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:grindly/features/auth/presentation/widgets/text_field.dart';
import 'package:grindly/features/auth/presentation/widgets/grindly_logo.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
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
                    SizedBox(height: height * 0.005),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(right: width * 0.05),
                      child: TextButton(
                        onPressed: () {},
                        child: Text('Forgot password'),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Center(
                      child: SizedBox(
                        width: width * 0.8,
                        height: height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!formKey.currentState!.validate()) return;
                            context
                                .read<AuthCubit>()
                                .signUpWithEmailAndPassword(
                                  emailController.text,
                                  passwordController.text,
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.primary,
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
                    SizedBox(height: height * 0.02),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: Container(
                              height: height * 0.05,
                              width: width * 0.3,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.03,
                                    child: Image.asset(
                                      "assets/images/google.png",
                                    ),
                                  ),
                                  Text(
                                    'oogle',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.tertiary,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            tooltip: "Sign in with Google",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          case AuthLoading():
            return Center(child: CircularProgressIndicator());
          case AuthSuccess():
            return Center(child: Text('Welcome ${state.user.user?.email}'));
          case AuthFailure():
            return Center(child: Text('Registration not successful'));
        }
      },
    );
  }
}
