part of 'ioc_container_.dart';

typedef DependencyTag = Object;

typedef RefreshStream = Stream<DependencyTag>;

typedef RefreshStreamSubscription = StreamSubscription<DependencyTag>;

typedef IOCFinalizer = Finalizer<IOCContainer>;
