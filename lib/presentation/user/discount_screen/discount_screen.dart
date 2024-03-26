import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
 import 'package:maseef_app/presentation/visitor/visitor_discount_screen/controller/discount_controller.dart';
import 'package:maseef_app/widgets/search_store_form.dart';
 import 'package:maseef_app/widgets/user_store_card.dart';
import '../../../widgets/scaffold_background.dart';

class DiscountScreen  extends GetWidget<DiscountController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
          opacity: 0.9,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: [
                  SearchStoreForm(controller:controller.searchStoreController,items: [],onSearchTextChanged: (p0) {
                    controller.search();
                  },),
                  SizedBox(height: 20.0,),
                  Obx(() => Visibility(
                      visible:controller.storesSearch.length == 0,
                      child: controller.state.value.getScreenWidget(_body(controller.stores), (){}))),
                  Obx(() => Visibility(
                      visible:controller.storesSearch.length != 0,
                      child: controller.state.value.getScreenWidget(_body(controller.storesSearch), (){})))
                ]
            ),
          )
      ),
    );
  }
  _body(stores)=>  ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder:(context, index) {
      var store = stores[index];
      return UserStoreRequestCard(store: store,);
    },
    separatorBuilder: (context, index) => SizedBox(height: 20.0,),
    itemCount: stores.length,);
}
