import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 1626,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Color(0xFFEBEDEF)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 360,
            height: 24,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 24,
                    decoration: const BoxDecoration(color: Color(0xFFE9ECEF)),
                  ),
                ),
                Positioned(
                  left: 306,
                  top: 7,
                  child: Container(
                    width: 46,
                    height: 10,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/46x10"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 360,
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 101, vertical: 14),
            decoration: const BoxDecoration(color: Color(0xFFFAFAFA)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 0.50, color: Color(0xFFDEE2E6)),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '1',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFADB5BD),
                                          fontSize: 14,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 0.50, color: Color(0xFFDEE2E6)),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '2',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFADB5BD),
                                          fontSize: 14,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF017BFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '3',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFF8F9FA),
                                          fontSize: 14,
                                          fontFamily: 'Plus Jakarta Sans',
                                          fontWeight: FontWeight.w500,
                                          height: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              'Result',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF111314),
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w500,
                                height: 21,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1470,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 360,
                  height: 360,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 360,
                          height: 360,
                          decoration: const BoxDecoration(color: Color(0xFFFF7287)),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 360,
                          height: 360,
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 82.17,
                                top: 89,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..translate(0.0, 0.0)
                                    ..rotateZ(0.14),
                                  child: Container(
                                    width: 168,
                                    height: 224,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF7544DE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 285.92,
                                top: 160,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..translate(0.0, 0.0)
                                    ..rotateZ(0.13),
                                  child: Container(
                                    width: 4,
                                    height: 7,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF111314),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11.11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 261.32,
                                top: 155.50,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..translate(0.0, 0.0)
                                    ..rotateZ(0.13),
                                  child: Container(
                                    width: 4,
                                    height: 7,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF111314),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(11.11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 248,
                                top: 150.56,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(width: 2, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 276,
                                top: 154,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(width: 2, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 255,
                                top: 268,
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF7384E7),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 289,
                                top: 311,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF7384E7),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 307,
                                top: 316,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFF7384E7),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 28,
                        top: 24,
                        child: SizedBox(
                          width: 304,
                          child: Text(
                            'Conductive Hearing Loss or Sensorineural Hearing Loss (SNHL)',
                            style: TextStyle(
                              color: Color(0xFF111314),
                              fontSize: 24,
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w700,
                              height: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 285,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 88,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 3.53,
                                          top: -1.48,
                                          child: Transform(
                                            transform: Matrix4.identity()
                                              ..translate(0.0, 0.0)
                                              ..rotateZ(0.26),
                                            child: SizedBox(
                                              width: 17.11,
                                              height: 18.60,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: -2.26,
                                                    top: 8.45,
                                                    child: Transform(
                                                      transform: Matrix4.identity()
                                                        ..translate(0.0, 0.0)
                                                        ..rotateZ(0.26),
                                                      child: Container(
                                                        width: 4.17,
                                                        height: 4.17,
                                                        decoration: const ShapeDecoration(
                                                          color: Color(0xFFADB5BD),
                                                          shape: OvalBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: -1.68,
                                                    top: 9.47,
                                                    child: Transform(
                                                      transform: Matrix4.identity()
                                                        ..translate(0.0, 0.0)
                                                        ..rotateZ(0.26),
                                                      child: Container(
                                                        width: 2.50,
                                                        height: 2.50,
                                                        decoration: const ShapeDecoration(
                                                          color: Color(0xFF111314),
                                                          shape: OvalBorder(),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'What it is',
                                    style: TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Hearing loss due to problems in the ear\'s ability to conduct sound waves or damage to the auditory nerve',
                                style: TextStyle(
                                  color: Color(0xFF212529),
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 105,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0.83,
                                          top: 13.33,
                                          child: Container(
                                            width: 18.33,
                                            height: 5.83,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF111314),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 12.50,
                                          top: 6.67,
                                          child: Container(
                                            width: 2.50,
                                            height: 4.17,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Is it serious?',
                                    style: TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 320,
                                    height: 12,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: const BoxDecoration(color: Color(0xFFDEE2E6)),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: const BoxDecoration(color: Color(0xFFDEE2E6)),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Container(
                                            height: double.infinity,
                                            decoration: const BoxDecoration(color: Color(0xFFDE1936)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const SizedBox(
                                    width: 320,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              'Healthy',
                                              style: TextStyle(
                                                color: Color(0xFF212529),
                                                fontSize: 10,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w600,
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              'Caution',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFF212529),
                                                fontSize: 10,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w600,
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Expanded(
                                          child: SizedBox(
                                            child: Text(
                                              'Serious',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xFF212529),
                                                fontSize: 10,
                                                fontFamily: 'Plus Jakarta Sans',
                                                fontWeight: FontWeight.w600,
                                                height: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Serious, as it affects hearing',
                                style: TextStyle(
                                  color: Color(0xFF212529),
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 312,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 67,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    child: const Stack(
                                      children: [
                                        Positioned(
                                          left: 1.90,
                                          top: 1.90,
                                          child: SizedBox(
                                            width: 16.20,
                                            height: 16.20,
                                            child: Stack(children: []),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Usual treatment',
                                    style: TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(
                              width: 320,
                              child: Text(
                                'Treatment may involve hearing aids, cochlear implants, or surgery depending on the cause',
                                style: TextStyle(
                                  color: Color(0xFF212529),
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 153,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 13.75,
                                          top: -2.08,
                                          child: Transform(
                                            transform: Matrix4.identity()
                                              ..translate(0.0, 0.0)
                                              ..rotateZ(0.79),
                                            child: const SizedBox(
                                              width: 11.67,
                                              height: 22.50,
                                              child: Stack(children: []),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Medications',
                                    style: TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const SizedBox(
                              width: 320,
                              child: Text(
                                'Pain relievers and antibiotics if necessary',
                                style: TextStyle(
                                  color: Color(0xFF212529),
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 21,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 72,
                                          height: 72,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 72,
                                                  height: 72,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFEBEDEF),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(80),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 20,
                                                top: 20,
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 30.67,
                                                        top: 1.33,
                                                        child: Transform(
                                                          transform: Matrix4.identity()
                                                            ..translate(0.0, 0.0)
                                                            ..rotateZ(3.14),
                                                          child: const SizedBox(
                                                            width: 29.33,
                                                            height: 29.33,
                                                            child: Stack(children: []),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Pain relievers',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF111314),
                                              fontSize: 10,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 72,
                                          height: 72,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                left: 0,
                                                top: 0,
                                                child: Container(
                                                  width: 72,
                                                  height: 72,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(0xFFEBEDEF),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(80),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                left: 20,
                                                top: 20,
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 22,
                                                        top: -3.33,
                                                        child: Transform(
                                                          transform: Matrix4.identity()
                                                            ..translate(0.0, 0.0)
                                                            ..rotateZ(0.79),
                                                          child: const SizedBox(
                                                            width: 18.67,
                                                            height: 36,
                                                            child: Stack(children: []),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Antibiotics',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF111314),
                                              fontSize: 10,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 295,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 40,
                  ),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 235,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Stack(children: []),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'MediGenie\'s insight',
                                    style: TextStyle(
                                      color: Color(0xFF212529),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'You\'re experiencing hearing loss, either due to problems in how your ear conducts sound waves or damage to the nerve that carries sound signals to your brain. This can impact your daily life significantly. Depending on the cause, treatment could involve hearing aids, cochlear implants, or surgery. To prevent hearing loss, avoid exposure to loud noises, and seek immediate medical help if you have an ear infection.',
                                style: TextStyle(
                                  color: Color(0xFF111314),
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 21,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 64,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    clipBehavior: Clip.antiAlias,
                                    child: const Stack(children: []),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'PLEASE BE ADVISED',
                                    style: TextStyle(
                                      color: Color(0xFFDE1936),
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w700,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const SizedBox(
                              width: 24,
                              height: 24,
                              child: Stack(children: []),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 24,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 24,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://via.placeholder.com/28x28"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Powered by AI Technology Developed at\nYonsei School of Medicine',
                        style: TextStyle(
                          color: Color(0xFF111314),
                          fontSize: 10,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w600,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 360,
                  height: 40,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 360,
                        height: 40,
                        decoration: const BoxDecoration(color: Color(0x00FF6870)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 360,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0x00F8F9FA), Color(0xFFF8F9FA)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 24,
                  child: SizedBox(
                    width: 320,
                    height: 56,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 320,
                            height: 56,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF017BFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        const Positioned(
                          left: 0,
                          top: 0,
                          child: SizedBox(
                            width: 320,
                            height: 56,
                            child: Text(
                              'Done',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF8F9FA),
                                fontSize: 16,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w500,
                                height: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
