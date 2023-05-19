import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/account/bloc/account_bloc.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nickNameController = TextEditingController();
    return LoaderOverlay(
        child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Profile",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),
          ),
        ),
        body: BlocConsumer<AccountBloc, AccountState>(
          listener: (context, state) {
            if (state is AccountLoading) {
              context.loaderOverlay.show();
            } else if (state is UploadAvatarLoading) {
              context.loaderOverlay.show();
            }
            if (state is UploadAvatarByCameraSuccessful) {
              context.loaderOverlay.hide();
              context.read<AccountBloc>().add(GetAccountInformation());
            } else if (state is UploadAvatarByCameraFailure) {
              context.loaderOverlay.hide();
            } else if (state is UploadAvatarByGallerySuccessful) {
              context.loaderOverlay.hide();
              context.read<AccountBloc>().add(GetAccountInformation());
            } else if (state is UploadAvatarByGalleryFailure) {
              context.loaderOverlay.hide();
            }
          },
          builder: (context, state) {
            if (state is AccountLoadedFailure) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is AccountLoadedSuccessful) {
              context.loaderOverlay.hide();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: state.accountInformation.userImageURL != null
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    imageUrl:
                                        state.accountInformation.userImageURL!)
                                : Image.asset(ImagePath.userAvatarImagePath),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: kPrimary,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16.0),
                                            topRight: Radius.circular(16.0)),
                                      ),
                                      child: Wrap(
                                        alignment: WrapAlignment.end,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.end,
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.camera),
                                            title: const Text('Camera'),
                                            onTap: () {
                                              context
                                                  .read<AccountBloc>()
                                                  .add(UploadAvatarByCamera());
                                              context.pop();
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.image),
                                            title: const Text('Gallery'),
                                            onTap: () {
                                              context
                                                  .read<AccountBloc>()
                                                  .add(UploadAvatarByGallery());
                                              context.pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipOval(
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  color: kWhite,
                                  child: ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      color: kRed,
                                      child: const Icon(Icons.edit),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                      ]),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Email')),
                          Expanded(
                            flex: 2,
                            child: Text(state.accountInformation.email!),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('First Name')),
                          Expanded(
                            flex: 2,
                            child: Text(state.accountInformation.firstName!),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Last Name')),
                          Expanded(
                            flex: 2,
                            child: Text(state.accountInformation.lastName!),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Phone number')),
                          Expanded(
                            flex: 2,
                            child: Text(
                                state.accountInformation.phoneNumber ?? ""),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Gender')),
                          Expanded(
                            flex: 2,
                            child: Text(state.accountInformation.genderName!),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Date Of Birth')),
                          Expanded(
                            flex: 2,
                            child: Text(state.accountInformation.dob != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(state.accountInformation.dob!)
                                : ""),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: Text('Nick name')),
                          Expanded(
                            flex: 2,
                            child: Row(children: [
                              // Text(state.accountInformation.nickname ?? ""),
                              // Spacer(),
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText:
                                          state.accountInformation.nickname ??
                                              ""),
                                  controller: nickNameController,
                                ),
                              ),
                              ElevatedButton(
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          backgroundColor:
                                              const MaterialStatePropertyAll(
                                                  kRed)),
                                  onPressed: () {},
                                  child: const Text('Change'))
                            ]),
                          )
                        ],
                      )
                    ]
                        .map((widget) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: widget,
                            ))
                        .toList(),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    ));
    // );
  }
}
