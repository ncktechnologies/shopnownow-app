
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/modules/authentication/screens/reset_password.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/widgets.dart';

class VerifyOtp extends StatefulWidget {
  final String email;
  const VerifyOtp({Key? key, required this.email}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
      noScroll: true,
        child: Padding(
      padding: const EdgeInsets.only(
          left: kMicroPadding,
          right: kMicroPadding,
          top: kRegularPadding,
          bottom: kSmallPadding),
      child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  verifyOtp,
                  style: textTheme.displayLarge!.copyWith(color: kPurple50),
                ),
                YBox(kMicroPadding),
                PinCodeTextFieldWidget(
                  onSaved: (val) {},
                  onChanged: (val) {},
                  controller: pinController,
                ),
                 NoOtp(email: widget.email,)
              ],
            ),
          ),
          Consumer(builder: (context, ref, _) {
            var buttonWidget = LargeButton(
                title: resetPassword,
                onPressed: () {

                  if (pinController.text.isEmpty) {
                    showErrorBar(context, "Pin cannot be empty");
                  } else {
                    pushTo(ResetPassword(
                      email: widget.email,
                      pin: pinController.text,
                    ));
                    // ref
                    //     .read(forgotVerifyOtpProvider.notifier)
                    //     .forgotVerifyOtp(
                    //     email: widget.email,
                    //     otp: pinController.text,
                    //     then: () {
                    //
                    // });
                  }
                });
            return ref.watch(forgotVerifyOtpProvider).when(
                done: (done) => buttonWidget,
                loading: () => const SpinKitDemo(),
                error: (val) => buttonWidget);
          })

        ],
      ),
    ));
  }
}
