import "./globals.css";

export const metadata = {
  title: "E-Commerce Dashboard",
  description: "Next.js + PostgreSQL",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="bg-gray-50 text-gray-900 min-h-screen">
        <nav className="bg-white shadow-sm border-b border-gray-200 py-4 mb-8">
          <div className="max-w-6xl mx-auto px-4">
            <h1 className="text-xl font-bold text-blue-600">🛒 E-Commerce Showcase</h1>
          </div>
        </nav>
        <main className="max-w-6xl mx-auto px-4 pb-12">
          {children}
        </main>
      </body>
    </html>
  );
}
