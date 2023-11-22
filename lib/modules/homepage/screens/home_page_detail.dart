import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class HomePageDetail extends ConsumerStatefulWidget {
  final GetCategories menuItems;
  final List<GetCategories> category;

  const HomePageDetail(
      {Key? key, required this.menuItems, required this.category})
      : super(key: key);

  @override
  ConsumerState<HomePageDetail> createState() => _HomePageDetailState();
}

class _HomePageDetailState extends ConsumerState<HomePageDetail> {
  TextEditingController controller = TextEditingController();
  List<Product> searchResult = [];
  OverlayEntry? overlayEntry;
  GetCategories? categoryName;

  void _showOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      // You can return any widget you like here
      // to be displayed on the Overlay
      return Positioned(
        left: kRegularPadding,
        right: kRegularPadding,
        top: MediaQuery.of(context).size.height * 0.25,
        child: Container(
            padding: const EdgeInsets.all(kSmallPadding),
            decoration: BoxDecoration(
              color: kPrimaryWhite,
              borderRadius: BorderRadius.circular(kSmallPadding),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200]!,
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(0, 0), // changes position of shadow
                )
              ],
            ),
            // width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
                children: widget.category
                    .map((e) => Material(
                          child: InkWellNoShadow(
                            onTap: () {
                              setState(() {
                                categoryName = e;
                              });
                              overlayEntry?.remove();
                              overlayEntry = null;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: kSmallPadding),
                              child: Row(
                                children: [
                                  SvgPicture.network(
                                    e.thumbnail ?? "",
                                    fit: BoxFit.scaleDown,
                                    height: kMacroPadding,
                                    width: kMacroPadding,
                                  ),
                                  XBox(kSmallPadding),
                                  Text(
                                    e.name ?? "",
                                    style: textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color:
                                            categoryName!.name!.toLowerCase() ==
                                                    e.name!.toLowerCase()
                                                ? kPrimaryColor
                                                : kPurple50),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList())),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayEntry!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName = widget.menuItems!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        overlayEntry?.remove();
        return true;
      },
      child: InitialPage(
        child: GestureDetector(
          onTap: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
            child: Column(
              children: [
                YBox(kMediumPadding),
                InkWellNoShadow(
                  onTap: () {
                    if (overlayEntry == null) {
                      _showOverlay(context);
                    } else {}
                  },
                  child: Container(
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
                            child: SvgPicture.network(
                              widget.menuItems.thumbnail ?? "",
                              fit: BoxFit.scaleDown,
                              height: kRegularPadding,
                              width: kRegularPadding,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            categoryName?.name ?? "",
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
                ),
                YBox(kRegularPadding),
                SearchTextInputNoIcon(
                  prefixIcon: SvgPicture.asset(
                    AssetPaths.search,
                    fit: BoxFit.scaleDown,
                  ),
                  // icon: InkWellNoShadow(
                  //   onTap: (){},
                  //   child: const Icon(
                  //     Icons.send,
                  //     color: kPrimaryColor,
                  //   ),
                  // ),
                  controller: controller,
                  onChanged: (val) {
                    onSearchTextChanged(val ?? "");
                  },
                  hintText: searchText,
                ),
                searchResult.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: screenSize.height,
                        color: kPrimaryWhite,
                        child:  EmptyHomeProduct(
                          text: noProd,
                          subText: addItem,
                        ))
                    : Container(
                        padding: const EdgeInsets.all(kRegularPadding),
                        decoration: BoxDecoration(
                            color: kPrimaryWhite,
                            borderRadius:
                                BorderRadius.circular(kRegularPadding),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 0,
                                blurRadius: 2,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              )
                            ],
                            border: Border.all(width: 1, color: kLight300)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            searchResult.length,
                            (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      height: 80,
                                      width: 80,
                                      imageUrl: searchResult[index]
                                              .thumbnailUrl ??
                                          "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
                                      fit: BoxFit.cover,
                                      imageBuilder: (context, prov) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1, color: kLight300),
                                              borderRadius: kBorderSmallRadius,
                                              image: DecorationImage(
                                                  image: prov,
                                                  fit: BoxFit.cover)),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/img.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    XBox(kSmallPadding),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          searchResult[index].name ?? "",
                                          style:
                                              textTheme.titleMedium!.copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        YBox(kPadding),
                                        Text(
                                          widget.menuItems.name ?? "",
                                          style: textTheme.displaySmall!
                                              .copyWith(
                                                  color: kDarkPurple,
                                                  fontSize: 10),
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
                                              style: textTheme.displayLarge!
                                                  .copyWith(
                                                fontSize: 10,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                searchResult[index].price ??
                                                    "0",
                                                softWrap: true,
                                                style: textTheme.displayLarge!
                                                    .copyWith(
                                                  fontSize: 10,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                                    SessionManager.getToken() == null ? YBox(0) :
                                    InkWellNoShadow(
                                      onTap: () {
                                        AddProductRequest request =
                                            AddProductRequest(products: [
                                          ProductRequest(
                                              id: searchResult[index].id!,
                                              quantity: 1)
                                        ]);
                                        ref
                                            .read(addToListProvider(
                                                    searchResult[index]
                                                        .id
                                                        .toString())
                                                .notifier)
                                            .addToList(request: request, then: (val){
                                              showSuccessBar(context, val);
                                        });

                                      },
                                      child: ref.watch(addToListProvider(searchResult[index]
                                          .id
                                          .toString())).when(done: (data)=> Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                kMicroPadding),
                                            border: Border.all(
                                                color: kLightAsh50,
                                                width: 1.5)),
                                        child: Text(
                                          addList,
                                          style: textTheme.displayLarge!
                                              .copyWith(
                                              color: kGrey600,
                                              fontSize: 14),
                                        ),
                                      ),loading: ()=> const SpinKitDemo())

                                    )
                                  ],
                                ),
                                YBox(kSmallPadding),
                                index == searchResult.length - 1
                                    ? YBox(0)
                                    : const Divider(
                                        thickness: 1,
                                        color: kDividerColor,
                                      ),
                                YBox(index == searchResult.length - 1
                                    ? 0
                                    : kSmallPadding),
                              ],
                            ),
                          ).toList(),
                        ),
                      ),
                YBox(kRegularPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    searchResult.clear();
    if (text.isEmpty) {
      setState(() {
        searchResult = [];
      });
      return;
    }
    ref.read(getProductsBySearchProvider.notifier).getProductsBySearch(
        query: controller.text,
        categoryId: categoryName!.id.toString(),
        then: (val) {
          searchResult.clear();
          for (var element in val) {
            setState(() {
              searchResult.add(element);
            });
          }
        });
    setState(() {});
  }
}
