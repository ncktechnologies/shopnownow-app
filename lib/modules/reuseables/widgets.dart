import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/screens/login.dart';
import 'package:shopnownow/modules/authentication/screens/signup.dart';
import 'package:shopnownow/modules/orders/screen/order_history.dart';
import 'package:shopnownow/modules/profile/screens/profile.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/helpcenter/screens/help_center.dart';
import 'package:shopnownow/modules/savedlist/saved_list.dart';
import 'package:shopnownow/modules/specialrequest/screens/quick_guide.dart';
import 'package:shopnownow/modules/specialrequest/screens/special_request.dart';
import 'package:shopnownow/modules/wallet/screens/wallet.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class InkWellNoShadow extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? highlightColor;

  const InkWellNoShadow(
      {Key? key,
      this.onTap,
      required this.child,
      this.highlightColor = kTransparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: kTransparent,
      highlightColor: highlightColor,
      onTap: onTap,
      child: child,
    );
  }
}

class LargeButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool outlineButton, isLoading, disable;
  final Color? color;

  LargeButton({
    required this.title,
    required this.onPressed,
    this.outlineButton = false,
    this.isLoading = false,
    this.disable = true,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(!disable
              ? kGrey100
              : outlineButton
                  ? kPrimaryWhite
                  : color ?? kPrimaryColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                side: BorderSide(
                  color: outlineButton ? kBright700 : kTransparent,
                ),
                borderRadius: BorderRadius.circular(60)),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
                horizontal: 20, vertical: kRegularPadding),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: textTheme.displayMedium!.copyWith(
            color: outlineButton ? kDarkColor400 : kPrimaryWhite,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  final Widget child;
  final bool noScroll;

  const InitialPage({
    required this.child,
    this.noScroll = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(child: DrawerScaffoldContainer()),
      // resizeToAvoidBottomInset: noScroll ? false : true,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => InkWellNoShadow(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Padding(
              padding: const EdgeInsets.only(left: kRegularPadding),
              child: SvgPicture.asset(
                AssetPaths.moreLogo,
              ),
            ),
          ),
        ),
        leadingWidth: 40,
        title: Image.asset(AssetPaths.logo, height: 40),
        centerTitle: true,
      ),
      body: SafeArea(
        child: noScroll ? child : SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}

class DrawerScaffoldContainer extends StatelessWidget {

  const DrawerScaffoldContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryWhite,
      padding: const EdgeInsets.only(
        left: kMediumPadding, right: kMediumPadding,
        top: 70,
      ),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                menu,
                style: textTheme.displayLarge!
                    .copyWith(color: kPurple50, fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.only(right: kMacroPadding),
                child: InkWellNoShadow(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  child: const Icon(
                    Icons.close,
                    color: kGrey600,
                  ),
                ),
              ),
            ],
          ),
          YBox(kLargePadding),
          SessionManager.getToken() != null
              ? DrawerContainer(
            text: profile,
            onTap: () {
              pushTo(const Profile());
            },
          )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
            text: wallet,
            onTap: () {
              pushTo(const MyWallet());
            },
          )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
            text: orders,
            onTap: () {
              pushTo(const OrderHistory());
            },
          )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
            text: savedList,
            onTap: () {pushTo(const SavedList());},
          )
              : YBox(0),
          DrawerContainer(
            text: specialRequest,
            onTap: () {
              pushTo(const SpecialRequest());
            },
          ),
          SessionManager.getToken() != null
              ? const Padding(
            padding: EdgeInsets.only(right: kMacroPadding),
            child: Divider(
              color: kDividerColor,
              thickness: 1,
              height: 0,
            ),
          ): YBox(0),
          YBox(SessionManager.getToken() != null
              ? kRegularPadding : 0),
          DrawerContainer(
            text: quickGuide,
            onTap: () {
              pushTo(const QuickGuide());
            },
          ),
          DrawerContainer(
            text: share,
            onTap: () {},
          ),
          DrawerContainer(
            text: helpCenter,
            onTap: () {
              pushTo(const HelpCenter());
            },
          ),
          YBox(kMacroPadding),
          const Padding(
            padding: EdgeInsets.only(right: kMacroPadding),
            child: Divider(
              color: kDividerColor,
              thickness: 1,
            ),
          ),
          YBox(kFullPadding),
          SessionManager.getToken() != null
              ?   InkWellNoShadow(
            onTap: (){
              pushToAndClearStack(const LogIn());
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: kMediumPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    signOut,
                    style: textTheme.displayLarge!.copyWith(color: kPurple50),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: kMacroPadding),
                    child: SvgPicture.asset(AssetPaths.downArrow),
                  )
                ],
              ),
            ),
          ) :
          Row(
            children: [
              Expanded(
                  child: LargeButton(
                    onPressed: () {
                      pushTo(const LogIn());
                    },
                    title: logIn,
                    outlineButton: true,
                  )),
              XBox(kRegularPadding),
              Expanded(
                  child: LargeButton(
                    onPressed: () {
                      pushTo(const SignUp());
                    },
                    title: signUp,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({Key? key, required this.text, required this.onTap})
      : super(key: key);

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellNoShadow(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: kMediumPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textTheme.displayLarge!.copyWith(color: kPurple50),
            ),
            Padding(
              padding: const EdgeInsets.only(right: kMacroPadding),
              child: SvgPicture.asset(AssetPaths.arrow),
            )
          ],
        ),
      ),
    );
  }
}

// class PinCodeTextFieldWidget extends StatelessWidget {
//   final Function(String?) onSaved;
//   final Function(String) onChanged;
//   final MainAxisAlignment? mainAlignment;
//   final FocusNode? focusNode;
//   final TextEditingController? controller;
//   final String? hintCharacter;
//   final TextStyle? hintColor;
//
//   const PinCodeTextFieldWidget(
//       {Key? key,
//       required this.onSaved,
//       required this.onChanged,
//       this.focusNode,
//       this.controller,
//       this.mainAlignment,
//       this.hintCharacter,
//       this.hintColor})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return PinCodeTextField(
//         useHapticFeedback: true,
//         keyboardType: TextInputType.number,
//         enableActiveFill: true,
//         mainAxisAlignment: MainAxisAlignment.start,
//         animationDuration: const Duration(milliseconds: 300),
//         cursorColor: kPrimaryColor,
//         controller: controller,
//         errorTextSpace: 25,
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         focusNode: focusNode,
//         validator: (val) {
//           if (val!.isEmpty) {
//             return "Pin is empty";
//           } else if (val.length != 4) {
//             return "Pin must be 4 digits";
//           } else {
//             return null;
//           }
//         },
//         onSaved: onSaved,
//         inputFormatters: [
//           FilteringTextInputFormatter.digitsOnly,
//           LengthLimitingTextInputFormatter(4),
//         ],
//         textStyle: textTheme.bodyLarge!.copyWith(
//           fontWeight: FontWeight.w400,
//           fontSize: 18,
//         ),
//         pinTheme: PinTheme(
//           fieldWidth: 45,
//           fieldHeight: 45,
//           shape: PinCodeFieldShape.box,
//           borderRadius: BorderRadius.circular(kSmallPadding),
//           fieldOuterPadding: mainAlignment == MainAxisAlignment.spaceBetween
//               ? null
//               : const EdgeInsets.only(right: kMediumPadding),
//           selectedColor: kTransparent,
//           inactiveColor: kLightAsh200,
//           activeColor: kGrey700,
//           selectedFillColor: kGrey700,
//           activeFillColor: kGrey700,
//           inactiveFillColor: kPrimaryWhite,
//         ),
//         appContext: context,
//         length: 4,
//         onChanged: onChanged);
//   }
// }
//
// class NotRegistered extends StatelessWidget {
//   final Color? color;
//   final String text;
//   final String subText;
//   final TextAlign? align;
//   final Function() onTap;
//
//   const NotRegistered(
//       {super.key,
//       this.align,
//       this.color,
//       required this.text,
//       required this.subText,
//       required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       textAlign: align ?? TextAlign.center,
//       text: TextSpan(
//         text: text,
//         style: textTheme.displayMedium!.copyWith(color: color ?? kPrimaryWhite),
//         children: [
//           TextSpan(
//               text: subText,
//               recognizer: TapGestureRecognizer()..onTap = onTap,
//               style: textTheme.bodyMedium!
//                   .copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.2)),
//         ],
//       ),
//     );
//   }
// }
//
class OrWidget extends StatelessWidget {
  final Color? color;
  const OrWidget({
    super.key,
    this.color = k200
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Expanded(
          child: Divider(
            thickness: 0.8,
            color: color,
          ),
        ),
        Text("   $orText   ", style: textTheme.headlineMedium),
         Expanded(
          child: Divider(
            thickness: 0.8,
            color: color,
          ),
        )
      ],
    );
  }
}

Widget makeDismissible(
        {required Widget child, required BuildContext context, required Function() onTap}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
