DROP TABLE IF EXISTS DH_CHARGE;

DROP TABLE IF EXISTS DH_CURRENCY;

DROP TABLE IF EXISTS DH_DATAITEM;

DROP TABLE IF EXISTS DH_DENYGROUP;

DROP TABLE IF EXISTS DH_DENYUSER;

DROP TABLE IF EXISTS DH_DOWNLOADLOG;

DROP TABLE IF EXISTS DH_FIELD;

DROP TABLE IF EXISTS DH_GROUP;

DROP TABLE IF EXISTS DH_LOG;

DROP TABLE IF EXISTS DH_PERMITGROUP;

DROP TABLE IF EXISTS DH_PERMITTYPE;

DROP TABLE IF EXISTS DH_PERMITUSER;

DROP TABLE IF EXISTS DH_REPOSITORY;

DROP TABLE IF EXISTS DH_SUPPLYSTYLE;

DROP TABLE IF EXISTS DH_UPLOADLOG;

DROP TABLE IF EXISTS DH_USER;

DROP TABLE IF EXISTS DH_USERLEVEL;

DROP TABLE IF EXISTS DH_USERLIST;

DROP TABLE IF EXISTS DH_USERSTATUS;

/*==============================================================*/
/* Table: DH_CHARGE                                             */
/*==============================================================*/
CREATE TABLE DH_CHARGE
(
   ACCOUNT_ID           VARCHAR(64) NOT NULL COMMENT '账号',
   CURRENCY_TYPE        INT NOT NULL,
   FEE_TYPE             CHAR(10) COMMENT '充值费用类型
            1-押金
            2-预存款
            3-信用度',
   PAYMENT              DECIMAL(10,3),
   OPTIME               DATETIME NOT NULL COMMENT '帐户变动日期',
   USER_ID              INT
);

/*==============================================================*/
/* Table: DH_CURRENCY                                           */
/*==============================================================*/
CREATE TABLE DH_CURRENCY
(
   CURRENCY_TYPE        INT NOT NULL,
   CURRENCY_NAME        VARCHAR(64) COMMENT '币种名称，如Q币、人民币、欧元',
   COMMENT              VARCHAR(1024)
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
   COMMENT              VARCHAR(1024)
);

/*==============================================================*/
/* Table: DH_DENYGROUP                                          */
/*==============================================================*/
CREATE TABLE DH_DENYGROUP
(
   GROUP_ID             INT NOT NULL,
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL
);

/*==============================================================*/
/* Table: DH_DENYUSER                                           */
/*==============================================================*/
CREATE TABLE DH_DENYUSER
(
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL
);

/*==============================================================*/
/* Table: DH_DOWNLOADLOG                                        */
/*==============================================================*/
CREATE TABLE DH_DOWNLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   DATA_DATE            DATE NOT NULL,
   DOWN_USER            INT NOT NULL,
   OP_TIME              DATETIME NOT NULL
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
   COMMENT              VARCHAR(1024)
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
   COMMENT              VARCHAR(1024)
);

/*==============================================================*/
/* Table: DH_LOG                                                */
/*==============================================================*/
CREATE TABLE DH_LOG
(
   USER_ID              INT NOT NULL,
   INTERFACE            VARCHAR(64) NOT NULL,
   PARAMETER            VARCHAR(1024) NOT NULL,
   OPTIME               DATETIME NOT NULL COMMENT '定义或修改时间'
);

/*==============================================================*/
/* Table: DH_PERMITGROUP                                        */
/*==============================================================*/
CREATE TABLE DH_PERMITGROUP
(
   GROUP_ID             INT NOT NULL,
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL
);

/*==============================================================*/
/* Table: DH_PERMITTYPE                                         */
/*==============================================================*/
CREATE TABLE DH_PERMITTYPE
(
   PERMIT_TYPE          INT NOT NULL,
   PERMIT_NAME          VARCHAR(64) NOT NULL
);

/*==============================================================*/
/* Table: DH_PERMITUSER                                         */
/*==============================================================*/
CREATE TABLE DH_PERMITUSER
(
   REPOSITORY_ID        INT NOT NULL,
   DATAITEM_ID          INT NOT NULL,
   USER_ID              INT NOT NULL
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
            6-用户组黑名单不可见'
);

/*==============================================================*/
/* Table: DH_SUPPLYSTYLE                                        */
/*==============================================================*/
CREATE TABLE DH_SUPPLYSTYLE
(
   SUPPLY_STYLE         INT NOT NULL,
   SUPPLY_NAME          VARCHAR(64) NOT NULL
);

/*==============================================================*/
/* Table: DH_UPLOADLOG                                          */
/*==============================================================*/
CREATE TABLE DH_UPLOADLOG
(
   DATAITEM_ID          INT NOT NULL,
   DATA_DATE            DATE NOT NULL,
   FILENAME             VARCHAR(1024)
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
   CLONE_USER           INT
);

/*==============================================================*/
/* Table: DH_USERLEVEL                                          */
/*==============================================================*/
CREATE TABLE DH_USERLEVEL
(
   USER_LEVEL           INT NOT NULL,
   LEVEL_NAME           VARCHAR(64)
);

/*==============================================================*/
/* Table: DH_USERLIST                                           */
/*==============================================================*/
CREATE TABLE DH_USERLIST
(
   GROUP_ID             INT NOT NULL,
   USER_ID              INT NOT NULL
);

/*==============================================================*/
/* Table: DH_USERSTATUS                                         */
/*==============================================================*/
CREATE TABLE DH_USERSTATUS
(
   USER_STATUS          INT NOT NULL,
   STATUS_NAME          VARCHAR(64)
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

INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1010', '终端信息', 'terminal.png', '手机,iphone', '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'EXCEL文件', 'terminal.del', '888888', '市场存量、新增、流转终端品牌、机型、数量等情况。终端ARUP、DOU、网龄、换机、迁徙、离网情况，APP安装情况。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2000', '银联数据', 'unionpay.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '888855', '通过数十个维度的特征指标，对用户群体进行消费特征分析，帮助商户勾勒出详细的用户群特征。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2001', '工商数据', 'industry_commerce.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '888866', '1800万家企业数据；覆盖企业、事业、机关、社会团体、民办非企业及其他合法组织；覆盖所有县市乡镇；全国联网操作，数据动态每日汇总，次日更新上线；通过动态数据实时校验用户身份的合法性；实时数据服务接口');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2002', '社交数据', 'social.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '互联网上公开数据（论坛，贴吧，微博，微信公众号等），用户评论、转发，可作为品牌效果评价，也可以作为产品改进或者营销创意的依据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2003', '公交数据', 'bus.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '首末班发车，发车间隔、甩站、滞站、行车速度、轨迹监管、正点发车、区间校时、单边准点以及考勤、超速、偏航。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2004', '气象数据', 'weather.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '风力风向、每日平均温度、每日最高最低温度、降水量、相对湿度、气压、雷电自建国以来全国2000+国家级地面观测站（人工职守站）的风温湿压雨（风力风向、每日平均温度、每日最高最低温度、降水量、相对湿度）等各气象要素记录；以及5W+区域自动站（无人职守站，2009年接入）的实时监测数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2005', 'GIS地图', 'GIS_map.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国基础地图数据（1:500/1:1000/1:2000/1:5000/1:10000/1:50000）、三维模型数据、360全景数据、遥感影像数据、标准地址数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2006', '农业数据', 'farming.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括宏观经济景气数据、农村统计数据、农业统计数据、渔业统计数据、畜牧业统计数据、林业统计数据、粮食专题数据、农产品贸易统计数据、饲料专题数据、奶业专题数据、棉花专题数据，蔬菜、水果、茶叶、中药材、水产品价格监测。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2007', '线上电商零售数据', 'sell.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括京东、天猫、亚马逊、1号店、当当网、我买网、国美、苏宁、聚美网、乐峰网、易迅等线上电商数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2008', '线上医药数据', 'medicine.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括壹药网、康爱、老百姓大药房、好药师、金象网等');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2009', '影视数据', 'film.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括优酷、爱奇艺、搜狐视频、腾讯视频、乐视网、豆瓣、1905等');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2010', '旅游信息', 'trip.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '包括携程、去哪儿、途牛等数据。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2011', '交通数据', 'traffic.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国31个省级重点营运车辆200万辆');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2012', 'APP数据', 'app.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国安卓系统内App应用的留存用户、新增用户、在线用户、推送数据、用户点击行为等核心数据');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2013', '新浪微博数据', 'sina_weibo.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '新浪微博账号统计数据，7×24h全天候实时监测，账号分析、互动分析、粉丝分析3方面共计11个专业数据维度；腾讯微博账号统计数据；粉丝属性及行为分析；微博传播数据分析；账号互动分析；行业标杆数据对比分析。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2014', '车辆违章查询、生活服务、定位服务、金融征信', 'car_peccancy.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '全国车辆违章查询。');
INSERT INTO DH_DATAITEM VALUES ('20', '1004', '2015', '人脸识别', 'face_identify.png', NULL, '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', NULL, '111111', '人脸识别身份信息。');

INSERT INTO DH_FIELD VALUES ('1010', '1', 'phone_id', '手机型号', '1', '1', NULL,'');
INSERT INTO DH_FIELD VALUES ('1010', '2', 'phone_brand', '品牌', '0', '2', '16','');
INSERT INTO DH_FIELD VALUES ('1010', '3', 'company', '出品厂商', '0', '2', '16','');
INSERT INTO DH_FIELD VALUES ('1010', '4', 'price', '定价', '0', '3', NULL,'');
INSERT INTO DH_FIELD VALUES ('1010', '5', 'first_date', '入网日期', '0', '4', NULL,'');
INSERT INTO DH_FIELD VALUES ('1010', '6', 'amount', '数量', '0', '1', NULL,'');



INSERT INTO DH_FIELD VALUES ('1011', '1', 'phone_id', '手机型号', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011', '2', 'phone_brand', '手机品牌', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1011', '3', 'time_band', '时间段', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1011', '4', 'call_counts', '通话次数', '0', '3', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1011', '5', 'amount', '产生的网络流量', '0', '4', NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1012', '1', 'phone_id', '手机型号', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012', '2', 'phone_brand', '手机品牌', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1012', '3', 'position_name', '位置名称', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1012', '4', 'call_counts', '通话次数', '0', '3', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012', '5', 'amount', '产生的网络流量', '0','4',NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1012', '6', 'call_time', '首次通话时间', '0', '4',NULL,NULL);

INSERT INTO DH_FIELD VALUES ('1013', '1', 'phone_id', '手机型号', '1', '1', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013', '2', 'gender', '性别', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1013', '3', 'age', '年龄', '0', '2', '16',NULL);
INSERT INTO DH_FIELD VALUES ('1013', '4', 'in_years', '入网时长', '0', '3', NULL,NULL);
INSERT INTO DH_FIELD VALUES ('1013', '5', 'hobby', '兴趣爱好', '0','4',NULL,NULL);


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
