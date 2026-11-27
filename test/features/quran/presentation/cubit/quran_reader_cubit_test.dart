import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/core/database/app_database.dart';
import 'package:qandil/features/quran/data/repositories/quran_local_repository_impl.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';
import 'package:qandil/features/quran/presentation/cubit/quran_reader_cubit.dart';
import 'package:qandil/features/quran/presentation/cubit/quran_reader_state.dart';

void main() {
  late AppDatabase db;
  late QuranLocalRepositoryImpl localRepo;

  const page1Verses = [
    QuranVerse(
      id: 1,
      verseKey: '1:1',
      chapterId: 1,
      verseNumber: 1,
      pageNumber: 1,
      juzNumber: 1,
      hizbNumber: 1,
      textUthmani: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      textImlaeiSimple: 'بسم الله الرحمن الرحيم',
    ),
  ];

  const page2Verses = [
    QuranVerse(
      id: 8,
      verseKey: '2:1',
      chapterId: 2,
      verseNumber: 1,
      pageNumber: 2,
      juzNumber: 1,
      hizbNumber: 1,
      textUthmani: 'الٓمٓ',
      textImlaeiSimple: 'الم',
    ),
  ];

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    localRepo = QuranLocalRepositoryImpl(database: db);

    await localRepo.cacheChapters(const [
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
    ]);
    await localRepo.cacheVerses([...page1Verses, ...page2Verses]);
  });

  tearDown(() async {
    await db.close();
  });

  group('QuranReaderCubit', () {
    test(
        'automatically saves reading position and restores it when app/cubit is restarted',
        () async {
      final firstSessionCubit = QuranReaderCubit(
        repository: localRepo,
        database: db,
        localRepository: localRepo,
        enableBundledSeed: false,
      );

      await firstSessionCubit.initialize();
      expect(firstSessionCubit.state.currentPageNumber, 1);

      // Turn to page 2 (Surah Al-Baqarah)
      await firstSessionCubit.goToPage(2);
      expect(firstSessionCubit.state.currentPageNumber, 2);
      expect(firstSessionCubit.state.currentSurahNumber, 2);
      await firstSessionCubit.close();

      // Simulate app kill and relaunch with a fresh QuranReaderCubit attached to same DB
      final restoredSessionCubit = QuranReaderCubit(
        repository: localRepo,
        database: db,
        localRepository: localRepo,
        enableBundledSeed: false,
      );
      await restoredSessionCubit.initialize();

      expect(restoredSessionCubit.state.currentPageNumber, 2);
      expect(restoredSessionCubit.state.currentSurahNumber, 2);
      expect(
          restoredSessionCubit.state.currentPageVerses.first.verseKey, '2:1');
      await restoredSessionCubit.close();
    });

    test(
        'toggles Mushaf page and Verse list modes, saves colored bookmarks, personal notes, and Khatmah plan',
        () async {
      final cubit = QuranReaderCubit(
        repository: localRepo,
        database: db,
        localRepository: localRepo,
        enableBundledSeed: false,
      );
      await cubit.initialize();

      // Switch view mode
      cubit.setViewMode(QuranReaderViewMode.verseList);
      expect(cubit.state.viewMode, QuranReaderViewMode.verseList);

      // Bookmark verse 1:1 with Nile green
      await cubit.setBookmark(
        verse: page1Verses.first,
        colorHex: '#1F6F5C',
      );
      expect(cubit.state.bookmarksByVerseKey['1:1'], '#1F6F5C');

      // Save personal reflection note
      await cubit.saveNote(
        verse: page1Verses.first,
        content: 'تأمل في البسملة',
      );
      expect(cubit.state.activeVerseNote, 'تأمل في البسملة');

      // Update Khatmah plan to 15 days
      await cubit.updateKhatmahPlan(targetDays: 15);
      expect(cubit.state.khatmahTargetDays, 15);
      expect(cubit.state.khatmahSummary.basePagesPerDay, 41);

      // Search Arabic verses (normalized matching, unaltered textUthmani)
      await cubit.searchArabicVerses('الرحمن');
      expect(cubit.state.searchMatchedVerses.length, 1);
      expect(
        cubit.state.searchMatchedVerses.first.textUthmani,
        'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
      );

      await cubit.close();
    });
  });
}
