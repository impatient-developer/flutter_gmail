import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gmail/ThreadSummary.dart';
import 'package:quiver/iterables.dart' as iter;
import 'package:random_user/models.dart';
import 'package:random_user/random_user.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

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
  final _random = Random();
  var _threads = <ThreadSummary>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RandomUser().getUsers(results: 50).then(_updateThreads);
  }

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
                _buildSenderList(thread),
                _buildSubject(thread),
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
        child: Row(
          children: <Widget>[
            Icon(Icons.image),
            Text(attachment),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
    );
  }

  void _updateThreads(List<User> users) {
    setState(() {
      _threads = _generateThreadSummaries(users);
    });
  }

  List<ThreadSummary> _generateThreadSummaries(List<User> users) {
    return iter.partition(users, 5).map(_generateOneThread).toList();
  }

  ThreadSummary _generateOneThread(List users) {
    final senders = users.cast<User>();
    final attachmentCount = max(0, _random.nextInt(6) - 3);

    return ThreadSummary(
      sender: senders.map((user) => user.name.first).toList(),
      avatarUrl: senders.last.picture.medium,
      subject: lorem(paragraphs: 1, words: 4),
      snippet: lorem(paragraphs: 1, words: 4),
      unreadCount: _random.nextInt(senders.length + 1),
      attachments: List.generate(
          attachmentCount, (_) => lorem(paragraphs: 1, words: 1) + 'jpg'),
    );
  }

  Widget _buildSubject(ThreadSummary thread) {
    if (thread.unreadCount > 0) {
      return _boldText(thread.subject);
    }
    return Text(thread.subject);
  }

  Widget _buildSenderList(ThreadSummary thread) {
    if (thread.unreadCount == 0) {
      return Text(thread.sender.join(','));
    }
    final readCount = thread.sender.length - thread.unreadCount;
    if (readCount == 0) {
      return _boldText(thread.sender.join(','));
    }
    return Row(
      children: <Widget>[
        Text(thread.sender.take(readCount).join(',') + ','),
        _boldText(thread.sender.skip(readCount).join(',')),
      ],
    );
  }

  Text _boldText(String text) {
    return Text(text, style: TextStyle(fontWeight: FontWeight.bold));
  }
}
