# PowerLytix Dashboard - Quick Start Guide

## 🚀 Getting Started in 5 Minutes

Welcome to your PowerLytix Private KPI Dashboard! This guide will help you get up and running quickly.

---

## 📍 Dashboard URL

**Live Dashboard**: https://power-lytix-private-kpi-dashboard-erhxyw3nc-velocity-venture.vercel.app

---

## 🔐 Step 1: First Login

### Create Your Account
1. Navigate to the dashboard URL above
2. Click **"Sign Up"** (if you don't have an account yet)
3. **Enter your email address** (any valid email)
4. **Create a password** (any password - minimum 6 characters)
5. Click **"Sign Up"** or **"Create Account"**

### Login to Existing Account
1. Enter your **email address**
2. Enter your **password**
3. Click **"Sign In"** or **"Login"**

> **Note**: The dashboard uses Supabase authentication, so your credentials are secure and encrypted.

---

## 🏠 Step 2: Explore the Dashboard

After logging in, you'll see:

### **Main Dashboard** (Default View)
- **36 KPI cards** organized into 4 categories:
  - 🎯 **Top-Line Rollup** (5 KPIs)
  - 📢 **Marketing** (4 KPIs)
  - 📞 **Call Center** (4 KPIs)
  - 💰 **Sales** (4 KPIs)
- Each card shows:
  - Current value with animated count-up
  - 7-day sparkline trend
  - Period-over-period comparison (when enabled)

### **Key Features to Try**
1. **Date Filtering** (top right):
   - Click **7d**, **30d**, or **90d** for quick ranges
   - Click **"Custom Range"** to select specific dates

2. **Compare Mode** (top right):
   - Toggle **"Compare with Previous Period"**
   - See green ↑ or red ↓ arrows with percentage changes

3. **Charts Section** (scroll down):
   - View trend charts for key metrics
   - Hover over data points for details

4. **Goals Section** (scroll down):
   - 4 goal cards with progress bars
   - Track performance against targets

5. **Export Options** (top right):
   - **Export to PDF**: Download comprehensive report
   - **Export to Excel**: Get raw data in spreadsheet format

---

## 🔑 Step 3: Set Up API Keys (Optional)

If you need to integrate external data sources:

### Navigate to API Key Management
1. Click your **profile icon** or **menu** (top right)
2. Select **"Admin"** or **"Integrations"**
3. Navigate to **`/admin/integrations`** page

### Add API Keys
1. Select the **platform** (e.g., Google Ads, Facebook Ads)
2. Enter your **API Key** or **Access Token**
3. Give it a **descriptive name** (e.g., "Main Google Ads Account")
4. Click **"Save"** or **"Add Key"**

### Test Your Integration
- Once saved, the dashboard will start pulling data from that platform
- Refresh the dashboard to see updated metrics

> **Note**: API keys are encrypted and stored securely in your Supabase database.

---

## 👤 Step 4: Set Up for Yourself

### Customize Your View
1. **Set Your Goals**:
   - Scroll to the **Goals section**
   - Click **"Edit"** or **gear icon** on each goal card
   - Enter your target values and timeframes
   - Click **"Save"**

2. **Configure Alerts**:
   - Scroll to **Alert Configuration** section (or navigate to Settings)
   - Set threshold values for critical KPIs
   - Choose which metrics trigger alerts
   - Click **"Save Alert Settings"**

3. **Adjust Date Range**:
   - Set your preferred default date range
   - The dashboard will remember your last selection

### Personalize Your Experience
- Bookmark the dashboard URL for quick access
- Set up browser notifications (if prompted)
- Explore the charts and data to understand your baseline metrics

---

## 🏢 Step 5: Set Up for Each Client

If you're managing multiple clients, here's how to organize:

### Option A: Multiple User Accounts (Recommended for Now)
Since v1 doesn't have multi-tenant architecture yet, create separate setups:

1. **Create a new account** for each client:
   - Use client-specific email (e.g., `client1@youragency.com`)
   - Set a unique password
   - Log in with that account

2. **Configure each client dashboard**:
   - Add their API keys in **Admin > Integrations**
   - Set their specific goals
   - Configure their alert thresholds

3. **Access multiple clients**:
   - Log out and log back in with different credentials
   - Or use multiple browser profiles (Chrome profiles, Firefox containers)

### Option B: Naming Convention (Temporary Workaround)
Until multi-client features are added:

1. Use **descriptive names** for API keys:
   - "Client A - Google Ads"
   - "Client B - Facebook Ads"

2. Create **separate goal cards** or track in notes:
   - "Client A Sales Goal: $50K"
   - "Client B Sales Goal: $75K"

### Option C: Request Version 2 Multi-Tenant Features
For proper client separation:
- See **Version 2 Roadmap** for multi-tenant architecture
- This will provide:
  - Separate dashboard instances per client
  - Client-specific branding
  - Consolidated agency view
  - Easy client switching

---

## 📊 Step 6: Daily Usage Tips

### Your Daily Workflow
1. **Morning Check-In**:
   - Log in to dashboard
   - Review Top-Line Rollup KPIs
   - Check for any red ↓ arrows (declining metrics)
   - Look at Goals progress

2. **Weekly Review**:
   - Toggle **Compare Mode** to see week-over-week changes
   - Export to PDF for team meetings
   - Adjust goals if needed

3. **Monthly Analysis**:
   - Change date range to **30d** or custom month
   - Export to Excel for deeper analysis
   - Review all 36 KPIs across categories

### Best Practices
- ✅ Check dashboard daily for real-time insights
- ✅ Use Compare Mode to spot trends early
- ✅ Set realistic goals and update them quarterly
- ✅ Export reports before client calls
- ✅ Configure alerts for critical metrics (don't miss important changes)

---

## 🆘 Common Questions

### Q: I forgot my password. How do I reset it?
**A**: Click **"Forgot Password"** on the login page and follow the email instructions.

### Q: Can I give access to my team members?
**A**: Yes! Have them create their own accounts with their email addresses. They'll see the same dashboard (currently shared data view).

### Q: How often does the data update?
**A**: Data refreshes based on your API integration settings. Manual data entry updates in real-time.

### Q: Can I customize which KPIs are displayed?
**A**: Currently, all 36 KPIs are shown by default. Custom KPI selection is planned for Version 2.

### Q: How do I export data?
**A**: Click the **"Export to PDF"** or **"Export to Excel"** buttons in the top right corner of the dashboard.

### Q: Where are my API keys stored?
**A**: API keys are encrypted and stored securely in your Supabase database. Only you can access them.

### Q: Can I access this on mobile?
**A**: Yes! The dashboard is fully responsive and works on phones and tablets through your web browser.

### Q: How do I add more integrations?
**A**: Navigate to **Admin > Integrations** and add API keys for supported platforms.

---

## 📞 Need Help?

If you have questions or need assistance:

1. **Review the Full User Guide**: [Link to POWERLYTIX_USER_GUIDE.md]
2. **Watch the Demo Video**: [PowerLytix-Demo-Video.mp4]
3. **Contact Support**: [Your support email/contact info]

---

## 🎯 Next Steps

- [ ] Create your account and log in
- [ ] Explore all 36 KPIs and understand what they measure
- [ ] Set up your API keys (if using integrations)
- [ ] Configure your first set of goals
- [ ] Set up alert thresholds
- [ ] Export your first PDF report
- [ ] Set up accounts for each client (if applicable)
- [ ] Review Version 2 Roadmap for upcoming features

---

**Ready to make data-driven decisions?**  
**Log in now and start tracking your KPIs!**

🚀 **Dashboard URL**: https://power-lytix-private-kpi-dashboard-erhxyw3nc-velocity-venture.vercel.app

---

**Document Version**: 1.0  
**Last Updated**: January 2024  
**Dashboard Version**: 1.0 (Production)
