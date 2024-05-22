import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Center(
          child: Text('Contenu de la Page Deux')
      ), // Ajoutez ici le contenu de votre première page
    );
  }
}