part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool isLoading;
  final List<Item> displayItems;

  const HomeState({
    @required this.isLoading,
    @required this.displayItems,
  });

  factory HomeState.initial() => HomeState(
        isLoading: true,
        displayItems: [],
      );

  HomeState copyWith({
    bool isLoading,
    List<Item> displayItems,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        displayItems: displayItems ?? this.displayItems,
      );
}
