import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:number_trivia/core/error/failures.dart';
import 'package:number_trivia/core/usecases/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_tirvia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_tirvia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  GetConcreteNumberTrivia(this.repository);

//The call method lets us call the class directly without using the method also known as callable class.
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List<Object> get props => [number];
}
