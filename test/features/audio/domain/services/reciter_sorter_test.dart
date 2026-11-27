import 'package:flutter_test/flutter_test.dart';
import 'package:qandil/features/audio/domain/services/reciter_sorter.dart';
import 'package:qandil/features/quran/domain/entities/quran_entities.dart';

void main() {
  group('ReciterSorter', () {
    test(
        'places Egyptian reciters first and preserves recitation styles (Murattal / Mujawwad)',
        () {
      const reciters = [
        RecitationResource(
          id: 4,
          reciterName: 'Abu Bakr al-Shatri',
          style: 'Murattal',
          translatedName: 'أبو بكر الشاطري',
        ),
        RecitationResource(
          id: 7,
          reciterName: 'Mishari Rashid al-`Afasy',
          style: 'Murattal',
          translatedName: 'مشاري راشد العفاسي',
        ),
        RecitationResource(
          id: 6,
          reciterName: 'Mahmoud Khalil Al-Husary',
          style: 'Murattal',
          translatedName: 'محمود خليل الحصري',
        ),
        RecitationResource(
          id: 8,
          reciterName: 'Mohamed Siddiq al-Minshawi',
          style: 'Mujawwad',
          translatedName: 'محمد صديق المنشاوي',
        ),
        RecitationResource(
          id: 1,
          reciterName: 'AbdulBaset AbdulSamad',
          style: 'Mujawwad',
          translatedName: 'عبد الباسط عبد الصمد',
        ),
      ];

      final sorted = ReciterSorter.sortEgyptianFirst(reciters);

      // The 3 Egyptian Qaris must be at indices 0, 1, 2
      expect(sorted[0].reciterName, 'Mahmoud Khalil Al-Husary');
      expect(sorted[1].reciterName, 'Mohamed Siddiq al-Minshawi');
      expect(sorted[2].reciterName, 'AbdulBaset AbdulSamad');

      // Non-Egyptian reciters follow in their original order
      expect(sorted[3].reciterName, 'Abu Bakr al-Shatri');
      expect(sorted[4].reciterName, 'Mishari Rashid al-`Afasy');

      // Verify localized display name includes style
      expect(
        ReciterSorter.formatDisplayName(sorted[0], languageCode: 'ar'),
        'محمود خليل الحصري (مرتل)',
      );
      expect(
        ReciterSorter.formatDisplayName(sorted[1], languageCode: 'ar'),
        'محمد صديق المنشاوي (مجود)',
      );
      expect(
        ReciterSorter.formatDisplayName(sorted[1], languageCode: 'en'),
        'Mohamed Siddiq al-Minshawi (Mujawwad)',
      );
    });
  });
}
