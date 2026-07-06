import 'package:dartz/dartz.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/error/error_converter.dart';
import 'package:tozher/features/interests/data/source/interest_source.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/domain/params/interest_add_params.dart';
import 'package:tozher/features/interests/domain/params/interest_update_params.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';

class InterestRepoImpl extends InterestRepo {
  final InterestSource interestSource;

  InterestRepoImpl(this.interestSource);

  @override
  Future<Either<Failure, List<Interest>>> getInterests() async {
    return ErrorConverter.safeCall<List<Interest>>(() async {
      final interestModels = await interestSource.getInterests();
      return interestModels.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addInterest(InterestAddParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await interestSource.addInterest(params);
    });
  }

  @override
  Future<Either<Failure, void>> updateInterest(InterestUpdateParams params) async {
    return ErrorConverter.safeCall<void>(() async {
      await interestSource.updateInterest(params);
    });
  }

  @override
  Future<Either<Failure, void>> deleteInterest(String interestId) async {
    return ErrorConverter.safeCall<void>(() async {
      await interestSource.deleteInterest(interestId);
    });
  }
}
