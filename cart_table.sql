-- 购物车表
CREATE TABLE IF NOT EXISTS `cart` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` bigint NOT NULL COMMENT '用户ID',
    `book_id` bigint NOT NULL COMMENT '图书ID',
    `count` int NOT NULL DEFAULT 1 COMMENT '数量',
    -- 冗余图书信息，避免跨库查询
    `book_title` varchar(255) NOT NULL COMMENT '图书标题',
    `book_author` varchar(255) DEFAULT NULL COMMENT '图书作者',
    `book_category` varchar(100) DEFAULT NULL COMMENT '图书分类',
    `book_image_url` varchar(500) DEFAULT NULL COMMENT '图书图片URL',
    `book_type` int DEFAULT 1 COMMENT '图书类型：1电子书，2纸质书',
    `book_price` int NOT NULL DEFAULT 0 COMMENT '图书价格（分）',
    `book_points_price` int DEFAULT 0 COMMENT '积分价格',
    `book_stock` int NOT NULL DEFAULT 0 COMMENT '图书库存',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_book` (`user_id`, `book_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_book_id` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车表';