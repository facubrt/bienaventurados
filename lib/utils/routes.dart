import 'package:bienaventurados/pages/comenzar/comenzar_page.dart';
import 'package:bienaventurados/pages/comenzar/iniciar_sesion.dart';
import 'package:bienaventurados/pages/comenzar/registrarse.dart';
import 'package:bienaventurados/pages/configuraciones/configuraciones_page.dart';
import 'package:bienaventurados/pages/construir/construir.dart';
import 'package:bienaventurados/pages/informacion/informacion_page.dart';
import 'package:bienaventurados/pages/inicio/dashboard.dart';
import 'package:bienaventurados/utils/fade_transition_route.dart';
import 'package:flutter/material.dart';

const String dashboardPage = 'dashboardPage';
const String inicioPage = 'inicioPage';
const String configuracionesPage = 'configuracionesPage';
const String comenzarPage = 'comenzarPage';
const String iniciarSesionPage = 'iniciarSesionPage';
const String registrarsePage = 'registrarsePage';
const String construirPage = 'construirPage';
const String informacionPage = 'informacionPage';

class Routes {
  static Route<dynamic> generateRoute (RouteSettings settings) {
    
    switch (settings.name) {
      case (dashboardPage):
        return FadeTransitionRoute(widget: DashboardPage());
      case (configuracionesPage):
        return FadeTransitionRoute(widget: ConfiguracionesPage());
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
      default:
        return FadeTransitionRoute(widget: DashboardPage());
    }
  }
}