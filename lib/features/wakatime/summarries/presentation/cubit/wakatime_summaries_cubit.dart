import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grindly/features/wakatime/summarries/domain/entities/todays_summarries.dart';
import 'package:grindly/features/wakatime/summarries/domain/repositories/wakatime_summarries_repository.dart';

part 'wakatime_summaries_state.dart';

class WakatimeSummariesCubit extends Cubit<WakatimeSummariesState> {
  final WakatimeSummariesRepository repository;
  WakatimeSummariesCubit({required this.repository})
    : super(WakatimeSummariesInitial());

  Future<void> getTodaysSummary() async {
    emit(WakatimeSummariesInProgress());
    try {
      final summary = await repository.getTodaysSummarries();
      emit(WakatimeSummariesSuccess(summarries: summary));
    } catch (e) {
      emit(WakatimeSummariesFailure(errorMessage: e.toString()));
    }
  }
}
