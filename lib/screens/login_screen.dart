import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';
import 'register_screen.dart';

enum UserType { merchant, customer }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  void _loginAsGuest() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(isGuest: true),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  UserType _selectedType = UserType.customer;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;

  late AnimationController _backgroundController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _pulseController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    // Simulate login
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const MainNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 600),
        ),
      );
    }
  }

  void _loginAsGuest() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => 
          const MainNavigation(isGuest: true),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  void _showForgotPassword() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildForgotPasswordSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          _buildAnimatedBackground(),
          
          // Content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      
                      // Logo
                      _buildLogo()
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                      
                      const SizedBox(height: 30),
                      
                      // Welcome Text
                      _buildWelcomeText()
                        .animate()
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0),
                      
                      const SizedBox(height: 40),
                      
                      // User Type Selection
                      _buildUserTypeSelection()
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0),
                      
                      const SizedBox(height: 30),
                      
                      // Phone Field
                      _buildPhoneField()
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 600.ms),
                      
                      const SizedBox(height: 20),
                      
                      // Password Field
                      _buildPasswordField()
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 600.ms),
                      
                      const SizedBox(height: 12),
                      
                      // Forgot Password
                      _buildForgotPassword()
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 600.ms),
                      
                      const SizedBox(height: 30),
                      
                      // Login Button
                      _buildLoginButton()
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 600.ms)
                        .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                      
                      const SizedBox(height: 20),
                      
                      // Guest Login
                      _buildGuestLogin()
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 600.ms),
                      
                      const SizedBox(height: 40),
                      
                      // Bottom Actions
                      _buildBottomActions()
                        .animate()
                        .fadeIn(delay: 1000.ms, duration: 600.ms),
                      
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A2E),
                const Color(0xFF16213E),
                const Color(0xFF0F3460),
                Color.lerp(
                  const Color(0xFF0F3460),
                  const Color(0xFF1A1A2E),
                  _backgroundController.value,
                )!,
              ],
            ),
          ),
          child: Stack(
            children: [
              // Animated circles
              Positioned(
                top: -100 + (_backgroundController.value * 50),
                left: -50 + (_backgroundController.value * 30),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.goldPrimary.withOpacity( 0.15),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -150 - (_backgroundController.value * 50),
                right: -100 + (_backgroundController.value * 40),
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppTheme.goldPrimary.withOpacity( 0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Grid pattern overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity( 0.3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.goldPrimary, AppTheme.goldLight],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppTheme.goldPrimary.withOpacity( 0.3 + (_pulseController.value * 0.2)),
                blurRadius: 30 + (_pulseController.value * 10),
                spreadRadius: 2 + (_pulseController.value * 3),
              ),
            ],
          ),
          child: const Icon(
            Icons.shopping_bag,
            size: 60,
            color: Colors.black,
          ),
        );
      },
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      children: [
        const Text(
          'مرحباً بعودتك',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Changa',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'قم بتسجيل الدخول للمتابعة',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity( 0.7),
            fontFamily: 'Changa',
          ),
        ),
      ],
    );
  }

  Widget _buildUserTypeSelection() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity( 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTypeButton(
              type: UserType.merchant,
              icon: Icons.storefront,
              label: 'نقطة مبيعات',
            ),
          ),
          Expanded(
            child: _buildTypeButton(
              type: UserType.customer,
              icon: Icons.person_outline,
              label: 'عميل',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton({
    required UserType type,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedType == type;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isSelected ? const LinearGradient(
            colors: [AppTheme.goldPrimary, AppTheme.goldLight],
          ) : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.white.withOpacity( 0.7),
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white.withOpacity( 0.7),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
                fontFamily: 'Changa',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity( 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity( 0.2),
        ),
      ),
      child: TextFormField(
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Changa',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'رقم الموبايل',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity( 0.5),
            fontFamily: 'Changa',
          ),
          prefixIcon: const Icon(
            Icons.phone_android,
            color: AppTheme.goldPrimary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال رقم الموبايل';
          }
          if (value.length < 9) {
            return 'رقم الموبايل غير صحيح';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity( 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity( 0.2),
        ),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Changa',
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: 'كلمة المرور',
          hintStyle: TextStyle(
            color: Colors.white.withOpacity( 0.5),
            fontFamily: 'Changa',
          ),
          prefixIcon: const Icon(
            Icons.fingerprint,
            color: AppTheme.goldPrimary,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.white.withOpacity( 0.5),
            ),
            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال كلمة المرور';
          }
          if (value.length < 6) {
            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _showForgotPassword,
        child: Text(
          'نسيت كلمة المرور؟',
          style: TextStyle(
            color: Colors.white.withOpacity( 0.7),
            fontFamily: 'Changa',
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.goldColor,
          foregroundColor: Colors.black,
          elevation: 8,
          shadowColor: AppTheme.goldColor.withOpacity( 0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: _isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 2,
              ),
            )
          : Text(
              _selectedType == UserType.customer 
                ? 'تسجيل الدخول كـ عميل'
                : 'تسجيل الدخول كـ تاجر',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Changa',
              ),
            ),
      ),
    );
  }

  Widget _buildGuestLogin() {
    return GestureDetector(
      onTap: _loginAsGuest,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity( 0.3),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              color: Colors.white.withOpacity( 0.7),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'دخول كضيف',
              style: TextStyle(
                color: Colors.white.withOpacity( 0.7),
                fontFamily: 'Changa',
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: Icons.phone,
          label: 'الرقم المجاني',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.location_on,
          label: 'نقاط الخدمة',
          onTap: () {},
        ),
        _buildActionButton(
          icon: Icons.support_agent,
          label: 'خدمة العملاء',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity( 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity( 0.2),
              ),
            ),
            child: Icon(
              icon,
              color: AppTheme.goldPrimary,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity( 0.7),
              fontFamily: 'Changa',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordSheet() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.darkSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 24),
          const Icon(
            Icons.lock_reset,
            size: 60,
            color: AppTheme.goldPrimary,
          ),
          const SizedBox(height: 16),
          const Text(
            'نسيت كلمة المرور؟',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Changa',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أدخل رقم موبايلك لإرسال رمز التحقق',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity( 0.7),
              fontFamily: 'Changa',
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity( 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white, fontFamily: 'Changa'),
              decoration: InputDecoration(
                hintText: 'رقم الموبايل',
                hintStyle: TextStyle(color: Colors.white.withOpacity( 0.5), fontFamily: 'Changa'),
                prefixIcon: const Icon(Icons.phone_android, color: AppTheme.goldPrimary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إرسال رمز التحقق'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldPrimary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'إرسال رمز التحقق',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Changa',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _loginAsGuest() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(isGuest: true),
      ),
    );
  }
}

  void _loginAsGuest() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainNavigation(isGuest: true),
      ),
    );
  }
