import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strive/presentation/screens/medicine/medicine_provider.dart';

class MedicineScreen extends ConsumerWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final medicines = ref.watch(medicineProvider);

    // Cálculos de progresso
    final total = medicines.length;
    final taken = medicines.where((m) => m.isTaken).length;
    final progress = total == 0 ? 0.0 : taken / total;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // --- Cabeçalho ---
            SliverAppBar(
              backgroundColor: theme.colorScheme.surface,
              title: Text('Medicamentos',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  // CORREÇÃO: Evita o erro "Nothing to pop"
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/dashboard');
                  }
                },
              ),
            ),

            // --- Conteúdo ---
            if (medicines.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    _ProgressHeader(
                        progress: progress, taken: taken, total: total),
                    const SizedBox(height: 24),
                    Text("Sua agenda hoje",
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...medicines.map((med) => _MedicineCard(medicine: med)),

                    // Espaço extra no final
                    const SizedBox(height: 180),
                  ]),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton.extended(
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            builder: (context) => const _AddMedicineSheet(),
          ),
          label: const Text('Adicionar'),
          icon: const Icon(Icons.add),
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}

// --- Componentes Visuais ---

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medication_liquid_rounded,
                size: 80, color: theme.colorScheme.primary.withOpacity(0.3)),
            const SizedBox(height: 24),
            Text(
              "Nenhum medicamento",
              style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              "Adicione seus medicamentos ou suplementos para receber lembretes e acompanhar seu uso.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  final double progress;
  final int taken;
  final int total;

  const _ProgressHeader(
      {required this.progress, required this.taken, required this.total});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Progresso Diário",
                    style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer)),
                const SizedBox(height: 4),
                Text(
                  taken == total
                      ? "Tudo certo! 🎉"
                      : "$taken de $total tomados",
                  style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer),
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress,
                strokeWidth: 6,
                backgroundColor: theme.colorScheme.surface.withOpacity(0.5),
                color: theme.colorScheme.primary,
              ),
              Text("${(progress * 100).toInt()}%",
                  style: TextStyle(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}

class _MedicineCard extends ConsumerWidget {
  final Medicine medicine;
  const _MedicineCard({required this.medicine});

  IconData _getIcon(MedicineType type) {
    switch (type) {
      case MedicineType.pill:
        return Icons.circle;
      case MedicineType.liquid:
        return Icons.water_drop;
      case MedicineType.injection:
        return Icons.vaccines;
      case MedicineType.inhaler:
        return Icons.air;
      case MedicineType.supplement:
        return Icons.bolt;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isTaken = medicine.isTaken;

    return Dismissible(
      key: Key(medicine.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(16)),
        child: Icon(Icons.delete, color: theme.colorScheme.onErrorContainer),
      ),
      onDismissed: (_) =>
          ref.read(medicineProvider.notifier).removeMedicine(medicine.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isTaken
              ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.5)
              : theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isTaken
                  ? theme.colorScheme.secondaryContainer
                  : theme.colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(medicine.type),
                color: isTaken
                    ? theme.colorScheme.onSecondaryContainer
                    : theme.colorScheme.primary,
                size: 20),
          ),
          title: Text(
            medicine.name,
            style: theme.textTheme.titleMedium?.copyWith(
              decoration: isTaken ? TextDecoration.lineThrough : null,
              color: isTaken
                  ? theme.colorScheme.onSurface.withOpacity(0.6)
                  : theme.colorScheme.onSurface,
            ),
          ),
          subtitle:
              Text("${medicine.dosage} • ${medicine.time.format(context)}"),
          trailing: Checkbox(
            value: isTaken,
            onChanged: (_) =>
                ref.read(medicineProvider.notifier).toggleTaken(medicine.id),
            shape: const CircleBorder(),
          ),
        ),
      ),
    );
  }
}

class _AddMedicineSheet extends ConsumerStatefulWidget {
  const _AddMedicineSheet();

  @override
  ConsumerState<_AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends ConsumerState<_AddMedicineSheet> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();

  MedicineType _selectedType = MedicineType.pill;
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(24, 24, 24, bottomPadding + 100),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("O que você vai tomar?",
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // 1. Input Nome
            TextField(
              controller: _nameController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Nome do medicamento",
                hintText: "Ex: Vitamina C, Dipirona...",
                prefixIcon: const Icon(Icons.edit),
                filled: true,
                fillColor:
                    theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Seletor Visual de Tipo
            Text("Tipo", style: theme.textTheme.labelLarge),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: MedicineType.values.map((type) {
                  final isSelected = _selectedType == type;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedType = type),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 12),
                      width: 70,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        border: isSelected
                            ? Border.all(
                                color: theme.colorScheme.primary, width: 2)
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getIcon(type),
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getTypeName(type),
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Dosagem e Hora
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dosageController,
                    decoration: InputDecoration(
                      labelText: "Dose (Opcional)",
                      hintText: "Ex: 500mg",
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest
                          .withOpacity(0.5),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final t = await showTimePicker(
                          context: context, initialTime: _selectedTime);
                      if (t != null) setState(() => _selectedTime = t);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 8),
                          Text(
                            _selectedTime.format(context),
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Botão Salvar
            FilledButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  // Fecha o teclado antes de sair para evitar bugs visuais
                  FocusScope.of(context).unfocus();

                  ref.read(medicineProvider.notifier).addMedicine(
                        _nameController.text,
                        _dosageController.text.isEmpty
                            ? 'Padrão'
                            : _dosageController.text,
                        _selectedType,
                        _selectedTime,
                      );
                  context.pop(); // Fecha o modal
                }
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Salvar Lembrete"),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(MedicineType type) {
    switch (type) {
      case MedicineType.pill:
        return Icons.circle_outlined;
      case MedicineType.liquid:
        return Icons.water_drop_outlined;
      case MedicineType.injection:
        return Icons.vaccines_outlined;
      case MedicineType.inhaler:
        return Icons.air;
      case MedicineType.supplement:
        return Icons.bolt;
    }
  }

  String _getTypeName(MedicineType type) {
    switch (type) {
      case MedicineType.pill:
        return "Pílula";
      case MedicineType.liquid:
        return "Líquido";
      case MedicineType.injection:
        return "Injeção";
      case MedicineType.inhaler:
        return "Inalador";
      case MedicineType.supplement:
        return "Supl.";
    }
  }
}
