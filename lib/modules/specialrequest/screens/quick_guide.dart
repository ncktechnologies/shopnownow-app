import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopnownow/modules/homepage/model/homepage_model.dart';
import 'package:shopnownow/modules/homepage/provider/homepage_provider.dart';
import 'package:shopnownow/modules/reuseables/size_boxes.dart';
import 'package:shopnownow/modules/reuseables/widgets.dart';
import 'package:shopnownow/utils/constants.dart';
import 'package:shopnownow/utils/strings.dart';

class QuickGuide extends ConsumerStatefulWidget {
  const QuickGuide({Key? key}) : super(key: key);

  @override
  ConsumerState<QuickGuide> createState() => _QuickGuideState();
}

class _QuickGuideState extends ConsumerState<QuickGuide> {
  late Timer _t;
  int _currentPage = 0;
   PageController _controller = PageController(
    initialPage: 0,
  );
  List<GetQuickGuide> quickGuide = [];

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void startTicker() {
    _t = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < quickGuide.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(getQuickGuideProvider).data!.forEach((element) {
        setState(() {
          quickGuide.add(element);
        });
      });
    });
    startTicker();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InitialPage(
        noIcon: true,
        noScroll: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kRegularPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YBox(kMacroPadding),
              Text(
                quickGuideCaps,
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
              quickGuide.isEmpty
                  ? Text("No Quick Guide")
                  : Expanded(
                    child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              onPageChanged: _onChanged,
                              controller: _controller,
                              itemCount: quickGuide.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    quickGuide[index]
                                        .imagePath!
                                        .split(".")
                                        .last ==
                                        "svg"
                                        ? SvgPicture.network(
                                      quickGuide[index]
                                          .imagePath!,
                                      height: 150,
                                      width: 150,
                                    )
                                        : Image.network(
                                      quickGuide[index]
                                          .imagePath!,
                                      height: 150,
                                      width: 150,
                                    ),
                                    YBox(70),
                                    Text(quickGuide[index].title ?? "", style: textTheme.bodyMedium!.copyWith(
                                      color: Colors.black,
                                      fontSize: 28,
                                    ),textAlign:  TextAlign.center,),
                                    YBox(kMediumPadding),
                                    Text(quickGuide[index].body ?? "", style: textTheme.titleSmall!.copyWith(
                                      color: Colors.black,
                                      height: 1.5,
                                    ), textAlign: TextAlign.center,),
                                    YBox(kMacroPadding),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for (int i = 0; i < quickGuide.length; i++)
                                          PageIndicator(i, _currentPage, color: Colors.red,)
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),

                        ],
                      ),
                  )
            ],
          ),
        ));
  }
}
