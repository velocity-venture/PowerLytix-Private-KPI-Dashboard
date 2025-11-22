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
