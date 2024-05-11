
 import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
 import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer.dart';
import 'package:maseef_app/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:maseef_app/data/remote_data_source/remote_data_source.dart';
import 'package:maseef_app/presentation/admin/category_management_screen/model/category.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/user/notification_screen/model/notification_model.dart';
import 'package:maseef_app/presentation/user/profile_screen/controller/profile_controller.dart';
import '../../../admin/post_management_screen/model/comment.dart';

class HomeController extends GetxController {
  Rx<FlowState> state = Rx<FlowState>(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
  Rx<FlowState> stateComment = Rx<FlowState>(ContentState());
  List<Post> posts = [];
  List<Post> postsLove = [];
  UserRemoteDataSource  remoteDataSource = Get.find<UserRemoteDataSourceImpl>();
  UserProfileController profileController = Get.find<UserProfileController>();
  TextEditingController searchPostsController = TextEditingController();
  TextEditingController searchLovePostsController = TextEditingController();

   RxList<Category> categories = RxList<Category>([]);


   getAllCategories()async{
     (await remoteDataSource.getCategories()).fold((failure) {},(r) {
        categories.value = r;
     },) ;
   }


   getFilterPost(String category)async{
    await getAllPosts();
     state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    posts = posts.where((element) => element.category == category).toList();
    state.value = ContentState();
   }

  getFilterLovePost(String category)async{
    await getAllPosts();
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    postsLove = postsLove.where((element) => element.category == category).toList();
    state.value = ContentState();
  }

   getAllPosts()async{
    state.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.getAllPosts()).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(List<Post> posts) {
      this.posts = posts;
      postsLove = posts.where((element) => element.love).toList();
      if(posts.isNotEmpty) {
        state.value = ContentState();
      } else
        {
          state.value = EmptyState('No Posts Found');
        }
    }) ;
  }

  lovePost(int index) async{
    posts[index].love = !posts[index].love ;
    (await remoteDataSource.likeOrDislikePost(posts[index])).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(r) async{
      if(posts[index].love) {
      var post = posts[index];
/*
      await remoteDataSource.sendForAllLoversNotification(post, NotificationModel(
          leadingImage: profileController.user.imagePath,
          title: post.postTitle,
          date: DateTime.now(),
          postId: post.postId,
          trailingImage: post.postImage,
          subtitle: '${profileController.user.name} love the post',
          isSystemComment: false));
*/

      }
      getAllPosts();
    }) ;
  }

  loveComment(Comment comment) async{
    comment.love = !comment.love ;
    (await remoteDataSource.likeOrDislikeComment(comment)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(r)async {
      if(comment.love) {
        var post = posts.firstWhere((element) =>
        element.postId == comment.postId);
        if(profileController.user.id != comment.userId) {
          await remoteDataSource.sendForYouNotification(comment.userId!, NotificationModel(
            leadingImage: profileController.user.imagePath,
            title: post.postTitle,
            date: DateTime.now(),
            postId: comment.postId,
            trailingImage: post.postImage,
            subtitle: '${profileController.user.name} love your comment',
            isSystemComment: false));
        }
      }
      ContentState();
     }) ;

  }


  loveReplay(Comment mainComment,bool status,Comment comment) async{
    //comment.love = !comment.love ;
    (await remoteDataSource.likeOrDislikeReplay(mainComment)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    },(r)async {
      if(status) {
        var post = posts.firstWhere((element) =>
        element.postId == mainComment.postId);
        if(profileController.user.id != comment.userId) {
          await remoteDataSource.sendForYouNotification(mainComment.userId!, NotificationModel(
            leadingImage: profileController.user.imagePath,
            title: post.postTitle,
            date: DateTime.now(),
            postId: mainComment.postId,
            trailingImage: post.postImage,
            subtitle: '${profileController.user.name} love your reply',
            isSystemComment: false));
        }
      }
      ContentState();
    }) ;

  }




  addComment(Comment comment) async{
     stateComment.value = LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState);
    (await remoteDataSource.addComment(comment)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) async{
      var post = posts.firstWhere((element) =>
      element.postId == comment.postId);
/*
      await remoteDataSource.sendForAllLoversNotification(post, NotificationModel(
          leadingImage: profileController.user.imagePath,
          title: post.postTitle,
          date: DateTime.now(),
          postId: comment.postId,
          trailingImage: post.postImage,
          subtitle: '${profileController.user.name} add comment ',
          isSystemComment: false));
*/
      await getAllComments(comment.postId!);
    });
  }

 Future<List<Comment>> getAllComments(String post)async{

   List<Comment> comments = [];
   (await remoteDataSource.getAllComments(post)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) {
      comments = r;
      for(var i = 0 ; i < comments.length ; i++){
        for(var j = 0 ; j < comments[i].replies.length ; j++){
           comments[i].replies[j].id = j.toString();
           comments[i].replies[j].love = comments[i].replies[j].lovers.contains(profileController.user.id);
        }

      }
       stateComment.value = ContentState();
    });
    return comments;
  }
  @override
  void onInit() async{
    await getAllPosts();
    await getAllCategories();
    super.onInit();
  }
TextEditingController replayController = TextEditingController();
  Future<void> replayComment(String mainCommentID) async{
   await  Get.defaultDialog(
       title: 'Replay Comment',
       content: TextFormField(controller:replayController,),
       actions: [
         TextButton(onPressed: (){
           Get.back();
         }, child: Text('Cancel')),
         TextButton(onPressed: ()async{
           var comment = Comment(postId: posts.first.postId,
               comment:replayController.text , date: DateTime.now());
           Get.back();
           replayController.clear();
          await replay(mainCommentID, comment);

         }, child: Text('Replay')),
       ]
     );
  }

  Future<void> replay(String mainCommentId,Comment comment)async {
    (await remoteDataSource.replayComment(mainCommentId,comment)).fold((failure) {
      state.value = ErrorState(StateRendererType.popupErrorState, failure.message);
    }, (r) async{
      var post = posts.firstWhere((element) =>
      element.postId == comment.postId);
      if(profileController.user.id != comment.userId){
      await remoteDataSource.sendForYouNotification(comment.userId!, NotificationModel(
          leadingImage: profileController.user.imagePath,
          title: post.postTitle,
          date: DateTime.now(),
          postId: comment.postId,
          trailingImage: post.postImage,
          subtitle: '${profileController.user.name} replay comment',
          isSystemComment: false));
      }
    });

    }

}