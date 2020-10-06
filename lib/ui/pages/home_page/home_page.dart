import 'package:base_project/locator/locator.dart';
import 'package:base_project/ui/components/atoms/up_button.dart';
import 'package:base_project/ui/components/molecules/no_internet_content.dart';
import 'package:base_project/ui/pages/home_page/sections/categories_section.dart';
import 'package:base_project/ui/pages/home_page/sections/header_section.dart';
import 'package:base_project/ui/pages/home_page/sections/new_posts_section.dart';
import 'package:base_project/ui/pages/home_page/sections/promotion_section.dart';
import 'package:base_project/utils/project_theme.dart';
import 'package:base_project/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked/stacked.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    var mainScroll = useScrollController();
    var showUpButton = useState(false);

    void updateButtonState() {
      if (mainScroll.offset >= 400) {
        showUpButton.value = true;
      } else {
        showUpButton.value = false;
      }
    }

    useEffect(() {
      mainScroll.addListener(() => updateButtonState());
      return () => mainScroll.removeListener(() => updateButtonState());
    }, [mainScroll]);

    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: false,
      initialiseSpecialViewModelsOnce: true,
      fireOnModelReadyOnce: true,
      onModelReady: (model) => model.firstLoad(context: context),
      viewModelBuilder: () => locator<HomeViewModel>(),
      builder: (_, model, __) => Scaffold(
          body: (model.isNetworkError)
              ? NoInternetContent(ctaAction: () => model.firstLoad())
              : Stack(
                  children: <Widget>[
                    RefreshIndicator(
                      onRefresh: () => model.firstLoad(),
                      child: CustomScrollView(
                        controller: mainScroll,
                        key: PageStorageKey("home-key"),
                        slivers: <Widget>[
                          Header(),
                          PromotionsSection(),
                          CategoriesSection(),
                          NewPostsSection(),
                          SliverPadding(padding: EdgeInsets.only(top: Gap.xxl))
                        ],
                      ),
                    ),
                    if (showUpButton.value)
                      Positioned(
                        bottom: AppBar().preferredSize.height + Gap.l,
                        right: Gap.m,
                        child: UpButton(
                          onTap: () {
                            mainScroll.animateTo(
                              0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      )
                  ],
                )),
    );
  }
}
