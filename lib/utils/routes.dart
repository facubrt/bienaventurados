import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/pages/comenzar/bienaventurados_page.dart';
import 'package:bienaventurados/pages/comenzar/comenzar_page.dart';
import 'package:bienaventurados/pages/comenzar/iniciar_sesion_page.dart';
import 'package:bienaventurados/pages/comenzar/registrarse_page.dart';
import 'package:bienaventurados/pages/configuraciones/informacion_page.dart';
import 'package:bienaventurados/pages/configuraciones/notificaciones_configuracion_page.dart';
import 'package:bienaventurados/pages/configuraciones/tema_configuracion_page.dart';
import 'package:bienaventurados/pages/construir/construir.dart';
import 'package:bienaventurados/pages/construir/editar.dart';
import 'package:bienaventurados/pages/inicio/dashboard.dart';
import 'package:bienaventurados/pages/perfil/guardados_page.dart';
import 'package:bienaventurados/pages/perfil/redescubre_page.dart';
import 'package:bienaventurados/pages/taller/taller_page.dart';
import 'package:bienaventurados/utils/fade_transition_route.dart';
import 'package:bienaventurados/utils/slide_transition_route.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String inicioPage = 'inicioPage';
const String comenzarPage = 'comenzarPage';
const String bienaventuradosPage = 'bienaventuradosPage';
const String iniciarSesionPage = 'iniciarSesionPage';
const String registrarsePage = 'registrarsePage';
const String construirPage = 'construirPage';
const String informacionPage = 'informacionPage';
const String tallerPage = 'tallerPage';
const String editarPage = 'editarPage';
const String configuracionesPage = 'configuracionesPage';
const String perfilPage = 'perfilPage';
const String redescubrePage = 'redescubrePage';
const String guardadosPage = 'guardadosPage';
const String temaConfiguracionPage = 'temaConfiguracionPage';
const String notificacionesConfiguracionPage = 'notificacionesConfiguracionPage';

class Routes {
  static Route<dynamic> generateRoute (RouteSettings settings) {
    
    switch (settings.name) {
      case (dashboardPage):
        return FadeTransitionRoute(widget: DashboardPage());
      case (tallerPage):
        return SlideLeftTransitionRoute(widget: TallerPage());
      case (guardadosPage):
        return SlideLeftTransitionRoute(widget: GuardadosPage());
      case (editarPage):
        final args = settings.arguments;
        Avioncito avioncito = args as Avioncito;
        return FadeTransitionRoute(widget: EditarPage(id: avioncito.id, frase: avioncito.frase, santo: avioncito.santo, reflexion: avioncito.reflexion, tag: avioncito.tag, usuario: avioncito.usuario,));
      case (informacionPage):
        return SlideLeftTransitionRoute(widget: InformacionPage());
      case (comenzarPage):
        return SlideLeftTransitionRoute(widget: ComenzarPage());
      case (iniciarSesionPage):
        return SlideLeftTransitionRoute(widget: IniciarSesionPage());
      case (registrarsePage):
        return SlideLeftTransitionRoute(widget: RegistrarsePage());
      case (construirPage):
        return SlideLeftTransitionRoute(widget: ConstruirPage());
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
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}