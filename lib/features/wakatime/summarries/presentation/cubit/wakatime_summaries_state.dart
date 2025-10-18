part of 'wakatime_summaries_cubit.dart';

sealed class WakatimeSummariesState extends Equatable {
  const WakatimeSummariesState();

  @override
  List<Object> get props => [];
}

final class WakatimeSummariesInitial extends WakatimeSummariesState {}

final class WakatimeSummariesInProgress extends WakatimeSummariesState {}

final class WakatimeSummariesSuccess extends WakatimeSummariesState {
  final TodaysSummarries summarries;
  const WakatimeSummariesSuccess({required this.summarries});
}

final class WakatimeSummariesFailure extends WakatimeSummariesState {
  final String errorMessage;
  const WakatimeSummariesFailure({required this.errorMessage});
}
