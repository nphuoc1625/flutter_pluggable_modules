# flutter_pluggable_modules

Design isolated, scalable, testable, abstract feature modules using clean architecture principles that able to work with different implementations

## Architecture Overview

### 🏗️ Architecture Module
- Clean Architecture (Presentation, Domain, Data layers)
- SOLID principles implementation
- Dependency Injection (GetIt, Provider)
- State Management (Bloc, Riverpod, Provider)
- Repository Pattern
- Factory Pattern for object creation
- Strategy Pattern for interchangeable behaviors
- Observer Pattern for event handling

## Feature Modules

1. 🔐 AuthModule
- Email/password, phone, social login
- AuthRepository abstraction
- Platform-native login (e.g. Google/Facebook via native SDKs)
- Persist token/session
- Auth state management
- Token refresh mechanism

2. 💳 PaymentModule
- Payment gateway (e.g., Stripe, ZaloPay, Momo)
- Native SDK integration (via platform channels or plugins)
- Payment flow abstraction
- Handle success/failure/cancel logic
- Payment state management
- Transaction history

3. 🔔 NotificationModule (Optional)
- Push notifications (Firebase Messaging)
- Local notifications
- Handle foreground, background, terminated
- Notification preferences
- Notification center

4. 📄 ProfileModule
- User settings
- Upload avatar (camera/gallery)
- Preferences and update profile API
- Profile state management
- User data caching

5. 📦 CoreModule
- Networking (Dio or Chopper)
- Token interceptor
- Error handling
- App-wide constants/enums
- Base classes and interfaces
- Common widgets
- Utility functions
- Theme management
- Localization
- Analytics tracking