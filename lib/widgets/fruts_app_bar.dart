import 'package:flutter/material.dart';

const double kAppBarHeight = kToolbarHeight * 1.6;
const double kBottomBarHeight = kToolbarHeight * 0.8;
const double prefferedHeight = kAppBarHeight + kBottomBarHeight;

class FrutsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FrutsAppBar({
    Key key,
    this.leading,
    this.title,
    this.action,
    this.bottom,
    this.backgroundColor,
    this.bottomOpacity = 1.0,
  })  : preferredSize = const Size.fromHeight(prefferedHeight),
        super(key: key);

  final Widget leading;
  final String title;
  final Widget action;
  final Widget bottom;
  final Color backgroundColor;
  final double bottomOpacity;

  @override
  final Size preferredSize;

  @override
  _FrutsAppBarState createState() => _FrutsAppBarState();
}

class _FrutsAppBarState extends State<FrutsAppBar> {
  Widget appBar;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    // final colorScheme = Theme.of(context).colorScheme;

    if (widget.bottom != null) {
      appBar = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Container(
              alignment: Alignment.center,
              child: SafeArea(
                child: Stack(
                  fit: StackFit.passthrough,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widget.leading ??
                            ImageIcon(
                              AssetImage('images/icons/menu.png'),
                              size: 26,
                            ),
                        widget.action ?? Container(),
                      ],
                    ),
                    Text(
                      widget.title ?? 'FRUTS',
                      style: textTheme.headline6.copyWith(letterSpacing: 3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.bottomOpacity == 1.0)
            Container(
              height: kBottomBarHeight,
              child: widget.bottom,
            )
          else
            Opacity(
              opacity: const Interval(0.25, 1.0, curve: Curves.fastOutSlowIn)
                  .transform(widget.bottomOpacity),
              child: Container(
                height: kBottomBarHeight,
                child: widget.bottom,
              ),
            ),
        ],
      );
    } else {
      appBar = Container(
        height: kAppBarHeight,
        alignment: Alignment.center,
        child: SafeArea(
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.leading ??
                      ImageIcon(
                        AssetImage('images/icons/menu.png'),
                        size: 30,
                      ),
                  widget.action ?? Container(),
                ],
              ),
              Text(
                widget.title ?? 'FRUTS',
                style: textTheme.headline6.copyWith(letterSpacing: 3),
              ),
            ],
          ),
        ),
      );
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Material(
        color: Colors.transparent,
        elevation: 0.0,
        child: Container(
          height: widget.bottom == null
              ? widget.preferredSize.height - kBottomBarHeight
              : widget.preferredSize.height,
          width: width,
          color: widget.backgroundColor ?? Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: appBar,
        ),
      ),
    );
  }
}
