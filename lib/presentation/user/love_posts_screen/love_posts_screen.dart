import 'package:flutter/material.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';

import '../../../core/constants/constants.dart';
import '../../../widgets/post_card.dart';
import '../../../widgets/search_form.dart';
import '../../admin/post_management_screen/model/post.dart';

class LovePostsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
          opacity: 0.9,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
                children: [
                  SearchForm(),
                  SizedBox(height: 20.0,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:(context, index) => PostCard(Post(postId: '6', adminId: 'adminId', postDate: DateTime.now(), postContent: 'Hello', postLocation:startMapLocation , postImage: 'assets/images/Group.png' , postTitle: 'Read kit park', addressLocation: 'Damaris',love: true), index),
                      separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                      itemCount: 3)
                ]
            ),
          )
      ),
    );
  }
}
