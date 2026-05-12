-- 通知表
CREATE TABLE IF NOT EXISTS `notification` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `user_id` bigint NOT NULL COMMENT '用户ID',
    `type` varchar(50) NOT NULL COMMENT '通知类型：order(订单), system(系统), promotion(促销), book(新书)',
    `content` text NOT NULL COMMENT '通知内容',
    `is_read` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已读：0未读，1已读',
    `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_is_read` (`is_read`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知表';