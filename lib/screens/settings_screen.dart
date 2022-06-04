import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:weather/components/components.dart';
import 'package:weather/size_config.dart';
import 'package:weather/types/translated_text.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatefulWidget {
  final String appBackground;
  final String data;
  const SettingsScreen(
      {required this.appBackground, required this.data, Key? key})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

void makeChange() async {
  var box = await Hive.openBox('Storage');
  box.put('sync', false);
}

class _SettingsScreenState extends State<SettingsScreen> {
  String data = '';
  bool isShowModal = true;
  void showModal() {
    makeChange();
    if (isShowModal) {
      setState(() {
        isShowModal = false;
      });
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(Translated('Предупреждение').translate(),
                      style: TextStyle(fontFamily: 'Roboto')),
                  Text(
                      '${Translated("Некоторые настройки вступят в силу только после перезагрузки").translate()}!',
                      style: TextStyle(fontFamily: 'Roboto')),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColorLight)),
                    child: Text(Translated('Закрыть').translate(),
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Roboto')),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    data = arguments['data'];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: ExtraAppBarComponent(),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            FullBackgroundComponent(
              widget.appBackground,
              withBlur: true,
            ),
            DarkerBackgroundComponent(0.7),
            SafeArea(
                child: ListView(
              padding: EdgeInsets.only(left: getPadding(), right: getPadding()),
              children: [
                SettingsGroup(
                    title: Translated('Общие Настройки').translate(),
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(getPadding()),
                        child: Column(
                          children: [
                            SwitchSettingsTile(
                                title: Translated('Сохранять Последнюю Сессию')
                                    .translate(),
                                settingKey: "key-save-history",
                                onChange: (value) => showModal(),
                                defaultValue: false),
                            SwitchSettingsTile(
                              title: Translated('Присылать Уведомления')
                                  .translate(),
                              settingKey: "key-notifications",
                              defaultValue: true,
                              onChange: (value) => showModal(),
                            ),
                          ],
                        ),
                      ),
                    ]),
                SizedBox(height: getPaddingX2()),
                SettingsGroup(
                    title: Translated('Отображение Температуры').translate(),
                    children: [
                      Container(
                        padding: EdgeInsets.all(getPadding()),
                        child: RadioSettingsTile<int>(
                          showTitles: false,
                          title: Translated('Единицы измерения температуры')
                              .translate(),
                          settingKey: 'key-units',
                          values: <int, String>{
                            0: '${Translated("Градус Фаренгейта").translate()} (°F)',
                            1: '${Translated("Градус Цельсия").translate()} (°C)',
                          },
                          selected: 0,
                          onChange: (value) => showModal(),
                        ),
                      )
                    ]),
                SizedBox(height: getPaddingX2()),
                SettingsGroup(
                    title: Translated('Фон и Цвет').translate(),
                    children: [
                      Container(
                        padding: EdgeInsets.all(getPadding()),
                        child: CheckboxSettingsTile(
                          settingKey: 'key-static_background',
                          title: Translated('Статический Фон').translate(),
                          onChange: (value) => showModal(),
                          childrenIfEnabled: <Widget>[
                            DropDownSettingsTile<int>(
                              title: Translated('№ :').translate(),
                              settingKey: "key-background-id",
                              values: const <int, String>{
                                0: 'Blue Montain',
                                1: 'Red Tower',
                                2: 'Dark Sunset',
                                3: 'Magic Meadow',
                                4: 'Softwood Forest',
                                5: 'Сyan Hill',
                                6: 'Freeze Lighthouse',
                                7: 'Edgeless River',
                                8: 'Pink Pond',
                                9: 'Autumn Forest',
                                10: 'Deer and Sunbeam',
                                11: 'Laim Montain',
                                12: 'Before Midnight',
                              },
                              selected: 0,
                              onChange: (value) => showModal(),
                            ),
                          ],
                        ),
                      )
                    ]),
                SettingsGroup(
                    title: Translated('Языковые Настройки').translate(),
                    children: [
                      Container(
                          padding: EdgeInsets.all(getPadding()),
                          child: DropDownSettingsTile<int>(
                            title: Translated('Язык').translate(),
                            settingKey: "key-lang",
                            values: const <int, String>{
                              0: 'Русский',
                              1: 'English',
                            },
                            selected: 0,
                            onChange: (value) => showModal(),
                          ))
                    ]),
              ],
            ))
          ],
        ));
  }
}
