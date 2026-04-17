import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ekareach/bloc/customer/customer_bloc.dart';
import 'package:ekareach/screens/customer/customer_form.dart';

class CustomerScreenBody extends StatefulWidget {
  final int status;
  final Color colorHeader;
  final Color colorFontHeader;

  const CustomerScreenBody({
    Key? key,
    required this.status,
    required this.colorHeader,
    required this.colorFontHeader,
  }) : super(key: key);

  @override
  State<CustomerScreenBody> createState() => __CustomerScreenBodyStateState();
}

class __CustomerScreenBodyStateState extends State<CustomerScreenBody> {
  Timer? _debounceTimer;
  late TextEditingController _textEditingController;
  late CustomerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<CustomerBloc>(context);

    _textEditingController = TextEditingController(text: bloc.search);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(GetAllCustomer(
        filters: [
          ["status", "=", "${widget.status}"]
        ],
        refresh: true,
        search: _textEditingController.text,
      ));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String searchText) {
    bloc.add(CustomerChangeSearch(searchText));

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 1), () {
      bloc.add(GetAllCustomer(
        filters: [
          ["status", "=", "${widget.status}"]
        ],
        refresh: true,
        search: searchText,
      ));
    });
  }

  void _clearSearchText() {
    bloc.add(CustomerChangeSearch(""));
    _textEditingController.text = "";
    bloc.add(GetAllCustomer(
      filters: [
        ["status", "=", "${widget.status}"]
      ],
      refresh: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        bloc.tabActive = widget.status;

        // if (state is ItemTokenExpired) {
        //   if (state.error ==
        //       "Forbiden, you have to login to access the data!") {
        //     BlocProvider.of<AuthBloc>(context).add(OnLogout());
        //   }
        // }
      },
      builder: (context, state) {
        if (state is CustomerIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CustomerIsLoaded) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                const SizedBox(height: 5),
                TextFormField(
                  controller: _textEditingController,
                  onChanged: _onSearchTextChanged,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: _clearSearchText,
                      icon: Visibility(
                        visible: bloc.search != "",
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 230, 228, 228),
                          width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 69, 69, 69), width: 2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      bloc.add(GetAllCustomer(
                        filters: [
                          ["status", "=", "${widget.status}"]
                        ],
                        refresh: true,
                        search: _textEditingController.text,
                      ));
                    },
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent &&
                            state.hasMore) {
                          state.IsloadingPage = true;
                          state.hasMore = false;
                          bloc.add(GetAllCustomer(
                            filters: [
                              ["status", "=", "${bloc.tabActive ?? 1}"]
                            ],
                            refresh: false,
                            search: _textEditingController.text,
                          ));
                        }
                        return false;
                      },
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Visibility(
                                  visible: state.data.isEmpty,
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 50),
                                    child: Center(
                                      child: Text(
                                        "Data not found",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: state.data.isNotEmpty,
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: state.data.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return CustomerFormScreen(
                                                    id: "${state.data[index].id}",
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          // trailing: Icon(
                                          //   Icons.sync_disabled,
                                          //   color: Colors.grey[400],
                                          //   size: 17,
                                          // ),
                                          // leading: CircleAvatar(
                                          //   backgroundColor: Colors.grey[200],
                                          //   child: state.data[index].img ==
                                          //               null ||
                                          //           state.data[index].img == ""
                                          //       ? Icon(
                                          //           Icons.now_wallpaper,
                                          //           color: Colors.grey[400],
                                          //         )
                                          //       : ClipOval(
                                          //           child: Image.network(
                                          //             'http://${bloc.url}${state.data[index].img}',
                                          //             width: 100,
                                          //             height: 100,
                                          //           ),
                                          //         ),
                                          // ),
                                          title:
                                              Text('${state.data[index].name}'),
                                          subtitle: Text(
                                              '${state.data[index].customerGroup.name}'),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: state.IsloadingPage,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 60),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.amber,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return const Center(
          child: Text(
            "Data Not Found!",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
