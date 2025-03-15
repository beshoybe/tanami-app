import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patrol/patrol.dart';
import 'package:tanami_capital/app.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/core/cache/cache_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/auth_di.dart';
import 'package:tanami_capital/features/auth/presentation/widgets/pin_sheet/pin_sheet.dart';

Future<WidgetRef> runTanamiApp(PatrolIntegrationTester $) async {
  late WidgetRef geneeratedRef;
  await dotenv.load(fileName: '.env');
  await $.pumpWidgetAndSettle(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, child) {
          geneeratedRef = ref;
          return TanamiApp();
        },
      ),
    ),
  );
  return geneeratedRef;
}

Future<WidgetRef> runTanamiAppWithSavedLogin(PatrolIntegrationTester $) async {
  final container = ProviderContainer();
  await dotenv.load(fileName: '.env');
  await container
      .read(authDatasourceProvider)
      .login(dotenv.env["TESTING_EMAIL"]!, dotenv.env["TESTING_PASSWORD"]!);
  await container
      .read(cacheHelperProvider)
      .writeString(kPasswordLessPinCacheKey, dotenv.env["TESTING_PIN"]!);
  return await runTanamiApp($);
}

Future<void> enterPin(
  PatrolIntegrationTester $,
  String pin,
  WidgetRef ref,
) async {
  ref.read(pinPutTextEditingControllerProvider).text = "1234";
  await $.pumpAndSettle();
}
