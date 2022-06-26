  // LECTURA DEL DIA
  /*
  Future<bool> getLectura() async {
    String _day = DateTime.now().day.toString().padLeft(2, '0');
    String _month = DateTime.now().month.toString().padLeft(2, '0');
    String _year = DateTime.now().year.toString();
    String feedURL =
        'http://feed.evangelizo.org/v2/reader.php?date=20220101&lang=SP&type=all';
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(feedURL));
      _lectura = RssFeed.parse(response.body).toString();
      notifyListeners();
    } catch (e) {
      //
    }
    return true;
  }
*/

  /*
  Future<bool> getTiempoLiturgico() async {
    String _day = DateTime.now().day.toString().padLeft(2, '0');
    String _month = DateTime.now().month.toString().padLeft(2, '0');
    String _year = DateTime.now().year.toString();
    String url =
        'http://feed.evangelizo.org/v2/reader.php?date=$_year$_month$_day&lang=SP&type=liturgic_t&content=FR';
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      _tiempoLiturgico = response.body;
      notifyListeners();
    } else {
      throw Exception();
    }

    return true;
  }
  */