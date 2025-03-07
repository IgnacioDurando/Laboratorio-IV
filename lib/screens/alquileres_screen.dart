import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/drawer_menu.dart';
import 'casa_screen.dart';

class AlquileresScreen extends StatefulWidget {
  const AlquileresScreen({super.key});

  @override
  _AlquileresScreenState createState() => _AlquileresScreenState();
}

class _AlquileresScreenState extends State<AlquileresScreen> {
  List<Casa> alquileres = [];

  @override
  void initState() {
    super.initState();
    fetchAlquileres();
  }

  Future<void> fetchAlquileres() async {
    final response = await http.get(
        Uri.parse('https://apirender-express-laboiv.onrender.com/api/v1/alquileres'));

    if (response.statusCode == 200) {
      final List<dynamic> alquileresJson =
          json.decode(response.body)['alquileres'];
      setState(() {
        alquileres =
            alquileresJson.map((alquiler) => Casa.fromJson(alquiler)).toList();
      });
    } else {
      throw Exception('Failed to load alquileres');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Casas en alquiler',
          style: TextStyle(fontSize: 22, color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      drawer: DrawerMenu(),
      body: alquileres.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: alquileres.length,
              itemBuilder: (context, index) {
                final casa = alquileres[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: Image.network(casa.image,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(casa.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(casa.city, style: const TextStyle(fontSize: 12)),
                      Text(casa.price,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CasaScreen(
                          image: casa.image,
                          name: casa.name,
                          city: casa.city,
                          price: casa.price,
                          description: casa.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class Casa {
  final String image;
  final String name;
  final String city;
  final String price;

  Casa(
      {required this.image,
      required this.name,
      required this.city,
      required this.price});

  factory Casa.fromJson(Map<String, dynamic> json) {
    return Casa(
      image: json['image'],
      name: json['name'],
      city: json['city'],
      price: json['price'],
    );
  }
}
