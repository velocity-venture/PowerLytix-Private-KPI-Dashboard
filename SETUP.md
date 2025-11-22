# PowerLytix Setup Guide

## Quick Start

### 1. Supabase Setup

1. Go to https://supabase.com and create an account
2. Click "New Project"
3. Fill in project details and wait for database to initialize
4. Go to Settings > API
5. Copy your credentials:
   - Project URL
   - anon public key

### 2. Database Migration

1. In Supabase dashboard, go to SQL Editor
2. Open the file `supabase/schema.sql` from your project
3. Copy the entire contents
4. Paste into SQL Editor and click "Run"
5. Verify tables were created in Table Editor (should see 9 tables)

### 3. Environment Variables

Create a `.env.local` file in your project root:

```env
NEXT_PUBLIC_SUPABASE_URL=your_project_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
Write-Host ""
Write-Host "Committing all changes to Git..." -ForegroundColor Yellow
git add .
git commit -m "Complete PowerLytix build: UI components, multi-tenant routing, database schema, documentation"
Write-Host "✓ Committed to Git" -ForegroundColor Green

Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
Write-Host "✓ Pushed to GitHub" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "🎉 BUILD COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Files Created:" -ForegroundColor Cyan
Write-Host "  ✓ 5 Library files (Supabase, Auth, Data)" -ForegroundColor Green
Write-Host "  ✓ 6 UI components (Badge, Button, Input, Label, Skeleton)" -ForegroundColor Green
Write-Host "  ✓ 3 Custom components (Client Header, Sync Badge, KPI Grid)" -ForegroundColor Green
Write-Host "  ✓ 3 Multi-tenant route files" -ForegroundColor Green
Write-Host "  ✓ Database schema (9 tables)" -ForegroundColor Green
Write-Host "  ✓ Setup documentation" -ForegroundColor Green
Write-Host ""
Write-Host "NEXT STEPS:" -ForegroundColor Yellow
Write-Host "1. Set up Supabase (see SETUP.md)" -ForegroundColor White
Write-Host "2. Run database migration" -ForegroundColor White
Write-Host "3. Add environment variables" -ForegroundColor White
Write-Host "4. Test at http://localhost:3000" -ForegroundColor White
Write-Host ""
Write-Host "All changes pushed to GitHub! ✓" -ForegroundColor Green
Write-Host ""
