import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/user/discount_screen/discount_screen.dart';
import 'package:maseef_app/presentation/user/home_screen/controller/home_controller.dart';
import 'package:maseef_app/presentation/user/locations_screen/locations_screen.dart';
import 'package:maseef_app/presentation/user/love_posts_screen/controller/love_posts_controller.dart';
import 'package:maseef_app/presentation/user/love_posts_screen/love_posts_screen.dart';
import 'package:maseef_app/presentation/user/notification_screen/notification_screen.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../../../core/app_export.dart';
import '../../home_screen/home_screen.dart';

class MainController extends GetxController {

  RxInt currentIndex = 0.obs;
  UserRemoteDataSource userRemoteDataSource = Get.find<UserRemoteDataSourceImpl>() ;
  Rx<FlowState> flowState = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  late UserModel userModel ;
  getProfile() async{
    flowState.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await userRemoteDataSource.getProfile()).fold((l) {
      flowState.value  = ErrorState(StateRendererType.fullScreenErrorState,l.message);
    }, (r) {
      userModel = r ;
      flowState.value  = ContentState();
    });
  }

  @override
  void onInit() {
    getProfile() ;
    super.onInit();
  }

  PageController pageController = PageController();

  bool get  postsScreen => currentIndex.value == 0
  ||  currentIndex.value == 1 ;

  void changeIndex(int index){
    currentIndex.value = index;
    pageController.jumpToPage(index);
    if(currentIndex.value == 0){
      Get.find<HomeController>().getAllPosts();
    }else if(currentIndex==1){
      Get.find<LovePostController>().getLovePosts();
    }
  }

  List<Widget> pages = [
    HomeScreen(),
    LovePostsScreen(),
    LocationsScreen(),
    NotificationScreen(),
    DiscountScreen(),
   ];


}