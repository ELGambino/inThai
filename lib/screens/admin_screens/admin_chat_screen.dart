import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class AdminChatScreen extends StatefulWidget {
  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final _channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
  List<String> _messages = [];

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter message',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Send Message'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
      _messages.add('Sent: ${_controller.text}');
      _controller.clear();
      setState(() {}); // Refresh the view to display the new message
    }
  }

  @override
  void initState() {
    super.initState();
    _channel.stream.listen((data) {
      setState(() {
        _messages.add('Received: $data');
      });
    });
  }
}
