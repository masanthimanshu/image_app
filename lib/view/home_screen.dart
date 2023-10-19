import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_sample/controller/image_data_controller.dart';
import 'package:image_sample/network/endpoints.dart';
import 'package:image_sample/view/details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _offset = 0;

  Map<String, dynamic> _apiData = {
    "url": APIEndpoints().imageData,
    "body": {"user_id": "108", "offset": "0"},
  };

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(getImageData(_apiData));

    return Scaffold(
      body: res.hasValue
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: res.value!.images.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (e, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailsScreen(
                                imgUrl: res.value!.images[index].xtImage,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(
                            height: 225,
                            fit: BoxFit.contain,
                            res.value!.images[index].xtImage,
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _offset++;
                        _apiData = {
                          "url": APIEndpoints().imageData,
                          "body": {
                            "user_id": "108",
                            "offset": _offset.toString(),
                          },
                        };
                      });
                    },
                    child: const Text("Load More"),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
