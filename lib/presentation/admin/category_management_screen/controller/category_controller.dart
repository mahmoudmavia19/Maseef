import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/category.dart';

class CategoryController extends GetxController {
   RxList<Category> categories = RxList<Category>();
   final TextEditingController addCategoryNameController = TextEditingController();
   final TextEditingController editCategoryNameController = TextEditingController();

  void addCategory(String name) {
    categories.add(Category(id: DateTime.now().toString(), name: name));
  }

  void editCategory(int index, String newName) {
    categories[index] =categories[index]..name = newName;
  }

  void deleteCategory(Category category) {
    categories.remove(category);
  }
}