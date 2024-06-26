import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/comment.dart';
import 'package:maseef_app/presentation/admin/show_post_screen/comment_item.dart';
import 'package:maseef_app/presentation/admin/show_post_screen/controller/post_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/utils/app_strings.dart';

// ignore: must_be_immutable
class ShowPostScreen extends GetWidget<PostManageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor.withOpacity(0.8),
      appBar:  AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
        title: CustomImageView(
          imagePath: ImageConstant.logo,
          height: 100.0,
        ),
      ),
      body: Obx(() {
        return ScaffoldBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0,),
              _button('Delete post',ColorConstant.deleteColor,CustomImageView(imagePath: ImageConstant.delete),(){
                showConfirmationDialog((){
                  controller.deletePost(controller.index);
                }, AppStrings.sureDelete, 'Alert');
              }),
                SizedBox(height: 10.0,),
                _button('Edit post', ColorConstant.editColor,CustomImageView(imagePath: ImageConstant.edit),(){
                  Get.toNamed(AppRoutes.adminEditPostManagementScreen,arguments:controller.index);
                }),
                SizedBox(height: 10.0,),
                _button('Block users',ColorConstant.userColor,CustomImageView(imagePath: ImageConstant.person),(){
                  Get.toNamed(AppRoutes.adminBlockUsers,arguments: controller.comments);
                }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.transparent,
                    child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: ColorConstant.backgroundColor.withOpacity(0.5),
                        ),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.postController.posts[controller.index].postTitle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0),
                                  ),
                                ),
                               Row(
                                 children: [
                                   Image.asset(ImageConstant.location,
                                     fit: BoxFit.fill,
                                     height: 40.0,
                                     width: 40.0,),
                                    Image.asset(ImageConstant.love,
                                      fit: BoxFit.fill,
                                      height: 40.0,
                                      width: 40.0,),
                                    Text(
                                      controller.post.lovers.length.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Image.asset(ImageConstant.comments,
                                      fit: BoxFit.fill,
                                      height: 40.0,
                                      width: 40.0,),
                                    Text(controller.comments.length.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                                 ],
                               ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Image.network(
                              controller.postController.posts[controller.index].postImage,
                              errorBuilder: (context, error, stackTrace) => Image.asset(ImageConstant.imageNotFound,height: 200,),
                              height: 150.0,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                              child: Text(DateFormat.yMMMd().format(controller.postController.posts[controller.index].postDate),))
                        ])),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin:const EdgeInsets.all(20.0),
                  color: Colors.transparent,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: ColorConstant.backgroundColor.withOpacity(0.5),
                      ),
                      child: Text(
                        controller.postController.posts[controller.index].postContent,
                        textAlign: TextAlign.center,
                      )),
                ),
                if(controller.comments.isNotEmpty)
                 Obx(
                   () => controller.stateComment.value.getScreenWidget(_bodyComments(), (){}),
                 )
              ],
            ),
          ),
        );
      }),
     );
  }

  _bodyComments()=>ExpandedTileList.separated(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    separatorBuilder: (context, index) => Divider(
      color: Colors.white,
      height: 0,
      endIndent: 0,
      indent: 0,
    ),
    itemCount: controller.comments.length,
    itemBuilder: (context, index,ami) => ExpandedTile(
        title: AdminCommentWidget(controller.comments[index],(){
          Get.defaultDialog(
              title: 'Delete comment',
              content:  Text('Are you sure you want to delete this comment?',textAlign: TextAlign.center,),
              actions:  [
                TextButton(onPressed: (){
                  Get.back();
                }, child: Text('Cancel')),
                TextButton(onPressed: (){
                  controller.deleteComment(controller.comments[index]);
                  controller.getAllPostComments();
                  Get.back();
                }, child: Text('Delete')),
              ]
          );
        }) ,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: ColorConstant.primary),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for(var reply in controller.comments[index].replies)
                  AdminReplayCommentWidget(reply)

              ],
            ),
          ),
        ),
        trailing: Container(),
        theme: ExpandedTileThemeData(
          headerPadding: EdgeInsets.zero,
          headerColor: ColorConstant.gray100.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          contentBackgroundColor: ColorConstant.gray100.withOpacity(0.5),
        ),
        controller: ExpandedTileController()

    ),
  );
_button(String text,Color color,Widget icon,void Function() action) =>  Container(
  width: 300.0,
  height: 50.0,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: MaterialButton(
      onPressed: action,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold),),
          SizedBox(width: 10.0,),
          icon
        ],
      )),
);
  _commentWidget(Comment comment) => ExpandedTile(
        theme: ExpandedTileThemeData(
          headerPadding: EdgeInsets.zero,
          headerColor: ColorConstant.gray100.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          contentBackgroundColor: ColorConstant.gray100.withOpacity(0.5),
        ),
        trailing: Container(),
        controller: ExpandedTileController(),
        content:Container(),
        title: _commentContent(comment),
      );

  _commentContent(Comment comment) => InkWell(
    onLongPress: () {
      Get.dialog(
          Dialog(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize:MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _button('Delete ِcomment',ColorConstant.deleteColor,CustomImageView(imagePath: ImageConstant.delete),(){
                     }),
                    SizedBox(height: 10.0,),
                    _button('Block user',ColorConstant.userColor,CustomImageView(imagePath: ImageConstant.person),(){

                    }),
                  ],
                ),
              ),
            ),
          )
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Maseef',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'Awonderful place that I recommend visiting',
                ),
              ),
            ]),
          ),
          Row(
            children: [
              Image.asset(ImageConstant.love,
                fit: BoxFit.fill,
                height: 40.0,
                width: 40.0,),
              Text(
                '12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5.0,
              ),
              Image.asset(ImageConstant.comments,
                fit: BoxFit.fill,
                height: 40.0,
                width: 40.0,),
              Text('12',
                  style:
                  TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ),
  );
}


