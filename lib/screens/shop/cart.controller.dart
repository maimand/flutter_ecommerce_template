import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/data/models/cart.model.dart';
import 'package:ecommerce_int2/data/models/product.model.dart';
import 'package:ecommerce_int2/data/repository/cart.repository.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/utils/message_dialog.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepository repository;

  final SwiperController swiperController = SwiperController();

  CartController(this.repository);

  bool isLoadingCart = false;

  List<Product> get products {
    if (carts == null) return [];
    List<Product> products = [];
    for (CartModel cart in carts!) {
      products.addAll(cart.products!);
    }
    return products;
  }

  List<CartModel>? carts;

  @override
  onInit() {
    super.onInit();
  }

  String get total {
    int result = 0;
    products.forEach((element) {
      result += element.price ?? element.purchasePrice ?? 0;
    });
    return '$result VND';
  }

  Future<void> getCart() async {
    isLoadingCart = true;
    update();
    repository.getCarts().then((value) {
      carts = value;
      isLoadingCart = false;
      update();
    });
  }

  void remove(Product product) {
    CartModel? cart = carts!
        .firstWhereOrNull((element) => element.products!.contains(product));
    if (cart == null) {
      MessageDialog.showToast("There is something wrong!!");
      return;
    }
    repository.deleteProduct(cart.sId!, product.sId!);
    cart.products!.remove(product);
    update();
  }

  void addProduct(Product product, {int? quantity}) async {
    try {
      AddProductParam param = AddProductParam(products: [
        ProductParam(
            product: product.sId,
            price: product.price,
            merchant: product.merchant,
            quantity: quantity)
      ]);
      final String cartId = await repository.addProduct(param);
      MessageDialog.showToast("Added product to cart");
      int index = carts!.indexWhere((element) => element.sId == cartId);
      if (index != -1) {
        carts![index].products!.add(product);
      } else {
        carts!.add(CartModel(sId: cartId, products: [product]));
      }
      update();
    } on Exception catch (e) {
      print(e);
    }
  }

  void checkOut() async {
    MessageDialog.showLoading();
    final List<String> orderIds = await repository.checkOutCart(carts!);
    MessageDialog.hideLoading();
    Get.to(() => AddAddressPage(), arguments: orderIds);
  }
}
