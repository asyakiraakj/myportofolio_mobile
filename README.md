# myportofolio_mobile

### Tugas 7
1. **Jelaskan apa yang dimaksud dengan *widget tree* pada Flutter dan bagaimana hubungan induk-anak (*parent-child*) bekerja antar-*widget*!**
    <br>Hampir semua elemen UI di flutter direpresentasikan *widget*. Widget-widget tersebut disusun secara hierarkis dan membentuk struktur pohon atau disebut juga *widget tree*. Akarnya adalah root widget yang dipasing ke `runApp()` di `MyApp/MaterialApp`, dan daunnya adalah widget-yang tidak punya child, seperti `Text` atau `Icon`.
    <br>Adapun hubungan *parent-child* bekerja sebagai berikut:
    - Parent membungkus dan mengatur child melalui properti `child` (satu anak, misal Padding, Card, Inkwell) atau `children` (banyak anak, misal `Column`, `Row`, `GridView`).
    - Soal layout, Flutter punya prinsip “*constraints go down, sizes go up, parent sets position*”. Parent memberi *constraints* ke child, child memilih size di dalam batasan (*constraints*) itu lalu melaporkannya ke parent, kemudian parent yang menentukan posisi child.
    - Data seperti theme dan ukuran layar mengalir dari atas ke bawah tree.

2. **Sebutkan semua *widget* yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**
    - `MyApp`: widget root buatkan sendiri yang mengembalikan `MaterialApp`.
    - `MaterialApp`: menyediakan konfigurasi aplikasi dengan style Material Design, seperti title, theme, dan halaman (`home`).
    - `Scaffold`: kerangka dasar halaman yang menyediakan tempat untuk AppBar, body, dan SnackBar.
    - `AppBar`: bar di bagian atas halaman yang menampilkan judul aplikasi.
    - `Text`: menampilkan teks, misalya judul AppBar, isi `InfoCard`, nama tombol, dll.
    - `Padding`: memberi jarak di sekeliling child.
    - `Column`: menyusun child secara vertikal.
    - `Row`: menyusun menyusun child secara horizontal, dipakai untuk menjajarkan tiga `InfoCard`.
    - `Center`: menempatkan child di tengah.
    - `SizedBox`: memberi jarak kosong dengan ukuran tetap di antara elemen.
    - `InfoCard`: custom widget reusable untuk menampilkan NPM, Nama, dan Kelas.
    - `Card`: wadah dengan style Material dengan efek shadow (`elevation`), dipakai dalam `InfoCard`.
    - `Container`: wadah *multipurpose* untuk mengatuh *width*, *padding*, dan dekorasi.
    - `GridView.count`: menampilkan kartu tombol dalam grid dengan jumlah kolom tetap, yaitu 3 kolom
    - `ItemCard`: custom widget *reusable* untuk tombol aksi yang berisi ikon dan teks.
    - `Material`: permukaan Material yang memberi warna latar dan sudut membulat pada tombol (warna diambil dari item.color).
    - `InkWell`: membuat area bisa ditekan dengan efek ripple, sekaligus menyediakan callback onTap.
    - `Icon`: menampilkan ikon pada setiap tombol.
    - `ScaffoldMessenger`: mengatur dan menampilkan SnackBar pada Scaffold terdekat.
    - `SnackBar`: notifikasi singkat di bawah layar yang berisi “Kamu telah menekan tombol [Nama Tombol]!”.

    3. **Apa fungsi dari *widget* `MaterialApp`? Jelaskan mengapa *widget* ini umumnya digunakan sebagai *root widget* pada aplikasi Flutter!**<br>
    `MaterialApp` adalah widget yang membungkus banyak fitur dasar untuk aplikasi dengan fondasi Material Design. Fungsi utamanya:
    - Menyediakan tema global (`ThemeData` dan `ColorScheme`) yang bisa diakses semua widget di bawahnya.
    - Menentukan halaman awal lewat home, serta mengelola navigation/routing (`Navigator`, `routes`).
    - Mengatur title aplikasi, localization, dan pengaturan tingkat aplikasi lainnya.
    - Menyiapkan infrastruktur yang dibutuhkan widget Material, seperti `Overlay`, `ScaffoldMessenger`, `MediaQuery`, dan `Directionality`.<br>

    Alasan MaterialApp dipakai sebagai root: widget seperti `Scaffold`, `AppBar`, dan `SnackBar` membutuhkan infrastruktur yang disediakannya. Selain itu, theme dan navigation cukup diatur sekali di puncak tree, lalu otomatis diwariskan ke semua halaman, sehingga tampilan aplikasi tetap konsisten.<br>

4. **Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan kita sebaiknya memilih `StatelessWidget` dan kapan harus menggunakan `StatefulWidget`?**<br>
    - `StatelessWidget` bersifat immutable. Tampilannya hanya bergantung pada data yang diberikan lewat *constructor*, tidak menyimpan *state internal*, dan hanya dibangun ulang kalau *parent*-nya memberi data baru.
    - `StatefulWidget` punya objek `State` terpisah yang menyimpan data yang bisa berubah selama aplikasi berjalan. Perubahan dilakukan lewat `setState()`, yang memicu `build()` ulang. *Lifecycle*-nya juga bisa dikelola lewat `initState()` dan `dispose()`.<br>
    Kapan memilih yang mana:<br>
    - `StatelessWidget` dipakai untuk UI yang statis atau hanya bergantung pada data dari luar. Contohnya `MyHomePage`, `InfoCard`, dan `ItemCard` di proyek ini. Lebih sederhana dan ringan.
    - `StatefulWidget` dipakai jika widget perlu mengubah tampilannya sendiri sebagai respons terhadap interaksi user atau perubahan data. Contohnya *counter*, *form input*, *checkbox*, animasi, atau data yang di-*load* secara *asynchronous*. Aplikasi *counter* bawaan Flutter sendiri memakai `StatefulWidget`.
5. **Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?**<br>
    `BuildContext` adalah objek yang merepresentasikan posisi sebuah widget di dalam widget tree. Lewat context, widget bisa “melihat ke atas” tree untuk menemukan *widget ancestor* dan data yang diwariskan (*inherited widgets*), seperti *theme*, ukuran layar, dan Scaffold.<br>
    Mengapa penting:<br>
    - Context memungkinkan akses ke data dari *ancestor*.
    - Menjadi dasar untuk *navigation* dan notifikasi, misalnya `ScaffoldMessenger.of(context)`.<br>
    Penggunaannya di dalam method `build(BuildContext context)` pada proyek ini:
    - `Theme.of(context).colorScheme.primary` untuk mengambil warna `AppBar` dari theme.
    - `MediaQuery.of(context).size.width / 3.5` untuk menentukan lebar InfoCard berdasarkan lebar layar.
    - `ScaffoldMessenger.of(context).showSnackBar(...)` di dalam `onTap` pada `ItemCard` untuk menampilkan `SnackBar`.
    Context yang diterima `build` adalah milik widget itu sendiri, jadi pencarian *ancestor* dimulai dari posisinya di tree lalu naik ke atas.
6. **Jelaskan konsep *hot reload* di Flutter dan apa perbedaannya dengan *hot restart*! Kapan kita tidak bisa hanya mengandalkan *hot reload* dan harus melakukan *hot restart* atau *full restart?***<br>
    ***Hot reload:*** Flutter memasukkan kode Dart yang baru ke Dart VM yang sedang berjalan, lalu membangun ulang (*rebuild*) widget tree. State aplikasi tetap dipertahankan dan prosesnya sangat cepat. Cocok untuk mengubah tampilan seperti warna, teks, atau layout.<br>
    ***Hot restart:*** aplikasi dijalankan ulang dari awal, `main()` dieksekusi lagi, dan semua state di-*reset*. Lebih lambat dari hot reload, tapi lebih cepat dari *full restart*.<br>
    ***Full restart***: aplikasi dihentikan sepenuhnya, lalu dijalankan lagi dengan `flutter run`. Prosesnya dilakukan dengan membangun ulang aplikasi dan menginstallnya lagi ke perangkat.<br>
    Situasi saat hot reload saja tidak cukup:
    - Mengubah isi `main()` atau `initState()`, karena keduanya hanya berjalan sekali. Butuh *hot restart*.
    - Mengubah nilai variabel global atau field static yang sudah terinisialisasi. Butuh *hot restart*.
    - Mengubah tipe deklarasi, misalnya dari `StatelessWidget` ke `StatefulWidget` atau sebaliknya, atau dari `enum` ke `class`. Butuh *hot restart*.
    - Mengubah `pubspec.yaml` (menambah dependency atau asset), menambah plugin, atau mengubah kode native seperti `AndroidManifest.xml`, konfigurasi Gradle, dan folder `ios/`. Butuh *full restart*, yaitu menghentikan aplikasi lalu menjalankannya lagi.

#### AI Disclosure
Saya menggunakan Generative AI yaitu Claude untuk membantu saya menentukan secara detail apa saja yang harus saya ubah. Selain itu saya juga menggunakan Claude untuk meminta penjelasan mengenai indentasi di Dart/Flutter. Saya juga menggunakan Claude untuk mendalami konsep dasar Flutter.<br>
AI Chat Log:
- [Checklist Tugas 7](https://claude.ai/share/f45cfe82-1062-4722-9b83-d1a135360517)
- [Indentasi di Dart](https://claude.ai/share/df32d6e6-37f1-4674-b8ba-9181d7483d8f)
- [Widget Tree dan Hubungan Parent-Child antar Widget, BuildContext](https://claude.ai/share/4abac271-24d4-43c1-8a43-334d18a16879)
- [MaterialApp](https://claude.ai/share/df211031-7b8f-4613-8103-f984f2d18819)
- [Perbedaan StatelessWidget dan StatefulWidget](https://claude.ai/share/da977c33-ac3f-4a8e-b658-6d55560beecf)
- [Hot Reload, Hot Restart, dan Full Restart](https://claude.ai/share/7dced05f-81da-47d2-93fa-df1a399f7bd8)
