import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shopnownow/modules/orders/model/order_model.dart';
import 'package:shopnownow/modules/orders/screen/order_widget.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/extensions.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';

class OrderDetails extends StatelessWidget {
  // final bool? isPending;
  final Order order;

  const OrderDetails({Key? key, required this.order}) : super(key: key);

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
                              "$orderId${order.orderId} ",
                              style: textTheme.displayLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            InkWellNoShadow(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: "${order.orderId}"));
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
                          "$dateOrdered ${DateFormat("dd MMM, yyyy").format(order.createdAt!)}",
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
                      color: () {
                        switch (order.status) {
                          case "delivered":
                            return kToastColor2.withOpacity(0.1);
                          case "cancelled":
                            return Colors.red.withOpacity(0.1);
                          case "picked":
                            return Colors.orange.withOpacity(0.1);
                          default:
                            return kGreen300.withOpacity(0.1);
                        }
                      }(),
                    ),
                    child: Text(
                      toBeginningOfSentenceCase(order.status) ?? '',
                      style: textTheme.headlineMedium!.copyWith(
                        fontSize: 10,
                        color: () {
                          switch (order.status) {
                            case "delivered":
                              return kToastColor2;
                            case "cancelled":
                              return Colors.red;
                            case "picked":
                              return Colors.orange;
                            default:
                              return kGreen300;
                          }
                        }(),
                      ),
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
                        margin: const EdgeInsets.only(top: kSmallPadding),
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
                            color: order.status != "paid"
                                ? kGreen300
                                : kTextInputBorderColor),
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
                          color: () {
                            switch (order.status) {
                              case "paid":
                                return kTextInputBorderColor;
                              case "picked":
                                return Colors.orange;
                              case "delivered":
                                return kGreen300;
                              case "cancelled":
                                return Colors.red;
                              default:
                                return kTextInputBorderColor;
                            }
                          }(),
                        ),
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
                          DateFormat("dd MMM, yyyy").format(order.createdAt!),
                          style: textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: kToastColor2,
                              fontSize: 10),
                        ),
                        YBox(kMacroPadding),
                        Text(
                          order.status == 'cancelled'
                              ? orderCancelled
                              : orderDelivered,
                          style: textTheme.displaySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: order.status != "paid"
                                  ? kDarkColor300
                                  : kLight700),
                        ),
                        YBox(kPadding),
                        order.status == "delivered"
                            ? Text(
                                DateFormat("dd MMM, yyyy")
                                    .format(order.updatedAt!),
                                style: textTheme.displaySmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: kToastColor2,
                                    fontSize: 10),
                              )
                            : Text(
                                "${order.status == 'paid' ? 'Pending' : toBeginningOfSentenceCase(order.status)}",
                                style: textTheme.displaySmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: order.status == 'cancelled'
                                      ? Colors.red
                                      : kYellow,
                                ),
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
                subText: order.price!,
              ),
              PaymentRow(
                text: tax,
                subText: order.tax!,
              ),
              PaymentRow(
                text: delivery,
                subText: order.deliveryFee!,
              ),
              PaymentRow(
                text: total,
                subText: (int.parse(order.price!.replaceAll(".00", "")) +
                        int.parse(order.tax!.replaceAll(".00", "")) +
                        int.parse(order.deliveryFee!.replaceAll(".00", "")))
                    .toString(),
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
                subText: order.recipientName!.toTitleCase(),
              ),
              DeliveryDetails(
                text: phoneNo,
                subText: "(+234) ${order.recipientPhone!.substring(1)}",
              ),
              DeliveryDetails(
                text: deliveryAdd,
                subText: order.deliveryInfo!.toTitleCase(),
              ),
              YBox(kPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kMediumPadding),
              Text("${order.products!.length} item(s)",
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  )),
              YBox(kRegularPadding),
              ...List.generate(
                order.products!.length,
                (index) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 65,
                          width: 65,
                          imageUrl: order.products![index].thumbnailUrl ??
                              "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
                          fit: BoxFit.cover,
                          imageBuilder: (context, prov) {
                            return Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1.5, color: kGrey700),
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: prov, fit: BoxFit.cover)),
                            );
                          },
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/images/img.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        XBox(kSmallPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.products![index].name!,
                                style: textTheme.headlineMedium!
                                    .copyWith(color: kDarkColor300),
                              ),
                              YBox(kRegularPadding),
                              Text("X${order.products![index].quantity}",
                                  style: textTheme.bodyLarge),
                            ],
                          ),
                        ),
                        Text(
                          "₦ ${order.products![index].price}",
                          style: textTheme.displayLarge!.copyWith(
                              color: kDarkPurple,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    YBox(kRegularPadding)
                  ],
                ),
              )
            ])));
  }
}
