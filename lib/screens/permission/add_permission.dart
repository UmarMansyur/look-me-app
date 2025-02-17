import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:look_me/store/token.dart';
import 'package:look_me/styles/styles.dart';
import 'package:http_parser/http_parser.dart';

class AddPermissionScreen extends StatefulWidget {
  const AddPermissionScreen({super.key});

  @override
  State<AddPermissionScreen> createState() => _AddPermissionScreenState();
}

class _AddPermissionScreenState extends State<AddPermissionScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _shortDescController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, String>> _permissionTypes = [
    {
      'label': 'Sakit',
      'value': 'Sickness',
    },
    {
      'label': 'Cuti',
      'value': 'Leave',
    },
    {
      'label': 'Izin',
      'value': 'Permission',
    },
  ];
  String? _selectedFileName;
  String? _selectedPermissionType;
  PlatformFile? _selectedFile;
  bool _isLoading = false;
  dynamic _selectedFileBytes;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      withData: true,
    );

    if (result != null) {
      String extension = result.files.single.extension?.toLowerCase() ?? '';
      if (['jpg', 'jpeg', 'png'].contains(extension)) {
        setState(() {
          _selectedFile = result.files.single;
          _selectedFileName = result.files.single.name;
          _selectedFileBytes = result.files.single.bytes;
          print(_selectedFileBytes);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Hanya file gambar (JPG, JPEG, PNG) yang diizinkan'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  final labelStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Color(0xFF063039),
  );

  Future<void> _addPermission() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final headers = {
        'Authorization': 'Bearer ${await TokenStore.getTokenAccess()}',
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.64:3000/permission-request/'),
      );
      request.headers.addAll(headers);

      request.fields['type'] = _selectedPermissionType ?? '';
      request.fields['start_date'] = _startDateController.text;
      request.fields['end_date'] = _endDateController.text;
      request.fields['title'] = _shortDescController.text;
      request.fields['desc'] = _descriptionController.text;

      if (_selectedFile != null && _selectedFileBytes != null) {
        final extension = _selectedFile!.extension?.toLowerCase() ?? '';
        final mimeType = extension == 'png' ? 'image/png' : 'image/jpeg';

        final file = http.MultipartFile.fromBytes(
          'file',
          _selectedFileBytes,
          filename: _selectedFileName,
          contentType: MediaType.parse(mimeType),
        );
        request.files.add(file);
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perizinan berhasil ditambahkan'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacementNamed(context, '/permission');
      } else {
        throw Exception('Gagal menambahkan perizinan');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Tambah Perizinan',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                // buatkan form untuk menambahkan perizinan
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Jenis Perizinan: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            dropdownColor: const Color(0xFFF4FDFA),
                            value: _selectedPermissionType,
                            items: _permissionTypes.map((type) {
                              return DropdownMenuItem<String>(
                                value: type['value'],
                                child: Text(
                                  type['label'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF707070),
                                  ),
                                ),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              hintText: 'Pilih Jenis Perizinan',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF707070),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF4FDFA),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedPermissionType = value;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Tanggal Mulai: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _startDateController,
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, _startDateController),
                            decoration: const InputDecoration(
                              hintText: 'Tanggal Mulai',
                              suffixIcon: Icon(Icons.calendar_month),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF707070),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF4FDFA),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Tanggal Selesai: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _endDateController,
                            readOnly: true,
                            onTap: () =>
                                _selectDate(context, _endDateController),
                            decoration: const InputDecoration(
                              hintText: 'Tanggal Selesai',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF707070),
                              ),
                              suffixIcon: Icon(Icons.calendar_month),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF4FDFA),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Keterangan Singkat: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _shortDescController,
                            decoration: const InputDecoration(
                              hintText: 'Contoh: Perjalanan Dinas',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF707070),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF4FDFA),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('Keterangan: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Keterangan',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF707070),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFF4FDFA),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text('File: ', style: labelStyle),
                              const SizedBox(height: 10),
                              const Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          // F5F5F5
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: _pickFile,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.cloud_upload,
                                        size: 50,
                                        color: _selectedFileName != null
                                            ? Colors.black
                                            : const Color(0xFF707070)),
                                    Text(
                                      _selectedFileName ??
                                          'Klik untuk memilih file',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: _selectedFileName != null
                                            ? Colors.black
                                            : const Color(0xFF707070),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_selectedPermissionType == null ||
                                    _startDateController.text.isEmpty ||
                                    _endDateController.text.isEmpty ||
                                    _shortDescController.text.isEmpty ||
                                    _descriptionController.text.isEmpty ||
                                    _selectedFileName == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Harap isi semua field yang wajib'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                _addPermission();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AuthStyles.primary2Color,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              child: const Text(
                                'Simpan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _shortDescController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
