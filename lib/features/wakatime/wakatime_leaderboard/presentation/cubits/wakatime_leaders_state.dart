part of 'wakatime_leaders_cubit.dart';

class WakatimeLeadersState extends Equatable {
  final int index;
  final List<Leader> globalLeaders;
  final List<Leader> countryLeaders;
  final Country? currentUsersCountry;
  const WakatimeLeadersState({
    required this.index,
    required this.globalLeaders,
    required this.countryLeaders,
    this.currentUsersCountry,
  });

  WakatimeLeadersState copyWith({
    List<Leader>? globalLeaders,
    List<Leader>? countryLeaders,
    Country? currentUsersCountry,
  }) {
    return WakatimeLeadersState(
      index: index,
      globalLeaders: globalLeaders ?? this.globalLeaders,
      countryLeaders: countryLeaders ?? this.countryLeaders,
      currentUsersCountry: currentUsersCountry ?? this.currentUsersCountry,
    );
  }

  @override
  List<Object?> get props => [
    index,
    globalLeaders,
    countryLeaders,
    currentUsersCountry,
  ];
}

final class WakatimeLeadersInitial extends WakatimeLeadersState {
  const WakatimeLeadersInitial({
    required super.index,
    required super.globalLeaders,
    required super.countryLeaders,
  });
}

final class WakatimeLeadersInProgress extends WakatimeLeadersState {
  const WakatimeLeadersInProgress({
    required super.index,
    required super.globalLeaders,
    required super.countryLeaders,
  });
}

final class WakatimeLeadersSuccess extends WakatimeLeadersState {
  const WakatimeLeadersSuccess({
    required super.index,
    required super.globalLeaders,
    required super.countryLeaders,
    super.currentUsersCountry,
  });
}

final class WakatimeLeadersFailure extends WakatimeLeadersState {
  final String errorMessage;
  const WakatimeLeadersFailure({
    required super.index,
    required this.errorMessage,
    required super.globalLeaders,
    required super.countryLeaders,
  });
}
