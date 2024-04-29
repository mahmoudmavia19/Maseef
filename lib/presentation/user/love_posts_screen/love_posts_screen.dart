import 'package:flutter/material.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';
import 'package:maseef_app/widgets/scaffold_background.dart';
import '../../../core/app_export.dart';
import '../../../core/utils/app_strings.dart';
import '../../../widgets/post_card.dart';
import '../../../widgets/search_post_form.dart';

class LovePostsScreen extends  GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldBackground(
          opacity: 0.9,
          child: Obx(()=> SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                  children: [
                    SearchPostForm(controller:controller.searchLovePostsController ,items: controller.postsLove),
                    SizedBox(height: 10.0,),
                    SizedBox(
                      height: 45.0,
                      child: Row(
                        children: [
                          Icon(Icons.filter_list_alt),
                          Expanded(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Row(
                                children: [
                                  _tab('all', (){
                                    controller.getAllPosts();
                                  }),
                                  Expanded(
                                    child: Obx(
                                      () =>ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:controller.categories.length, // Adjust this based on the number of tabs you have
                                        itemBuilder: (BuildContext context, int index) {
                                          return _tab(controller.categories[index].name, (){
                                            controller.getFilterLovePost(controller.categories[index].id);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                     controller.state.value.getScreenWidget(_body(), (){})
                  ]
              ),
            ),
          )
      ),
    );
  }
_body()=>ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder:(context, index) {
      var post = controller.postsLove[index];
      return PostCard(post, index);
    },
    separatorBuilder: (context, index) => SizedBox(height: 20.0,),
    itemCount: controller.postsLove.length) ;
  String getTabTitle(int index) {
    switch (index) {
      case 0:
        return AppStrings.All;
      case 1:
        return AppStrings.parks;
      case 2:
        return AppStrings.historical_places;
      case 3:
        return AppStrings.Malls;
      case 4:
        return AppStrings.Hotels;
      case 5:
        return AppStrings.Cafes;
      case 6:
        return AppStrings.Restaurants;
      case 7:
        return AppStrings.Projects;
      default:
        return '';
    }
  }

  _tab(String title, VoidCallback onTap) {
    RxBool selected = false.obs;
    return InkWell(
      onTap: () {
        selected.value = !selected.value;
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:4.0),
        child: Obx(()=>Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              color:selected.value? ColorConstant.primary: ColorConstant.gray900,
              borderRadius: BorderRadius.circular(25.0)
          ) ,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        ),
      ),
    );
  }
}
