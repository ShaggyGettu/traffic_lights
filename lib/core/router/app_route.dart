import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:traffic_lights/modules/traffic_lights/pages/home_page.dart';

class AppRouteModel {
  final String path;
  final String displayName;
  final Function(BuildContext context, {GoRouterState? state, Widget? child})?
      page;
  final FutureOr<String?> Function(BuildContext, GoRouterState)? redirect;
  final Page<dynamic> Function(BuildContext, GoRouterState)? pageBuilder;

  AppRouteModel({
    required this.path,
    this.displayName = '',
    this.page,
    this.redirect,
    this.pageBuilder,
  });

  String get asSubRoute => path[0] == '/' ? path.replaceFirst('/', '') : path;
}

enum AppRoute {
  home;

  AppRouteModel get data {
    switch (this) {
      case AppRoute.home:
        return AppRouteModel(
          path: '/',
          displayName: 'Home',
          page: (context, {state, child}) => const HomePage(),
        );
    }
  }
}
