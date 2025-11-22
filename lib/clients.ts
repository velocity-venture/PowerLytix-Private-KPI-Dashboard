import { supabase } from './supabaseClient';

export interface Client {
  id: string;
  name: string;
  slug: string;
  logo_url?: string;
  primary_color?: string;
  status: 'active' | 'trial' | 'inactive';
  created_at: string;
}

export async function getAllClients(): Promise<Client[]> {
  const { data, error } = await supabase
    .from('clients')
    .select('*')
    .order('created_at', { ascending: false });
  
  if (error) throw error;
  return data || [];
}

export async function getClientBySlug(slug: string): Promise<Client | null> {
  const { data, error } = await supabase
    .from('clients')
    .select('*')
    .eq('slug', slug)
    .single();
  
  if (error) {
    if (error.code === 'PGRST116') return null;
    throw error;
  }
  return data;
}

export async function createClient(client: Omit<Client, 'id' | 'created_at'>): Promise<Client> {
  const { data, error } = await supabase
    .from('clients')
    .insert([client])
    .select()
    .single();
  
  if (error) throw error;
  return data;
}
