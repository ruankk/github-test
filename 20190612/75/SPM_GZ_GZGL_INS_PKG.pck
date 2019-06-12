CREATE OR REPLACE PACKAGE "SPM_GZ_GZGL_INS_PKG" IS
  --Global Char
  /*
  取消使用全局变量，使用后会导致频繁报丢失包情况
  G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
  G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';*/
  /*=================================================================
  *   PROGRAM NAME: SPM_GZ_AP_INFO_IMP
  *
  *   DESCRIPTION: SPM 与 EBS AP发票接口中间表同步的存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message需要返回的错误原因
  *   HISTORY:
  *     1.0  20171018   MCQ           Created
  * ===============================================================*/
  /*PROCEDURE SPM_GZ_AP_INFO_IMP_OFFICE(\*V_ID             IN NUMBER,*\
  V_MAIN_ID        IN  NUMBER, --数据批号
  V_GLDATE         IN  VARCHAR2, --总账日期
  V_PERIODDATE     IN  VARCHAR2, --期间
  V_DQYEAR         IN  VARCHAR2, -- 当前年
  V_DQMONTH        IN  VARCHAR2, -- 当前月
  V_DQNUM          IN  VARCHAR2, --当前次
  v_Return_Code    OUT VARCHAR2,
  v_Return_Message OUT VARCHAR2);*/

  /*PROCEDURE SPM_GZ_AP_INFO_IMP_DEPT(\*V_ID             IN NUMBER,*\
  V_MAIN_ID        IN NUMBER, --数据批号
  V_GLDATE         IN VARCHAR2, --总账日期
  V_PERIODDATE     IN VARCHAR2, --期间
  V_DQYEAR         IN  VARCHAR2, -- 当前年
  V_DQMONTH        IN  VARCHAR2, -- 当前月
  V_DQNUM          IN  VARCHAR2, --当前次
  v_Return_Code    OUT VARCHAR2,
  v_Return_Message OUT VARCHAR2);*/
  --专家咨询费导入财务生成凭证
  PROCEDURE SPM_EXPERT_FEE_CREATE_CERT( /*V_ID             IN NUMBER,*/V_MAIN_ID IN NUMBER, --数据批号
                                       --V_DEPTCODE         IN VARCHAR2, --部门段
                                       /*V_PERIODDATE     IN VARCHAR2, --期间
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQYEAR         IN  VARCHAR2, -- 当前年
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQMONTH        IN  VARCHAR2, -- 当前月
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQNUM          IN  VARCHAR2, --当前次*/
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);

  --批量进项发票验证                              
  PROCEDURE BATCH_INPUT_VALIDATE(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 P_MSG       OUT VARCHAR2);
  -- 批量进项发票导入                                
  PROCEDURE BATCH_INPUT_IMPORT(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               F_TABLENAME VARCHAR2,
                               F_TABLEID   VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  /*采购订单发票信息保存至消息中间表*/
  PROCEDURE SPM_CON_SYNC_INVOICEINFO(V_ID             IN VARCHAR2,
                                     V_MSG            IN CLOB,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2);
  /*根据采购订单生成进项发票*/
  PROCEDURE CREATE_INPUT_INVOICE(V_IDS         IN VARCHAR2,
                                 V_RETURN_CODE OUT VARCHAR2,
                                 V_RETURN_MSG  OUT VARCHAR2);

  --资金计划额度 从综合查询获取各项值
  FUNCTION SPM_CAPITAL_FIND_AMOUNT(P_PERIOD_YEAR  IN NUMBER, --年份
                                   P_PERIOD_NUM_F IN NUMBER, --月份
                                   P_PERIOD_NUM_T IN NUMBER, --月份
                                   P_KM           IN SPM_TYPE_TBL, --科目                                
                                   P_GS           IN VARCHAR2, --公司段  
                                   DEPTCODE       IN VARCHAR2, --大部门段 
                                   P_VALTYPE      IN VARCHAR2, --取值类型   
                                   ORGID          IN VARCHAR2) RETURN NUMBER;
  --根据传的班组id 关联查资金额度主键id
  FUNCTION GET_CAPITAL_ID(P_DEPT_ID VARCHAR2) RETURN NUMBER;

  --资金计划额度明细 保存数据时 根据用户填的 上会增加额 其他调整额  更新资金计划额度                                
  PROCEDURE SPM_CON_CAPITAL_QUOTA_UPDATE(ID NUMBER);

  --资金计划额度 复制数据
  PROCEDURE SPM_CAPITAL_COPY_DATA(CAPITALID IN NUMBER,
                                  V_STATUS  OUT VARCHAR2,
                                  V_MESSAGE OUT VARCHAR2);
  --根据扫描发票信息 导入进项发票表                             
  PROCEDURE INSERT_INPUTINVOICE_INFO(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2,
                                     V_RETURN_MSG  OUT VARCHAR2);
  --根据总账凭证模版生成总账凭证数据
  PROCEDURE IMPORT_GL_CRRT_BY_TEMPLATE(P_TEMPLATE_CODE  VARCHAR,
                                       P_VERSION_NUMBER VARCHAR,
                                       P_GL_DATE        VARCHAR,
                                       P_ATTACH_CNT     NUMBER,
                                       P_PARAM          VARCHAR2,
                                       OUT_SUCESS_FLAG  OUT VARCHAR,
                                       OUT_MESSAGE      OUT VARCHAR);
   PROCEDURE IMPORT_GL_CRRT_BY_TEMPLATE_GZ(P_TEMPLATE_CODE  VARCHAR,
                                       P_VERSION_NUMBER VARCHAR,
                                       P_GL_DATE        VARCHAR,
                                       P_ATTACH_CNT     NUMBER,
                                       P_PARAM          VARCHAR2,
                                       OUT_SUCESS_FLAG  OUT VARCHAR,
                                       OUT_MESSAGE      OUT VARCHAR);
   --付款提交以及制证时校验资金计划额度是否足够
   --K_PAYMENT_IDS 付款单主键s   K_TYPE 类型  1:提交   2:导入
   FUNCTION CHECK_CAPITAL_BALANCE_FOR_PAY(K_PAYMENT_IDS VARCHAR2,K_TYPE VARCHAR2) RETURN VARCHAR2;
   --校验退票提交时 对应蓝票剩余金额是否充足  Y:充足  N:
   FUNCTION CHECK_RETURN_INVOICE_SUBMIT(K_OUTPUT_ID NUMBER) RETURN VARCHAR2;
   --撤销业务收款核销销项发票
   PROCEDURE CANCEL_YW_RECEIPT_INVOICE(K_RECEIPT_INVOICE_IDS IN VARCHAR2,
                                       MSG OUT VARCHAR2);

END SPM_GZ_GZGL_INS_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_GZ_GZGL_INS_PKG" AS

  /*=================================================================
  *   PROGRAM NAME: SPM_GZ_AP_INFO_IMP
  *
  *   DESCRIPTION: SPM 与 EBS AP工资接口中间表同步的存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message需要返回的错误原因
  *   HISTORY:
  *     1.0  20171122   YJ          Created
  * ===============================================================*/
  /* PROCEDURE SPM_GZ_AP_INFO_IMP_OFFICE(--\*V_ID             IN NUMBER,*\
                                V_MAIN_ID        IN  NUMBER, --数据批号
                                V_GLDATE         IN  VARCHAR2, --总账日期
                                V_PERIODDATE     IN  VARCHAR2, --期间
                                V_DQYEAR         IN  VARCHAR2, -- 当前年
                                V_DQMONTH        IN  VARCHAR2, -- 当前月
                                V_DQNUM          IN  VARCHAR2, --当前次
                                V_RETURN_CODE    OUT VARCHAR2,
                                V_RETURN_MESSAGE OUT VARCHAR2) IS
     L_IFACE_RGZGL     CUX_GL_INTERFACE_DATA%ROWTYPE;
     T_HEADERS_ID        NUMBER;
     T_NUMLINE           NUMBER;
     T_RETURN_CODE       VARCHAR2(1);
     T_RETURN_MESSAGE    VARCHAR2(4000);
     T_SYSDATE           VARCHAR2(20);
     T_ORG_CODE          VARCHAR2(20);
     T_OFFICE_CODE       VARCHAR2(40);
     T_CREATED_BY        VARCHAR2(20);
     T_LAST_UPDATE_LOGIN VARCHAR2(20);
     T_LAST_UPDATED_BY   VARCHAR2(20);
     JBGZ_KMJE         NUMBER; --基本工资等科目金额  借方
     JJIN_KMJE         NUMBER; --\*月奖等科目金额 借方*\
     DSZNF_KMJE        NUMBER; --\*独子 托补科目金额 借方*\
     FSJWF_KMJE        NUMBER; --\*防暑降温科目金额 借方*\
     
     JBYANGLBX_KMJE    NUMBER; --\*扣基本养老科目金额 贷方*\
     JBYILBX_KMJE      NUMBER; --\*扣医疗保险科目金额 贷方*\
     KSY_KMJE          NUMBER; --\*扣失业科目金额 贷方*\
     ZFGJJ_KMJE        NUMBER; --\*扣住房公积金科目金额 贷方*\
     QYNJ_KMJE         NUMBER; ---\*扣企业年金科目金额 贷方*\
     JJ_KMJE_DAI       NUMBER; --\*扣事假科目金额 贷方*\
     GRSDS_KMJE        NUMBER; --\*所得税科目金额 贷方*\
     JBH_KMJE          NUMBER; --\*基本户科目金额（实发工资）贷方*\
     
     JBGZ_KMJE_BM      NUMBER; --\*基本工资等科目编码*\
     JJIN_KMJE_BM      NUMBER; --\*月奖等科目编码*\
     DSZNF_KMJE_BM     NUMBER;-- \*独子 托补等科目编码*\
     FSJWF_KMJE_BM     NUMBER;-- \*防暑降温科目编码*\
     JBYANGLBX_KMJE_BM NUMBER; --\*扣基本养老科目编码*\
     JBYILBX_KMJE_BM   NUMBER; --\*扣医疗保险科目编码*\
     --BCYLBX_KMJE_BM    NUMBER; \*补充医疗保险科目编码*\
     KSY_KMJE_BM       NUMBER; --\*扣失业科目编码*\
     ZFGJJ_KMJE_BM     NUMBER; --\*扣住房公积金科目编码*\
     QYNJ_KMJE_BM      NUMBER; --\*扣企业年金科目编码*\
     JJ_KMJE_DAI_BM    NUMBER; --\*扣事假科目编码 贷方*\
     GRSDS_KMJE_BM     NUMBER; --\*所得税科目编码*\
     JBH_KMJE_BM       NUMBER; --\*基本户科目编码（实发工资）*\
     T_DATA_ID         NUMBER;
     V_IDS               VARCHAR2(200);
     IDS                 SPM_TYPE_TBL;
   
     --根据main_id获取处室编码
     
     CURSOR CUR_1(P_MAIN_ID NUMBER) IS
        SELECT DISTINCT OFFICECODE AS OFFICE_CODE
         FROM SPM_GZ_WAGEDATA W
        WHERE MAIN_ID = P_MAIN_ID;
     REC_1 CUR_1%ROWTYPE;
   
     --按照处室分组，查询处室编码和各科目金额
     CURSOR CUR_2(P_OFFICE_CODE VARCHAR2) IS
       SELECT *
         FROM (SELECT SUM(WA.GZYF_01+WA.GZYF_02+WA.GZYF_03) AS JBGZ_KMJE,--基本工资等金额
                      SUM(WA.GZYF_04+WA.GZYF_06 +WA.GZYF_07 
                       +WA.GZYF_10 + WA.GZYF_11 + WA.GZYF_48 + WA.GZYF_49
                      ) AS JJIN_KMJE,--月奖等金额
                      SUM(WA.GZYF_08+ WA.GZYF_09) DSZNF_KMJE,--独子 托补等金额
                      SUM(WA.GZYF_12+WA.GZYF_19) FSJWF_KMJE,--防暑降温等金额
                      SUM(WA.GZKJ_01) JBYANGLBX_KMJE,--扣基本养老金额
                      SUM(WA.GZKJ_02+WA.GZKJ_03) JBYILBX_KMJE,--扣医疗保险 扣大额医疗金额
                      --SUM(WA.GZKJ_03) BCYLBX_KMJE,--去掉
                      SUM(WA.GZKJ_04) KSY_KMJE,--扣失业金额
                      SUM(WA.GZKJ_05) ZFGJJ_KMJE,--扣住房公积金金额
                      SUM(WA.GZKJ_06) QYNJ_KMJE,--扣企业年金金额
                      SUM(WA.GZKJ_07 + WA.GZKJ_08) JJ_KMJE_DAI,--扣事假 扣病假金额
                      SUM(WA.WAGE_TAX1) GRSDS_KMJE,--所得税金额
                      SUM(WA.WAGE_FACT) JBH_KMJE,--实发工资金额
                      WA.OFFICECODE
                 FROM SPM_GZ_WAGEDATA WA
                 WHERE WA.MAIN_ID=V_MAIN_ID
                GROUP BY WA.OFFICECODE)
        WHERE 1 = 1
          AND OFFICECODE = P_OFFICE_CODE;
          
   BEGIN
   
    SELECT COUNT(CD.GL_DATA_ID)
       INTO T_DATA_ID
       FROM CUX_GL_INTERFACE_DATA CD
      WHERE 1 = 1
        AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
        AND CD.DATA_STATUS <> 'E';
      IF T_DATA_ID <> 0 THEN
       V_RETURN_CODE    := 'N';
       V_RETURN_MESSAGE := '当前的工资数据已经执行了同步财务操作';
       DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
       RETURN;
     END IF;
   
      T_NUMLINE := 0;
      
     --开始循环
     OPEN CUR_1(V_MAIN_ID);
     loop
   
       FETCH CUR_1
         INTO REC_1;
         exit when CUR_1%notfound;
   
       --获取公司代码 创建人 修改人id 修改人
       SELECT DISTINCT WA.ORGCODE,WA.CREATED_BY,WA.LAST_UPDATE_LOGIN,WA.LAST_UPDATED_BY
         INTO T_ORG_CODE,T_CREATED_BY,T_LAST_UPDATE_LOGIN,T_LAST_UPDATED_BY
         FROM SPM_GZ_WAGEDATA WA
        WHERE WA.MAIN_ID = V_MAIN_ID;
        --获得十个科目段的科目组合      
         SELECT c.subject_com
         INTO V_IDS
         FROM spm_gz_createcert c
         WHERE c.wagetype_code='017';
         
         SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS, '.') INTO IDS FROM DUAL;
         
           DBMS_OUTPUT.PUT_LINE(IDS(1));
           DBMS_OUTPUT.PUT_LINE(IDS(4));
       -- 获取系统时间
       SELECT TO_CHAR(sysdate, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
       T_OFFICE_CODE := REC_1.OFFICE_CODE;
       
       --遍历游标2
       FOR REC_2 IN CUR_2(T_OFFICE_CODE) LOOP
                   
         BEGIN
           
   
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
         T_NUMLINE    :=  T_NUMLINE+1;
        
         
         if REC_2.JBGZ_KMJE <>0 then 
           --插入中间表  处室第一列
           SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '基本工资';
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,--修改日期
              LAST_UPDATED_BY, --修改人
              LAST_UPDATE_LOGIN, --登录人id
              CREATION_DATE, --创建日期
              CREATED_BY)    --创建人
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              REC_2.JBGZ_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 导入日期
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JBGZ_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          if REC_2.JJIN_KMJE <>0 then 
           --插入中间表  处室第二列
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '月奖';      
            T_NUMLINE    := T_NUMLINE+1;
            
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              REC_2.JJIN_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JJIN_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.DSZNF_KMJE <>0 then
   
           --插入中间表  处室第三列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '独子';          
         T_NUMLINE    := T_NUMLINE+1;
         
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              REC_2.DSZNF_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              DSZNF_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
         end if;
          
          if REC_2.FSJWF_KMJE <>0 then
   
           --插入中间表  处室第四列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '防暑降温';      
         T_NUMLINE    := T_NUMLINE+1;
         
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              REC_2.FSJWF_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              FSJWF_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.JBYANGLBX_KMJE <>0 then
            
           --插入中间表  处室第五列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣基本养老';         
         T_NUMLINE    := T_NUMLINE+1;
         
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
               'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.JBYANGLBX_KMJE,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JBYANGLBX_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.JBYILBX_KMJE <>0 then
   
           --插入中间表  处室第六列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣医疗保险';         
           T_NUMLINE  :=  T_NUMLINE+1;
          
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.JBYILBX_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
               V_PERIODDATE,--期间
               2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JBYILBX_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.KSY_KMJE <>0 then
   
           --插入中间表  处室第七列 
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣失业';               
           T_NUMLINE    :=  T_NUMLINE+1;
           
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
               'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.KSY_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              KSY_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.ZFGJJ_KMJE <>0 then
   
           --插入中间表  处室第八列
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣住房公积金';        
          T_NUMLINE    :=  T_NUMLINE+1;
          
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
             'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
             T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.ZFGJJ_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              ZFGJJ_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.QYNJ_KMJE <>0 then
   
           --插入中间表  处室第九列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣企业年金';        
          T_NUMLINE    :=  T_NUMLINE+1;
          
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
               'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
             T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.QYNJ_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              QYNJ_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
         end if;
          
          if REC_2.JJ_KMJE_DAI <>0 then
   
           --插入中间表  处室第十列
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '扣病假';         
            T_NUMLINE    :=  T_NUMLINE+1;
           
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.JJ_KMJE_DAI,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JJ_KMJE_DAI_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.GRSDS_KMJE <>0 then
   
           --插入中间表  处室第十一列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '所得税';         
            T_NUMLINE    :=  T_NUMLINE+1;
            
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
             T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.GRSDS_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              GRSDS_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
          end if;
          
          if REC_2.JBH_KMJE <>0 then
   
           --插入中间表  处室第十二列
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '实发工资';         
            T_NUMLINE    :=  T_NUMLINE+1;
            
           -- 获取本次头信息的主键数据id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
   
           INSERT INTO CUX_GL_INTERFACE_DATA
             (GL_DATA_ID,
              GL_DATA_SOURCE,
              JE_BATCH_NAME,
              BATCH_DESCRIPTION,
              JE_HEADER_NAME,
              HEADER_DESCRIPTION,
              GL_DATE,
              CURRENCY_CODE,
              JE_LINE_NUM,
              JE_LINE_DESCRIPTION,
              ENTERED_DR,
              ENTERED_CR,
              DATA_STATUS,
              OBJECT_VERSION_NUMBER,
              OPERATE_DATE,
              BUSINESS_TYPE,
              USER_JE_SOURCE_NAME,
              USER_JE_CATEGORY_NAME,
              PERIOD_NAME,
              GL_SET_OF_BOOK_ID,
              SEGMENT1,
              SEGMENT2,
              SEGMENT3,
              SEGMENT4,
              SEGMENT5,
              SEGMENT6,
              SEGMENT7,
              SEGMENT8,
              SEGMENT9,
              SEGMENT10,
              LAST_UPDATE_DATE,
              LAST_UPDATED_BY,
              LAST_UPDATE_LOGIN,
              CREATION_DATE,
              CREATED_BY)
           VALUES
             (T_HEADERS_ID,
              'SPM系统',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
              V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
              '工资',   --
              '发放' || V_DQMONTH || '月工资',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
              'CNY',
              T_NUMLINE,
              '发放本月工资',
              0,
              REC_2.JBH_KMJE,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '用户',
              '人工',
              '记账',
              V_PERIODDATE,--期间
              2021,
              T_ORG_CODE,
              T_OFFICE_CODE,
              JBH_KMJE_BM,
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              '00',
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_LAST_UPDATED_BY,
              T_LAST_UPDATE_LOGIN,
              TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
              T_CREATED_BY);
           end if;
           commit;
         END;
       END LOOP;  
     end loop;   
     CLOSE CUR_1;
      cux_gl_import_pkg.MAIN(errbuf           => T_RETURN_MESSAGE,
                             retcode          => T_RETURN_CODE,
                             p_data_source    => 'SPM系统',
                             P_JE_BATCH_NAME  =>  T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,
                             p_repeant        =>  'Y');
     IF T_RETURN_CODE = 'S' THEN 
     --T_RETURN_CODE := G_INTERFACE_SUCCESS;
      V_RETURN_CODE    := T_RETURN_CODE;
     END IF;  
     IF V_RETURN_CODE <> 'S' THEN
       DELETE FROM CUX_GL_INTERFACE_DATA CD        
         WHERE CD.JE_BATCH_NAME = T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM;
     END IF;
     \*\*DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
     DBMS_OUTPUT.PUT_LINE('返回状态为：');
     DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
     DBMS_OUTPUT.PUT_LINE('错误原因为：');
     DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);*\*\
      DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
     DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE); 
     V_RETURN_CODE    := T_RETURN_CODE;
     V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  \* 
    \*  IF V_RETURN_CODE <> 'S' THEN
       UPDATE CUX_GL_INTERFACE_DATA CD
          SET DATA_STATUS = 'ERROR'
        WHERE CD.GL_DATA_ID = T_HEADERS_ID;
     END IF;*\*\
   
   END SPM_GZ_AP_INFO_IMP_OFFICE;*/

  /*PROCEDURE SPM_GZ_AP_INFO_IMP_DEPT(\*V_ID             IN NUMBER,*\
                               V_MAIN_ID        IN  NUMBER, --数据批号
                               V_GLDATE         IN  VARCHAR2, --总账日期
                               V_PERIODDATE     IN  VARCHAR2, --期间
                               V_DQYEAR         IN  VARCHAR2, -- 当前年
                               V_DQMONTH        IN  VARCHAR2, -- 当前月
                               V_DQNUM          IN  VARCHAR2, --当前次
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
   \* L_IFACE_RGZGL     CUX_GL_INTERFACE_DATA%ROWTYPE;*\
    T_HEADERS_ID        NUMBER;
    T_NUMLINE           NUMBER;
    T_RETURN_CODE       VARCHAR2(1);
    T_RETURN_MESSAGE    VARCHAR2(4000);
    T_SYSDATE           VARCHAR2(20);
    T_ORG_CODE          VARCHAR2(20);
    T_DEPT_CODE       VARCHAR2(40);
    T_CREATED_BY        VARCHAR2(20);
    T_LAST_UPDATE_LOGIN VARCHAR2(20);
    T_LAST_UPDATED_BY   VARCHAR2(20);
    JBGZ_KMJE         NUMBER; \*基本工资等科目金额*\
    JJIN_KMJE         NUMBER; \*月奖等科目金额 借方*\
    DSZNF_KMJE        NUMBER; \*独子 托补科目金额*\
    FSJWF_KMJE        NUMBER; \*防暑降温科目金额*\
    JBYANGLBX_KMJE    NUMBER; \*扣基本养老科目金额*\
    JBYILBX_KMJE      NUMBER; \*扣医疗保险科目金额*\
    --BCYLBX_KMJE       NUMBER; \*补充医疗保险科目金额*\
    KSY_KMJE          NUMBER; \*扣失业科目金额*\
    ZFGJJ_KMJE        NUMBER; \*扣住房公积金科目金额*\
    QYNJ_KMJE         NUMBER; \*扣企业年金科目金额*\
    JJ_KMJE_DAI       NUMBER; \*扣事假科目金额 贷方*\
    GRSDS_KMJE        NUMBER; \*所得税科目金额*\
    JBH_KMJE          NUMBER; \*基本户科目金额（实发工资）*\
    
    JBGZ_KMJE_BM      NUMBER; \*基本工资等科目编码*\
    JJIN_KMJE_BM      NUMBER; \*月奖等科目编码*\
    DSZNF_KMJE_BM     NUMBER; \*独子 托补等科目编码*\
    FSJWF_KMJE_BM     NUMBER; \*防暑降温科目编码*\
    JBYANGLBX_KMJE_BM NUMBER; \*扣基本养老科目编码*\
    JBYILBX_KMJE_BM   NUMBER; \*扣医疗保险科目编码*\
    --BCYLBX_KMJE_BM    NUMBER; \*补充医疗保险科目编码*\
    KSY_KMJE_BM       NUMBER; \*扣失业科目编码*\
    ZFGJJ_KMJE_BM     NUMBER; \*扣住房公积金科目编码*\
    QYNJ_KMJE_BM      NUMBER; \*扣企业年金科目编码*\
    JJ_KMJE_DAI_BM    NUMBER; \*扣事假科目编码 贷方*\
    GRSDS_KMJE_BM     NUMBER; \*所得税科目编码*\
    JBH_KMJE_BM       NUMBER; \*基本户科目编码（实发工资）*\
    T_DATA_ID         NUMBER;
  
    --根据main_id获取处室编码
    
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
       SELECT DISTINCT DEPTCODE AS DEPT_CODE
        FROM SPM_GZ_WAGEDATA W
       WHERE MAIN_ID = P_MAIN_ID;
    REC_1 CUR_1%ROWTYPE;
  
    --按照处室分组，查询处室编码和各科目金额
    CURSOR CUR_2(P_DEPT_CODE VARCHAR2) IS
      SELECT *
        FROM (SELECT SUM(WA.GZYF_01+WA.GZYF_02 + WA.GZYF_03) AS JBGZ_KMJE,--基本工资等金额
                     SUM(WA.GZYF_04 + WA.GZYF_05 +WA.GZYF_06 + WA.GZYF_07 
                         + WA.GZYF_10 + WA.GZYF_11 + WA.GZYF_48 + WA.GZYF_49
                     ) AS JJIN_KMJE,--月奖等金额
                     SUM(WA.GZYF_08+ WA.GZYF_09) DSZNF_KMJE,--独子 托补等金额
                     SUM(WA.GZYF_12+WA.GZYF_19) FSJWF_KMJE,--防暑降温等金额
                     SUM(WA.GZKJ_01) JBYANGLBX_KMJE,--扣基本养老金额
                     SUM(WA.GZKJ_02+WA.GZKJ_03) JBYILBX_KMJE,--扣医疗保险 扣大额医疗金额
                     --SUM(WA.GZKJ_03) BCYLBX_KMJE,--去掉
                     SUM(WA.GZKJ_04) KSY_KMJE,--扣失业金额
                     SUM(WA.GZKJ_05) ZFGJJ_KMJE,--扣住房公积金金额
                     SUM(WA.GZKJ_06) QYNJ_KMJE,--扣企业年金金额
                     SUM(WA.GZKJ_07 + WA.GZKJ_08) JJ_KMJE_DAI,--扣事假 扣病假金额
                     SUM(WA.WAGE_TAX1) GRSDS_KMJE,--所得税金额
                     SUM(WA.WAGE_FACT) JBH_KMJE,--实发工资金额
                     WA.DEPTCODE
                FROM SPM_GZ_WAGEDATA WA
                WHERE WA.MAIN_ID=V_MAIN_ID
               GROUP BY WA.DEPTCODE)
       WHERE 1 = 1
         AND DEPTCODE = P_DEPT_CODE; 
   BEGIN
  
   SELECT COUNT(CD.GL_DATA_ID)
      INTO T_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       AND CD.DATA_STATUS <> 'E';
    IF T_DATA_ID <> 0 THEN
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '当前的工资数据已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
     T_NUMLINE := 0;
  
    --开始循环
    OPEN CUR_1(V_MAIN_ID);
    loop
  
      FETCH CUR_1
        INTO REC_1;
        exit when CUR_1%notfound;
  
      --获取公司代码 创建人 修改人id 修改人
      SELECT DISTINCT WA.ORGCODE,WA.CREATED_BY,WA.LAST_UPDATE_LOGIN,WA.LAST_UPDATED_BY
        INTO T_ORG_CODE,T_CREATED_BY,T_LAST_UPDATE_LOGIN,T_LAST_UPDATED_BY
        FROM SPM_GZ_WAGEDATA WA
       WHERE WA.MAIN_ID = V_MAIN_ID;
  
      -- 获取系统时间
      SELECT TO_CHAR(sysdate, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      T_DEPT_CODE := REC_1.DEPT_CODE;
       
      FOR REC_2 IN CUR_2(T_DEPT_CODE) LOOP
                  
        BEGIN
  
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
        T_NUMLINE    :=  T_NUMLINE+1;
        
        if REC_2.JBGZ_KMJE <>0 then 
          --插入中间表  处室第一列
          SELECT V.FLEX_VALUE 
            INTO JBGZ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '基本工资';
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,--修改日期
             LAST_UPDATED_BY, --修改人
             LAST_UPDATE_LOGIN, --登录人id
             CREATION_DATE, --创建日期
             CREATED_BY)    --创建人
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             REC_2.JBGZ_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 导入日期
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JBGZ_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
         end if;
         
         if REC_2.JJIN_KMJE <>0 then
          --插入中间表  处室第二列
         SELECT V.FLEX_VALUE 
            INTO JJIN_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '月奖';
           T_NUMLINE    := T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             REC_2.JJIN_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JJIN_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.DSZNF_KMJE <>0 then
  
          --插入中间表  处室第三列
          SELECT V.FLEX_VALUE 
            INTO DSZNF_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '独子';        
           T_NUMLINE    := T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             REC_2.DSZNF_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             DSZNF_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.FSJWF_KMJE <>0 then
  
          --插入中间表  处室第四列
           SELECT V.FLEX_VALUE 
            INTO FSJWF_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '防暑降温';         
        T_NUMLINE    := T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             REC_2.FSJWF_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             FSJWF_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.JBYANGLBX_KMJE <>0 then
  
          --插入中间表  处室第五列
           SELECT V.FLEX_VALUE 
            INTO JBYANGLBX_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣基本养老';         
        T_NUMLINE    := T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
              'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.JBYANGLBX_KMJE,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JBYANGLBX_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.JBYILBX_KMJE <>0 then
  
          --插入中间表  处室第六列
          SELECT V.FLEX_VALUE 
            INTO JBYILBX_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣医疗保险';           
          T_NUMLINE  :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.JBYILBX_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
              V_PERIODDATE,--期间
              2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JBYILBX_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.KSY_KMJE <>0 then
  
          --插入中间表  处室第七列       
           SELECT V.FLEX_VALUE 
            INTO KSY_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣失业';        
          T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
              'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.KSY_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             KSY_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
           end if;
         
          if REC_2.ZFGJJ_KMJE <>0 then
  
          --插入中间表  处室第八列
           SELECT V.FLEX_VALUE 
            INTO ZFGJJ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣住房公积金';         
         T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
            'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
            T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.ZFGJJ_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             ZFGJJ_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.QYNJ_KMJE <>0 then
  
          --插入中间表  处室第九列
           SELECT V.FLEX_VALUE 
            INTO QYNJ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣企业年金';         
         T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
              'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
            T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.QYNJ_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             QYNJ_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.JJ_KMJE_DAI <>0 then
  
          --插入中间表  处室第十列
           SELECT V.FLEX_VALUE 
            INTO JJ_KMJE_DAI_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '扣病假';        
           T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.JJ_KMJE_DAI,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JJ_KMJE_DAI_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.GRSDS_KMJE <>0 then
  
          --插入中间表  处室第十一列
           SELECT V.FLEX_VALUE 
            INTO GRSDS_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '所得税';         
           T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
            T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.GRSDS_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             GRSDS_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
         
          if REC_2.JBH_KMJE <>0 then
  
          --插入中间表  处室第十二列
          SELECT V.FLEX_VALUE 
            INTO JBH_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '实发工资';          
           T_NUMLINE    :=  T_NUMLINE+1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
  
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY)
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || V_DQNUM || '次工资', --
             '工资',   --
             '发放' || V_DQMONTH || '月工资',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- 总账日期
             'CNY',
             T_NUMLINE,
             '发放本月工资',
             0,
             REC_2.JBH_KMJE,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '用户',
             '人工',
             '记账',
             V_PERIODDATE,--期间
             2021,
             T_ORG_CODE,
             T_DEPT_CODE,
             JBH_KMJE_BM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_CREATED_BY);
          end if;
          commit;
        END;
      END LOOP;   
    end loop;   
    CLOSE CUR_1;
    cux_gl_import_pkg.MAIN( errbuf           => T_RETURN_MESSAGE,
                            retcode          => T_RETURN_CODE,
                            p_data_source    => 'SPM系统',
                            P_JE_BATCH_NAME  =>  T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,
                            p_repeant        =>  'Y');
    IF T_RETURN_CODE = 'S' THEN 
    --T_RETURN_CODE := G_INTERFACE_SUCCESS;
     V_RETURN_CODE    := T_RETURN_CODE;
    END IF;  
    IF V_RETURN_CODE <> 'S' THEN
      DELETE FROM CUX_GL_INTERFACE_DATA CD        
        WHERE CD.JE_BATCH_NAME = T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM;
    END IF;
    \*DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
    DBMS_OUTPUT.PUT_LINE('返回状态为：');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE('错误原因为：');*\
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE); 
    V_RETURN_CODE    := T_RETURN_CODE;
    V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  
   \*  IF V_RETURN_CODE <> 'S' THEN
      UPDATE CUX_GL_INTERFACE_DATA CD
         SET DATA_STATUS = 'ERROR'
       WHERE CD.GL_DATA_ID = T_HEADERS_ID;
    END IF;*\
  
  END SPM_GZ_AP_INFO_IMP_DEPT;*/
  --专家咨询费导入财务生成凭证
  PROCEDURE SPM_EXPERT_FEE_CREATE_CERT(V_MAIN_ID        IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2) IS
    T_HEADERS_ID        NUMBER;
    T_NUMLINE           NUMBER;
    T_RETURN_CODE       VARCHAR2(40);
    T_RETURN_MESSAGE    VARCHAR2(4000);
    T_SYSDATE           VARCHAR2(20);
    V_GLDATE            VARCHAR2(40); --总账日期
    V_PERIODNAME        VARCHAR2(40); --期间
    T_ORG_CODE          VARCHAR2(20);
    V_DEPTCODE          VARCHAR2(20);
    T_CON_NAME          VARCHAR2(90);
    T_CREATED_BY        NUMBER; --经办人
    T_LAST_UPDATE_LOGIN VARCHAR2(20);
    T_LAST_UPDATED_BY   VARCHAR2(20);
    T_DATA_ID           NUMBER;
    FAIL_DATA_ID        NUMBER;
    V_ORG_ID            NUMBER;
    V_DQYEAR            VARCHAR2(20);
    V_DQMONTH           VARCHAR2(20);
    YHDKMBM             VARCHAR2(40);
    V_BANKCAPTION       VARCHAR2(40);
    CREATEDBYNAME       VARCHAR2(40);
    V_CASH_FLOW         VARCHAR2(200);
    V_JE_NAME           VARCHAR2(2000);
    V_GROUP_ID          NUMBER;
    
    V_MATCH_DEPT          VARCHAR2(40); --资金使用项目
    V_MATCH_PROJECT       VARCHAR2(40); --资金使用部门
    
    V_KM     VARCHAR2(40);--生成科目
    K_PROJECT VARCHAR2(40);--项目段

    --根据main_id获取处室编码
  
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
      SELECT SUM(D.FACT_AMOUNT) AS YHCKJE, --银行存款金额
             SUM(D.TAX_AMOUNT) AS YJSFJE, --应交个人所得税金额
             SUM(D.PAY_AMOUNT) AS ZXFWFJE --咨询服务费金额
        FROM SPM_EXPERT_FEE_DETAIL D
       WHERE D.FEE_MAIN_ID = P_MAIN_ID;
    REC_1 CUR_1%ROWTYPE;
  
  BEGIN
    --默认值   50010625
    V_KM := '50010625';
    
    /*select P.PROJECT_CODE
      INTO K_PROJECT
      from SPM_CON_PROJECT P, SPM_EXPERT_FEE F
     WHERE P.ORG_ID = F.ORG_ID
       AND P.PROJECT_NAME like '%无工程-%'
       AND F.FEE_MAIN_ID = V_MAIN_ID;*/
    
    BEGIN
      select NVL(D.ATTRABUTE1, '50010625')
        INTO V_KM
        from SPM_EXPERT_FEE            F,
             HR_ALL_ORGANIZATION_UNITS U,
             SPM_DICT                  D,
             SPM_DICT_TYPE             T
       WHERE F.DEPT_ID = U.ORGANIZATION_ID
         AND D.DICT_TYPE_ID = T.DICT_TYPE_ID
         AND T.TYPE_CODE = 'SPM_EXPERT_KM'
         AND D.DICT_CODE = U.ATTRIBUTE6
         AND F.FEE_MAIN_ID = V_MAIN_ID;
    EXCEPTION
      WHEN OTHERS THEN
        V_KM := '50010625';
    END;
    
    
  
    SELECT COUNT(CD.GL_DATA_ID)
      INTO T_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       AND CD.DATA_STATUS = 'IMPORT';
    IF T_DATA_ID <> 0 THEN
      --说明已经导入过
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '当前的工资数据已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
    SELECT COUNT(CD.GL_DATA_ID)
      INTO FAIL_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       AND CD.DATA_STATUS <> 'IMPORT';
    IF FAIL_DATA_ID <> 0 THEN
      --说明有错误数据在中间表
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID;
    END IF;
  
    T_NUMLINE := 0;
    BEGIN
      --开始循环
      OPEN CUR_1(V_MAIN_ID);
      LOOP
      
        FETCH CUR_1
          INTO REC_1;
        EXIT WHEN CUR_1%NOTFOUND;
      
        --获取会议名称、部门段、银行科目段、总账时间 创建人 修改人id 修改人
        SELECT DISTINCT SUBSTRB(F.CONFERENCE_NAME, 1, 50),
                        F.ATTRIBUTE2,
                        F.ATTRIBUTE3,
                        TO_CHAR(F.TOTAL_DATE, 'YYYYMMDD'),
                        TO_CHAR(F.TOTAL_DATE, 'YYYYMM'),
                        F.CREATED_BY,
                        F.LAST_UPDATE_LOGIN,
                        F.LAST_UPDATED_BY,
                        F.ORG_ID,
                        D.FF_YEAR,
                        D.FF_MONTH,
                        F.CASH_FLOW_ID,
                        F.MATCH_DEPT,
                        F.MATCH_PROJECT
                                              
          INTO T_CON_NAME,
               V_DEPTCODE,
               V_BANKCAPTION,
               V_GLDATE,
               V_PERIODNAME,
               T_CREATED_BY,
               T_LAST_UPDATE_LOGIN,
               T_LAST_UPDATED_BY,
               V_ORG_ID,
               V_DQYEAR,
               V_DQMONTH,
               V_CASH_FLOW,
               V_MATCH_DEPT,
               V_MATCH_PROJECT
               
          FROM SPM_EXPERT_FEE F
          LEFT JOIN SPM_EXPERT_FEE_DETAIL D
            ON F.FEE_MAIN_ID = D.FEE_MAIN_ID
         WHERE F.FEE_MAIN_ID = V_MAIN_ID;
        --获取经办人      
        CREATEDBYNAME := SPM_EAM_COMMON_PKG.GET_FULLNAME_BY_USERID(T_CREATED_BY);
        --获取公司段 
        SELECT OU.SHORT_CODE
          INTO T_ORG_CODE
          FROM HR_OPERATING_UNITS OU
         WHERE OU.ORGANIZATION_ID = V_ORG_ID;
      
        -- 获取系统时间
        SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      
        -- 获取本次头信息的主键数据id
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
        T_NUMLINE  := T_NUMLINE + 1;
        V_JE_NAME  := T_ORG_CODE || V_DQYEAR || V_DQMONTH || T_CON_NAME ||
                      V_MAIN_ID;
        V_GROUP_ID := V_MAIN_ID || V_DQYEAR || V_DQMONTH;
        IF REC_1.ZXFWFJE <> 0 THEN
          --插入中间表  咨询服务费第一列
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE, --修改日期
             LAST_UPDATED_BY, --修改人
             LAST_UPDATE_LOGIN, --登录人id
             CREATION_DATE, --创建日期
             CREATED_BY, --创建人
             GROUP_ID) --GROUP_ID
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             V_JE_NAME, -- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || T_CON_NAME ||
             '专家咨询费报销单', --
             '专家咨询费', --
             '报销' || T_CON_NAME || '专家咨询费', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 总账日期
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '报销' || T_CON_NAME || '专家咨询费', --摘要
             REC_1.ZXFWFJE, --借方金额
             0, --贷方金额
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 导入日期
             '用户',
             '专家咨询费',
             '记账',
             V_PERIODNAME, --期间
             2021,
             T_ORG_CODE,
             V_DEPTCODE,
             V_KM,
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             V_GROUP_ID);
        END IF;
      
        IF REC_1.YJSFJE <> 0 THEN
          --插入中间表  应交税费第二列       
          T_NUMLINE := T_NUMLINE + 1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
        
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY,
             GROUP_ID) --GROUP_ID
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             V_JE_NAME, -- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || T_CON_NAME ||
             '专家咨询费报销单', --
             '专家咨询费', --
             '报销' || T_CON_NAME || '专家咨询费', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 总账日期
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '报销' || T_CON_NAME || '专家咨询费', --摘要
             0, --借方金额
             REC_1.YJSFJE, --贷方金额                      
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 导入日期
             '用户',
             '专家咨询费',
             '记账',
             V_PERIODNAME, --期间
             2021,
             T_ORG_CODE,
             V_DEPTCODE,
             '222118',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             V_GROUP_ID);
        END IF;
      
        IF REC_1.YHCKJE <> 0 THEN
        
          --插入中间表  银行存款第三列                  
          T_NUMLINE := T_NUMLINE + 1;
          -- 获取本次头信息的主键数据id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          --查询银行段科目编号
          SELECT F.ATTRIBUTE1
            INTO YHDKMBM
            FROM SPM_EXPERT_FEE F
           WHERE F.FEE_MAIN_ID = V_MAIN_ID;
        
          INSERT INTO CUX_GL_INTERFACE_DATA
            (GL_DATA_ID,
             GL_DATA_SOURCE,
             JE_BATCH_NAME,
             BATCH_DESCRIPTION,
             JE_HEADER_NAME,
             HEADER_DESCRIPTION,
             GL_DATE,
             CURRENCY_CODE,
             JE_LINE_NUM,
             JE_LINE_DESCRIPTION,
             ENTERED_DR,
             ENTERED_CR,
             DATA_STATUS,
             OBJECT_VERSION_NUMBER,
             OPERATE_DATE,
             BUSINESS_TYPE,
             USER_JE_SOURCE_NAME,
             USER_JE_CATEGORY_NAME,
             PERIOD_NAME,
             GL_SET_OF_BOOK_ID,
             ATTRIBUTE4,
             SEGMENT1,
             SEGMENT2,
             SEGMENT3,
             SEGMENT4,
             SEGMENT5,
             SEGMENT6,
             SEGMENT7,
             SEGMENT8,
             SEGMENT9,
             SEGMENT10,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_LOGIN,
             CREATION_DATE,
             CREATED_BY,
             GROUP_ID) --GROUP_ID
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             V_JE_NAME, -- 账批号
             V_DQYEAR || '年' || V_DQMONTH || '月' || T_CON_NAME ||
             '专家咨询费报销单', --
             '专家咨询费', --
             '报销' || T_CON_NAME || '专家咨询费', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 总账日期
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '报销' || T_CON_NAME || '专家咨询费', --摘要
             0, --借方金额
             REC_1.YHCKJE, --贷方金额            
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- 导入日期
             '用户',
             '专家咨询费',
             '记账',
             V_PERIODNAME, --期间
             2021,
             V_CASH_FLOW,
             T_ORG_CODE,
             '00',
             V_BANKCAPTION, --银行科目           
             '00',
             '00',
             '00',
             '00',
             '00',
             YHDKMBM, --银行段
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             T_LAST_UPDATE_LOGIN,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             T_LAST_UPDATED_BY,
             V_GROUP_ID);
        END IF;
        COMMIT;
      END LOOP;
      CLOSE CUR_1;
    END;
    CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => T_RETURN_CODE,
                           RETCODE         => T_RETURN_MESSAGE,
                           P_DATA_SOURCE   => 'SPM系统',
                           P_JE_BATCH_NAME => V_JE_NAME,
                           P_REPEANT       => 'Y');
    IF T_RETURN_CODE = 'S' THEN
      --T_RETURN_CODE := G_INTERFACE_SUCCESS;
      V_RETURN_CODE := T_RETURN_CODE;
    
      BEGIN
        -- 更新现金流
        UPDATE GL_JE_LINES GJL
           SET GJL.ATTRIBUTE4 = V_CASH_FLOW,
               GJL.ATTRIBUTE1 = V_MATCH_DEPT,
               GJL.ATTRIBUTE2 = V_MATCH_PROJECT,
               GJL.CONTEXT = V_BANKCAPTION
         WHERE GJL.JE_HEADER_ID IN
               (SELECT JH.JE_HEADER_ID
                  FROM GL_JE_BATCHES JB, GL_JE_HEADERS JH
                 WHERE JH.JE_BATCH_ID = JB.JE_BATCH_ID        
                   AND JB.NAME LIKE '%' || V_JE_NAME || '%')                  
               AND EXISTS
           (SELECT 1
                    FROM GL_CODE_COMBINATIONS GCC
                   WHERE GCC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
                     AND GCC.SEGMENT1 = T_ORG_CODE
                     AND GCC.SEGMENT2 = '00'
                     AND GCC.SEGMENT3 = V_BANKCAPTION);
      
        -- 更新groupId
        UPDATE SPM_EXPERT_FEE F
           SET F.GROUP_ID = V_GROUP_ID
         WHERE F.FEE_MAIN_ID = V_MAIN_ID;
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);
      END;
    ELSE
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID;
    END IF;
    /* DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
    DBMS_OUTPUT.PUT_LINE('返回状态为：');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE('错误原因为：');*/
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);
    V_RETURN_CODE    := T_RETURN_CODE;
    V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  
    /*IF V_RETURN_CODE <> 'S' THEN
      UPDATE CUX_GL_INTERFACE_DATA CD
         SET DATA_STATUS = 'ERROR'
       WHERE CD.GL_DATA_ID = T_HEADERS_ID;
    END IF;*/
  END SPM_EXPERT_FEE_CREATE_CERT;

  --进项发票验证
  PROCEDURE BATCH_INPUT_VALIDATE(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA_HEAD IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H),
             TRIM(I),
             TRIM(J),
             TRIM(K),
             TRIM(L),
             TRIM(M),
             TRIM(N),
             TRIM(O),
             TRIM(P),
             TRIM(Q),
             TRIM(R),
             TRIM(S),
             TRIM(T),
             TRIM(U),
             TRIM(V),
             TRIM(W)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '发票主信息'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    CURSOR CU_DATA_LINE IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '发票行信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A  VARCHAR2(2000);
    VALIDATE_B  VARCHAR2(2000);
    VALIDATE_C  VARCHAR2(2000);
    VALIDATE_D  VARCHAR2(2000);
    VALIDATE_E  VARCHAR2(2000);
    VALIDATE_F  VARCHAR2(2000);
    VALIDATE_G  VARCHAR2(2000);
    VALIDATE_H  VARCHAR2(2000);
    VALIDATE_I  VARCHAR2(2000);
    VALIDATE_J  VARCHAR2(2000);
    VALIDATE_K  VARCHAR2(2000);
    VALIDATE_L  VARCHAR2(2000);
    VALIDATE_M  VARCHAR2(2000);
    VALIDATE_N  VARCHAR2(2000);
    VALIDATE_O  VARCHAR2(2000);
    VALIDATE_P  VARCHAR2(2000);
    VALIDATE_Q  VARCHAR2(2000);
    VALIDATE_R  VARCHAR2(2000);
    VALIDATE_S  VARCHAR2(2000);
    VALIDATE_T  VARCHAR2(2000);
    VALIDATE_U  VARCHAR2(2000);
    VALIDATE_V  VARCHAR2(2000);
    VALIDATE_W  VARCHAR2(2000);
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
  
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    INVOICENUMBER1   NUMBER;
    INVOICENUMBER2   NUMBER;
    CONCODENUMBER    NUMBER;
    COUNTNUMBER1     NUMBER;
    COUNTNUMBER2     NUMBER;
    KMDNUMBER        NUMBER; --科目段值count
    --记录符合条件的合同，项目，客户
    V_CONTRACT_ID NUMBER(15);
    V_PROJECT_ID  NUMBER(15);
    V_CUST_ID     NUMBER(15);
    V_USER_ID     NUMBER(15);
    V_DEPT_ID     NUMBER(15);
    V_VENDOR_ID   NUMBER(15); --供应商id
  
    P_MSG_H     VARCHAR2(2000) := '头表';
    P_MSG_L     VARCHAR2(2000) := '行表';
    SHORTCODE   VARCHAR2(20);
    SERVICETYPE VARCHAR2(40);
  
    MSG_A2 VARCHAR2(4000);
    MSG_A  VARCHAR2(4000);
    MSG_B  VARCHAR2(4000);
    MSG_C  VARCHAR2(4000);
    MSG_D  VARCHAR2(4000);
    MSG_E  VARCHAR2(4000);
    MSG_F  VARCHAR2(4000);
    MSG_FF VARCHAR2(4000);
    MSG_G  VARCHAR2(4000);
    MSG_H  VARCHAR2(4000);
    MSG_I  VARCHAR2(4000);
    MSG_J  VARCHAR2(4000);
    MSG_K  VARCHAR2(4000);
    MSG_L  VARCHAR2(4000);
    MSG_M  VARCHAR2(4000);
    MSG_N  VARCHAR2(4000);
    MSG_N1 VARCHAR2(4000);
    MSG_N2 VARCHAR2(4000);
    MSG_O  VARCHAR2(4000);
    MSG_P  VARCHAR2(4000);
    MSG_P1 VARCHAR2(4000);
    MSG_Q  VARCHAR2(4000);
    MSG_R  VARCHAR2(4000);
    MSG_S  VARCHAR2(4000);
    MSG_T  VARCHAR2(4000);
    MSG_U  VARCHAR2(4000);
    MSG_V  VARCHAR2(4000);
    MSG_W  VARCHAR2(4000);
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
    MSG_D1 VARCHAR2(4000);
    MSG_D2 VARCHAR2(4000);
    MSG_E1 VARCHAR2(4000);
    MSG_F1 VARCHAR2(4000);
    MSG_G1 VARCHAR2(4000);
    MSG_H1 VARCHAR2(4000);
  
  BEGIN
    --验证 EBS发票号码在表里是否已经存在  
    SELECT COUNT(*)
      INTO INVOICENUMBER1
      FROM SPM_CON_INPUT_INVOICE I
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_IMPORT_TEMP_D D
             WHERE D.A = I.INVOICE_CODE
               AND D.TEMP_M_ID = P_BATCHCODE);
    --不为0时 已经存在 
    IF INVOICENUMBER1 <> 0 THEN
      P_MSG := 'EBS发票号码和系统里的号码有重复';
      RETURN;
    END IF;
    --验证当EBS发票号码存在相同的情况时，合同编号是否相同
    /* SELECT COUNT(1) INTO COUNTNUMBER1 FROM 
     (SELECT DISTINCT D.A FROM SPM_IMPORT_TEMP_D D 
       WHERE TEMP_M_ID = P_BATCHCODE
        AND SHEET_NAME = '发票主信息'
        AND TO_NUMBER(ROW_NUMBER) >= 2
        AND D.A)
      WHERE 1 = 1;
    SELECT COUNT(1) INTO COUNTNUMBER2 FROM 
     (SELECT DISTINCT D.D FROM SPM_IMPORT_TEMP_D D 
       WHERE TEMP_M_ID = P_BATCHCODE
        AND SHEET_NAME = '发票主信息'
        AND TO_NUMBER(ROW_NUMBER) >= 2)
      WHERE 1 = 1;
     IF COUNTNUMBER1 <> COUNTNUMBER2 THEN
        P_MSG := 'EBS发票号码相同时，合同（订单）编号列存在不相同的情况';
     RETURN;
    END IF;*/
    --验证行信息的EBS发票号码是否都存在于主信息EBS发票号码   
    SELECT COUNT(*)
      INTO INVOICENUMBER2
      FROM (SELECT DISTINCT D.A
              FROM SPM_IMPORT_TEMP_D D
             WHERE 1 = 1
               AND D.TEMP_M_ID = P_BATCHCODE
               AND D.SHEET_NAME = '发票行信息'
               AND TO_NUMBER(ROW_NUMBER) >= 2) DL
     WHERE 1 = 1
       AND NOT EXISTS (SELECT 1
              FROM (SELECT DISTINCT D.A
                      FROM SPM_IMPORT_TEMP_D D
                     WHERE 1 = 1
                       AND D.TEMP_M_ID = P_BATCHCODE
                       AND D.SHEET_NAME = '发票主信息'
                       AND TO_NUMBER(ROW_NUMBER) >= 2) DH
             WHERE DH.A = DL.A);
    --不为0时 行号码有不在主号码里的情况
    IF INVOICENUMBER2 <> 0 THEN
      P_MSG := '发票行信息里EBS发票号码与主信息对比存在多余的发票号码';
      RETURN;
    END IF;
  
    --验证行信息的合同编号是否都存在于主信息合同编号里
    SELECT COUNT(*)
      INTO CONCODENUMBER
      FROM (SELECT DISTINCT D.B
              FROM SPM_IMPORT_TEMP_D D
             WHERE 1 = 1
               AND D.TEMP_M_ID = P_BATCHCODE
               AND D.SHEET_NAME = '发票行信息'
               AND TO_NUMBER(ROW_NUMBER) >= 2
               AND D.B IS NOT NULL) DL
     WHERE 1 = 1
       AND NOT EXISTS (SELECT 1
              FROM (SELECT DISTINCT D.D
                      FROM SPM_IMPORT_TEMP_D D
                     WHERE 1 = 1
                       AND D.TEMP_M_ID = P_BATCHCODE
                       AND D.SHEET_NAME = '发票主信息'
                       AND TO_NUMBER(ROW_NUMBER) >= 2
                       AND D.B IS NOT NULL) DH
             WHERE DH.D = DL.B);
    --不为0时 行合同编号有不在主信息合同编号里的情况
    IF CONCODENUMBER <> 0 THEN
      P_MSG := '发票行信息里和合同（订单）编号与主信息对比存在多余的合同编号';
      RETURN;
    END IF;
  
    OPEN CU_DATA_HEAD;
    FETCH CU_DATA_HEAD
      INTO VALIDATE_A,
           VALIDATE_B,
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E,
           VALIDATE_F,
           VALIDATE_G,
           VALIDATE_H,
           VALIDATE_I,
           VALIDATE_J,
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           VALIDATE_N,
           VALIDATE_O,
           VALIDATE_P,
           VALIDATE_Q,
           VALIDATE_R,
           VALIDATE_S,
           VALIDATE_T,
           VALIDATE_U,
           V_DEPT_ID,
           V_USER_ID;
  
    OPEN CU_DATA_LINE;
    FETCH CU_DATA_LINE
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1;
  
    --验证导入字段名格式是否正确
    IF CU_DATA_HEAD%FOUND THEN
    
      IF VALIDATE_A <> 'EBS发票号码' OR VALIDATE_B <> '发票代码' OR
         VALIDATE_C <> '发票号码' OR VALIDATE_D <> '合同（订单）编号' OR
         VALIDATE_E <> '合同名称' OR VALIDATE_F <> '项目名称' OR
         VALIDATE_G <> '单位名称' OR VALIDATE_H <> '发票分类' OR
         VALIDATE_I <> '开票日期' OR VALIDATE_J <> '摘要' OR VALIDATE_K <> '登记时间' OR
         VALIDATE_L <> '供应商地点' OR VALIDATE_M <> '发票金额' OR
         VALIDATE_N <> '税率' OR VALIDATE_O <> '税额' OR VALIDATE_P <> '产品类型' OR
         VALIDATE_Q <> '不含税差异' OR VALIDATE_R <> '核算部门' OR
         VALIDATE_S <> '备注' OR VALIDATE_T <> '快递单号' OR VALIDATE_U <> '收件人' THEN
        P_MSG := '导入数据的列名不符合格式';
        CLOSE CU_DATA_HEAD;
        RETURN;
      END IF;
    
      IF CU_DATA_LINE%FOUND THEN
        IF VALIDATE_A1 <> 'EBS发票号码' OR VALIDATE_B1 <> '合同（订单）编号' OR
           VALIDATE_C1 <> '入库单号' OR VALIDATE_D1 <> '不含税金额' OR
           VALIDATE_E1 <> '摘要' OR VALIDATE_F1 <> '科目段' THEN
          P_MSG := '导入数据的行表列名不符合格式';
          CLOSE CU_DATA_LINE;
          RETURN;
        END IF;
      END IF;
    
      FETCH CU_DATA_HEAD
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F,
             VALIDATE_G,
             VALIDATE_H,
             VALIDATE_I,
             VALIDATE_J,
             VALIDATE_K,
             VALIDATE_L,
             VALIDATE_M,
             VALIDATE_N,
             VALIDATE_O,
             VALIDATE_P,
             VALIDATE_Q,
             VALIDATE_R,
             VALIDATE_S,
             VALIDATE_T,
             VALIDATE_U,
             V_DEPT_ID,
             V_USER_ID;
      WHILE CU_DATA_HEAD%FOUND LOOP
      
        -- 验证A、B C 、G、H、I、J、M、N、O P 是否为空
        IF VALIDATE_A IS NULL THEN
          --EBS发票号码是否为空
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_B IS NULL THEN
          --发票代码是否为空
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_C IS NULL THEN
          --发票号码是否为空
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        /*IF VALIDATE_D IS NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA_HEAD%ROWCOUNT+1;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA_HEAD%ROWCOUNT+1;
          END IF;
        END IF;
        IF VALIDATE_E IS NULL THEN
          IF MSG_E IS NULL THEN
            MSG_E := CU_DATA_HEAD%ROWCOUNT+1;
          ELSE
            MSG_E := MSG_E || ',' || CU_DATA_HEAD%ROWCOUNT+1;
          END IF;
        END IF;
        IF VALIDATE_F IS NULL THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA_HEAD%ROWCOUNT+1;
          ELSE
            MSG_F := MSG_F || ',' || CU_DATA_HEAD%ROWCOUNT+1;
          END IF;
        END IF;*/
        IF VALIDATE_G IS NULL THEN
          --单位名称是否为空
          IF MSG_G IS NULL THEN
            MSG_G := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_G := MSG_G || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_H IS NULL THEN
          --发票分类是否为空
          IF MSG_H IS NULL THEN
            MSG_H := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_H := MSG_H || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_I IS NULL THEN
          --开票日期是否为空  
          IF MSG_I IS NULL THEN
            MSG_I := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_I := MSG_I || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_J IS NULL THEN
          --摘要是否为空
          IF MSG_J IS NULL THEN
            MSG_J := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_J := MSG_J || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        /*      IF VALIDATE_K IS NULL THEN  --
          IF MSG_K IS NULL THEN
            MSG_K := CU_DATA_HEAD%ROWCOUNT+1;
          ELSE
            MSG_K := MSG_K || ',' || CU_DATA_HEAD%ROWCOUNT+1;
          END IF;
        END IF;
        IF VALIDATE_L IS NULL THEN
          IF MSG_L IS NULL THEN
            MSG_L := CU_DATA_HEAD%ROWCOUNT+1;
          ELSE
            MSG_L := MSG_L || ',' || CU_DATA_HEAD%ROWCOUNT+1;
          END IF;
        END IF;*/
        IF VALIDATE_M IS NULL THEN
          --发票金额是否为空
          IF MSG_M IS NULL THEN
            MSG_M := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_M := MSG_M || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_N IS NULL THEN
          --税率是否为空
          IF MSG_N IS NULL THEN
            MSG_N := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_N := MSG_N || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_O IS NULL THEN
          --税额是否为空
          IF MSG_O IS NULL THEN
            MSG_O := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_O := MSG_O || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_P IS NULL THEN
          --产品类型是否为空
          IF MSG_P IS NULL THEN
            MSG_P := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_P := MSG_P || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        -- 发票号码重复性验证
        /* IF VALIDATE_A IS NOT NULL THEN
            SELECT COUNT(1)
              INTO VALIDATE_NUMBER
              FROM SPM_CON_INPUT_INVOICE I
             WHERE I.INVOICE_CODE = VALIDATE_A;
          
            IF VALIDATE_NUMBER <> 0 THEN
              IF MSG_A IS NULL THEN
                MSG_A := CU_DATA_HEAD%ROWCOUNT+1;
              ELSE
                MSG_A := MSG_A || ',' || CU_DATA_HEAD%ROWCOUNT+1;
              END IF;
            END IF;
          END IF;
        */
        -- 合同编号验证
        IF VALIDATE_D IS NOT NULL THEN
          SELECT COUNT(C.CONTRACT_ID)
            INTO VALIDATE_NUMBER
            FROM SPM_CON_HT_INFO C
           WHERE 1 = 1 /* AND C.STATUS = 'E'*/
             AND C.ORG_ID = SPM_SSO_PKG.GETORGID
             AND C.CONTRACT_CODE = VALIDATE_D;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          ELSE
            --验证合同名称的一致性
            SELECT COUNT(C.CONTRACT_ID)
              INTO VALIDATE_NUMBER
              FROM SPM_CON_HT_INFO C
             WHERE 1 = 1 /* AND C.STATUS = 'E'*/
               AND C.ORG_ID = SPM_SSO_PKG.GETORGID
               AND C.CONTRACT_NAME = VALIDATE_E
               AND C.CONTRACT_CODE = VALIDATE_D;
          
            IF VALIDATE_NUMBER = 0 THEN
              IF MSG_E IS NULL THEN
                MSG_E := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_E := MSG_E || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            ELSIF VALIDATE_NUMBER = 1 THEN
              SELECT C.CONTRACT_ID
                INTO V_CONTRACT_ID
                FROM SPM_CON_HT_INFO C
               WHERE 1 = 1
                 AND C.ORG_ID = SPM_SSO_PKG.GETORGID
                 AND C.CONTRACT_NAME = VALIDATE_E
                 AND C.CONTRACT_CODE = VALIDATE_D;
            ELSE
              SELECT C.CONTRACT_ID
                INTO V_CONTRACT_ID
                FROM SPM_CON_HT_INFO C
               WHERE 1 = 1
                 AND C.ORG_ID = SPM_SSO_PKG.GETORGID
                 AND C.STATUS = 'E'
                 AND C.STATUS_CHANGE = '1'
                 AND C.CONTRACT_NAME = VALIDATE_E
                 AND C.CONTRACT_CODE = VALIDATE_D;
            END IF;
          END IF;
        END IF;
      
        --项目名称验证
        IF VALIDATE_F IS NOT NULL THEN
          --验证该公司的00项目
          IF VALIDATE_F = '00' THEN
            SELECT COUNT(1)
              INTO VALIDATE_NUMBER
              FROM SPM_CON_PROJECT P
             WHERE P.PROJECT_NAME LIKE '%无工程-%'
               AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
          
            IF VALIDATE_NUMBER = 0 THEN
              IF MSG_FF IS NULL THEN
                MSG_FF := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_FF := MSG_FF || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            END IF;
          ELSE
            SELECT COUNT(1)
              INTO VALIDATE_NUMBER
              FROM SPM_CON_PROJECT P
             WHERE P.PROJECT_NAME = VALIDATE_F
               AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
          
            IF VALIDATE_NUMBER = 0 THEN
              IF MSG_F IS NULL THEN
                MSG_F := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_F := MSG_F || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            ELSE
              --记录符合条件的工程ID
              SELECT P.PROJECT_ID
                INTO V_PROJECT_ID
                FROM SPM_CON_PROJECT P
               WHERE P.PROJECT_NAME = VALIDATE_F
                 AND P.STATUS = 'E'
                 AND P.EBS_STATUS = 'S'
                 AND ROWNUM = 1;
            END IF;
          END IF;
        END IF;
      
        -- 供应商 单位名称验证
        IF VALIDATE_G IS NOT NULL THEN
          SELECT COUNT(V.VENDOR_ID)
            INTO VALIDATE_NUMBER
            FROM SPM_CON_VENDOR_INFO V
           WHERE V.VENDOR_NAME = VALIDATE_G;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_G IS NULL THEN
              MSG_G := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_G := MSG_G || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          ELSE
            SELECT V.VENDOR_ID
              INTO V_VENDOR_ID
              FROM SPM_CON_VENDOR_INFO V
             WHERE V.VENDOR_NAME = VALIDATE_G;
          END IF;
        END IF;
      
        -- 发票分类验证
        /* IF VALIDATE_H IS NOT NULL THEN
          SELECT COUNT(1)
            INTO VALIDATE_NUMBER
            FROM FND_LOOKUP_VALUES_VL T
           WHERE T.LOOKUP_TYPE = 'INV/CM'
             AND T.ENABLED_FLAG = 'Y'
             AND T.LOOKUP_CODE IN ('INV', 'CM')
             AND T.MEANING = VALIDATE_H;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA_HEAD%ROWCOUNT+1;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA_HEAD%ROWCOUNT+1;
            END IF;
          END IF;
        END IF;*/
      
        -- 开票时间格式校验
        IF VALIDATE_I IS NOT NULL THEN
          VALIDATE_NUMBER := SPM_CON_UTIL_PKG.IS_DATE(SUBSTR(VALIDATE_I,
                                                             1,
                                                             10),
                                                      'YYYY-MM-DD');
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_I IS NULL THEN
              MSG_I := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_I := MSG_I || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
      
        -- 登记时间格式校验
        IF VALIDATE_K IS NOT NULL THEN
          VALIDATE_NUMBER := SPM_CON_UTIL_PKG.IS_DATE(SUBSTR(VALIDATE_K,
                                                             1,
                                                             10),
                                                      'YYYY-MM-DD');
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_K IS NULL THEN
              MSG_K := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_K := MSG_K || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
      
        -- 供应商地点是否存在验证
        IF VALIDATE_L IS NOT NULL THEN
          SELECT S.SHORT_CODE
            INTO SHORTCODE
            FROM HR_OPERATING_UNITS S
           WHERE S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID;
        
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER
            FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP, HR_OPERATING_UNITS S
           WHERE S.SHORT_CODE = SHORTCODE --
             AND S.ORGANIZATION_ID = T.ORG_ID
             AND T.VENDOR_ID = PP.VENDOR_ID
             AND PP.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND T.VENDOR_SITE_CODE = VALIDATE_L
             AND PP.VENDOR_NAME = VALIDATE_G;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_L IS NULL THEN
              MSG_L := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_L := MSG_L || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        -- 发票金额数字验证
        IF VALIDATE_M IS NOT NULL THEN
          SELECT SPM_CON_UTIL_PKG.IS_NUMBER(VALIDATE_M, '')
            INTO VALIDATE_NUMBER
            FROM DUAL;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
      
        --校验税率（%）是否为固定值
        IF VALIDATE_N IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER2
            FROM DUAL
           WHERE VALIDATE_N IN (0，3，5，10，11，16，17);
          IF VALIDATE_NUMBER2 = 0 THEN
            --不在固定值范围里
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          ELSE
            IF VALIDATE_H = '增值税专用发票' AND VALIDATE_N = '0' THEN
              IF MSG_N1 IS NULL THEN
                MSG_N1 := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_N1 := MSG_N1 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            END IF;
            IF VALIDATE_H = '其他' AND VALIDATE_N <> '0' THEN
              IF MSG_N2 IS NULL THEN
                MSG_N2 := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_N2 := MSG_N2 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            END IF;
          END IF;
        END IF;
      
        -- 税额数字验证
        IF VALIDATE_O IS NOT NULL THEN
          SELECT SPM_CON_UTIL_PKG.IS_NUMBER(VALIDATE_O, '')
            INTO VALIDATE_NUMBER
            FROM DUAL;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_O IS NULL THEN
              MSG_O := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_O := MSG_O || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_P IS NOT NULL THEN
          IF VALIDATE_P <> '服务' AND VALIDATE_P <> '货物' THEN
            IF MSG_P1 IS NULL THEN
              MSG_P1 := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_P1 := MSG_P1 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        --不含税差异数值验证
        IF VALIDATE_Q IS NOT NULL THEN
          SELECT SPM_CON_UTIL_PKG.IS_NUMBER(VALIDATE_Q, '')
            INTO VALIDATE_NUMBER
            FROM DUAL;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_Q IS NULL THEN
              MSG_Q := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_Q := MSG_Q || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        -- 核算部门验证
        IF VALIDATE_R IS NOT NULL THEN
          SELECT COUNT(1)
            INTO VALIDATE_NUMBER
            FROM FND_FLEX_VALUES_VL V
           WHERE FLEX_VALUE_SET_ID =
                 (SELECT F.FLEX_VALUE_SET_ID
                    FROM FND_FLEX_VALUE_SETS F
                   WHERE F.FLEX_VALUE_SET_NAME = 'DT 部门')
             AND V.ENABLED_FLAG = 'Y'
             AND DESCRIPTION = VALIDATE_R;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_R IS NULL THEN
              MSG_R := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_R := MSG_R || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
      
        -- 验证合同、项目与供应商的关联关系
        IF V_CONTRACT_ID IS NULL /*AND V_PROJECT_ID IS NULL*/
           AND V_VENDOR_ID IS NULL THEN
          WITH S AS
           (SELECT DISTINCT H.CONTRACT_ID
              FROM SPM_CON_HT_INFO H
             WHERE 1 = 1
                  /*AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(H.CONTRACT_ID) = 'Y'*/
               AND H.IN_OUT_TYPE != '1'
               AND H.ORG_ID = SPM_SSO_PKG.GETORGID),
          HV AS
           (SELECT DISTINCT HI.CONTRACT_ID, VI.VENDOR_ID
              FROM SPM_CON_HT_MERCHANTS HM,
                   SPM_CON_HT_INFO      HI,
                   SPM_CON_VENDOR_INFO  VI
             WHERE HM.CONTRACT_ID = HI.CONTRACT_ID
               AND VI.VENDOR_ID = HM.MERCHANTS_ID
               AND VI.STATUS = 'E'
               AND SPM_CON_CONTRACT_PKG.SPM_CON_VENDOR_TOEBS(VI.VENDOR_ID) = 'Y'
               AND VI.VENDOR_ID = V_VENDOR_ID
               AND HM.MERCHANTS_FLAG = '2'),
          HP AS
           (SELECT P.PROJECT_ID, P.CONTRACT_ID
              FROM SPM_CON_HT_PROJECT P, SPM_CON_HT_INFO H
             WHERE P.CONTRACT_ID = H.CONTRACT_ID)
          
          SELECT COUNT(S.CONTRACT_ID)
            INTO VALIDATE_NUMBER
            FROM S
           INNER JOIN HV
              ON S.CONTRACT_ID = HV.CONTRACT_ID
           WHERE 1 = 1
                /*AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'*/
             AND S.CONTRACT_ID = V_CONTRACT_ID
          /*AND EXISTS (SELECT 1
           FROM HP
          WHERE HP.CONTRACT_ID = S.CONTRACT_ID
            AND HP.PROJECT_ID = V_PROJECT_ID)*/
          ;
        
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_S IS NULL THEN
              MSG_S := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_S := MSG_S || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        FETCH CU_DATA_HEAD
          INTO VALIDATE_A,
               VALIDATE_B,
               VALIDATE_C,
               VALIDATE_D,
               VALIDATE_E,
               VALIDATE_F,
               VALIDATE_G,
               VALIDATE_H,
               VALIDATE_I,
               VALIDATE_J,
               VALIDATE_K,
               VALIDATE_L,
               VALIDATE_M,
               VALIDATE_N,
               VALIDATE_O,
               VALIDATE_P,
               VALIDATE_Q,
               VALIDATE_R,
               VALIDATE_S,
               VALIDATE_T,
               VALIDATE_U,
               V_DEPT_ID,
               V_USER_ID;
      END LOOP;
      CLOSE CU_DATA_HEAD;
    END IF;
  
    FETCH CU_DATA_LINE
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1;
    WHILE CU_DATA_LINE%FOUND LOOP
      --必填项验证
      IF VALIDATE_A1 IS NULL THEN
        --EBS发票号码是否为空
        IF MSG_A1 IS NULL THEN
          MSG_A1 := CU_DATA_LINE%ROWCOUNT + 1;
        ELSE
          MSG_A1 := MSG_A1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
        END IF;
      END IF;
      /* IF VALIDATE_B1 IS NULL THEN
        IF MSG_B1 IS NULL THEN
          MSG_B1 := CU_DATA_LINE%ROWCOUNT+1;
        ELSE
          MSG_B1 := MSG_B1 || ',' || CU_DATA_LINE%ROWCOUNT+1;
        END IF;
      END IF;
      IF VALIDATE_C1 IS NULL THEN
        IF MSG_C1 IS NULL THEN
          MSG_C1 := CU_DATA_LINE%ROWCOUNT+1;
        ELSE
          MSG_C1 := MSG_C1 || ',' || CU_DATA_LINE%ROWCOUNT+1;
        END IF;
      END IF;*/
      IF VALIDATE_A1 IS NOT NULL THEN
        SELECT DISTINCT (D.P)
          INTO SERVICETYPE
          FROM SPM_IMPORT_TEMP_D D
         WHERE D.A = VALIDATE_A1
           AND D.SHEET_NAME = '发票主信息'
           AND D.TEMP_M_ID = P_BATCHCODE;
      END IF;
      IF SERVICETYPE = '货物' THEN
        IF VALIDATE_B1 IS NULL AND VALIDATE_C1 IS NULL THEN
          IF MSG_B1 IS NULL THEN
            MSG_B1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_B1 := MSG_B1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      IF SERVICETYPE = '服务' THEN
        ---产品类型为服务时 不含税金额是否为空
        IF VALIDATE_D1 IS NULL THEN
          IF MSG_D1 IS NULL THEN
            MSG_D1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_D1 := MSG_D1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      IF VALIDATE_E1 IS NULL THEN
        --摘要是否为空
        IF MSG_E1 IS NULL THEN
          MSG_E1 := CU_DATA_LINE%ROWCOUNT + 1;
        ELSE
          MSG_E1 := MSG_E1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
        END IF;
      END IF;
      /* IF VALIDATE_F1 IS NULL THEN
        IF MSG_F1 IS NULL THEN
          MSG_F1 := CU_DATA_LINE%ROWCOUNT+1;
        ELSE
          MSG_F1 := MSG_F1 || ',' || CU_DATA_LINE%ROWCOUNT+1;
        END IF;
      END IF;*/
    
      -- 行信息 发票号码重复性验证
      /* IF VALIDATE_A1 IS NOT NULL THEN
        SELECT COUNT(1)
          INTO VALIDATE_NUMBER
          FROM SPM_CON_INPUT_INVOICE I
         WHERE I.INVOICE_CODE = VALIDATE_A1;
      
        IF VALIDATE_NUMBER <> 0 THEN
          IF MSG_A1 IS NULL THEN
            MSG_A1 := CU_DATA_LINE%ROWCOUNT+1;
          ELSE
            MSG_A1 := MSG_A1 || ',' || CU_DATA_LINE%ROWCOUNT+1;
          END IF;
        END IF;
      END IF;*/
      --入库单号有效性验证
      IF VALIDATE_C1 IS NOT NULL THEN
        SELECT COUNT(1)
          INTO VALIDATE_NUMBER
          FROM SPM_CON_WAREHOUSE W
         WHERE W.WAREHOUSE_CODE = VALIDATE_C1;
        IF VALIDATE_NUMBER = 0 THEN
          IF MSG_C1 IS NULL THEN
            MSG_C1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_C1 := MSG_C1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      -- 不含税金额数字验证
      IF VALIDATE_D1 IS NOT NULL THEN
        SELECT SPM_CON_UTIL_PKG.IS_NUMBER(VALIDATE_D1, '')
          INTO VALIDATE_NUMBER
          FROM DUAL;
        IF VALIDATE_NUMBER = 1 THEN
          IF VALIDATE_D1 = 0 OR VALIDATE_D1 < 0 THEN
            IF MSG_D2 IS NULL THEN
              MSG_D2 := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_D2 := MSG_D2 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_NUMBER = 0 THEN
          IF MSG_D1 IS NULL THEN
            MSG_D1 := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_D1 := MSG_D1 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      --科目段验证 
      IF VALIDATE_F1 IS NOT NULL THEN
        SELECT COUNT(1)
          INTO KMDNUMBER --科目段值count
          FROM (SELECT V.FLEX_VALUE AS VALUE, V.DESCRIPTION AS NAME
                  FROM FND_FLEX_VALUES_VL V
                 WHERE FLEX_VALUE_SET_ID =
                       (SELECT F.FLEX_VALUE_SET_ID
                          FROM FND_FLEX_VALUE_SETS F
                         WHERE F.FLEX_VALUE_SET_NAME = 'DT 科目')
                   AND V.SUMMARY_FLAG = 'N'
                   AND V.ENABLED_FLAG = 'Y'
                   AND V.END_DATE_ACTIVE IS NULL
                 ORDER BY FLEX_VALUE) KM
         WHERE 1 = 1
           AND KM.NAME = VALIDATE_F1;
        IF KMDNUMBER <> 1 THEN
          IF MSG_F1 IS NULL THEN
            MSG_F1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_F1 := MSG_F1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
    
      FETCH CU_DATA_LINE
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1;
    
    END LOOP;
    CLOSE CU_DATA_LINE;
  
    IF MSG_A IS NOT NULL THEN
      MSG_A := MSG_A || '行 EBS发票号码为空;';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '行 发票代码为空;';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '行 发票号码为空;';
    END IF;
    IF MSG_D IS NOT NULL THEN
      MSG_D := MSG_D || '行 合同编号填写有误;';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '行 合同名称填写有误或与合同编号不对应;';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '行 未找到对应项目;';
    END IF;
    IF MSG_FF IS NOT NULL THEN
      MSG_FF := MSG_FF || '行 未找到对应的无工程;';
    END IF;
    IF MSG_G IS NOT NULL THEN
      MSG_G := MSG_G || '行 单位名称为空或填写有误;';
    END IF;
    IF MSG_H IS NOT NULL THEN
      MSG_H := MSG_H || '行 发票分类为空或填写有误;';
    END IF;
    IF MSG_I IS NOT NULL THEN
      MSG_I := MSG_I || '行 开票时间为空或格式错误;';
    END IF;
    IF MSG_J IS NOT NULL THEN
      MSG_J := MSG_J || '行 摘要为空或填写有误;';
    END IF;
    IF MSG_K IS NOT NULL THEN
      MSG_K := MSG_K || '行 登记时间格式错误;';
    END IF;
    IF MSG_L IS NOT NULL THEN
      MSG_L := MSG_L || '行 供应商填写有误;';
    END IF;
    IF MSG_M IS NOT NULL THEN
      MSG_M := MSG_M || '行 发票金额为空或填写格式有误;';
    END IF;
    IF MSG_N IS NOT NULL THEN
      MSG_N := MSG_N || '行 税率不在具体值，即（0,3,5,10,11,16,17）范围内;';
    END IF;
    IF MSG_N1 IS NOT NULL THEN
      MSG_N1 := MSG_N1 || '行 发票类型为增值税专用发票时，不允许税率为0;';
    END IF;
    IF MSG_N2 IS NOT NULL THEN
      MSG_N2 := MSG_N2 || '行 发票类型为其他时，税率只允许为0;';
    END IF;
    IF MSG_O IS NOT NULL THEN
      MSG_O := MSG_O || '行 税额为空或填写格式有误;';
    END IF;
    IF MSG_P IS NOT NULL THEN
      MSG_P := MSG_P || '行 产品类型为空;';
    END IF;
    IF MSG_P1 IS NOT NULL THEN
      MSG_P1 := MSG_P1 || '行 产品类型只能为服务或货物;';
    END IF;
    IF MSG_Q IS NOT NULL THEN
      MSG_Q := MSG_Q || '行 不含税差异填写格式有误;';
    END IF;
    IF MSG_R IS NOT NULL THEN
      MSG_R := MSG_R || '行 未找到对应的核算部门;';
    END IF;
    IF MSG_S IS NOT NULL THEN
      MSG_S := MSG_S || '行 合同、项目与供应商的关联关系不对应;';
    END IF;
  
    --行信息  
    IF MSG_A1 IS NOT NULL THEN
      MSG_A1 := MSG_A1 || '行 发票号码为空或填写有误;';
    END IF;
    /* IF MSG_B1 IS NOT NULL THEN
      MSG_B1 := MSG_B1 || '行 货物或服务名称为空或填写有误;';
    END IF;*/
    IF MSG_B1 IS NOT NULL THEN
      MSG_B1 := MSG_B1 || '行 产品类型为货物时，合同（订单）编号、入库单号两者不能全为空;';
    END IF;
    IF MSG_C1 IS NOT NULL THEN
      MSG_C1 := MSG_C1 || '行 入库单号填写有误;';
    END IF;
    IF MSG_D1 IS NOT NULL THEN
      MSG_D1 := MSG_D1 || '行 不含税金额为空或填写格式有误;';
    END IF;
    IF MSG_D2 IS NOT NULL THEN
      MSG_D2 := MSG_D2 || '行 不含税金额不允许为0或负值;';
    END IF;
    IF MSG_E1 IS NOT NULL THEN
      MSG_E1 := MSG_E1 || '行 摘要为空或填写有误;';
    END IF;
    IF MSG_F1 IS NOT NULL THEN
      MSG_F1 := MSG_F1 || '行 科目段填写有误;';
    END IF;
  
    P_MSG_H := P_MSG_H || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E ||
               MSG_F || MSG_FF || MSG_G || MSG_H || MSG_I || MSG_J || MSG_K ||
               MSG_L || MSG_M || MSG_N || MSG_N1 || MSG_N2 || MSG_O ||
               MSG_P || MSG_P1 || MSG_Q || MSG_R || MSG_S;
  
    P_MSG_L := P_MSG_L || MSG_A1 || MSG_B1 || MSG_C1 || MSG_D1 || MSG_D2 ||
               MSG_E1 || MSG_F1;
  
    IF P_MSG_H = '头表' THEN
      P_MSG_H := NULL;
    END IF;
  
    IF P_MSG_L = '行表' THEN
      P_MSG_L := NULL;
    END IF;
  
    P_MSG := P_MSG_H || P_MSG_L;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END BATCH_INPUT_VALIDATE;

  -- 进项发票导入
  PROCEDURE BATCH_INPUT_IMPORT(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               F_TABLENAME VARCHAR2,
                               F_TABLEID   VARCHAR2,
                               P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA_HEAD IS
      SELECT TRIM(A),
             TRIM(MAX(B)),
             TRIM(MAX(C)),
             TRIM(MAX(D)),
             TRIM(MAX(E)),
             TRIM(MAX(F)),
             TRIM(MAX(G)),
             TRIM(MAX(H)),
             TRIM(MAX(I)),
             TRIM(MAX(J)),
             TRIM(MAX(K)),
             TRIM(MAX(L)),
             TRIM(SUM(M)),
             TRIM(MAX(N)),
             TRIM(SUM(O)),
             TRIM(MAX(P)),
             TRIM(MAX(Q)),
             TRIM(MAX(R)),
             TRIM(MAX(S)),
             TRIM(MAX(T)),
             TRIM(MAX(U)),
             TRIM(MAX(V)),
             TRIM(MAX(W))
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 3
         AND SHEET_NAME = '发票主信息'
       GROUP BY TRIM(A);
    -- ORDER BY TO_NUMBER(ROW_NUMBER);
    CURSOR CU_DATA_LINE IS
      SELECT TRIM(A),
             TRIM(MAX(B)),
             TRIM(MAX(C)),
             TRIM(SUM(D)),
             TRIM(MAX(E)),
             TRIM(MAX(F)),
             TRIM(MAX(G)),
             TRIM(MAX(H))
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 3
         AND SHEET_NAME = '发票行信息'
       GROUP BY TRIM(A);
    --ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A  VARCHAR2(2000);
    VALIDATE_B  VARCHAR2(2000);
    VALIDATE_C  VARCHAR2(2000);
    VALIDATE_D  VARCHAR2(2000);
    VALIDATE_E  VARCHAR2(2000);
    VALIDATE_F  VARCHAR2(2000);
    VALIDATE_G  VARCHAR2(2000);
    VALIDATE_H  VARCHAR2(2000);
    VALIDATE_I  VARCHAR2(2000);
    VALIDATE_J  VARCHAR2(2000);
    VALIDATE_K  VARCHAR2(2000);
    VALIDATE_L  VARCHAR2(2000);
    VALIDATE_M  VARCHAR2(2000);
    VALIDATE_N  VARCHAR2(2000);
    VALIDATE_O  VARCHAR2(2000);
    VALIDATE_P  VARCHAR2(2000);
    VALIDATE_Q  VARCHAR2(2000);
    VALIDATE_R  VARCHAR2(2000);
    VALIDATE_S  VARCHAR2(2000);
    VALIDATE_T  VARCHAR2(2000);
    VALIDATE_U  VARCHAR2(2000);
    VALIDATE_V  VARCHAR2(2000);
    VALIDATE_W  VARCHAR2(2000);
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
  
    VALIDATE_NUMBER NUMBER;
    --记录符合条件的合同，项目，客户(供应商)
    V_CONTRACT_ID           NUMBER(15);
    V_PROJECT_ID            NUMBER(15);
    V_CUST_ID               NUMBER(15);
    V_VENDOR_ID             NUMBER(15);
    V_VENDOR_SITE_ID        NUMBER(15); --供应商地点id
    V_GYSID                 NUMBER(15); --供应商地点
    V_USER_ID               NUMBER(15);
    V_DEPT_ID               NUMBER(15);
    V_PERSON_ID             NUMBER(15); --
    V_INVOICE_SERIAL_NUMBER VARCHAR2(100);
    V_INVOICETYPE           VARCHAR2(5); --发票分类
    INVOICETAXAMOUNT        NUMBER; --不含税金额 （总金额）
    WHAMOUNTMONEY           NUMBER; --入库单下的不含税金额 
    NOTAXDIF                NUMBER; --不含税差异
    NOCONTRACT              VARCHAR2(2);
    V_INPUT_INVOICE_ID      NUMBER(15); --进项发票主键
    CONTRACTID              NUMBER(15);
    WAREHOUSEID             NUMBER(15);
    EBSDEPTCODE             VARCHAR2(40); --核算部门code
    PAYMENTSTATUS           VARCHAR2(40); --付款情况
    SERVICETYPE             VARCHAR2(40); --产品类型
    DEPTSEC                 VARCHAR2(40); --部门段 
    SUBSEC                  VARCHAR2(40); --科目段
    DEALINGSSEC             VARCHAR2(40); --往来段
    PROJECTSEC              VARCHAR2(40); --项目段
    PRODUCTSEC              VARCHAR2(40); --产品段
    VENDORNAME              VARCHAR2(200); --单位名称
    PROJECTNAME             VARCHAR2(200); --项目名称
  BEGIN
    OPEN CU_DATA_HEAD;
    FETCH CU_DATA_HEAD
      INTO VALIDATE_A,
           VALIDATE_B,
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E,
           VALIDATE_F,
           VALIDATE_G,
           VALIDATE_H,
           VALIDATE_I,
           VALIDATE_J,
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           VALIDATE_N,
           VALIDATE_O,
           VALIDATE_P,
           VALIDATE_Q,
           VALIDATE_R,
           VALIDATE_S,
           VALIDATE_T,
           VALIDATE_U,
           V_DEPT_ID,
           V_USER_ID;
  
    OPEN CU_DATA_LINE;
    FETCH CU_DATA_LINE
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           V_DEPT_ID,
           V_USER_ID;
    WHILE CU_DATA_HEAD%FOUND LOOP
    
      --BEGIN
    
      /* SELECT NAMEC, MEDICINEMODEL, OUTLOOKC, MEMO2
       FROM (SELECT NAMEC, MEDICINEMODEL, OUTLOOKC, MEMO2
               FROM 表名
              GROUP BY NAMEC, MEDICINEMODEL, OUTLOOKC, MEMO2
              ORDER BY BIDPRICE)
      WHERE ROWNUM = 1;*/
      IF VALIDATE_D IS NOT NULL AND VALIDATE_E IS NOT NULL THEN
        --合同
        SELECT C.CONTRACT_ID
          INTO V_CONTRACT_ID --
          FROM SPM_CON_HT_INFO C
         WHERE 1 = 1
           AND C.STATUS = 'E'
           AND C.STATUS_CHANGE = '1'
           AND C.CONTRACT_NAME = VALIDATE_E
           AND C.CONTRACT_CODE = VALIDATE_D;
      ELSE
        V_CONTRACT_ID := '';
      END IF;
    
      IF VALIDATE_F IS NOT NULL THEN
        --项目验证是否存在
        SELECT P.PROJECT_ID
          INTO V_PROJECT_ID
          FROM SPM_CON_PROJECT P
         WHERE P.PROJECT_NAME = VALIDATE_F
           AND P.STATUS = 'E'
           AND P.EBS_STATUS = 'S';
      ELSE
        SELECT P.PROJECT_ID
          INTO V_PROJECT_ID
          FROM SPM_CON_PROJECT P
         WHERE P.PROJECT_NAME LIKE '%无工程-%'
           AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
      END IF;
      -- 供应商名称转换成id
      SELECT VI.VENDOR_ID
        INTO V_VENDOR_ID
        FROM SPM_CON_VENDOR_INFO VI
       WHERE 1 = 1
         AND VI.VENDOR_NAME = VALIDATE_G
         AND VI.STATUS = 'E';
    
      IF VALIDATE_L IS NOT NULL THEN
        --供应商地点ID
        SELECT T.VENDOR_SITE_ID
          INTO V_GYSID
          FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
         WHERE 1 = 1
           AND T.ORG_ID = SPM_SSO_PKG.GETORGID
           AND T.VENDOR_ID = PP.VENDOR_ID
           AND PP.ENABLED_FLAG = 'Y'
           AND T.PURCHASING_SITE_FLAG = 'Y'
           AND T.PAY_SITE_FLAG = 'Y'
           AND T.VENDOR_SITE_CODE = VALIDATE_L
           AND PP.VENDOR_NAME = VALIDATE_G
           AND ROWNUM = 1;
        V_VENDOR_SITE_ID := V_GYSID;
      ELSE
        SELECT T.VENDOR_SITE_ID
          INTO V_GYSID
          FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
         WHERE 1 = 1
           AND T.ORG_ID = SPM_SSO_PKG.GETORGID
           AND T.VENDOR_ID = PP.VENDOR_ID
           AND PP.ENABLED_FLAG = 'Y'
           AND T.PURCHASING_SITE_FLAG = 'Y'
           AND T.PAY_SITE_FLAG = 'Y'
           AND T.VENDOR_SITE_CODE = '商品采购'
           AND PP.VENDOR_NAME = VALIDATE_G
           AND ROWNUM = 1;
        V_VENDOR_SITE_ID := V_GYSID;
      END IF;
      --判断发票类型   
      IF VALIDATE_H = '增值税专用发票' THEN
        V_INVOICETYPE := 'A';
      ELSIF VALIDATE_H = '增值税普通发票' THEN
        V_INVOICETYPE := 'B';
      ELSE
        V_INVOICETYPE := 'C';
      END IF;
      --判断产品类型
      IF VALIDATE_P = '服务' THEN
        PAYMENTSTATUS := 'F';
        NOTAXDIF      := '';
        --不含税金额计算
        SELECT VALIDATE_M - VALIDATE_O INTO INVOICETAXAMOUNT FROM DUAL; --发票金额-税额-不含税差异
      ELSE
        --货物类
        PAYMENTSTATUS := 'Y';
        IF VALIDATE_Q IS NULL THEN
          NOTAXDIF := 0;
        ELSE
          NOTAXDIF := VALIDATE_Q;
        END IF;
        --不含税金额计算
        SELECT VALIDATE_M - VALIDATE_O - NOTAXDIF
          INTO INVOICETAXAMOUNT
          FROM DUAL; --发票金额-税额-不含税差异
      END IF;
      --如果登记时间为空 取系统当前时间
      IF VALIDATE_K IS NULL THEN
        VALIDATE_K := SYSDATE;
      END IF;
      --是否无合同
      IF VALIDATE_D IS NULL THEN
        NOCONTRACT := 'Y';
      ELSE
        NOCONTRACT := '';
      END IF;
      --根据登录人userid 获取personid 
      SELECT T.PERSON_ID
        INTO V_PERSON_ID
        FROM SPM_EAM_ALL_PEOPLE_V T
       WHERE T.USER_ID = V_USER_ID;
      --核算部门
      IF VALIDATE_R IS NOT NULL THEN
        SELECT FLEX_VALUE
          INTO EBSDEPTCODE
          FROM FND_FLEX_VALUES_VL V
         WHERE FLEX_VALUE_SET_ID =
               (SELECT F.FLEX_VALUE_SET_ID
                  FROM FND_FLEX_VALUE_SETS F
                 WHERE F.FLEX_VALUE_SET_NAME = 'DT 部门')
           AND V.ENABLED_FLAG = 'Y'
           AND DESCRIPTION = VALIDATE_R;
      ELSE
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
      END IF;
    
      --插入数据
      INSERT INTO SPM_CON_INPUT_INVOICE
        (INPUT_INVOICE_ID, --进项发票管理主键
         VENDOR_ID, --供应商id
         INVOICE_CONTENT, --摘要
         INVOICE_TYPE, --发票类型
         INVOICE_CODE, --发票号码
         INVOICE_AMOUNT, --发票金额
         CURRENCY_TYPE, --发票金额币种
         PROJECT_ID, --关联项目ID
         CONTRACT_ID, --关联合同ID       
         VERIFIC_IMPREST_AMOUNT, --核销预付款金额
         CREATED_BY, --登记经办人
         CREATION_DATE, --登记日期
         LAST_UPDATE_DATE, -- 最后修改时间     
         STATUS, --审批状态
         ORG_ID, --所属机构ID
         DEPT_ID, --所属部门ID
         RESIDUAL_AMOUNT, --剩余金额
         BILLING_DATE, --开票日期
         PAYMENT_TERM, --付款条件
         PAYMENT_TYPE, --付款方式
         VENDOR_SITE_ID, --供应商地点ID
         TAX_AMOUNT, --税额
         INVOICETAX_AMOUNT, --总金额 不含税金额
         TAX_RATE, --税率
         NO_TAX_DIF, --不含税差异金额
         NO_CONTRACT, --是否无合同
         EBS_DEPT_CODE, --核算部门code
         PAYMENT_STATUS, --付款情况        
         EBS_STATUS, --EBS同步状态
         EBS_TYPE --发票类型EBS
         )
      VALUES
        (SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL,
         V_VENDOR_ID, --供应商id
         VALIDATE_J, --摘要        
         V_INVOICETYPE, --发票分类
         VALIDATE_A, --EBS发票号码
         ROUND(VALIDATE_M, 2), --发票金额
         'CNY', --发票金额币种
         V_PROJECT_ID, --关联项目ID
         V_CONTRACT_ID, --关联合同ID
         0, -- --核销预付款金额
         V_USER_ID, --登记经办人  
         SYSDATE,
         --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--登记日期 
         SYSDATE, --最后修改时间
         'A', --审批状态
         SPM_SSO_PKG.GETORGID, --所属机构ID
         V_DEPT_ID, --所属部门ID
         ROUND(VALIDATE_M, 2), --剩余金额        
         TO_DATE(SUBSTR(VALIDATE_I, 1, 10), 'yyyy-mm-dd'), --开票日期
         '10000', --付款条件
         'WIRE', --付款方式
         V_VENDOR_SITE_ID, --供应商地点ID
         ROUND(VALIDATE_O, 2), --税额
         ROUND(INVOICETAXAMOUNT, 2), --总金额 不含税金额
         VALIDATE_N, --税率
         NOTAXDIF, --0, --不含税差异金额
         NOCONTRACT, --是否无合同
         EBSDEPTCODE, --核算部门
         PAYMENTSTATUS, --付款情况
         'N', --EBS同步状态
         'STANDARD' --发票类型EBS
         );
    
      FETCH CU_DATA_HEAD
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F,
             VALIDATE_G,
             VALIDATE_H,
             VALIDATE_I,
             VALIDATE_J,
             VALIDATE_K,
             VALIDATE_L,
             VALIDATE_M,
             VALIDATE_N,
             VALIDATE_O,
             VALIDATE_P,
             VALIDATE_Q,
             VALIDATE_R,
             VALIDATE_S,
             VALIDATE_T,
             VALIDATE_U,
             V_DEPT_ID,
             V_USER_ID;
    END LOOP;
    CLOSE CU_DATA_HEAD;
    COMMIT;
  
    /* FETCH CU_DATA_LINE
    INTO VALIDATE_A1,
         VALIDATE_B1,
         VALIDATE_C1,
         VALIDATE_D1,
         VALIDATE_E1,
         V_DEPT_ID,
         V_USER_ID;*/
    WHILE CU_DATA_LINE%FOUND LOOP
    
      --关联进项发票ID
      SELECT I.INPUT_INVOICE_ID
        INTO V_INPUT_INVOICE_ID
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INVOICE_CODE = VALIDATE_A1
         AND I.ORG_ID = SPM_SSO_PKG.GETORGID;
      --如果合同（订单）编号 不为空时  根据合同编号先查到合同id  再根据合同id 去入库单表里查入库单id
      IF VALIDATE_B1 IS NOT NULL AND VALIDATE_C1 IS NULL THEN
        SELECT HT.CONTRACT_ID
          INTO CONTRACTID
          FROM SPM_CON_HT_INFO HT
         WHERE HT.CONTRACT_CODE = VALIDATE_B1;
      
        SELECT WH.WAREHOUSE_ID
          INTO WAREHOUSEID
          FROM SPM_CON_WAREHOUSE WH
         WHERE WH.CONTRACT_ID = CONTRACTID;
      ELSIF VALIDATE_C1 IS NOT NULL THEN
        --如果入库单号不为空 根据入库单号查询入库单id 
        SELECT WH.WAREHOUSE_ID
          INTO WAREHOUSEID
          FROM SPM_CON_WAREHOUSE WH
         WHERE WH.WAREHOUSE_CODE = VALIDATE_C1;
      ELSIF VALIDATE_B1 IS NULL AND VALIDATE_C1 IS NULL THEN
        WAREHOUSEID := '';
      END IF;
      --如果入库单号不为空,根据入库单号查询不含税金额（入库金额）
      IF VALIDATE_C1 IS NOT NULL AND VALIDATE_D1 IS NULL THEN
        SELECT WH.WAREHOUSE_AMOUNT_MONEY
          INTO WHAMOUNTMONEY
          FROM SPM_CON_WAREHOUSE WH
         WHERE WH.WAREHOUSE_CODE = VALIDATE_C1;
      ELSE
        WHAMOUNTMONEY := VALIDATE_D1;
      END IF;
    
      IF VALIDATE_A1 IS NOT NULL THEN
        SELECT DISTINCT (D.P), (D.G), (D.F)
          INTO SERVICETYPE, VENDORNAME, PROJECTNAME --产品类型
          FROM SPM_IMPORT_TEMP_D D
         WHERE D.A = VALIDATE_A1
           AND D.SHEET_NAME = '发票主信息'
           AND D.TEMP_M_ID = P_BATCHCODE;
      END IF;
      IF SERVICETYPE = '货物' THEN
        DEPTSEC     := '';
        SUBSEC      := '';
        DEALINGSSEC := '';
        PROJECTSEC  := '';
        PRODUCTSEC  := '';
      END IF;
      IF SERVICETYPE = '服务' THEN
        PRODUCTSEC := '00';
        --根据登录人userid 获取personid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --获取部门段
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO DEPTSEC
          FROM DUAL;
        IF DEPTSEC IS NULL THEN
          DEPTSEC := '00';
        END IF;
        --获取往来段
        SELECT V.VALUE
          INTO DEALINGSSEC
          FROM (SELECT FLEX_VALUE AS VALUE, DESCRIPTION AS NAME
                  FROM FND_FLEX_VALUES_VL
                 WHERE FLEX_VALUE_SET_ID =
                       (SELECT F.FLEX_VALUE_SET_ID
                          FROM FND_FLEX_VALUE_SETS F
                         WHERE F.FLEX_VALUE_SET_NAME = 'DT 往来')
                 ORDER BY FLEX_VALUE) V
         WHERE 1 = 1
           AND (V.NAME = VENDORNAME); -- OR V.VALUE = '00')
        IF DEALINGSSEC IS NULL THEN
          DEALINGSSEC := '00';
        END IF;
        --获取项目段
        IF PROJECTNAME IS NOT NULL THEN
          SELECT V.VALUE
            INTO PROJECTSEC
            FROM (SELECT D.项目编号 AS VALUE, D.项目名称 AS NAME
                    FROM DT_PROJECT D) V
           WHERE 1 = 1
             AND V.NAME = PROJECTNAME;
        ELSE
          SELECT P.PROJECT_CODE
            INTO PROJECTSEC
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '%无工程-%'
             AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
        END IF;
        --获取科目段
        IF VALIDATE_F1 IS NOT NULL THEN
          SELECT KM.VALUE
            INTO SUBSEC
            FROM (SELECT V.FLEX_VALUE AS VALUE, V.DESCRIPTION AS NAME
                    FROM FND_FLEX_VALUES_VL V
                   WHERE FLEX_VALUE_SET_ID =
                         (SELECT F.FLEX_VALUE_SET_ID
                            FROM FND_FLEX_VALUE_SETS F
                           WHERE F.FLEX_VALUE_SET_NAME = 'DT 科目')
                     AND V.SUMMARY_FLAG = 'N'
                     AND V.ENABLED_FLAG = 'Y'
                     AND V.END_DATE_ACTIVE IS NULL
                   ORDER BY FLEX_VALUE) KM
           WHERE 1 = 1
             AND KM.NAME = VALIDATE_F1;
        ELSE
          SUBSEC := '00';
        END IF;
      END IF;
      INSERT INTO SPM.SPM_CON_INPUT_WAREHOUSE
        (INPUT_WAREHOUSE_ID, --主键
         INPUT_INVOICE_ID, --进项发票主键
         WAREHOUSE_ID, --入库单关联ID
         CREATED_BY, --创建人
         CREATION_DATE, --创建时间
         LAST_UPDATE_DATE, --最后修改时间
         ORG_ID, --所属机构id
         DEPT_ID, --所属部门ID
         REMARK, --摘要        
         MONEY_AMOUNT, --行金额  不含税金额
         DEPT_SEC, --部门段
         SUB_SEC, --科目段
         DEALINGS_SEC, --往来段
         PROJECT_SEC, --项目段
         PRODUCT_SEC --产品段
         )
      VALUES
        (SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL, --主键
         V_INPUT_INVOICE_ID, --进项发票主键
         WAREHOUSEID, --入库单关联ID
         V_USER_ID, --创建人
         SYSDATE, --创建时间
         SYSDATE, ----最后修改时间
         SPM_SSO_PKG.GETORGID, --所属机构id
         V_DEPT_ID, --所属部门ID
         VALIDATE_E1, --摘要
         ROUND(WHAMOUNTMONEY, 2), --行金额  不含税金额  
         DEPTSEC, --部门段
         SUBSEC, --科目段
         DEALINGSSEC, --往来段
         PROJECTSEC, --项目段
         PRODUCTSEC --产品段              
         );
      FETCH CU_DATA_LINE
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             V_DEPT_ID,
             V_USER_ID;
    END LOOP;
    CLOSE CU_DATA_LINE;
    COMMIT;
  
  END BATCH_INPUT_IMPORT;

  /*采购订单发票信息保存至消息中间表*/
  PROCEDURE SPM_CON_SYNC_INVOICEINFO(V_ID             IN VARCHAR2,
                                     V_MSG            IN CLOB,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    V_CREATEDBY         NUMBER(15);
    V_CREATION_DATE     VARCHAR2(200);
    V_LAST_UPDATED_BY   NUMBER(15);
    V_LAST_UPDATE_DATE  VARCHAR2(200);
    V_LAST_UPDATE_LOGIN NUMBER(15);
    V_ORG_ID            NUMBER(15);
    V_DEPT_ID           NUMBER(15);
    V_CONFIGURE_ID      NUMBER(15); --配置表id
    V_REPEAT            VARCHAR2(20);
  
  BEGIN
    --去重验证 ：为Y 无重复
    V_REPEAT := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_INPUT_INVOICE',
                                                      'POINVOICESYNC',
                                                      V_ID);
    IF V_REPEAT <> 'Y' THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '存在重复性信息，无法插入到中间表';
      RETURN;
    END IF;
    SELECT I.CREATED_BY,
           I.CREATION_DATE,
           I.LAST_UPDATED_BY,
           I.LAST_UPDATE_DATE,
           I.LAST_UPDATE_LOGIN,
           I.ORG_ID,
           I.DEPT_ID
      INTO V_CREATEDBY,
           V_CREATION_DATE,
           V_LAST_UPDATED_BY,
           V_LAST_UPDATE_DATE,
           V_LAST_UPDATE_LOGIN,
           V_ORG_ID,
           V_DEPT_ID
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = V_ID;
  
    --配置表ID查询
    V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('POINVOICEINFO');
    INSERT INTO SPM.SPM_CON_MQ_MESSAGE
      (MESSAGE_ID, --消息表ID
       CONFIGURE_ID, --配置表ID
       BUSINESS_NAME, --业务表
       BUSINESS_CHARAC, --业务标识
       BUSINESS_ID, --业务ID
       MESSAGE_CONTENT, --消息内容
       CREATED_BY, --创建人
       CREATION_DATE, --创建日期
       LAST_UPDATED_BY, --修改人        
       LAST_UPDATE_DATE, --修改日期
       LAST_UPDATE_LOGIN, --LOGIN
       ORG_ID, --所属组织id
       DEPT_ID, --所属部门id
       REMARK --备注       
       )
    VALUES
      (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL, --主键
       --V_CONFIGURE_ID, --配置表id
       122,
       'SPM_CON_INPUT_INVOICE', --业务表
       'POINVOICESYNC', --业务标识
       V_ID, --业务id
       V_MSG, ----消息内容
       V_CREATEDBY, --创建人
       V_CREATION_DATE, --创建日期
       V_LAST_UPDATED_BY, --修改人
       V_LAST_UPDATE_DATE, --修改日期
       V_LAST_UPDATE_LOGIN, --login
       V_ORG_ID, --所属组织id
       V_DEPT_ID, --所属部门id       
       '采购订单发票信息同步' --备注                    
       );
    COMMIT;
    V_RETURN_CODE    := 'S';
    V_RETURN_MESSAGE := '插入中间表成功';
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '插入中间表出现异常，请联系管理员';
      RETURN;
  END;
  --END SPM_CON_SYNC_INVOICEINFO;

  /*根据采购订单生成进项发票*/
  PROCEDURE CREATE_INPUT_INVOICE(V_IDS         IN VARCHAR2,
                                 V_RETURN_CODE OUT VARCHAR2,
                                 V_RETURN_MSG  OUT VARCHAR2) IS
    IDS              SPM_TYPE_TBL;
    V_CODE           VARCHAR2(40);
    V_USER_ID        NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID         NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID        NUMBER;
    V_INVOICECODE    VARCHAR2(40); --发票号码
    EBSDEPTCODE      VARCHAR2(40); --核算部门code
    V_TAXRATE        VARCHAR2(40); --税率
    V_PERSON_ID      NUMBER(15); --
    V_VENDOR_SITE_ID NUMBER(15); --供应商地点id
    V_CONTRACT_ID    NUMBER(15);
    V_PROJECT_ID     NUMBER(15);
    V_VENDOR_ID      NUMBER(15);
    V_VENDORNAME     VARCHAR2(40);
    INVOICETAXAMOUNT NUMBER; --不含税金额 （总金额）
    V_TAXAMOUNT      NUMBER; --税额
    V_INVOICEAMOUNT  NUMBER; --发票金额
    V_NUMBER1        NUMBER;
    V_CODE_PRE       VARCHAR2(40);
  BEGIN
    -- 部门信息
    SELECT T.ORGANIZATION_ID
      INTO V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = 89 --V_ORG_ID
       AND T.PERSON_ID = SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(1851); --V_USER_ID);
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_INPUT_CODE');
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        SELECT M.CONTRACT_CODE
          INTO V_CODE
          FROM SPM_CON_HT_INFO M
         WHERE M.CONTRACT_ID = IDS(I);
        --获取合同id 项目id 供应商id 供应商名称 税率
        SELECT H.CONTRACT_ID,
               P.PROJECT_ID,
               M.MERCHANTS_ID,
               H.VENDOR_NAME,
               H.TAX_RATE
          INTO V_CONTRACT_ID,
               V_PROJECT_ID,
               V_VENDOR_ID,
               V_VENDORNAME,
               V_TAXRATE
          FROM SPM_CON_HT_INFO H
          LEFT JOIN SPM_CON_HT_PROJECT P
            ON H.CONTRACT_ID = P.CONTRACT_ID
          LEFT JOIN SPM_CON_HT_MERCHANTS M
            ON M.CONTRACT_ID = H.CONTRACT_ID
         WHERE 1 = 1
           AND H.CONTRACT_ID = IDS(I)
           AND H.ONLINE_RETAILERS = 'DSCG'
           AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(H.CONTRACT_ID) = 'Y'
           AND M.IN_OUT_TYPE = '2';
        --根据流水号规则生成发票号码 
        V_INVOICECODE := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_INPUT_INVOICE',
                                                            'INVOICE_CODE',
                                                            'FM000000',
                                                            V_CODE_PRE);
      
        --根据登录人userid 获取personid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --核算部门                         
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
        --供应商地点
        /* SELECT T.VENDOR_SITE_ID
         INTO V_VENDOR_SITE_ID
         FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
        WHERE 1 = 1
          AND T.ORG_ID = 89--SPM_SSO_PKG.GETORGID
          AND T.VENDOR_ID = PP.VENDOR_ID
          AND PP.ENABLED_FLAG = 'Y'
          AND T.PURCHASING_SITE_FLAG = 'Y'
          AND T.PAY_SITE_FLAG = 'Y'
          AND T.VENDOR_SITE_CODE = '商品采购'
          AND PP.VENDOR_NAME = V_VENDORNAME
          AND ROWNUM = 1;*/
      
        --查询入库单下不含税金额  
        --先判断订单下是否有入库单 
        SELECT COUNT(E.WAREHOUSE_AMOUNT_MONEY)
          INTO V_NUMBER1
          FROM SPM_CON_WAREHOUSE E
         WHERE 1 = 1
           AND NOT EXISTS (SELECT H.WAREHOUSE_ID
                  FROM SPM_CON_INPUT_WAREHOUSE H
                 WHERE H.WAREHOUSE_ID = E.WAREHOUSE_ID)
           AND E.ATTRIBUTE5 = 'Y'
           AND NVL(E.ATTRIBUTE2, 'N') <> '1'
           AND E.STATUS = 'E'
           AND SPM_CON_CONTRACT_PKG.SPM_CON_DATAPERMISSION_DEPT(E.DEPT_ID) = 'Y'
           AND E.ORG_ID = SPM_SSO_PKG.GETORGID
           AND E.VENDOR_ID = V_VENDOR_ID
           AND E.CONTRACT_ID = V_CONTRACT_ID
           AND E.PROJECT_ID = V_PROJECT_ID;
      
        IF V_NUMBER1 > 0 THEN
          --有入库单
          SELECT E.WAREHOUSE_AMOUNT_MONEY
            INTO INVOICETAXAMOUNT
            FROM SPM_CON_WAREHOUSE E
           WHERE 1 = 1
             AND NOT EXISTS (SELECT H.WAREHOUSE_ID
                    FROM SPM_CON_INPUT_WAREHOUSE H
                   WHERE H.WAREHOUSE_ID = E.WAREHOUSE_ID)
             AND E.ATTRIBUTE5 = 'Y'
             AND NVL(E.ATTRIBUTE2, 'N') <> '1'
             AND E.STATUS = 'E'
             AND SPM_CON_CONTRACT_PKG.SPM_CON_DATAPERMISSION_DEPT(E.DEPT_ID) = 'Y'
             AND E.ORG_ID = SPM_SSO_PKG.GETORGID
             AND E.VENDOR_ID = V_VENDOR_ID
             AND E.CONTRACT_ID = V_CONTRACT_ID
             AND E.PROJECT_ID = V_PROJECT_ID;
        
          --税额计算
          SELECT TO_NUMBER(INVOICETAXAMOUNT) * TO_NUMBER(V_TAXRATE)
            INTO V_TAXAMOUNT
            FROM DUAL; --不含税金额*税率
          --发票金额计算
          SELECT INVOICETAXAMOUNT + V_TAXAMOUNT
            INTO V_INVOICEAMOUNT
            FROM DUAL; --不含税金额*税率
          /*ELSE 
          V_RETURN_CODE := 'F';
          V_RETURN_MSG := '编号为' || V_CODE || '的合同下未关联入库单不能生成发票';
          RETURN;*/
        END IF;
      
        --插入数据
        INSERT INTO SPM_CON_INPUT_INVOICE
          (INPUT_INVOICE_ID, --进项发票管理主键
           VENDOR_ID, --供应商id
           INVOICE_CONTENT, --摘要
           INVOICE_TYPE, --发票类型
           INVOICE_CODE, --发票号码
           INVOICE_AMOUNT, --发票金额
           CURRENCY_TYPE, --发票金额币种
           PROJECT_ID, --关联项目ID
           CONTRACT_ID, --关联合同ID       
           VERIFIC_IMPREST_AMOUNT, --核销预付款金额
           CREATED_BY, --登记经办人
           CREATION_DATE, --登记日期
           LAST_UPDATE_DATE, -- 最后修改时间     
           STATUS, --审批状态
           ORG_ID, --所属机构ID
           DEPT_ID, --所属部门ID
           RESIDUAL_AMOUNT, --剩余金额
           BILLING_DATE, --开票日期
           PAYMENT_TERM, --付款条件
           PAYMENT_TYPE, --付款方式
           VENDOR_SITE_ID, --供应商地点ID
           TAX_AMOUNT, --税额
           INVOICETAX_AMOUNT, --总金额 不含税金额
           TAX_RATE, --税率
           NO_TAX_DIF, --不含税差异金额
           NO_CONTRACT, --是否无合同
           EBS_DEPT_CODE, --核算部门code
           PAYMENT_STATUS, --付款情况        
           EBS_STATUS, --EBS同步状态
           GL_DATE, --入账日期
           EBS_TYPE --发票类型EBS
           )
        VALUES
          (SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL,
           V_VENDOR_ID, --供应商id
           V_INVOICECODE, --VALIDATE_J, --摘要        
           'A', --V_INVOICETYPE, --发票分类
           V_INVOICECODE, --EBS发票号码
           ROUND(V_INVOICEAMOUNT, 2), --发票金额
           'CNY', --发票金额币种
           V_PROJECT_ID, --关联项目ID
           V_CONTRACT_ID, --关联合同ID
           0, -- --核销预付款金额
           V_USER_ID, --登记经办人                       
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--登记日期 
           SYSDATE, --最后修改时间
           'A', --审批状态
           SPM_SSO_PKG.GETORGID, --所属机构ID
           V_DEPT_ID, --所属部门ID
           ROUND(V_INVOICEAMOUNT, 2), --剩余金额  同发票金额      
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_I, 1, 10), 'yyyy-mm-dd'), --开票日期
           '10000', --付款条件
           'WIRE', --付款方式
           200761, --V_VENDOR_SITE_ID,--供应商地点ID
           ROUND(V_TAXAMOUNT, 2), --税额
           ROUND(INVOICETAXAMOUNT, 2), --总金额 不含税金额
           V_TAXRATE, --税率
           0, --NOTAXDIF, --不含税差异金额
           '', --NOCONTRACT, --是否无合同        
           EBSDEPTCODE, --核算部门         
           'Y', --付款情况
           'N', --EBS同步状态
           SYSDATE, --入账日期
           'STANDARD' --发票类型EBS
           );
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || ',';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CODE;
      END;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      COMMIT;
      V_RETURN_CODE := 'S';
    ELSE
      V_RETURN_MSG := '编号为' || V_RETURN_MSG || '的合同生成发票失败';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行异常';
  END CREATE_INPUT_INVOICE;

  --资金计划额度 从综合查询获取各项值
  FUNCTION SPM_CAPITAL_FIND_AMOUNT(P_PERIOD_YEAR  IN NUMBER, --年份
                                   P_PERIOD_NUM_F IN NUMBER, --月份
                                   P_PERIOD_NUM_T IN NUMBER, --月份
                                   P_KM           IN SPM_TYPE_TBL, --科目                                
                                   P_GS           IN VARCHAR2, --公司段  
                                   DEPTCODE       IN VARCHAR2, --大部门段 
                                   P_VALTYPE      IN VARCHAR2, --取值类型  
                                   ORGID          IN VARCHAR2) RETURN NUMBER IS
    QCYEAMOUNT  NUMBER;
    BQJFAMOUNT  NUMBER;
    BQDFAMOUNT  NUMBER;
    VRETURND    NUMBER;
    VRETURNC    NUMBER;
    V_SMALLCODE SPM_TYPE_TBL;
    BACKAMOUNT  NUMBER;
  BEGIN
    --根据大部门code 查询其下的小部门结果集
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    IF ORGID = 81 THEN
      --本部带部门段     
      SELECT NVL(SUM(GJL.ACCOUNTED_DR), 0), NVL(SUM(GJL.ACCOUNTED_CR), 0)
        INTO VRETURND, VRETURNC
        FROM GL.GL_JE_LINES       GJL,
             GL.GL_JE_HEADERS     GJH,
             APPS.CUX_DIQ_GL_CCID RGC
       WHERE GJL.JE_HEADER_ID = GJH.JE_HEADER_ID
         AND RGC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
         AND GJH.ACTUAL_FLAG = 'A'
         AND RGC.SEG1 = P_GS
         AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
            --AND GJH.CURRENCY_CODE = P_CURRENCY
         AND RGC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY'), 0)) =
             NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM'), 0)) <=
             NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND TO_NUMBER(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM')) >=
             NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GJH.STATUS <> 'P'
         AND GJH.LEDGER_ID = '2021';
      ---期初余额
      SELECT NVL(SUM(NVL(GB.BEGIN_BALANCE_DR, 0)) -
                 SUM(NVL(GB.BEGIN_BALANCE_CR, 0)),
                 0)
        INTO QCYEAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            -- AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM = NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GLC.SEG1 = P_GS
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
      ----本期借方
      SELECT NVL(SUM(NVL(GB.PERIOD_NET_DR, 0)), 0) + VRETURND
        INTO BQJFAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            --AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM >= NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GB.PERIOD_NUM <= NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND GLC.SEG1 = P_GS
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
      ---本期贷方
      SELECT NVL(SUM(NVL(GB.PERIOD_NET_CR, 0)), 0) + VRETURNC
        INTO BQDFAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            -- AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM >= NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GB.PERIOD_NUM <= NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND GLC.SEG1 = P_GS
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
      ------非本部不带部门段
    ELSE
      IF P_VALTYPE = 'REPORTPROFIT' THEN
        SELECT NVL(SUM(GJL.ACCOUNTED_DR), 0), NVL(SUM(GJL.ACCOUNTED_CR), 0)
          INTO VRETURND, VRETURNC
          FROM GL.GL_JE_LINES       GJL,
               GL.GL_JE_HEADERS     GJH,
               APPS.CUX_DIQ_GL_CCID RGC
         WHERE GJL.JE_HEADER_ID = GJH.JE_HEADER_ID
           AND RGC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
           AND GJH.ACTUAL_FLAG = 'A'
           AND RGC.SEG1 = P_GS
              -- AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--小部门段
              --AND GJH.CURRENCY_CODE = P_CURRENCY
           AND RGC.SEG3 LIKE (SELECT COLUMN_VALUE FROM TABLE(P_KM)) || '%' --科目值
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY'), 0)) =
               NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM'), 0)) <=
               NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
           AND TO_NUMBER(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM')) >=
               NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
           AND GJH.STATUS <> 'P'
           AND GJH.LEDGER_ID = '2021';
      ELSE
        SELECT NVL(SUM(GJL.ACCOUNTED_DR), 0), NVL(SUM(GJL.ACCOUNTED_CR), 0)
          INTO VRETURND, VRETURNC
          FROM GL.GL_JE_LINES       GJL,
               GL.GL_JE_HEADERS     GJH,
               APPS.CUX_DIQ_GL_CCID RGC
         WHERE GJL.JE_HEADER_ID = GJH.JE_HEADER_ID
           AND RGC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
           AND GJH.ACTUAL_FLAG = 'A'
           AND RGC.SEG1 = P_GS
              -- AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--小部门段
              --AND GJH.CURRENCY_CODE = P_CURRENCY
           AND RGC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY'), 0)) =
               NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM'), 0)) <=
               NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
           AND TO_NUMBER(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM')) >=
               NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
           AND GJH.STATUS <> 'P'
           AND GJH.LEDGER_ID = '2021';
      END IF;
      ---期初余额
      SELECT NVL(SUM(NVL(GB.BEGIN_BALANCE_DR, 0)) -
                 SUM(NVL(GB.BEGIN_BALANCE_CR, 0)),
                 0)
        INTO QCYEAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            -- AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM = NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GLC.SEG1 = P_GS
            --AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
      ----本期借方
      SELECT NVL(SUM(NVL(GB.PERIOD_NET_DR, 0)), 0) + VRETURND
        INTO BQJFAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            -- AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM >= NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GB.PERIOD_NUM <= NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND GLC.SEG1 = P_GS
            -- AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
      ---本期贷方
      SELECT NVL(SUM(NVL(GB.PERIOD_NET_CR, 0)), 0) + VRETURNC
        INTO BQDFAMOUNT
        FROM APPS.GL_BALANCES GB, APPS.CUX_DIQ_GL_CCID GLC
       WHERE GB.CODE_COMBINATION_ID = GLC.CODE_COMBINATION_ID
            --  AND GLC.SUMMARY_FLAG = 'N'
         AND GB.ACTUAL_FLAG = 'A'
         AND GB.CURRENCY_CODE = 'CNY'
         AND GB.PERIOD_YEAR = NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND GB.PERIOD_NUM >= NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GB.PERIOD_NUM <= NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND GLC.SEG1 = P_GS
            -- AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--小部门段
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --科目值
         AND GB.LEDGER_ID = '2021';
    END IF;
  
    --查询的结果值
    IF P_VALTYPE = 'NONPAYCOST' THEN
      --非付现
      SELECT BQJFAMOUNT - BQDFAMOUNT INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'REPORTPROFITDF' THEN
      --报表利润  贷方     
      SELECT BQDFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'REPORTPROFITJF' THEN
      --报表利润  借方     
      SELECT BQJFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'TAXSYXX' THEN
      --上月销项
      SELECT BQDFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSE
      --上月进项
      SELECT BQJFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    END IF;
    RETURN BACKAMOUNT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END SPM_CAPITAL_FIND_AMOUNT;

  --根据传的班组id 关联查资金额度主键id
  FUNCTION GET_CAPITAL_ID(P_DEPT_ID VARCHAR2) RETURN NUMBER IS
    LAST_RECEIVE_MONTH NUMBER;
    CAPITAL_QUOTA      NUMBER;
    ORGANID            NUMBER(15);
    V_DEPT_CODE        VARCHAR2(20);
    V_CAPITAL_ID       NUMBER(15);
    T_SYSDATE          VARCHAR2(50);
  BEGIN
    -- 获取系统时间
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM') INTO T_SYSDATE FROM DUAL;
    --未配大部门的 暂时查不到V_DEPT_CODE
    SELECT W.ORGANIZATION_ID, W.ATTRIBUTE6
      INTO ORGANID, V_DEPT_CODE
      FROM HR_ALL_ORGANIZATION_UNITS W
     WHERE W.ORGANIZATION_ID = P_DEPT_ID;
    SELECT MIN(P.CAPITAL_ID)
      INTO V_CAPITAL_ID
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.DEPT_CODE = V_DEPT_CODE
       AND P.QUOTA_MONTH = T_SYSDATE;
    RETURN V_CAPITAL_ID;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_CAPITAL_ID;

  --资金计划额度明细 保存数据时 根据用户填的 上会增加额 其他调整额  更新资金计划额度   
  PROCEDURE SPM_CON_CAPITAL_QUOTA_UPDATE(ID NUMBER) AS
  
    V_AMOUNT1          NUMBER;
    V_AMOUNT2          NUMBER;
    V_AMOUNTSUM        NUMBER;
    CAPITALQUOTA       NUMBER;
    THISMONTHBALANCE   NUMBER;
    RECEIVEAMOUNT      NUMBER;
    NONPAYCOST         NUMBER;
    REPORTPROFIT       NUMBER;
    TAXAMOUNT          NUMBER;
    CAPITALBALANCE     NUMBER;
    PAYAMOUNT          NUMBER;
    V_CAPITALQUOTA     NUMBER; --加上明细额度后
    V_THISMONTHBALANCE NUMBER; --加上明细额度后
  BEGIN
    --查出上会增加额的总金额  其他调整额的总金额
    SELECT (NVL((SELECT SUM(ROUND(D.SHADD_AMOUNT, 2))
                  FROM SPM_CON_CAPITAL_PLAN_DEL D
                 WHERE D.CAPITAL_ID = P.CAPITAL_ID),
                0)),
           (NVL((SELECT SUM(ROUND(D.ADJUST_AMOUNT, 2))
                  FROM SPM_CON_CAPITAL_PLAN_DEL D
                 WHERE D.CAPITAL_ID = P.CAPITAL_ID),
                0))
      INTO V_AMOUNT1, V_AMOUNT2
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.CAPITAL_ID = ID;
    --上会总额 加上 其他额总金额  明细表的总金额 
    SELECT V_AMOUNT1 + V_AMOUNT2 INTO V_AMOUNTSUM FROM DUAL;
    --查询主表原来的金额数据
    SELECT P.RECEIVE_AMOUNT,
           P.NON_PAY_COST,
           P.REPORT_PROFIT,
           P.TAX_AMOUNT,
           P.CAPITAL_BALANCE,
           P.PAY_AMOUNT
      INTO RECEIVEAMOUNT,
           NONPAYCOST,
           REPORTPROFIT,
           TAXAMOUNT,
           CAPITALBALANCE,
           PAYAMOUNT
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.CAPITAL_ID = ID;
    --重新计算 资金计划额度 
    SELECT RECEIVEAMOUNT - NONPAYCOST - REPORTPROFIT - TAXAMOUNT +
           CAPITALBALANCE
      INTO CAPITALQUOTA
      FROM DUAL;
    --重新计算 本月结余额
    SELECT CAPITALQUOTA - PAYAMOUNT INTO THISMONTHBALANCE FROM DUAL;
    --加上 明细金额后的 资金计划额度  本月结余额
    SELECT CAPITALQUOTA + V_AMOUNTSUM INTO V_CAPITALQUOTA FROM DUAL;
    SELECT THISMONTHBALANCE + V_AMOUNTSUM
      INTO V_THISMONTHBALANCE
      FROM DUAL;
    --修改资金计划额度
    UPDATE SPM_CON_CAPITAL_PLAN P
       SET P.CAPITAL_QUOTA      = V_CAPITALQUOTA,
           P.THIS_MONTH_BALANCE = V_THISMONTHBALANCE
     WHERE P.CAPITAL_ID = ID;
  END;

  --资金计划额度 复制数据
  PROCEDURE SPM_CAPITAL_COPY_DATA(CAPITALID IN NUMBER,
                                  V_STATUS  OUT VARCHAR2,
                                  V_MESSAGE OUT VARCHAR2) IS
    CAPITALBALANCE     NUMBER; --上月额度余缺
    RECEIVEAMOUNT      NUMBER; --上月收款金额
    NONPAYCOST         NUMBER; --上月非付现成本
    REPORTPROFIT       NUMBER; --上月报表利润
    TAXAMOUNT          NUMBER; --上月应纳税
    CAPITALQUOTA       NUMBER; --资金计划额度
    PAYAMOUNT          NUMBER; --本月付款金额
    THISMONTHBALANCE   NUMBER; --本月结余额
    SYXXAMOUNT         NUMBER; --上月销项金额
    SYJXAMOUNT         NUMBER; --上月进项金额
    EXCHANGEREC        NUMBER; --往来应收金额
    EXCHANGEPAY        NUMBER; --往来应付金额
    V_QUOTAMONTH_LAST  VARCHAR2(10); --上一月 2018-06
    V_QUOTAMONTH       VARCHAR2(10); --当前月 2018-07
    V_MONTHLAST        VARCHAR2(10); --上一月 -06
    V_YEAR             VARCHAR2(10); --当前年 -2018
    FIRSTMONTH         VARCHAR2(20); --上月月初 2018-07-01
    ENDMONTH           VARCHAR2(20); --上月末 2018-07-31
    V_NUMBER1          NUMBER;
    V_NUMBER2          NUMBER;
    V_ORGID            NUMBER(15);
    V_DEPTCODE         VARCHAR2(10);
    V_DEPTID           NUMBER(15);
    V_THISMONTHBALANCE NUMBER; --本月结余额
    V_ORGCODE          VARCHAR2(20);
    V_VALTYPE1         VARCHAR2(50); --取值的类型  非付现
    V_VALTYPE2         VARCHAR2(50); --取值的类型  报表利润
    V_VALTYPE3         VARCHAR2(50); --取值的类型  上月销项
    V_VALTYPE4         VARCHAR2(50); --取值的类型  上月进项
    V_SMALLCODE        SPM_TYPE_TBL := SPM_TYPE_TBL();
    V_KMZH             SPM_TYPE_TBL := SPM_TYPE_TBL(); --非付现成本的科目组合
    V_KMBBLR           SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月报表利润的科目组合
    V_KMYNSXX          SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月应纳税的上月销项科目组合
    V_KMYNSJX          SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月应纳税的上月进项科目组合
  BEGIN
    --根据选中数据的id 查询其他字段数据
    SELECT P.ORG_ID,
           P.DEPT_CODE,
           P.DEPT_ID,
           P.QUOTA_MONTH,
           P.THIS_MONTH_BALANCE
      INTO V_ORGID, V_DEPTCODE, V_DEPTID, V_QUOTAMONTH, V_THISMONTHBALANCE
      FROM SPM_CON_CAPITAL_PLAN P
      LEFT JOIN SPM_CON_CAPITAL_PLAN_DEL D
        ON D.CAPITAL_ID = P.CAPITAL_ID
     WHERE P.CAPITAL_ID = CAPITALID;
    --查询公司段
    SELECT OU.SHORT_CODE
      INTO V_ORGCODE
      FROM HR_OPERATING_UNITS OU
     WHERE OU.ORGANIZATION_ID = V_ORGID;
    --根据大部门code 查询其下的小部门结果集
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(V_DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    --
    SELECT TO_CHAR(SYSDATE, 'yyyy-mm') INTO V_QUOTAMONTH FROM DUAL; --当前年月 2018-07
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL; --上一年月 2018-06
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'mm')
      INTO V_MONTHLAST
      FROM DUAL; --上一月 06*/
    SELECT TO_CHAR(SYSDATE, 'yyyy') INTO V_YEAR FROM DUAL; --当前年 2018
    -- SELECT to_char(sysdate, 'yyyy-mm') INTO V_QUOTAMONTH from dual; 
    -- select to_char(add_months(trunc(sysdate),-1),'yyyy-mm') INTO V_QUOTAMONTH_LAST from dual;
    --上月月初  月末
    SELECT TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -2) + 1, 'yyyy-mm-dd'),
           TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -1), 'yyyy-mm-dd')
      INTO FIRSTMONTH, ENDMONTH
      FROM DUAL;
    --查询该部门本月是否已填报资金计划
    SELECT COUNT(P.CAPITAL_ID)
      INTO V_NUMBER2
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.DEPT_CODE = V_DEPTCODE
       AND P.QUOTA_MONTH = V_QUOTAMONTH;
    IF V_NUMBER2 = 1 THEN
      V_STATUS  := 'ERROR';
      V_MESSAGE := '该部门本月已填报资金计划';
    ELSE
      --查询 上月收款金额  
      IF V_ORGID = 81 THEN
        SELECT NVL(SUM(R.MONEY_AMOUNT), 0) --本部 往来应收
          INTO EXCHANGEREC
          FROM SPM_CON_RECEIPT R
         WHERE R.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND R.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND R.RECEIPT_DEPT IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
           AND R.EBS_STATUS = 'US';
        SELECT NVL(SUM(I.INVOICE_AMOUNT), 0) --本部 往来应付
          INTO EXCHANGEPAY
          FROM SPM_CON_INPUT_INVOICE I
         WHERE I.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND I.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND I.EBS_DEPT_CODE IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
           AND I.MONEY_REG_ID IS NOT NULL
           AND I.EBS_STATUS = 'US';
        SELECT EXCHANGEREC + EXCHANGEPAY INTO RECEIVEAMOUNT FROM DUAL;
        ---
      ELSE
        SELECT NVL(SUM(M.MONEY_ACCOUNT), 0)
          INTO RECEIVEAMOUNT
          FROM SPM_CON_MONEY_REG M
         WHERE M.COLLECTION_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND M.COLLECTION_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
              --AND A.ATTRIBUTE3 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))
           AND M.ORG_ID = V_ORGID;
      END IF;
      IF RECEIVEAMOUNT < 0 THEN
        RECEIVEAMOUNT := 0;
      END IF;
      --查询上月非付现成本金额  
      FOR I IN 1 .. 6 LOOP
        V_KMZH.EXTEND;
      END LOOP;
      V_KMZH(1) := '50010608';
      V_KMZH(2) := '660102';
      V_KMZH(3) := '660202';
      V_KMZH(4) := '50010635';
      V_KMZH(5) := '660203';
      V_KMZH(6) := '660103';
      V_VALTYPE1 := 'NONPAYCOST';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMZH,
                                                         V_ORGCODE,
                                                         V_DEPTCODE,
                                                         V_VALTYPE1,
                                                         V_ORGID)
        INTO NONPAYCOST
        FROM DUAL;
      --查询上月报表利润
      V_KMBBLR.EXTEND;
      V_KMBBLR(1) := '4103';
      V_VALTYPE2 := 'REPORTPROFIT';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMBBLR,
                                                         V_ORGCODE,
                                                         V_DEPTCODE,
                                                         V_VALTYPE2,
                                                         V_ORGID)
        INTO REPORTPROFIT
        FROM DUAL;
      --查询上月应纳税 
      --上月销项      
      V_KMYNSXX.EXTEND;
      V_KMYNSXX(1) := '22210107';
      V_VALTYPE3 := 'TAXSYXX';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMYNSXX,
                                                         V_ORGCODE,
                                                         V_DEPTCODE,
                                                         V_VALTYPE3,
                                                         V_ORGID)
        INTO SYXXAMOUNT
        FROM DUAL;
      --上月进项
      V_KMYNSJX.EXTEND;
      V_KMYNSJX(1) := '2221010101';
      V_VALTYPE4 := 'TAXSHJX';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMYNSJX,
                                                         V_ORGCODE,
                                                         V_DEPTCODE,
                                                         V_VALTYPE4,
                                                         V_ORGID)
        INTO SYJXAMOUNT
        FROM DUAL;
      SELECT SYXXAMOUNT + SYJXAMOUNT INTO TAXAMOUNT FROM DUAL; --计算上月应纳税额
      --计算资金计划额度
      SELECT RECEIVEAMOUNT - NONPAYCOST - REPORTPROFIT - TAXAMOUNT +
             V_THISMONTHBALANCE
        INTO CAPITALQUOTA
        FROM DUAL;
      INSERT INTO SPM_CON_CAPITAL_PLAN
        (CAPITAL_ID,
         CAPITAL_BALANCE, --上月额度余缺
         QUOTA_MONTH, --年月份
         ORG_ID,
         DEPT_CODE,
         DEPT_ID,
         RECEIVE_AMOUNT, --上月收款金额
         NON_PAY_COST, --上月非付现成本
         REPORT_PROFIT, --上月报表利润
         TAX_AMOUNT, --上月应缴纳的增值税
         CAPITAL_QUOTA, --资金计划额度
         QUOTA_YEAR,
         PAY_AMOUNT, --本月付款金额
         THIS_MONTH_BALANCE, --本月结余额
         REMARK)
      VALUES
        (SPM_CON_CAPITAL_PLAN_SEQ.NEXTVAL,
         V_THISMONTHBALANCE,
         V_QUOTAMONTH,
         V_ORGID,
         V_DEPTCODE,
         V_DEPTID,
         RECEIVEAMOUNT,
         NONPAYCOST,
         REPORTPROFIT,
         TAXAMOUNT,
         CAPITALQUOTA,
         '',
         0,
         CAPITALQUOTA,
         '');
      V_STATUS  := 'SUCCESS';
      V_MESSAGE := '操作成功！';
    END IF;
  END SPM_CAPITAL_COPY_DATA;

  --根据扫描发票信息 导入进项发票表
  PROCEDURE INSERT_INPUTINVOICE_INFO(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2,
                                     V_RETURN_MSG  OUT VARCHAR2) IS
    IDS                   SPM_TYPE_TBL;
    V_ID                  NUMBER;
    V_USER_ID             NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID              NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID             NUMBER;
    V_INVOICE_ID          NUMBER(15);
    V_INVOICE_ID_P        NUMBER;
    V_ERROR_MESSAGE       VARCHAR2(4000);
    V_INVOICETYPE         VARCHAR2(10);
    V_INVOICECODE         VARCHAR2(40); --发票号码
    EBSDEPTCODE           VARCHAR2(40); --核算部门code
    V_TAXRATE             NUMBER; --税率
    V_PERSON_ID           NUMBER(15); --
    V_VENDOR_SITE_ID      NUMBER(15); --供应商地点id
    V_CONTRACT_ID         NUMBER(15);
    V_PROJECT_ID          NUMBER(15);
    V_VENDOR_ID           NUMBER(15);
    V_VENDORNAME          VARCHAR2(100);
    INVOICETAXAMOUNT      NUMBER; --不含税金额 （总金额）
    V_TAXAMOUNT           NUMBER; --税额
    V_INVOICEAMOUNT       NUMBER; --发票金额
    V_NUMBER1             NUMBER;
    V_NUMLICODE           NUMBER;
    V_RATENUM             NUMBER;
    V_CODE_PRE            VARCHAR2(40);
    V_BILLING_DATE        VARCHAR2(100); --开票日期
    V_CONTRACT_CODE       VARCHAR2(100);
    V_INVOICE_TYPE        VARCHAR2(100);
    V_INVOICE_RATE_NUMBER VARCHAR2(100); --三证合一码
    L_MONEYAMOUNT         NUMBER; --行信息 不含税金额
    L_TAXRATE             NUMBER; --行信息 税率
    L_TAXAMOUNT           NUMBER; --行信息 税额
    X_ERROR_MSG           VARCHAR2(4000);
  
    CURSOR CUR1(V_CODE VARCHAR2) IS
      SELECT VI.MQ_ID,
             VI.INVOICE_ID,
             VI.CODE,
             VI.INVOICE_NUM,
             VI.CONTRACT_CODE
        FROM SPM_DB_IN_INVOICE_VIEW VI
       WHERE VI.CONTRACT_CODE = V_CODE;
    REC1 CUR1%ROWTYPE;
  
  BEGIN
    -- 部门信息
    SELECT T.ORGANIZATION_ID
      INTO V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = V_ORG_ID
       AND T.PERSON_ID =
           SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(V_USER_ID);
    -- 获取本组织无工程
    SELECT P.PROJECT_ID
      INTO V_PROJECT_ID
      FROM SPM_CON_PROJECT P
     WHERE P.PROJECT_NAME LIKE '无工程-%'
       AND P.ORG_ID = V_ORG_ID;
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_INPUT_CODE');
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        --根据选择的主键mq_id 查询所需信息
        SELECT VI.INVOICE_ID,
               VI.CONTRACT_CODE,
               VI.INVOICE_TYPE,
               VI.VENDOR_NAME,
               VI.INVOICE_RATE_NUMBER,
               TO_CHAR(VI.BILLING_DATE, 'YYYYMMDD')
          INTO V_INVOICE_ID_P,
               V_CONTRACT_CODE,
               V_INVOICE_TYPE,
               V_VENDORNAME,
               V_INVOICE_RATE_NUMBER,
               V_BILLING_DATE
          FROM SPM_DB_IN_INVOICE_VIEW VI
         WHERE VI.MQ_ID = IDS(I);
        SELECT COUNT(V_INVOICE_RATE_NUMBER) INTO V_NUMLICODE FROM DUAL;
        IF V_NUMLICODE = 0 THEN
          V_RETURN_CODE := 'F';
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE || '供应商开票税号信息为空';
          UPDATE SPM_DB_IN_INVOICE_VIEW VI
             SET VI.ATTRIBUTE5 = '供应商开票税号信息为空'
           WHERE VI.CONTRACT_CODE = V_CONTRACT_CODE;
          CONTINUE;
        ELSE
          SELECT TO_NUMBER(SPM_CON_VENDOR_PACKAGE.QUERY_VENDOR_STATUS_BY_CODE(VI.INVOICE_RATE_NUMBER))
            INTO V_VENDOR_ID
            FROM SPM_DB_IN_INVOICE_VIEW VI
           WHERE VI.MQ_ID = IDS(I);
          --V_VENDOR_ID := '99988800';
          IF V_VENDOR_ID < 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '获取供应商“' || V_VENDORNAME || '（' ||
                             V_INVOICE_RATE_NUMBER || '）”数据失败：';
          
            IF V_VENDOR_ID = -1 THEN
              X_ERROR_MSG := X_ERROR_MSG || '电商供应商中间表不存在该条记录，请联系电商推送数据';
            ELSIF V_VENDOR_ID = -2 THEN
              X_ERROR_MSG := X_ERROR_MSG || '尚未生成业务数据';
            ELSIF V_VENDOR_ID = -3 THEN
              X_ERROR_MSG := X_ERROR_MSG || '该供应商未生效';
            ELSIF V_VENDOR_ID = -5 THEN
              X_ERROR_MSG := X_ERROR_MSG || '获取过程异常，请联系系统管理员';
            END IF;
          
            IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '；';
            END IF;
            V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE || X_ERROR_MSG;
            UPDATE SPM_DB_IN_INVOICE_VIEW VI
               SET VI.ATTRIBUTE5 = X_ERROR_MSG
             WHERE VI.CONTRACT_CODE = V_CONTRACT_CODE;
            CONTINUE;
          END IF;
        
        END IF;
        SELECT M.CONTRACT_ID
          INTO V_CONTRACT_ID
          FROM SPM_CON_HT_INFO M
         WHERE M.CONTRACT_CODE = V_CONTRACT_CODE;
        --V_CONTRACT_ID := 2348979000;
        SELECT SUM(VI.INVOICE_AMOUNT), SUM(VI.TAX_AMOUNT)
          INTO V_INVOICEAMOUNT, V_TAXAMOUNT
          FROM SPM_DB_IN_INVOICE_VIEW VI
         WHERE VI.CONTRACT_CODE = V_CONTRACT_CODE;
        --根据流水号规则生成发票号码 
        V_INVOICECODE := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_INPUT_INVOICE',
                                                            'INVOICE_CODE',
                                                            'FM000000',
                                                            V_CODE_PRE);
        --根据登录人userid 获取personid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --核算部门                         
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
        --不含税金额计算
        SELECT V_INVOICEAMOUNT - V_TAXAMOUNT
          INTO INVOICETAXAMOUNT
          FROM DUAL; --发票金额-税额
        --税率计算
        --SELECT V_TAXAMOUNT / INVOICETAXAMOUNT INTO V_TAXRATE FROM DUAL;--税额 / 不含税金额 
        --判断发票分类
        IF V_INVOICE_TYPE = 0 THEN
          V_INVOICETYPE := 'A';
        ELSIF V_INVOICE_TYPE = 3 THEN
          V_INVOICETYPE := 'B';
        ELSE
          V_INVOICETYPE := 'C';
        END IF;
        --获取行信息的税率 
        SELECT COUNT(W.TAX_RATE)
          INTO V_RATENUM --L_TAXRATE
          FROM SPM_DB_IN_INVOICE_ITEM_VIEW W
         WHERE W.INVOICE_ID = V_INVOICE_ID_P;
        IF V_RATENUM = 0 THEN
          V_TAXRATE := '';
        ELSE
          SELECT MAX(W.TAX_RATE)
            INTO V_TAXRATE
            FROM SPM_DB_IN_INVOICE_ITEM_VIEW W
           WHERE W.INVOICE_ID = V_INVOICE_ID_P;
        END IF;
        V_INVOICE_ID := SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL;
        --插入数据
        INSERT INTO SPM_CON_INPUT_INVOICE
          (INPUT_INVOICE_ID, --进项发票管理主键
           VENDOR_ID, --供应商id
           INVOICE_CONTENT, --摘要
           INVOICE_TYPE, --发票类型
           INVOICE_CODE, --发票号码
           INVOICE_AMOUNT, --发票金额
           CURRENCY_TYPE, --发票金额币种
           PROJECT_ID, --关联项目ID
           CONTRACT_ID, --关联合同ID       
           VERIFIC_IMPREST_AMOUNT, --核销预付款金额
           CREATED_BY, --登记经办人
           CREATION_DATE, --登记日期
           LAST_UPDATE_DATE, -- 最后修改时间     
           STATUS, --审批状态
           ORG_ID, --所属机构ID
           DEPT_ID, --所属部门ID
           RESIDUAL_AMOUNT, --剩余金额
           BILLING_DATE, --开票日期
           PAYMENT_TERM, --付款条件
           PAYMENT_TYPE, --付款方式
           VENDOR_SITE_ID, --供应商地点ID
           TAX_AMOUNT, --税额
           INVOICETAX_AMOUNT, --总金额 不含税金额
           TAX_RATE, --税率
           NO_TAX_DIF, --不含税差异金额
           NO_CONTRACT, --是否无合同
           EBS_DEPT_CODE, --核算部门code
           PAYMENT_STATUS, --付款情况        
           EBS_STATUS, --EBS同步状态
           GL_DATE, --入账日期
           EBS_TYPE --发票类型EBS
           )
        VALUES
          (V_INVOICE_ID,
           V_VENDOR_ID, --供应商id
           '摘要', --VALIDATE_J, --摘要        
           V_INVOICETYPE, --发票分类
           V_INVOICECODE, --EBS发票号码
           ROUND(V_INVOICEAMOUNT, 2), --发票金额
           'CNY', --发票金额币种
           V_PROJECT_ID, --关联项目ID
           V_CONTRACT_ID, --关联合同ID
           0, -- --核销预付款金额
           V_USER_ID, --登记经办人                       
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--登记日期 
           SYSDATE, --最后修改时间
           'A', --审批状态
           V_ORG_ID, --所属机构ID
           V_DEPT_ID, --所属部门ID
           ROUND(V_INVOICEAMOUNT, 2), --剩余金额  同发票金额      
           TO_DATE(V_BILLING_DATE, 'YYYY-MM-DD'), --开票日期
           '10000', --付款条件
           'WIRE', --付款方式
           200761, --V_VENDOR_SITE_ID,--供应商地点ID
           ROUND(V_TAXAMOUNT, 2), --税额
           ROUND(INVOICETAXAMOUNT, 2), --总金额 不含税金额
           V_TAXRATE, --税率
           0, --NOTAXDIF, --不含税差异金额
           '', --NOCONTRACT, --是否无合同        
           EBSDEPTCODE, --核算部门         
           'Y', --付款情况
           'N', --EBS同步状态
           SYSDATE, --入账日期
           'STANDARD' --发票类型EBS
           );
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE || '生成发票数据异常';
          UPDATE SPM_DB_IN_INVOICE_VIEW VI
             SET VI.ATTRIBUTE5 = '生成发票数据异常'
           WHERE VI.CONTRACT_CODE = V_CONTRACT_CODE;
          CONTINUE;
      END;
    
      BEGIN
        OPEN CUR1(V_CONTRACT_CODE);
        FETCH CUR1
          INTO REC1;
        WHILE CUR1%FOUND LOOP
          V_ID := REC1.INVOICE_ID;
          SELECT SUM(W.MONEY_AMOUNT), MAX(W.TAX_RATE)
            INTO L_MONEYAMOUNT, L_TAXRATE
            FROM SPM_DB_IN_INVOICE_ITEM_VIEW W
           WHERE W.INVOICE_ID = V_ID;
          --计算税额
          SELECT L_MONEYAMOUNT * L_TAXRATE INTO L_TAXAMOUNT FROM DUAL; --不含税金额*税率
          INSERT INTO SPM_CON_PAPER_INVOICE
            (PAPER_INVOICE_ID, --表主键 
             INVOICE_ID, --外键
             INVOICE_CODE, --发票代码
             INVOICE_NUMBER, --发票号码
             INVOICE_TYPE, --发票类型 ap
             ORG_ID,
             DEPT_ID,
             REMARK,
             MONEY_AMOUNT, --不含税金额
             TAX_AMOUNT, --税额
             INVOICE_URL, --电子发票地址
             INVALID_FLAG --物理发票作废标识
             )
          VALUES
            (SPM_CON_PAPER_INVOICE_SEQ.NEXTVAL,
             V_INVOICE_ID,
             REC1.CODE,
             REC1.INVOICE_NUM,
             'AP',
             SPM_SSO_PKG.GETORGID,
             V_DEPT_ID,
             '',
             L_MONEYAMOUNT, --不含税金额
             L_TAXAMOUNT, --税额
             '',
             '');
          UPDATE SPM_DB_IN_INVOICE_VIEW VI
             SET VI.ATTRIBUTE1 = 'Y'
           WHERE VI.CONTRACT_CODE = V_CONTRACT_CODE;
        
          FETCH CUR1
            INTO REC1;
        END LOOP;
        CLOSE CUR1;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || ',';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE;
      END;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      V_RETURN_CODE := 'S';
    ELSE
      V_RETURN_MSG := '交易单号' || V_RETURN_MSG || '数据获取失败';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '数据执行异常';
  END INSERT_INPUTINVOICE_INFO;
  /*=================================================================
  *   PROGRAM NAME: IMPORT_GL_CRRT_BY_TEMPLATE
  *
  *   DESCRIPTION: 根据总账凭证模版生成总账凭证数据
  *   ARGUMENT:
  *   PARAM : P_TEMPLATE_CODE：模版CODE,P_VERSION_NUMBER:本次生成的数据批次标识，P_GL_DATE：总账日期，格式:yyyy-mm-dd 本次需要同步的发票id；
  *  P_PARAM：模版参数，OUT_SUCESS_FLAG：输出参数：成功标识，S:成功，E:失败， OUT_MESSAGE：输出结果信息
  *   HISTORY:
  *     1.0  20180813   cl          Created
  */

  PROCEDURE IMPORT_GL_CRRT_BY_TEMPLATE(P_TEMPLATE_CODE  VARCHAR,
                                       P_VERSION_NUMBER VARCHAR,
                                       P_GL_DATE        VARCHAR,
                                       P_ATTACH_CNT     NUMBER,
                                       P_PARAM          VARCHAR2,
                                       OUT_SUCESS_FLAG  OUT VARCHAR,
                                       OUT_MESSAGE      OUT VARCHAR) IS
    PARAM_ARRAY     SPM_TYPE_TBL; --第一次分割成的数组
    PARAM_VARCHAR   VARCHAR(4000); --第一次截取字符
    V_TEMPLATE_NAME VARCHAR2(200); --模版名称
    V_LINE_NUMBER   NUMBER(3); --ebs行号
    V_ORG_CODE      VARCHAR(20); --公司编码
    V_DEPT_CODE     VARCHAR(50); --部门编码
    V_PRO_CODE      VARCHAR(50); --项目编码
    V_PARAM_TEMP    VARCHAR(4000); --参数集合
    V_PARAMS        VARCHAR(4000); --参数集合
    V_PARAMS_CNT    NUMBER(2); --SQLZ中参数个数（？号个数）
    V_PARAM         VARCHAR(50); --参数
    V_ATTACH_CNT    NUMBER(5); --附件张数
    V_PARAMS_ARRAY  SPM_TYPE_TBL; --参数集合
    --V_SQL_CNT                  NUMBER(3);-- 取值类型为SQL的模版明细行数
    V_SQL VARCHAR(4000); --获取金额的SQL
    --V_ITEM_CNT           NUMBER(3);--模版明细条数
    --V_INDEX              NUMBER(3):=0;--获取金额SQL中参数索引
    V_AMOUNT NUMBER(20, 2); --最终得到的金额
    --V_SUBJECT_COM        VARCHAR(200);--重新生成的科目组合
    V_DATA_CNT       NUMBER(3); --该总账数据在接口表中的条数 
    V_ERROR_DATA_CNT NUMBER(3); --该总账数据在接口表中的条数 --错误诗句
    --T_HEADERS_ID        NUMBER; --中间表主键
    V_GL_DATE       DATE; --总账日期
    V_JE_BATCH_NAME VARCHAR2(500); --传总账批名
    V_DR_AMOUNT     NUMBER(18, 2) := 0; --借方总金额
    V_CR_AMOUNT     NUMBER(18, 2) := 0; --贷方总金额
    V_CERT_NUMBER   VARCHAR2(100); --总账凭证
    V_JE_BATCH_ID   VARCHAR(20); --批名ID
    V_REQUEST_ID    NUMBER(20); --请求ID   
    V_HEADER_ID     NUMBER(20); --总账头ID
    L_WAIT_REQ      BOOLEAN;
    L_CHILD_PHASE   VARCHAR2(20);
    L_CHILD_STATUS  VARCHAR2(20);
    L_DEV_PHASE     VARCHAR2(20);
    L_DEV_STATUS    VARCHAR2(20);
    L_MESSAGE       VARCHAR2(20);
  BEGIN
  
    BEGIN
      SELECT TO_DATE(P_GL_DATE, 'YYYY-MM-DD') INTO V_GL_DATE FROM DUAL;
    
      SELECT A.TEMPLATE_NAME
        INTO V_TEMPLATE_NAME
        FROM SPM_GZ_CERT_TEMPLATE A, SPM_GZ_CERT_TEMPLATE_ITEM B
       WHERE A.TEMPLATE_ID = B.TEMPLATE_ID
         AND A.TEMPLATE_CODE = P_TEMPLATE_CODE
         AND ROWNUM = 1;
    EXCEPTION
      WHEN OTHERS THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '没有找到该模版对应的模版明细信息';
        --插入日志
        INSERT INTO SPM_GZ_IMPORT_CERT_LOG
          (LOG_ID,
           TEMPLATE_CODE,
           VERSION_NUMBER,
           GL_DATE,
           PARAM,
           JE_BATCH_NAME,
           SUCESS_FLAG,
           OUT_MESSAGE,
           CERT_NUMBER)
        VALUES
          (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
           P_TEMPLATE_CODE,
           P_VERSION_NUMBER,
           V_GL_DATE,
           P_PARAM,
           V_JE_BATCH_NAME,
           OUT_SUCESS_FLAG,
           OUT_MESSAGE,
           '');
        COMMIT;
        RETURN;
    END;
  
    --查询
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
       AND CD.JE_BATCH_NAME LIKE '%' || V_TEMPLATE_NAME || '%'
       AND CD.DATA_STATUS = 'IMPORT';
    IF V_DATA_CNT <> 0 THEN
      --说明已经导入过
      OUT_SUCESS_FLAG := 'E';
      OUT_MESSAGE     := '当前的数据已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(OUT_MESSAGE);
      --插入日志
      INSERT INTO SPM_GZ_IMPORT_CERT_LOG
        (LOG_ID,
         TEMPLATE_CODE,
         VERSION_NUMBER,
         GL_DATE,
         PARAM,
         JE_BATCH_NAME,
         SUCESS_FLAG,
         OUT_MESSAGE,
         CERT_NUMBER)
      VALUES
        (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
         P_TEMPLATE_CODE,
         P_VERSION_NUMBER,
         V_GL_DATE,
         P_PARAM,
         V_JE_BATCH_NAME,
         OUT_SUCESS_FLAG,
         OUT_MESSAGE,
         '');
      COMMIT;
      RETURN;
    END IF;
  
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_ERROR_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER
       AND CD.DATA_STATUS <> 'IMPORT';
    IF V_ERROR_DATA_CNT <> 0 THEN
      --说明有错误数据在中间表
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER;
    END IF;
  
    BEGIN
    
      SELECT NVL(P_ATTACH_CNT, 0) INTO V_ATTACH_CNT FROM DUAL;
      --现将原来的记录删除
      DELETE FROM SPM_GZ_CERT_ITEM_TEMP;
      --将模版中的数据出入到临时表中
      INSERT INTO SPM_GZ_CERT_ITEM_TEMP
        (ITEM_ID,
         TEMPLATE_ID,
         LINE_NUMBER,
         SUMMARY,
         SUBJECT_COM,
         DRCR_TYPE,
         VALUE_TYPE,
         AMOUNT,
         CORRESPOND_LINE,
         CASH_FLOW,
         SEGMENT1,
         SEGMENT2,
         SEGMENT3,
         SEGMENT4,
         SEGMENT5,
         SEGMENT6,
         SEGMENT7,
         SEGMENT8,
         SEGMENT9,
         SEGMENT10,
         CREATED_BY,
         CREATION_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_DATE,
         LAST_UPDATE_LOGIN,
         ATTRIBUTE1,
         ATTRIBUTE2,
         ATTRIBUTE3,
         ATTRIBUTE4,
         ATTRIBUTE5)
        SELECT B.ITEM_ID,
               B.TEMPLATE_ID,
               B.LINE_NUMBER,
               B.SUMMARY,
               B.SUBJECT_COM,
               B.DRCR_TYPE,
               B.VALUE_TYPE,
               B.AMOUNT,
               B.CORRESPOND_LINE,
               B.CASH_FLOW,
               B.SEGMENT1,
               B.SEGMENT2,
               B.SEGMENT3,
               B.SEGMENT4,
               B.SEGMENT5,
               B.SEGMENT6,
               B.SEGMENT7,
               B.SEGMENT8,
               B.SEGMENT9,
               B.SEGMENT10,
               B.CREATED_BY,
               B.CREATION_DATE,
               B.LAST_UPDATED_BY,
               B.LAST_UPDATE_DATE,
               B.LAST_UPDATE_LOGIN,
               B.ATTRIBUTE1,
               B.ATTRIBUTE2,
               B.ATTRIBUTE3,
               B.ATTRIBUTE4,
               B.ATTRIBUTE5
          FROM SPM_GZ_CERT_TEMPLATE A, SPM_GZ_CERT_TEMPLATE_ITEM B
         WHERE A.TEMPLATE_ID = B.TEMPLATE_ID
           AND A.TEMPLATE_CODE = P_TEMPLATE_CODE;
    
      SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(P_PARAM), '},')
        INTO PARAM_ARRAY
        FROM DUAL;
      --遍历 --根据EBS行号
      FOR I IN 1 .. PARAM_ARRAY.COUNT LOOP
        PARAM_VARCHAR := PARAM_ARRAY(I);
        --DBMS_OUTPUT.put_line(PARAM_VARCHAR);
        --获取EBS行号
        V_LINE_NUMBER := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                             INSTR(PARAM_VARCHAR, ':') + 1,
                                             INSTR(PARAM_VARCHAR, ',') -
                                             (INSTR(PARAM_VARCHAR, ':') + 1))),
                                 '''',
                                 '');
        -- DBMS_OUTPUT.PUT_LINE('行号：'||V_LINE_NUMBER);
        V_DEPT_CODE := '';
        V_PRO_CODE  := '';
        --获取部门编码
        V_DEPT_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                           INSTR(PARAM_VARCHAR, ':', 1, 2) + 1,
                                           INSTR(PARAM_VARCHAR, ',', 1, 2) -
                                           (INSTR(PARAM_VARCHAR, ':', 1, 2) + 1))),
                               '''');
        --获取项目段
        V_PRO_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                          INSTR(PARAM_VARCHAR, ':', 1, 3) + 1,
                                          INSTR(PARAM_VARCHAR, ',', 1, 3) -
                                          (INSTR(PARAM_VARCHAR, ':', 1, 3) + 1))),
                              '''');
        IF LENGTH(NVL(V_DEPT_CODE, '')) > 0 OR
           LENGTH(NVL(V_PRO_CODE, '')) > 0 THEN
          -- 10000629.00.100202.00.T.00.00.00.00.00
          --将科目组合信息中的部门段更新为传过来的部门段
        
          UPDATE SPM_GZ_CERT_ITEM_TEMP
             SET SEGMENT2    = V_DEPT_CODE,
                 SEGMENT5    = V_PRO_CODE,
                 SUBJECT_COM = SUBSTR(SUBJECT_COM,
                                      1,
                                      INSTR(SUBJECT_COM, '.')) ||
                               V_DEPT_CODE ||
                               SUBSTR(SUBJECT_COM,
                                      INSTR(SUBJECT_COM, '.', 1, 2),
                                      INSTR(SUBJECT_COM, '.', 1, 5) -
                                      INSTR(SUBJECT_COM, '.', 1, 2)) ||
                               V_PRO_CODE ||
                               SUBSTR(SUBJECT_COM,
                                      INSTR(SUBJECT_COM, '.', 1, 5))
           WHERE LINE_NUMBER = V_LINE_NUMBER;
        END IF;
        --获取参数结合
        V_PARAM_TEMP := TRIM(SUBSTR(PARAM_VARCHAR,
                                    INSTR(PARAM_VARCHAR, ':', 1, 4) + 1));
        --去掉最后一位}
        IF SUBSTR(V_PARAM_TEMP, LENGTH(V_PARAM_TEMP)) = '}' THEN
          V_PARAMS := SUBSTR(V_PARAM_TEMP, 1, LENGTH(V_PARAM_TEMP) - 1);
        ELSE
          V_PARAMS := V_PARAM_TEMP;
        END IF;
        --根据模版CODE和EBS行号查询模版明细信息
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET SQL_PARAMS = V_PARAMS
         WHERE VALUE_TYPE = '1'
           AND LINE_NUMBER = V_LINE_NUMBER;
      END LOOP;
      COMMIT;
      --当取值类型为SQL时
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '1') LOOP
        V_SQL      := I.AMOUNT;
        V_ORG_CODE := I.SEGMENT1;
        --得到参数集合
        DBMS_OUTPUT.PUT_LINE('SQL_PARAMS:' || I.SQL_PARAMS);
        SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(I.SQL_PARAMS), ',')
          INTO V_PARAMS_ARRAY
          FROM DUAL;
      
        SELECT LENGTH(REGEXP_REPLACE(V_SQL, '[^?？]', ''))
          INTO V_PARAMS_CNT
          FROM DUAL;
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_ARRAY.COUNT:'||V_PARAMS_ARRAY.COUNT);
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_CNT:'||V_PARAMS_CNT);
        IF V_PARAMS_ARRAY.COUNT <> V_PARAMS_CNT THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '参数个数和SQL中的参数个数不匹配';
          --插入日志
          INSERT INTO SPM_GZ_IMPORT_CERT_LOG
            (LOG_ID,
             TEMPLATE_CODE,
             VERSION_NUMBER,
             GL_DATE,
             PARAM,
             JE_BATCH_NAME,
             SUCESS_FLAG,
             OUT_MESSAGE,
             CERT_NUMBER)
          VALUES
            (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
             P_TEMPLATE_CODE,
             P_VERSION_NUMBER,
             V_GL_DATE,
             P_PARAM,
             V_JE_BATCH_NAME,
             OUT_SUCESS_FLAG,
             OUT_MESSAGE,
             '');
          COMMIT;
          RETURN;
        END IF;
        --遍历
        FOR J IN 1 .. V_PARAMS_ARRAY.COUNT LOOP
          V_PARAM := V_PARAMS_ARRAY(J);
          --  V_INDEX:=V_INDEX+1;
          --替换SQL中的？号
          --SELECT  REGEXP_REPLACE(V_SQL,'[?]',V_PARAM,1,V_INDEX) INTO V_SQL  FROM DUAL;
          SELECT REGEXP_REPLACE(V_SQL, '[?？]', V_PARAM, 1, 1)
            INTO V_SQL
            FROM DUAL;
        END LOOP;
      
        DBMS_OUTPUT.PUT_LINE('SQL：' || V_SQL);
        --执行sql
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO V_AMOUNT;
        EXCEPTION
          WHEN OTHERS THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '执行获取金额SQL出错，原因：' || SQLERRM;
            --插入日志
            INSERT INTO SPM_GZ_IMPORT_CERT_LOG
              (LOG_ID,
               TEMPLATE_CODE,
               VERSION_NUMBER,
               GL_DATE,
               PARAM,
               JE_BATCH_NAME,
               SUCESS_FLAG,
               OUT_MESSAGE,
               CERT_NUMBER)
            VALUES
              (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
               P_TEMPLATE_CODE,
               P_VERSION_NUMBER,
               V_GL_DATE,
               P_PARAM,
               V_JE_BATCH_NAME,
               OUT_SUCESS_FLAG,
               OUT_MESSAGE,
               '');
            COMMIT;
            RETURN;
        END;
        -- DBMS_OUTPUT.put_line('金额：'||V_AMOUNT);
        --更新金额
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = NVL(V_AMOUNT, 0)
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      --当取值类型为对应行号时   
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '2') LOOP
        SELECT SUM(AMOUNT)
          INTO V_AMOUNT
          FROM SPM_GZ_CERT_ITEM_TEMP
         WHERE DRCR_TYPE <> I.DRCR_TYPE
           AND CORRESPOND_LINE = I.AMOUNT;
        --更新金额
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = V_AMOUNT
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      COMMIT;
      --判断借贷总金额是否相等
      SELECT SUM(NVL(AMOUNT, 0))
        INTO V_DR_AMOUNT
        FROM SPM_GZ_CERT_ITEM_TEMP
       WHERE DRCR_TYPE = 'DR';
      SELECT SUM(NVL(AMOUNT, 0))
        INTO V_CR_AMOUNT
        FROM SPM_GZ_CERT_ITEM_TEMP
       WHERE DRCR_TYPE = 'CR';
      IF V_DR_AMOUNT <> V_CR_AMOUNT THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '借贷总金额不相等。';
        --插入日志
        INSERT INTO SPM_GZ_IMPORT_CERT_LOG
          (LOG_ID,
           TEMPLATE_CODE,
           VERSION_NUMBER,
           GL_DATE,
           PARAM,
           JE_BATCH_NAME,
           SUCESS_FLAG,
           OUT_MESSAGE,
           CERT_NUMBER)
        VALUES
          (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
           P_TEMPLATE_CODE,
           P_VERSION_NUMBER,
           V_GL_DATE,
           P_PARAM,
           V_JE_BATCH_NAME,
           OUT_SUCESS_FLAG,
           OUT_MESSAGE,
           '');
        COMMIT;
        RETURN;
      END IF;
      --构造批次名称
      V_JE_BATCH_NAME := V_ORG_CODE || TO_CHAR(V_GL_DATE, 'YYYY') ||
                         TO_CHAR(V_GL_DATE, 'MM') ||
                         TO_CHAR(V_GL_DATE, 'DD') || V_TEMPLATE_NAME ||
                         P_VERSION_NUMBER;
      --将临时表中的数据插入到总账中间表
      INSERT INTO CUX_GL_INTERFACE_DATA
        (GL_DATA_ID,
         GL_DATA_SOURCE,
         JE_BATCH_NAME,
         BATCH_DESCRIPTION,
         JE_HEADER_NAME,
         HEADER_DESCRIPTION,
         GL_DATE,
         CURRENCY_CODE,
         JE_LINE_NUM,
         JE_LINE_DESCRIPTION,
         ENTERED_DR,
         ENTERED_CR,
         DATA_STATUS,
         OBJECT_VERSION_NUMBER,
         OPERATE_DATE,
         BUSINESS_TYPE,
         USER_JE_SOURCE_NAME,
         USER_JE_CATEGORY_NAME,
         PERIOD_NAME,
         GL_SET_OF_BOOK_ID,
         ATTRIBUTE4,
         SEGMENT1,
         SEGMENT2,
         SEGMENT3,
         SEGMENT4,
         SEGMENT5,
         SEGMENT6,
         SEGMENT7,
         SEGMENT8,
         SEGMENT9,
         SEGMENT10,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_LOGIN,
         CREATION_DATE,
         CREATED_BY)
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL, T.*
          FROM (SELECT 'SPM系统',
                       V_JE_BATCH_NAME, -- 账批号
                       TO_CHAR(V_GL_DATE, 'YYYY') ||
                       TO_CHAR(V_GL_DATE, 'MM') || TO_CHAR(V_GL_DATE, 'DD') ||
                       V_TEMPLATE_NAME,
                       V_TEMPLATE_NAME BATCH_DESCRIPTION,
                       V_TEMPLATE_NAME JE_HEADER_NAME,
                       V_GL_DATE GL_DATE,
                       'CNY',
                       LINE_NUMBER,
                       SUMMARY,
                       DECODE(DRCR_TYPE, 'DR', AMOUNT, 0),
                       DECODE(DRCR_TYPE, 'CR', AMOUNT, 0),
                       'NEW',
                       P_VERSION_NUMBER,
                       V_GL_DATE,
                       '用户',
                       '人工',
                       '记账',
                       TO_CHAR(V_GL_DATE, 'YYYYMM'),
                       2021,
                       CASH_FLOW,
                       SEGMENT1,
                       SEGMENT2,
                       SEGMENT3,
                       SEGMENT4,
                       SEGMENT5,
                       SEGMENT6,
                       SEGMENT7,
                       SEGMENT8,
                       SEGMENT9,
                       SEGMENT10,
                       SYSDATE LAST_UPDATE_DATE,
                       LAST_UPDATED_BY,
                       LAST_UPDATE_LOGIN,
                       SYSDATE CREATION_DATE,
                       CREATED_BY
                  FROM SPM_GZ_CERT_ITEM_TEMP
                 ORDER BY LINE_NUMBER) T;
      COMMIT;
      --执行生成总账凭证数据
      CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => OUT_MESSAGE,
                             RETCODE         => OUT_SUCESS_FLAG,
                             P_DATA_SOURCE   => 'SPM系统',
                             P_JE_BATCH_NAME => V_JE_BATCH_NAME,
                             P_REPEANT       => 'Y');
    
      --  IF OUT_SUCESS_FLAG = 'S' THEN
      --T_RETURN_CODE := G_INTERFACE_SUCCESS;
      -- OUT_SUCESS_FLAG    := 'S';
      SELECT DECODE(DATA_STATUS, 'FAIL', 'E', 'S') DATA_STATUS, FAIL_RESON
        INTO OUT_SUCESS_FLAG, OUT_MESSAGE
        FROM CUX_GL_INTERFACE_DATA
       WHERE OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
         AND ROWNUM = 1;
      IF OUT_SUCESS_FLAG = 'S' THEN
      
        --查询生成后的批次名
        SELECT JE_BATCH_ID, NAME
          INTO V_JE_BATCH_ID, V_JE_BATCH_NAME
          FROM GL_JE_BATCHES
         WHERE NAME LIKE '%' || V_JE_BATCH_NAME || '%';
      
        V_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('SQLGL',
                                                   'GLPPOSS',
                                                   '自动过账',
                                                   NULL,
                                                   FALSE,
                                                   2021,
                                                   1000, -- NEW PARAMETER
                                                   50348,
                                                   V_JE_BATCH_ID,
                                                   CHR(0));
        IF V_REQUEST_ID <= 0 THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '自动过账并发请求提交失败';
          RETURN;
        ELSE
          UPDATE GL_JE_BATCHES T
             SET T.STATUS         = 'S',
                 T.POSTING_RUN_ID = V_JE_BATCH_ID,
                 T.REQUEST_ID     = V_REQUEST_ID
           WHERE T.JE_BATCH_ID = V_JE_BATCH_ID;
          COMMIT;
          L_WAIT_REQ := FND_CONCURRENT.WAIT_FOR_REQUEST(V_REQUEST_ID,
                                                        1,
                                                        0,
                                                        L_CHILD_PHASE,
                                                        L_CHILD_STATUS,
                                                        L_DEV_PHASE,
                                                        L_DEV_STATUS,
                                                        L_MESSAGE);
          IF L_CHILD_STATUS <> INITCAP('正常') THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '自动过账并发请求提交失败';
            RETURN;
          ELSE
            OUT_SUCESS_FLAG := 'S';
            OUT_MESSAGE     := '生成总账凭证数据成功';
          END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('V_JE_BATCH_ID:' || V_JE_BATCH_ID);
        --凭证号 只有过账后侧能生成凭证号 
        SELECT JH.EXTERNAL_REFERENCE, JB.NAME, JH.JE_HEADER_ID
          INTO V_CERT_NUMBER, V_JE_BATCH_NAME, V_HEADER_ID
          FROM GL_JE_BATCHES JB, GL_JE_HEADERS JH
         WHERE JH.JE_BATCH_ID = JB.JE_BATCH_ID
           AND JB.JE_BATCH_ID = V_JE_BATCH_ID;
        DBMS_OUTPUT.PUT_LINE('V_HEADER_ID:' || V_HEADER_ID);
      
        --更新附件张数
        UPDATE GL_JE_HEADERS GJH
           SET ATTRIBUTE1 = V_ATTACH_CNT
         WHERE GJH.JE_HEADER_ID = V_HEADER_ID;
        --更新总账头表中的现金流信息
        FOR CASH IN (SELECT *
                       FROM SPM_GZ_CERT_ITEM_TEMP
                      WHERE CASH_FLOW IS NOT NULL) LOOP
          UPDATE GL_JE_LINES GJL
             SET GJL.ATTRIBUTE4 = CASH.CASH_FLOW
           WHERE GJL.JE_HEADER_ID = V_HEADER_ID
             AND EXISTS
           (SELECT 1
                    FROM GL_CODE_COMBINATIONS GCC
                   WHERE GCC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
                     AND GCC.SEGMENT1 = CASH.SEGMENT1
                     AND GCC.SEGMENT2 = CASH.SEGMENT2
                     AND GCC.SEGMENT3 = CASH.SEGMENT3
                     AND GCC.SEGMENT4 = CASH.SEGMENT4
                     AND GCC.SEGMENT5 = CASH.SEGMENT5
                     AND GCC.SEGMENT6 = CASH.SEGMENT6
                     AND GCC.SEGMENT7 = CASH.SEGMENT7
                     AND GCC.SEGMENT8 = CASH.SEGMENT8
                     AND GCC.SEGMENT9 = CASH.SEGMENT9
                     AND GCC.SEGMENT10 = CASH.SEGMENT10);
        END LOOP;
      
      END IF;
    
      /*  ELSIF OUT_SUCESS_FLAG <> 'S' OR OUT_SUCESS_FLAG IS NULL THEN
      DELETE FROM CUX_GL_INTERFACE_DATA CD
      WHERE CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER;
      COMMIT;*/
      --  END IF;   
    
    EXCEPTION
      WHEN OTHERS THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '生成总账凭证数据失败，原因：' || SQLERRM;
        -- RETURN;
    END;
    DBMS_OUTPUT.PUT_LINE('OUT_MESSAGE:' || OUT_MESSAGE);
    DBMS_OUTPUT.PUT_LINE('OUT_SUCESS_FLAG:' || OUT_SUCESS_FLAG);
  
    --插入日志
    INSERT INTO SPM_GZ_IMPORT_CERT_LOG
      (LOG_ID,
       TEMPLATE_CODE,
       VERSION_NUMBER,
       GL_DATE,
       PARAM,
       JE_BATCH_NAME,
       SUCESS_FLAG,
       OUT_MESSAGE,
       CERT_NUMBER)
    VALUES
      (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
       P_TEMPLATE_CODE,
       P_VERSION_NUMBER,
       V_GL_DATE,
       P_PARAM,
       V_JE_BATCH_NAME,
       OUT_SUCESS_FLAG,
       OUT_MESSAGE,
       V_CERT_NUMBER);
    COMMIT;
  END IMPORT_GL_CRRT_BY_TEMPLATE;
  
  PROCEDURE IMPORT_GL_CRRT_BY_TEMPLATE_GZ(P_TEMPLATE_CODE  VARCHAR,
                                       P_VERSION_NUMBER VARCHAR,
                                       P_GL_DATE        VARCHAR,
                                       P_ATTACH_CNT     NUMBER,
                                       P_PARAM          VARCHAR2,
                                       OUT_SUCESS_FLAG  OUT VARCHAR,
                                       OUT_MESSAGE      OUT VARCHAR) IS
    PARAM_ARRAY     SPM_TYPE_TBL; --第一次分割成的数组
    PARAM_VARCHAR   VARCHAR(4000); --第一次截取字符
    V_TEMPLATE_NAME VARCHAR2(200); --模版名称
    V_LINE_NUMBER   NUMBER(3); --ebs行号
    V_ORG_CODE      VARCHAR(20); --公司编码
    V_DEPT_CODE     VARCHAR(50); --部门编码
    V_PRO_CODE      VARCHAR(50); --项目编码
    V_PARAM_TEMP    VARCHAR(4000); --参数集合
    V_PARAMS        VARCHAR(4000); --参数集合
    V_PARAMS_CNT    NUMBER(2); --SQLZ中参数个数（？号个数）
    V_PARAM         VARCHAR(50); --参数
    V_ATTACH_CNT    NUMBER(5); --附件张数
    V_PARAMS_ARRAY  SPM_TYPE_TBL; --参数集合
    --V_SQL_CNT                  NUMBER(3);-- 取值类型为SQL的模版明细行数
    V_SQL VARCHAR(4000); --获取金额的SQL
    --V_ITEM_CNT           NUMBER(3);--模版明细条数
    --V_INDEX              NUMBER(3):=0;--获取金额SQL中参数索引
    V_AMOUNT NUMBER(20, 2); --最终得到的金额
    --V_SUBJECT_COM        VARCHAR(200);--重新生成的科目组合
    V_DATA_CNT       NUMBER(3); --该总账数据在接口表中的条数 
    V_ERROR_DATA_CNT NUMBER(3); --该总账数据在接口表中的条数 --错误诗句
    --T_HEADERS_ID        NUMBER; --中间表主键
    V_GL_DATE       DATE; --总账日期
    V_JE_BATCH_NAME VARCHAR2(500); --传总账批名
    V_DR_AMOUNT     NUMBER(18, 2) := 0; --借方总金额
    V_CR_AMOUNT     NUMBER(18, 2) := 0; --贷方总金额
    V_CERT_NUMBER   VARCHAR2(100); --总账凭证
    V_JE_BATCH_ID   VARCHAR(20); --批名ID
    V_REQUEST_ID    NUMBER(20); --请求ID   
    V_HEADER_ID     NUMBER(20); --总账头ID
    L_WAIT_REQ      BOOLEAN;
    L_CHILD_PHASE   VARCHAR2(20);
    L_CHILD_STATUS  VARCHAR2(20);
    L_DEV_PHASE     VARCHAR2(20);
    L_DEV_STATUS    VARCHAR2(20);
    L_MESSAGE       VARCHAR2(20);
    K_UPDATE_WAGEITEMS  VARCHAR2(400);--要替换为1的工资项目
    K_UPDATE_WAGEDEPTS  VARCHAR2(400);--要替换为2的工资部门
    K_SQL               VARCHAR2(4000);--最终的sql
  BEGIN
    --FND_GLOBAL.APPS_INITIALIZE(1769, 51292, 101);
  
    BEGIN
      SELECT TO_DATE(P_GL_DATE, 'YYYY-MM-DD') INTO V_GL_DATE FROM DUAL;
    
      SELECT A.TEMPLATE_NAME
        INTO V_TEMPLATE_NAME
        FROM SPM_GZ_CERT_TEMPLATE A, SPM_GZ_CERT_TEMPLATE_ITEM B
       WHERE A.TEMPLATE_ID = B.TEMPLATE_ID
         AND A.TEMPLATE_CODE = P_TEMPLATE_CODE
         AND ROWNUM = 1;
    EXCEPTION
      WHEN OTHERS THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '没有找到该模版对应的模版明细信息';
        --插入日志
        INSERT INTO SPM_GZ_IMPORT_CERT_LOG
          (LOG_ID,
           TEMPLATE_CODE,
           VERSION_NUMBER,
           GL_DATE,
           PARAM,
           JE_BATCH_NAME,
           SUCESS_FLAG,
           OUT_MESSAGE,
           CERT_NUMBER)
        VALUES
          (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
           P_TEMPLATE_CODE,
           P_VERSION_NUMBER,
           V_GL_DATE,
           P_PARAM,
           V_JE_BATCH_NAME,
           OUT_SUCESS_FLAG,
           OUT_MESSAGE,
           '');
        COMMIT;
        RETURN;
    END;
  
    --查询
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
       AND CD.JE_BATCH_NAME LIKE '%' || V_TEMPLATE_NAME || '%'
       AND CD.DATA_STATUS = 'IMPORT';
    IF V_DATA_CNT <> 0 THEN
      --说明已经导入过
      OUT_SUCESS_FLAG := 'E';
      OUT_MESSAGE     := '当前的数据已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(OUT_MESSAGE);
      --插入日志
      INSERT INTO SPM_GZ_IMPORT_CERT_LOG
        (LOG_ID,
         TEMPLATE_CODE,
         VERSION_NUMBER,
         GL_DATE,
         PARAM,
         JE_BATCH_NAME,
         SUCESS_FLAG,
         OUT_MESSAGE,
         CERT_NUMBER)
      VALUES
        (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
         P_TEMPLATE_CODE,
         P_VERSION_NUMBER,
         V_GL_DATE,
         P_PARAM,
         V_JE_BATCH_NAME,
         OUT_SUCESS_FLAG,
         OUT_MESSAGE,
         '');
      COMMIT;
      RETURN;
    END IF;
  
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_ERROR_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER
       AND CD.DATA_STATUS <> 'IMPORT';
    IF V_ERROR_DATA_CNT <> 0 THEN
      --说明有错误数据在中间表
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER;
    END IF;
  
    BEGIN
    
      SELECT NVL(P_ATTACH_CNT, 0) INTO V_ATTACH_CNT FROM DUAL;
      --现将原来的记录删除
      DELETE FROM SPM_GZ_CERT_ITEM_TEMP;
      --将模版中的数据出入到临时表中
      INSERT INTO SPM_GZ_CERT_ITEM_TEMP
        (ITEM_ID,
         TEMPLATE_ID,
         LINE_NUMBER,
         SUMMARY,
         SUBJECT_COM,
         DRCR_TYPE,
         VALUE_TYPE,
         AMOUNT,
         CORRESPOND_LINE,
         CASH_FLOW,
         SEGMENT1,
         SEGMENT2,
         SEGMENT3,
         SEGMENT4,
         SEGMENT5,
         SEGMENT6,
         SEGMENT7,
         SEGMENT8,
         SEGMENT9,
         SEGMENT10,
         CREATED_BY,
         CREATION_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_DATE,
         LAST_UPDATE_LOGIN,
         ATTRIBUTE1,
         ATTRIBUTE2,
         ATTRIBUTE3,
         ATTRIBUTE4,
         ATTRIBUTE5,
         WAGE_ITEMS,
         WAGE_DEPTS)
        SELECT B.ITEM_ID,
               B.TEMPLATE_ID,
               B.LINE_NUMBER,
               B.SUMMARY,
               B.SUBJECT_COM,
               B.DRCR_TYPE,
               B.VALUE_TYPE,
               B.AMOUNT,
               B.CORRESPOND_LINE,
               B.CASH_FLOW,
               B.SEGMENT1,
               B.SEGMENT2,
               B.SEGMENT3,
               B.SEGMENT4,
               B.SEGMENT5,
               B.SEGMENT6,
               B.SEGMENT7,
               B.SEGMENT8,
               B.SEGMENT9,
               B.SEGMENT10,
               B.CREATED_BY,
               B.CREATION_DATE,
               B.LAST_UPDATED_BY,
               B.LAST_UPDATE_DATE,
               B.LAST_UPDATE_LOGIN,
               B.ATTRIBUTE1,
               B.ATTRIBUTE2,
               B.ATTRIBUTE3,
               B.ATTRIBUTE4,
               B.ATTRIBUTE5,
               B.WAGE_ITEMS,
               B.WAGE_DEPTS
          FROM SPM_GZ_CERT_TEMPLATE A, SPM_GZ_CERT_TEMPLATE_ITEM B
         WHERE A.TEMPLATE_ID = B.TEMPLATE_ID
           AND A.TEMPLATE_CODE = P_TEMPLATE_CODE;
    
      SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(P_PARAM), '},')
        INTO PARAM_ARRAY
        FROM DUAL;
      --遍历 --根据EBS行号
      FOR I IN 1 .. PARAM_ARRAY.COUNT LOOP
        PARAM_VARCHAR := PARAM_ARRAY(I);
        --DBMS_OUTPUT.put_line(PARAM_VARCHAR);
        --获取EBS行号
        V_LINE_NUMBER := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                             INSTR(PARAM_VARCHAR, ':') + 1,
                                             INSTR(PARAM_VARCHAR, ',') -
                                             (INSTR(PARAM_VARCHAR, ':') + 1))),
                                 '''',
                                 '');
        -- DBMS_OUTPUT.PUT_LINE('行号：'||V_LINE_NUMBER);
        V_DEPT_CODE := '';
        V_PRO_CODE  := '';
        --获取部门编码
        V_DEPT_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                           INSTR(PARAM_VARCHAR, ':', 1, 2) + 1,
                                           INSTR(PARAM_VARCHAR, ',', 1, 2) -
                                           (INSTR(PARAM_VARCHAR, ':', 1, 2) + 1))),
                               '''');
        --获取项目段
        V_PRO_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                          INSTR(PARAM_VARCHAR, ':', 1, 3) + 1,
                                          INSTR(PARAM_VARCHAR, ',', 1, 3) -
                                          (INSTR(PARAM_VARCHAR, ':', 1, 3) + 1))),
                              '''');
        IF LENGTH(NVL(V_DEPT_CODE, '')) > 0 OR
           LENGTH(NVL(V_PRO_CODE, '')) > 0 THEN
          -- 10000629.00.100202.00.T.00.00.00.00.00
          --将科目组合信息中的部门段更新为传过来的部门段
        
          UPDATE SPM_GZ_CERT_ITEM_TEMP
             SET SEGMENT2    = V_DEPT_CODE,
                 SEGMENT5    = V_PRO_CODE,
                 SUBJECT_COM = SUBSTR(SUBJECT_COM,
                                      1,
                                      INSTR(SUBJECT_COM, '.')) ||
                               V_DEPT_CODE ||
                               SUBSTR(SUBJECT_COM,
                                      INSTR(SUBJECT_COM, '.', 1, 2),
                                      INSTR(SUBJECT_COM, '.', 1, 5) -
                                      INSTR(SUBJECT_COM, '.', 1, 2)) ||
                               V_PRO_CODE ||
                               SUBSTR(SUBJECT_COM,
                                      INSTR(SUBJECT_COM, '.', 1, 5))
           WHERE LINE_NUMBER = V_LINE_NUMBER;
        END IF;
        --获取参数结合
        V_PARAM_TEMP := TRIM(SUBSTR(PARAM_VARCHAR,
                                    INSTR(PARAM_VARCHAR, ':', 1, 4) + 1));
        --去掉最后一位}
        IF SUBSTR(V_PARAM_TEMP, LENGTH(V_PARAM_TEMP)) = '}' THEN
          V_PARAMS := SUBSTR(V_PARAM_TEMP, 1, LENGTH(V_PARAM_TEMP) - 1);
        ELSE
          V_PARAMS := V_PARAM_TEMP;
        END IF;
        --根据模版CODE和EBS行号查询模版明细信息
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET SQL_PARAMS = V_PARAMS
         WHERE VALUE_TYPE = '1'
           AND LINE_NUMBER = V_LINE_NUMBER;
          
         /*************替换sql中的参数*************/
       SELECT P.AMOUNT, P.WAGE_ITEMS, P.WAGE_DEPTS
         INTO K_SQL, K_UPDATE_WAGEITEMS, K_UPDATE_WAGEDEPTS
         FROM SPM_GZ_CERT_ITEM_TEMP P
        WHERE P.LINE_NUMBER = V_LINE_NUMBER;
        
        K_UPDATE_WAGEITEMS:=REPLACE(K_UPDATE_WAGEITEMS,',','),0)+nvl(sum(');
        K_UPDATE_WAGEITEMS:='nvl(sum(' ||  K_UPDATE_WAGEITEMS ||  '),0)';
        
        K_SQL:=REPLACE(K_SQL,'KK1',K_UPDATE_WAGEITEMS);
        K_SQL:=REPLACE(K_SQL,'KK2',K_UPDATE_WAGEDEPTS);
        
        UPDATE SPM_GZ_CERT_ITEM_TEMP T SET T.AMOUNT = K_SQL
        WHERE T.LINE_NUMBER = V_LINE_NUMBER;
        /**************************/
      END LOOP;
      COMMIT;
      --当取值类型为SQL时
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '1') LOOP
        V_SQL      := I.AMOUNT;
        V_ORG_CODE := I.SEGMENT1;
        --得到参数集合
        DBMS_OUTPUT.PUT_LINE('SQL_PARAMS:' || I.SQL_PARAMS);
        SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(I.SQL_PARAMS), ',')
          INTO V_PARAMS_ARRAY
          FROM DUAL;
      
        SELECT LENGTH(REGEXP_REPLACE(V_SQL, '[^?？]', ''))
          INTO V_PARAMS_CNT
          FROM DUAL;
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_ARRAY.COUNT:'||V_PARAMS_ARRAY.COUNT);
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_CNT:'||V_PARAMS_CNT);
        IF V_PARAMS_ARRAY.COUNT <> V_PARAMS_CNT THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '参数个数和SQL中的参数个数不匹配';
          --插入日志
          INSERT INTO SPM_GZ_IMPORT_CERT_LOG
            (LOG_ID,
             TEMPLATE_CODE,
             VERSION_NUMBER,
             GL_DATE,
             PARAM,
             JE_BATCH_NAME,
             SUCESS_FLAG,
             OUT_MESSAGE,
             CERT_NUMBER)
          VALUES
            (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
             P_TEMPLATE_CODE,
             P_VERSION_NUMBER,
             V_GL_DATE,
             P_PARAM,
             V_JE_BATCH_NAME,
             OUT_SUCESS_FLAG,
             OUT_MESSAGE,
             '');
          COMMIT;
          RETURN;
        END IF;
        --遍历
        FOR J IN 1 .. V_PARAMS_ARRAY.COUNT LOOP
          V_PARAM := V_PARAMS_ARRAY(J);
          --  V_INDEX:=V_INDEX+1;
          --替换SQL中的？号
          --SELECT  REGEXP_REPLACE(V_SQL,'[?]',V_PARAM,1,V_INDEX) INTO V_SQL  FROM DUAL;
          SELECT REGEXP_REPLACE(V_SQL, '[?？]', V_PARAM, 1, 1)
            INTO V_SQL
            FROM DUAL;
        END LOOP;
      
        DBMS_OUTPUT.PUT_LINE('SQL：' || V_SQL);
        --执行sql
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO V_AMOUNT;
        EXCEPTION
          WHEN OTHERS THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '执行获取金额SQL出错，原因：' || SQLERRM;
            --插入日志
            INSERT INTO SPM_GZ_IMPORT_CERT_LOG
              (LOG_ID,
               TEMPLATE_CODE,
               VERSION_NUMBER,
               GL_DATE,
               PARAM,
               JE_BATCH_NAME,
               SUCESS_FLAG,
               OUT_MESSAGE,
               CERT_NUMBER)
            VALUES
              (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
               P_TEMPLATE_CODE,
               P_VERSION_NUMBER,
               V_GL_DATE,
               P_PARAM,
               V_JE_BATCH_NAME,
               OUT_SUCESS_FLAG,
               OUT_MESSAGE,
               '');
            COMMIT;
            RETURN;
        END;
        -- DBMS_OUTPUT.put_line('金额：'||V_AMOUNT);
        --更新金额
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = NVL(V_AMOUNT, 0)
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      --当取值类型为对应行号时   
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '2') LOOP
        SELECT SUM(AMOUNT)
          INTO V_AMOUNT
          FROM SPM_GZ_CERT_ITEM_TEMP
         WHERE DRCR_TYPE <> I.DRCR_TYPE
           AND CORRESPOND_LINE = I.AMOUNT;
        --更新金额
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = V_AMOUNT
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      COMMIT;
      --判断借贷总金额是否相等
      SELECT SUM(NVL(AMOUNT, 0))
        INTO V_DR_AMOUNT
        FROM SPM_GZ_CERT_ITEM_TEMP
       WHERE DRCR_TYPE = 'DR';
      SELECT SUM(NVL(AMOUNT, 0))
        INTO V_CR_AMOUNT
        FROM SPM_GZ_CERT_ITEM_TEMP
       WHERE DRCR_TYPE = 'CR';
      IF V_DR_AMOUNT <> V_CR_AMOUNT THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '借贷总金额不相等。';
        --插入日志
        INSERT INTO SPM_GZ_IMPORT_CERT_LOG
          (LOG_ID,
           TEMPLATE_CODE,
           VERSION_NUMBER,
           GL_DATE,
           PARAM,
           JE_BATCH_NAME,
           SUCESS_FLAG,
           OUT_MESSAGE,
           CERT_NUMBER)
        VALUES
          (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
           P_TEMPLATE_CODE,
           P_VERSION_NUMBER,
           V_GL_DATE,
           P_PARAM,
           V_JE_BATCH_NAME,
           OUT_SUCESS_FLAG,
           OUT_MESSAGE,
           '');
        COMMIT;
        RETURN;
      END IF;
      --构造批次名称
      V_JE_BATCH_NAME := V_ORG_CODE || TO_CHAR(V_GL_DATE, 'YYYY') ||
                         TO_CHAR(V_GL_DATE, 'MM') ||
                         TO_CHAR(V_GL_DATE, 'DD') || V_TEMPLATE_NAME ||
                         P_VERSION_NUMBER;
      --将临时表中的数据插入到总账中间表
      INSERT INTO CUX_GL_INTERFACE_DATA
        (GL_DATA_ID,
         GL_DATA_SOURCE,
         JE_BATCH_NAME,
         BATCH_DESCRIPTION,
         JE_HEADER_NAME,
         HEADER_DESCRIPTION,
         GL_DATE,
         CURRENCY_CODE,
         JE_LINE_NUM,
         JE_LINE_DESCRIPTION,
         ENTERED_DR,
         ENTERED_CR,
         DATA_STATUS,
         OBJECT_VERSION_NUMBER,
         OPERATE_DATE,
         BUSINESS_TYPE,
         USER_JE_SOURCE_NAME,
         USER_JE_CATEGORY_NAME,
         PERIOD_NAME,
         GL_SET_OF_BOOK_ID,
         ATTRIBUTE4,
         SEGMENT1,
         SEGMENT2,
         SEGMENT3,
         SEGMENT4,
         SEGMENT5,
         SEGMENT6,
         SEGMENT7,
         SEGMENT8,
         SEGMENT9,
         SEGMENT10,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_LOGIN,
         CREATION_DATE,
         CREATED_BY)
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL, T.*
          FROM (SELECT 'SPM系统',
                       V_JE_BATCH_NAME, -- 账批号
                       TO_CHAR(V_GL_DATE, 'YYYY') ||
                       TO_CHAR(V_GL_DATE, 'MM') || TO_CHAR(V_GL_DATE, 'DD') ||
                       V_TEMPLATE_NAME,
                       V_TEMPLATE_NAME BATCH_DESCRIPTION,
                       V_TEMPLATE_NAME JE_HEADER_NAME,
                       V_GL_DATE GL_DATE,
                       'CNY',
                       LINE_NUMBER,
                       SUMMARY,
                       DECODE(DRCR_TYPE, 'DR', AMOUNT, 0),
                       DECODE(DRCR_TYPE, 'CR', AMOUNT, 0),
                       'NEW',
                       P_VERSION_NUMBER,
                       V_GL_DATE,
                       '用户',
                       '工资系统',
                       '记账',
                       TO_CHAR(V_GL_DATE, 'YYYYMM'),
                       2021,
                       CASH_FLOW,
                       SEGMENT1,
                       SEGMENT2,
                       SEGMENT3,
                       SEGMENT4,
                       SEGMENT5,
                       SEGMENT6,
                       SEGMENT7,
                       SEGMENT8,
                       SEGMENT9,
                       SEGMENT10,
                       SYSDATE LAST_UPDATE_DATE,
                       LAST_UPDATED_BY,
                       LAST_UPDATE_LOGIN,
                       SYSDATE CREATION_DATE,
                       CREATED_BY
                  FROM SPM_GZ_CERT_ITEM_TEMP
                 ORDER BY LINE_NUMBER) T;
      COMMIT;
      --执行生成总账凭证数据
      CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => OUT_MESSAGE,
                             RETCODE         => OUT_SUCESS_FLAG,
                             P_DATA_SOURCE   => 'SPM系统',
                             P_JE_BATCH_NAME => V_JE_BATCH_NAME,
                             P_REPEANT       => 'Y');
    
      --  IF OUT_SUCESS_FLAG = 'S' THEN
      --T_RETURN_CODE := G_INTERFACE_SUCCESS;
      -- OUT_SUCESS_FLAG    := 'S';
      SELECT DECODE(DATA_STATUS, 'FAIL', 'E', 'S') DATA_STATUS, FAIL_RESON
        INTO OUT_SUCESS_FLAG, OUT_MESSAGE
        FROM CUX_GL_INTERFACE_DATA
       WHERE OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
         AND ROWNUM = 1;
      IF OUT_SUCESS_FLAG = 'S' THEN
      
        --查询生成后的批次名
        SELECT JE_BATCH_ID, NAME
          INTO V_JE_BATCH_ID, V_JE_BATCH_NAME
          FROM GL_JE_BATCHES
         WHERE NAME LIKE '%' || V_JE_BATCH_NAME || '%';
      
        V_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('SQLGL',
                                                   'GLPPOSS',
                                                   '自动过账',
                                                   NULL,
                                                   FALSE,
                                                   2021,
                                                   1000, -- NEW PARAMETER
                                                   50348,
                                                   V_JE_BATCH_ID,
                                                   CHR(0));
        IF V_REQUEST_ID <= 0 THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '自动过账并发请求提交失败';
          RETURN;
        ELSE
          UPDATE GL_JE_BATCHES T
             SET T.STATUS         = 'S',
                 T.POSTING_RUN_ID = V_JE_BATCH_ID,
                 T.REQUEST_ID     = V_REQUEST_ID
           WHERE T.JE_BATCH_ID = V_JE_BATCH_ID;
          COMMIT;
          L_WAIT_REQ := FND_CONCURRENT.WAIT_FOR_REQUEST(V_REQUEST_ID,
                                                        1,
                                                        0,
                                                        L_CHILD_PHASE,
                                                        L_CHILD_STATUS,
                                                        L_DEV_PHASE,
                                                        L_DEV_STATUS,
                                                        L_MESSAGE);
          IF L_CHILD_STATUS <> INITCAP('正常') THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '自动过账并发请求提交失败';
            RETURN;
          ELSE
            OUT_SUCESS_FLAG := 'S';
            OUT_MESSAGE     := '生成总账凭证数据成功';
          END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('V_JE_BATCH_ID:' || V_JE_BATCH_ID);
        --凭证号 只有过账后侧能生成凭证号 
        SELECT JH.EXTERNAL_REFERENCE, JB.NAME, JH.JE_HEADER_ID
          INTO V_CERT_NUMBER, V_JE_BATCH_NAME, V_HEADER_ID
          FROM GL_JE_BATCHES JB, GL_JE_HEADERS JH
         WHERE JH.JE_BATCH_ID = JB.JE_BATCH_ID
           AND JB.JE_BATCH_ID = V_JE_BATCH_ID;
        DBMS_OUTPUT.PUT_LINE('V_HEADER_ID:' || V_HEADER_ID);
      
        --更新附件张数
        UPDATE GL_JE_HEADERS GJH
           SET ATTRIBUTE1 = V_ATTACH_CNT
         WHERE GJH.JE_HEADER_ID = V_HEADER_ID;
        --更新总账头表中的现金流信息
        FOR CASH IN (SELECT *
                       FROM SPM_GZ_CERT_ITEM_TEMP
                      WHERE CASH_FLOW IS NOT NULL) LOOP
          UPDATE GL_JE_LINES GJL
             SET GJL.ATTRIBUTE4 = CASH.CASH_FLOW
           WHERE GJL.JE_HEADER_ID = V_HEADER_ID
             AND EXISTS
           (SELECT 1
                    FROM GL_CODE_COMBINATIONS GCC
                   WHERE GCC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
                     AND GCC.SEGMENT1 = CASH.SEGMENT1
                     AND GCC.SEGMENT2 = CASH.SEGMENT2
                     AND GCC.SEGMENT3 = CASH.SEGMENT3
                     AND GCC.SEGMENT4 = CASH.SEGMENT4
                     AND GCC.SEGMENT5 = CASH.SEGMENT5
                     AND GCC.SEGMENT6 = CASH.SEGMENT6
                     AND GCC.SEGMENT7 = CASH.SEGMENT7
                     AND GCC.SEGMENT8 = CASH.SEGMENT8
                     AND GCC.SEGMENT9 = CASH.SEGMENT9
                     AND GCC.SEGMENT10 = CASH.SEGMENT10);
        END LOOP;
      
      END IF;
    
      /*  ELSIF OUT_SUCESS_FLAG <> 'S' OR OUT_SUCESS_FLAG IS NULL THEN
      DELETE FROM CUX_GL_INTERFACE_DATA CD
      WHERE CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER;
      COMMIT;*/
      --  END IF;   
    
    EXCEPTION
      WHEN OTHERS THEN
        OUT_SUCESS_FLAG := 'E';
        OUT_MESSAGE     := '生成总账凭证数据失败，原因：' || SQLERRM;
        -- RETURN;
    END;
    DBMS_OUTPUT.PUT_LINE('OUT_MESSAGE:' || OUT_MESSAGE);
    DBMS_OUTPUT.PUT_LINE('OUT_SUCESS_FLAG:' || OUT_SUCESS_FLAG);
  
    --插入日志
    INSERT INTO SPM_GZ_IMPORT_CERT_LOG
      (LOG_ID,
       TEMPLATE_CODE,
       VERSION_NUMBER,
       GL_DATE,
       PARAM,
       JE_BATCH_NAME,
       SUCESS_FLAG,
       OUT_MESSAGE,
       CERT_NUMBER)
    VALUES
      (SPM_GZ_IMPORT_CERT_LOG_SEQ.NEXTVAL,
       P_TEMPLATE_CODE,
       P_VERSION_NUMBER,
       V_GL_DATE,
       P_PARAM,
       V_JE_BATCH_NAME,
       OUT_SUCESS_FLAG,
       OUT_MESSAGE,
       V_CERT_NUMBER);
    COMMIT;
  END IMPORT_GL_CRRT_BY_TEMPLATE_GZ;
--付款提交以及制证时校验资金计划额度是否足够
--K_PAYMENT_IDS 付款单主键S   K_TYPE 类型  1:提交   2:导入
--区分提交以及导入的主要原因是因为提交的时候还没财务录入子表信息
FUNCTION CHECK_CAPITAL_BALANCE_FOR_PAY(K_PAYMENT_IDS VARCHAR2,
                                       K_TYPE        VARCHAR2)
  RETURN VARCHAR2 IS
  RE_MEG                VARCHAR2(2); --返回的校验结果   金额充足 :Y ,金额不够 :N
  K_CAPITAL_ID          NUMBER; --资金计划额度主键
  K_NUMBER              NUMBER; --差值
  K_DEPT_ID             VARCHAR2(40);
  IDS                   SPM_TYPE_TBL;
  K_PAY_PURPOSE         VARCHAR(40); --付款用途,招标--结服务费 24 不进行校验
  K_PLAN_FLAG           VARCHAR(40); --付款类型 区分新旧付款  'Y' :新付款  'N':旧付款 为了区分付款账户在头还是行信息中
  K_PAY_BANK_ACCOUNT_ID NUMBER; --付款银行 11002 不校验
  JS_NUMBER             NUMBER;
  USED_NUMBER           NUMBER;--已经被提交占用额度
  /*K_DEPT_ID             NUMBER;*/
  BIG_DEPT_CODE         VARCHAR2(40);--大部门编号
  K_CHECK               VARCHAR2(40);
BEGIN

  --1.根据登录人的部门主键获取资金计划额度主键
  /*SELECT TO_CHAR(T.ORGANIZATION_ID)
    INTO K_DEPT_ID
    FROM SPM_CON_HT_PEOPLE_V T
   WHERE ROWNUM < 2
     AND T.BELONGORGID = SPM_SSO_PKG.GETORGID
     AND T.USER_ID = SPM_SSO_PKG.GETUSERID;

  K_CAPITAL_ID := SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(K_DEPT_ID);

  IF K_CAPITAL_ID IS NULL THEN
    RE_MEG := 'N';
  ELSE
    --2.获取资金计划额度剩余值
    SELECT P.THIS_MONTH_BALANCE
      INTO K_NUMBER
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.CAPITAL_ID = K_CAPITAL_ID;*/
     
     K_CHECK :='N';--默认未开启校验
  
    --IDS(I)  24 招标--结服务费 
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(K_PAYMENT_IDS)
      INTO IDS
      FROM DUAL;
  
    --3.1导入的校验
    IF K_TYPE = '2' THEN
    
      FOR I IN 1 .. IDS.COUNT LOOP
        --是否是特殊 24 业务 
        SELECT P.PAY_PURPOSE, --付款用途
               NVL(P.PLAN_FLAG, 'N'), --新旧付款
               NVL(P.PAY_BANK_ACCOUNT_ID, 0), --付款银行
               TO_CHAR(P.DEPT_ID) --部门
          INTO K_PAY_PURPOSE, K_PLAN_FLAG, K_PAY_BANK_ACCOUNT_ID, K_DEPT_ID
          FROM SPM_CON_PAYMENT P
         WHERE P.PAYMENT_ID = IDS(I);
        
        --取数资金计划剩余额度
        IF K_NUMBER IS NULL THEN
           K_CAPITAL_ID := SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(K_DEPT_ID);
            IF K_CAPITAL_ID IS NULL THEN
              /*RE_MEG := 'N';
              RETURN RE_MEG;*/
              --解决无资金计划，无法提中转付款的情况，资金剩余额度赋0
              K_NUMBER := 0;
            ELSE
              --2.获取资金计划额度剩余值
              SELECT P.THIS_MONTH_BALANCE
                INTO K_NUMBER
                FROM SPM_CON_CAPITAL_PLAN P
               WHERE P.CAPITAL_ID = K_CAPITAL_ID;
            END IF;
        END IF;
      
       /* IF K_PAY_PURPOSE = '24' THEN
          CONTINUE;
        ELSE*/
          --旧付款
        IF K_PLAN_FLAG = 'N' THEN
          IF K_PAY_BANK_ACCOUNT_ID = 11002 THEN
            CONTINUE;
          ELSE
            SELECT H.MONEY_AMOUNT
              INTO JS_NUMBER
              FROM SPM_CON_PAYMENT H
             WHERE H.PAYMENT_ID = IDS(I);
            K_NUMBER := K_NUMBER - JS_NUMBER;
            K_CHECK :='Y';
          END IF;
        ELSE
          --新付款
          SELECT NVL(SUM(C.MONEY_AMOUNT), 0)
            INTO JS_NUMBER
            FROM SPM_CON_PAYMENT_CHILD C
           WHERE C.PAYMENT_ID = IDS(I)
             AND C.PAY_BANK_ACCOUNT_ID <> 11002
             AND NVL(C.STATUS, 'A') <> 'US';
          K_NUMBER := K_NUMBER - JS_NUMBER;
          K_CHECK :='Y';
        END IF;
       /* END IF;*/
      
      END LOOP;
    
      --3.2提交的校验 
    ELSE
    
      FOR I IN 1 .. IDS.COUNT LOOP
        --是否是特殊 24 业务 
        SELECT P.PAY_PURPOSE,
               NVL(P.PLAN_FLAG, 'N'),
               NVL(P.PAY_BANK_ACCOUNT_ID, 0), --付款银行
               TO_CHAR(P.DEPT_ID) --部门
          INTO K_PAY_PURPOSE, K_PLAN_FLAG, K_PAY_BANK_ACCOUNT_ID, K_DEPT_ID
          FROM SPM_CON_PAYMENT P
         WHERE P.PAYMENT_ID = IDS(I);
         
         --取数资金计划剩余额度
        IF K_NUMBER IS NULL THEN
           K_CAPITAL_ID := SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(K_DEPT_ID);
            IF K_CAPITAL_ID IS NULL THEN
              RE_MEG := 'N';
              RETURN RE_MEG;
            ELSE
              --2.获取（资金计划-制证额度）结余额度
              SELECT P.CAPITAL_QUOTA - P.PAY_AMOUNT
                INTO K_NUMBER
                FROM SPM_CON_CAPITAL_PLAN P
               WHERE P.CAPITAL_ID = K_CAPITAL_ID;
               
               --查询已经被付款单提交占用的金额
              /* select NVL(SUM(P.MONEY_AMOUNT), 0)
                 INTO USED_NUMBER
                 from SPM_CON_PAYMENT P
                WHERE P.MONTH_DETAIL_ID = K_CAPITAL_ID
                  AND P.PAYMENT_ID <> IDS(I)
                  AND NVL(P.PAY_PURPOSE, '1') <> '24'
                  AND P.STATUS NOT IN ('A','D')
                  AND NVL(P.EBS_STATUS,'KK') <> 'R';*/
               SELECT HR.ATTRIBUTE6
                  INTO BIG_DEPT_CODE
                  FROM SPM_CON_PAYMENT P, HR_ALL_ORGANIZATION_UNITS HR
                 WHERE P.DEPT_ID = HR.ORGANIZATION_ID
                   AND P.PAYMENT_ID = IDS(I);
                   
               SELECT NVL(SUM(SP.MONEY_AMOUNT),0) INTO USED_NUMBER
                FROM SPM_CON_PAYMENT SP, HR_ALL_ORGANIZATION_UNITS SPCP
               WHERE NVL(SP.PAY_PURPOSE, '1') <> '24'
                 AND SP.DEPT_ID = SPCP.ORGANIZATION_ID
                 AND SP.PLAN_FLAG = 'Y'
                 AND SP.PAYMENT_ID <> IDS(I)
                 AND NVL(SP.EBS_STATUS, 'N') NOT IN ('R', 'US')
                 AND SP.STATUS NOT IN ('A', 'D')
                 AND SPCP.ATTRIBUTE6 = BIG_DEPT_CODE;


               
               K_NUMBER:= K_NUMBER - USED_NUMBER;

               
            END IF;
        END IF;
      
        IF K_PAY_PURPOSE = '24' THEN
          CONTINUE;
        ELSE
          SELECT H.MONEY_AMOUNT
                INTO JS_NUMBER
                FROM SPM_CON_PAYMENT H
               WHERE H.PAYMENT_ID = IDS(I);
          K_NUMBER := K_NUMBER - JS_NUMBER;
          K_CHECK :='Y';
          --旧付款
         /* IF K_PLAN_FLAG = 'N' THEN
            IF K_PAY_BANK_ACCOUNT_ID = 11002 THEN
              CONTINUE;
            ELSE
              SELECT H.MONEY_AMOUNT
                INTO JS_NUMBER
                FROM SPM_CON_PAYMENT H
               WHERE H.PAYMENT_ID = IDS(I);
              K_NUMBER := K_NUMBER - JS_NUMBER;
            END IF;
          ELSE
            --新付款
            SELECT H.MONEY_AMOUNT
              INTO JS_NUMBER
              FROM SPM_CON_PAYMENT H
             WHERE H.PAYMENT_ID = IDS(I);
            K_NUMBER := K_NUMBER - JS_NUMBER;
          END IF;*/
        END IF;
      
      END LOOP;
    END IF;
    IF K_CHECK = 'Y' THEN
      IF K_NUMBER >= 0 THEN
        RE_MEG := 'Y';
      ELSE
        RE_MEG := 'N';
      END IF;
    ELSE 
      RE_MEG := 'Y';
    END IF;
  /*END IF;*/

  RETURN RE_MEG;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'N';
END CHECK_CAPITAL_BALANCE_FOR_PAY;
/*--校验退票提交时 对应蓝票剩余金额是否充足  Y:充足  N:*/
FUNCTION CHECK_RETURN_INVOICE_SUBMIT(K_OUTPUT_ID NUMBER) RETURN VARCHAR2 IS
  CURSOR S(P_OUTPUT_ID NUMBER) IS
    select O.INVOICE_SERIAL_NUMBER,
           O.RESIDUAL_AMOUNT,
           SUM(P.MONEY_AMOUNT) USED_AMOUNT
      FROM SPM_CON_OUTPAPER_RETURN R,
           SPM_CON_PAPER_INVOICE   P,
           SPM_CON_OUTPUT_INVOICE  O
     WHERE 1 = 1
       AND P.INVOICE_ID = O.OUTPUT_INVOICE_ID
       AND R.PAPER_INVOICE_ID = P.PAPER_INVOICE_ID
       AND P.INVOICE_TYPE = 'AR'
       AND R.OUTPUT_INVOICE_ID = P_OUTPUT_ID
     GROUP BY O.INVOICE_SERIAL_NUMBER, O.RESIDUAL_AMOUNT;
  RETURN_MSG VARCHAR2(2000);
BEGIN
  RETURN_MSG := '';
  FOR SP IN S(K_OUTPUT_ID) LOOP
    --如果退票额度大于剩余金额
    IF SP.USED_AMOUNT > SP.RESIDUAL_AMOUNT THEN
      RETURN_MSG := RETURN_MSG || '单据号为' || sp.invoice_serial_number ||
                    '的销项发票剩余金额不足;';
    END IF;
  END LOOP;
  IF LENGTH(RETURN_MSG) > 0 THEN
    RETURN RETURN_MSG;
  ELSE
    RETURN 'Y';
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 'N';
END CHECK_RETURN_INVOICE_SUBMIT;

--撤销业务收款核销销项发票
PROCEDURE CANCEL_YW_RECEIPT_INVOICE(K_RECEIPT_INVOICE_IDS IN VARCHAR2,
                                    MSG                   OUT VARCHAR2)

 IS
  IDS       SPM_TYPE_TBL;
  JS_AMOUNT NUMBER;--核销金额
  OUT_ID    NUMBER;--销项发票主键
BEGIN
  SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(K_RECEIPT_INVOICE_IDS)
    INTO IDS
    FROM DUAL;
  FOR I IN 1 .. IDS.COUNT LOOP
  
    select T.MONEY_AMOUNT, T.OUTPUT_INVOICE_ID
      INTO JS_AMOUNT, OUT_ID
      from SPM_CON_RECEIPT_INVOICE T
     WHERE T.RECEIPT_INVOICE_ID = IDS(I);
  
    UPDATE SPM_CON_OUTPUT_INVOICE T
       SET T.RESIDUAL_AMOUNT = T.RESIDUAL_AMOUNT + JS_AMOUNT
     WHERE T.OUTPUT_INVOICE_ID = OUT_ID;
  
    DELETE SPM_CON_RECEIPT_INVOICE T WHERE T.RECEIPT_INVOICE_ID = IDS(I);
    
  END LOOP;
  MSG := 'Y';
EXCEPTION
  WHEN OTHERS THEN
    MSG := '存储过程执行异常';
END CANCEL_YW_RECEIPT_INVOICE;

END SPM_GZ_GZGL_INS_PKG;
/
