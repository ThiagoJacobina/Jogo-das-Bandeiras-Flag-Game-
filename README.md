# 🚩 Flag Game — Quiz Interativo de Bandeiras do Mundo

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)


O **Flag Game** é um aplicativo mobile interativo desenvolvido no framework **Flutter** para a disciplina de **Dispositivos Móveis**. O principal objetivo é testar e aprimorar os conhecimentos geográficos dos jogadores, desafiando-os a identificar as bandeiras dos países do mundo contra o relógio em uma interface gamificada e dinâmica.

---

## Capturas de Tela

*<img width="300" height="500" alt="Captura de tela 2026-11-05 161301 - Copia" src="https://github.com/user-attachments/assets/74ef0311-45e4-444e-be5a-7a0780c843ef" />*
*<img width="300" height="500" alt="Captura de tela 2026-11-05 161314" src="https://github.com/user-attachments/assets/631a4166-ceb7-4423-894d-2902a91d2ac9" />*
*<img width="300" height="500" alt="Captura de tela 2026-11-05 161715" src="https://github.com/user-attachments/assets/7b4089a8-0713-44de-a1d1-314f25543974" />*


---

## Requisitos e Funcionalidades do Aplicativo

### 1. Menu Principal (Tela Inicial)
- **Modos de Jogo Selecionáveis:**
  -  **Jogar por Continente:** Permite ao jogador selecionar um continente específico (**África, América, Ásia, Europa ou Oceania**) para filtrar as bandeiras exibidas.
  -  **Jogo Aleatório:** Sorteia bandeiras de todos os países cadastrados no banco de dados sem restrição geográfica.
- ** Configuração do Temporizador:**
  - O jogador pode personalizar o tempo total da partida escolhendo entre **30 segundos, 60 segundos (1 min), 3 minutos ou 5 minutos**.
- ** Exibição do High Score:**
  - Mostra o recorde global de acertos já alcançado no dispositivo na tela principal.

### 2.  Tela de Jogo (Quiz Gamificado)
- **Exibição da Bandeira:** Moldura central destacada com renderização vetorial de alta definição.
- **4 Opções de Resposta:** Quatro cartões com identificadores (`A`, `B`, `C`, `D`), onde apenas uma alternativa é a correta.
- **Feedback Visual Imediato:**
  - 🟢 **Verde** e ícone de check (✓) para a alternativa correta.
  - 🔴 **Vermelho** e ícone de cancelamento (✗) caso o jogador selecione uma alternativa errada.
- **Temporizador e Barra de Progresso:**
  - Contador regressivo no topo e barra animada que fica vermelha quando faltam 10 segundos ou menos.
  - A transição entre perguntas ocorre de forma fluida com temporizador de descanso ajustado.

### 3. Tela de Resultados
- **Estatísticas Completas:**
  - Total de perguntas respondidas durante o tempo selecionado.
  - Quantidade exata de acertos.
  - Percentual de aproveitamento (%) calculado em tempo real.
- **Destaque de Novo Recorde:** Animação e indicativo visual de **🎉 NOVO RECORDE! 🎉** quando o jogador supera a pontuação máxima anterior.
- **Retorno Limpo:** Botão para voltar ao Menu Principal e iniciar uma nova partida.

---

## Tecnologias e Pacotes Utilizados

- **[Flutter SDK](https://flutter.dev/):** Framework UI para desenvolvimento multiplataforma.
- **[Dart](https://dart.dev/):** Linguagem de programação reativa orientada a objetos.
- **[country_flags (^3.0.0)](https://pub.dev/packages/country_flags):** Renderização vetorial offline das bandeiras através dos códigos ISO-3166-1 alpha-2 dos países.
- **[shared_preferences (^2.2.2)](https://pub.dev/packages/shared_preferences):** Persistência de dados local (armazenamento de chave-valor) para guardar a maior pontuação.

---

## Arquitetura do Código

O projeto segue os princípios de separação de responsabilidades (Clean Code) com uma estrutura modular organizada da seguinte forma:

```text
lib/
├── models/
│   ├── country.dart         # Modelo da entidade País (nome, isoCode, continente)
│   └── game_config.dart     # Configurações passadas para o jogo (modo e tempo)
├── data/
│   └── countries_data.dart  # Banco de dados local com 60+ países organizados por continentes
├── services/
│   └── score_service.dart   # Gerenciador da lógica de persistência do High Score (shared_preferences)
├── screens/
│   ├── menu_screen.dart     # Tela do Menu Principal e escolha de parâmetros
│   ├── game_screen.dart     # Tela principal da partida (StatefulWidget, Timer, quiz e feedback)
│   └── result_screen.dart   # Relatório e estatísticas de encerramento da partida
└── main.dart                # Configuração do aplicativo e tema global (Material Design 3)
```

---

##  Como Executar o Projeto Localmente

### Pré-requisitos
- **Flutter SDK** instalado (versão igual ou superior a `3.0.0`).
- Gerenciador de dependências `dart` e `git`.
- Emulador Android/iOS ou dispositivo físico conectado via USB.

### Passo a Passo

1. **Clonar o Repositório:**
   ```bash
   git clone https://github.com/ThiagoJacobina/Jogo-das-Bandeiras-Flag-Game.git
   ```

2. **Acessar o Diretório do Projeto:**
   ```bash
   cd flag-game
   ```

3. **Instalar as Dependências:**
   ```bash
   flutter pub get
   ```

4. **Executar a Aplicação:**
   ```bash
   flutter run
   ```

---

## 🎥 Vídeo Demonstrativo e Apresentação

- 📹 **[Link para o Vídeo de Demonstração no YouTube / Drive]()**

---

## ✒️ Autor

Desenvolvido por **Thiago Morais Jacobina** como parte do Desafio Acadêmico da disciplina de **Dispositivos Móveis**.
