import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const colorDark = Color(0xff171620);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd1bcc9),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const PlayerDisc(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.only(bottom: 80),
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                'https://picsum.photos/40',
                              ),
                            ),
                            title: const Text('Congratulations'),
                            subtitle: const Text('Post malone tf. Quavo'),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrd exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MyAppBar(),
            ),
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ContainerBottom(),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerDisc extends HookWidget {
  const PlayerDisc({super.key});

  @override
  Widget build(BuildContext context) {
    final headerCollapse = useState(false);
    final hcValue = headerCollapse.value;
    final sw = MediaQuery.of(context).size.width;
    final hw = hcValue ? sw : sw - 120;
    final hh = hcValue ? 48.0 : 150.0;
    final hPaddingTop = hcValue ? 12.0 : 90.0;
    return GestureDetector(
      onVerticalDragUpdate: (dt) {
        if (dt.delta.dy < -9) {
          headerCollapse.value = true;
        } else {
          headerCollapse.value = false;
        }
      },
      child: Container(
        color: colorDark,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: hw,
              decoration: BoxDecoration(
                color: const Color(0xffd1bcc9),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(hh - 8),
                ),
              ),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 16, top: hPaddingTop),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: hh,
                height: hh,
                child: const AnimatedDisc(),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Slider(
                          value: 0.2,
                          onChanged: (_) {},
                          activeColor: Colors.white,
                          thumbColor: Colors.white,
                          inactiveColor: Colors.white70,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Opacity(
                            opacity: 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('00:30'),
                                Text('02:40'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shuffle),
                  ),
                ],
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  headerCollapse.value = !hcValue;
                },
                child: const HLine(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.home),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.download),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class ContainerBottom extends HookWidget {
  const ContainerBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final open = useState(false);
    final oValue = open.value;
    const tItems = 4;
    const wItem = 40.0;
    const mbItem = 32.0;
    const mbItemTotals = mbItem * tItems;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      // 30: vertical padding from AnimatedContainer
      height: open.value ? wItem * tItems + mbItemTotals + 30 : 80,
      decoration: const BoxDecoration(
        color: colorDark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () {
                open.value = !oValue;
              },
              child: const HLine(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 350),
              opacity: oValue ? 0 : 1,
              child: IconButton(
                onPressed: () {
                  open.value = !oValue;
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ),
          ...List.generate(
            tItems,
            (idx) => AnimatedPositioned(
              // 35: initial in open, 25 init in close
              top: oValue ? 35 + (wItem + mbItem) * idx : 25,
              // 20: left space, 0.75 widthFactor
              left: oValue ? 20 : 20 + (wItem * 0.75) * idx,
              duration: const Duration(milliseconds: 350),
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/${wItem.toInt()}?$idx',
                ),
              ),
            ),
          ),
          ...List.generate(
            tItems,
            (idx) => AnimatedPositioned(
              top: oValue
                  ? 22 + (wItem + mbItem) * idx
                  : mbItemTotals + (64 * idx),
              // padding l: 20, 10: space avatar & ListTile,
              left: oValue ? 20 + 10 + wItem : sw,
              duration: Duration(
                milliseconds: oValue
                    ? 400 + (tItems * 50) - (idx * 50)
                    : 400 + (idx * 50),
              ),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 350),
                opacity: oValue ? 1 : 0,
                child: Container(
                  // padding l: 20, 10: space avatar & ListTile, 20 padding r
                  width: sw - 20 - wItem - 10 - 20,
                  height: 64,
                  padding: const EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    gradient: const LinearGradient(
                      colors: [Color(0xff312f42), colorDark],
                    ),
                  ),
                  child: const ListTile(
                    visualDensity: VisualDensity.compact,
                    title: Text('Congratulations'),
                    subtitle: Opacity(
                      opacity: 0.75,
                      child: Text('Post Malone'),
                    ),
                    trailing: Icon(Icons.bar_chart),
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

class HLine extends StatelessWidget {
  const HLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 80,
          height: 3,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AnimatedDisc extends HookWidget {
  const AnimatedDisc({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = useAnimationController(
      duration: const Duration(seconds: 5),
    )
      ..forward()
      ..repeat();
    return RotationTransition(
      turns: ctrl,
      child: ClipOval(
        child: Image.network(
          'https://picsum.photos/150',
        ),
      ),
    );
  }
}
