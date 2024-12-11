import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrawingApp(),
    );
  }
}

class DrawingApp extends StatefulWidget {
  @override
  _DrawingAppState createState() => _DrawingAppState();
}

class _DrawingAppState extends State<DrawingApp> {
  String selectedEmoji = 'Smile'; // Default selected emoji

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emoji Drawing App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CustomPaint(
                painter: EmojiPainter(selectedEmoji),
                size: Size(300, 300), // Set fixed size for the canvas
              ),
            ),
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedEmoji,
            items: [
              DropdownMenuItem(
                child: Text('Smile Emoji'),
                value: 'Smile',
              ),
              DropdownMenuItem(
                child: Text('Party Face Emoji'),
                value: 'Party',
              ),
              DropdownMenuItem(
                child: Text('Heart Emoji'),
                value: 'Heart',
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedEmoji = value!;
              });
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class EmojiPainter extends CustomPainter {
  final String emojiType;
  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    // Draw different emojis based on selected type
    switch (emojiType) {
      case 'Smile':
        _drawSmileEmoji(canvas, size, paint);
        break;
      case 'Party':
        _drawPartyFaceEmoji(canvas, size, paint);
        break;
      case 'Heart':
        _drawHeartEmoji(canvas, size, paint);
        break;
    }
  }

  void _drawSmileEmoji(Canvas canvas, Size size, Paint paint) {
    // Draw face (circle)
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw eyes
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width / 3, size.height / 3), 20, paint);
    canvas.drawCircle(Offset(2 * size.width / 3, size.height / 3), 20, paint);

    // Draw smile (arc)
    paint.color = Colors.black;
    Rect smileRect =
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 80);
    canvas.drawArc(smileRect, 0.1, 3, false, paint);
  }

  void _drawPartyFaceEmoji(Canvas canvas, Size size, Paint paint) {
    // Draw face
    paint.color = Colors.yellow;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw party hat - moving it upwards
    paint.color = Colors.blue;
    Path hat = Path();
    double hatHeight = size.height / 3;
    double hatWidth = size.width / 4;
    
    // Move the whole hat upwards by adjusting y-values slightly
    double yOffset = size.height / 3; // Move hat higher
    hat.moveTo(size.width / 2, size.height / 2 - hatHeight - yOffset); // Top of the hat
    hat.lineTo(size.width / 2 - hatWidth, size.height / 2 - yOffset); // Bottom left of the hat
    hat.lineTo(size.width / 2 + hatWidth, size.height / 2 - yOffset); // Bottom right of the hat
    hat.close();
    canvas.drawPath(hat, paint);

    // Draw eyes
    paint.color = Colors.black;
    canvas.drawCircle(Offset(size.width / 3, size.height / 2.5), 20, paint);
    canvas.drawCircle(Offset(2 * size.width / 3, size.height / 2.5), 20, paint);

    // Draw smile (arc)
    paint.color = Colors.black;
    Rect smileRect =
        Rect.fromCircle(center: Offset(size.width / 2, size.height / 1.5), radius: 80);
    canvas.drawArc(smileRect, 0.1, 3, false, paint);
  }

  void _drawHeartEmoji(Canvas canvas, Size size, Paint paint) {
    paint.color = Colors.red;

    Path heartPath = Path();
    heartPath.moveTo(size.width / 2, size.height / 3);
    heartPath.cubicTo(size.width / 4, 0, 0, size.height / 2,
        size.width / 2, size.height);
    heartPath.cubicTo(size.width, size.height / 2, 3 * size.width / 4, 0,
        size.width / 2, size.height / 3);

    canvas.drawPath(heartPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}