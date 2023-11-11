import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/screens/home_page_detail.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class HomePage extends StatefulWidget {
  final bool? loggedIn;
  const HomePage({Key? key, this.loggedIn = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return InitialPage(
      loggedIn: widget.loggedIn,

        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kRegularPadding,
            vertical: kMediumPadding,
          ),
          child: Column(
            children: [
              SearchTextInputNoIcon(
                prefixIcon: SvgPicture.asset(
                  AssetPaths.search,
                  fit: BoxFit.scaleDown,
                ),
                controller: controller,
                onChanged: (val) {
                  if (val!.isEmpty) {
                    setState(() {
                      isEmpty = true;
                    });
                  } else {
                    setState(() {
                      isEmpty = false;
                    });
                  }
                },
                hintText: searchText,
              ),
              YBox(kMicroPadding),
              MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: menuItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: kRegularPadding,
                  mainAxisSpacing: kRegularPadding,
                  itemBuilder: (ctx, index) {
                    return InkWellNoShadow(
                      onTap: (){
                        pushTo(HomePageDetail(menuItems: menuItems[index]));
                      },
                      child: Container(
                        height: screenSize.height / 4.6,
                        padding: const EdgeInsets.only(
                            top: kRegularPadding,
                            left: kMediumPadding,
                            right: kMediumPadding,
                            bottom: kMicroPadding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(kRegularPadding),
                          color: kSecondaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: index == 4
                                    ? Image.asset(
                                        menuItems[index].icon,
                                        height: 40,
                                        width: 40,
                                      )
                                    : SvgPicture.asset(
                                        menuItems[index].icon,
                                      )),
                            Text(
                              menuItems[index].text,
                              style: textTheme.displayLarge!,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              YBox(kMacroPadding),
              Text(
                downloadApp,
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium!.copyWith(
                    color: kDarkColor300, fontWeight: FontWeight.w500),
              ),
              YBox(kSmallPadding),
              Row(
                children: [
                  AppleGoogleWidget(
                    icon: AssetPaths.appleLogo,
                    text: downloadOn,
                    subText: appStore,
                  ),
                  XBox(kRegularPadding),
                  AppleGoogleWidget(
                    icon: AssetPaths.googleLogo,
                    text: getIt,
                    subText: googlePlay,
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class AppleGoogleWidget extends StatelessWidget {
  final String icon;
  final String text, subText;

  const AppleGoogleWidget({
    required this.text,
    required this.subText,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(kSmallPadding),
        decoration: BoxDecoration(
            borderRadius: kBorderSmallRadius,
            color: Colors.black,
            border: Border.all(width: 1, color: kGrey800)),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            XBox(kSmallPadding),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  subText,
                  style: textTheme.displayMedium!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
