# Changelog

## Unpublished

### Added

### Changed

### Fixed

---

## 1.1.0 (2025-10-09)

### Added

- **Dio Integration**: Migrated from `http` package to `Dio` for improved HTTP request handling
- **Logger Interceptor Type**: Added new `InterceptorType.logger` for better logging management
- **Interceptor Support in Endpoint**: Added optional `loggerInterceptor` parameter to Endpoint class
- **DELETE Method Support**: Added DELETE HTTP method to Endpoint enum

### Changed

- **Response Handling**: Updated authentication methods to properly handle Dio's response structure (`response.data` instead of `response.body`)
- **Endpoint Constructor**: Improved with required URL parameter, mutable maps support, and assert validation
- **Response Data Parsing**: Enhanced to handle Map, List, and String JSON formats consistently
- **Error Message Extraction**: Improved to handle various error response formats (Map, List, String JSON)
- **Interceptor Management**: Improved interceptor handling with support for logger type that applies to both authenticated and non-authenticated calls
- **Parameter Handling**: Changed from `formParams` to `data` in authentication card for better consistency

### Fixed

- **Null Status Code Handling**: Added validation to throw `DetailException` when response status code is null
- **Method Consistency**: Aligned `_parseResponseData` and `_extractErrorMessage` to handle identical data formats
- **Code Cleanup**: Removed unused imports and dependencies from various files

### Removed

- **HTTP Package Dependencies**: Removed dependency on `http` package in favor of Dio
- **HybridLogger Wrapper**: Removed HybridLoggerWrapper usage from core

---

## 1.0.10 (2025-09-03)

### Added

- **Detail Exception**: Integration of the `Detail Exception` error, with the status code and message parameters

### Changed

- An error handle has been added to the `getCurrentToken` method, which converts status codes > 300 into a `DetailException` with the status code and error message.

### Fixed

### Removed

---

## 0.0.2 (2025-08-12)

### Added

- **HybridLogger**: Integration of the `HybridLogger` package, developed by the Flutter Rudo team, to enhance event logging and debugging capabilities.

### Changed

- Updated dependencies in `pubspec.yaml` to use newer versions of packages, ensuring compatibility with the latest Flutter ecosystem.
- Updated Flutter SDK to version `3.32.8` (thoroughly tested).

### Fixed

- Added support for the named constructor `withNavigatorKey` in `PasswordAuthenticationCard` for the login page.
- Removed warnings related to auto-generated code.

### Removed

- Unused code and unnecessary dependencies.

---

## 0.0.1 (2024-02-27)

### Added

- Initial implementation of the `flutter_moshimoshi` package.

### Description

A powerful package for optimizing communication between Flutter applications and HTTP servers. Crafted to simplify the complexities of HTTP requests, authentication, and data storage, MooshiMoshi offers a robust toolkit of utilities and abstractions.
