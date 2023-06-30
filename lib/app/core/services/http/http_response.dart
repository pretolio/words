
import 'http_error.dart';

class MyHttpResponse {
  final bool isSucess;
  var data;
  HttpError? httpError;
  int? statusCode;

  MyHttpResponse({required this.isSucess, this.httpError, this.data, this.statusCode});
}