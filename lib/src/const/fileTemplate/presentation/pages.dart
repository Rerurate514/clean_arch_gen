import 'package:clean_arch_gen/src/models/presentation/page.dart';

String createPages(Page page){
  return """
import 'package:flutter/material.dart';

class ${page.name}Page extends StatelessWidget {
  const ${page.name}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Placeholder()
      )
    );
  }
}

""";
}
