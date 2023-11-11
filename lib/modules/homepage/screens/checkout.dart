import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/orders/order_widget.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

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
                    "2",
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
                        "2",
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
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.5, color: kGrey700),
                            borderRadius:
                                BorderRadius.circular(kRegularPadding)),
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
                                    "Knorr Chicken Seasoning Cubes",
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
                                      "X1",
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
                              "₦750",
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
                  index == 2 - 1
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
          Text(
            addList,
            style: textTheme.displayLarge!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          YBox(54),
          Text(
            delInfo,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kRegularPadding),
          TextInputNoIcon(text: recipientName),
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
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700
                                ),
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
                                    horizontal: kRegularPadding, vertical: kSmallPadding),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kMicroPadding),
                                    border: Border.all(
                                        color: kLightAsh50, width: 1.5)),
                                child: Row(
                                  children: [
                                    InkWellNoShadow(
                                      onTap: (){
                                        if(itemCount != 1){
                                          setState(() {
                                            itemCount--;
                                          });
                                        }

                                      },
                                      child: Text(
                                        "-",
                                        style: textTheme.displayLarge!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12, color: itemCount != 1 ? kPrimaryColor : kLight700),
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
                                      onTap: (){
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
