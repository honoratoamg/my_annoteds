import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_annoteds/app/repositories/shared/user_settings.dart';
import 'package:my_annoteds/app/repositories/shared/themes/AppThemes.dart';

import 'package:my_annoteds/app/model/user.dart';
import 'package:my_annoteds/app/modules/splash_screen/splash_screen_page.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final loggedUser = Modular.get<User>();
  bool islogged = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserSettings>(
      builder: (context, value) {
        return MaterialApp(
          title: "My Anoteds",
          theme: ThemeCollection.getAppTheme(),
          darkTheme: ThemeCollection.darkTheme(),
          initialRoute: SplashPage.routeName,
          navigatorKey: Modular.navigatorKey,
          onGenerateRoute: Modular.generateRoute,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
