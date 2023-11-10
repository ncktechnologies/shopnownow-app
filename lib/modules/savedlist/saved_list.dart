import 'package:flutter/material.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class SavedList extends StatelessWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                savedList,
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
          YBox(kSmallPadding),
          const Divider(
            color: kLightAsh200,
            thickness: 2,
          ),
          YBox(kMediumPadding),
          ...List.generate(
              3,
              (index) => Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            AssetPaths.cartImage,
                            height: 48,
                            width: 48,
                          ),
                          XBox(kSmallPadding),
                          Expanded(
                            child: Text(
                              "7 items created",
                              style: textTheme.titleSmall,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kRegularPadding,
                                vertical: kSmallPadding),
                            decoration: BoxDecoration(
                              color: kGreen100,
                              borderRadius: BorderRadius.circular(500),
                            ),
                            child: Text(
                              checkout,
                              style: textTheme.bodyLarge!
                                  .copyWith(color: kGreen200, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: kLight900,
                        thickness: 1,
                      )
                    ],
                  ))
        ],
      ),
    ));
  }
}
