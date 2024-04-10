enum NetworkType { wired, wireless }

// TODO:: RetriveState Enum for geting status of loading data in getx controller
enum RetrieveState { waiting, loading, success, error, empty }
// enum LoaderStyle {circle, normal,none}

enum ScanWifi { searching, stillSearching, shown, selected, empty }

// TODO:: Photoview Zoom direction
enum ZoomDirection { forward, backward }

// Alerts body

enum AlertBodyType {
  carrierSheet,
  outputPageSheet,
  dataTransfer,
  mergeDocuments,
  autoDetectColor,
  thresholdBlackWhite,
  exposureforColorandGray,
  colorDropout,
  separateDocument,
  eraseEdges,
  blankPageSetting,
  cleanUpBackround,
  splitRotateImage,
  selectZone,
  customScanSize,
  none
}

/// [RecorderListView] move direction

enum Move { up, down }

/// [AWIP] states of awip
enum AwipStates {
  // Insert the data members as shown
  WaitingForJobStart,
  WaitingForFileStart,
  WaitingForPageStart,
  WaitingForDataTransferStart,
  DataTransfer,
  WaitingForPageEnd,
  WaitingForFileEnd,
  WaitingForJobEnd
}

enum ButtonDecorationColor {
  // Button Decoration color for primary button
  primaryButton,
  greenButton,
  deleteButton,
  primaryGradientReverce
}

/// Wireless Error code name

enum ScannerStatus {
  coverOpen,
  noPaper,
  paperJam,
  success,
  scannerBusy,
  hasPaper,
  unknown
}

enum DirectoryOption { image, document, temp }

enum LogMode { info, warn, error, errorTrace }

enum ExposureAction { brightness, contrast, midtone, none }
