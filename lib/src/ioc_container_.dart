import 'dart:async';

part 'dependency.dart';

part 'dependency_tag.dart';

/// An IOC container that allows you to refresh it's [Dependency] both manually by:
/// - calling [refreshAll] or [refresh]
/// - calling [refreshAllWithTag] with a [DependencyTag] to refresh all dependencies with that tag
/// and automatically by:
/// - adding a stream to be listened to, that dispatches a [DependencyTag] which then invokes the [refreshAllWithTag] method
final class IOCContainer {
  final List<RefreshStream> refreshStreams;

  static final List<RefreshStreamSubscription> _refreshListeners = [];

  static final IOCFinalizer _finalizer = IOCFinalizer(
    (instance) => instance._close(),
  );

  IOCContainer({
    this.refreshStreams = const [],
    required List<Dependency> dependencies,
  }) : _typeDependencies = dependencies.fold(
          {},
          (previousValue, element) {
            previousValue[element.type] = element;
            return previousValue;
          },
        ) {
    _finalizer.attach(this, this, detach: this);
    for (final RefreshStream listenable in refreshStreams) {
      _refreshListeners.add(listenable.listen(_refreshListener));
    }
  }

  void _refreshListener(DependencyTag tag) {
    refreshAllWithTag(tag);
  }

  final Map<Type, Dependency> _typeDependencies;

  T get<T>() {
    try {
      return _typeDependencies[T]!.instance;
    } catch (e) {
      throw Exception('Dependency not found for type $T');
    }
  }

  T call<T>() => get<T>();

  void refresh<T>() {
    _typeDependencies[T]!.refresh();
  }

  void refreshAll() {
    for (final Type key in _typeDependencies.keys) {
      _typeDependencies[key] = _typeDependencies[key]!.refresh();
    }
  }

  void refreshAllWithTag(DependencyTag tag) {
    for (final Type key in _typeDependencies.keys) {
      if (_typeDependencies[key]!.tags.contains(tag)) {
        _typeDependencies[key] = _typeDependencies[key]!.refresh();
      }
    }
  }

  void _close() {
    for (final listener in _refreshListeners) {
      listener.cancel();
    }
    _finalizer.detach(this);
  }
}
