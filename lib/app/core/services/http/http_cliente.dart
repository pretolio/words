import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import "package:http/http.dart" as http;

import 'http_error.dart';
import 'http_response.dart';


class HttpCli {

  Future<MyHttpResponse> get(
      {required String url, Map<String, String>? headers, bool decoder = true, bool bits = false,}) async {

      try {
        final http.Response response = await http.get(
          Uri.parse(url),
          headers: headers ?? <String, String>{
            'Content-Type': 'application/json',
          }
        ).timeout(const Duration(seconds: 15), onTimeout : () {
          debugPrint('get timeout');
          throw HttpError.timeout;
        });

        try{
          if(response.statusCode >= 200 && response.statusCode < 300){
            var result = bits ? response.bodyBytes : decoder ? json.decode(response.body) : response.body;

            return MyHttpResponse(
              isSucess: true,
              statusCode: response.statusCode,
              data: result,
            );
          } else {
            throw HttpError.statusCode;
          }

        } catch(e){
          debugPrint('catch $e');
          bool r = e == HttpError.statusCode;
          return MyHttpResponse(
              isSucess: false,
              httpError: r ? HttpError.statusCode : HttpError.unexpected,
              statusCode: response.statusCode,
              data: r ? response.body :  'Unexpected error, please try again later'
          );
        }
      } catch (error) {
        debugPrint('onError $error');
        return MyHttpResponse(
            isSucess: false,
            httpError: error == HttpError.timeout ? HttpError.timeout : HttpError.unexpected,
            data: error == HttpError.timeout ?
            'Exceeded connection timeout' :  'Unexpected error, please try again later'
        );
      }
  }


  Future<MyHttpResponse> post({required String url, Map<String, String>? headers,
      Map<String, dynamic>? body, bool decoder = true, bool isbyte = false}) async {

    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers ?? <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body)
      ).timeout(const Duration(seconds: 15), onTimeout : () {
        debugPrint('post timeout');
        throw HttpError.timeout;
      });

      try{
        if(response.statusCode >= 200 && response.statusCode < 300){
          final result =  isbyte ? response.bodyBytes : decoder ? json.decode(response.body) : response.body;


          return MyHttpResponse(
              isSucess: true,
              statusCode: response.statusCode,
              data: result,
          );
        } else {
          debugPrint(response.body);
          throw HttpError.statusCode;
        }

      } catch(e){
        debugPrint('catch $e');
        bool r = e == HttpError.statusCode;
        return MyHttpResponse(
            isSucess: false,
            httpError: r ? HttpError.statusCode : HttpError.unexpected,
            statusCode: response.statusCode,
            data: r ? response.body :  'Unexpected error, please try again later'
        );
      }
    }  catch (error) {
      debugPrint('onError $error');
      return MyHttpResponse(
          isSucess: false,
          httpError: error == HttpError.timeout ? HttpError.timeout : HttpError.unexpected,
          data: error == HttpError.timeout ?
          'Exceeded connection timeout' :  'Unexpected error, please try again later'
      );
    }
  }

  Future<MyHttpResponse> put({required String url, Map<String, String>? headers,
        Map<String, dynamic>? body, bool decoder = true}) async {

    try {
      final http.Response response = await http.put(
          Uri.parse(url),
          headers: headers ?? <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body)
      ).timeout(const Duration(seconds: 15), onTimeout : () {
        debugPrint('get timeout');
        throw HttpError.timeout;
      });

      try{
        if(response.statusCode >= 200 && response.statusCode < 300){
          final result = decoder ? json.decode(response.body) : response.body;
          return MyHttpResponse(
              isSucess: true,
              statusCode: 200,
              data: result,
          );
        } else {
          throw HttpError.statusCode;
        }

      } catch(e){
        debugPrint('catch $e');
        bool r = e == HttpError.statusCode;
        return MyHttpResponse(
            isSucess: false,
            httpError: r ? HttpError.statusCode : HttpError.unexpected,
            statusCode: response.statusCode,
            data: r ? response.body :  'Unexpected error, please try again later'
        );
      }
    } catch (error) {
      debugPrint('onError $error');

      return MyHttpResponse(
          isSucess: false,
          httpError: error == HttpError.timeout ? HttpError.timeout : HttpError.unexpected,
          data: error == HttpError.timeout ?
          'Exceeded connection timeout' :  'Unexpected error, please try again later'
      );
    }
  }

  Future<MyHttpResponse> patch({required String url, Map<String, String>? headers,
    Map<String, dynamic>? body, bool decoder = true}) async {

    try {
      final http.Response response = await http.patch(
          Uri.parse(url),
          headers: headers ?? <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body)
      ).timeout(const Duration(seconds: 15), onTimeout : () {
        debugPrint('get timeout');
        throw HttpError.timeout;
      });

      try{
        if(response.statusCode >= 200 && response.statusCode < 300){
          final result = decoder ? json.decode(response.body) : response.body;
          return MyHttpResponse(
              isSucess: true,
              statusCode: 200,
              data: result,
          );
        } else {
          throw HttpError.statusCode;
        }

      } catch(e){
        debugPrint('catch $e');
        bool r = e == HttpError.statusCode;
        return MyHttpResponse(
            isSucess: false,
            httpError: r ? HttpError.statusCode : HttpError.unexpected,
            statusCode: response.statusCode,
            data: r ? response.body :  'Unexpected error, please try again later'
        );
      }
    } catch (error) {
      debugPrint('onError $error');

      return MyHttpResponse(
          isSucess: false,
          httpError: error == HttpError.timeout ? HttpError.timeout : HttpError.unexpected,
          data: error == HttpError.timeout ?
          'Exceeded connection timeout' :  'Unexpected error, please try again later'
      );
    }
  }

  Future<MyHttpResponse> del({required String url, Map<String, String>? headers,
    Map<String, dynamic>? body, bool decoder = true}) async {

    try {
      final http.Response response = await http.delete(
          Uri.parse(url),
          headers: headers ?? <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body)
      ).timeout(const Duration(seconds: 15), onTimeout : () {
        debugPrint('get timeout');
        throw HttpError.timeout;
      });

      try{
        if(response.statusCode >= 200 && response.statusCode < 300){
          final result = decoder ? json.decode(response.body) : response.body;
          return MyHttpResponse(
              isSucess: true,
              statusCode: 200,
              data: result,
          );
        } else {
          throw HttpError.statusCode;
        }

      } catch(e){
        debugPrint('catch $e');
        bool r = e == HttpError.statusCode;
        return MyHttpResponse(
            isSucess: false,
            httpError: r ? HttpError.statusCode : HttpError.unexpected,
            statusCode: response.statusCode,
            data: r ? response.body :  'Unexpected error, please try again later'
        );
      }
    } catch (error) {
      debugPrint('onError $error');

      return MyHttpResponse(
          isSucess: false,
          httpError: error == HttpError.timeout ? HttpError.timeout : HttpError.unexpected,
          data: error == HttpError.timeout ?
          'Exceeded connection timeout' :  'Unexpected error, please try again later'
      );
    }
  }
}