import 'package:dartz/dartz.dart';
import '../../core/constants/constants.dart';
import '../../core/errors/error_handler.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';
import '../../presentation/admin/drivers_management/model/driver.dart';
import '../apiClient/driver_api_client.dart';

abstract class DriverRemoteDataSource {
  Future<Either<Failure, Driver>>login({required String email, required String password});
  Future<Either<Failure, void>> signOut();
}

class DriverRemoteDataSourceImpl  implements DriverRemoteDataSource {
  DriverApiClient apiClient;
  NetworkInfo networkInfo;
  DriverRemoteDataSourceImpl(this.apiClient, this.networkInfo);
  @override
  Future<Either<Failure, Driver>> login({required String email, required String password}) async {
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


}