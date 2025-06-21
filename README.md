# News Grid Flutter App 🚀

A sleek, responsive Flutter application that delivers the latest news under one roof. Featuring a beautiful splash screen, category-based browsing, trending and breaking news sections, and direct links to full articles.

---

## ✨ Features

* **Beautiful Splash Screen**: Engaging entry animation that sets the tone for the app.
* **Category Explorer**: Browse news by topic—Technology, Business, Sports, Health, Entertainment, and more.
* **Trending News**: View the most popular articles of the day, updated in real time.
* **Breaking News**: Stay ahead with the latest headlines as they happen.
* **Interactive Cards**: Designed with Material elevation, rounded corners, and ripple feedback.
* **Efficient Image Caching**: Fast, offline-capable images with `cached_network_image` and graceful placeholders.
* **Pull-to-Refresh**: Instantly update any feed by swiping down.
* **Deep Linking**: Tap "Read More" to open full articles in the device browser via `url_launcher`.

---

## 📺 Demo

<video src="assets/videos/NewApp.mp4" controls width="100%" poster="docs/demo-poster.png">
  Your browser does not support the video tag.
</video>

> For a quick GIF preview, see [assets/videos/NewApp.mp4](docs/demo.gif)

---

## 🚀 Getting Started

### Prerequisites

* **Flutter SDK** v2.10.0 or higher
* **Dart** v2.16.0 or higher
* A valid **NewsAPI** key: [https://newsapi.org](https://newsapi.org)

### Installation

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/news_grid_flutter.git
   cd news_grid_flutter
   ```
2. **Install packages**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```



## 🗂 Project Structure

```plaintext
lib/
├── model/
│   ├── api_model.dart         # Article and data models
│   ├── category_model.dart    # News category model
│   ├── category_tile.dart     # Category tile widget
│   └── data.dart              # Static data (e.g., category list)
├── model_screens/
│   ├── category_detail_page.dart  # Category-specific news view
│   ├── deatil_breaking.dart       # Breaking news widget
│   ├── headline_news.dart         # Headline news section
│   └── trending_news.dart         # Trending news section
├── Screens/
│   ├── homepage.dart           # Main landing/home screen
│   ├── landing_pages.dart      # Early landing pages (intro/tutorial)
│   ├── news_provider.dart      # State management for API data
│   └── splash_Screen.dart      # Beautiful splash animation
├── services/
│   └── fetch_api.dart          # Networking with NewsAPI
└── main.dart                   # App entry point
```



## 📦 Dependencies

| Package                 | Purpose                       |
| ----------------------- | ----------------------------- |
| `flutter`               | Core framework                |
| `cached_network_image`  | Async image loading & caching |
| `url_launcher`          | Open external URLs            |
| `http`                  | NEWS API calls                |
| `provider` *(optional)* | State management              |



## 🤝 Contributing

1. Fork this repository
2. Create a branch: `git checkout -b feature/YourFeature`
3. Commit changes: `git commit -m "Add feature: YourFeature"`
4. Push branch: `git push origin feature/YourFeature`
5. Open a Pull Request

Please follow the existing code style and include tests if applicable.







*Built with ❤️ using Flutter.*
