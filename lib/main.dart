import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:mcp_toolkit/mcp_toolkit.dart';

import 'package:training_trainer/core/app/app.dart';
import 'package:training_trainer/core/di/injection_container.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      MCPToolkitBinding.instance.initialize();
      await Hive.initFlutter();
      await setupDependencies();

      runApp(const ProviderScope(child: MainApp()));
    },
    (error, stack) {
      MCPToolkitBinding.instance.handleZoneError(error, stack);
    },
  );
}
