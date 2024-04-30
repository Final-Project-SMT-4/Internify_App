import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jobs_controller.dart';

class JobsView extends GetView<JobsController> {
  const JobsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TaskView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
