import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Welcome to MIDI Visualizer Studio',
      'description': 'Create stunning visualizations for your MIDI performances.',
      'icon': 'piano',
    },
    {
      'title': 'Design Your Layout',
      'description': 'Drag and drop pads, knobs, and faders to match your controller.',
      'icon': 'dashboard_customize',
    },
    {
      'title': 'Connect & Play',
      'description': 'Connect your MIDI device and watch your design come to life.',
      'icon': 'cable',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  return _TutorialSlide(
                    title: _slides[index]['title']!,
                    description: _slides[index]['description']!,
                    iconData: _getIconData(_slides[index]['icon']!),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () => context.go('/home'), child: const Text('Skip')),
                  Row(
                    children: List.generate(
                      _slides.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage < _slides.length - 1) {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                      } else {
                        context.go('/home');
                      }
                    },
                    child: Text(_currentPage == _slides.length - 1 ? 'Done' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'piano':
        return Icons.piano;
      case 'dashboard_customize':
        return Icons.dashboard_customize;
      case 'cable':
        return Icons.cable;
      default:
        return Icons.help;
    }
  }
}

class _TutorialSlide extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;

  const _TutorialSlide({required this.title, required this.description, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 120, color: Theme.of(context).primaryColor),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(description, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
