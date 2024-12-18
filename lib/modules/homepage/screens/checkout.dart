import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:pay_with_paystack/pay_with_paystack.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paystack_for_flutter/paystack_for_flutter.dart';
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
import 'package:url_launcher/url_launcher.dart';

class CheckOut extends ConsumerStatefulWidget {
  final List<Product> productList;
  final Band? band;
  final String? tax;

  const CheckOut({Key? key, required this.productList, this.tax, this.band})
      : super(key: key);

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
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var publicKey = 'pk_live_5cd36a8da973af18baaa38ffaa526e4427f16c2d';
  // final plugin = PaystackPlugin();
  TextEditingController couponController = TextEditingController();
  int totalAmount = 0;
  int couponAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // plugin.initialize(publicKey: publicKey);
    totalAmount = widget.productList.fold<int>(0, (previousValue, element) {
      return (previousValue +
          (int.parse(element.price?.replaceAll(".00", "") ?? "0") *
              element.quantity!));
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(getLocationsProvider.notifier).getLocations(
          then: (val) {
            for (var element in val) {
              setState(() {
                locationList.add(element);
              });
            }
          },
          id: widget.band!.id!);
      ref.read(getTimeSlotProvider.notifier).getTimeSlot(
          id: widget.band!.id!,
          then: (val) {
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
            SessionManager.getToken() == null
                ? YBox(0)
                : Consumer(builder: (context, ref, _) {
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
              inputType: TextInputType.name,
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
              inputType: TextInputType.phone,
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
            SessionManager.getToken() != null
                ? YBox(0)
                : TextInputNoIcon(
                    text: emailAddress,
                    inputType: TextInputType.emailAddress,
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
            TextInputNoIcon(
              text: scheduleDate,
              hintText: selectDate,
              read: true,
              onTap: () async {
                DateTime? datePicked = await DatePicker.showSimpleDatePicker(
                  context,
                  initialDate: DateTime(DateTime.now().year,
                      DateTime.now().month, DateTime.now().day),
                  firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                  lastDate: DateTime(3000, 12, 31),
                  dateFormat: "dd-MMMM-yyyy",
                  locale: DateTimePickerLocale.en_us,
                  looping: true,
                );
                if (datePicked != null) {
                  dateController.text =
                      DateFormat("yyyy-MM-dd").format(datePicked);
                }
              },
              controller: dateController,
              icon: const SizedBox(
                width: 40,
                child: Icon(
                  weight: 3,
                  Icons.calendar_today_outlined,
                  color: kGrey100,
                ),
              ),
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
                Consumer(builder: (context, ref, _) {
                  var widget = InkWellNoShadow(
                    onTap: () {
                      ref.read(loadCouponProvider.notifier).loadCoupon(
                          coupon: couponController.text,
                          error: (val) => showErrorBar(context, val),
                          then: (val) {
                            setState(() {
                              couponAmount =
                                  int.parse(val.replaceAll(".00", ""));
                              // totalAmount = couponAmount > totalAmount ? 0 : totalAmount - couponAmount;
                            });
                          });
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
                  );
                  return ref.watch(loadCouponProvider).when(
                      done: (done) => widget,
                      loading: () => const Center(child: SpinKitDemo()),
                      error: (val) => widget);
                })
              ],
            ),
            YBox(kMediumPadding),
            SessionManager.getToken() == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$minOrder₦${widget.band!.minimum}",
                        style: textTheme.headlineMedium!
                            .copyWith(color: kOrange500),
                      ),
                      YBox(kMediumPadding),
                      PaymentRow(
                        text: subTotal,
                        subText: subTotalCalculation().toString(),
                      ),
                      PaymentRow(
                        text: "$tax(${widget.tax?.replaceAll(".00", "")}%)",
                        subText: (double.parse(subTotalCalculation()) *
                                double.parse((double.parse(
                                            widget.tax!.replaceAll(".00", "")) /
                                        100)
                                    .toString()))
                            .toStringAsFixed(2),
                      ),
                      PaymentRow(
                        text: delivery,
                        subText: _location == null ? "0" : _location!.price!,
                      ),
                      _location == null
                          ? YBox(0)
                          : PaymentRow(
                              text: total,
                              subText: (double.parse(subTotalCalculation()) >
                                      widget.band!.freeDeliveryThreshold!
                                          .toDouble())
                                  ? ((double.parse(subTotalCalculation())) +
                                          (double.parse(subTotalCalculation()) *
                                              double.parse(
                                                  (double.parse(widget.tax!.replaceAll(".00", "")) / 100)
                                                      .toString())))
                                      .toStringAsFixed(2)
                                  : ((double.parse(subTotalCalculation())) +
                                          double.parse(_location!.price!) +
                                          (double.parse(subTotalCalculation()) *
                                              double.parse(
                                                  (double.parse(widget.tax!.replaceAll(".00", "")) / 100)
                                                      .toString())))
                                      .toStringAsFixed(2)),
                      YBox(kMediumPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            activeColor: kPrimaryColor,
                            checkColor: kPrimaryWhite,
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 2.0,
                                  color: isChecked ? kPrimaryColor : kGrey400),
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
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          const url =
                                              'https://api.shopnownow.app/terms-and-conditions';
                                          if (await canLaunchUrl(
                                              Uri.parse(url))) {
                                            await launchUrl(Uri.parse(url));
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                    ),
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
                            done: (data) =>
                                Consumer(builder: (context, ref, _) {
                                  var buttonWidget = LargeButton(
                                      title: _location == null
                                          ? "Pay ₦ ${((double.parse(subTotalCalculation()) + (double.parse(subTotalCalculation()) * double.parse((double.parse(widget.tax!.replaceAll(".00", "")) / 100).toString())))).toStringAsFixed(2)}"
                                          : (double.parse(
                                                      subTotalCalculation()) >
                                                  widget.band!
                                                      .freeDeliveryThreshold!
                                                      .toDouble())
                                              ? "Pay ₦ ${((double.parse(subTotalCalculation()) + (double.parse(subTotalCalculation()) * double.parse((double.parse(widget.tax!.replaceAll(".00", "")) / 100).toString())))).toStringAsFixed(2)}"
                                              : "Pay ₦ ${((double.parse(subTotalCalculation()) + double.parse(_location!.price!) + (double.parse(subTotalCalculation()) * double.parse((double.parse(widget.tax!.replaceAll(".00", "")) / 100).toString())))).toStringAsFixed(2)}",
                                      onPressed: () {
                                        if (isChecked) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            List<ProductRequest> request = [];
                                            for (var element
                                                in widget.productList) {
                                              setState(() {
                                                request.add(ProductRequest(
                                                    id: element.id!,
                                                    quantity:
                                                        element.quantity!));
                                              });
                                            }
                                            CreateOrderRequest orderRequest =
                                                CreateOrderRequest(
                                              products: request,
                                              scheduledDate:
                                                  dateController.text,
                                              couponCode: couponController.text,
                                              discountApplied: double.parse(
                                                          subTotalCalculation()
                                                              .replaceAll(
                                                                  ".00", "")) <
                                                      totalAmount
                                                  ? 1
                                                  : 0,
                                              userId: 0,
                                              price: (double.parse(
                                                      subTotalCalculation())
                                                  .toInt()),
                                              tax: (double.parse(
                                                          subTotalCalculation()) *
                                                      double.parse(
                                                          (double.parse(widget
                                                                      .tax!
                                                                      .replaceAll(
                                                                          ".00",
                                                                          "")) /
                                                                  100)
                                                              .toString()))
                                                  .toInt(),
                                              status: "pending",
                                              deliveryInfo:
                                                  addressController.text,
                                              paymentType: "card",
                                              recipientName:
                                                  nameController.text,
                                              recipientPhone:
                                                  phoneController.text,
                                              recipientEmail: SessionManager
                                                          .getEmail() !=
                                                      null
                                                  ? SessionManager.getEmail()!
                                                  : emailController.text,
                                              deliveryFee: (double.parse(
                                                          subTotalCalculation()) >
                                                      widget.band!
                                                          .freeDeliveryThreshold!
                                                          .toDouble())
                                                  ? 0
                                                  : int.parse(_location!.price!
                                                      .replaceAll(".00", "")),
                                              deliveryTimeSlot:
                                                  timeSlot!.deliveryTime!,
                                            );
                                            ref
                                                .read(createOrderProvider
                                                    .notifier)
                                                .createOrder(
                                                    orderRequest: orderRequest,
                                                    then: (val) {
                                                      checkOut(
                                                          (double.parse(
                                                                      subTotalCalculation()) >
                                                                  widget.band!
                                                                      .freeDeliveryThreshold!
                                                                      .toDouble())
                                                              ? ((double.parse(subTotalCalculation()) +
                                                                          (double.parse(subTotalCalculation()) *
                                                                              double.parse((double.parse(widget.tax!.replaceAll(".00", "")) / 100)
                                                                                  .toString()))) *
                                                                      100)
                                                                  .toInt()
                                                              : ((double.parse(subTotalCalculation()) +
                                                                          double.parse(_location!
                                                                              .price!) +
                                                                          (double.parse(subTotalCalculation()) *
                                                                              double.parse((double.parse(widget.tax!.replaceAll(".00", "")) / 100).toString()))) *
                                                                      100)
                                                                  .toInt(),
                                                          val["orderId"]);
                                                    });
                                          }
                                        } else {
                                          showErrorBar(context,
                                              "Please accept the terms and conditions");
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
                : Column(
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
                                padding: const EdgeInsets.only(
                                    bottom: kRegularPadding),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: kPrimaryColor,
                                                          shape:
                                                              BoxShape.circle),
                                                )
                                              : YBox(0),
                                        ),
                                        XBox(kSmallPadding),
                                        Text(
                                          pay[index],
                                          style:
                                              textTheme.titleMedium!.copyWith(
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
                            color: kPrimaryColor),
                      ),
                      const Divider(
                        thickness: 2,
                        color: k200,
                      ),
                      YBox(kRegularPadding),
                      Text(
                        "$minOrder₦${widget.band!.minimum}",
                        style: textTheme.headlineMedium!
                            .copyWith(color: kOrange500),
                      ),
                      YBox(kMediumPadding),
                      PaymentRow(
                        text: subTotal,
                        subText: subTotalCalculation().toString(),
                      ),
                      PaymentRow(
                        text: "$tax(${widget.tax?.replaceAll(".00", "")}%)",
                        subText: subTotalCalculation() == "0"
                            ? "0"
                            : (double.parse(subTotalCalculation()) *
                                    double.parse((double.parse(widget.tax!
                                                .replaceAll(".00", "")) /
                                            100)
                                        .toString()))
                                .toStringAsFixed(2),
                      ),
                      PaymentRow(
                        text: delivery,
                        subText: _location == null ? "0" : _location!.price!,
                      ),
                      PaymentRow(
                          text: walletBalance,
                          subText: SessionManager.getWallet() ?? "0"),
                      _location == null
                          ? YBox(0)
                          : PaymentRow(
                              text: total,
                              subText: double.parse(finalAmountToBePaid(
                                      subTotalCalculation()))
                                  .toStringAsFixed(2)),
                      YBox(kMediumPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            activeColor: kPrimaryColor,
                            checkColor: kPrimaryWhite,
                            side: MaterialStateBorderSide.resolveWith(
                              (states) => BorderSide(
                                  width: 2.0,
                                  color: isChecked ? kPrimaryColor : kGrey400),
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
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          const url =
                                              'https://api.shopnownow.app/terms-and-conditions';
                                          if (await canLaunchUrl(
                                              Uri.parse(url))) {
                                            await launchUrl(Uri.parse(url));
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                    ),
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
                            done: (data) =>
                                Consumer(builder: (context, ref, _) {
                                  var buttonWidget = LargeButton(
                                      title: _location == null
                                          ? ""
                                          : "Pay ₦ ${double.parse(finalAmountToBePaid(subTotalCalculation())).toStringAsFixed(2).startsWith("-") ? double.parse(finalAmountToBePaid(subTotalCalculation())).toStringAsFixed(2).substring(1) : double.parse(finalAmountToBePaid(subTotalCalculation())).toStringAsFixed(2)}",
                                      onPressed: () {
                                        if (isChecked) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            List<ProductRequest> request = [];
                                            for (var element
                                                in widget.productList) {
                                              setState(() {
                                                request.add(ProductRequest(
                                                    id: element.id!,
                                                    quantity:
                                                        element.quantity!));
                                              });
                                            }
                                            CreateOrderRequest orderRequest =
                                                CreateOrderRequest(
                                              products: request,
                                              scheduledDate:
                                                  dateController.text,
                                              couponCode: couponController.text,
                                              discountApplied: double.parse(
                                                          subTotalCalculation()) <
                                                      totalAmount.toDouble()
                                                  ? 1
                                                  : 0,
                                              userId:
                                                  SessionManager.getUserId(),
                                              price: double.parse(
                                                      subTotalCalculation())
                                                  .floor(),
                                              tax: (double.parse(
                                                          subTotalCalculation()) *
                                                      double.parse(
                                                          (double.parse(widget
                                                                      .tax!
                                                                      .replaceAll(
                                                                          ".00",
                                                                          "")) /
                                                                  100)
                                                              .toString()))
                                                  .toInt(),
                                              status: "pending",
                                              deliveryInfo:
                                                  addressController.text,
                                              paymentType: currentIndex == 0
                                                  ? "card"
                                                  : "wallet",
                                              recipientName:
                                                  nameController.text,
                                              recipientPhone:
                                                  phoneController.text,
                                              recipientEmail:
                                                  emailController.text.isEmpty
                                                      ? (SessionManager
                                                                  .getEmail() !=
                                                              null
                                                          ? SessionManager
                                                              .getEmail()!
                                                          : '')
                                                      : emailController.text,
                                              deliveryFee: (double.parse(
                                                          subTotalCalculation()) >
                                                      (widget.band!
                                                                  .freeDeliveryThreshold ??
                                                              0)
                                                          .toDouble())
                                                  ? 0
                                                  : int.parse(_location!.price!
                                                      .replaceAll(".00", "")),
                                              deliveryTimeSlot:
                                                  timeSlot!.deliveryTime!,
                                            );
                                            ref
                                                .read(createOrderProvider
                                                    .notifier)
                                                .createOrder(
                                                    orderRequest: orderRequest,
                                                    error: (val) =>
                                                        showErrorBar(
                                                            context, val),
                                                    then: (val) {
                                                      if (double.parse(
                                                              SessionManager
                                                                      .getWallet()!
                                                                  .replaceAll(
                                                                      ".00",
                                                                      "")) >
                                                          double.parse(
                                                              finalAmountToBePaid(
                                                                  subTotalCalculation()))) {
                                                        ProcessPaymentRequest
                                                            paymentRequest =
                                                            ProcessPaymentRequest(
                                                          userId: SessionManager
                                                              .getUserId(),
                                                          amount: finalAmountToBePaid(
                                                                      subTotalCalculation())
                                                                  .startsWith(
                                                                      "-")
                                                              ? double.parse(finalAmountToBePaid(
                                                                          subTotalCalculation())
                                                                      .substring(
                                                                          1))
                                                                  .floor()
                                                                  .toString()
                                                              : double.parse(
                                                                      finalAmountToBePaid(
                                                                          subTotalCalculation()))
                                                                  .floor()
                                                                  .toString(),
                                                          status: "successful",
                                                          orderId:
                                                              val["orderId"],
                                                          reference: "wallet",
                                                          paymentType: "wallet",
                                                          paymentGateway:
                                                              "wallet",
                                                          paymentGatewayReference:
                                                              "wallet",
                                                        );
                                                        ref
                                                            .read(
                                                                processPaymentProvider
                                                                    .notifier)
                                                            .processPayment(
                                                                paymentRequest:
                                                                    paymentRequest,
                                                                then: (val) {
                                                                  pushToAndClearStack(
                                                                      HomePage(
                                                                          message:
                                                                              val));
                                                                });
                                                      } else {
                                                        checkOut(
                                                            (((double.parse(finalAmountToBePaid(subTotalCalculation())) -
                                                                            (double.parse(SessionManager.getWallet()!.replaceAll(".00",
                                                                                ""))))
                                                                        .roundToDouble() *
                                                                    100))
                                                                .toInt(),
                                                            val["orderId"],
                                                            paymentAmount: double.parse(
                                                                    finalAmountToBePaid(
                                                                        subTotalCalculation()))
                                                                .toString());
                                                      }
                                                    });
                                          }
                                        } else {
                                          showErrorBar(context,
                                              "Please accept the terms and conditions");
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

  String subTotalCalculation() {
    double subtotal = 0;
    double discount1 = 0;
    double discount2 = 0;

    if (widget.band!.discountEnabled == 1) {
      discount1 =
          (totalAmount * (int.parse(widget.band!.generalDiscount!) / 100));
    }

    if (totalAmount > int.parse(widget.band!.bulkDiscountAmount ?? "0")) {
      discount2 = (totalAmount *
          (double.parse(widget.band!.bulkDiscountPercentage ?? "0") / 100));
    }

    subtotal = couponAmount > totalAmount
        ? 0
        : totalAmount - (discount1 + discount2 + couponAmount);
    return subtotal == 0 ? "0" : (subtotal).toStringAsFixed(2);
  }

  String finalAmountToBePaid(String subTotalPrice) {
    String amount = "0";
    if (double.parse(subTotalCalculation()) >
        (widget.band!.freeDeliveryThreshold ?? 0).toDouble()) {
      if (double.parse(SessionManager.getWallet()!.replaceAll(".00", "")) >
          double.parse(((double.parse(subTotalPrice) +
                  (double.parse(subTotalPrice) *
                      double.parse(
                          (double.parse(widget.tax!.replaceAll(".00", "")) /
                                  100)
                              .toString()))))
              .toStringAsFixed(2))) {
        // amount = "0";
        amount = (double.parse(subTotalPrice) +
                (double.parse(subTotalPrice) *
                    double.parse(
                        (double.parse(widget.tax!.replaceAll(".00", "")) / 100)
                            .toString())))
            .abs()
            .toStringAsFixed(2);
      } else {
        amount =
            // (double.parse(SessionManager.getWallet()!.replaceAll(".00", "")) -
            (double.parse(subTotalPrice) +
                    (double.parse(subTotalPrice) *
                        double.parse(
                            (double.parse(widget.tax!.replaceAll(".00", "")) /
                                    100)
                                .toString())))
                //)
                .abs()
                .toStringAsFixed(2);
      }
    } else {
      if (double.parse(SessionManager.getWallet()!.replaceAll(".00", "")) >
          double.parse(((double.parse(subTotalPrice) +
                  double.parse(_location!.price!) +
                  (double.parse(subTotalPrice) *
                      double.parse(
                          (double.parse(widget.tax!.replaceAll(".00", "")) /
                                  100)
                              .toString()))))
              .toStringAsFixed(2))) {
        // amount = "0";
        amount = (double.parse(subTotalPrice) +
                double.parse(_location!.price!) +
                (double.parse(subTotalPrice) *
                    double.parse(
                        (double.parse(widget.tax!.replaceAll(".00", "")) / 100)
                            .toString())))
            .abs()
            .toStringAsFixed(2);
      } else {
        amount =
            // (double.parse(SessionManager.getWallet()!.replaceAll(".00", "")) -
            (double.parse(subTotalPrice) +
                    double.parse(_location!.price!) +
                    (double.parse(subTotalPrice) *
                        double.parse(
                            (double.parse(widget.tax!.replaceAll(".00", "")) /
                                    100)
                                .toString())))
                //)
                .abs()
                .toStringAsFixed(2);
      }
    }

    return amount;
  }

  // checkOut(int cost, int checkoutOrderId, {String? paymentAmount}) async {
  //   String email = (emailController.text.isEmpty)
  //       ? (SessionManager.getEmail() != null ? SessionManager.getEmail()! : '')
  //       : emailController.text;

  //   final uniqueTransRef = "${DateTime.now().millisecondsSinceEpoch}";

  //   PayWithPayStack().now(
  //     context: context,
  //     secretKey: "sk_test_7f97db22564ed0d9bc71225f4629c0ee971e2942",
  //     customerEmail: email,
  //     reference: uniqueTransRef,
  //     callbackUrl: "setup in your paystack dashboard",
  //     currency: "NGN",
  //     paymentChannel: ["bank", "card"],
  //     amount: cost.toString(),
  //     transactionCompleted: () {
  //       ProcessPaymentRequest paymentRequest = ProcessPaymentRequest(
  //         userId: SessionManager.getUserId(),
  //         amount: paymentAmount ?? (cost / 100).toString(),
  //         status: "successful",
  //         orderId: checkoutOrderId,
  //         reference: uniqueTransRef,
  //         paymentType: "card",
  //         paymentGateway: "paystack",
  //         paymentGatewayReference: uniqueTransRef,
  //       );

  //       ref.read(processPaymentProvider.notifier).processPayment(
  //           paymentRequest: paymentRequest,
  //           noToken: SessionManager.getToken() == null ? true : false,
  //           then: (val) {
  //             print("Transaction Successful!");
  //             pushToAndClearStack(const HomePage());
  //             showSuccessBar(context, val);
  //           });
  //     },
  //     transactionNotCompleted: () {
  //       print("Transaction Not Successful!");
  //     },
  //   );
  // }

  checkOut(int cost, int checkoutOrderId, {String? paymentAmount}) async {
    String email = (emailController.text.isEmpty)
        ? (SessionManager.getEmail() != null ? SessionManager.getEmail()! : '')
        : emailController.text;

    final uniqueTransRef = "${DateTime.now().millisecondsSinceEpoch}";
    PaystackFlutter().pay(
      context: context,
      secretKey:
          'sk_test_7f97db22564ed0d9bc71225f4629c0ee971e2942', // Your Paystack secret key
      amount: (cost * 100) /
          100, // The amount to be charged in the smallest currency unit
      email: email, // The customer's email address
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
        ProcessPaymentRequest paymentRequest = ProcessPaymentRequest(
          userId: SessionManager.getUserId(),
          amount: (cost / 100).toString(),
          status: "successful",
          orderId: checkoutOrderId,
          reference: uniqueTransRef,
          paymentType: "card",
          paymentGateway: "paystack",
          paymentGatewayReference: uniqueTransRef,
        );

        ref.read(processPaymentProvider.notifier).processPayment(
              paymentRequest: paymentRequest,
              noToken: SessionManager.getToken() == null ? true : false,
              then: (val) {
                print("Transaction Successful!");
                pushToAndClearStack(const HomePage());
                showSuccessBar(context, val);
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
