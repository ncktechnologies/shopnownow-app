import 'package:flutter/material.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class SpecialRequest extends StatelessWidget {
  const SpecialRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        loggedIn: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kRegularPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YBox(kMacroPadding),
              Text(
                specialRequestCaps,
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
              TextInputNoIcon(
                text: request,
              ),
              TextInputNoIcon(
                text: comment,
                maxLine: 8,
              ),
              YBox(80),
              LargeButton(title: submitRequest, onPressed: (){})
            ],
          ),
        ));
  }
}
