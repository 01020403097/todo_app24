import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/style/app_theme.dart';

import '../../providers/setting_prov.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SettingsTab extends StatelessWidget {
  static const String routeName = 'settingsTab';

  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(appBar: AppBar(backgroundColor: AppTheme.primary,
    title: Text(AppLocalizations.of(context)!.settings,style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppTheme.white)),
    flexibleSpace: Container(),toolbarHeight: MediaQuery.sizeOf(context).height*0.15,),


      body:Padding(
        padding:  EdgeInsetsDirectional.only(top: MediaQuery.sizeOf(context).height*0.028),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width * 0.05),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsetsDirectional.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.025,
                  horizontal: MediaQuery.sizeOf(context).width * 0.12),
              padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width * 0.05),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                  border: Border.all(width: 2, color: AppTheme.primary)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: settingProvider.language,
                  items: [
                    DropdownMenuItem(
                      value: 'en',
                      child: Text('English',     style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppTheme.primary),),
                    ),
                    DropdownMenuItem(
                      value: 'ar',
                      child: Text('العربيه',     style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppTheme.primary),),
                    ),
                  ],
                  onChanged: (selectedLanguage) {
                    if (selectedLanguage == null) return;
                    settingProvider.changeLanguage(selectedLanguage);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width * 0.05),
              child: Text(
                AppLocalizations.of(context)!.mode,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsetsDirectional.symmetric(
                  vertical: MediaQuery.sizeOf(context).height * 0.025,
                  horizontal: MediaQuery.sizeOf(context).width * 0.12),
              padding: EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width * 0.05),
              decoration: BoxDecoration(color: Theme.of(context).cardColor,
                  border: Border.all(width: 2, color: AppTheme.primary)
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: settingProvider.themeMode,
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text(
                        'Light',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppTheme.primary),
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text(
                        'Dark',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppTheme.primary),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    settingProvider.changeTheme(value);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    )
      ;
  }
}
