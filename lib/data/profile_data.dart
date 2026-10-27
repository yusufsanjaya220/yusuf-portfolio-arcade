import 'package:flutter/material.dart';
import 'models.dart';

class ProfileData {
  // 8.1 Identitas
  static const String name = "Yusuf Sanjaya";
  
  static const String headlineId =
      "Full Stack Developer Intern di PT Kayaba Indonesia | CCNA Certified | Mahasiswa Informatika";
  static const String headlineEn =
      "Full Stack Developer Intern at PT Kayaba Indonesia | CCNA Certified | Informatics Student";

  static const String tagline = "Network Engineer | Software Engineer";
  static const String location = "DKI Jakarta Area, Indonesia";
  static const String campus = "Universitas Bhayangkara Jakarta Raya";
  static const String semester = "Semester 5 (Informatics)";

  static const List<String> openForRoles = [
    "Software Development",
    "Network Engineering",
    "DevOps",
    "System Administration",
  ];

  // 8.2 Tentang (About)
  static const String aboutParagraph1Id =
      "Mahasiswa Teknik Informatika Semester 5 di Universitas Bhayangkara Jakarta Raya, memadukan fondasi kuat dalam Network Engineering dengan pengalaman praktis pengembangan perangkat lunak (Full Stack Development). Memegang sertifikasi CCNA (Cisco Certified Network Associate) dan berfokus merancang aplikasi yang tangguh serta memahami infrastruktur jaringan di baliknya.";
  static const String aboutParagraph1En =
      "5th-Semester Informatics student at Universitas Bhayangkara Jakarta Raya, combining a strong foundation in Network Engineering with hands-on software development experience. Holds Cisco Certified Network Associate (CCNA) certification and specializes in building robust applications while understanding the underlying network infrastructure.";

  static const String aboutParagraph2Id =
      "Saat ini berkontribusi sebagai Full Stack Developer Intern di PT Kayaba Indonesia, mengembangkan dan memelihara aplikasi web untuk operasional manufaktur dan bisnis perusahaan. Sebelumnya membangun dasar jaringan sebagai Network Technician Intern di PT Bintang Maraga Lintas Media menginstalasi infrastruktur kabel serat optik.";
  static const String aboutParagraph2En =
      "Currently working as a Full Stack Developer Intern at PT Kayaba Indonesia, developing and maintaining web-based applications to support manufacturing and business operations. Previously built a networking foundation as a Network Technician Intern at PT Bintang Maraga Lintas Media, deploying fiber-optic infrastructure.";

  static const String aboutParagraph3Id =
      "Kombinasi Full Stack Development (Laravel, PHP, Tailwind CSS) dan Network Engineering (CCNA, Routing & Switching) menjembatani celah antara pembuatan aplikasi modern dengan penyebaran infrastruktur jaringan yang aman dan andal.";
  static const String aboutParagraph3En =
      "The blend of Full Stack Development (Laravel, PHP, Tailwind CSS) and Network Engineering (CCNA, Routing & Switching) bridges the gap between software creation and secure, reliable network deployment.";

  // Quick Highlights for Hero section
  static final List<QuickHighlight> quickHighlights = [
    const QuickHighlight(
      titleId: "Posisi Saat Ini",
      titleEn: "Current Role",
      valueId: "Full Stack Dev Intern @ PT Kayaba",
      valueEn: "Full Stack Dev Intern @ PT Kayaba",
      icon: Icons.code,
      badgeText: "ACTIVE",
    ),
    const QuickHighlight(
      titleId: "Sertifikasi Unggulan",
      titleEn: "Featured Cert",
      valueId: "Cisco CCNA Module Certified",
      valueEn: "Cisco CCNA Module Certified",
      icon: Icons.verified,
      badgeText: "VERIFIED",
    ),
    const QuickHighlight(
      titleId: "Fokus Akademik",
      titleEn: "Academic Focus",
      valueId: "Informatics Smt 5 (IPK 3.5+)",
      valueEn: "Informatics Sem 5 (GPA 3.5+)",
      icon: Icons.school,
      badgeText: "LEVEL 5",
    ),
  ];

  // 8.3 Pengalaman (Quest Log)
  static final List<ExperienceItem> experiences = [
    ExperienceItem(
      id: "kayaba",
      positionId: "Full Stack Developer (Magang)",
      positionEn: "Full Stack Developer (Intern)",
      organization: "PT Kayaba Indonesia",
      periodId: "Agt 2026 - Sekarang",
      periodEn: "Aug 2026 - Present",
      location: "Cikarang Barat, Jawa Barat",
      status: "ON GOING",
      summaryId:
          "Mengembangkan sistem automasi approval internal perusahaan untuk Additional Budget dan Mutation Budget dengan logika conditional routing berjenjang dan sinkronisasi database Oracle ke MySQL.",
      summaryEn:
          "Developed enterprise automated approval systems for Additional Budget and Mutation Budget with multi-tiered conditional routing and synchronized Oracle DB to MySQL.",
      bulletPointsId: [
        "Membangun sistem approval otomatis untuk Additional Budget dan Mutation Budget menggunakan Laravel, PHP, dan Tailwind CSS.",
        "Mengimplementasikan Role-Based Access Control (RBAC) dan conditional routing berdasarkan batas nominal budget.",
        "Mengintegrasikan dan menyinkronkan data perusahaan dari Oracle Database ke lingkungan phpMyAdmin (MySQL).",
        "Menerapkan pola arsitektur MVC yang bersih untuk kemudahan pemeliharaan sistem skala manufaktur.",
      ],
      bulletPointsEn: [
        "Architected automated approval workflows for Additional & Mutation Budgets using Laravel, PHP, and Tailwind CSS.",
        "Implemented strict Role-Based Access Control (RBAC) and conditional approval routing based on dynamic budget thresholds.",
        "Integrated and synchronized company enterprise data pipelines from Oracle Database to MySQL (phpMyAdmin).",
        "Applied clean MVC architecture to ensure robust maintainability across manufacturing operations.",
      ],
      techStack: [
        "Laravel",
        "PHP",
        "Tailwind CSS",
        "Oracle DB",
        "MySQL",
        "SQL",
        "MVC Architecture",
        "RBAC",
      ],
      showcase: const ProjectShowcase(
        titleId: "Sistem Approval Otomatis Budget (Fitur Utama)",
        titleEn: "Automated Budget Approval System (Featured Quest)",
        descriptionId:
            "Sistem ini menangani alur persetujuan keuangan secara otomatis berdasarkan nilai pengajuan dan departemen asal/tujuan dengan validasi multi-level.",
        descriptionEn:
            "Automated enterprise financial approval engine handling conditional routing based on transaction values and multi-level department authorizations.",
        approvalSteps: [
          ApprovalWorkflowStep(
            condition: "Mutasi < Rp 11 Juta",
            approversId: "Kadept Asal & Tujuan + Finance (Foreman & Kadept)",
            approversEn: "Source & Dest Dept Head + Finance (Foreman & Dept Head)",
          ),
          ApprovalWorkflowStep(
            condition: "Mutasi Rp 11 Jt - Rp 100 Jt",
            approversId: "Tambahan: Kadiv Asal & Tujuan + Kadiv Finance",
            approversEn: "Added: Source & Dest Div Head + Finance Div Head",
          ),
          ApprovalWorkflowStep(
            condition: "Mutasi > Rp 100 Juta",
            approversId: "Tambahan: Board of Directors (BOD) Asal, Tujuan, & BOD Finance",
            approversEn: "Added: BOD Source, Dest, and BOD Finance",
          ),
          ApprovalWorkflowStep(
            condition: "Additional Budget",
            approversId: "Lengkap: Kadept, Kadiv, BOD (Asal/Tujuan) & Seluruh Jajaran Finance",
            approversEn: "Full Stack: Dept Head, Div Head, BOD (Source/Dest) & Complete Finance Board",
          ),
        ],
        highlights: [
          "Eliminasi proses manual dokumen kertas menjadi digital paperless approval.",
          "Mencegah human-error lewat validasi rule engine otomatis.",
          "Sinkronisasi data real-time dengan basis data Oracle perusahaan.",
        ],
      ),
    ),
    ExperienceItem(
      id: "dsc-ubharajaya",
      positionId: "Wakil Divisi IT Networking (Paruh Waktu)",
      positionEn: "Vice Head of IT Networking Division (Part-time)",
      organization: "Developer Student Club (DSC) Universitas Bhayangkara",
      periodId: "2024 - Sekarang",
      periodEn: "2024 - Present",
      location: "Bekasi, Jawa Barat",
      status: "ON GOING",
      summaryId:
          "Mengkoordinasikan edukasi, workshop teknis jaringan, dan manajemen infrastruktur laboratorium jaringan bagi komunitas mahasiswa.",
      summaryEn:
          "Coordinating student community networking workshops, lab infrastructure management, and peer-to-peer technical knowledge sharing.",
      bulletPointsId: [
        "Memfasilitasi sesi pembelajaran hands-on Cisco Packet Tracer dan konfigurasi router/switch.",
        "Mengatur arsitektur konektivitas lab internal dan simulasi topologi jaringan kampus.",
        "Membimbing anggota baru dalam pemahaman konsep OSI Model, TCP/IP, dan subnetting.",
      ],
      bulletPointsEn: [
        "Facilitated hands-on workshops on Cisco Packet Tracer and router/switch configuration.",
        "Designed internal lab connectivity architectures and campus network topology simulations.",
        "Mentored members on core OSI layer fundamentals, TCP/IP, routing protocols, and subnetting.",
      ],
      techStack: [
        "Cisco Packet Tracer",
        "Routing & Switching",
        "Subnetting",
        "LAN/WLAN",
        "Team Leadership",
      ],
    ),
    ExperienceItem(
      id: "bintang-maraga",
      positionId: "Cable Jointer (Magang)",
      positionEn: "Cable Jointer (Intern)",
      organization: "PT Bintang Maraga Lintas Media",
      periodId: "Jan 2023 - Mar 2023 (3 Bulan)",
      periodEn: "Jan 2023 - Mar 2023 (3 Months)",
      location: "Tangerang Selatan, Banten",
      status: "COMPLETED",
      summaryId:
          "Melaksanakan instalasi, fusion splicing kabel serat optik, dan terminasi kabel untuk memastikan kualitas transmisi data jaringan telekomunikasi.",
      summaryEn:
          "Executed fiber optic cable installation, fusion splicing, and network termination ensuring high-fidelity data transmission standards.",
      bulletPointsId: [
        "Melakukan fusion splicing serat optik dengan presisi redaman (attenuation) rendah.",
        "Melakukan terminasi kabel OTB/ODP dan pengujian loss daya menggunakan Optical Time-Domain Reflectometer (OTDR).",
        "Melakukan penelusuran gangguan (troubleshooting) fisik jalur kabel serat optik di lapangan.",
      ],
      bulletPointsEn: [
        "Executed precision fiber optic fusion splicing maintaining minimal loss and attenuation standards.",
        "Handled OTB/ODP terminations and verified signal integrity using Optical Power Meters & OTDR.",
        "Troubleshot on-site physical fiber route disruptions and outdoor distribution closures.",
      ],
      techStack: [
        "Fusion Splicing",
        "Fiber Optic Cable",
        "OTDR Testing",
        "ODP / OTB Termination",
        "System Troubleshooting",
      ],
    ),
  ];

  // 8.4 Pendidikan
  static final List<EducationItem> educations = [
    const EducationItem(
      institution: "Universitas Bhayangkara Jakarta Raya",
      majorId: "Informatics (Teknik Informatika)",
      majorEn: "Informatics (Computer Science)",
      period: "Sep 2024 - Sekarang (Semester 5)",
      detailsId:
          "Mempelajari algoritma komputer, struktur data, pemrograman berorientasi objek, rekayasa perangkat lunak, dan pemecahan masalah algoritma (C++, Python).",
      detailsEn:
          "Studying computer algorithms, data structures, object-oriented programming, software engineering, and analytical problem solving (C++, Python).",
      activities: ["DSC IT Networking Division", "Competitive Programming Study Group"],
    ),
    const EducationItem(
      institution: "SMK Telekomunikasi Telesandi Bekasi",
      majorId: "Teknik Komputer dan Jaringan (TKJ)",
      majorEn: "Computer Engineering & Networking",
      period: "Jul 2021 - Jun 2024",
      detailsId:
          "Lulus dengan IPK 3.5. Fondasi komprehensif dalam administrasi server jaringan, perakitan komputer, kabel optik, dan konfigurasi routing mikrotik/cisco.",
      detailsEn:
          "Graduated with GPA 3.5. Comprehensive foundation in network server administration, computer hardware, optical cabling, and Cisco/Mikrotik routing.",
      activities: ["Nihon Club (Head of Analysis)", "Volleyball Club", "Tomcat Club"],
    ),
  ];

  // 8.5 Keahlian (Skill Tree)
  static final List<SkillCategory> skillCategories = [
    const SkillCategory(
      id: "software",
      titleId: "Software Development",
      titleEn: "Software Development",
      icon: Icons.laptop_chromebook,
      skills: [
        SkillItem(name: "Full-Stack Web Dev", level: 4, noteId: "Pengembangan web end-to-end modern", noteEn: "Modern end-to-end web development"),
        SkillItem(name: "PHP (Laravel)", level: 4, noteId: "Arsitektur MVC, Eloquent ORM, REST API", noteEn: "MVC architecture, Eloquent ORM, REST API"),
        SkillItem(name: "Tailwind CSS", level: 4, noteId: "Utility-first responsive styling", noteEn: "Utility-first responsive styling"),
        SkillItem(name: "Conditional Workflow / RBAC", level: 5, noteId: "Aturan routing approval & hierarki akses", noteEn: "Approval routing engine & access hierarchy"),
        SkillItem(name: "Flutter & Dart", level: 3, noteId: "Multiplatform UI & interactive game canvas", noteEn: "Multiplatform UI & interactive game canvas"),
      ],
    ),
    const SkillCategory(
      id: "database",
      titleId: "Database & Pipelines",
      titleEn: "Database & Pipelines",
      icon: Icons.storage,
      skills: [
        SkillItem(name: "SQL & Query Optimization", level: 4, noteId: "Relational queries, index & joins", noteEn: "Relational queries, index & joins"),
        SkillItem(name: "Oracle Database", level: 4, noteId: "Integrasi sistem enterprise manufaktur", noteEn: "Enterprise manufacturing system integration"),
        SkillItem(name: "MySQL / phpMyAdmin", level: 4, noteId: "Skema aplikasi web & data warehouse", noteEn: "Web application schemas & operational DB"),
        SkillItem(name: "Oracle to MySQL Sync", level: 4, noteId: "Pipelines data sinkronisasi otomatis", noteEn: "Automated data synchronization pipeline"),
      ],
    ),
    const SkillCategory(
      id: "programming",
      titleId: "Bahasa Pemrograman",
      titleEn: "Programming Languages",
      icon: Icons.code,
      skills: [
        SkillItem(name: "PHP", level: 4, noteId: "Backend web server logic", noteEn: "Backend web server logic"),
        SkillItem(name: "C++", level: 4, noteId: "Algoritma & pemrograman sistem", noteEn: "Algorithms & system programming"),
        SkillItem(name: "Python", level: 4, noteId: "Scripting automasi & problem solving", noteEn: "Automation scripting & problem solving"),
        SkillItem(name: "JavaScript / Dart", level: 3, noteId: "Frontend logic & reactive state", noteEn: "Frontend logic & reactive state"),
      ],
    ),
    const SkillCategory(
      id: "network",
      titleId: "Network Engineering",
      titleEn: "Network Engineering",
      icon: Icons.router,
      skills: [
        SkillItem(name: "Cisco Routers & Switches", level: 5, noteId: "Konfigurasi perangkat enterprise Cisco", noteEn: "Cisco enterprise hardware configuration"),
        SkillItem(name: "Routing Protocols (OSPF, RIP)", level: 4, noteId: "Dynamic routing & subnet planning", noteEn: "Dynamic routing & subnet planning"),
        SkillItem(name: "LAN / VLAN Switching", level: 4, noteId: "Segmentasi trafik jaringan & trunking", noteEn: "Traffic segmentation & trunking"),
        SkillItem(name: "Wireless Networking", level: 4, noteId: "WLAN deployment & access points", noteEn: "WLAN deployment & access points"),
      ],
    ),
    const SkillCategory(
      id: "infrastructure",
      titleId: "Infrastruktur & Fiber Optik",
      titleEn: "Infrastructure & Fiber",
      icon: Icons.cable,
      skills: [
        SkillItem(name: "Fusion Splicing", level: 5, noteId: "Penyambungan inti fiber optik presisi", noteEn: "High-precision core alignment splicing"),
        SkillItem(name: "Fiber Optic Cable Termination", level: 5, noteId: "OTB / ODP outdoor & indoor", noteEn: "OTB / ODP outdoor & indoor installation"),
        SkillItem(name: "System Troubleshooting", level: 4, noteId: "Pengecekan redaman kabel & sinyal", noteEn: "Signal degradation & route fault finding"),
      ],
    ),
    const SkillCategory(
      id: "it-ops",
      titleId: "IT Operations & Cloud",
      titleEn: "IT Operations & Cloud",
      icon: Icons.cloud_done,
      skills: [
        SkillItem(name: "Server Administration", level: 3, noteId: "Linux / Windows Web Server setup", noteEn: "Linux / Windows Web Server setup"),
        SkillItem(name: "Cloud Computing Basics", level: 3, noteId: "Konsep IaaS, PaaS & VM hosting", noteEn: "IaaS, PaaS fundamentals & VM hosting"),
        SkillItem(name: "Cybersecurity Basics", level: 3, noteId: "Firewall rules, port hardening & SSL", noteEn: "Firewall rules, port hardening & SSL"),
      ],
    ),
  ];

  // 8.6 Sertifikasi (Achievements)
  static final List<CertificationItem> certifications = [
    const CertificationItem(
      id: "ccna-srwe",
      title: "CCNA: Switching, Routing, and Wireless Essentials",
      issuer: "Cisco Networking Academy",
      issueDate: "Jul 2026",
      credentialUrl: "https://www.netacad.com/",
      tags: ["LAN Switching", "Routing Protocols", "Wireless Networking", "VLANs", "STP"],
      descriptionId:
          "Sertifikasi modul resmi Cisco yang memvalidasi kompetensi dalam konfigurasi switch, router, troubleshooting protokol routing VLAN, WLAN, dan keamanan jaringan lokal.",
      descriptionEn:
          "Official Cisco credential validating competencies in switch and router configuration, troubleshooting VLAN routing, WLAN architecture, and local network security.",
    ),
    const CertificationItem(
      id: "ccna-itn",
      title: "CCNA: Introduction to Networks",
      issuer: "Cisco Networking Academy",
      issueDate: "Mar 2026",
      credentialUrl: "https://www.netacad.com/",
      tags: ["IPv4 / IPv6 Subnetting", "Ethernet", "OSI Model", "Network Fundamentals"],
      descriptionId:
          "Validasi fondasi jaringan komprehensif: pemahaman mendalam tentang model TCP/IP, arsitektur Ethernet, kalkulasi subnetting IP, dan media transmisi jaringan.",
      descriptionEn:
          "Comprehensive networking foundation credential: deep dive into TCP/IP protocols, Ethernet architecture, IP addressing calculations, and physical transmission media.",
    ),
    const CertificationItem(
      id: "bootcamp-networking",
      title: "Bootcamp IT Networking Specialist",
      issuer: "PT Graha Karya Informasi",
      issueDate: "2025",
      credentialUrl: "https://grahakarya.com/",
      tags: ["Hands-on Lab", "Network Configuration", "System Administration"],
      descriptionId:
          "Pelatihan intensif praktik langsung konfigurasi perangkat jaringan industri, routing dinamis, dan pemeliharaan server infrastruktur IT.",
      descriptionEn:
          "Intensive hands-on industrial bootcamp on enterprise networking hardware setup, dynamic routing, and core IT infrastructure server administration.",
    ),
  ];

  // 8.7 Kontak
  static const String linkedInUrl = "https://www.linkedin.com/in/yusuf-sanjaya-1b86ba348";
  static const String email = "yusufsanjaya.dev@gmail.com";
  static const String githubUrl = "https://github.com/yusufsanjaya";
  static const String whatsappUrl = "https://wa.me/6281200000000"; // Placeholder
  static const String cvDownloadUrl = "#"; // Trigger download modal

  // 7.6 In-Game Achievements (Nilai Pembeda)
  static List<InGameAchievement> generateAchievements() => [
    InGameAchievement(
      id: "first_blood",
      title: "First Bug Squashed",
      descriptionId: "Membasmi 1 bug pertama dalam game! (Skor 50)",
      descriptionEn: "Eliminated the first bug in space! (Score 50)",
      triggerScore: 50,
    ),
    InGameAchievement(
      id: "score_500",
      title: "Clean Coder",
      descriptionId: "Mencapai 500 Poin: Membuka fakta keahlian Full-Stack Yusuf!",
      descriptionEn: "Reached 500 Pts: Unlocked Yusuf's Full-Stack expertise fact!",
      triggerScore: 500,
    ),
    InGameAchievement(
      id: "wave_3",
      title: "Network Resilient",
      descriptionId: "Bertahan hingga Wave 3: Membuka fakta sertifikasi Cisco CCNA!",
      descriptionEn: "Survived until Wave 3: Unlocked Cisco CCNA certification lore!",
      triggerWave: 3,
    ),
    InGameAchievement(
      id: "boss_beaten",
      title: "Deadline Conquered",
      descriptionId: "Mengalahkan Boss 'Deadline' pada Wave 5! Kamu seorang Hero!",
      descriptionEn: "Defeated the 'Deadline' Boss on Wave 5! You are a Hero!",
      triggerWave: 5,
    ),
  ];
}
