import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({Key? key}) : super(key: key);

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
                    onTap: (){},
                    text: instagram,
                  ),
                  YBox(kMicroPadding),
                  SocialRow(
                    icon: AssetPaths.facebook,
                    onTap: (){},
                    text: facebook,
                  ),
                  YBox(kMicroPadding),
                  SocialRow(
                    icon: AssetPaths.x,
                    onTap: (){},
                    text: "X",
                  ),
            ])));
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
    return Row(
      children: [
        InkWellNoShadow(
          onTap: onTap,
          child: Container(
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
        ),
        XBox(kMediumPadding),
        Text(
          text,
          style: textTheme.displayLarge!.copyWith(color: kDark400, ),
        )
      ],
    );
  }
}
