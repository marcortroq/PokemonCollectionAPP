import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultScreen extends StatelessWidget {
  final String text;

  ResultScreen({Key? key, required this.text}) : super(key: key);

  final List<String> pokemonNames = [
    'Bulbasaur', 'Ivysaur', 'Venusaur', 'Charmander', 'Charmeleon', 'Charizard', 'Squirtle', 'Wartortle', 'Blastoise', 
    'Caterpie', 'Metapod', 'Butterfree', 'Weedle', 'Kakuna', 'Beedrill', 'Pidgey', 'Pidgeotto', 'Pidgeot', 'Rattata', 
    'Raticate', 'Spearow', 'Fearow', 'Ekans', 'Arbok', 'Pikachu', 'Raichu', 'Sandshrew', 'Sandslash', 'Nidoran♀', 
    'Nidorina', 'Nidoqueen', 'Nidoran♂', 'Nidorino', 'Nidoking', 'Clefairy', 'Clefable', 'Vulpix', 'Ninetales', 
    'Jigglypuff', 'Wigglytuff', 'Zubat', 'Golbat', 'Oddish', 'Gloom', 'Vileplume', 'Paras', 'Parasect', 'Venonat', 
    'Venomoth', 'Diglett', 'Dugtrio', 'Meowth', 'Persian', 'Psyduck', 'Golduck', 'Mankey', 'Primeape', 'Growlithe', 
    'Arcanine', 'Poliwag', 'Poliwhirl', 'Poliwrath', 'Abra', 'Kadabra', 'Alakazam', 'Machop', 'Machoke', 'Machamp', 
    'Bellsprout', 'Weepinbell', 'Victreebel', 'Tentacool', 'Tentacruel', 'Geodude', 'Graveler', 'Golem', 'Ponyta', 
    'Rapidash', 'Slowpoke', 'Slowbro', 'Magnemite', 'Magneton', 'Farfetch\'d', 'Doduo', 'Dodrio', 'Seel', 'Dewgong', 
    'Grimer', 'Muk', 'Shellder', 'Cloyster', 'Gastly', 'Haunter', 'Gengar', 'Onix', 'Drowzee', 'Hypno', 'Krabby', 
    'Kingler', 'Voltorb', 'Electrode', 'Exeggcute', 'Exeggutor', 'Cubone', 'Marowak', 'Hitmonlee', 'Hitmonchan', 
    'Lickitung', 'Koffing', 'Weezing', 'Rhyhorn', 'Rhydon', 'Chansey', 'Tangela', 'Kangaskhan', 'Horsea', 'Seadra', 
    'Goldeen', 'Seaking', 'Staryu', 'Starmie', 'Mr. Mime', 'Scyther', 'Jynx', 'Electabuzz', 'Magmar', 'Pinsir', 
    'Tauros', 'Magikarp', 'Gyarados', 'Lapras', 'Ditto', 'Eevee', 'Vaporeon', 'Jolteon', 'Flareon', 'Porygon', 
    'Omanyte', 'Omastar', 'Kabuto', 'Kabutops', 'Aerodactyl', 'Snorlax', 'Articuno', 'Zapdos', 'Moltres', 'Dratini', 
    'Dragonair', 'Dragonite', 'Mewtwo', 'Mew'
  ];

  Future<String?> fetchCardImage(int pokemonIndex) async {
    final pokemonName = pokemonNames[pokemonIndex];
    final response = await http.get(Uri.parse('http://51.141.92.127:5000/carta/${pokemonIndex + 1}'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final fotoCarta = jsonData['Carta']['FOTO_CARTA'];
      return fotoCarta;
    } else {
      throw Exception('Failed to load card image');
    }
  }

  void _showSaveConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Guardar Pokémon'),
          content: Text('¿Quieres guardar este Pokémon?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                Navigator.of(context).pop(); // Vuelve a la pantalla anterior
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para la animación de reducción y desplazamiento
                // Muestra un SnackBar como ejemplo
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pokémon guardado'),
                  ),
                );
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final foundPokemonIndex = pokemonNames.indexWhere((pokemon) => text.contains(pokemon));

    return Scaffold(
      appBar: null, // Quita la barra de título
      body: GestureDetector(
        onTap: () {
          _showSaveConfirmation(context);
        },
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              child: Image.asset(
                'assets/fondo_ocr.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: foundPokemonIndex != -1
                  ? FutureBuilder<String?>(
                      future: fetchCardImage(foundPokemonIndex),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Image.asset(
                            'assets/pokemon_carga1.gif',
                            height: 200,
                            width: 200,
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final cardImageBase64 = snapshot.data!;
                          final cardImageBytes = base64Decode(cardImageBase64);
                          return Image.memory(cardImageBytes, fit: BoxFit.cover);
                        } else {
                          return Text('No se encontró ninguna imagen de carta para este Pokémon');
                        }
                      },
                    )
                  : Text('No se encontró ningún Pokémon'),
            ),
          ],
        ),
      ),
    );
  }
}