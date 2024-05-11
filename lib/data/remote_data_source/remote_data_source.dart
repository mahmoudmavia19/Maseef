import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/data/apiClient/user_api_client.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/comment.dart';
import 'package:maseef_app/presentation/admin/post_management_screen/model/post.dart';
import 'package:maseef_app/presentation/admin/store_management_screen/model/store.dart';
import 'package:maseef_app/presentation/user/notification_screen/model/notification_model.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../presentation/admin/category_management_screen/model/category.dart';
import '../../presentation/admin/complaint_screen/model/complaint.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel>> register(
      {required UserModel user, required String password});
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, List<Post>>> getLovePosts();
  Future<Either<Failure, void>> likeOrDislikePost(Post post);
  Future<Either<Failure, List<Comment>>> getAllComments(String post);
  Future<Either<Failure, void>> addComment(Comment comment);
  Future<Either<Failure, void>> replayComment(String mainCommentId,Comment comment);
  Future<Either<Failure, List<Store>>> getAllStores();
  Future<Either<Failure, void>> addStore(Store store, File file);
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
  Future<Either<Failure, UserModel>> getProfile();
  Future<Either<Failure, void>> updateProfile(UserModel user, XFile? file);
  Future<Either<Failure, void>> sendComplaint(Complaint complaint);
  Future<Either<Failure, List<Complaint>>> getComplaints();
  Future<Either<Failure, UserModel>> getUser(String id);
  Future<Either<Failure, void>> sendForAllLoversNotification(
      Post post, NotificationModel notification);
  Future<Either<Failure, void>> sendForYouNotification(
      String userId, NotificationModel notification);
  Future<Either<Failure, void>> likeOrDislikeComment(Comment comment);
  Future<Either<Failure, void>> likeOrDislikeReplay(Comment mainComment);
  Future<Either<Failure,List<Category>>> getCategories();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  UserApiClient apiClient;
  NetworkInfo networkInfo;

  UserRemoteDataSourceImpl(this.apiClient, this.networkInfo);

  @override
  Future<Either<Failure, UserModel>> login(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.signIn(email, password);
        return Right(response!);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.signOut();
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> register(
      {required UserModel user, required String password}) async {
    if (await networkInfo.isConnected()) {
      try {
        var response = await apiClient.signUp(user, password);
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.forgetPassword(email);
        return Right(nullVoid);
      } catch (e) {
        return Left(Failure(
            ApiInternalStatus.FAILURE.toString(), ResponseMessage.DEFAULT));
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getAllPosts();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addComment(Comment comment) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.addComment(comment);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Comment>>> getAllComments(String post) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getComments(post);
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likeOrDislikePost(Post post) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.likeOrDislikePost(post);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Store>>> getAllStores() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getStores();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addStore(Store store, File file) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.addStore(store, file);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getLovePosts() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getLoversPosts();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> getNotifications() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getNotifications();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getProfile();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
      UserModel user, XFile? file) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.updateProfile(user, file);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendComplaint(Complaint complaint) async {
    if (await networkInfo.isConnected()) {
      try {
        apiClient.sendComplaint(complaint);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Complaint>>> getComplaints() async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getComplaints();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    if (await networkInfo.isConnected()) {
      try {
        final response = await apiClient.getUser(id);
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likeOrDislikeComment(Comment comment) async {
    if (await networkInfo.isConnected()) {
      try {
        await apiClient.likeOrDislikeComment(comment);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }



  @override
  Future<Either<Failure, void>> sendForAllLoversNotification(
      Post post, NotificationModel notification) async {
    if (await networkInfo.isConnected()) {
      try {
        await apiClient.sendForAllLoversNotification(post, notification);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sendForYouNotification(
      String userId, NotificationModel notification) async {
    if (await networkInfo.isConnected()) {
      try {
        await apiClient.sendForYouNotification(userId, notification);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories()async{
    if(await networkInfo.isConnected()){
      try {
        var response = await apiClient.getCategories();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    }  else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> replayComment(String mainCommentId,Comment comment)async {
    if (await networkInfo.isConnected()) {
    try {
    apiClient.replayComment(mainCommentId,comment);
    return Right(nullVoid);
    } catch (e) {
    return Left(ErrorHandler.handle(e).failure);
    }
    } else {
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> likeOrDislikeReplay(Comment mainComment)async {
    if(await networkInfo.isConnected()) {
      try {
        apiClient.likeOrDislikeReplay(mainComment);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
