import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/checkout.dart';
import 'package:shopnownow/modules/orders/provider/order_provider.dart';
import 'package:shopnownow/modules/orders/screen/order_details.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/extensions.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/widgets.dart';

class OrderHistory extends ConsumerStatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends ConsumerState<OrderHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(orderProvider.notifier).getOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        noIcon: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
            child: ref.watch(orderProvider).when(
                done: (data) {
                  if (data == null) {
                    return const SizedBox();
                  } else {
                    return Column(
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
                        const Divider(
                          color: kLightAsh200,
                          thickness: 2,
                        ),
                        YBox(kMacroPadding),
                        ...List.generate(
                            data.orders!.length,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWellNoShadow(
                                      onTap: () {
                                        pushTo(OrderDetails(
                                            order: data.orders![index]));
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
                                            child: SvgPicture.asset(
                                                AssetPaths.order),
                                          ),
                                          XBox(kSmallPadding),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.orders![index].orderId
                                                      .toString(),
                                                  style: textTheme.titleSmall,
                                                ),
                                                YBox(kPadding),
                                                Row(
                                                  children: [
                                                    Text(
                                                      DateFormat("dd MMM, ")
                                                          .add_jm()
                                                          .format(data
                                                              .orders![index]
                                                              .createdAt!),
                                                      style: textTheme
                                                          .headlineMedium!
                                                          .copyWith(
                                                              fontSize: 10),
                                                    ),
                                                    Container(
                                                      height: kPadding,
                                                      width: kPadding,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  kLightGrey100),
                                                    ),
                                                    Text(
                                                        "  ₦${(int.parse(data.orders![index].price!.replaceAll(".00", "")) + int.parse(data.orders![index].tax!.replaceAll(".00", "")) + int.parse(data.orders![index].deliveryFee!.replaceAll(".00", ""))).toString()}",
                                                        style: textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                fontSize: 10)),
                                                  ],
                                                ),
                                                YBox(kPadding),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: kSmallPadding,
                                                      vertical: kPadding),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kSmallPadding),
                                                      color: data.orders![index]
                                                                  .status ==
                                                              "delivered"
                                                          ? kSuccess
                                                          : kLight800),
                                                  child: Text(
                                                    data.orders![index].status!
                                                        .toTitleCase(),
                                                    style: textTheme
                                                        .headlineMedium!
                                                        .copyWith(
                                                            fontSize: 10,
                                                            color: data
                                                                        .orders![
                                                                            index]
                                                                        .status ==
                                                                    "delivered"
                                                                ? kToastColor2
                                                                : kYellow),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // data.orders![index].status == "delivered"  ?
                                          Consumer(builder: (context, ref, _) {
                                            var widget = Consumer(
                                                builder: (context, ref, _) {
                                              var widget = InkWellNoShadow(
                                                onTap: () {
                                                  pushTo(CheckOut(
                                                    productList: data
                                                        .orders![index]
                                                        .products!,
                                                    band: data.orders![index]
                                                        .products![0].band,
                                                    tax: data
                                                        .orders![index]
                                                        .products![0]
                                                        .category!
                                                        .tax,
                                                  ));
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500),
                                                      color: kLightGrey100),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          AssetPaths.reOrder),
                                                      XBox(kSmallPadding),
                                                      Text(
                                                        reOrder,
                                                        style: textTheme
                                                            .headlineMedium!
                                                            .copyWith(
                                                                color:
                                                                    kBlack100,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                              return ref
                                                  .watch(reorderProvider(
                                                      data.orders![index].id!))
                                                  .when(
                                                      done: (done) => widget,
                                                      loading: () =>
                                                          const SpinKitDemo(),
                                                      error: (val) => widget);
                                            });
                                            return ref
                                                .watch(processPaymentProvider2(
                                                    data.orders![index].id!))
                                                .when(
                                                    done: (data) => widget,
                                                    loading: () =>
                                                        const SpinKitDemo());
                                          }),

                                          //: YBox(0)
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
                    );
                  }
                },
                loading: () => const SpinKitDemo(),
                error: (val) => YBox(0))));
  }
}
