import 'package:base_project/utils/project_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  /// 1. block, 2. horizontal, 3. vertical, 4. grid, 5. list, 6. block horizontal, 7. circle
  final int type;
  final double itemHeight;
  final double itemWidth;

  const ShimmerPlaceholder({
    this.type = 1,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.block({
    this.type = 1,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.horizontal({
    this.type = 2,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.vertical({this.type = 3, this.itemHeight, this.itemWidth});

  ShimmerPlaceholder.grid({
    this.type = 4,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.list({
    this.type = 5,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.blockHorizontal({
    this.type = 6,
    this.itemHeight,
    this.itemWidth,
  });

  ShimmerPlaceholder.circle({
    this.type = 7,
    this.itemHeight,
    this.itemWidth,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 1:
        return ShimmerBlock(
          width: MediaQuery.of(context).size.width,
          height: itemHeight,
        );
        break;
      case 2:
        return ShimmerHorizontal();
        break;
      case 3:
        return ShimmerVertical();
        break;
      case 4:
        return ShimmerGrid();
        break;
      case 5:
        return ShimmerList();
        break;
      case 6:
        return ShimmerBlockHorizontal(
          itemHeight: itemHeight,
          itemWidth: itemWidth,
        );
      case 7:
        return ShimmerCircle(
          height: itemHeight,
          width: itemWidth,
        );
        break;
      default:
        return ShimmerBlock(width: MediaQuery.of(context).size.width);
    }
  }
}

class ShimmerBlockHorizontal extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;

  const ShimmerBlockHorizontal({Key key, this.itemWidth, this.itemHeight});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight ?? 100,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: Gap.s),
          child: ShimmerBlock(
            width: itemWidth ?? 100,
            height: itemHeight ?? 100,
          ),
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ShimmerHorizontal(),
        SizedBox(height: Gap.s),
        ShimmerHorizontal(),
        SizedBox(height: Gap.s),
        ShimmerHorizontal(),
        SizedBox(height: Gap.s),
        ShimmerHorizontal(),
      ],
    );
  }
}

class ShimmerGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: Gap.s,
      crossAxisSpacing: Gap.s,
      children: <Widget>[
        ShimmerVertical(),
        ShimmerVertical(),
        ShimmerVertical(),
        ShimmerVertical(),
      ],
    );
  }
}

class ShimmerVertical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(child: ShimmerBlock(width: MediaQuery.of(context).size.width)),
        SizedBox(height: Gap.s),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ShimmerText(),
            ShimmerText(),
            ShimmerText(isShorter: true),
          ],
        )
      ],
    );
  }
}

class ShimmerHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          ShimmerBlock(),
          SizedBox(width: Gap.s),
          Expanded(
              child: Column(
            children: <Widget>[
              ShimmerText(),
              ShimmerText(),
              ShimmerText(isShorter: true),
            ],
          ))
        ],
      ),
    );
  }
}

class ShimmerBlock extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerBlock({
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ProjectColor.shimmer,
      highlightColor: ProjectColor.shimmerHighlight,
      enabled: true,
      child: Container(
        width: width ?? 100,
        height: height ?? 100,
        color: ProjectColor.shimmer,
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  final bool isShorter;

  const ShimmerText({this.isShorter = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ProjectColor.shimmer,
      highlightColor: ProjectColor.shimmerHighlight,
      enabled: true,
      child: Container(
        height: 20,
        color: ProjectColor.main,
        margin: EdgeInsets.only(
          bottom: Gap.s,
          right: isShorter ? Gap.xl : Gap.zero,
        ),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerCircle({
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ProjectColor.shimmer,
      highlightColor: ProjectColor.shimmerHighlight,
      enabled: true,
      child: Container(
        width: width ?? 100,
        height: height ?? 100,
        decoration: BoxDecoration(
          color: ProjectColor.shimmer,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
