import 'package:flutter/cupertino.dart';
import 'package:robowars_app/features/screens/gallery_screen/gallery_screen.dart';

import '../../main_layout.dart';

final Map<String,WidgetBuilder> route = {
    '/profile' : (context) => MainLayout(),
    '/home': (context) => MainLayout(),
    '/schedule' : (context) => MainLayout(),
    '/teams': (context) => MainLayout(),
    '/updates' : (context) => MainLayout(),
    '/gallery' : (context) => GalleryScreen(),
};