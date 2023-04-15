import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whats_app_me/common/Wigets/custom_icon_button.dart';
import 'package:whats_app_me/common/extention/custom_Theme_extention.dart';

class imagepickerpage extends StatefulWidget {
  const imagepickerpage({super.key});

  @override
  State<imagepickerpage> createState() => _imagepickerpageState();
}

class _imagepickerpageState extends State<imagepickerpage> {
  List<Widget> imageList = [];
  int currentpage = 0;
  int? lastpage;

  handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent <= .33) return;
    if (currentpage == lastpage) return;
    fatchAllimages();
  }

  fatchAllimages() async {
    lastpage = currentpage;
    final permission = await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return PhotoManager.openSetting();

    List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      onlyAll: true,
    );

    List<AssetEntity> photos =
        await albums[0].getAssetListPaged(page: currentpage, size: 24);

    List<Widget> temp = [];

    for (var asset in photos) {
      temp.add(
        FutureBuilder(
            future: asset.thumbnailDataWithSize(
              ThumbnailSize(200, 200),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Navigator.pop(context, snapshot.data),
                    borderRadius: BorderRadius.circular(5),
                    splashFactory: NoSplash.splashFactory,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.theme.graycolor!.withOpacity(0.4),
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: MemoryImage(snapshot.data as Uint8List),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            }),
      );
    }
    setState(() {
      imageList.addAll(temp);
      currentpage++;
    });
  }

  @override
  void initState() {
    fatchAllimages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        //elevation: 0,
        leading: CustomIconButton(
          onTap: () => Navigator.pop(context),
          icon: Icons.arrow_back,
        ),
        title: Text(
          'WhatsApp',
          style: TextStyle(color: context.theme.authAppbarTextColor),
        ),
        actions: [CustomIconButton(onTap: () {}, icon: Icons.more_vert)],
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            handleScrollEvent(scroll);
            return true;
          },
          child: GridView.builder(
            itemCount: imageList.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (_, index) {
              return imageList[index];
            },
          ),
        ),
      ),
    );
  }
}
