import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/shared/user_profile/presentation/cubit/user_profile_cubit.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Center(
        child: BlocConsumer<UserProfileCubit, UserProfileState>(
          listener: (context, state) {
            if (state is UserProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('user: ${state.user.displayName}')),
              );
            }
          },
          builder: (context, state) {
            if (state is UserProfileSuccess) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: height * 0.05,
                      right: width * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.edit,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.13,
                    width: height * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: width * 0.01,
                      ),
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary,
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(state.user.photoUrl!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.015),
                    child: Text(
                      state.user.displayName,
                      style: theme.textTheme.headlineSmall!.copyWith(),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.05,
                      top: height * 0.03,
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '0',
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Following'),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                          ),
                          height: height * 0.05,
                          color: theme.colorScheme.secondaryContainer,
                          child: SizedBox(width: width * 0.005),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '0',
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Followers'),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.05,
                          ),
                          height: height * 0.05,
                          color: theme.colorScheme.secondaryContainer,
                          child: SizedBox(width: width * 0.005),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '15',
                              style: theme.textTheme.headlineLarge!.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Current Streak'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return ElevatedButton(
              onPressed: () {
                context.read<UserProfileCubit>().getUser();
              },
              child: Text('press me'),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            context.go(Routes.todaysSummary);
          }
        },
        items: [
          BottomNavigationBarItem(
            label: "summary",
            icon: Icon(Icons.auto_graph),
          ),
          BottomNavigationBarItem(label: 'profile', icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
