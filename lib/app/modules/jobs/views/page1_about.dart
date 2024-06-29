// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, unused_element
import 'package:flutter/material.dart';
import 'package:simag_app/app/modules/jobs/controllers/fetch_jobs_controller.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page1About extends StatelessWidget {
  // static const LatLng _pGooglePlex =
  //     LatLng(-8.164649818926275, 113.70408169949097);
  const Page1About({super.key});

  @override
  Widget build(BuildContext context) {
    final FetchJobsByIdController fetchController = Get.find();

    return Obx(() {
      if (fetchController.jobsModel.value.message.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        final job = fetchController.jobsModel.value.data;
        final kriteriaList = job.kriteria.split(',');
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Job Description",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  job.deskripsiPekerjaan,
                ),
                SizedBox(
                  height: 17,
                ),
                Text(
                  "Location",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Location : ${job.alamat}"),
                SizedBox(
                  height: 10,
                ),
                // SizedBox(
                //   height: 250,
                //   child: GoogleMap(
                //     mapType: MapType.normal,
                //     initialCameraPosition:
                //         CameraPosition(target: _pGooglePlex, zoom: 13),
                //     markers: {
                //       Marker(
                //           markerId: MarkerId("Current Location"),
                //           icon: BitmapDescriptor.defaultMarker,
                //           position: _pGooglePlex)
                //     },
                //   ),
                // ),
                SizedBox(
                  height: 17,
                ),
                Text(
                  "Criteria",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                for (var kriteria in kriteriaList)
                  _listFacilities(
                    title: kriteria,
                  ),
                // SizedBox(
                //   height: 75,
                // )
              ],
            ),
          ),
        );
      }
    });
  }
}

class _listFacilities extends StatelessWidget {
  final String title;

  const _listFacilities({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.circle, size: 8),
      title: Text(title, style: TextStyle(fontSize: 14)),
    );
  }
}
