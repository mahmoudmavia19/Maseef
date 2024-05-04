import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/admin_post_item.dart';
import 'package:maseef_app/widgets/custom_app_bar.dart';
import 'package:maseef_app/widgets/custom_drawer.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/app_export.dart';
import 'controller/post_controller.dart';
import 'model/post.dart';

class PostManagementScreen extends GetWidget<PostController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: customAppBar(AppStrings.postManagement),
      body: Obx(() => ScaffoldBackground(
        child: controller.getState.getScreenWidget(_widget(), () {

        })
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Get.toNamed(AppRoutes.adminAddPostManagementScreen),
        tooltip: 'Add Post',
        child: Icon(Icons.add),
      ),
    );
  }
_widget()=> RefreshIndicator(
  onRefresh: () {
    controller.getPosts();
    return Future.value(true);
  },
  child: ListView.builder(
    itemCount: controller.posts.length,
    itemBuilder: (context, index) {
      Post post = controller.posts[index];
      return AdminPostItem(index: index, post: post);
    },
  ),
);
}