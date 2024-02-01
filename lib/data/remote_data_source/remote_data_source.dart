
import 'package:maseef_app/core/app_export.dart';
import 'package:maseef_app/data/apiClient/user_api_client.dart';
import 'package:maseef_app/presentation/user/profile_screen/model/user_model.dart';

import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
 import 'package:dartz/dartz.dart';
abstract class UserRemoteDataSource {

  Future<Either<Failure, UserModel>>login({required String email, required String password});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserModel>> register({required UserModel user, required String password});
  Future<Either<Failure, void>> forgetPassword(String email);
}


class UserRemoteDataSourceImpl implements UserRemoteDataSource {
   UserApiClient apiClient ;
   NetworkInfo networkInfo ;

   UserRemoteDataSourceImpl(this.apiClient, this.networkInfo);

   @override
   Future<Either<Failure, UserModel>> login({required String email, required String password}) async {
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
  Future<Either<Failure, UserModel>> register({required UserModel user, required String password}) async{
    if(await networkInfo.isConnected()){
      try {
         var response = await apiClient.signUp(user, password);
        return Right(response);
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
      } else{
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async{
    if(await networkInfo.isConnected()){
      try {
        apiClient.forgetPassword(email);
        return Right(nullVoid);
      } catch (e) {
        return Left(Failure(ApiInternalStatus.FAILURE.toString(), ResponseMessage.DEFAULT));
      }
    }  else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }


}