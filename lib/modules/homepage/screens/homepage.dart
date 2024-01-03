
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/home_page_detail.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/profile/provider/profile_provider.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/wallet/provider/wallet_provider.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  final bool? loggedIn;

  const HomePage({Key? key, this.loggedIn = false}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController controller = TextEditingController();
  List<GetCategories> categories = [];
  List<GetCategories> searchResult = [];
  // final FirebaseMessaging messaging = FirebaseMessaging.instance;

//Firebase functions
  // Future<void> initalizeFirebase() async {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }

  // void getToken() async {
  //   print(await messaging.getToken());

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //     // Now we can proceed to subscribe
  //     messaging.subscribeToTopic("allShopNowNowUsers");
  //     messaging.subscribeToTopic(SessionManager.getUserId().toString());
  //   } else {
  //     print('User declined or has not yet responded to the permission request');
  //   }
  // }

  void registerNotification() async {}

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getToken();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getContactProvider.notifier).getContact();
      ref.read(getQuickGuideProvider.notifier).getQuickGuide();
      ref.read(getCategoriesProvider.notifier).getCategories(then: (val) {
        for (var element in val) {
          categories.add(element);
        }
      });
      if (SessionManager.getToken() != null) {
        ref.read(getProfileProvider.notifier).getProfile();
        ref.read(getWalletProvider.notifier).getWallet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        noScroll: true,
        noIcon: true,
        child: Padding(
          padding: const EdgeInsets.only(
              left: kRegularPadding,
              right: kRegularPadding,
              top: kMediumPadding),
          child: Column(
            children: [
              SearchTextInputNoIcon(
                prefixIcon: SvgPicture.asset(
                  AssetPaths.search,
                  fit: BoxFit.scaleDown,
                ),
                controller: controller,
                onChanged: (val) {
                  onSearchTextChanged(val ?? "");
                },
                hintText: searchText,
              ),
              YBox(kMicroPadding),
              ref.watch(getCategoriesProvider).when(
                  done: (data) {
                    if (data == null) {
                      return const SizedBox();
                    } else {
                      return Expanded(
                        child: searchResult.isEmpty
                            ? MasonryGridView.count(
                                crossAxisCount: 2,
                                itemCount: categories.length,
                                crossAxisSpacing: kRegularPadding,
                                mainAxisSpacing: kRegularPadding,
                                itemBuilder: (ctx, index) {
                                  return InkWellNoShadow(
                                    onTap: () {
                                      pushTo(HomePageDetail(
                                        menuItems: categories[index],
                                        category: categories,
                                      ));
                                    },
                                    child: Container(
                                      height: screenSize.height / 4.6,
                                      padding: const EdgeInsets.only(
                                          top: kRegularPadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding,
                                          bottom: kMicroPadding),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kRegularPadding),
                                        color: kSecondaryColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: categories[index]
                                                          .thumbnail!
                                                          .split(".")
                                                          .last ==
                                                      "svg"
                                                  ? SvgPicture.network(
                                                      categories[index]
                                                          .thumbnail!,
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  : Image.network(
                                                      categories[index]
                                                          .thumbnail!,
                                                      height: kLargePadding,
                                                      width: kLargePadding,
                                                    )),
                                          Text(
                                            categories[index].name ?? "",
                                            style: textTheme.displayLarge!,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : MasonryGridView.count(
                                crossAxisCount: 2,
                                itemCount: searchResult.length,
                                crossAxisSpacing: kRegularPadding,
                                mainAxisSpacing: kRegularPadding,
                                itemBuilder: (ctx, index) {
                                  return InkWellNoShadow(
                                    onTap: () {
                                      pushTo(HomePageDetail(
                                        menuItems: searchResult[index],
                                        category: searchResult,
                                      ));
                                    },
                                    child: Container(
                                      height: screenSize.height / 4.6,
                                      padding: const EdgeInsets.only(
                                          top: kRegularPadding,
                                          left: kMediumPadding,
                                          right: kMediumPadding,
                                          bottom: kMicroPadding),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            kRegularPadding),
                                        color: kSecondaryColor,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: categories[index]
                                                          .thumbnail!
                                                          .split(".")
                                                          .last ==
                                                      "svg"
                                                  ? SvgPicture.network(
                                                      searchResult[index]
                                                          .thumbnail!,
                                                      height: 40,
                                                      width: 40,
                                                    )
                                                  : Image.network(
                                                      categories[index]
                                                          .thumbnail!,
                                                      height: kLargePadding,
                                                      width: kLargePadding,
                                                    )),
                                          Text(
                                            searchResult[index].name ?? "",
                                            style: textTheme.displayLarge!,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      );
                    }
                  },
                  loading: () => const SpinKitDemo()),
              YBox(kMacroPadding),
              // !Platform.isAndroid && !Platform.isIOS
              //     ?
              Column(
                children: [
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
              )
              // : const SizedBox(height: 0),
            ],
          ),
        ));
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var subject in categories) {
      if (subject.name!.isNotEmpty) {
        if (subject.name!.toLowerCase().contains(text.toLowerCase())) {
          searchResult.add(subject);
        }
      }
    }
    setState(() {});
  }
}
