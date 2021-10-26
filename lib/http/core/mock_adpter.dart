import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

/// 测试适配器，mock数据

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<dynamic>> send<T>(BaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(seconds: 1), () {
      return HiNetResponse(
        statusCode: 200,
        data: {
          "data": {
            "code": 0,
            "message": "success",
          },
        },
      );
    });
  }
}
