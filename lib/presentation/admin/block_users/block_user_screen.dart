
import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';

import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';
 import '../../../widgets/scaffold_background.dart';
import 'controller/block_users_controller.dart';

class BlockUsersScreen extends GetWidget<BlockUsersController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(AppStrings.busManagement),
        actions: [
          CustomImageView(
            imagePath: ImageConstant.logo,
          )
        ],
      ),
      body: Obx(
              () => ScaffoldBackground(
              child: controller.state.value.getScreenWidget(_widget(), (){})),
      ),

    );
  }

  _widget()=>Obx(
    ()=> ListView.builder(
      itemCount: controller.users.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(controller.users[index].imagePath),
        ),
        title: Text(controller.users[index].name),
        subtitle: Text(controller.users[index].email),
        trailing: controller.users[index].blocked?Text('Unblock',style: TextStyle(color: Colors.green,fontSize: 16.0,fontWeight: FontWeight.bold),):  Text('Block',style: TextStyle(color: Colors.red,fontSize: 16.0,fontWeight: FontWeight.bold),),
        onTap: () {
          controller.blockUser(index);
        },
      )
    ),
  );

}
