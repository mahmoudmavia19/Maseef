import 'package:flutter/cupertino.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';

import '../../../admin/category_management_screen/model/category.dart';
import '../../../admin/post_management_screen/model/comment.dart';

class GuestHomeController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  UserRemoteDataSource remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  FlowState get getState => state.value;
  TextEditingController searchPostsController = TextEditingController();
  RxList<Post> posts = <Post>[].obs;

  RxList<Category> categories = RxList<Category>([]);


  getAllCategories()async{
    (await remoteDataSource.getCategories()).fold((failure) {},(r) {
      categories.value = r;
    },) ;
  }

  Future<List<Comment>> getAllComments(String post)async{
    List<Comment> comments = [];
    (await remoteDataSource.getAllComments(post)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) {
      comments = r;

      state.value = ContentState();
    });
    return comments;
  }
  getFilterPost(String category)async{
    await getAllPosts();
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    posts.value = posts.where((element) => element.category == category).toList();
    state.value = ContentState();
  }

  onInit() {
    getAllPosts();
    getAllCategories();
    super.onInit();
  }
  getAllPosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getAllPosts()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(posts) {
       this.posts.value = posts;
       if(posts.isNotEmpty) {
         state.value = ContentState();
       } else
         {
           state.value = EmptyState('No Posts Found');
         }
       }
    );
  }



}