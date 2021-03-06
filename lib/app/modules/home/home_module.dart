import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_annoteds/app/modules/home/reminder_page.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  // TODO: implement binds
  List<Bind> get binds => [
        Bind((i) => HomeController()),
      ];

  @override
  // TODO: implement routers
  List<ModularRouter> get routers => [
        ModularRouter<String>(
          HomePage.routeName,
          child: (_, args) => HomePage(),
          transition: TransitionType.leftToRightWithFade,
        ),
        ModularRouter(
          ReminderPage.routeName,
          child: (_, args) => ReminderPage(
            postit: args.data.postit,
          ),
        ),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
