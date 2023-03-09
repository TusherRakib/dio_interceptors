import 'package:get/get.dart';
import 'api_provider.dart';
import 'collections_model.dart';

class HomeController extends GetxController {

  RxList<Collections> sellCollections = <Collections>[].obs;
  RxBool collectionDataLoading = false.obs;


  @override
  void onReady() {
    super.onReady();
    getHomeCollectionList();
  }

  void getHomeCollectionList() async {
    collectionDataLoading.value = true;
    CollectionListModel? sellCollectionListModel = await getCollectionListApi(2,1);

    if (sellCollectionListModel?.success ?? false) {
      if (sellCollectionListModel?.data != null) {
        sellCollections.value = sellCollectionListModel!.data!;
      }
      collectionDataLoading.value = false;
    }else{
      collectionDataLoading.value = false;
    }
  }
}