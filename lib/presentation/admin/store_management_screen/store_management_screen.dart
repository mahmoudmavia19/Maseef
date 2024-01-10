import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/store_card.dart';

import '../../../core/utils/image_constant.dart';
import '../../../widgets/custom_image_view.dart';
import 'controller/store_controller.dart';
import 'model/store.dart';

class StoreManagementScreen extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController discountCodeController = TextEditingController();
  final TextEditingController photoUrlController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(AppStrings.storeManagementTitle),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: ScaffoldBackground(
        child: Obx(
              () => storeController.state.value.getScreenWidget(
                _widget(context),
                () {},
              )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddStoreDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddStoreDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.addStore),
          content: _buildForm(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                await _addStore();
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.add),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditStoreDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppStrings.editStore),
          content: _buildForm(index: index),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.cancel),
            ),
            TextButton(
              onPressed: () async {
                await _editStore(index);
                Navigator.of(context).pop();
              },
              child: Text(AppStrings.saveChanges),
            ),
          ],
        );
      },
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
            await _pickImage();
          },
          child: Text(AppStrings.pickImage),
        ),
       ],
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoUrlController.text = pickedFile.path;
    }
  }

  Future<void> _addStore() async {
    Store newStore = Store(
      id: DateTime.now().toString(),
      name: nameController.text,
      link: linkController.text,
      discountCode: discountCodeController.text,
      photoUrl: photoUrlController.text,
    );
    storeController.addStore(newStore);
    _clearTextControllers();
  }

  Future<void> _editStore(int index) async {
    Store editedStore = storeController.stores[index].copyWith(
      name: nameController.text,
      link: linkController.text,
      discountCode: discountCodeController.text,
      photoUrl: photoUrlController.text,
    );
    storeController.editStore(index, editedStore);
    _clearTextControllers();
  }

  void _clearTextControllers() {
    nameController.clear();
    linkController.clear();
    discountCodeController.clear();
    photoUrlController.clear();
  }

  _widget(BuildContext context) =>
      ListView.builder(
    itemCount: storeController.stores.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () => _showEditStoreDialog(context, index),
        child: StoreCard(
          store: storeController.stores[index],

        ),
      );
    },
  );
}
