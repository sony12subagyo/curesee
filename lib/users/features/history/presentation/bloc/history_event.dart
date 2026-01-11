abstract class HistoryEvent {}

class LoadHistoryEvent extends HistoryEvent {}

class LoadDetailScanEvent extends HistoryEvent {
  final String id;
  LoadDetailScanEvent(this.id);
}

class DeleteScanEvent extends HistoryEvent {
  final String id;
  DeleteScanEvent(this.id);
}

// ==========================
// SAVE SCAN (INI YANG KURANG)
// ==========================
class SaveScanEvent extends HistoryEvent {
  final String imagePath;
  final String label;
  final double confidence;

  SaveScanEvent({
    required this.imagePath,
    required this.label,
    required this.confidence,
  });
}
