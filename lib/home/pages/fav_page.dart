import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: Center(
          child: Text('Contenu de la Page Deux')
      ), // Ajoutez ici le contenu de votre première page
    );
  }
}