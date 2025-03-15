import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tanami_capital/core/usecases/usecase.dart';
import 'package:tanami_capital/features/home/domain/entities/home_entity.dart';
import 'package:tanami_capital/features/home/home_di.dart';

part 'home_provider.g.dart';

@Riverpod(keepAlive: false)
Future<HomeEntity> homeData(Ref ref) async {
  final homeUsecase = ref.read(homeUsecaseProvider);
  final result = await homeUsecase.call(NoParams());
  return result.fold((l) => throw l, (r) => r);
}
