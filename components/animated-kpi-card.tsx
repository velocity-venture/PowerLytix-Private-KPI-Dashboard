'use client';

import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { TrendingUp, TrendingDown, Minus } from 'lucide-react';
import CountUp from 'react-countup';
import { LineChart, Line, ResponsiveContainer } from 'recharts';

interface KPICardProps {
  title: string;
  value: string | number;
  change: number;
  trend: 'up' | 'down' | 'neutral';
  sparklineData?: number[];
  prefix?: string;
  suffix?: string;
  decimals?: number;
  index?: number;
}

export function AnimatedKPICard({
  title,
  value,
  change,
  trend,
  sparklineData = [],
  prefix = '',
  suffix = '',
  decimals = 0,
  index = 0
}: KPICardProps) {
  // Extract numeric value for count-up animation
  const numericValue = typeof value === 'string' 
    ? parseFloat(value.replace(/[^0-9.-]+/g, '')) 
    : value;

  const isNumeric = !isNaN(numericValue);

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.4, delay: index * 0.05 }}
    >
      <Card className="hover:shadow-xl transition-all duration-300 hover:scale-105 border-2 hover:border-blue-400">
        <CardHeader className="pb-2">
          <CardTitle className="text-sm font-medium text-muted-foreground flex items-center justify-between">
            <span>{title}</span>
            <motion.div
              initial={{ scale: 0 }}
              animate={{ scale: 1 }}
              transition={{ duration: 0.3, delay: index * 0.05 + 0.2 }}
            >
              {trend === 'up' && (
                <div className="w-8 h-8 rounded-full bg-green-100 flex items-center justify-center">
                  <TrendingUp className="w-4 h-4 text-green-600" />
                </div>
              )}
              {trend === 'down' && (
                <div className="w-8 h-8 rounded-full bg-red-100 flex items-center justify-center">
                  <TrendingDown className="w-4 h-4 text-red-600" />
                </div>
              )}
              {trend === 'neutral' && (
                <div className="w-8 h-8 rounded-full bg-gray-100 flex items-center justify-center">
                  <Minus className="w-4 h-4 text-gray-600" />
                </div>
              )}
            </motion.div>
          </CardTitle>
        </CardHeader>
        <CardContent className="space-y-3">
          <div className="flex items-baseline justify-between">
            <div className="text-3xl font-bold">
              {isNumeric ? (
                <CountUp
                  start={0}
                  end={numericValue}
                  duration={1.5}
                  delay={index * 0.05}
                  decimals={decimals}
                  prefix={prefix}
                  suffix={suffix}
                  separator=","
                />
              ) : (
                value
              )}
            </div>
            <motion.div
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.4, delay: index * 0.05 + 0.3 }}
              className={`flex items-center text-sm font-semibold px-2 py-1 rounded-full ${
                trend === 'up' 
                  ? 'text-green-700 bg-green-100' 
                  : trend === 'down' 
                  ? 'text-red-700 bg-red-100' 
                  : 'text-gray-700 bg-gray-100'
              }`}
            >
              {trend === 'up' && <TrendingUp className="w-3 h-3 mr-1" />}
              {trend === 'down' && <TrendingDown className="w-3 h-3 mr-1" />}
              {trend === 'neutral' && <Minus className="w-3 h-3 mr-1" />}
              <span>{Math.abs(change)}%</span>
            </motion.div>
          </div>

          {/* Sparkline Chart */}
          {sparklineData.length > 0 && (
            <motion.div
              initial={{ opacity: 0, scaleY: 0 }}
              animate={{ opacity: 1, scaleY: 1 }}
              transition={{ duration: 0.5, delay: index * 0.05 + 0.4 }}
              className="h-12 w-full"
            >
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={sparklineData.map((val, idx) => ({ value: val, index: idx }))}>
                  <Line
                    type="monotone"
                    dataKey="value"
                    stroke={trend === 'up' ? '#10b981' : trend === 'down' ? '#ef4444' : '#6b7280'}
                    strokeWidth={2}
                    dot={false}
                    animationDuration={1000}
                    animationBegin={index * 50 + 400}
                  />
                </LineChart>
              </ResponsiveContainer>
            </motion.div>
          )}
        </CardContent>
      </Card>
    </motion.div>
  );
}
