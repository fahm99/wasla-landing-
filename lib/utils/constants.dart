class Constants {
  static const String appName = 'Wasla (وصلة)';
  static const String heroTitle = 'تعلم، علّم، وانطلق بمستقبلك مع';
  static const String heroSubtitle =
      'منصة وصلة تربط بين الطلاب الشغوفين ومقدمي الخدمات التعليمية  في بيئة تعليمية متكاملة وسهلة الاستخدام.';

  static const List<Map<String, String>> userTypes = [
    {'value': 'student', 'label': 'طالب'},
    {'value': 'university', 'label': 'جامعة'},
    {'value': 'institute', 'label': 'معهد'},
    {'value': 'training_center', 'label': 'مركز تدريبي'},
    {'value': 'trainer', 'label': 'مدرب'},
  ];

  // روابط الصور
  static const String heroImage =
      'https://cdn.mos.cms.futurecdn.net/x8oyLJtDJBPmL59WUoa36C-1200-80.jpg'; // مبرمج يعمل

  static const String studentImage =
      'https://cdn2.opendemocracy.net/media/images/PA-54565102.max-1520x1008.max-760x504.jpg'; // طالب يتعلم (يمني)

  static const String providerImage =
      'https://thediversitymovement.com/wp-content/uploads/2024/01/iStock-1481369283-scaled.jpg'; // فريق عمل متعاون

  static const String platformDashboard =
      'assets/wep/dashboard.png'; // واجهة المنصة

  static const String logoImage = 'assets/logo.png'; // شعار المنصة

  static const String nationalUnivLogo =
      'https://national-univ.net/wp-content/uploads/2021/01/aaa.png'; // شعار الجامعة الوطنية

  static const String nationalUnivLogoWhite =
      'https://national-univ.net/wp-content/uploads/2021/08/logo_mod.png'; // شعار الجامعة الوطنية (أبيض)

  static const String certificateImage =
      'https://res.cloudinary.com/certifier/image/upload/v1719841655/graduation_certificate_Certifier_blog_cover_fc0b496b7c.jpg'; // شهادة تخرج

  // صور الشهادات (للأفاتار)
  static const List<String> avatarImages = [];

  static const List<Map<String, String>> testimonials = [
    {
      'quote':
          '"كأنني امتلكت مفتاحاً لمستقبلي. وصلة لم تكن مجرد منصة، بل كانت الجسر الذي عبرت به نحو أول وظيفة لي كمصمم."',
      'name': 'أحمد علي',
      'role': 'طالب تصميم جرافيك',
      'image':
          'https://media.istockphoto.com/id/2192933531/photo/middle-eastern-male-professional-in-traditional-clothing-standing-in-meeting-room.jpg', // رجل أعمال عربي
    },
    {
      'quote':
          '"بصفتي مدربة، وجدت في وصلة الأدوات التي كنت أحلم بها لتوصيل علمي لأكبر عدد ممكن من الطلاب بكل احترافية."',
      'name': 'سارة محمود',
      'role': 'مدربة تطوير أعمال',
      'image':
          'https://symondsresearch.com/wp-content/uploads/2022/11/communication-skills.jpg', // مدربة
    },
    {
      'quote':
          '"سهولة الاستخدام وجودة المحتوى هي ما يميز وصلة فعلاً. أنصح بها كل من يبحث عن تطوير حقيقي لمهاراته."',
      'name': 'ياسين إبراهيم',
      'role': 'متخصص تسويق رقمي',
      'image':
          'https://media.istockphoto.com/id/2165425195/photo/portrait-of-a-man-in-an-office.jpg', // شاب محترف
    },
  ];
}
