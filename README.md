# 🚀 Clean Arch Generator for Dart
`clean_arch_gen`は、YAMLファイルに基づいて**Clean Architecture**のファイルとディレクトリ構造を自動生成するDartパッケージです。ボイラープレートの作成時間を大幅に短縮し、開発者がアプリケーションのロジックに集中できるようにします。

## ✨ 特徴
  - 簡単な設定: シンプルなYAMLファイルで、ドメイン、プレゼンテーション、インフラストラクチャの各レイヤーを定義できます。
  - 自動生成: エンティティ、ユースケース、リポジトリ、データソースなどのファイルを一括で生成します。
  - クリーンな構造: Clean Architectureの原則に則った、整理されたファイル構成を提供します。
  - 拡張可能: 定義ファイルに新しい要素を追加するだけで、簡単に機能を拡張できます。

## ⚙️ 使い方
### 1\. パッケージのインストール
`pubspec.yaml`ファイルに以下の依存関係を追加します。

```yaml
dev_dependencies:
  clean_arch_gen: ^1.0.0
```

そして、ターミナルで以下のコマンドを実行してパッケージをインストールします。

```bash
dart pub get
```

### 2\. YAMLファイルの作成
プロジェクトのあるディレクトリ(おすすめは`lib/feature/機能名/`配下)に、任意の名前（例：`user_auth.yaml`）でYAMLファイルを作成します。以下は、ユーザー認証機能を例としたYAMLファイルです。

```yaml
feature_name: UserAuthentication

domain:
  entities:
    - User:
        fields:
          id: String
          email: String
          name: String
  usecases:
    - AuthenticateUsecase:
        method:
          returns: Future<User>
          params:
            - email: String
            - password: String
          isAsync: true
  repositories:
    - UserRepository:
        methods:
          - findByEmail:
              returns: Future<User>
              params:
                - email: String
              isAsync: true
          - validateCredentials:
              returns: Future<bool>
              params:
                - email: String
                - password: String
              isAsync: true

infrastructure:
  datasources:
    - AuthDatasource:
        methods:
          - authenticate:
              returns: Future<AuthResponse>
              params:
                - email: String
                - password: String
              isAsync: true
  responses:
    - AuthResponse

presentation:
  pages:
    - Login
    - Dashboard
  notifiers:
    - Auth
```

### 3\. ファイルの生成
YAMLファイルを作成したら、以下のコマンドを実行してファイルを生成します。

```bash
dart run clean_arch_gen <path_to_your_yaml_file>
```

例：

```bash
dart run clean_arch_gen C:/Users/User/flutter_app/lib/feature/test/user_auth.yaml
```

このコマンドを実行すると、YAMLファイルで定義された構造に基づいて、YAMLファイルと同じディレクトリ内に各レイヤーごとのディレクトリが自動生成されます。

また、これらで生成されるモデルファイルは`freezed`を使用しているので、その生成コマンドも一緒に実行します。
```bash
flutter pub run build_runner build
```

そのあと、`datasource`やリポジトリの処理を書きます。

### 4\. 生成されるファイル構造
上記のYAMLファイルを基に、以下のようなファイルとディレクトリが生成されます。

```
lib/
└── features/
    └── user_authentication/
        ├──user_auth.yaml
        ├── application/
        │   ├── extensions/
        │   ├── utils/
        │   └── usecase/
        │       └── authention_usecase_impl.dart
        ├── core/
        ├── domain/
        │   ├── entity/
        │   │   └── user.dart
        │   ├── factory/
        │   │   └── user_factory.dart
        │   ├── usecases/
        │   │   └── authenticate_usecase.dart
        │   └── repositories/
        │       └── user_repository.dart
        ├── infrastructure/
        │   ├── datasources/
        │   │   └── auth_datasource.dart
        │   ├── factory/
        │   │   └── user_factory_impl.dart
        │   └── responses/
        │       └── auth_response.dart
        └── presentation/
            ├── components/
            ├── pages/
            │   ├── login_page.dart
            │   └── dashboard_page.dart
            └── notifiers/
                └── auth_notifier.dart
```

-----

## YAMLの書き方
`clean_arch_gen`のYAMLファイルの書き方は、以下の主要なセクションで構成されています。

### 1\. 📂 `feature_name`
生成する機能の名前を定義します。これは、ファイルやディレクトリの名前付けに使用されます。

```yaml
feature_name: UserAuthentication
```

### 2\. 📂 `domain`
Clean Architectureの**ドメイン層**を定義します。
  - **`entities`**: アプリケーションのコアデータを表すエンティティを定義します。
      - `[エンティティ名]`:
          - `fields`: フィールド名とデータ型をキーとバリューで指定します。
  - **`usecases`**: ビジネスロジックをカプセル化するユースケースを定義します。
      - `[ユースケース名]`:
          - `method`:
              - `returns`: 返り値の型を指定します。
              - `params`: メソッドの引数をフィールド名とデータ型のリストで指定します。
              - `isAsync`: メソッドが非同期かどうかを`true`または`false`で指定します。
  - **`repositories`**: データアクセスを抽象化するリポジトリを定義します。
      - `[リポジトリ名]`:
          - `methods`:
              - `[メソッド名]`:
                  - `returns`: 返り値の型を指定します。
                  - `params`: メソッドの引数をフィールド名とデータ型のリストで指定します。
                  - `isAsync`: メソッドが非同期かどうかを`true`または`false`で指定します。

### 3\. 📂 `infrastructure`
Clean Architectureの**インフラストラクチャ層**を定義します。
  - **`datasources`**: 外部データ（API、データベースなど）にアクセスするデータソースを定義します。
      - `[データソース名]`:
          - `methods`:
              - `[メソッド名]`:
                  - `returns`: 返り値の型を指定します。
                  - `params`: メソッドの引数をフィールド名とデータ型のリストで指定します。
                  - `isAsync`: メソッドが非同期かどうかを`true`または`false`で指定します。
  - **`responses`**: データソースからの応答を表すモデルを定義します。
      - `[応答名]`

### 4\. 📂 `presentation`
Clean Architectureの**プレゼンテーション層**を定義します。
  - **`pages`**: ユーザーインターフェースの画面を定義します。
      - `[ページ名]`
  - **`notifiers`**: 画面の状態管理を行うクラスを定義します。
      - `[Notifier名]`

---

## 🤝 貢献
このプロジェクトはオープンソースです。バグ報告、機能提案、プルリクエストを歓迎します。

## 📄 ライセンス
このプロジェクトはMITライセンスの下で公開されています。
