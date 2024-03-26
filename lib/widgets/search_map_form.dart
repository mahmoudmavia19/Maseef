import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:searchfield/searchfield.dart';
class SearchMapForm extends StatelessWidget {
  final TextEditingController controller;
  final List<Post>? items;
    bool loggedIn = true;
  dynamic Function(SearchFieldListItem<Post>)? onSuggestionTap ;
SearchMapForm({
    Key? key,
    required this.controller,
    required this.items,
     this.loggedIn = true,
  this.onSuggestionTap
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.withOpacity(0.55),
      ),
      child: Row(
        children: [
          SvgPicture.asset(ImageConstant.search_icon, width: 30),
          SizedBox(width: 10),
          Expanded(
            child: SearchField<Post>(
              controller: controller,
               onSuggestionTap:onSuggestionTap,
               suggestions: items!.map((e) => SearchFieldListItem<Post>(
                  e.postTitle,
                 item: e,
               )).toList(),
              searchInputDecoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
