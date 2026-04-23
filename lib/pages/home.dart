import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 54, 54, 211),
            Color(0xFF64B5F6),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(200, 0, 0, 0),
                    blurRadius: 40,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher une ville',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: Container(
                    width: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset('assets/icons/loupe-search-svgrepo-com (1).svg'), // Optionnel : icône loupe
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/left-arrow-svgrepo-com (1).svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      title: const Text(
        "Météo",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/three-dots-menu-svgrepo-com (1).svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}