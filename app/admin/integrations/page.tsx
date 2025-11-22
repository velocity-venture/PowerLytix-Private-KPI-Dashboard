'use client';

import { useState } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';

interface Integration {
  id: string;
  name: string;
  type: string;
  icon: string;
  isConnected: boolean;
  description: string;
}

export default function IntegrationsPage() {
  const [integrations, setIntegrations] = useState<Integration[]>([
    {
      id: '1',
      name: 'Salesforce',
      type: 'salesforce',
      icon: '☁️',
      isConnected: false,
      description: 'Connect to Salesforce for CRM data and sales pipeline tracking'
    },
    {
      id: '2',
      name: 'QuickBooks Online',
      type: 'quickbooks',
      icon: '💚',
      isConnected: false,
      description: 'Sync financial data, invoices, and revenue from QuickBooks'
    },
    {
      id: '3',
      name: 'Google Ads',
      type: 'google_ads',
      icon: '🎯',
      isConnected: false,
      description: 'Track ad spend, leads generated, and ROAS from Google Ads'
    },
    {
      id: '4',
      name: 'Facebook Ads',
      type: 'facebook_ads',
      icon: '📘',
      isConnected: false,
      description: 'Monitor Facebook advertising spend and lead performance'
    },
    {
      id: '5',
      name: 'Zoho CRM',
      type: 'zoho',
      icon: '🔶',
      isConnected: false,
      description: 'Connect Zoho CRM for sales pipeline and customer data'
    },
    {
      id: '6',
      name: 'Custom Data Source',
      type: 'custom',
      icon: '🔌',
      isConnected: false,
      description: 'Connect your custom data source via API webhook'
    }
  ]);

  const [selectedIntegration, setSelectedIntegration] = useState<Integration | null>(null);
  const [apiKey, setApiKey] = useState('');
  const [apiSecret, setApiSecret] = useState('');
  const [testingConnection, setTestingConnection] = useState(false);

  const handleConnect = () => {
    console.log('Connecting:', { apiKey, apiSecret, type: selectedIntegration?.type });
    
    setIntegrations(integrations.map(int => 
      int.id === selectedIntegration?.id 
        ? { ...int, isConnected: true }
        : int
    ));
    
    setSelectedIntegration(null);
    setApiKey('');
    setApiSecret('');
    
    alert(`Successfully connected to ${selectedIntegration?.name}!`);
  };

  const handleTestConnection = async () => {
    setTestingConnection(true);
    await new Promise(resolve => setTimeout(resolve, 1500));
    setTestingConnection(false);
    alert('Connection test successful! ✓');
  };

  const handleDisconnect = (integration: Integration) => {
    setIntegrations(integrations.map(int => 
      int.id === integration.id 
        ? { ...int, isConnected: false }
        : int
    ));
    alert(`Disconnected from ${integration.name}`);
  };

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-7xl mx-auto">
        <div className="mb-8">
          <h1 className="text-4xl font-bold text-gray-900 mb-2">Integrations</h1>
          <p className="text-gray-600">Connect your data sources to automatically track all 36 KPIs</p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {integrations.map((integration) => (
            <Card key={integration.id} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-center justify-between mb-2">
                  <div className="flex items-center gap-3">
                    <span className="text-4xl">{integration.icon}</span>
                    <CardTitle className="text-lg">{integration.name}</CardTitle>
                  </div>
                </div>
                <Badge variant={integration.isConnected ? 'success' : 'secondary'} className="w-fit">
                  {integration.isConnected ? '✓ Connected' : 'Not Connected'}
                </Badge>
              </CardHeader>
              <CardContent>
                <p className="text-sm text-gray-600 mb-4">{integration.description}</p>
                {integration.isConnected ? (
                  <div className="space-y-2">
                    <Button
                      variant="outline"
                      className="w-full"
                      onClick={() => handleDisconnect(integration)}
                    >
                      Disconnect
                    </Button>
                    <div className="text-xs text-gray-500 text-center">
                      Last synced: 5 minutes ago
                    </div>
                  </div>
                ) : (
                  <Button
                    className="w-full bg-blue-600 hover:bg-blue-700"
                    onClick={() => setSelectedIntegration(integration)}
                  >
                    Connect Now
                  </Button>
                )}
              </CardContent>
            </Card>
          ))}
        </div>

        {selectedIntegration && (
          <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <div className="bg-white rounded-2xl max-w-md w-full p-6">
              <div className="flex items-center gap-3 mb-6">
                <span className="text-4xl">{selectedIntegration.icon}</span>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900">
                    Connect {selectedIntegration.name}
                  </h2>
                  <p className="text-sm text-gray-600">Enter your API credentials below</p>
                </div>
              </div>

              <div className="space-y-4 mb-6">
                <div>
                  <Label htmlFor="apiKey">API Key / Client ID</Label>
                  <Input
                    id="apiKey"
                    type="text"
                    value={apiKey}
                    onChange={(e) => setApiKey(e.target.value)}
                    placeholder="Enter your API key"
                    className="mt-1"
                  />
                </div>

                <div>
                  <Label htmlFor="apiSecret">API Secret / Client Secret (Optional)</Label>
                  <Input
                    id="apiSecret"
                    type="password"
                    value={apiSecret}
                    onChange={(e) => setApiSecret(e.target.value)}
                    placeholder="Enter your API secret"
                    className="mt-1"
                  />
                </div>

                <div className="bg-blue-50 border border-blue-200 rounded-lg p-3">
                  <p className="text-xs text-blue-800">
                    <strong>💡 Tip:</strong> Find your API credentials in {selectedIntegration.name} settings under API or Developer section.
                  </p>
                </div>
              </div>

              <div className="flex gap-3">
                <Button
                  variant="outline"
                  className="flex-1"
                  onClick={() => {
                    setSelectedIntegration(null);
                    setApiKey('');
                    setApiSecret('');
                  }}
                >
                  Cancel
                </Button>
                <Button
                  variant="outline"
                  onClick={handleTestConnection}
                  disabled={!apiKey || testingConnection}
                >
                  {testingConnection ? 'Testing...' : 'Test'}
                </Button>
                <Button
                  className="flex-1 bg-blue-600 hover:bg-blue-700"
                  onClick={handleConnect}
                  disabled={!apiKey}
                >
                  Connect
                </Button>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
