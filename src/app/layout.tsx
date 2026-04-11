import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'Wasla (وصلة) - تعلم، علّم، وانطلق',
  description: 'منصة تعليمية تربط بين الطلاب والمدربين في بيئة احترافية',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ar" dir="rtl">
      <head>
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link 
          href="https://fonts.googleapis.com/css2?family=Cairo:wght@400;500;600;700&family=IBM+Plex+Sans+Arabic:wght@400;500;600;700&family=Tajawal:wght@400;500;600;700&display=swap" 
          rel="stylesheet" 
        />
        <link 
          rel="stylesheet" 
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" 
        />
      </head>
      <body>{children}</body>
    </html>
  );
}
