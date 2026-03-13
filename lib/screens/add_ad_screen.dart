import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class AddAdScreen extends StatefulWidget {
  const AddAdScreen({super.key});

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

class _AddAdScreenState extends State<AddAdScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = '';
  String _selectedCity = '';
  bool _isNegotiable = false;
  bool _isLoading = false;

  final List<String> _categories = [
    'سيارات',
    'عقارات',
    'إلكترونيات',
    'أثاث',
    'ملابس',
    'مطاعم',
    'خدمات',
    'أخرى',
  ];

  final List<String> _cities = [
    'صنعاء',
    'عدن',
    'تعز',
    'الحديدة',
    'المكلا',
    'إب',
    'ذمار',
    'البيضاء',
    'سيئون',
    'مارب',
  ];

  Future<void> _submitAd() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار الفئة'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }
    if (_selectedCity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء اختيار المدينة'),
          backgroundColor: AppTheme.error,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم نشر إعلانك بنجاح!'),
          backgroundColor: AppTheme.success,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة إعلان جديد'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitAd,
            child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppTheme.goldColor,
                  ),
                )
              : const Text('نشر'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Images Section
              _buildImagesSection()
                .animate()
                .fadeIn(duration: 400.ms),
              
              const SizedBox(height: 24),
              
              // Title
              _buildSectionTitle('عنوان الإعلان'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'مثال: سيارة تويوتا كامري 2020',
                  filled: true,
                  fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال عنوان الإعلان';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 100.ms),
              
              const SizedBox(height: 24),
              
              // Category
              _buildSectionTitle('الفئة'),
              const SizedBox(height: 8),
              _buildCategorySelector()
                .animate()
                .fadeIn(delay: 200.ms),
              
              const SizedBox(height: 24),
              
              // Price
              _buildSectionTitle('السعر'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: 'أدخل السعر',
                        filled: true,
                        fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        suffixText: 'ر.ي',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال السعر';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Row(
                    children: [
                      Checkbox(
                        value: _isNegotiable,
                        onChanged: (value) {
                          setState(() => _isNegotiable = value ?? false);
                        },
                        activeColor: AppTheme.goldColor,
                      ),
                      const Text('قابل للتفاوض'),
                    ],
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms),
              
              const SizedBox(height: 24),
              
              // City
              _buildSectionTitle('المدينة'),
              const SizedBox(height: 8),
              _buildCitySelector()
                .animate()
                .fadeIn(delay: 400.ms),
              
              const SizedBox(height: 24),
              
              // Description
              _buildSectionTitle('الوصف'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 5,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: 'اكتب وصفاً تفصيلياً للإعلان...',
                  filled: true,
                  fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال وصف الإعلان';
                  }
                  if (value.length < 20) {
                    return 'الوصف يجب أن يكون 20 حرف على الأقل';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 500.ms),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitAd,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.goldColor,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'نشر الإعلان',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Changa',
                        ),
                      ),
                ),
              ).animate().fadeIn(delay: 600.ms).scale(),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildImagesSection() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          // Add Image Button
          Container(
            width: 120,
            margin: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.goldColor.withOpacity( 0.5),
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  size: 40,
                  color: AppTheme.goldColor.withOpacity( 0.7),
                ),
                const SizedBox(height: 8),
                Text(
                  'إضافة صورة',
                  style: TextStyle(
                    color: AppTheme.goldColor.withOpacity( 0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Sample Images
          ...List.generate(3, (index) {
            return Container(
              width: 120,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.grey[800],
                      child: Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey[600],
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          color: Colors.white,
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _categories.map((category) {
        final isSelected = _selectedCategory == category;
        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = category),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.goldColor
                  : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? AppTheme.goldColor
                    : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
              ),
            ),
            child: Text(
              category,
              style: TextStyle(
                color: isSelected ? Colors.black : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCitySelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCity.isEmpty ? null : _selectedCity,
          hint: const Text('اختر المدينة'),
          isExpanded: true,
          alignment: Alignment.centerRight,
          items: _cities.map((city) {
            return DropdownMenuItem(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedCity = value ?? '');
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
