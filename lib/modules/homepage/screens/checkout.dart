import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/orders/order_widget.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class CheckOut extends StatefulWidget {
  final List<Product> productList;

  const CheckOut({Key? key, required this.productList}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  String? _location;
  int currentIndex = 0;
  bool isChecked = false;
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                checkout,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(13),
                  decoration: const BoxDecoration(
                      color: kPrimaryColor, shape: BoxShape.circle),
                  child: Text(
                    widget.productList.length.toString(),
                    style: textTheme.displayMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ))
            ],
          ),
          YBox(kPadding),
          const Divider(
            color: kLightAsh200,
            thickness: 2,
          ),
          YBox(kRegularPadding),
          Row(
            children: [
              Text(
                yourItem,
                style: textTheme.displayLarge!.copyWith(
                  color: Colors.black,
                ),
              ),
              XBox(kMediumPadding),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          color: kPrimaryColor, shape: BoxShape.circle),
                      child: Text(
                        widget.productList.length.toString(),
                        style: textTheme.displayMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )),
                ),
              ),
              Text(
                showLess,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              XBox(kPadding),
              const Icon(
                Icons.keyboard_arrow_up,
                size: 25,
                color: kPrimaryColor,
              )
            ],
          ),
          YBox(kRegularPadding),
          ...List.generate(
            widget.productList.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        height: 80,
                        width: 80,
                        imageUrl: widget.productList[index].thumbnailUrl ??
                            "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
                        fit: BoxFit.cover,
                        imageBuilder: (context, prov) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5, color: kGrey700),
                                borderRadius:
                                    BorderRadius.circular(kRegularPadding),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.productList[index].name ?? "",
                                    style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        height: 1.5),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  YBox(kPadding),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "X${widget.productList[index].quantity}",
                                      softWrap: true,
                                      style: textTheme.titleSmall!.copyWith(
                                          fontSize: 10, color: kDarkPurple),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "₦${(widget.productList.fold<int>(0, (previousValue, element) {
                                return (previousValue +
                                    int.parse(
                                        element.price?.replaceAll(".00", "") ??
                                            "0"));
                              }).toString())}",
                              style: textTheme.displayLarge!.copyWith(
                                color: kDarkColor400,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  YBox(kRegularPadding),
                  index == widget.productList.length - 1
                      ? YBox(0)
                      : Divider(
                          color: kLightGrey400,
                          thickness: 1,
                          indent: screenSize.width / 4.5,
                        )
                ],
              ),
            ),
          ),
          YBox(kRegularPadding),
          Consumer(builder: (context, ref, _) {
            var addToListWidget = InkWellNoShadow(
              onTap: () {
                List<ProductRequest> prodRequest = [];
                for (var element in widget.productList) {
                  setState(() {
                    prodRequest.add(ProductRequest(
                        id: element.id!, quantity: element.quantity!));
                  });
                }
                ref.read(addToListProvider.notifier).addToList(
                    request: AddProductRequest(products: prodRequest),
                    then: (val) {
                      showSuccessBar(context, val);
                    });
              },
              child: Text(
                addList,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            );
            return ref.watch(addToListProvider).when(
                done: (data) => addToListWidget,
                loading: () => const SpinKitDemo(),
                error: (val) => addToListWidget);
          }),
          YBox(54),
          Text(
            delInfo,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kRegularPadding),
          TextInputNoIcon(
            text: recipientName,
          ),
          TextInputNoIcon(text: mobNo),
          TextInputNoIcon(text: emailAddress),
          FormDropdown<String>(
            value: _location,
            text: location,
            extraText: true,
            extraWidget: const SizedBox(),
            bottomPadding: kRegularPadding,
            extraTextString: "",
            hint: selLocation,
            onChanged: (String? val) {
              _location = val;
            },
            items: naijaState
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: textTheme.headlineMedium!
                            .copyWith(color: kDarkColor400),
                      ),
                    ))
                .toList(),
          ),
          TextInputNoIcon(
            text: address,
            hintText: enterDelAddress,
          ),
          FormDropdown<String>(
            value: _location,
            text: delTime,
            extraText: true,
            extraWidget: const SizedBox(),
            bottomPadding: kRegularPadding,
            extraTextString: "",
            hint: selectSlot,
            onChanged: (String? val) {
              _location = val;
            },
            items: naijaState
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(
                        e,
                        style: textTheme.headlineMedium!
                            .copyWith(color: kDarkColor400),
                      ),
                    ))
                .toList(),
          ),
          YBox(kLargePadding),
          Text(
            applyDiscount,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kRegularPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SearchTextInputNoIcon(
                  noBorder: false,
                  hintText: enterCoupon,
                ),
              ),
              XBox(kRegularPadding),
              Container(
                width: 96,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(kMacroPadding)),
                child: Text(
                  apply,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          YBox(kLargePadding),
          Text(
            payWith,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kMediumPadding),
          ...List.generate(
              pay.length,
              (index) => Padding(
                    padding: const EdgeInsets.only(bottom: kRegularPadding),
                    child: InkWellNoShadow(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: Row(
                          children: [
                            Container(
                              height: kMediumPadding,
                              width: kMediumPadding,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: currentIndex == index
                                          ? kPrimaryColor
                                          : kTextInputBorderColor),
                                  shape: BoxShape.circle),
                              child: currentIndex == index
                                  ? Container(
                                      height: kSmallPadding,
                                      width: kSmallPadding,
                                      decoration: const BoxDecoration(
                                          color: kPrimaryColor,
                                          shape: BoxShape.circle),
                                    )
                                  : YBox(0),
                            ),
                            XBox(kSmallPadding),
                            Text(
                              pay[index],
                              style: textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )),
                  )),
          YBox(85),
          const Divider(
            thickness: 2,
            color: k200,
          ),
          YBox(kRegularPadding),
          Text(
            "$minOrder₦2,500",
            style: textTheme.headlineMedium!.copyWith(color: kOrange500),
          ),
          YBox(kMediumPadding),
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
          YBox(kMediumPadding),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                activeColor: kPrimaryColor,
                checkColor: kPrimaryWhite,
                side: MaterialStateBorderSide.resolveWith(
                  (states) => BorderSide(
                      width: 2.0, color: isChecked ? kPrimaryColor : kGrey700),
                ),
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: kPrimaryColor, width: 5),
                ),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: kPadding),
                  child: RichText(
                    text: TextSpan(
                      text: "$accept ",
                      style: textTheme.headlineMedium!.copyWith(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: terms,
                            style: textTheme.headlineMedium!.copyWith(
                                color: kPrimaryColor,
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          YBox(kMacroPadding),
          LargeButton(title: "Pay ₦ 102,300", onPressed: () {}),
          YBox(kRegularPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 100,
                    width: 108,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: kLight300),
                        borderRadius: kBorderSmallRadius),
                  ),
                  XBox(kSmallPadding),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Knorr Chicken Seasoning Cubes",
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      YBox(kPadding),
                      Text(
                        "Groceries",
                        style: textTheme.displaySmall!
                            .copyWith(color: kDarkPurple, fontSize: 10),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      YBox(kPadding),
                      Row(
                        children: [
                          Text(
                            "₦",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.displayLarge!.copyWith(
                                fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "817",
                              softWrap: true,
                              style: textTheme.displayLarge!.copyWith(
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      YBox(kPadding),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kRegularPadding,
                                vertical: kSmallPadding),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kMicroPadding),
                                border:
                                    Border.all(color: kLightAsh50, width: 1.5)),
                            child: Row(
                              children: [
                                InkWellNoShadow(
                                  onTap: () {
                                    if (itemCount != 1) {
                                      setState(() {
                                        itemCount--;
                                      });
                                    }
                                  },
                                  child: Text(
                                    "-",
                                    style: textTheme.displayLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: itemCount != 1
                                            ? kPrimaryColor
                                            : kLight700),
                                  ),
                                ),
                                XBox(kMediumPadding),
                                Text(
                                  itemCount.toString(),
                                  style: textTheme.displayLarge!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                XBox(kMediumPadding),
                                InkWellNoShadow(
                                  onTap: () {
                                    setState(() {
                                      itemCount++;
                                    });
                                  },
                                  child: Text(
                                    "+",
                                    style: textTheme.displayLarge!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          XBox(kFullPadding),
                          SvgPicture.asset(AssetPaths.delete)
                        ],
                      )
                    ],
                  )),
                ],
              ),
              YBox(kSmallPadding),
              const Divider(
                thickness: 1,
                color: kDividerColor,
              ),
              YBox(kSmallPadding),
            ],
          )
        ],
      ),
    ));
  }
}
