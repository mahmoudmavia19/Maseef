import 'package:flutter/material.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import '../core/app_export.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final RxBool love = false.obs;
  final int index;

  PostCard(this.post, this.index){
    loveToggle(isLove: post.love);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.userShowPostScreen,
          arguments: [index, post],
        );
      },
      child: _buildPostContainer(),
    );
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
      child: Image.asset(
        post?.postImage ?? '',
        height: 170.0,
        fit: BoxFit.fitHeight,
        alignment: Alignment.topCenter,
        width: double.infinity,
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
              post?.postTitle ?? '',
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
          InkWell(
            onTap: () {
              loveToggle();
            },
            child: Image.asset(
              ImageConstant.love,
              color: love.value ? Colors.red : Colors.black,
              fit: BoxFit.fill,
              height: 40.0,
              width: 40.0,
            ),
          ),
          _buildActionText('12'),
          SizedBox(width: 5.0),
          Image.asset(
            ImageConstant.comments,
            fit: BoxFit.fill,
            height: 40.0,
            width: 40.0,
          ),
          _buildActionText('12'),
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

  void loveToggle({bool? isLove}) {
    love.value = isLove ?? !love.value;
    post?.love = !love.value;
  }
}
