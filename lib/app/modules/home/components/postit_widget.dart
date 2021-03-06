import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_annoteds/app/model/postit_color.dart';
import 'package:my_annoteds/app/modules/crud_postit/crud_postit_page.dart';
import 'package:my_annoteds/app/repositories/shared/Utils/image_picker_utils.dart';

import '../../../app_controller.dart';
import '../reminder_page.dart';

class PostitWidget extends StatelessWidget {
  PostitWidget({this.index});

  final int index;
  final appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed(CrudPostitPage.routeName,
            arguments:
                CrudPostitPageArguments(postit: appController.postits[index]));
      },
      onLongPress: () {
        Modular.link.pushNamed(ReminderPage.routeName,
            arguments:
                ReminderPageArguments(postit: appController.postits[index]));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          appController.removePostit(index: index);
        },
        child: Container(
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Color(PostitColor
                    .colors[appController.postits[index].color]['hex'])),
            child: Column(
              children: [
                Container(
                  child: Text(
                    appController.postits[index].title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (appController.postits[index].color == "verde" ||
                                appController.postits[index].color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                Container(
                  child: appController.postits[index].image != null
                      ? Row(
                    children: [
                      Icon(Icons.attach_file),
                      Image.memory(
                        ImagePickerUtils.getBytesImage(
                            base64Image: appController.postits[index].image),
                        height: 20,
                        width: 20,
                      ),
                    ],
                  )
                      : null,
                ),
                Container(
                  child: Text(
                    appController.postits[index].description,
                    style: TextStyle(
                        color: (appController.postits[index].color == "verde" ||
                                appController.postits[index].color == "azul")
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
