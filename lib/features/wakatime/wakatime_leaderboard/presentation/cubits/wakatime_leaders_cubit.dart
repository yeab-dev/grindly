import 'package:equatable/equatable.dart';
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
  }) : super(
         WakatimeLeadersInitial(
           index: 0,
           globalLeaders: [],
           countryLeaders: [],
           grindlyLeaders: [],
         ),
       );

  Future<void> getGlobalLeaders() async {
    if (state.globalLeaders.isNotEmpty) {
      emit(
        WakatimeLeadersSuccess(
          index: 0,
          globalLeaders: state.globalLeaders,
          countryLeaders: state.countryLeaders,
          currentUsersCountry: state.currentUsersCountry,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
      return;
    }
    emit(
      WakatimeLeadersInProgress(
        index: 0,
        globalLeaders: state.globalLeaders,
        countryLeaders: state.globalLeaders,
        grindlyLeaders: state.grindlyLeaders,
      ),
    );
    try {
      final globalLeaders = await repository.getLeaders();
      final countryName = await storageRepository.read(key: "country_name");
      final countryCode = await storageRepository.read(key: "country_code");
      emit(
        WakatimeLeadersSuccess(
          index: 0,
          globalLeaders: globalLeaders,
          countryLeaders: state.countryLeaders,
          grindlyLeaders: state.grindlyLeaders,
          currentUsersCountry: Country(
            countryName: countryName ?? "Nowhere",
            countryCode: countryCode ?? "NW",
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        WakatimeLeadersFailure(
          index: 0,
          errorMessage: e.toString(),
          globalLeaders: state.globalLeaders,
          countryLeaders: state.countryLeaders,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
    }
  }

  Future<void> getCountryLeaders({required String countryCode}) async {
    if (state.countryLeaders.isNotEmpty) {
      emit(
        WakatimeLeadersSuccess(
          index: 1,
          globalLeaders: state.globalLeaders,
          countryLeaders: state.countryLeaders,
          currentUsersCountry: state.currentUsersCountry,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
      return;
    }
    emit(
      WakatimeLeadersInProgress(
        index: 1,
        globalLeaders: state.globalLeaders,
        countryLeaders: state.countryLeaders,
        grindlyLeaders: state.grindlyLeaders,
      ),
    );
    try {
      final countryName = await storageRepository.read(key: "country_name");
      final countryCode = await storageRepository.read(key: "country_code");
      final countryLeaders = await repository.getLeadersByCountry(countryCode!);
      emit(
        WakatimeLeadersSuccess(
          index: 1,
          globalLeaders: state.globalLeaders,
          countryLeaders: countryLeaders,
          grindlyLeaders: state.grindlyLeaders,
          currentUsersCountry: Country(
            countryName: countryName ?? "Nowhere",
            countryCode: countryCode,
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        WakatimeLeadersFailure(
          index: 1,
          errorMessage: e.toString(),
          globalLeaders: state.globalLeaders,
          countryLeaders: state.globalLeaders,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
    }
  }

  Future<void> getGrindlyLeaders() async {
    if (state.grindlyLeaders.isNotEmpty) {
      emit(
        WakatimeLeadersSuccess(
          index: 2,
          globalLeaders: state.globalLeaders,
          countryLeaders: state.countryLeaders,
          currentUsersCountry: state.currentUsersCountry,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
      return;
    }
    emit(
      WakatimeLeadersInProgress(
        index: 2,
        globalLeaders: state.globalLeaders,
        countryLeaders: state.countryLeaders,
        grindlyLeaders: state.grindlyLeaders,
      ),
    );
    try {
      final grindlyLeaders = await repository.getGrindlyLeaders();
      final countryName = await storageRepository.read(key: "country_name");
      final countryCode = await storageRepository.read(key: "country_code");
      emit(
        WakatimeLeadersSuccess(
          index: 2,
          globalLeaders: state.globalLeaders,
          countryLeaders: state.countryLeaders,
          grindlyLeaders: grindlyLeaders,
          currentUsersCountry: Country(
            countryName: countryName ?? "Nowhere",
            countryCode: countryCode ?? "NW",
          ),
        ),
      );
    } on Exception catch (e) {
      emit(
        WakatimeLeadersFailure(
          index: 2,
          errorMessage: e.toString(),
          globalLeaders: state.globalLeaders,
          countryLeaders: state.globalLeaders,
          grindlyLeaders: state.grindlyLeaders,
        ),
      );
    }
  }

  Future<void> saveGrindlyLeader({required Leader leader}) async {
    await repository.saveLeaderToFirestore(leader: leader);
  }
}
