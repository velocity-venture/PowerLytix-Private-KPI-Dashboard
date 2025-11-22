'use client';

import React, { useState } from 'react';
import DatePicker from 'react-datepicker';
import 'react-datepicker/dist/react-datepicker.css';
import { Calendar } from 'lucide-react';

export interface DateRange {
  from: Date;
  to: Date;
}

interface DateRangePickerProps {
  dateRange: DateRange;
  onDateRangeChange: (range: DateRange) => void;
}

export function DateRangePicker({ dateRange, onDateRangeChange }: DateRangePickerProps) {
  const [startDate, setStartDate] = useState<Date>(dateRange.from);
  const [endDate, setEndDate] = useState<Date>(dateRange.to);

  const handleStartDateChange = (date: Date | null) => {
    if (date) {
      setStartDate(date);
      // If end date is before new start date, adjust it
      if (endDate < date) {
        setEndDate(date);
        onDateRangeChange({ from: date, to: date });
      } else {
        onDateRangeChange({ from: date, to: endDate });
      }
    }
  };

  const handleEndDateChange = (date: Date | null) => {
    if (date) {
      setEndDate(date);
      onDateRangeChange({ from: startDate, to: date });
    }
  };

  return (
    <div className="flex items-center gap-2 bg-white rounded-lg border border-gray-200 px-3 py-2 shadow-sm">
      <Calendar className="h-4 w-4 text-gray-500" />
      <div className="flex items-center gap-2">
        <DatePicker
          selected={startDate}
          onChange={handleStartDateChange}
          selectsStart
          startDate={startDate}
          endDate={endDate}
          maxDate={new Date()}
          dateFormat="MMM d, yyyy"
          className="w-32 text-sm border-none focus:outline-none focus:ring-0 cursor-pointer"
          placeholderText="Start date"
        />
        <span className="text-gray-400">→</span>
        <DatePicker
          selected={endDate}
          onChange={handleEndDateChange}
          selectsEnd
          startDate={startDate}
          endDate={endDate}
          minDate={startDate}
          maxDate={new Date()}
          dateFormat="MMM d, yyyy"
          className="w-32 text-sm border-none focus:outline-none focus:ring-0 cursor-pointer"
          placeholderText="End date"
        />
      </div>
    </div>
  );
}
