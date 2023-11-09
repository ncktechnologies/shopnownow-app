import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/utils/constants.dart';

/// Redesign or replace your flushbar design here
void showErrorBar(BuildContext context, String? value) {
  if (value != null) {
    Flushbar(
      message: value,
      messageColor: kPrimaryWhite,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      borderRadius: kBorderSmallRadius,
      borderWidth: 1,
      borderColor: Colors.orange,
      icon: const Icon(
        CupertinoIcons.multiply_circle_fill,
        color: Colors.orange,
      ),
      mainButton: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.close_rounded,
          color: Colors.orange,
        ),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 15, right: 20, top: 15, bottom: 15),
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}

void showSuccessBar(BuildContext context, String? value) {
  if (value != null) {
    Flushbar(
      message: value,
      messageColor: kPrimaryWhite,
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: kBright100,
      borderRadius: BorderRadius.circular(kMacroPadding),
      userInputForm: Form(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: kSmallPadding, horizontal:kRegularPadding ),
            child: Row(
        children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            XBox(kRegularPadding),
            Expanded(
              child: Text(
                value,
                style: textTheme.displayLarge!.copyWith(color: kDarkPurpleColor),
              ),
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.close_rounded,
                color: kLight200,
              ),
            ),
        ],
      ),
          )),
      titleSize: 20,
      mainButton: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Icon(
          Icons.close_rounded,
          color: Colors.green,
        ),
      ),
      borderWidth: 0,
      borderColor: kPrimaryWhite,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(left: 15, right: 20, top: 15, bottom: 15),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
