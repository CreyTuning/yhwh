import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_do/animate_do.dart' as animateDo;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({ Key? key }) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return animateDo.FadeIn(
      duration: Duration(milliseconds: 150),
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(
          child: Container(
            height: 550,
            child: ListView(
              
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 100,
                  child: Container(
                    child: Image(
                      isAntiAlias: true,
                      image: AssetImage('assets/portrait_logo.png')
                    ),
                  ),
                ),
    
                Container(height: 20),
    
                InkWell(
                  onTap: () => launch('https://instagram.com/iglesiayhwh'),
                  child: Container(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.instagram),
                        Container(width: 5),
                        Text(
                        'Instagram',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
    
                InkWell(
                  onTap: () => launch('https://github.com/llromerorr/yhwh/releases'),
                  child: Container(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.github),
                        Container(width: 5),
                        Text(
                        'Github',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
    
                InkWell(
                  onTap: () => launch('mailto:yhwh.principal@gmail.com'),
                  child: Container(
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.message),
                        Container(width: 5),
                        Text(
                        'Email',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: <Widget>[
                    Divider(height: 25, color: Color(0x00)),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'Desarrollado por Luis Romero',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Baloo',
                                color: Theme.of(context).textTheme.bodyMedium!.color,
                                height: 1.2
                            )
                          ),
                          textAlign: TextAlign.center,
                        )
                    ),

                    TextButton(
                      child: Text('Version: 0.1.2 beta',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Baloo',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).textTheme.bodyLarge!.color
                        )
                      ),
                      onPressed: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}