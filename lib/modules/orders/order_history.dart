import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/orders/order_details.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

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
            orderHistory,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          YBox(kSmallPadding),
          const Divider(color: kLightAsh200, thickness: 2,),
          YBox(kMacroPadding),
          ...List.generate(
              4,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWellNoShadow(
                    onTap: (){
                      pushTo(OrderDetails(
                        isPending: index == 1 ? true : false,
                      ));
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 12),
                          decoration: const BoxDecoration(
                            color: kGrey700,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(AssetPaths.order),
                        ),
                        XBox(kSmallPadding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "#KD1890",
                                style: textTheme.titleSmall,
                              ),
                              YBox(kPadding),
                              Row(
                                children: [
                                  Text(
                                    "30 Jul, 7:56 PM  ",
                                    style: textTheme.headlineMedium!
                                        .copyWith(fontSize: 10),
                                  ),
                                  Container(
                                    height: kPadding,
                                    width: kPadding,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kLightGrey100),
                                  ),
                                  Text("  ₦21,600.00",
                                      style: textTheme.headlineMedium!
                                          .copyWith(fontSize: 10)),
                                ],
                              ),
                              YBox(kPadding),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kSmallPadding,
                                    vertical: kPadding),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        kSmallPadding),
                                    color:index == 1 ? kSuccess : kLight800),
                                child: Text(
                                 index == 1 ? "Delivered" : "Pending",
                                  style: textTheme.headlineMedium!.copyWith(
                                      fontSize: 10, color: index == 1 ? kToastColor2: kYellow),
                                ),
                              ),
                            ],
                          ),
                        ),
                        index == 1 ?  Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              color: kLightGrey100),
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetPaths.reOrder),
                              XBox(kSmallPadding),
                              Text(
                                reOrder,
                                style: textTheme.headlineMedium!.copyWith(
                                    color: kBlack100,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ) : YBox(0)
                      ],
                    ),
                  ),
                  YBox(kRegularPadding),
                  const Divider(
                    color: kLight900,
                    thickness: 1,
                  ),
                  YBox(kRegularPadding),
                ],
              ))
        ],
      ),
    ));
  }
}
