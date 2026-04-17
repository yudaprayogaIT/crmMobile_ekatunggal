// ignore_for_file: unused_local_variable, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ekareach/bloc/user/user_bloc.dart';
import 'package:ekareach/models/user_model.dart';
import 'package:ekareach/screens/user/user_setting.dart';
import 'package:ekareach/utils/local_data.dart';

class ProfilePicture extends StatelessWidget {
  UserModel data;
  ProfilePicture({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.amber,
                  ],
                ),
              ),
            ),
            Visibility(
              visible: data.img != null,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: FutureBuilder<dynamic>(
                  future: LocalData().getData("url"), // Fungsi async
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Menampilkan loader saat data sedang dimuat
                      return Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(), // Loader
                        ),
                      );
                    } else if (snapshot.hasError || !snapshot.hasData) {
                      // Menangani error atau data kosong
                      return Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: const Icon(
                          Icons.error, // Ikon error
                          size: 30,
                          color: Colors.red,
                        ),
                      );
                    } else {
                      // Data berhasil dimuat
                      final url = snapshot.data!;

                      return Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Colors.grey[300],
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                          image: data.img != null && data.img!.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(
                                    "${url}images/users/${data.img}",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: data.img == null || data.img!.isEmpty
                            ? const Icon(
                                Icons.person, // Placeholder jika gambar kosong
                                size: 30,
                                color: Colors.grey,
                              )
                            : null,
                      );
                    }
                  },
                ),
              ),
            ),
            Visibility(
              visible: data.img == null,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/icons/profile.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey[300],
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "@${data.username}",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  Get.back();
                  Navigator.of(context).push(
                    MaterialPageRoute<UserSetting>(
                      builder: (_) =>
                          UserSetting(bloc: BlocProvider.of<UserBloc>(context)),
                    ),
                  );
                },
                icon: Icon(
                  Icons.settings,
                  size: 20,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
