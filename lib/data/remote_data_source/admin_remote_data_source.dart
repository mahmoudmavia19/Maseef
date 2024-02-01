import 'package:dartz/dartz.dart';
import 'package:maseef_app/data/apiClient/admin_api_client.dart';
import 'package:maseef_app/data/apiClient/user_api_client.dart';

import '../../core/constants/constants.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';

abstract class AdminRemoteDataSource {
  Future<Either<Failure, void>>login({required String email, required String password});
  Future<Either<Failure, void>> signOut();
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

}