import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/orders/screen/order_widget.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';

class OrderDetails extends StatelessWidget {
  final bool? isPending;

  const OrderDetails({Key? key, this.isPending = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              YBox(kMacroPadding),
              Text(
                orderDetails,
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
              YBox(kRegularPadding),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$orderId#KD1890 ",
                              style: textTheme.displayLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            InkWellNoShadow(
                              onTap: () {
                                Clipboard.setData(
                                    const ClipboardData(text: "#KD1890"));
                                showSuccessBar(context, "Copied");
                              },
                              child: SvgPicture.asset(
                                AssetPaths.copy,
                              ),
                            )
                          ],
                        ),
                        YBox(kPadding),
                        Text(
                          "$dateOrdered 18 Oct, 2023",
                          style: textTheme.headlineMedium!
                              .copyWith(color: kPurple100),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: kSmallPadding),
                    padding: const EdgeInsets.symmetric(
                        horizontal: kSmallPadding, vertical: kPadding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kSmallPadding),
                        color: isPending! ? kSuccess : kLight800),
                    child: Text(
                      isPending! ? "Delivered" : "Pending",
                      style: textTheme.headlineMedium!.copyWith(
                          fontSize: 10,
                          color: isPending! ? kToastColor2 : kYellow),
                    ),
                  ),
                ],
              ),
              YBox(kMicroPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kMediumPadding),
              Text(
                orderStatus,
                style: textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              YBox(kRegularPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: kSmallPadding),
                        height: kRegularPadding,
                        width: kRegularPadding,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kGreen300),
                      ),
                      YBox(2),
                      Container(
                        alignment: Alignment.topLeft,
                        height: 44,
                        width: 2,
                        decoration: BoxDecoration(
                            color:
                                isPending! ? kGreen300 : kTextInputBorderColor),
                        child: Container(
                          height: 22,
                          width: 2,
                          decoration: const BoxDecoration(color: kGreen300),
                        ),
                      ),
                      YBox(2),
                      Container(
                        height: kRegularPadding,
                        width: kRegularPadding,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPending! ? kGreen300 : kTextInputBorderColor),
                      )
                    ],
                  ),
                  XBox(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderReceived,
                          style: textTheme.displaySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        YBox(kPadding),
                        Text(
                          "18 Oct, 2023",
                          style: textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: kToastColor2,
                              fontSize: 10),
                        ),
                        YBox(kMacroPadding),
                        Text(
                          orderDelivered,
                          style: textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isPending! ? kDarkColor300 : kLight700),
                        ),
                        YBox(kPadding),
                        isPending!
                            ? Text(
                                "18 Oct, 2023",
                                style: textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: kToastColor2,
                                    fontSize: 10),
                              )
                            : Text(
                                "Pending",
                                style: textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: kYellow),
                              ),
                      ],
                    ),
                  )
                ],
              ),
              YBox(kMediumPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kMediumPadding),
              Text(
                payDetails,
                style: textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              YBox(kSmallPadding),
              PaymentRow(
                text: subTotal,
                subText: "13,350",
              ),
              PaymentRow(
                text: tax,
                subText: "150",
              ),
              PaymentRow(
                text: delivery,
                subText: "13,350",
              ),
              PaymentRow(
                text: total,
                subText: "13,350",
              ),
              YBox(kSmallPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kMediumPadding),
              Text(
                deliveryDetails,
                style: textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              YBox(kRegularPadding),
              DeliveryDetails(
                text: recipientName,
                subText: "Josh Osazuwa",
              ),
              DeliveryDetails(
                text: phoneNo,
                subText: "(+234) 8031 889558",
              ),
              DeliveryDetails(
                text: deliveryAdd,
                subText: "124, Oyediran Estate, Lagos, Nigeria, 5432",
              ),
              YBox(kPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kMediumPadding),
              Text("2 item(s)",
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )),
              YBox(kRegularPadding),
              ...List.generate(
                2,
                (index) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: const BoxDecoration(
                              color: Colors.grey, borderRadius: kBorderSmallRadius),
                        ),
                        XBox(kSmallPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nike Blazer Low ‘77",
                                style: textTheme.headlineMedium!.copyWith(
                                  color: kDarkColor300
                                ),
                              ),
                              YBox(kPadding),
                              Text(
                                "XM345 Vintage",
                                style: textTheme.headlineMedium!.copyWith(
                                    color: kDarkColor300
                                ),
                              ),
                              YBox(kPadding),
                              Text(
                                "X2",
                                style: textTheme.bodyLarge
                              ),


                            ],
                          ),
                        ),
                        Text("₦ 64,500", style: textTheme.displayLarge!.copyWith(
                          color: kDarkPurple,
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                    YBox(kRegularPadding)
                  ],
                ),
              )
            ])));
  }
}
