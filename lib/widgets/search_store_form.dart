import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:searchfield/searchfield.dart';
class SearchStoreForm extends StatelessWidget {
  final TextEditingController controller;
  final List<Store>? items;
    bool loggedIn = true;
  List<SearchFieldListItem<Store>>? Function(String)? onSearchTextChanged;
    SearchStoreForm({
    Key? key,
    required this.controller,
    required this.items,
     this.loggedIn = true,
      this.onSearchTextChanged
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
            child: SearchField<Store>(
              controller: controller,
               onSuggestionTap: (p0) {
                if(loggedIn) {
                  Get.toNamed(
                   AppRoutes.userShowPostScreen,
                   arguments: [items!.indexOf(p0.item!),p0.item],
                 );
                }else {
                  Get.toNamed(
                    AppRoutes.userLoginScreen
                  );
                }

                },
               suggestions: items!.map((e) => SearchFieldListItem<Store>(
                  e.name,
                 item: e,
               )).toList(),
              onSearchTextChanged: onSearchTextChanged,
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
