import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/widgets/user_store_card.dart';
import '../../../core/utils/app_strings.dart';
import '../../../widgets/scaffold_background.dart';
import '../../../widgets/search_form.dart';

class GuestDiscountScreen  extends StatelessWidget {

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
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:(context, index) => UserStoreRequestCard(store: Store(id: 'id', name: 'Roman Cafe',
                          link: 'link', discountCode: '20%', photoUrl:'assets/images/Group.png'),),
                      separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                      itemCount: 3)
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

  Widget _buildForm({int? index}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(labelText: AppStrings.storeNameLabel),
        ),
        TextField(
          controller: linkController,
          decoration: InputDecoration(labelText: AppStrings.storeLinkLabel),
        ),
        TextField(
          controller: discountCodeController,
          decoration: InputDecoration(labelText: AppStrings.discountCodeLabel),
        ),
        ElevatedButton(
          onPressed: () async {

          },
          child: Text(AppStrings.pickImage),
        ),
      ],
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
                Get.back();
              },
              child: Text(AppStrings.add),
            ),
          ],
        ) );
  }
}
