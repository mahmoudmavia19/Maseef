import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/store_card.dart';
import 'package:maseef_app/widgets/store_request_card.dart';
import 'controller/store_controller.dart';
import 'model/store.dart';

class StoreManagementScreen extends StatelessWidget {
  final StoreController storeController = Get.put(StoreController());



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
        child: _widget(context)
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
    return Form(
      key: storeController.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: storeController.nameController,
            decoration: InputDecoration(labelText: AppStrings.storeNameLabel),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            }
          ),
          TextFormField(
            controller:  storeController.linkController,
            decoration: InputDecoration(labelText: AppStrings.storeLinkLabel),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a link';
              }
              return null;
            },
          ),
          TextFormField(
            controller:  storeController.discountCodeController,
            decoration: InputDecoration(labelText: AppStrings.discountCodeLabel),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a discount code';
              }
              return null;
            }
          ),
          ElevatedButton(
            onPressed: ()   {
               storeController.getImage();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppStrings.pickImage),
                SizedBox(width: 5.0,),
                Obx(()=>Visibility(
                  visible: storeController.imageFile.value != null,
                    child: Icon(Icons.check_circle_outline,color: Colors.white,)))
              ],
            ),
          ),
         ],
      ),
    );
  }

  Future<void> _addStore() async {
    storeController.addStore();
   // _clearTextControllers();
  }

  Future<void> _editStore(int index) async {
   /* Store editedStore = storeController.stores[index].copyWith(
      name: nameController.text,
      link: linkController.text,
      discountCode: discountCodeController.text,
      photoUrl: photoUrlController.text,
    );
    storeController.editStore(index, editedStore);
    _clearTextControllers();*/
  }

  void _clearTextControllers() {
    storeController.nameController.clear();
    storeController.linkController.clear();
    storeController.discountCodeController.clear();
    storeController.photoUrlController.clear();
  }

  _widget(BuildContext context) =>DefaultTabController(
      length: 2,
      child:Column(
        children: [
          TabBar(
            labelColor: ColorConstant.primary,
              indicatorColor: ColorConstant.primary,
              tabs: [
                Tab(
                    child: Text(
                      AppStrings.requests,
                    )
                ),
                Tab(
                    child: Text(
                      AppStrings.stores,
                    )
                ),
              ]
          ),
          Expanded(
            child: TabBarView(
                children: [
                  tab1(),
                  tab2(),
                ]
            ),
          ),
        ],
      )
  );
  tab1() => Obx(
          () => storeController.state.value.getScreenWidget(
        RefreshIndicator(
          onRefresh: () {
            storeController.getStores();
            return Future.value(true);
          },
          child:  ListView.builder(
            itemCount: storeController.storesRequests.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => _showEditStoreDialog(context, index),
                child: StoreRequestCard(
                  store: storeController.storesRequests[index],
                  onAccept: () {
                    showConfirmationDialog((){
                      storeController.storesRequests[index].accepted = true;
                      storeController.editStore(index,storeController.storesRequests[index]);
                    },'Are you want accept this store?', 'Alert');
                  },
                  onReject: () {
                    showConfirmationDialog((){
                      storeController.storesRequests[index].accepted = false;
                      storeController.editStore(index,storeController.storesRequests[index]);
                    },'Are you want reject this store ?', 'Alert');
                  },
                ),
              );
            },
          ),
        ) ,
            () {},));
  tab2() =>Obx(
        () => storeController.state.value.getScreenWidget(
          RefreshIndicator(
            onRefresh: () {
              storeController.getStores();
              return Future.value(true);
            },
            child: ListView.builder(
              itemCount: storeController.stores.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => _showEditStoreDialog(context, index),
                  child: StoreCard(
                    store: storeController.stores[index],
                  ),
                );
              },
            ),
          ) ,
      () {},));

}
