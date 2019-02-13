class ThreadSummary {
  List<String> senders;
  String subject;
  String snippet;
  List<String> attachments;
  String avatarUrl;
  int unreadCount;

  ThreadSummary({
    this.senders,
    this.subject,
    this.snippet,
    this.attachments,
    this.avatarUrl,
    this.unreadCount,
  });
}
