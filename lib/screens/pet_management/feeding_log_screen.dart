import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/pet_model.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text_field.dart';

class FeedingLogScreen extends StatefulWidget {
  final Pet pet;

  const FeedingLogScreen({super.key, required this.pet});

  @override
  State<FeedingLogScreen> createState() => _FeedingLogScreenState();
}

class _FeedingLogScreenState extends State<FeedingLogScreen> {
  final List<FeedingLog> _logs = [];

  @override
  void initState() {
    super.initState();
    // Sample data
    _logs.addAll([
      FeedingLog(
        id: '1',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        foodType: 'Dog Food - Premium',
        amount: 200,
        unit: 'g',
        notes: 'Breakfast',
      ),
      FeedingLog(
        id: '2',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(hours: 10)),
        foodType: 'Chicken & Rice',
        amount: 150,
        unit: 'g',
        notes: 'Dinner yesterday',
      ),
      FeedingLog(
        id: '3',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        foodType: 'Dog Food - Premium',
        amount: 200,
        unit: 'g',
      ),
    ]);
  }

  void _showAddFeedingDialog() {
    final foodController = TextEditingController();
    final amountController = TextEditingController();
    final notesController = TextEditingController();
    String selectedUnit = 'g';

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
                      'Add Feeding Record',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      labelText: 'Food Type',
                      hintText: 'e.g., Dog Food, Chicken & Rice',
                      controller: foodController,
                      prefixIcon: const Icon(Icons.restaurant, color: AppColors.textSecondary),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            labelText: 'Amount',
                            hintText: 'Enter amount',
                            controller: amountController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Unit',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.primary),
                                ),
                                child: DropdownButton<String>(
                                  value: selectedUnit,
                                  isExpanded: true,
                                  underline: const SizedBox(),
                                  dropdownColor: AppColors.cardBackground,
                                  style: const TextStyle(color: AppColors.textPrimary),
                                  items: ['g', 'kg', 'cups', 'oz'].map((unit) {
                                    return DropdownMenuItem(
                                      value: unit,
                                      child: Text(unit),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setModalState(() {
                                      selectedUnit = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Notes (Optional)',
                      hintText: 'Add any notes',
                      controller: notesController,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Add Record',
                      onPressed: () {
                        if (foodController.text.isNotEmpty && amountController.text.isNotEmpty) {
                          setState(() {
                            _logs.insert(
                              0,
                              FeedingLog(
                                id: DateTime.now().toString(),
                                petId: widget.pet.id,
                                dateTime: DateTime.now(),
                                foodType: foodController.text,
                                amount: double.parse(amountController.text),
                                unit: selectedUnit,
                                notes: notesController.text,
                              ),
                            );
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Feeding record added!'),
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
        title: Text('${widget.pet.name}\'s Feeding Log'),
      ),
      body: _logs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 80,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No feeding records yet',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _showAddFeedingDialog,
                    child: const Text('Add first record'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _logs.length,
              itemBuilder: (context, index) {
                return _buildLogItem(_logs[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFeedingDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLogItem(FeedingLog log) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restaurant,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.foodType,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${log.amount} ${log.unit}',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                if (log.notes.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    log.notes,
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatTime(log.dateTime),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(log.dateTime),
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
