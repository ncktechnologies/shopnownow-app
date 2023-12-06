import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/modules/authentication/screens/verify_otp.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

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
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      forgotPassword,
                      style: textTheme.displayLarge!.copyWith(color: kPurple50),
                    ),
                    YBox(kMicroPadding),
                    TextInputNoIcon(
                      text: emailAddress,
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return emptyField;
                        } else if (!isEmail(val)) {
                          return invalidEmail;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Consumer(builder: (context, ref, _) {
                var widget = LargeButton(
                    title: resetPassword,
                    onPressed: () {
                      if (emailController.text.isEmpty) {
                        showErrorBar(context, "Email Address cannot be empty");
                      } else {
                        ref
                            .read(forgotPasswordProvider.notifier)
                            .forgotPassword(
                                email: emailController.text, then: () {
                                  pushTo(VerifyOtp(
                                    email: emailController.text
                                  ));
                        });
                      }
                    });
                return ref.watch(forgotPasswordProvider).when(
                    done: (done) => widget,
                    loading: () => const SpinKitDemo(),
                    error: (val) => widget);
              })
            ],
          ),
        ));
  }
}
