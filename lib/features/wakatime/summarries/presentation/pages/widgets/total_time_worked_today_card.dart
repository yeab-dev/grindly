import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/summarries/presentation/cubit/wakatime_summaries_cubit.dart';

class TotalTimeWorkedTodayCard extends StatelessWidget {
  final Duration duration;
  const TotalTimeWorkedTodayCard({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.1),
      child: Container(
        width: width * 0.4,
        height: height * 0.2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primary,
            width: width * 0.03,
          ),
        ),
        child: BlocConsumer<WakatimeSummariesCubit, WakatimeSummariesState>(
          listener: (context, state) {
            if (state is WakatimeSummariesFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            final dur = duration.toString().split(':');
            if (duration == Duration.zero) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${dur[0]}:${dur[1]}',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: theme.colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: state is WakatimeSummariesFailure
                        ? "couldn't load your wakatime data"
                        : "You haven't worked on any projects today",
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    child: const Icon(Icons.warning, color: Colors.amber),
                  ),
                ],
              );
            }
            return Center(
              child: Stack(
                children: [
                  Text(
                    '${dur[0]}:${dur[1]}',
                    style: theme.textTheme.headlineLarge!.copyWith(
                      color: theme.colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
