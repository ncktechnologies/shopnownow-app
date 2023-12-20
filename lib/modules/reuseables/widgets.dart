import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/authentication/screens/login.dart';
import 'package:shopnownow/modules/authentication/screens/signup.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
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
  final bool noIcon;

  const InitialPage({
    required this.child,
    this.noScroll = false,
    this.noIcon = false,
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
        actions: [
          noIcon
              ? YBox(0)
              : InkWellNoShadow(
                  onTap: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: kMediumPadding),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                )
        ],
        leadingWidth: 40,
        title: Image.asset(AssetPaths.logo, height: 40),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth > 600) {
            return Center(
              child: Container(
                width: 800,
                child: SafeArea(
                  child: noScroll
                      ? child
                      : SingleChildScrollView(
                          child: child,
                        ),
                ),
              ),
            );
          } else {
            return SafeArea(
              child: noScroll
                  ? child
                  : SingleChildScrollView(
                      child: child,
                    ),
            );
            // return _buildNormalContainer();
          }
        },
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
        left: kMediumPadding,
        right: kMediumPadding,
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
          DrawerContainer(
            text: home,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              pushToAndClearStack(const HomePage());
            },
          ),
          SessionManager.getToken() != null
              ? DrawerContainer(
                  text: profile,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    pushToAndClearStack(const Profile());
                  },
                )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
                  text: wallet,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    pushToAndClearStack(const MyWallet());
                  },
                )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
                  text: orders,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    pushToAndClearStack(const OrderHistory());
                  },
                )
              : YBox(0),
          SessionManager.getToken() != null
              ? DrawerContainer(
                  text: savedList,
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    pushToAndClearStack(const SavedList());
                  },
                )
              : YBox(0),
          DrawerContainer(
            text: specialRequest,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              pushToAndClearStack(const SpecialRequest());
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
                )
              : YBox(0),
          YBox(SessionManager.getToken() != null ? kRegularPadding : 0),
          DrawerContainer(
            text: quickGuide,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              pushToAndClearStack(const QuickGuide());
            },
          ),
          DrawerContainer(
            text: share,
            onTap: () {},
          ),
          DrawerContainer(
            text: helpCenter,
            onTap: () {
              Scaffold.of(context).closeDrawer();
              pushToAndClearStack(const HelpCenter());
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
              ? InkWellNoShadow(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                    pushToAndClearStack(const LogIn());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: kMediumPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          signOut,
                          style: textTheme.displayLarge!
                              .copyWith(color: kPurple50),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: kMacroPadding),
                          child: SvgPicture.asset(AssetPaths.downArrow),
                        )
                      ],
                    ),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                        child: LargeButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        pushToAndClearStack(const LogIn());
                      },
                      title: logIn,
                      outlineButton: true,
                    )),
                    XBox(kRegularPadding),
                    Expanded(
                        child: LargeButton(
                      onPressed: () {
                        Scaffold.of(context).closeDrawer();
                        pushToAndClearStack(const SignUp());
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

class PageIndicator extends StatelessWidget {
  final int index, currentPage;
  final Color color;
  final Color? inactiveColor;

  PageIndicator(this.index, this.currentPage,
      {this.color = kPurple50, this.inactiveColor = kLightDark400});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: EdgeInsets.all(currentPage == index ? 3 : 0),
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(
        horizontal: kPadding,
      ),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: currentPage == index ? color : inactiveColor,
          shape: BoxShape.circle),
    );
  }
}

class OrWidget extends StatelessWidget {
  final Color? color;
  const OrWidget({super.key, this.color = k200});

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
        {required Widget child,
        required BuildContext context,
        required Function() onTap}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );
