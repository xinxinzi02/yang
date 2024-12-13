SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP DATABASE IF EXISTS `takeaway`;
CREATE DATABASE `takeaway`;
use `takeaway`;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货地址',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '联系电话',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '收货地址表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (3, '大连交通大学', '瑶瑶1号', '1589742', 1);
INSERT INTO `address` VALUES (33, '大连交通大学', '牛先生', '7534568523', 9);

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色标识',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '管理员' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', '管理员1', 'http://localhost:9090/files/1707657524366-user5.jpg', 'ADMIN', '13677889922', 'admin@xm.com');

-- ----------------------------
-- Table structure for banner
-- ----------------------------
DROP TABLE IF EXISTS `banner`;
CREATE TABLE `banner`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '广告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banner
-- ----------------------------
INSERT INTO `banner` VALUES (8, 'http://localhost:9090/files/1707804076242-cfab8b38c78c64a841fce81ee08836d.jpg', 22);
INSERT INTO `banner` VALUES (9, 'http://localhost:9090/files/1707804084572-8dc7ce0481a066190e0c015cdbc3f95.jpg', 24);
INSERT INTO `banner` VALUES (10, 'http://localhost:9090/files/1707804092510-0fb80cdd6d64a9ce90270c2b4da5dc6.jpg', 21);
INSERT INTO `banner` VALUES (11, 'http://localhost:9090/files/1707804101250-299a5f5c30ebf41d0d6857d5f8b7237.jpg', 19);
INSERT INTO `banner` VALUES (12, 'http://localhost:9090/files/1707804123206-b978e51f3a00862adce96c097b502f5.jpg', 19);
INSERT INTO `banner` VALUES (13, 'http://localhost:9090/files/1707804132893-d24acda531dc71e233a22308cb1d0b2.jpg', 22);

-- ----------------------------
-- Table structure for business
-- ----------------------------
DROP TABLE IF EXISTS `business`;
CREATE TABLE `business`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '序号',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'logo',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '简介',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `license` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '营业执照',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '待审核' COMMENT '审核状态',
  `time_range` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '营业时间',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商家表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of business
-- ----------------------------
INSERT INTO `business` VALUES (19, '111', '111', '霸王茶姬', 'http://localhost:9090/files/1707657785289-霸王.jpg', 'BUSINESS', '8859620', '本店新出新品！', '大连罗斯福广场', 'http://localhost:9090/files/1707657788656-营业执照.jpg', '通过', '周一到周五9:00 - 22:00', '奶茶饮品');
INSERT INTO `business` VALUES (20, '222', '222', '酥味轩', 'http://localhost:9090/files/1707659381836-酥味轩.jpg', 'BUSINESS', '123456', '新店开张', '大连罗斯福广场', 'http://localhost:9090/files/1707659385301-营业执照.jpg', '通过', '周一到周9:00 - 22:00', '特色美味');
INSERT INTO `business` VALUES (21, '333', '333', '麦当劳', 'http://localhost:9090/files/1707660153968-e339e2059db67abafe5a03cccb6f3f7.jpg', 'BUSINESS', '1234567', '祝你新年金拱门', '大连罗斯福广场', 'http://localhost:9090/files/1707660157076-营业执照.jpg', '通过', '周二到周日    9:00 - 22:00', '炸鸡汉堡');
INSERT INTO `business` VALUES (22, '444', '444', '满魏明', 'http://localhost:9090/files/1707660687777-71bd63117d3ac441bf42e2dfa141bf3.jpg', 'BUSINESS', '1234567', '油炸不腻', '大连罗斯福广场', 'http://localhost:9090/files/1707660693902-营业执照.jpg', '通过', '周一到周日8.00-9.00', '炸鸡汉堡');
INSERT INTO `business` VALUES (23, '555', '555', '吉野家', 'http://localhost:9090/files/1707661371904-b468f77462fdfac78d5a88d3f3353a9.jpg', 'BUSINESS', '123456', '本店新出新品！', '大连罗斯福广场', 'http://localhost:9090/files/1707661376338-营业执照.jpg', '通过', '周一到周五9:00 - 22:00', '特色美味');
INSERT INTO `business` VALUES (24, '666', '666', '必胜客', 'http://localhost:9090/files/1707661753781-0bef4f0bad638d20581e2e7487155b0.jpg', 'BUSINESS', '1234546', '西餐一流', '大连罗斯福广场', 'http://localhost:9090/files/1707661775712-29c5a49f986ac98290774592001fd8c.jpg', '通过', '周一到周五9:00 - 22:00', '特色美味');

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `num` int NULL DEFAULT NULL COMMENT '数量',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 142 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '购物车' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (120, 30, 1, 1, 22);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品分类' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (18, '饮品', 19);
INSERT INTO `category` VALUES (19, '蛋糕', 20);
INSERT INTO `category` VALUES (20, '油炸类', 21);
INSERT INTO `category` VALUES (21, '炸鸡类', 22);
INSERT INTO `category` VALUES (22, '主食类', 23);
INSERT INTO `category` VALUES (23, '本店精选', 24);
INSERT INTO `category` VALUES (24, '西餐', 24);

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户收藏' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES (7, 23, 1, '2024-02-17 16:24:41');
INSERT INTO `collect` VALUES (8, 20, 1, '2024-02-17 16:24:56');
INSERT INTO `collect` VALUES (9, 24, 9, '2024-02-17 18:10:31');
INSERT INTO `collect` VALUES (11, 24, 1, '2024-02-19 22:11:43');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论',
  `star` double(10, 1) NULL DEFAULT 0.0 COMMENT '评分',
  `user_id` int NULL DEFAULT NULL COMMENT '用户ID',
  `business_id` int NULL DEFAULT NULL COMMENT '商家iD',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品ID',
  `order_id` int NULL DEFAULT NULL COMMENT '订单ID',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_id`(`user_id` ASC, `order_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '评价表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (6, '非常好吃', 5.0, 1, 24, NULL, 6, '2024-02-16 15:51:28');
INSERT INTO `comment` VALUES (7, '好', 2.0, 1, 24, NULL, 14, '2024-02-17 16:07:13');
INSERT INTO `comment` VALUES (12, '哈哈哈', 3.0, 1, 23, NULL, 23, '2024-02-19 22:16:30');

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片',
  `descr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '描述',
  `origin` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '原材料',
  `taste` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '口味',
  `specs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '规格',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '上架日期',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '上架' COMMENT '上架状态',
  `discount` double(11, 1) NULL DEFAULT 1.0 COMMENT '折扣',
  `business_id` int NULL DEFAULT NULL COMMENT '商家ID',
  `category_id` int NULL DEFAULT NULL COMMENT '分类ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '商品信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (16, '伯牙绝弦', 16.00, 'http://localhost:9090/files/1707657903873-shop1.jpg', '130卡路里', '茶 ，奶，糖', '3分糖', '600ml', '2024-02-11', '上架', 1.0, 19, 18);
INSERT INTO `goods` VALUES (17, '桂馥兰香', 18.00, 'http://localhost:9090/files/1707658143493-shop2.jpg', '本店新出新品！', '茶，糖', '香甜', '600ml', '2024-02-10', '上架', 1.0, 19, 18);
INSERT INTO `goods` VALUES (18, '白雾红尘', 18.00, 'http://localhost:9090/files/1707658218843-shop4.jpg', '本店新出新品！', '牛奶+茶', '醇厚', '700ml', '2024-02-09', '上架', 1.0, 19, 18);
INSERT INTO `goods` VALUES (19, '青青糯山', 18.00, 'http://localhost:9090/files/1707659165569-shop5.jpg', '好喝！', '糯米，奶茶', '香醇', '650ml', '2024-02-09', '上架', 1.0, 19, 18);
INSERT INTO `goods` VALUES (20, '玫瑰普尔', 17.00, 'http://localhost:9090/files/1707659238508-shop3.jpg', '本店新出新品！', '玫瑰+奶茶', '香香的', '550ml', '2024-02-16', '上架', 1.0, 19, 18);
INSERT INTO `goods` VALUES (21, '芋泥虎皮卷', 13.00, 'http://localhost:9090/files/1707659631301-3b9de87645a1460d925388d073000c1.jpg', '本店新品！', '鸡蛋+牛奶', '香醇浓厚', '150g/份', '2024-02-06', '上架', 1.0, 20, 19);
INSERT INTO `goods` VALUES (22, '蛋黄酥', 16.00, 'http://localhost:9090/files/1707659781831-5c6fabccfb8d9887998cccf470abd96.jpg', '好吃', '蛋黄+酥皮', '微咸', '200g/份', '2024-02-09', '上架', 1.0, 20, 19);
INSERT INTO `goods` VALUES (23, '麻薯布丁', 15.00, 'http://localhost:9090/files/1707659903715-5807ba5dd8d2d9b66cff669814e6582.jpg', '淡淡的香味', '鸡蛋', '不甜', '500g/盒', '2024-02-23', '上架', 1.0, 20, 19);
INSERT INTO `goods` VALUES (24, '十翅桶', 90.00, 'http://localhost:9090/files/1707660200372-4d0c9f83098584372f40812d7eb73f3.jpg', '活鸡现杀', '鸡腿+鸡翅', '麻辣', '600g/份', '2024-02-17', '上架', 1.0, 21, 20);
INSERT INTO `goods` VALUES (25, '辣腿翅乐四件套', 56.00, 'http://localhost:9090/files/1707660284294-876ba3e88c9e0fe4539710050a4d753.jpg', '四件套', '琵琶腿', '香辣', '400g/份', '2024-02-23', '上架', 1.0, 21, 20);
INSERT INTO `goods` VALUES (26, '金拱门香辣鸡腿堡', 20.00, 'http://localhost:9090/files/1707660332626-598fce276faa991f6e0b9892357c821.jpg', '够吃', '鸡腿+面包+生菜', '麻辣', '100g/个', '2024-02-06', '上架', 1.0, 21, 20);
INSERT INTO `goods` VALUES (27, '薯条', 15.00, 'http://localhost:9090/files/1707660422641-c27a757ac4f80bb951d92bc6b84116c.jpg', 'yyds，非常好吃！', '马铃薯', '香脆', '200g/盒', '2024-02-15', '上架', 1.0, 21, 20);
INSERT INTO `goods` VALUES (28, '香芋派', 10.00, 'http://localhost:9090/files/1707660476917-e124eafe60ea890eac87b4faf1bc6cb.jpg', '好吃不腻！', '香芋+淀粉', '微甜', '50g/个', '2024-02-29', '上架', 0.5, 21, 20);
INSERT INTO `goods` VALUES (29, '大鸡腿', 20.00, 'http://localhost:9090/files/1707660739879-1cae47ad9ff7078ae8cc4843e723d94.jpg', '香而不腻', '鸡腿', '甜辣', '200g/个', '2024-02-29', '上架', 1.0, 22, 21);
INSERT INTO `goods` VALUES (30, '生炸鸡叉骨', 23.00, 'http://localhost:9090/files/1707660807193-2e19a7431141eb1139c98bd88d23101.jpg', '甜脆好吃！', '鸡叉骨', '孜然香', '500g/份', '2024-02-29', '上架', 1.0, 22, 21);
INSERT INTO `goods` VALUES (31, '生炸鸡脖', 21.00, 'http://localhost:9090/files/1707660899610-11c804152091e1435fbfe119300d75b.jpg', '肉多', '鸡脖子', '香辣', '200g/份', '2024-02-07', '上架', 1.0, 22, 21);
INSERT INTO `goods` VALUES (32, '招牌鸡架', 16.00, 'http://localhost:9090/files/1707660960532-35cb613c75114423c42089c9c711f0b.jpg', '很大一只', '鸡架子', '糖醋', '500g/个', '2024-02-14', '上架', 1.0, 22, 21);
INSERT INTO `goods` VALUES (33, '板烧辛麻鸡肉饭小菜蒸蛋套', 21.00, 'http://localhost:9090/files/1707661521638-1dc410b91e2624c1738e51a09816c19.jpg', '本店新品！', NULL, NULL, NULL, '2024-02-23', '上架', 1.0, 23, 22);
INSERT INTO `goods` VALUES (34, '吉味双拼饭', 18.00, 'http://localhost:9090/files/1707661579216-7d5e0fd0baec22705e2e70187317472.jpg', '本店新品！', NULL, NULL, NULL, '2024-02-07', '上架', 1.0, 23, 22);
INSERT INTO `goods` VALUES (35, '招牌牛肉饭套餐', 17.00, 'http://localhost:9090/files/1707661644863-89c8f036ea145da23988d20a8f4ffd9.jpg', '本店新品！', NULL, NULL, NULL, '2024-02-16', '上架', 1.0, 23, 22);
INSERT INTO `goods` VALUES (36, '爆款薯角培根披萨', 60.00, 'http://localhost:9090/files/1707661811885-5b82f16f217c07cad2e09a025c1e0b3.jpg', '本店新出新品', '荞麦面', '香甜', '14寸', '2024-02-07', '上架', 1.0, 24, 23);
INSERT INTO `goods` VALUES (37, '爆款意式肉酱披萨', 52.00, 'http://localhost:9090/files/1707661874157-9775ecb801732314449b98e570653a1.jpg', '香甜肉酱', '小麦粉+肉酱', '香醇', '15寸', '2024-02-14', '上架', 1.0, 24, 23);
INSERT INTO `goods` VALUES (38, '臻选西冷牛排', 75.00, 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', '鲜嫩多汁', '牛肉+黑胡椒', '孜然麻辣', '600g/份', '2024-02-22', '上架', 1.0, 24, 23);
INSERT INTO `goods` VALUES (39, '意式肉酱面', 30.00, 'http://localhost:9090/files/1707662035961-70f8a6da06966fb593e3b2f625448cb.jpg', '味道极好', '意大利面', '番茄味', '400g/份', '2024-02-27', '上架', 0.5, 24, 24);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '内容',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建时间',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '公告信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (1, '今天系统正式上线，开始内测', '今天系统正式上线，开始内测', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (2, '所有功能都已完成，可以正常使用', '所有功能都已完成，可以正常使用', '2023-09-05', 'admin');
INSERT INTO `notice` VALUES (3, '今天天气很不错，可以出去一起玩了', '今天天气很不错，可以出去一起玩了', '2023-09-05', 'admin');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单编号',
  `time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '下单时间',
  `pay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付类型',
  `pay_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '订单状态',
  `business_id` int NULL DEFAULT NULL COMMENT '接单商家ID',
  `user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '送货地址',
  `user_id` int NULL DEFAULT NULL COMMENT '下单人ID',
  `amount` decimal(10, 2) NULL DEFAULT NULL COMMENT '订单总价',
  `discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠金额',
  `actual` decimal(10, 2) NULL DEFAULT NULL COMMENT '实付款',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '备注',
  `cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (6, '1758094917759754240', '2024-02-15 19:44:25', '支付宝', NULL, '已经完成', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 440.00, 15.00, 425.00, '', 'http://localhost:9090/files/1707661874157-9775ecb801732314449b98e570653a1.jpg', '爆款意式肉酱披萨等8件商品');
INSERT INTO `orders` VALUES (9, '1758384600976805888', '2024-02-16 14:55:31', '支付宝', '2024-02-17 02:42:55', '已完成', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 150.00, 75.00, 75.00, '', 'http://localhost:9090/files/1707662035961-70f8a6da06966fb593e3b2f625448cb.jpg', '意式肉酱面等5件商品');
INSERT INTO `orders` VALUES (12, '1758471770995544064', '2024-02-16 20:41:54', '支付宝', '2024-02-17 02:42:54', '已完成', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 30.00, 15.00, 15.00, '', 'http://localhost:9090/files/1707662035961-70f8a6da06966fb593e3b2f625448cb.jpg', '意式肉酱面等1件商品');
INSERT INTO `orders` VALUES (13, '1758472778299592704', '2024-02-16 20:45:55', '支付宝', '2024-02-17 02:42:57', '已完成', 23, '瑶瑶1号', '1589742', '大连交通大学', 1, 34.00, 0.00, 34.00, '', 'http://localhost:9090/files/1707661644863-89c8f036ea145da23988d20a8f4ffd9.jpg', '招牌牛肉饭套餐等2件商品');
INSERT INTO `orders` VALUES (14, '1758763923604848640', '2024-02-17 16:02:48', '支付宝', '2024-02-17 16:02:53', '已完成', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 165.00, 15.00, 150.00, '', 'http://localhost:9090/files/1707661811885-5b82f16f217c07cad2e09a025c1e0b3.jpg', '爆款薯角培根披萨等3件商品');
INSERT INTO `orders` VALUES (15, '1758774651367796736', '2024-02-17 16:45:26', '支付宝', '2024-02-17 16:45:30', '待收货', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 60.00, 30.00, 30.00, '', 'http://localhost:9090/files/1707662035961-70f8a6da06966fb593e3b2f625448cb.jpg', '意式肉酱面等2件商品');
INSERT INTO `orders` VALUES (16, '1758775272959455232', '2024-02-17 16:47:56', '支付宝', '2024-02-17 16:47:58', '待评价', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 300.00, 0.00, 300.00, '', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', '臻选西冷牛排等4件商品');
INSERT INTO `orders` VALUES (17, '1758778325238362112', '2024-02-17 17:00:03', '支付宝', '2024-02-17 17:00:05', '待评价', 24, '瑶瑶1号', '1589742', '大连交通大学', 1, 75.00, 0.00, 75.00, '', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', '臻选西冷牛排等1件商品');
INSERT INTO `orders` VALUES (18, '1758796154163523584', '2024-02-17 18:10:53', '支付宝', '2024-02-17 18:10:56', '待评价', 24, '牛先生', '7534568523', '大连交通大学', 9, 225.00, 0.00, 225.00, '', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', '臻选西冷牛排等3件商品');
INSERT INTO `orders` VALUES (19, '1758796543365574656', '2024-02-17 18:12:27', '支付宝', '2024-02-17 18:12:29', '待评价', 24, '牛先生', '7534568523', '大连交通大学', 9, 52.00, 0.00, 52.00, '', 'http://localhost:9090/files/1707661874157-9775ecb801732314449b98e570653a1.jpg', '爆款意式肉酱披萨等1件商品');
INSERT INTO `orders` VALUES (22, '1759582300661383168', '2024-02-19 22:14:46', '支付宝', '2024-02-19 22:14:50', '已退款', 21, '瑶瑶1号', '1589742', '大连交通大学', 1, 10.00, 5.00, 5.00, '', 'http://localhost:9090/files/1707660476917-e124eafe60ea890eac87b4faf1bc6cb.jpg', '香芋派等1件商品');
INSERT INTO `orders` VALUES (23, '1759582624247742464', '2024-02-19 22:16:03', '支付宝', '2024-02-19 22:16:07', '已完成', 23, '瑶瑶1号', '1589742', '大连交通大学', 1, 17.00, 0.00, 17.00, '', 'http://localhost:9090/files/1707661644863-89c8f036ea145da23988d20a8f4ffd9.jpg', '招牌牛肉饭套餐等1件商品');

-- ----------------------------
-- Table structure for orders_item
-- ----------------------------
DROP TABLE IF EXISTS `orders_item`;
CREATE TABLE `orders_item`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int NULL DEFAULT NULL COMMENT '订单ID',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品名称',
  `goods_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '商品图片',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '商品价格',
  `num` int NULL DEFAULT NULL COMMENT '购买数量',
  `goods_id` int NULL DEFAULT NULL COMMENT '商品id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders_item
-- ----------------------------
INSERT INTO `orders_item` VALUES (29, 16, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 10, 38);
INSERT INTO `orders_item` VALUES (30, 16, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 1, 38);
INSERT INTO `orders_item` VALUES (31, 16, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 1, 38);
INSERT INTO `orders_item` VALUES (32, 16, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 1, 38);
INSERT INTO `orders_item` VALUES (33, 17, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 1, 38);
INSERT INTO `orders_item` VALUES (34, 18, '臻选西冷牛排', 'http://localhost:9090/files/1707661927727-d38817c8ff1942a5d44e23ccf89e001.jpg', 75.00, 3, 38);
INSERT INTO `orders_item` VALUES (35, 19, '爆款意式肉酱披萨', 'http://localhost:9090/files/1707661874157-9775ecb801732314449b98e570653a1.jpg', 52.00, 1, 37);
INSERT INTO `orders_item` VALUES (38, 22, '香芋派', 'http://localhost:9090/files/1707660476917-e124eafe60ea890eac87b4faf1bc6cb.jpg', 5.00, 1, 28);
INSERT INTO `orders_item` VALUES (39, 23, '招牌牛肉饭套餐', 'http://localhost:9090/files/1707661644863-89c8f036ea145da23988d20a8f4ffd9.jpg', 17.00, 1, 35);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '密码',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色',
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '123', '123', '瑶瑶1号', 'http://localhost:9090/files/1708152782908-gSW5fm3V4AoIe4c4b0437a54deaaafaa887d82d22de3.jpg', 'USER', '女', '12345678');
INSERT INTO `user` VALUES (2, '456', '456', '瑶瑶2号', 'http://localhost:9090/files/1707657455617-user2.jpg', 'USER', '女', '123456');
INSERT INTO `user` VALUES (3, '789', '789', '瑶瑶3号', 'http://localhost:9090/files/1707657474988-user3.jpg', 'USER', '女', '1234567');
INSERT INTO `user` VALUES (8, 'aaaa', 'aaaa', 'aaaa', NULL, 'USER', NULL, NULL);
INSERT INTO `user` VALUES (9, '瑶瑶5号', '123', '瑶瑶5号', 'http://localhost:9090/files/1697438073596-avatar.png', 'USER', '女', '123456');

SET FOREIGN_KEY_CHECKS = 1;
