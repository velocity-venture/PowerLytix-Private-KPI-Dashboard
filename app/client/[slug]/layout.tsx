import { notFound } from 'next/navigation';
import { getClientBySlug } from '@/lib/clients';
import { ClientHeader } from '@/components/client-header';

export default async function ClientLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: { slug: string };
}) {
  const client = await getClientBySlug(params.slug);
  
  if (!client) {
    notFound();
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <ClientHeader
        clientName={client.name}
        logoUrl={client.logo_url}
        primaryColor={client.primary_color}
      />
      <main>{children}</main>
    </div>
  );
}
