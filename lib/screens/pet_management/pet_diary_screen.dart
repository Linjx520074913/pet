import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/pet_model.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text_field.dart';

class PetDiaryScreen extends StatefulWidget {
  final Pet pet;

  const PetDiaryScreen({super.key, required this.pet});

  @override
  State<PetDiaryScreen> createState() => _PetDiaryScreenState();
}

class _PetDiaryScreenState extends State<PetDiaryScreen> {
  final List<PetDiary> _diaries = [];

  @override
  void initState() {
    super.initState();
    // Sample data
    _diaries.addAll([
      PetDiary(
        id: '1',
        petId: widget.pet.id,
        dateTime: DateTime.now(),
        title: 'First Day at the Park',
        content: 'Today ${widget.pet.name} had so much fun at the park! Made new friends and played fetch for hours. Really enjoyed the sunshine!',
        mood: 'happy',
        photos: [],
      ),
      PetDiary(
        id: '2',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        title: 'Learning New Tricks',
        content: '${widget.pet.name} learned how to sit and stay today. Very proud moment!',
        mood: 'excited',
        photos: [],
      ),
      PetDiary(
        id: '3',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 5)),
        title: 'Rainy Day',
        content: 'Had to stay inside today because of the rain. ${widget.pet.name} was a bit restless but we played games indoors.',
        mood: 'calm',
        photos: [],
      ),
    ]);
  }

  void _showAddDiaryDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedMood = 'happy';

    final moods = {
      'happy': '😊',
      'excited': '🤩',
      'playful': '😄',
      'calm': '😌',
      'sleepy': '😴',
      'curious': '🤔',
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24,
                right: 24,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New Diary Entry',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Title',
                      hintText: 'What happened today?',
                      controller: titleController,
                      prefixIcon: const Icon(Icons.title, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Story',
                      hintText: 'Tell the story...',
                      controller: contentController,
                      maxLines: 6,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Mood',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: moods.entries.map((entry) {
                        final isSelected = selectedMood == entry.key;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              selectedMood = entry.key;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.divider,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.value,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  entry.key[0].toUpperCase() + entry.key.substring(1),
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.background
                                        : AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Save Entry',
                      onPressed: () {
                        if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                          setState(() {
                            _diaries.insert(
                              0,
                              PetDiary(
                                id: DateTime.now().toString(),
                                petId: widget.pet.id,
                                dateTime: DateTime.now(),
                                title: titleController.text,
                                content: contentController.text,
                                mood: selectedMood,
                              ),
                            );
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Diary entry saved!'),
                              backgroundColor: AppColors.success,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('${widget.pet.name}\'s Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _diaries.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    size: 80,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No diary entries yet',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _showAddDiaryDialog,
                    child: const Text('Write first entry'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _diaries.length,
              itemBuilder: (context, index) {
                return _buildDiaryCard(_diaries[index]);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDiaryDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        icon: const Icon(Icons.edit),
        label: const Text('Write'),
      ),
    );
  }

  Widget _buildDiaryCard(PetDiary diary) {
    final moodEmojis = {
      'happy': '😊',
      'excited': '🤩',
      'playful': '😄',
      'calm': '😌',
      'sleepy': '😴',
      'curious': '🤔',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.divider.withValues(alpha: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  moodEmojis[diary.mood] ?? '😊',
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        diary.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(diary.dateTime),
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              diary.content,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday, ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
    }
  }
}
