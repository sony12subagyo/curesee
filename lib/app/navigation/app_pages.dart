import 'package:flutter/material.dart';
import 'package:curesee/users/features/beranda/presentation/pages/beranda_page.dart';
import 'package:curesee/users/features/profile/presentation/pages/profil_page.dart';
import 'package:curesee/users/features/camera/presentation/pages/camera_page.dart';
import 'package:curesee/users/features/history/presentation/pages/history_page.dart';
import 'package:curesee/users/features/more/presentation/pages/more_page.dart';

class AppPages {
  static final pages = <Widget>[
    BerandaPage(),
    ProfilPage(),
    CameraPage(),
    HistoryPage(),
    MorePage(),
  ];
}
