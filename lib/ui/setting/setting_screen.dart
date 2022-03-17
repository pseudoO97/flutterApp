import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hilmy/providers/auth_provider.dart';
import 'package:hilmy/providers/theme_provider.dart';
import 'package:hilmy/routes.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settingAppTitle"),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("settingThemeListTitle"),
          subtitle: Text("settingThemeListSubTitle"),
          trailing: Switch(
            activeColor: Theme.of(context).appBarTheme.color,
            // activeTrackColor: Theme.of(context).textTheme.title!.color,
            value: Provider.of<ThemeProvider>(context).isDarkModeOn,
            onChanged: (booleanValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(booleanValue);
            },
          ),
        ),
        ListTile(
          title: Text("settingLanguageListTitle"),
          subtitle: Text("settingLanguageListSubTitle"),
          // trailing: SettingLanguageActions(),
        ),
        ListTile(
          title: Text("settingLogoutListTitle"),
          trailing: RaisedButton(
              onPressed: () {
                _confirmSignOut(context);
              },
              child: Text("settingLogoutButton")),
        )
      ],
    );
  }

  _confirmSignOut(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              material: (_, PlatformTarget target) => MaterialAlertDialogData(
                  backgroundColor: Theme.of(context).appBarTheme.color),
              title: Text("alertDialogTitle"),
              content: Text("alertDialogMessage"),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText("alertDialogCancelBtn"),
                  onPressed: () => Navigator.pop(context),
                ),
                PlatformDialogAction(
                  child: PlatformText("alertDialogYesBtn"),
                  onPressed: () {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);

                    authProvider.signOut();

                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.login, ModalRoute.withName(Routes.login));
                  },
                )
              ],
            ));
  }
}
