import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  static const String routeName = '/about';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Future<void> _launched;

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              'I made this app to practice some new skills. It is not perfect but it kinda works.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'You can watch the process of making this and learn something about it on my video here: ',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () => _launchURL('https://www.youtube.com/'),
              child: Image.asset(
                'assets/images/youtube.png',
                height: 60,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'You can also follow me on my other socials for more projects and star the project',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _launched = _launchURL('https://twitter.com/xenyy_');
                    });
                  },
                  child: Image.asset(
                    'assets/images/twitter.png',
                    height: 70,
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _launchURL('https://github.com/xenyy'),
                  child: Image.asset(
                    'assets/images/github.png',
                    height: 70,
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ],
        ),
      ),
    );
  }


}
