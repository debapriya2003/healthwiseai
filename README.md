# AI Doctor Chatbot (Flutter + Mistral API + Voice Output)

## 📌 Overview
This is a Flutter-based AI chatbot designed to act as a **medical specialist** across multiple domains.  
It integrates **Mistral AI API** for AI-generated responses, **Markdown** for rich-text display, and **Text-to-Speech (TTS)** for voice output.  
The app also includes **Light/Dark Mode switching** for better accessibility.

---

## ✨ Features

### 1. **AI-Powered Medical Responses**
- **Role**: Acts as a doctor and specialist in:
  - Accident & Emergency
  - Biological Hematology
  - Child Psychiatry
  - Clinical Biology
  - Clinical Chemistry
  - Clinical Neurophysiology
  - Clinical Radiology
  - Dental, Oral & Maxillo-Facial Surgery
  - Dermato-Venerology
  - Endocrinology
  - Gastro-Enterologic Surgery
  - General Hematology
  - General Practice
  - General Surgery
  - Immunology
  - Infectious Diseases
  - Internal Medicine
  - Laboratory Medicine
  - Maxillo-Facial Surgery
- **Implementation**: `system` role message is sent with domain expertise to Mistral API.

---

### 2. **Mistral API Integration**
- **Endpoint**: `https://api.mistral.ai/v1/chat/completions`
- **Model**: `mistral-small-latest`
- **Headers**:
  ```json
  {
    "Authorization": "Bearer YOUR_MISTRAL_API_KEY",
    "Content-Type": "application/json"
  }
````

* **Request Body Example**:

  ```json
  {
    "messages": [
      {"role": "system", "content": "You are an AI doctor and specialist..."},
      {"role": "user", "content": "What are the symptoms of anemia?"}
    ],
    "model": "mistral-small-latest"
  }
  ```

---

### 3. **Text-to-Speech (TTS)**

* **Package**: `flutter_tts`
* **Purpose**: Converts AI responses to speech for accessibility.
* **Usage**:

  ```dart
  flutterTts.speak(botMessage);
  ```

---

### 4. **Markdown Support**

* **Package**: `flutter_markdown`
* **Purpose**: Displays AI responses with formatting (headings, bold text, lists, etc.).
* **Implementation**:

  ```dart
  MarkdownBody(
    data: msg["message"]!,
    selectable: true,
  );
  ```

---

### 5. **Light/Dark Mode Toggle**

* **Implementation**:

  ```dart
  IconButton(
    icon: Icon(Icons.brightness_6),
    onPressed: widget.toggleTheme,
  )
  ```
* Dynamically switches between `ThemeData.light()` and `ThemeData.dark()`.

---

### 6. **Chat UI with Message Boundaries**

* **Color-coded messages**:

  * **User**: Blue background
  * **Bot**: Green background
* **Rounded container** for message boundaries.

---

## 🛠 Technical Stack

* **Framework**: Flutter
* **AI API**: Mistral API
* **Voice Output**: `flutter_tts`
* **Markdown Rendering**: `flutter_markdown`
* **Theme Management**: Stateful toggle between light/dark mode

---

## 🚀 How to Run

1. Clone this repository.
2. Install dependencies:

   ```bash
   flutter pub get
   ```
3. Replace `YOUR_MISTRAL_API_KEY` with your actual API key.
4. Run the app:

   ```bash
   flutter run
   ```

---

## 📌 Future Enhancements

* Multi-language support for both chat and TTS.
* Offline medical knowledge database.
* Option to export chat history as PDF/Markdown.
* Improved UI with animations.

```

---

If you want, I can now also **add screenshots and diagrams** to this Markdown so it becomes more visually engaging. Would you like me to do that?
```

