USE bookstore_book;

-- 插入《罪与罚》（电子书，价格设为 0.01 元，file_url 指向 HTML 和 EPUB 都需要？一个图书只能有一个 file_url，我们选择主文件 HTML，EPUB 作为备用？或者分开两条记录）
-- 这里我们只插入 HTML 版本作为主电子书，EPUB 可以再插一条作为另一种格式
INSERT INTO book (title, author, price, stock, type, file_url, description, points_price, seller_id, created)
VALUES ('Crime and Punishment', 'Fyodor Dostoyevsky', 0.01, 999, 1, '/ebooks/Crime and Punishment.html', '经典俄国文学作品，描写拉斯柯尼科夫的犯罪与忏悔。', 0, 0, NOW());

-- 如果你想单独插入 EPUB 版本作为另一本电子书（书名区分），也可以
INSERT INTO book (title, author, price, stock, type, file_url, description, points_price, seller_id, created)
VALUES ('Crime and Punishment (EPUB)', 'Fyodor Dostoyevsky', 0.01, 999, 1, '/ebooks/Crime and Punishment.epub', 'EPUB格式，适合电子书阅读器。', 0, 0, NOW());

-- 假设你还有 TXT 版本
INSERT INTO book (title, author, price, stock, type, file_url, description, points_price, seller_id, created)
VALUES ('Crime and Punishment (TXT)', 'Fyodor Dostoyevsky', 0.01, 999, 1, '/ebooks/Crime and Punishment.txt', '纯文本格式，方便预览。', 0, 0, NOW());