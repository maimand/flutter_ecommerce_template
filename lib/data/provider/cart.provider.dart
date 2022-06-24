import 'package:ecommerce_int2/data/models/product.model.dart';
import 'package:ecommerce_int2/data/provider/merchant.provider.dart';
import 'package:ecommerce_int2/services/network.service.dart';
import 'package:get_storage/get_storage.dart';

class CartProvider {
  final NetWorkService networkService;

  final GetStorage storage = GetStorage();

  CartProvider(this.networkService);

  final String getAllCartUrl =
      '$domain/cart';

  final String addProductToCartUrl =
      '$domain/cart/add';

  final String modifyProductToCartUrl =
      '$domain/cart/modify';

  final String deleteProductFromCartUrl =
      '$domain/cart/delete';

  final String checkOutCartUrl =
      '$domain/order/proceed';

  Future<HttpResponse> getCarts() {
    return networkService.get(getAllCartUrl);
  }

  Future<HttpResponse> addProduct(AddProductParam param) {
    return networkService.post(addProductToCartUrl, data: param.toJson());
  }

  Future<HttpResponse> modifyProduct(
      String cartId, String productId, int before, int after) {
    return networkService.put('$addProductToCartUrl/$cartId/$productId',
        data: {"previousQuantity": before, "currentQuantity": after});
  }

  Future<HttpResponse> deleteProduct(String cartId, String productId) {
    return networkService
        .delete('$deleteProductFromCartUrl/$cartId/$productId');
  }

  Future<HttpResponse> checkoutCart(String cartId, String merchant) {
    return networkService
        .post(checkOutCartUrl, data: {"cart": cartId, "merchant": merchant});
  }

  Future<HttpResponse> cancleOrder(String orderId) {
    return networkService.delete('$domain/order/$orderId/cancel');
  }
}
