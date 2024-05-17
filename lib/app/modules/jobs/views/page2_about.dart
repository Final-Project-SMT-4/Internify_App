// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Page2About extends StatelessWidget {
  const Page2About({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _contentAboutCompany(
              title: "About Compay",
              desc:
                  "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit repellendus fugit quis voluptatem mollitia deleniti ut architecto dolore, illum in debitis sequi nesciunt, blanditiis quae a recusandae. Dolores, expedita dolor.",
            ),
            Text(
              "Website",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Link(
              target: LinkTarget.defaultTarget,
              uri: Uri.parse('https://heyflutter.com'),
              builder: (context, followLink) => InkWell(
                onTap: followLink,
                child: Text(
                  "https://www.google.com",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            _contentAboutCompany(
              title: "Industry",
              desc: "Internet product",
            ),
            _contentAboutCompany(
              title: "Employee size",
              desc: "100 Employee",
            ),
            _contentAboutCompany(
              title: "Head Office",
              desc: "Mountain View, California, Amerika serikat",
            ),
            _contentAboutCompany(
              title: "Type",
              desc: "Multinational Company",
            ),
            _contentAboutCompany(
              title: "Since",
              desc: "2000",
            ),
            _contentAboutCompany(
              title: "Specialization",
              desc:
                  "Search technology, Web computing, Software and Online advertising",
            ),
            SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}

class _contentAboutCompany extends StatelessWidget {
  final String title;
  final String desc;

  const _contentAboutCompany({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          desc,
        ),
        SizedBox(
          height: 17,
        ),
      ]),
    );
  }
}
