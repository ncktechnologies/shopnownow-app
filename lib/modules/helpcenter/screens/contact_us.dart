import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/app/helpers/session_manager.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/assets_path.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


InAppBrowser browser = InAppBrowser();

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

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
            contactUs,
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
          Row(
            children: [
              Text(
                home,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "  /  ",
                style: textTheme.bodyLarge!
                    .copyWith(fontSize: 14, color: kGrey200),
              ),
              Text(
                helpCenter,
                style: textTheme.displayLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              Text(
                "  /  $contactUs",
                style: textTheme.bodyLarge!
                    .copyWith(fontSize: 14, color: kGrey200),
              ),
            ],
          ),
          YBox(kMacroPadding),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kRegularPadding, vertical: kMediumPadding),
            margin: const EdgeInsets.only(bottom: kRegularPadding),
            decoration: BoxDecoration(
                border: Border.all(color: kLightAsh100, width: 1),
                borderRadius: kBorderRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContactWidget(
                  icon: AssetPaths.email,
                  text: SessionManager.getContactEmail()!.split("Email@").last,
                  onTap: () {
                    openEmail();
                  },
                ),
                ContactWidget(
                    icon: AssetPaths.whatsappLogo,
                    text: SessionManager.getContactPhone()!.split("@").last,
                    onTap: () {
                      openWhatsApp();
                    }),
                ContactWidget(
                    icon: AssetPaths.liveChat,
                    text: "Live Chat",
                    onTap: () {
                      startLiveChat();
                    })
              ],
            ),
          ),
          YBox(kMacroPadding),
          // const OrWidget(color: kLightAsh400),
          // YBox(kMacroPadding),
          //
          // TextInputNoIcon(
          //   text: subject,
          // ),
          // TextInputNoIcon(
          //   text: message,
          //   maxLine: 8,
          // ),
          // YBox(80),
          // LargeButton(title: submit, onPressed: (){}),
          // YBox(kRegularPadding),
        ],
      ),
    ));
  }
}

Future<void> startLiveChat() async {
  await browser.openUrlRequest(
    urlRequest: URLRequest(
        url: Uri.parse(
            "https://tawk.to/chat/658d73a470c9f2407f840733/1hio8netc")),
    options: InAppBrowserClassOptions(
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
      ),
    ),
  );
}

void openWhatsApp() async {
  String whatsappUrl =
      "https://wa.me/${SessionManager.getContactPhone()!.split("@").last}"; // Replace with the actual phone number
  if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
    await launchUrl(Uri.parse(whatsappUrl));
  } else {}
}

void openEmail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: SessionManager.getContactPhone()!.split("@").last,
    );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {}
}

class ContactWidget extends StatelessWidget {
  final String text, icon;
  final Function()? onTap;

  const ContactWidget({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellNoShadow(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(kRegularPadding),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kLightRed100,
            ),
            child: SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              height: 24,
              width: 24,
            ),
          ),
          Text(
            text,
            style: textTheme.displayLarge!.copyWith(
              color: kDark400,
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
