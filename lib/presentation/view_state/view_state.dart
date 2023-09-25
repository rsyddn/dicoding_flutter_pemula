import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.freezed.dart';

@freezed
class ViewState<T> with _$ViewState<T> {
  const factory ViewState.initial() = Initial;

  const factory ViewState.loading() = Loading;

  const factory ViewState.success({required T data}) = Success;

  const factory ViewState.failed({required String message}) = Failed;
}
