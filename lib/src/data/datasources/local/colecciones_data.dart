import 'package:bienaventurados/src/data/models/coleccion_model.dart';

class Colecciones {
  static final colecciones = [
    // COLECCION DE PRUEBA
    Coleccion(
      id: 0,
      dia: DateTime.now().day,
      mes: DateTime.now().month,
      titulo: 'Coleccion de PRUEBA',
      img: 'assets/images/colecciones/solemnidad-01.png',
      tipo: 'Solemnidad',
      descripcion: 'descripcion',
      desbloqueado: false,
    ),
    //
    Coleccion(
      id: 1,
      mes: 01,
      dia: 01,
      titulo: 'Santa María Madre de Dios',
      img: 'assets/images/colecciones/solemnidad-01.png',
      tipo: 'Solemnidad',
      descripcion:
          'Se conmemora en este día el dogma mariano de la Maternidad Divina, y se la considera la festividad más importante en honor de María, ya que toda su vida y sus dones personales estuvieron orientados a ser la madre de Jesús.\n\nTambién nos recuerda que el mismo Dios nos la regala como Madre de cada uno de nosotros.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 2,
      dia: 06,
      mes: 01,
      titulo: 'Epifanía del Señor',
      img: 'assets/images/colecciones/solemnidad-02.png',
      tipo: 'Solemnidad',
      descripcion:
          '"Al ver la estrella, los sabios se llenaron de alegría. Luego entraron en la casa y vieron al niño con María, su madre. Y arrodillándose, lo adoraron. Abrieron sus cofres y le ofrecieron oro, incienso y mirra." (Mt 2, 10-11)\n\nLa Iglesia celebra este hecho bajo la solemnidad de la Epifanía del Señor, es decir, la “manifestación de Dios”. Es un día para adorar al pequeño Dios y celebrar la salvación que trae a personas de todas las culturas.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 3,
      dia: 02,
      mes: 03,
      titulo: 'Miércoles de cenizas',
      img: 'assets/images/colecciones/solemnidad-03.png',
      tipo: 'Solemnidad',
      descripcion:
          'Este día marca el inicio de la Cuaresma. La imposición de la ceniza no es únicamente un gesto recordatorio de la muerte y de nuestra caducidad humana. También es símbolo de comienzo, y todo comienzo tiene una meta al otro extremo. Somos llamados a la vida para que, al final, participemos de la Resurrección de Cristo.\n\nCuando el sacerdote nos marca la frente con la ceniza, nos recuerda nuestra humildad y pequeñez: "Todos caminan hacia una misma meta: todos han salido del polvo y al polvo volverán" (Ecl 3, 20).',
      desbloqueado: false,
    ),
    Coleccion(
      id: 4,
      dia: 19,
      mes: 03,
      titulo: 'San José, esposo de la Virgen María',
      img: 'assets/images/colecciones/solemnidad-04.png',
      tipo: 'Solemnidad',
      descripcion:
          '"En los Evangelios, San José aparece como un hombre fuerte y valiente, trabajador, pero en su alma se percibe una gran ternura, que no es la virtud de los débiles, sino más bien todo lo contrario" (Papa Francisco, Homilía de la Santa Misa, 19 de marzo del 2013).\n\nEn este día se lo recuerda a San José como Padre de la Sagrada Familia y Patrono de la Iglesia Universal. ',
      desbloqueado: false,
    ),
    Coleccion(
      id: 5,
      dia: 25,
      mes: 03,
      titulo: 'La anunciación del Señor',
      img: 'assets/images/colecciones/solemnidad-05.png',
      tipo: 'Solemnidad',
      descripcion:
          'El ángel entró donde estaba María y le dijo: "Dios te salve, llena de gracia, el Señor está contigo". Al oír estas palabras, ella quedó desconcertada y se preguntaba qué significaba tal saludo. El ángel le dijo: "No temas, María, pues Dios te ha concedido su favor. Concebirás y darás a luz un hijo, al que pondrás por nombre Jesús. Él será grande, será llamado Hijo del Altísimo; el Señor Dios le dará el trono de David, su padre, reinará sobre toda la descendencia de Jacob por siempre y su reino no tendrá fin" (...) María dijo: Aquí está la esclava del Señor, que me suceda como tú dices." (Lc 1, 28-33, 38)',
      desbloqueado: false,
    ),
    Coleccion(
      id: 6,
      dia: 10,
      mes: 04,
      titulo: 'Domingo de ramos',
      img: 'assets/images/colecciones/solemnidad-06.png',
      tipo: 'Solemnidad',
      descripcion:
          'El Domingo de Ramos abre solemnemente la Semana Santa, con el recuerdo de las Palmas y de la Pasión, de la entrada de Jesús en Jerusalén y la liturgia de la palabra que evoca la Pasión del Señor en el Evangelio de San Marcos.\n\nLa liturgia de las palmas anticipa en este domingo, llamado pascua florida, el triunfo de la resurrección; mientras que la lectura de la Pasión nos invita a entrar conscientemente en la Semana Santa de la Pasión gloriosa y amorosa de Cristo el Señor.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 7,
      dia: 14,
      mes: 04,
      titulo: 'Jueves Santo',
      img: 'assets/images/colecciones/solemnidad-07.png',
      tipo: 'Solemnidad',
      descripcion:
          'Con la celebración del jueves Santo no solo se abre el Triduo Pascual. En este día nuestra Iglesia Católica conmemora la institución de la Eucaristía en la Última Cena, pero a la vez con las Palabras mismas de Jesucristo "Hagan esto en conmemoración mía", festejamos a todos los valientes que dijeron sí, un sí de corazón como el de María a vivir una vida consagrada a Jesús; y con el gesto del lavatorio de pies también festejamos a todos aquellos que dedican su vida a servir de manera humilde y extraordinaria a los demás cumpliendo el último mandamiento de Cristo.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 8,
      dia: 15,
      mes: 04,
      titulo: 'Viernes Santo',
      img: 'assets/images/colecciones/solemnidad-08.png',
      tipo: 'Solemnidad',
      descripcion: '"Desde el mediodía y hasta la media tarde, toda la tierra quedó sumida en la oscuridad, pues el sol se ocultó. Y la cortina del santuario del templo se rasgó en dos. Entonces Jesús exclamó con fuerza: -¡Padre, en tus manos encomiendo mi espíritu! Y al decir esto, expiró" (Lucas 23, 44-46).\n\nEl Viernes Santo es, fundamentalmente, un día de duelo durante el cual se recuerda la crucifixión de Jesucristo en el Calvario, quien se sacrifica para salvar del pecado a la humanidad y darle la vida eterna.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 9,
      dia: 17,
      mes: 04,
      titulo: 'Domingo de Pascua',
      img: 'assets/images/colecciones/solemnidad-09.png',
      tipo: 'Solemnidad',
      descripcion: '“Si Cristo no hubiera resucitado, vana seria nuestra fe” (I Corintios 15, 14)\n\nEl Domingo de Resurrección o de Pascua es la fiesta más importante para todos los católicos, ya que con la Resurrección de Jesús es cuando adquiere sentido toda nuestra religión.\n\nLa Resurrección es fuente de profunda alegría, es una luz para los hombres y cada cristiano debe irradiar esa misma luz a todos los hombres haciéndolos partícipes de la alegría de la Resurrección por medio de sus palabras, su testimonio y su trabajo apostólico.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 10,
      dia: 24,
      mes: 04,
      titulo: 'Divina Misericordia',
      img: 'assets/images/colecciones/solemnidad-10.png',
      tipo: 'Solemnidad',
      descripcion:
          'La inspiración que condujo a la institución de esta fiesta en la Iglesia surge del deseo que Jesús había comunicado a Sor Faustina: "Deseo que la Fiesta de la Misericordia sea refugio y amparo para todas las almas y, especialmente, para los pobres pecadores. Derramo todo un mar de gracias sobre las almas que se acercan al manantial de Mi misericordia. El alma que se confiese y reciba la Santa Comunión obtendrá el perdón total de las culpas y de las penas. En ese día están abiertas todas las compuertas divinas a través de las cuales fluyen las gracias."',
      desbloqueado: false,
    ),
    Coleccion(
      id: 11,
      dia: 26,
      mes: 05,
      titulo: 'La ascensión del Señor',
      img: 'assets/images/colecciones/solemnidad-11.png',
      tipo: 'Solemnidad',
      descripcion:
          '"Después de hablarles, el Señor Jesús fue elevado al cielo y se sentó a la derecha de Dios" (Mc 16, 19)\n\nDe esta manera, la Ascensión de Cristo al cielo no es el fin de su presencia entre los hombres, sino el comienzo de una nueva forma de estar en el mundo. En este día celebramos un nuevo comienzo en donde nuestra participación es la clave y su presencia acompaña con signos la misión evangelizadora de cada uno de nosotros.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 12,
      dia: 05,
      mes: 06,
      titulo: 'Pentecostés',
      img: 'assets/images/colecciones/solemnidad-12.png',
      tipo: 'Solemnidad',
      descripcion:
          '"Al llegar el día de Pentecostés, estaban todos juntos en el mismo lugar. De repente vino del cielo un ruido, semejante a una ráfaga de viento impetuoso, y llenó toda la casa donde se encontraban. Entonces aparecieron lenguas como de fuego, que se repartían y se posaban sobre cada uno de ellos. Todos quedaron llenos de Espíritu Santo y comenzaron a hablar en lenguas extrañas, según el Espíritu los movía a expresarse." (Hc 2, 1-4)\n\nLa solemnidad de Pentecostés es una de las más importantes en el calendario de la Iglesia y contiene una rica profundidad de significado. Es una fecha para abrir los corazones a la esperanza.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 13,
      dia: 12,
      mes: 06,
      titulo: 'Santísima Trinidad',
      img: 'assets/images/colecciones/solemnidad-13.png',
      tipo: 'Solemnidad',
      descripcion:
          'La solemnidad de la Santísima Trinidad se celebra una semana después de Pentecostés. Es el domingo dedicado en honor a la creencia más fundamental de los cristianos y el dogma central de nuestra Iglesia. Dios es tres personas en una naturaleza. Las tres personas que conforman la Santísima Trinidad son: Padre, Hijo y Espíritu Santo, son un solo Dios, y no pueden estar divididos.\n\nSan Patricio intentó explicar esto de una manera muy sencilla utilizando la imagen de un trébol, el cual tiene tres hojas distintas, pero sin embargo sigue siendo un solo trébol',
      desbloqueado: false,
    ),
    Coleccion(
      id: 14,
      dia: 16,
      mes: 06,
      titulo: 'Corpus Christi',
      img: 'assets/images/colecciones/solemnidad-14.png',
      tipo: 'Solemnidad',
      descripcion:
          'Corpus Christi es la fiesta del Cuerpo y la Sangre de Cristo, de la presencia real de Jesucristo en la Eucaristía, instituida por Jesús durante la última cena que conmemoramos el Jueves Santo.\n\nAdorar a Jesucristo en el Santísimo Sacramento es la respuesta de fe y de amor hacia Aquel que siendo Dios se hizo hombre, hacia nuestro Salvador que nos ha amado hasta dar su vida por nosotros y que sigue amándonos de amor eterno. Es el reconocimiento de la misericordia y majestad del Señor, que eligió el Santísimo Sacramento para quedarse con nosotros hasta el fin de mundo. ',
      desbloqueado: false,
    ),
    Coleccion(
      id: 15,
      dia: 24,
      mes: 06,
      titulo: 'Natividad de San Juan Bautista',
      img: 'assets/images/colecciones/solemnidad-15.png',
      tipo: 'Solemnidad',
      descripcion:
          'Normalmente, La Iglesia celebra la fiesta de los santos en el día de su nacimiento a la vida eterna, que es el día de su muerte. En el caso de San Juan Bautista, se hace una excepción y se celebra el día de su nacimiento. San Juan, el Bautista, fue santificado en el vientre de su madre cuando la Virgen María, embarazada de Jesús, visita a su prima Isabel, según el Evangelio.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 16,
      dia: 24,
      mes: 06,
      titulo: 'Sagrado Corazón de Jesús',
      img: 'assets/images/colecciones/solemnidad-16.png',
      tipo: 'Solemnidad',
      descripcion:
          '"El Corazón de Cristo es símbolo de la fe cristiana, particularmente amado tanto por el pueblo como por los místicos y los teólogos, pues expresa de una manera sencilla y auténtica la buena noticia del amor, resumiendo en sí el misterio de la encarnación y de la redención." (Benedicto XVI)\n\nHoy en día, Jesús nos llama nuevamente a reconocer cómo nos ha amado y a corresponder a su amor, de manera que nuestro corazón pueda parecerse más al suyo.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 17,
      dia: 15,
      mes: 08,
      titulo: 'Asunción de la Virgen María',
      img: 'assets/images/colecciones/solemnidad-17.png',
      tipo: 'Solemnidad',
      descripcion:
          '"En esta solemnidad de la Asunción contemplamos a María: ella nos abre a la esperanza, a un futuro lleno de alegría y nos enseña el camino para alcanzarlo: acoger en la fe a su Hijo; no perder nunca la amistad con él, sino dejarnos iluminar y guiar por su Palabra; seguirlo cada día, incluso en los momentos en que sentimos que nuestras cruces resultan pesadas. María, el arca de la alianza que está en el santuario del cielo, nos indica con claridad luminosa que estamos en camino hacia nuestra verdadera Casa, la comunión de alegría y de paz con Dios”. (Benedicto XVI, Homilía de la Santa Misa, 2010)\n\nLa fiesta de la Asunción de la Santísima Virgen María, se celebra en toda la Iglesia el 15 de agosto. Esta fiesta tiene un doble objetivo: La feliz partida de María de esta vida y la asunción de su cuerpo al cielo.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 18,
      dia: 01,
      mes: 11,
      titulo: 'Todos los Santos',
      img: 'assets/images/colecciones/solemnidad-18.png',
      tipo: 'Solemnidad',
      descripcion:
          'En este día la Iglesia celebra una fiesta solemne por todos los difuntos que, habiendo superado el purgatorio, se han santificado totalmente, han obtenido la visión beatífica y gozan de la vida eterna en la presencia de Dios. No se festeja solo en honor a los beatos o santos que están en la lista de los canonizados; sino también en honor a todos los que no están canonizados pero viven ya en la presencia de Dios.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 19,
      dia: 02,
      mes: 11,
      titulo: 'Todos los fieles difuntos',
      img: 'assets/images/colecciones/solemnidad-19.png',
      tipo: 'Solemnidad',
      descripcion:
          '"Yo soy la resurrección y la vida. El que cree en mí, aunque haya muerto, vivirá; y todo el que esté vivo y crea en mi, jamás morirá" (Jn 11, 25-26)\n\nEsta solemnidad nos llama a recordar y orar por las personas que han dejado su vida terrenal y gozan de la presencia de Dios, así como también por aquellas almas que aún se encuentran en el purgatorio, para que pronto disfruten de la vida eterna.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 20,
      dia: 20,
      mes: 11,
      titulo: 'Cristo Rey',
      img: 'assets/images/colecciones/solemnidad-20.png',
      tipo: 'Solemnidad',
      descripcion:
          '"Yo soy Rey. Para esto nací, para esto vine al mundo, para ser testigo de la Verdad" (Jn 18, 36-37)\n\nCon la Solemnidad de Cristo Rey, la Iglesia Católica concluye el Año Litúrgico recordando a los fieles y al mundo entero que nada -persona o ley humana- está por encima de Dios. Cristo es Señor del tiempo y de la historia, como es Señor de todo lo creado. Esta solemnidad fue instituida por el Papa Pío XI en 1925. Con ella, la Santa Madre Iglesia quiere que volvamos los ojos a Cristo, rey bondadoso y sencillo, y nos dejemos conducir por Él.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 21,
      dia: 08,
      mes: 12,
      titulo: 'Inmaculada Concepción de Santa María Virgen',
      img: 'assets/images/colecciones/solemnidad-21.png',
      tipo: 'Solemnidad',
      descripcion:
          'En esta solemnidad conmemoramos el tercer dogma mariano, en el cual se afirma que, desde el momento de su concepción, María fue preservada del pecado original. Es por esto que toda su vida estuvo llena de la Gracia de Dios, implica que Ella permaneció sin pecado durante toda su vida. A esto los ortodoxos llaman la “panagia”, la toda santa.',
      desbloqueado: false,
    ),
    Coleccion(
      id: 22,
      dia: 25,
      mes: 12,
      titulo: 'Natividad del Señor',
      img: 'assets/images/colecciones/solemnidad-22.png',
      tipo: 'Solemnidad',
      descripcion:
          'Esto es lo que podemos pedir a Jesús para Navidad: la gracia de la pequeñez. "Señor, enséñanos a amar la pequeñez. Ayúdanos a comprender que es el camino para la verdadera grandeza". (Papa Francisco, Homilía de la Santa Misa, 24 de diciembre del 2021\n\nEn esta fecha muy especial todos estamos invitados a acercarnos al pesebre para ver al recién nacido. Su presencia tiene que hacernos reflexionar. En este Niño, Dios nos está diciendo que nos ama, nos está diciendo cuánto nos ama. Nos está pidiendo que salgamos de nuestro egoísmo y nuestra indiferencia, que nos abramos a Él y a los demás hombres.',
      desbloqueado: false,
    ),
  ];
}
