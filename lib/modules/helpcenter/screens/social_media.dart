import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({Key? key}) : super(key: key);

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              YBox(kMacroPadding),
              Text(
                socialMedia,
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
              Row(
                children: [
                  Text(
                    home,
                    style: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "  /  ",
                    style: textTheme.bodyLarge!
                        .copyWith(fontSize: 14, color: kGrey200),
                  ),
                  Text(
                    helpCenter,
                    style: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "  /  $socialMedia",
                    style: textTheme.bodyLarge!
                        .copyWith(fontSize: 14, color: kGrey200),
                  ),
                ],
              ),
                  YBox(50),
                  SocialRow(
                    icon: AssetPaths.instagram,
                    onTap: openInstagram
                    ,
                    text: instagram,
                  ),
                  YBox(kMicroPadding),
                  SocialRow(
                    icon: AssetPaths.facebook,
                    onTap: openFacebook,
                    text: facebook,
                  ),
                  YBox(kMicroPadding),
                  SocialRow(
                    icon: AssetPaths.x,
                    onTap: openTwitter,
                    text: "X",
                  ),
            ])));

  }

  void openTwitter() async {
    final twitterUrl =
        "https://twitter.com/${SessionManager.getTwitter()!.split("@").last}";
    if (await canLaunchUrl(Uri.parse(twitterUrl))) {
      await launchUrl(Uri.parse(twitterUrl));
    } else {
      showErrorBar(context, "The twitter link provided is invalid");
    }
  }

  void openInstagram() async {

    final instagramUrl =
        "https://www.instagram.com/${SessionManager.getInstagram()!.split("@").last}";
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else {
      showErrorBar(context, "The instagram link provided is invalid");
    }
  }

  void openFacebook() async {
    final facebookUrl =
        SessionManager.getFacebook()!.split("@").last;
    if (await canLaunchUrl(Uri.parse(facebookUrl))) {
      await launchUrl(Uri.parse(facebookUrl));
    } else {
      showErrorBar(context, "The facebook link provided is invalid");
    }
  }
}

class SocialRow extends StatelessWidget {
 final Function() onTap;
 final String icon, text;
  const SocialRow({
    super.key,
   required this.onTap,
    required this.icon,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return InkWellNoShadow(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(kRegularPadding),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kLightRed100,
            ),
            child: SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              height: 24,
              width: 24,
            ),
          ),
          XBox(kMediumPadding),
          Text(
            text,
            style: textTheme.displayLarge!.copyWith(color: kDark400, ),
          )
        ],
      ),
    );
  }
}
