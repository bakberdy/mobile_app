// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ExampleTodoEditorScreen]
class ExampleTodoEditorRoute extends PageRouteInfo<ExampleTodoEditorRouteArgs> {
  ExampleTodoEditorRoute({Key? key, Todo? todo, List<PageRouteInfo>? children})
    : super(
        ExampleTodoEditorRoute.name,
        args: ExampleTodoEditorRouteArgs(key: key, todo: todo),
        initialChildren: children,
      );

  static const String name = 'ExampleTodoEditorRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExampleTodoEditorRouteArgs>(
        orElse: () => const ExampleTodoEditorRouteArgs(),
      );
      return ExampleTodoEditorScreen(key: args.key, todo: args.todo);
    },
  );
}

class ExampleTodoEditorRouteArgs {
  const ExampleTodoEditorRouteArgs({this.key, this.todo});

  final Key? key;

  final Todo? todo;

  @override
  String toString() {
    return 'ExampleTodoEditorRouteArgs{key: $key, todo: $todo}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExampleTodoEditorRouteArgs) return false;
    return key == other.key && todo == other.todo;
  }

  @override
  int get hashCode => key.hashCode ^ todo.hashCode;
}

/// generated route for
/// [ExampleTodosScreen]
class ExampleTodosRoute extends PageRouteInfo<void> {
  const ExampleTodosRoute({List<PageRouteInfo>? children})
    : super(ExampleTodosRoute.name, initialChildren: children);

  static const String name = 'ExampleTodosRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ExampleTodosScreen();
    },
  );
}

/// generated route for
/// [MainNavigationScreen]
class MainNavigationRoute extends PageRouteInfo<void> {
  const MainNavigationRoute({List<PageRouteInfo>? children})
    : super(MainNavigationRoute.name, initialChildren: children);

  static const String name = 'MainNavigationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MainNavigationScreen();
    },
  );
}

/// generated route for
/// [UserConfigExampleScreen]
class UserConfigExampleRoute extends PageRouteInfo<void> {
  const UserConfigExampleRoute({List<PageRouteInfo>? children})
    : super(UserConfigExampleRoute.name, initialChildren: children);

  static const String name = 'UserConfigExampleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const UserConfigExampleScreen();
    },
  );
}
