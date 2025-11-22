'use client';

import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import Link from 'next/link';
import { 
  BarChart3, 
  TrendingUp, 
  Zap, 
  Shield, 
  Users, 
  ArrowRight,
  CheckCircle2,
  Sparkles,
  LineChart,
  Bell,
  Lock,
  Globe
} from 'lucide-react';

export default function LandingPage() {
  const [hoveredFeature, setHoveredFeature] = useState<number | null>(null);

  const features = [
    {
      icon: <BarChart3 className="w-6 h-6" />,
      title: '36 Critical KPIs',
      description: 'Track marketing, sales, call center, and canvassing metrics in real-time',
      color: 'from-blue-500 to-cyan-500'
    },
    {
      icon: <Zap className="w-6 h-6" />,
      title: 'Live Data Sync',
      description: 'Automatic updates from Salesforce, QuickBooks, Google Ads, and more',
      color: 'from-purple-500 to-pink-500'
    },
    {
      icon: <Shield className="w-6 h-6" />,
      title: 'White-Label Ready',
      description: 'Fully customizable branding for your construction business',
      color: 'from-orange-500 to-red-500'
    },
    {
      icon: <Users className="w-6 h-6" />,
      title: 'Multi-Tenant',
      description: 'Manage multiple client dashboards with complete data isolation',
      color: 'from-green-500 to-emerald-500'
    },
    {
      icon: <Bell className="w-6 h-6" />,
      title: 'Smart Alerts',
      description: 'Get notified when KPIs hit thresholds or trends shift',
      color: 'from-indigo-500 to-purple-500'
    },
    {
      icon: <Lock className="w-6 h-6" />,
      title: 'Enterprise Security',
      description: 'Bank-level encryption with role-based access control',
      color: 'from-slate-600 to-slate-800'
    }
  ];

  const integrations = [
    { name: 'Salesforce', logo: '☁️' },
    { name: 'QuickBooks', logo: '💚' },
    { name: 'Google Ads', logo: '🎯' },
    { name: 'Facebook Ads', logo: '📘' },
    { name: 'Zoho CRM', logo: '🔶' },
    { name: 'BuilderPrime', logo: '🏗️' }
  ];

  const stats = [
    { value: '36', label: 'KPIs Tracked' },
    { value: '8+', label: 'Integrations' },
    { value: '99.9%', label: 'Uptime' },
    { value: '<2s', label: 'Load Time' }
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
      {/* Navigation */}
      <nav className="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-lg border-b border-slate-200">
        <div className="container mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center">
                <LineChart className="w-6 h-6 text-white" />
              </div>
              <span className="text-xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                PowerLytix
              </span>
            </div>
            <Link href="/login">
              <Button size="lg" className="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700">
                Sign In
                <ArrowRight className="ml-2 w-4 h-4" />
              </Button>
            </Link>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <section className="pt-32 pb-20 px-6">
        <div className="container mx-auto max-w-6xl">
          <div className="text-center space-y-8">
            <Badge className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white px-4 py-2 text-sm">
              <Sparkles className="w-4 h-4 mr-2 inline" />
              Construction & Home Services Analytics
            </Badge>
            
            <h1 className="text-6xl md:text-7xl font-bold leading-tight">
              <span className="bg-gradient-to-r from-slate-900 via-blue-800 to-indigo-900 bg-clip-text text-transparent">
                Your Business Metrics,
              </span>
              <br />
              <span className="bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                Crystal Clear
              </span>
            </h1>

            <p className="text-xl text-slate-600 max-w-3xl mx-auto leading-relaxed">
              PowerLytix brings all your construction KPIs into one beautiful dashboard. 
              Track marketing ROI, sales performance, call center efficiency, and canvassing results in real-time.
            </p>

            <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
              <Link href="/login">
                <Button size="lg" className="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-lg px-8 py-6">
                  Get Started Free
                  <ArrowRight className="ml-2 w-5 h-5" />
                </Button>
              </Link>
              <Button size="lg" variant="outline" className="text-lg px-8 py-6 border-2 hover:border-blue-600">
                <Globe className="mr-2 w-5 h-5" />
                View Demo
              </Button>
            </div>

            {/* Stats Bar */}
            <div className="grid grid-cols-2 md:grid-cols-4 gap-6 pt-12">
              {stats.map((stat, idx) => (
                <div key={idx} className="text-center">
                  <div className="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                    {stat.value}
                  </div>
                  <div className="text-sm text-slate-600 mt-1">{stat.label}</div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-20 px-6 bg-white/50">
        <div className="container mx-auto max-w-6xl">
          <div className="text-center mb-16">
            <h2 className="text-4xl font-bold text-slate-900 mb-4">
              Everything You Need to Scale
            </h2>
            <p className="text-xl text-slate-600">
              Built specifically for construction and home services businesses
            </p>
          </div>

          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {features.map((feature, idx) => (
              <Card 
                key={idx}
                className={`border-2 transition-all duration-300 cursor-pointer ${
                  hoveredFeature === idx 
                    ? 'border-blue-500 shadow-xl scale-105' 
                    : 'border-slate-200 hover:border-blue-300'
                }`}
                onMouseEnter={() => setHoveredFeature(idx)}
                onMouseLeave={() => setHoveredFeature(null)}
              >
                <CardContent className="p-6 space-y-4">
                  <div className={`w-12 h-12 rounded-xl bg-gradient-to-br ${feature.color} flex items-center justify-center text-white`}>
                    {feature.icon}
                  </div>
                  <h3 className="text-xl font-semibold text-slate-900">
                    {feature.title}
                  </h3>
                  <p className="text-slate-600 leading-relaxed">
                    {feature.description}
                  </p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Integrations Section */}
      <section className="py-20 px-6">
        <div className="container mx-auto max-w-6xl">
          <div className="text-center mb-12">
            <h2 className="text-4xl font-bold text-slate-900 mb-4">
              Seamless Integrations
            </h2>
            <p className="text-xl text-slate-600">
              Connect your existing tools in minutes
            </p>
          </div>

          <div className="flex flex-wrap justify-center gap-6">
            {integrations.map((integration, idx) => (
              <Card key={idx} className="w-40 h-40 border-2 border-slate-200 hover:border-blue-500 transition-all hover:shadow-lg">
                <CardContent className="p-6 flex flex-col items-center justify-center h-full">
                  <div className="text-4xl mb-3">{integration.logo}</div>
                  <div className="text-sm font-medium text-slate-700">{integration.name}</div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-20 px-6 bg-gradient-to-br from-blue-600 to-indigo-600">
        <div className="container mx-auto max-w-4xl text-center text-white space-y-8">
          <h2 className="text-5xl font-bold">
            Ready to Transform Your Business?
          </h2>
          <p className="text-xl text-blue-100">
            Join construction companies already tracking their KPIs with PowerLytix
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center pt-4">
            <Link href="/login">
              <Button size="lg" className="bg-white text-blue-600 hover:bg-blue-50 text-lg px-8 py-6">
                Start Free Trial
                <ArrowRight className="ml-2 w-5 h-5" />
              </Button>
            </Link>
            <Button size="lg" variant="outline" className="text-white border-2 border-white hover:bg-white/10 text-lg px-8 py-6">
              Schedule Demo
            </Button>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="py-12 px-6 bg-slate-900 text-slate-400">
        <div className="container mx-auto max-w-6xl text-center">
          <div className="flex items-center justify-center gap-2 mb-4">
            <LineChart className="w-6 h-6 text-blue-500" />
            <span className="text-lg font-semibold text-white">PowerLytix</span>
          </div>
          <p className="text-sm">
            © 2024 PowerLytix. Built for construction and home services businesses.
          </p>
        </div>
      </footer>
    </div>
  );
}
