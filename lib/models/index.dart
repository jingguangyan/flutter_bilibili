export 'video_model.dart';
export 'test_all.dart';
export 'product.dart';
export 'home_model.dart';
import 'package:quiver/core.dart';

T? checkOptional<T>(Optional<T?>? optional, T? def) {
  // No value given, just take default value
  if (optional == null) return def;

  // We have an input value
  if (optional.isPresent) return optional.value;

  // We have a null inside the optional
  return null;
}
