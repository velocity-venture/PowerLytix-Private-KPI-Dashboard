'use client';

import { useState } from 'react';
import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Badge } from '@/components/ui/badge';
import { Bell, Mail, TrendingDown, TrendingUp, Save } from 'lucide-react';

interface Alert {
  kpi: string;
  condition: 'above' | 'below';
  threshold: number;
  email: string;
  enabled: boolean;
}

export function AlertConfiguration() {
  const [alerts, setAlerts] = useState<Alert[]>([
    { kpi: 'Cost Per Lead', condition: 'above', threshold: 50, email: 'you@example.com', enabled: true },
    { kpi: 'Appointment Set Rate', condition: 'below', threshold: 60, email: 'you@example.com', enabled: true },
    { kpi: 'Gross Margin %', condition: 'below', threshold: 25, email: 'you@example.com', enabled: false },
  ]);

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5 }}
    >
      <Card className="border-2">
        <CardHeader>
          <CardTitle className="flex items-center gap-2">
            <Bell className="w-5 h-5 text-orange-600" />
            KPI Alert Configuration
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-4">
          {alerts.map((alert, idx) => (
            <motion.div
              key={idx}
              initial={{ opacity: 0, x: -20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.4, delay: idx * 0.1 }}
              className="p-4 border rounded-lg space-y-3"
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  {alert.condition === 'above' ? (
                    <TrendingUp className="w-4 h-4 text-red-600" />
                  ) : (
                    <TrendingDown className="w-4 h-4 text-orange-600" />
                  )}
                  <span className="font-semibold">{alert.kpi}</span>
                </div>
                <Badge variant={alert.enabled ? 'default' : 'outline'}>
                  {alert.enabled ? 'Active' : 'Disabled'}
                </Badge>
              </div>
              
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <Label className="text-xs">Condition</Label>
                  <div className="text-sm mt-1">
                    Alert when {alert.condition === 'above' ? 'exceeds' : 'falls below'}
                  </div>
                </div>
                <div>
                  <Label className="text-xs">Threshold</Label>
                  <Input 
                    type="number" 
                    value={alert.threshold} 
                    className="mt-1 h-8"
                    onChange={(e) => {
                      const newAlerts = [...alerts];
                      newAlerts[idx].threshold = parseFloat(e.target.value);
                      setAlerts(newAlerts);
                    }}
                  />
                </div>
              </div>
              
              <div>
                <Label className="text-xs flex items-center gap-1">
                  <Mail className="w-3 h-3" />
                  Email Address
                </Label>
                <Input 
                  type="email" 
                  value={alert.email} 
                  className="mt-1 h-8"
                  onChange={(e) => {
                    const newAlerts = [...alerts];
                    newAlerts[idx].email = e.target.value;
                    setAlerts(newAlerts);
                  }}
                />
              </div>
              
              <div className="flex gap-2">
                <Button
                  size="sm"
                  variant={alert.enabled ? 'outline' : 'default'}
                  onClick={() => {
                    const newAlerts = [...alerts];
                    newAlerts[idx].enabled = !newAlerts[idx].enabled;
                    setAlerts(newAlerts);
                  }}
                  className="flex-1"
                >
                  {alert.enabled ? 'Disable' : 'Enable'}
                </Button>
                <Button size="sm" className="bg-gradient-to-r from-blue-600 to-indigo-600">
                  <Save className="w-4 h-4 mr-1" />
                  Save
                </Button>
              </div>
            </motion.div>
          ))}
          
          <Button variant="outline" className="w-full">
            <Bell className="w-4 h-4 mr-2" />
            Add New Alert
          </Button>
        </CardContent>
      </Card>
    </motion.div>
  );
}
