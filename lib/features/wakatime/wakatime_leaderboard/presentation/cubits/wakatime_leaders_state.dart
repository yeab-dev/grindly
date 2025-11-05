part of 'wakatime_leaders_cubit.dart';

sealed class WakatimeLeadersState {
  const WakatimeLeadersState();
}

final class WakatimeLeadersInitial extends WakatimeLeadersState {}

final class WakatimeLeadersInProgress extends WakatimeLeadersState {}

final class WakatimeLeadersSuccess extends WakatimeLeadersState {
  final List<Leader> leaders;
  final Country? currentUsersCuntry;
  const WakatimeLeadersSuccess({
    required this.leaders,
    required this.currentUsersCuntry,
  });
}

final class WakatimeLeadersFailure extends WakatimeLeadersState {
  final String errorMessage;
  const WakatimeLeadersFailure({required this.errorMessage});
}
