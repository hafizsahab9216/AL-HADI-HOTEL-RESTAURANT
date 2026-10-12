# Al Hadi Hotel & Restaurant — Official Website & Admin Console
### Jacobabad, Sindh, Pakistan | Shikarpur Road (Plus Code: `7F63+77Q`)

Welcome to the premium, modern luxury website developed specifically for **Al Hadi Hotel & Restaurant**, Jacobabad, Sindh, Pakistan.

---

## 🌟 Highlights & Features

1. **Brand Identity & Luxury Aesthetic**:
   - Palette: Royal dark green (`#071711`), onyx black, warm ivory cream, and champagne gold (`#d4af37`).
   - Typography: **Playfair Display** (luxury editorial serif) paired with **Plus Jakarta Sans** (clean, crisp modern readability).
   - Custom SVG Gold & Emerald Crest Logo featuring traditional culinary symbols, cloche dome, and Jacobabad regional identity.

2. **Hero Section**:
   - Headline: *"Welcome to Al Hadi Hotel & Restaurant"*
   - Tagline: *"Great Taste. Warm Hospitality. Memorable Moments."*
   - Direct Call Now button (`tel:+923146173872`).
   - Get Directions button (`https://maps.app.goo.gl/8UvL8yND8Wp4cid56?g_st=ac`).
   - Sizzling culinary preview card with live status indicator.

3. **Real Google Maps Photo Slots & Pakistani Food Gallery**:
   - 4 clearly designated photo slots for verified restaurant premises:
     1. Roadside Facade & Entrance (Shikarpur Road highway frontage)
     2. Family Dining & Seating Hall
     3. Live Tandoor & Cooking Hearth
     4. Roadside Parking & Evening Ambiance
   - Interactive Lightbox Zoom modal for all photos.
   - High-definition Pakistani cuisine showcase (Shinwari chicken karahi, Sindhi chicken biryani, charcoal seekh kababs, tandoori roghni naans, karak chai).

4. **Interactive Food Menu**:
   - 6 Categories:
     - Pakistani Cuisine
     - Biryani & Rice
     - Karahi & Traditional Dishes
     - BBQ & Grilled Food
     - Fast Food
     - Tea, Cold Drinks & Refreshments
   - Interactive search bar & category navigation.
   - Direct **"Inquire on WhatsApp"** button for every dish (pre-fills message with dish name).
   - Direct Call button on every dish.
   - Transparent disclaimer noting sample items & tentative pricing.

5. **Customer Reviews & Ethics**:
   - Strict compliance with honesty: no fabricated testimonials or artificial star ratings.
   - Prominent **"Read Google Reviews"** button linking directly to the Google Maps listing.
   - Direct patron feedback submission form stored in Supabase / admin portal.

6. **Location & Interactive Google Map**:
   - Embedded Google Map pinned at Jacobabad coordinates `28.2771, 68.4523` (`7F63+77Q, Shikarpur Road`).
   - Direct "Get Directions" and "Send Pin on WhatsApp" buttons.

7. **Admin Console (`admin.html`)**:
   - **Passcode**: `alhadi2026` (or `admin`)
   - Live Supabase Connection Monitor.
   - Site Settings manager (phone, WhatsApp, hero text, about us, address).
   - Full Menu CRUD: Add, edit, delete dishes, toggle availability, mark specials.
   - Real Photo Manager: update image URLs for the Google Maps slots.
   - Customer Inquiries Manager with 1-click WhatsApp Reply.
   - 1-Click Copy Supabase Schema SQL tool.

---

## ⚡ Supabase Setup (1-Click Instructions)

Your Supabase project is already wired into the application:
- **Project URL:** `https://ggfzfreenxcsllwopmqp.supabase.co`
- **Publishable Key:** `sb_publishable_6PDNlvskFhzzTpRjuA88pw_gBkqz5tt`
- **Anon JWT Key:** Already configured in `js/supabase-client.js`.

### How to run the database setup:
1. Open your Supabase Dashboard: [https://supabase.com/dashboard/project/ggfzfreenxcsllwopmqp](https://supabase.com/dashboard/project/ggfzfreenxcsllwopmqp)
2. In the left navigation, click on **SQL Editor**.
3. Open `supabase-schema.sql` in this folder (or click **"Copy SQL Schema"** inside `admin.html`).
4. Paste the SQL into the editor and click **Run**.
5. All 6 tables (`site_settings`, `menu_categories`, `menu_items`, `gallery_images`, `inquiries`, `customer_feedback`) and Row Level Security policies will be created and populated immediately!

> **Note:** The website has an automatic local storage fallback. It functions flawlessly out of the box even before running SQL, and syncs automatically with Supabase as soon as the tables are active!

---

## 📞 Key Business Contact Coordinates
- **Business Name:** Al Hadi Hotel & Restaurant
- **Phone:** `0314 6173872` (`+923146173872`)
- **Location:** `7F63+77Q, Shikarpur Road, Jacobabad, Sindh, Pakistan`
- **Google Maps:** `https://maps.app.goo.gl/8UvL8yND8Wp4cid56?g_st=ac`
