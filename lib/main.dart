import 'package:dicoding_flutter_pemula_submission/presentation/routes/pages.dart';
import 'package:dicoding_flutter_pemula_submission/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Dicoding Flutter Pemula",
      initialRoute: Routes.HOME,
      getPages: Pages.routes,
    );
  }
}
