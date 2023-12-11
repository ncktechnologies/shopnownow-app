import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Text(
            contactUs,
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
                "  /  $contactUs",
                style: textTheme.bodyLarge!
                    .copyWith(fontSize: 14, color: kGrey200),
              ),
            ],
          ),
          YBox(kMacroPadding),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kRegularPadding, vertical: kMediumPadding),
            margin: const EdgeInsets.only(bottom: kRegularPadding),
            decoration: BoxDecoration(
                border: Border.all(color: kLightAsh100, width: 1),
                borderRadius: kBorderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContactWidget(
                  icon: AssetPaths.email,
                  text: "hello@chopnownow.com",
                ),ContactWidget(
                  icon: AssetPaths.whatsappLogo,
                  text: "090 9074 3953",
                ),ContactWidget(
                  icon: AssetPaths.liveChat,
                  text: "Live Chat",
                ),
              ],
            ),
          ),
          YBox(kMacroPadding),
          // const OrWidget(color: kLightAsh400),
          // YBox(kMacroPadding),
          //
          // TextInputNoIcon(
          //   text: subject,
          // ),
          // TextInputNoIcon(
          //   text: message,
          //   maxLine: 8,
          // ),
          // YBox(80),
          // LargeButton(title: submit, onPressed: (){}),
          // YBox(kRegularPadding),

        ],
      ),
    ));
  }
}

class ContactWidget extends StatelessWidget {
  final String text, icon;

  const ContactWidget({
    required this.icon, required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Text(
          text,
          style: textTheme.displayLarge!.copyWith(color: kDark400,  fontSize: 10,),
        )
      ],
    );
  }
}
