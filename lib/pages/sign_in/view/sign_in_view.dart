import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';
import 'package:hikicomic/widget/snackbar.dart';

class SignInDialog extends StatelessWidget {
  const SignInDialog({super.key});

//   @override
//   State<SignInDialog> createState() => _SignInDialogState();
// }

// class _SignInDialogState extends State<SignInDialog> {

  // bool _isFormValid = false;
  // @override
  // void initState() {
  //   valueCheckRememberMe = false;
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formGlobalKey = GlobalKey<FormState>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => SignInBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)),
          child: Container(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.only(
                  top: 18.0,
                ),
                margin: EdgeInsets.only(top: 13.0, right: 8.0),
                decoration: BoxDecoration(
                    color: kPrimary,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                      ),
                    ]),
                child: BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    if (state.status == SignInStatus.success) {
                      SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) async => await successSnakBar(
                                  success: "Sign In Successful", duration: 10)
                              .show(context));
                      Navigator.of(context).pop();
                    }
                    if (state.status == SignInStatus.failure) {
                      context.read<SignInBloc>().add(
                            SignInLoadingEvent(
                                email: emailController.text,
                                password: emailController.text),
                          );
                      SchedulerBinding.instance.addPostFrameCallback(
                          (timeStamp) async => await errorSnakBar(
                                  error: state.message, duration: 10)
                              .show(context));
                    }
                  },
                  builder: (context, state) {
                    var inputDecoration = InputDecoration(
                        errorStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.redAccent.shade100),
                        errorMaxLines: 3,
                        contentPadding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                        hintStyle: TextStyle(fontSize: 12),
                        hintText: "Enter your passsword",
                        labelText: "Password",
                        labelStyle: TextStyle(color: kWhite),
                        // prefixIcon: const Padding(
                        //   padding: EdgeInsets.all(kDefaultPadding),
                        //   child: Icon(
                        //     Icons.lock,
                        //     color: kYellow,
                        //     size: kSmallIconSize,
                        //   ),
                        // ),
                        // suffix: ,

                        focusColor: Colors.grey,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              state.isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: kSmallIconSize,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              context.read<SignInBloc>().add(
                                  SignInObscurePasswordChangedEvent(
                                      isObscure: !state.isObscure));
                            },
                          ),
                        ),
                        border: OutlineInputBorder(
                          gapPadding: 1,
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.white),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          gapPadding: 1,
                          borderSide: BorderSide(width: 0.5, color: kRed),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          gapPadding: 1,
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.grey),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ));
                    return Form(
                      key: formGlobalKey,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'One-click social media Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        iconSize: 40,
                                        onPressed: () {},
                                        icon: Image.asset(
                                          ImagePath.iconPathGoogle,
                                          //height: ,
                                          //width: 300,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        iconSize: 40,
                                        onPressed: () {},
                                        icon: Image.asset(
                                          ImagePath.iconPathFacebook,
                                          //height: ,
                                          //width: 300,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                        iconSize: 40,
                                        onPressed: () {},
                                        icon: Image.asset(
                                            ImagePath.iconPathTwitter
                                            //height: ,
                                            //width: 300,
                                            )),
                                  ],
                                ),
                              ),
                              Text(
                                'Sign In with Email',
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {
                                  context.read<SignInBloc>().add(
                                      SignInEmailChangedEvent(email: value));
                                },
                                validator: (value) {
                                  // if (EmailValidator.validate(value!)) {
                                  //   context.read<SignInBloc>().add(
                                  //       const SignInEmailValidatedEvent(
                                  //           isValidated: true));
                                  //   // formGlobalKey.currentState!.save();
                                  //   return null;
                                  // }
                                  if (RegExp(
                                          r'^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$')
                                      .hasMatch(value!.trim())) {
                                    context.read<SignInBloc>().add(
                                        const SignInEmailValidatedEvent(
                                            isValidated: true));
                                    // formGlobalKey.currentState!.save();
                                    return null;
                                  }
                                  if (value.trim().isEmpty) {
                                    context.read<SignInBloc>().add(
                                        const SignInEmailValidatedEvent(
                                            isValidated: false));
                                    return "Enter your Email";
                                  }
                                  context.read<SignInBloc>().add(
                                      const SignInEmailValidatedEvent(
                                          isValidated: false));

                                  return "Invalid Email";
                                },
                                controller: emailController,
                                cursorColor: kWhite,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: InputDecoration(
                                    errorStyle: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: Colors.redAccent.shade100),
                                    // prefixIcon: Padding(
                                    //   padding: EdgeInsets.all(kDefaultPadding),
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
                                      borderSide:
                                          BorderSide(width: 0.5, color: kRed),
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
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  context.read<SignInBloc>().add(
                                      SignInPasswordChangedEvent(
                                          password: value));
                                },
                                maxLength: 32,
                                obscureText: state.isObscure,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    context.read<SignInBloc>().add(
                                        const SignInPasswordValidatedEvent(
                                            isValidated: false));
                                    return "Enter your password";
                                  } else {
                                    if (value.trim().length < 6) {
                                      context.read<SignInBloc>().add(
                                          const SignInPasswordValidatedEvent(
                                              isValidated: false));
                                      return "Your password must be at least 6 characters long";
                                    } else {
                                      context.read<SignInBloc>().add(
                                          const SignInPasswordValidatedEvent(
                                              isValidated: true));
                                      return null;
                                    }
                                  }
                                },
                                controller: passwordController,
                                cursorColor: kWhite,
                                style: Theme.of(context).textTheme.bodyMedium,
                                decoration: inputDecoration,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // BlocBuilder<
                                      //     CheckBoxRememberMeCubit, bool>(
                                      //   builder: (context, isChecked) {
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Checkbox(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            activeColor: kRed,
                                            value: state.rememberMe,
                                            onChanged: (value) {
                                              context.read<SignInBloc>().add(
                                                  SignInRememberMeChangedEvent(
                                                      rememberMe: value!));
                                            }
                                            // setState(() {
                                            //   valueCheckRememberMe =
                                            //       !valueCheckRememberMe;
                                            // }),
                                            ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),

                                      // },
                                      // ),
                                      Text(
                                        'Remember me',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        context.pushNamed('forgot-password'),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: kBodySmallFontSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
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
                                      backgroundColor: state.emailValidated &&
                                              state.passwordValidated
                                          ? kRed
                                          : kGrey),
                                  onPressed: () {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      formGlobalKey.currentState!.save();
                                      context.read<SignInBloc>().add(
                                            SignInButtonPressedEvent(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim()),
                                          );
                                    }
                                    return;
                                  },
                                  child:
                                      // state.status == SignInStatus.loading
                                      //     ? const CircularProgressIndicator()
                                      // :
                                      Text(
                                    'Sign In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("You don't have an account? "),
                                  GestureDetector(
                                      onTap: () => context.pushNamed("sign-up"),
                                      // Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               const SignUpView()),
                                      //     ),
                                      child: Text(
                                        'Sign Up',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ))
                                ],
                              ),
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
              Positioned(
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.close, color: kRed),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// class BuildRememberMe extends StatefulWidget {
//   const BuildRememberMe({super.key});

//   @override
//   State<BuildRememberMe> createState() => _BuildRememberMeState();
// }

// class _BuildRememberMeState extends State<BuildRememberMe> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
