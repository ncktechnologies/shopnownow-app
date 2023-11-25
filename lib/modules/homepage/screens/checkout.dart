import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/app/navigators/navigators.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/homepage/screens/home_widget_constant.dart';
import 'package:shopnownow/modules/homepage/screens/homepage.dart';
import 'package:shopnownow/modules/orders/screen/order_widget.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class CheckOut extends ConsumerStatefulWidget {
  final List<Product> productList;

  const CheckOut({Key? key, required this.productList}) : super(key: key);

  @override
  ConsumerState<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends ConsumerState<CheckOut> {
  Location? _location;
  int currentIndex = 0;
  bool isChecked = false;
  int itemCount = 1;
  bool isShow = true;
  List<Location> locationList = [];
  List<TimeSlot> timeSlotList = [];
  TimeSlot? timeSlot;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var publicKey = 'pk_test_25e249297133695de0f477d314a9d2658c967446';
  final plugin = PaystackPlugin();
  TextEditingController couponController = TextEditingController();
  int totalAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plugin.initialize(publicKey: publicKey);
    totalAmount = widget.productList.fold<int>(0, (previousValue, element) {
      return (previousValue +
          int.parse(element.price
              ?.replaceAll(".00", "") ??
              "0"));
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getLocationsProvider.notifier).getLocations(then: (val) {
        for (var element in val) {
          setState(() {
            locationList.add(element);
          });
        }
      });
      ref.read(getTimeSlotProvider.notifier).getTimeSlot(then: (val) {
        for (var element in val) {
          setState(() {
            timeSlotList.add(element);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  checkout,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(13),
                    decoration: const BoxDecoration(
                        color: kPrimaryColor, shape: BoxShape.circle),
                    child: Text(
                      widget.productList.length.toString(),
                      style: textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ))
              ],
            ),
            YBox(kPadding),
            const Divider(
              color: kLightAsh200,
              thickness: 2,
            ),
            YBox(kRegularPadding),
            Row(
              children: [
                Text(
                  yourItem,
                  style: textTheme.displayLarge!.copyWith(
                    color: Colors.black,
                  ),
                ),
                XBox(kMediumPadding),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: kPrimaryColor, shape: BoxShape.circle),
                        child: Text(
                          widget.productList.length.toString(),
                          style: textTheme.displayMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )),
                  ),
                ),
                InkWellNoShadow(
                  onTap: () {
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: Text(
                    isShow ? showLess : "Show more",
                    style: textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                XBox(kPadding),
                Icon(
                  isShow ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 25,
                  color: kPrimaryColor,
                )
              ],
            ),
            YBox(kRegularPadding),
            ...List.generate(
              widget.productList.length,
              (index) => isShow
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                height: 80,
                                width: 80,
                                imageUrl: widget
                                        .productList[index].thumbnailUrl ??
                                    "https://us.123rf.com/450wm/mathier/mathier1905/mathier190500002/mathier190500002-no-thumbnail-image-placeholder-for-forums-blogs-and-websites.jpg?ver=6",
                                fit: BoxFit.cover,
                                imageBuilder: (context, prov) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5, color: kGrey700),
                                        borderRadius: BorderRadius.circular(
                                            kRegularPadding),
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.productList[index].name ??
                                                "",
                                            style: textTheme.titleMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                    height: 1.5),
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          YBox(kPadding),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              "X${widget.productList[index].quantity}",
                                              softWrap: true,
                                              style: textTheme.titleSmall!
                                                  .copyWith(
                                                      fontSize: 10,
                                                      color: kDarkPurple),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "₦${widget.productList[index].quantity! * int.parse(widget.productList[index].price!.replaceAll(".00", ""))}",
                                      style: textTheme.displayLarge!.copyWith(
                                        color: kDarkColor400,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          YBox(kRegularPadding),
                          index == widget.productList.length - 1
                              ? YBox(0)
                              : Divider(
                                  color: kLightGrey400,
                                  thickness: 1,
                                  indent: screenSize.width / 4.5,
                                )
                        ],
                      ),
                    )
                  : YBox(0),
            ),
            YBox(kRegularPadding),

          SessionManager.getToken() == null ? YBox(0) :  Consumer(builder: (context, ref, _) {
              var addToListWidget = InkWellNoShadow(
                onTap: () {
                  List<ProductRequest> prodRequest = [];
                  for (var element in widget.productList) {
                    setState(() {
                      prodRequest.add(ProductRequest(
                          id: element.id!, quantity: element.quantity!));
                    });
                  }
                  ref.read(addToListProvider.notifier).addToList(
                      request: AddProductRequest(products: prodRequest),
                      then: (val) {
                        showSuccessBar(context, val);
                      });
                },
                child: Text(
                  addList,
                  style: textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              );
              return ref.watch(addToListProvider).when(
                  done: (data) => addToListWidget,
                  loading: () => const SpinKitDemo(),
                  error: (val) => addToListWidget);
            }),
            YBox(54),
            Text(
              delInfo,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            YBox(kRegularPadding),
            TextInputNoIcon(
              text: recipientName,
              controller: nameController,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else {
                  return null;
                }
              },
            ),
            TextInputNoIcon(
              text: mobNo,
              controller: phoneController,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else {
                  return null;
                }
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            TextInputNoIcon(
              text: emailAddress,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else if (!isEmail(val)) {
                  return invalidEmail;
                } else {
                  return null;
                }
              },
              controller: emailController,
            ),
            FormDropdown<Location>(
              value: _location,
              text: location,
              extraText: true,
              extraWidget: const SizedBox(),
              bottomPadding: kRegularPadding,
              extraTextString: "",
              validator: (val) {
                if (val == null) {
                  return emptyField;
                } else {
                  return null;
                }
              },
              hint: selLocation,
              onChanged: (Location? val) {
                setState(() {
                  _location = val;
                });
              },
              items: locationList
                  .map((e) => DropdownMenuItem<Location>(
                        value: e,
                        child: Text(
                          e.location!,
                          style: textTheme.headlineMedium!
                              .copyWith(color: kDarkColor400),
                        ),
                      ))
                  .toList(),
            ),
            TextInputNoIcon(
              text: address,
              hintText: enterDelAddress,
              controller: addressController,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else {
                  return null;
                }
              },
            ),
            FormDropdown<TimeSlot>(
              value: timeSlot,
              text: delTime,
              extraText: true,
              extraWidget: const SizedBox(),
              bottomPadding: kRegularPadding,
              extraTextString: "",
              hint: selectSlot,
              validator: (val) {
                if (val == null) {
                  return emptyField;
                } else {
                  return null;
                }
              },
              onChanged: (TimeSlot? val) {
                timeSlot = val;
              },
              items: timeSlotList
                  .map((e) => DropdownMenuItem<TimeSlot>(
                        value: e,
                        child: Text(
                          e.deliveryTime.toString(),
                          style: textTheme.headlineMedium!
                              .copyWith(color: kDarkColor400),
                        ),
                      ))
                  .toList(),
            ),
            YBox(kLargePadding),
            Text(
              applyDiscount,
              style: textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            YBox(kRegularPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SearchTextInputNoIcon(
                    noBorder: false,
                    hintText: enterCoupon,
                    controller: couponController,
                  ),
                ),
                XBox(kRegularPadding),
                InkWellNoShadow(
                  onTap: () {
                    ref
                        .read(loadCouponProvider.notifier)
                        .loadCoupon(coupon: couponController.text);
                  },
                  child: Container(
                    width: 96,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(kMacroPadding)),
                    child: Text(
                      apply,
                      style: textTheme.displayMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),

            YBox(kMediumPadding),
         SessionManager.getToken() == null ? Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               "$minOrder₦2,500",
               style: textTheme.headlineMedium!.copyWith(color: kOrange500),
             ),
             YBox(kMediumPadding),
             PaymentRow(
               text: subTotal,
               subText: totalAmount.toString(),
             ),
             PaymentRow(
               text: tax,
               subText: (totalAmount * 0.1).toString(),
             ),
             PaymentRow(
               text: delivery,
               subText: _location == null ? "0" : _location!.price!,
             ),
             _location == null
                 ? PaymentRow(
                 text: total,
                 subText: (totalAmount + (totalAmount* 0.1)).toString())
                 : PaymentRow(
                 text: total,
                 subText: ((totalAmount +
                     double.parse(_location!.price!) +
                     (totalAmount * 0.1))).toString()),
             YBox(kMediumPadding),
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Checkbox(
                   visualDensity:
                   const VisualDensity(horizontal: -4, vertical: -4),
                   activeColor: kPrimaryColor,
                   checkColor: kPrimaryWhite,
                   side: MaterialStateBorderSide.resolveWith(
                         (states) => BorderSide(
                         width: 2.0,
                         color: isChecked ? kPrimaryColor : kGrey700),
                   ),
                   shape: const RoundedRectangleBorder(
                     side: BorderSide(color: kPrimaryColor, width: 5),
                   ),
                   value: isChecked,
                   onChanged: (bool? value) {
                     setState(() {
                       isChecked = value!;
                     });
                   },
                 ),
                 Expanded(
                   child: Container(
                     padding: const EdgeInsets.only(top: kPadding),
                     child: RichText(
                       text: TextSpan(
                         text: "$accept ",
                         style: textTheme.headlineMedium!.copyWith(
                           color: Colors.black,
                         ),
                         children: [
                           TextSpan(
                               text: terms,
                               style: textTheme.headlineMedium!.copyWith(
                                   color: kPrimaryColor,
                                   decoration: TextDecoration.underline)),
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),
             YBox(kMacroPadding),
             Consumer(builder: (context, ref, _) {
               return ref.watch(processPaymentProvider).when(
                   done: (data) => Consumer(builder: (context, ref, _) {
                     var buttonWidget = LargeButton(
                         title: _location == null
                             ? "Pay ₦ ${((totalAmount + (totalAmount * 0.1))).toString()}"
                             : "Pay ₦ ${((totalAmount +
                             double.parse(_location!.price!) +
                             (totalAmount * 0.1))).toString()}",
                         onPressed: () {
                           if (isChecked) {
                             if (formKey.currentState!.validate()) {
                               List<ProductRequest> request = [];
                               for (var element in widget.productList) {
                                 setState(() {
                                   request.add(ProductRequest(
                                       id: element.id!,
                                       quantity: element.quantity!));
                                 });
                               }
                               CreateOrderRequest orderRequest =
                               CreateOrderRequest(
                                 products: request,
                                 userId: 0,
                                 price: totalAmount,
                                 tax: (totalAmount *
                                     0.1)
                                     .toInt(),
                                 status: "pending",
                                 deliveryInfo: addressController.text,
                                 paymentType: "card",
                                 recipientName: nameController.text,
                                 recipientPhone: phoneController.text,
                                 recipientEmail: emailController.text,
                                 deliveryFee: int.parse(_location!.price!
                                     .replaceAll(".00", "")),
                                 deliveryTimeSlot: timeSlot!.deliveryTime!,
                               );
                               ref
                                   .read(createOrderProvider.notifier)
                                   .createOrder(
                                   orderRequest: orderRequest,
                                   then: (val) {
                                       checkOut(
                                           ((totalAmount +
                                               double.parse(_location!.price!) +
                                               (totalAmount * 0.1))).toInt(),
                                           val["orderId"]);
                                   });
                             }
                           } else {
                             showErrorBar(context,
                                 "Please accept the terms and condition");
                           }
                         });
                     return ref.watch(createOrderProvider).when(
                       done: (data) => buttonWidget,
                       error: (val) => buttonWidget,
                       loading: () => const SpinKitDemo(),
                     );
                   }),
                   loading: () => const SpinKitDemo());
             }),
             YBox(kRegularPadding),
           ],
         ) :
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                YBox(kLargePadding),
                Text(
                  payWith,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                YBox(kSmallPadding),
                ...List.generate(
                    pay.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(bottom: kRegularPadding),
                      child: InkWellNoShadow(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                height: kMediumPadding,
                                width: kMediumPadding,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: currentIndex == index
                                            ? kPrimaryColor
                                            : kTextInputBorderColor),
                                    shape: BoxShape.circle),
                                child: currentIndex == index
                                    ? Container(
                                  height: kSmallPadding,
                                  width: kSmallPadding,
                                  decoration: const BoxDecoration(
                                      color: kPrimaryColor,
                                      shape: BoxShape.circle),
                                )
                                    : YBox(0),
                              ),
                              XBox(kSmallPadding),
                              Text(
                                pay[index],
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )),
                    )),
                YBox(85),
                Text(
                  "Note: Your wallet balance will be deducted first and the remaining balance will be removed from your card!!!",
                  style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: kPrimaryColor
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: k200,
                ),
                YBox(kRegularPadding),
                Text(
                  "$minOrder₦2,500",
                  style: textTheme.headlineMedium!.copyWith(color: kOrange500),
                ),
                YBox(kMediumPadding),
                PaymentRow(
                  text: subTotal,
                  subText: totalAmount.toString(),
                ),
                PaymentRow(
                  text: tax,
                  subText: (totalAmount * 0.1).toString(),
                ),
                PaymentRow(
                  text: delivery,
                  subText: _location == null ? "0" : _location!.price!,
                ),
                PaymentRow(
                    text: walletBalance,
                    subText: SessionManager.getWallet() ?? "0"),
                _location == null
                    ? PaymentRow(
                    text: total,
                    subText:  ( int.parse(SessionManager.getWallet()!.replaceAll(".00", "") ?? "0") -
                        (totalAmount + (totalAmount* 0.1))).toString())
                    : PaymentRow(
                    text: total,
                    subText: totalAmountToBePaid()),
                YBox(kMediumPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                      activeColor: kPrimaryColor,
                      checkColor: kPrimaryWhite,
                      side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                            width: 2.0,
                            color: isChecked ? kPrimaryColor : kGrey700),
                      ),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: kPrimaryColor, width: 5),
                      ),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: kPadding),
                        child: RichText(
                          text: TextSpan(
                            text: "$accept ",
                            style: textTheme.headlineMedium!.copyWith(
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: terms,
                                  style: textTheme.headlineMedium!.copyWith(
                                      color: kPrimaryColor,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                YBox(kMacroPadding),
                Consumer(builder: (context, ref, _) {
                  return ref.watch(processPaymentProvider).when(
                      done: (data) => Consumer(builder: (context, ref, _) {
                        var buttonWidget = LargeButton(
                            title: _location == null
                                ? "Pay ₦ ${(int.parse(SessionManager.getWallet()!.replaceAll(".00", "") ?? "0") -(totalAmount +
                                (totalAmount * 0.1))).toString()}"
                                : "Pay ₦ ${totalAmountToBePaid()}",
                            onPressed: () {
                              if (isChecked) {
                                if (formKey.currentState!.validate()) {
                                  List<ProductRequest> request = [];
                                  for (var element in widget.productList) {
                                    setState(() {
                                      request.add(ProductRequest(
                                          id: element.id!,
                                          quantity: element.quantity!));
                                    });
                                  }
                                  CreateOrderRequest orderRequest =
                                  CreateOrderRequest(
                                    products: request,
                                    userId: SessionManager.getUserId(),
                                    price: totalAmount,
                                    tax: (totalAmount *
                                        0.1)
                                        .toInt(),
                                    status: "pending",
                                    deliveryInfo: addressController.text,
                                    paymentType:
                                    currentIndex == 0 ? "card" : "wallet",
                                    recipientName: nameController.text,
                                    recipientPhone: phoneController.text,
                                    recipientEmail: emailController.text,
                                    deliveryFee: int.parse(_location!.price!
                                        .replaceAll(".00", "")),
                                    deliveryTimeSlot: timeSlot!.deliveryTime!,
                                  );
                                  ref
                                      .read(createOrderProvider.notifier)
                                      .createOrder(
                                      orderRequest: orderRequest,
                                      then: (val) {
                                        if(totalAmountToBePaid() == "0" ){
                                          ProcessPaymentRequest paymentRequest = ProcessPaymentRequest(
                                            userId: SessionManager.getUserId(),
                                            amount: totalAmountToBePaid(),
                                            status: "successful",
                                            orderId: val["orderId"],
                                            reference: "wallet",
                                            paymentType: "wallet",
                                            paymentGateway: "wallet",
                                            paymentGatewayReference: "wallet",
                                          );
                                          ref.read(processPaymentProvider.notifier).processPayment(
                                              paymentRequest: paymentRequest,
                                              then: (val) {
                                                pushToAndClearStack(const HomePage());
                                                showSuccessBar(context, val);
                                              });
                                        }else {
                                          checkOut(
                                              int.parse(totalAmountToBePaid().substring(1).replaceAll(".0", "")),
                                              val["orderId"]);
                                        }
                                        // "message" : data["message"],
                                        // "orderId"
                                        // showSuccessBar(context, val["message"]);
                                      });
                                }
                              } else {
                                showErrorBar(context,
                                    "Please accept the terms and condition");
                              }
                            });
                        return ref.watch(createOrderProvider).when(
                          done: (data) => buttonWidget,
                          error: (val) => buttonWidget,
                          loading: () => const SpinKitDemo(),
                        );
                      }),
                      loading: () => const SpinKitDemo());
                }),
                YBox(kRegularPadding),
              ],
            )
          ],
        ),
      ),
    ));
  }

  String totalAmountToBePaid(){
    String amount = "0";
    if(double.parse(SessionManager.getWallet()!.replaceAll(".00", "")) > double.parse(((totalAmount +
        double.parse(_location!.price!) +
        (totalAmount * 0.1))).toString()) ){
        amount = "0";

    }else{
        amount =  (int.parse(SessionManager.getWallet()!.replaceAll(".00", "") ?? "0") - (totalAmount +
            double.parse(_location!.price!) +
            (totalAmount * 0.1)))
            .toString();
    }
    return amount;
  }

  checkOut(int cost, int checkoutOrderId) async {
    Charge charge = Charge()
      ..amount = cost * 100
      ..reference = "${DateTime.now().millisecondsSinceEpoch}"
      ..email = emailController.text;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status) {
      ProcessPaymentRequest paymentRequest = ProcessPaymentRequest(
        userId: SessionManager.getUserId(),
        amount: cost.toString(),
        status: "successful",
        orderId: checkoutOrderId,
        reference: response.reference!,
        paymentType: "card",
        paymentGateway: "paystack",
        paymentGatewayReference: response.reference!,
      );

      ref.read(processPaymentProvider.notifier).processPayment(
          paymentRequest: paymentRequest,
          noToken: SessionManager.getToken() == null ? true : false,
          then: (val) {
            pushToAndClearStack(const HomePage());
            showSuccessBar(context, val);
          });
    }
  }
}
