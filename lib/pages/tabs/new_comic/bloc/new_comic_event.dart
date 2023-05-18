part of 'new_comic_bloc.dart';

abstract class NewComicEvent extends Equatable {
  const NewComicEvent();
}

class LoadNewComicEvent extends NewComicEvent {
  final int pageIndex;
  final int pageSize;

  const LoadNewComicEvent({required this.pageIndex, required this.pageSize});
  @override
  List<Object?> get props => [pageIndex, pageSize];
}
