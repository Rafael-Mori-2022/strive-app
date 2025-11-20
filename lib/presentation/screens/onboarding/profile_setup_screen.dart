import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// Certifique-se de importar seu modelo de UserProfile corretamente
// import 'package:strive/domain/entities/user_profile.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final _nameCtrl = TextEditingController();
  // _ageCtrl REMOVIDO. Substituído pela data abaixo.
  final _dobCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();

  DateTime? _selectedDateOfBirth; // Variável para guardar a data real
  String? _selectedGoal;
  String? _selectedGender;

  final List<String> _goals = [
    'Perder Peso',
    'Ganhar Massa Muscular',
    'Melhorar Resistência',
    'Manter Saúde'
  ];

  final List<String> _genders = ['Masculino', 'Feminino', 'Outro'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _dobCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  // Função auxiliar para calcular idade
  int _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Função para abrir o calendário
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now()
          .subtract(const Duration(days: 365 * 18)), // Começa em 18 anos atrás
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale(
          'pt', 'BR'), // Se tiver suporte a localização configurado
    );

    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
        // Formatação visual simples DD/MM/AAAA
        _dobCtrl.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedGoal == null ||
        _selectedGender == null ||
        _selectedDateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Usuário não autenticado");

      final calculatedAge = _calculateAge(_selectedDateOfBirth!);

      final weightString = _weightCtrl.text.replaceAll(',', '.');
      final heightString = _heightCtrl.text; // Altura mantemos inteiro (cm)

      final newProfile = {
        'id': user.uid,
        'email': user.email,
        'name': _nameCtrl.text.trim(),
        'age': calculatedAge, // Salva a idade calculada
        'birthDate': Timestamp.fromDate(
            _selectedDateOfBirth!), // É bom salvar a data original também
        'heightCm': double.parse(heightString),
        'weightKg': double.parse(weightString),
        'gender': _selectedGender,
        'goal': _selectedGoal,
        'xp': 0,
        'createdAt': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(newProfile);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Bem-vindo(a)!",
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Vamos configurar seu perfil para personalizar sua jornada.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),

                _buildSectionTitle(context, "Sobre você"),
                _buildTextField(
                  controller: _nameCtrl,
                  label: "Nome Completo",
                  icon: Icons.person_outline,
                  validator: (v) => v!.isEmpty ? 'Informe seu nome' : null,
                ),
                const SizedBox(height: 16),

                // Linha de Data de Nascimento e Gênero
                Row(
                  children: [
                    Expanded(
                      // Campo de Data de Nascimento (Read Only)
                      child: _buildTextField(
                        controller: _dobCtrl,
                        label: "Nascimento",
                        icon: Icons.calendar_today_outlined,
                        readOnly: true, // Impede digitar texto
                        onTap: () => _selectDate(context), // Abre o calendário
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdown(
                        label: "Gênero",
                        value: _selectedGender,
                        items: _genders,
                        icon: Icons.people_outline,
                        onChanged: (v) => setState(() => _selectedGender = v),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildSectionTitle(context, "Medidas"),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _heightCtrl,
                        label: "Altura (cm)",
                        icon: Icons.height,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Só números
                          LengthLimitingTextInputFormatter(
                              3), // Máximo 3 dígitos (ex: 180)
                        ],
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildTextField(
                        controller: _weightCtrl,
                        label: "Peso (kg)",
                        icon: Icons.monitor_weight_outlined,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          // Permite números, ponto e vírgula
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                          // Aumentamos para 5 para permitir "105.5" (3 digitos + ponto + decimal)
                          LengthLimitingTextInputFormatter(5),
                        ],
                        validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                _buildSectionTitle(context, "Objetivo Principal"),
                _buildDropdown(
                  label: "Selecione seu objetivo",
                  value: _selectedGoal,
                  items: _goals,
                  icon: Icons.flag_outlined,
                  onChanged: (v) => setState(() => _selectedGoal = v),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Finalizar Cadastro",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool readOnly = false, // Novo parâmetro para o campo de data
    VoidCallback? onTap, // Novo parâmetro para o clique
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      readOnly: readOnly, // Impede abrir teclado se for true
      onTap: onTap, // Ação ao clicar
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String item) {
        return DropdownMenuItem(
            value: item, child: Text(item, overflow: TextOverflow.ellipsis));
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor:
            Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
      ),
    );
  }
}
