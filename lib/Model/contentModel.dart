import 'package:flutter/material.dart';

class Content {
  int? timestamp;
  String? sender;
  String? content;

  Content(int this.timestamp, String this.sender, String this.content);

  Content.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        sender = json["sender"],
        content = json["content"];

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "sender": sender,
        "content": content,
      };
}
