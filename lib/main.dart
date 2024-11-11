import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/evento_provider.dart';
import 'screens/home_screen.dart';

void main() {
runApp(
    MultiProvider(
    providers: [
    ChangeNotifierProvider(create: (_) => EventProvider()),
    ],
    child: const MyApp(
    ),
    ),
);
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Gestión de Eventos',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            ),
    home: HomeScreen(),
    );
}
}
