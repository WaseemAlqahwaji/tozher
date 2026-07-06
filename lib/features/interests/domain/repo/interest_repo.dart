import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/domain/params/interest_add_params.dart';
import 'package:tozher/features/interests/domain/params/interest_update_params.dart';

abstract class InterestRepo {
  Future<Either<Failure, List<Interest>>> getInterests();

  Future<Either<Failure, void>> addInterest(InterestAddParams params);
  Future<Either<Failure, void>> updateInterest(InterestUpdateParams params);
  Future<Either<Failure, void>> deleteInterest(String interestId);
}
