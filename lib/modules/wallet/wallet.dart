import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/wallet/provider/wallet_provider.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/widgets.dart';

class MyWallet extends ConsumerStatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  ConsumerState<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends ConsumerState<MyWallet> {
  bool obscure = true;
  var publicKey = 'pk_test_25e249297133695de0f477d314a9d2658c967446';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKey);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getTransactionProvider.notifier).getTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Text(
            wallet,
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
          YBox(kMacroPadding),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: kMacroPadding, vertical: kMediumPadding),
            decoration: const BoxDecoration(
                borderRadius: kBorderSmallRadius, color: green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walletBalance,
                  style: textTheme.bodyLarge!
                      .copyWith(color: kLightAsh, fontSize: 16),
                ),
                YBox(kSmallPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      obscure ? "********" : "₦${SessionManager.getWallet()}",
                      style: textTheme.displayMedium!
                          .copyWith(fontWeight: FontWeight.w900, fontSize: 38),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: obscure
                          ? const Icon(
                              Icons.remove_red_eye_outlined,
                              color: kPrimaryWhite,
                            )
                          : SvgPicture.asset(
                              AssetPaths.closeEye,
                              fit: BoxFit.scaleDown,
                              color: kPrimaryWhite,
                            ),
                    ),
                  ],
                ),
                YBox(kRegularPadding),
                InkWellNoShadow(
                  onTap: () {
                    checkOut(
                      100,
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kMediumPadding),
                        color: kPrimaryColor),
                    child: Text(
                      fundWallet,
                      style: textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          YBox(kRegularPadding),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: kRegularPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kRegularPadding),
                color: kYellow400),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  decoration: const BoxDecoration(
                    color: kPrimaryWhite,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AssetPaths.pointLogo),
                ),
                XBox(kSmallPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loyaltyPoint,
                        style: textTheme.displayLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                      YBox(kPadding),
                      Text(
                        "${SessionManager.getLoyaltyPoints()} pts",
                        style: textTheme.displayLarge!
                            .copyWith(fontSize: 18, color: kBlack600),
                      ),
                      Text(
                        "50pts = ₦10.00 ",
                        style: textTheme.headlineMedium!
                            .copyWith(fontSize: 10, color: kBlack600),
                      ),
                    ],
                  ),
                ),
                Consumer(builder: (context, ref, _) {
                  var widget = InkWellNoShadow(
                    onTap: () {
                      ref.read(convertPointsProvider.notifier).convertPoints(
                            then: (val) => showSuccessBar(context, val),
                            error: (val) => showErrorBar(context, val),
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: kOrange500),
                      child: Text(
                        convertPoint,
                        style: textTheme.displayMedium!.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                  return ref.watch(convertPointsProvider).when(
                      done: (done) => widget,
                      loading: () => const SpinKitDemo(),
                      error: (val) => widget);
                })
              ],
            ),
          ),
          YBox(kRegularPadding),
          Text(
            transActivity,
            style: textTheme.bodyLarge!.copyWith(color: kBlue, fontSize: 16),
          ),
          YBox(kRegularPadding),
          Consumer(builder: (context, ref, _) {
            return ref.watch(getTransactionProvider).when(
                done: (data) {
                  if (data != null) {
                    return data.transactions!.isEmpty
                        ? EmptyHomeProduct(
                            text: noTrans,
                            subText: noTransSub,
                          )
                        : Column(
                            children: List.generate(
                              data.transactions!.length,
                              (index) => Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    bottom: kSmallPadding),
                                padding: const EdgeInsets.all(kRegularPadding),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(kRegularPadding),
                                    color: kLightGrey200),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: kLightAsh300,
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                          AssetPaths.failTrans,
                                          color:
                                              data.transactions![index].type ==
                                                      "debit"
                                                  ? kError900
                                                  : kGreen10),
                                    ),
                                    XBox(kSmallPadding),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.transactions![index].message ??
                                                "",
                                            style: textTheme.headlineMedium!
                                                .copyWith(color: kBlue),
                                          ),
                                          YBox(8),
                                          Row(
                                            children: [
                                              Text(
                                                DateFormat("dd.MM.yyyy").format(
                                                    data.transactions![index]
                                                        .createdAt!),
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kDark100),
                                              ),
                                              XBox(kPadding),
                                              Container(
                                                height: kPadding,
                                                width: kPadding,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kDark100),
                                              ),
                                              XBox(kPadding),
                                              Text(
                                                DateFormat().add_jm().format(
                                                    data.transactions![index]
                                                        .createdAt!),
                                                style: textTheme.bodyLarge!
                                                    .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kDark100),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      data.transactions![index].type == "debit"
                                          ? "- ₦ ${data.transactions![index].amount}"
                                          : "+ ₦ ${data.transactions![index].amount}",
                                      style: textTheme.displayLarge!.copyWith(
                                          color:
                                              data.transactions![index].type ==
                                                      "debit"
                                                  ? kError900
                                                  : kGreen10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                  } else {
                    return const SizedBox();
                  }
                },
                loading: () => const SpinKitDemo());
          })
        ],
      ),
    ));
  }

  checkOut(int cost) async {
    Charge charge = Charge()
      ..amount = cost * 100
      ..reference = "${DateTime.now().millisecondsSinceEpoch}"
      ..email = SessionManager.getEmail();
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status) {
      ref.read(fundWalletProvider.notifier).fundWallet(
          amount: cost.toString(),
          reference: response.reference!,
          then: () {
            ref.read(getTransactionProvider.notifier).getTransaction();
            ref.read(getWalletProvider.notifier).getWallet(then: () {
              setState(() {});
            });
          });
    }
  }
}
