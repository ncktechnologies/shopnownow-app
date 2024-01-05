import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/checkout.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/orders/screen/order_widget.dart';
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
  OverlayEntry? overlaySearchEntry;
  GetCategories? categoryName;
  Timer? _debounce;
  List<Product> productList = [];
  bool _searching = false;

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
                                controller.clear();
                              });
                              overlayEntry?.remove();
                              overlayEntry = null;
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: kSmallPadding),
                              child: Row(
                                children: [
                                  e.thumbnail!.split(".").last == "svg"
                                      ? SvgPicture.network(
                                          e.thumbnail ?? "",
                                          fit: BoxFit.scaleDown,
                                          height: kMacroPadding,
                                          width: kMacroPadding,
                                        )
                                      : Image.network(
                                          e.thumbnail!,
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

  void _showSearchOverlay(BuildContext context) async {
    OverlayState overlayState = Overlay.of(context);
    overlaySearchEntry = OverlayEntry(builder: (context) {
      // You can return any widget you like here
      // to be displayed on the Overlay
      return Positioned(
        left: kRegularPadding,
        right: kRegularPadding,
        top: MediaQuery.of(context).size.height * 0.30,
        child: Container(
            height: searchResult.length == 1 ? 150 : 350,
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
            child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (context, index) {
                  return Material(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: kSmallPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                height: 80,
                                width: 80,
                                imageUrl: searchResult[index].thumbnailUrl ??
                                    "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
                                fit: BoxFit.cover,
                                imageBuilder: (context, prov) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: kLight300),
                                        borderRadius: kBorderSmallRadius,
                                        image: DecorationImage(
                                            image: prov, fit: BoxFit.cover)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    searchResult[index].name ?? "",
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  YBox(kPadding),
                                  Text(
                                    widget.menuItems.name ?? "",
                                    style: textTheme.displaySmall!.copyWith(
                                        color: kDarkPurple, fontSize: 10),
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
                                          searchResult[index].price ?? "0",
                                          softWrap: true,
                                          style:
                                              textTheme.displayLarge!.copyWith(
                                            fontSize: 10,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                              InkWellNoShadow(
                                onTap: () {
                                  if(productList.isEmpty){
                                    setState(() {
                                      productList.add(
                                        Product(
                                            id: searchResult[index].id!,
                                            name: searchResult[index].name!,
                                            quantity: 1,
                                            bandId: searchResult[index].bandId!,
                                            price: searchResult[index].price,
                                            thumbnailUrl: searchResult[index]
                                                .thumbnailUrl),
                                      );

                                      overlayEntry?.remove();
                                      overlaySearchEntry?.remove();
                                      overlayEntry = null;
                                      overlaySearchEntry = null;
                                    });
                                  }else{
                                  if (productList.first.bandId ==
                                      searchResult[index].bandId) {
                                    setState(() {
                                      productList.add(
                                        Product(
                                            id: searchResult[index].id!,
                                            name: searchResult[index].name!,
                                            quantity: 1,
                                            bandId: searchResult[index].bandId,
                                            price: searchResult[index].price,
                                            thumbnailUrl: searchResult[index]
                                                .thumbnailUrl),
                                      );

                                      overlayEntry?.remove();
                                      overlaySearchEntry?.remove();
                                      overlayEntry = null;
                                      overlaySearchEntry = null;
                                    });
                                  }else{
                                    showErrorBar(context, "This Category does not have the same Band as the previous category and can't be added to list.");
                                    setState(() {
                                      overlayEntry?.remove();
                                      overlaySearchEntry?.remove();
                                      overlayEntry = null;
                                      overlaySearchEntry = null;
                                    });

                                  }
                                }},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(kMicroPadding),
                                      border: Border.all(
                                          color: kLightAsh50, width: 1.5)),
                                  child: Text(
                                    addList,
                                    style: textTheme.displayLarge!.copyWith(
                                        color: kGrey600, fontSize: 14),
                                  ),
                                ),
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
                    ),
                  );
                })),
      );
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlaySearchEntry!);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryName = widget.menuItems;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        overlayEntry?.remove();
        overlaySearchEntry?.remove();
        return true;
      },
      child: Scaffold(
        drawer: const Drawer(
          child: DrawerScaffoldContainer(),
        ),
        onDrawerChanged: (val) {
          overlayEntry?.remove();
          overlaySearchEntry?.remove();
          overlayEntry = null;
          overlaySearchEntry = null;
        },
        resizeToAvoidBottomInset: false,
        bottomSheet: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
          child: InkWellNoShadow(
            onTap: () {
              overlayEntry?.remove();
              overlaySearchEntry?.remove();
              overlayEntry = null;
              overlaySearchEntry = null;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 2,
                  color: k200,
                ),
                YBox(kRegularPadding),
                Text(
                  "$minOrder₦${widget.menuItems.band!.minimum}",
                  style: textTheme.headlineMedium!.copyWith(color: kOrange500),
                ),
                YBox(kMediumPadding),
                PaymentRow(
                    text: subTotal,
                    subText:
                        (productList.fold<int>(0, (previousValue, element) {
                      return (previousValue +
                          (int.parse(
                                  element.price?.replaceAll(".00", "") ?? "0") *
                              element.quantity!));
                    }).toString())),
                YBox(kRegularPadding),
                LargeButton(
                    title: checkout,
                    onPressed: productList.isEmpty
                        ? () {
                            showErrorBar(context, "Please add a Product");
                          }
                        : () {
                            if (double.parse(widget.menuItems.band!.minimum!) >
                                double.parse((productList.fold<int>(0,
                                    (previousValue, element) {
                                  return (previousValue +
                                      (int.parse(element.price
                                                  ?.replaceAll(".00", "") ??
                                              "0") *
                                          element.quantity!));
                                }).toString()))) {
                              showErrorBar(context,
                                  "The minimum order is ₦${widget.menuItems.band!.minimum}");
                            } else {
                              overlayEntry?.remove();
                              overlaySearchEntry?.remove();
                              overlayEntry = null;
                              overlaySearchEntry = null;
                              pushTo(
                                CheckOut(
                                  productList: productList,
                                  band: widget.menuItems.band,
                                  tax: widget.menuItems.tax,
                                ),
                              );
                            }
                          }),
                YBox(kRegularPadding),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            InkWellNoShadow(
              onTap: () {
                overlayEntry?.remove();
                overlaySearchEntry?.remove();
                overlayEntry = null;
                overlaySearchEntry = null;
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(right: kMediumPadding),
                child: Center(
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            )
          ],
          leading: Builder(
            builder: (context) => InkWellNoShadow(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.only(left: kRegularPadding),
                child: SvgPicture.asset(
                  AssetPaths.moreLogo,
                ),
              ),
            ),
          ),
          leadingWidth: 40,
          title: Image.asset(AssetPaths.logo, height: 40),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              overlayEntry?.remove();
              overlaySearchEntry?.remove();
              overlayEntry = null;
              overlaySearchEntry = null;
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
                      } else {
                        setState(() {
                          overlayEntry?.remove();
                          overlaySearchEntry?.remove();
                          overlayEntry = null;
                          overlaySearchEntry = null;
                        });
                      }
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
                          XBox(25),
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
                    controller: controller,
                    icon: _searching
                        ? SizedBox(
                            width: 40,
                            child: Container(
                                margin: const EdgeInsets.only(
                                    right: kMediumPadding),
                                child: const SpinKitDemo(
                                  size: 30,
                                )),
                          )
                        : YBox(0),
                    onChanged: (inputValue) {
                      if (_debounce?.isActive ?? false) _debounce?.cancel();
                      _debounce = Timer(const Duration(seconds: 1), () {
                        if (inputValue != null &&
                            inputValue.trim().isNotEmpty) {
                          onSearchTextChanged(inputValue ?? "");
                          setState(() {
                            _searching = true;
                          });
                        } else {
                          overlaySearchEntry?.remove();
                          overlaySearchEntry = null;
                          setState(() {
                            _searching = false;
                          });
                        }

                        setState(() {});
                      });
                    },
                    // onChanged: (val) {
                    //   if (val!.isEmpty) {
                    //     overlaySearchEntry?.remove();
                    //     overlaySearchEntry = null;
                    //   } else {
                    //     onSearchTextChanged(val ?? "");
                    //   }
                    // },
                    hintText: searchText,
                  ),
                  productList.isEmpty
                      ? YBox(0)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              shoppingList,
                              style: textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            Consumer(builder: (context, ref, _) {
                              var widget = InkWellNoShadow(
                                onTap: () {
                                  List<ProductRequest> prodRequest = [];
                                  for (var element in productList) {
                                    setState(() {
                                      prodRequest.add(ProductRequest(
                                          id: element.id!,
                                          quantity: element.quantity!));
                                    });
                                  }
                                  ref
                                      .read(addToListProvider.notifier)
                                      .addToList(
                                          request: AddProductRequest(
                                              products: prodRequest),
                                          then: (val) {
                                            showSuccessBar(context, val);
                                          });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kRegularPadding,
                                      vertical: kPadding),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(500),
                                      color: kLightPurple200),
                                  child: Text(
                                    saveList,
                                    style: textTheme.bodyLarge!.copyWith(
                                        fontSize: 14, color: kLightBlue400),
                                  ),
                                ),
                              );
                              return ref.watch(addToListProvider).when(
                                  done: (data) => widget,
                                  error: (val) => widget,
                                  loading: () => const SpinKitDemo());
                            })
                          ],
                        ),
                  YBox(productList.isEmpty ? 0 : kMicroPadding),
                  productList.isEmpty
                      ? Container(
                          width: double.infinity,
                          height: screenSize.height,
                          color: kPrimaryWhite,
                          child: EmptyHomeProduct(
                            text: noProd,
                            subText: addItem,
                          ))
                      : Expanded(
                          child: ListView(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              productList.length,
                              (index) => HomeCartList(
                                product: productList[index],
                                subtractTap: () {
                                  if (productList[index].quantity != 1) {
                                    setState(() {
                                      productList[index].quantity =
                                          productList[index].quantity! - 1;
                                    });
                                  }
                                },
                                addTap: () {
                                  setState(() {
                                    productList[index].quantity =
                                        productList[index].quantity! + 1;
                                  });
                                },
                                category: categoryName!,
                                onTap: () {
                                  setState(() {
                                    productList.removeAt(index);
                                  });
                                },
                              ),
                            ).toList(),
                          ),
                        ),
                  YBox(170),
                ],
              ),
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
          setState(() {
            _searching = false;
          });
          for (var element in val) {

            setState(() {
              searchResult.add(element);
              if (searchResult.isNotEmpty) {
                print(searchResult);
                if (overlaySearchEntry == null) {
                  _searching = false;
                  _showSearchOverlay(context);
                }
              }
            });
          }
        });
    setState(() {
      _searching = false;
    });
  }
}

class HomeCartList extends StatefulWidget {
  final Product product;
  final GetCategories category;
  final Function() onTap, addTap, subtractTap;

  const HomeCartList(
      {Key? key,
      required this.product,
      required this.category,
      required this.addTap,
      required this.subtractTap,
      required this.onTap})
      : super(key: key);

  @override
  State<HomeCartList> createState() => _HomeCartListState();
}

class _HomeCartListState extends State<HomeCartList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              height: 105,
              width: 108,
              imageUrl: widget.product.thumbnailUrl ??
                  "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
              fit: BoxFit.cover,
              imageBuilder: (context, prov) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: kLight300),
                      borderRadius: kBorderSmallRadius,
                      image: DecorationImage(image: prov, fit: BoxFit.cover)),
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
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name ?? "",
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                YBox(kPadding),
                Text(
                  widget.category.name ?? "",
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
                      style: textTheme.displayLarge!
                          .copyWith(fontSize: 10, fontWeight: FontWeight.w700),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "${widget.product.price}",
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
                          borderRadius: BorderRadius.circular(kMicroPadding),
                          border: Border.all(color: kLightAsh50, width: 1.5)),
                      child: Row(
                        children: [
                          InkWellNoShadow(
                            onTap: widget.subtractTap,
                            child: Text(
                              "-",
                              style: textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: widget.product.quantity != 1
                                      ? kPrimaryColor
                                      : kLight700),
                            ),
                          ),
                          XBox(kMediumPadding),
                          Text(
                            widget.product.quantity.toString(),
                            style: textTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                          XBox(kMediumPadding),
                          InkWellNoShadow(
                            onTap: widget.addTap,
                            child: Text(
                              "+",
                              style: textTheme.displayLarge!.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    XBox(kFullPadding),
                    InkWellNoShadow(
                      child: SvgPicture.asset(AssetPaths.delete),
                      onTap: widget.onTap,
                    )
                  ],
                )
              ],
            )),
          ],
        ),
        YBox(kMediumPadding),
      ],
    );
  }
}
