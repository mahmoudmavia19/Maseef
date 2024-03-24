import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/presentation/visitor/visitor_discount_screen/controller/discount_controller.dart';
import 'package:maseef_app/widgets/user_store_card.dart';
import '../../../core/utils/app_strings.dart';
import '../../../widgets/scaffold_background.dart';
import '../../../widgets/search_form.dart';

class GuestDiscountScreen  extends GetWidget<DiscountController>{

   final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController discountCodeController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
          opacity: 0.9,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: [
                  SearchForm(),
                  SizedBox(height: 20.0,),
                Obx(() => controller.state.value.getScreenWidget(_body(), (){}))
                ]
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddStoreDialog,
        child: Icon(Icons.add),
      ) ,
    );
  }
_body()=>  ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder:(context, index) {
      var store = controller.stores[index];
      return UserStoreRequestCard(store: store,);
    },
    separatorBuilder: (context, index) => SizedBox(height: 20.0,),
    itemCount: controller.stores.length,);
  Widget _buildForm({int? index}) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(labelText: AppStrings.storeNameLabel),
          ),
          TextFormField(
            controller: linkController,
            decoration: InputDecoration(labelText: AppStrings.storeLinkLabel),
          ),
          TextFormField(
            controller: discountCodeController,
            decoration: InputDecoration(labelText: AppStrings.discountCodeLabel),
          ),
          SizedBox(height: 20.0,),
          Obx(() => controller.image.value != null ? Image.file(controller.image.value!,height: 150,) : SizedBox()),
          ElevatedButton(
            onPressed: () async {
              await controller.pickImage();
            },
            child: Text(AppStrings.pickImage),
          ),
        ],
      ),
    );
  }
  Future<void> _showAddStoreDialog() async {
    return Get.dialog(AlertDialog(
          title: Text(AppStrings.addStore),
          content: _buildForm(),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
              controller.addStore(Store(
                name: nameController.text,
                link: linkController.text,
                discountCode: discountCodeController.text,
                photoUrl: photoUrlController.text
              ));
              },
              child: Text(AppStrings.add),
            ),
          ],
        ) );
  }
}
