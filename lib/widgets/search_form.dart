import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maseef_app/core/app_export.dart';

import '../core/utils/image_constant.dart';

class SearchForm extends StatelessWidget {

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
            SvgPicture.asset(ImageConstant.search_icon,width: 30,),
            SizedBox(width:10,),
            Expanded(
              child: TextFormField(
                cursorColor: ColorConstant.primary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder:InputBorder.none,
                  hintText: 'Search',
                ),
              ),
            ),
          ],
        ));
  }
}
