part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool isLoading;
  final List<Item> displayItems;
  final List<String> sortingTypes;
  final String selectedSortingType;

  const HomeState(
      {@required this.isLoading,
      @required this.displayItems,
      @required this.sortingTypes,
      @required this.selectedSortingType});

  factory HomeState.initial() => HomeState(
        isLoading: true,
        displayItems: [],
        sortingTypes: HomeStateSortingType.values
            .map<String>((item) => item.displayName)
            .toList(),
        selectedSortingType: HomeStateSortingType.addingDateDesc.displayName,
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
      sorting = sortingType.displayName;
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
        return "Name ↑";
      case HomeStateSortingType.nameDes:
        return "Name ↓";
      case HomeStateSortingType.addingDateAsc:
        return "Adding ↑";
      case HomeStateSortingType.addingDateDesc:
        return "Adding ↓";
      case HomeStateSortingType.expirationDateAsc:
        return "Expiration ↑";
      case HomeStateSortingType.expirationDateDesc:
        return "Expiration ↓";
    }
    throw Exception("Unsupported sorting type");
  }
}
