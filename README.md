# Riverpod Advanced Playground

[![Flutter CI](https://github.com/WagyuuA5/Riverpod_Advanced_Playground/actions/workflows/ci.yml/badge.svg)](https://github.com/WagyuuA5/Riverpod_Advanced_Playground/actions/workflows/ci.yml)
[![Riverpod](https://img.shields.io/badge/Riverpod-2.5.1-blue.svg)](https://riverpod.dev)
[![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)](https://flutter.dev)

A comprehensive, professional portfolio project demonstrating advanced state management patterns in Flutter using **Riverpod** with **Code Generation** (`riverpod_generator`). 

This is not a simple counter app. It is a deeply structured playground designed to showcase how to handle complex, real-world application states efficiently.

---

## ??? System Flow & Architecture

This project is built using a clean separation of concerns, heavily relying on Riverpod for dependency injection and state management. The flow of the system is divided into specific feature-based screens, each tackling a unique state management challenge:

1. **Data Layer**: Mock repositories (`PostRepository`, `TodoRepository`, `ItemRepository`) simulate real-world API interactions, including artificial network delays and simulated server failures to test our error handling.
2. **Application Layer (Notifiers)**: This is where the business logic resides. We use Riverpod's code-generated classes (`@riverpod`) such as `AsyncNotifier` to orchestrate data fetching, mutations, and caching.
3. **Presentation Layer**: The UI strictly observes the state (`ref.watch`) and reacts to changes, loading states, and errors seamlessly without holding business logic.

---

##  Core Concepts Demonstrated

The playground consists of 5 main screens (Screens A to E) and a special Rebuild Counter screen.

| Concept | File Location | Why is it used? |
| --- | --- | --- |
| **Auto Dispose Default** (Screen A) | `random_number_provider.dart` | Proves that Riverpod's code generation applies `autoDispose` by default, automatically clearing memory when the screen is closed. |
| **Async Fetch & Pull-to-Refresh** (Screen B) | `post_list_notifier.dart` | Handles asynchronous data fetching from an API. Uses `AsyncValue.when` to gracefully show loading/error states and `ref.invalidate()` to refresh data. |
| **Optimistic Mutation & Rollback** (Screen C) | `todo_list_notifier.dart` | Demonstrates lightning-fast UX. The UI updates instantly before the API request completes. If the API fails, the Notifier catches the error and automatically rolls back the state. |
| **Family & KeepAlive Timer** (Screen D) | `item_detail_provider.dart` | Fetches specific details by ID (`Family`) and uses `ref.keepAlive()` paired with a Timer to cache the data in memory for exactly 5 minutes before disposing of it. |
| **Dependent Providers & Select** (Screen E) | `dependent_providers.dart` | Shows how one provider can watch another to create derived states (e.g., filtered lists). It also demonstrates `ref.watch(provider.select())` to prevent unnecessary widget rebuilds. |
| **Rebuild Counter** (Special) | `rebuild_counter_screen.dart` | A visual proof of concept comparing a widget that watches the full state vs. one using `.select()`. It physically counts and displays how many times `build()` is called. |

---

##  Legacy Riverpod vs Code Generation

By utilizing `riverpod_generator`, we eliminate boilerplate and make our intent much clearer.

### 1. Standard Provider
**Before (Manual):**
```dart
final randomNumberProvider = Provider.autoDispose<int>((ref) => Random().nextInt(100));
```
**After (Generator):**
```dart
@riverpod
int randomNumber(RandomNumberRef ref) => Random().nextInt(100);
```

### 2. Async Notifier
**Before (StateNotifierProvider):**
```dart
class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  PostListNotifier(this.ref) : super(const AsyncValue.loading()) { fetch(); }
  final Ref ref;

  Future<void> fetch() async {
    try {
      final data = await ref.read(postRepositoryProvider).fetchPosts();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
final postListProvider = StateNotifierProvider.autoDispose<...>((ref) => PostListNotifier(ref));
```
**After (AsyncNotifier with Generator):**
```dart
@riverpod
class PostList extends _$PostList {
  @override
  Future<List<Post>> build() async {
    // No more try-catch boilerplate for initialization!
    return ref.watch(postRepositoryProvider).fetchPosts();
  }
}
```

---

##  Getting Started

Follow these steps to run the project locally:

1. **Get Dependencies:**
   ```bash
   flutter pub get
   ```
2. **Generate Riverpod Files:**
   ```bash
   dart run build_runner build -d
   ```
3. **Run the App:**
   ```bash
   flutter run
   ```
*(Note: To run tests, simply execute `flutter test`. To check linting, run `flutter analyze`.)*

---

##  Documentation Gallery

Here is a visual walkthrough of the system in action:

<div align="center">
  <img width="32%" src="https://github.com/user-attachments/assets/6316f4a9-3d0e-450a-b02d-e0ec180f92ab" alt="Screenshot 1"/>
  <img width="32%" src="https://github.com/user-attachments/assets/4dc238d0-7933-4362-9cc8-e2f166a60b50" alt="Screenshot 2"/>
  <img width="32%" src="https://github.com/user-attachments/assets/e1ac4681-037d-4839-b934-5936f1c58a37" alt="Screenshot 3"/>
  <br/><br/>
  <img width="32%" src="https://github.com/user-attachments/assets/a844b364-f895-433c-a289-db388ef0420b" alt="Screenshot 4"/>
  <img width="32%" src="https://github.com/user-attachments/assets/d94fbd2f-dee4-4c0f-a8b6-cb3fab2b59e0" alt="Screenshot 5"/>
  <img width="32%" src="https://github.com/user-attachments/assets/908260ed-d674-496e-ba3a-8ab830bb42cf" alt="Screenshot 6"/>
  <br/><br/>
  <img width="32%" src="https://github.com/user-attachments/assets/7b542310-48ae-4968-a651-ec58b8db5429" alt="Screenshot 7"/>
  <img width="32%" src="https://github.com/user-attachments/assets/a5c37f05-fc1e-4b53-846d-c5190617e4b2" alt="Screenshot 8"/>
  <img width="32%" src="https://github.com/user-attachments/assets/39512f3f-4603-4f7e-b369-bda2685f80f3" alt="Screenshot 9"/>
  <br/><br/>
  <img width="32%" src="https://github.com/user-attachments/assets/0d1adb9e-6fdb-4a7c-998a-4107142efcb7" alt="Screenshot 10"/>
  <img width="32%" src="https://github.com/user-attachments/assets/bdd791bf-a308-43e2-bedc-687bc1fef35c" alt="Screenshot 11"/>
  <img width="32%" src="https://github.com/user-attachments/assets/ac0d4de7-42d7-402c-adbd-4c942b7f58ee" alt="Screenshot 12"/>
</div>
