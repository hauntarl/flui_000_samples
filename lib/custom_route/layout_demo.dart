import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(LayoutDemo());

/// tutorial: https://flutter.dev/docs/development/ui/layout/tutorial
class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
    final title = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );
    final color = Theme.of(context).primaryColor;
    final buttons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(color, Icons.call, 'CALL'),
        _buildButton(color, Icons.near_me, 'ROUTE'),
        _buildButton(color, Icons.share, 'SHARE'),
      ],
    );
    const description = Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
        textAlign: TextAlign.justify,
        style: TextStyle(letterSpacing: 0.5),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              'assets/lake.jpg',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            title,
            buttons,
            description,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(Color color, IconData icon, String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Icon(icon, color: color),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  var _isFavorite = true;
  var _favoriteCount = 41;

  void _toggleFavorite() {
    _isFavorite = !_isFavorite;
    _favoriteCount += _isFavorite ? 1 : -1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.only(bottom: 2),
          icon: _isFavorite
              ? const Icon(Icons.star)
              : const Icon(Icons.star_outline),
          color: Colors.red,
          iconSize: 30,
          onPressed: _toggleFavorite,
        ),
        SizedBox(
          width: 20,
          child: Text('$_favoriteCount'),
        ),
      ],
    );
  }
}
