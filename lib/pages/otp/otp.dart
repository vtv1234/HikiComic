import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hikicomic/utils/colors.dart';

import 'package:hikicomic/widget/snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:async/async.dart';

import 'bloc/otp_bloc.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
    required this.email,
    required this.password,
    // this.phoneNumber,
  }) : super(key: key);

  final String? email;
  final String? password;

  @override
  State<OTPScreen> createState() => _OTPScreen();
}

class _OTPScreen extends State<OTPScreen> {
  final CancelableOperation _debounce = CancelableOperation.fromFuture(
    Future.delayed(Duration(seconds: 30)),
  );
  DateTime lastPressedAt = DateTime.now();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "OTP Verification",
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
        create: (context) => OtpBloc(),
        child: BlocConsumer<OtpBloc, OtpState>(
          listener: (context, state) {
            if (state is OtpSuccess) {
              successSnakBar(success: state.message, duration: 10)
                  .show(context);
              Future.delayed(
                  const Duration(seconds: 1), () => context.goNamed('home'));
            }
            if (state is OtpFailure) {
              errorSnakBar(error: state.error, duration: 10).show(context);
            }
            if (state is OtpResendEmailVerificationSuccess) {
              successSnakBar(success: state.message, duration: 10)
                  .show(context);
              // Future.delayed(
              //     Duration(seconds: 1), () => context.goNamed('home'));
            }
            if (state is OtpResendEmailVerificationFailure) {
              errorSnakBar(error: state.error, duration: 10).show(context);
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 3,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: Image.asset(Constants.otpGifImage),
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 8.0),
                    //   child: Text(
                    //     'OTP Verification',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 22),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: Text(
                        "Please check your email for the OTP we have sent and enter it in the field provided",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     text:
                      //         "Please check your email for the OTP we have sent and enter it in the field provided",
                      //     children: [
                      //       // TextSpan(
                      //       //   text: "${widget.phoneNumber}",
                      //       //   style: const TextStyle(
                      //       //     color: kWhite,
                      //       //     fontWeight: FontWeight.bold,
                      //       //     fontSize: 15,
                      //       //   ),
                      //       // ),
                      //     ],
                      //     style: const TextStyle(
                      //       color: kWhite,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 30,
                        ),
                        child: PinCodeTextField(
                          autoFocus: true,
                          // focusNode: ,
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
                          // obscureText: true,
                          // obscuringCharacter: '*',
                          // obscuringWidget: const FlutterLogo(
                          //   size: 24,
                          // ),
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 3) {
                              return "Enter your OTP";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.underline,
                            // borderRadius: BorderRadius.circular(15),
                            inactiveFillColor: Colors.black,
                            inactiveColor: kWhite,
                            selectedFillColor: Colors.grey.shade600,
                            selectedColor: Colors.red,
                            activeColor: Colors.grey.shade100,
                            activeFillColor: Colors.grey.shade600,

                            // borderRadius: BorderRadius.circular(5),
                            // fieldHeight: 50,
                            // fieldWidth: 40,
                            // activeFillColor: Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        hasError
                            ? "*Please fill up all the cells properly"
                            : "",
                        style: const TextStyle(
                          // color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't receive the code? ",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            if (DateTime.now().difference(lastPressedAt) >=
                                Duration(seconds: 30)) {
                              // Execute the function here
                              context.read<OtpBloc>().add(
                                  ResendEmailVerificationEvent(
                                      widget.email!, widget.password!));
                              lastPressedAt = DateTime.now();
                            }
                            if (DateTime.now()
                                    .difference(lastPressedAt)
                                    .inSeconds !=
                                0) {
                              infoSnakBar(
                                      info:
                                          "Resend after ${30 - DateTime.now().difference(lastPressedAt).inSeconds} seconds",
                                      duration: 10)
                                  .show(context);
                            }

                            // if (!_debounce.isCompleted) {
                            //   infoSnakBar(
                            //           info: "Resend after 30 second",
                            //           duration: 5)
                            //       .show(context);

                            //   // _debounce = CancelableOperation.fromFuture(
                            //   //   Future.delayed(Duration(seconds: 1)),
                            //   // );
                            //   _debounce.value.then((_) {
                            //     // Call your function here
                            //     context.read<OtpBloc>().add(
                            //         ResendEmailVerificationEvent(
                            //             widget.email!, widget.password!));
                            //   }
                            //   );
                            // }
                            // context.read<OtpBloc>().add(
                            //       ResendEmailVerificationEvent(
                            //           widget.email!, widget.password!));
                          },
                          child: const Text(
                            "Resend",
                            style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 30),
                      decoration: BoxDecoration(
                        color: kRed,
                        borderRadius: BorderRadius.circular(5),
                        // boxShadow: [
                        //   BoxShadow(
                        //       color: Colors.red.shade200,
                        //       offset: const Offset(1, -2),
                        //       blurRadius: 5),
                        //   BoxShadow(
                        //       color: Colors.red.shade200,
                        //       offset: const Offset(-1, 2),
                        //       blurRadius: 5)
                        // ]
                      ),
                      child: TextButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                          context.read<OtpBloc>().add(SendOtp(
                              email: widget.email!,
                              password: widget.password!,
                              otp: textEditingController.text));
                          // conditions for validating
                          // if (currentText.length != 6 ||
                          //     currentText != "123456") {
                          //   errorController!.add(ErrorAnimationType
                          //       .shake); // Triggering error shake animation
                          //   setState(() => hasError = true);
                          // } else {
                          //   setState(
                          //     () {
                          //       hasError = false;
                          //       snackBar("OTP Verified!!");
                          //     },
                          //   );
                          // }
                        },
                        child: Center(
                          child: Text(
                            "VERIFY".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Flexible(
                    //       child: TextButton(
                    //         child: const Text("Clear"),
                    //         onPressed: () {
                    //           textEditingController.clear();
                    //         },
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: TextButton(
                    //         child: const Text("Set Text"),
                    //         onPressed: () {
                    //           setState(() {
                    //             textEditingController.text = "123456";
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
