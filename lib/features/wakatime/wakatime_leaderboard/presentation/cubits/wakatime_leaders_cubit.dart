import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/wakatime_leaders_repository.dart';

part 'wakatime_leaders_state.dart';

class WakatimeLeadersCubit extends Cubit<WakatimeLeadersState> {
  WakatimeLeadersRepository repository;
  WakatimeLeadersCubit({required this.repository})
    : super(WakatimeLeadersInitial());

  Future<void> getLeaders() async {
    emit(WakatimeLeadersInProgress());
    try {
      final leaders = await repository.getLeaders();
      emit(WakatimeLeadersSuccess(leaders: leaders));
    } on Exception catch (e) {
      emit(WakatimeLeadersFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getLeadersByCountry() async {
    emit(WakatimeLeadersInProgress());
    try {
      final leaders = await repository.getLeadersByCountry(
        'et',
      ); //TODO: change the country code to support other countries too
      emit(WakatimeLeadersSuccess(leaders: leaders));
    } on Exception catch (e) {
      emit(WakatimeLeadersFailure(errorMessage: e.toString()));
    }
  }
}
