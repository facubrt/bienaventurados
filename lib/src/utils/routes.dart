import 'package:bienaventurados/src/models/paperplane_model.dart';
import 'package:bienaventurados/src/views/pages/labPage/lab_page.dart';
import 'package:bienaventurados/src/views/pages/initialPage/bienaventurados_page.dart';
import 'package:bienaventurados/src/views/pages/initialPage/initial_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/account/update_password_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/account/update_email_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/account/update_name_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/account/account_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/general/general_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/general/information_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/general/notifications_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/general/theme_page.dart';
import 'package:bienaventurados/src/views/pages/configPage/legal/legal_page.dart';
import 'package:bienaventurados/src/views/pages/buildPage/edit_page.dart';
import 'package:bienaventurados/src/views/pages/dashboardPage/dashboard.dart';
import 'package:bienaventurados/src/views/pages/profilePage/collections_page.dart';
import 'package:bienaventurados/src/views/pages/profilePage/achievements_page.dart';
import 'package:bienaventurados/src/views/pages/garagePage/garage_page.dart';
import 'package:bienaventurados/src/utils/transitions.dart';
import 'package:bienaventurados/src/views/pages/paperplanePage/paperplane_page.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String todayPage = 'todayPage';
const String bienaventuradosPage = 'bienaventuradosPage';
const String initialPage = 'initialPage';
const String buildPage = 'buildPage';
const String collectionsPage = 'collectionsPage';
const String achievementsPage = 'achievementsPage';
const String informationPage = 'informationPage';
const String studioPage = 'studioPage';
const String editPage = 'editPage';
const String configPage = 'configPage';
const String profilePage = 'profilePage';
const String rediscoverPage = 'rediscoverPage';
const String paperplanePage = 'paperplanePage';
const String savedPage = 'savedPage';
const String themeConfigPage = 'themeConfigPage';
const String notiConfigPage = 'notiConfigPage';
const String generalConfigPage = 'generalConfigPage';
const String accountConfigPage = 'accountConfigPage';
const String legalPage = 'legalPage';
const String updateNamePage = 'updateNamePage';
const String updatePasswordPage = 'updatePasswordPage';
const String updateEmailPage = 'updateEmailPage';
const String creatorPage = 'creatorPage';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // MAIN PAGES
      case (bienaventuradosPage):
        return SlideLeftTransitionRoute(widget: BienaventuradosPage());
      case (dashboardPage):
        return FadeTransitionRoute(widget: DashboardPage());
      // case (buildPage):
      //   final args = settings.arguments;
      //   VoidCallback openDrawer = args as VoidCallback;
      //   return SlideLeftTransitionRoute(
      //       widget: buildPage(openDrawer: openDrawer));
      // case (configPage):
      //   return FadeTransitionRoute(widget: configPage());
      // case (perfilPage):
      //   final args = settings.arguments;
      //   VoidCallback openDrawer = args as VoidCallback;
      //   return FadeTransitionRoute(widget: PerfilPage(openDrawer: openDrawer));

      // OTHERS PAGES
      case (creatorPage):
        return SlideLeftTransitionRoute(widget: LabPage());
      case (studioPage):
        return SlideLeftTransitionRoute(widget: GaragePage());
      case (paperplanePage):
        final args = settings.arguments;
        Paperplane paperplane = args as Paperplane;
        return SlideUpTransitionRoute(
            widget: PaperplanePage(paperplane: paperplane));
      case (editPage):
        final args = settings.arguments;
        Paperplane paperplane = args as Paperplane;
        return FadeTransitionRoute(
            widget: EditPage(
          paperplane: paperplane,
        ));
      case (informationPage):
        return SlideLeftTransitionRoute(widget: InformationPage());
      case (initialPage):
        return SlideLeftTransitionRoute(widget: InitialPage());
      case (collectionsPage):
        return SlideLeftTransitionRoute(widget: CollectionsPage());
      case (achievementsPage):
        return SlideLeftTransitionRoute(widget: AchievementsPage());
      case (themeConfigPage):
        return SlideLeftTransitionRoute(widget: ThemePage());
      case (notiConfigPage):
        return SlideLeftTransitionRoute(widget: NotificationsPage());
      case (generalConfigPage):
        return SlideLeftTransitionRoute(widget: GeneralPage());
      case (accountConfigPage):
        return SlideLeftTransitionRoute(widget: AccountPage());
      case (updateEmailPage):
        return SlideLeftTransitionRoute(widget: UpdateEmailPage());
      case (updateNamePage):
        return SlideLeftTransitionRoute(widget: UpdateNamePage());
      case (updatePasswordPage):
        return SlideLeftTransitionRoute(widget: UpdatePasswordPage());
      case (legalPage):
        return SlideLeftTransitionRoute(widget: LegalPage());
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}
