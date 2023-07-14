import 'package:flutter/cupertino.dart';

class CollectPage extends StatefulWidget {
  const CollectPage({super.key});

  @override
  State<CollectPage> createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doPost();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void doPost() async {

  }
}
