import 'package:base_project/network/api/shopping_cart_api.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingCartRepository {
  final ShoppingCartApi _api = ShoppingCartApi();
  final BehaviorSubject<int> _countController = BehaviorSubject<int>();

  ShoppingCartRepository() {
    _countController.add(0);
  }

  void setCartCount(int val) {
    _countController.sink.add(val);
  }

  Stream<int> get cartCount => _countController.stream;
}
