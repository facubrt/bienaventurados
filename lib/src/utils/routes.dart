import 'package:bienaventurados/src/models/avioncito_model.dart';
import 'package:bienaventurados/src/views/pages/comenzar/bienaventurados_page.dart';
import 'package:bienaventurados/src/views/pages/comenzar/iniciar_aventura_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/cuenta/actualizar_contrasena_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/cuenta/actualizar_correo_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/cuenta/actualizar_nombre_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/cuenta/cuenta_configuraciones_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/general/general_configuraciones_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/general/informacion_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/general/notificaciones_configuracion_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/general/tema_configuracion_page.dart';
import 'package:bienaventurados/src/views/pages/configuraciones/legal/legal_configuraciones_page.dart';
import 'package:bienaventurados/src/views/pages/construir/editar_page.dart';
import 'package:bienaventurados/src/views/pages/dashboard/dashboard.dart';
import 'package:bienaventurados/src/views/pages/perfil/colecciones_page.dart';
import 'package:bienaventurados/src/views/pages/perfil/logros_page.dart';
import 'package:bienaventurados/src/views/pages/studio/studio_page.dart';
import 'package:bienaventurados/src/utils/transitions.dart';
import 'package:bienaventurados/src/views/pages/paperplane/paperplane_page.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String todayPage = 'todayPage';
const String bienaventuradosPage = 'bienaventuradosPage';
const String getStartedPage = 'getStartedPage';
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
      case (studioPage):
        return SlideLeftTransitionRoute(widget: StudioPage());
      case (paperplanePage):
        final args = settings.arguments;
        Avioncito paperplane = args as Avioncito;
        return SlideUpTransitionRoute(
            widget: PaperplanePage(paperplane: paperplane));
      case (editPage):
        final args = settings.arguments;
        Avioncito avioncito = args as Avioncito;
        return FadeTransitionRoute(
            widget: EditarPage(
          id: avioncito.id,
          frase: avioncito.frase,
          santo: avioncito.santo,
          reflexion: avioncito.reflexion,
          tag: avioncito.tag,
          usuario: avioncito.usuario,
        ));
      case (informationPage):
        return SlideLeftTransitionRoute(widget: InformacionPage());
      case (getStartedPage):
        return SlideLeftTransitionRoute(widget: IniciarAventuraPage());
      case (collectionsPage):
        return SlideLeftTransitionRoute(widget: ColeccionesPage());
      case (achievementsPage):
        return SlideLeftTransitionRoute(widget: LogrosPage());
      case (themeConfigPage):
        return SlideLeftTransitionRoute(widget: TemaConfiguracionPage());
      case (notiConfigPage):
        return SlideLeftTransitionRoute(
            widget: NotificacionesConfiguracionPage());
      case (generalConfigPage):
        return SlideLeftTransitionRoute(widget: GeneralConfiguracionesPage());
      case (accountConfigPage):
        return SlideLeftTransitionRoute(widget: CuentaConfiguracionesPage());
      case (updateEmailPage):
        return SlideLeftTransitionRoute(widget: ActualizarCorreoPage());
      case (updateNamePage):
        return SlideLeftTransitionRoute(widget: ActualizarNombrePage());
      case (updatePasswordPage):
        return SlideLeftTransitionRoute(widget: ActualizarContrasenaPage());
      case (legalPage):
        return SlideLeftTransitionRoute(widget: LegalConfiguracionesPage());
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}
