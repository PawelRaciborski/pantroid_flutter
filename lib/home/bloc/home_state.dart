part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool isLoading;
  final List<Item> displayItems;
  final List<HomeStateSortingType> sortingTypes;
  final HomeStateSortingType selectedSortingType;

  const HomeState(
      {@required this.isLoading,
      @required this.displayItems,
      @required this.sortingTypes,
      @required this.selectedSortingType});

  factory HomeState.initial() => HomeState(
        isLoading: true,
        displayItems: [],
        sortingTypes: HomeStateSortingType.values.toList(),
        selectedSortingType: HomeStateSortingType.addingDateDesc,
      );

  HomeState copyWith({
    bool isLoading,
    List<Item> displayItems,
    HomeStateSortingType sortingType,
  }) {
    var sorting;

    if (sortingType == null) {
      sorting = this.selectedSortingType;
    } else {
      sorting = sortingType;
    }

    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      displayItems: displayItems ?? this.displayItems,
      sortingTypes: this.sortingTypes,
      selectedSortingType: sorting,
    );
  }
}

enum HomeStateSortingType {
  nameAsc,
  nameDes,
  addingDateAsc,
  addingDateDesc,
  expirationDateAsc,
  expirationDateDesc,
}

extension HomeStateSortingTypeExtension on HomeStateSortingType {
  String get displayName {
    switch (this) {
      case HomeStateSortingType.nameAsc:
        return "name_asc";
      case HomeStateSortingType.nameDes:
        return "name_des";
      case HomeStateSortingType.addingDateAsc:
        return "adding_date_asc";
      case HomeStateSortingType.addingDateDesc:
        return "adding_date_desc";
      case HomeStateSortingType.expirationDateAsc:
        return "expiration_date_asc";
      case HomeStateSortingType.expirationDateDesc:
        return "expiration_date_desc";
    }
    throw Exception("Unsupported sorting type");
  }
}
