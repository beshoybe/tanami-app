import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:tanami_capital/core/theme/theme_extension.dart';

class PdfSheet extends StatelessWidget {
  final String url;
  final String? title;

  static Future<void> open(BuildContext context, String url, {String? title}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.appTheme.white,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (context) => PdfSheet._(url: url, title: title),
    );
  }

  const PdfSheet._({required this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appTheme.light,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close),
          ),

          Center(
            child: Text(
              title ?? 'PDF',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: PDF(
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              backgroundColor: context.appTheme.white,
            ).cachedFromUrl(
              url,
              placeholder:
                  (progress) => Center(
                    child: CircularProgressIndicator.adaptive(
                      value: progress,
                      valueColor: AlwaysStoppedAnimation(
                        context.appTheme.normal,
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
