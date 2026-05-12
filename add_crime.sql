USE bookstore_book;

-- 确保分类字段存在（如果 final_db_fix.sql 没加上，这里补一下）
ALTER TABLE book ADD COLUMN IF NOT EXISTS category VARCHAR(50) DEFAULT NULL AFTER author;
ALTER TABLE book ADD COLUMN IF NOT EXISTS image_url VARCHAR(255) DEFAULT NULL AFTER category;
ALTER TABLE book ADD COLUMN IF NOT EXISTS epub_url VARCHAR(255) DEFAULT NULL AFTER file_url;

-- 删除旧的《罪与罚》记录（如果还存在的话）
DELETE FROM book WHERE title = '罪与罚' OR title = 'Crime and Punishment' OR file_url LIKE '%Crime%';

-- 插入新的《罪与罚》（中文书名，支持 HTML + EPUB）
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

-- 查看插入结果
SELECT id, title, category, file_url, epub_url FROM book WHERE title = '罪与罚';