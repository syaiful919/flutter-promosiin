import 'dart:async';

import 'package:base_project/locator/locator.dart';
import 'package:base_project/repository/shopping_cart_repository.dart';
import 'package:base_project/service/connectivity/connectivity_service.dart';
import 'package:base_project/service/connectivity/connectivity_status.dart';
import 'package:base_project/service/navigation/navigation_service.dart';
import 'package:base_project/service/navigation/router.gr.dart';
import 'package:base_project/utils/stream_key.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class MultipleStreamSampleViewModel extends MultipleStreamViewModel {
  final _navigationService = locator<NavigationService>();
  final _connectivityService = locator<ConnectivityService>();

  final _shoppingCartRepository = locator<ShoppingCartRepository>();

  BuildContext pageContext;

  int get cartCount => dataMap[StreamKey.cartCount];

  Future<void> firstLoad({BuildContext context}) async {
    if (pageContext == null && context != null) pageContext = context;
  }

  void goBack() => _navigationService.pop();

  void goToNoInternetPage() =>
      _navigationService.pushToNoInternetPage(Routes.multipleStreamSamplePage);

  @override
  Map<String, StreamData> get streamsMap => {
        StreamKey.cartCount: StreamData<int>(_shoppingCartRepository.cartCount),
        StreamKey.connectivity:
            StreamData<ConnectivityStatus>(_connectivityService.status),
      };

  @override
  void onData(String key, data) {
    super.onData(key, data);
    if (key == StreamKey.connectivity) {
      if (data == ConnectivityStatus.Offline) goToNoInternetPage();
    }
  }

  void increment() => _shoppingCartRepository.setCartCount(cartCount + 1);
  void decrement() => _shoppingCartRepository.setCartCount(cartCount - 1);
}
