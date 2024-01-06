import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/app_strings.dart';
import 'package:maseef_app/widgets/custom_app_bar.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/app_export.dart';
import 'controller/post_controller.dart';
import 'model/post.dart';

class PostManagementScreen extends GetWidget<PostController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: customAppBar(AppStrings.postManagement),
      body: Obx(() => ScaffoldBackground(
        child: ListView.builder(
            itemCount: controller.posts.length,
            itemBuilder: (context, index) {
              Post post = controller.posts[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.showPostScreen,arguments: [index,post]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Image.file(File(post.postImage),height: 150.0,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: double.infinity,),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(post.postTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                              Spacer(),
                              Icon(Icons.heart_broken_rounded),
                              Text('12',style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(width: 5.0,),
                              Icon(Icons.comment_bank),
                              Text('12',style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ]
                    )
                  ),
                ),
              );
            },
          ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Get.toNamed(AppRoutes.AddPostManagementScreen),
        tooltip: 'Add Post',
        child: Icon(Icons.add),
      ),
    );
  }

}