import 'package:flutter/material.dart';
import 'package:grindly/features/auth/presentation/widgets/grindly_logo.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
