import 'dart:convert';
import 'api_client.dart';
import 'entity.dart';

abstract class Repository {
  Future<List<Entity>> fitchList();
  Future<void> createTodo({required String title, String? description});
  Future<void> updateTodo(
      {required int id, required String title, String? description});
  Future<void> deleteTodo({required int id});
}

class RepositoryImpl implements Repository {
  RepositoryImpl({required this.apiClient});

  final ApiClient apiClient;

  static const endPoint = '/todos';

  @override
  Future<List<Entity>> fitchList() async {
    final responseBody = await apiClient.get(endPoint);
    try {
      final decodedJson = json.decode(responseBody) as List<dynamic>;
      return decodedJson
          .map((dynamic itemJson) =>
              Entity.fromJson(itemJson as Map<String, dynamic>))
          .toList();
    } on Exception catch (error) {
      throw Exception('Json decode error: $error');
    }
  }

  @override
  Future<void> createTodo({required String title, String? description}) async {
    final body = {
      'title': title,
      if (description != null) 'description': description,
    };

    await apiClient.post(endPoint, body: json.encode(body));
  }

  @override
  Future<void> updateTodo(
      {required int id, required String title, String? description}) async {
    final body = {
      'title': title,
      if (description != null) 'description': description,
    };
    await apiClient.put('$endPoint/$id', body: json.encode(body));
  }

  @override
  Future<void> deleteTodo({required int id}) async {
    await apiClient.delete('$endPoint/$id');
  }
}
