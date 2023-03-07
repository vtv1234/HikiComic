import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int? genreId;
  final String? genreName;
  final String? genreParentId;
  final bool? isShowHome;
  final String? summary;
  final String? genreSEOSummary;

  final String? genreSEOTitle;
  final String? genreSEOAlias;
  final String? genreImageURL;
  final bool? isActive;
  final DateTime? dateCreated;

  const Genre(
      {this.genreId,
      this.genreName,
      this.genreParentId,
      this.isShowHome,
      this.summary,
      this.genreSEOSummary,
      this.genreSEOTitle,
      this.genreSEOAlias,
      this.genreImageURL,
      this.isActive,
      this.dateCreated});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
