import 'package:go_router/go_router.dart';

import '../features/capture/presentation/pages/_pages.dart';
import '../features/food_detail/presentation/pages/_pages.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CapturePage()),
    GoRoute(
      path: '/detail',
      builder: (context, state) =>
          FoodDetailPage(args: state.extra! as FoodDetailArgs),
    ),
  ],
);
