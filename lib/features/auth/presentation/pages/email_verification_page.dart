import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/auth/presentation/cubits/signup/sign_up_cubit.dart';
import 'package:grindly/features/auth/presentation/widgets/grindly_logo.dart';
import 'package:lottie/lottie.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    final double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: GrindlyLogo(),
                ),
                // Spacer(),
                Spacer(),
                SizedBox(
                  height: height * 0.07,

                  child: Lottie.asset(
                    repeat: false,
                    'assets/lottie_animations/email-verification.json',
                  ),
                ),
                SizedBox(height: height * 0.03),
                Text(
                  "we've sent a verification link to",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${state.user!.email}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'resend link',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.025),
                SizedBox(
                  width: width * 0.5,
                  height: height * 0.05,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text('Done'),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
