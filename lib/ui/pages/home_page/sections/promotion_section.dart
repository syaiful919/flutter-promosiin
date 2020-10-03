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
                          color: ProjectColor.main.withOpacity(0.5),
                        ),
                        child: Text(
                          model.promotions[index].name,
                          style: TypoStyle.caption500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
