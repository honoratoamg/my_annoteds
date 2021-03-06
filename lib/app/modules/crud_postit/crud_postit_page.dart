import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_annoteds/app/data/marking_dao.dart';
import 'package:my_annoteds/app/model/postit.dart';
import 'package:my_annoteds/app/model/postit_color.dart';
import 'package:my_annoteds/app/modules/crud_postit/presenter/crud_postit_presenter.dart';
import 'package:my_annoteds/app/repositories/shared/Utils/image_picker_utils.dart';

import '../../app_controller.dart';
import 'components/crud_postit_select_image_menu_widget.dart';
import 'components/crud_postit_settings_menu_widget.dart';
import 'crud_postit_controller.dart';

class CrudPostitPageArguments {
  CrudPostitPageArguments({this.postit});
  Postit postit;
}

class CrudPostitPage extends StatefulWidget {
  CrudPostitPage({this.postit});

  static const routeName = "/crudPostitPage";
  final Postit postit;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CrudPostitPage> implements ICrudPostitPresenter {
  final appController = Modular.get<AppController>();
  final crudPostitController = Modular.get<CrudPostitController>();
  final markingDao = Modular.get<MarkingDao>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String color;
  String title;
  String description;
  CrudPostitPresenter presenter;

  @override
  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    presenter = CrudPostitPresenter(this);
    titleController.text = widget.postit != null ? widget.postit.title : "";
    descriptionController.text =
        widget.postit != null ? widget.postit.description : "";
    color = widget.postit != null ? widget.postit.color : "branco";
    title = titleController.text;
    description = descriptionController.text;

    if (widget.postit != null) {
      presenter.initializePostitMarkers(
          loggedUserId: appController.loggedUser.id,
          postitId: widget.postit.id);
    }

    if (widget.postit?.image != null) {
      presenter.base64Image = widget.postit.image;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Meu Postit'),
            Spacer(),
            IconButton(
              icon: Icon(Icons.save),
              tooltip: 'Salvar postit',
              onPressed: () {
                crudPostitController.savePostit(
                  title: title,
                  description: description,
                  color: color,
                  postit: widget.postit,
                  base64Image: presenter.base64Image,
                  postitMarkers: presenter.postitMarkers,
                );
                Modular.to.pop();
              },
            ),
          ],
        ),
        actions: [
          CrudPostitSettingsMenuWidget(
            presenter: presenter,
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    children: presenter.postitMarkers.map<Card>((int markerId) {
                      return Card(
                          margin: EdgeInsets.all(8),
                          child: Text(appController.getMarkerTitleById(
                              markerId: markerId)));
                    }).toList(),
                  ),
                ),
              ),
              Container(
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: titleController,
                  maxLines: null, // Necessario para entrada multilinha
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      color: PostitColor.colors[color]['darkColor']
                          ? Colors.white
                          : Colors.black),
                  onChanged: (valor) => setState(() => title = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Insira o T??tulo do seu Postit',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PostitColor.colors[color]['darkColor']
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 16,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: PostitColor.colors[color]['darkColor']
                          ? Colors.white
                          : Colors.black),
                  onChanged: (valor) => setState(() => description = valor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: PostitColor.colors[color]['darkColor']
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    labelText: 'Insira seu texto',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: PostitColor.colors[color]['darkColor']
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
              Container(
                color: Color(PostitColor.colors[color]['hex']),
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    widget.postit?.image != null
                        ? Image.memory(
                            ImagePickerUtils.getBytesImage(
                                base64Image: presenter.base64Image),
                          )
                        : presenter.image == null
                            ? SizedBox.shrink()
                            : Image.file(
                                presenter.image,
                              ),
                  ],
                ),
              ),
            ],
          )),
      bottomNavigationBar: BottomAppBar(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CrudPostitSelectImageMenuWidget(presenter.setImageValue),
              Row(
                children: PostitColor.colors.keys
                    .map<IconButton>((String listItemValue) {
                  return IconButton(
                      icon: Icon(Icons.circle),
                      color: Color(PostitColor.colors[listItemValue]['hex']),
                      onPressed: () {
                        setState(() {
                          color = listItemValue;
                        });
                      });
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
