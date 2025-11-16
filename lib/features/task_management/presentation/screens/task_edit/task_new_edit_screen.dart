import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/enums.dart';
import 'package:task_manager/features/task_management/domain/entities/task.dart';

import 'package:task_manager/features/task_management/presentation/bloc/task/task_bloc.dart';
import 'package:task_manager/features/task_management/presentation/widgets/custom_toast.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/generated/l10n.dart';
import 'package:task_manager/features/task_management/presentation/widgets/slide_fade_in.dart';
import 'package:task_manager/features/task_management/presentation/widgets/quick_action_chip.dart';
import 'widgets/status_chip_picker.dart';
import 'widgets/priority_chip_picker.dart';
import 'widgets/group_chip_picker.dart';
import 'widgets/date_time_field.dart';

class TaskNewEditScreen extends StatefulWidget {
  const TaskNewEditScreen({super.key, this.entry});

  final (int, Task)? entry;

  @override
  State<TaskNewEditScreen> createState() => _TaskNewEditScreenState();
}

class _TaskNewEditScreenState extends State<TaskNewEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  Priority _priority = Priority.medium;
  TaskGroup _group = TaskGroup.work;
  TaskStatus _status = TaskStatus.todo;
  DateTime? _startDate;
  DateTime? _endDate;

  bool get isEditing => widget.entry != null;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onFormChanged);
    final e = widget.entry;
    if (e != null) {
      final t = e.$2;
      _titleController.text = t.title;
      _descController.text = t.description ?? '';
      _priority = t.priority;
      _group = t.group;
      _status = t.status;
      _startDate = t.startDate;
      _endDate = t.endDate;
    }
  }

  @override
  void dispose() {
    _titleController.removeListener(_onFormChanged);
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _onFormChanged() => setState(() {});

  bool get _canSave {
    if (_titleController.text.trim().isEmpty) return false;
    if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration _dec(String label, IconData icon, {String? hint, String? helper, Widget? suffix, bool alignWithHint = false}) {
      return InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helper,
        counterText: '',
        prefixIcon: Icon(icon, color: Colors.black54),
        suffixIcon: suffix,
        alignLabelWithHint: alignWithHint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0x1F000000)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.8),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? S.of(context).editTask : S.of(context).addTask),
        actions: [
          IconButton(onPressed: _submit, icon: const Icon(Icons.check), tooltip: S.of(context).save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              SlideFadeIn(
                child: TextFormField(
                  controller: _titleController,
                  maxLength: 60,
                  textInputAction: TextInputAction.next,
                  autofocus: !isEditing,
                  decoration: _dec(
                    S.of(context).title,
                    Icons.title_outlined,
                    hint: S.of(context).titleHint,
                    suffix: _titleController.text.isNotEmpty
                        ? IconButton(
                            tooltip: S.of(context).clear,
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => setState(() => _titleController.clear()),
                          )
                        : null,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty) ? S.of(context).titleRequired : null,
                ),
              ),
              const SizedBox(height: 12),
              SlideFadeIn(
                child: TextFormField(
                  controller: _descController,
                  minLines: 2,
                  maxLines: 5,
                  maxLength: 200,
                  decoration: _dec(
                    S.of(context).descriptionOptional,
                    Icons.notes_rounded,
                    hint: S.of(context).descriptionHint,
                    alignWithHint: true,
                    suffix: _descController.text.isNotEmpty
                        ? IconButton(
                            tooltip: S.of(context).clear,
                            icon: const Icon(Icons.close_rounded),
                            onPressed: () => setState(() => _descController.clear()),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SlideFadeIn(
                child: PriorityChipPicker(
                  value: _priority,
                  onChanged: (v) => setState(() => _priority = v),
                ),
              ),
              const SizedBox(height: 12),
              SlideFadeIn(
                child: GroupChipPicker(
                  value: _group,
                  onChanged: (v) => setState(() => _group = v),
                ),
              ),
              const SizedBox(height: 12),
              SlideFadeIn(
                child: StatusChipPicker(
                  value: _status,
                  onChanged: (s) => setState(() {
                    _status = s;
                    if (_status == TaskStatus.inProgress && _startDate == null) {
                      _startDate = DateTime.now();
                    }
                    if (_status == TaskStatus.done) {
                      final now = DateTime.now();
                      _startDate ??= now;
                      if (_endDate == null || (_startDate != null && _endDate!.isBefore(_startDate!))) {
                        _endDate = now;
                      }
                    }
                  }),
                ),
              ),
              const SizedBox(height: 8),
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 150),
                child: Text(
                  _status == TaskStatus.todo
                      ? S.of(context).tipTodo
                      : _status == TaskStatus.inProgress
                          ? S.of(context).tipInProgress
                          : S.of(context).tipDone,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black54),
                ),
              ),
              const SizedBox(height: 12),
              SlideFadeIn(
                child: Row(
                  children: [
                    Expanded(
                      child: DateTimeField(
                        label: S.of(context).startDateTime,
                        value: _startDate,
                        onPick: () async {
                          final picked = await pickDateTime(context, _startDate);
                          if (picked != null) setState(() => _startDate = picked);
                        },
                        onClear: () => setState(() => _startDate = null),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DateTimeField(
                        label: S.of(context).endDateTime,
                        value: _endDate,
                        onPick: () async {
                          final picked = await pickDateTime(context, _endDate ?? _startDate);
                          if (picked != null) setState(() => _endDate = picked);
                        },
                        onClear: () => setState(() => _endDate = null),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SlideFadeIn(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      QuickActionChip(
                        label: S.of(context).startNow,
                        onTap: () => setState(() => _startDate = DateTime.now()),
                      ),
                      const SizedBox(width: 8),
                      QuickActionChip(
                        label: S.of(context).plus30mEnd,
                        onTap: () => setState(() {
                          final base = _startDate ?? DateTime.now();
                          _endDate = base.add(const Duration(minutes: 30));
                        }),
                      ),
                      const SizedBox(width: 8),
                      QuickActionChip(
                        label: S.of(context).plus1hEnd,
                        onTap: () => setState(() {
                          final base = _startDate ?? DateTime.now();
                          _endDate = base.add(const Duration(hours: 1));
                        }),
                      ),
                      const SizedBox(width: 8),
                      QuickActionChip(
                        label: S.of(context).clearDates,
                        onTap: () => setState(() {
                          _startDate = null;
                          _endDate = null;
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton.icon(
            onPressed: _canSave ? _submit : null,
            icon: const Icon(Icons.check),
            label: Text(isEditing ? S.of(context).saveChanges : S.of(context).addTask),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate != null && _endDate != null && _endDate!.isBefore(_startDate!)) {
      CustomToast.showError(context, S.of(context).endDateBeforeStartError);
      return;
    }

    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final bloc = context.read<TaskBloc>();

    if (isEditing) {
      final (key, current) = widget.entry!;
      final updated = current.copyWith(
        title: title,
        description: desc.isEmpty ? null : desc,
        priority: _priority,
        group: _group,
        status: _status,
        isCompleted: _status == TaskStatus.done,
        startDate: _startDate,
        endDate: _endDate,
      );
      bloc.add(UpdateTaskRequested(key: key, updated: updated));
    } else {
      bloc.add(AddTaskRequested(
        title: title,
        description: desc.isEmpty ? null : desc,
        priority: _priority,
        group: _group,
        status: _status,
        isCompleted: _status == TaskStatus.done,
        startDate: _startDate,
        endDate: _endDate,
      ));
    }
    Navigator.of(context).pop(isEditing ? 'updated' : 'added');
  }
}
