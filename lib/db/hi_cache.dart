import 'package:shared_preferences/shared_preferences.dart';

/// 缓存管理类
class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    init();
  }

  static HiCache? _instance;

  HiCache._pre(this.prefs);

  /// 预初始化，防止在使用get时，prefs还未初始化
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var _prefs = await SharedPreferences.getInstance();
      _instance = HiCache._pre(_prefs);
    }
    return _instance!;
  }

  static HiCache getInstance() {
    _instance ??= HiCache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    prefs?.setString(key, value);
  }

  void setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  void setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  void setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  void setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs?.get(key) as T;
  }
}
