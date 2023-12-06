import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/modules/authentication/screens/login.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class ResetPassword extends StatefulWidget {
  final String email, pin;
  const ResetPassword({Key? key, required this.pin, required this.email}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool obscure = true;
  bool obscure2 = true;
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return InitialPage(
      noScroll: true,
      child: Padding(
        padding: EdgeInsets.only(
            left: kMicroPadding,
            right: kMicroPadding,
            top: kRegularPadding,
            bottom: kSmallPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Text(
                      createPassword,
                      style: textTheme.displayLarge!.copyWith(color: kPurple50),
                    ),
                    YBox(kMicroPadding),
                    TextInputNoIcon(
                      text: newPass,
                      hintText: enterPassword,
                      inputType: TextInputType.text,
                      obscure: obscure,
                      controller: passwordController,
                      onChanged: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return emptyField;
                        } else {
                          return null;
                        }
                      },
                      icon: InkWell(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: obscure
                            ? const Icon(
                          Icons.remove_red_eye_outlined,
                          color: kLight700,
                        )
                            : SvgPicture.asset(
                          AssetPaths.closeEye,
                          fit: BoxFit.scaleDown,
                          color: kLight700,
                        ),
                      ),
                    ),
                    TextInputNoIcon(
                      text: confirmPassword,
                      hintText: enterPassword,
                      inputType: TextInputType.text,
                      obscure: obscure2,
                      controller: passwordController2,
                      onChanged: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return emptyField;
                        } else if(val != passwordController.text){
                          return "Password misMatch";
                        } else {
                          return null;
                        }
                      },
                      icon: InkWell(
                        onTap: () {
                          setState(() {
                            obscure2 = !obscure2;
                          });
                        },
                        child: obscure2
                            ? const Icon(
                          Icons.remove_red_eye_outlined,
                          color: kLight700,
                        )
                            : SvgPicture.asset(
                          AssetPaths.closeEye,
                          fit: BoxFit.scaleDown,
                          color: kLight700,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Consumer(builder: (context, ref, _) {
                var buttonWidget = LargeButton(
                    title: resetPassword,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(resetPasswordProvider.notifier)
                            .resetPassword(
                            email: widget.email,
                            otp: widget.pin,
                            password: passwordController.text,
                            confirmPassword: passwordController2.text,
                            error: (val)=> showErrorBar(context, val),
                            then: () {
                              pushToAndClearStack(const LogIn());
                            });
                      }
                    });
                return ref.watch(resetPasswordProvider).when(
                    done: (done) => buttonWidget,
                    loading: () => const SpinKitDemo(),
                    error: (val) => buttonWidget);
              })
            ],
          ),
        ),
      ),
    );
  }
}
