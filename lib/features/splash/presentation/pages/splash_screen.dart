import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/features/auth/presentation/widgets/grindly_logo.dart';
import 'package:grindly/shared/user_profile/presentation/cubits/user_profile/user_profile_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileSuccess) {
            context.go(Routes.todaysSummary);
          }
        },
        builder: (context, state) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [GrindlyLogo()],
            ),
            if (state is UserProfileInProgress)
              SizedBox(
                height: height * 0.02,
                width: height * 0.02,
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
