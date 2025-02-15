import 'package:ecommerce_int2/data/models/address.model.dart';
import 'package:ecommerce_int2/data/provider/merchant.provider.dart';
import 'package:ecommerce_int2/services/network.service.dart';
import 'package:get_storage/get_storage.dart';

class AddressProvider {
  final NetWorkService networkService;

  final GetStorage storage = GetStorage();

  AddressProvider(this.networkService);

  final String getAddressUrl =
      '$domain/address';
  final String addAddressUrl =
      '$domain/address/add';


  Future<HttpResponse> getAllAddress() {
    return networkService
        .get(getAddressUrl);
  }

  Future<HttpResponse> addAddress(
      Address address) {
    return networkService.post(addAddressUrl, data: address.toJson());
  }

  Future<HttpResponse> updateAddress(
      Address address) {
    return networkService.post('$addAddressUrl/${address.id}', data: address.toJson());
  }
}
