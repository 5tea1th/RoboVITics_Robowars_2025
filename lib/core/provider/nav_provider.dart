// navigation_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
}); */

// navigation_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_provider.g.dart';

@riverpod
class Navigation extends _$Navigation {
  @override
  int build() => 0; // Initial index

  void setIndex(int index) {
    state = index;
  }
}
/*class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
} */