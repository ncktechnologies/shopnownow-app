import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/modules/specialrequest/provider/special_provider.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class SpecialRequest extends StatefulWidget {
  const SpecialRequest({Key? key}) : super(key: key);

  @override
  State<SpecialRequest> createState() => _SpecialRequestState();
}

class _SpecialRequestState extends State<SpecialRequest> {
  TextEditingController requestController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YBox(kMacroPadding),
            Text(
              specialRequestCaps,
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
            YBox(kMicroPadding),
            TextInputNoIcon(
              text: request,
              controller: requestController,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else {
                  return null;
                }
              },
            ),
            TextInputNoIcon(
              text: comment,
              maxLine: 8,
              controller: commentController,
              validator: (val) {
                if (val!.isEmpty) {
                  return emptyField;
                } else {
                  return null;
                }
              },
            ),
            YBox(80),
            Consumer(builder: (context, ref, _) {
              var widget = LargeButton(
                  title: submitRequest,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref.read(specialRequestProvider.notifier).specialRequest(
                          request: requestController.text,
                          comment: commentController.text,
                          then: (val) => showSuccessBar(context, val),
                          error: (val) => showErrorBar(context, val));
                    }
                  });
              return ref.watch(specialRequestProvider).when(
                    done: (data) => widget,
                    loading: () => const SpinKitDemo(),
                    error: (val) => widget,
                  );
            })
          ],
        ),
      ),
    ));
  }
}
