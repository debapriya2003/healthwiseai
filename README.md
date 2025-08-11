Got it ✅
Here’s a **feature and technical documentation** in **Markdown** for the Flutter chat app you’ve been working on:

---


# 📱 Flutter AI Chat App — Feature & Technical Documentation

## 📖 Overview
This Flutter application is an **AI-powered chat interface** that allows users to send messages to an AI model and receive **formatted (Markdown-supported)** responses in real-time.  
It features a **light/dark mode toggle**, **UI with boundaries**, **chat saving**, and a **sidebar for navigation** (without Supabase).

---

## 🚀 Features

### 1. 💬 Real-Time AI Chat
- Users can type messages in the input field and get responses instantly from the AI model.
- AI responses support **Markdown** formatting for:
  - Headings
  - Bold, Italics, and Underline
  - Code blocks and inline code
  - Bullet points and numbered lists
- Messages are displayed in a **chat bubble format** with clear sender separation.

---

### 2. 🎨 Light/Dark Mode
- Implemented **dynamic theme switching** for better user experience.
- Stores theme preference locally (so the app remembers your mode).
- Uses `ThemeData.light()` and `ThemeData.dark()` in Flutter.

---

### 3. 🖌 Improved UI Design
- **Boundaries around messages** for clear separation.
- **Rounded chat bubbles** for modern aesthetics.
- Distinct colors for **user** and **AI messages**.
- Scrollable chat history using `ListView.builder`.
- Proper spacing, padding, and margins.

---

### 4. 📂 Chat Saving (Local)
- Conversations are stored **locally** (no database, no Supabase).
- Uses **local JSON storage** with Flutter’s `shared_preferences` or `hive` package.
- Users can reopen the app and view previous chats.

---

### 5. 📑 Sidebar Navigation
- **Drawer menu** on the left side.
- Contains:
  - Home (current chat)
  - Saved Chats
  - Settings (Theme toggle)
  - About

---

### 6. 🛠 Debugging & Error Handling
- Try/catch blocks to handle API errors.
- Shows friendly messages when something goes wrong.
- Prevents empty message submissions.

---

## 🛠 Technical Implementation

### **1. Project Structure**
```

lib/
│── main.dart            # Entry point of the app
│── chat\_page.dart       # Main chat screen
│── message\_model.dart   # Message data structure
│── storage\_service.dart # Local storage handling
│── theme\_service.dart   # Light/Dark mode handling
│── sidebar.dart         # Drawer menu UI

````

---

### **2. Message Model**

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});

  Map<String, dynamic> toJson() => {
    'sender': sender,
    'text': text,
  };

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    sender: json['sender'],
    text: json['text'],
  );
}


---

### **3. Local Storage**

* Using `shared_preferences`:

```dart
Future<void> saveChat(List<Message> messages) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = jsonEncode(messages.map((m) => m.toJson()).toList());
  prefs.setString('saved_chat', jsonData);
}

Future<List<Message>> loadChat() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonData = prefs.getString('saved_chat');
  if (jsonData == null) return [];
  final List decoded = jsonDecode(jsonData);
  return decoded.map((item) => Message.fromJson(item)).toList();
}
```

---

### **4. Light/Dark Mode**

```dart
ThemeMode _themeMode = ThemeMode.light;

void toggleTheme() {
  _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  notifyListeners();
}
```

---

### **5. Markdown Rendering**

* Using `flutter_markdown` package:

```dart
import 'package:flutter_markdown/flutter_markdown.dart';

MarkdownBody(
  data: aiResponseText,
  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
)
```

---

### **6. API Integration**

* Uses `http` package for API requests.
* Sends POST request with user message and receives AI response.

```dart
final response = await http.post(
  Uri.parse('https://api.example.com/chat'),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'message': userInput}),
);
```

---

## 📌 Future Enhancements

* Add **multi-chat sessions**.
* Implement **cloud sync** with Firebase.
* Voice input and output.
* Rich media (images, videos) in chat.

---

## 📦 Dependencies

* `flutter_markdown` — for AI response formatting.
* `shared_preferences` — for local chat saving.
* `http` — for API requests.
* `provider` — for state management.

---

## 🖼 UI Preview (Concept)

```
[ Sidebar ]  |  Chat Window
             -----------------
  Menu       |  [ AI Response in Markdown Box ]
  Saved      |  [ User Message Bubble       ]
  Settings   |  [ AI Response in Markdown   ]
```

---

## 📜 License

This project is open-source and available under the MIT License.

```

---

If you want, I can now also **make this Markdown into a polished GitHub README** with badges, screenshots, and usage instructions. That way it looks professional for public release.
```
