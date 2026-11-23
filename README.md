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

### Tugas 8
1. **Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`. Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi *Home* di *drawer* membawa pengguna kembali ke halaman utama.**<br>
    - `Navigator.push()` menambahkan halaman baru **di atas** halaman yang sedang aktif. Halaman lama tetap ada di bawahnya sehingga pengguna bisa kembali lewat tombol *back* di `AppBar` atau gestur *back* sistem.
    - `Navigator.pushReplacement()` **menggantikan** halaman yang sedang aktif dengan halaman baru. Halaman lama dibuang dari tumpukan, jadi jumlah halaman di tumpukan tidak bertambah dan pengguna tidak bisa kembali ke halaman yang digantikan.
    - `Navigator.pop()` **mengeluarkan** halaman paling atas dari tumpukan sehingga pengguna kembali ke halaman di bawahnya. Metode ini juga dipakai untuk menutup `AlertDialog`, seperti pada tombol "OK" di dialog setelah formulir berhasil disimpan.

    Untuk membuka formulir dari kartu aksi, proyek ini memakai `Navigator.push()`:
    - `ItemCard` (`project_card.dart`): saat tombol "Tambah Proyek" ditekan, `Navigator.push()` membuka `ProjectFormPage`.
    - `ExperienceCard` (`experience_card.dart`): saat tombol "Add Experience" ditekan, `Navigator.push()` membuka `ExperienceFormPage`.

    Alasannya, formulir adalah halaman lanjutan dari halaman utama, sehingga pengguna perlu bisa kembali ke halaman utama dengan tombol *back* tanpa kehilangan halaman asalnya.

    Opsi *Home* di `LeftDrawer` memanggil `Navigator.pushReplacement()` dengan `MaterialPageRoute(builder: (context) => MyHomePage())`. Halaman yang sedang dibuka (misalnya halaman formulir) diganti dengan `MyHomePage`, sehingga pengguna langsung sampai di halaman utama. Drawer ikut hilang karena ia adalah bagian dari `Scaffold` halaman yang diganti, dan halaman baru memiliki `Scaffold` serta drawer-nya sendiri. Selain itu, tombol "Back to Home" di `ExperienceFormPage` memakai `Navigator.pushAndRemoveUntil()` dengan kondisi `(route) => false`, yang mengosongkan seluruh tumpukan sebelum menampilkan `MyHomePage`.

    **Note:** Pada `experience_form.dart`, tombol "Back to Home" memakai `Navigator.pushAndRemoveUntil()`. `Navigator.pushAndRemoveUntil()` membuka halaman baru sekaligus menghapus halaman lama dari navigation stack sampai kondisi pada parameter ketiga terpenuhi. Dengan `(route) => false`, kondisi itu tidak pernah terpenuhi sehingga **semua** halaman lama dihapus dan tumpukan hanya berisi halaman baru. Berbeda dengan `pushReplacement()` yang hanya mengganti satu halaman paling atas, `pushAndRemoveUntil()` cocok untuk "kembali ke awal" karena tidak meninggalkan halaman lama di tumpukan. Pada `pushReplacement()` di opsi *Home* drawer, jika formulir sebelumnya dibuka lewat `push` dari Home, Home lama masih tersisa di bawah Home yang baru, sehingga tombol *back* membawa pengguna ke Home lama. Dengan `pushAndRemoveUntil()`, tombol *back* dari Home langsung keluar dari aplikasi.

2. **Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**<br>
    `Scaffold` adalah kerangka halaman dengan slot yang sudah tetap: `appBar` di atas, `drawer` di sisi kiri, dan `body` untuk konten. Semua halaman (`MyHomePage`, `ProjectFormPage`, `ExperienceFormPage`) memakai kerangka yang sama, sehingga pengguna selalu menemukan judul halaman di bagian atas, tombol menu untuk membuka *drawer*, dan konten di bawahnya. Pada `Drawer`, widget `LeftDrawer` dibuat sekali di `left_drawer.dart` lalu dipakai ulang lewat `drawer: const LeftDrawer()` di setiap halaman, sehingga menu navigasi selalu sama dan perubahan cukup dilakukan di satu tempat. `AppBar` mendapat gaya dari `appBarTheme` di `AppTheme`, sehingga tampilannya seragam walaupun judulnya berbeda.

    Contoh penggunaan warna tema di lebih dari satu halaman adalah `AppColors.primary500`:
    - Di `AppTheme`, warna ini dipakai sebagai `primary` pada `ColorScheme` dan sebagai `backgroundColor` pada `appBarTheme`, sehingga `AppBar` di halaman utama, halaman *Add Project*, dan halaman *Add Experience* semuanya berwarna sama.
    - `DrawerHeader` di `LeftDrawer` mengambil warna yang sama lewat `Theme.of(context).colorScheme.primary`, dan karena drawer dipakai di semua halaman, *header*-nya tampil dengan warna tersebut di mana pun ia dibuka.
    - Di halaman utama, *card* "Lihat Proyek" dan "Add Experience" memakai `AppColors.primary500` sebagai warna *background*.

    Warna *background* halaman juga seragam karena `scaffoldBackgroundColor` diatur ke `AppColors.background` di tema, bukan di masing-masing halaman.

3. **Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**<br>
    Formulir disusun dengan `Form` -> `SingleChildScrollView` -> `Column` (`crossAxisAlignment: CrossAxisAlignment.start`), dan setiap kolom isian dibungkus `Padding(padding: EdgeInsets.all(8.0))`. Susunan vertikal dipilih karena layar ponsel sempit dan setiap isian memerlukan lebar penuh untuk label, teks, dan pesan *error*. Urutan atas ke bawah juga mengikuti alur pengisian dari nama, deskripsi, kategori, sampai tombol "Save". Perataan kiri membuat label dan isian terbaca rapi.
    - **Widget pengatur jarak** (`Padding`, juga `SizedBox` di halaman lain) memberi ruang di sekitar tiap isian supaya tidak saling menempel, area sentuh lebih nyaman, dan pesan validasi di bawah kolom tidak menimpa isian berikutnya.
    - **Widget penggulir** (`SingleChildScrollView`) membuat seluruh isi `Column` bisa digulir. Formulir ini punya banyak isian, dan saat papan ketik muncul tinggi area yang terlihat makin kecil. Tanpa penggulir, `Column` yang lebih tinggi dari layar akan menyebabkan *overflow* ("*bottom overflowed by ... pixels*"), dan isian di bagian bawah atau tombol "Save" tidak bisa dijangkau. Dengan penggulir, ukuran konten tidak lagi dibatasi tinggi layar. Hal yang sama dipakai pada `content` `AlertDialog`, yang juga dibungkus `SingleChildScrollView` supaya ringkasan data tetap bisa dibaca di layar kecil.

4. **Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol "Simpan" ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**<br>
    - `GlobalKey<FormState>` (`_formKey`) dipasang pada widget `Form` lewat `key: _formKey`. Kunci ini memberi akses ke `FormState` dari luar `Form`, misalnya dari `onPressed` tombol "Save" yang tidak berada di dalam `TextFormField`. Lewat kunci yang sama, `_formKey.currentState!.reset()` dipanggil setelah dialog ditutup untuk mengosongkan isian.
    - `validator` adalah fungsi di tiap `TextFormField` yang menerima nilai isian dan mengembalikan `String?`. Jika nilainya tidak valid, ia mengembalikan pesan *error* (misalnya `"Nama proyek tidak boleh kosong!"`), dan jika valid ia mengembalikan `null`.
    - `validate()` dipanggil saat "Save" ditekan. Metode ini menjalankan semua `validator` di dalam `Form` sekaligus, menampilkan pesan *error* di bawah isian yang bermasalah, lalu mengembalikan `true` hanya jika semua `validator` mengembalikan `null`. Karena dipakai di `if (_formKey.currentState!.validate())`, dialog "berhasil ditambahkan" hanya muncul jika seluruh isian valid.

    Contoh nilai yang ditolak: pada kolom "Nama Proyek", pengguna mengetik hanya spasi (`"   "`). Karena `value.trim().isEmpty` bernilai `true`, `validator` mengembalikan `"Nama proyek tidak boleh kosong!"` dan data tidak disimpan. Contoh lain pada formulir pengalaman: tanggal selesai yang lebih awal dari tanggal mulai ditolak dengan pesan `"Tanggal selesai tidak boleh sebelum tanggal mulai!"`.

    Jenis input atau papan ketik saja belum cukup karena `keyboardType` hanya mengubah tampilan papan ketik, bukan memeriksa isinya. Pengguna masih bisa menempel (*paste*) teks, memakai papan ketik fisik, mengetik hanya spasi, atau membiarkan isian kosong. Papan ketik juga tidak bisa memeriksa aturan yang bergantung pada isian lain, seperti tanggal selesai yang harus setelah tanggal mulai. Isian tanggal di proyek ini memakai `showDatePicker` dengan `readOnly: true`, tetapi pengguna tetap bisa menekan "Save" sebelum memilih tanggal, sehingga `validator` tetap dibutuhkan sebagai pemeriksa terakhir sebelum data diterima.

#### AI Disclosure
Saya menggunakan Generative AI berupa ChatGPT (Codex) sebagai alat bantu untuk implementasi instruksi Tugas 8, memahami pola navigasi dan formulir, dan menyusun dokumentasi. Saran AI dapat mengasumsikan nama berkas, alur navigasi, atau perilaku yang berbeda dari proyek, sehingga saya mencocokkannya dengan kode dan kebutuhan tugas. Implementasi akhir dan keputusan teknis saya tinjau berdasarkan kode yang benar-benar tersedia. Saya menggunakan hasilnya sebagai masukan, lalu memeriksa kembali kesesuaiannya dengan kode dan instruksi tugas.<br>
AI Chat Log:
https://chatgpt.com/s/cx_6b0460da1bf08191bf0a73a6f10a3c1a
https://chatgpt.com/s/cx_6b04616e23e481919b4b652ec6806dda
https://chatgpt.com/s/cx_6b046190a0e88191a381377e693bece8
