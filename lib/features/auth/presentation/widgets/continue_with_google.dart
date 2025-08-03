import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Text(
                'Or continue with',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: height * 0.01),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                icon: Container(
                  height: height * 0.045,
                  width: width * 0.25,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.025,
                        child: Image.asset("assets/images/google.png"),
                      ),
                      Text(
                        'oogle',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                tooltip: "continue with Google",
                onPressed: () {
                  context.read<SignInCubit>().continueWithGoogle();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
