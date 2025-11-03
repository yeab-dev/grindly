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
      margin: EdgeInsets.only(top: height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: theme.colorScheme.tertiary),
      ),
      child: ToggleButtons(
        renderBorder: false,
        borderRadius: BorderRadius.circular(15),
        selectedColor: theme.colorScheme.tertiary,
        fillColor: theme.colorScheme.primaryContainer,
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
