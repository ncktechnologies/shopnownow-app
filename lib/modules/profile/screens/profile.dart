import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:shopnownow/utils/text_field_comp.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return InitialPage(
        loggedIn: true,
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
              TextInputNoIcon(
                text: fullName,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.person,
                  fit: BoxFit.scaleDown,
                ),
                // controller: emailController,
              ),
              TextInputNoIcon(
                text: emailAddress,
                read: true,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.email,
                  fit: BoxFit.scaleDown,
                ),
                // controller: emailController,
              ),

              TextInputNoIcon(
                text: phoneNo,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.person,
                  fit: BoxFit.scaleDown,
                ),
                // controller: emailController,
              ),
              YBox(kSmallPadding),
              LargeButton(title: saveChanges, onPressed: (){}, disable: false,),
              YBox(kFullPadding),
              Text(
                updatePass,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              YBox(kMicroPadding),
              TextInputNoIcon(
                text: currentPass,
                hintText: enterPassword,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.lock,
                  fit: BoxFit.scaleDown,
                ),
                // controller: emailController,
              ),

              TextInputNoIcon(
                text: newPass,
                hintText: enterNewPass,
                prefixIcon: SvgPicture.asset(
                  AssetPaths.lock,
                  fit: BoxFit.scaleDown,
                ),
                // controller: emailController,
              ),
              YBox(kSmallPadding),
              LargeButton(title: updatePass, onPressed: (){}, disable: false,),
              YBox(kRegularPadding),

            ],
          ),
        ));
  }
}
