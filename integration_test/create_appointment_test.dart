import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:veterinaria/main.dart' as app;

void main() {
  patrolTest(
    'Flujo completo: Iniciar sesión y crear cita con Patrol',
    ($) async {
      // 1. Iniciar la aplicación
      app.main();
      await $.pumpAndSettle();

      // 2. Rellenar campos de Login (buscando por el texto descriptivo)
      await $(TextField).at(0).enterText('nuevo@gmail.com');
      await $(TextField).at(1).enterText('123456');

      // Ocultar teclado e iniciar sesión
      await $.tap($(Text('Iniciar sesion')));
      await $.pumpAndSettle();

      // 3. Abrir formulario de Crear Cita usando el Key('create_appointment_fab')
      await $(#create_appointment_fab).tap();
      await $.pumpAndSettle();

      // 4. Llenar formulario de Cita
      await $(TextField).at(0).enterText('Firulais');

      // Seleccionar Fecha y Hora
      await $(Text('Seleccionar Fecha')).tap();
      await $.pumpAndSettle();
      await $(Text('OK')).tap();
      await $.pumpAndSettle();

      await $(Text('Seleccionar Hora')).tap();
      await $.pumpAndSettle();
      await $(Text('OK')).tap();
      await $.pumpAndSettle();

      // Motivo de la cita
      await $(TextField).at(1).enterText('Chequeo general y vacunas');

      // 5. Presionar guardar cita
      await $(ElevatedButton).tap();
      await $.pumpAndSettle();

      // 6. Verificar que la cita de Firulais está en pantalla
      expect($(Text('Firulais')), findsOneWidget);
    },
  );
}
