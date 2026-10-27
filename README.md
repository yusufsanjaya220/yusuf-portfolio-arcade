# Yusuf Sanjaya - Cyber Arcade Portfolio & 2D Space Shooter 🚀

Portofolio pribadi interaktif bertema **Retro Cyber Arcade / Tactical Terminal** dengan mini-game **2D Space Shooter (60 FPS)** yang dibangun menggunakan **Flutter**. Mendukung target **Flutter Web** dan **Android APK**.

---

## 🎨 Desain & Visual (Bebas Warna Ungu / Anti AI Slop)

Sesuai permintaan, palet warna dirancang dengan estetika terminal high-tech & arcade autentik tanpa gradien ungu generik:
- **Latar Belakang Obsidian & Slate**: `#090D16` dan `#0F172A` (gelap, tegas, profesional).
- **Aksen Neon Fiber Cyan**: `#00E5FF` (identitas network engineering & kecepatan data).
- **Terminal Emerald Green**: `#10B981` / `#00E676` (status sistem aktif, skill bar, dan perisai).
- **Arcade Amber / Skor Emas**: `#FACC15` / `#F59E0B` (koin retro arcade, level EXP, high score).
- **Peringatan / Alert Red**: `#EF4444` (musuh bug, peringatan batas HP).
- **Tipografi Seimbang**: Judul bergaya 8-bit arcade (*Press Start 2P*), teks deskripsi & detail proyek menggunakan font tajam dan mudah dibaca (*Space Grotesk*).

---

## 🌟 Fitur Utama Sesuai PRD

1. **2D Space Shooter Mini-Game (Pure Flutter Canvas 60 FPS)**:
   - **Multi-Control**: Keyboard (Panah/WASD + Spasi), Mouse, serta **Touch Drag Gesture** di layar HP Android.
   - **5 Tipe Musuh Bergelombang**:
     - *Bug* (lurus, lambat - 1 HP)
     - *Glitch* (gerak zig-zag orange - 1 HP)
     - *Crash* (menyeruduk ke arah pemain - 2 HP)
     - *Legacy Code Tank* (gunmetal armor tebal & menembak peluru - 5 HP)
     - *Boss "Deadline"* (raksasa berdarah tebal dengan HP bar & tembakan 3 arah pada Wave 5)
   - **Power-ups**: *Flutter Boost* (rapid fire), *Clean Code Shield* (perisai emerald), *Hot Reload* (heal +1 HP), *Multi-Thread* (tembakan 3 arah).
   - **Lore Unlocks**: Skor dan gelombang tertentu membuka fakta profil Yusuf secara interaktif.
   - **High Score**: Tersimpan di `shared_preferences`.

2. **6 Bagian Portofolio Lengkap (Berdasarkan Data LinkedIn Yusuf Sanjaya)**:
   - **START (Hero Base)**: Tagline typewriter, bento highlight, tombol arcade "PRESS START" dan "LIHAT PROFIL".
   - **PLAYER PROFILE (About)**: Kartu karakter RPG level 5, statistik HP/EXP/Status, ringkasan bio, dan tombol Unduh CV.
   - **QUEST LOG (Experience)**: Timeline pengalaman kerja (PT Kayaba Indonesia, DSC Bhayangkara, PT Bintang Maraga Lintas Media) dilengkapi **diagram RBAC alur approval budget**.
   - **SKILL TREE (Keahlian)**: Filter kategori (Software Dev, Database, Programming Languages, Network, Infrastructure, IT Ops) dengan bar tingkat kemahiran (1-5).
   - **ACHIEVEMENTS (Sertifikasi)**: Modul CCNA Switching Routing Wireless, CCNA Intro to Networks, dan Bootcamp IT Networking dengan tautan verifikasi kredensial.
   - **CONTINUE? (Kontak)**: Gaya countdown arcade dengan tombol salin email otomatis, LinkedIn, GitHub, dan WhatsApp.

3. **Bilingual Toggle (ID / EN)**:
   - Beralih bahasa secara instan antara Bahasa Indonesia dan Bahasa Inggris kapan saja di navigasi HUD atas.

---

## 🤖 Cara Otomatis Menghasilkan File APK via GitHub (GitHub Actions)

Proyek ini sudah dilengkapi file workflow otomatis: [`.github/workflows/build_apk.yml`](.github/workflows/build_apk.yml).

### Langkah-langkah Lengkap:

1. **Inisialisasi Git & Push ke GitHub**:
   ```bash
   git init
   git add .
   git commit -m "feat: initial commit cyber arcade portfolio"
   git branch -M main
   git remote add origin https://github.com/<username-kamu>/<nama-repo>.git
   git push -u origin main
   ```

2. **GitHub Actions Akan Berjalan Otomatis**:
   - Begitu kode di-push ke branch `main`, buka tab **"Actions"** di repositori GitHub kamu.
   - Kamu akan melihat workflow **"Build Android APK"** sedang berjalan.
   - GitHub secara otomatis menyiapkan mesin Ubuntu, Java 17, Flutter SDK stable terbaru, mengunduh dependencies, dan menjalankan `flutter build apk --release`.

3. **Cara Mengunduh File APK**:
   - Klik workflow run yang telah selesai (bertanda centang hijau ✅).
   - Scroll ke bagian paling bawah di halaman tersebut ke bagian **"Artifacts"**.
   - Klik **`yusuf-portfolio-arcade-release-apk`**.
   - GitHub akan mengunduh file zip yang berisi **`app-release.apk`**. Ekstrak dan kirim file `.apk` ke HP Android kamu untuk langsung di-install!

4. **Menjalankan Build APK Kapan Saja Secara Manual**:
   - Masuk ke tab **Actions** di GitHub.
   - Pilih workflow **"Build Android APK"** di sebelah kiri.
   - Klik tombol **"Run workflow"** -> klik **Run workflow**.

---

## 🌐 Menjalankan & Build Web

### Menjalankan di Browser (Lokal):
```bash
flutter run -d chrome
```

### Build Web untuk Deploy ke Hosting:
```bash
flutter build web --release
```
*(Repositori ini juga memiliki [`.github/workflows/deploy_web.yml`](.github/workflows/deploy_web.yml) yang otomatis mendeploy situs ke GitHub Pages jika diaktifkan).*

---

## ✏️ Mengubah & Menyesuaikan Data Diri

Semua data tersentralisasi di:
👉 [`lib/data/profile_data.dart`](lib/data/profile_data.dart)
Cukup sesuaikan link email, LinkedIn, URL sertifikasi, atau teks bio tanpa perlu memodifikasi kode UI.
