# FLEX YEMEN 🛒

<div align="center">

[![Flutter Version](https://img.shields.io/badge/Flutter-3.22+-blue.svg)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Codemagic](https://img.shields.io/badge/Codemagic-Build-green.svg)](https://codemagic.io)

**السوق الإلكتروني اليمني الأول - منصة عالمية تنافس Amazon و Alibaba**

[🇺🇸 English](#english) | [🇸🇦 العربية](#arabic)

</div>

---

<a name="arabic"></a>
# 🇸🇦 العربية

## 🎯 نظرة عامة

**FLEX YEMEN** هو السوق الإلكتروني اليمني الأول المصمم لتنافس أكبر المنصات العالمية مثل Amazon و Alibaba. يوفر المنصة تجربة تسوق إلكتروني متكاملة مع محفظة إلكترونية متعددة العملات ونظام محادثات فوري.

## ✨ المميزات الرئيسية

### 🎨 تصميم عالمي احترافي
- ✅ ثيم داكن/نهاري مع ألوان ذهبية مميزة
- ✅ خط Changa SemiBold العربي الاحترافي
- ✅ أيقونات SVG متجهة عالية الجودة
- ✅ لمسات حركية سلسة (Animations)
- ✅ خلفيات متحركة جذابة

### 🔐 نظام المصادقة المتقدم
- ✅ تسجيل الدخول برقم الموبايل
- ✅ خيارين للتسجيل: **تاجر** أو **عميل**
- ✅ دخول كضيف بدون تسجيل
- ✅ مصادقة بصمة (Biometric)
- ✅ استعادة كلمة المرور

### 💰 المحفظة الإلكترونية
- ✅ 3 عملات: ريال يمني / ريال سعودي / دولار أمريكي
- ✅ شحن الرصيد
- ✅ تحويل الأموال
- ✅ سحب نقدي
- ✅ سجل العمليات
- ✅ المدفوعات

### 📱 الصفحات المتوفرة

| الصفحة | الوصف |
|--------|-------|
| Splash Screen | شاشة ترحيب متحركة (5 ثواني) |
| Login Screen | تسجيل الدخول مع خيارين (تاجر/عميل) |
| Register Screen | إنشاء حساب جديد |
| Home Screen | الصفحة الرئيسية مع سلايدر (5 سلايدات) |
| Wallet Screen | المحفظة الإلكترونية |
| Add Ad Screen | إضافة إعلان مع رفع الصور |
| Chat Screen | نظام المحادثات الفوري |
| Profile Screen | حسابي مع الإحصائيات |
| Settings Screen | الإعدادات المتكاملة |

## 🚀 التثبيت والتشغيل

### المتطلبات
- Flutter 3.22+
- Dart 3.0+
- Android SDK 21+
- Xcode 14+ (لـ iOS)

### خطوات التثبيت

```bash
# 1. استنساخ المشروع
git clone https://github.com/flexyemen/app.git
cd flex_yemen

# 2. تثبيت الاعتماديات
flutter pub get

# 3. تشغيل التطبيق
flutter run
```

### بناء الإصدار

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 🏗️ هيكل المشروع

```
lib/
├── main.dart                    # نقطة الدخول
├── models/                      # نماذج البيانات
│   ├── user_model.dart
│   ├── ad_model.dart
│   └── wallet_model.dart
├── screens/                     # الشاشات
│   ├── splash_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── main_navigation.dart
│   ├── home_screen.dart
│   ├── wallet_screen.dart
│   ├── add_ad_screen.dart
│   ├── chat_screen.dart
│   ├── profile_screen.dart
│   ├── wallet/                  # صفحات المحفظة
│   │   ├── deposit_screen.dart
│   │   ├── transfer_screen.dart
│   │   ├── withdraw_screen.dart
│   │   ├── transactions_screen.dart
│   │   └── payments_screen.dart
│   └── settings/                # صفحات الإعدادات
│       ├── notifications_settings_screen.dart
│       ├── security_settings_screen.dart
│       ├── payment_methods_screen.dart
│       ├── language_screen.dart
│       ├── about_screen.dart
│       ├── privacy_policy_screen.dart
│       └── help_support_screen.dart
├── services/                    # الخدمات
│   └── supabase_service.dart
├── theme/                       # الثيم والتصميم
│   └── app_theme.dart
└── widgets/                     # الويدجات المشتركة
```

## 🔧 التقنيات المستخدمة

| التقنية | الاستخدام |
|---------|----------|
| Flutter 3.22+ | إطار العمل الرئيسي |
| Dart 3.0+ | لغة البرمجة |
| Supabase | قاعدة البيانات والمصادقة |
| Provider | إدارة الحالة |
| flutter_svg | الأيقونات المتجهة |
| flutter_animate | اللمسات الحركية |
| google_fonts | الخطوط |
| image_picker | رفع الصور |

## 📦 CI/CD

### Codemagic
```yaml
# codemagic.yaml
# تم تكوينه لـ:
# - بناء Android (APK + AAB)
# - بناء iOS (IPA)
# - بناء Web
# - نشر على Google Play
# - نشر على App Store
```

### GitHub Actions
```yaml
# .github/workflows/flutter_ci.yml
# يتضمن:
# - تحليل الكود
# - تشغيل الاختبارات
# - بناء Android/iOS/Web
# - إنشاء إصدارات
```

## 🌐 البيئات

| البيئة | الوصف |
|--------|-------|
| Development | التطوير المحلي |
| Staging | الاختبار قبل الإنتاج |
| Production | الإنتاج |

## 📱 لقطات الشاشة

<div align="center">

| شاشة الترحيب | تسجيل الدخول | الصفحة الرئيسية |
|:------------:|:------------:|:---------------:|
| ![Splash](screenshots/splash.png) | ![Login](screenshots/login.png) | ![Home](screenshots/home.png) |

| المحفظة | المحادثات | الإعدادات |
|:-------:|:---------:|:---------:|
| ![Wallet](screenshots/wallet.png) | ![Chat](screenshots/chat.png) | ![Settings](screenshots/settings.png) |

</div>

## 🤝 المساهمة

نرحب بمساهماتكم! يرجى اتباع الخطوات التالية:

1. Fork المشروع
2. إنشاء فرع جديد (`git checkout -b feature/amazing-feature`)
3. Commit التغييرات (`git commit -m 'Add amazing feature'`)
4. Push للفرع (`git push origin feature/amazing-feature`)
5. فتح Pull Request

## 📄 الترخيص

هذا المشروع مرخص بموجب [MIT License](LICENSE).

## 📞 التواصل

- 🌐 الموقع: [www.flexyemen.com](https://www.flexyemen.com)
- 📧 البريد: support@flexyemen.com
- 📱 الهاتف: +967 777 123 456
- 💬 واتساب: [رابط الواتساب](https://wa.me/967777123456)

---

<div align="center">

**تم التطوير بكل ❤️ في اليمن**

© 2024 FLEX YEMEN. جميع الحقوق محفوظة.

</div>

---

<a name="english"></a>
# 🇺🇸 English

## 🎯 Overview

**FLEX YEMEN** is Yemen's first e-commerce platform designed to compete with global giants like Amazon and Alibaba. It provides a complete online shopping experience with a multi-currency digital wallet and instant messaging system.

## ✨ Key Features

### 🎨 Professional Global Design
- ✅ Dark/Light theme with distinctive gold colors
- ✅ Professional Changa SemiBold Arabic font
- ✅ High-quality SVG vector icons
- ✅ Smooth animations
- ✅ Attractive animated backgrounds

### 🔐 Advanced Authentication System
- ✅ Phone number login
- ✅ Two registration options: **Merchant** or **Customer**
- ✅ Guest login without registration
- ✅ Biometric authentication
- ✅ Password recovery

### 💰 Digital Wallet
- ✅ 3 currencies: Yemeni Rial / Saudi Riyal / US Dollar
- ✅ Balance recharge
- ✅ Money transfer
- ✅ Cash withdrawal
- ✅ Transaction history
- ✅ Payments

## 🚀 Installation & Running

### Requirements
- Flutter 3.22+
- Dart 3.0+
- Android SDK 21+
- Xcode 14+ (for iOS)

### Installation Steps

```bash
# 1. Clone the repository
git clone https://github.com/flexyemen/app.git
cd flex_yemen

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

### Building Releases

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 🔧 Technologies Used

| Technology | Usage |
|------------|-------|
| Flutter 3.22+ | Main framework |
| Dart 3.0+ | Programming language |
| Supabase | Database & Authentication |
| Provider | State management |
| flutter_svg | Vector icons |
| flutter_animate | Animations |
| google_fonts | Fonts |
| image_picker | Image upload |

## 📦 CI/CD

### Codemagic Configuration
- Android build (APK + AAB)
- iOS build (IPA)
- Web build
- Google Play deployment
- App Store deployment

### GitHub Actions Workflow
- Code analysis
- Test execution
- Android/iOS/Web builds
- Release creation

## 📄 License

This project is licensed under the [MIT License](LICENSE).

## 📞 Contact

- 🌐 Website: [www.flexyemen.com](https://www.flexyemen.com)
- 📧 Email: support@flexyemen.com
- 📱 Phone: +967 777 123 456
- 💬 WhatsApp: [WhatsApp Link](https://wa.me/967777123456)

---

<div align="center">

**Developed with ❤️ in Yemen**

© 2024 FLEX YEMEN. All rights reserved.

</div>
