import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/widgets/custom_app_bar.dart';

import 'controller/category_controller.dart';

class CategoryManagementScreen extends GetWidget<CategoryController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

      ),
      appBar: customAppBar(AppStrings.categoryManagement),
      body: Obx(() => ListView.builder(
          itemCount: controller.categories.length,
          itemBuilder: (context, index) {
             return _categoryCard(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(),
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ),
    );
  }
  
  _categoryCard(int index) {
    return Card(
      child: ListTile(
        iconColor: ColorConstant.primaryMaterialColor,
        title: Text(controller.categories[index].name,style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold
         ),),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editCategory(index),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => controller.deleteCategory(controller.categories[index]),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showAddCategoryDialog() {
    Get.dialog(AlertDialog(
      title: Text('Add Category'),
      content: TextField(
        controller: controller.addCategoryNameController,
        decoration: InputDecoration(labelText: 'Category Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            controller.addCategory(controller.addCategoryNameController.text);
            Get.back();
            controller.addCategoryNameController.clear();
          },
          child: Text('Add'),
        ),
      ],
    ));
  }
  void _editCategory(int index) {
    Get.dialog(AlertDialog(
      title: Text('Edit Category'),
      content: TextField(
        controller: controller.editCategoryNameController..text = controller.categories[index].name,
        decoration: InputDecoration(labelText: 'Category Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            controller.editCategory(index, controller.editCategoryNameController.text);
            Get.back();
            controller.editCategoryNameController.clear();
          },
          child: Text('Save'),
        ),
      ],
    ));
  }
}
