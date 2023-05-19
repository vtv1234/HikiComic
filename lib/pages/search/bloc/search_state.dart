part of 'search_bloc.dart';

abstract class SearchState extends Equatable {}

class SearchStateInitial extends SearchState {
  final List<Comic> hotComics;

  SearchStateInitial(this.hotComics);
  @override
  List<Object?> get props => [hotComics];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

class SearchStateSuccess extends SearchState {
  final List<Comic> comics;
  final List<Comic> hotComics;

  SearchStateSuccess(this.comics, this.hotComics);
  @override
  List<Object?> get props => [comics];
}

class SearchStateError extends SearchState {
  final String error;

  SearchStateError(this.error);
  @override
  List<Object?> get props => [error];
}

// class SearchState extends Equatable {
//   final bool? isLoading;
//   final List<Comic>? comics;
//   final bool? hasError;

//   SearchState(
//       {required this.isLoading, required this.comics, required this.hasError});
//   @override
//   factory SearchState.initial() {
//     return SearchState(
//       comics: [],
//       isLoading: false,
//       hasError: false,
//     );
//   }

//   factory SearchState.loading() {
//     return SearchState(
//       comics: [],
//       isLoading: true,
//       hasError: false,
//     );
//   }

//   factory SearchState.success(List<Comic> comics) {
//     print('success');
//     return SearchState(
//       comics: comics,
//       isLoading: false,
//       hasError: false,
//     );
//   }

//   factory SearchState.error() {
//     return SearchState(
//       comics: [],
//       isLoading: false,
//       hasError: true,
//     );
//   }

//   @override
//   
//   List<Object?> get props => [];
// }
