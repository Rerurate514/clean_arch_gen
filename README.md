日本語READMEはこちら : https://github.com/Rerurate514/clean_arch_gen/blob/develop/README-ja.md

# 🚀 Clean Arch Generator for Dart
`clean_arch_gen` is a Dart package that automatically generates **Clean Architecture** files and directory structures based on YAML files. It significantly reduces boilerplate creation time and allows developers to focus on application logic.

## ✨ Features
- Simple Configuration: Define domain, presentation, and infrastructure layers with a simple YAML file.
- Auto-generation: Generate entities, use cases, repositories, data sources, and other files in bulk.
- Clean Structure: Provides an organized file structure that follows Clean Architecture principles.
- Extensible: Easily extend functionality by simply adding new elements to the definition file.

## ⚙️ Usage
### 1. Package Installation
Add the following dependency to your `pubspec.yaml` file.

```yaml
dev_dependencies:
  clean_arch_gen: ^1.0.0
```

Then run the following command in the terminal to install the package.

```bash
dart pub get
```

### 2. Creating YAML File
Create a YAML file with any name (e.g., `user_auth.yaml`) in your project directory (recommended location: `lib/feature/feature_name/`). Below is an example YAML file for user authentication functionality.

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
        repositories: 
          - UserRepository
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

### 3. File Generation
After creating the YAML file, run the following command to generate the files.

```bash
dart run clean_arch_gen <path_to_your_yaml_file>
```

Example:

```bash
dart run clean_arch_gen C:/Users/User/flutter_app/lib/feature/test/user_auth.yaml
```

When you run this command, directories for each layer will be automatically generated in the same directory as the YAML file, based on the structure defined in the YAML file.

Since the generated model files use `freezed`, run the generation command together:
```bash
flutter pub run build_runner build
```

After that, write the processing for `datasource` and repositories.

### 4. Generated File Structure
Based on the above YAML file, the following files and directories will be generated:

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

## YAML Writing Guide
The YAML file structure for `clean_arch_gen` consists of the following main sections:

### 1. 📂 `feature_name`
Defines the name of the feature to be generated. This is used for naming files and directories.

```yaml
feature_name: UserAuthentication
```

### 2. 📂 `domain`
Defines the **domain layer** of Clean Architecture.
- **`entities`**: Defines entities that represent core data of the application.
    - `[Entity Name]`:
        - `fields`: Specify field names and data types as key-value pairs.
- **`usecases`**: Defines use cases that encapsulate business logic.
    - `[Use Case Name]`:
        - `repositories`: Define repository names with dependencies here in list format.
        - `method`:
            - `returns`: Specify the return type.
            - `params`: Specify method arguments as a list of field names and data types.
            - `isAsync`: Specify whether the method is asynchronous with `true` or `false`.
- **`repositories`**: Defines repositories that abstract data access.
    - `[Repository Name]`:
        - `methods`:
            - `[Method Name]`:
                - `returns`: Specify the return type.
                - `params`: Specify method arguments as a list of field names and data types.
                - `isAsync`: Specify whether the method is asynchronous with `true` or `false`.

### 3. 📂 `infrastructure`
Defines the **infrastructure layer** of Clean Architecture.
- **`datasources`**: Defines data sources that access external data (API, database, etc.).
    - `[Data Source Name]`:
        - `methods`:
            - `[Method Name]`:
                - `returns`: Specify the return type.
                - `params`: Specify method arguments as a list of field names and data types.
                - `isAsync`: Specify whether the method is asynchronous with `true` or `false`.
- **`responses`**: Defines models that represent responses from data sources.
    - `[Response Name]`

### 4. 📂 `presentation`
Defines the **presentation layer** of Clean Architecture.
- **`pages`**: Defines user interface screens.
    - `[Page Name]`
- **`notifiers`**: Defines classes that manage screen state.
    - `[Notifier Name]`

---

## 🤝 Contributing
This project is open source. We welcome bug reports, feature suggestions, and pull requests.

## 📄 License
This project is published under the MIT License.
