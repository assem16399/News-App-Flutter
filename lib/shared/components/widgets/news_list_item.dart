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
    return Column(
      children: [
        ListTile(
          minVerticalPadding: 10,
          horizontalTitleGap: 15,
          minLeadingWidth: 40,
          leading: Container(
            width: 100,
            height: 150,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: imageUrl == null
                  ? Image.asset(
                      'assets/images/error.png',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          title: Text(
            title ?? 'null',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(
            description ?? 'unknown',
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        )
      ],
    );
  }
}
