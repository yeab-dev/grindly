import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/presentation/cubits/wakatime_leaders_cubit.dart';

class LeaderboardFilteringWidget extends StatefulWidget {
  final int? lastFilter;
  const LeaderboardFilteringWidget({super.key, this.lastFilter});

  @override
  State<LeaderboardFilteringWidget> createState() =>
      _LeaderboardFilteringWidgetState();
}

class _LeaderboardFilteringWidgetState
    extends State<LeaderboardFilteringWidget> {
  List<bool> _selectedFilters = [true, false, false];
  final List<String> _filters = ['Global', 'Your Country', 'Grindly'];
  @override
  void initState() {
    _selectedFilters = (widget.lastFilter == null)
        ? [true, false, false]
        : [
            widget.lastFilter! == 0,
            widget.lastFilter! == 1,
            widget.lastFilter == 2,
          ];
    super.initState();
  }

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
      child: BlocBuilder<WakatimeLeadersCubit, WakatimeLeadersState>(
        builder: (context, state) {
          if (state is WakatimeLeadersSuccess) {
            _filters[1] =
                state.currentUsersCountry?.countryName ?? 'Your country';
            return ToggleButtons(
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
                  if (index == 0) {
                    context.read<WakatimeLeadersCubit>().getGlobalLeaders();
                  } else if (index == 1) {
                    if (state.currentUsersCountry != null) {
                      context.read<WakatimeLeadersCubit>().getCountryLeaders(
                        countryCode: state.currentUsersCountry!.countryCode,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'please set your country on your wakatime settings.',
                          ),
                        ),
                      );
                    }
                  } else {}
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
            );
          }
          return ToggleButtons(
            textStyle: theme.textTheme.bodyLarge,
            renderBorder: false,
            borderRadius: BorderRadius.circular(15),
            selectedColor: theme.colorScheme.onPrimary,
            fillColor: theme.colorScheme.primary,
            isSelected: _selectedFilters,
            onPressed: (index) {},
            children: _filters
                .map(
                  (filter) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: Text(filter),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
