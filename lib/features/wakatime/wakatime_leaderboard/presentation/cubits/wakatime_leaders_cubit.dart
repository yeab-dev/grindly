import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/entities/leader.dart';
import 'package:grindly/features/wakatime/wakatime_leaderboard/domain/repositories/wakatime_leaders_repository.dart';
import 'package:grindly/features/wakatime/wakatime_profile/domain/entities/country.dart';
import 'package:grindly/shared/domain/repositories/secure_storage_repository.dart';

part 'wakatime_leaders_state.dart';

class WakatimeLeadersCubit extends Cubit<WakatimeLeadersState> {
  WakatimeLeadersRepository repository;
  SecureStorageRepository storageRepository;
  WakatimeLeadersCubit({
    required this.repository,
    required this.storageRepository,
  }) : super(WakatimeLeadersInitial());

  Future<void> getLeaders() async {
    emit(WakatimeLeadersInProgress());
    try {
      final leaders = await repository.getLeaders();
      final countryName = await storageRepository.read(key: 'country_name');
      final countryCode = await storageRepository.read(key: 'country_code');
      emit(
        WakatimeLeadersSuccess(
          leaders: leaders,
          currentUsersCuntry: Country(
            countryName: countryName ?? 'nowhere',
            countryCode: countryCode ?? 'NW',
          ),
        ),
      );
    } on Exception catch (e) {
      emit(WakatimeLeadersFailure(errorMessage: e.toString()));
    }
  }

  Future<void> getLeadersByCountry({required String countryCode}) async {
    emit(WakatimeLeadersInProgress());
    try {
      final countryName = await storageRepository.read(key: 'country_name');
      final countryCode = await storageRepository.read(key: 'country_code');
      final leaders = await repository.getLeadersByCountry(countryCode!);
      emit(
        WakatimeLeadersSuccess(
          leaders: leaders,
          currentUsersCuntry: Country(
            countryName: countryName ?? 'nowhere',
            countryCode: countryCode,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(WakatimeLeadersFailure(errorMessage: e.toString()));
    }
  }
}
