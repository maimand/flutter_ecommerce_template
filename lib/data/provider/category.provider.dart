import 'package:ecommerce_int2/data/provider/merchant.provider.dart';
import 'package:ecommerce_int2/services/network.service.dart';
import 'package:get_storage/get_storage.dart';

class CategoryProvider {
  final NetWorkService networkService;

  final GetStorage storage = GetStorage();

  CategoryProvider(this.networkService);

  final String getAllCaegories =
      '$domain/category';

  Future<HttpResponse> getCategories() {
    return networkService.get(getAllCaegories);
  }
}
