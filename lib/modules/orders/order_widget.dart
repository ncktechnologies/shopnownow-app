import 'package:flutter/material.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/utils/constants.dart';

class PaymentRow extends StatelessWidget {
  final String text, subText;
  const PaymentRow({
    required this.subText,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textTheme.displayMedium!.copyWith(color: kLight700),
            ),
            Row(
              children: [
                Text(
                  "₦",
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(subText,
                      style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                )
              ],
            )
          ],
        ),
        YBox(kSmallPadding)
      ],
    );
  }
}

class DeliveryDetails extends StatelessWidget {
  final String text, subText;
  const DeliveryDetails({
    required this.subText, required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: textTheme.displaySmall,),
        YBox(kPadding),
        Text(subText, style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),),
        YBox(kRegularPadding)
      ],
    );
  }
}

