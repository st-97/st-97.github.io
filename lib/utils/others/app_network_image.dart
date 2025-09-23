import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portfolio/utils/constants/app_constants.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(
      {super.key,
      this.url = '',
      this.fileImage,
      this.assetPath = '',
      this.isRound,
      this.fit = BoxFit.contain,
      this.width,
      this.height,
      this.showBorder = false,
      this.background = Colors.transparent,
      this.borderColor = Colors.transparent,
      this.borderRadius = 10,
      this.borderWidth = 2});

  final String url;
  final File? fileImage;
  final String assetPath;
  final bool? isRound;
  final bool showBorder;
  final double borderWidth;
  final Color background;
  final Color borderColor;
  final double borderRadius;

  final double? width;

  final double? height;
  final BoxFit fit;

  ImageProvider<Object> get imageProvider {
    return url.isNotEmpty
        ? CachedNetworkImageProvider(url) as ImageProvider<Object>
        : NetworkImage(AppConstants.placeHolderImage) as ImageProvider<Object>;
  }

  @override
  Widget build(BuildContext context) {
    return url.isNotEmpty
        ? GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => FullImageScreen(imageUrl: url),
              );
            },
            child: CachedNetworkImage(
              width: width ?? 0.12.sh,
              height: height ?? 0.12.sh,
              imageUrl: url,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    color: background,
                    shape:
                        isRound == true ? BoxShape.circle : BoxShape.rectangle,
                    border: (showBorder && isRound == false)
                        ? Border.all(width: borderWidth, color: borderColor)
                        : null,
                    borderRadius: isRound == true
                        ? null
                        : BorderRadius.circular(borderRadius).r,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: fit,
                    ),
                  ),
                );
              },
              placeholder: (BuildContext context, String url) {
                return Center(
                  child: Container(
                    height: 15.h,
                    width: 15.h,
                    // width: width ?? 0.12.sh,
                    // height: height ?? 0.12.sh,
                    decoration: BoxDecoration(
                      border: (showBorder && isRound == false)
                          ? Border.all(width: borderWidth, color: borderColor)
                          : null,
                      borderRadius: isRound == true
                          ? null
                          : BorderRadius.circular(borderRadius).r,
                      shape: isRound == true
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                    ),
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 2.0,
                    ),
                  ),
                );
              },
              errorWidget: (BuildContext context, String url, dynamic error) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    border: (showBorder && isRound == false)
                        ? Border.all(width: borderWidth, color: borderColor)
                        : null,
                    borderRadius: isRound == true
                        ? null
                        : BorderRadius.circular(borderRadius).r,
                    shape:
                        isRound == true ? BoxShape.circle : BoxShape.rectangle,
                  ),
                  child: Image.network(
                    AppConstants.placeHolderImage,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          )
        : fileImage != null
            ? Container(
                width: width ?? 0.3.sw,
                height: height ?? 0.12.sh,
                decoration: BoxDecoration(
                  color: background,
                  border: showBorder
                      ? Border.all(width: borderWidth, color: borderColor)
                      : null,
                  borderRadius: isRound == false
                      ? BorderRadius.circular(borderRadius).r
                      : null,
                  shape: isRound == true
                      ? BoxShape.circle
                      : BoxShape.rectangle, // Set shape based on isRound
                  image: DecorationImage(
                    image: FileImage(fileImage!),
                    fit: fit,
                  ),
                ),
              )
            : Container(
                width: width ?? 0.3.sw,
                height: height ?? 0.12.sh,
                decoration: BoxDecoration(
                  color: background,
                  border: (showBorder && isRound == false)
                      ? Border.all(width: borderWidth, color: borderColor)
                      : null,
                  borderRadius: isRound == true
                      ? null
                      : BorderRadius.circular(borderRadius).r,
                  shape: isRound == true
                      ? BoxShape.circle
                      : BoxShape.rectangle, // Set shape based on isRound
                  image: DecorationImage(
                    image: NetworkImage(AppConstants.placeHolderImage),
                    fit: fit,
                  ),
                ),
              );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  FullImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Transparent container to detect taps on the black background
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color:
                Colors.black.withOpacity(0.5), // Black background with opacity
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              // Prevent the image tap from dismissing the screen
            },
            child: Image.network(
              imageUrl,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // Image has finished loading
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
