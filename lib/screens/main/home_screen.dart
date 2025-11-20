import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../widgets/pet_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _currentCardIndex = 0;
  late AnimationController _animationController;

  final List<PetData> _pets = [
    PetData(
      name: 'Max',
      breed: 'Golden Retriever',
      age: 2,
      distance: '2.5 km away',
      imageUrl: AppImages.dog1,
      badges: ['Vaccinated', 'Friendly'],
    ),
    PetData(
      name: 'Luna',
      breed: 'Siberian Husky',
      age: 3,
      distance: '3.2 km away',
      imageUrl: AppImages.dog2,
      badges: ['Playful'],
    ),
    PetData(
      name: 'Charlie',
      breed: 'Labrador Retriever',
      age: 1,
      distance: '1.8 km away',
      imageUrl: AppImages.dog3,
      badges: ['Vaccinated', 'Trained'],
    ),
    PetData(
      name: 'Bella',
      breed: 'French Bulldog',
      age: 2,
      distance: '4.2 km away',
      imageUrl: AppImages.dog4,
      badges: ['Friendly'],
    ),
    PetData(
      name: 'Milo',
      breed: 'Pomeranian',
      age: 1,
      distance: '1.5 km away',
      imageUrl: AppImages.dog5,
      badges: ['Vaccinated'],
    ),
    PetData(
      name: 'Whiskers',
      breed: 'Persian Cat',
      age: 2,
      distance: '2.8 km away',
      imageUrl: AppImages.cat1,
      badges: ['Indoor'],
    ),
    PetData(
      name: 'Shadow',
      breed: 'British Shorthair',
      age: 3,
      distance: '3.5 km away',
      imageUrl: AppImages.cat2,
      badges: ['Calm'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _swipeCard(bool liked) {
    _animationController.forward().then((_) {
      setState(() {
        if (_currentCardIndex < _pets.length - 1) {
          _currentCardIndex++;
        } else {
          _currentCardIndex = 0;
        }
      });
      _animationController.reset();
    });

    if (liked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You liked ${_pets[_currentCardIndex].name}!'),
          duration: const Duration(seconds: 1),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on, color: AppColors.primary, size: 20),
            const SizedBox(width: 4),
            const Text(
              'San Francisco',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    // Show next card in background
                    if (_currentCardIndex < _pets.length - 1)
                      Positioned.fill(
                        child: Transform.scale(
                          scale: 0.95,
                          child: Opacity(
                            opacity: 0.5,
                            child: PetCard(
                              name: _pets[_currentCardIndex + 1].name,
                              breed: _pets[_currentCardIndex + 1].breed,
                              age: _pets[_currentCardIndex + 1].age,
                              distance: _pets[_currentCardIndex + 1].distance,
                              imageUrl: _pets[_currentCardIndex + 1].imageUrl,
                            ),
                          ),
                        ),
                      ),
                    // Current card
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 - (_animationController.value * 0.1),
                            child: Opacity(
                              opacity: 1.0 - _animationController.value,
                              child: child,
                            ),
                          );
                        },
                        child: PetCard(
                          name: _pets[_currentCardIndex].name,
                          breed: _pets[_currentCardIndex].breed,
                          age: _pets[_currentCardIndex].age,
                          distance: _pets[_currentCardIndex].distance,
                          imageUrl: _pets[_currentCardIndex].imageUrl,
                          badges: _pets[_currentCardIndex].badges,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Action buttons
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    color: AppColors.error,
                    size: 60,
                    onPressed: () => _swipeCard(false),
                  ),
                  _buildActionButton(
                    icon: Icons.star,
                    color: AppColors.info,
                    size: 50,
                    onPressed: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.favorite,
                    color: AppColors.primary,
                    size: 60,
                    onPressed: () => _swipeCard(true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
        iconSize: size * 0.5,
      ),
    );
  }
}

class PetData {
  final String name;
  final String breed;
  final int age;
  final String distance;
  final String imageUrl;
  final List<String>? badges;

  PetData({
    required this.name,
    required this.breed,
    required this.age,
    required this.distance,
    required this.imageUrl,
    this.badges,
  });
}
