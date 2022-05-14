import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:together_with_firebase/src/controllers/file_controller.dart';

class FilePieChartThumbnail extends GetView<FileController> {
  const FilePieChartThumbnail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PieChart(
          colorList: controller.folderColorList,
          dataMap: controller.folderMap,
          chartType: ChartType.ring,
          chartRadius: Get.width * 0.2,
          ringStrokeWidth: 4,
          chartValuesOptions: const ChartValuesOptions(
              chartValueBackgroundColor: Colors.transparent,
              showChartValuesInPercentage: true),
          legendOptions: const LegendOptions(showLegends: false),
        ),
        SizedBox(
          width: Get.width * 0.1,
        ),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  controller.folders.length,
                  (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 6,
                              backgroundColor: controller.folders[index].color
                                  .withOpacity(0.6),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                controller.folders[index].fileMap.keys.first,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            ),
                            Text(
                              controller.folders[index].folderSize
                                      .toStringAsFixed(0) +
                                  " Files",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ))),
        )
      ],
    );
  }
}
