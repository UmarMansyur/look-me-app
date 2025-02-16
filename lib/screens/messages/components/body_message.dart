// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:look_me/components/avatar.dart';
import 'package:look_me/network/api.dart';

class BodyMessage extends StatefulWidget {
  const BodyMessage({super.key});

  @override
  State<BodyMessage> createState() => _BodyMessageState();
}

class _BodyMessageState extends State<BodyMessage> {
  List<dynamic> _messages = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData([String? search]) async {
    final endpoint = search != null && search.isNotEmpty
        ? 'warning-letter/pegawai?search=$search'
        : 'warning-letter/pegawai';
    final response = await Api.getRequest(endpoint, true);
    setState(() {
      _messages = response?['data'] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // search produk
          TextField(
            controller: _searchController,
            cursorColor: Colors.black12,
            onChanged: (value) {
              _getData(value);
            },
            decoration: const InputDecoration(
              hintText: 'Cari',
              hintStyle: TextStyle(color: Colors.black12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              focusColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.black12),
              ),
              // icon sebelah kanan
              suffixIcon: Icon(Icons.search_sharp, color: Colors.grey),
              prefixStyle: TextStyle(color: Colors.black54),
              fillColor: Colors.white,
            ),
          ),
          // list pesan
          const SizedBox(height: 10),
          const Text(
            'Daftar Pesan',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.black26,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/detail-message',
                          arguments: _messages[index]['id']);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Avatar(
                          width: 50,
                          height: 50,
                          backgroundColor: Colors.grey,
                          imageUrl: _messages[index]['thumbnail'] ?? '',
                          radius: 25,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _messages[index]['username'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    _messages[index]['time_ago'] ?? '',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _messages[index]['message'] + '...',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  // jika belum di baca tampilkan icon bulat
                                  if (_messages[index]['is_read'] == false)
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF608384),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
