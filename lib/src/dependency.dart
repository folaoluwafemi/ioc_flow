part of 'ioc_container_.dart';

/// This class represents a dependency, it holds your service [_instance] as well as a set of [tags]
///
///
/// Note:
/// - All Dependencies are lazy
/// - If you do not specify [T], it will be inferred from the [_factory] you provide.
/// - A [Dependency] can have more than one [tag]
class Dependency<T> {
  final Type type = T;
  final Set<DependencyTag> tags;
  final T Function() _factory;
  T? _instance;

  Dependency(
    this._factory, {
    this.tags = const {},
  });

  T get instance {
    _instance ??= _factory();
    return _instance!;
  }

  Dependency<T> refresh() {
    _instance = _factory();
    return this;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dependency &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          tags == other.tags &&
          _factory == other._factory &&
          _instance == other._instance;

  @override
  int get hashCode =>
      type.hashCode ^ tags.hashCode ^ _factory.hashCode ^ _instance.hashCode;
}
