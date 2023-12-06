// import 'package:flutter/material.dart';
//
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class SpinKitDemo extends StatelessWidget {
  final double? size;
  final Color? color;

  const SpinKitDemo({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingFour(
      color: color ?? kPrimaryColor,
      size: size ?? 35,
    );
  }
}

class PinCodeTextFieldWidget extends StatelessWidget {
  final Function(String?) onSaved;
  final Function(String) onChanged;
  final MainAxisAlignment? mainAlignment;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintCharacter;
  final TextStyle? hintColor;

  const PinCodeTextFieldWidget(
      {Key? key,
      required this.onSaved,
      required this.onChanged,
      this.focusNode,
      this.controller,
      this.mainAlignment,
      this.hintCharacter,
      this.hintColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return PinCodeTextField(
        useHapticFeedback: true,
        keyboardType: TextInputType.number,
        enableActiveFill: true,
        mainAxisAlignment: MainAxisAlignment.center,
        animationDuration: const Duration(milliseconds: 300),
        cursorColor: kPrimaryColor,
        controller: controller,
        errorTextSpace: 25,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: focusNode,
        validator: (val) {
          if (val!.isEmpty) {
            return "Pin is empty";
          } else if (val.length != 4) {
            return "Pin must be 4 digits";
          } else {
            return null;
          }
        },
        onSaved: onSaved,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        textStyle: textTheme.headlineMedium!.copyWith(color: kDarkColor400),
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: kGrey600,
        ),
        pinTheme: PinTheme(
          fieldWidth: 80,
          fieldHeight: 60,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(kSmallPadding),
          borderWidth: 2,
          fieldOuterPadding: mainAlignment == MainAxisAlignment.spaceBetween
              ? null
              : const EdgeInsets.only(right: kSmallPadding),
          selectedColor: kTextInputBorderColor,
          inactiveColor: kTextInputBorderColor,
          activeColor: kTextInputBorderColor,
          selectedFillColor: kTransparent,
          activeFillColor: kTransparent,
          inactiveFillColor: kTransparent,
          disabledColor: Colors.pink
        ),
        appContext: context,
        length: 4,
        onChanged: onChanged);
  }
}

class NoOtp extends StatefulWidget {
  final String email;
  const NoOtp({
    super.key,
    required this.email
  });

  @override
  State<NoOtp> createState() => _NoOtpState();
}

class _NoOtpState extends State<NoOtp> {
  Timer? countDown;
  int secs = 60;
  late DateTime _endTime;
  bool _canSend = false;

  void startTimer() {
    // timeCheck() = "60";
    secs = 60;
    countDown?.cancel();

    _endTime = DateTime.now().add(Duration(seconds: secs));
    countDown = Timer.periodic(const Duration(seconds: 1), (timer) {
      while (DateTime.now().isBefore(_endTime)) {
        setState(() {
          secs = _endTime.difference(DateTime.now()).inSeconds;
        });
        return;
      }
      if (secs <= 1) {
        setState(() {
          _canSend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    countDown!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _){
      var buttonWidget = RichText(
        text: TextSpan(
          text: resendOtp,
          style: textTheme.titleMedium!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          children: [
            TextSpan(
                text: timeCheck() == "00"
                    ? " Resend"
                    : " (${timeCheck()}secs)",
                style: textTheme.titleMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kLightRed400
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = timeCheck() == "00" ? () {
                  ref.read(resendOtpProvider.notifier).resendOtp(email: widget.email, then: (){
                    startTimer();
                  });

                  } : null),
          ],
        ),
      );
      return ref.watch(resendOtpProvider).when(done: (data)=>buttonWidget, error: (val)=> buttonWidget, loading: ()=> const SpinKitDemo());
    });

  }

  String timeCheck() {
    return secs == 60
        ?
        // "${Duration(seconds: secs).inMinutes.remainder(60)}:"
        Duration(seconds: secs)
            .inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0')
        :
        // : "0${Duration(seconds: secs).inMinutes.remainder(60)}:"
        Duration(seconds: secs)
            .inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
  }
}

//
// class GlobalErrorWidget extends StatelessWidget {
//   const GlobalErrorWidget({Key? key, required this.onTap, this.message})
//       : super(key: key);
//
//   final Function() onTap;
//   final String? message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(kLargePadding),
//       child: Column(
//         children: [
//           Text(
//             message ?? "An error Occurred. Please refresh this page",
//             style: TextStyle(
//               color: Colors.red,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           YBox(kRegularPadding),
//           InkWellNoShadow(
//               onTap: onTap,
//               child: Icon(
//                 Icons.refresh,
//                 color: Colors.red,
//               ))
//         ],
//       ),
//     );
//   }
// }
