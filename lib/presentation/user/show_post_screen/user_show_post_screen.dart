import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import 'controller/user_post_controller.dart';

// ignore: must_be_immutable
class UserShowPostScreen extends GetWidget<UserPostManageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor.withOpacity(0.8),
      appBar: AppBar(
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
      body: ScaffoldBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                                  controller.post.postTitle,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    ImageConstant.location,
                                    fit: BoxFit.fill,
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Image.asset(
                                    ImageConstant.love,
                                    fit: BoxFit.fill,
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Text(
                                    '12',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Image.asset(
                                    ImageConstant.comments,
                                    fit: BoxFit.fill,
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                  Text('12',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                          child: Image.asset(
                            controller.post.postImage,
                            height: 150.0,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ) ,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            DateFormat. yMMMd().format(
                                controller.post.postDate
                            ),
                          ),
                        )
                      ])),
                ),
              ),
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                margin: const EdgeInsets.all(20.0),
                color: Colors.transparent,
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: ColorConstant.backgroundColor.withOpacity(0.5),
                    ),
                    child: Text(
                      controller.post.postContent,
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
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          padding: EdgeInsets.only(left: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey),
          child: TextFormField(
            cursorColor: ColorConstant.primary,
              decoration: InputDecoration(
                  hintText: 'Add a comment',
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo),
                  ))),
        ),
      ),
    );
  }
  _commentWidget() => ExpandedTile(
        onLongTap: () {
          replayComment();
        },
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

  _commentContent() {
    RxBool love = false.obs;
    return Container(
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
                'test name',
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
              InkWell(
                onTap: () {
                  love.value = !love.value;
                },
                child: Obx(
                  () => Image.asset(
                    ImageConstant.love,
                    fit: BoxFit.fill,
                    color: love.value ? Colors.red : Colors.black,
                    height: 40.0,
                    width: 40.0,
                  ),
                ),
              ),
              Text(
                '12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5.0,
              ),
              Image.asset(
                ImageConstant.comments,
                fit: BoxFit.fill,
                height: 40.0,
                width: 40.0,
              ),
              Text('12', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  void replayComment() {
    Get.dialog(Dialog(
        child: Container(
      padding: EdgeInsets.all(20.0),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          'Reply',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
            height: 50.0,
            width: double.infinity,
            child: TextFormField(
                decoration: InputDecoration(
                  border:InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Add a comment',
            )))
      ]),
    )));
  }
}
