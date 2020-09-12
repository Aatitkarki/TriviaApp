import 'dart:convert';
import 'dart:html';

import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_tirvia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return _getTriviaFromURL("http://numbersapi.com/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getTriviaFromURL('http://numbersapi.com/random');
  }

  Future<NumberTriviaModel> _getTriviaFromURL(String url) async {
    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
