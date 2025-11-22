import { KpiCard } from "@/components/kpi-card";
import { Skeleton } from "@/components/ui/skeleton";

interface KpiData {
  title: string;
  value: string;
  change?: string;
  trend?: 'up' | 'down' | 'neutral';
}

interface KpiGridProps {
  kpis: KpiData[];
  loading?: boolean;
}

export function KpiGrid({ kpis, loading = false }: KpiGridProps) {
  if (loading) {
    return (
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {Array.from({ length: 6 }).map((_, i) => (
          <div key={i} className="space-y-3">
            <Skeleton className="h-[120px] w-full" />
          </div>
        ))}
      </div>
    );
  }

  return (
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
  );
}
