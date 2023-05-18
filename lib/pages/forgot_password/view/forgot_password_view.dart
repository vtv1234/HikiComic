import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/snackbar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Forgot Password",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: kWhite),
          ),
          //foregroundColor: darkAppBarTheme.backgroundColor,
          elevation: 0,
          backgroundColor: kAppBarDark,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: kWhite,
              )),
        ),
        backgroundColor: kPrimary,
        body: BlocProvider(
          create: (context) => ForgotPasswordBloc(),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) async {
              if (state is ForgotPasswordSuccess) {
                SchedulerBinding.instance.addPostFrameCallback(
                    (timeStamp) async => await successSnakBar(
                            success: state.message, duration: 10)
                        .show(context));
                await context.pushNamed('verify-forgot-password', params: {
                  'email': state.email,
                });
              }
              if (state is ForgotPasswordFailure) {
                errorSnakBar(error: state.error, duration: 10).show(context);
              }
            },
            buildWhen: (previous, current) =>
                previous != current && current is ForgotPasswordLoading,
            builder: (context, state) {
              if (state is ForgotPasswordLoading) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(height: 20),
                      Text(
                        "Please check your email for the OTP we have sent and enter it in the field provided to reset password",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: formGlobalKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  context
                                      .read<ForgotPasswordBloc>()
                                      .add(EmailChangedEvent(value));
                                },
                                validator: (value) {
                                  if (RegExp(
                                          r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$')
                                      .hasMatch(value!.trim())) {
                                    context.read<ForgotPasswordBloc>().add(
                                        EmailValidateEvent(
                                            email: value, isValidated: true));
                                    // formGlobalKey.currentState!.save();
                                    return null;
                                  }
                                  if (value.trim().isEmpty) {
                                    context.read<ForgotPasswordBloc>().add(
                                        EmailValidateEvent(
                                            email: value, isValidated: false));
                                    return "Enter your Email";
                                  }
                                  context.read<ForgotPasswordBloc>().add(
                                      EmailValidateEvent(
                                          email: value, isValidated: false));

                                  return "Invalid Email";
                                },
                                controller: emailController,
                                cursorColor: kWhite,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    errorStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: kRed),
                                    // prefixIcon: Padding(
                                    //   padding: EdgeInsets.all(
                                    //       kDefaultPadding),
                                    //   child: Icon(
                                    //     Icons.email,
                                    //     color: kYellow,
                                    //     size: kSmallIconSize,
                                    //   ),
                                    // ),
                                    border: OutlineInputBorder(
                                      gapPadding: 1,
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      gapPadding: 1,
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.red),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    contentPadding: EdgeInsets.all(8),
                                    hintStyle: TextStyle(fontSize: 12),
                                    hintText: "Enter your Email",
                                    labelStyle: TextStyle(color: kWhite),
                                    labelText: "Email",
                                    enabledBorder: OutlineInputBorder(
                                      gapPadding: 1,
                                      borderSide: BorderSide(
                                          width: 0.5, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                // height: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 50),

                                      // padding: MaterialStateProperty.all(
                                      //     EdgeInsets.symmetric(horizontal: 10)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      backgroundColor: state.isEmailValidated
                                          ? kRed
                                          : kGrey),
                                  onPressed: () {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      formGlobalKey.currentState!.save();
                                      context.read<ForgotPasswordBloc>().add(
                                            SendRequestForgotPasswordEvent(
                                              email:
                                                  emailController.text.trim(),
                                            ),
                                          );
                                    }
                                    return;
                                  },
                                  child:
                                      // state.status == SignUpStatus.loading
                                      //     ? const CircularProgressIndicator()
                                      // :
                                      Text(
                                    'Next',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ]),
                  ),
                );
              }
              return Container();
            },
          ),
        ));
  }
}
