import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grindly/core/router/routes.dart';

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
          ? BottomNavigationBar(
              backgroundColor: theme.appBarTheme.backgroundColor,
              currentIndex: widget.currentIndex!,
              onTap: (index) {
                if (index == 0) {
                  context.go(Routes.todaysSummary);
                } else if (index == 1) {
                  context.go(Routes.profilePage);
                } else if (index == -1) {
                  context.go(Routes.editProfilePage);
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
              ],
            )
          : null,
    );
  }
}
