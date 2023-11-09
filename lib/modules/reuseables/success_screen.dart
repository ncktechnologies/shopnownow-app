import 'package:flutter/material.dart';

// class SuccessfulScreen extends StatelessWidget {
//   final String text;
//   final String subText;
//   final String buttonText;
//   final Function() onTap;
//
//   const SuccessfulScreen({
//     Key? key,
//     required this.text,
//     required this.subText,
//     required this.buttonText,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: kMicroPadding, vertical: kRegularPadding),
//         child: Column(
//           children: [
//             YBox(kSupremePadding),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   height: kSupremePadding,
//                   width: kSupremePadding,
//                   decoration: const BoxDecoration(
//                       shape: BoxShape.circle, color: kSuccess),
//                   child: const Icon(
//                     Icons.check,
//                     color: kPrimaryWhite,
//                     size: 40,
//                   ),
//                 ),
//                 YBox(kMediumPadding),
//                 Text(
//                   text,
//                   textAlign: TextAlign.center,
//                   style: textTheme.displayLarge!.copyWith(
//                     color: Colors.black,
//                     fontSize: 22,
//                   ),
//                 ),
//                 YBox(kSmallPadding),
//                 Text(subText,
//                     textAlign: TextAlign.center, style: textTheme.titleMedium),
//               ],
//             ),
//             const Spacer(),
//             LargeButton(
//                 title: buttonText,
//                 onPressed: onTap)
//           ],
//         ),
//       ),
//     );
//   }
// }
