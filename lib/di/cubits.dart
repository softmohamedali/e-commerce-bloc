import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../market/presentation/screens/filter/filter_cubit.dart';
import '../profile/presentation/screens/notification/notifications_cubit.dart';
import '../market/presentation/screens/product_details/share_cubit.dart';
import '../market/presentation/screens/wishlist/wishlist_cubit.dart';

import '../market/presentation/screens/root/bottom_navbar_cubit.dart';
import 'di.dart';

void registerCubits() {
  sl.registerFactory(() => NavigationCubit());

  sl.registerFactory(() => FilterCubit());

  sl.registerFactory(() => WishlistCubit());

  sl.registerFactory(() => ShareCubit());

  sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  sl.registerFactory(() => NotificationsCubit(sl()));
}
