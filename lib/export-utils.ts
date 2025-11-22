'use client';

import { jsPDF } from 'jspdf';
import autoTable from 'jspdf-autotable';

interface KPIData {
  title: string;
  value: string | number;
  change: number;
  trend: string;
}

export const exportToPDF = (
  kpiData: { [key: string]: KPIData[] },
  dateRange: string
) => {
  const doc = new jsPDF();
  
  // Header
  doc.setFillColor(59, 130, 246);
  doc.rect(0, 0, 210, 40, 'F');
  doc.setTextColor(255, 255, 255);
  doc.setFontSize(24);
  doc.text('PowerLytix Dashboard Report', 20, 25);
  doc.setFontSize(12);
  doc.text(`Period: ${dateRange}`, 20, 35);
  
  let yPosition = 50;
  
  // Add each category
  Object.entries(kpiData).forEach(([category, kpis]) => {
    doc.setTextColor(0, 0, 0);
    doc.setFontSize(16);
    doc.text(category, 20, yPosition);
    yPosition += 10;
    
    const tableData = kpis.map((kpi) => [
      kpi.title,
      typeof kpi.value === 'number' ? kpi.value.toLocaleString() : kpi.value,
      `${kpi.change > 0 ? '+' : ''}${kpi.change}%`,
      kpi.trend,
    ]);
    
    autoTable(doc, {
      startY: yPosition,
      head: [['KPI', 'Value', 'Change', 'Trend']],
      body: tableData,
      theme: 'grid',
      headStyles: { fillColor: [59, 130, 246] },
    });
    
    yPosition = (doc as any).lastAutoTable.finalY + 15;
    
    if (yPosition > 250) {
      doc.addPage();
      yPosition = 20;
    }
  });
  
  const timestamp = new Date().toISOString().split('T')[0];
  doc.save(`PowerLytix-Report-${timestamp}.pdf`);
};

export const exportToExcel = (
  kpiData: { [key: string]: KPIData[] },
  dateRange: string
) => {
  let csvContent = `PowerLytix Dashboard Report\nPeriod: ${dateRange}\n\n`;
  
  Object.entries(kpiData).forEach(([category, kpis]) => {
    csvContent += `\n${category}\n`;
    csvContent += 'KPI,Value,Change (%),Trend\n';
    
    kpis.forEach((kpi) => {
      const value = typeof kpi.value === 'number' ? kpi.value : `"${kpi.value}"`;
      csvContent += `"${kpi.title}",${value},${kpi.change},${kpi.trend}\n`;
    });
  });
  
  const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  const url = URL.createObjectURL(blob);
  const timestamp = new Date().toISOString().split('T')[0];
  
  link.setAttribute('href', url);
  link.setAttribute('download', `PowerLytix-Report-${timestamp}.csv`);
  link.style.visibility = 'hidden';
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
};
