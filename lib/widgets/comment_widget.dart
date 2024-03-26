
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/comment.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';

import '../core/utils/image_constant.dart';
import '../presentation/user/profile_screen/model/user_model.dart';

class CommentWidget extends StatefulWidget {
  Comment comment;

  CommentWidget(this.comment);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class  _CommentWidgetState extends State<CommentWidget> {
  RxBool love = false.obs;
  RxInt lovers = 0.obs;

  Rx<UserModel?> userModel = Rx<UserModel?>(null);
  HomeController controller = Get.find<HomeController>();
@override
  void initState() {
 controller.remoteDataSource.getUser(widget.comment.userId!).then((value) {
   value.fold((l) => null, (r){
     userModel.value = r;
   });
   love.value = widget.comment.love;
   lovers.value = widget.comment.lovers.length ;
 });
  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
    userModel.value==null?Center(child: CircularProgressIndicator(),):
        Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
              userModel.value?.imagePath??'',
            ),

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
                  widget
                  .comment.comment??'',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  DateFormat.yMMMd().format(widget.comment.date??DateTime.now()),
                ),
              ),
            ]),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  love.value = !love.value;
                  controller.loveComment(widget.comment);
                  if(love.value)
                    lovers.value++;
                  else
                    lovers.value--;
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
                lovers.toString(),
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
              Text(widget
                  .comment.replies.length.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ));
  }
}
