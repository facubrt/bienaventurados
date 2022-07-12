import 'package:bienaventurados/src/constants/constants.dart';
import 'package:bienaventurados/src/models/logro_model.dart';
import 'package:bienaventurados/src/providers/providers.dart';
import 'package:bienaventurados/src/utils/utilities.dart';
import 'package:bienaventurados/src/views/widgets/floating_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AchievementsPage extends StatefulWidget {
  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage>
    with TickerProviderStateMixin {
  final tabs = [ACHIEVEMENTS_COMMONS, ACHIEVEMENTS_RARES];

  @override
  Widget build(BuildContext context) {
    //TabController tabController = TabController(initialIndex: 0, vsync: this, length: tabs.length);
    ColorFilter greyscaleFilter = getGreyScaleFilter();

    final achievementProvider =
        Provider.of<AchievementProvider>(context, listen: false);
    // final prefs = UserPreferences();
    Box box = achievementProvider.getAchievements();
    return Scaffold(
      appBar: AppBar(
        //title: Text('Logros', style: Theme.of(context).textTheme.headline4),
        elevation: 0.0,
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(40.0),
              sliver: SliverToBoxAdapter(
                child: Text(ACHIEVEMENTS_PAGE_TITLE,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize:
                              MediaQuery.of(context).size.width * SCALE_H2,
                        )),
              ),
            ),
            SliverPadding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  ACHIEVEMENTS_PAGE_TEXT,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: MediaQuery.of(context).size.width * SCALE_H4,
                      ),
                ),
              ),
            ),
            // SOLO PARA VERSION 1.4.4 - SINCRONIZACION CON LA NUBE
            // (!prefs.collectionsSync && prefs.appVersion == '1.4.4')
            //     ? SliverPadding(
            //         padding: const EdgeInsets.only(
            //             left: 20.0, right: 20, bottom: 20),
            //         sliver: SliverToBoxAdapter(
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(BORDER_RADIUS),
            //               color: Theme.of(context).colorScheme.tertiary,
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.all(20.0),
            //               child: Column(
            //                 children: [
            //                   Text(
            //                     '¡Sincroniza tus insignias!',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .subtitle1!
            //                         .copyWith(color: ColorPalette.primaryLight),
            //                   ),
            //                   SizedBox(
            //                     height:
            //                         MediaQuery.of(context).size.width * 0.04,
            //                   ),
            //                   Text(
            //                     'Ya no más insignias perdidos cuando cambies de sesión. ¡Que emoción!',
            //                     style: Theme.of(context)
            //                         .textTheme
            //                         .bodyText1!
            //                         .copyWith(
            //                             fontSize: 16,
            //                             color: ColorPalette.primaryLight),
            //                   ),
            //                   SizedBox(
            //                     height:
            //                         MediaQuery.of(context).size.width * 0.04,
            //                   ),
            //                   TextButton(
            //                     style: ButtonStyle(
            //                       backgroundColor:
            //                           MaterialStateProperty.all<Color>(
            //                               ColorPalette.primaryDark
            //                                   .withOpacity(0.2)),
            //                     ),
            //                     child: Padding(
            //                       padding: const EdgeInsets.symmetric(
            //                           horizontal: 10.0, vertical: 20.0),
            //                       child: Text(
            //                         'Sincronizar',
            //                         style: Theme.of(context)
            //                             .textTheme
            //                             .subtitle1!
            //                             .copyWith(
            //                               fontSize: MediaQuery.of(context)
            //                                       .size
            //                                       .width *
            //                                   0.03,
            //                               color: ColorPalette.primaryLight,
            //                             ),
            //                       ),
            //                     ),
            //                     onPressed: () async {
            //                       //UPDATE ALL COLLECTION AND ACHIEVEMENT
            //                       final authProvider =
            //                           Provider.of<AuthProvider>(context,
            //                               listen: false);
            //                       final achievementProvider =
            //                           Provider.of<AchievementProvider>(context,
            //                               listen: false);
            //                       achievementProvider.openAchievements();
            //                       final achievements = Map<String, bool>();

            //                       Box box =
            //                           achievementProvider.getAchievements();
            //                       box.values.forEach((achievement) {
            //                         if (achievement.desbloqueado) {
            //                           achievements.addAll({
            //                             '${achievement.titulo}':
            //                                 achievement.desbloqueado
            //                           });
            //                         }
            //                         prefs.achievementsSync = true;
            //                       });
            //                       //ACA SE LLAMA A LA FUNCION QUE SUBE A LA NUBE EL ARRAY
            //                       achievementProvider.updateAllAchievementsData(
            //                           authProvider.user.uid!, achievements);
            //                     },
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       )
            //     : SliverToBoxAdapter(child: SizedBox.shrink()),
            /////////////////////////////////////////
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (contex, index) {
                    return box.getAt(index).desbloqueado
                        ? InkWell(
                            onTap: () {
                              openItem(context, box.getAt(index));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            ))
                        : ColorFiltered(
                            colorFilter: greyscaleFilter,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                box.getAt(index).img,
                              ),
                            ),
                          );
                  },
                  childCount: box.values.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //     Column(children: [
    //       Padding(
    //         padding: const EdgeInsets.all(30.0),
    //         child: Text('Consigue todas las insignias',
    //             style: Theme.of(context).textTheme.headline1!.copyWith(
    //                   fontSize: MediaQuery.of(context).size.width * 0.08,
    //                 )),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(30.0),
    //         child: Text(
    //           'Cada pequeño paso, cada simple acción merece ser celebrada.',
    //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
    //                 color: Theme.of(context).primaryColorDark,
    //                 fontSize: MediaQuery.of(context).size.width * 0.04,
    //               ),
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 30.0, right: 30.0),
    //         child: TabBar(
    //           indicator: BoxDecoration(
    //             color: Theme.of(context).primaryColorDark,
    //             borderRadius: BorderRadius.circular(100),
    //           ),
    //           isScrollable: true,
    //           controller: tabController,
    //           labelColor: Theme.of(context).primaryColor,
    //           unselectedLabelColor: Theme.of(context).primaryColorDark,
    //           tabs: tabs
    //               .map(
    //                 (coleccion) => Tab(
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 5.0),
    //                     child: Text(
    //                       coleccion.toUpperCase(),
    //                       style: TextStyle(
    //                         fontFamily: 'Gotham',
    //                         fontSize: MediaQuery.of(context).size.width * 0.03,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               )
    //               .toList(),
    //         ),
    //       ),
    //       Expanded(
    //         child: TabBarView(
    //           controller: tabController,
    //           children: [
    //             LogrosComunes('Comunes'),
    //             ProximamenteWidget(),
    //           ],
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
  }

  void openItem(BuildContext context, Logro? achievement) {
    showFloatingModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
      builder: (context) {
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
                          achievement!.img,
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
                              achievement.titulo,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Text(
                  achievement.objetivo,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color:
                            Theme.of(context).primaryColorDark.withOpacity(0.4),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  achievement.descripcion,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.036),
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
                  child: Text(ACHIEVEMENT_UNLOCKED_BTN,
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
