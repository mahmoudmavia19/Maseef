import 'package:flutter/material.dart';
 import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

import '../../../core/app_export.dart';
import 'controller/post_controller.dart';
import 'model/comment.dart';

class AdminPostItem extends StatefulWidget {

  int index;
  Post post;
  AdminPostItem({Key? key, required this.index, required this.post}) : super(key: key);

  @override
  State<AdminPostItem> createState() => _AdminPostItemState();
}

class _AdminPostItemState extends State<AdminPostItem> {
  PostController controller = Get.find<PostController>();

  RxList<Comment> comments = RxList<Comment>([]);
  @override
  void initState() {
    controller.getAllComments(widget.post.postId!).then((value){
      comments.value = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.adminShowPostScreen,arguments: [widget.index,widget.post]);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.grey[200]!.withOpacity(0.7)
            ),
            child: Column(
                children: [
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Image.network(widget.post.postImage,
                      height: 200.0,
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.topCenter,
                      errorBuilder:(context, error, stackTrace) => Image.asset(ImageConstant.imageNotFound,height: 200,),
                      width: double.infinity,),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.post.postTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(ImageConstant.love,
                              fit: BoxFit.fill,
                              height: 40.0,
                              width: 40.0,),
                            Text(
                              widget.post.lovers.length.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Image.asset(ImageConstant.comments,
                              fit: BoxFit.fill,
                              height: 40.0,
                              width: 40.0,),
                            Obx(
                                ()=> Text(comments.length.toString(),
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
            )
        ),
      ),
    );
  }
}
