import 'package:ballet_championship/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BallitChampionshipApp should render Cadastro de Times page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BallitChampionshipApp());

    // Verify that the "Cadastro de Times" text is present.
    expect(find.text('Cadastro de Times'), findsOneWidget);
    
    // Verify the presence of the form fields.
    expect(find.byType(TextFormField), findsNWidgets(3));
    
    // Verify the presence of the submit button.
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Cadastro de Time Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BallitChampionshipApp());

    // Verify that the "Cadastro de Times" text is present.
    expect(find.text('Cadastro de Times'), findsOneWidget);

    // Enter text into the form fields.
    await tester.enterText(find.byKey(Key('nomeTimeField')), 'Time A');
    await tester.enterText(find.byKey(Key('gritoDeGuerraField')), 'Vamos ganhar!');
    await tester.enterText(find.byKey(Key('anoFundacaoField')), '2020');

    // Tap the submit button.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the time was added to the list.
    expect(find.text('Time A'), findsOneWidget);
    expect(find.text('Vamos ganhar!'), findsOneWidget);
    expect(find.text('2020'), findsOneWidget);
  });
}
