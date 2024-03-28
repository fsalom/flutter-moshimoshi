# MoshiMoshi  <img src="/lib/docs/assets/moshiMoshiIcon.png" alt="image" width="70" height="70">
[![My Skills](https://skillicons.dev/icons?i=dart,flutter)](https://flutter.dev)

Introducing the MooshiMoshi library: A powerful pakage for optimizing communication between Flutter applications and HTTP servers. Crafted to simplify the complexities of HTTP requests, authentication, and data storage, MooshiMoshi offers a robust toolkit of utilities and abstractions.

## Get started

### Install

Add the `MoshiMoshi` package to your
[pubspec dependencies](https://pub.dev/packages/dio/install).
```dart
 flutter_moshimoshi:
    git:
      url: https://github.com/fsalom/flutter-moshimoshi
```
**Flutter versions: This package requires nullsafety to work, so it can only be run on flutter versions higher than 2.0.1


## Awesome MoshiMoshi

🎉 A curated list of awesome things related to MoshiMoshi.

### Third party plugins
[Dio](https://pub.dev/packages/dio) is a powerful tool that provides robust functionality to handle HTTP requests and responses efficiently. By integrating Dio within MoshiMoshi, we ensure optimal performance and a smooth development experience for users when performing network operations on their applications.
## Usage
To implement this package correctly it is recommended to create a wrapper, this class encapsulates the configuration and initialisation of the MooshiMoshi library along with other related components such as the authenticator, storage and interceptors. It provides a convenient way to initialise and access these components throughout the application.

### Wrapper
Some of the methods we suggest you implement in the wrapper are the following:

`initialize(BuildContext? context):`
This method initializes the components necessary for authentication. It sets up the token storage, password authentication card, authenticator, and authentication interceptor.\
   ###### **Parameters:** 
    context: A BuildContext object


`_buildAuthCard(BuildContext? context):`
This is a private method used internally to construct the password authentication card. It utilizes provided login and refresh endpoints along with a login page to create the authentication card.\
  ###### **Parameters:** 
    context: A BuildContext object


`_buildMoshi(Authenticator authenticator, StorageInterface tokenStore, AuthInterceptor authInterceptor):`
Another private method, this one is responsible for building and configuring an instance of MoshiMoshi. It configures MoshiMoshi with an authenticator, token storage, and authentication interceptor. Additionally, it adds a custom interceptor (CustomInterceptor) to requests made by MoshiMoshi.\
  ###### **Parameters:** 
    authenticator: The authenticator used in the application.
    tokenStore: The storage interface for tokens.
    authInterceptor: The authentication interceptor.


`moshi:`
This is a getter method that returns the built instance of MoshiMoshi.

`authenticator:`
This getter method returns the authenticator used in the application.

<details>
    <summary>Wrapper example</summary>
    <br>

```dart

class Endpoints {
  static final Endpoint loginEndpoint = Endpoint(
    url: '/auth/token',
    headers: {"Content-Type": "application/json"},
    method: Method.post,
  );

  static final Endpoint refreshEndpoint = Endpoint(
    url: '/auth/token',
    headers: {"Content-Type": "application/json"},
    method: Method.post,
  );
}

class MoshiWrapper {
  late final StorageInterface _tokenStore;
  late final PasswordAuthenticationCard _authCard;
  late final AuthInterceptor _authInterceptor;
  late final Authenticator _authenticator;
  late final MoshiMoshi _moshi;

  factory MoshiWrapper() => _singleton;
  MoshiWrapper._internal();

  static final MoshiWrapper _singleton = MoshiWrapper._internal();

  void initialize(BuildContext? context) {
    _tokenStore = SharedPreferencesStorage();
    _authCard = _buildAuthCard(context);
    _authenticator = Authenticator(_tokenStore, _authCard);
    _authInterceptor = AuthInterceptor(authenticator: _authenticator);
    _moshi = _buildMoshi(_authenticator, _tokenStore, _authInterceptor);
  }

  PasswordAuthenticationCard _buildAuthCard(BuildContext? context) {
    return PasswordAuthenticationCard(
      loginEndpoint: Endpoints.loginEndpoint,
      refreshEndpoint: Endpoints.refreshEndpoint,
      context: context,
      loginPage: const CharacterView(),
    );
  }

  MoshiMoshi _buildMoshi(
    Authenticator authenticator,
    StorageInterface tokenStore,
    AuthInterceptor authInterceptor,
  ) {
    final moshi = MoshiMoshi(
      authenticator: authenticator,
      storage: tokenStore,
      interceptor: authInterceptor,
    );
    moshi.call.interceptors.add(CustomInterceptor());
    return moshi;
  }

  MoshiMoshi get moshi => _moshi;
  Authenticator get authenticator => _authenticator;
}
```
</details>

### Performing auth:
```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoshiWrapper().initialize(context); 
    return MaterialApp(
      title: 'My App',
      home: LoginePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "grant_type": "xxxx", 
      'email': "xxxx@xxxxx.com",
      'password': "xxxxxxxxx",
    };
    final moshi = MoshiWrapper(); 
    Response<dynamic>? response;
    await moshi.moshi.authenticator.getNewToken(data);
  }
}
```

### Performing a requests:
Within the HTTP calls section we can differentiate two types, public or authenticated calls, the latter makes use of the data obtained from the authenticator to be able to make the calls.
#### Public request:
```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoshiWrapper().initialize(context); 
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moshi = MoshiWrapper(); 
    Response<dynamic>? response;
    response = await moshi.moshi.call
        .get('https://example.com');
  }
}
```
#### Ahtheticated request:
```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoshiWrapper().initialize(context); 
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moshi = MoshiWrapper(); 
    Response<dynamic>? response;
    response = await moshi.moshi.callAuthenticated.get('https://example-auth.com');
  }
}
```
### 💖 Thanks!
