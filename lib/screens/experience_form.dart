import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _experienceName = "";
  String _description = "";
  String _category = "Part-time"; // default
  String _technologies = "";
  DateTime? _startDate;
  DateTime? _endDate;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  final List<String> _categories = [
    'Full-time',
    'Part-time',
    'Internship',
    'Freelance',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      _startDate = selectedDate;
      _startDateController.text = _formatDate(selectedDate);
      if (_endDate != null && _endDate!.isBefore(selectedDate)) {
        _endDate = null;
        _endDateController.clear();
      }
    });
  }

  Future<void> _selectEndDate() async {
    final firstDate = _startDate ?? DateTime(1900);
    final today = DateTime.now();
    final initialDate = _endDate != null && !_endDate!.isBefore(firstDate)
        ? _endDate!
        : today.isBefore(firstDate)
        ? firstDate
        : today;

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: DateTime(2100),
    );

    if (selectedDate == null || !mounted) return;

    setState(() {
      _endDate = selectedDate;
      _endDateController.text = _formatDate(selectedDate);
    });
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Experience Form')),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Experience Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Pengalaman",
                    labelText: "Nama Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _experienceName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Deskripsi Pengalaman",
                    labelText: "Deskripsi Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi pengalaman tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Experience Dates ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  onTap: _selectStartDate,
                  decoration: InputDecoration(
                    labelText: "Tanggal Mulai",
                    hintText: "Pilih tanggal mulai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: (String? value) {
                    if (_startDate == null) {
                      return "Tanggal mulai wajib dipilih!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  onTap: _selectEndDate,
                  decoration: InputDecoration(
                    labelText: "Tanggal Selesai",
                    hintText: "Pilih tanggal selesai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: (String? value) {
                    if (_endDate == null) {
                      return "Tanggal selesai wajib dipilih!";
                    }
                    if (_startDate != null && _endDate!.isBefore(_startDate!)) {
                      return "Tanggal selesai tidak boleh sebelum tanggal mulai!";
                    }
                    return null;
                  },
                ),
              ),

              // === Category ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori Pengalaman",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _category,
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === Technologies ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Teknologi yang Digunakan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _technologies = value!;
                    });
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Pengalaman berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Pengalaman: $_experienceName'),
                                    Text('Deskripsi: $_description'),
                                    Text(
                                      'Tanggal Mulai: ${_formatDate(_startDate!)}',
                                    ),
                                    Text(
                                      'Tanggal Selesai: ${_formatDate(_endDate!)}',
                                    ),
                                    Text('Kategori: $_category'),
                                    Text('Teknologi: $_technologies'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _experienceName = "";
                                      _description = "";
                                      _category = "Part-time";
                                      _technologies = "";
                                      _startDate = null;
                                      _endDate = null;
                                      _startDateController.clear();
                                      _endDateController.clear();
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
