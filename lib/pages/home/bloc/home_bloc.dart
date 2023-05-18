import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

enum HomeTab {
  Ongoing,
  New,
  Completed,
  Ranking,
  Genres,
  Newsfeed,
}

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState()) {
    //// on<TabChangeEvent>((event, emit) => emit(TabHomeState(tab: event.tab)));
  }
  void setTab(HomeTab tab) => emit(HomeState(tab: tab));
}
