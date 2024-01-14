import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/widgets/post_card.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import 'package:maseef_app/widgets/search_form.dart';

class HomeScreen extends StatelessWidget {
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
                    itemBuilder:(context, index) => PostCard(Post(postId: '6', adminId: 'adminId', postDate: DateTime.now(), postContent: 'Hello', postLocation:startMapLocation , postImage: 'assets/images/Group.png' , postTitle: 'Read kit park', addressLocation: 'Damaris'), index),
                    separatorBuilder: (context, index) => SizedBox(height: 20.0,),
                    itemCount: 3)
              ]
            ),
          )
      ),
    );
  }
}
