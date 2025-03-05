import 'package:get_it/get_it.dart';
import '../../di/cubits.dart';
import '../../di/product.dart';
import '../../di/user.dart';
import 'category.dart';
import 'common.dart';

final sl = GetIt.instance;

Future<void> init() async {
  registerCategoryFeature();
  registerProductFeature();
  registerUserFeature();

  registerCubits();

  registerCommonDependencies();
}
