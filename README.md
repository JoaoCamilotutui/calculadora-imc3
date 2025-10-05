<!-- Banner estilizado -->
<p align="center">
  <img src="https://img.shields.io/badge/Flutter%20App-%F0%9F%A7%AE-blue?style=for-the-badge" alt="Flutter App Badge"/>
  <img src="https://img.shields.io/badge/Dart-%F0%9F%92%99-blue?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/IMC%20Calculator-%F0%9F%8D%8C-green?style=for-the-badge"/>
</p>

<h1 align="center">🧮 Calculadora IMC3</h1>
<p align="center">Um aplicativo Flutter para calcular o Índice de Massa Corporal (IMC) com design moderno e gráfico interativo.</p>

---

## 🚀 Sobre o Projeto

A **Calculadora IMC3** é um app Flutter criado para ajudar os usuários a **calcular e acompanhar o IMC (Índice de Massa Corporal)** de forma simples, visual e educativa.  
É também um excelente exemplo para iniciantes aprenderem conceitos fundamentais de Flutter, como **layout, estado, widgets personalizados e integração com pacotes externos.**

---

## ✨ Funcionalidades

- ✅ Cálculo automático do IMC com base no peso e altura informados  
- 📊 Exibição gráfica dos resultados com o pacote `fl_chart`  
- 🌗 Suporte a tema claro e escuro  
- 🧠 Classificação automática conforme os padrões da **OMS**  
- ⚡ Interface responsiva e intuitiva  

---

## 🧰 Tecnologias Utilizadas

| Tecnologia | Descrição |
|-------------|------------|
| **Flutter** | Framework principal para desenvolvimento multiplataforma |
| **Dart** | Linguagem de programação base do Flutter |
| **fl_chart** | Biblioteca para geração de gráficos |
| **intl** | Formatação de números e datas |

---

## 📁 Estrutura do Projeto

```plaintext
lib/
├── main.dart               # Ponto de entrada da aplicação
├── screens/
│   └── home_screen.dart    # Tela principal com o cálculo do IMC
├── widgets/
│   ├── input_field.dart    # Campos de entrada personalizados
│   ├── result_card.dart    # Exibição do resultado do IMC
│   └── imc_chart.dart      # Gráfico interativo do IMC
└── utils/
    └── imc_calculator.dart # Funções de cálculo e classificação do IMC

⚙️ Como Executar o Projeto

    Clone este repositório

git clone https://github.com/seu-usuario/imc3_app.git

Acesse a pasta do projeto

cd imc3_app

Instale as dependências

flutter pub get

Execute o aplicativo

    flutter run

💡 Dica: use o Visual Studio Code com o plugin do Flutter para uma experiência mais fluida.
🧮 Cálculo do IMC

A fórmula utilizada é:
IMC=peso(altura)2
IMC=(altura)2peso​
Classificação	IMC (kg/m²)
Abaixo do peso	< 18.5
Peso normal	18.5 – 24.9
Sobrepeso	25 – 29.9
Obesidade grau I	30 – 34.9
Obesidade grau II	35 – 39.9
Obesidade grau III	≥ 40

🧩 Próximos Passos

Adicionar histórico de cálculos

Permitir salvar resultados localmente

Melhorar o design do gráfico com animações suaves

    Implementar testes unitários básicos

🤝 Contribuições

Contribuições são muito bem-vindas!
Abra uma issue ou envie um pull request com sua sugestão de melhoria.
📚 Recursos Úteis

    Documentação oficial do Flutter

Guia do Material Design

Tour pela linguagem Dart

Pacote fl_chart no pub.dev
🪪 Licença

Este projeto é de código aberto sob a licença MIT.
Você pode usar, modificar e distribuir livremente, desde que mantenha os créditos.
Feito em Flutter
Desenvolvido por João Camilo Tutuí
