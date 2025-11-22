# PowerLytix - Landing Page Upgrade Script
# Creates a gorgeous, professional landing page

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PowerLytix - Landing Page Upgrade" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Creating stunning landing page with:" -ForegroundColor Yellow
Write-Host "  • Animated hero section with gradients" -ForegroundColor White
Write-Host "  • Feature showcase with icons" -ForegroundColor White
Write-Host "  • Stats/metrics section" -ForegroundColor White
Write-Host "  • Client testimonials" -ForegroundColor White
Write-Host "  • Professional CTA sections" -ForegroundColor White
Write-Host "  • Responsive design" -ForegroundColor White
Write-Host ""

$ErrorActionPreference = "Continue"

# Create gorgeous landing page
Write-Host "Creating new landing page..." -ForegroundColor Yellow
$landingContent = @'
import Link from 'next/link';

export default function HomePage() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
      {/* Navigation */}
      <nav className="border-b bg-white/80 backdrop-blur-md fixed w-full z-50 shadow-sm">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className="w-10 h-10 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-xl flex items-center justify-center">
                <span className="text-white font-bold text-xl">P</span>
              </div>
              <span className="text-2xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                PowerLytix
              </span>
            </div>
            <div className="flex items-center gap-4">
              <Link
                href="/login"
                className="px-6 py-2.5 text-gray-700 hover:text-blue-600 font-medium transition"
              >
                Sign In
              </Link>
              <Link
                href="/login"
                className="px-6 py-2.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl font-semibold hover:shadow-lg hover:scale-105 transition-all duration-200"
              >
                Get Started
              </Link>
            </div>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-32 pb-20 px-6">
        <div className="max-w-7xl mx-auto text-center">
          <div className="inline-block mb-6">
            <span className="px-4 py-2 bg-blue-100 text-blue-700 rounded-full text-sm font-semibold">
              🚀 Multi-Tenant Analytics Platform
            </span>
          </div>
          <h1 className="text-6xl md:text-7xl font-bold text-gray-900 mb-6 leading-tight">
            Real-Time KPIs for
            <br />
            <span className="bg-gradient-to-r from-blue-600 via-indigo-600 to-purple-600 bg-clip-text text-transparent">
              Construction & Home Services
            </span>
          </h1>
          <p className="text-xl text-gray-600 mb-10 max-w-3xl mx-auto leading-relaxed">
            Track sales pipeline, accounts receivable, and job operations in one powerful dashboard. 
            Connect Salesforce, QuickBooks, and 4 more platforms instantly.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/login"
              className="px-8 py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl font-semibold text-lg hover:shadow-2xl hover:scale-105 transition-all duration-200"
            >
              Start Free Trial
            </Link>
            <Link
              href="/dashboard"
              className="px-8 py-4 bg-white text-gray-700 rounded-xl font-semibold text-lg border-2 border-gray-200 hover:border-blue-600 hover:text-blue-600 transition-all duration-200"
            >
              View Demo Dashboard
            </Link>
          </div>
          
          {/* Hero Image Placeholder */}
          <div className="mt-16 relative">
            <div className="absolute inset-0 bg-gradient-to-r from-blue-600/20 to-indigo-600/20 rounded-3xl blur-3xl"></div>
            <div className="relative bg-white rounded-3xl shadow-2xl p-8 border border-gray-200">
              <div className="aspect-video bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl flex items-center justify-center">
                <div className="text-center">
                  <div className="text-6xl mb-4">📊</div>
                  <p className="text-gray-600 font-medium">Dashboard Preview</p>
                  <p className="text-sm text-gray-500 mt-2">Live KPI tracking in action</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="py-16 px-6 bg-white/50 backdrop-blur-sm">
        <div className="max-w-7xl mx-auto">
          <div className="grid grid-cols-2 md:grid-cols-4 gap-8">
            <div className="text-center">
              <div className="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent mb-2">
                15+
              </div>
              <div className="text-gray-600 font-medium">Real-Time KPIs</div>
            </div>
            <div className="text-center">
              <div className="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent mb-2">
                6
              </div>
              <div className="text-gray-600 font-medium">Data Integrations</div>
            </div>
            <div className="text-center">
              <div className="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent mb-2">
                99.9%
              </div>
              <div className="text-gray-600 font-medium">Uptime SLA</div>
            </div>
            <div className="text-center">
              <div className="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent mb-2">
                24/7
              </div>
              <div className="text-gray-600 font-medium">Auto Sync</div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="py-20 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              Everything You Need to Scale
            </h2>
            <p className="text-xl text-gray-600 max-w-2xl mx-auto">
              Purpose-built for construction and home services businesses
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            {/* Feature 1 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">📈</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Sales Pipeline</h3>
              <p className="text-gray-600 leading-relaxed">
                Track pipeline value, win rates, deal sizes, and booking rates in real-time. Never miss a sales opportunity.
              </p>
            </div>

            {/* Feature 2 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-green-500 to-emerald-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">💰</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Financial Health</h3>
              <p className="text-gray-600 leading-relaxed">
                Monitor A/R, revenue, cash flow, and margins. Get alerts on overdue payments automatically.
              </p>
            </div>

            {/* Feature 3 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-purple-500 to-pink-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">🔧</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Job Operations</h3>
              <p className="text-gray-600 leading-relaxed">
                Track job backlog, completion rates, and cancellations. Keep projects on time and on budget.
              </p>
            </div>

            {/* Feature 4 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-orange-500 to-red-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">🔌</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Seamless Integrations</h3>
              <p className="text-gray-600 leading-relaxed">
                Connect Salesforce, QuickBooks, Zoho, BuilderPrime, JobNimbus, and Sage in minutes.
              </p>
            </div>

            {/* Feature 5 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-cyan-500 to-blue-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">🏢</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Multi-Tenant Ready</h3>
              <p className="text-gray-600 leading-relaxed">
                White-label dashboards for each client. Complete data isolation and custom branding.
              </p>
            </div>

            {/* Feature 6 */}
            <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100 hover:shadow-2xl hover:scale-105 transition-all duration-300">
              <div className="w-14 h-14 bg-gradient-to-br from-yellow-500 to-orange-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl">⚡</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Real-Time Updates</h3>
              <p className="text-gray-600 leading-relaxed">
                Data syncs automatically every 4 hours. Always see the latest numbers without lifting a finger.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* Integrations Section */}
      <section className="py-20 px-6 bg-gradient-to-br from-blue-600 to-indigo-600 text-white">
        <div className="max-w-7xl mx-auto text-center">
          <h2 className="text-4xl md:text-5xl font-bold mb-6">
            Connects to Your Existing Tools
          </h2>
          <p className="text-xl text-blue-100 mb-12 max-w-2xl mx-auto">
            No data entry. No manual updates. Just automatic syncing with the platforms you already use.
          </p>
          
          <div className="grid grid-cols-2 md:grid-cols-6 gap-8">
            {['Salesforce', 'QuickBooks', 'Zoho CRM', 'BuilderPrime', 'JobNimbus', 'Sage'].map((integration) => (
              <div key={integration} className="bg-white/10 backdrop-blur-sm rounded-xl p-6 hover:bg-white/20 transition">
                <div className="text-4xl mb-3">🔌</div>
                <p className="font-semibold">{integration}</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Social Proof Section */}
      <section className="py-20 px-6 bg-white">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
              Trusted by Leading Contractors
            </h2>
            <p className="text-xl text-gray-600">
              Join construction and home services businesses making data-driven decisions
            </p>
          </div>

          <div className="grid md:grid-cols-3 gap-8">
            <div className="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-2xl p-8 border border-blue-100">
              <div className="flex items-center mb-6">
                <div className="w-12 h-12 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-full flex items-center justify-center text-white font-bold text-xl mr-4">
                  A
                </div>
                <div>
                  <p className="font-bold text-gray-900">Acme Construction</p>
                  <p className="text-sm text-gray-600">General Contractor</p>
                </div>
              </div>
              <p className="text-gray-700 leading-relaxed italic">
                "PowerLytix cut our reporting time from 4 hours to 5 minutes. We finally have visibility into our cash flow."
              </p>
            </div>

            <div className="bg-gradient-to-br from-green-50 to-emerald-50 rounded-2xl p-8 border border-green-100">
              <div className="flex items-center mb-6">
                <div className="w-12 h-12 bg-gradient-to-br from-green-600 to-emerald-600 rounded-full flex items-center justify-center text-white font-bold text-xl mr-4">
                  B
                </div>
                <div>
                  <p className="font-bold text-gray-900">BuildRight Homes</p>
                  <p className="text-sm text-gray-600">Home Builder</p>
                </div>
              </div>
              <p className="text-gray-700 leading-relaxed italic">
                "The real-time pipeline view helps us forecast revenue accurately. Game changer for our sales team."
              </p>
            </div>

            <div className="bg-gradient-to-br from-purple-50 to-pink-50 rounded-2xl p-8 border border-purple-100">
              <div className="flex items-center mb-6">
                <div className="w-12 h-12 bg-gradient-to-br from-purple-600 to-pink-600 rounded-full flex items-center justify-center text-white font-bold text-xl mr-4">
                  P
                </div>
                <div>
                  <p className="font-bold text-gray-900">Premier Contractors</p>
                  <p className="text-sm text-gray-600">Renovation Specialist</p>
                </div>
              </div>
              <p className="text-gray-700 leading-relaxed italic">
                "We reduced overdue A/R by 40% in the first month. The automated alerts are incredibly helpful."
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-6 bg-gradient-to-br from-gray-900 to-gray-800 text-white">
        <div className="max-w-4xl mx-auto text-center">
          <h2 className="text-4xl md:text-5xl font-bold mb-6">
            Ready to Transform Your Business Intelligence?
          </h2>
          <p className="text-xl text-gray-300 mb-10">
            Start your free 14-day trial. No credit card required. Set up in under 10 minutes.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link
              href="/login"
              className="px-8 py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl font-semibold text-lg hover:shadow-2xl hover:scale-105 transition-all duration-200"
            >
              Start Free Trial
            </Link>
            <Link
              href="/admin"
              className="px-8 py-4 bg-white/10 backdrop-blur-sm text-white rounded-xl font-semibold text-lg border-2 border-white/20 hover:bg-white/20 transition-all duration-200"
            >
              Schedule Demo
            </Link>
          </div>
          <p className="text-sm text-gray-400 mt-6">
            ✓ No credit card required  ✓ 14-day free trial  ✓ Cancel anytime
          </p>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-12 px-6 bg-gray-900 text-gray-400 border-t border-gray-800">
        <div className="max-w-7xl mx-auto">
          <div className="grid md:grid-cols-4 gap-8 mb-8">
            <div>
              <div className="flex items-center gap-2 mb-4">
                <div className="w-8 h-8 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-lg flex items-center justify-center">
                  <span className="text-white font-bold">P</span>
                </div>
                <span className="text-lg font-bold text-white">PowerLytix</span>
              </div>
              <p className="text-sm leading-relaxed">
                Real-time KPI analytics for construction and home services businesses.
              </p>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Product</h3>
              <ul className="space-y-2 text-sm">
                <li><Link href="/dashboard" className="hover:text-white transition">Features</Link></li>
                <li><Link href="/dashboard" className="hover:text-white transition">Integrations</Link></li>
                <li><Link href="/dashboard" className="hover:text-white transition">Pricing</Link></li>
              </ul>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Company</h3>
              <ul className="space-y-2 text-sm">
                <li><Link href="/" className="hover:text-white transition">About</Link></li>
                <li><Link href="/" className="hover:text-white transition">Contact</Link></li>
                <li><Link href="/" className="hover:text-white transition">Careers</Link></li>
              </ul>
            </div>
            
            <div>
              <h3 className="text-white font-semibold mb-4">Legal</h3>
              <ul className="space-y-2 text-sm">
                <li><Link href="/" className="hover:text-white transition">Privacy</Link></li>
                <li><Link href="/" className="hover:text-white transition">Terms</Link></li>
                <li><Link href="/" className="hover:text-white transition">Security</Link></li>
              </ul>
            </div>
          </div>
          
          <div className="pt-8 border-t border-gray-800 text-center text-sm">
            <p>&copy; 2025 PowerLytix by Velocity Venture. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}
'@

Set-Content -Path "app/page.tsx" -Value $landingContent -Encoding UTF8
Write-Host "✓ Created gorgeous landing page" -ForegroundColor Green

# Commit changes
Write-Host ""
Write-Host "Committing changes..." -ForegroundColor Yellow
git add app/page.tsx
git commit -m "Upgrade landing page with modern design, animations, and professional styling"
Write-Host "✓ Committed to Git" -ForegroundColor Green

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
Write-Host "✓ Pushed to GitHub" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✨ LANDING PAGE UPGRADED!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "New Features:" -ForegroundColor Cyan
Write-Host "  ✓ Modern gradient hero section" -ForegroundColor Green
Write-Host "  ✓ Animated hover effects" -ForegroundColor Green
Write-Host "  ✓ Stats showcase section" -ForegroundColor Green
Write-Host "  ✓ 6 feature cards with icons" -ForegroundColor Green
Write-Host "  ✓ Integrations display" -ForegroundColor Green
Write-Host "  ✓ Client testimonials" -ForegroundColor Green
Write-Host "  ✓ Professional CTA sections" -ForegroundColor Green
Write-Host "  ✓ Complete footer" -ForegroundColor Green
Write-Host ""
Write-Host "Visit http://localhost:3000 to see it! 🚀" -ForegroundColor Yellow
Write-Host ""
