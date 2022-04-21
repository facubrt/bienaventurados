import 'package:bienaventurados/src/models/logro_model.dart';

class Achievements {
  static final allAchievements = [
    Logro(
      id: 0,
      titulo: 'Comienza tu aventura',
      objetivo: 'Inicia Sesión por primera vez',
      img: 'assets/images/logros/logro-primer-inicio.png',
      descripcion: '¡Bienaventurado seas! Has desbloqueado este logro por elegirnos como compañeros de viaje en esta aventura grandiosa que es tu santidad. Esperamos que este camino compartido sea agradable y esté lleno de sorpresas, de amor y de fe. ¡En marcha!',
      n: 0,
      maximo: 1,
      desbloqueado: false,
    ),
    Logro(
      id: 1,
      titulo: 'Paso a paso',
      objetivo: 'Mantén una constancia de 3 día',
      img: 'assets/images/logros/logro-constancia-3.png',
      descripcion: '¡Hola de nuevo! Has desbloqueado este logro por tu constancia y tu determinación para dar pequeños pasos en dirección a la santidad. ¡Sigue adelante!',
      n: 1,
      maximo: 3,
      desbloqueado: false,
    ),
    Logro(
      id: 2,
      titulo: 'Un poco más cerca',
      objetivo: 'Mantén una constancia de 10 días',
      img: 'assets/images/logros/logro-constancia-10.png',
      descripcion: '¡Mira nada más, 10 días de constante aventura! Todo camino comienza con un simple y pequeño paso. Un recorrido lleno de amor y de fe te está esperando, sigue adelante. ¡Hacia lo alto!',
      n: 3,
      maximo: 10,
      desbloqueado: false,
    ),
    Logro(
      id: 3,
      titulo: 'Constancia de acero',
      objetivo: 'Mantén una constancia de 50 días',
      img: 'assets/images/logros/logro-constancia-50.png',
      descripcion: '¡Impresionante! No has parado a descansar en ningún momento. Todos estos días recibiendo avioncitos de papel y compartiendo su amor, haciendo llegar sus palabras mucho más lejos, han construido en vos una constancia de acero. ¡Bienaventurado seas!',
      n: 10,
      maximo: 50,
      desbloqueado: false,
    ),
    Logro(
      id: 4,
      titulo: 'Mas vale avioncito en mano',
      objetivo: 'Guarda 3 avioncito de papel',
      img: 'assets/images/logros/logro-guardar-1.png',
      descripcion:
          '¿Esto es el inicio de un nuevo pasatiempo? Al guardar 3 avioncito de papel para descubrirlo en otro momento has desbloqueado este logro. ¡Sigue así!',
      n: 0,
      maximo: 3,
      desbloqueado: false,
    ),
    Logro(
      id: 5,
      titulo: 'Un nuevo pasatiempo',
      objetivo: 'Guarda 20 avioncito de papel',
      img: 'assets/images/logros/logro-guardar-10.png',
      descripcion:
          '¡Esto es un nuevo pasatiempo! Tienes en tus manos 20 avioncitos de papel que has guardado, esto es un montón de palabras de amor que puedes redescubrir en cualquier momento. ¡Sigue adelante!',
      n: 3,
      maximo: 20,
      desbloqueado: false,
    ),
    Logro(
      id: 6,
      titulo: 'Coleccionista de avioncitos',
      objetivo: 'Guarda 50 avioncito de papel',
      img: 'assets/images/logros/logro-guardar-50.png',
      descripcion:
          '¡Mira nada más! Quién diría que serías un coleccionista de avioncitos de papel. Este logro te lo has ganado por capturar y guardar 50 avioncitos. ¡Cuantas palabras de amor!',
      n: 20,
      maximo: 50,
      desbloqueado: false,
    ),
    Logro(
      id: 7,
      titulo: 'Pequeños detalles',
      objetivo: 'Califica Bienaventurados en la Play Store',
      img: 'assets/images/logros/logro-calificar-app.png',
      descripcion: '¡Qué detalle! Queremos hacer de Bienaventurados un espacio común donde todos podamos aventurarnos a esa santidad que está al alcance de la mano. Tus pasos y tu experiencia en esta aventura son muy importantes. ¡Bienaventurado seas!',
      n: 0,
      maximo: 1,
      desbloqueado: false,
    ),
    Logro(
      id: 8,
      titulo: 'Mensajero de su amor',
      objetivo: 'Comparte 10 avioncito de papel',
      img: 'assets/images/logros/logro-compartir-1.png',
      descripcion: '¡Ahí van tus palabras! Obtuviste este logro por compartir 10 avioncito de papel con tus amigos y familiares. Toda aventura es mejor a la par de otros. ¡Sigue así!',
      n: 0,
      maximo: 10,
      desbloqueado: false,
    ),
    Logro(
      id: 9,
      titulo: 'Luz y sal de la tierra',
      objetivo: 'Comparte 50 avioncito de papel',
      img: 'assets/images/logros/logro-compartir-10.png',
      descripcion: 'Has compartido 10 avioncitos de papel con tus amigos y familiares. Te mereces este logro por llevar el mensaje de su amor muy lejos. Para que los avioncitos lleguen lejos, necesitan que los mandes a volar. ¡Sigue adelante!',
      n: 10,
      maximo: 50,
      desbloqueado: false,
    ),
    Logro(
      id: 10,
      titulo: 'Ser Eucaristía',
      objetivo: 'Comparte 100 avioncito de papel',
      img: 'assets/images/logros/logro-compartir-50.png',
      descripcion: '¡Mira todos esos avioncitos volando en el cielo! ¿No te parece tan lindo que el amor de Dios esté alcanzando tantos lugares y corazones? Este logro es para vos, que compartiste 50 avioncitos de papel con tus amigos y familiares. ¡Felicidades!',
      n: 50,
      maximo: 100,
      desbloqueado: false,
    ),
    Logro(
      id: 11,
      titulo: 'Aventura con amigos',
      objetivo: 'Comparte Bienaventurados con tus amigos',
      img: 'assets/images/logros/logro-compartir-app.png',
      descripcion: '¡Grandioso! Toda aventura es mejor con amigos. Al compartir Bienaventurados con esas personas que son tan especiales para vos y para Dios has desbloqueado este logro. ¡Gracias por ser luz!',
      n: 0,
      maximo: 1,
      desbloqueado: false,
    ),
    Logro(
      id: 12,
      titulo: 'Actos de amor',
      objetivo: 'Construye 3 avioncito de papel',
      img: 'assets/images/logros/logro-construir-1.png',
      descripcion: '¿Un pájaro? ¿Un avión? No, es un avioncito de papel y está llevando en su corazón un mensaje muy especial. Al construir 3 avioncito de papel has desbloqueado este logro. ¡Sigamos construyendo muchos más avioncitos de papel y compartamos la fe con gozo y alegría!',
      n: 0,
      maximo: 3,
      desbloqueado: false,
    ),
    Logro(
      id: 13,
      titulo: 'Una pequeña luz',
      objetivo: 'Construye 20 avioncito de papel',
      img: 'assets/images/logros/logro-construir-10.png',
      descripcion: '¡Wow! Has desbloqueado este logro por construir 20 avioncitos de papel. ¡Eso son un montón de avioncitos dando vueltas por el cielo! Piensa en todo lo bueno que significa eso, alguien recibirá tus palabras algún día y puede que esas palabras sean las que estaba necesitando escuchar, ¿No es hermoso eso?',
      n: 3,
      maximo: 20,
      desbloqueado: false,
    ),
    Logro(
      id: 14,
      titulo: 'Constructor de esperanza',
      objetivo: 'Construye 50 avioncito de papel',
      img: 'assets/images/logros/logro-construir-50.png',
      descripcion: '¡No podría haberlo hecho mejor! 50 avioncitos construidos, esto es un montón. Te mereces este logro por animarte a ser luz y construir con pequeños detalles como estos un mundo de esperanza y de amor. ¡Bienaventurado seas!',
      n: 20,
      maximo: 50,
      desbloqueado: false,
    ),
    Logro(
      id: 15,
      titulo: 'Aventura bajo las estrellas',
      objetivo: 'Activa el Modo Noche',
      img: 'assets/images/logros/logro-modo-noche.png',
      descripcion: 'En toda aventura la noche se transforma en una compañera silenciosa. Desbloqueaste este logro porque activaste el modo noche. Aprovecha este tiempo para rezar y poner a Dios en tus oraciones, verás que en el silencio también están sus palabras.',
      n: 0,
      maximo: 1,
      desbloqueado: false,
    ),
  ];
}
