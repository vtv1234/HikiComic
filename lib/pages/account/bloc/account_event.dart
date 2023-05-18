part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountInformation extends AccountEvent {}

class UploadAvatarByCamera extends AccountEvent {
  final ImageSource imageSource = ImageSource.camera;
}

class UploadAvatarByGallery extends AccountEvent {
  final ImageSource imageSource = ImageSource.gallery;
}
