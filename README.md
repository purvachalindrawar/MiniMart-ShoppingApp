# MiniMart – Grocery Shopping App

MiniMart is a small grocery shopping app built with Flutter.  
It was created as an assignment to show how I structure a real app with state
management, routing, persistence and simple animations.

The app is focused on a clean UI, smooth flows and clear code.

---

## Features

- Home
  - Search bar with debounce.
  - Category chips (Fruits, Vegetables, Dairy, Snacks).
  - Product grid with image, name, price and rating.
  - Shimmer placeholders while products load.

- Product detail
  - Hero animation from the product card.
  - Image banner (carousel ready).
  - Price and rating.
  - Description section that can be expanded.
  - Add to cart button with a small animation.

- Cart
  - List of items in the cart with quantity stepper.
  - Swipe to remove with `Dismissible`.
  - Total price calculation.
  - Cart stored locally with Hive.

- Favorites / Saved items
  - Heart icon on product detail to toggle favorite.
  - Favorites stored in Hive.
  - Saved items shown in the Profile screen.

- Profile
  - Shows the current user name and email.
  - Editable text fields.
  - Dark / light theme switch with persistence.
  - Logout button.

- Onboarding
  - Three simple onboarding pages with icons and text.
  - Page indicators and Next / Get started / Skip buttons.
  - Onboarding completion flag saved in Hive.

- Authentication (local demo)
  - Email + password sign up and sign in.
  - Auth state stored in Hive for demo purposes.
  - Initial route logic:
    - If onboarding not done → onboarding.
    - If done and user exists → home.
    - If done and no user → login screen.

---

## Tech stack

- Flutter
- Riverpod / flutter_riverpod
- go_router
- Hive + hive_flutter
- Material 3 + custom color scheme

---

## Project structure (short)

- [lib/main.dart](cci:7://file:///c:/Assesments/Mini-Mart/mini_mart/lib/main.dart:0:0-0:0) – app bootstrap and theme.
- `lib/core/` – routing, theme, onboarding provider, shared widgets.
- `lib/features/home/` – home screen and providers.
- `lib/features/product_detail/` – product detail screen.
- `lib/features/cart/` – cart screen and cart logic.
- `lib/features/profile/` – profile screen with theme + favorites + logout.
- `lib/features/auth/` – local auth state and login screen.
- `lib/features/onboarding/` – onboarding flow.
- `lib/features/favorites/` – favorites provider.
- `lib/models/` – simple models like `Product` and [User](cci:2://file:///c:/Assesments/Mini-Mart/mini_mart/lib/models/user.dart:0:0-38:1).

---

## Getting started

### Requirements

- Flutter SDK (version compatible with the `pubspec.yaml`)
- Android Studio or VS Code (optional)
- Git

Clone the repository:

```bash
git clone https://github.com/purvachalindrawar/MiniMart-ShoppingApp.git
cd MiniMart-ShoppingApp/mini_mart