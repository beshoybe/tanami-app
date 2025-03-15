// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginFormKeyHash() => r'99b6f5fceb9b43c241f155c8a627ef2c5520d8a3';

/// See also [loginFormKey].
@ProviderFor(loginFormKey)
final loginFormKeyProvider = AutoDisposeProvider<GlobalKey<FormState>>.internal(
  loginFormKey,
  name: r'loginFormKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginFormKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginFormKeyRef = AutoDisposeProviderRef<GlobalKey<FormState>>;
String _$loginEmailControllerHash() =>
    r'6e6c607cca343dcaf0db78bfc08c8742dc1e540a';

/// See also [loginEmailController].
@ProviderFor(loginEmailController)
final loginEmailControllerProvider =
    AutoDisposeProvider<TextEditingController>.internal(
  loginEmailController,
  name: r'loginEmailControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginEmailControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginEmailControllerRef = AutoDisposeProviderRef<TextEditingController>;
String _$loginPasswordControllerHash() =>
    r'cf0d50b8b6c86ba6838b0c148f4b2a59fb185f60';

/// See also [loginPasswordController].
@ProviderFor(loginPasswordController)
final loginPasswordControllerProvider =
    AutoDisposeProvider<TextEditingController>.internal(
  loginPasswordController,
  name: r'loginPasswordControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loginPasswordControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LoginPasswordControllerRef
    = AutoDisposeProviderRef<TextEditingController>;
String _$loginHash() => r'f614111f226acafdecaf3119d6e5674e1e70aa5c';

/// See also [Login].
@ProviderFor(Login)
final loginProvider = AutoDisposeNotifierProvider<Login, LoginState>.internal(
  Login.new,
  name: r'loginProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Login = AutoDisposeNotifier<LoginState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
