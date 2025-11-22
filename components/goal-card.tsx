'use client';

import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Target, TrendingUp, AlertTriangle, CheckCircle } from 'lucide-react';

interface GoalCardProps {
  title: string;
  current: number;
  goal: number;
  unit?: string;
  prefix?: string;
  suffix?: string;
  index?: number;
}

export function GoalCard({
  title,
  current,
  goal,
  unit = '',
  prefix = '',
  suffix = '',
  index = 0,
}: GoalCardProps) {
  const percentage = Math.min((current / goal) * 100, 100);
  const isOnTrack = percentage >= 80;
  const isExceeding = percentage >= 100;
  
  const getStatusColor = () => {
    if (isExceeding) return 'from-green-500 to-emerald-500';
    if (isOnTrack) return 'from-blue-500 to-cyan-500';
    return 'from-orange-500 to-red-500';
  };
  
  const getStatusIcon = () => {
    if (isExceeding) return <CheckCircle className="w-4 h-4" />;
    if (isOnTrack) return <TrendingUp className="w-4 h-4" />;
    return <AlertTriangle className="w-4 h-4" />;
  };
  
  const getStatusText = () => {
    if (isExceeding) return 'Exceeded';
    if (isOnTrack) return 'On Track';
    return 'Behind';
  };

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4, delay: index * 0.05 }}
    >
      <Card className="hover:shadow-lg transition-all duration-300">
        <CardHeader className="pb-3">
          <div className="flex items-center justify-between">
            <CardTitle className="text-sm font-medium text-muted-foreground">
              {title}
            </CardTitle>
            <Badge 
              className={`bg-gradient-to-r ${getStatusColor()} text-white border-0`}
            >
              {getStatusIcon()}
              <span className="ml-1">{getStatusText()}</span>
            </Badge>
          </div>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="flex items-baseline justify-between">
            <div>
              <div className="text-2xl font-bold">
                {prefix}{current.toLocaleString()}{suffix}
              </div>
              <div className="text-xs text-muted-foreground mt-1">
                Goal: {prefix}{goal.toLocaleString()}{suffix}
              </div>
            </div>
            <div className="text-right">
              <div className="text-2xl font-bold text-blue-600">
                {percentage.toFixed(0)}%
              </div>
              <div className="text-xs text-muted-foreground">Complete</div>
            </div>
          </div>
          
          {/* Progress Bar */}
          <div className="relative w-full h-3 bg-gray-200 rounded-full overflow-hidden">
            <motion.div
              className={`absolute top-0 left-0 h-full bg-gradient-to-r ${getStatusColor()} rounded-full`}
              initial={{ width: 0 }}
              animate={{ width: `${percentage}%` }}
              transition={{ duration: 1.5, delay: index * 0.05 + 0.3, ease: 'easeOut' }}
            />
          </div>
        </CardContent>
      </Card>
    </motion.div>
  );
}
