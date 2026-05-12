-- =====================================================
-- 在线图书商城数据库完整修复脚本
-- 包含：user-service, book-service, order-service 所需数据
-- 执行前请确保三个数据库已存在
-- =====================================================

-- 设置客户端字符集，避免中文乱码
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- 1. 修复 bookstore_user 数据库
USE bookstore_user;

-- 清空并重建地址表（确保数据完整）
TRUNCATE TABLE address;
INSERT INTO `address` (`user_id`, `receiver_name`, `phone`, `province`, `city`, `district`, `detail`, `is_default`, `created_at`) VALUES
(1, '张三', '13800138002', '北京市', '北京市', '朝阳区', '建国路1号', 1, NOW()),
(1, '李四', '13800138003', '上海市', '上海市', '浦东新区', '世纪大道100号', 0, NOW()),
(2, '王卖家', '13800000001', '广东省', '深圳市', '南山区', '科技园路10号', 1, NOW()),
(3, '赵卖家', '13800000002', '浙江省', '杭州市', '西湖区', '文三路20号', 1, NOW());

-- 修复优惠券名称
UPDATE `coupon` SET `name` = '满100减10' WHERE `id` = 1;
UPDATE `coupon` SET `name` = '满200减25' WHERE `id` = 2;
UPDATE `coupon` SET `name` = '满300减40' WHERE `id` = 3;
UPDATE `coupon` SET `name` = '新用户专享5元券' WHERE `id` = 4;
UPDATE `coupon` SET `name` = '黄金会员8折券' WHERE `id` = 5;

-- 修复通知内容
UPDATE `notification` SET `content` = '欢迎注册图书商城！' WHERE `id` = 1;
UPDATE `notification` SET `content` = '签到获得20积分' WHERE `id` = 2;
UPDATE `notification` SET `content` = '订单 #1001 已支付成功' WHERE `id` = 3;
UPDATE `notification` SET `content` = '您关注的卖家上新了图书：《Spring Cloud实战》' WHERE `id` = 4;
UPDATE `notification` SET `content` = '恭喜您升级为黄金会员！' WHERE `id` = 5;
UPDATE `notification` SET `content` = '您的优惠券“满100减10”即将过期' WHERE `id` = 6;

-- 2. 修复 bookstore_book 数据库
USE bookstore_book;

-- 创建缺失的表（如果不存在）
CREATE TABLE IF NOT EXISTS `book_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `rating` tinyint(1) NOT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_book_id` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `user_browse_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `book_id` bigint NOT NULL,
  `browse_time` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `uk_user_book` (`user_id`, `book_id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 清空并重新插入完整的图书数据（A~Z 分类，共26本）
TRUNCATE TABLE book;
INSERT INTO `book` (`id`, `title`, `author`, `price`, `stock`, `created`, `description`, `category`, `image_url`, `type`, `seller_id`, `points_price`, `is_free`, `purchase_count`, `sold_count`) VALUES
(1, '马克思主义哲学原理', '王伟光', 45.00, 50, NOW(), '马克思主义基本原理概论', 'A', 'https://picsum.photos/200/280?random=1', 2, 0, 0.00, 0, 12, 10),
(2, '论语译注', '杨伯峻', 32.00, 80, NOW(), '儒家经典译注', 'B', 'https://picsum.photos/200/280?random=2', 2, 0, 0.00, 0, 25, 20),
(3, '社会学概论', '郑杭生', 38.00, 60, NOW(), '社会学入门教材', 'C', 'https://picsum.photos/200/280?random=3', 2, 0, 0.00, 0, 8, 7),
(4, '政治学基础', '王浦劬', 42.00, 40, NOW(), '政治学理论经典', 'D', 'https://picsum.photos/200/280?random=4', 2, 0, 0.00, 0, 5, 4),
(5, '孙子兵法', '孙武', 28.00, 100, NOW(), '中国古典军事著作', 'E', 'https://picsum.photos/200/280?random=5', 2, 0, 0.00, 0, 30, 28),
(6, '经济学原理', '曼昆', 68.00, 70, NOW(), '经济学经典教材', 'F', 'https://picsum.photos/200/280?random=6', 2, 0, 0.00, 0, 45, 40),
(7, '文化苦旅', '余秋雨', 45.00, 55, NOW(), '余秋雨文化散文集', 'G', 'https://picsum.photos/200/280?random=7', 2, 0, 0.00, 0, 20, 18),
(8, '现代汉语', '黄伯荣', 55.00, 45, NOW(), '现代汉语权威教材', 'H', 'https://picsum.photos/200/280?random=8', 2, 0, 0.00, 0, 10, 9),
(9, '围城', '钱钟书', 39.00, 90, NOW(), '钱钟书经典小说', 'I', 'https://picsum.photos/200/280?random=9', 2, 0, 0.00, 0, 60, 55),
(10, '艺术的故事', '贡布里希', 120.00, 30, NOW(), '艺术史入门必读', 'J', 'https://picsum.photos/200/280?random=10', 2, 0, 0.00, 0, 15, 12),
(11, '中国通史', '吕思勉', 88.00, 40, NOW(), '中国通史经典', 'K', 'https://picsum.photos/200/280?random=11', 2, 0, 0.00, 0, 22, 20),
(12, '自然科学概论', '陈阅增', 52.00, 35, NOW(), '自然科学综合概论', 'N', 'https://picsum.photos/200/280?random=12', 2, 0, 0.00, 0, 6, 5),
(13, '高等数学', '同济大学数学系', 65.00, 60, NOW(), '高等数学教材', 'O', 'https://picsum.photos/200/280?random=13', 2, 0, 0.00, 0, 35, 30),
(14, '天文学简史', '迈克尔·霍斯金', 48.00, 25, NOW(), '天文学发展简史', 'P', 'https://picsum.photos/200/280?random=14', 2, 0, 0.00, 0, 4, 3),
(15, '物种起源', '达尔文', 58.00, 40, NOW(), '进化论奠基之作', 'Q', 'https://picsum.photos/200/280?random=15', 2, 0, 0.00, 0, 18, 15),
(16, '内科学', '葛均波', 98.00, 20, NOW(), '内科学权威教材', 'R', 'https://picsum.photos/200/280?random=16', 2, 0, 0.00, 0, 12, 10),
(17, '农业生态学', '骆世明', 46.00, 30, NOW(), '农业生态学基础', 'S', 'https://picsum.photos/200/280?random=17', 2, 0, 0.00, 0, 3, 2),
(18, '计算机组成原理', '唐朔飞', 59.00, 80, NOW(), '计算机组成原理经典', 'T', 'https://picsum.photos/200/280?random=18', 2, 0, 0.00, 0, 55, 50),
(19, '交通运输工程', '吴娇蓉', 72.00, 15, NOW(), '交通运输工程概论', 'U', 'https://picsum.photos/200/280?random=19', 2, 0, 0.00, 0, 2, 1),
(20, '航空航天概论', '贾玉红', 65.00, 20, NOW(), '航空航天技术概论', 'V', 'https://picsum.photos/200/280?random=20', 2, 0, 0.00, 0, 5, 4),
(21, '环境保护与可持续发展', '钱易', 49.00, 35, NOW(), '环境保护与可持续发展', 'X', 'https://picsum.photos/200/280?random=21', 2, 0, 0.00, 0, 7, 6),
(22, '百科全书', '英国DK公司', 180.00, 10, NOW(), '综合百科全书', 'Z', 'https://picsum.photos/200/280?random=22', 2, 0, 0.00, 0, 8, 7),
(23, '算法导论', 'Thomas H. Cormen', 128.00, 20, NOW(), '算法设计与分析经典', 'T', 'https://picsum.photos/200/280?random=23', 2, 1, 0.00, 0, 42, 38),
(24, 'Java编程思想', 'Bruce Eckel', 99.00, 30, NOW(), 'Java编程思想', 'T', 'https://picsum.photos/200/280?random=24', 2, 2, 0.00, 0, 70, 65),
(25, 'Python核心编程', 'Wesley Chun', 89.00, 25, NOW(), 'Python核心编程', 'T', 'https://picsum.photos/200/280?random=25', 1, 1, 0.00, 0, 50, 45),
(26, 'Spring Boot实战', 'Craig Walls', 79.00, 50, NOW(), 'Spring Boot实战', 'T', 'https://picsum.photos/200/280?random=26', 1, 0, 0.00, 0, 38, 35);

-- 清空并重新插入图书评论
TRUNCATE TABLE book_review;
INSERT INTO `book_review` (`book_id`, `user_id`, `rating`, `comment`, `created_at`) VALUES
(1, 1, 5, '马克思主义哲学入门必读，讲解清晰', NOW()),
(2, 1, 4, '论语译注详细，适合初学者', NOW()),
(23, 1, 5, '算法导论不愧是圣经，值得反复阅读', NOW()),
(24, 2, 4, 'Java编程思想经典，但部分内容稍旧', NOW()),
(25, 3, 5, 'Python核心编程，实战性强', NOW());

-- 清空并重新插入浏览历史
TRUNCATE TABLE user_browse_history;
INSERT INTO `user_browse_history` (`user_id`, `book_id`, `browse_time`) VALUES
(1, 1, NOW()), (1, 2, NOW()), (1, 23, NOW()), (1, 24, NOW());

-- 3. 修复 bookstore_order 数据库（补充缺失的表）
USE bookstore_order;

-- 创建缺失的表（如果不存在）
CREATE TABLE IF NOT EXISTS `book_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `book_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `rating` tinyint(1) NOT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `user_browse_history` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `book_id` bigint NOT NULL,
  `browse_time` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `uk_user_book` (`user_id`, `book_id`),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 清空并重新插入订单数据（已有订单保持不变，可选择性清空）
-- 为避免破坏已有订单，这里只做补充，不清空。如果希望全新开始，可取消下面注释
-- TRUNCATE TABLE order_item;
-- TRUNCATE TABLE logistics;
-- TRUNCATE TABLE `order`;
-- 然后重新插入之前的测试订单（略）

-- 验证查询（可选，执行后应看到0条空标题）
SELECT '图书空标题数量:' AS Info, COUNT(*) FROM bookstore_book.book WHERE title IS NULL OR title = '';
SELECT '地址表记录数:' AS Info, COUNT(*) FROM bookstore_user.address;

-- 完成提示
SELECT '数据库修复完成，所有中文数据已正确插入！' AS Status;