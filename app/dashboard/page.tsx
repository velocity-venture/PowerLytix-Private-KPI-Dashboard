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
            ðŸ“Š Sample Data Mode
          </h2>
          <p className="text-blue-800 text-sm">
            Currently showing demo KPIs. Connect your data sources in Settings to display real-time metrics.
          </p>
        </div>
      </div>
    </div>
  );
}
