import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/pet_model.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_text_field.dart';

class HealthRecordsScreen extends StatefulWidget {
  final Pet pet;

  const HealthRecordsScreen({super.key, required this.pet});

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {
  final List<HealthRecord> _records = [];

  @override
  void initState() {
    super.initState();
    // Sample data
    _records.addAll([
      HealthRecord(
        id: '1',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 7)),
        recordType: 'Vaccination',
        title: 'Annual Vaccination',
        description: 'Received annual vaccination including rabies and DHPP',
        vetName: 'Dr. Sarah Johnson',
        nextCheckup: DateTime.now().add(const Duration(days: 365)),
      ),
      HealthRecord(
        id: '2',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 30)),
        recordType: 'Checkup',
        title: 'Regular Checkup',
        description: 'General health checkup. All vitals normal. Weight: ${widget.pet.weight} kg',
        vetName: 'Dr. Sarah Johnson',
        nextCheckup: DateTime.now().add(const Duration(days: 180)),
      ),
      HealthRecord(
        id: '3',
        petId: widget.pet.id,
        dateTime: DateTime.now().subtract(const Duration(days: 90)),
        recordType: 'Treatment',
        title: 'Flea Treatment',
        description: 'Applied flea and tick prevention medication',
        medication: 'Frontline Plus',
      ),
    ]);
  }

  void _showAddRecordDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final vetController = TextEditingController();
    final medicationController = TextEditingController();
    String selectedType = 'Checkup';
    DateTime? nextCheckup;

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
                      'Add Health Record',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Record Type',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: selectedType,
                        isExpanded: true,
                        underline: const SizedBox(),
                        dropdownColor: AppColors.cardBackground,
                        style: const TextStyle(color: AppColors.textPrimary),
                        items: ['Checkup', 'Vaccination', 'Treatment', 'Surgery', 'Dental', 'Other']
                            .map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setModalState(() {
                            selectedType = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Title',
                      hintText: 'e.g., Annual Vaccination',
                      controller: titleController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Description',
                      hintText: 'Details about the visit',
                      controller: descriptionController,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Vet Name (Optional)',
                      hintText: 'e.g., Dr. Sarah Johnson',
                      controller: vetController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Medication (Optional)',
                      hintText: 'e.g., Frontline Plus',
                      controller: medicationController,
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Add Record',
                      onPressed: () {
                        if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
                          setState(() {
                            _records.insert(
                              0,
                              HealthRecord(
                                id: DateTime.now().toString(),
                                petId: widget.pet.id,
                                dateTime: DateTime.now(),
                                recordType: selectedType,
                                title: titleController.text,
                                description: descriptionController.text,
                                vetName: vetController.text.isNotEmpty ? vetController.text : null,
                                medication: medicationController.text.isNotEmpty ? medicationController.text : null,
                                nextCheckup: nextCheckup,
                              ),
                            );
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Health record added!'),
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
        title: Text('${widget.pet.name}\'s Health'),
      ),
      body: _records.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_services,
                    size: 80,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No health records yet',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _showAddRecordDialog,
                    child: const Text('Add first record'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _records.length,
              itemBuilder: (context, index) {
                return _buildRecordCard(_records[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddRecordDialog,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecordCard(HealthRecord record) {
    final typeIcons = {
      'Checkup': Icons.medical_services,
      'Vaccination': Icons.vaccines,
      'Treatment': Icons.healing,
      'Surgery': Icons.local_hospital,
      'Dental': Icons.medication,
      'Other': Icons.note_add,
    };

    final typeColors = {
      'Checkup': AppColors.info,
      'Vaccination': AppColors.success,
      'Treatment': AppColors.warning,
      'Surgery': AppColors.error,
      'Dental': AppColors.primary,
      'Other': AppColors.secondary,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (typeColors[record.recordType] ?? AppColors.primary).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    typeIcons[record.recordType] ?? Icons.note_add,
                    color: typeColors[record.recordType] ?? AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        record.recordType,
                        style: TextStyle(
                          color: typeColors[record.recordType] ?? AppColors.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _formatDate(record.dateTime),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              record.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            if (record.vetName != null || record.medication != null) ...[
              const SizedBox(height: 12),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 12),
            ],
            if (record.vetName != null)
              Row(
                children: [
                  const Icon(Icons.person, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    record.vetName!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            if (record.medication != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.medication, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    record.medication!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
            if (record.nextCheckup != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.event, size: 16, color: AppColors.info),
                    const SizedBox(width: 8),
                    Text(
                      'Next checkup: ${_formatDate(record.nextCheckup!)}',
                      style: const TextStyle(
                        color: AppColors.info,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
}
