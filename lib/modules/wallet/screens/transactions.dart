import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/wallet/provider/wallet_provider.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/widgets.dart';

class AllTransactions extends ConsumerStatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  ConsumerState<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends ConsumerState<AllTransactions> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getTransactionProvider.notifier).getTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
      child: ref.watch(getTransactionProvider).when(
          loading: () => const SpinKitDemo(),
          done: (data) {
            if (data == null) {
              return const SizedBox();
            } else {
              return data.transactions!.isEmpty
                  ? Padding(
                    padding: const EdgeInsets.only(top: kLargePadding),
                    child: Center(
                        child: EmptyHomeProduct(
                          text: noTrans,
                          subText: noTransSub,
                        ),
                      ),
                  )
                  : Column(
                      children: List.generate(
                        data.transactions!.length,
                        (index) => Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: kSmallPadding),
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
                                child: SvgPicture.asset(AssetPaths.failTrans,
                                    color: data.transactions![index].type ==
                                            "debit"
                                        ? kError900
                                        : kGreen10),
                              ),
                              XBox(kSmallPadding),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.transactions![index].message ?? "",
                                      style: textTheme.headlineMedium!
                                          .copyWith(color: kBlue),
                                    ),
                                    YBox(8),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat("dd.MM.yyyy").format(data
                                              .transactions![index].createdAt!),
                                          style: textTheme.bodyLarge!.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
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
                                          DateFormat().add_jm().format(data
                                              .transactions![index].createdAt!),
                                          style: textTheme.bodyLarge!.copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
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
                                    color: data.transactions![index].type ==
                                            "debit"
                                        ? kError900
                                        : kGreen10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }
          }),
    );
  }
}
