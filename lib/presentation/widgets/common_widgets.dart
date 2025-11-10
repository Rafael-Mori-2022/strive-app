import 'package:flutter/material.dart';
import 'package:strive/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? leadingIcon;
  final bool isExpanded;
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.leadingIcon,
      this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(RadiusTokens.pill),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          width: isExpanded ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: ShapeDecoration(
            color: scheme.primary,
            shape:
                StadiumBorder(side: BorderSide(color: scheme.primaryContainer)),
            shadows: [
              BoxShadow(
                  color: scheme.primary.withAlpha(50),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 6))
            ],
          ),
          child: Row(
              mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (leadingIcon != null)
                  Icon(leadingIcon, color: scheme.onPrimary, size: 20),
                if (leadingIcon != null) const SizedBox(width: 8),
                Text(label,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: scheme.onPrimary)),
              ]),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? leadingIcon;
  const SecondaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(RadiusTokens.pill),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: ShapeDecoration(
            color: scheme.primaryContainer,
            shape: StadiumBorder(
                side: BorderSide(color: scheme.primary.withAlpha(50))),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (leadingIcon != null)
              Icon(leadingIcon, color: scheme.onPrimaryContainer, size: 20),
            if (leadingIcon != null) const SizedBox(width: 8),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: scheme.onPrimaryContainer)),
          ]),
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  const SearchInput(
      {super.key, required this.hint, required this.onChanged, this.onClear});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.lg),
        border: Border.all(color: Colors.grey.withAlpha(50)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: [
        const Icon(Icons.search, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              border: InputBorder.none,
            ),
          ),
        ),
        if (_controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              _controller.clear();
              widget.onChanged('');
              widget.onClear?.call();
              setState(() {});
            },
          ),
      ]),
    );
  }
}

class FormInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const FormInput(
      {super.key,
      required this.controller,
      required this.label,
      this.hint,
      this.keyboardType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }
}

class XPBar extends StatelessWidget {
  final double progress; // 0..1
  final String label;
  const XPBar({super.key, required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RadiusTokens.lg),
          gradient: LinearGradient(
              colors: [scheme.primaryContainer, scheme.primary.withAlpha(50)])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('XP', style: Theme.of(context).textTheme.titleMedium),
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ]),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusTokens.pill),
          child: LinearProgressIndicator(
              minHeight: 12,
              value: progress,
              backgroundColor: Colors.grey.withAlpha(50),
              valueColor: AlwaysStoppedAnimation(scheme.primary)),
        ),
      ]),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? tint;
  final VoidCallback? onTap;
  const StatCard(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      this.tint,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = tint ?? scheme.primary;
    return Material(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(RadiusTokens.lg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.lg),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusTokens.lg),
            border: Border.all(color: color.withAlpha(50)),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: color, size: 22),
            const Spacer(),
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.grey[600]),
                softWrap: true,
                overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
          ]),
        ),
      ),
    );
  }
}

class LeagueCard extends StatelessWidget {
  final String tier;
  final int rank;
  final VoidCallback onTap;
  const LeagueCard(
      {super.key, required this.tier, required this.rank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.primaryContainer,
      borderRadius: BorderRadius.circular(RadiusTokens.xl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(RadiusTokens.xl),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            CircleAvatar(
                radius: 28,
                backgroundColor: scheme.primary,
                child: Icon(Icons.military_tech, color: scheme.onPrimary)),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('League',
                      style: Theme.of(context).textTheme.labelMedium),
                  Text(tier, style: Theme.of(context).textTheme.titleLarge),
                  Text('Rank #$rank',
                      style: Theme.of(context).textTheme.labelMedium),
                ])),
            Icon(Icons.chevron_right, color: scheme.onPrimaryContainer)
          ]),
        ),
      ),
    );
  }
}

class ExpandableMealCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback onAdd;
  const ExpandableMealCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.children,
      required this.onAdd});

  @override
  State<ExpandableMealCard> createState() => _ExpandableMealCardState();
}

class _ExpandableMealCardState extends State<ExpandableMealCard> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusTokens.lg),
        border: Border.all(color: Colors.grey.withAlpha(50)),
      ),
      child: Column(children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(widget.title,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 2),
                    Text(widget.subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.grey)),
                  ])),
              IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: scheme.primary,
                  onPressed: widget.onAdd),
              AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: _expanded ? 0.5 : 0,
                  child: const Icon(Icons.expand_more)),
            ]),
          ),
        ),
        AnimatedCrossFade(
          crossFadeState:
              _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 220),
          firstChild: Column(children: widget.children),
          secondChild: const SizedBox.shrink(),
        )
      ]),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String name;
  final String details;
  final VoidCallback onAdd;
  const ExerciseTile(
      {super.key,
      required this.name,
      required this.details,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: const Icon(Icons.fitness_center, color: Colors.deepPurple)),
      title: Text(name, overflow: TextOverflow.ellipsis),
      subtitle: Text(details, overflow: TextOverflow.ellipsis),
      trailing: IconButton(
          icon: const Icon(Icons.add_circle),
          color: Colors.green,
          onPressed: onAdd),
      onTap: onAdd,
    );
  }
}
