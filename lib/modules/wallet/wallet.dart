import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  bool obscure = true;

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
            wallet,
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
          YBox(kMacroPadding),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: kMacroPadding, vertical: kMediumPadding),
            decoration: const BoxDecoration(
                borderRadius: kBorderSmallRadius, color: green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walletBalance,
                  style: textTheme.bodyLarge!
                      .copyWith(color: kLightAsh, fontSize: 16),
                ),
                YBox(kSmallPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obscure ? "********" : "₦2,000.00",
                      style: textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w900, fontSize: 38),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: obscure
                          ? const Icon(
                              Icons.remove_red_eye_outlined,
                              color: kPrimaryWhite,
                            )
                          : SvgPicture.asset(
                              AssetPaths.closeEye,
                              fit: BoxFit.scaleDown,
                              color: kPrimaryWhite,
                            ),
                    ),
                  ],
                ),
                YBox(kRegularPadding),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kMediumPadding),
                      color: kPrimaryColor),
                  child: Text(
                    fundWallet,
                    style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          YBox(kRegularPadding),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: kRegularPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kRegularPadding),
                color: kYellow400),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: kPrimaryWhite,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AssetPaths.pointLogo),
                ),
                XBox(kSmallPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loyaltyPoint,
                        style: textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      YBox(kPadding),
                      Text(
                        "2,000 pts",
                        style: textTheme.displayLarge!
                            .copyWith(fontSize: 18, color: kBlack600),
                      ),
                      Text(
                        "50pts = ₦10.00 ",
                        style: textTheme.headlineMedium!
                            .copyWith(fontSize: 10, color: kBlack600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      color: kOrange500),
                  child: Text(
                    convertPoint,
                    style: textTheme.displayMedium!
                        .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          YBox(kRegularPadding),
          Text(
            transActivity,
            style: textTheme.bodyLarge!.copyWith(color: kBlue, fontSize: 16),
          ),
          YBox(kRegularPadding),
          ...List.generate(
            4,
            (index) => Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: kSmallPadding),
              padding: const EdgeInsets.all(kRegularPadding),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRegularPadding),
                  color: kLightGrey200),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: kLightAsh300,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset( AssetPaths.failTrans, color: index == 1 ? kGreen10: kError900),
                  ),
                  XBox(kSmallPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Payment",
                          style:
                              textTheme.headlineMedium!.copyWith(color: kBlue),
                        ),
                        YBox(8),
                        Row(
                          children: [
                            Text(
                              "12.03.2022  ",
                              style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: kDark100),
                            ),
                            Container(
                              height: kPadding,
                              width: kPadding,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: kDark100),
                            ),
                            Text("  12:54 PM",
                              style: textTheme.bodyLarge!.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: kDark100),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "- ₦ 5,000.00",
                    style: textTheme.displayLarge!
                        .copyWith(color: index == 1 ? kGreen10: kError900),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
