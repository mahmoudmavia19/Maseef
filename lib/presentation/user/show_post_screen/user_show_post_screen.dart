import 'package:flutter/material.dart';
 import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
 import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';
import 'package:maseef_app/widgets/comment_widget.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../admin/post_management_screen/model/comment.dart';
import '../../admin/post_management_screen/model/post.dart';

// ignore: must_be_immutable
class UserShowPostScreen extends StatelessWidget{
  HomeController controller = Get.find<HomeController>();
  int index = Get.arguments[0];
  TextEditingController commentController = TextEditingController();
  Rx<Post> post = Rx<Post>(Get.arguments[1]);
  RxList<Comment> comments = RxList<Comment>([]);
  UserShowPostScreen(){
     controller.getAllComments(post.value.postId!).then((value) {
      comments.value = value ;
    });
  }
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
          child: Obx(()=>Column(
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
                                    post.value.postTitle,
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
                                  InkWell(
                                    onTap: () {
                                       controller.lovePost(index);
                                    },
                                    child: Image.asset(
                                      ImageConstant.love,
                                      color: post.value.love ? Colors.red : Colors.black,
                                      fit: BoxFit.fill,
                                      height: 40.0,
                                      width: 40.0,
                                    ),
                                  ),
                                    Text(
                                      post.value.lovers.length.toString(),
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
                                    Text(comments.length.toString(),
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
                              post.value.postImage,
                              height: 150.0,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImageConstant.imageNotFound,
                                  height: 150.0,
                                )   ;
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(DateFormat.yMMMd().format(post.value.postDate),style: TextStyle(fontSize: 12.0),)),
                          ),
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
                        post.value.postContent,
                        textAlign: TextAlign.center,
                      )),
                ),
                if(comments.length > 0)
                ExpandedTileList.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white,
                    height: 0,
                    endIndent: 0,
                    indent: 0,
                  ),
                  itemCount: comments.length,
                  itemBuilder: (context, index, controller) => _commentWidget(index),
                ),
              ],
            ),
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
            controller: commentController,
            cursorColor: ColorConstant.primary,
              decoration: InputDecoration(
                  hintText: 'Add a comment',
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller
                          .addComment(Comment(postId: post.value.postId,
                          comment:commentController.text , date: DateTime.now()));
                      commentController.clear();
                    },
                    icon: Icon(Icons.send),
                  ))),
        ),
      ),
    );
  }
  _commentWidget(index) => ExpandedTile(
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
        content:CommentWidget(comments[index]),
        title:CommentWidget(comments[index]),
      );

/*
  _commentContent(Comment comment) {
    RxBool love = false.obs;
    Rx<UserModel?> userModel = Rx<UserModel?>(null);
      controller.getUser(comment.userId!).then((value){
      userModel.value = value;
      print('object') ;
      print(value?.toJson()) ;
    }); ;
    return Obx(()=>Container(
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
                  userModel.value?.name??'',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    comment.comment??'',
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
                  comment.lovers.length.toString(),
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
                Text(comment.replies.length.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
*/

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
