import 'package:band_names/pages/status.dart';
import 'package:band_names/services/sockets_service.dart';
import 'package:flutter/material.dart';
import 'package:band_names/pages/home.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SocketService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'home',
        theme: ThemeData(
          useMaterial3: true,
        ),
        routes: {
          'home': (_) => const HomePage(),
          'status': (_) => const StatusPage(),
        },
      ),
    );
  }
}
