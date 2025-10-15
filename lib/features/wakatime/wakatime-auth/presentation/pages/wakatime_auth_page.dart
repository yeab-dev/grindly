import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime-auth/presentation/cubit/wakatime_auth_cubit.dart';

class WakatimeAuthPage extends StatelessWidget {
  const WakatimeAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: width,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.15,
                bottom: height * 0.03,
              ),
              child: SizedBox(
                width: width * 0.45,
                child: Image.asset('assets/images/grindly-and-wakatime.png'),
              ),
            ),
            SizedBox(
              width: width * 0.65,
              child: Text(
                'inorder to track your coding stats '
                'we might need an access to your wakatime account. ',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: height * 0.5),
            BlocBuilder<WakatimeAuthCubit, WakatimeAuthState>(
              builder: (context, state) {
                return SizedBox(
                  height: height * 0.06,
                  width: width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: theme.colorScheme.onPrimary,
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      context.read<WakatimeAuthCubit>().authorizeApp();
                    },
                    child: Text(
                      'continue with wakatime',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.04,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
