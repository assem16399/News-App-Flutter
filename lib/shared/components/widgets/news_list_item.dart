import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({
    required this.imageUrl,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);
  final String? imageUrl;
  final String? title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListTile(
        leading: Image.network(
          imageUrl ?? '',
          width: 100,
        ),
        title: Text(title ?? 'null'),
        subtitle: Text(
          description ?? 'unknown',
          maxLines: 1,
        ),
      ),
    );
  }
}
