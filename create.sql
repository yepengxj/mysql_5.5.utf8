DROP TABLE IF EXISTS DH_CURRENCY;

DROP TABLE IF EXISTS DH_DATAITEM;

DROP TABLE IF EXISTS DH_DENYGROUP;

DROP TABLE IF EXISTS DH_DENYUSER;

DROP TABLE IF EXISTS DH_DOWNLOADLOG;

DROP TABLE IF EXISTS DH_FIELD;

DROP TABLE IF EXISTS DH_GROUP;

DROP TABLE IF EXISTS DH_PERMITGROUP;

DROP TABLE IF EXISTS DH_PERMITTYPE;

DROP TABLE IF EXISTS DH_PERMITUSER;

DROP TABLE IF EXISTS DH_PRICEUNIT;

DROP TABLE IF EXISTS DH_REPOSITORY;

DROP TABLE IF EXISTS DH_SUPPLYSTYLE;

DROP TABLE IF EXISTS DH_UPLOADLOG;

DROP TABLE IF EXISTS DH_USER;

DROP TABLE IF EXISTS DH_USERLEVEL;

DROP TABLE IF EXISTS DH_USERLIST;

DROP TABLE IF EXISTS DH_USERSTATUS;

/*==============================================================*/
/* Table: DH_CURRENCY                                           */
/*==============================================================*/
CREATE TABLE DH_CURRENCY
(
   CURRENCY_TYPE        INT NOT NULL,
   CURRENCY_NAME        VARCHAR(64) COMMENT '币种名称，如Q币、人民币、欧元',
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (CURRENCY_TYPE)
);

/*==============================================================*/
/* Table: DH_DATAITEM                                           */
/*==============================================================*/
CREATE TABLE DH_DATAITEM
(
   REPOSITORY_ID        INT,
   USER_ID              INT,
   DATAITEM_ID          INT NOT NULL,
   DATAITEM_NAME        VARCHAR(1024) COMMENT '表义的中文名字的
            在搜索结果页面上展示用',
   ICO_NAME             VARCHAR(64) COMMENT '图标文件名',
   TAG                  VARCHAR(1024) COMMENT '用逗号分隔多个tag标记',
   PERMIT_TYPE          INT COMMENT '1-私有，仅限有血缘关系的帐号使用
            2-向所有用户开放
            3-用户白名单可用
            4-用户黑名单不可用
            5-用户组白名单可用
            6-用户组黑名单不可用',
   SUPPLY_STYLE         INT COMMENT '实时单条；批量； 流',
   PRICEUNIT_TYPE       INT COMMENT '定价单位',
   PRICE                DECIMAL(12,3) COMMENT '定价',
   OPTIME               DATE COMMENT '初始化或修改时间',
   REFRESH_TYPE         INT COMMENT '数据的刷新周期，缺省为日',
   REFRESH_DATE         DATE COMMENT '最新数据日期，上传时更新',
   FILE_TYPE            VARCHAR(64) COMMENT '文件格式',
   SAMPLE_FILENAME      VARCHAR(1024) COMMENT '样例数据',
   PASSWORD             VARCHAR(64) COMMENT '查看宝藏的密码，存明码，admin查询提供给请求的用户，可临时查看',
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (DATAITEM_ID)
);

/*==============================================================*/
/* Table: DH_DENYGROUP                                          */
/*==============================================================*/
CREATE TABLE DH_DENYGROUP
(
   GROUP_ID             INT NOT NULL,
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, GROUP_ID, DATAITEM_ID)
);

/*==============================================================*/
/* Table: DH_DENYUSER                                           */
/*==============================================================*/
CREATE TABLE DH_DENYUSER
(
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, DATAITEM_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_DOWNLOADLOG                                        */
/*==============================================================*/
CREATE TABLE DH_DOWNLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   DATA_DATE            DATE NOT NULL,
   DOWN_USER            INT NOT NULL,
   OP_TIME              DATETIME NOT NULL,
   PRIMARY KEY (DATAITEM_ID, DATA_DATE, DOWN_USER, OP_TIME)
);

/*==============================================================*/
/* Table: DH_FIELD                                              */
/*==============================================================*/
CREATE TABLE DH_FIELD
(
   DATAITEM_ID          INT NOT NULL,
   FIELD_ID             INT NOT NULL,
   FIELD_RAWNAME        VARCHAR(64) COMMENT '字段名或文件列名，用于提取数据使用',
   FIELD_NAME           VARCHAR(64) COMMENT '数据项名称，在搜索结果页面上展示',
   PRIMARY_KEY          INT COMMENT '是否是原表中的主键，是数据建立链接的id',
   FIELD_DATATYPE       INT COMMENT '数据项的数据类型',
   FIELD_DATALENGTH     INT COMMENT '数据项的长度',
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (DATAITEM_ID, FIELD_ID)
);

/*==============================================================*/
/* Table: DH_GROUP                                              */
/*==============================================================*/
CREATE TABLE DH_GROUP
(
   GROUP_ID             INT NOT NULL,
   GROUP_NAME           VARCHAR(64),
   CREATE_USER          INT,
   OPTIME               DATETIME,
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (GROUP_ID)
);

/*==============================================================*/
/* Table: DH_PERMITGROUP                                        */
/*==============================================================*/
CREATE TABLE DH_PERMITGROUP
(
   GROUP_ID             INT NOT NULL,
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, GROUP_ID, DATAITEM_ID)
);

/*==============================================================*/
/* Table: DH_PERMITTYPE                                         */
/*==============================================================*/
CREATE TABLE DH_PERMITTYPE
(
   PERMIT_TYPE          INT NOT NULL,
   PERMIT_NAME          VARCHAR(64) NOT NULL,
   PRIMARY KEY (PERMIT_TYPE)
);

/*==============================================================*/
/* Table: DH_PERMITUSER                                         */
/*==============================================================*/
CREATE TABLE DH_PERMITUSER
(
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, DATAITEM_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_PRICEUNIT                                          */
/*==============================================================*/
CREATE TABLE DH_PRICEUNIT
(
   PRICEUNIT_TYPE       INT NOT NULL COMMENT '条、百条、千条
            字节、千字节、兆字节',
   CURRENCY_TYPE        INT,
   PRICEUNIT_NAME       VARCHAR(64),
   PRIMARY KEY (PRICEUNIT_TYPE)
);

/*==============================================================*/
/* Table: DH_REPOSITORY                                         */
/*==============================================================*/
CREATE TABLE DH_REPOSITORY
(
   REPOSITORY_ID        INT NOT NULL,
   REPOSITORY_NAME      VARCHAR(64) COMMENT '数据提供者起的名字，对消费者有吸引力即可',
   USER_ID              INT,
   PERMIT_TYPE          INT COMMENT '1-私有，仅限有血缘关系的帐号可见
            2-所有用户可见
            3-用户白名单可见
            4-用户黑名单不可见
            5-用户组白名单可见
            6-用户组黑名单不可见',
   PRIMARY KEY (REPOSITORY_ID)
);

/*==============================================================*/
/* Table: DH_SUPPLYSTYLE                                        */
/*==============================================================*/
CREATE TABLE DH_SUPPLYSTYLE
(
   SUPPLY_STYLE         INT NOT NULL,
   SUPPLY_NAME          VARCHAR(64) NOT NULL,
   PRIMARY KEY (SUPPLY_STYLE)
);

/*==============================================================*/
/* Table: DH_UPLOADLOG                                          */
/*==============================================================*/
CREATE TABLE DH_UPLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   DATA_DATE            DATE NOT NULL,
   FILENAME             VARCHAR(1024),
   OP_TIME              DATETIME NOT NULL,
   PRIMARY KEY (DATAITEM_ID, DATA_DATE)
);

/*==============================================================*/
/* Table: DH_USER                                               */
/*==============================================================*/
CREATE TABLE DH_USER
(
   USER_ID              INT NOT NULL,
   USER_LEVEL           INT COMMENT '1-组册用户
            2-认证用户（核定了资质）
            3-授权用户（有押金）',
   COMPANY_ID           BIGINT,
   LOGIN_NAME           VARCHAR(64) COMMENT '登录用户名',
   LOGIN_PASSWD         VARCHAR(1024) COMMENT '密码，需密文存储',
   PHONE_NO             VARCHAR(64),
   EMAIL                VARCHAR(1024),
   USER_STATUS          INT COMMENT '标记用户帐户状态，-1阻止登录',
   CLONE_USER           INT,
   PRIMARY KEY (USER_ID)
);

/*==============================================================*/
/* Table: DH_USERLEVEL                                          */
/*==============================================================*/
CREATE TABLE DH_USERLEVEL
(
   USER_LEVEL           INT NOT NULL,
   LEVEL_NAME           VARCHAR(64),
   PRIMARY KEY (USER_LEVEL)
);

/*==============================================================*/
/* Table: DH_USERLIST                                           */
/*==============================================================*/
CREATE TABLE DH_USERLIST
(
   GROUP_ID             INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (USER_ID, GROUP_ID)
);

/*==============================================================*/
/* Table: DH_USERSTATUS                                         */
/*==============================================================*/
CREATE TABLE DH_USERSTATUS
(
   USER_STATUS          INT NOT NULL,
   STATUS_NAME          VARCHAR(64),
   PRIMARY KEY (USER_STATUS)
);

#SET @@CHARACTER_SET_SERVER='utf8'; 

INSERT INTO DH_USER VALUES ('1001', '3', NULL, 'zhhs888888', '5dc828c0e0fc5ff0e94dec595251259b', '13609251885', 'gongjing5@asiainfo.com', '1', NULL);
INSERT INTO DH_USER VALUES ('1002', '3', NULL, 'sya666666', 'bde202e8ab686fec2a848e15b61744cb', '13808305511', 'gongjing5@asiainfo.com', '1', NULL);
INSERT INTO DH_USER VALUES ('1004', '5', NULL, 'admin', '0192023a7bbd73250516f069df18b500', '82166436', 'gongjing5@asiainfo.com', '1', NULL);
INSERT INTO DH_USER VALUES ('2001', '5', NULL, 'fenghw', '86edd721bd0c5533aef7856bd0eb96ed', NULL, NULL, '1', NULL);
INSERT INTO DH_USER VALUES ('2002', '5', NULL, 'gongjing', '2ae630ce03d318325426a807057d2be6', '13311288822', 'gongjing5@asiainfo.com', '1', NULL);


INSERT INTO DH_REPOSITORY VALUES ('10', '手机信息大全', '1002', '2');
INSERT INTO DH_REPOSITORY VALUES ('11', '位置信息大全', '1002', '2');
INSERT INTO DH_REPOSITORY VALUES ('20', '公共数据', '2002', '2');

INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1011', '全国在网（新增）终端', 'terminal.png', '手机;终端;iphone', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'terminal.del', '888888', '全国终端在网和新增终端的分布情况。分省份、地市，统计终端的品牌分布、网龄分布、DOU分布、ARPU分布，平均DOU、平均ARUP等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1012', '全国终端换机分析', 'terminal.png', '手机;终端;iphone', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'terminal.del', '888888', '统计全国终端换机分布情况。分省份、地市，统计终端换机前、后的终端品牌、型号，消费ARPU、DOU，换机周期、换机终端数量等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1013', 'APP使用情况', 'Apps.png', 'APP;应用', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'app.del', '888888', '统计全国智能终端APP的使用情况。按天统计用户APP的使用情况，包括APP类型、APP名称、独立访客访问次数、访问总次数等信息。');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1014', '电商访问数据', 'electronic_business.png', '电商;网店', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'app.del', '888888', '统计全国智能终端访问电商的情况。以天为统计周期，内容包括访问方式、访问对象、访问商品ID，独立访客访访问量、访问总量、购买数、收藏数。');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1015', '股票访问次数', 'stock.png', '股票;stock', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'app.del', '888888', '统计全国智能终端访问股票的情况。以天为统计周期，包括访问的股票名称、股票代码、浏览次数、WEB浏览次数、搜索次数等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1016', '搜索热词', 'search_hot.png', '搜索;search;热词', '2', '1', '1', '1.000', '2015-08-01', '2', '2015-07-31', 'txt格式文件', 'app.del', '888888', '汇总全国移动端搜索数据。以天为周期，内容包扩用户使用的搜索引擎，搜索关键词，独立访客访问量、访问总量等。');

INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2000', '银联数据', 'unionpay.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'txt格式文件', NULL, '888855', '通过数十个维度的特征指标，对用户群体进行消费特征分析。包含42亿张银联卡，8亿银联持卡人，1200万家境内联网商户、3000万家境外联网商户、6000万笔日均交易流水。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2001', '工商数据', 'industry_commerce.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'txt格式文件', NULL, '888866', '全国企业、事业、机关、社会团体、民办非企业及其他合法组织的工商数据。共覆盖1800万家单位，覆盖所有省、市、县、乡镇，每日动态更新数据。为校验用户身份提供有效依据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2002', '社交数据', 'social.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'txt格式文件', NULL, '111111', '互联用户的社交数据。包括论坛、贴吧、微博、微信公众号等主流社交网络的用户信息、用户评论、转发，用户关系等数据。可作为品牌效果评价，也可以作为产品改进或者营销创意的依据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2003', '公交数据', 'bus.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '基于海量车辆运行产生的GPS数据。包含自动分析出当前准确的车辆行驶线路、车站位置、线路站序、车-线对应关系、首末班发车，发车间隔、甩站、滞站、行车速度。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2004', '气象数据', 'weather.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国天气监测数据。包括风力风向、每日平均温度、每日最高最低温度、降水量、相对湿度、气压，共覆盖2000+国家级地面观测站、5W+区域自动站的实时监测数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2005', 'GIS地图', 'GIS_map.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国基础地图数据。包括不同比例，如1:500、1:1000、1:2000、1:5000、1:10000、1:50000等图例，包括多种数据模型，如多维模型数据、360全景数据、遥感影像数据、标准地址数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2006', '农业数据', 'farming.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国农业数据信息。包括宏观经济景气数据、农村统计数据、渔业统计数据、畜牧业统计数据、林业统计数据、粮食专题数据、农产品贸易数据；蔬果、茶叶、中药材、水产品价格监测。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2007', '线上电商零售数据', 'sell.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '主流电商零售数据。包括京东、天猫、亚马逊、1号店、当当网、我买网、国美、苏宁、聚美网、乐峰网、易迅等线上电商商品品类、价格、销售量、关联销售、促销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2008', '线上医药数据', 'medicine.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括壹药网、康爱、老百姓大药房、好药师、金象网等网站药品类目、价格、销售、促销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2009', '影视数据', 'film.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '主流视频网站的影视数据。包括优酷、爱奇艺、搜狐视频、腾讯视频、乐视网、豆瓣、1905影视内容、浏览量、客户评论、热度，相关艺人的关注度、影视库，好评度等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2010', '旅游信息', 'trip.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '主流在线旅游网站的旅游产品信息。包括携程、去哪儿、途牛等网站旅游产品、旅游路线、旅游产品关注度、产品价格、攻略、客户问题、营销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2012', 'APP数据', 'app.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国安卓系统APP情况。包括App应用的留存用户、新增用户、在线用户、推送数据、用户点击行为等核心数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2013', '新浪微博数据', 'sina_weibo.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '新浪微博账号统计数据。包括7×24h全天候实时监测，账号分析、互动分析、大号分析、行业分析、粉丝分析等共计11个专业维度。微博营销情况，微博热门事件等事件分析。 ');


INSERT INTO DH_FIELD VALUES ('1011','1','月份','month_id', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','2','省份','province', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','3','地市','city', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','4','品牌','manu', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','5','型号','device', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','6','终端价格','price', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','7','新增终端量','addcnt', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','8','在网终端量','cnt', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','9','0终端网龄','tiff_range_0', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','10','终端网龄（0,3]','tiff_range_1', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','11','终端网龄（3,6]','tiff_range_2', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','12','终端网龄（6,9]','tiff_range_3', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','13','终端网龄（9,12]','tiff_range_4', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','14','终端网龄（12,15]','tiff_range_5', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','15','终端网龄（15,18]','tiff_range_6', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','16','终端网龄（18,21]','tiff_range_7', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','17','终端网龄（21,24]','tiff_range_8', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','18','终端网龄24月份以上','tiff_range_9', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','19','终端平均网龄','avg_tiff_range', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','20','零DOU','0DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','21','0-1DOU','0-1DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','22','1-5DOU','1-5DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','23','5-10DOU','5-10DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','24','10-20DOU','10-20DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','25','20-30DOU','20-30DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','26','30-50DOU','30-50DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','27','50-100DOU','50-100DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','28','100-150DOU','100-150DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','29','150-200DOU','150-200DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','30','200-300DOU','200-300DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','31','300-400DOU','300-400DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','32','400-500DOU','400-500DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','33','500-600DOU','500-600DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','34','600-700DOU','600-700DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','35','700-750DOU','600-750DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','36','750-1GDOU','750-1GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','37','1G-1.5GDOU','1G-1.5GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','38','1.5G-2GDOU','1.5G-2GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','39','2G-3GDOU','2G-3GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','40','3G-4GDOU','3G-4GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','41','4G-5GDOU','4G-5GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','42','5G-6GDOU','5G-6GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','43','大于6GDOU','6GDOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','44','平均流量','DOU', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','45','零ARUP','0ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','46','0-10ARUP','0-10ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','47','10-20ARUP','10-20ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','48','20-30ARUP','20-30ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','49','30-40ARUP','30-40ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','50','40-50ARUP','40-50ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','51','50-60ARUP','50-60ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','52','60-70ARUP','60-70ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','53','70-80ARUP','70-80ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','54','80-90ARUP','80-90ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','55','90-100ARUP','90-100ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','56','100-110ARUP','100-110ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','57','110-120ARUP','110-120ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','58','120-113ARUP','120-130ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','59','130-140ARUP','130-140ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','60','140-150ARUP','140-150ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','61','150-160ARUP','150-160ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','62','160-170ARUP','160-170ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','63','170-180ARUP','170-180ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','64','180-190ARUP','180-190ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','65','190-200ARUP','190-200ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','66','200-300ARUP','200-300ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','67','300-400ARUP','300-400ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','68','400-500ARUP','400-500ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','69','500-700ARUP','500-700ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','70','大于700ARUP','700ARUP', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011','71','平均收入','ARUP', '1', '1', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1012','1','换机月份','month', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','2','省份','province', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','3','地市','city', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','4','换机后新的手机品牌','manu', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','5','换机后新的手机型号（tac）','device', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','6','换机前品牌','manu_af', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','7','换机前型号（tac）','device_af', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','8','换机终端量','cnt', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','9','换机前一手终端量','addcnt', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','10','换机前二手终端量','oldcnt', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','11','当月DOU(换机前流量)','useflows0', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','12','当月ARUP(换机前ARUP)','usearpu0', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','13','N-1月DOU(换机前流量)','useflows1', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','14','N-1月ARUP(换机前ARUP)','usearpu1', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','15','N-2月DOU(换机前流量)','useflows2', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','16','N-2月ARUP(换机前ARUP)','usearpu2', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','17','N-3月DOU(换机前流量)','useflows3', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','18','N-3月ARUP(换机前ARUP)','usearpu3', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','19','N+1月DOU(换机前流量)','useflows4', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','20','N+1月ARUP(换机前ARUP)','usearpu4', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','21','N+2月DOU(换机前流量)','useflows5', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','22','N+2月ARUP(换机前ARUP)','usearpu6', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012','23','平均换机周期','avg_esn_tiffs', '1', '1', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1013','1','日期','date_id','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013','2','APP类型','app_type','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013','3','APP名称','app_name','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013','4','UV','UV','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013','5','PV','PV','1', '1', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1014','1','日期','date_id','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','2','访问方式','access_type','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','3','访问对象','access_object','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','4','商品ID','product_id','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','5','UV','UV','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','6','PV','PV','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','7','购买数','bug_num','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1014','8','收藏数','follow_num','1', '1', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1015','1','股票名称','stock_name','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1015','2','股票代码','stock_code','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1015','3','APP浏览次数','app_views','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1015','4','WEB浏览次数','web_views','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1015','5','搜索次数','search_num','1', '1', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1016','1','日期','date_id','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1016','2','搜索引擎','engine','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1016','3','关键词','key_word','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1016','4','UV','UV','1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1016','5','PV','PV','1', '1', NULL,NULL);

INSERT INTO DH_USERLEVEL VALUES ('1', '注册用户');
INSERT INTO DH_USERLEVEL VALUES ('2', '认证用户');
INSERT INTO DH_USERLEVEL VALUES ('3', 'VIP用户');

INSERT INTO DH_USERSTATUS VALUES ('1', '正常');
INSERT INTO DH_USERSTATUS VALUES ('2', '封锁');
INSERT INTO DH_USERSTATUS VALUES ('3', '注销');

INSERT INTO DH_CURRENCY VALUES ('1', '人民币', '中国银行发行的钞票');
INSERT INTO DH_CURRENCY VALUES ('2', '美元', '山姆大叔的绿纸');
INSERT INTO DH_CURRENCY VALUES ('3', 'Q币', '腾讯公司的虚拟币');
INSERT INTO DH_CURRENCY VALUES ('4', '比特币', '一个神奇的币种');

INSERT INTO DH_PERMITTYPE VALUES ('1', '私有');
INSERT INTO DH_PERMITTYPE VALUES ('2', '公有');
INSERT INTO DH_PERMITTYPE VALUES ('3', '用户白名单可见');
INSERT INTO DH_PERMITTYPE VALUES ('4', '用户黑名单不可见');
INSERT INTO DH_PERMITTYPE VALUES ('5', '组白名单可见');
INSERT INTO DH_PERMITTYPE VALUES ('6', '组黑名单不可见');


INSERT INTO DH_PRICEUNIT VALUES ('10', '1', '单条');
INSERT INTO DH_PRICEUNIT VALUES ('11', '1', '1千条');
INSERT INTO DH_PRICEUNIT VALUES ('20', '1', '1个周期全部数据');
INSERT INTO DH_PRICEUNIT VALUES ('30', '1', '1小时流量');

INSERT INTO DH_SUPPLYSTYLE VALUES ('1', '批量');
INSERT INTO DH_SUPPLYSTYLE VALUES ('2', '小批');
INSERT INTO DH_SUPPLYSTYLE VALUES ('3', '流数据');
INSERT INTO DH_SUPPLYSTYLE VALUES ('4', '单条查询');
COMMIT;


## DH_USER，DH_REPOSITORY 设置主键、自增
ALTER TABLE DH_USER MODIFY USER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(USER_ID);

ALTER TABLE DH_REPOSITORY MODIFY REPOSITORY_ID INT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY(REPOSITORY_ID);

SELECT * FROM DH_DATAITEM WHERE DATAITEM_NAME="手机开通";
;
;
