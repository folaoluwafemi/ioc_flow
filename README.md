A package that offers a declarative way for inversion of control and allows refreshing dependencies
in the ioc container automatically, it also features a tag to each dependency, such that you can
choose to refresh dependencies that subscribe to a specific tag

## Features

- Serves as a service locator
- Refresh dependencies manually and automatically (stream)
- refresh specific dependencies by tag

## Getting started

In your `pubspec.yaml` file within your Flutter Project:

```yaml
dependencies:
  ioc_container: ^0.0.1+1-alpha
```

or

```bash
$ flutter pub add ioc_container
```

Then import the package in your code:

```dart
import 'package:ioc_container/ioc_container.dart';
```

## Usage

```dart

const like = 'sample';
```

## Additional information

To create issues, prs or otherwise contribute in anyway check out
the [package repository home](https://github.com/folaoluwafemi/ioc_flow)