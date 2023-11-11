import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class HomePageDetail extends StatefulWidget {
  final HomeMenuItems menuItems;

  const HomePageDetail({Key? key, required this.menuItems}) : super(key: key);

  @override
  State<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends State<HomePageDetail> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
        child: Column(
          children: [
            YBox(kMediumPadding),
            Container(
              padding: const EdgeInsets.all(kRegularPadding),
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(kMacroPadding)),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: kPrimaryWhite),
                      child: SvgPicture.asset(
                        widget.menuItems.icon,
                        fit: BoxFit.scaleDown,
                        height: kRegularPadding,
                        width: kRegularPadding,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.menuItems.text,
                      style: textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: kPrimaryColor,
                  )
                ],
              ),
            ),
            YBox(kRegularPadding),
            SearchTextInputNoIcon(
              prefixIcon: SvgPicture.asset(
                AssetPaths.search,
                fit: BoxFit.scaleDown,
              ),
              controller: controller,
              onChanged: (val) {},
              hintText: searchText,
            ),
            // const EmptyHomeProduct(),
            Container(
              padding: const EdgeInsets.all(kRegularPadding),
              decoration: BoxDecoration(
                  color: kPrimaryWhite,
                  borderRadius: BorderRadius.circular(kRegularPadding),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200]!,
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2), // changes position of shadow
                    )
                  ],
                  border: Border.all(width: 1, color: kLight300)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  3,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      "817",
                                      softWrap: true,
                                      style: textTheme.displayLarge!.copyWith(
                                        fontSize: 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kMicroPadding),
                                border:
                                    Border.all(color: kLightAsh50, width: 1.5)),
                            child: Text(
                              addList,
                              style: textTheme.displayLarge!
                                  .copyWith(color: kGrey600, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      YBox(kSmallPadding),
                     index == 3-1? YBox(0) : const Divider(
                        thickness: 1,
                        color: kDividerColor,
                      ),
                      YBox(index == 3-1? 0 :kSmallPadding),
                    ],
                  ),
                ).toList(),
              ),
            ),
            YBox(kRegularPadding),
          ],
        ),
      ),
    );
  }
}

class EmptyHomeProduct extends StatelessWidget {
  const EmptyHomeProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AssetPaths.emptyProd),
        Text(
          noProd,
          style: textTheme.bodyLarge!.copyWith(color: kDark900, fontSize: 16),
        ),
        YBox(kPadding),
        Text(
          addItem,
          style: textTheme.displaySmall!.copyWith(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
