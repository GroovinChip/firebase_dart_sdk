// File created by
// Lung Razvan <long1eu>
// on 25/09/2018

import 'package:firebase_common/firebase_common.dart';

/// Metadata about a snapshot, describing the state of the snapshot.
///
/// * <b>Subclassing Note</b>: Firestore classes are not meant to be subclassed except for use in
/// test mocks. Subclassing is not supported in production code and new SDK releases may break code
/// that does so.
@publicApi
class SnapshotMetadata {
  /**
   * @return true if the snapshot contains the result of local writes (e.g. set() or update() calls)
   *     that have not yet been committed to the backend. If your listener has opted into metadata
   *     updates (via `MetadataChanges.INCLUDE`) you will receive another snapshot with
   *     `hasPendingWrites()` equal to false once the writes have been committed to the backend.
   */
  final bool hasPendingWrites;

  /**
   * @return true if the snapshot was created from cached data rather than guaranteed up-to-date
   *     server data. If your listener has opted into metadata updates (via
   *     `MetadataChanges.INCLUDE`) you will receive another snapshot with `isFomCache()` equal to
   *     false once the client has received up-to-date data from the backend.
   */
  final bool isFromCache;

  const SnapshotMetadata(this.hasPendingWrites, this.isFromCache);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnapshotMetadata &&
          runtimeType == other.runtimeType &&
          hasPendingWrites == other.hasPendingWrites &&
          isFromCache == other.isFromCache;

  @override
  int get hashCode => hasPendingWrites.hashCode ^ isFromCache.hashCode;

  @override
  String toString() {
    return 'SnapshotMetadata{hasPendingWrites: $hasPendingWrites, isFromCache: $isFromCache}';
  }
}
