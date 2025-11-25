# MiniMart – Flutter Shopping App

MiniMart is a sample shopping application built in Flutter.  
The goal is to demonstrate clean architecture, modern Flutter practices, and production-ready UX.

## Assignment Scope

- Home page with:
  - Search bar with debounce
  - Horizontal category list
  - Product grid (image, name, price, rating)
  - Skeleton loaders & shimmer while fetching
- Product detail page:
  - Hero animation from product card
  - Image carousel
  - Expandable description
  - Animated “Add to cart” button
- Cart page:
  - Update item quantity
  - Swipe to delete
  - Cart total calculation
  - Persistent cart state
- Profile page:
  - Editable profile
  - Theme switch (dark/light)
  - Saved items section

## Tech Stack & Decisions

- **Flutter** (stable channel)
- **State Management:** Riverpod
- **Navigation:** `go_router`
- **Local Storage:** Hive
- **Architecture:**
  - Feature-first folder structure
  - Separate layers for models, services, and state providers
  - Clear separation of UI and business logic
