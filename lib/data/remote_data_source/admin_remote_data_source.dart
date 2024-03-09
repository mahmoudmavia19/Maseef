import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:maseef_app/data/apiClient/admin_api_client.dart';
import 'package:maseef_app/presentation/admin/complaint_screen/model/complaint.dart';
import 'package:maseef_app/presentation/admin/drivers_management/model/driver.dart';

import '../../core/constants/constants.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';
import '../../presentation/admin/bus_management_screen/model/bus.dart';
import '../../presentation/admin/category_management_screen/model/category.dart';
import '../../presentation/admin/post_management_screen/model/post.dart';
import '../../presentation/admin/store_management_screen/model/store.dart';

abstract class AdminRemoteDataSource {
  Future<Either<Failure, void>>login({required String email, required String password});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure,void>> addPost(Post post,File file);
  Future<Either<Failure,List<Post>>> getPosts();
  Future<Either<Failure,void>> deletePost(Post post);
  Future<Either<Failure,void>> editPost(Post post,File? file);
  Future<Either<Failure,void>> addCategory(Category category);
  Future<Either<Failure,void>> editCategory(Category category);
  Future<Either<Failure,void>> deleteCategory(Category category);
  Future<Either<Failure,List<Category>>> getCategories();
  Future<Either<Failure,List<Bus>>> getBuses();
  Future<Either<Failure,void>> addBus(Bus bus);
  Future<Either<Failure,void>> editBus(Bus bus);
  Future<Either<Failure,void>> deleteBus(Bus bus);
  Future<Either<Failure,List<Driver>>> getDrivers();
  Future<Either<Failure,void>> deleteDriver(Driver driver);
  Future<Either<Failure,void>> addDriver(Driver driver,String password);
  Future<Either<Failure,void>> editDriver(Driver driver);
  Future<Either<Failure,void>> addStore(Store store,File file);
  Future<Either<Failure,void>> editStore(Store store);
  Future<Either<Failure,List<Store>>> getStores();
  Future<Either<Failure,List<Complaint>>> getComplaint();
  Future<Either<Failure,void>> responseComplaint(Complaint complaint);

}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  AdminApiClient apiClient ;
  NetworkInfo networkInfo ;
  AdminRemoteDataSourceImpl(this.apiClient , this.networkInfo);

  @override
  Future<Either<Failure, void>> login({required String email, required String password}) async {
    if (await networkInfo.isConnected()) {
      try {
        var isAdmin =  await apiClient.signIn(email, password);
        if(isAdmin){
          return Right(nullVoid);
        } else {
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),'you are not an admin'));
        }
        return Right(nullVoid);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }

  @override
  Future<Either<Failure, void>> signOut() async{
    if(await networkInfo.isConnected()){
      try {
      apiClient.signOut();
      return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }

  }

  @override
  Future<Either<Failure, void>> addPost(Post post, File file)async{
   if(await networkInfo.isConnected()){
     try {
       var response = await apiClient.addPost(post, file);
       return Right(nullVoid);
     } catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
   } else{
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, List<Post>>> getPosts() async{
    if(await networkInfo.isConnected()){
      try {
        var response = await apiClient.getPosts();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(Post post) async{
         if(await networkInfo.isConnected()){
           try {
             var response = apiClient.deletePost(post);
             return Right(nullVoid);
           } catch (e) {
             return Left(ErrorHandler.handle(e).failure);
           }
         } else{
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, void>> editPost(Post post,File? file) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.editPost(post,file);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(Category category) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.addCategory(category);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async{
    if(await networkInfo.isConnected()){
      try {
        var response = await apiClient.getCategories();
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(Category category) async{
     if(await networkInfo.isConnected()){
       try {
         var response = apiClient.deleteCategory(category);
         return Right(nullVoid);
       } catch (e) {
         return Left(ErrorHandler.handle(e).failure);
       }
     } else{
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, void>> editCategory(Category category) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.editCategory(category);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addBus(Bus bus) async{
   if(await networkInfo.isConnected()){
     try {
       var response = apiClient.addBus(bus);
       return Right(nullVoid);
     } catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
   } else{
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, void>> editBus(Bus bus) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.editBus(bus);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Bus>>> getBuses() async{
     if(await networkInfo.isConnected()){
       try {
         var response = await apiClient.getBuses();
         if(response.isEmpty){
           return Left(Failure(ApiInternalStatus.FAILURE.toString(),'no buses found'));
         }
         return Right(response);
       } catch (e) {
         return Left(ErrorHandler.handle(e).failure);
       }
     } else{
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }

  @override
  Future<Either<Failure, void>> deleteBus(Bus bus) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.deleteBus(bus);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addDriver(Driver driver,String password) async{
   if(await networkInfo.isConnected()){
     try {
       var response = apiClient.addDriver(driver,password);
       return Right(nullVoid);
     } catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
   } else{
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, void>> deleteDriver(Driver driver) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.deleteDriver(driver);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editDriver(Driver driver) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.editDriver(driver);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Driver>>> getDrivers() async{
   if(await networkInfo.isConnected()){
     try {
       var response = await apiClient.getDrivers();
       if(response.isEmpty){
         return Left(Failure(ApiInternalStatus.FAILURE.toString(),'no drivers found'));
       }
       return Right(response);
     } catch (e) {
       return Left(ErrorHandler.handle(e).failure);
     }
   } else{
     return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
   }
  }

  @override
  Future<Either<Failure, void>> addStore(Store store,File file) async{
    if(await networkInfo.isConnected()){
      try {
        var response =await apiClient.addStore(store,file);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editStore(Store store) async{
    if(await networkInfo.isConnected()){
      try {
        var response = apiClient.editStore(store);
        return Right(nullVoid);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Store>>> getStores() async{
    if(await networkInfo.isConnected()){
      try {
        var response = await apiClient.getStores();
        if(response.isEmpty){
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),'no stores found'));
        }
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Complaint>>> getComplaint() async{
    if(await networkInfo.isConnected()){
      try {
        var response = await apiClient.getComplaints();
        if(response.isEmpty){
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),'no complaints found'));
        }
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


  @override
  Future<Either<Failure, void>> responseComplaint(Complaint complaint) async{
     if(await networkInfo.isConnected()){
       try {
         var response = apiClient.responseComplaint(complaint);
         return Right(nullVoid);
       } catch (e) {
         return Left(ErrorHandler.handle(e).failure);
       }
     } else{
       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
     }
  }
}

