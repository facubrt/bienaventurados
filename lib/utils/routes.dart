import 'package:bienaventurados/models/avioncito_model.dart';
import 'package:bienaventurados/models/guardados_model.dart';
import 'package:bienaventurados/pages/comenzar/comenzar_page.dart';
import 'package:bienaventurados/pages/comenzar/iniciar_sesion.dart';
import 'package:bienaventurados/pages/comenzar/registrarse.dart';
import 'package:bienaventurados/pages/construir/construir.dart';
import 'package:bienaventurados/pages/construir/editar.dart';
import 'package:bienaventurados/pages/informacion/informacion_page.dart';
import 'package:bienaventurados/pages/inicio/dashboard.dart';
import 'package:bienaventurados/pages/perfil/guardados_page.dart';
import 'package:bienaventurados/pages/perfil/redescubre_page.dart';
import 'package:bienaventurados/pages/taller/taller_page.dart';
import 'package:bienaventurados/utils/fade_transition_route.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String inicioPage = 'inicioPage';
const String comenzarPage = 'comenzarPage';
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

class Routes {
  static Route<dynamic> generateRoute (RouteSettings settings) {
    
    switch (settings.name) {
      case (dashboardPage):
        return FadeTransitionRoute(widget: DashboardPage());
      case (tallerPage):
        return FadeTransitionRoute(widget: TallerPage());
      case (guardadosPage):
        return FadeTransitionRoute(widget: GuardadosPage());
      case (editarPage):
        final args = settings.arguments;
        Avioncito avioncito = args as Avioncito;
        return FadeTransitionRoute(widget: EditarPage(frase: avioncito.frase, santo: avioncito.santo, reflexion: avioncito.reflexion, tag: avioncito.tag, usuario: 'Ruben'));
      case (informacionPage):
        return FadeTransitionRoute(widget: InformacionPage());
      case (comenzarPage):
        return FadeTransitionRoute(widget: ComenzarPage());
      case (iniciarSesionPage):
        return FadeTransitionRoute(widget: IniciarSesionPage());
      case (registrarsePage):
        return FadeTransitionRoute(widget: RegistrarsePage());
      case (construirPage):
        return FadeTransitionRoute(widget: ConstruirPage());
      case (redescubrePage):
        final args = settings.arguments as Guardados;
        return FadeTransitionRoute(widget: RedescubrePage(avioncitoGuardado: args));
      // case (configuracionesPage):
      //   return FadeTransitionRoute(widget: ConfiguracionesPage());
      // case (perfilPage):
      //   return FadeTransitionRoute(widget: PerfilPage());
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}