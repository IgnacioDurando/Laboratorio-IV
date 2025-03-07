import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/drawer_menu.dart';
import 'casa_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Inmobiliaria',
          style: TextStyle(fontSize: 22, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CardPoster(size: size),
            const CardBody(),
            const SizedBox(height: 10),
            const CardSwiper(),
          ],
        ),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Bienvenido!',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 28,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '¡The Inmobiliaria es una app para poder encontrar el alquiler de tus sueños en Argentina! Disponemos de casas en todo el pais y con precios que se adaptan a cada uno de ustedes!!',
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16),
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}

class CardSwiper extends StatefulWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  _CardSwiperState createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  List _novedades = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response = await http.get(
        Uri.parse('https://apirender-express-laboiv.onrender.com/api/v1/novedades'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _novedades = data['novedades'];
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Caseron del mes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: _novedades.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _novedades.length,
                    itemBuilder: (context, index) {
                      var novedad = _novedades[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CasaScreen(
                                name: novedad['name'],
                                image: novedad['image'],
                                city: novedad['city'],
                                price: novedad['price'],
                                description: novedad['name'],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: SizedBox(
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/loading.gif'),
                                      image: NetworkImage(novedad['image']),
                                      width: 300,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    novedad['name'],
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    novedad['city'],
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    novedad['price'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.green),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class CardPoster extends StatelessWidget {
  final Size size;

  const CardPoster({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.35,
      child: const FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/images/intro.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
