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

  AccountLoadedSuccessful(this.accountInformation);
  @override
  List<Object> get props => [accountInformation];
}

class AccountLoadedFailure extends AccountState {
  final String error;

  AccountLoadedFailure(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class UploadAvatarLoading extends AccountState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UploadAvatarByCameraSuccessful extends AccountState {
  // final Account accountInformation;

  const UploadAvatarByCameraSuccessful();
  @override
  List<Object> get props => [];
}

class UploadAvatarByCameraFailure extends AccountState {
  final String error;

  UploadAvatarByCameraFailure(this.error);
  @override
  List<Object> get props => [error];
}

class UploadAvatarByGallerySuccessful extends AccountState {
  // final Account accountInformation;

  UploadAvatarByGallerySuccessful();
  @override
  List<Object> get props => [];
}

class UploadAvatarByGalleryFailure extends AccountState {
  final String error;

  UploadAvatarByGalleryFailure(this.error);
  @override
  List<Object> get props => [error];
}
