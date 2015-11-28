USE datahub;

DROP TABLE IF EXISTS DH_CHARGE;

DROP TABLE IF EXISTS DH_COMPANYINFO;

DROP TABLE IF EXISTS DH_DATAITEM;

DROP TABLE IF EXISTS DH_DATAITEMUSAGE;

DROP TABLE IF EXISTS DH_DENYUSER1;

DROP TABLE IF EXISTS DH_DENYUSER2;

DROP TABLE IF EXISTS DH_DIMTABLE;

DROP TABLE IF EXISTS DH_DOWNLOADLOG;

DROP TABLE IF EXISTS DH_EARN;

DROP TABLE IF EXISTS DH_EARNACCOUNT;

DROP TABLE IF EXISTS DH_EXPLORE;

DROP TABLE IF EXISTS DH_FIELD;

DROP TABLE IF EXISTS DH_FOLLOW;

DROP TABLE IF EXISTS DH_GROUP;

DROP TABLE IF EXISTS DH_GROUPMAP;

DROP TABLE IF EXISTS DH_MESSAGEFROM;

DROP TABLE IF EXISTS DH_MESSAGETO;

DROP TABLE IF EXISTS DH_ORDER;

DROP TABLE IF EXISTS DH_PAYACCOUNT;

DROP TABLE IF EXISTS DH_PAYMENT;

DROP TABLE IF EXISTS DH_PERMITUSER1;

DROP TABLE IF EXISTS DH_PERMITUSER2;

DROP TABLE IF EXISTS DH_PRICEUNIT;

DROP TABLE IF EXISTS DH_QUOTA;

DROP TABLE IF EXISTS DH_QUOTAREMAIN;

DROP TABLE IF EXISTS DH_REPOSITORY;

DROP TABLE IF EXISTS DH_REPOSITORYRANKLOG;

DROP TABLE IF EXISTS DH_UPLOADLOG;

DROP TABLE IF EXISTS DH_USER;

DROP TABLE IF EXISTS DH_USERINFO;

/*==============================================================*/
/* Table: DH_CHARGE                                             */
/*==============================================================*/
CREATE TABLE DH_CHARGE
(
   ACCOUNT_ID           VARCHAR(64) NOT NULL COMMENT '账号',
   CURRENCY_TYPE        INT NOT NULL,
   FEE_TYPE             INT COMMENT '充值费用类型
            1-押金
            2-预存款
            3-信用度',
   PAYMENT              DECIMAL(10,3),
   OPTIME               DATETIME NOT NULL COMMENT '帐户变动日期',
   USER_ID              INT,
   PRIMARY KEY (ACCOUNT_ID, CURRENCY_TYPE, OPTIME)
);

/*==============================================================*/
/* Table: DH_COMPANYINFO                                        */
/*==============================================================*/
CREATE TABLE DH_COMPANYINFO
(
   USER_ID              INT NOT NULL,
   COMPANY_NAME         VARCHAR(1024),
   ADDRESS              VARCHAR(1024),
   CERTIFY1             VARCHAR(1024) COMMENT '资质证明材料，上传照片存储的文件名',
   CERTIFY2             VARCHAR(1024) COMMENT '资质证明材料，上传照片存储的文件名',
   CONTACT_NAME         VARCHAR(64),
   PHONE_NO             VARCHAR(16),
   PRIMARY KEY (USER_ID)
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
   PERMIT_TYPE          INT COMMENT '2-public,所有用户可见,但用户黑名单不可见
            3-private,所有用户不可见,但白名单用户可见',
   KEY_WORDS            VARCHAR(1024) COMMENT '用分号分隔多个关键字标记，用于搜索。之前字段名为tag，但tag用于上传数据的标记',
   SUPPLY_STYLE         INT COMMENT '实时单条；批量； 流',
   PRICEUNIT_TYPE       INT COMMENT '定价单位',
   PRICE                DECIMAL(12,3) COMMENT '定价',
   OPTIME               DATE COMMENT '初始化或修改时间',
   DATA_FORMAT          INT COMMENT '数据格式，1-txt、2-xls、3-ppt、4-doc、...',
   REFRESH_TYPE         INT COMMENT '数据的刷新周期，月、日、时、分、秒',
   REFRESH_NUM          INT COMMENT '刷新周期refresh_type的个数',
   META_FILENAME        VARCHAR(1024) COMMENT '新增字段用于数据项描述
            存json格式较好，否则显示没有渲染',
   SAMPLE_FILENAME      VARCHAR(1024) COMMENT '存放样例数据的文件名
            文件内容可以是json格式，显示时可以根据特定的关键字在web上进行渲染',
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (DATAITEM_ID)
);

/*==============================================================*/
/* Table: DH_DATAITEMUSAGE                                      */
/*==============================================================*/
CREATE TABLE DH_DATAITEMUSAGE
(
   DATAITEM_ID          INT NOT NULL,
   DATAITEM_NAME        VARCHAR(1024) COMMENT '表义的中文名字的
            在搜索结果页面上展示用',
   VIEWS                INT COMMENT '查看次数',
   FOLLOWS              INT COMMENT '关注人数',
   DOWNLOADS            INT COMMENT '下载次数',
   STARS                INT COMMENT '质量星级',
   REFRESH_DATE         DATE COMMENT '最新数据日期，上传时更新',
   USABILITY            INT,
   PRIMARY KEY (DATAITEM_ID)
);

/*==============================================================*/
/* Table: DH_DENYUSER1                                          */
/*==============================================================*/
CREATE TABLE DH_DENYUSER1
(
   REPOSITORY_ID        INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_DENYUSER2                                          */
/*==============================================================*/
CREATE TABLE DH_DENYUSER2
(
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (DATAITEM_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_DIMTABLE                                           */
/*==============================================================*/
CREATE TABLE DH_DIMTABLE
(
   FIELD_NAME           VARCHAR(64) NOT NULL,
   ID                   INT NOT NULL,
   NAME                 VARCHAR(64),
   PRIMARY KEY (FIELD_NAME, ID)
);

/*==============================================================*/
/* Table: DH_DOWNLOADLOG                                        */
/*==============================================================*/
CREATE TABLE DH_DOWNLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   TAG                  VARCHAR(64) NOT NULL,
   DOWN_USER            INT NOT NULL,
   OPTIME               DATETIME NOT NULL,
   PRIMARY KEY (DATAITEM_ID, TAG, DOWN_USER, OPTIME)
);

/*==============================================================*/
/* Table: DH_EARN                                               */
/*==============================================================*/
CREATE TABLE DH_EARN
(
   USER_ID              INT NOT NULL,
   YEAR                 INT NOT NULL,
   MONTH                INT NOT NULL,
   CURRENCY_TYPE        INT NOT NULL,
   SHOULD_EARN          DECIMAL(10,3),
   PRIMARY KEY (USER_ID, YEAR, MONTH, CURRENCY_TYPE)
);

/*==============================================================*/
/* Table: DH_EARNACCOUNT                                        */
/*==============================================================*/
CREATE TABLE DH_EARNACCOUNT
(
   ACCOUNT_ID           VARCHAR(64) NOT NULL COMMENT '账号',
   CURRENCY_TYPE        INT NOT NULL,
   USER_ID              INT,
   EARN                 DECIMAL(10,3) COMMENT '信用度，',
   OPTIME               DATETIME COMMENT '帐户变动日期',
   PRIMARY KEY (ACCOUNT_ID, CURRENCY_TYPE)
);

/*==============================================================*/
/* Table: DH_EXPLORE                                            */
/*==============================================================*/
CREATE TABLE DH_EXPLORE
(
   EXPLORE_ID           INT NOT NULL,
   EXPLORE_NAME         VARCHAR(64) NOT NULL COMMENT '1-终端、时空、交通信息、...
            2-txt、xls、pdf、...
            3-...',
   PRIMARY KEY (EXPLORE_ID)
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
/* Table: DH_FOLLOW                                             */
/*==============================================================*/
CREATE TABLE DH_FOLLOW
(
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (DATAITEM_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_GROUP                                              */
/*==============================================================*/
CREATE TABLE DH_GROUP
(
   GROUP_ID             INT NOT NULL,
   GROUP_NAME           VARCHAR(64),
   CREATOR              INT,
   GROUP_QUOTA          INT COMMENT '协作组人数配额
            从creator用户在SellQuota表超的相应字段抄过来',
   USER_NUM             INT COMMENT '协作的用户总数，取自创建组用户的group_quota',
   OPTIME               DATETIME,
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (GROUP_ID)
);

/*==============================================================*/
/* Table: DH_GROUPMAP                                           */
/*==============================================================*/
CREATE TABLE DH_GROUPMAP
(
   GROUP_ID             INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (USER_ID, GROUP_ID)
);

/*==============================================================*/
/* Table: DH_MESSAGEFROM                                        */
/*==============================================================*/
CREATE TABLE DH_MESSAGEFROM
(
   MESSAGE_ID           INT NOT NULL,
   USER_ID              INT NOT NULL,
   MESSAGE              VARCHAR(1024) COMMENT 'json格式的消息，记录涉及的数据对象、内容',
   CREATE_TIME          DATETIME NOT NULL,
   PRIMARY KEY (MESSAGE_ID)
);

/*==============================================================*/
/* Table: DH_MESSAGETO                                          */
/*==============================================================*/
CREATE TABLE DH_MESSAGETO
(
   MESSAGE_ID           INT NOT NULL,
   USER_ID              INT NOT NULL COMMENT '消息的接收者，拥有者',
   STATUS               INT COMMENT '1-创建
            2-已读
            7-删除',
   OPTIME               DATETIME NOT NULL,
   PRIMARY KEY (MESSAGE_ID)
);

/*==============================================================*/
/* Table: DH_ORDER                                              */
/*==============================================================*/
CREATE TABLE DH_ORDER
(
   ORDER_ID             INT NOT NULL,
   USER_ID              INT,
   DATAITEM_ID          INT,
   AMOUNT               INT COMMENT '购买量
            批的是几批；
            条的是几条；
            流的是几分钟；',
   LIST_PRICE           DECIMAL(10,3) COMMENT '列表价',
   APPLY_PRICE          DECIMAL(10,3),
   ACK_PRICE            DECIMAL(10,3) COMMENT '成交价',
   ORDER_STATUS         INT COMMENT '订购状态
            1-初始申请
            8-双方确认
            公开数据、价格为0数据、未议价订单均自动确认',
   OPTIME               DATETIME COMMENT '申请日期、状态变更日期',
   COMMENT              VARCHAR(1024),
   PRIMARY KEY (ORDER_ID)
);

/*==============================================================*/
/* Table: DH_PAYACCOUNT                                         */
/*==============================================================*/
CREATE TABLE DH_PAYACCOUNT
(
   ACCOUNT_ID           INT NOT NULL COMMENT '账号',
   CURRENCY_TYPE        INT NOT NULL,
   USER_ID              INT,
   DEPOSIT              DECIMAL(10,3) COMMENT '押金',
   PREPAY               DECIMAL(10,3) COMMENT '预付款',
   CREDIT               DECIMAL(10,3) COMMENT '信用度，',
   OPTIME               DATETIME COMMENT '帐户变动日期',
   PRIMARY KEY (ACCOUNT_ID)
);

/*==============================================================*/
/* Table: DH_PAYMENT                                            */
/*==============================================================*/
CREATE TABLE DH_PAYMENT
(
   ORDER_ID             INT NOT NULL,
   OPTIME               DATETIME NOT NULL COMMENT '定义或修改时间',
   ACCOUNT_ID           VARCHAR(64) COMMENT '账号',
   PAYMENT              DECIMAL(10,3),
   CREDIT_PAY           DECIMAL(10,3),
   PRIMARY KEY (ORDER_ID, OPTIME)
);

/*==============================================================*/
/* Table: DH_PERMITUSER1                                        */
/*==============================================================*/
CREATE TABLE DH_PERMITUSER1
(
   REPOSITORY_ID        INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_PERMITUSER2                                        */
/*==============================================================*/
CREATE TABLE DH_PERMITUSER2
(
   REPOSITORY_ID        INT NOT NULL,
   USER_ID              INT NOT NULL,
   PRIMARY KEY (REPOSITORY_ID, USER_ID)
);

/*==============================================================*/
/* Table: DH_PRICEUNIT                                          */
/*==============================================================*/
CREATE TABLE DH_PRICEUNIT
(
   PRICEUNIT_TYPE       INT NOT NULL COMMENT '条、百条、千条
            字节、千字节、兆字节',
   CURRENCY_TYPE        INT NOT NULL,
   PRICEUNIT_NAME       VARCHAR(64),
   PRIMARY KEY (PRICEUNIT_TYPE)
);

/*==============================================================*/
/* Table: DH_QUOTA                                              */
/*==============================================================*/
CREATE TABLE DH_QUOTA
(
   SELL_LEVEL           INT NOT NULL,
   REPOSITORY_QUOTA     INT NOT NULL COMMENT '创建repository个数',
   DATAITEM_QUOTA       INT NOT NULL COMMENT '创建dataitem个数',
   TAG_QUOTA            INT NOT NULL,
   GROUP_QUOTA          INT COMMENT '协作组人数配额',
   SPACE_QUOTA          INT NOT NULL COMMENT '托管区空间配额，单位GB',
   PRIMARY KEY (SELL_LEVEL)
);

/*==============================================================*/
/* Table: DH_QUOTAREMAIN                                        */
/*==============================================================*/
CREATE TABLE DH_QUOTAREMAIN
(
   USER_ID              INT NOT NULL,
   REPOSITORY_QUOTA     INT NOT NULL COMMENT '创建repository个数',
   DATAITEM_QUOTA       INT NOT NULL COMMENT '创建dataitem个数',
   TAG_QUOTA            INT,
   GROUP_QUOTA          INT,
   SPACE_QUOTA          INT COMMENT '托管区空间配额，单位GB',
   PRIMARY KEY (USER_ID)
);

/*==============================================================*/
/* Table: DH_REPOSITORY                                         */
/*==============================================================*/
CREATE TABLE DH_REPOSITORY
(
   REPOSITORY_ID        INT NOT NULL,
   REPOSITORY_NAME      VARCHAR(64) COMMENT '数据提供者起的名字，对消费者有吸引力即可',
   USER_ID              INT,
   PERMIT_TYPE          INT COMMENT '2-public,所有用户可见,但用户黑名单不可见
            3-private,所有用户不可见,但白名单用户可见',
   ARRANG_TYPE          INT COMMENT '1-申请托管
            2-可以托管(使用上传功能,将文件上传到托管区）
            ',
   COMMENT              VARCHAR(1024) COMMENT '说明',
   RANK                 INT COMMENT '排名',
   STATUS               INT COMMENT '上升、下降标识
            1-上升
            2-下降',
   DATAITEMS            INT COMMENT '数据项个数',
   TAGS                 INT COMMENT '累计上传的tag个数',
   STARS                INT COMMENT '质量星级',
   OPTIME               DATETIME COMMENT '最新上传tag的日期',
   PRIMARY KEY (REPOSITORY_ID)
);

/*==============================================================*/
/* Table: DH_REPOSITORYRANKLOG                                  */
/*==============================================================*/
CREATE TABLE DH_REPOSITORYRANKLOG
(
   REPOSITORY_ID        INT NOT NULL,
   RANK                 INT COMMENT '查看次数',
   OPTIME               DATETIME NOT NULL,
   PRIMARY KEY (REPOSITORY_ID)
);

/*==============================================================*/
/* Table: DH_UPLOADLOG                                          */
/*==============================================================*/
CREATE TABLE DH_UPLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   TAG                  VARCHAR(64) NOT NULL COMMENT '标识数据的日期等，不可以重复',
   FILENAME             VARCHAR(1024) COMMENT '在文件系统上存储时，存tag_filename',
   OPTIME               DATETIME NOT NULL,
   PRIMARY KEY (DATAITEM_ID, TAG)
);

/*==============================================================*/
/* Table: DH_USER                                               */
/*==============================================================*/
CREATE TABLE DH_USER
(
   USER_ID              INT NOT NULL,
   USER_STATUS          INT NOT NULL,
   USER_TYPE            INT COMMENT '1-普通；2-管理员',
   USER_NAME            VARCHAR(64) COMMENT '登录用户名',
   NICK_NAME            VARCHAR(1024),
   LOGIN_NAME           VARCHAR(64),
   LOGIN_PASSWD         VARCHAR(1024) COMMENT '密码，需密文存储',
   SUMMARY              VARCHAR(1024),
   OP_TIME              TIMESTAMP,
   PRIMARY KEY (USER_ID)
);

/*==============================================================*/
/* Table: DH_USERINFO                                           */
/*==============================================================*/
CREATE TABLE DH_USERINFO
(
   USER_ID              INT NOT NULL,
   ID                   CHAR(18) COMMENT '身份证号',
   NAME                 VARCHAR(64) COMMENT '姓名',
   PHONE_NO             VARCHAR(16),
   PRIMARY KEY (USER_ID)
);

#SET @@CHARACTER_SET_SERVER='utf8'; 

INSERT INTO DH_USER VALUES ('1001', '2', '1', '何鸿凌','何鸿凌', 'hehl@asiainfo.com','8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1002', '2', '1',  '王军', '王军', 'wangjun15@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1003', '2', '1', '龚静','龚静', 'gongjing5@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1004', '2', '1',  '曹润月','曹润月', 'caory@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1005', '2', '1', '程冠凯','程冠凯', 'chenggk@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1006', '2', '1',  '宋亮','宋亮', 'songliang@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1007', '2', '1',  '贺晓童','贺晓童', 'hext3@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1008', '2', '1', '罗振苏','罗振苏', 'luozs@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1009', '2', '1',  '沈道峰','沈道峰', 'shendf@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1010', '2', '1', '王峥','王峥', 'wangzheng3@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1011', '2', '1',  '叶鹏','叶鹏', 'yepeng@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1012', '2', '1', '孟静','孟静', 'mengjing@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1013', '2', '1', '刘杰','刘杰', 'liujie15@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1014', '2', '1',  '王迪','王迪', 'wangdi6@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1015', '2', '1',  '刘雪莹','刘雪莹', 'liuxy10@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1016', '2', '1', '刘旭','刘旭', 'liuxu@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1017', '2', '1',  '潘新元','潘新元', 'panxy3@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1018', '2', '1',  '柴宗山','柴宗山', 'chaizs@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1019', '2', '1',  '袁伟明','袁伟明', 'yuanwm@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1020', '2', '1', '张维意','张维意', 'zhangwy@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1021', '2', '1', '程康健','程康健', 'chengkj@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1022', '2', '2',  'admin','admin', 'datahub@asiainfo.com', '46c5fc8491b9632401a207c7ab04eb0a', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1023', '2', '1', '重庆市数易安信息技术有限公司','数易安', '13808305511@139.com', 'bde202e8ab686fec2a848e15b61744cb', '数易安公司成立于2015年，主要从事数据分析和数据产品服务。','2015-11-12');
INSERT INTO DH_USER VALUES ('1024', '2', '1', '亚信','亚信', 'yaxin@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '亚信是中国最大、全球领先的通信行业IT解决方案和服务提供商,致力于成为“产业互联网时代的领航者”,为实现让中国软件影响世界的目标而不断进取。','2015-11-18');
INSERT INTO DH_USER VALUES ('1025', '2', '1', '华院数据技术（上海）有限公司','华院数据', 'huaysj@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '华院数据技术（上海）有限公司（以下简称“华院数据”—于2012年8月由华院分析和德盈数据合并），成立于2002年3月，是国内为数很少的以高水平的数据挖掘和数据分析为核心能力的专业服务公司。','2015-11-18');
INSERT INTO DH_USER VALUES ('1026', '2', '1', '杭州亚信中亿科技有限公司','中亿', 'zhongyi@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '杭州亚信中亿科技有限公司（以下简称中亿）隶属亚信集团，秉承亚信22年专业服务精神，专业为广大客户提供征信服务。拥有优质的数据合作源，能提供多维度征信服务。','2015-11-19');
INSERT INTO DH_USER VALUES ('1027', '2', '1', '方亮','方亮', 'fangliang@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-12');
INSERT INTO DH_USER VALUES ('1028', '2', '1', '银联智惠','银联智惠', 'yinlian@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '银联智惠是中国银联旗下子公司，成立于2012年，依托中国银联在中国及海外的庞大数据资源，建立并不断完善基于消费数据的商户一站式服务平台，为银联及合作伙伴提供行业分析、经营决策、商业策略等多方面的大数据应用解决方案。','2015-11-19');
INSERT INTO DH_USER VALUES ('1029', '2', '1', '北京芃柏信息技术有限公司','北京芃柏信息技术有限公司', 'pengbai@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '芃柏信息成立于2013年7月，主要从事企业信息服务产品开发和销售，为客户提供企业身份实时认证、企业信息咨询服务。','2015-11-19');
INSERT INTO DH_USER VALUES ('1030', '2', '1', '中科宇图科技股份有限公司','中科宇图科技股份有限公司', 'zhongke@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '2001年11月成立至今，中科宇图通过一次次的技术创新和不断引领业界潮流思路的变革，在环境信息化建设中，以一年一个台阶的速度急速前行——成立国内首家数字环保实验室、制定《环境信息应用软件开发技术规范》、将3S技术与环保业务相结合、设立数字环保奖学金、还多次主持、参与了科技部和环保部的“973计划”、“863计划”、“国家科技支撑计划”、等课题及项目,日渐成为环保行业内最具成长性的优秀企业。','2015-11-19');
INSERT INTO DH_USER VALUES ('1031', '2', '1', '北京市公安局公安交通管理局','北京市公安局公安交通管理局', 'bjjtgl@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市公安局公安交通管理局（简称市公安局交管局）是全市道路交通安全的主管机关，下设17个职能部门，直管东城、西城、朝阳、海淀、丰台、石景山、房山、通州、昌平等9个交通支队和开发区交通大队，并负责指导门头沟、大兴、顺义、怀柔、平谷、机场、密云、延庆等8个非直管交通支、大队和清河分局交通大队的业务工作。','2015-11-20');
INSERT INTO DH_USER VALUES ('1032', '2', '1',  '北京市卫生局','北京市卫生局', 'bjhb@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市卫生局是负责北京市卫生工作的市政府组成部门。','2015-11-20');
INSERT INTO DH_USER VALUES ('1033', '2', '1',  '北京市教育委员会','北京市教育委员会', 'bjedu@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市教育委员会是北京市市政府直辖的一级政府职能部门，主要负责全市教育工作。','2015-11-20');
INSERT INTO DH_USER VALUES ('1034', '2', '1',  '北京市旅游发展委员会','北京市旅游发展委员会', 'bjta@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市旅游发展委员会是主管北京市旅游业管理工作的市政府直属机构。位于朝阳区建国门外大街。前身是北京市服务局、北京市第一服务局、北京市旅行游览事业管理局、北京市旅游事业管理局等。2011年4月，北京市旅游局正式更名为北京市旅游发展委员会。','2015-11-20');
INSERT INTO DH_USER VALUES ('1035', '2', '1', '北京市民防局','北京市民防局', 'bjrf@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市民防局是负责本市人民防空和防灾救灾相关工作的市政府直属机构。加强本市人民防空工程建设和管理的职责，强化人防工程使用安全的管理。强化为中央在京单位人防工程建设、管理、维护、安全使用提供服务和保障的职责。市民防局设8个内设机构，机关行政编制61名。','2015-11-20');
INSERT INTO DH_USER VALUES ('1036', '2', '1', '北京市质量技术监督局','北京市质量技术监督局', 'bjtsb@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '北京市质量技术监督局主要负责北京市质量监督检查；受理对产品质量问题的举报和投诉，调解质量纠纷；管理产品质量仲裁的检验、鉴定；负责查处生产和经销假冒伪劣商品的违法行为；负责产品质量监督检验机构的设置和管理； 监督管理评价性活动。','2015-11-20');
INSERT INTO DH_USER VALUES ('1037', '2', '1', '上海市政府数据服务网','上海市政府数据服务网', 'datashanghai@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '上海市政府数据服务网是上海市人民政府办公厅、上海市经济和信息化委员会牵头，相关政府部门共同参与建设的政府数据服务门户。其目标是促进政府数据资源的开发利用，发挥政府数据资源在本市加快建设“四个中心”和具有全球影响力科技创新中心、产业结构调整和经济结构转型中的重要作用，满足公众和企业对政府数据的“知情权”和“使用权”，向社会提供政府数据资源的浏览、查询、下载等基本服务，同时汇聚发布基于政府数据资源开发的应用程序等增值服务。','2015-11-25');
INSERT INTO DH_USER VALUES ('1038', '2', '1', '党莎','党莎', 'dangsha@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-28');
INSERT INTO DH_USER VALUES ('1039', '2', '1', '王旭宁','王旭宁', 'wangxn5@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-28');
INSERT INTO DH_USER VALUES ('1040', '2', '1', '汪宇虹','汪宇虹', 'wangyh10@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-28');
INSERT INTO DH_USER VALUES ('1041', '2', '1', '刘亮亮','刘亮亮', 'liull7@asiainfo.com', '8ddcff3a80f4189ca1c9d4d902c3c909', '','2015-11-28');


INSERT INTO DH_REPOSITORY VALUES ('10', '位置信息大全', '1002', '2', '1', '','1','1','3','0','5',NULL);
INSERT INTO DH_REPOSITORY VALUES ('20', '公共数据', '2002', '2', '1', '最好的数据，谁都可以用哟','2','2','0','0','1',NULL);

INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1011', '全国在网（新增）终端', 'terminal.png', '2', '手机;iphone', '3', '1', '0.000', '2015-08-01', '2', '1', '1','meta_terminal.doc', 'sample_terminal.doc', '对终端使用情况、变化情况进行了全方面的分析。包括分品牌统计市场存量、新增、机型、数量、换机等情况。终端与ARPU、DOU、网龄的映射关系。终端的APP安装情况等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1012', '全国终端换机分析', 'terminal.png', '2', '手机;iphone', '3', '1', '0.000', '2015-08-01', '2', '1', '1','meta_terminal2.doc', 'sample_terminal2.doc', '对终端使用情况、变化情况进行了全方面的分析。包括分品牌统计市场存量、新增、机型、数量、换机等情况。终端与ARPU、DOU、网龄的映射关系。终端的APP安装情况等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1013', 'APP使用情况', 'Apps.png', '2','app;应用', '3', '1', '0.000', '2015-08-01', '2', '1','1', 'meta_apps.doc', 'sample_apps.doc', '统计全国智能终端APP的使用情况。按天统计用户APP的使用情况，包括APP类型、APP名称、独立访客访问次数、访问总次数等信息。');
INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1014', '电商访问数据', 'electronic_business.png', '2','电商;网店', '3', '1', '0.000', '2015-08-01', '2', '1', '1','meta_electronic_business.doc', 'sample_electronic_business.doc', '统计全国智能终端访问电商的情况。以天为统计周期，内容包括访问方式、访问对象、访问商品ID，独立访客访访问量、访问总量、购买数、收藏数。');
INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1015', '股票访问次数', 'stock.png', '2','股票;stock', '3', '1', '0.000', '2015-08-01', '2', '1', '1','meta_stock.doc', 'sample_stock.doc', '统计全国智能终端访问股票的情况。以天为统计周期，包括访问的股票名称、股票代码、浏览次数、WEB浏览次数、搜索次数等。');
INSERT INTO DH_DATAITEM VALUES ('10', '1004', '1016', '搜索热词', 'search_hot.png', '2','搜索;search;热词', '3', '1', '0.000', '2015-08-01', '2', '1', '1','meta_search_hot.doc', 'sample_search_hot.doc', '汇总全国移动端搜索数据。以天为周期，内容包扩用户使用的搜索引擎，搜索关键词，独立访客访问量、访问总量等。');



INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2001', '银联数据', 'unionpay.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_unionpay.doc', 'sample_unionpay.doc', '通过数十个维度的特征指标，对用户群体进行消费特征分析。包含42亿张银联卡，8亿银联持卡人，1200万家境内联网商户、3000万家境外联网商户、6000万笔日均交易流水。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2002', '工商数据', 'industry_commerce.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_commerce.doc', 'sample_commerce.doc', '全国企业、事业、机关、社会团体、民办非企业及其他合法组织的工商数据。共覆盖1800万家单位，覆盖所有省、市、县、乡镇，每日动态更新数据。为校验用户身份提供有效依据。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2003', '社交数据', 'social.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_social.doc', 'sample_social.doc', '互联用户的社交数据。包括论坛、贴吧、微博、微信公众号等主流社交网络的用户信息、用户评论、转发，用户关系等数据。可作为品牌效果评价，也可以作为产品改进或者营销创意的依据。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2004', '公交数据', 'bus.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_bus.doc', 'sample_bus.doc', '基于海量车辆运行产生的GPS数据。包含自动分析出当前准确的车辆行驶线路、车站位置、线路站序、车-线对应关系、首末班发车，发车间隔、甩站、滞站、行车速度。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2005', '气象数据', 'weather.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_weather.doc', 'sample_weather.doc', '全国天气监测数据。包括风力风向、每日平均温度、每日最高最低温度、降水量、相对湿度、气压，共覆盖2000+国家级地面观测站、5W+区域自动站的实时监测数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2006', 'GIS地图', 'GIS_map.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_gis.doc', 'sample_gis.doc', '全国基础地图数据。包括不同比例，如1:500、1:1000、1:2000、1:5000、1:10000、1:50000等图例，包括多种数据模型，如多维模型数据、360全景数据、遥感影像数据、标准地址数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2007', '农业数据', 'farming.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_farming.doc', 'sample_farming.doc', '全国农业数据信息。包括宏观经济景气数据、农村统计数据、渔业统计数据、畜牧业统计数据、林业统计数据、粮食专题数据、农产品贸易数据；蔬果、茶叶、中药材、水产品价格监测。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2008', '线上电商零售数据', 'sell.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_sell.doc', 'sample_sell.doc', '主流电商零售数据。包括京东、天猫、亚马逊、1号店、当当网、我买网、国美、苏宁、聚美网、乐峰网、易迅等线上电商商品品类、价格、销售量、关联销售、促销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2009', '线上医药数据', 'medicine.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_medicine.doc', 'sample_medicine.doc', '主流线上医药数据。包括壹药网、康爱、老百姓大药房、好药师、金象网等网站药品类目、价格、销售、促销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2010', '影视数据', 'film.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_film.doc', 'sample_film.doc', '主流视频网站的影视数据。包括优酷、爱奇艺、搜狐视频、腾讯视频、乐视网、豆瓣、1905影视内容、浏览量、客户评论、热度，相关艺人的关注度、影视库，好评度等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2011', '旅游信息', 'trip.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_trip.doc', 'sample_trip.doc', '主流在线旅游网站的旅游产品信息。包括携程、去哪儿、途牛等网站旅游产品、旅游路线、旅游产品关注度、产品价格、攻略、客户问题、营销活动等信息。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2013', 'APP数据', 'app.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1', '1','meta_app.doc', 'sample_app.doc', '全国安卓系统APP情况。包括App应用的留存用户、新增用户、在线用户、推送数据、用户点击行为等核心数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '2002', '2014', '新浪微博数据', 'sina_weibo.png', '2', '', '3', '1', '0.000', '2015-08-01', '1', '1','1', 'meta_weibo.doc', 'sample_weibo.doc', '新浪微博账号统计数据。包括7×24h全天候实时监测，账号分析、互动分析、大号分析、行业分析、粉丝分析等共计11个专业维度。微博营销情况，微博热门事件等事件分析。 ');

INSERT INTO DH_DATAITEMUSAGE(DATAITEM_ID,DATAITEM_NAME,VIEWS,FOLLOWS,DOWNLOADS,STARS,REFRESH_DATE,USABILITY)
SELECT DATAITEM_ID,DATAITEM_NAME,100,0,0,1,NULL,1
FROM DH_DATAITEM;

INSERT INTO DH_FIELD VALUES ('1011', '1', 'phone_id', '手机型号', '1', '1', NULL,'');
INSERT INTO DH_FIELD VALUES ('1011', '2', 'phone_brand', '品牌', '0', '2', '16','');
INSERT INTO DH_FIELD VALUES ('1011', '3', 'company', '出品厂商', '0', '2', '16','');
INSERT INTO DH_FIELD VALUES ('1011', '4', 'price', '定价', '0', '3', NULL,'');
INSERT INTO DH_FIELD VALUES ('1011', '5', 'first_date', '入网日期', '0', '4', NULL,'');
INSERT INTO DH_FIELD VALUES ('1011', '6', 'amount', '数量', '0', '1', NULL,'');


INSERT INTO DH_DIMTABLE VALUES ('permit_type',2,'public');
INSERT INTO DH_DIMTABLE VALUES ('permit_type',3,'private');
INSERT INTO DH_DIMTABLE VALUES ('permit_type',4,'public+黑名单');
INSERT INTO DH_DIMTABLE VALUES ('permit_type',5,'private+白名单');
INSERT INTO DH_DIMTABLE VALUES ('arrange_type',1,'申请托管');
INSERT INTO DH_DIMTABLE VALUES ('arrange_type',2,'可以托管');
INSERT INTO DH_DIMTABLE VALUES ('supply_style',1,'单条查询');
INSERT INTO DH_DIMTABLE VALUES ('supply_style',2,'流数据');
INSERT INTO DH_DIMTABLE VALUES ('supply_style',3,'文件');
INSERT INTO DH_DIMTABLE VALUES ('user_type',1,'企业');
INSERT INTO DH_DIMTABLE VALUES ('user_type',2,'个人');
INSERT INTO DH_DIMTABLE VALUES ('user_status',1,'注册用户');
INSERT INTO DH_DIMTABLE VALUES ('user_status',2,'激活用户');
INSERT INTO DH_DIMTABLE VALUES ('user_status',3,'认证用户');
INSERT INTO DH_DIMTABLE VALUES ('user_status',4,'授权用户');
INSERT INTO DH_DIMTABLE VALUES ('user_status',8,'帐号冻结');
INSERT INTO DH_DIMTABLE VALUES ('user_status',7,'帐号销毁');
INSERT INTO DH_DIMTABLE VALUES ('sell_level',1,'铜牌');
INSERT INTO DH_DIMTABLE VALUES ('sell_level',3,'银牌');
INSERT INTO DH_DIMTABLE VALUES ('sell_level',5,'金牌');
INSERT INTO DH_DIMTABLE VALUES ('arrang_type',1,'申请托管');
INSERT INTO DH_DIMTABLE VALUES ('arrang_type',2,'可以托管');
INSERT INTO DH_DIMTABLE VALUES ('rank_status',1,'上升');
INSERT INTO DH_DIMTABLE VALUES ('rank_status',7,'下降');
INSERT INTO DH_DIMTABLE VALUES ('data_format',1,'txt');
INSERT INTO DH_DIMTABLE VALUES ('data_format',2,'pdf');
INSERT INTO DH_DIMTABLE VALUES ('data_format',3,'xls');
INSERT INTO DH_DIMTABLE VALUES ('data_format',4,'doc');
INSERT INTO DH_DIMTABLE VALUES ('data_format',5,'ppt');
INSERT INTO DH_DIMTABLE VALUES ('data_format',6,'csv');
INSERT INTO DH_DIMTABLE VALUES ('refresh_type',1,'月');
INSERT INTO DH_DIMTABLE VALUES ('refresh_type',2,'日');
INSERT INTO DH_DIMTABLE VALUES ('refresh_type',3,'时');
INSERT INTO DH_DIMTABLE VALUES ('refresh_type',4,'分');
INSERT INTO DH_DIMTABLE VALUES ('refresh_type',5,'秒');
INSERT INTO DH_DIMTABLE VALUES ('currency_type',1,'人民币');
INSERT INTO DH_DIMTABLE VALUES ('currency_type',2,'美元');
INSERT INTO DH_DIMTABLE VALUES ('currency_type',3,'Q币');
INSERT INTO DH_DIMTABLE VALUES ('currency_type',4,'比特币');

INSERT INTO DH_EXPLORE VALUES ('1', '终端信息');
INSERT INTO DH_EXPLORE VALUES ('2', '时空信息');
INSERT INTO DH_EXPLORE VALUES ('3', '交通信息');


INSERT INTO DH_PRICEUNIT VALUES ('10', '1', '单条');
INSERT INTO DH_PRICEUNIT VALUES ('11', '1', '1千条');
INSERT INTO DH_PRICEUNIT VALUES ('20', '1', '1个周期全部数据');
INSERT INTO DH_PRICEUNIT VALUES ('30', '1', '1小时流量');

INSERT INTO DH_QUOTA VALUES ('1', '5', '25', '100', '0', '100');
INSERT INTO DH_QUOTA VALUES ('2', '20', '100', '2000', '10', '2048');
INSERT INTO DH_QUOTA VALUES ('3', '100', '500', '10000', '20', '4096');

INSERT INTO DH_QUOTAREMAIN VALUES ('1002', '4', '24', '100', '0', '100');
INSERT INTO DH_QUOTAREMAIN VALUES ('1004', '4', '24', '100', '0', '100');
COMMIT;


## DH_USER，DH_REPOSITORY 设置主键、自增
ALTER TABLE DH_USER MODIFY USER_ID INT UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE DH_REPOSITORY MODIFY REPOSITORY_ID INT UNSIGNED NOT NULL AUTO_INCREMENT;
