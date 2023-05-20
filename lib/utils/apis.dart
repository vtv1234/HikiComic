class Apis {
  static const _baseUrl =
      // 'https://5997-2a09-bac5-d46f-18c8-00-278-8f.ngrok-free.app/api';

      'https://localhost:7068/api';

  static const authorsApi = '$_baseUrl/authors';
  static const _userUrl = '$_baseUrl/users';

  //comic
  static const _comicsUrl = '$_baseUrl/comics';
  static const getHotComicsUrl = '$_comicsUrl/get-comic-by-ranking-comics';
  static const getNewComicsUrl = '$_comicsUrl/get-comic-by-new-comics';
  static const getComicByGenre = '$_comicsUrl/get-comic-by-genre-paging';
  static const getComicByStatus = '$_comicsUrl/get-comic-by-status-paging';

  //user-following-comic
  static const getFollowedComicsApi =
      '$_baseUrl/user-comic-followings/get-user-followed-comic';

  static const loginApi = '$_baseUrl/users/login';
  //user

  static const getUserByUserId = '$_userUrl/get-user-by-user-id';

  //genres

  static const _genresApi = '$_baseUrl/genres';
  static const getAllGenresApi = '$_genresApi/get-all';

  //comic detail

  static const _comicDetailApi = '$_baseUrl/comic-details';
  static const getComicDetailByComicSeoAlias =
      '$_comicDetailApi/get-comic-detail-by-comic-seo-alias/';

  static const getComicDetailByComicSeoAliasWithUser =
      '$_comicDetailApi/get-comic-detail-by-comic-seo-alias-with-user/';
  static const updateStatusUserFollowComic =
      '$_comicDetailApi/update-status-user-follow-comic/';
  static const userRatingComic = '$_baseUrl/user-comic-ratings/create-rating/';

  //chapter
  static const _chapterComicApi = '$_baseUrl/chapters';
  static const getChaptersByComicSeoAlias =
      '$_chapterComicApi/get-chapters-by-comic-seo-alias/';
//chapter image
  static const _chapterImageComicApi = '$_baseUrl/chapter-image-urls';
  static const getChapterByChapterComicSeoAlias =
      '$_chapterImageComicApi/get-free-chapter-by-chapter-comic-seo-alias/';

  //auth
  static const _authApi = '$_baseUrl/auth';
  static const login = '$_authApi/login';
  static const register = '$_authApi/register';
  static const verifyEmail = '$_authApi/user-verify-email';
  static const resendEmailVerification = '$_authApi/re-send-email-verification';
  static const forgotPassword = '$_authApi/forgot-password';
  static const verifyForgotPassword = '$_authApi/user-verify-forgot-password';

//account
  static const _accountApi = '$_baseUrl/accounts';
  static const resetPassword = '$_accountApi/reset-password';
  static const getAccountInformaton = '$_userUrl/get-user-by-user-id';
  static const uploadAvatar = '$_accountApi/user-change-avatar';

  //history
  static const comicReadingHistories = '$_baseUrl/user-comic-reading-histories';

  //comment
  static const _commentApi = '$_baseUrl/comments';
  static const pagingComment = '$_commentApi/paging';
  static const createComment = '$_commentApi/create';
}
