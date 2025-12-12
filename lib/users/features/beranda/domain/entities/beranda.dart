// beranda/domain/entities/beranda.dart
import 'package:equatable/equatable.dart';

class Beranda extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl; 
  final DateTime? createdAt; 

  const Beranda({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.createdAt,
  });


  Beranda copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return Beranda(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, createdAt];

  @override
  String toString() => 'Beranda(id: $id, title: $title)';
}
