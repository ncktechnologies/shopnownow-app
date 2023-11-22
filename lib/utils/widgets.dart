// import 'package:flutter/material.dart';
//
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopnownow/utils/constants.dart';

class SpinKitDemo extends StatelessWidget {
  final double? size;
  final Color? color;

  const SpinKitDemo({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingFour(
      color: color ?? kPrimaryColor,
      size: size ?? 35,
    );
  }
}
//
// class GlobalErrorWidget extends StatelessWidget {
//   const GlobalErrorWidget({Key? key, required this.onTap, this.message})
//       : super(key: key);
//
//   final Function() onTap;
//   final String? message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(kLargePadding),
//       child: Column(
//         children: [
//           Text(
//             message ?? "An error Occurred. Please refresh this page",
//             style: TextStyle(
//               color: Colors.red,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           YBox(kRegularPadding),
//           InkWellNoShadow(
//               onTap: onTap,
//               child: Icon(
//                 Icons.refresh,
//                 color: Colors.red,
//               ))
//         ],
//       ),
//     );
//   }
// }
