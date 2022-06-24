import 'package:ecommerce_int2/data/models/order.model.dart';
import 'package:ecommerce_int2/data/provider/merchant.provider.dart';
import 'package:ecommerce_int2/services/network.service.dart';
import 'package:get_storage/get_storage.dart';

class OrderProvider {
  final NetWorkService networkService;

  final GetStorage storage = GetStorage();

  OrderProvider(this.networkService);

  final String orderUrl = '$domain/order';

  final String completeOrderUrl =
      '$domain/order/';

  final String checkOutCartUrl =
      '$domain/proceed';

  final String cancleOrderUrl =
      '$domain/order';

  final String confirmReceivedUrl =
      '$domain/order';

  Future<HttpResponse> getAllOrders() {
    return networkService.get(orderUrl);
  }

  Future<HttpResponse> completeOrder(String orderId, CompleteOrderParam param) {
    return networkService.put('$completeOrderUrl/$orderId/',
        data: param.toJson());
  }

  Future<HttpResponse> makePayment(String orderId) {
    return networkService.post('$completeOrderUrl/$orderId/pay');
  }

  Future<HttpResponse> cancleOrder(String orderId) {
    return networkService.put('$confirmReceivedUrl/$orderId/status',
        data: {"status": "CANCEL"});
  }

  Future<HttpResponse> cancleCart(String orderId) {
    return networkService.delete('$cancleOrderUrl/$orderId/cancel');
  }

  Future<HttpResponse> getOrderDetail(String orderId) {
    return networkService.get('$orderUrl/$orderId');
  }

  Future<HttpResponse> confirmReceived(String orderId) {
    return networkService.put('$confirmReceivedUrl/$orderId/status',
        data: {"status": "RECEIVED"});
  }

  Future<HttpResponse> payOrder(String orderId) {
    return networkService.put('$confirmReceivedUrl/$orderId/status',
        data: {"paymentStatus": "PAID"});
  }
}
