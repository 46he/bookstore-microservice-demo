-- 设置客户端字符集，避免乱码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 使用图书数据库
USE bookstore_book;

-- 删除之前插入的乱码《罪与罚》（id=27）
DELETE FROM book WHERE id = 27;

-- 插入正确的中文《罪与罚》（包含详细简介）
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
    '《罪与罚》是俄国作家陀思妥耶夫斯基的代表作，也是世界文学史上的经典。小说描写穷大学生拉斯柯尼科夫受无政府主义思想毒害，为生计所迫，杀死放高利贷的老太婆和她的无辜妹妹，制造了一起震惊全俄的凶杀案。经历了一场内心痛苦的忏悔后，他最终在基督徒索尼娅的规劝下投案自首，被判流放西伯利亚。作品着重刻画主人公犯罪前后的心理变化，揭示俄国下层人民的苦难生活，是一部卓越的社会心理小说。',
    0,
    0,
    NOW(),
    '外国文学',
    'https://picsum.photos/200/280?random=27'
);

-- 验证插入结果（应该看到 id=27，title 正常显示）
SELECT id, title, author, category, price, file_url, epub_url FROM book WHERE id = 27;