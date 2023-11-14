import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../infrustructure/splash/repository/splash_repository.dart';
import '../event/splash_events.dart';
import '../state/splash_states.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashRepository splashRepo;

  SplashBloc({required this.splashRepo}) : super(InitialState()) {
    on<FetchDataEvent>(onFetchData);
    on<InitialSplashEvent>((InitialSplashEvent event, Emitter emit) {
      emit(InitialState());
    });
  }

  onFetchData(FetchDataEvent event, Emitter emit) async {
    emit(LoadingState());
    try {
      final jsonData = await splashRepo.fetchData();
      emit(
          DataLoadedState(color: jsonData['color'], videos: jsonData['video']));
    } catch (e) {
      emit(ErrorState(error: 'Error fetching data: $e'));
    }
  }
}
