'use client';

import { useState } from 'react';
import { supabase } from '@/lib/supabase';
import './globals.css';

export default function HomePage() {
  const [isWaitlistModalOpen, setIsWaitlistModalOpen] = useState(false);
  const [isSuccessModalOpen, setIsSuccessModalOpen] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [email, setEmail] = useState('');
  const [userType, setUserType] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [defaultUserType, setDefaultUserType] = useState('');

  const openWaitlistModal = (type: string) => {
    setDefaultUserType(type === 'trainer' ? 'trainer' : 'student');
    setUserType(type === 'trainer' ? 'trainer' : 'student');
    setIsWaitlistModalOpen(true);
    setIsMobileMenuOpen(false);
  };

  const closeWaitlistModal = () => {
    setIsWaitlistModalOpen(false);
    setEmail('');
    setUserType('');
  };

  const closeSuccessModal = () => {
    setIsSuccessModalOpen(false);
  };

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen(!isMobileMenuOpen);
  };

  const closeMobileMenu = () => {
    setIsMobileMenuOpen(false);
  };

  const submitWaitlist = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!email || !userType) return;
    
    setIsSubmitting(true);

    try {
      const { error } = await supabase
        .from('waitlist')
        .insert([
          {
            email: email,
            user_type: userType,
            email_sent: false
          }
        ]);

      if (error) {
        if (error.code === '23505') {
          alert('هذا البريد الإلكتروني مسجل مسبقاً!');
        } else {
          throw error;
        }
      } else {
        closeWaitlistModal();
        setIsSuccessModalOpen(true);
      }
    } catch (error) {
      console.error('Error:', error);
      alert('حدث خطأ. يرجى المحاولة مرة أخرى.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <>
      {/* Header Section */}
      <header className="header">
        <div className="container">
          <nav className="navbar">
            <a href="#" className="logo">
              <span>Wasla</span>
              <span className="logo-arabic">(وصلة)</span>
            </a>
            <ul className="nav-links">
              <li><a href="#features">المميزات</a></li>
              <li><a href="#providers">لمقدمي الخدمة</a></li>
              <li><a href="#how-it-works">كيف يعمل</a></li>
              <li><a href="#download">تحميل</a></li>
            </ul>
            <div className="header-buttons">
              <button className="btn btn-secondary" onClick={() => openWaitlistModal('student')}>
                <i className="fas fa-download"></i>
                تحميل التطبيق
              </button>
              <button className="btn btn-primary" onClick={() => openWaitlistModal('trainer')}>
                <i className="fas fa-briefcase"></i>
                التسجيل كشريك تعليمي
              </button>
            </div>
            <button className="mobile-menu-btn" onClick={toggleMobileMenu}>
              <i className="fas fa-bars"></i>
            </button>
          </nav>
        </div>
      </header>

      {/* Mobile Menu */}
      <div className={`mobile-menu ${isMobileMenuOpen ? 'active' : ''}`} id="mobileMenu">
        <ul className="mobile-nav-links">
          <li><a href="#features" onClick={closeMobileMenu}>المميزات</a></li>
          <li><a href="#providers" onClick={closeMobileMenu}>لمقدمي الخدمة</a></li>
          <li><a href="#how-it-works" onClick={closeMobileMenu}>كيف يعمل</a></li>
          <li><a href="#download" onClick={closeMobileMenu}>تحميل</a></li>
        </ul>
        <button className="cta-button" onClick={() => openWaitlistModal('trainer')}>
          ابدأ الآن
        </button>
      </div>

      {/* Hero Section */}
      <section className="hero">
        <div className="container">
          <div className="hero-content">
            <div className="hero-text">
              <h1 className="hero-title">
                تعلم، علّم، وانطلق بمستقبلك مع
                <span className="highlight">وصلة</span>
              </h1>
              <p className="hero-subtitle">
                منصة وصلة تربط بين الطلاب الشغوفين ومقدمي الخدمات التعليمية في بيئة تعليمية متكاملة وسهلة الاستخدام.
              </p>
              <div className="hero-buttons">
                <button className="btn btn-primary" onClick={() => openWaitlistModal('trainer')}>
                  ابدأ الآن كمقدم خدمة
                </button>
                <button className="btn btn-secondary" onClick={() => openWaitlistModal('student')}>
                  تحميل التطبيق
                </button>
              </div>
            </div>
            <div className="hero-image">
              <div className="hero-image-wrapper">
                <img src="/dashboard.png" alt="لوحة تحكم وصلة" />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="features" id="features">
        <div className="container">
          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon secondary">
                <i className="fas fa-school"></i>
              </div>
              <h3 className="feature-title">تعلم من أفضل المدربين</h3>
              <p className="feature-description">نخبة من الخبراء في مختلف المجالات يقدمون خلاصة تجاربهم بين يديك.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon primary">
                <i className="fas fa-award"></i>
              </div>
              <h3 className="feature-title">كورسات احترافية</h3>
              <p className="feature-description">محتوى تعليمي عالي الجودة مصمم ليتناسب مع متطلبات سوق العمل الحالية.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon secondary">
                <i className="fas fa-certificate"></i>
              </div>
              <h3 className="feature-title">شهادات معتمدة</h3>
              <p className="feature-description">احصل على شهادة إتمام موثقة تعزز ملفك الشخصي وتفتح لك أبواب الفرص.</p>
            </div>
            <div className="feature-card">
              <div className="feature-icon primary">
                <i className="fas fa-chart-line"></i>
              </div>
              <h3 className="feature-title">متابعة تقدمك بسهولة</h3>
              <p className="feature-description">أدوات متطورة تتيح لك قياس مستواك وتتبع إنجازاتك في كل خطوة.</p>
            </div>
          </div>
        </div>
      </section>

      {/* For Providers Section */}
      <section className="providers" id="providers">
        <div className="container">
          <div className="providers-content">
            <div className="providers-image">
              <div className="providers-image-wrapper">
                <img src="https://thediversitymovement.com/wp-content/uploads/2024/01/iStock-1481369283-scaled.jpg" alt="For Providers" />
              </div>
              <div className="providers-badge">
                <i className="fas fa-rocket"></i>
              </div>
            </div>
            <div className="providers-info">
              <span className="section-label">للخبراء والمدربين</span>
              <h2 className="section-title">إذا كنت مدرب أو جهة تعليمية...</h2>
              <div className="provider-items">
                <div className="provider-item">
                  <div className="provider-icon">
                    <i className="fas fa-plus-square"></i>
                  </div>
                  <div className="provider-text">
                    <h4>إنشاء الكورسات بسهولة</h4>
                    <p>أدوات قوية لرفع الفيديوهات، الملفات، والاختبارات في دقائق.</p>
                  </div>
                </div>
                <div className="provider-item">
                  <div className="provider-icon">
                    <i className="fas fa-users"></i>
                  </div>
                  <div className="provider-text">
                    <h4>إدارة الطلاب</h4>
                    <p>تواصل مع طلابك، تابع تقدمهم، وقدم الدعم الفني مباشرة عبر المنصة.</p>
                  </div>
                </div>
                <div className="provider-item">
                  <div className="provider-icon">
                    <i className="fas fa-wallet"></i>
                  </div>
                  <div className="provider-text">
                    <h4>تحقيق الأرباح</h4>
                    <p>نظام مالي شفاف يضمن لك استلام مستحقاتك بكل أمان وسهولة.</p>
                  </div>
                </div>
              </div>
              <button className="btn btn-primary" onClick={() => openWaitlistModal('trainer')}>
                ابدأ الآن كمقدم خدمة
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* How It Works Section */}
      <section className="how-it-works" id="how-it-works">
        <div className="container">
          <div className="section-header">
            <h2 className="section-title">كيف تعمل وصلة للطلاب؟</h2>
            <p className="section-subtitle">أربع خطوات بسيطة تبعدك عن تحقيق أهدافك التعليمية</p>
          </div>
          <div className="steps-grid">
            <div className="step-card">
              <span className="step-number">1</span>
              <div className="step-icon">
                <i className="fas fa-user-plus"></i>
              </div>
              <h4 className="step-title">سجل حساب</h4>
              <p className="step-description">أنشئ حسابك المجاني في ثوانٍ</p>
            </div>
            <div className="step-card">
              <span className="step-number">2</span>
              <div className="step-icon">
                <i className="fas fa-search"></i>
              </div>
              <h4 className="step-title">اختر كورس</h4>
              <p className="step-description">تصفح وجد ما يناسب اهتمامك</p>
            </div>
            <div className="step-card">
              <span className="step-number">3</span>
              <div className="step-icon">
                <i className="fas fa-book-reader"></i>
              </div>
              <h4 className="step-title">تعلم</h4>
              <p className="step-description">شاهد الفيديوهات وطبق الدروس</p>
            </div>
            <div className="step-card">
              <span className="step-number">4</span>
              <div className="step-icon">
                <i className="fas fa-trophy"></i>
              </div>
              <h4 className="step-title">احصل على شهادة</h4>
              <p className="step-description">وثق إنجازك وشارك نجاحك</p>
            </div>
          </div>
        </div>
      </section>

      {/* App Screens Section */}
      <section className="app-screens">
        <div className="container">
          <div className="section-header">
            <h2 className="section-title app-screens-title">تجربة مستخدم استثنائية مصممة خصيصاً لتناسب نمط حياتك</h2>
          </div>
          <div className="screens-showcase">
            <div className="phone-mockup">
              <div className="phone-frame">
                <img src="/screens/screen1.jpg" alt="شاشة الكورسات" className="phone-screen-image" />
              </div>
            </div>
            
            <div className="phone-mockup center">
              <div className="phone-frame">
                <img src="/screens/screen2.jpg" alt="شاشة المعاهد" className="phone-screen-image" />
              </div>
            </div>
            
            <div className="phone-mockup">
              <div className="phone-frame">
                <img src="/screens/screen3.jpg" alt="شاشة الترحيب" className="phone-screen-image" />
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* App Preview Section */}
      <section className="app-preview">
        <div className="container">
          <div className="preview-content">
            <div className="preview-info">
              <span className="section-label">تجربة تعليمية متكاملة</span>
              <h2 className="section-title">كل ما تحتاجه في مكان واحد</h2>
              <div className="preview-features">
                <div className="preview-feature">
                  <i className="fas fa-video"></i>
                  <span>فيديوهات تعليمية عالية الجودة</span>
                </div>
                <div className="preview-feature">
                  <i className="fas fa-file-alt"></i>
                  <span>ملفات ودروس تفاعلية</span>
                </div>
                <div className="preview-feature">
                  <i className="fas fa-comments"></i>
                  <span>تواصل مباشر مع المدربين</span>
                </div>
                <div className="preview-feature">
                  <i className="fas fa-mobile-alt"></i>
                  <span>ممتاز على جميع الأجهزة</span>
                </div>
              </div>
            </div>
            <div className="preview-image">
              <img src="https://cdn.mos.cms.futurecdn.net/x8oyLJtDJBPmL59WUoa36C-1200-80.jpg" alt="App Preview" />
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="cta" id="download">
        <div className="container">
          <div className="cta-box">
            <h2 className="cta-title">ابدأ رحلتك الآن</h2>
            <p className="cta-text">
              سواء كنت تريد التعلم أو مشاركة معرفتك، وصلة هي المكان الأمثل لتبدأ قصة نجاحك الجديدة.
            </p>
            <div className="cta-buttons">
              <button className="btn btn-dark" onClick={() => openWaitlistModal('trainer')}>
                ابدأ الآن كمقدم خدمة
              </button>
              <button className="btn btn-light" onClick={() => openWaitlistModal('student')}>
                تحميل التطبيق
              </button>
            </div>
          </div>
        </div>
      </section>

      {/* Footer Section */}
      <footer className="footer">
        <div className="container">
          <div className="footer-grid">
            <div className="footer-col">
              <div className="footer-logo">
                <span>Wasla</span>
                <span className="logo-arabic">(وصلة)</span>
              </div>
              <p className="footer-description">منصة تعليمية تربط بين الطلاب والمدربين في بيئة احترافية</p>
            </div>
            <div className="footer-col">
              <h4>الشركة</h4>
              <ul>
                <li><a href="#">About Us</a></li>
                <li><a href="#">Careers</a></li>
                <li><a href="#">Contact Us</a></li>
              </ul>
            </div>
            <div className="footer-col">
              <h4>القانونية</h4>
              <ul>
                <li><a href="#">Privacy Policy</a></li>
                <li><a href="#">Terms of Service</a></li>
              </ul>
            </div>
            <div className="footer-col">
              <h4>تحميل التطبيق</h4>
              <div className="store-buttons">
                <a href="#" className="store-btn">
                  <i className="fab fa-apple"></i>
                  <div>
                    <span>Available on</span>
                    <span>App Store</span>
                  </div>
                </a>
                <a href="#" className="store-btn">
                  <i className="fab fa-google-play"></i>
                  <div>
                    <span>Get it on</span>
                    <span>Google Play</span>
                  </div>
                </a>
              </div>
            </div>
          </div>
          <div className="footer-bottom">
            <p>© 2024 Wasla. All rights reserved.</p>
            <div className="social-links">
              <a href="#"><i className="fab fa-facebook-f"></i></a>
              <a href="#"><i className="fab fa-linkedin-in"></i></a>
              <a href="#"><i className="fas fa-envelope"></i></a>
            </div>
          </div>
        </div>
      </footer>

      {/* Waitlist Modal */}
      <div className={`modal ${isWaitlistModalOpen ? 'active' : ''}`} id="waitlistModal">
        <div className="modal-content">
          <button className="modal-close" onClick={closeWaitlistModal}>
            <i className="fas fa-times"></i>
          </button>
          <div className="modal-header">
            <div className="modal-icon">
              <i className="fas fa-envelope"></i>
            </div>
            <div>
              <h3 className="modal-title">انضم إلى قائمة الانتظار</h3>
              <p className="modal-subtitle">سنخبرك فور جاهزية المنصة!</p>
            </div>
          </div>
          <form onSubmit={submitWaitlist}>
            <div className="form-group">
              <input 
                type="email" 
                placeholder="البريد الإلكتروني" 
                required
                value={email}
                onChange={(e) => setEmail(e.target.value)}
              />
              <i className="fas fa-envelope"></i>
            </div>
            <div className="form-group">
              <select 
                required
                value={userType}
                onChange={(e) => setUserType(e.target.value)}
              >
                <option value="">اختر نوع المستخدم</option>
                <option value="student">طالب</option>
                <option value="university">جامعة</option>
                <option value="institute">معهد</option>
                <option value="training_center">مركز تدريبي</option>
                <option value="trainer">مدرب</option>
              </select>
              <i className="fas fa-user"></i>
            </div>
            <button type="submit" className="btn btn-primary btn-full" disabled={isSubmitting}>
              {isSubmitting ? 'جاري التسجيل...' : 'انضم الآن'}
            </button>
          </form>
          <button className="btn-text" onClick={closeWaitlistModal}>لاحقاً</button>
        </div>
      </div>

      {/* Success Modal */}
      <div className={`modal ${isSuccessModalOpen ? 'active' : ''}`} id="successModal">
        <div className="modal-content success">
          <div className="success-icon">
            <i className="fas fa-check"></i>
          </div>
          <h3 className="success-title">تم التسجيل بنجاح!</h3>
          <p className="success-text">سنخبرك فوراً عبر البريد الإلكتروني عند إطلاق المنصة</p>
          <button className="btn btn-primary" onClick={closeSuccessModal}>حسناً</button>
        </div>
      </div>
    </>
  );
}
