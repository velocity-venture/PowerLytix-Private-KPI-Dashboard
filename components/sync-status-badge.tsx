import { Badge } from "@/components/ui/badge";

interface SyncStatusBadgeProps {
  status: 'syncing' | 'synced' | 'error' | 'never';
  lastSyncedAt?: string;
}

export function SyncStatusBadge({ status, lastSyncedAt }: SyncStatusBadgeProps) {
  const statusConfig = {
    syncing: { variant: 'info' as const, label: 'Syncing...', icon: '🔄' },
    synced: { variant: 'success' as const, label: 'Synced', icon: '✓' },
    error: { variant: 'destructive' as const, label: 'Sync Error', icon: '✗' },
    never: { variant: 'secondary' as const, label: 'Never Synced', icon: '○' },
  };

  const config = statusConfig[status];

  return (
    <div className="flex items-center gap-2">
      <Badge variant={config.variant}>
        {config.icon} {config.label}
      </Badge>
      {lastSyncedAt && status === 'synced' && (
        <span className="text-xs text-gray-500">
          {new Date(lastSyncedAt).toLocaleString()}
        </span>
      )}
    </div>
  );
}
