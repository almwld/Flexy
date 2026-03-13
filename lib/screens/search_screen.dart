import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSearching = false;

  final List<String> _recentSearches = [
    'سيارة تويوتا',
    'شقة للإيجار',
    'آيفون 14',
    'أثاث مكتبي',
  ];

  final List<String> _popularSearches = [
    'سيارات',
    'عقارات',
    'هواتف',
    'لابتوب',
    'أثاث',
    'ملابس',
    'مطاعم',
    'خدمات',
  ];

  final List<Map<String, dynamic>> _searchResults = [
    {
      'title': 'تويوتا كامري 2020',
      'price': '45,000',
      'location': 'صنعاء',
      'image': 'https://images.unsplash.com/photo-1621007947382-bb3c3968e3bb?w=400',
      'category': 'سيارات',
    },
    {
      'title': 'آيفون 14 Pro Max',
      'price': '350,000',
      'location': 'عدن',
      'image': 'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?w=400',
      'category': 'إلكترونيات',
    },
    {
      'title': 'شقة 3 غرف للإيجار',
      'price': '50,000',
      'location': 'تعز',
      'image': 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400',
      'category': 'عقارات',
    },
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;
    
    setState(() {
      _isSearching = true;
      if (!_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 10) {
          _recentSearches.removeLast();
        }
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'البحث...',
              hintStyle: TextStyle(
                color: Colors.grey[500],
                fontFamily: 'Changa',
              ),
              prefixIcon: _isSearching
                ? IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: _clearSearch,
                  )
                : const Icon(Icons.search, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onSubmitted: _performSearch,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() => _isSearching = false);
              }
            },
          ),
        ),
      ),
      body: _isSearching
        ? _buildSearchResults()
        : _buildSearchSuggestions(isDark),
    );
  }

  Widget _buildSearchSuggestions(bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() => _recentSearches.clear());
                  },
                  child: const Text('مسح'),
                ),
                const Text(
                  'عمليات البحث الأخيرة',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _recentSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = search;
                    _performSearch(search);
                  },
                  child: Chip(
                    avatar: const Icon(Icons.history, size: 18),
                    label: Text(search),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() => _recentSearches.remove(search));
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Popular Searches
          const Text(
            'عمليات البحث الشائعة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _popularSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
                child: Chip(
                  backgroundColor: AppTheme.goldColor.withValues(alpha: 0.2),
                  label: Text(
                    search,
                    style: const TextStyle(color: AppTheme.goldColor),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Categories
          const Text(
            'تصفح حسب الفئة',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            children: [
              _buildCategoryIcon(Icons.directions_car, 'سيارات'),
              _buildCategoryIcon(Icons.home, 'عقارات'),
              _buildCategoryIcon(Icons.phone_android, 'إلكترونيات'),
              _buildCategoryIcon(Icons.chair, 'أثاث'),
              _buildCategoryIcon(Icons.checkroom, 'ملابس'),
              _buildCategoryIcon(Icons.restaurant, 'مطاعم'),
              _buildCategoryIcon(Icons.build, 'خدمات'),
              _buildCategoryIcon(Icons.more_horiz, 'أخرى'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        _searchController.text = label;
        _performSearch(label);
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.goldColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.goldColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return _buildResultCard(result, index);
      },
    );
  }

  Widget _buildResultCard(Map<String, dynamic> result, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.network(
              result['image'] as String,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        result['category'] as String,
                        style: const TextStyle(
                          color: AppTheme.goldColor,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      result['location'] as String,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  result['title'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.goldColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${result['price']} ر.ي',
                        style: const TextStyle(
                          color: AppTheme.goldColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
      .animate()
      .fadeIn(delay: (index * 100).ms, duration: 400.ms)
      .slideY(begin: 0.2, end: 0);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
