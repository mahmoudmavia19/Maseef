import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_app_bar.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'controller/category_controller.dart';

class CategoryManagementScreen extends GetWidget<CategoryController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:MainDrawer(),
      appBar: customAppBar(AppStrings.categoryManagement),
      body: Obx(() => ScaffoldBackground(
        child: controller.getState.getScreenWidget(_widget(), () {})
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(),
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ),
    );
  }


  _widget() {
    return  ListView.builder(
      itemCount: controller.categories.length,
      itemBuilder: (context, index) {
        return _categoryCard(index);
      },
    );
  }
  _categoryCard(int index) {
    return Card(
      color: Colors.transparent,
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
              icon: Icon(Icons.edit,color: ColorConstant.primaryMaterialColor,),
              onPressed: () => _editCategory(index),
            ),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.red,),
              onPressed: () =>  showConfirmationDialog((){
                controller.deleteCategory(controller.categories[index]) ;
              }, AppStrings.sureDelete, 'Alert'),
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
