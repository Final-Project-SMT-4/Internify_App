import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simag_app/app/modules/timeline/controllers/post_jobs_controller.dart';
import 'package:simag_app/app/modules/timeline/controllers/timeline_controller.dart';

class SuratBalasan extends GetView<TimelineController> {
  const SuratBalasan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    @override
    final TimelineController controller = Get.put(TimelineController());
    final PostJobsController postController = Get.put(PostJobsController());

    void _submit() {
      if (controller.validate()) {
        postController.filepath = controller.selectedFile.value!.path!;
        postController.postResponseLetter();
        print("Form valid and submitted");
      } else {
        if (controller.selectedFile.value == null) {
          Get.snackbar(
            "Error",
            "File Is Required",
            animationDuration: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 1650),
            backgroundColor: Colors.red,
            colorText: Colors.white,
            borderWidth: 5.0,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(20.0),
            icon: const Icon(CupertinoIcons.info_circle),
          );
        }
        print("Form not valid");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Response Letter",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 72, 71, 156),
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17),
            const Text(
              "Upload Response Letter",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Add your response letter",
            ),
            const SizedBox(
              height: 17,
            ),
            Obx(
              () => controller.selectedFile.value == null
                  ? SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => controller.pickFile(),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload_file,
                                color: Colors.grey.shade700),
                            const SizedBox(width: 8.0),
                            Text(
                              'Upload Letter',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.picture_as_pdf, color: Colors.red),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              controller.selectedFile.value!.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '${(controller.selectedFile.value!.size / 1024).toStringAsFixed(1)} Kb',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 8.0),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: controller.removeFile,
                          ),
                        ],
                      ),
                    ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 22),
        color: Colors.white,
        height: 78,
        child: TextButton(
          onPressed: _submit,
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(
              Color.fromARGB(255, 70, 116, 222),
            ),
          ),
          child: const Text(
            "Send Letter",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
