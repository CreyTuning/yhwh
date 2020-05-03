import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:yhwh/data/Define.dart';
import 'package:flutter/material.dart';
import 'package:yhwh/data/Data.dart';
import 'package:yhwh/ui_widgets/chapter_footer.dart';
import 'package:yhwh/ui_widgets/ui_verse.dart';

import 'BookViewer.dart';

class BiblePage extends StatefulWidget {
  @override
  _BiblePageState createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {

  ScrollController _scrollController;


  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: appData.scrollOffset, keepScrollOffset: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: appData.getBook,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            color: Theme.of(context).appBarTheme.color,
            child: SafeArea(
              child: Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                            width: 41.0,
                            height: 41.0,
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              fillColor: Theme.of(context).buttonColor,
                              child: Icon(Icons.keyboard_arrow_left, color: Theme.of(context).iconTheme.color,),
                              onPressed: () async {
                                await appData.previousChapter();
                                setState(() {
                                  _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              },
                            )),
                        Expanded(child: SizedBox.fromSize()),
                        Container(
                            width: 41.0,
                            height: 41.0,
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              fillColor: Theme.of(context).buttonColor,
                              child: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).iconTheme.color,),
                              onPressed: () async {
                                await appData.nextChapter();
                                setState(() {
                                  _scrollController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  body: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollStartNotification) {
                        _onStartScroll(scrollNotification.metrics);
                      } else if (scrollNotification is ScrollUpdateNotification) {
                        _onUpdateScroll(scrollNotification.metrics);
                      } else if (scrollNotification is ScrollEndNotification) {
                        _onEndScroll(scrollNotification.metrics);
                      }
                      return true;
                    },
                    child: Scrollbar(
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: <Widget>[
                          SliverAppBar(
                            floating: true,

                            actions: <Widget>[
                              FlatButton(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        '${intToBook[appData.getBookNumber]} ${appData.getChapterNumber}',
                                        style: Theme.of(context).textTheme.button
                                    ),

                                    Icon(Icons.arrow_drop_down, color: Theme.of(context).iconTheme.color),

                                  ],
                                ),


                                onPressed: () {
                                  Navigator.pushNamed(context, 'books', arguments: {
                                    'snapshot' : snapshot,
                                    'scrollController' : _scrollController
                                  });
                                },
                              ),
                              Spacer(),

                              Container(
                                width: 60.0,
                                height: 60.0,
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'styles');
                                  },

                                  onLongPress: (){
                                    appData.setDarkMode = appData.darkMode == true ? false : true;
                                    Phoenix.rebirth(context);
                                  },
                                ),
                              ),

                            ],
                          ),

                          // DEBE SER REMPLAZADO POR READVIEWER
                          SliverList(
                            delegate: SliverChildBuilderDelegate((context, item)
                            {
                              print(snapshot.data.chapters.length);
                              return UiVerse(
                                number: snapshot.data.chapters[appData.getChapterNumber - 1].versos[item][0],
                                text: snapshot.data.chapters[appData.getChapterNumber - 1].versos[item][1],
                                color: Theme.of(context).textTheme.body2.color,
                                colorOfNumber: Theme.of(context).textTheme.body1.color,
                                fontSize: appData.fontSize,
                                height: appData.fontHeight,
                                letterSeparation: appData.fontLetterSpacing,
                              );
                            },
                              childCount: snapshot.data.chapters[appData.getChapterNumber - 1].versos.length,
                            ),
                          ),

                          SliverToBoxAdapter(
                            child: ChapterFooter(),
                          )
                        ],
                      ),
                    )
                  )
              ),
            ),
          );
        }

        return Center(
          child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).appBarTheme.color,
            ),

            body: Center(
                child: CircularProgressIndicator()
            ),
          )
        );
      },
    );
  }

  _onStartScroll(ScrollMetrics metrics) {

  }

  _onUpdateScroll(ScrollMetrics metrics) {

  }

  _onEndScroll(ScrollMetrics metrics) {
    appData.scrollOffset = _scrollController.offset;
    appData.saveData();
  }
}