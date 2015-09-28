DROP TABLE IF EXISTS DH_CHARGE;

DROP TABLE IF EXISTS DH_COMPANY;

DROP TABLE IF EXISTS DH_CURRENCY;

DROP TABLE IF EXISTS DH_DATAITEM;

DROP TABLE IF EXISTS DH_DATAPOOL;

DROP TABLE IF EXISTS DH_DATAPOOLUSAGE;

DROP TABLE IF EXISTS DH_DENYGROUP;

DROP TABLE IF EXISTS DH_DENYUSER;

DROP TABLE IF EXISTS DH_DOWNLOADLOG;

DROP TABLE IF EXISTS DH_EARN;

DROP TABLE IF EXISTS DH_EARNACCOUNT;

DROP TABLE IF EXISTS DH_ENTRYPOINT;

DROP TABLE IF EXISTS DH_FIELD;

DROP TABLE IF EXISTS DH_GROUP;

DROP TABLE IF EXISTS DH_JOB;

DROP TABLE IF EXISTS DH_LOG;

DROP TABLE IF EXISTS DH_ORDER;

DROP TABLE IF EXISTS DH_PAYACCOUNT;

DROP TABLE IF EXISTS DH_PAYMENT;

DROP TABLE IF EXISTS DH_PERMITGROUP;

DROP TABLE IF EXISTS DH_PERMITTYPE;

DROP TABLE IF EXISTS DH_PERMITUSER;

DROP TABLE IF EXISTS DH_PRICEUNIT;

DROP TABLE IF EXISTS DH_PULLLOG;

DROP TABLE IF EXISTS DH_REPOSITORY;

DROP TABLE IF EXISTS DH_SUPPLYSTYLE;

DROP TABLE IF EXISTS DH_UPLOADLOG;

DROP TABLE IF EXISTS DH_USER;

DROP TABLE IF EXISTS DH_USERINFO;

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
/* Table: DH_COMPANY                                            */
/*==============================================================*/
CREATE TABLE DH_COMPANY
(
   COMPANY_ID           INT NOT NULL,
   COMPANY_NAME         VARCHAR(128),
   CERTIFY1             VARCHAR(128) COMMENT '资质证明材料，上传照片存储的文件名',
   CERTIFY2             VARCHAR(128) COMMENT '资质证明材料，上传照片存储的文件名',
   所属行业                 CHAR(10),
   性质                   CHAR(10),
   规模                   CHAR(10)
);

/*==============================================================*/
/* Table: DH_CURRENCY                                           */
/*==============================================================*/
CREATE TABLE DH_CURRENCY
(
   CURRENCY_TYPE        INT NOT NULL,
   CURRENCY_NAME        VARCHAR(64) COMMENT '币种名称，如Q币、人民币、欧元',
   COMMENT              VARCHAR(128)
);

/*==============================================================*/
/* Table: DH_DATAITEM                                           */
/*==============================================================*/
CREATE TABLE DH_DATAITEM
(
   REPOSITORY_ID        INT,
   USER_ID              INT,
   DATAITEM_ID          INT NOT NULL,
   DATAITEM_NAME        VARCHAR(128) COMMENT '表义的中文名字的
            在搜索结果页面上展示用',
   TAG                  VARCHAR(128) COMMENT '用逗号分隔多个tag标记',
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
   SAMPLE_FILENAME      VARCHAR(64) COMMENT '样例数据',
   PASSWORD             VARCHAR(64) COMMENT '查看宝藏的密码，存明码，admin查询提供给请求的用户，可临时查看',
   COMMENT              VARCHAR(128)
);

/*==============================================================*/
/* Table: DH_DATAPOOL                                           */
/*==============================================================*/
CREATE TABLE DH_DATAPOOL
(
   DATAPOOL_ID          INT NOT NULL,
   DATAPOOL_NAME        VARCHAR(64),
   DATAPOOL_TYPE        INT,
   LOCATION             VARCHAR(128) COMMENT '文件系统的安装点',
   CONN                 VARCHAR(128) COMMENT '连接串信息',
   OBJ_QUOTA            INT COMMENT '存放对象数限额',
   SPACE_QUOTA          INT COMMENT '空间容量，限xGB',
   OPTIME               DATETIME COMMENT '创建或更新日期'
);

/*==============================================================*/
/* Table: DH_DATAPOOLUSAGE                                      */
/*==============================================================*/
CREATE TABLE DH_DATAPOOLUSAGE
(
   DATAPOOL_ID          INT NOT NULL,
   DATA_NAME            VARCHAR(64) COMMENT 'Server中的对象名',
   RAW_NAME             VARCHAR(128) COMMENT '本地存储名'
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
/* Table: DH_EARN                                               */
/*==============================================================*/
CREATE TABLE DH_EARN
(
   USER_ID              INT NOT NULL,
   YEAR                 INT NOT NULL,
   MONTH                INT NOT NULL,
   CURRENCY_TYPE        INT NOT NULL,
   SHOULD_EARN          DECIMAL(10,3)
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
   OPTIME               DATETIME COMMENT '帐户变动日期'
);

/*==============================================================*/
/* Table: DH_ENTRYPOINT                                         */
/*==============================================================*/
CREATE TABLE DH_ENTRYPOINT
(
   ENTRYPOINT_ID        INT NOT NULL,
   ENTRYPOINT_NAME      VARCHAR(64),
   PROTOCAL             INT,
   MODEL                INT,
   INNER_IP             VARCHAR(64),
   IP                   INT,
   OUTER_IP             VARCHAR(64),
   OUTER_PORT           INT,
   STATUS               INT,
   OPTIME               DATETIME,
   COMMENT              VARCHAR(128)
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
   FIELD_DATALENGTH     INT COMMENT '数据项的长度'
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
   COMMENT              VARCHAR(128)
);

/*==============================================================*/
/* Table: DH_JOB                                                */
/*==============================================================*/
CREATE TABLE DH_JOB
(
   JOB_ID               INT NOT NULL,
   JOB_NAME             VARCHAR(64),
   TYPE                 INT,
   STATUS               INT,
   START_TIME           DATETIME,
   END_TIME             DATETIME,
   COMMENT              VARCHAR(128)
);

/*==============================================================*/
/* Table: DH_LOG                                                */
/*==============================================================*/
CREATE TABLE DH_LOG
(
   USER_ID              INT NOT NULL,
   INTERFACE            VARCHAR(64) NOT NULL,
   PARAMETER            VARCHAR(128) NOT NULL,
   OPTIME               DATETIME NOT NULL COMMENT '定义或修改时间'
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
   COMMENT              VARCHAR(128)
);

/*==============================================================*/
/* Table: DH_PAYACCOUNT                                         */
/*==============================================================*/
CREATE TABLE DH_PAYACCOUNT
(
   ACCOUNT_ID           INT NOT NULL COMMENT '账号',
   CURRENCY_TYPE        INT,
   USER_ID              INT,
   DEPOSIT              DECIMAL(10,3) COMMENT '押金',
   PREPAY               DECIMAL(10,3) COMMENT '预付款',
   CREDIT               DECIMAL(10,3) COMMENT '信用度，',
   OPTIME               DATETIME COMMENT '帐户变动日期'
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
   CREDIT_PAY           DECIMAL(10,3)
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
/* Table: DH_PRICEUNIT                                          */
/*==============================================================*/
CREATE TABLE DH_PRICEUNIT
(
   PRICEUNIT_TYPE       INT NOT NULL COMMENT '条、百条、千条
            字节、千字节、兆字节',
   CURRENCY_TYPE        INT,
   PRICEUNIT_NAME       VARCHAR(64)
);

/*==============================================================*/
/* Table: DH_PULLLOG                                            */
/*==============================================================*/
CREATE TABLE DH_PULLLOG
(
   DATA_ID              INT NOT NULL,
   DATA_NAME            VARCHAR(64),
   OPTIME               DATETIME,
   AMOUNT               INT
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
   DATA_DATE            DATE NOT NULL
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
   LOGIN_PASSWD         VARCHAR(128) COMMENT '密码，需密文存储',
   PHONE_NO             VARCHAR(64),
   EMAIL                VARCHAR(128),
   USER_STATUS          INT COMMENT '标记用户帐户状态，-1阻止登录',
   CLONE_USER           INT
);

/*==============================================================*/
/* Table: DH_USERINFO                                           */
/*==============================================================*/
CREATE TABLE DH_USERINFO
(
   USER_ID              INT,
   ID                   CHAR(10),
   兴趣                   CHAR(10)
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

SET @@CHARACTER_SET_SERVER='utf8'; 

INSERT INTO DH_USER VALUES ('1', '5', NULL, 'admin', '21232f297a57a5a743894a0e4a801fc3', '82166436', 'gongjing5@asiainfo.com', NULL, '1');
INSERT INTO DH_USER VALUES ('1001', '3', NULL, 'zhhs888888', '5dc828c0e0fc5ff0e94dec595251259b', '13609251885', 'gongjing5@asiainfo.com', NULL, '1');
INSERT INTO DH_USER VALUES ('1002', '3', NULL, 'sya666666', 'bde202e8ab686fec2a848e15b61744cb', '13808305511', 'gongjing5@asiainfo.com', NULL, '1');
INSERT INTO DH_USER VALUES ('2001', '5', NULL, 'fenghw', '86edd721bd0c5533aef7856bd0eb96ed', NULL, NULL, NULL, '1');

INSERT INTO DH_REPOSITORY VALUES ('10', '手机信息大全', '1002', '2');
INSERT INTO DH_DATAITEM VALUES ('10', '1002', '1010', '手机开通', '手机,iphone', '2', '1', '1', '1.000', '2015-08-01', '1', '2015-07-31', 'RAR压缩包', 'terminal.del', '888888', '手机开通情况统计');
INSERT INTO DH_FIELD VALUES ('1010', '1', 'phone_id', '手机型号', '1', '1', NULL);
INSERT INTO DH_FIELD VALUES ('1010', '2', 'phone_brand', '手机品牌', '0', '2', '16');
INSERT INTO DH_FIELD VALUES ('1010', '3', 'company', '出品厂商', '0', '2', '16');
INSERT INTO DH_FIELD VALUES ('1010', '4', 'price', '定价', '0', '3', NULL);
INSERT INTO DH_FIELD VALUES ('1010', '5', 'first_date', '入网日期', '0', '4', NULL);
INSERT INTO DH_FIELD VALUES ('1010', '6', 'amount', '数量', '0', '1', NULL);

INSERT INTO DH_UPLOADLOG VALUES ('1010', '2015-09-05');
INSERT INTO DH_UPLOADLOG VALUES ('1010', '2015-08-05');
INSERT INTO DH_UPLOADLOG VALUES ('1010', '2015-07-05');
INSERT INTO DH_UPLOADLOG VALUES ('1010', '2015-06-05');
INSERT INTO DH_DOWNLOADLOG VALUES ('1010', '2015-08-05', '1001', '2015-08-06 17:34:27');
INSERT INTO DH_DOWNLOADLOG VALUES ('1010', '2015-07-05', '1001', '2015-07-06 17:34:59');
INSERT INTO DH_DOWNLOADLOG VALUES ('1010', '2015-06-05', '1001', '2015-06-06 17:35:29');

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
