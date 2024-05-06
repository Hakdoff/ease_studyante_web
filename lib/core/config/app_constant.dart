import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const appName = 'EaseStudyante';

  // DEPLOYED ENV
  static const clientId = 'yseOBLsAqKeLTRSFR0L2KFJORZyFRQXQDDX8FOdx';
  static const clientSecret =
      'nZ4Ct3m7ZsqsPGAftgz6HaaqVGlZZPaWYlVkKlJmbqsIVtTQtT4OFeEw4M4IJCyA0u5WlTVriFDC55GjBYimIXiFxgxgcvL8z1RYdmN8pRVgVUojFe2DpWp6mQ6AFBCP';
  static const serverUrl = 'https://easestudyante.onrender.com';
  static const serverHost = 'easestudyante.onrender.com';

  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
}
