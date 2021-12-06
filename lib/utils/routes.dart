import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/pages/comenzar/bienaventurados_page.dart';
import 'package:bienaventurados/pages/comenzar/iniciar_aventura_page.dart';
import 'package:bienaventurados/pages/configuraciones/cuenta/actualizar_contrasena_page.dart';
import 'package:bienaventurados/pages/configuraciones/cuenta/actualizar_correo_page.dart';
import 'package:bienaventurados/pages/configuraciones/cuenta/actualizar_nombre_page.dart';
import 'package:bienaventurados/pages/configuraciones/cuenta/cuenta_configuraciones_page.dart';
import 'package:bienaventurados/pages/configuraciones/general/general_configuraciones_page.dart';
import 'package:bienaventurados/pages/configuraciones/general/informacion_page.dart';
import 'package:bienaventurados/pages/configuraciones/general/notificaciones_configuracion_page.dart';
import 'package:bienaventurados/pages/configuraciones/general/tema_configuracion_page.dart';
import 'package:bienaventurados/pages/configuraciones/legal/legal_configuraciones_page.dart';
import 'package:bienaventurados/pages/construir/construir_page.dart';
import 'package:bienaventurados/pages/construir/editar_page.dart';
import 'package:bienaventurados/pages/inicio/dashboard.dart';
import 'package:bienaventurados/pages/perfil/redescubre_page.dart';
import 'package:bienaventurados/pages/taller/taller_page.dart';
import 'package:bienaventurados/utils/fade_transition_route.dart';
import 'package:bienaventurados/utils/slide_transition_route.dart';
import 'package:bienaventurados/pages/inicio/avioncito_page.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String inicioPage = 'inicioPage';
const String comenzarPage = 'comenzarPage';
const String bienaventuradosPage = 'bienaventuradosPage';
const String iniciarAventuraPage = 'iniciarAventuraPage';
const String construirPage = 'construirPage';
const String informacionPage = 'informacionPage';
const String tallerPage = 'tallerPage';
const String editarPage = 'editarPage';
const String configuracionesPage = 'configuracionesPage';
const String perfilPage = 'perfilPage';
const String redescubrePage = 'redescubrePage';
const String avioncitoPage = 'avioncitoPage';
const String guardadosPage = 'guardadosPage';
const String temaConfiguracionPage = 'temaConfiguracionPage';
const String notificacionesConfiguracionPage = 'notificacionesConfiguracionPage';
const String generalConfiguracionPage = 'generalConfiguracionPage';
const String cuentaConfiguracionPage = 'cuentaConfiguracionPage';
const String legalConfiguracionPage = 'legalConfiguracionPage';
const String actualizarNombrePage = 'actualizarNombrePage';
const String actualizarContrasenaPage = 'actualizarContrasenaPage';
const String actualizarCorreoPage = 'actualizarCorreoPage';
const String basePage = 'basePage';

class Routes {
  static Route<dynamic> generateRoute (RouteSettings settings) {
    
    switch (settings.name) {
      case (dashboardPage):
        return FadeTransitionRoute(widget: DashboardPage());
      case (tallerPage):
        return SlideLeftTransitionRoute(widget: TallerPage());
      case (avioncitoPage):
        final args = settings.arguments;
        Avioncito avioncito = args as Avioncito;
        return SlideUpTransitionRoute(widget: AvioncitoPage(avioncito: avioncito));
      // case (guardadosPage):
      //   return SlideLeftTransitionRoute(widget: GuardadosPage());
      case (editarPage):
        final args = settings.arguments;
        Avioncito avioncito = args as Avioncito;
        return FadeTransitionRoute(widget: EditarPage(id: avioncito.id, frase: avioncito.frase, santo: avioncito.santo, reflexion: avioncito.reflexion, tag: avioncito.tag, usuario: avioncito.usuario,));
      case (informacionPage):
        return SlideLeftTransitionRoute(widget: InformacionPage());
      case (iniciarAventuraPage):
        return SlideLeftTransitionRoute(widget: IniciarAventuraPage());
      case (construirPage):
        final args = settings.arguments;
        VoidCallback openDrawer = args as VoidCallback;
        return SlideLeftTransitionRoute(widget: ConstruirPage(openDrawer: openDrawer));
      case (temaConfiguracionPage):
        return SlideLeftTransitionRoute(widget: TemaConfiguracionPage());
      case (notificacionesConfiguracionPage):
        return SlideLeftTransitionRoute(widget: NotificacionesConfiguracionPage());
      case (bienaventuradosPage):
        return SlideLeftTransitionRoute(widget: BienaventuradosPage());
      case (redescubrePage):
        final args = settings.arguments as Avioncito;
        return SlideUpTransitionRoute(widget: RedescubrePage(avioncitoGuardado: args));
      // case (configuracionesPage):
      //   return FadeTransitionRoute(widget: ConfiguracionesPage());
      // case (perfilPage):
      //   return FadeTransitionRoute(widget: PerfilPage());
      case (generalConfiguracionPage):
        return SlideLeftTransitionRoute(widget: GeneralConfiguracionesPage());
      case (cuentaConfiguracionPage):
        return SlideLeftTransitionRoute(widget: CuentaConfiguracionesPage());
      case (actualizarCorreoPage):
        return SlideLeftTransitionRoute(widget: ActualizarCorreoPage());
      case (actualizarNombrePage):
        return SlideLeftTransitionRoute(widget: ActualizarNombrePage());
      case (actualizarContrasenaPage):
        return SlideLeftTransitionRoute(widget: ActualizarContrasenaPage());
      case (legalConfiguracionPage):
        return SlideLeftTransitionRoute(widget: LegalConfiguracionesPage());
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}