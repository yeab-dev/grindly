import 'package:flutter/material.dart';

class FriendsFilterWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const FriendsFilterWidget({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: 18,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.secondary,
        ),
        child: Text(label),
      ),
    );
  }
}
