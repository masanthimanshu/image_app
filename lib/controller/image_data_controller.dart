import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_sample/model/image_data_model.dart';
import 'package:image_sample/network/requests.dart';

final getImageData = FutureProvider.family((ref, Map<String, dynamic> data) {
  return ImageDataController().postData(
    url: data["url"],
    body: data["body"],
  );
});

class ImageDataController {
  Future<ImageDataModel?> postData({
    required String url,
    required Object body,
  }) async {
    final data = await APIRequests().imageRequest(
      url: url,
      payload: body,
    );

    if (data != null) return imageDataModelFromJson(data);
    return null;
  }
}
