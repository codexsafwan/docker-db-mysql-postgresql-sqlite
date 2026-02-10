import { query } from "@/lib/db";

export const dynamic = 'force-dynamic';

async function getData() {
  const products = await query("SELECT * FROM products ORDER BY id ASC");
  const categories = await query("SELECT * FROM categories ORDER BY id ASC");
  
  return {
    products: products.rows,
    categories: categories.rows,
  };
}

export default async function Home() {
  const { products, categories } = await getData();

  return (
    <div className="space-y-12">
      {/* Categories Section */}
      <section>
        <h2 className="text-2xl font-bold mb-6 text-gray-800 border-l-4 border-blue-500 pl-4">
          Categories
        </h2>
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          {categories.map((category) => (
            <div 
              key={category.id} 
              className="bg-white p-4 rounded-xl shadow-sm border border-gray-100 hover:shadow-md transition-shadow flex items-center justify-between"
            >
              <span className="font-medium">{category.name}</span>
              <span className="text-xs text-gray-400 bg-gray-50 px-2 py-1 rounded">#{category.id}</span>
            </div>
          ))}
        </div>
      </section>

      {/* Products Section */}
      <section>
        <h2 className="text-2xl font-bold mb-6 text-gray-800 border-l-4 border-green-500 pl-4">
          Products
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {products.map((product) => (
            <div 
              key={product.id} 
              className="bg-white p-6 rounded-2xl shadow-sm border border-gray-100 hover:border-green-100 hover:shadow-lg transition-all"
            >
              <div className="flex justify-between items-start mb-4">
                <h3 className="text-lg font-bold text-gray-900">{product.name}</h3>
                <span className="text-green-600 font-bold font-mono">${product.price}</span>
              </div>
              <div className="flex items-center text-sm text-gray-500 space-x-4">
                <span className="flex items-center">
                  📦 Stock: <b className="ml-1 text-gray-700">{product.stock}</b>
                </span>
                <span className={`px-2 py-0.5 rounded-full text-xs font-semibold ${
                  product.status === 'active' ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-700'
                }`}>
                  {product.status.toUpperCase()}
                </span>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
