// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:salesappnew/bloc/customer/customer_bloc.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'package:salesappnew/widgets/back_button_custom.dart';
import 'package:maps_launcher/maps_launcher.dart';

class CustomerFormScreen extends StatelessWidget {
  String id;
  CustomerFormScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    void openMaps(double latitude, double longitude) async {
      bool? launched =
          await MapsLauncher.launchCoordinates(latitude, longitude);

      if (!launched) {
        print("Google Maps tidak dapat dibuka.");
      }
    }

    return BlocProvider(
      create: (context) => CustomerBloc()
        ..add(
          ShowCustomer(id),
        ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFFE6212A),
          title: BlocBuilder<CustomerBloc, CustomerState>(
            builder: (context, state) {
              if (state is CustomerIsLoading) {
                return const Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }
              if (state is CustomerShowLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButtonCustom(),
                    const Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          size: 17,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            "Customer List",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<CustomerBloc>(context).add(
                              ShowCustomer(id),
                            );
                          },
                          icon: const Icon(
                            Icons.refresh,
                            color: Color.fromARGB(255, 121, 8, 14),
                          ),
                        ),
                        // Visibility(
                        //   visible: state.workflow.isNotEmpty,
                        //   child: PopupMenuButton(
                        //     padding: const EdgeInsets.all(0),
                        //     icon: const Icon(
                        //       Icons.more_vert,
                        //       color: Color.fromARGB(255, 121, 8, 14),
                        //     ),
                        //     itemBuilder: (context) {
                        //       return state.workflow.map((item) {
                        //         return PopupMenuItem(
                        //           child: InkWell(
                        //             onTap: () async {
                        //               Get.back();
                        //               // BlocProvider.of<InvoiceBloc>(context).add(
                        //               //   ChangeWorkflow(
                        //               //       id: id, nextStateId: item.nextState.id),
                        //               // );
                        //             },
                        //             child: Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 10, vertical: 10),
                        //               child: Text(item['action']),
                        //             ),
                        //           ),
                        //         );
                        //       }).toList();
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButtonCustom(),
                  const Text(
                    "Customer List",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CustomerBloc>(context).add(
                        ShowCustomer(id),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh,
                      color: Color.fromARGB(255, 121, 8, 14),
                    ),
                  ),
                ],
              );
            },
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CustomerShowLoaded) {
              return Column(
                children: [
                  Container(
                    width: Get.width,
                    constraints: const BoxConstraints(
                      maxHeight: double.infinity,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 215, 28, 38),
                      border: Border(
                          bottom: BorderSide(
                              color: Color.fromARGB(
                                255,
                                215,
                                28,
                                38,
                              ),
                              width: 1)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: Text(
                            textAlign: TextAlign.center,
                            '${state.data.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                            top: 20,
                            bottom: 10,
                          ),
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.33),
                              1: FractionColumnWidth(0.07),
                              2: FractionColumnWidth(0.6),
                            },
                            // border: TableBorder.all(),
                            children: [
                              buildRow(['Type', ':', '${state.data.type}']),
                              buildRow([
                                'Group',
                                ':',
                                '${state.data.customerGroup?.name}'
                              ]),
                              buildRow([
                                'Branch',
                                ':',
                                '${state.data.branch?.name}'
                              ]),
                              buildRow(
                                [
                                  'Address',
                                  ':',
                                  '${state.data.address != "undefined" && state.data.address != null ? state.data.address : ""}'
                                ],
                              ),
                              buildRow([
                                'Status',
                                ':',
                                (state.data.status == "1"
                                    ? "Active"
                                    : "Disabled")
                              ]),
                              buildRow([
                                'Workflow State',
                                ':',
                                '${state.data.workflowState}'
                              ]),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: state.data.location?.coordinates != null &&
                              state.data.location!.coordinates?.length == 2,
                          child: ElevatedButton(
                            onPressed: () async {
                              openMaps(
                                state.data.location!.coordinates![1],
                                state.data.location!.coordinates![0],
                              );
                            },
                            child: const Text(
                              "Open Google Maps",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Expanded(
                  //   child: Container(
                  //     width: Get.width * 0.9,
                  //     height: 255,
                  //     decoration: const BoxDecoration(
                  //       color: Colors.black,
                  //       borderRadius: BorderRadius.all(Radius.circular(8)),
                  //     ),
                  //     child: state.data.img != null && state.data.img != ""
                  //         ? InkWell(
                  //             onTap: () async {
                  //               // await showDialog(
                  //               //   context: context,
                  //               //   builder: (BuildContext dialogContext) =>
                  //               //       SizedBox(
                  //               //     width: Get.width,
                  //               //     height: Get.height,
                  //               //     child: PhotoView(
                  //               //       imageProvider: NetworkImage(
                  //               //         'https://${state.erpUrl != null && state.erpUrl != "" ? "${state.erpUrl}" : ""}${state.data.image}',
                  //               //       ),
                  //               //     ),
                  //               //   ),
                  //               // );
                  //             },
                  //             child: Image.network(
                  //               'https://${state.erpUrl != null && state.erpUrl != "" ? "${state.erpUrl}" : ""}${state.data.img}',
                  //             ),
                  //           )
                  //         : Image.asset(
                  //             "assets/images/noimage.jpg",
                  //           ),
                  //   ),
                  // ),
                  Expanded(
                    child: FutureBuilder<dynamic>(
                      future: LocalData().getData("url"),
                      builder: (context, snapshot) {
                        String baseUrl = snapshot.data ?? "";
                        String imageUrl =
                            '${baseUrl.isNotEmpty ? baseUrl : ""}public/customer/${state.data.img}';
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return Container(
                          width: Get.width * 0.9,
                          height: 255,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: state.data.img != null && state.data.img != ""
                              ? InkWell(
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext dialogContext) =>
                                          SizedBox(
                                        width: Get.width,
                                        height: Get.height,
                                        child: PhotoView(
                                          imageProvider: NetworkImage(imageUrl),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Image.network(imageUrl,
                                      fit: BoxFit.cover),
                                )
                              : Image.asset("assets/images/noimage.jpg"),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  state is CustomerIsFailure ? state.error : "No Data",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign:
                      TextAlign.center, // Menyebabkan teks menjadi rata tengah
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

TableRow buildRow(List<String> cells) => TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Text(
            cell,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
