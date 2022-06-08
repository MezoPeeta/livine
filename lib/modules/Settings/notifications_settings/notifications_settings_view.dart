import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/misc/notification.dart';
import '../../../translations/locale_keys.g.dart';

class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({Key? key}) : super(key: key);

  @override
  State<NotificationsSettings> createState() => _NotificationsSettingsState();
}

class _NotificationsSettingsState extends State<NotificationsSettings> {
  bool isNotified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.notfications.tr()),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  width: 200,
                  child: Text(LocaleKeys.ask_me_how_i_feel.tr(),
                      style: TextStyle(fontSize: 18.0))),
              Switch(
                  value: isNotified,
                  onChanged: (value) {
                    setState(() {
                      isNotified = value;
                    });

                    if (!value) {
                      flutterLocalNotificationsPlugin.cancel(0);
                    } else {
                      showNotification();
                    }
                  })
            ],
          ),
        )
      ]),
    );
  }
}