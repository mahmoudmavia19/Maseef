import 'package:flutter/material.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/visitor/visitor_home_screen/controller/home_controller.dart';
import '../core/app_export.dart';
import '../presentation/admin/post_management_screen/model/comment.dart';

class VPostCard extends StatefulWidget {
  final Post post;
  final int index;

  VPostCard(this.post, this.index){

  }

  @override
  State<VPostCard> createState() => _VPostCardState();
}

class _VPostCardState extends State<VPostCard> {

   RxList<Comment> comments = RxList<Comment>([]);

  GuestHomeController controller = Get.find<GuestHomeController>();

   @override
  void initState() {
    controller.getAllComments(widget.post.postId!).then((value) {
      comments.value = value ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostContainer();
  }

  Widget _buildPostContainer() {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.grey[200]!.withOpacity(0.7),
      ),
      child: Column(
        children: [
          _buildPostImage(),
          _buildPostDetails(),
        ],
      ),
    );
  }

  Widget _buildPostImage() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Image.network(
        widget.post.postImage,
        height: 170.0,
        fit: BoxFit.fitHeight,
        alignment: Alignment.topCenter,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            ImageConstant.imageNotFound,
            height: 170.0,
          );
        }
      ),
    );
  }

  Widget _buildPostDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.post.postTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          _buildPostActions(),
        ],
      ),
    );
  }

  Widget _buildPostActions() {
    return Obx(
          () => Row(
        children: [
          Image.asset(
            ImageConstant.love,
            color:Colors.black,
            fit: BoxFit.fill,
            height: 40.0,
            width: 40.0,
          ),
          _buildActionText(widget.post.lovers.length.toString()),
          SizedBox(width: 5.0),
          Image.asset(
            ImageConstant.comments,
            fit: BoxFit.fill,
            height: 40.0,
            width: 40.0,
          ),
          _buildActionText(comments.length.toString()),
        ],
      ),
    );
  }

  Widget _buildActionText(String text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

}
