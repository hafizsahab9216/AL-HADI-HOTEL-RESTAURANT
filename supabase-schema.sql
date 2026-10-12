-- ========================================================
-- AL HADI HOTEL & RESTAURANT - DATABASE SCHEMA (SUPABASE)
-- Jacobabad, Sindh, Pakistan | Shikarpur Road (7F63+77Q)
-- ========================================================

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- 1. SITE SETTINGS TABLE
create table if not exists public.site_settings (
    id text primary key default 'main',
    business_name text not null default 'Al Hadi Hotel & Restaurant',
    phone text not null default '0314 6173872',
    phone_raw text not null default '+923146173872',
    whatsapp_number text not null default '923146173872',
    location_code text not null default '7F63+77Q',
    address text not null default '7F63+77Q, Shikarpur Road, Jacobabad, Sindh, Pakistan',
    hero_headline text not null default 'Welcome to Al Hadi Hotel & Restaurant',
    hero_tagline text not null default 'Great Taste. Warm Hospitality. Memorable Moments.',
    about_text text not null default 'Welcome to Al Hadi Hotel & Restaurant, located on Shikarpur Road in Jacobabad, Sindh. Discover a welcoming place to enjoy good food and spend quality time with friends and family.',
    google_maps_url text not null default 'https://maps.app.goo.gl/8UvL8yND8Wp4cid56?g_st=ac',
    notice_text text default 'Open 24/7 on Shikarpur Road • Traditional Sindhi & Pakistani Flavors • Fresh Tandoor & Karahi',
    updated_at timestamptz default now()
);

-- 2. MENU CATEGORIES TABLE
create table if not exists public.menu_categories (
    id text primary key,
    name text not null,
    name_urdu text,
    description text,
    display_order integer default 0
);

-- 3. MENU ITEMS TABLE
create table if not exists public.menu_items (
    id text primary key,
    category_id text references public.menu_categories(id) on delete cascade,
    name text not null,
    name_urdu text,
    description text,
    price numeric default 0,
    price_display text default 'Ask for Price',
    image_url text,
    is_available boolean default true,
    is_special boolean default false,
    is_sample boolean default true,
    display_order integer default 0,
    created_at timestamptz default now()
);

-- 4. GALLERY IMAGES TABLE (REAL PHOTOS & FOOD GALLERY)
create table if not exists public.gallery_images (
    id text primary key,
    title text not null,
    category text not null default 'food', -- 'real_maps', 'food', 'ambiance'
    is_real_maps boolean default false,
    slot_name text,
    image_url text not null,
    caption text,
    display_order integer default 0,
    created_at timestamptz default now()
);

-- 5. CUSTOMER INQUIRIES & RESERVATIONS TABLE
create table if not exists public.inquiries (
    id uuid default gen_random_uuid() primary key,
    name text not null,
    phone text not null,
    inquiry_type text default 'General Inquiry',
    message text,
    created_at timestamptz default now()
);

-- 6. CUSTOMER REVIEWS & FEEDBACK TABLE
create table if not exists public.customer_feedback (
    id uuid default gen_random_uuid() primary key,
    name text not null,
    rating integer default 5,
    comment text not null,
    visit_type text default 'Dine-in',
    is_approved boolean default true,
    created_at timestamptz default now()
);

-- ENABLE ROW LEVEL SECURITY
alter table public.site_settings enable row level security;
alter table public.menu_categories enable row level security;
alter table public.menu_items enable row level security;
alter table public.gallery_images enable row level security;
alter table public.inquiries enable row level security;
alter table public.customer_feedback enable row level security;

-- CREATE OPEN POLICIES FOR ANONYMOUS / WEB CLIENT (Read & Insert)
drop policy if exists "Allow public read on site_settings" on public.site_settings;
create policy "Allow public read on site_settings" on public.site_settings for select using (true);
create policy "Allow all on site_settings" on public.site_settings for all using (true);

drop policy if exists "Allow public read on menu_categories" on public.menu_categories;
create policy "Allow public read on menu_categories" on public.menu_categories for select using (true);
create policy "Allow all on menu_categories" on public.menu_categories for all using (true);

drop policy if exists "Allow public read on menu_items" on public.menu_items;
create policy "Allow public read on menu_items" on public.menu_items for select using (true);
create policy "Allow all on menu_items" on public.menu_items for all using (true);

drop policy if exists "Allow public read on gallery_images" on public.gallery_images;
create policy "Allow public read on gallery_images" on public.gallery_images for select using (true);
create policy "Allow all on gallery_images" on public.gallery_images for all using (true);

drop policy if exists "Allow public insert on inquiries" on public.inquiries;
create policy "Allow public insert on inquiries" on public.inquiries for insert with check (true);
create policy "Allow all on inquiries" on public.inquiries for all using (true);

drop policy if exists "Allow public read on customer_feedback" on public.customer_feedback;
create policy "Allow public read on customer_feedback" on public.customer_feedback for select using (true);
create policy "Allow public insert on customer_feedback" on public.customer_feedback for insert with check (true);
create policy "Allow all on customer_feedback" on public.customer_feedback for all using (true);

-- ========================================================
-- SEED INITIAL SAMPLE DATA
-- ========================================================

-- Initial Site Settings
insert into public.site_settings (id, business_name, phone, phone_raw, whatsapp_number, location_code, address, hero_headline, hero_tagline, about_text, google_maps_url, notice_text)
values (
    'main',
    'Al Hadi Hotel & Restaurant',
    '0314 6173872',
    '+923146173872',
    '923146173872',
    '7F63+77Q',
    '7F63+77Q, Shikarpur Road, Jacobabad, Sindh, Pakistan',
    'Welcome to Al Hadi Hotel & Restaurant',
    'Great Taste. Warm Hospitality. Memorable Moments.',
    'Welcome to Al Hadi Hotel & Restaurant, located on Shikarpur Road in Jacobabad, Sindh. Discover a welcoming place to enjoy good food and spend quality time with friends and family.',
    'https://maps.app.goo.gl/8UvL8yND8Wp4cid56?g_st=ac',
    'Open Daily on Shikarpur Road • Authentic Desi & Pakistani Cuisine • Traditional Hospitality'
) on conflict (id) do nothing;

-- Menu Categories
insert into public.menu_categories (id, name, name_urdu, description, display_order) values
('pakistani-cuisine', 'Pakistani Cuisine', 'روایتی پاکستانی کھانے', 'Classic authentic dishes, gravies, and slow-cooked regional specialties', 1),
('biryani-rice', 'Biryani & Rice', 'بریانی اور چاول', 'Fragrant long-grain basmati rice cooked with royal spices', 2),
('karahi-traditional', 'Karahi & Traditional Dishes', 'کڑاہی اور ہانڈی', 'Freshly wok-tossed chicken & mutton karahi with hand-ground spices', 3),
('bbq-grilled', 'BBQ & Grilled Food', 'بار بی کیو اور کباب', 'Charcoal-grilled seekh kababs, tikkas, and smoky delights', 4),
('fast-food', 'Fast Food', 'فاسٹ فوڈ', 'Quick savory bites, crispy burgers, and golden fries', 5),
('tea-refreshments', 'Tea, Cold Drinks & Refreshments', 'چائے اور مشروبات', 'Authentic Karak Dhabba Chai, chilled lassi, and cold sodas', 6)
on conflict (id) do nothing;

-- Menu Items (Sample items with clear disclaimer)
insert into public.menu_items (id, category_id, name, name_urdu, description, price, price_display, image_url, is_available, is_special, is_sample, display_order) values
-- Pakistani Cuisine
('item-1', 'pakistani-cuisine', 'Special Daal Makhni / Handi', 'دال مکھنی ہانڈی', 'Slow-cooked lentils simmered in butter and aromatic spices. (Sample item)', 350, 'Rs. 350 (Sample)', 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=800&q=80', true, false, true, 1),
('item-2', 'pakistani-cuisine', 'Fresh Tandoori Roghni Naan', 'روغنی نان تندوری', 'Hot from the clay tandoor with sesame seeds and pure ghee. (Sample item)', 60, 'Rs. 60 (Sample)', 'https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=800&q=80', true, true, true, 2),
('item-3', 'pakistani-cuisine', 'Desi Murgh Salan (Curry)', 'دیسی مرغ سالن', 'Traditional homestyle chicken curry cooked with tomato and spices. (Sample item)', 750, 'Rs. 750 (Sample)', 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=800&q=80', true, false, true, 3),

-- Biryani & Rice
('item-4', 'biryani-rice', 'Sindhi Special Chicken Biryani', 'سندھی چکن بریانی', 'Fragrant basmati rice layered with tender chicken, potatoes, and Sindhi spices. (Sample item)', 450, 'Rs. 450 (Sample)', 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80', true, true, true, 4),
('item-5', 'biryani-rice', 'Matka Dum Biryani', 'مٹکہ دم بریانی', 'Slow-cooked in sealed clay pot with royal aroma and raita. (Sample item)', 550, 'Rs. 550 (Sample)', 'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=800&q=80', true, false, true, 5),
('item-6', 'biryani-rice', 'Zeera Chawal & Daal Platter', 'زیرہ چاول اور دال', 'Light cumin-tempered basmati rice served with yellow tadka daal. (Sample item)', 300, 'Rs. 300 (Sample)', 'https://images.unsplash.com/photo-1512058564366-18510be2db19?auto=format&fit=crop&w=800&q=80', true, false, true, 6),

-- Karahi & Traditional Dishes
('item-7', 'karahi-traditional', 'Shinwari Chicken Karahi (Full/Half)', 'شنواری چکن کڑاہی', 'Authentic Khyber & highway style karahi cooked in pure fat, tomatoes, and black pepper. (Sample item)', 1600, 'Rs. 1,600 (Sample)', 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=800&q=80', true, true, true, 7),
('item-8', 'karahi-traditional', 'White Murgh Handi', 'وائٹ مرغ ہانڈی', 'Boneless chicken cubes cooked in silky cream, green chilies, and mild herbs. (Sample item)', 1400, 'Rs. 1,400 (Sample)', 'https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=800&q=80', true, false, true, 8),
('item-9', 'karahi-traditional', 'Mutton Karahi Special', 'مٹن کڑاہی اسپیشل', 'Tender goat mutton simmered with fresh ginger slices and crushed coriander. (Sample item)', 2400, 'Rs. 2,400 (Sample)', 'https://images.unsplash.com/photo-1545247181-516773cae754?auto=format&fit=crop&w=800&q=80', true, true, true, 9),

-- BBQ & Grilled Food
('item-10', 'bbq-grilled', 'Chicken Tikka Boti (Sizzling)', 'چکن تکہ بوٹی', 'Charcoal flame-grilled chicken cubes marinated in spicy yogurt blend. (Sample item)', 500, 'Rs. 500 (Sample)', 'https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?auto=format&fit=crop&w=800&q=80', true, true, true, 10),
('item-11', 'bbq-grilled', 'Reshmi Seekh Kabab Plate', 'ریشمی سیخ کباب', 'Tender minced chicken skewers grilled over coals with mint chutney. (Sample item)', 550, 'Rs. 550 (Sample)', 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=800&q=80', true, false, true, 11),
('item-12', 'bbq-grilled', 'Beef Seekh Kabab', 'بیف سیخ کباب', 'Juicy spiced minced beef skewers grilled to perfection. (Sample item)', 600, 'Rs. 600 (Sample)', 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80', true, false, true, 12),

-- Fast Food
('item-13', 'fast-food', 'Crispy Zinger Chicken Burger', 'کرسپی زنگر برگر', 'Golden deep-fried spicy chicken fillet with lettuce and mayo. (Sample item)', 380, 'Rs. 380 (Sample)', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80', true, false, true, 13),
('item-14', 'fast-food', 'Loaded Crispy French Fries', 'مسالہ دار فرنچ فرائز', 'Hot golden potato fries tossed with desi chaat masala. (Sample item)', 200, 'Rs. 200 (Sample)', 'https://images.unsplash.com/photo-1576107232684-1279f3908594?auto=format&fit=crop&w=800&q=80', true, false, true, 14),

-- Tea & Refreshments
('item-15', 'tea-refreshments', 'Special Dhabba Karak Chai', 'اسپیشل ڈھابہ کڑک چائے', 'Strong brewed buffalo milk tea with cardamom and rich aroma. (Sample item)', 80, 'Rs. 80 (Sample)', 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?auto=format&fit=crop&w=800&q=80', true, true, true, 15),
('item-16', 'tea-refreshments', 'Sweet Desi Meethi Lassi', 'دیسی میٹھی لسی', 'Thick churned creamy yogurt drink served in traditional glasses. (Sample item)', 160, 'Rs. 160 (Sample)', 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?auto=format&fit=crop&w=800&q=80', true, false, true, 16),
('item-17', 'tea-refreshments', 'Chilled Cold Drinks & Soda', 'کولڈ ڈرنکس اور سوڈا', 'Chilled 300ml / 500ml glass bottle soft drinks. (Sample item)', 90, 'Rs. 90 (Sample)', 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=800&q=80', true, false, true, 17)
on conflict (id) do nothing;

-- Gallery Images
insert into public.gallery_images (id, title, category, is_real_maps, slot_name, image_url, caption, display_order) values
-- Real Maps Slots (clearly designated)
('map-slot-1', 'Restaurant Highway Frontage & Entrance', 'real_maps', true, 'Exterior Facade Slot', 'assets/images/placeholder.svg', 'Shikarpur Road Highway Entrance (Awaiting Owner Photo Upload)', 1),
('map-slot-2', 'Main Family Dining & Seating Hall', 'real_maps', true, 'Interior Seating Slot', 'assets/images/placeholder.svg', 'Clean and welcoming dining area for families and travelers (Awaiting Owner Photo Upload)', 2),
('map-slot-3', 'Live Tandoor & Cooking Hearth', 'real_maps', true, 'Kitchen / Tandoor Slot', 'assets/images/placeholder.svg', 'Traditional wood-fired tandoor & live kitchen (Awaiting Owner Photo Upload)', 3),
('map-slot-4', 'Roadside Parking & Evening Ambiance', 'real_maps', true, 'Atmosphere Slot', 'assets/images/placeholder.svg', 'Night view and highway roadside parking space (Awaiting Owner Photo Upload)', 4),

-- Food Showcase Photography (Realistic Pakistani Cuisine)
('food-1', 'Traditional Chicken Karahi', 'food', false, null, 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1000&q=80', 'Rich slow-cooked karahi with julienne ginger and coriander', 5),
('food-2', 'Aromatic Royal Sindhi Biryani', 'food', false, null, 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1000&q=80', 'Fragrant basmati rice cooked with authentic spices', 6),
('food-3', 'Charcoal Grilled Seekh Kabab', 'food', false, null, 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1000&q=80', 'Juicy skewers cooked over glowing open embers', 7),
('food-4', 'Fresh Tandoori Naan & Roti', 'food', false, null, 'https://images.unsplash.com/photo-1626074353765-517a681e40be?auto=format&fit=crop&w=1000&q=80', 'Piping hot naan baked fresh in the clay tandoor', 8),
('food-5', 'Sizzling Spiced Chicken Tikka', 'food', false, null, 'https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?auto=format&fit=crop&w=1000&q=80', 'Tender boneless chicken marinated in authentic desi masala', 9),
('food-6', 'Karak Chai & Traditional Tea', 'food', false, null, 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?auto=format&fit=crop&w=1000&q=80', 'Freshly brewed hot karak chai, popular with Jacobabad travelers', 10)
on conflict (id) do nothing;
