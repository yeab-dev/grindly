import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';
import 'package:grindly/shared/user_profile/presentation/cubit/user_profile_cubit.dart';

class MainScaffold extends StatefulWidget {
  final String? title;
  final Widget child;
  final int? currentIndex;
  const MainScaffold({
    super.key,
    this.title,
    this.currentIndex,
    required this.child,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? "")),
      body: widget.child,
      bottomNavigationBar: widget.currentIndex != null
          ? BlocBuilder<UserProfileCubit, UserProfileState>(
              builder: (context, state) {
                return BottomNavigationBar(
                  backgroundColor: theme.appBarTheme.backgroundColor,
                  currentIndex: widget.currentIndex!,
                  onTap: (index) {
                    if (index == 0) {
                      context.go(Routes.todaysSummary);
                    } else if (index == 1) {
                      context.go(Routes.profilePage);
                    } else if (index == 2) {
                      context.go(
                        Routes.leaderboard,
                        extra: (state as UserProfileSuccess).user,
                      );
                    }
                  },
                  items: [
                    BottomNavigationBarItem(
                      label: "summary",
                      icon: Icon(Icons.auto_graph),
                    ),
                    BottomNavigationBarItem(
                      label: 'profile',
                      icon: Icon(Icons.person),
                    ),
                    BottomNavigationBarItem(
                      label: "leaderboard",
                      icon: Icon(Icons.leaderboard),
                    ),
                  ],
                );
              },
            )
          : null,
    );
  }
}
