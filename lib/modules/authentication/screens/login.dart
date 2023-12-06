import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/modules/authentication/screens/forgot_password.dart';
import 'package:shopnownow/modules/authentication/screens/signup.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool obscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.only(
          left: kMicroPadding,
          right: kMicroPadding,
          top: kRegularPadding,
          bottom: kSmallPadding),
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                logInContinue,
                style: textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              YBox(kSmallPadding),
              Text(
                logInContinueSub,
                style: textTheme.headlineMedium!.copyWith(height: 1.4),
                textAlign: TextAlign.center,
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
              TextInputNoIcon(
                text: password,
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
              InkWellNoShadow(
                onTap: (){
                  pushTo(ForgotPassword());
                },
                child: Text("$forgotPassword?", style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ), textAlign: TextAlign.left,),
              ),
              YBox(kMicroPadding),

              Consumer(builder: (context, ref, _) {
                var widget = LargeButton(
                    title: logIn,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(logInProvider.notifier).logIn(
                            email: emailController.text,
                            password: passwordController.text,
                            error: (val) {
                              showErrorBar(context, val);
                            },
                            then: () {
                              pushToAndClearStack(const HomePage());
                            });
                      }
                    });
                return ref.watch(logInProvider).when(
                    done: (data) => widget,
                    loading: () => const SpinKitDemo(),
                    error: (val) => widget);
              }),
              YBox(kRegularPadding),
              const OrWidget(),
              YBox(kRegularPadding),
              InkWellNoShadow(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMacroPadding, vertical: kRegularPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(width: 1.5, color: kTextInputBorderColor)),
                  child: Text(
                    continueGuest,
                    style:
                        textTheme.displayLarge!.copyWith(color: kDarkColor300),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              YBox(70),
              InkWellNoShadow(
                onTap: () {
                  pushReplacementTo(const SignUp());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMacroPadding, vertical: kRegularPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kSecondaryColor),
                  child: RichText(
                      text: TextSpan(
                          text: noAccount,
                          style: textTheme.headlineMedium!
                              .copyWith(color: kGrey400),
                          children: [
                        TextSpan(
                            text: " $signUp",
                            style: textTheme.displayLarge!.copyWith(
                              fontSize: 14,
                            ))
                      ])),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
