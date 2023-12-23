import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nasi_igut_han/components/about_us.dart';
import 'package:nasi_igut_han/components/app_bar.dart';
import 'package:nasi_igut_han/components/background.dart';
import 'package:nasi_igut_han/components/contact_us_form.dart';
import 'package:nasi_igut_han/components/drawer.dart';
import 'package:nasi_igut_han/components/faq.dart';
import 'package:nasi_igut_han/components/footer.dart';
import 'package:nasi_igut_han/components/products.dart';
import 'package:nasi_igut_han/providers/settings_provider.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  final ValueNotifier<bool> isShrink = ValueNotifier<bool>(false);

  _scrollListener() {
    isShrink.value = _scrollController.hasClients &&
        _scrollController.offset > (325 - kToolbarHeight);
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(settingsProvider.notifier).load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Stack(
            children: [
              const MyBackground(),
              GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Scaffold(
                  key: MyHomePage.scaffoldKey,
                  backgroundColor: Colors.transparent,
                  drawer: const MyDrawer(),
                  body: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        ValueListenableBuilder(
                            valueListenable: isShrink,
                            builder: (context, value, child) {
                              return MyAppBar(isShrink: value);
                            }),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              const MyAboutUs(),
                              const MyFAQ(),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                                  child: const Wrap(
                                    runSpacing: 30,
                                    children: [
                                      MyProducts(),
                                    ],
                                  ),
                                ),
                              ),
                              const MyContactUsForm(),
                              const MyFooter(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }
}
