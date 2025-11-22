# I'll create the files in smaller chunks

# Step 1: Update the database schema file
Write-Host "Updating database schema with 36 KPIs..." -ForegroundColor Yellow

$newSchema = @"
-- PowerLytix Database Schema - UPDATED WITH 36 KPIs
-- Marketing, Call Center, Sales, Canvassing, Top-Line categories

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Clients table (unchanged)
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(100) UNIQUE NOT NULL,
  logo_url TEXT,
  primary_color VARCHAR(7) DEFAULT '#3b82f6',
  status VARCHAR(20) DEFAULT 'trial',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Data sources with API key storage
CREATE TABLE data_sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  source_type VARCHAR(50) NOT NULL,
  source_name VARCHAR(255) NOT NULL,
  is_connected BOOLEAN DEFAULT FALSE,
  api_key TEXT,
  api_secret TEXT,
  access_token TEXT,
  last_synced_at TIMESTAMP WITH TIME ZONE,
  sync_status VARCHAR(20) DEFAULT 'never',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- KPI definitions table
CREATE TABLE kpi_definitions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  display_name VARCHAR(255) NOT NULL,
  category VARCHAR(50),
  unit VARCHAR(20),
  sort_order INTEGER DEFAULT 0
);

-- Insert 36 KPIs
-- MARKETING
INSERT INTO kpi_definitions (name, display_name, category, unit, sort_order) VALUES
  ('spend_per_channel', 'Spend per Channel', 'marketing', 'currency', 1),
  ('leads_generated_per_channel', 'Leads Generated (per channel)', 'marketing', 'number', 2),
  ('cost_per_lead', 'Cost per Lead (CPL)', 'marketing', 'currency', 3),
  ('return_on_ad_spend', 'Return on Ad Spend (ROAS)', 'marketing', 'percentage', 4),
  ('landing_page_conversion', 'Landing Page Conversion %', 'marketing', 'percentage', 5);

-- CALL CENTER
INSERT INTO kpi_definitions (name, display_name, category, unit, sort_order) VALUES
  ('leads_received', 'Leads Received', 'call_center', 'number', 11),
  ('appointment_set_rate', 'Appointment Set Rate', 'call_center', 'percentage', 12),
  ('speed_to_lead', 'Speed to Lead (mins)', 'call_center', 'minutes', 13),
  ('set_behavior', 'Set Behavior', 'call_center', 'number', 14),
  ('set_leads_per_hour', 'Set Leads Per Hour', 'call_center', 'number', 15),
  ('issue_rate', 'Issue Rate', 'call_center', 'percentage', 16),
  ('confirmation_rate_cc', 'Confirmation Rate', 'call_center', 'percentage', 17),
  ('demo_rate', 'Demo Rate', 'call_center', 'percentage', 18);

-- SALES
INSERT INTO kpi_definitions (name, display_name, category, unit, sort_order) VALUES
  ('issued_appointments', 'Issued Appointments', 'sales', 'number', 21),
  ('raw_close_rate_by_product', 'Raw Close Rate % (by product)', 'sales', 'percentage', 22),
  ('raw_close_rate_overall', 'Raw Close Rate % (overall)', 'sales', 'percentage', 23),
  ('close_to_demo', 'Close to Demo %', 'sales', 'percentage', 24),
  ('average_sale', 'Average Sale', 'sales', 'currency', 25),
  ('nsli_by_product', 'NSLI (by product)', 'sales', 'currency', 26),
  ('nsli_overall', 'NSLI (overall)', 'sales', 'currency', 27),
  ('cancellation_rate', 'Cancellation Rate %', 'sales', 'percentage', 28),
  ('gross_margin', 'Gross Margin %', 'sales', 'percentage', 29);

-- CANVASSING  
INSERT INTO kpi_definitions (name, display_name, category, unit, sort_order) VALUES
  ('total_man_hours', 'Total Man Hours Worked', 'canvassing', 'hours', 31),
  ('total_canvass_spend', 'Total Spend', 'canvassing', 'currency', 32),
  ('doors_knocked', 'Doors Knocked', 'canvassing', 'number', 33),
  ('contacts_made', 'Contacts Made %', 'canvassing', 'percentage', 34),
  ('demos_per_hour', 'Demos Per Hour', 'canvassing', 'number', 35),
  ('canvass_confirmation_rate', 'Confirmation Rate', 'canvassing', 'percentage', 36),
  ('leads_generated_canvass', 'Leads Generated', 'canvassing', 'number', 37),
  ('canvass_set_behavior', 'Set Behavior', 'canvassing', 'number', 38),
  ('sales_from_canvass', 'Sales from Canvass', 'canvassing', 'number', 39);

-- TOP-LINE
INSERT INTO kpi_definitions (name, display_name, category, unit, sort_order) VALUES
  ('total_marketing_spend', 'Total Marketing Spend', 'top_line', 'currency', 41),
  ('total_leads', 'Total Leads', 'top_line', 'number', 42),
  ('total_appointments', 'Total Appointments', 'top_line', 'number', 43),
  ('total_sales', 'Total Sales', 'top_line', 'number', 44),
  ('net_revenue_sold', 'Net Revenue (sold)', 'top_line', 'currency', 45),
  ('net_revenue_installed', 'Net Revenue (installed)', 'top_line', 'currency', 46);

-- KPI values table
CREATE TABLE kpi_values (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  kpi_name VARCHAR(255) NOT NULL,
  value NUMERIC NOT NULL,
  value_formatted VARCHAR(50) NOT NULL,
  change_percentage NUMERIC,
  trend VARCHAR(10),
  calculated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
"@

Set-Content -Path "supabase/schema.sql" -Value $newSchema -Encoding UTF8
Write-Host "✓ Updated supabase/schema.sql with 36 KPIs" -ForegroundColor Green
