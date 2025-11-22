'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { AlertCircle, TrendingUp, Calendar } from 'lucide-react';
import Link from 'next/link';
import { AnimatedKPICard } from '@/components/animated-kpi-card';
import { LineChart, Line, BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, Area, AreaChart } from 'recharts';
import { motion } from 'framer-motion';

// Generate sparkline data (7 data points for last 7 days)
const generateSparklineData = (baseValue: number, volatility: number = 0.1) => {
  return Array.from({ length: 7 }, (_, i) => {
    const variance = (Math.random() - 0.5) * volatility * baseValue;
    return Math.max(0, baseValue + variance);
  });
};

// Generate trend data for charts (30 days)
const generateTrendData = (label: string, baseValue: number) => {
  return Array.from({ length: 30 }, (_, i) => ({
    day: i + 1,
    value: Math.max(0, baseValue + (Math.random() - 0.5) * baseValue * 0.3),
    label: `Day ${i + 1}`
  }));
};

const demoData = {
  topLine: [
    { id: '1', title: 'Total Marketing Spend', value: 45230, change: 8.2, trend: 'up' as const, prefix: '$', sparkline: generateSparklineData(45230) },
    { id: '2', title: 'Total Leads', value: 1247, change: 12.5, trend: 'up' as const, sparkline: generateSparklineData(1247) },
    { id: '3', title: 'Total Appointments', value: 892, change: 5.3, trend: 'up' as const, sparkline: generateSparklineData(892) },
    { id: '4', title: 'Total Sales', value: 234, change: -2.1, trend: 'down' as const, sparkline: generateSparklineData(234) },
    { id: '5', title: 'Net Revenue (Sold)', value: 1200000, change: 15.7, trend: 'up' as const, prefix: '$', sparkline: generateSparklineData(1200000) },
  ],
  marketing: [
    { id: '6', title: 'Google Ads Spend', value: 18450, change: 5.2, trend: 'up' as const, prefix: '$', sparkline: generateSparklineData(18450) },
    { id: '7', title: 'Facebook Leads', value: 423, change: 18.3, trend: 'up' as const, sparkline: generateSparklineData(423) },
    { id: '8', title: 'Cost Per Lead', value: 36.28, change: -8.5, trend: 'down' as const, prefix: '$', decimals: 2, sparkline: generateSparklineData(36.28) },
    { id: '9', title: 'ROAS', value: 4.2, change: 12.1, trend: 'up' as const, suffix: 'x', decimals: 1, sparkline: generateSparklineData(4.2, 0.2) },
  ],
  callCenter: [
    { id: '10', title: 'Leads Received', value: 847, change: 9.2, trend: 'up' as const, sparkline: generateSparklineData(847) },
    { id: '11', title: 'Appointment Set Rate', value: 68.5, change: 3.4, trend: 'up' as const, suffix: '%', decimals: 1, sparkline: generateSparklineData(68.5, 0.05) },
    { id: '12', title: 'Speed to Lead', value: 4.2, change: -15.3, trend: 'down' as const, suffix: ' mins', decimals: 1, sparkline: generateSparklineData(4.2, 0.3) },
    { id: '13', title: 'Confirmation Rate', value: 82.1, change: 5.7, trend: 'up' as const, suffix: '%', decimals: 1, sparkline: generateSparklineData(82.1, 0.05) },
  ],
  sales: [
    { id: '14', title: 'Issued Appointments', value: 580, change: 7.8, trend: 'up' as const, sparkline: generateSparklineData(580) },
    { id: '15', title: 'Raw Close Rate', value: 40.3, change: 2.1, trend: 'up' as const, suffix: '%', decimals: 1, sparkline: generateSparklineData(40.3, 0.05) },
    { id: '16', title: 'Average Sale', value: 5120, change: 8.9, trend: 'up' as const, prefix: '$', sparkline: generateSparklineData(5120) },
    { id: '17', title: 'Gross Margin', value: 28.4, change: 1.2, trend: 'up' as const, suffix: '%', decimals: 1, sparkline: generateSparklineData(28.4, 0.05) },
  ],
};

// Trend chart data
const revenueVsSpendData = generateTrendData('Revenue', 45000);
const leadsVsAppointmentsData = Array.from({ length: 30 }, (_, i) => ({
  day: i + 1,
  leads: Math.floor(Math.random() * 50) + 30,
  appointments: Math.floor(Math.random() * 35) + 20,
}));

export default function DashboardPage() {
  const [mounted, setMounted] = useState(false);
  const [selectedPeriod, setSelectedPeriod] = useState('30d');

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  return (
    <div className="container mx-auto p-6 space-y-8">
      {/* Header with Date Filter */}
      <motion.div
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
        className="flex items-center justify-between"
      >
        <div>
          <h1 className="text-4xl font-bold tracking-tight bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
            Dashboard
          </h1>
          <p className="text-muted-foreground mt-1">Real-time business metrics at a glance</p>
        </div>
        <div className="flex items-center gap-2">
          <Calendar className="w-5 h-5 text-muted-foreground" />
          {['7d', '30d', '90d'].map((period) => (
            <Button
              key={period}
              variant={selectedPeriod === period ? 'default' : 'outline'}
              size="sm"
              onClick={() => setSelectedPeriod(period)}
              className={selectedPeriod === period ? 'bg-gradient-to-r from-blue-600 to-indigo-600' : ''}
            >
              Last {period === '7d' ? '7 days' : period === '30d' ? '30 days' : '90 days'}
            </Button>
          ))}
        </div>
      </motion.div>

      {/* Demo Data Notice */}
      <motion.div
        initial={{ opacity: 0, scale: 0.95 }}
        animate={{ opacity: 1, scale: 1 }}
        transition={{ duration: 0.4, delay: 0.1 }}
      >
        <Card className="border-blue-200 bg-gradient-to-r from-blue-50 to-indigo-50">
          <CardContent className="pt-6">
            <div className="flex items-start gap-3">
              <AlertCircle className="w-5 h-5 text-blue-600 mt-0.5" />
              <div>
                <h3 className="font-semibold text-blue-900">📊 Sample Data Mode</h3>
                <p className="text-sm text-blue-700 mt-1">
                  Currently showing demo KPIs. Connect your data sources in{' '}
                  <Link href="/admin/integrations" className="underline font-medium hover:text-blue-900">
                    Settings
                  </Link>
                  {' '}to display real-time metrics.
                </p>
              </div>
            </div>
          </CardContent>
        </Card>
      </motion.div>

      {/* Top-Line Rollup */}
      <section>
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.2 }}
          className="flex items-center gap-2 mb-4"
        >
          <h2 className="text-2xl font-semibold">📈 Top-Line Rollup</h2>
          <Badge variant="outline" className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white border-0">
            5 KPIs
          </Badge>
        </motion.div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">
          {demoData.topLine.map((kpi, idx) => (
            <AnimatedKPICard
              key={kpi.id}
              title={kpi.title}
              value={kpi.value}
              change={kpi.change}
              trend={kpi.trend}
              sparklineData={kpi.sparkline}
              prefix={kpi.prefix}
              suffix={kpi.suffix}
              decimals={kpi.decimals}
              index={idx}
            />
          ))}
        </div>
      </section>

      {/* Trend Charts */}
      <section className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.4 }}
        >
          <Card className="border-2">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <TrendingUp className="w-5 h-5 text-green-600" />
                Revenue Trend (30 Days)
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={250}>
                <AreaChart data={revenueVsSpendData}>
                  <defs>
                    <linearGradient id="colorRevenue" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.8}/>
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0}/>
                    </linearGradient>
                  </defs>
                  <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                  <XAxis dataKey="day" stroke="#6b7280" />
                  <YAxis stroke="#6b7280" />
                  <Tooltip 
                    contentStyle={{ backgroundColor: '#fff', border: '2px solid #3b82f6', borderRadius: '8px' }}
                  />
                  <Area 
                    type="monotone" 
                    dataKey="value" 
                    stroke="#3b82f6" 
                    strokeWidth={3}
                    fillOpacity={1} 
                    fill="url(#colorRevenue)"
                    animationDuration={1500}
                  />
                </AreaChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.5 }}
        >
          <Card className="border-2">
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <TrendingUp className="w-5 h-5 text-indigo-600" />
                Leads vs Appointments (30 Days)
              </CardTitle>
            </CardHeader>
            <CardContent>
              <ResponsiveContainer width="100%" height={250}>
                <BarChart data={leadsVsAppointmentsData}>
                  <CartesianGrid strokeDasharray="3 3" stroke="#e5e7eb" />
                  <XAxis dataKey="day" stroke="#6b7280" />
                  <YAxis stroke="#6b7280" />
                  <Tooltip 
                    contentStyle={{ backgroundColor: '#fff', border: '2px solid #6366f1', borderRadius: '8px' }}
                  />
                  <Legend />
                  <Bar dataKey="leads" fill="#3b82f6" radius={[8, 8, 0, 0]} animationDuration={1500} />
                  <Bar dataKey="appointments" fill="#6366f1" radius={[8, 8, 0, 0]} animationDuration={1500} />
                </BarChart>
              </ResponsiveContainer>
            </CardContent>
          </Card>
        </motion.div>
      </section>

      {/* Marketing */}
      <section>
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.6 }}
          className="flex items-center gap-2 mb-4"
        >
          <h2 className="text-2xl font-semibold">📢 Marketing</h2>
          <Badge variant="outline" className="bg-gradient-to-r from-purple-600 to-pink-600 text-white border-0">
            4 KPIs
          </Badge>
        </motion.div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.marketing.map((kpi, idx) => (
            <AnimatedKPICard
              key={kpi.id}
              title={kpi.title}
              value={kpi.value}
              change={kpi.change}
              trend={kpi.trend}
              sparklineData={kpi.sparkline}
              prefix={kpi.prefix}
              suffix={kpi.suffix}
              decimals={kpi.decimals}
              index={idx}
            />
          ))}
        </div>
      </section>

      {/* Call Center */}
      <section>
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.7 }}
          className="flex items-center gap-2 mb-4"
        >
          <h2 className="text-2xl font-semibold">📞 Call Center</h2>
          <Badge variant="outline" className="bg-gradient-to-r from-green-600 to-emerald-600 text-white border-0">
            4 KPIs
          </Badge>
        </motion.div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.callCenter.map((kpi, idx) => (
            <AnimatedKPICard
              key={kpi.id}
              title={kpi.title}
              value={kpi.value}
              change={kpi.change}
              trend={kpi.trend}
              sparklineData={kpi.sparkline}
              prefix={kpi.prefix}
              suffix={kpi.suffix}
              decimals={kpi.decimals}
              index={idx}
            />
          ))}
        </div>
      </section>

      {/* Sales */}
      <section>
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5, delay: 0.8 }}
          className="flex items-center gap-2 mb-4"
        >
          <h2 className="text-2xl font-semibold">💰 Sales</h2>
          <Badge variant="outline" className="bg-gradient-to-r from-orange-600 to-red-600 text-white border-0">
            4 KPIs
          </Badge>
        </motion.div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.sales.map((kpi, idx) => (
            <AnimatedKPICard
              key={kpi.id}
              title={kpi.title}
              value={kpi.value}
              change={kpi.change}
              trend={kpi.trend}
              sparklineData={kpi.sparkline}
              prefix={kpi.prefix}
              suffix={kpi.suffix}
              decimals={kpi.decimals}
              index={idx}
            />
          ))}
        </div>
      </section>
    </div>
  );
}
