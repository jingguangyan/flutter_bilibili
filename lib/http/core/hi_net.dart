import 'package:flutter_bilibili/http/core/dio_adapter.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
// import 'package:flutter_bilibili/http/core/mock_adpter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;

  static HiNet getInstance() {
    _instance ??= HiNet._();
    return _instance!;
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    late var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog('result: ${result}');

    int? status = response?.statusCode;

    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    // printLog('url: ${request.url()}');
    // printLog('method: ${request.httpMethod()}');
    // // request.addHeader('token', '123');
    // printLog('header: ${request.header}');
    // printLog('params: ${request.params}');
    // // 使用Mock发送请求
    // HiNetAdapter adapter = MockAdapter();
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(dynamic log) {
    print('hi_net: ${log.toString()}');
  }
}
