Ballet Championship

Ballet Championship é uma aplicação desenvolvida em Flutter para gerenciamento de campeonatos de times de ballet. Permite o cadastro de times, gerenciamento de partidas e exibição dos resultados finais, incluindo um histórico detalhado das partidas.


Funcionalidades:

Cadastro de Times
Permite o cadastro de novos times com nome, ano de fundação, grito de guerra e logo.
Validação de campos obrigatórios.



Início do Campeonato
Interface para iniciar o campeonato após o cadastro dos times.
Verificação do número mínimo de times necessários para iniciar o campeonato.



Fases do Campeonato
Organização dos times em duplas para realização das partidas.
Exibição das partidas a serem realizadas em cada fase.



Administração da Partida
Painel para administrar cada partida, registrando pontos, blots e plifs.
Permite encerrar a partida e resolver empates com o "grusht".



Resultados Finais
Exibição dos resultados finais do campeonato com classificação dos times.
Destaque para o campeão e exibição do grito de guerra do vencedor.
Prêmios para os três primeiros colocados (1º Lugar: R$ 2000, 2º Lugar: R$ 1000, 3º Lugar: R$ 500).



Histórico de Partidas
Registro detalhado de todas as partidas realizadas no campeonato.
Acesso ao histórico de partidas através de um botão na interface.




Como Rodar o Projeto:
Este projeto e feito para implementação web e app, para rodar web siga os passos a baixo caso ele nao abra altomaticamente o http://localhost pra você.

Pré-requisitos
Flutter instalado - Flutter 3.19.6
Dart SDK - Dart 3.3.4
Editor de código (VS Code, Android Studio, etc.)

Passos
Clone o repositório:
git clone https://github.com/seu_usuario/ballet_championship.git


Instale as dependências:
flutter pub get

Configure o Flutter para web (opcional):
flutter config --enable-web


Rode o projeto:

web:
flutter run -d windows

google:
flutter run -d chrome

App:
Instale o Android Studio e baixe o SDK para poder emular um celular.
Conecte um dispositivo Android via USB ou inicie um emulador Android.
Execute o comando:
flutter run
Ou vá no ícone de "Run and Debug" (joaninha) no seu editor de código, escolha o dispositivo e clique em "Run and Debug".