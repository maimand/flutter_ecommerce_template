import 'package:ecommerce_int2/data/models/category.model.dart';
import 'package:ecommerce_int2/data/repository/category.repository.dart';
import 'package:ecommerce_int2/screens/category/sub_category_list_page.dart';
import 'package:ecommerce_int2/screens/search_products/search_page.dart';
import 'package:ecommerce_int2/utils/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final CategoryRepository repository;

  CategoryController(this.repository);

  CategoryList categoryList = CategoryList();

  TextEditingController searchController = TextEditingController();

  List<Category> get list => categoryList.data ?? [];

  List<Category> tempList = [];

  @override
  void onInit() {
    // getCategoryList();
    super.onInit();
  }

  @override
  void onReady() {
    getCategoryList();
    super.onReady();
  }

  void getCategoryList() async {
    MessageDialog.showLoading();
    try {
      final value = await repository.getAllCategories();
      categoryList = value;
      final temp = CategoryList.fromJson(value.toJson());
      tempList = temp.data!;
      update();
    } on Exception catch (e) {
      print(e);
    } finally {
      MessageDialog.hideLoading();
    }
  }

  void onTap(Category category) {
    if (category.subcategories == null || category.subcategories!.isEmpty) {
      Get.to(() => SearchPage(subCategory: category.name!.toLowerCase()));
    } else {
      Get.to(() => SubCategoryListPage(category: category));
    }
  }

  void onChanged(String value) {
    if (value.isNotEmpty) {
      tempList.clear();
      list.forEach((category) {
        if (category.name!.toLowerCase().contains(value)) {
          tempList.add(category);
        }
      });
    } else {
      tempList.clear();
      tempList.addAll(list);
    }
    update();
  }
}
