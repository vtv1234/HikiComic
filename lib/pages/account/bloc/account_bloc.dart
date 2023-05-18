import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/account.dart';
import 'package:hikicomic/repository/account_repository.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository = AccountRepository();
  final AuthenticationRepository _authenticationRepository;
  AccountBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AccountLoading()) {
    on<GetAccountInformation>((event, emit) async {
      emit(AccountLoading());
      try {
        final result = await _accountRepository.getAccountInformation();
        if (result.isSuccessed == true) {
          emit(AccountLoadedSuccessful(result.ressultObj));
        } else {
          emit(AccountLoadedFailure(result.message.toString()));
        }
      } catch (e) {
        emit(AccountLoadedFailure(e.toString()));
      }
    });

    on<UploadAvatarByCamera>(
      (event, emit) async {
        emit(UploadAvatarLoading());
        try {
          final ImagePicker picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: event.imageSource,
          );

          if (pickedFile != null) {
            bool isSuccessed =
                await _accountRepository.uploadAvatar(File(pickedFile.path));
            if (isSuccessed) {
              _authenticationRepository.controller
                  .add(AuthenticationStatus.authenticated);
              emit(const UploadAvatarByCameraSuccessful());
            } else {
              emit(UploadAvatarByCameraFailure('Cannot upload image'));
            }
          }
        } catch (e) {
          emit(UploadAvatarByCameraFailure(e.toString()));
        }
      },
    );
    on<UploadAvatarByGallery>(
      (event, emit) async {
        emit(UploadAvatarLoading());
        try {
          final ImagePicker picker = ImagePicker();
          final XFile? pickedFile = await picker.pickImage(
            source: event.imageSource,
          );

          if (pickedFile != null) {
            bool isSuccessed =
                await _accountRepository.uploadAvatar(File(pickedFile.path));
            if (isSuccessed) {
              _authenticationRepository.controller
                  .add(AuthenticationStatus.authenticated);
              emit(UploadAvatarByGallerySuccessful());
            } else {
              emit(UploadAvatarByGalleryFailure('Cannot upload image'));
            }
          }
        } catch (e) {
          emit(UploadAvatarByGalleryFailure(e.toString()));
        }
      },
    );
  }
}
