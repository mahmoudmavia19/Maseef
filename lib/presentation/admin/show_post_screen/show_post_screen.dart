import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/show_post_screen/controller/post_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

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
              _button('Delete post', Colors.red, Icon(Icons.delete,color: Colors.white,),(){
                controller.deletePost(controller.index);
              }),
                SizedBox(height: 10.0,),
                _button('Edit post', Colors.green, Icon(Icons.edit,color: Colors.white,),(){
                  Get.toNamed(AppRoutes.EditPostManagementScreen,arguments:controller.index);
                }),
                SizedBox(height: 10.0,),
                _button('Block user', Colors.orange, Icon(Icons.person,color: Colors.white,),(){

                }),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(Icons.heart_broken_rounded),
                              Text(
                                '12',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Icon(Icons.comment_bank),
                              Text('12',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                          child: Image.file(
                            File( controller.postController.posts[controller.index].postImage),
                            height: 150.0,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                          ),
                        ),
                      ])),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
                ExpandedTileList.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                    height: 0,
                    endIndent: 0,
                    indent: 0,
                  ),
                  itemCount: 5,
                  itemBuilder: (context, index, controller) => _commentWidget(),
                ),
              ],
            ),
          ),
        );
      }),
 /*     bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey.withOpacity(0.5)),
          child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Add a comment',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo),
                  ))),
        ),
      ),*/
    );
  }
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
          Text(text,style: TextStyle(color: Colors.white),),
          SizedBox(width: 10.0,),
          icon
        ],
      )),
);
  _commentWidget() => ExpandedTile(
        theme: ExpandedTileThemeData(
          headerPadding: EdgeInsets.zero,
          headerColor: ColorConstant.gray100.withOpacity(0.5),
          contentPadding: EdgeInsets.zero,
          contentBackgroundColor: ColorConstant.gray100.withOpacity(0.5),
        ),
        trailing: Container(),
        controller: ExpandedTileController(),
        content: _commentContent(),
        title: _commentContent(),
      );
}

_commentContent() => Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
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
                'Sahar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  'Awonderful place that I recommend visiting',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          ),
          Icon(Icons.heart_broken_rounded),
          Text(
            '12',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 5.0,
          ),
          Icon(Icons.comment_bank),
          Text('12', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
