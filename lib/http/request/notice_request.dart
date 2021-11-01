import 'package:flutter_bilibili/http/request/base_request.dart';

class NoticeRequest extends BaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLoading() {
    return true;
  }

  @override
  String path() {
    return '/uapi/notice';
  }
}