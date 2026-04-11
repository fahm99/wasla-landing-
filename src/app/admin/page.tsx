'use client';

import { useState, useEffect } from 'react';
import { waitlistService, WaitlistEntry } from '@/lib/supabase';

export default function AdminPage() {
  const [waitlist, setWaitlist] = useState<WaitlistEntry[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  const [sentCount, setSentCount] = useState(0);

  useEffect(() => {
    loadWaitlist();
  }, []);

  const loadWaitlist = async () => {
    try {
      const data = await waitlistService.getWaitlist();
      setWaitlist(data);
      setTotalCount(data.length);
      setSentCount(data.filter(item => item.email_sent).length);
    } catch (error) {
      console.error('Error loading waitlist:', error);
    } finally {
      setLoading(false);
    }
  };

  const markAsSent = async (id: string) => {
    try {
      const result = await waitlistService.markEmailAsSent(id);
      if (result.success) {
        loadWaitlist();
      }
    } catch (error) {
      console.error('Error marking email as sent:', error);
    }
  };

  const getUserTypeLabel = (type: string): string => {
    const labels: { [key: string]: string } = {
      student: 'طالب',
      university: 'جامعة',
      institute: 'معهد',
      training_center: 'مركز تدريبي',
      trainer: 'مدرب'
    };
    return labels[type] || type;
  };

  const formatDate = (dateString: string): string => {
    return new Date(dateString).toLocaleDateString('ar-SA', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    });
  };

  return (
    <>
      <style jsx global>{`
        * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
        }
        
        body {
          font-family: 'IBM Plex Sans Arabic', sans-serif;
          background: #f7f9fc;
          direction: rtl;
        }

        .admin-container {
          display: flex;
          min-height: 100vh;
        }

        .sidebar {
          width: 280px;
          background: #0E1647;
          color: white;
          position: fixed;
          height: 100vh;
          overflow-y: auto;
        }

        .sidebar-header {
          padding: 24px;
          border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h2 {
          font-size: 20px;
          font-weight: 700;
        }

        .sidebar-nav {
          padding: 16px 0;
        }

        .sidebar-nav a {
          display: flex;
          align-items: center;
          gap: 12px;
          padding: 16px 24px;
          color: rgba(255, 255, 255, 0.7);
          text-decoration: none;
          transition: all 0.3s ease;
        }

        .sidebar-nav a:hover,
        .sidebar-nav a.active {
          background: rgba(255, 255, 255, 0.1);
          color: white;
        }

        .sidebar-nav a.active {
          border-right: 3px solid #FDD34D;
        }

        .main-content {
          flex: 1;
          margin-right: 280px;
          padding: 32px;
        }

        .content-header {
          margin-bottom: 32px;
        }

        .content-header h1 {
          font-size: 28px;
          color: #191C1E;
          margin-bottom: 24px;
        }

        .header-stats {
          display: flex;
          gap: 24px;
        }

        .stat-card {
          background: white;
          padding: 20px 32px;
          border-radius: 16px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .stat-label {
          display: block;
          font-size: 14px;
          color: #46464F;
          margin-bottom: 8px;
        }

        .stat-value {
          font-size: 32px;
          font-weight: 700;
          color: #0E1647;
        }

        .table-container {
          background: white;
          border-radius: 16px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
          overflow: hidden;
        }

        .data-table {
          width: 100%;
          border-collapse: collapse;
        }

        .data-table th {
          background: #f0f3f7;
          padding: 16px;
          text-align: right;
          font-weight: 600;
          color: #191C1E;
          font-size: 14px;
        }

        .data-table td {
          padding: 16px;
          border-bottom: 1px solid #e0e3e6;
          color: #46464F;
          font-size: 14px;
        }

        .data-table tr:last-child td {
          border-bottom: none;
        }

        .data-table tr:hover td {
          background: #f7f9fc;
        }

        .status-badge {
          display: inline-flex;
          align-items: center;
          gap: 6px;
          padding: 6px 12px;
          border-radius: 20px;
          font-size: 12px;
          font-weight: 500;
        }

        .status-badge.sent {
          background: #dcfce7;
          color: #166534;
        }

        .status-badge.pending {
          background: #fef3c7;
          color: #92400e;
        }

        .action-btn {
          padding: 8px 16px;
          border: none;
          border-radius: 8px;
          cursor: pointer;
          font-size: 13px;
          transition: all 0.3s ease;
        }

        .action-btn.send {
          background: #0E1647;
          color: white;
        }

        .action-btn.send:hover {
          background: #0C1445;
        }

        .action-btn:disabled {
          background: #e0e3e6;
          color: #767680;
          cursor: not-allowed;
        }

        .loading {
          text-align: center;
          padding: 48px !important;
          color: #767680;
        }

        .back-link {
          display: inline-flex;
          align-items: center;
          gap: 8px;
          color: #0E1647;
          text-decoration: none;
          font-weight: 500;
          margin-bottom: 24px;
        }

        .back-link:hover {
          color: #0C1445;
        }

        @media (max-width: 1024px) {
          .sidebar {
            width: 80px;
          }
          
          .sidebar-header h2,
          .sidebar-nav a span {
            display: none;
          }
          
          .sidebar-nav a {
            justify-content: center;
            padding: 16px;
          }
          
          .main-content {
            margin-right: 80px;
          }
        }

        @media (max-width: 768px) {
          .header-stats {
            flex-direction: column;
          }
          
          .data-table {
            display: block;
            overflow-x: auto;
          }
        }
      `}</style>

      <div className="admin-container">
        {/* Sidebar */}
        <aside className="sidebar">
          <div className="sidebar-header">
            <h2>Wasla Admin</h2>
          </div>
          <nav className="sidebar-nav">
            <a href="/admin" className="active">
              <i className="fas fa-users"></i>
              <span>قائمة الانتظار</span>
            </a>
            <a href="#">
              <i className="fas fa-envelope"></i>
              <span>إرسال الإيميلات</span>
            </a>
            <a href="/">
              <i className="fas fa-arrow-left"></i>
              <span>العودة للموقع</span>
            </a>
          </nav>
        </aside>

        {/* Main Content */}
        <main className="main-content">
          <a href="/" className="back-link">
            <i className="fas fa-arrow-left"></i>
            العودة للموقع
          </a>

          <header className="content-header">
            <h1>إدارة قائمة الانتظار</h1>
            <div className="header-stats">
              <div className="stat-card">
                <span className="stat-label">إجمالي المسجلين</span>
                <span className="stat-value">{totalCount}</span>
              </div>
              <div className="stat-card">
                <span className="stat-label">تم إرسال الإيميل</span>
                <span className="stat-value">{sentCount}</span>
              </div>
            </div>
          </header>

          <div className="content-body">
            <div className="table-container">
              {loading ? (
                <table className="data-table">
                  <tbody>
                    <tr>
                      <td colSpan={6} className="loading">جاري التحميل...</td>
                    </tr>
                  </tbody>
                </table>
              ) : waitlist.length === 0 ? (
                <table className="data-table">
                  <tbody>
                    <tr>
                      <td colSpan={6} className="loading">لا توجد بيانات</td>
                    </tr>
                  </tbody>
                </table>
              ) : (
                <table className="data-table">
                  <thead>
                    <tr>
                      <th>#</th>
                      <th>البريد الإلكتروني</th>
                      <th>نوع المستخدم</th>
                      <th>تاريخ التسجيل</th>
                      <th>حالة الإيميل</th>
                      <th>إجراءات</th>
                    </tr>
                  </thead>
                  <tbody>
                    {waitlist.map((item, index) => (
                      <tr key={item.id}>
                        <td>{index + 1}</td>
                        <td>{item.email}</td>
                        <td>{getUserTypeLabel(item.user_type)}</td>
                        <td>{formatDate(item.created_at)}</td>
                        <td>
                          <span className={`status-badge ${item.email_sent ? 'sent' : 'pending'}`}>
                            <i className={`fas fa-${item.email_sent ? 'check' : 'clock'}`}></i>
                            {item.email_sent ? 'تم الإرسال' : 'قيد الانتظار'}
                          </span>
                        </td>
                        <td>
                          <button 
                            className="action-btn send"
                            onClick={() => markAsSent(item.id)}
                            disabled={item.email_sent}
                          >
                            {item.email_sent ? 'تم الإرسال' : 'إرسال'}
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              )}
            </div>
          </div>
        </main>
      </div>
    </>
  );
}
