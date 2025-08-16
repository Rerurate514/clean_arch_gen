import 'package:clean_arch_gen/src/utils/recase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringCasingExtension', () {
    group('toLowerCamelCase', () {
      test('ハイフン区切りの文字列をローワーキャメルケースに変換する', () {
        expect('my-variable-name'.toLowerCamelCase(), 'myVariableName');
      });

      test('アンダースコア区切りの文字列をローワーキャメルケースに変換する', () {
        expect('my_variable_name'.toLowerCamelCase(), 'myVariableName');
      });

      test('スペース区切りの文字列をローワーキャメルケースに変換する', () {
        expect('my variable name'.toLowerCamelCase(), 'myVariableName');
      });

      test('複数の区切り文字が混在する文字列を適切に処理する', () {
        expect('my-variable_name test'.toLowerCamelCase(), 'myVariableNameTest');
      });

      test('空の文字列を処理する', () {
        expect(''.toLowerCamelCase(), '');
      });

      test('単一の単語を処理する', () {
        expect('variable'.toLowerCamelCase(), 'variable');
      });

      test('すべて大文字の単語を処理する', () {
        expect('VARIABLE'.toLowerCamelCase(), 'variable');
      });

      test('アッパーキャメルケースをロウワ―キャメルケースに処理する', () {
        expect('MyVariableName'.toLowerCamelCase(), 'myVariableName');
      });
    });

    group('toLowerSnakeCase', () {
      test('キャメルケースをスネークケースに変換する', () {
        expect('myVariableName'.toLowerSnakeCase(), 'my_variable_name');
      });

      test('先頭が大文字のキャメルケースを処理する', () {
        expect('MyVariableName'.toLowerSnakeCase(), 'my_variable_name');
      });

      test('ハイフン区切りの文字列をスネークケースに変換する', () {
        expect('my-variable-name'.toLowerSnakeCase(), 'my_variable_name');
      });

      test('スペース区切りの文字列をスネークケースに変換する', () {
        expect('my variable name'.toLowerSnakeCase(), 'my_variable_name');
      });

      test('空の文字列を処理する', () {
        expect(''.toLowerSnakeCase(), '');
      });

      test('単一の単語を処理する', () {
        expect('variable'.toLowerSnakeCase(), 'variable');
      });
    });
  });
}
