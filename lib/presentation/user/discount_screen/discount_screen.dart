import 'package:flutter/material.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/widgets/store_card.dart';
import 'package:maseef_app/widgets/store_request_card.dart';
import 'package:maseef_app/widgets/user_store_card.dart';

import '../../../widgets/scaffold_background.dart';
import '../../../widgets/search_form.dart';

class DiscountScreen  extends StatelessWidget {

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
    );
  }
}
