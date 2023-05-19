import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hikicomic/utils/colors.dart';

import 'package:hikicomic/widget/snackbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
  DateTime lastPressedAt = DateTime.now();
  TextEditingController textEditingController = TextEditingController();
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 8),
                      child: Text(
                        "Please check your email for the OTP we have sent and enter it in the field provided",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
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
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            color: Colors.green.shade600,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,
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
                            inactiveFillColor: Colors.black,
                            inactiveColor: kWhite,
                            selectedFillColor: Colors.grey.shade600,
                            selectedColor: Colors.red,
                            activeColor: Colors.grey.shade100,
                            activeFillColor: Colors.grey.shade600,
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
                          onChanged: (value) {
                            debugPrint(value);
                            setState(() {
                              currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
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
                                const Duration(seconds: 30)) {
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
                      ),
                      child: TextButton(
                        onPressed: () {
                          formKey.currentState!.validate();
                          context.read<OtpBloc>().add(SendOtp(
                              email: widget.email!,
                              password: widget.password!,
                              otp: textEditingController.text));
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
