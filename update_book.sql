USE bookstore_book;

-- 1. 添加分类和图片字段（如果已经存在，忽略错误）
SET @exist := (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'book' AND column_name = 'category');
SET @sql := IF(@exist = 0, 'ALTER TABLE book ADD COLUMN category VARCHAR(50) DEFAULT NULL AFTER author', 'SELECT "category already exists"');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @exist := (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'book' AND column_name = 'image_url');
SET @sql := IF(@exist = 0, 'ALTER TABLE book ADD COLUMN image_url VARCHAR(255) DEFAULT NULL AFTER category', 'SELECT "image_url already exists"');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 2. 给 book 表增加 epub_url 字段（用于存放 EPUB 文件路径）
SET @exist := (SELECT COUNT(*) FROM information_schema.columns WHERE table_name = 'book' AND column_name = 'epub_url');
SET @sql := IF(@exist = 0, 'ALTER TABLE book ADD COLUMN epub_url VARCHAR(255) DEFAULT NULL AFTER file_url', 'SELECT "epub_url already exists"');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- 3. 删除旧的《罪与罚》记录（避免重复）
DELETE FROM book WHERE title = '罪与罚' OR title = 'Crime and Punishment' OR file_url LIKE '%Crime%';

-- 4. 插入新记录（包含 HTML 和 EPUB 两种路径）
INSERT INTO book (
    title, author, price, stock, type,
    file_url, epub_url, description, points_price,
    seller_id, created, category, image_url
) VALUES (
    '罪与罚',
    '陀思妥耶夫斯基 著',
    0.01,
    999,
    1,
    '/ebooks/Crime and Punishment.html',
    '/ebooks/Crime and Punishment.epub',
    '俄国文学巨匠陀思妥耶夫斯基的代表作，深刻探讨罪与罚的心理过程。',
    0,
    0,
    NOW(),
    '外国文学',
    'https://picsum.photos/200/280?random=100'
);

-- 5. 验证插入
SELECT id, title, category, image_url, file_url, epub_url FROM book WHERE title = '罪与罚';