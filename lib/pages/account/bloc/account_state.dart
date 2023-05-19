part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountLoadedSuccessful extends AccountState {
  final Account accountInformation;

  const AccountLoadedSuccessful(this.accountInformation);
  @override
  List<Object> get props => [accountInformation];
}

class AccountLoadedFailure extends AccountState {
  final String error;

  const AccountLoadedFailure(this.error);
  @override
  List<Object> get props => [error];
}

class UploadAvatarLoading extends AccountState {
  @override
  List<Object?> get props => [];
}

class UploadAvatarByCameraSuccessful extends AccountState {

  const UploadAvatarByCameraSuccessful();
  @override
  List<Object> get props => [];
}

class UploadAvatarByCameraFailure extends AccountState {
  final String error;

  const UploadAvatarByCameraFailure(this.error);
  @override
  List<Object> get props => [error];
}

class UploadAvatarByGallerySuccessful extends AccountState {

  const UploadAvatarByGallerySuccessful();
  @override
  List<Object> get props => [];
}

class UploadAvatarByGalleryFailure extends AccountState {
  final String error;

  const UploadAvatarByGalleryFailure(this.error);
  @override
  List<Object> get props => [error];
}
