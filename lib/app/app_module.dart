import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_annoteds/app/app_controller.dart';
import 'package:my_annoteds/app/app_widget.dart';
import 'package:my_annoteds/app/data/marking_dao.dart';
import 'package:my_annoteds/app/modules/crud_marker/crud_marker_page.dart';
import 'package:my_annoteds/app/modules/crud_postit/crud_postit_page.dart';
import 'package:my_annoteds/app/modules/user_settings/user_settings_page.dart';
import 'package:my_annoteds/app/repositories/shared/user_settings.dart';
import 'package:my_annoteds/app/data/marker_dao.dart';
import 'package:my_annoteds/app/data/postit_dao.dart';
import 'package:my_annoteds/app/data/users_dao.dart';
import 'package:my_annoteds/app/model/user.dart';
import 'package:my_annoteds/app/modules/home/home_module.dart';
import 'package:my_annoteds/app/modules/login/login_controller.dart';
import 'package:my_annoteds/app/modules/login/login_module.dart';
import 'package:my_annoteds/app/modules/login/view/login_page.dart';
import 'package:my_annoteds/app/modules/splash_screen/splash_screen_module.dart';
import 'package:my_annoteds/app/modules/splash_screen/splash_screen_page.dart';

import 'modules/crud_marker/crud_marker_module.dart';
import 'modules/crud_postit/crud_postit_module.dart';
import 'modules/home/home_page.dart';
import 'modules/user_settings/user_settings_module.dart';

class AppModule extends MainModule {
  @override
  // Lista de injecoes de independencia do projeto
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => PostitDao()),
        Bind((i) => UserDao()),
        Bind((i) => MarkerDao()),
        Bind((i) => MarkingDao()),
        Bind((i) => User()),
        Bind((i) => UserSettings()),
        Bind((i) => LoginController()),
      ];

  @override
  // Root Widget
  Widget get bootstrap => AppWidget();

  @override
  // Modulos associados a este aplicativo
  List<ModularRouter> get routers => [
        ModularRouter(SplashPage.routeName, module: SplashModule()),
        ModularRouter(LoginPage.routeName, module: LoginModule()),
        ModularRouter(HomePage.routeName, module: HomeModule()),
        ModularRouter(CrudPostitPage.routeName, module: CrudPostitModule()),
        ModularRouter(CrudMarkerPage.routeName, module: CrudMarkerModule()),
        ModularRouter(UserSettingsPage.routeName, module: UserSettingsModule()),
      ];
}
