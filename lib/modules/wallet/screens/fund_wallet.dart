import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack_plus/flutter_paystack_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/wallet/provider/wallet_provider.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class FundWalletScreen extends ConsumerStatefulWidget {
  const FundWalletScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FundWalletScreen> createState() => _FundWalletScreenState();
}

class _FundWalletScreenState extends ConsumerState<FundWalletScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
      noScroll: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YBox(kMacroPadding),
            Text(
              fundWallet,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            YBox(kMicroPadding),
            Expanded(
              child: TextInputNoIcon(
                text: enterAmount,
                controller: controller,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            ref.watch(fundWalletProvider).when(
                loading: ()=> const SpinKitDemo(),done: (data) => LargeButton(
                      title: fundAmount,
                      onPressed: () {
                        if(controller.text.isEmpty){
                          showErrorBar(context, "Please put in an amount");
                        }else {
                          checkOut(int.parse(controller.text));
                        }
                      },
                    )),
            YBox(kRegularPadding)
          ],
        ),
      ),
    );
  }

  checkOut(int cost) async {
    FlutterPaystackPlus.openPaystackPopup(
      publicKey: publicKey,
      customerEmail: SessionManager.getEmail()!,
      context: context,
      secretKey: secretKey,
      currency: 'NGN',
      amount: (cost * 100).toString(),
      reference: DateTime.now().millisecondsSinceEpoch.toString(),
      callBackUrl: "[GET IT FROM YOUR PAYSTACK DASHBOARD]",
      onClosed: () {
        debugPrint('Could\'nt finish payment');
      },
      onSuccess: () async {
        debugPrint('successful payment');

        ref.read(fundWalletProvider.notifier).fundWallet(
            amount: cost.toString(),
            reference: DateTime.now().millisecondsSinceEpoch.toString(),
            then: () {

              ref.read(getTransactionProvider.notifier).getTransaction();
              ref.read(getLimitedTransactionProvider.notifier).getLimitedTransaction();
              ref.read(getWalletProvider.notifier).getWallet(then: () {
                Navigator.pop(context);
                setState(() {});
              });

            });
      },
    );
  }
}
