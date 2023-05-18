// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final HomeTab tab;
  // final int index;

  const HomeState({this.tab = HomeTab.Ongoing});
  // final HomeTab tab;

  // const HomeState({this.tab = HomeTab.New});

  @override
  List<Object?> get props => [tab];
}
