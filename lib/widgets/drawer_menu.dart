import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, String>> _menuItems = <Map<String, String>>[
    {'route': 'home', 'title': 'Inicio'},
    {'route': 'alquileres', 'title': 'Alquileres'},
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeaderAlternative(),
          ...ListTile.divideTiles(
              context: context,
              tiles: _menuItems
                  .map((item) => ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        dense: true,
                        minLeadingWidth: 25,
                        iconColor: Colors.blueGrey,
                        title: Text(item['title']!,
                            style: const TextStyle(
                                fontFamily: 'FuzzyBubbles', fontSize: 18)),
                        leading: const Icon(Icons.chevron_right),
                        onTap: () {
                          Navigator.pop(context);
                          //Navigator.pushReplacementNamed(context, item['route']!);
                          Navigator.pushNamed(context, item['route']!);
                        },
                      ))
                  .toList())
        ],
      ),
    );
  }
}

class _DrawerHeaderAlternative extends StatelessWidget {
  const _DrawerHeaderAlternative({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          Positioned(
            top: -50,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              transform: Matrix4.rotationZ(0.3),
            ),
          ),
          Positioned(
            bottom: -20,
            right: -40,
            child: Container(
              width: 150,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10),
              ),
              transform: Matrix4.rotationZ(-0.5),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              transform: Matrix4.rotationZ(0.8),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 80,
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              transform: Matrix4.rotationZ(-0.8),
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Center(
              child: Text(
                'CabaniasArg',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
