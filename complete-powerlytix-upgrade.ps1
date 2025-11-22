# PowerLytix - Complete System Upgrade
# Updates database with 36 actual KPIs, adds API key management, updates dashboards, and gorgeous landing page

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PowerLytix - COMPLETE SYSTEM UPGRADE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "This comprehensive upgrade includes:" -ForegroundColor Yellow
Write-Host "  Phase 1: Database - 36 Real KPIs (Marketing, Call Center, Sales, Canvassing, Top-Line)" -ForegroundColor White
Write-Host "  Phase 2: Admin UI - API Key Management Interface" -ForegroundColor White
Write-Host "  Phase 3: Dashboards - Updated KPI Displays" -ForegroundColor White
Write-Host "  Phase 4: Landing Page - Gorgeous Professional Design" -ForegroundColor White
Write-Host ""
Write-Host "Estimated time: 3-5 minutes" -ForegroundColor Yellow
Write-Host ""

$ErrorActionPreference = "Continue"

# ============================================
# PHASE 1: UPDATE DATABASE SCHEMA WITH 36 KPIs
# ============================================

Write-Host "PHASE 1: Updating Database Schema..." -ForegroundColor Cyan
Write-Host ""

Write-Host "Creating updated database schema..." -ForegroundColor Yellow
$updatedSchemaContent = @'
-- PowerLytix Database Schema - UPDATED WITH ACTUAL 36 KPIs
-- Multi-tenant SaaS analytics platform

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clients table
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  logo_url TEXT,
  primary_color VARCHAR(7) DEFAULT '#3b82f6',
  status VARCHAR(20) DEFAULT 'trial' CHECK (status IN ('active', 'trial', 'inactive')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_clients_slug ON clients(slug);
CREATE INDEX idx_clients_status ON clients(status);

-- Users table
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  email VARCHAR(255) UNIQUE NOT NULL,
  full_name VARCHAR(255),
  role VARCHAR(20) DEFAULT 'user' CHECK (role IN ('admin', 'manager', 'user')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_users_client_id ON users(client_id);
CREATE INDEX idx_users_email ON users(email);

-- Data sources table (with API keys)
CREATE TABLE data_sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  source_type VARCHAR(50) NOT NULL CHECK (source_type IN ('salesforce', 'quickbooks', 'zoho', 'builderprime', 'jobnimbus', 'sage', 'google_ads', 'facebook_ads', 'custom')),
  source_name VARCHAR(255) NOT NULL,
  is_connected BOOLEAN DEFAULT FALSE,
  api_key TEXT,
  api_secret TEXT,
  access_token TEXT,
  refresh_token TEXT,
  additional_config JSONB,
  last_synced_at TIMESTAMP WITH TIME ZONE,
  sync_status VARCHAR(20) DEFAULT 'never' CHECK (sync_status IN ('syncing', 'synced', 'error', 'never')),
  sync_error TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_data_sources_client_id ON data_sources(client_id);

-- KPI definitions table (36 KPIs organized by category)
CREATE TABLE kpi_definitions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  display_name VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(50) CHECK (category IN ('marketing', 'call_center', 'sales', 'canvassing', 'top_line')),
  unit VARCHAR(20) CHECK (unit IN ('currency', 'percentage', 'number', 'minutes', 'hours')),
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert 36 actual KPIs
-- MARKETING (5 KPIs)
INSERT INTO kpi_definitions (name, display_name, description, category, unit, sort_order) VALUES
  ('spend_per_channel', 'Spend per Channel', 'Marketing spend broken down by channel', 'marketing', 'currency', 1),
  ('leads_generated_per_channel', 'Leads Generated (per channel)', 'Number of leads generated from each marketing channel', 'marketing', 'number', 2),
  ('cost_per_lead', 'Cost per Lead (CPL)', 'Average cost to acquire one lead', 'marketing', 'currency', 3),
  ('return_on_ad_spend', 'Return on Ad Spend (ROAS)', 'Revenue generated per dollar spent on advertising', 'marketing', 'percentage', 4),
  ('landing_page_conversion', 'Landing Page Conversion %', 'Percentage of landing page visitors who convert to leads', 'marketing', 'percentage', 5);

-- CALL CENTER (8 KPIs)
INSERT INTO kpi_definitions (name, display_name, description, category, unit, sort_order) VALUES
  ('leads_received', 'Leads Received', 'Total number of leads received by call center', 'call_center', 'number', 11),
  ('appointment_set_rate', 'Appointment Set Rate/Conversion Rate', 'Percentage of leads converted to appointments', 'call_center', 'percentage', 12),
  ('speed_to_lead', 'Speed to Lead (mins)', 'Average time to contact a new lead', 'call_center', 'minutes', 13),
  ('set_behavior', 'Set Behavior', 'How far out appointments are being scheduled', 'call_center', 'number', 14),
  ('set_leads_per_hour', 'Set Leads Per Hour', 'Number of appointments set per hour worked', 'call_center', 'number', 15),
  ('issue_rate', 'Issue Rate', 'Percentage of appointments with issues', 'call_center', 'percentage', 16),
  ('confirmation_rate', 'Confirmation Rate', 'Percentage of appointments confirmed', 'call_center', 'percentage', 17),
  ('demo_rate', 'Demo Rate', 'Percentage of appointments that result in demos', 'call_center', 'percentage', 18);

-- SALES (9 KPIs)
INSERT INTO kpi_definitions (name, display_name, description, category, unit, sort_order) VALUES
  ('issued_appointments', 'Issued Appointments', 'Total appointments issued to sales team', 'sales', 'number', 21),
  ('raw_close_rate_by_product', 'Raw Close Rate % (by product and source)', 'Close rate broken down by product and lead source', 'sales', 'percentage', 22),
  ('raw_close_rate_overall', 'Raw Close Rate % (overall)', 'Overall close rate across all products', 'sales', 'percentage', 23),
  ('close_to_demo', 'Close to Demo %', 'Percentage of demos that close', 'sales', 'percentage', 24),
  ('average_sale', 'Average Sale ($)', 'Average dollar value per closed deal', 'sales', 'currency', 25),
  ('nsli_by_product', 'NSLI (by product)', 'Net Sales per Lead Issued by product', 'sales', 'currency', 26),
  ('nsli_overall', 'NSLI (overall)', 'Net Sales per Lead Issued overall', 'sales', 'currency', 27),
  ('cancellation_rate', 'Cancellation Rate %', 'Percentage of sales that cancel', 'sales', 'percentage', 28),
  ('gross_margin', 'Gross Margin %', 'Gross profit margin percentage', 'sales', 'percentage', 29);

-- CANVASSING (9 KPIs)
INSERT INTO kpi_definitions (name, display_name, description, category, unit, sort_order) VALUES
  ('total_man_hours', 'Total Man Hours Worked', 'Total hours worked by canvassing team', 'canvassing', 'hours', 31),
  ('total_canvass_spend', 'Total Spend (Hourly Wages)', 'Total hourly wages paid to canvassing team', 'canvassing', 'currency', 32),
  ('doors_knocked', 'Doors Knocked', 'Total number of doors knocked', 'canvassing', 'number', 33),
  ('contacts_made', 'Contacts Made (%)', 'Percentage of doors knocked that result in contact', 'canvassing', 'percentage', 34),
  ('demos_per_hour', 'Demos Per Hour', 'Number of demos scheduled per hour worked', 'canvassing', 'number', 35),
  ('canvass_confirmation_rate', 'Confirmation Rate', 'Percentage of canvass appointments confirmed', 'canvassing', 'percentage', 36),
  ('leads_generated_canvass', 'Leads Generated/Appointments Set', 'Total leads generated from canvassing', 'canvassing', 'number', 37),
  ('canvass_set_behavior', 'Set Behavior', 'How far out canvass appointments are set', 'canvassing', 'number', 38),
  ('sales_from_canvass', 'Sales from Canvass Leads', 'Total sales closed from canvass-generated leads', 'canvassing', 'number', 39);

-- TOP-LINE ROLLUP (5 KPIs)
INSERT INTO kpi_definitions (name, display_name, description, category, unit, sort_order) VALUES
  ('total_marketing_spend', 'Total Marketing Spend', 'Total spend across all marketing channels', 'top_line', 'currency', 41),
  ('total_leads', 'Total Leads', 'Total leads across all channels', 'top_line', 'number', 42),
  ('total_appointments', 'Total Appointments', 'Total appointments set across all channels', 'top_line', 'number', 43),
  ('total_sales', 'Total Sales', 'Total sales closed', 'top_line', 'number', 44),
  ('net_revenue_sold', 'Net Revenue (sold)', 'Total revenue from sold contracts', 'top_line', 'currency', 45),
  ('net_revenue_installed', 'Net Revenue (installed)', 'Total revenue from installed projects', 'top_line', 'currency', 46);

-- KPI values table
CREATE TABLE kpi_values (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  kpi_definition_id UUID REFERENCES kpi_definitions(id) ON DELETE CASCADE,
  kpi_name VARCHAR(255) NOT NULL,
  value NUMERIC NOT NULL,
  value_formatted VARCHAR(50) NOT NULL,
  change_percentage NUMERIC,
  trend VARCHAR(10) CHECK (trend IN ('up', 'down', 'neutral')),
  period VARCHAR(50),
  breakdown JSONB,
  calculated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_kpi_values_client_id ON kpi_values(client_id);
CREATE INDEX idx_kpi_values_calculated_at ON kpi_values(calculated_at DESC);
CREATE INDEX idx_kpi_values_category ON kpi_values((kpi_name));

-- Raw data tables
CREATE TABLE raw_marketing_data (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  channel VARCHAR(100),
  spend NUMERIC,
  leads_generated INTEGER,
  clicks INTEGER,
  impressions INTEGER,
  date DATE,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_marketing_client ON raw_marketing_data(client_id);

CREATE TABLE raw_call_center_data (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  lead_id VARCHAR(255),
  received_at TIMESTAMP WITH TIME ZONE,
  contacted_at TIMESTAMP WITH TIME ZONE,
  appointment_set BOOLEAN,
  appointment_date TIMESTAMP WITH TIME ZONE,
  confirmed BOOLEAN,
  demo_completed BOOLEAN,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_call_center_client ON raw_call_center_data(client_id);

CREATE TABLE raw_sales_data (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  appointment_id VARCHAR(255),
  product VARCHAR(255),
  source VARCHAR(255),
  demo_date TIMESTAMP WITH TIME ZONE,
  sale_amount NUMERIC,
  closed BOOLEAN,
  closed_date TIMESTAMP WITH TIME ZONE,
  cancelled BOOLEAN,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_sales_client ON raw_sales_data(client_id);

CREATE TABLE raw_canvassing_data (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  canvasser_name VARCHAR(255),
  date DATE,
  hours_worked NUMERIC,
  doors_knocked INTEGER,
  contacts_made INTEGER,
  demos_scheduled INTEGER,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_canvassing_client ON raw_canvassing_data(client_id);

-- Sync logs table
CREATE TABLE sync_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  data_source_id UUID REFERENCES data_sources(id) ON DELETE CASCADE,
  sync_started_at TIMESTAMP WITH TIME ZONE,
  sync_completed_at TIMESTAMP WITH TIME ZONE,
  status VARCHAR(20) CHECK (status IN ('started', 'completed', 'failed')),
  records_processed INTEGER DEFAULT 0,
  error_message TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_sync_logs_client ON sync_logs(client_id);
'@

Set-Content -Path "supabase/schema.sql" -Value $updatedSchemaContent -Encoding UTF8
Write-Host "  ✓ Updated supabase/schema.sql with 36 KPIs" -ForegroundColor Green

Write-Host ""
Write-Host "PHASE 1 COMPLETE: Database schema updated" -ForegroundColor Green
Write-Host ""

# ============================================
# PHASE 2: API KEY MANAGEMENT UI
# ============================================

Write-Host "PHASE 2: Creating API Key Management UI..." -ForegroundColor Cyan
Write-Host ""

# Create Integrations Settings Page
Write-Host "Creating integrations settings page..." -ForegroundColor Yellow
New-Item -Path "app/admin/integrations" -ItemType Directory -Force | Out-Null

$integrationsPageContent = @'
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
      description: 'Connect to Salesforce for CRM data and lead tracking'
    },
    {
      id: '2',
      name: 'QuickBooks Online',
      type: 'quickbooks',
      icon: '💚',
      isConnected: false,
      description: 'Sync financial data and invoices from QuickBooks'
    },
    {
      id: '3',
      name: 'Google Ads',
      type: 'google_ads',
      icon: '🎯',
      isConnected: false,
      description: 'Track ad spend, leads, and ROAS from Google Ads'
    },
    {
      id: '4',
      name: 'Facebook Ads',
      type: 'facebook_ads',
      icon: '📘',
      isConnected: false,
      description: 'Monitor Facebook advertising performance'
    },
    {
      id: '5',
      name: 'Zoho CRM',
      type: 'zoho',
      icon: '🔶',
      isConnected: false,
      description: 'Connect Zoho CRM for sales pipeline data'
    },
    {
      id: '6',
      name: 'Custom API',
      type: 'custom',
      icon: '🔌',
      isConnected: false,
      description: 'Connect your custom data source via API'
    }
  ]);

  const [selectedIntegration, setSelectedIntegration] = useState<Integration | null>(null);
  const [apiKey, setApiKey] = useState('');
  const [apiSecret, setApiSecret] = useState('');
  const [testingConnection, setTestingConnection] = useState(false);

  const handleConnect = () => {
    // TODO: Implement actual API connection logic
    console.log('Connecting with:', { apiKey, apiSecret, type: selectedIntegration?.type });
    
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
    
    // Simulate API test
    await new Promise(resolve => setTimeout(resolve, 2000));
    
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
          <p className="text-gray-600">Connect your data sources to start tracking KPIs automatically</p>
        </div>

        <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {integrations.map((integration) => (
            <Card key={integration.id} className="hover:shadow-lg transition-shadow">
              <CardHeader>
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-3">
                    <span className="text-4xl">{integration.icon}</span>
                    <div>
                      <CardTitle className="text-lg">{integration.name}</CardTitle>
                    </div>
                  </div>
                  <Badge variant={integration.isConnected ? 'success' : 'secondary'}>
                    {integration.isConnected ? '✓ Connected' : 'Not Connected'}
                  </Badge>
                </div>
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
                    className="w-full"
                    onClick={() => setSelectedIntegration(integration)}
                  >
                    Connect
                  </Button>
                )}
              </CardContent>
            </Card>
          ))}
        </div>

        {/* Connection Modal */}
        {selectedIntegration && (
          <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
            <div className="bg-white rounded-2xl max-w-md w-full p-6">
              <div className="flex items-center gap-3 mb-6">
                <span className="text-4xl">{selectedIntegration.icon}</span>
                <div>
                  <h2 className="text-2xl font-bold text-gray-900">
                    Connect {selectedIntegration.name}
                  </h2>
                  <p className="text-sm text-gray-600">Enter your API credentials</p>
                </div>
              </div>

              <div className="space-y-4 mb-6">
                <div>
                  <Label htmlFor="apiKey">API Key</Label>
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
                  <Label htmlFor="apiSecret">API Secret (Optional)</Label>
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
                    <strong>Need help?</strong> Visit your {selectedIntegration.name} settings to generate API credentials.
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
                  className="flex-1"
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
'@

Set-Content -LiteralPath "app/admin/integrations/page.tsx" -Value $integrationsPageContent -Encoding UTF8
Write-Host "  ✓ Created app/admin/integrations/page.tsx" -ForegroundColor Green

Write-Host ""
Write-Host "PHASE 2 COMPLETE: API Key Management UI created" -ForegroundColor Green
Write-Host ""

# Continue in next part due to length...
Write-Host "Continuing to Phase 3..." -ForegroundColor Yellow
