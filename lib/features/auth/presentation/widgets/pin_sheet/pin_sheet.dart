import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:tanami_capital/config/keys.dart';
import 'package:tanami_capital/config/router/routes.dart';
import 'package:tanami_capital/core/locale/locale_extensions.dart';
import 'package:tanami_capital/core/responsive/responsive_extensions.dart';
import 'package:tanami_capital/features/auth/presentation/providers/logout/logout_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/pin_provider/pin_provider.dart';
import 'package:tanami_capital/features/auth/presentation/providers/pin_provider/pin_states.dart';
import 'package:tanami_capital/gen/assets/assets.gen.dart';
import 'package:tanami_capital/shared/widgets/app_button.dart';
import 'package:tanami_capital/shared/widgets/app_dialog.dart';

final pinPutTextEditingControllerProvider =
    Provider.autoDispose<TextEditingController>((ref) {
      final controller = TextEditingController();
      ref.onDispose(() {
        controller.dispose();
      });

      return controller;
    });

class PinSheet extends ConsumerWidget {
  final bool setNewPin;

  const PinSheet({super.key, required this.setNewPin});

  static Future<void> pinSet(
    BuildContext context,
    WidgetRef ref, {
    String? failRouterCallback,
    String? successRouterCallback,
    bool redirectOnSuccess = true,
  }) async {
    final res = await show(context, setNewPin: true);
    if (!context.mounted) return;
    if (res) {
      if (redirectOnSuccess) {
        GoRouter.of(
          context,
        ).pushReplacement(successRouterCallback ?? HomeRoute().location);
      }
    } else {
      AppDialog.show(
        context,
        title: context.tr.please,
        content: context.tr.setPinToContinue,
        action: Column(
          children: [
            AppButton(
              child: Text(context.tr.setPin),
              onPressed: () {
                pinSet(
                  context,
                  ref,
                  failRouterCallback: failRouterCallback,
                  successRouterCallback: successRouterCallback,
                  redirectOnSuccess: redirectOnSuccess,
                );
              },
            ),
            SizedBox(height: context.h(8)),
            AppButton(
              child: Text(context.tr.cancel),
              onPressed: () async {
                await ref.read(logoutProvider.future);
                if (!context.mounted) return;
                Navigator.of(context).pop();

                if (failRouterCallback != null) {
                  GoRouter.of(context).go(failRouterCallback);
                }
              },
            ),
          ],
        ),
      );
    }
  }

  static Future<bool> show(
    BuildContext context, {
    bool setNewPin = false,
  }) async {
    final result = await showModalBottomSheet<bool>(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.5,
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) => PinSheet(setNewPin: setNewPin),
    );

    return result ?? false; // Default to false if dismissed
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(pinProvider.notifier);
    ref.watch(pinProvider);
    ref.listen(pinProvider, (previous, current) {
      if (current is PinSuccess) {
        Navigator.of(context).pop(true);
      } else if (current is PinError) {
        Navigator.of(context).pop(false);
      } else if (current is PinInvalidPin) {
        Navigator.of(context).pop(false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.tr.invalidPin),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.w(24),
        vertical: context.h(24),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: context.h(16)),
          Assets.svg.logo.svg(width: context.w(150)),
          SizedBox(height: context.h(32)),
          if (setNewPin) ...[
            Text(context.tr.setPinForSecure),
            SizedBox(height: context.h(16)),
          ],
          Pinput(
            controller: ref.watch(pinPutTextEditingControllerProvider),
            key: kPinSheetFieldKey,
            autofocus: true,
            defaultPinTheme: PinTheme(
              width: context.w(60),
              height: context.w(60),
              textStyle: const TextStyle(fontSize: 24),
              padding: EdgeInsets.all(context.w(8)),
              margin: EdgeInsets.symmetric(horizontal: context.w(8)),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(context.w(8)),
              ),
            ),
            length: 4,
            keyboardType: TextInputType.number,
            obscureText: true,
            onCompleted: (value) {
              if (setNewPin) {
                provider.setPin(value);
              } else {
                provider.verifyPin(value);
              }
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),

          SizedBox(height: context.h(16)),

          AppButton(
            key: kPinSheetButtonKey,
            child: Text(context.tr.submit),
            onPressed: () {
              if (setNewPin) {
                provider.setPin(
                  ref.read(pinPutTextEditingControllerProvider).text,
                );
              } else {
                provider.verifyPin(
                  ref.read(pinPutTextEditingControllerProvider).text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
