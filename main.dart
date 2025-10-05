import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const IMCApp());
}

class IMCApp extends StatelessWidget {
  const IMCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de IMC 3.0',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const IMCHomePage(),
    );
  }
}

class IMC {
  final double peso;
  final double altura;
  final DateTime data;

  IMC({
    required this.peso,
    required this.altura,
    required this.data,
  });

  double get valor => peso / (altura * altura);

  String get classificacao {
    final imc = valor;
    if (imc < 18.5) return "Abaixo do peso";
    if (imc < 24.9) return "Peso normal";
    if (imc < 29.9) return "Sobrepeso";
    if (imc < 34.9) return "Obesidade Grau I";
    if (imc < 39.9) return "Obesidade Grau II";
    return "Obesidade Grau III";
  }

  Color get cor {
    final imc = valor;
    if (imc < 18.5) return Colors.blueAccent;
    if (imc < 24.9) return Colors.green;
    if (imc < 29.9) return Colors.orange;
    if (imc < 34.9) return Colors.deepOrange;
    return Colors.red;
  }

  String get dataFormatada =>
      "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";

  Map<String, dynamic> toMap() => {
        'peso': peso,
        'altura': altura,
        'data': data.toIso8601String(),
      };

  factory IMC.fromMap(Map<String, dynamic> map) {
    return IMC(
      peso: map['peso'],
      altura: map['altura'],
      data: DateTime.parse(map['data']),
    );
  }
}

class IMCHomePage extends StatefulWidget {
  const IMCHomePage({super.key});

  @override
  State<IMCHomePage> createState() => _IMCHomePageState();
}

class _IMCHomePageState extends State<IMCHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  List<IMC> _resultados = [];

  @override
  void initState() {
    super.initState();
    _carregarResultados();
  }

  Future<void> _carregarResultados() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = prefs.getStringList('imc_list') ?? [];

    setState(() {
      _resultados = dados
          .map((e) => IMC.fromMap(json.decode(e)))
          .toList()
          .reversed
          .toList();
    });
  }

  Future<void> _salvarResultados() async {
    final prefs = await SharedPreferences.getInstance();
    final dados = _resultados.map((imc) => json.encode(imc.toMap())).toList();
    await prefs.setStringList('imc_list', dados.reversed.toList());
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      final peso = double.parse(_pesoController.text);
      final altura = double.parse(_alturaController.text);

      final imc = IMC(peso: peso, altura: altura, data: DateTime.now());

      setState(() {
        _resultados.insert(0, imc);
      });

      _salvarResultados();
      _pesoController.clear();
      _alturaController.clear();
    }
  }

  void _removerResultado(int index) async {
    setState(() {
      _resultados.removeAt(index);
    });
    _salvarResultados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC 3.0'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _pesoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Peso (kg)",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final peso = double.tryParse(value ?? '');
                      if (peso == null || peso <= 0) {
                        return "Informe um peso válido";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _alturaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Altura (m)",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final altura = double.tryParse(value ?? '');
                      if (altura == null || altura <= 0) {
                        return "Informe uma altura válida";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _calcularIMC,
                    icon: const Icon(Icons.calculate),
                    label: const Text("Calcular IMC"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_resultados.isNotEmpty)
              Expanded(
                child: Column(
                  children: [
                    const Text(
                      "Evolução do IMC",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 180,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _resultados
                                  .reversed
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map((e) => FlSpot(
                                      e.key.toDouble(),
                                      e.value.valor))
                                  .toList(),
                              isCurved: true,
                              color: Colors.green,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.green.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _resultados.length,
                        itemBuilder: (context, index) {
                          final imc = _resultados[index];
                          return Card(
                            color: imc.cor.withOpacity(0.15),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: imc.cor,
                                child: Text(
                                  imc.valor.toStringAsFixed(1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(imc.classificacao),
                              subtitle: Text(
                                "Peso: ${imc.peso} kg | Altura: ${imc.altura} m\n${imc.dataFormatada}",
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removerResultado(index),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              const Expanded(
                child: Center(
                  child: Text(
                    "Nenhum cálculo salvo ainda.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
