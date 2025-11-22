import { supabase } from './supabaseClient';

export interface KpiValue {
  id: string;
  client_id: string;
  kpi_name: string;
  value: number;
  value_formatted: string;
  change_percentage?: number;
  trend: 'up' | 'down' | 'neutral';
  period: string;
  calculated_at: string;
}

export async function getKpisForClient(clientId: string): Promise<KpiValue[]> {
  const { data, error } = await supabase
    .from('kpi_values')
    .select('*')
    .eq('client_id', clientId)
    .order('calculated_at', { ascending: false });
  
  if (error) throw error;
  return data || [];
}

export async function getLatestKpisForClient(clientId: string): Promise<KpiValue[]> {
  const { data, error } = await supabase
    .from('kpi_values')
    .select('*')
    .eq('client_id', clientId)
    .order('calculated_at', { ascending: false })
    .limit(15);
  
  if (error) throw error;
  return data || [];
}
