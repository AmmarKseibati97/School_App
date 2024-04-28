part of 'root_cubit.dart';

@immutable
sealed class RootState {}

final class RootInitial extends RootState {}
class RootChangedState extends RootState {
  final int index;

  RootChangedState(this.index);
}
