import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/presentation/visitor/visitor_discount_screen/controller/discount_controller.dart';
import 'package:maseef_app/widgets/store_card.dart';
import 'package:maseef_app/widgets/store_request_card.dart';
import 'package:maseef_app/widgets/user_store_card.dart';

import '../../../widgets/scaffold_background.dart';
import '../../../widgets/search_form.dart';

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
                  SearchForm(),
                  SizedBox(height: 20.0,),
                  Obx(() => controller.state.value.getScreenWidget(_body(), (){}))
                ]
            ),
          )
      ),
    );
  }
  _body()=>  ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder:(context, index) {
          var store = controller.stores[index];
        return UserStoreRequestCard(store:store,);
      },
      separatorBuilder: (context, index) => SizedBox(height: 20.0,),
      itemCount: controller.stores.length,);
}
