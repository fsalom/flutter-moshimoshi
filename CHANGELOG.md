# Changelog

## Unpublished

### Added

- **Detail Exception**: Integration of the `Detail Exception` error, with the status code and message parameters

### Changed

- An error handle has been added to the `getCurrentToken` method, which converts status codes > 300 into a `DetailException` with the status code and error message.

### Fixed

### Removed

- `AuthorizationFailed` class removed

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
