import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/provider/auth_provider.dart';
import 'package:shopnownow/modules/authentication/screens/login.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool obscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                createAccount,
                style: textTheme.bodyMedium,
              ),
              YBox(kSmallPadding),
              Text(
                createAccountSub,
                style: textTheme.headlineMedium!.copyWith(height: 1.4),
                textAlign: TextAlign.center,
              ),
              YBox(kLargePadding),
              TextInputNoIcon(
                text: fullName,
                controller: nameController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return emptyField;
                  } else {
                    return null;
                  }
                },
                // controller: emailController,
              ),
              TextInputNoIcon(
                text: emailAddress,
                controller: emailController,
                validator: (val) {
                  if (val!.isEmpty) {
                    return emptyField;
                  } else if (!isEmail(val)) {
                    return invalidEmail;
                  }else {
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
                validator: (val) {
                  if (val!.isEmpty) {
                    return emptyField;
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {},
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
              Consumer(builder: (context, ref, _) {
                var widget = LargeButton(
                    title: signUp,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(signUpProvider.notifier).signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            fullName: nameController.text,
                            error: (val) {
                              showErrorBar(context, val);
                            },
                            then: () {
                              pushToAndClearStack(const HomePage());
                            });
                      }
                    });
                return ref.watch(signUpProvider).when(
                    done: (data) => widget, loading: () => const SpinKitDemo());
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
                  pushReplacementTo(const LogIn());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kMacroPadding, vertical: kRegularPadding),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kSecondaryColor),
                  child: RichText(
                      text: TextSpan(
                          text: haveAccount,
                          style: textTheme.headlineMedium!
                              .copyWith(color: kGrey400),
                          children: [
                        TextSpan(
                            text: " $logIn",
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
