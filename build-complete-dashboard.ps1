# PowerLytix Dashboard - Automated Build Script
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PowerLytix Dashboard - Automated Builder" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$ErrorActionPreference = "Continue"

# Create app/login/page.tsx
Write-Host "Creating login page..." -ForegroundColor Yellow
$loginPageContent = @'
'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';

export default function LoginPage() {
  const router = useRouter();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    try {
      if (email && password) {
        router.push('/dashboard');
      } else {
        setError('Please enter email and password');
      }
    } catch (err) {
      setError('Login failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100 px-4">
      <div className="max-w-md w-full bg-white rounded-2xl shadow-xl p-8">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900">PowerLytix</h1>
          <p className="text-gray-600 mt-2">Sign in to your dashboard</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-2">
              Email Address
            </label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
              placeholder="you@company.com"
              required
            />
          </div>

          <div>
            <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-2">
              Password
            </label>
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
              placeholder="••••••••"
              required
            />
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-lg text-sm">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-lg transition disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {loading ? 'Signing in...' : 'Sign In'}
          </button>
        </form>

        <p className="text-center text-sm text-gray-600 mt-6">
          Demo Mode: Use any email/password to test
        </p>
      </div>
    </div>
  );
}
'@

New-Item -Path "app/login" -ItemType Directory -Force | Out-Null
Set-Content -Path "app/login/page.tsx" -Value $loginPageContent -Encoding UTF8
Write-Host "  ✓ app/login/page.tsx" -ForegroundColor Green

# Create app/admin/page.tsx
Write-Host "Creating admin dashboard..." -ForegroundColor Yellow
$adminPageContent = @'
export default function AdminPage() {
  const systemMetrics = [
    { label: 'Total Clients', value: '12', change: '+2 this month' },
    { label: 'Active Users', value: '47', change: '+8 this week' },
    { label: 'API Calls (24h)', value: '1,247', change: '↑ 15%' },
    { label: 'System Uptime', value: '99.8%', change: 'Last 30 days' },
  ];

  const recentClients = [
    { name: 'Acme Construction', slug: 'acme', users: 5, status: 'Active' },
    { name: 'BuildRight Homes', slug: 'buildright', users: 8, status: 'Active' },
    { name: 'Premier Contractors', slug: 'premier', users: 3, status: 'Trial' },
  ];

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        <h1 className="text-4xl font-bold text-gray-900 mb-2">Admin Dashboard</h1>
        <p className="text-gray-600 mb-8">System overview and client management</p>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
          {systemMetrics.map((metric) => (
            <div key={metric.label} className="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
              <p className="text-sm text-gray-600 mb-1">{metric.label}</p>
              <p className="text-3xl font-bold text-gray-900 mb-2">{metric.value}</p>
              <p className="text-xs text-gray-500">{metric.change}</p>
            </div>
          ))}
        </div>

        <div className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div className="px-6 py-4 border-b border-gray-200">
            <h2 className="text-xl font-semibold text-gray-900">Recent Clients</h2>
          </div>
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Client Name</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Slug</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Users</th>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-200">
              {recentClients.map((client) => (
                <tr key={client.slug} className="hover:bg-gray-50">
                  <td className="px-6 py-4 text-sm font-medium text-gray-900">{client.name}</td>
                  <td className="px-6 py-4 text-sm text-gray-600">{client.slug}</td>
                  <td className="px-6 py-4 text-sm text-gray-600">{client.users}</td>
                  <td className="px-6 py-4 text-sm">
                    <span className={`px-2 py-1 rounded-full text-xs font-semibold ${
                      client.status === 'Active' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'
                    }`}>
                      {client.status}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
'@

New-Item -Path "app/admin" -ItemType Directory -Force | Out-Null
Set-Content -Path "app/admin/page.tsx" -Value $adminPageContent -Encoding UTF8
Write-Host "  ✓ app/admin/page.tsx" -ForegroundColor Green

# Create components/ui/card.tsx
Write-Host "Creating Card component..." -ForegroundColor Yellow
New-Item -Path "components/ui" -ItemType Directory -Force | Out-Null
$cardContent = @'
import * as React from "react"
import { cn } from "@/lib/utils"

const Card = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn(
      "rounded-xl border bg-card text-card-foreground shadow",
      className
    )}
    {...props}
  />
))
Card.displayName = "Card"

const CardHeader = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex flex-col space-y-1.5 p-6", className)}
    {...props}
  />
))
CardHeader.displayName = "CardHeader"

const CardTitle = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLHeadingElement>
>(({ className, ...props }, ref) => (
  <h3
    ref={ref}
    className={cn("font-semibold leading-none tracking-tight", className)}
    {...props}
  />
))
CardTitle.displayName = "CardTitle"

const CardDescription = React.forwardRef<
  HTMLParagraphElement,
  React.HTMLAttributes<HTMLParagraphElement>
>(({ className, ...props }, ref) => (
  <p
    ref={ref}
    className={cn("text-sm text-muted-foreground", className)}
    {...props}
  />
))
CardDescription.displayName = "CardDescription"

const CardContent = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div ref={ref} className={cn("p-6 pt-0", className)} {...props} />
))
CardContent.displayName = "CardContent"

const CardFooter = React.forwardRef<
  HTMLDivElement,
  React.HTMLAttributes<HTMLDivElement>
>(({ className, ...props }, ref) => (
  <div
    ref={ref}
    className={cn("flex items-center p-6 pt-0", className)}
    {...props}
  />
))
CardFooter.displayName = "CardFooter"

export { Card, CardHeader, CardFooter, CardTitle, CardDescription, CardContent }
'@

Set-Content -Path "components/ui/card.tsx" -Value $cardContent -Encoding UTF8
Write-Host "  ✓ components/ui/card.tsx" -ForegroundColor Green

# Create components/kpi-card.tsx
Write-Host "Creating KPI Card component..." -ForegroundColor Yellow
$kpiCardContent = @'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

interface KpiCardProps {
  title: string;
  value: string;
  change?: string;
  trend?: 'up' | 'down' | 'neutral';
  icon?: React.ReactNode;
}

export function KpiCard({ title, value, change, trend = 'neutral', icon }: KpiCardProps) {
  const trendColors = {
    up: 'text-green-600',
    down: 'text-red-600',
    neutral: 'text-gray-600',
  };

  return (
    <Card>
      <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
        <CardTitle className="text-sm font-medium text-gray-600">
          {title}
        </CardTitle>
        {icon && <div className="text-gray-400">{icon}</div>}
      </CardHeader>
      <CardContent>
        <div className="text-3xl font-bold text-gray-900">{value}</div>
        {change && (
          <p className={`text-xs mt-2 ${trendColors[trend]}`}>
            {change}
          </p>
        )}
      </CardContent>
    </Card>
  );
}
'@

Set-Content -Path "components/kpi-card.tsx" -Value $kpiCardContent -Encoding UTF8
Write-Host "  ✓ components/kpi-card.tsx" -ForegroundColor Green

# Create app/dashboard/page.tsx
Write-Host "Creating KPI dashboard..." -ForegroundColor Yellow
$dashboardPageContent = @'
import { KpiCard } from "@/components/kpi-card";

export default function DashboardPage() {
  const kpis = [
    {
      title: "Pipeline Value",
      value: "$847,320",
      change: "+12.5% from last month",
      trend: "up" as const,
    },
    {
      title: "Win Rate (90d)",
      value: "34.2%",
      change: "+2.1% from last quarter",
      trend: "up" as const,
    },
    {
      title: "Revenue MTD",
      value: "$156,480",
      change: "67% of monthly goal",
      trend: "neutral" as const,
    },
    {
      title: "Outstanding A/R",
      value: "$42,150",
      change: "-8% from last month",
      trend: "up" as const,
    },
    {
      title: "Job Backlog Value",
      value: "$1.2M",
      change: "+18% from last month",
      trend: "up" as const,
    },
    {
      title: "Gross Margin %",
      value: "28.4%",
      change: "+1.2% from last month",
      trend: "up" as const,
    },
  ];

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">Dashboard</h1>
          <p className="text-gray-600">Real-time business metrics at a glance</p>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {kpis.map((kpi) => (
            <KpiCard
              key={kpi.title}
              title={kpi.title}
              value={kpi.value}
              change={kpi.change}
              trend={kpi.trend}
            />
          ))}
        </div>

        <div className="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
          <h2 className="text-lg font-semibold text-blue-900 mb-2">
            📊 Sample Data Mode
          </h2>
          <p className="text-blue-800 text-sm">
            Currently showing demo KPIs. Connect your data sources in Settings to display real-time metrics.
          </p>
        </div>
      </div>
    </div>
  );
}
'@

New-Item -Path "app/dashboard" -ItemType Directory -Force | Out-Null
Set-Content -Path "app/dashboard/page.tsx" -Value $dashboardPageContent -Encoding UTF8
Write-Host "  ✓ app/dashboard/page.tsx" -ForegroundColor Green

# Git operations
Write-Host ""
Write-Host "Committing to Git..." -ForegroundColor Yellow
git add .
git commit -m "Add login page, admin dashboard, and KPI dashboard components"
Write-Host "  ✓ Committed" -ForegroundColor Green

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
Write-Host "  ✓ Pushed" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "BUILD COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Created Files:" -ForegroundColor Cyan
Write-Host "  ✓ app/login/page.tsx" -ForegroundColor Green
Write-Host "  ✓ app/admin/page.tsx" -ForegroundColor Green
Write-Host "  ✓ app/dashboard/page.tsx" -ForegroundColor Green
Write-Host "  ✓ components/ui/card.tsx" -ForegroundColor Green
Write-Host "  ✓ components/kpi-card.tsx" -ForegroundColor Green
Write-Host ""
Write-Host "Test Your Pages:" -ForegroundColor Cyan
Write-Host "  Login:     http://localhost:3000/login" -ForegroundColor White
Write-Host "  Admin:     http://localhost:3000/admin" -ForegroundColor White
Write-Host "  Dashboard: http://localhost:3000/dashboard" -ForegroundColor White
Write-Host ""
