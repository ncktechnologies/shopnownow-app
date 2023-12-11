import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/profile/provider/profile_provider.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/flushbar.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';
import 'package:shopnownow/utils/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController(
    text: SessionManager.getEmail()
  );
  TextEditingController nameController = TextEditingController(
    text: SessionManager.getFullName()
  );
  TextEditingController phoneController = TextEditingController(
    text: SessionManager.getPhone()
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        noIcon: true,
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YBox(kMacroPadding),
          Text(
            profile,
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
          YBox(kSmallPadding),
          Text(
            profileSetting,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kMicroPadding),
          Form(
            key: _formKey2,
              child: Column(
            children: [
              TextInputNoIcon(
                text: fullName,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.person,
                  fit: BoxFit.scaleDown,
                ),
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
                text: emailAddress,
                read: true,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.email,
                  fit: BoxFit.scaleDown,
                ),
                controller: emailController,
              ),
              TextInputNoIcon(
                text: phoneNo,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.person,
                  fit: BoxFit.scaleDown,
                ),
                controller: phoneController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              YBox(kSmallPadding),
              Consumer(builder: (context, ref, _) {
                var widget = LargeButton(
                  title: saveChanges,
                  onPressed: () {
                    if (_formKey2.currentState!.validate()) {
                      ref
                          .read(updateProfileProvider.notifier)
                          .updateProfile(
                          name: nameController.text,
                          phone: phoneController.text,
                          then: () => showSuccessBar(context, "User updated successfully"),
                          error: (val) => showErrorBar(context, val));
                    }
                  },
                  // disable: false,
                );
                return ref.watch(updateProfileProvider).when(
                    done: (data) => widget,
                    loading: () => const SpinKitDemo(),
                    error: (val) => widget);
              }),
            ],
          )),

          YBox(kFullPadding),
          Text(
            updatePass,
            style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          YBox(kMicroPadding),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextInputNoIcon(
                  text: currentPass,
                  hintText: enterPassword,
                  controller: currentPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return emptyField;
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: SvgPicture.asset(
                    AssetPaths.lock,
                    fit: BoxFit.scaleDown,
                  ),
                  // controller: emailController,
                ),
                TextInputNoIcon(
                  text: newPass,
                  hintText: enterNewPass,
                  controller: newPasswordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return emptyField;
                    } else {
                      return null;
                    }
                  },
                  prefixIcon: SvgPicture.asset(
                    AssetPaths.lock,
                    fit: BoxFit.scaleDown,
                  ),
                  // controller: emailController,
                ),
                YBox(kSmallPadding),
                Consumer(builder: (context, ref, _) {
                  var widget = LargeButton(
                    title: updatePass,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(updatePasswordProvider.notifier)
                            .updatePassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text,
                                then: (val) => showSuccessBar(context, val),
                                error: (val) => showErrorBar(context, val));
                      }
                    },
                    // disable: false,
                  );
                  return ref.watch(updatePasswordProvider).when(
                      done: (data) => widget,
                      loading: () => const SpinKitDemo(),
                      error: (val) => widget);
                }),
                YBox(kRegularPadding),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
