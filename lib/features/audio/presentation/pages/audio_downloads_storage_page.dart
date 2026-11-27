import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../quran/domain/entities/quran_entities.dart';
import '../../domain/entities/audio_entities.dart';
import '../../domain/services/reciter_sorter.dart';
import '../cubit/audio_cubit.dart';
import '../cubit/audio_state.dart';

/// Dedicated Offline Audio Downloads & Storage Usage screen:
/// - Displays total app-private storage used by downloaded recitations
/// - Credits the reciter and Quran Foundation explicitly
/// - Allows user-initiated per-surah download, pause/resume with progress bar, and delete
class AudioDownloadsStoragePage extends StatelessWidget {
  const AudioDownloadsStoragePage({
    required this.chapters,
    super.key,
  });

  final List<QuranChapter> chapters;

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 MB';
    final mb = bytes / (1024 * 1024);
    if (mb < 1.0) {
      final kb = bytes / 1024;
      return '${kb.toStringAsFixed(1)} KB';
    }
    return '${mb.toStringAsFixed(2)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final lang = Localizations.localeOf(context).languageCode;

    final effectiveChapters = chapters.isNotEmpty
        ? chapters
        : const [
            QuranChapter(
              id: 1,
              nameArabic: 'الفاتحة',
              nameSimple: 'Al-Fatihah',
              nameTranslated: 'The Opener',
              revelationPlace: 'makkah',
              revelationOrder: 5,
              bismillahPre: false,
              versesCount: 7,
              startPage: 1,
              endPage: 1,
            ),
            QuranChapter(
              id: 2,
              nameArabic: 'البقرة',
              nameSimple: 'Al-Baqarah',
              nameTranslated: 'The Cow',
              revelationPlace: 'madinah',
              revelationOrder: 87,
              bismillahPre: true,
              versesCount: 286,
              startPage: 2,
              endPage: 49,
            ),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.audioDownloadsTitle),
      ),
      body: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          final cubit = context.read<AudioCubit>();
          final reciterDisplay = ReciterSorter.formatDisplayName(
            state.selectedReciter,
            languageCode: lang,
          );

          return ListView(
            padding: const EdgeInsetsDirectional.all(16),
            children: [
              // 1. Storage Usage Summary Card
              Card(
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.storage_rounded,
                            color: AppColors.lantern,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.audioStorageUsedLabel(
                                _formatBytes(state.totalStorageUsedBytes),
                              ),
                              style: theme.textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        l10n.audioReciterCreditBanner(reciterDisplay),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Per-Surah Download List for the Selected Reciter
              ...effectiveChapters.map((chapter) {
                SurahAudioDownloadItem? downloadItem;
                for (final d in state.downloads) {
                  if (d.reciterId == state.selectedReciterId &&
                      d.surahNumber == chapter.id) {
                    downloadItem = d;
                    break;
                  }
                }

                final status =
                    downloadItem?.status ?? AudioDownloadStatus.notDownloaded;
                final progress = downloadItem?.progress ?? 0.0;

                return Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.lantern,
                                foregroundColor: AppColors.night,
                                child: Text('${chapter.id}'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      chapter.nameArabic,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    Text(
                                      reciterDisplay,
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              _buildActionButtons(
                                context,
                                l10n,
                                cubit,
                                state.selectedReciterId,
                                chapter,
                                status,
                              ),
                            ],
                          ),
                          if (status == AudioDownloadStatus.downloading ||
                              status == AudioDownloadStatus.paused) ...[
                            const SizedBox(height: 10),
                            LinearProgressIndicator(value: progress),
                          ],
                          if (status == AudioDownloadStatus.completed &&
                              downloadItem != null) ...[
                            const SizedBox(height: 6),
                            Text(
                              '${l10n.audioDownloadedBadge} • ${_formatBytes(downloadItem.totalBytes)}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    AppLocalizations l10n,
    AudioCubit cubit,
    int reciterId,
    QuranChapter chapter,
    AudioDownloadStatus status,
  ) {
    return switch (status) {
      AudioDownloadStatus.notDownloaded ||
      AudioDownloadStatus.failed =>
        IconButton(
          tooltip: l10n.audioDownloadSurahAction,
          icon: const Icon(Icons.download_rounded),
          onPressed: () => cubit.startOrResumeOfflineDownload(
            surahNumber: chapter.id,
            surahName: chapter.nameArabic,
          ),
        ),
      AudioDownloadStatus.downloading => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: l10n.audioPauseDownloadAction,
              icon: const Icon(Icons.pause_circle_outline_rounded),
              onPressed: () => cubit.pauseOfflineDownload(
                surahNumber: chapter.id,
              ),
            ),
            IconButton(
              tooltip: l10n.audioDeleteDownloadAction,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => cubit.deleteOfflineDownload(
                reciterId: reciterId,
                surahNumber: chapter.id,
              ),
            ),
          ],
        ),
      AudioDownloadStatus.paused => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: l10n.audioResumeDownloadAction,
              icon: const Icon(Icons.play_circle_outline_rounded),
              onPressed: () => cubit.startOrResumeOfflineDownload(
                surahNumber: chapter.id,
                surahName: chapter.nameArabic,
              ),
            ),
            IconButton(
              tooltip: l10n.audioDeleteDownloadAction,
              icon: const Icon(Icons.delete_outline_rounded),
              onPressed: () => cubit.deleteOfflineDownload(
                reciterId: reciterId,
                surahNumber: chapter.id,
              ),
            ),
          ],
        ),
      AudioDownloadStatus.completed => IconButton(
          tooltip: l10n.audioDeleteDownloadAction,
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: () => cubit.deleteOfflineDownload(
            reciterId: reciterId,
            surahNumber: chapter.id,
          ),
        ),
    };
  }
}
