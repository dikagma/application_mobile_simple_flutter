import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/meteo.service.dart';

class MeteoPage extends StatefulWidget{
  const MeteoPage({super.key});

  @override
 _MeteoPageState createState() => _MeteoPageState();

}

class _MeteoPageState extends State<MeteoPage>{
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String city = "Paris";
  String? error;
  final TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cityController.text = city;
    loadWeather();
  }

  Future<void> loadWeather() async {
  //  final data = await MeteoService.getWeather(city);
    setState(() {
      weatherData = null;
      error = null;
      isLoading = true;
    });

    final data = await MeteoService.getWeather(cityController.text.trim());

    setState(() {
      isLoading = false;
      if (data == null || data['cod'] != 200) {
        error = "Ville non trouvée ou erreur de connexion.";
      } else {
        weatherData = data;
        city = cityController.text.trim();
      }
    });

  }

  Widget buildWeatherInfo() {
    final temp = weatherData!['main']['temp'];
    final description = weatherData!['weather'][0]['description'];
    final iconCode = weatherData!['weather'][0]['icon'];
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@4x.png';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(iconUrl, width: 100),
        Text(
          '$temp °C',
          style: const TextStyle(fontSize: 32),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Météo")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: InputDecoration(
                labelText: "Entrez une ville",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: loadWeather,
                ),
              ),
              onSubmitted: (_) => loadWeather(),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : error != null
                    ? Text(error!,
                    style: const TextStyle(color: Colors.red, fontSize: 18))
                    : weatherData != null
                    ? buildWeatherInfo()
                    : const Text("Aucune donnée"),
              ),
            ),
          ],
        ),
      ),
    );


  }


  
}