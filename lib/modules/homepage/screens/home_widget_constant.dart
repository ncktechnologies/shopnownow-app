import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class HomeMenuItems{
  final String icon;
  final String text;

  HomeMenuItems({required this.text, required this.icon});
}

List<String> pay = [debitCard, payWallet];

List<HomeMenuItems> menuItems = [
  HomeMenuItems(text: groceries, icon: AssetPaths.grocery),
  HomeMenuItems(text: homeCare, icon: AssetPaths.homeCare),
  HomeMenuItems(text: alcohol, icon: AssetPaths.alcohol),
  HomeMenuItems(text: gift, icon: AssetPaths.gift),
  HomeMenuItems(text: chopNow, icon: AssetPaths.chopLogo),
  HomeMenuItems(text: meat, icon: AssetPaths.meat),
];

List<String> naijaState = [
  "Abia",
  "Adamawa",
  "Akwa Ibom",
  "Anambra",
  "Bauchi",
  "Bayelsa",
  "Benue",
  "Borno",
  "Cross River",
  "Delta",
  "Ebonyi",
  "Edo",
  "Ekiti",
  "Enugu",
  "Federal Capital Territory",
  "Gombe",
  "Imo",
  "Jigawa",
  "Kaduna",
  "Kano",
  "Katsina",
  "Kebbi",
  "Kogi",
  "Kwara",
  "Lagos",
  "Nasarawa",
  "Niger",
  "Ogun",
  "Ondo",
  "Osun",
  "Oyo",
  "Plateau",
  "Rivers",
  "Sokoto",
  "Taraba",
  "Yobe",
  "Zamfara"
];

class EmptyHomeProduct extends StatelessWidget {
  final String text, subText;
  const EmptyHomeProduct({
    super.key,
    required this.text,
    required this.subText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AssetPaths.emptyProd),
        Text(
          text,
          style: textTheme.bodyLarge!.copyWith(color: kDark900, fontSize: 16),
        ),
        YBox(kPadding),
        Text(
          subText,
          style: textTheme.displaySmall!.copyWith(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class AppleGoogleWidget extends StatelessWidget {
  final String icon;
  final String text, subText;

  const AppleGoogleWidget({
    required this.text,
    required this.subText,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kSmallPadding),
        decoration: BoxDecoration(
            borderRadius: kBorderSmallRadius,
            color: Colors.black,
            border: Border.all(width: 1, color: kGrey800)),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            XBox(kSmallPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  subText,
                  style: textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

