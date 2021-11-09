import 'package:flutter/material.dart';
import 'package:flutter_bilibili/models/home_model.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight;
  final EdgeInsetsGeometry? padding;
  const HiBanner({
    Key? key,
    required this.bannerList,
    this.bannerHeight = 160,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding?.horizontal ?? 0) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      //指示器
      pagination: SwiperPagination(
        alignment: Alignment.bottomRight,
        margin: EdgeInsets.fromLTRB(0, 0, right, 10),
        builder: const DotSwiperPaginationBuilder(
          color: Colors.white60,
          size: 6,
          activeSize: 8,
        ),
      ),
    );
  }

  _image(BannerMo bannerMo) {
    return InkWell(
      onTap: () {
        print(bannerMo.title);
        handleBannerClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            bannerMo.cover ?? '',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

///banner点击跳转
void handleBannerClick(BannerMo bannerMo) {
  print(bannerMo.toJson());
  if (bannerMo.type == 'video') {
    HiNavigator.getInstance().onJumpTo(RouteStatus.detail, args: {"videoModel": VideoModel(vid: bannerMo.url)});
  } else {
    // HiNavigator.getInstance().openH5(bannerMo.url);
  }
}
