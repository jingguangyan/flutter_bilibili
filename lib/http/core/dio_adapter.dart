import 'package:dio/dio.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

/// Dio 适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse> send<T>(BaseRequest request) async {
    var response, options = Options(headers: request.header);
    var error;

    try {
      switch (request.httpMethod()) {
        case HttpMethod.GET:
          response = await Dio().get(request.url(), options: options);
          break;
        case HttpMethod.POST:
          response = await Dio().post(request.url(), options: options);
          break;
        case HttpMethod.DELETE:
          response = await Dio().delete(request.url(), options: options);
          break;
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }
    // 抛出HiNetError
    if (error != null) {
      throw HiNetError(response?.statusCode ?? -1, error.toString(),
          data: buildRes(response, request));
    }
    return buildRes(response, request);
  }

  // 构建 HiNetResponse
  buildRes(response, BaseRequest request) {
    return HiNetResponse(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response,
    );
  }
}
