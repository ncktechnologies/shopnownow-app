import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/checkout.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/orders/model/order_model.dart' as order;
import 'package:shopnownow/modules/savedlist/provider/savedlist_provider.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/widgets.dart';

class SavedList extends ConsumerStatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  ConsumerState<SavedList> createState() => _SavedListState();
}

class _SavedListState extends ConsumerState<SavedList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(savedListProvider.notifier).getSavedList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        noIcon: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
            child: ref.watch(savedListProvider).when(
                done: (data) {
                  if (data == null) {
                    return const SizedBox();
                  } else {
                    print(  data.shoppingLists!.isEmpty);

                    return Column(
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
                                    color: kPrimaryColor,
                                    shape: BoxShape.circle),
                                child: Text(
                                  data.shoppingLists!.length.toString(),
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
                        data.shoppingLists!.isEmpty ?  Center(
                          child: EmptyHomeProduct(
                            text: noSavedList,
                            subText: addItem,
                          ),
                        ) :
                       Column(
                         children: [ ...List.generate(
                             data.shoppingLists!.length,
                                 (index) =>
                                 Column(
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
                                             "${data.shoppingLists![index].productIds!.length} item(s) created",
                                             style: textTheme.titleSmall,
                                           ),
                                         ),
                                         Row(
                                           children: [
                                             InkWellNoShadow(
                                               onTap: () {
                                                 pushTo(CheckOut(
                                                     productList: data
                                                         .shoppingLists![index]
                                                         .productIds!,
                                                     band: data
                                                         .shoppingLists![index]
                                                         .productIds![0]
                                                         .band,
                                                     tax: data
                                                         .shoppingLists![index]
                                                         .productIds![0]
                                                         .category!
                                                         .tax));
                                               },
                                               child: Container(
                                                 padding:
                                                 const EdgeInsets.symmetric(
                                                     horizontal:
                                                     kRegularPadding,
                                                     vertical:
                                                     kSmallPadding),
                                                 decoration: BoxDecoration(
                                                   color: kGreen100,
                                                   borderRadius:
                                                   BorderRadius.circular(
                                                       500),
                                                 ),
                                                 child: Text(
                                                   checkout,
                                                   style: textTheme.bodyLarge!
                                                       .copyWith(
                                                       color: kGreen200,
                                                       fontSize: 14),
                                                 ),
                                               ),
                                             ),
                                             XBox(kRegularPadding),
                                             InkWellNoShadow(
                                                 onTap: () {
                                                   ref
                                                       .read(deleteSavedListProvider(
                                                       data
                                                           .shoppingLists![
                                                       index]
                                                           .id!)
                                                       .notifier)
                                                       .deleteSavedList(
                                                       listId: data
                                                           .shoppingLists![
                                                       index]
                                                           .id!,
                                                       then: (val) {
                                                         ref
                                                             .read(savedListProvider
                                                             .notifier)
                                                             .getSavedList(
                                                             loading:
                                                             false);
                                                       },
                                                       error: (val) {
                                                         showErrorBar(
                                                             context, val);
                                                       });
                                                 },
                                                 child: ref
                                                     .watch(
                                                     deleteSavedListProvider(
                                                         data
                                                             .shoppingLists![
                                                         index]
                                                             .id!))
                                                     .when(
                                                     done: (done) =>
                                                     const Icon(
                                                       Icons.delete,
                                                       color:
                                                       kPrimaryColor,
                                                     ),
                                                     error: (val) =>
                                                     const Icon(
                                                       Icons.delete,
                                                       color:
                                                       kPrimaryColor,
                                                     ),
                                                     loading: () =>
                                                     const SpinKitDemo()))
                                           ],
                                         )
                                       ],
                                     ),
                                     const Divider(
                                       color: kLight900,
                                       thickness: 1,
                                     )
                                   ],
                                 ))],
                       )
                      ],
                    );
                  }
                },
                loading: () => const Padding(
                      padding: EdgeInsets.only(top: kSmallPadding),
                      child: SpinKitDemo(),
                    ),
                error: (val) => const SizedBox())));
  }
}
