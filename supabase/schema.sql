-- PowerLytix Database Schema
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

-- Data sources table
CREATE TABLE data_sources (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  source_type VARCHAR(50) NOT NULL CHECK (source_type IN ('salesforce', 'quickbooks', 'zoho', 'builderprime', 'jobnimbus', 'sage')),
  source_name VARCHAR(255) NOT NULL,
  is_connected BOOLEAN DEFAULT FALSE,
  last_synced_at TIMESTAMP WITH TIME ZONE,
  sync_status VARCHAR(20) DEFAULT 'never' CHECK (sync_status IN ('syncing', 'synced', 'error', 'never')),
  sync_error TEXT,
  credentials JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_data_sources_client_id ON data_sources(client_id);

-- KPI definitions table
CREATE TABLE kpi_definitions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL UNIQUE,
  display_name VARCHAR(255) NOT NULL,
  description TEXT,
  category VARCHAR(50) CHECK (category IN ('sales', 'financial', 'operations')),
  unit VARCHAR(20) CHECK (unit IN ('currency', 'percentage', 'number', 'days')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert 15 KPI definitions
INSERT INTO kpi_definitions (name, display_name, description, category, unit) VALUES
  ('pipeline_value', 'Pipeline Value', 'Total value of open opportunities', 'sales', 'currency'),
  ('open_opportunities', 'Open Opportunities', 'Number of active sales opportunities', 'sales', 'number'),
  ('win_rate_90d', 'Win Rate (90d)', 'Percentage of opportunities won in last 90 days', 'sales', 'percentage'),
  ('avg_deal_size', 'Average Deal Size', 'Average value of closed deals', 'sales', 'currency'),
  ('avg_sales_cycle', 'Average Sales Cycle', 'Average days from lead to close', 'sales', 'days'),
  ('new_leads_mtd', 'New Leads MTD', 'New leads generated month-to-date', 'sales', 'number'),
  ('booking_rate', 'Booking Rate', 'Percentage of leads converted to bookings', 'sales', 'percentage'),
  ('revenue_mtd', 'Revenue MTD', 'Revenue generated month-to-date', 'financial', 'currency'),
  ('outstanding_ar', 'Outstanding A/R', 'Total outstanding accounts receivable', 'financial', 'currency'),
  ('overdue_ar', 'Overdue A/R', 'Total overdue accounts receivable', 'financial', 'currency'),
  ('avg_days_to_collect', 'Avg Days to Collect (DSO)', 'Average days to collect payment', 'financial', 'days'),
  ('job_backlog_value', 'Job Backlog Value', 'Total value of scheduled jobs', 'operations', 'currency'),
  ('jobs_completed_mtd', 'Jobs Completed MTD', 'Jobs completed month-to-date', 'operations', 'number'),
  ('gross_margin_pct', 'Gross Margin %', 'Gross profit margin percentage', 'financial', 'percentage'),
  ('cancellation_rate', 'Cancellation Rate', 'Percentage of jobs cancelled', 'operations', 'percentage');

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
  calculated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_kpi_values_client_id ON kpi_values(client_id);
CREATE INDEX idx_kpi_values_calculated_at ON kpi_values(calculated_at DESC);

-- Raw data tables
CREATE TABLE raw_salesforce_opportunities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  external_id VARCHAR(255) NOT NULL,
  name VARCHAR(255),
  amount NUMERIC,
  stage VARCHAR(100),
  close_date DATE,
  probability NUMERIC,
  created_date TIMESTAMP WITH TIME ZONE,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_sf_opp_client ON raw_salesforce_opportunities(client_id);

CREATE TABLE raw_quickbooks_invoices (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  external_id VARCHAR(255) NOT NULL,
  customer_name VARCHAR(255),
  total_amount NUMERIC,
  balance NUMERIC,
  due_date DATE,
  invoice_date DATE,
  status VARCHAR(50),
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_qb_inv_client ON raw_quickbooks_invoices(client_id);

CREATE TABLE raw_jobs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  source_type VARCHAR(50),
  external_id VARCHAR(255) NOT NULL,
  job_name VARCHAR(255),
  job_value NUMERIC,
  status VARCHAR(50),
  start_date DATE,
  completion_date DATE,
  synced_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  raw_data JSONB
);

CREATE INDEX idx_raw_jobs_client ON raw_jobs(client_id);

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
