import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyWidget(),
    ),
  );
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Offset touchingPoint;
  double xValue = 0;
  double yValue = 0;
  double witdthValue = 40;
  double heigthValue = 40;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    debugPrint('Got screensize: $screenSize');
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Image.network(
              'https://spiceworksmyanmar.com/blog/wp-content/uploads/2019/07/cover_flutter.png'),
        ),
        CustomPaint(
          painter: HolePainter(
            top: yValue,
            left: xValue,
            heigth: heigthValue,
            width: witdthValue,
          ),
          child: Container(),
        ),
        Positioned(left: 16, bottom: 64, child: Text('x $xValue y: $yValue')),
        Positioned(
          left: 0,
          right: 0,
          bottom: 64,
          child: Slider(
              activeColor: Colors.red,
              inactiveColor: Colors.redAccent,
              value: xValue,
              max: screenSize.width,
              onChanged: (value) {
                setState(() {
                  this.xValue = value;
                });
              }),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Slider(
            value: yValue,
            max: screenSize.height,
            onChanged: (value) {
              setState(() {
                this.yValue = value;
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 95,
          child: Slider(
            value: heigthValue,
            max: screenSize.height,
            onChanged: (value) {
              setState(() {
                this.heigthValue = value;
              });
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 127,
          child: Slider(
            value: witdthValue,
            max: screenSize.width,
            onChanged: (value) {
              setState(() {
                this.witdthValue = value;
              });
            },
          ),
        ),
      ]),
    );
  }
}

class HolePainter extends CustomPainter {
  final double heigth;
  final double width;
  final double top;
  final double left;

  HolePainter(
      {this.heigth = 0, this.width = 0, this.top = 0.0, this.left = 0.0});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black.withOpacity(0.75);
    final background = Path()
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    if (this.heigth == 0 && this.width == 0) {
      canvas.drawPath(background, paint);
    } else {
      canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          background,
          Path()
            ..addRRect(RRect.fromLTRBR(
                /*left*/ left,
                /*top*/ top,
                /*right*/ width + left,
                /*bottom*/ heigth + top,
                const Radius.circular(12)))
            ..close(),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
