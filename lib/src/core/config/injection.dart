import 'package:flutter/material.dart';
import 'package:pots_app/src/core/config/di.dart';


class DependencyInjection {
  static Future<void>init ()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    await initDi ();
  }
}