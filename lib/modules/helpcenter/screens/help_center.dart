import 'package:flutter/material.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/helpcenter/screens/contact_us.dart';
import 'package:shopnownow/modules/helpcenter/screens/faq.dart';
import 'package:shopnownow/modules/helpcenter/screens/social_media.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Text(
            helpCenter,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          YBox(kSmallPadding),
          const Divider(
            color: kLightAsh200,
            thickness: 2,
          ),
          YBox(kMicroPadding),
          DrawerContainer(
            text: faq,
            onTap: () {
              pushTo(const FAQ());
            },
          ),DrawerContainer(
            text: contactUs,
            onTap: () {
              pushTo(const ContactUs());
            },
          ),DrawerContainer(
            text: socialMedia,
            onTap: () {
              pushTo(const SocialMedia());
            },
          ),
        ],
      ),
    ));
  }
}
