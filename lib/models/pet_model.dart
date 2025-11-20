class Pet {
  final String id;
  final String name;
  final String breed;
  final int age;
  final double weight;
  final String gender;
  final String imageUrl;
  final String ownerName;
  final String ownerId;
  final String location;
  final double distance;
  final List<String> photos;
  final String about;
  final DateTime birthDate;
  final bool isVaccinated;
  final bool isNeutered;
  final List<String> traits;

  Pet({
    required this.id,
    required this.name,
    required this.breed,
    required this.age,
    required this.weight,
    required this.gender,
    required this.imageUrl,
    required this.ownerName,
    required this.ownerId,
    required this.location,
    required this.distance,
    required this.photos,
    required this.about,
    required this.birthDate,
    required this.isVaccinated,
    required this.isNeutered,
    required this.traits,
  });

  String get ageText {
    if (age < 1) {
      final months = (DateTime.now().difference(birthDate).inDays / 30).floor();
      return '$months months';
    }
    return '$age year${age > 1 ? 's' : ''}';
  }
}

class FeedingLog {
  final String id;
  final String petId;
  final DateTime dateTime;
  final String foodType;
  final double amount;
  final String unit;
  final String notes;

  FeedingLog({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.foodType,
    required this.amount,
    required this.unit,
    this.notes = '',
  });
}

class ActivityLog {
  final String id;
  final String petId;
  final DateTime dateTime;
  final String activityType;
  final int duration;
  final String notes;
  final List<String> photos;

  ActivityLog({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.activityType,
    required this.duration,
    this.notes = '',
    this.photos = const [],
  });
}

class HealthRecord {
  final String id;
  final String petId;
  final DateTime dateTime;
  final String recordType;
  final String title;
  final String description;
  final String? vetName;
  final String? medication;
  final DateTime? nextCheckup;

  HealthRecord({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.recordType,
    required this.title,
    required this.description,
    this.vetName,
    this.medication,
    this.nextCheckup,
  });
}

class PetDiary {
  final String id;
  final String petId;
  final DateTime dateTime;
  final String title;
  final String content;
  final List<String> photos;
  final String mood;

  PetDiary({
    required this.id,
    required this.petId,
    required this.dateTime,
    required this.title,
    required this.content,
    this.photos = const [],
    this.mood = 'happy',
  });
}
