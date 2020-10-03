import 'dart:math';

import 'package:base_project/ui/components/atoms/shimmer_placeholder.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class PromotionsSection extends HookViewModelWidget<HomeViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var currentIndex = useState(0);
    return SliverToBoxAdapter(
      child: (model.promotions == null)
          ? ShimmerPlaceholder.block(itemHeight: 150)
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  CarouselSlider.builder(
                    options: CarouselOptions(
                      onPageChanged: (index, _) {
                        currentIndex.value = index;
                      },
                      enlargeCenterPage: true,
                      aspectRatio: 18 / 9,
                      enableInfiniteScroll: true,
                    ),
                    itemCount: model.promotions.length,
                    itemBuilder: (_, index) => Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: ProjectColor.main, width: 0.5),
                        borderRadius: BorderRadius.circular(RadiusSize.l),
                        image: DecorationImage(
                          image:
                              NetworkImage(model.promotions[index].bannerPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.only(bottom: Gap.s, right: Gap.s),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Gap.s, vertical: Gap.xxs),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(RadiusSize.m),
                          color: ProjectColor.main.withOpacity(0.75),
                        ),
                        child: Text(
                          model.promotions[index].name,
                          style: TypoStyle.small500,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Gap.s,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buildDots(
                            currentIndex.value + 0.0, model.promotions.length),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

List<Widget> buildDots(double currentIndex, int length) {
  Widget buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((currentIndex ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (1.5 - 1.0) * selectedness;
    return Container(
      width: 15,
      child: Center(
        child: Material(
          color: (currentIndex >= index - 0.2 && currentIndex <= index + 0.2)
              ? ProjectColor.grey1
              : ProjectColor.grey1.withOpacity(0.5),
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  List<Widget> dots = List<Widget>.generate(length, buildDot);

  return dots;
}
