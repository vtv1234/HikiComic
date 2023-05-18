import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';

import 'package:hikicomic/widget/snackbar.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Sign Up",
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
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            //controller: NeverScrollableScrollPhysics(),
            child: Container(
              // color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text(
                          //   "Sign up",
                          //   style: TextStyle(
                          //       fontSize: 30,
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black),
                          // ),
                          const SizedBox(
                            height: 100,
                          ),
                          Image.asset(ImagePath.logoPath),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                      BlocProvider(
                        create: (context) => SignUpBloc(
                            authenticationRepository:
                                RepositoryProvider.of<AuthenticationRepository>(
                                    context)),
                        child: BlocConsumer<SignUpBloc, SignUpState>(
                          listener: (context, state) {
                            if (state.status == SignUpStatus.success) {
                              SchedulerBinding.instance.addPostFrameCallback(
                                  (timeStamp) async => await successSnakBar(
                                          success: state.message, duration: 10)
                                      .show(context));
                              context.pushNamed('otp', params: {
                                'email': state.email,
                                'password': state.password
                              });
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => OTPScreen(
                              //           email: state.email,
                              //           password: state.password),
                              //     ));
                            }
                            if (state.status == SignUpStatus.failure) {
                              context.read<SignUpBloc>().add(
                                    SignUpLoadingEvent(
                                        email: emailController.text,
                                        password: emailController.text,
                                        confirmPassword:
                                            confirmPasswordController.text),
                                  );
                              SchedulerBinding.instance.addPostFrameCallback(
                                  (timeStamp) async => await errorSnakBar(
                                          error: state.message, duration: 10)
                                      .show(context));
                            }
                          },
                          builder: (context, state) {
                            return Form(
                              key: formGlobalKey,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        onChanged: (value) {
                                          context.read<SignUpBloc>().add(
                                              SignUpEmailChangedEvent(
                                                  email: value));
                                        },
                                        validator: (value) {
                                          if (RegExp(
                                                  r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$')
                                              .hasMatch(value!.trim())) {
                                            context.read<SignUpBloc>().add(
                                                const SignUpEmailValidatedEvent(
                                                    isValidated: true));
                                            // formGlobalKey.currentState!.save();
                                            return null;
                                          }
                                          if (value.trim().isEmpty) {
                                            context.read<SignUpBloc>().add(
                                                const SignUpEmailValidatedEvent(
                                                    isValidated: false));
                                            return "Enter your Email";
                                          }
                                          context.read<SignUpBloc>().add(
                                              const SignUpEmailValidatedEvent(
                                                  isValidated: false));

                                          return "Invalid Email";
                                        },
                                        controller: emailController,
                                        cursorColor: kWhite,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
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
                                                  width: 0.5,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            contentPadding: EdgeInsets.all(8),
                                            hintStyle: TextStyle(fontSize: 12),
                                            hintText: "Enter your Email",
                                            labelStyle:
                                                TextStyle(color: kWhite),
                                            labelText: "Email",
                                            enabledBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          context.read<SignUpBloc>().add(
                                              SignUpPasswordChangedEvent(
                                                  password: value));
                                        },
                                        maxLength: 32,
                                        obscureText: state.isPasswordObscure,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            context.read<SignUpBloc>().add(
                                                const SignUpPasswordValidatedEvent(
                                                    isValidated: false));
                                            return "Enter your password";
                                          } else {
                                            if (value.trim().length < 6) {
                                              context.read<SignUpBloc>().add(
                                                  const SignUpPasswordValidatedEvent(
                                                      isValidated: false));
                                              return "Your password must be at least 6 characters long";
                                            } else {
                                              context.read<SignUpBloc>().add(
                                                  const SignUpPasswordValidatedEvent(
                                                      isValidated: true));
                                              return null;
                                            }
                                          }
                                        },
                                        controller: passwordController,
                                        cursorColor: kWhite,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                            hoverColor: Colors.white,
                                            errorStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: kRed),
                                            errorMaxLines: 3,
                                            contentPadding: EdgeInsets.all(8),
                                            hintStyle: TextStyle(fontSize: 12),
                                            hintText: "Enter your passsword",
                                            labelText: "Password",
                                            labelStyle:
                                                TextStyle(color: kWhite),
                                            // prefixIcon: const Padding(
                                            //   padding: EdgeInsets.all(
                                            //       kDefaultPadding),
                                            //   child: Icon(
                                            //     Icons.lock,
                                            //     color: kYellow,
                                            //     size: kSmallIconSize,
                                            //   ),
                                            // ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                state.isPasswordObscure
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                size: kSmallIconSize,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                context.read<SignUpBloc>().add(
                                                    SignUpObscurePasswordChangedEvent(
                                                        isObscure: !state
                                                            .isPasswordObscure));
                                              },
                                            ),
                                            border: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                      ),
                                      TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          context.read<SignUpBloc>().add(
                                              SignUpConfirmPasswordChangedEvent(
                                                  confirmPassword: value));
                                        },
                                        maxLength: 32,
                                        obscureText:
                                            state.isConfirmPasswordObscure,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            context.read<SignUpBloc>().add(
                                                const SignUpConfirmPasswordValidatedEvent(
                                                    isValidated: false));
                                            return 'Enter your confirm password';
                                          }
                                          if (value.trim() !=
                                              passwordController.text) {
                                            context.read<SignUpBloc>().add(
                                                const SignUpConfirmPasswordValidatedEvent(
                                                    isValidated: false));
                                            return 'Please ensure that the password entered in the confirmation field matches the original password you entered.';
                                          }
                                          context.read<SignUpBloc>().add(
                                              const SignUpConfirmPasswordValidatedEvent(
                                                  isValidated: true));
                                          return null;
                                        },
                                        controller: confirmPasswordController,
                                        cursorColor: kWhite,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        decoration: InputDecoration(
                                            errorStyle: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(color: kRed),
                                            errorMaxLines: 3,
                                            contentPadding: EdgeInsets.all(8),
                                            hintStyle: TextStyle(fontSize: 12),
                                            hintText:
                                                "Enter your confirm passsword",
                                            labelText: "Confirm Password",
                                            labelStyle:
                                                TextStyle(color: kWhite),
                                            // prefixIcon: const Padding(
                                            //   padding: EdgeInsets.all(
                                            //       kDefaultPadding),
                                            //   child: Icon(
                                            //     Icons.lock,
                                            //     // color: kYellow,
                                            //     size: kSmallIconSize,
                                            //   ),
                                            // ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                state.isConfirmPasswordObscure
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                size: kSmallIconSize,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                context.read<SignUpBloc>().add(
                                                    SignUpObscureConfirmPasswordChangedEvent(
                                                        isObscure: !state
                                                            .isConfirmPasswordObscure));
                                              },
                                            ),
                                            border: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.red),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              gapPadding: 1,
                                              borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   // crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Row(
                                      //       children: [
                                      //         // BlocBuilder<
                                      //         //     CheckBoxRememberMeCubit, bool>(
                                      //         //   builder: (context, isChecked) {
                                      //         SizedBox(
                                      //           height: 20,
                                      //           width: 20,
                                      //           child: Checkbox(
                                      //               materialTapTargetSize:
                                      //                   MaterialTapTargetSize
                                      //                       .shrinkWrap,
                                      //               activeColor: Colors.red,
                                      //               value: state.rememberMe,
                                      //               onChanged: (value) {
                                      //                 context
                                      //                     .read<SignUpBloc>()
                                      //                     .add(
                                      //                         SignUpRememberMeChangedEvent(
                                      //                             rememberMe:
                                      //                                 value!));
                                      //               }
                                      //               // setState(() {
                                      //               //   valueCheckRememberMe =
                                      //               //       !valueCheckRememberMe;
                                      //               // }),
                                      //               ),
                                      //         ),
                                      //         SizedBox(
                                      //           width: 10,
                                      //         ),

                                      //         // },
                                      //         // ),
                                      //         Text(
                                      //           'Remember me',
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodySmall,
                                      //         ),
                                      //       ],
                                      //     ),
                                      //     Text(
                                      //       "Forgot Password?",
                                      //       style: TextStyle(
                                      //           fontSize: kBodySmallFontSize,
                                      //           fontWeight: FontWeight.bold),
                                      //     )
                                      //   ],
                                      // ),
                                      SizedBox(
                                        width: double.infinity,
                                        // height: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 50),

                                              // padding: MaterialStateProperty.all(
                                              //     EdgeInsets.symmetric(horizontal: 10)),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0)),
                                              backgroundColor: state
                                                          .emailValidated &&
                                                      state.passwordValidated
                                                  ? kRed
                                                  : kGrey),
                                          onPressed: () {
                                            if (formGlobalKey.currentState!
                                                .validate()) {
                                              formGlobalKey.currentState!
                                                  .save();
                                              context.read<SignUpBloc>().add(
                                                    SignUpButtonPressedEvent(
                                                        email: emailController
                                                            .text
                                                            .trim(),
                                                        password:
                                                            passwordController
                                                                .text
                                                                .trim(),
                                                        confirmPassword:
                                                            confirmPasswordController
                                                                .text
                                                                .trim()),
                                                  );
                                            }
                                            return;
                                          },
                                          child:
                                              // state.status == SignUpStatus.loading
                                              //     ? const CircularProgressIndicator()
                                              // :
                                              Text(
                                            'Sign Up',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [
                                      //     Text("You don't have an account? "),
                                      //     GestureDetector(
                                      //         onTap: () => Navigator.push(
                                      //               context,
                                      //               MaterialPageRoute(
                                      //                   builder: (context) =>
                                      //                       const SignUpView()),
                                      //             ),
                                      //         child: Text(
                                      //           'Sign Up',
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .headlineSmall,
                                      //         ))
                                      //   ],
                                      // ),
                                      // Text('You have an account? Sign In')
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ]
                                        .map((widget) => Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: widget,
                                            ))
                                        .toList(),
                                  )),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: kWhite),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: Text(
                              "Sign In",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: kWhite,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
