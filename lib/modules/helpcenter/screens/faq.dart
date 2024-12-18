import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  List<bool> isChecked = [];
  List< dynamic> faqList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    faqList = jsonDecode(SessionManager.getFaq()!);
    isChecked = List.generate(faqList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    print(jsonDecode(SessionManager.getFaq()!));
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Text(
            faq,
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
              Text(
                home,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "  /  ",
                style: textTheme.bodyLarge!
                    .copyWith(fontSize: 14, color: kGrey200),
              ),
              Text(
                helpCenter,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "  /  $faq",
                style: textTheme.bodyLarge!
                    .copyWith(fontSize: 14, color: kGrey200),
              ),
            ],
          ),
          YBox(kMediumPadding),
          ...List.generate(
              faqList.length,
              (index) => InkWellNoShadow(
                    onTap: () {
                      for (int i = 0; i < isChecked.length; i++) {
                        if (isChecked[index] == false) {
                          setState(() => isChecked[i] = false);
                        }
                      }
                      isChecked[index] == true
                          ? setState(() => isChecked[index] = false)
                          : setState(() => isChecked[index] = true);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(kRegularPadding),
                      margin: const EdgeInsets.only(bottom: kRegularPadding),
                      decoration: BoxDecoration(
                          border: Border.all(color: kLight500, width: 1),
                          borderRadius: kBorderRadius),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // ${index + 1}
                                "${faqList[index]["question"]}",
                                style: textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: isChecked[index] ? kPrimaryColor : kDarkColor200 ,
                                ),
                              ),
                              Icon(
                                isChecked[index]
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 25,
                                color: isChecked[index] ? kPrimaryColor : kDarkColor200 ,
                              )
                            ],
                          ),
                          isChecked[index]
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: kRegularPadding),
                                  child: Text(
                                    "${faqList[index]["answer"]}",
                                    style: textTheme.headlineMedium!
                                        .copyWith(color: kDark300),
                                  ),
                                )
                              : YBox(0)
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    ));
  }
}
