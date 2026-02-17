-- CreateTable
CREATE TABLE "customers" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "full_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "phone" TEXT,
    "default_address" TEXT,
    "registered_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "brands" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "country" TEXT,
    "description" TEXT,
    "logo_url" TEXT
);

-- CreateTable
CREATE TABLE "categories" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "products" (
    "article" TEXT NOT NULL PRIMARY KEY,
    "model" TEXT NOT NULL,
    "brand_id" INTEGER NOT NULL,
    "price" REAL NOT NULL,
    "old_price" REAL,
    "description" TEXT,
    "mechanism_type" TEXT,
    "case_material" TEXT,
    "strap_material" TEXT,
    "water_resistance" TEXT,
    "case_diameter" INTEGER,
    "dial_color" TEXT,
    "stock_quantity" INTEGER NOT NULL DEFAULT 0,
    "main_image_url" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "products_brand_id_fkey" FOREIGN KEY ("brand_id") REFERENCES "brands" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "product_categories" (
    "product_article" TEXT NOT NULL,
    "category_id" INTEGER NOT NULL,

    PRIMARY KEY ("product_article", "category_id"),
    CONSTRAINT "product_categories_product_article_fkey" FOREIGN KEY ("product_article") REFERENCES "products" ("article") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "product_categories_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "orders" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "customer_id" INTEGER NOT NULL,
    "order_date" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "total_amount" REAL NOT NULL,
    "status_id" INTEGER NOT NULL,
    "delivery_method_id" INTEGER,
    "delivery_address" TEXT,
    "payment_method_id" INTEGER,
    CONSTRAINT "orders_customer_id_fkey" FOREIGN KEY ("customer_id") REFERENCES "customers" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "orders_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "order_statuses" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "orders_delivery_method_id_fkey" FOREIGN KEY ("delivery_method_id") REFERENCES "delivery_methods" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "orders_payment_method_id_fkey" FOREIGN KEY ("payment_method_id") REFERENCES "payment_methods" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "order_items" (
    "order_id" INTEGER NOT NULL,
    "product_article" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "price_at_purchase" REAL NOT NULL,

    PRIMARY KEY ("order_id", "product_article"),
    CONSTRAINT "order_items_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "orders" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "order_items_product_article_fkey" FOREIGN KEY ("product_article") REFERENCES "products" ("article") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "delivery_methods" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "cost" REAL,
    "estimated_days" INTEGER
);

-- CreateTable
CREATE TABLE "payment_methods" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT
);

-- CreateTable
CREATE TABLE "order_statuses" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "status_name" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "customers_email_key" ON "customers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "brands_name_key" ON "brands"("name");

-- CreateIndex
CREATE UNIQUE INDEX "categories_name_key" ON "categories"("name");

-- CreateIndex
CREATE UNIQUE INDEX "order_statuses_status_name_key" ON "order_statuses"("status_name");
