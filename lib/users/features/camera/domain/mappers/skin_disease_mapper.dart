// import '../entities/skin_detection_entity.dart';
// import '../entities/skin_disease_entity.dart';

// class SkinDiseaseMapper {
//   static SkinDiseaseEntity map(SkinDetectionEntity detection) {
//     final label = detection.rawLabel.toLowerCase();

//     // =========================
//     // JERAWAT
//     // =========================
//     if (label.contains('acne') ||
//         label.contains('pimple') ||
//         label.contains('zit')) {
//       return SkinDiseaseEntity(
//         diseaseName: 'Jerawat',
//         confidence: detection.confidence,
//         description:
//             'Jerawat adalah kondisi kulit yang terjadi akibat penyumbatan pori-pori oleh minyak dan sel kulit mati.',
//         suggestion:
//             'Jaga kebersihan wajah, hindari memencet jerawat, dan gunakan produk perawatan yang sesuai.',
//       );
//     }

//     // =========================
//     // DERMATITIS / IRITASI
//     // =========================
//     if (label.contains('rash') ||
//         label.contains('red') ||
//         label.contains('irritation')) {
//       return SkinDiseaseEntity(
//         diseaseName: 'Dermatitis / Iritasi',
//         confidence: detection.confidence,
//         description:
//             'Dermatitis merupakan peradangan kulit yang ditandai dengan kemerahan dan rasa gatal.',
//         suggestion:
//             'Hindari pemicu iritasi, gunakan pelembap, dan jaga kebersihan area kulit.',
//       );
//     }

//     // =========================
//     // PANU / JAMUR
//     // =========================
//     if (label.contains('fungal') ||
//         label.contains('tinea') ||
//         label.contains('white spot')) {
//       return SkinDiseaseEntity(
//         diseaseName: 'Infeksi Jamur (Panu)',
//         confidence: detection.confidence,
//         description:
//             'Panu adalah infeksi jamur pada kulit yang menyebabkan bercak putih atau kecoklatan.',
//         suggestion:
//             'Jaga kulit tetap kering dan bersih, serta gunakan produk antijamur bila diperlukan.',
//       );
//     }

//     // =========================
//     // NORMAL
//     // =========================
//     return SkinDiseaseEntity(
//       diseaseName: 'Kulit Normal',
//       confidence: detection.confidence,
//       description:
//           'Tidak ditemukan indikasi masalah kulit yang signifikan berdasarkan analisis gambar.',
//       suggestion:
//           'Tetap jaga kebersihan dan kesehatan kulit secara rutin.',
//     );
//   }
// }


import '../entities/skin_detection_entity.dart';
import '../entities/skin_disease_entity.dart';

class SkinDiseaseMapper {
  static SkinDiseaseEntity map(SkinDetectionEntity detection) {
    final label = detection.rawLabel.toLowerCase();
    final confidence = detection.confidence;

    switch (label) {

      // =========================
      // JERAWAT
      // =========================
      case 'acne':
        return SkinDiseaseEntity(
          diseaseName: 'Jerawat',
          confidence: confidence,
          description:
              'Jerawat adalah kondisi kulit akibat penyumbatan pori-pori oleh minyak dan sel kulit mati.',
          suggestion:
              'Jaga kebersihan wajah, hindari memencet jerawat, dan gunakan produk perawatan yang sesuai.',
        );

      // =========================
      // EKSIM / DERMATITIS
      // =========================
      case 'eczema':
      case 'dermatitis':
        return SkinDiseaseEntity(
          diseaseName: 'Eksim / Dermatitis',
          confidence: confidence,
          description:
              'Eksim adalah peradangan kulit yang ditandai dengan kemerahan, gatal, dan kulit kering.',
          suggestion:
              'Gunakan pelembap secara rutin dan hindari pemicu iritasi.',
        );

      // =========================
      // PSORIASIS
      // =========================
      case 'psoriasis':
        return SkinDiseaseEntity(
          diseaseName: 'Psoriasis',
          confidence: confidence,
          description:
              'Psoriasis adalah penyakit kulit kronis yang menyebabkan penebalan dan pengelupasan kulit.',
          suggestion:
              'Jaga kelembapan kulit dan konsultasikan ke tenaga medis jika gejala memburuk.',
        );

      // =========================
      // PANU / JAMUR
      // =========================
      case 'tinea':
      case 'fungal':
        return SkinDiseaseEntity(
          diseaseName: 'Infeksi Jamur (Panu)',
          confidence: confidence,
          description:
              'Infeksi jamur pada kulit yang menyebabkan bercak putih atau kemerahan.',
          suggestion:
              'Jaga kulit tetap kering dan bersih, serta gunakan produk antijamur.',
        );

      // =========================
      // KULIT NORMAL
      // =========================
      case 'normal':
        return SkinDiseaseEntity(
          diseaseName: 'Kulit Normal',
          confidence: confidence,
          description:
              'Tidak ditemukan indikasi penyakit kulit berdasarkan analisis gambar.',
          suggestion:
              'Pertahankan kebersihan dan perawatan kulit secara rutin.',
        );

      // =========================
      // TIDAK DIKENALI
      // =========================
      default:
        return SkinDiseaseEntity(
          diseaseName: 'Tidak dapat diidentifikasi',
          confidence: confidence,
          description:
              'Hasil analisis belum dapat menentukan kondisi kulit secara pasti.',
          suggestion:
              'Silakan ambil foto ulang dengan pencahayaan yang lebih baik.',
        );
    }
  }
}
