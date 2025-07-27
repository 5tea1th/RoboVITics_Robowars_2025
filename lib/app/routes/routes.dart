import 'package:flutter/cupertino.dart';

import '../../home_page/main_layout.dart';

final Map<String,WidgetBuilder> route = {
    '/profile' : (context) => MainLayout(),
    '/home': (context) => MainLayout(),
    '/schedule' : (context) => MainLayout(),
    '/teams': (context) => MainLayout(),
    '/updates' : (context) => MainLayout(),
};