import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../settings/settings_screen.dart';
import '../pet_management/my_pets_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('我的'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Profile header
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: AppColors.background,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                    color: AppColors.background,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '李明',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '北京市 · 朝阳区',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('宠物数量', '2'),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.divider,
                ),
                _buildStat('记录天数', '128'),
                Container(
                  width: 1,
                  height: 40,
                  color: AppColors.divider,
                ),
                _buildStat('健康评分', '85'),
              ],
            ),
            const SizedBox(height: 32),
            // My Pets section
            _buildSectionHeader('我的宠物', onTap: () {}),
            const SizedBox(height: 16),
            _buildPetCard(
              name: 'Max',
              breed: '金毛',
              age: '2岁',
            ),
            const SizedBox(height: 32),
            // Menu items
            _buildSectionHeader('账户设置', onTap: null),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.person_outline,
              title: '编辑资料',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.pets,
              title: '宠物管理',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyPetsScreen()),
                );
              },
            ),
            _buildMenuItem(
              icon: Icons.location_on_outlined,
              title: '位置管理',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('偏好设置', onTap: null),
            const SizedBox(height: 16),
            _buildMenuItem(
              icon: Icons.notifications_outlined,
              title: '通知设置',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.privacy_tip_outlined,
              title: '隐私设置',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.help_outline,
              title: '帮助与支持',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildMenuItem(
              icon: Icons.logout,
              title: '退出登录',
              onTap: () {},
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (onTap != null)
          TextButton(
            onPressed: onTap,
            child: const Text('添加'),
          ),
      ],
    );
  }

  Widget _buildPetCard({
    required String name,
    required String breed,
    required String age,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.pets,
              color: AppColors.primary,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$breed • $age',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? AppColors.error : AppColors.textPrimary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDestructive ? AppColors.error : AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDestructive ? AppColors.error : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
