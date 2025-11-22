import { Badge } from "@/components/ui/badge";

interface ClientHeaderProps {
  clientName: string;
  logoUrl?: string;
  primaryColor?: string;
}

export function ClientHeader({ clientName, logoUrl, primaryColor = "#3b82f6" }: ClientHeaderProps) {
  return (
    <div className="border-b bg-white px-6 py-4">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          {logoUrl && (
            <img
              src={logoUrl}
              alt={`${clientName} logo`}
              className="h-10 w-10 rounded-lg object-contain"
            />
          )}
          <div>
            <h1 className="text-2xl font-bold text-gray-900">{clientName}</h1>
            <p className="text-sm text-gray-600">Business Analytics Dashboard</p>
          </div>
        </div>
        <Badge variant="success">Active</Badge>
      </div>
    </div>
  );
}
