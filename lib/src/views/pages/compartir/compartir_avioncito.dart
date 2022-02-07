import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/data/repositories/preferencias_usuario.dart';
import 'package:bienaventurados/src/logic/providers/compartir_provider.dart';
import 'package:bienaventurados/src/views/pages/compartir/widget/slide_dots.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class CompartirPage extends StatefulWidget {
  final Avioncito avioncito;

  const CompartirPage({Key? key, required this.avioncito}) : super(key: key);

  @override
  State<CompartirPage> createState() => _CompartirPageState();
}

class _CompartirPageState extends State<CompartirPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  ScreenshotController screenshot11Controller = ScreenshotController();
  ScreenshotController screenshot916Controller = ScreenshotController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final compartirProvider = Provider.of<CompartirProvider>(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(
                Iconsax.close_square,
                size: MediaQuery.of(context).size.width * 0.06,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView(
              onPageChanged: _onPageChanged,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                avioncito916Widget(context),
                avioncito11Widget(context),
              ],
            ),
            SizedBox(height: 60),
            Container(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 2; i++)
                  if (i == _currentPage) SlideDots(true) else SlideDots(false)
              ],
            )),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
          child: compartirProvider.descargando
              ? Text(
                  'Descargando avioncito...',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                )
              : compartirProvider.compartiendo
                  ? Text(
                      'Compartiendo avioncito...',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4),
                          ),
                    )
                  : Text(
                      'Desliza hacia arriba para hacer volar estas palabras, o descargalas deslizando hacia abajo',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.4),
                          )),
        )
        //compartirBoton(context),
        );
  }

  Widget avioncito11Widget(BuildContext context) {
    final prefs = PreferenciasUsuario();

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: Column(
          children: [
            Spacer(),
            GestureDetector(
              onVerticalDragStart: (details) {
                final compartirProvider =
                    Provider.of<CompartirProvider>(context, listen: false);
                compartirProvider.startPosition(details);
              },
              onVerticalDragUpdate: (details) {
                final compartirProvider =
                    Provider.of<CompartirProvider>(context, listen: false);
                compartirProvider.updatePosition(details);
              },
              onVerticalDragEnd: (details) {
                final compartirProvider =
                    Provider.of<CompartirProvider>(context, listen: false);
                compartirProvider.endPosition(screenshot11Controller,
                    widget.avioncito.frase!, widget.avioncito.santo!);
              },
              child: Builder(builder: (context) {
                final compartirProvider =
                    Provider.of<CompartirProvider>(context);
                final position = compartirProvider.position;
                final milliseconds = compartirProvider.isDragging ? 0 : 400;
                return AnimatedContainer(
                  duration: Duration(milliseconds: milliseconds),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..translate(position.dx, position.dy),
                  child: Screenshot(
                    controller: screenshot11Controller,
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                              width: 2,
                              color: Theme.of(context).primaryColorDark),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06),
                            prefs.modoNoche
                                ? Image.asset(
                                    'assets/images/isotipo-claro.png',
                                    height: 40,
                                  )
                                : Image.asset(
                                    'assets/images/isotipo-oscuro.png',
                                    height: 40,
                                  ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                widget.avioncito.frase!,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.046,
                                    ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.1),
                            Container(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Text(
                                    widget.avioncito.santo!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.032,
                                        ),
                                    textAlign: TextAlign.end,
                                  ),
                                )),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget avioncito916Widget(BuildContext context) {
    final prefs = PreferenciasUsuario();
    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0,
        right: 40.0,
        bottom: 40.0,
        top: 20,
      ),
      child: GestureDetector(
        onVerticalDragStart: (details) {
          final compartirProvider =
              Provider.of<CompartirProvider>(context, listen: false);
          compartirProvider.startPosition(details);
        },
        onVerticalDragUpdate: (details) {
          final compartirProvider =
              Provider.of<CompartirProvider>(context, listen: false);
          compartirProvider.updatePosition(details);
        },
        onVerticalDragEnd: (details) {
          final compartirProvider =
              Provider.of<CompartirProvider>(context, listen: false);
          compartirProvider.endPosition(screenshot916Controller,
              widget.avioncito.frase!, widget.avioncito.santo!);
        },
        child: Builder(
          builder: (context) {
            final compartirProvider = Provider.of<CompartirProvider>(context);
            final position = compartirProvider.position;
            final milliseconds = compartirProvider.isDragging ? 0 : 400;
            return AnimatedContainer(
              duration: Duration(milliseconds: milliseconds),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()
                ..translate(position.dx, position.dy),
              child: Screenshot(
                controller: screenshot916Controller,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.74,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        prefs.modoNoche
                            ? Image.asset(
                                'assets/images/isotipo-horizontal-claro.png',
                                height: 50,
                              )
                            : Image.asset(
                                'assets/images/isotipo-horizontal-oscuro.png',
                                height: 50,
                              ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            widget.avioncito.frase!,
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * 0.08),
                        Container(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                widget.avioncito.santo!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.036,
                                    ),
                                textAlign: TextAlign.end,
                              ),
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
