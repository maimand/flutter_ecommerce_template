import 'package:ecommerce_int2/services/network.service.dart';
import 'package:get_storage/get_storage.dart';

const String domain = 'https://ecommerce-api-dut.herokuapp.com/api';

class MerchantProvider {
  final NetWorkService networkService;

  final GetStorage storage = GetStorage();

  MerchantProvider(this.networkService);

  final String getMerchantInfoUrl =
      '$domain/merchant';

  Future<HttpResponse> getMerchantInfo(
      String keyword) {
    return networkService.get("$getMerchantInfoUrl/$keyword/all");
  }


}
