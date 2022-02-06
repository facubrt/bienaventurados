import 'package:bienaventurados/src/core/theme/colores.dart';
import 'package:bienaventurados/src/data/models/avioncito_model.dart';
import 'package:bienaventurados/src/views/pages/compartir/widget/slide_dots.dart';
import 'package:bienaventurados/src/views/pages/inicio/widgets/avioncito_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CompartirPage extends StatefulWidget {
  final Avioncito avioncito;

  const CompartirPage({Key? key, required this.avioncito}) : super(key: key);

  @override
  State<CompartirPage> createState() => _CompartirPageState();
}

class _CompartirPageState extends State<CompartirPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
          ))
        ],
      ),
      bottomNavigationBar: compartirBoton(context),
    );
  }

  Widget avioncito11Widget(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: Column(
          children: [
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(width: 2, color: Colores.acento),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Image.asset(
                    'assets/images/isotipo-oscuro.png',
                    height: 40,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      widget.avioncito.frase!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                          ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          widget.avioncito.santo!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.036,
                              ),
                          textAlign: TextAlign.end,
                        ),
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget avioncito916Widget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0,
        right: 40.0,
        bottom: 40.0,
        top: 20,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.74,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(width: 2, color: Colores.acento),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Image.asset(
              'assets/images/isotipo-horizontal.png',
              height: 50,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                widget.avioncito.frase!,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.06,
                    ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.08),
            Container(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    widget.avioncito.santo!,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.036,
                        ),
                    textAlign: TextAlign.end,
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget compartirBoton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110.0, vertical: 20.0),
      child: TextButton.icon(
        onPressed: () {
          print('TAP');
        },
        icon: Icon(
          Iconsax.send_2,
          color: Theme.of(context).primaryColor,
          size: 26,
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 20.0, bottom: 20.0),
          child: Text(
            'Hacer volar',
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
