import Link from 'next/link'

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-blue-50 to-white">
      <header className="border-b bg-white p-4">
        <div className="container mx-auto flex justify-between items-center">
          <span className="text-2xl font-bold">PowerLytix</span>
          <Link href="/login" className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">
            Sign In
          </Link>
        </div>
      </header>
      <section className="container mx-auto px-4 py-20 text-center">
        <h1 className="text-5xl font-bold mb-6">Real-Time KPIs for Your Business</h1>
        <p className="text-xl text-gray-600 mb-8">PowerLytix delivers analytics dashboards.</p>
      </section>
    </div>
  )
}
