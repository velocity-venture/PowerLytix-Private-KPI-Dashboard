'use client';

import React from 'react';
import { TrendingUp, BarChart3, SplitSquareHorizontal } from 'lucide-react';

export type ComparisonMode = 'none' | 'deltas' | 'overlay' | 'sidebyside';

interface ComparisonSelectorProps {
  isActive: boolean;
  currentMode: ComparisonMode;
  onModeChange: (mode: ComparisonMode) => void;
  onToggle: () => void;
}

export function ComparisonSelector({
  isActive,
  currentMode,
  onModeChange,
  onToggle,
}: ComparisonSelectorProps) {
  const comparisonOptions = [
    {
      mode: 'deltas' as ComparisonMode,
      label: 'Show Deltas',
      description: 'Numbers with ↑↓ indicators',
      icon: TrendingUp,
    },
    {
      mode: 'overlay' as ComparisonMode,
      label: 'Overlay Charts',
      description: 'Previous period on same chart',
      icon: BarChart3,
    },
    {
      mode: 'sidebyside' as ComparisonMode,
      label: 'Side-by-Side',
      description: 'Split view comparison',
      icon: SplitSquareHorizontal,
    },
  ];

  return (
    <div className="relative">
      {/* Compare Toggle Button */}
      <button
        onClick={onToggle}
        className={`px-4 py-2 rounded-lg font-medium transition-colors ${
          isActive
            ? 'bg-blue-600 text-white'
            : 'bg-white text-gray-700 border border-gray-300 hover:bg-gray-50'
        }`}
      >
        Compare {isActive && '▼'}
      </button>

      {/* Dropdown Menu */}
      {isActive && (
        <div className="absolute top-full left-0 mt-2 w-72 bg-white rounded-lg shadow-xl border border-gray-200 z-50 overflow-hidden">
          <div className="p-2">
            <div className="text-xs font-semibold text-gray-500 uppercase tracking-wide px-3 py-2">
              Comparison Mode
            </div>
            {comparisonOptions.map((option) => {
              const Icon = option.icon;
              const isSelected = currentMode === option.mode;
              
              return (
                <button
                  key={option.mode}
                  onClick={() => onModeChange(option.mode)}
                  className={`w-full flex items-start gap-3 px-3 py-3 rounded-md transition-colors ${
                    isSelected
                      ? 'bg-blue-50 border-2 border-blue-500'
                      : 'hover:bg-gray-50 border-2 border-transparent'
                  }`}
                >
                  <div
                    className={`p-2 rounded-md ${
                      isSelected ? 'bg-blue-100' : 'bg-gray-100'
                    }`}
                  >
                    <Icon
                      className={`h-5 w-5 ${
                        isSelected ? 'text-blue-600' : 'text-gray-600'
                      }`}
                    />
                  </div>
                  <div className="flex-1 text-left">
                    <div
                      className={`font-medium ${
                        isSelected ? 'text-blue-900' : 'text-gray-900'
                      }`}
                    >
                      {option.label}
                    </div>
                    <div className="text-xs text-gray-500 mt-0.5">
                      {option.description}
                    </div>
                  </div>
                  {isSelected && (
                    <div className="flex items-center">
                      <div className="h-2 w-2 rounded-full bg-blue-600"></div>
                    </div>
                  )}
                </button>
              );
            })}
          </div>
          <div className="border-t border-gray-200 bg-gray-50 px-4 py-3">
            <div className="text-xs text-gray-600">
              📊 Comparing to previous period (auto-calculated)
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
