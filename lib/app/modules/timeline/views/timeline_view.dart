import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simag_app/app/modules/timeline/controllers/fetch_jobs_controller.dart';

import '../controllers/timeline_controller.dart';

class TimelineView extends GetView<TimelineController> {
  const TimelineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FetchAlurMagangController fetchAlurMagangController =
        Get.put(FetchAlurMagangController());
    fetchAlurMagangController.fetchAlurMagang();
    // print(timelineController.alurMagangModel.value.data.dataAlurMagang.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Timeline",
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
      body: Obx(
        () {
          if (fetchAlurMagangController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (fetchAlurMagangController.alurMagangModel.value.data ==
              null)
            return Text("Kosong");
          else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressTrack(
                    data: fetchAlurMagangController
                        .alurMagangModel.value.data.dataAlurMagang?.idKelompok,
                    title: "Kelompok",
                    descriptionNull:
                        "Silahkan isi kelompokmu dengan menekan kotak ini",
                    descriptionNotNull: "Kelompok sudah terisi",
                    pageName: "my-team",
                  ),
                  ProgressTrack(
                    title: "Proposal Magang",
                    data: fetchAlurMagangController.alurMagangModel.value.data
                        .dataAlurMagang?.statusProposal,
                    descriptionNull: "Silahkan lengkapi proposal",
                    descriptionNotNull: "",
                    pageName: "apply-jobs",
                  ),
                  ProgressTrack(
                    data: fetchAlurMagangController.alurMagangModel.value.data
                        .dataAlurMagang?.suratBalasan,
                    title: "Surat Balasan",
                    descriptionNull:
                        "Silahkan upload surat balasan jika sudah ada",
                    descriptionNotNull:
                        "Surat balasan sudah diupload, menunggu surat pengantar",
                    pageName: "surat-balasan",
                  ),
                  ProgressTrack(
                    data: fetchAlurMagangController.alurMagangModel.value.data
                        .dataAlurMagang?.suratPengantar,
                    title: "Surat Pengantar",
                    descriptionNull: "Surat pengantar sedang diproses",
                    descriptionNotNull:
                        "Silahkan download surat pengantar magang",
                    pageName: "download-surat-pengantar",
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ProgressTrack extends StatelessWidget {
  final String title;
  final String descriptionNull;
  final String descriptionNotNull;
  final dynamic data;
  final String pageName;

  const ProgressTrack({
    Key? key,
    required this.title,
    required this.data,
    required this.descriptionNull,
    required this.descriptionNotNull,
    required this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FetchAlurMagangController fetchAlurMagangController = Get.find();
    TimelineController controller = Get.put(TimelineController());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(38, 0, 0, 0),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        onPressed: () {
          if (pageName == "download-surat-pengantar") {
            controller.downloadFile();
          } else {
            Get.toNamed(pageName);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data == null || data == 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Colors.grey, size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(descriptionNull),
                ],
              )
            else if (data == "belum ada")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Colors.grey, size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Silahkan upload proposal magang"),
                ],
              )
            else if (data == "menunggu konfirmasi")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Color.fromARGB(255, 173, 216, 230), size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Menunggu konfirmasi"),
                ],
              )
            else if (data == "revisi")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Color.fromARGB(255, 255, 223, 77), size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Terdapat revisi, silahkan upload kembali"),
                ],
              )
            else if (data == "ditolak")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Colors.red, size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "Proposal anda ditolak karena ${fetchAlurMagangController.alurMagangModel.value.data.dataAlurMagang?.alasanProposalDitolak}. Silahkan memilih tempat magang yang lain"),
                ],
              )
            else if (data == "diterima")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Color.fromARGB(255, 70, 116, 222), size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Selamat proposal anda diterima, silahkan lanjut ke proses selanjutnya"),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.check_circle_rounded,
                          color: Color.fromARGB(255, 70, 116, 222), size: 34),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(descriptionNotNull)
                ],
              )
          ],
        ),
      ),
    );
  }
}
