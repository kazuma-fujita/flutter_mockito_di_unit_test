import 'package:flutter_mockito_di_unit_test/entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mockito_di_unit_test/api_client.dart';
import 'package:flutter_mockito_di_unit_test/repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fixture.dart';
import 'repository_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient _apiClient;
  late Repository _repository;

  setUp(() {
    _apiClient = MockApiClient();
    _repository = RepositoryImpl(apiClient: _apiClient);
  });

  group('Todo repository testing', () {
    test('Test of fetch list with empty response.', () async {
      when(_apiClient.get(any)).thenAnswer((_) async => '[]');
      final todoList = await _repository.fitchList();
      verify(_apiClient.get(any)).called(1);
      expect(
          todoList,
          isA<List<Entity>>()
              .having((list) => list, 'isNotNull', isNotNull)
              .having((list) => list.length, 'length', 0));
    });

    test('Test of fetch list.', () async {
      final mockResponse = fixture('get_response.json');
      when(_apiClient.get(any)).thenAnswer((_) async => mockResponse);
      final todoList = await _repository.fitchList();
      verify(_apiClient.get(any)).called(1);
      expect(
        todoList,
        isA<List<Entity>>()
            .having((list) => list, 'isNotNull', isNotNull)
            .having((list) => list.length, 'length', 3)
            .having((list) => list[0].id, 'id', 1)
            .having((list) => list[0].title, 'title', 'First task')
            .having((list) => list[1].id, 'id', 2)
            .having((list) => list[1].title, 'title', 'Second task')
            .having((list) => list[2].id, 'id', 3)
            .having((list) => list[2].title, 'title', 'Third task'),
      );
    });

    test('Test of create todo.', () async {
      when(_apiClient.post(any, body: anyNamed('body')))
          .thenAnswer((_) async => '{"id": 1, "title": "First task"}');
      await _repository.createTodo(title: 'dummy');
      verify(_apiClient.post(any, body: anyNamed('body'))).called(1);
    });

    test('Test of update todo.', () async {
      when(_apiClient.put(any, body: anyNamed('body')))
          .thenAnswer((_) async => '{"id": 2, "title": "Rename task"}');
      await _repository.updateTodo(id: 1, title: 'dummy');
      verify(_apiClient.put(any, body: anyNamed('body'))).called(1);
    });

    test('Test of delete todo.', () async {
      when(_apiClient.delete(any)).thenAnswer((_) async => '');
      await _repository.deleteTodo(id: 1);
      verify(_apiClient.delete(any)).called(1);
    });
  });
  group('Todo repository error testing', () {
    test('Test of fetch list with format error json.', () async {
      final mockResponse = fixture('format_error_response.json');
      when(_apiClient.get(any)).thenAnswer((_) async => mockResponse);
      expect(() => _repository.fitchList(), throwsException);
    });
  });
}
