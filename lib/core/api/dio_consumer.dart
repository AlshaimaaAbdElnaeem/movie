

import 'package:dio/dio.dart';
import 'package:movie/core/api/api_service.dart';
import 'package:movie/core/api/end_points.dart';

class DioConsumer extends ApiService {
  final Dio dio;
  DioConsumer(this.dio) {
    dio.options.baseUrl = EndPoints.baseUrl;
  }

  @override
  Future get({required String endPoint}) async {
    final response = await dio.get(endPoint);
    return response.data;
  }
}
