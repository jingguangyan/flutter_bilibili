import 'package:flutter_bilibili/http/dao/login_dao.dart';

enum HttpMethod { GET, POST, DELETE }

/// 基础请求
abstract class BaseRequest {
  // curl -X GET "https://api.devio.org/uapi/test/test?requestParams=11" -H "accept */*"
  // curl -X GET "https://api.devio.org/uapi/test/test/1"

  var pathParams;
  var useHttps = true;
  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();
  String path();
  String url() {
    Uri uri;
    var pathStr = path();
    // 拼接path参数
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${pathStr}${pathParams}";
      } else {
        pathStr = "${pathStr}/${pathParams}";
      }
    }

    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }

    if (needLoading()) {
      // 给需要登录的接口携带登录令牌
      addHeader(LoginDao.BOARDING_PASS, LoginDao.getBoardingPass() ?? '');
    }
    print('uri:${uri.toString()}');
    return uri.toString();
  }

  bool needLoading();

  Map<String, String> params = {};

  /// 添加参数
  BaseRequest add(String key, Object value) {
    params[key] = value.toString();
    return this;
  }

  Map<String, dynamic> header = {
    "course-flag": "fa",
    // 访问令牌，在课程公告获取
    "auth-token": "ZmEtMjAyMS0wNC0xMiAyMToyMjoyMC1mYQ==fa"
  };
  // 添加header
  BaseRequest addHeader(String key, Object value) {
    header[key] = value.toString();
    return this;
  }
}
