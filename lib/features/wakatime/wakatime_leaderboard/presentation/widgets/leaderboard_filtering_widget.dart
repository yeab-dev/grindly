import 'package:flutter/material.dart';

class LeaderboardFilteringWidget extends StatefulWidget {
  const LeaderboardFilteringWidget({super.key});

  @override
  State<LeaderboardFilteringWidget> createState() =>
      _LeaderboardFilteringWidgetState();
}

class _LeaderboardFilteringWidgetState
    extends State<LeaderboardFilteringWidget> {
  final List<bool> _selectedFilters = [true, false, false];
  final List<String> _filters = ['Global', 'Ethiopia', 'Grindly'];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.primaryContainer,
      ),
      child: ToggleButtons(
        textStyle: theme.textTheme.bodyLarge,
        renderBorder: false,
        borderRadius: BorderRadius.circular(15),
        selectedColor: theme.colorScheme.onPrimary,
        fillColor: theme.colorScheme.primary,
        isSelected: _selectedFilters,
        onPressed: (index) {
          setState(() {
            for (int i = 0; i < _selectedFilters.length; i++) {
              _selectedFilters[i] = i == index;
            }
          });
        },
        children: _filters
            .map(
              (filter) => Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Text(filter),
              ),
            )
            .toList(),
      ),
    );
  }
}
