import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../models/startup_idea.dart';
import '../providers/ideas_provider.dart';

class AddIdeaScreen extends StatefulWidget {
  const AddIdeaScreen({super.key});

  @override
  State<AddIdeaScreen> createState() => _AddIdeaScreenState();
}

class _AddIdeaScreenState extends State<AddIdeaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  
  String _selectedIcon = '💡';
  double _innovation = 3.0;
  double _feasibility = 3.0;
  double _monetization = 3.0;
  
  final List<String> _availableIcons = [
    '💡', '🚀', '🌱', '🏢', '👗', '🐕', '🚗', '💪', '🥘', '📱',
    '💻', '🎨', '🏥', '🎵', '📚', '🎮', '🏡', '⚡', '🌍', '🔬'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _submitIdea() {
    if (!_formKey.currentState!.validate()) return;

    final tags = _tagsController.text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final newIdea = StartupIdea(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      tags: tags,
      icon: _selectedIcon,
      innovation: _innovation.round(),
      feasibility: _feasibility.round(),
      monetization: _monetization.round(),
    );

    // Add the idea to the provider
    Provider.of<IdeasProvider>(context, listen: false).addIdea(newIdea);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idea "${newIdea.title}" created successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Idea'),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        actions: [
          TextButton(
            onPressed: _submitIdea,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIconSelector(),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _titleController,
                label: 'Idea Title',
                icon: Icons.title,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _tagsController,
                label: 'Tags (comma separated)',
                icon: Icons.tag,
                hintText: 'AI, Mobile, Healthcare',
              ),
              const SizedBox(height: 24),
              _buildRatingSection(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _submitIdea,
                  icon: const Icon(Icons.save),
                  label: const Text('Create Idea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.emoji_emotions, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Choose an Icon',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    _selectedIcon,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableIcons.map((icon) {
                  final isSelected = icon == _selectedIcon;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedIcon = icon),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? null : Border.all(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          icon,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? hintText,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Rate Your Idea',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildRatingSlider(
          'Innovation',
          _innovation,
          (value) => setState(() => _innovation = value),
          Icons.lightbulb_outline,
        ),
        const SizedBox(height: 16),
        _buildRatingSlider(
          'Feasibility',
          _feasibility,
          (value) => setState(() => _feasibility = value),
          Icons.build_outlined,
        ),
        const SizedBox(height: 16),
        _buildRatingSlider(
          'Monetization',
          _monetization,
          (value) => setState(() => _monetization = value),
          Icons.monetization_on_outlined,
        ),
      ],
    );
  }

  Widget _buildRatingSlider(
    String label,
    double value,
    ValueChanged<double> onChanged,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${value.round()}/5',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RatingBar.builder(
            initialRating: value,
            minRating: 1,
            maxRating: 5,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 32,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: onChanged,
          ),
        ],
      ),
    );
  }
}