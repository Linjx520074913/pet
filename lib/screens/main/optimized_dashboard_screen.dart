import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/app_images.dart';
import '../../models/pet_model.dart';
import '../pet_management/my_pets_screen.dart';
import '../pet_management/pet_detail_screen.dart';
import '../pet_management/add_pet_screen.dart';
import '../pet_management/feeding_log_screen.dart';
import '../pet_management/pet_diary_screen.dart';
import '../pet_management/health_records_screen.dart';

/// 优化后的Dashboard - 以用户最关心的内容为中心
/// 设计理念：今日待办 > 宠物状态 > 快速操作 > 其他功能
class OptimizedDashboardScreen extends StatefulWidget {
  const OptimizedDashboardScreen({super.key});

  @override
  State<OptimizedDashboardScreen> createState() => _OptimizedDashboardScreenState();
}

class _OptimizedDashboardScreenState extends State<OptimizedDashboardScreen> {
  final List<Pet> _myPets = [
    Pet(
      id: '1',
      name: 'Max',
      breed: 'Golden Retriever',
      age: 2,
      weight: 30.5,
      gender: 'Male',
      imageUrl: AppImages.dog1,
      ownerName: 'John Doe',
      ownerId: 'user1',
      location: 'San Francisco',
      distance: 0,
      photos: [AppImages.dog1],
      about: 'Friendly and energetic',
      birthDate: DateTime(2022, 3, 15),
      isVaccinated: true,
      isNeutered: false,
      traits: ['Friendly', 'Energetic'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // 简洁的顶部栏
          SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: AppColors.background,
            title: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, color: AppColors.background, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, John',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '今天也要好好照顾Max哦',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                color: AppColors.textPrimary,
                onPressed: () {},
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // 🔥 核心区域1：我的宠物（横向滚动）- 最优先展示
                _buildMyPetsSection(),

                const SizedBox(height: 20),

                // 🔥 核心区域2：紧急提醒（最显眼 - 红色/黄色警告）
                if (_hasUrgentReminders())
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildUrgentReminder(),
                  ),

                if (_hasUrgentReminders()) const SizedBox(height: 20),

                // 🔥 核心区域3：今日任务（大卡片，一目了然）
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildTodayTasksSection(),
                ),

                const SizedBox(height: 24),

                // 🔥 核心区域4：快速操作（最常用的3个功能 - 超大按钮）
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildQuickActionsSection(),
                ),

                const SizedBox(height: 24),

                // 🔥 核心区域5：宠物状态卡片（健康、心情、活力）
                if (_myPets.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildPetStatusCard(_myPets[0]),
                  ),

                const SizedBox(height: 24),

                // 次要区域：最近活动
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildRecentActivities(),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      // 快速添加按钮 - 固定在右下角
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showQuickAddMenu(context),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        icon: const Icon(Icons.add, size: 28),
        label: const Text(
          '快速记录',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _hasUrgentReminders() => true; // 模拟数据

  // 🚨 紧急提醒卡片
  Widget _buildUrgentReminder() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.error,
            AppColors.error.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠️ 紧急提醒',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Max的狂犬病疫苗将在3天后到期',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  // 📋 今日任务区域
  Widget _buildTodayTasksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '📅 今日任务',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '已完成 1/3',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 任务进度条
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 1 / 3,
            minHeight: 8,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),

        const SizedBox(height: 16),

        // 任务列表
        _buildTaskItem('早餐', '08:00', Icons.restaurant, AppColors.primary, true),
        const SizedBox(height: 12),
        _buildTaskItem('早晨散步', '10:00', Icons.directions_walk, AppColors.success, false),
        const SizedBox(height: 12),
        _buildTaskItem('晚餐', '18:00', Icons.restaurant, AppColors.primary, false),
      ],
    );
  }

  Widget _buildTaskItem(String title, String time, IconData icon, Color color, bool isCompleted) {
    return GestureDetector(
      onTap: () {
        // TODO: 快速完成任务
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCompleted
            ? AppColors.success.withValues(alpha: 0.1)
            : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCompleted
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.divider,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted
                  ? AppColors.success
                  : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isCompleted
                    ? AppColors.success
                    : AppColors.textSecondary,
                  width: 2,
                ),
              ),
              child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
            ),
          ],
        ),
      ),
    );
  }

  // ⚡ 快速操作区域（最常用的3个功能 - 超大按钮）
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '⚡ 快速操作',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // 第一行：喂食（最常用 - 大按钮）
        _buildLargeActionButton(
          '🍖 记录喂食',
          '点击记录Max的用餐',
          AppColors.primary,
          Icons.restaurant_menu,
          () {
            if (_myPets.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FeedingLogScreen(pet: _myPets[0]),
                ),
              );
            }
          },
        ),

        const SizedBox(height: 12),

        // 第二行：散步 + 健康
        Row(
          children: [
            Expanded(
              child: _buildMediumActionButton(
                '🚶 散步',
                Icons.directions_walk,
                AppColors.success,
                () {
                  // TODO: 记录散步
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMediumActionButton(
                '❤️ 健康',
                Icons.favorite,
                AppColors.error,
                () {
                  if (_myPets.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HealthRecordsScreen(pet: _myPets[0]),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 大号操作按钮
  Widget _buildLargeActionButton(
    String title,
    String subtitle,
    Color color,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  // 中号操作按钮
  Widget _buildMediumActionButton(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🐕 宠物状态卡片
  Widget _buildPetStatusCard(Pet pet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🐕 Max的状态',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.secondary.withValues(alpha: 0.2),
                AppColors.primary.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.secondary.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // 健康评分
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusIndicator('健康', 85, AppColors.success, Icons.favorite),
                  _buildStatusIndicator('心情', 92, AppColors.primary, Icons.sentiment_very_satisfied),
                  _buildStatusIndicator('活力', 78, AppColors.secondary, Icons.flash_on),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.divider),
              const SizedBox(height: 16),
              // 今日总结
              Row(
                children: [
                  const Icon(Icons.tips_and_updates, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '今天Max的状态不错！继续保持规律的饮食和运动哦~',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator(String label, int score, Color color, IconData icon) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: score / 100,
                strokeWidth: 6,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$score',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // 最近活动
  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '📝 最近活动',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                if (_myPets.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PetDiaryScreen(pet: _myPets[0]),
                    ),
                  );
                }
              },
              child: const Text('查看全部'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildActivityItem('吃了早餐', '30分钟前', Icons.restaurant, AppColors.primary),
        const SizedBox(height: 8),
        _buildActivityItem('晨间散步', '2小时前', Icons.directions_walk, AppColors.success),
        const SizedBox(height: 8),
        _buildActivityItem('玩耍时间', '4小时前', Icons.sports_esports, AppColors.secondary),
      ],
    );
  }

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // 我的宠物区域
  Widget _buildMyPetsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '🐾 我的宠物',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyPetsScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.grid_view, size: 16),
                label: const Text('查看全部'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: _myPets.length + 1,
            itemBuilder: (context, index) {
              if (index == _myPets.length) {
                return _buildAddPetCard();
              }
              return _buildPetCard(_myPets[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPetCard(Pet pet) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PetDetailScreen(pet: pet),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                pet.imageUrl,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  child: const Icon(Icons.pets, size: 40, color: AppColors.primary),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pet.ageText,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddPetCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddPetScreen()),
        );
      },
      child: Container(
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary, width: 2),
          color: AppColors.cardBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 24, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            const Text(
              '添加宠物',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickAddMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  '快速记录',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildQuickAddOption(
                  '🍖 记录喂食',
                  Icons.restaurant,
                  AppColors.primary,
                  () {
                    Navigator.pop(context);
                    if (_myPets.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FeedingLogScreen(pet: _myPets[0]),
                        ),
                      );
                    }
                  },
                ),
                _buildQuickAddOption(
                  '🚶 记录散步',
                  Icons.directions_walk,
                  AppColors.success,
                  () {
                    Navigator.pop(context);
                    // TODO: 散步记录
                  },
                ),
                _buildQuickAddOption(
                  '💩 记录便便',
                  Icons.clean_hands,
                  AppColors.warning,
                  () {
                    Navigator.pop(context);
                    // TODO: 便便记录
                  },
                ),
                _buildQuickAddOption(
                  '📝 写日记',
                  Icons.edit_note,
                  AppColors.secondary,
                  () {
                    Navigator.pop(context);
                    if (_myPets.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PetDiaryScreen(pet: _myPets[0]),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickAddOption(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
