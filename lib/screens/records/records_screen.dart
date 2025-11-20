import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/pet_model.dart';
import '../../core/constants/app_images.dart';
import '../pet_management/feeding_log_screen.dart';
import '../pet_management/pet_diary_screen.dart';
import '../pet_management/health_records_screen.dart';

/// 记录模块 - 统一管理所有宠物记录
class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 示例宠物数据
  final Pet _currentPet = Pet(
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
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 顶部栏
            _buildHeader(),

            // Tab标签
            _buildTabBar(),

            // 内容区域
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAllRecords(),
                  _buildFeedingRecords(),
                  _buildWalkRecords(),
                  _buildHealthRecords(),
                  _buildDiaryRecords(),
                ],
              ),
            ),
          ],
        ),
      ),
      // 快速添加按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecordMenu(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // 宠物头像
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                _currentPet.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  child: const Icon(Icons.pets, color: AppColors.primary),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📝 成长记录',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${_currentPet.name}的所有记录',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // 搜索按钮
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: 实现搜索功能
            },
          ),
          // 筛选按钮
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: 实现筛选功能
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        labelColor: AppColors.background,
        unselectedLabelColor: AppColors.textSecondary,
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: '全部'),
          Tab(text: '🍖 喂食'),
          Tab(text: '🚶 散步'),
          Tab(text: '❤️ 健康'),
          Tab(text: '📖 日记'),
        ],
      ),
    );
  }

  // 全部记录
  Widget _buildAllRecords() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildDateSection('今天', [
          _buildRecordItem(
            '喂食',
            '早餐 - 狗粮 200g',
            '30分钟前',
            Icons.restaurant,
            AppColors.primary,
          ),
          _buildRecordItem(
            '散步',
            '晨间散步 30分钟',
            '2小时前',
            Icons.directions_walk,
            AppColors.success,
          ),
        ]),
        const SizedBox(height: 24),
        _buildDateSection('昨天', [
          _buildRecordItem(
            '健康',
            '体温测量 38.5°C',
            '昨天 20:00',
            Icons.favorite,
            AppColors.error,
          ),
          _buildRecordItem(
            '日记',
            '今天Max心情很好，玩得很开心',
            '昨天 18:30',
            Icons.book,
            AppColors.secondary,
          ),
          _buildRecordItem(
            '喂食',
            '晚餐 - 鸡胸肉 + 狗粮',
            '昨天 18:00',
            Icons.restaurant,
            AppColors.primary,
          ),
        ]),
        const SizedBox(height: 24),
        _buildDateSection('本周', [
          _buildRecordItem(
            '健康',
            '疫苗接种 - 狂犬病疫苗',
            '3天前',
            Icons.medical_services,
            AppColors.error,
          ),
          _buildRecordItem(
            '散步',
            '公园玩耍 1小时',
            '4天前',
            Icons.directions_walk,
            AppColors.success,
          ),
        ]),
      ],
    );
  }

  Widget _buildDateSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: item,
        )),
      ],
    );
  }

  Widget _buildRecordItem(
    String title,
    String content,
    String time,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
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
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 喂食记录
  Widget _buildFeedingRecords() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatCard(
          '本周喂食',
          '14次',
          '平均 2次/天',
          Icons.restaurant,
          AppColors.primary,
        ),
        const SizedBox(height: 20),
        _buildRecordItem(
          '早餐',
          '狗粮 200g + 鸡胸肉 50g',
          '30分钟前',
          Icons.restaurant,
          AppColors.primary,
        ),
        const SizedBox(height: 12),
        _buildRecordItem(
          '晚餐',
          '狗粮 200g',
          '昨天 18:00',
          Icons.restaurant,
          AppColors.primary,
        ),
        const SizedBox(height: 12),
        _buildRecordItem(
          '午餐',
          '狗粮 150g + 蔬菜',
          '昨天 12:00',
          Icons.restaurant,
          AppColors.primary,
        ),
      ],
    );
  }

  // 散步记录
  Widget _buildWalkRecords() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatCard(
          '本周散步',
          '12次',
          '总计 6小时',
          Icons.directions_walk,
          AppColors.success,
        ),
        const SizedBox(height: 20),
        _buildRecordItem(
          '晨间散步',
          '公园 30分钟',
          '2小时前',
          Icons.directions_walk,
          AppColors.success,
        ),
        const SizedBox(height: 12),
        _buildRecordItem(
          '傍晚散步',
          '小区 20分钟',
          '昨天 18:30',
          Icons.directions_walk,
          AppColors.success,
        ),
      ],
    );
  }

  // 健康记录
  Widget _buildHealthRecords() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatCard(
          '健康评分',
          '85分',
          '状态良好',
          Icons.favorite,
          AppColors.error,
        ),
        const SizedBox(height: 20),
        _buildRecordItem(
          '体温测量',
          '38.5°C 正常',
          '昨天 20:00',
          Icons.thermostat,
          AppColors.error,
        ),
        const SizedBox(height: 12),
        _buildRecordItem(
          '疫苗接种',
          '狂犬病疫苗',
          '3天前',
          Icons.medical_services,
          AppColors.error,
        ),
        const SizedBox(height: 12),
        _buildRecordItem(
          '体检',
          '常规体检 - 健康',
          '1周前',
          Icons.medical_information,
          AppColors.error,
        ),
      ],
    );
  }

  // 日记记录
  Widget _buildDiaryRecords() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildStatCard(
          '本月日记',
          '15篇',
          '记录美好时光',
          Icons.book,
          AppColors.secondary,
        ),
        const SizedBox(height: 20),
        _buildDiaryItem(
          '开心的一天',
          '今天Max心情特别好，在公园遇到了小伙伴，玩得很开心。回家后吃了最爱的鸡胸肉，满足地睡着了。',
          '昨天 18:30',
          '😊',
        ),
        const SizedBox(height: 12),
        _buildDiaryItem(
          '第一次游泳',
          'Max今天第一次下水游泳，一开始有点害怕，后来越玩越开心，在水里扑腾了半个小时。',
          '3天前',
          '🤩',
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.2),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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
    );
  }

  Widget _buildDiaryItem(String title, String content, String time, String mood) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.secondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                mood,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _showAddRecordMenu(BuildContext context) {
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
                  '添加记录',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildAddOption(
                  '🍖 喂食记录',
                  Icons.restaurant,
                  AppColors.primary,
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FeedingLogScreen(pet: _currentPet),
                      ),
                    );
                  },
                ),
                _buildAddOption(
                  '🚶 散步记录',
                  Icons.directions_walk,
                  AppColors.success,
                  () {
                    Navigator.pop(context);
                    // TODO: 创建散步记录页面
                  },
                ),
                _buildAddOption(
                  '❤️ 健康记录',
                  Icons.favorite,
                  AppColors.error,
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HealthRecordsScreen(pet: _currentPet),
                      ),
                    );
                  },
                ),
                _buildAddOption(
                  '📖 日记记录',
                  Icons.book,
                  AppColors.secondary,
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PetDiaryScreen(pet: _currentPet),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddOption(
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
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
