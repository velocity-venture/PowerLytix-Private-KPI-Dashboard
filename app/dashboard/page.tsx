'use client';

import { useState, useEffect } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { TrendingUp, TrendingDown, Minus, AlertCircle } from 'lucide-react';
import Link from 'next/link';

interface KPI {
  id: string;
  title: string;
  value: string;
  change: number;
  trend: 'up' | 'down' | 'neutral';
  unit?: string;
}

const demoData = {
  topLine: [
    { id: '1', title: 'Total Marketing Spend', value: '$45,230', change: 8.2, trend: 'up' as const, unit: '' },
    { id: '2', title: 'Total Leads', value: '1,247', change: 12.5, trend: 'up' as const, unit: '' },
    { id: '3', title: 'Total Appointments', value: '892', change: 5.3, trend: 'up' as const, unit: '' },
    { id: '4', title: 'Total Sales', value: '234', change: -2.1, trend: 'down' as const, unit: '' },
    { id: '5', title: 'Net Revenue (Sold)', value: '$1.2M', change: 15.7, trend: 'up' as const, unit: '' },
  ],
  marketing: [
    { id: '6', title: 'Google Ads Spend', value: '$18,450', change: 5.2, trend: 'up' as const, unit: '' },
    { id: '7', title: 'Facebook Leads', value: '423', change: 18.3, trend: 'up' as const, unit: '' },
    { id: '8', title: 'Cost Per Lead', value: '$36.28', change: -8.5, trend: 'down' as const, unit: '' },
    { id: '9', title: 'ROAS', value: '4.2x', change: 12.1, trend: 'up' as const, unit: '' },
  ],
  callCenter: [
    { id: '10', title: 'Leads Received', value: '847', change: 9.2, trend: 'up' as const, unit: '' },
    { id: '11', title: 'Appointment Set Rate', value: '68.5%', change: 3.4, trend: 'up' as const, unit: '' },
    { id: '12', title: 'Speed to Lead', value: '4.2 mins', change: -15.3, trend: 'down' as const, unit: '' },
    { id: '13', title: 'Confirmation Rate', value: '82.1%', change: 5.7, trend: 'up' as const, unit: '' },
  ],
  sales: [
    { id: '14', title: 'Issued Appointments', value: '580', change: 7.8, trend: 'up' as const, unit: '' },
    { id: '15', title: 'Raw Close Rate', value: '40.3%', change: 2.1, trend: 'up' as const, unit: '' },
    { id: '16', title: 'Average Sale', value: '$5,120', change: 8.9, trend: 'up' as const, unit: '' },
    { id: '17', title: 'Gross Margin', value: '28.4%', change: 1.2, trend: 'up' as const, unit: '' },
  ],
};

export default function DashboardPage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true);
  }, []);

  if (!mounted) {
    return null;
  }

  const renderKPICard = (kpi: KPI) => (
    <Card key={kpi.id} className="hover:shadow-lg transition-shadow">
      <CardHeader className="pb-2">
        <CardTitle className="text-sm font-medium text-muted-foreground">{kpi.title}</CardTitle>
      </CardHeader>
      <CardContent>
        <div className="flex items-baseline justify-between">
          <div className="text-2xl font-bold">{kpi.value}</div>
          <div className={`flex items-center text-sm ${
            kpi.trend === 'up' ? 'text-green-600' : 
            kpi.trend === 'down' ? 'text-red-600' : 
            'text-gray-600'
          }`}>
            {kpi.trend === 'up' && <TrendingUp className="w-4 h-4 mr-1" />}
            {kpi.trend === 'down' && <TrendingDown className="w-4 h-4 mr-1" />}
            {kpi.trend === 'neutral' && <Minus className="w-4 h-4 mr-1" />}
            <span>{Math.abs(kpi.change)}%</span>
          </div>
        </div>
      </CardContent>
    </Card>
  );

  return (
    <div className="container mx-auto p-6 space-y-8">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold tracking-tight">Dashboard</h1>
        <p className="text-muted-foreground">Real-time business metrics at a glance</p>
      </div>

      {/* Demo Data Notice */}
      <Card className="border-blue-200 bg-blue-50">
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

      {/* Top-Line Rollup */}
      <section>
        <div className="flex items-center gap-2 mb-4">
          <h2 className="text-xl font-semibold">📈 Top-Line Rollup</h2>
          <Badge variant="outline">5 KPIs</Badge>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5 gap-4">
          {demoData.topLine.map(renderKPICard)}
        </div>
      </section>

      {/* Marketing */}
      <section>
        <div className="flex items-center gap-2 mb-4">
          <h2 className="text-xl font-semibold">📢 Marketing</h2>
          <Badge variant="outline">4 KPIs</Badge>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.marketing.map(renderKPICard)}
        </div>
      </section>

      {/* Call Center */}
      <section>
        <div className="flex items-center gap-2 mb-4">
          <h2 className="text-xl font-semibold">📞 Call Center</h2>
          <Badge variant="outline">4 KPIs</Badge>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.callCenter.map(renderKPICard)}
        </div>
      </section>

      {/* Sales */}
      <section>
        <div className="flex items-center gap-2 mb-4">
          <h2 className="text-xl font-semibold">💰 Sales</h2>
          <Badge variant="outline">4 KPIs</Badge>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          {demoData.sales.map(renderKPICard)}
        </div>
      </section>
    </div>
  );
}
