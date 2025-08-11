import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: ChatScreen(toggleTheme: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
      }),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  ChatScreen({required this.toggleTheme});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final FlutterTts flutterTts = FlutterTts();
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({"role": "user", "message": userMessage});
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.mistral.ai/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer YOUR_MISTRAL_API_KEY',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "messages": [
            {"role": "system", "content": "You are an AI doctor and specialist in Accident and Emergency, Biological Hematology, Child Psychiatry, Clinical Biology, Clinical Chemistry, Clinical Neurophysiology, Clinical Radiology, Dental, Oral and Maxillo-Facial Surgery, Dermato-Venerology, Endocrinology, Gastro-Enterologic Surgery, General Hematology, General Practice, General Surgery, Immunology, Infectious Diseases, Internal Medicine, Laboratory Medicine, and Maxillo-Facial Surgery. Provide expert medical and general knowledge responses."},
            {"role": "user", "content": userMessage}
          ],
          "model": "mistral-small-latest"
        }),
      );

      print("API Response: ${response.body}");
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData.containsKey('choices') && responseData['choices'].isNotEmpty) {
          String botMessage = responseData['choices'][0]['message']['content'];
          
          setState(() {
            messages.add({"role": "bot", "message": botMessage});
          });

          flutterTts.speak(botMessage);
        } else {
          print("Error: Unexpected API response structure");
        }
      } else {
        print("API Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI Chatbot"),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: msg["role"] == "user" ? Colors.blue[100] : Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: MarkdownBody(
                    data: msg["message"]!,
                    selectable: true,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Type your message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}