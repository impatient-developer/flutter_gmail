import 'package:flutter/material.dart';
import 'package:flutter_gmail/ThreadSummary.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Gmail Clone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _threads = <ThreadSummary>[
    ThreadSummary(
      sender: ['sender 1', 'sender 2'],
      subject: 'test',
      snippet: 'snippet',
      attachments: ['attachment1', 'attachement2'],
      avatarUrl: 'https://randomuser.me/api/portraits/men/0.jpg',
    ),
    ThreadSummary(
      sender: ['sender 1'],
      subject: 'test test test ',
      snippet: 'snippet',
      attachments: [],
      avatarUrl: 'https://randomuser.me/api/portraits/men/0.jpg',
    ),
    ThreadSummary(
      sender: ['sender 3', 'sender 2', 'sender 4'],
      subject: 'hello world',
      snippet: 'snippet',
      attachments: ['attachment1'],
      avatarUrl: 'https://randomuser.me/api/portraits/men/0.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: _threads.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final thread = _threads[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(thread.avatarUrl),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(thread.sender.join(",")),
                Text(thread.subject),
                Text(thread.snippet),
                Row(
                  children:
                      thread.attachments.map(_buildAttachmentButton).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildAttachmentButton(String attachment) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlineButton(
        onPressed: () => print('pressed'),
        child: Text(attachment),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }
}
