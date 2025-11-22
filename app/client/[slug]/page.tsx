import { getClientBySlug } from '@/lib/clients';
import { getLatestKpisForClient } from '@/lib/kpis';
import { KpiGrid } from '@/components/kpi-grid';
import { notFound } from 'next/navigation';

export default async function ClientDashboardPage({
  params,
}: {
  params: { slug: string };
}) {
  const client = await getClientBySlug(params.slug);
  
  if (!client) {
    notFound();
  }

  const kpis = await getLatestKpisForClient(client.id);
  
  const formattedKpis = kpis.map(kpi => ({
    title: kpi.kpi_name,
    value: kpi.value_formatted,
    change: kpi.change_percentage ? `${kpi.change_percentage > 0 ? '+' : ''}${kpi.change_percentage}%` : undefined,
    trend: kpi.trend,
  }));

  return (
    <div className="p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h2 className="text-3xl font-bold text-gray-900">Dashboard</h2>
          <p className="text-gray-600 mt-2">Real-time business metrics</p>
        </div>
        
        <KpiGrid kpis={formattedKpis} />
        
        {kpis.length === 0 && (
          <div className="mt-8 bg-yellow-50 border border-yellow-200 rounded-xl p-6">
            <h3 className="text-lg font-semibold text-yellow-900 mb-2">
              No Data Yet
            </h3>
            <p className="text-yellow-800 text-sm">
              KPI data will appear here once your data sources are connected and synced.
            </p>
          </div>
        )}
      </div>
    </div>
  );
}
