-- 设置字符集
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

USE bookstore_book;

-- ========= 1. 修复 Python 核心编程的 file_url =========
UPDATE book SET file_url = '/ebooks/Python_Core_Programming_3rd.pdf' WHERE id = 25;

-- ========= 2. 删除所有旧版《罪与罚》冗余记录（仅保留 id=28） =========
DELETE FROM book WHERE title = 'Crime and Punishment' OR title LIKE 'Crime and Punishment%' OR id = 27;
-- 注意：id=28 是正确的中文版，不要删

-- ========= 3. 确保 id=28 的字段完整（已有，但再确认一次） =========
UPDATE book SET
    file_url = '/ebooks/Crime and Punishment.html',
    epub_url = '/ebooks/Crime and Punishment.epub',
    category = '外国文学',
    image_url = 'https://picsum.photos/200/280?random=28',
    description = '《罪与罚》是俄国作家陀思妥耶夫斯基的代表作，也是世界文学史上的经典。小说描写穷大学生拉斯柯尼科夫受无政府主义思想毒害，为生计所迫，杀死放高利贷的老太婆和她的无辜妹妹，制造了一起震惊全俄的凶杀案。经历了一场内心痛苦的忏悔后，他最终在基督徒索尼娅的规劝下投案自首，被判流放西伯利亚。作品着重刻画主人公犯罪前后的心理变化，揭示俄国下层人民的苦难生活，是一部卓越的社会心理小说。'
WHERE id = 28;

-- ========= 4. 验证更新结果 =========
SELECT id, title, file_url FROM book WHERE id = 25;
SELECT id, title, file_url, epub_url FROM book WHERE id = 28;