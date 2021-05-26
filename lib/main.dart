import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_client.dart';
import 'repository.dart';

final apiClientProvider = Provider.autoDispose(
  (_) => ApiClientImpl(baseUrl: 'http://127.0.0.1:8080'),
);

final repositoryProvider = Provider.autoDispose(
  (ref) => RepositoryImpl(apiClient: ref.read(apiClientProvider)),
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mockito Unit Test Demo',
    );
  }
}
