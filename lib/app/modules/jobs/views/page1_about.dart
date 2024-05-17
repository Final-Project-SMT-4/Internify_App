// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class Page1About extends StatelessWidget {
  // static const LatLng _pGooglePlex =
  //     LatLng(-8.164649818926275, 113.70408169949097);
  const Page1About({super.key});

  @override
  Widget build(BuildContext context) {
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
              "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit repellendus fugit quis voluptatem mollitia deleniti ut architecto dolore, illum in debitis sequi nesciunt, blanditiis quae a recusandae. Dolores, expedita dolor.",
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
            Text(
                "Location : Komplek Pertokoan Sawojajar Jalan Danau Toba Blok C22, Sawojajar, Kec. Kedungkandang, Kota Malang, Jawa Timur 56138"),
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
              "Facilities and Others",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            _listFacilities(
              title: "Medical",
            ),
            _listFacilities(
              title: "Dental",
            ),
            _listFacilities(
              title: "Technical Certification",
            ),
            _listFacilities(
              title: "Meal Allowance",
            ),
            _listFacilities(
              title: "Transport Allowance",
            ),
            _listFacilities(
              title: "Regular Hours",
            ),
            _listFacilities(
              title: "Mondays-Fridays",
            ),
            SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
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
