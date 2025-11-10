import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/domain/entities/user_profile.dart';
import 'package:strive/presentation/state/profile_providers.dart';
import 'package:strive/presentation/widgets/common_widgets.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _goalCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _goalCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileUpdateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Vamos começar',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            FormInput(
                controller: _nameCtrl,
                label: 'Nome',
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe seu nome' : null),
            const SizedBox(height: 12),
            FormInput(
                controller: _ageCtrl,
                label: 'Idade',
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe sua idade' : null),
            const SizedBox(height: 12),
            FormInput(
                controller: _heightCtrl,
                label: 'Altura (cm)',
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe sua altura' : null),
            const SizedBox(height: 12),
            FormInput(
                controller: _weightCtrl,
                label: 'Peso (kg)',
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Informe seu peso' : null),
            const SizedBox(height: 12),
            FormInput(
                controller: _goalCtrl,
                label: 'Objetivo',
                hint: 'Ex: Ganhar massa'),
            const SizedBox(height: 24),
            state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    label: 'Salvar',
                    leadingIcon: Icons.check,
                    isExpanded: true,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() != true) return;
                      final profile = UserProfile(
                        id: 'u1',
                        name: _nameCtrl.text.trim(),
                        age: int.tryParse(_ageCtrl.text.trim()) ?? 0,
                        heightCm: double.tryParse(_heightCtrl.text.trim()) ?? 0,
                        weightKg: double.tryParse(_weightCtrl.text.trim()) ?? 0,
                        goal: _goalCtrl.text.trim(),
                        xp: 0,
                      );
                      await ref
                          .read(profileUpdateProvider.notifier)
                          .save(profile);
                      if (context.mounted) context.go('/success');
                    },
                  ),
          ]),
        ),
      ),
    );
  }
}
