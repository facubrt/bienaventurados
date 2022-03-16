import 'package:bienaventurados/src/models/logro_model.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class LogrosComunes extends StatelessWidget {
  final String scrollKey;
  const LogrosComunes(this.scrollKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logroProvider = Provider.of<AchievementProvider>(context);
    Box box = logroProvider.getAchievements();
    const ColorFilter greyscaleFilter = ColorFilter.matrix(<double>[
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      0.5,
      0,
    ]);
    List logros = [];
    box.values.where((logro) => logro.tipo == 'Fiesta').forEach(
      (logro) {
        logros.add(logro);
      },
    );
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 30),
        key: PageStorageKey(scrollKey),
        itemCount: logros.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => logros[index].tipo == 'Fiesta'
            ? logros[index].desbloqueado
                ? InkWell(
                    onTap: () {
                      showFloatingModalBottomSheet<bool?>(
                          backgroundColor: Theme.of(context).primaryColor,
                          context: context,
                          builder: (context) {
                            return abrirLogro(context, logros[index]);
                          });
                      //abrirColeccion(context, logros[index]);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        logros[index].img,
                      ),
                    ))
                : ColorFiltered(
                    colorFilter: greyscaleFilter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        logros[index].img,
                      ),
                    ),
                  )
            : SizedBox.shrink(),
      ),
    );
  }

    Widget abrirLogro(BuildContext context, Logro? logro) {
    return Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Iconsax.close_square,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.height * 0.1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          logro!.img,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    Flexible(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logro.titulo,
                              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.06),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  logro.objetivo,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  logro.descripcion,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MediaQuery.of(context).size.width * 0.036),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).primaryColorDark.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Desbloqueado',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: MediaQuery.of(context).size.width * 0.03, color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ],
          ),
        );
  }
}
