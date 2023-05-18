part of 'completed_comic_bloc.dart';

abstract class CompletedComicEvent extends Equatable {
  const CompletedComicEvent();
}

class LoadCompletedComicEvent extends CompletedComicEvent {
  final int pageIndex;
  final int pageSize;

  const LoadCompletedComicEvent(
      {required this.pageIndex, required this.pageSize});
  @override
  List<Object?> get props => [pageIndex, pageSize];
}
