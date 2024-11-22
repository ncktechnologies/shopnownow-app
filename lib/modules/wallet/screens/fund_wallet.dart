import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';
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
  var publicKey = 'pk_live_5cd36a8da973af18baaa38ffaa526e4427f16c2d';
  // final plugin = PaystackPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // plugin.initialize(publicKey: publicKey);
  }

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
                loading: () => const SpinKitDemo(),
                done: (data) => LargeButton(
                      title: fundAmount,
                      onPressed: () {
                        if (controller.text.isEmpty) {
                          showErrorBar(context, "Please put in an amount");
                        } else {
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
    String? email = SessionManager.getEmail();
    final uniqueTransRef = "${DateTime.now().millisecondsSinceEpoch}";

    PaystackFlutter().pay(
      context: context,
      secretKey:
          'sk_test_7f97db22564ed0d9bc71225f4629c0ee971e2942', // Your Paystack secret key
      amount:
          cost * 100, // The amount to be charged in the smallest currency unit
      email: email!, // The customer's email address
      callbackUrl:
          'https://callback.com', // The URL to which Paystack will redirect the user after the transaction
      showProgressBar: true, // Show progress bar during the transaction
      paymentOptions: [
        PaymentOption.card,
        PaymentOption.bankTransfer,
        PaymentOption.mobileMoney
      ],
      currency: Currency.NGN,
      metaData: {
        "product_name": "Product Name",
        "product_quantity": 1,
        "product_price": cost
      }, // Additional metadata to be associated with the transaction
      onSuccess: (paystackCallback) {
        ref.read(fundWalletProvider.notifier).fundWallet(
              amount: (cost).toString(),
              reference: uniqueTransRef,
              then: () {
                ref.read(getTransactionProvider.notifier).getTransaction();
                ref
                    .read(getLimitedTransactionProvider.notifier)
                    .getLimitedTransaction();
                ref.read(getWalletProvider.notifier).getWallet(then: () {
                  Navigator.pop(context);
                  setState(() {});
                });
              },
            );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Transaction Successful::::${paystackCallback.reference}'),
            backgroundColor: Colors.blue,
          ),
        );
      }, // A callback function to be called when the payment is successful
      onCancelled: (paystackCallback) {
        print("Transaction Not Successful!");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Transaction Failed/Not successful::::${paystackCallback.reference}'),
            backgroundColor: Colors.red,
          ),
        );
      }, // A callback function to be called when the payment is canceled
    );
  }
}
