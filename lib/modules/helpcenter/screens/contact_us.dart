import 'package:flutter/material.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(child: Padding(
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
              Text(home, style: textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),),
              Text("  /  ", style: textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  color: kGrey200
              ),),
              Text(helpCenter, style: textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),),
              Text("  /  $faq", style: textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  color: kGrey200
              ),),
            ],
          )
        ],
      ),
    ));
  }
}
