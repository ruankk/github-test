CREATE OR REPLACE PACKAGE SPM_CON_ODO_PKG IS
  --SPM_CON_ODO_PKG为包名

  /**
  * @AUTHOR: 张龙龙
  * @DATE:2017.09.24
  * @DESC : 流程审批,将审批历史插入流程历史记录表 暂时能用,后续优化异常处理
  * @PARAM P_ITEM_KEY ITEM_KEY
  * @PARAM P_OTYPE_CODE 流程CODE
  * @PARAM ASS_TABLE_NAME
  *        业务表名称
  * @PARAM ASS_TABLE_STATUS
  *        业务表STATUS字段名称,填写此字段名称后,在活动表审批进行过程中,会回填该字段的状态
  * @PARAM FK_NAME
  *        活动表存储业务表主键的字段,没有活动表不填
  * @PARAM ASS_TABLE_PKNAME
  *        业务表主键字段名称
  */
  PROCEDURE SAVE_WF_HISTORY(P_ITEM_KEY       IN VARCHAR2,
                            P_OTYPE_CODE     VARCHAR2,
                            ASS_TABLE_NAME   IN VARCHAR2,
                            ASS_TABLE_STATUS IN VARCHAR2,
                            FK_NAME          IN VARCHAR2,
                            ASS_TABLE_PKNAME IN VARCHAR2,
                            CREDATE          IN VARCHAR2 DEFAULT 'CREATION_DATE');

  /**
  * @AUTHOR : 张龙龙
  * @DATE : 2017.12.05
  * @DESC : 通知生成后触发的回调函数(公用)
  * @PARAM P_NOTIFID 通知ID
  * @PARAM P_ITEMKEY 流程ITEMKEY
  * @PARAM P_OTYPE_CODE 流程CODE
  * @PARAM ASS_TABLE 业务表名称,在活动表审批进行过程中,会回填该字段的状态
  * @PARAM ASS_COL_PKNAME 业务表主键名
  * @PARAM ASS_COL_STATUS 业务表状态字段名称
  * @PARAM ASS_COL_ITEMKEY 业务表ITEM_KEY字段名称
  * @PARAM STATUS_REJECT 驳回后流程状态
  * @PARAM STATUS_PASSED 通过后的流程状态
  */
  PROCEDURE GENERATE_HISTORY_INFO(P_NOTIFID       IN VARCHAR2,
                                  P_ITEMKEY       IN VARCHAR2,
                                  P_OTYPE_CODE    IN VARCHAR2,
                                  ASS_TABLE       IN VARCHAR2,
                                  ASS_COL_PKNAME  IN VARCHAR2,
                                  ASS_COL_STATUS  IN VARCHAR2,
                                  ASS_COL_ITEMKEY IN VARCHAR2,
                                  STATUS_REJECT   IN VARCHAR2,
                                  STATUS_PASSED   IN VARCHAR2);
  --通知处理后触发的回调函数(公用)
  PROCEDURE UPDATE_HISTORY_INFO(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);

  --退货单流程发起
  PROCEDURE SPM_CON_WF_SALES_RETURN_TJ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --退货单驳回回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_BH(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2);
  --退货单批准回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_PZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       VPOSITOIN_ID IN VARCHAR2);
  --退货单通过回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_TG(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2);

  --入库单导入
  PROCEDURE WAREHOUSE_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);
  --验证入库单录入有效性
  PROCEDURE WAREHOUSE_VALIDATE(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  --出库单导入
  PROCEDURE ODO_DL_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2);
  --验证出库单录入有效性
  PROCEDURE ODO_DL_VALIDATE(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2);
  --入库单管道导入
  PROCEDURE WAREHOUSE_DL_GG_IMPORT(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   F_TABLENAME VARCHAR2,
                                   F_TABLEID   VARCHAR2,
                                   P_MSG       OUT VARCHAR2);
  --验证入库单录入有效性
  PROCEDURE WAREHOUSE_DL_GG_VALIDATE(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     P_MSG       OUT VARCHAR2);

  --出库单导入(电商)
  PROCEDURE DS_ODO_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2);
  --验证入库单录入有效性（电商）
  PROCEDURE DS_ODO_VALIDATE(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2);

  --入库单导入(电商)
  PROCEDURE DS_WAREHOUSE_IMPORT(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                F_TABLENAME VARCHAR2,
                                F_TABLEID   VARCHAR2,
                                P_MSG       OUT VARCHAR2);
  --验证出库单录入有效性（电商）
  PROCEDURE DS_WAREHOUSE_VALIDATE(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  P_MSG       OUT VARCHAR2);

  --采购结果导入
  PROCEDURE PURCHASE_RESULT_IMPORT(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   F_TABLENAME VARCHAR2,
                                   F_TABLEID   VARCHAR2,
                                   P_MSG       OUT VARCHAR2);
  --验证采购结果录入有效性
  PROCEDURE PURCHASE_RESULT_VALIDATE(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     P_MSG       OUT VARCHAR2);

  --资产减值导入
  PROCEDURE ASSETS_IMPAIRMENT_IMPORT(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     F_TABLENAME VARCHAR2,
                                     F_TABLEID   VARCHAR2,
                                     P_MSG       OUT VARCHAR2);
  --验证资产减值有效性
  PROCEDURE ASSETS_IMPAIRMENT_VALIDATE(P_TABLENAME VARCHAR2,
                                       P_TABLEID   VARCHAR2,
                                       P_BATCHCODE VARCHAR2,
                                       P_MSG       OUT VARCHAR2);

  --合同台账导入
  PROCEDURE HT_IMPORT(P_TABLENAME VARCHAR2,
                      P_TABLEID   VARCHAR2,
                      P_BATCHCODE VARCHAR2,
                      F_TABLENAME VARCHAR2,
                      F_TABLEID   VARCHAR2,
                      P_MSG       OUT VARCHAR2);
  --验证合同台账导入有效性
  PROCEDURE HT_VALIDATE(P_TABLENAME VARCHAR2,
                        P_TABLEID   VARCHAR2,
                        P_BATCHCODE VARCHAR2,
                        P_MSG       OUT VARCHAR2);

  --合同台账导入
  PROCEDURE HT_ORDER_IMPORT(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            F_TABLENAME VARCHAR2,
                            F_TABLEID   VARCHAR2,
                            P_MSG       OUT VARCHAR2);
  --验证合同台账导入有效性
  PROCEDURE HT_ORDER_VALIDATE(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              P_MSG       OUT VARCHAR2);

  --验证标的物录入有效性
  PROCEDURE HT_TARGET_VALIDATE(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);

  --标的物导入
  PROCEDURE HT_TARGET_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             
                             P_MSG OUT VARCHAR2);
  --显示字典名称
  FUNCTION GET_DICTNAME_BY_CODE(TYPE_CODE_IN IN VARCHAR2,
                                DICT_CODE_IN IN VARCHAR2) RETURN VARCHAR2;

  --显示字典ABCD
  FUNCTION GET_DICTCODE_BY_NAME(TYPE_CODE_IN IN VARCHAR2,
                                DICT_CODE_IN IN VARCHAR2) RETURN VARCHAR2;

  --验证员工工资录入有效性
  PROCEDURE PERSON_SALARY_VALIDATE(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   P_MSG       OUT VARCHAR2);
  -- 导入员工工资及员工信息
  --标的物导入
  PROCEDURE PERSON_SALARY_IMPORT(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 F_TABLENAME VARCHAR2,
                                 F_TABLEID   VARCHAR2,
                                 P_MSG       OUT VARCHAR2);
  PROCEDURE INSERT_ORGANIZATION(LINE NUMBER);

  --入库单审批HTML展现
  FUNCTION CLS_WAREHOUSE_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --验证标的物入有效性
  PROCEDURE HT_TARGET_VALIDATE1(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);

  --标的物导入
  PROCEDURE HT_TARGET_IMPORT1(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              
                              P_MSG OUT VARCHAR2);

  --出库单审批HTML展现
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --交货计划审批HTML展现
  FUNCTION CLS_GOODS_PLAN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                        POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --退货单审批HTML展现
  FUNCTION CLS_SALES_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --入库单流程通知生成回调
  PROCEDURE SPM_CON_WAREHOUSE_TZSC(P_NOTIFID IN VARCHAR2,
                                   
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --入库单流程通知处理(后)回调
  PROCEDURE SPM_CON_WAREHOUSE_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);

  --出库单流程通知生成回调
  PROCEDURE SPM_CON_ODO_TZSC(P_NOTIFID IN VARCHAR2,
                             
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2);

  --出库单流程通知处理(后)回调
  PROCEDURE SPM_CON_ODO_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2);

  --交货计划流程通知生成回调
  PROCEDURE SPM_CON_GOODS_PLAN_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --交货计划流程通知处理(后)回调
  PROCEDURE SPM_CON_GOODS_PLAN_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --退货单流程通知生成回调
  PROCEDURE SPM_CON_SALES_RETURN_TZSC(P_NOTIFID IN VARCHAR2,
                                      
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --退货单流程通知处理(后)回调
  PROCEDURE SPM_CON_SALES_RETURN_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);

  --退货单计算出库量
  PROCEDURE SPM_CON_COUNT_SALES_RETURN(ID NUMBER);

  --校验所有的物料编码都在EBS
  FUNCTION VALIDATE_EBSCODE(P_ID NUMBER) RETURN VARCHAR2;

  --校验所有的退货数量不能所有的都为0
  PROCEDURE VALIDATE_SALES_RETURN(P_ID NUMBER, OUT_MSG OUT VARCHAR2);

  --序列
  PROCEDURE SEQ_RESET(V_SEQNAME VARCHAR2);

  FUNCTION GET_STRARRAYSTROFINDEX(AV_STR   VARCHAR2, --要分割的字符串
                                  AV_SPLIT VARCHAR2, --分隔符号
                                  AV_INDEX NUMBER --取第几个元素
                                  ) RETURN VARCHAR2;
  PROCEDURE CHAYI;

  PROCEDURE RELATION;

  PROCEDURE FUJIAN(ID NUMBER, V_NAME VARCHAR2);

  PROCEDURE CREATE_WAREHOUSE_BY_HT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE CREATE_WAREHOUSE_BY_DSHT_ORDER(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2);
  PROCEDURE CREATE_WAREHOUSE_BY_DHD(IDS VARCHAR2, P_MSG OUT VARCHAR2);

  PROCEDURE CREATE_ODO_BY_HT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE CREATE_ODO_BY_DSHT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE CREATE_ODO_BY_WAREHOUSE(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_WAREHOUSE_STATUS_TO_C(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_WAREHOUSE_STATUS_TO_E(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_ODO_STATUS_TO_C(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_ODO_STATUS_TO_E(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE BATCH_CLAIM(IDS VARCHAR2, P_MSG OUT VARCHAR2);

  /*  FUNCTION FN_SPLIT (P_STR IN VARCHAR2, P_DELIMITER IN VARCHAR2)
  RETURN TY_STR_SPLIT;   */

  /*     FUNCTION STRSPLIT(P_VALUE VARCHAR2, P_SPLIT VARCHAR2 := ',')
  RETURN STRSPLIT_TYPE;*/
  PROCEDURE DSSM_TO_PUR_ORDER(P_MSG OUT VARCHAR2);
  PROCEDURE DSSM_TO_SALE_ORDER(P_MSG OUT VARCHAR2);
  PROCEDURE DSSM_TO_GOODS_ARRIVAL(P_MSG OUT VARCHAR2);
  PROCEDURE DSSM_TO_CONNECT;
  PROCEDURE DSSM_TO_GOODS_ARRIVAL1(P_MSG OUT VARCHAR2);
  PROCEDURE AUTO_WAREHOUSE_BY_DHD(P_MSG OUT VARCHAR2);
  PROCEDURE AUTO_CREATE_ODO_BY_WAREHOUSE(P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_OUTPUT_STATUS_TO_C(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE GENERATE_OUTPUT_STATUS_TO_E(IDS VARCHAR2, P_MSG OUT VARCHAR2);
  PROCEDURE DS_BATCH_WAREHOUSE_TO_EBS;
  PROCEDURE DS_BATCH_ODO_TO_EBS;

  --入库单均摊成本计算
  FUNCTION WAREHOUSE_COST_SHARING(V_WAREHOUSE_DL_ID NUMBER) RETURN NUMBER;
  --多个框架时生效订单合同
  PROCEDURE BATCH_CLAIM_MANY_KJ(HT_ID VARCHAR2,
                                KJ_ID VARCHAR2,
                                P_MSG OUT VARCHAR2);
  /*
  查询出库单行中剩余金额
  V_ID 入库单行ID
  by mcq
  20180906*/
  FUNCTION GET_WAREHOUSE_DL_MONEY(V_ID IN NUMBER) RETURN NUMBER;
  
  --查询入库单中入库剩余副数量
  FUNCTION GET_WAGEHOUSE_DL_F(V_ID IN NUMBER) RETURN NUMBER;
  /*
   查询出库单对应销售合同的税率
  V_ID 合同ID
  by mcq
  20180906*/
  FUNCTION GET_ODO_HT_TARGET_INFO(V_ID IN NUMBER, V_TYPE VARCHAR2)
    RETURN NUMBER;

  /*
    根据到货单信息生成对应入库单信息
    BY MCQ
    20180911
  */
  PROCEDURE CREATE_WAREHOUSE_BY_MQ_GOODS(P_IDS IN VARCHAR2,
                                         P_MSG OUT VARCHAR2);

  -- 出库单出库
  PROCEDURE GENERATE_SALE_ORDER(V_ID            IN NUMBER,
                                V_USER_ID       IN NUMBER,
                                V_RESP_ID       IN NUMBER,
                                V_RESP_APP_ID   IN NUMBER,
                                V_ORG_ID        IN NUMBER,
                                V_RETURN_STATUS OUT VARCHAR2);

  -- 入库单入库
  PROCEDURE GENERATE_PURCHASING_ORDER(V_ID            IN NUMBER,
                                      V_USER_ID       IN NUMBER,
                                      V_RESP_ID       IN NUMBER,
                                      V_RESP_APP_ID   IN NUMBER,
                                      V_ORG_ID        IN NUMBER,
                                      V_RETURN_STATUS OUT VARCHAR2);
  --平均成本更新 ruankk 2018-12-17
  PROCEDURE AVERAGE_COST_RENEWAL(V_ID            IN NUMBER,
                                 KMCODE          IN VARCHAR2,--科目段
                                 XMCODE          IN VARCHAR2,--项目段
                                 V_RETURN_STATUS OUT VARCHAR2,
                                 V_RETURN_MSG    OUT VARCHAR2);
END SPM_CON_ODO_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_CON_ODO_PKG IS
  --包名必须一致

  /**
  * @AUTHOR: 张龙龙
  * @DATE:2017.09.24
  * @DESC : 流程审批,将审批历史插入流程历史记录表 暂时能用,后续优化异常处理
  * @PARAM P_ITEM_KEY ITEM_KEY
  * @PARAM P_OTYPE_CODE 流程CODE
  * @PARAM ASS_TABLE_NAME
  *        业务表名称
  * @PARAM ASS_TABLE_STATUS
  *        业务表STATUS字段名称,填写此字段名称后,在活动表审批进行过程中,会回填该字段的状态
  * @PARAM FK_NAME
  *        活动表存储业务表主键的字段,没有活动表不填
  * @PARAM ASS_TABLE_PKNAME
  *        业务表主键字段名称
  */
  PROCEDURE SAVE_WF_HISTORY(P_ITEM_KEY       IN VARCHAR2,
                            P_OTYPE_CODE     VARCHAR2,
                            ASS_TABLE_NAME   IN VARCHAR2,
                            ASS_TABLE_STATUS IN VARCHAR2,
                            FK_NAME          IN VARCHAR2,
                            ASS_TABLE_PKNAME IN VARCHAR2,
                            CREDATE          IN VARCHAR2 DEFAULT 'CREATION_DATE') AS
    TYPE SPM_WF_REGINFO_TYPE IS TABLE OF SPM_WF_REGINFO%ROWTYPE INDEX BY BINARY_INTEGER;
    WFRI         SPM_WF_REGINFO_TYPE;
    SV           NUMBER; --SEQUENCEVALUE存储序列值
    NR           NUMBER; --NEW RECORD 新审批记录的WF_ID
    PKVAL        NUMBER; --参与流程的主键ID
    PKNAME       VARCHAR2(32); --参与流程的主键列名
    VSQL         VARCHAR2(2000);
    VSTATUS      VARCHAR2(40);
    RECEVIEDATE  DATE; --接收时间
    VCOU         NUMBER;
    V_UP_POSITON NUMBER; --当前流程所处的审批节点
    IS_EXIST     VARCHAR2(1);
  BEGIN
    --STEP1.根据流程CODE获取流程的配置信息
    SELECT *
      BULK COLLECT
      INTO WFRI
      FROM SPM_WF_REGINFO S
     WHERE S.WF_CODE = P_OTYPE_CODE;
    --STEP2.组装SQL，查询PKVAL
    IF FK_NAME IS NULL THEN
      PKNAME := WFRI(1).WF_TAB_KEYNAME;
    ELSIF FK_NAME IS NOT NULL THEN
      PKNAME := FK_NAME;
    END IF;
    VSQL := 'SELECT ' || PKNAME || ',' || WFRI(1).WF_STATE_NAME || ' FROM ' || WFRI(1)
           .WF_TAB_NAME || ' WHERE ' || WFRI(1).WF_ID_NAME || ' = ''' ||
            P_ITEM_KEY || '''';
    EXECUTE IMMEDIATE VSQL
      INTO PKVAL, VSTATUS;
  
    --STEP3.获取序列
    SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
  
    --STEP4.获取新审批记录的WF_ID
    SELECT MAX(WF_ID)
      INTO NR
      FROM CUX_WF_HISTORY_INFO S
     WHERE S.AUDIT_INFO IS NOT NULL
       AND WF_ITEMKEY = P_ITEM_KEY;
  
    --STEP5.获取接收时间
    SELECT NVL(MAX(WF_HISTORY_ID), 0)
      INTO VCOU
      FROM SPM_CON_WF_HISTORY
     WHERE WF_ITEMKEY = P_ITEM_KEY;
  
    IF VCOU = 0 THEN
      VSQL := 'SELECT ' || CREDATE || ' FROM ' || WFRI(1).WF_TAB_NAME ||
              ' WHERE ' || WFRI(1).WF_ID_NAME || ' = ''' || P_ITEM_KEY || '''';
      EXECUTE IMMEDIATE VSQL
        INTO RECEVIEDATE;
    ELSIF VCOU > 0 THEN
      SELECT AUDIT_DATE
        INTO RECEVIEDATE
        FROM SPM_CON_WF_HISTORY
       WHERE WF_ITEMKEY = P_ITEM_KEY
         AND WF_HISTORY_ID = VCOU;
    END IF;
  
    --STEP6.插入历史表
    SELECT SPM_CON_CONTRACT_PKG.JUDGE_IS_EXIST_HISTORY(P_ITEM_KEY,
                                                       S.AUDIT_DATE)
      INTO IS_EXIST
      FROM CUX_WF_HISTORY_INFO S, CCM_WF_PLAN_POSITION P
     WHERE S.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
       AND S.WF_ITEMKEY = P_ITEM_KEY
       AND S.WF_ID = NR;
  
    INSERT INTO SPM_CON_WF_HISTORY
      (WF_HISTORY_ID,
       ASS_TABLE_NAME,
       ASS_TABLE_PRIKEY_ID,
       ACT_TABLE_NAME,
       WF_ITEMKEY,
       WF_CODE,
       WF_NAME,
       WF_POSITION_ID,
       WF_POSITION_NAME,
       USER_ID,
       AUDIT_NAME,
       AUDIT_RESULT,
       AUDIT_INFO,
       RECEIVE_DATE,
       AUDIT_DATE,
       AUDIT_EFFICIENCY)
      SELECT SV,
             ASS_TABLE_NAME,
             PKVAL,
             WFRI(1).WF_TAB_NAME,
             S.WF_ITEMKEY,
             WFRI(1).WF_CODE,
             WFRI(1).OTYPE_NAME,
             P.WF_PLAN_POSITION_ID,
             P.WF_PLAN_POSITION_NAME,
             FND_GLOBAL.USER_ID,
             S.AUDIT_NAME,
             S.AUDIT_RESULT,
             S.AUDIT_INFO,
             RECEVIEDATE,
             S.AUDIT_DATE,
             SUBSTR(TO_CHAR(NUMTODSINTERVAL((S.AUDIT_DATE - RECEVIEDATE) * 24 * 60 * 60,
                                            'SECOND')),
                    9,
                    11)
        FROM CUX_WF_HISTORY_INFO S, CCM_WF_PLAN_POSITION P
       WHERE S.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
         AND S.WF_ITEMKEY = P_ITEM_KEY
         AND S.WF_ID = NR
         AND IS_EXIST = 'Y'
       ORDER BY S.AUDIT_DATE_CHAR;
    --STEP7.获得当前流程所处的父节点，如果是首个节点，则为空
    SELECT P.UP_WF_PLAN_POSITION_ID
      INTO V_UP_POSITON
      FROM CUX_WF_HISTORY_INFO S, CCM_WF_PLAN_POSITION P
     WHERE S.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
       AND S.WF_ITEMKEY = P_ITEM_KEY
       AND S.WF_ID = NR;
    --STEP8.更改业务表STATUS字段
    IF ASS_TABLE_STATUS IS NOT NULL AND ASS_TABLE_PKNAME IS NOT NULL AND
       V_UP_POSITON IS NOT NULL THEN
      VSQL := 'UPDATE ' || ASS_TABLE_NAME || ' SET ' || ASS_TABLE_STATUS ||
              ' = ''' || VSTATUS || '''' || ' WHERE ' || ASS_TABLE_PKNAME ||
              ' = ''' || PKVAL || '''';
      EXECUTE IMMEDIATE VSQL;
    END IF;
  
  END SAVE_WF_HISTORY;
  /**
  * @AUTHOR : 张龙龙
  * @DATE : 2017.12.05
  * @DESC : 通知生成后触发的回调函数(公用)
  * @PARAM P_NOTIFID 通知ID
  * @PARAM P_ITEMKEY 流程ITEMKEY
  * @PARAM P_OTYPE_CODE 流程CODE
  * @PARAM ASS_TABLE 业务表名称,在活动表审批进行过程中,会回填该字段的状态
  * @PARAM ASS_COL_PKNAME 业务表主键名
  * @PARAM ASS_COL_STATUS 业务表状态字段名称
  * @PARAM ASS_COL_ITEMKEY 业务表ITEM_KEY字段名称
  * @PARAM STATUS_REJECT 驳回后流程状态
  * @PARAM STATUS_PASSED 通过后的流程状态
  */
  PROCEDURE GENERATE_HISTORY_INFO(P_NOTIFID       IN VARCHAR2,
                                  P_ITEMKEY       IN VARCHAR2,
                                  P_OTYPE_CODE    IN VARCHAR2,
                                  ASS_TABLE       IN VARCHAR2,
                                  ASS_COL_PKNAME  IN VARCHAR2,
                                  ASS_COL_STATUS  IN VARCHAR2,
                                  ASS_COL_ITEMKEY IN VARCHAR2,
                                  STATUS_REJECT   IN VARCHAR2,
                                  STATUS_PASSED   IN VARCHAR2) AS
    TYPE SPM_WF_REGINFO_TYPE IS TABLE OF SPM_WF_REGINFO%ROWTYPE INDEX BY BINARY_INTEGER;
    WFRI SPM_WF_REGINFO_TYPE;
    TYPE WF_NOTIFICATIONS_TYPE IS TABLE OF WF_NOTIFICATIONS%ROWTYPE INDEX BY BINARY_INTEGER;
    WN              WF_NOTIFICATIONS_TYPE;
    SV              NUMBER; --SEQUENCEVALUE存储序列值
    PKVAL           NUMBER; --参与流程的主键ID
    VSQL            VARCHAR2(2000);
    V_STATUS        VARCHAR2(40);
    V_POSITION_ID   NUMBER;
    V_POSITION_NAME VARCHAR2(100);
    V_MSG_NAME      VARCHAR2(32);
    V_MSG_STATUS    VARCHAR2(32);
  BEGIN
  
    --获取通知信息
    SELECT *
      BULK COLLECT
      INTO WN
      FROM WF_NOTIFICATIONS S
     WHERE S.NOTIFICATION_ID = P_NOTIFID;
  
    --获取业务表主键值
    SELECT S.JOB_ID
      INTO PKVAL
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_ITEMKEY;
  
    IF WN(1).STATUS = 'OPEN' THEN
      /**
      * MESSAGE_NAME 值含义
      * MES_MEETING : 批准
      * MES_OK : 通过
      * MES_NO : 驳回
      */
      IF WN(1).MESSAGE_NAME = 'MES_MEETING' THEN
      
        --STEP1.根据流程CODE获取流程的配置信息
        SELECT *
          BULK COLLECT
          INTO WFRI
          FROM SPM_WF_REGINFO S
         WHERE S.WF_CODE = P_OTYPE_CODE;
      
        --STEP2.获取序列
        SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
      
        --STEP3.获取审批节点信息
        SELECT I.WF_POSITION_ID
          INTO V_POSITION_ID
          FROM CUX_WF_HISTORY_INFO I
         WHERE I.WF_ID = (SELECT MAX(WF_ID)
                            FROM CUX_WF_HISTORY_INFO
                           WHERE WF_ITEMKEY = P_ITEMKEY);
      
        SELECT PP.WF_PLAN_POSITION_NAME, SD.DICT_CODE
          INTO V_POSITION_NAME, V_STATUS
          FROM CCM_WF_OTYPE_POSITION OP,
               CCM_WF_PLAN_POSITION  PP,
               SPM_WF_PLAN_CAN_M     CM,
               SPM_DICT              SD
         WHERE OP.POSITION_STRUCTURE_ID = PP.WF_PLAN_ID
           AND PP.WF_PLAN_POSITION_ID = CM.PLAN_ID
           AND OP.OTYPE_CODE = P_OTYPE_CODE
           AND CM.STATUS = SD.DICT_ID
           AND PP.WF_PLAN_POSITION_ID = V_POSITION_ID;
      
        --STEP4.生成审批历史
        INSERT INTO SPM_CON_WF_HISTORY
          (WF_HISTORY_ID,
           NOTIFICATION_ID,
           ASS_TABLE_NAME,
           ASS_TABLE_PRIKEY_ID,
           ACT_TABLE_NAME,
           WF_ITEMKEY,
           WF_CODE,
           WF_NAME,
           WF_POSITION_ID,
           WF_POSITION_NAME,
           AUDIT_NAME,
           RECEIVE_DATE)
          SELECT SV,
                 P_NOTIFID,
                 A.JOB_TABLE,
                 A.JOB_ID,
                 WFRI(1).WF_TAB_NAME,
                 P_ITEMKEY,
                 A.WF_CODE,
                 A.WF_NAME,
                 V_POSITION_ID,
                 V_POSITION_NAME,
                 SPM_COMMON_PKG.GET_FULLNAME_BY_USERNAME(WN(1)
                                                         .RECIPIENT_ROLE),
                 SYSDATE
            FROM SPM_CON_WF_ACTIVITY A
           WHERE A.ITEM_KEY = P_ITEMKEY;
      
        --STEP5.修改主表状态
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || V_STATUS || ''',' || ASS_COL_ITEMKEY || ' = ''' ||
                P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME || ' = ''' ||
                PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      ELSIF WN(1).MESSAGE_NAME = 'MES_NO' THEN
        --流程驳回
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || STATUS_REJECT || ''',' || ASS_COL_ITEMKEY ||
                ' = ''' || P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME ||
                ' = ''' || PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      ELSIF WN(1).MESSAGE_NAME = 'MES_OK' THEN
        --流程通过
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || STATUS_PASSED || ''',' || ASS_COL_ITEMKEY ||
                ' = ''' || P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME ||
                ' = ''' || PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      END IF;
    
    END IF;
  END GENERATE_HISTORY_INFO;
  --通知处理后触发的回调函数(公用)
  PROCEDURE UPDATE_HISTORY_INFO(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
    TYPE CUX_WF_HISTORY_INFO_TYPE IS TABLE OF CUX_WF_HISTORY_INFO%ROWTYPE INDEX BY BINARY_INTEGER;
    CUX          CUX_WF_HISTORY_INFO_TYPE;
    POSITIONNAME VARCHAR2(32);
  BEGIN
  
    SELECT *
      BULK COLLECT
      INTO CUX
      FROM CUX_WF_HISTORY_INFO S
     WHERE S.WF_ID = (SELECT MAX(WF_ID)
                        FROM CUX_WF_HISTORY_INFO
                       WHERE WF_ITEMKEY = P_KEY);
  
    SELECT P.WF_PLAN_POSITION_NAME
      INTO POSITIONNAME
      FROM CUX_WF_HISTORY_INFO I, CCM_WF_PLAN_POSITION P
     WHERE I.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
       AND I.OTYE_CODE = P_OTYPE_CODE
       AND I.WF_ITEMKEY = P_KEY
       AND I.WF_ID = CUX(1).WF_ID;
  
    UPDATE SPM_CON_WF_HISTORY S
       SET S.WF_POSITION_ID   = CUX(1).WF_POSITION_ID,
           S.WF_POSITION_NAME = POSITIONNAME,
           S.AUDIT_RESULT     = CUX(1).AUDIT_RESULT,
           S.AUDIT_INFO       = CUX(1).AUDIT_INFO,
           S.AUDIT_DATE       = CUX(1).AUDIT_DATE,
           S.AUDIT_EFFICIENCY = SPM_CON_UTIL_PKG.GET_FORMAT_DATE(S.RECEIVE_DATE,
                                                                 CUX(1)
                                                                 .AUDIT_DATE,
                                                                 'CN')
     WHERE S.WF_ITEMKEY = P_KEY
       AND S.NOTIFICATION_ID = P_NOTIFID;
  
  END UPDATE_HISTORY_INFO;

  --退货单流程发起
  PROCEDURE SPM_CON_WF_SALES_RETURN_TJ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_SALES_RETURN
       SET STATUS = 'C', ITEM_KEY = ITEMKEY
     WHERE SALES_RETURN_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --退货单驳回回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_BH(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_SALES_RETURN
       SET STATUS = 'D'
     WHERE SALES_RETURN_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_SALES_RETURN',
                                         '',
                                         'JOB_ID',
                                         'SALES_RETURN_ID');
  
  END;

  --退货单批准回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_PZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_SALES_RETURN',
                                         'STATUS',
                                         'JOB_ID',
                                         'SALES_RETURN_ID');
  
  END;

  --退货单通过回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_TG(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_SALES_RETURN
       SET STATUS = 'E'
     WHERE SALES_RETURN_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_SALES_RETURN',
                                         '',
                                         'JOB_ID',
                                         'SALES_RETURN_ID');
  END;

  FUNCTION GET_DICTNAME_BY_CODE(TYPE_CODE_IN IN VARCHAR2,
                                DICT_CODE_IN IN VARCHAR2) RETURN VARCHAR2 IS
    RESULT VARCHAR2(400);
    /**
      DICT_CODE_IN:传入DICT_CODE 数据字典编码
      TYPE_CODE_IN:传入TYPE_CODE 数据字典类型编码
      返回数据字典名称;
    */
  BEGIN
    SELECT DICT_NAME
      INTO RESULT
      FROM SPM_DICT D
      LEFT JOIN SPM_DICT_TYPE DT
        ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
     WHERE D.DICT_CODE = DICT_CODE_IN
       AND DT.TYPE_CODE = TYPE_CODE_IN;
    RETURN(RESULT);
  END GET_DICTNAME_BY_CODE;

  FUNCTION GET_DICTCODE_BY_NAME(TYPE_CODE_IN IN VARCHAR2,
                                DICT_CODE_IN IN VARCHAR2) RETURN VARCHAR2 IS
    RESULT VARCHAR2(400);
  
  BEGIN
    SELECT D.DICT_CODE
      INTO RESULT
      FROM SPM_DICT D
      LEFT JOIN SPM_DICT_TYPE DT
        ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
     WHERE D.DICT_NAME = DICT_CODE_IN
       AND DT.TYPE_CODE = TYPE_CODE_IN;
    RETURN(RESULT);
  END GET_DICTCODE_BY_NAME;

  FUNCTION GET_STRARRAYSTROFINDEX(AV_STR   VARCHAR2, --要分割的字符串
                                  AV_SPLIT VARCHAR2, --分隔符号
                                  AV_INDEX NUMBER --取第几个元素
                                  ) RETURN VARCHAR2 IS
    LV_STR        VARCHAR2(1024);
    LV_STROFINDEX VARCHAR2(1024);
    LV_LENGTH     NUMBER;
  BEGIN
    LV_STR    := LTRIM(RTRIM(AV_STR));
    LV_STR    := CONCAT(LV_STR, AV_SPLIT);
    LV_LENGTH := AV_INDEX;
    IF LV_LENGTH = 0 THEN
      LV_STROFINDEX := SUBSTR(LV_STR,
                              1,
                              INSTR(LV_STR, AV_SPLIT) - LENGTH(AV_SPLIT));
    ELSE
      LV_LENGTH     := AV_INDEX + 1;
      LV_STROFINDEX := SUBSTR(LV_STR,
                              INSTR(LV_STR, AV_SPLIT, 1, AV_INDEX) +
                              LENGTH(AV_SPLIT),
                              INSTR(LV_STR, AV_SPLIT, 1, LV_LENGTH) -
                              INSTR(LV_STR, AV_SPLIT, 1, AV_INDEX) -
                              LENGTH(AV_SPLIT));
    END IF;
    RETURN LV_STROFINDEX;
  END GET_STRARRAYSTROFINDEX;

  --入库单导入IMPORT
  PROCEDURE WAREHOUSE_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
    VALIDATE_V VARCHAR2(2000);
    VALIDATE_W VARCHAR2(2000);
    VALIDATE_X VARCHAR2(2000);
    VALIDATE_Y VARCHAR2(2000);
    VALIDATE_Z VARCHAR2(2000);
  
    V_INFO_ID       NUMBER;
    V_TARGET_ID     NUMBER;
    V_CONTRACT_ID   NUMBER;
    HAS_CONTRACT    NUMBER;
    CONTRACT_CODE_4 VARCHAR2(2000);
    MATRIAL_CODE_V  VARCHAR2(2000);
    SEQ_CODE        VARCHAR2(2000);
    HAS_CONTRACT1   NUMBER;
    COUNT1          NUMBER;
    PORT_SURCHARGE  NUMBER; --港杂费
    PREMIUM_AMOUNT  NUMBER; --国内保险费
    TRAFFIC_EXPENSE NUMBER; --国内运输费
    EXCHANGE_RATE   NUMBER; --实时汇率
    TARIFF_RATE     NUMBER; --关税率
  
    V_HT_NUMBER        NUMBER; --验证合同是否已存在相同物料
    V_HT_MATERIAL_CODE VARCHAR2(100);
    V_HT_TARGET_ID     NUMBER;
  
    P_DEPT_ID NUMBER;
    P_USER_ID NUMBER;
  BEGIN
  
    SELECT T.DEPT_ID, T.CREATED_BY
      INTO P_DEPT_ID, P_USER_ID
      FROM SPM_CON_WAREHOUSE T
     WHERE T.WAREHOUSE_ID = F_TABLEID;
  
    --合同ID
    SELECT T.CONTRACT_ID
      INTO V_CONTRACT_ID
      FROM SPM_CON_WAREHOUSE T
     WHERE T.WAREHOUSE_ID = F_TABLEID;
  
    SELECT T.PORT_SURCHARGE,
           T.PREMIUM_AMOUNT,
           T.TRAFFIC_EXPENSE,
           T.EXCHANGE_RATE,
           T.TARIFF_RATE
      INTO PORT_SURCHARGE,
           PREMIUM_AMOUNT,
           TRAFFIC_EXPENSE,
           EXCHANGE_RATE,
           TARIFF_RATE
      FROM SPM_CON_WAREHOUSE T
     WHERE T.WAREHOUSE_ID = F_TABLEID;
  
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
    
      /*--主数量 副数量计算 外币单价（主） 为空时
       IF (VALIDATE_O IS NULL OR VALIDATE_O=0) AND VALIDATE_P IS NOT NULL THEN
          VALIDATE_O:= ROUND(VALIDATE_M * VALIDATE_P /VALIDATE_J,2);
        END IF;
      
        IF (VALIDATE_P IS NULL OR VALIDATE_P=0) AND VALIDATE_O IS NOT NULL THEN
            VALIDATE_P := ROUND(VALIDATE_J * VALIDATE_O /VALIDATE_M,2);
      END IF;*/
    
      /*       IF VALIDATE_O IS NOT NULL OR VALIDATE_P IS NOT NULL THEN
      -- 外币单价（主）*实时汇率*（1+关税率）=不含税人民币单价
         VALIDATE_R:=VALIDATE_O*EXCHANGE_RATE*(1+TARIFF_RATE);
         VALIDATE_V:=VALIDATE_R*(1+VALIDATE_T*0.01);
       END IF;*/
    
      /*        VALIDATE_V:=VALIDATE_V+(PORT_SURCHARGE/COUNT1)+(PREMIUM_AMOUNT/COUNT1)+(TRAFFIC_EXPENSE/COUNT1);
      */
      INSERT INTO SPM_CON_WAREHOUSE_DL
        (WAREHOUSE_DL_ID, --主键
         CONTRACT_ID,
         ATTRIBUTE2,
         MATERIAL_CODE, --物资编码
         DELIVERY_CARGO, --物料名称
         PIPELINE_NUMBER, --管号
         STOVE_NUMBER, --炉号
         PURCHASE_AMOUNT, --发票数量(主)
         THIS_WAREHOUSE_NUMBER, --本次入库数量
         UNIT, --单位
         DEPUTY_UNIT_AMOUNT, --发票数量(副)
         DEPUTY_UNIT, --副单位
         FOREIGN_UNIT_PRICE_CIF, --外币单价(CIF)(主)
         FOREIGN_UNIT_PRICE_DEPUTY, --外币单价(CIF)(副)
         CURRENCY_TYPE, -- 币种
         WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
         MONEY_AMOUNT, --金额(不含增值税)
         TAX_RATE, --税率
         TAX_AMOUNT, --进项税,
         TAX_UNIT_PRICE, --含税单价
         TAX_AMOUNT_COUNT, --价税合计
         PRODUCTION_FACTORY, --生产厂家
         REMARK, --备注
         DEPT_ID, --部门ID
         WAREHOUSE_ID, --外键,
         ORG_ID,
         CREATED_BY,
         CON_TARGET_ID,
         CREATION_DATE
         
         )
      VALUES
        (V_INFO_ID,
         V_CONTRACT_ID,
         VALIDATE_A,
         SPM_CON_HT_PKG.GET_TARGET_CODE(V_CONTRACT_ID),
         VALIDATE_C || '|' || VALIDATE_D || '|' || VALIDATE_E || '|',
         VALIDATE_H, --管号
         VALIDATE_I, --炉号
         VALIDATE_J, --发票数量(主)
         VALIDATE_K, --本次入库数量
         VALIDATE_L, --单位
         VALIDATE_M, --发票数量（副）
         VALIDATE_N, --副单位
         VALIDATE_O, --外币单价主
         --VALIDATE_P, --外币单价副
         --自动算出外币单价（副）=外币单价（主）*本次入库数量/发票数量（副）
         VALIDATE_O * VALIDATE_K / VALIDATE_M,
         VALIDATE_Q,
         (VALIDATE_V / (1 + VALIDATE_T * 0.01)), --单价（不含税）
         --入库单价自动算出=外币单价（主）*实时汇率（题头汇率）
         --VALIDATE_O*EXCHANGE_RATE,
         (VALIDATE_K * VALIDATE_V / (1 + VALIDATE_T * 0.01)), --金额(不含增值税)
         --VALIDATE_O*EXCHANGE_RATE*VALIDATE_K,--金额(不含增值税)
         VALIDATE_T, --税率
         ROUND((VALIDATE_V / (1 + VALIDATE_T * 0.01) * VALIDATE_K *
               VALIDATE_T * 0.01),
               2), --进项税
         VALIDATE_V, --含税单价
         --价税合计修改为：入库单价*入库数量+进项税保留2位 by macq
         (VALIDATE_K * VALIDATE_V / (1 + VALIDATE_T * 0.01)) +
         ROUND((VALIDATE_V / (1 + VALIDATE_T * 0.01) * VALIDATE_K *
               VALIDATE_T * 0.01),
               2),
         VALIDATE_X, --生产厂家
         VALIDATE_Y, --备注
         --VALIDATE_Y,
         P_DEPT_ID,
         F_TABLEID,
         SPM_SSO_PKG.GETORGID,
         P_USER_ID,
         V_TARGET_ID,
         SYSDATE
         /*,
         (SELECT T.SECONDARY_INVENTORY_NAME
            FROM MTL_SECONDARY_INVENTORIES T
           WHERE T.DESCRIPTION = VALIDATE_F
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID),
         (SELECT T.INVENTORY_LOCATION_ID
            FROM MTL_ITEM_LOCATIONS T
           WHERE T.SEGMENT1 || '.' || T.SEGMENT2 || '.' || T.SEGMENT3 || '.' ||
                 T.SEGMENT4 || '.' || T.SEGMENT5 || '.' || T.SEGMENT6 =
                 VALIDATE_G
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID)*/
         
         );
    
      /*      SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
       INTO CONTRACT_CODE_4
       FROM SPM_CON_HT_INFO O
      WHERE O.CONTRACT_ID = V_CONTRACT_ID;*/
    
      /*IF VALIDATE_A = '流水码' THEN
        SELECT COUNT(*)
          INTO HAS_CONTRACT
          FROM SPM_CON_HT_TARGET O
         WHERE O.CONTRACT_ID = V_CONTRACT_ID
           AND O.CODE_TYPE = '流水码';
        SELECT COUNT(*)
          INTO HAS_CONTRACT1
          FROM SPM_CON_WAREHOUSE_DL O
         WHERE O.CONTRACT_ID = V_CONTRACT_ID
           AND O.ATTRIBUTE2 = '流水码';
        --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
      
        --合同中已经导入了流水码 第一条数据
        IF HAS_CONTRACT > 0 AND HAS_CONTRACT1 < 2 THEN
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_HT_TARGET T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.CODE_TYPE = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 3,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '0000'))
            INTO SEQ_CODE
            FROM DUAL;
          \*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
          WHERE T.TARGET_ID=V_INFO_ID;*\
        
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
        --合同中已经导入了流水码 第二条数据
        IF HAS_CONTRACT > 0 AND HAS_CONTRACT1 > 1 THEN
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_WAREHOUSE_DL T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 3,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '0000'))
            INTO SEQ_CODE
            FROM DUAL;
          \*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
          WHERE T.TARGET_ID=V_INFO_ID;*\
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
        --验证物料是否在合同侧存在
        SELECT COUNT(*)
          INTO V_HT_NUMBER
          FROM SPM_CON_HT_TARGET H
               WHERE H.CONTRACT_ID = V_CONTRACT_ID
               AND H.MATERIAL_NAME = VALIDATE_C
               AND H.SPECIFICATION_MODEL = VALIDATE_D;
        IF V_HT_NUMBER <> 0 THEN
          SELECT H.MATERIAL_CODE, H.TARGET_ID
            INTO V_HT_MATERIAL_CODE, V_HT_TARGET_ID
                 FROM SPM_CON_HT_TARGET H
               WHERE H.CONTRACT_ID = V_CONTRACT_ID
               AND H.MATERIAL_NAME = VALIDATE_C
               AND H.SPECIFICATION_MODEL = VALIDATE_D
               AND ROWNUM = 1;
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = V_HT_MATERIAL_CODE,
                 T.CON_TARGET_ID = V_HT_TARGET_ID
             WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
        --合同中未导入物料编码 第一条数据
        IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '0001'
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
        --合同中未导入物料编码 第二条据
      
        IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 1 THEN
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_WAREHOUSE_DL T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 3,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '0000'))
            INTO SEQ_CODE
            FROM DUAL;
      
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
      END IF;*/
    
      --导入为管道码
      IF VALIDATE_A = '管道码' THEN
        --管道流水序列
        SELECT 1111 || TO_CHAR(SPM_CON_TARGET_GD_SEQ.NEXTVAL, 'FM000000')
          INTO SEQ_CODE
          FROM DUAL;
        UPDATE SPM_CON_WAREHOUSE_DL T
           SET T.MATERIAL_CODE = SEQ_CODE
         WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
      END IF;
      --导入为管件码
      IF VALIDATE_A = '管件码' THEN
        --管件流水序列
        SELECT 1112 || TO_CHAR(SPM_CON_TARGET_GJ_SEQ.NEXTVAL, 'FM000000')
          INTO SEQ_CODE
          FROM DUAL;
        UPDATE SPM_CON_WAREHOUSE_DL T
           SET T.MATERIAL_CODE = SEQ_CODE
         WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
      END IF;
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z;
    END LOOP;
    CLOSE CU_DATA;
    --回填入库金额
    UPDATE SPM_CON_WAREHOUSE AA
       SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                            I.WAREHOUSE_UNIT_PRICE,
                                                            2))
                                             FROM SPM_CON_WAREHOUSE_DL I
                                            WHERE I.WAREHOUSE_ID = P_TABLEID),
                                           0)
     WHERE AA.WAREHOUSE_ID = P_TABLEID;
  END;

  --入库单验证VALIDATE
  PROCEDURE WAREHOUSE_VALIDATE(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
    VALIDATE_V VARCHAR2(2000);
    VALIDATE_W VARCHAR2(2000);
    VALIDATE_X VARCHAR2(2000);
    VALIDATE_Y VARCHAR2(2000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
    VALIDATE_NUMBER1    NUMBER;
    VALIDATE_NUMBER2    NUMBER;
    VALIDATE_NUMBER3    NUMBER;
    VALIDATE_NUMBER4    NUMBER;
    VALIDATE_NUMBER5    NUMBER;
    VALIDATE_NUMBER6    NUMBER;
    VALIDATE_NUMBER7    NUMBER;
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    MSG_L VARCHAR2(4000);
    MSG_M VARCHAR2(4000);
    MSG_N VARCHAR2(4000);
    MSG_O VARCHAR2(4000);
    MSG_P VARCHAR2(4000);
    MSG_Q VARCHAR2(4000);
    MSG_R VARCHAR2(4000);
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '*编号类别' OR VALIDATE_B <> '*物料编码
(编号类别为中水码时，必填)' OR VALIDATE_C <> '*物料名称' OR VALIDATE_D <> '规格型号' OR
         VALIDATE_E <> '材质' OR VALIDATE_F <> '仓库(不填，导入后在页面批量设置)' OR
         VALIDATE_G <> '货位(不填，导入后在页面批量设置)' OR VALIDATE_H <> '管号' OR
         VALIDATE_I <> '炉号' OR VALIDATE_J <> '*发票数量(主)' OR
         VALIDATE_K <> '*本次入库数量' OR VALIDATE_L <> '单位' OR
         VALIDATE_M <> '发票数量(副)' OR VALIDATE_N <> '副单位' OR
         VALIDATE_O <> '外币单价(主)' OR VALIDATE_P <> '外币单价(副)' OR
         VALIDATE_Q <> '币种' OR VALIDATE_R <> '单价(不含增值税)' OR
         VALIDATE_S <> '金额(不含增值税)' OR VALIDATE_T <> '*税率(%)' OR
         VALIDATE_U <> '进项税' OR VALIDATE_V <> '*含税单价' OR
         VALIDATE_W <> '价税合计' OR VALIDATE_X <> '生产厂家' OR VALIDATE_Y <> '备注' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y;
      WHILE CU_DATA%FOUND LOOP
      
        --验证单位是否在EBS存在
        IF VALIDATE_L IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER1
            FROM MTL_UNITS_OF_MEASURE T
           WHERE T.UNIT_OF_MEASURE = VALIDATE_L;
          IF VALIDATE_NUMBER1 < 1 THEN
            IF MSG_A IS NULL THEN
              MSG_A := CU_DATA%ROWCOUNT;
            ELSE
              MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        
        END IF;
      
        --验证含税单价不能为空
        /*        IF VALIDATE_V IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;*/
        IF VALIDATE_V IS NULL THEN
          IF VALIDATE_O IS NULL AND VALIDATE_P IS NULL THEN
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_O IS NOT NULL OR VALIDATE_P IS NOT NULL THEN
          IF VALIDATE_W IS NOT NULL THEN
            MSG_O := MSG_O || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证仓库不能有值
        IF VALIDATE_F IS NOT NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证货位不能有值
        IF VALIDATE_G IS NOT NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证入库数量不能为空
        IF VALIDATE_K IS NULL THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA%ROWCOUNT;
          ELSE
            MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --当编号类别为中水码时
        IF VALIDATE_A = '中水码' THEN
          --物料编码不能为空
          IF VALIDATE_B IS NULL THEN
            IF MSG_G IS NULL THEN
              MSG_G := CU_DATA%ROWCOUNT;
            ELSE
              MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
            END IF;
            --验证中水码是否正确
          ELSE
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER4
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.SEGMENT1 = VALIDATE_B;
            IF VALIDATE_NUMBER4 = 0 THEN
              MSG_I := CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --当编号类别为流水码时 物料编码必须为空
        IF VALIDATE_A = '流水码' THEN
          IF VALIDATE_B IS NOT NULL THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            
            END IF;
          END IF;
        END IF;
      
        /*        --验证仓库是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT COUNT(*) INTO VALIDATE_NUMBER6 FROM MTL_SECONDARY_INVENTORIES T WHERE T.DESCRIPTION=VALIDATE_D AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER6<1 THEN
                  MSG_J :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;
        
        --验证货位是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT  COUNT(*) INTO VALIDATE_NUMBER7  FROM   MTL_ITEM_LOCATIONS T WHERE (CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(T.INVENTORY_LOCATION_ID,'NAME'))=VALIDATE_E AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER7<1 THEN
                  MSG_K :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;*/
      
        --发票数量(主)不能为空
        IF VALIDATE_J IS NULL THEN
          IF MSG_L IS NULL THEN
            MSG_L := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --税率不能为空
        IF VALIDATE_T IS NULL THEN
          IF MSG_M IS NULL THEN
            MSG_M := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --物料名称不能为空
        IF VALIDATE_C IS NULL THEN
          IF MSG_N IS NULL THEN
            MSG_N := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA
        
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
               VALIDATE_V,
               VALIDATE_W,
               VALIDATE_X,
               VALIDATE_Y;
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ; 单位在EBS不存在，请检查 ';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 ; 含税单价为空时，外币单价(主)/外币单价(副)不能均为空 ';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 ; 请勿填写仓库，到页面进行批量设置 ';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 ; 请勿填写货位，到页面进行批量设置 ';
      END IF;
    
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 ; 本次入库数量不能为空 ';
      END IF;
    
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 ; 当编号类别为中水码时,物料编码不能为空 ';
      END IF;
    
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 ; 当编号类别为流水码时,不可填写物料编码 ';
      END IF;
    
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 ; 当编号类别为中水码时,检查中水码是否正确 ';
      END IF;
    
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 ; 本组织下仓库不正确,请检查 ';
      END IF;
    
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 ; 本组织下货位不正确,请检查 ';
      END IF;
    
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 ; 发票数量(主)不能为空 ';
      END IF;
    
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 ; 税率不能为空(若无填写0) ';
      END IF;
    
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 ; 物料名称不能为空 ';
      END IF;
      IF MSG_O IS NOT NULL THEN
        MSG_O := MSG_O || '行 ; 外币单价(主)/外币单价(副)不为空,含税单价必须为空';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;
  --出库单导入IMPORT
  PROCEDURE ODO_DL_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E), TRIM(F)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
  
    V_INFO_ID         NUMBER;
    V_TARGET_ID       NUMBER;
    V_CONTRACT_ID     NUMBER;
    HAS_CONTRACT      NUMBER;
    CONTRACT_CODE_4   VARCHAR2(2000);
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    HAS_CONTRACT1     NUMBER;
    SPM_CON_ODO_DL_ID NUMBER;
    TAX_RATE          NUMBER;
    ODO_UNIT_PRICE    NUMBER;
    THIS_ODO_NUMBER   NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
      INTO VALIDATE_A,
           VALIDATE_B,
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E,
           VALIDATE_F;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT T.SPM_CON_ODO_DL_ID,
             T.ODO_UNIT_PRICE,
             T.TAX_RATE,
             T.THIS_ODO_NUMBER
        INTO SPM_CON_ODO_DL_ID, ODO_UNIT_PRICE, TAX_RATE, THIS_ODO_NUMBER
        FROM SPM_CON_ODO_DL T
       WHERE T.ODO_ID = P_TABLEID
         AND T.MATERIAL_CODE = VALIDATE_B
         AND T.MATERIAL_NAME = VALIDATE_C;
    
      UPDATE SPM_CON_ODO_DL T
         SET T.TAX_ODO_UNIT_PRICE = VALIDATE_D,
             T.TARGET_AMOUNT      = THIS_ODO_NUMBER * ODO_UNIT_PRICE,
             T.TAX_AMOUNT        =
             (VALIDATE_D / (1 + TAX_RATE * 0.01) * TAX_RATE *
             THIS_ODO_NUMBER * 0.01),
             T.TAX_AMOUNT_COUNT   = THIS_ODO_NUMBER * VALIDATE_D
       WHERE T.SPM_CON_ODO_DL_ID = SPM_CON_ODO_DL_ID
         AND T.ODO_ID = P_TABLEID
         AND T.MATERIAL_CODE = VALIDATE_B
         AND T.MATERIAL_NAME = VALIDATE_C;
    
      COMMIT;
      UPDATE SPM_CON_ODO AA
         SET AA.ODO_MONEY_AMOUNT =
             (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                    FROM SPM_CON_ODO_DL I
                   WHERE I.ODO_ID = P_TABLEID),
                  0))
       WHERE AA.ODO_ID = P_TABLEID;
    
      FETCH CU_DATA
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F;
    
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --出库单验证VALIDATE
  PROCEDURE ODO_DL_VALIDATE(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E), TRIM(F)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    V_1   NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
      INTO VALIDATE_A,
           VALIDATE_B,
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E,
           VALIDATE_F;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      /*      IF VALIDATE_A <> '*编号类别' OR VALIDATE_B <> '*物料编码
      (编号类别为中水码或者管道时，必填)' OR
               VALIDATE_C <> '*物料名称' OR VALIDATE_D <> '仓库' OR VALIDATE_E <> '货位' OR
               VALIDATE_F <> '管号' OR VALIDATE_G <> '炉号' OR
               VALIDATE_H <> '*发票数量(主)' OR VALIDATE_I <> '*本次入库数量' OR
               VALIDATE_J <> '单位' OR VALIDATE_K <> '发票数量(副)' OR
               VALIDATE_L <> '副单位' OR VALIDATE_M <> '外币单价(FOB)' OR
               VALIDATE_N <> '外币单价(CIF)(主)' OR VALIDATE_O <> '外币单价(CIF)(副)' OR
               VALIDATE_P <> '币种' OR VALIDATE_Q <> '单价(不含增值税)' OR
               VALIDATE_R <> '金额(不含增值税)' OR VALIDATE_S <> '*税率(%)' OR
               VALIDATE_T <> '进项税' OR VALIDATE_U <> '*含税单价' OR
               VALIDATE_V <> '价税合计' OR VALIDATE_W <> '生产厂家' OR VALIDATE_X <> '备注'
                THEN
              P_MSG := '导入数据的字段名不符合格式';
      
              CLOSE CU_DATA;
              RETURN;
            END IF;*/
      FETCH CU_DATA
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F;
    
      WHILE CU_DATA%FOUND LOOP
      
        --验证物料编码 物料名称不能为空
        IF VALIDATE_B IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证物料编码 物料名称不能为空
        IF VALIDATE_C IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --SPM_IMPORT_XLS_PKG
        /*       IF VALIDATE_D IS NOT NULL THEN
         SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_D) INTO V_1 FROM DUAL;
          IF V_1 = 0 THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;*/
      
        FETCH CU_DATA
        
          INTO VALIDATE_A,
               VALIDATE_B,
               VALIDATE_C,
               VALIDATE_D,
               VALIDATE_E,
               VALIDATE_F;
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ; 物料编码不能为空';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 ; 物料名称不能为空';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 ; 请输入数字格式的销售单价';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;

  --入库单明细导出再导入IMPORT
  PROCEDURE WAREHOUSE_DL_GG_IMPORT(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   F_TABLENAME VARCHAR2,
                                   F_TABLEID   VARCHAR2,
                                   P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             NVL(TRIM(H),0),
             TRIM(I),
             TRIM(J),
             TRIM(K)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000); --物流编号
    VALIDATE_C VARCHAR2(2000); --物料名称
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
  
    V_INFO_ID             NUMBER;
    V_TARGET_ID           NUMBER;
    V_CONTRACT_ID         NUMBER;
    HAS_CONTRACT          NUMBER;
    CONTRACT_CODE_4       VARCHAR2(2000);
    MATRIAL_CODE_V        VARCHAR2(2000);
    SEQ_CODE              VARCHAR2(2000);
    HAS_CONTRACT1         NUMBER;
    SPM_CON_ODO_DL_ID     NUMBER;
    TAX_RATE              NUMBER;
    ODO_UNIT_PRICE        NUMBER;
    THIS_ODO_NUMBER       NUMBER;
    WAREHOUSE_DL_ID       NUMBER;
    UNIT_PRICE1           NUMBER;
    THIS_WAREHOUSE_NUMBER NUMBER;
  
    --入库明细行ID
    P_DL_ID NUMBER;
    --主表汇率
    P_EXCHANGE NUMBER;
    --行中入库单价
    P_UNIT_PRICE NUMBER;
    --本次入库数量
    P_THIS_NUMBER NUMBER;
    --类型区分国内国外
    P_TYPE VARCHAR2(40);
  
  BEGIN
    --查找主表的汇率
    SELECT NVL(W.EXCHANGE_RATE, 0), W.MATERIAL_ORIGIN
      INTO P_EXCHANGE, P_TYPE
      FROM SPM_CON_WAREHOUSE W
     WHERE W.WAREHOUSE_ID = P_TABLEID;
  
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_K;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
    
      SELECT T.WAREHOUSE_DL_ID, T.THIS_WAREHOUSE_NUMBER
        INTO P_DL_ID, P_THIS_NUMBER
        FROM SPM_CON_WAREHOUSE_DL T
       WHERE T.WAREHOUSE_ID = P_TABLEID
         AND T.MATERIAL_CODE = VALIDATE_B
         AND T.DELIVERY_CARGO = VALIDATE_C;
    
      --国内
     IF P_TYPE = 'A' THEN
       P_UNIT_PRICE := VALIDATE_H / (1 + NVL(VALIDATE_G * 0.01, 0));
        UPDATE SPM_CON_WAREHOUSE_DL T
         SET 
             T.WAREHOUSE_UNIT_PRICE      = P_UNIT_PRICE, --入库单价
             T.TAX_RATE                  = NVL(VALIDATE_G, 0), --税率
             T.TAX_UNIT_PRICE            = VALIDATE_H, --含税单价
             T.MONEY_AMOUNT              = T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE, --金额(不含增值税)
             T.TAX_AMOUNT                = P_UNIT_PRICE *
                                           T.THIS_WAREHOUSE_NUMBER *
                                           NVL(VALIDATE_G, 0) * 0.01, --进项税,
             T.TAX_AMOUNT_COUNT          = T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE * NVL(VALIDATE_G, 0) * 0.01 +
                                           T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE, --价税合计
             T.PORT_ACCEPTANCE_QUANTITY  = VALIDATE_J,
             T.INSPECTION_GAP            = VALIDATE_K
      
       WHERE T.WAREHOUSE_DL_ID = P_DL_ID;             
     ELSE
     --国外
     P_UNIT_PRICE := VALIDATE_D * P_EXCHANGE;
     UPDATE SPM_CON_WAREHOUSE_DL T
         SET T.FOREIGN_UNIT_PRICE_CIF    = VALIDATE_D,
             T.FOREIGN_UNIT_PRICE_DEPUTY =
             (VALIDATE_D * P_THIS_NUMBER) / T.DEPUTY_UNIT_AMOUNT, --外币单价（副）=外币单价（主）*本次入库数量/发票数量（副）
             T.WAREHOUSE_UNIT_PRICE      = P_UNIT_PRICE, --入库单价
             T.TAX_RATE                  = NVL(VALIDATE_G, 0), --税率
             T.TAX_UNIT_PRICE            = VALIDATE_D * P_EXCHANGE *
                                           (1 + NVL(VALIDATE_G, 0) * 0.01), --含税单价
             T.MONEY_AMOUNT              = T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE, --金额(不含增值税)
             T.TAX_AMOUNT                = P_UNIT_PRICE *
                                           T.THIS_WAREHOUSE_NUMBER *
                                           NVL(VALIDATE_G, 0) * 0.01, --进项税,
             T.TAX_AMOUNT_COUNT          = T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE * NVL(VALIDATE_G, 0) * 0.01 +
                                           T.THIS_WAREHOUSE_NUMBER *
                                           P_UNIT_PRICE, --价税合计
             T.PORT_ACCEPTANCE_QUANTITY  = VALIDATE_J,
             T.INSPECTION_GAP            = VALIDATE_K
      
       WHERE T.WAREHOUSE_DL_ID = P_DL_ID;  
     
     END IF;
    
      FETCH CU_DATA
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
             VALIDATE_K;
    
    END LOOP;
  
    CLOSE CU_DATA;
  
    UPDATE SPM_CON_WAREHOUSE AA
       SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                            I.WAREHOUSE_UNIT_PRICE,
                                                            2))
                                             FROM SPM_CON_WAREHOUSE_DL I
                                            WHERE I.WAREHOUSE_ID = P_TABLEID),
                                           0)
     WHERE AA.WAREHOUSE_ID = P_TABLEID;
  END;

  --入库单导出再导入验证VALIDATE
  PROCEDURE WAREHOUSE_DL_GG_VALIDATE(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(K)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    V_1   NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
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
           VALIDATE_K;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '序号' OR VALIDATE_B <> '物料编码' OR VALIDATE_C <> '物料名称' OR
         VALIDATE_D <> '外币单价(主)' OR VALIDATE_E <> '外币单价(副)' OR
         VALIDATE_F <> '入库单价' OR VALIDATE_G <> '税率(%)' OR
         VALIDATE_H <> '含税单价' OR VALIDATE_I <> '均摊成本' OR
         VALIDATE_J <> '港口初验收数量(主)' OR VALIDATE_K <> '商检缺口' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
    
      FETCH CU_DATA
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
             VALIDATE_K;
    
      WHILE CU_DATA%FOUND LOOP
      
        --验证物料编码 物料名称不能为空
        /*        IF VALIDATE_B IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
        
          END IF;
        
        END IF;*/
      
        --验证物料编码 物料名称不能为空
        /*        IF VALIDATE_C IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
        
          END IF;
        
        END IF;
            */
      
        FETCH CU_DATA
        
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
               VALIDATE_K;
      
      END LOOP;
    
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ; 物料编码不能为空';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 ; 物料名称不能为空';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 ; 请输入数字格式的销售单价';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;
  --电商入库单导入IMPORT
  PROCEDURE DS_WAREHOUSE_IMPORT(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                F_TABLENAME VARCHAR2,
                                F_TABLEID   VARCHAR2,
                                P_MSG       OUT VARCHAR2) IS
  
    --头信息1
    CURSOR CU_DATA1 IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '入库单头信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --行信息 2
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '标的物'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --头信息定义变量1
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
    VALIDATE_I1 VARCHAR2(2000);
    VALIDATE_J1 VARCHAR2(2000);
    VALIDATE_K1 VARCHAR2(2000);
    VALIDATE_L1 VARCHAR2(2000);
    VALIDATE_M1 VARCHAR2(2000);
    VALIDATE_N1 VARCHAR2(2000);
    VALIDATE_O1 VARCHAR2(2000);
    VALIDATE_P1 VARCHAR2(2000);
    VALIDATE_Q1 VARCHAR2(2000);
    VALIDATE_R1 VARCHAR2(2000);
    VALIDATE_S1 VARCHAR2(2000);
    VALIDATE_T1 VARCHAR2(2000);
    VALIDATE_U1 VARCHAR2(2000);
    VALIDATE_V1 VARCHAR2(2000);
    VALIDATE_W1 VARCHAR2(2000);
    VALIDATE_X1 VARCHAR2(2000);
    VALIDATE_Y1 VARCHAR2(2000);
    VALIDATE_Z1 VARCHAR2(2000);
  
    --行信息定义变量2
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
    VALIDATE_V VARCHAR2(2000);
    VALIDATE_W VARCHAR2(2000);
    VALIDATE_X VARCHAR2(2000);
    VALIDATE_Y VARCHAR2(2000);
    VALIDATE_Z VARCHAR2(2000);
  
    V_INFO_ID       NUMBER;
    V_HT_ID         NUMBER;
    V_WAREHOUSE_ID  NUMBER;
    V_TARGET_ID     NUMBER;
    V_CONTRACT_ID   NUMBER;
    HAS_CONTRACT    NUMBER;
    CONTRACT_CODE_4 VARCHAR2(2000);
    MATRIAL_CODE_V  VARCHAR2(2000);
    SEQ_CODE        VARCHAR2(2000);
    HAS_CONTRACT1   NUMBER;
    V_SERIAL_NUMBER VARCHAR2(2000);
    P_TABLEID1      NUMBER;
  
  BEGIN
    OPEN CU_DATA1;
    FETCH CU_DATA1
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1,
           VALIDATE_I1,
           VALIDATE_J1,
           VALIDATE_K1,
           VALIDATE_L1,
           VALIDATE_M1,
           VALIDATE_N1,
           VALIDATE_O1,
           VALIDATE_P1,
           VALIDATE_Q1,
           VALIDATE_R1,
           VALIDATE_S1,
           VALIDATE_T1,
           VALIDATE_U1,
           VALIDATE_V1,
           VALIDATE_W1,
           VALIDATE_X1,
           VALIDATE_Y1,
           VALIDATE_Z1;
  
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z;
  
    WHILE CU_DATA1%FOUND LOOP
      SELECT T.CONTRACT_ID
        INTO V_HT_ID
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_B1;
      --获取流水号
      SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                            'SPM_CON_WAREHOUSE',
                                                            'WAREHOUSE_CODE',
                                                            'FM00000')
        INTO V_SERIAL_NUMBER
        FROM DUAL;
    
      INSERT INTO SPM_CON_WAREHOUSE
        (WAREHOUSE_ID, --主键
         CONTRACT_ID, --合同ID
         CONTRACT_NAME, --合同名称
         CONTRACT_CODE, --合同编号
         PROJECT_ID,
         PROJECT_NAME,
         PROJECT_CODE,
         VENDOR_ID, --供应商
         VENDOR_NAME,
         VENDOR_POSITION, --供应商地点
         MATERIAL_ORIGIN, --物资来源1
         MATERIAL_TYPE, --材料类别2
         TRANSPORT_TYPE, --运输方式3
         BUY_TYPE, --采购方式4
         WAREHOUSE_GRNI, --是否暂估5
         DIGEST, --摘要
         CAR_NUMBER, --车号
         WAREHOUSE_DATE,
         CREATION_DATE, --创建日期
         DEPT_ID, --部门
         ORG_ID, --组织
         CREATED_BY,
         WAREHOUSE_CODE,
         ATTRIBUTE5,
         STATUS
         
         )
      VALUES
        (SPM_CON_WAREHOUSE_SEQ.NEXTVAL,
         V_HT_ID,
         (SELECT T.CONTRACT_NAME
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_ID = V_HT_ID),
         VALIDATE_B1,
         (SELECT T.PROJECT_ID
            FROM SPM_CON_PROJECT T
           WHERE T.PROJECT_CODE = VALIDATE_D1),
         (SELECT T.PROJECT_NAME
            FROM SPM_CON_PROJECT T
           WHERE T.PROJECT_CODE = VALIDATE_D1),
         VALIDATE_D1,
         (SELECT T.VENDOR_ID
            FROM SPM_CON_VENDOR_INFO T
           WHERE T.VENDOR_CODE = VALIDATE_F1),
         (SELECT T.VENDOR_NAME
            FROM SPM_CON_VENDOR_INFO T
           WHERE T.VENDOR_CODE = VALIDATE_F1),
         (SELECT T.VENDOR_SITE_ID
            FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
           WHERE SPM_SSO_PKG.GETORGID() = T.ORG_ID
             AND T.VENDOR_ID = PP.VENDOR_ID
             AND PP.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND T.VENDOR_SITE_CODE = VALIDATE_G1
             AND PP.SEGMENT1 = VALIDATE_F1),
         GET_DICTCODE_BY_NAME('SPM_CON_MATERIAL_ORIGIN', VALIDATE_H1),
         GET_DICTCODE_BY_NAME('SPM_CON_MATERIAL_TYPE', VALIDATE_I1),
         GET_DICTCODE_BY_NAME('SPM_CON_TRANSPORT_TYPE', VALIDATE_L1),
         GET_DICTCODE_BY_NAME('SPM_CON_MATERIAL_ORIGIN', VALIDATE_H1),
         GET_DICTCODE_BY_NAME('SPM_CON_WAREHOUSE_GRNI', VALIDATE_J1),
         VALIDATE_P1, --摘要
         VALIDATE_O1, --车号
         TO_DATE(SUBSTR(VALIDATE_K1, 1, 10), 'YYYY-MM-DD'), --记账日期
         SYSDATE,
         (SELECT T.ORGANIZATION_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_N1
             AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
         SPM_SSO_PKG.GETORGID,
         (SELECT T.USER_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_N1
             AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
         V_SERIAL_NUMBER,
         'N',
         'A');
    
      FETCH CU_DATA1
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1,
             VALIDATE_I1,
             VALIDATE_J1,
             VALIDATE_K1,
             VALIDATE_L1,
             VALIDATE_M1,
             VALIDATE_N1,
             VALIDATE_O1,
             VALIDATE_P1,
             VALIDATE_Q1,
             VALIDATE_R1,
             VALIDATE_S1,
             VALIDATE_T1,
             VALIDATE_U1,
             VALIDATE_V1,
             VALIDATE_W1,
             VALIDATE_X1,
             VALIDATE_Y1,
             VALIDATE_Z1;
    END LOOP;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      --入库单CONTARGETID
      SELECT SPM_CON_TARGET_CD_SEQ.NEXTVAL INTO V_TARGET_ID FROM DUAL;
      --入库单主键
      SELECT T.WAREHOUSE_ID
        INTO P_TABLEID1
        FROM SPM_CON_WAREHOUSE T
       WHERE T.CONTRACT_CODE = VALIDATE_Y
         AND T.ORG_ID = SPM_SSO_PKG.GETORGID;
      --合同ID
      SELECT T.CONTRACT_ID
        INTO V_CONTRACT_ID
        FROM SPM_CON_WAREHOUSE T
       WHERE T.CONTRACT_CODE = VALIDATE_Y
         AND T.ORG_ID = SPM_SSO_PKG.GETORGID;
      INSERT INTO SPM_CON_WAREHOUSE_DL
        (WAREHOUSE_DL_ID, --主键
         CONTRACT_ID,
         ATTRIBUTE2,
         MATERIAL_CODE, --物资编码
         DELIVERY_CARGO, --物料名称
         STORE_ROOM_NAME, --仓库
         GOODS_POSITION_NAME, --货位
         PIPELINE_NUMBER, --管号
         STOVE_NUMBER, --炉号
         PURCHASE_AMOUNT, --发票数量(主)
         THIS_WAREHOUSE_NUMBER, --本次入库数量
         UNIT, --单位
         DEPUTY_UNIT_AMOUNT, --发票数量(副)
         DEPUTY_UNIT, --副单位
         FOREIGN_UNIT_PRICE_FOB, --外币单价(FOB)
         FOREIGN_UNIT_PRICE_CIF, --外币单价(CIF)(主)
         FOREIGN_UNIT_PRICE_DEPUTY, --外币单价(CIF)(副)
         CURRENCY_TYPE, -- 币种
         WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
         MONEY_AMOUNT, --金额(不含增值税)
         TAX_RATE, --税率
         TAX_AMOUNT, --进项税,
         TAX_UNIT_PRICE, --含税单价
         TAX_AMOUNT_COUNT, --价税合计
         PRODUCTION_FACTORY, --生产厂家
         REMARK, --备注
         --ATTRIBUTE1, --入库单编号
         DEPT_ID, --部门ID
         WAREHOUSE_ID, --外键,
         ORG_ID,
         CON_TARGET_ID,
         STORE_ROOM, --仓库
         GOODS_POSITION --货位
         
         )
      VALUES
        (V_INFO_ID,
         V_CONTRACT_ID,
         VALIDATE_A,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_D, --仓库
         VALIDATE_E, --货位
         VALIDATE_F,
         VALIDATE_G,
         VALIDATE_H,
         VALIDATE_I, --本次入库数量
         VALIDATE_J,
         VALIDATE_K,
         VALIDATE_L,
         VALIDATE_M,
         VALIDATE_N,
         VALIDATE_O,
         VALIDATE_P,
         (VALIDATE_U / (1 + VALIDATE_S * 0.01)), --单价（不含税）
         (VALIDATE_I * VALIDATE_U / (1 + VALIDATE_S * 0.01)),
         VALIDATE_S, --税率
         /*         (VALIDATE_Q*VALIDATE_I*VALIDATE_S*0.01),--进项税
         (VALIDATE_Q*(1+VALIDATE_S*0.01)),--含税单价
         (VALIDATE_I*VALIDATE_Q*VALIDATE_S*0.01+VALIDATE_I*VALIDATE_Q),--价税合计*/
         (VALIDATE_U / (1 + VALIDATE_S * 0.01) * VALIDATE_I * VALIDATE_S * 0.01),
         VALIDATE_U,
         (VALIDATE_I * (VALIDATE_U / (1 + VALIDATE_S * 0.01)) * VALIDATE_S * 0.01 +
         VALIDATE_I * (VALIDATE_U / (1 + VALIDATE_S * 0.01))),
         VALIDATE_W,
         VALIDATE_X,
         --VALIDATE_Y,
         (SELECT T.DEPT_ID
            FROM SPM_CON_WAREHOUSE T
           WHERE T.WAREHOUSE_ID = P_TABLEID1),
         P_TABLEID1,
         SPM_SSO_PKG.GETORGID,
         V_TARGET_ID,
         (SELECT T.SECONDARY_INVENTORY_NAME
            FROM MTL_SECONDARY_INVENTORIES T
           WHERE T.DESCRIPTION = 'VALIDATE_D'
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID),
         (SELECT T.INVENTORY_LOCATION_ID
            FROM MTL_ITEM_LOCATIONS T
           WHERE T.SEGMENT1 || '.' || T.SEGMENT2 || '.' || T.SEGMENT3 || '.' ||
                 T.SEGMENT4 || '.' || T.SEGMENT5 || '.' || T.SEGMENT6 =
                 VALIDATE_E
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID)
         
         );
      UPDATE SPM_CON_WAREHOUSE AA
         SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                              I.WAREHOUSE_UNIT_PRICE,
                                                              2))
                                               FROM SPM_CON_WAREHOUSE_DL I
                                              WHERE I.WAREHOUSE_ID =
                                                    P_TABLEID1),
                                             0)
       WHERE AA.WAREHOUSE_ID = P_TABLEID1;
    
      SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
        INTO CONTRACT_CODE_4
        FROM SPM_CON_HT_INFO O
       WHERE O.CONTRACT_ID = V_CONTRACT_ID;
    
      IF VALIDATE_A = '流水码' THEN
        SELECT COUNT(*)
          INTO HAS_CONTRACT
          FROM SPM_CON_HT_TARGET O
         WHERE O.CONTRACT_ID = V_CONTRACT_ID
           AND O.CODE_TYPE = '流水码';
        SELECT COUNT(*)
          INTO HAS_CONTRACT1
          FROM SPM_CON_WAREHOUSE_DL O
         WHERE O.CONTRACT_ID = V_CONTRACT_ID
           AND O.ATTRIBUTE2 = '流水码';
        --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
      
        --合同中已经导入了流水码 第一条数据
        IF HAS_CONTRACT > 0 AND HAS_CONTRACT1 < 2 THEN
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_HT_TARGET T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.CODE_TYPE = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 2,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '000'))
            INTO SEQ_CODE
            FROM DUAL;
          /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
          WHERE T.TARGET_ID=V_INFO_ID;*/
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
        --合同中已经导入了流水码 第二条数据
        IF HAS_CONTRACT > 0 AND HAS_CONTRACT1 > 1 THEN
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_WAREHOUSE_DL T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 2,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '000'))
            INTO SEQ_CODE
            FROM DUAL;
          /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
          WHERE T.TARGET_ID=V_INFO_ID;*/
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
        --合同中未导入物料编码 第一条数据
        IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '001'
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
        --合同中未导入物料编码 第二条据
      
        IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 1 THEN
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_WAREHOUSE_DL T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID
                     AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 2,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '000'))
            INTO SEQ_CODE
            FROM DUAL;
          /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
          WHERE T.TARGET_ID=V_INFO_ID;*/
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
           WHERE T.WAREHOUSE_DL_ID = V_INFO_ID;
        END IF;
      
      END IF;
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z;
    END LOOP;
    CLOSE CU_DATA1;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --入库单验证VALIDATE
  PROCEDURE DS_WAREHOUSE_VALIDATE(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  P_MSG       OUT VARCHAR2) IS
    --入库单头信息
    CURSOR CU_DATA1 IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '入库单头信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --标的物1
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '标的物'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
    VALIDATE_V VARCHAR2(2000);
    VALIDATE_W VARCHAR2(2000);
    VALIDATE_X VARCHAR2(2000);
    VALIDATE_Y VARCHAR2(2000);
  
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
    VALIDATE_I1 VARCHAR2(2000);
    VALIDATE_J1 VARCHAR2(2000);
    VALIDATE_K1 VARCHAR2(2000);
    VALIDATE_L1 VARCHAR2(2000);
    VALIDATE_M1 VARCHAR2(2000);
    VALIDATE_N1 VARCHAR2(2000);
    VALIDATE_O1 VARCHAR2(2000);
    VALIDATE_P1 VARCHAR2(2000);
    VALIDATE_Q1 VARCHAR2(2000);
    VALIDATE_R1 VARCHAR2(2000);
    VALIDATE_S1 VARCHAR2(2000);
    VALIDATE_T1 VARCHAR2(2000);
    VALIDATE_U1 VARCHAR2(2000);
    VALIDATE_V1 VARCHAR2(2000);
    VALIDATE_W1 VARCHAR2(2000);
    VALIDATE_X1 VARCHAR2(2000);
    VALIDATE_Y1 VARCHAR2(2000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
    VALIDATE_NUMBER1    NUMBER;
    VALIDATE_NUMBER2    NUMBER;
    VALIDATE_NUMBER3    NUMBER;
    VALIDATE_NUMBER4    NUMBER;
    VALIDATE_NUMBER5    NUMBER;
    VALIDATE_NUMBER6    NUMBER;
    VALIDATE_NUMBER7    NUMBER;
    VALIDATE_NUMBER8    NUMBER;
    VALIDATE_NUMBER9    NUMBER;
    VALIDATE_NUMBER10   NUMBER;
    VALIDATE_NUMBER11   NUMBER;
    VALIDATE_NUMBER12   NUMBER;
    VALIDATE_NUMBER13   NUMBER;
    VALIDATE_NUMBER14   NUMBER;
    VALIDATE_NUMBER15   NUMBER;
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    MSG_L VARCHAR2(4000);
    MSG_M VARCHAR2(4000);
    MSG_N VARCHAR2(4000);
    MSG_O VARCHAR2(4000);
    MSG_P VARCHAR2(4000);
    MSG_Q VARCHAR2(4000);
    MSG_R VARCHAR2(4000);
  
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
    MSG_D1 VARCHAR2(4000);
    MSG_E1 VARCHAR2(4000);
    MSG_F1 VARCHAR2(4000);
    MSG_G1 VARCHAR2(4000);
    MSG_H1 VARCHAR2(4000);
    MSG_I1 VARCHAR2(4000);
    MSG_J1 VARCHAR2(4000);
    MSG_K1 VARCHAR2(4000);
    MSG_L1 VARCHAR2(4000);
    MSG_M1 VARCHAR2(4000);
    MSG_N1 VARCHAR2(4000);
    MSG_O1 VARCHAR2(4000);
    MSG_P1 VARCHAR2(4000);
    MSG_Q1 VARCHAR2(4000);
    MSG_R1 VARCHAR2(4000);
  
  BEGIN
    OPEN CU_DATA1;
    OPEN CU_DATA;
    FETCH CU_DATA1
    
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1,
           VALIDATE_I1,
           VALIDATE_J1,
           VALIDATE_K1,
           VALIDATE_L1,
           VALIDATE_M1,
           VALIDATE_N1,
           VALIDATE_O1,
           VALIDATE_P1,
           VALIDATE_Q1,
           VALIDATE_R1,
           VALIDATE_S1,
           VALIDATE_T1,
           VALIDATE_U1,
           VALIDATE_V1,
           VALIDATE_W1,
           VALIDATE_X1,
           VALIDATE_Y;
  
    FETCH CU_DATA
    
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y;
    --验证导入字段名格式是否正确
    IF CU_DATA1%FOUND THEN
      IF VALIDATE_A1 <> '合同名称' OR VALIDATE_B1 <> '*合同编号' OR
         VALIDATE_C1 <> '项目名称' OR VALIDATE_D1 <> '*项目编号' OR
         VALIDATE_E1 <> '供应商' OR VALIDATE_F1 <> '*供应商编号' OR
         VALIDATE_G1 <> '*供应商地点' OR VALIDATE_H1 <> '*物资来源' OR
         VALIDATE_I1 <> '*材料类别' OR VALIDATE_J1 <> '*是否暂估' OR
         VALIDATE_K1 <> '*记账日期' OR VALIDATE_L1 <> '*运输方式' OR
         VALIDATE_M1 <> '*采购方式' OR VALIDATE_N1 <> '*经办人' OR
         VALIDATE_O1 <> '车号' OR VALIDATE_P1 <> '摘要' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA1;
        RETURN;
      END IF;
      FETCH CU_DATA1
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1,
             VALIDATE_I1,
             VALIDATE_J1,
             VALIDATE_K1,
             VALIDATE_L1,
             VALIDATE_M1,
             VALIDATE_N1,
             VALIDATE_O1,
             VALIDATE_P1,
             VALIDATE_Q1,
             VALIDATE_R1,
             VALIDATE_S1,
             VALIDATE_T1,
             VALIDATE_U1,
             VALIDATE_V1,
             VALIDATE_W1,
             VALIDATE_X1,
             VALIDATE_Y1;
      WHILE CU_DATA1%FOUND LOOP
      
        --验证为空的 合同编号 项目编号 供应商编号 第一批不为空
        IF VALIDATE_B1 IS NULL OR VALIDATE_D1 IS NULL OR
           VALIDATE_F1 IS NULL THEN
          MSG_A1 := CU_DATA1%ROWCOUNT;
        END IF;
      
        --验证为空的 供应商地点 物资来源 材料类别 是否暂估  第二批不为空
        IF VALIDATE_G1 IS NULL OR VALIDATE_H1 IS NULL OR
           VALIDATE_I1 IS NULL OR VALIDATE_J1 IS NULL THEN
          MSG_B1 := CU_DATA1%ROWCOUNT;
        END IF;
      
        --验证为空的 记账日期 运输方式 采购方式 经办人 第三批不为空
        IF VALIDATE_K1 IS NULL OR VALIDATE_L1 IS NULL OR
           VALIDATE_M1 IS NULL OR VALIDATE_N1 IS NULL THEN
          MSG_C1 := CU_DATA1%ROWCOUNT;
        END IF;
      
        --验证数据字典 物资来源
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_MATERIAL_ORIGIN',
                                                  VALIDATE_H1)
          INTO VALIDATE_NUMBER1
          FROM DUAL;
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_MATERIAL_TYPE',
                                                  VALIDATE_I1)
          INTO VALIDATE_NUMBER2
          FROM DUAL;
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_WAREHOUSE_GRNI',
                                                  VALIDATE_J1)
          INTO VALIDATE_NUMBER3
          FROM DUAL;
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_TRANSPORT_TYPE',
                                                  VALIDATE_L1)
          INTO VALIDATE_NUMBER4
          FROM DUAL;
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_BUY_TYPE',
                                                  VALIDATE_M1)
          INTO VALIDATE_NUMBER5
          FROM DUAL;
      
        --验证数据字典:物资来源
        IF VALIDATE_H1 IS NOT NULL THEN
          IF VALIDATE_NUMBER1 < 1 THEN
            MSG_D1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证数据字典:材料类别
        IF VALIDATE_I1 IS NOT NULL THEN
          IF VALIDATE_NUMBER2 < 1 THEN
            MSG_E1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证数据字典:是否暂估
        IF VALIDATE_J1 IS NOT NULL THEN
          IF VALIDATE_NUMBER3 < 1 THEN
            MSG_F1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证数据字典:运输方式
        IF VALIDATE_L1 IS NOT NULL THEN
          IF VALIDATE_NUMBER4 < 1 THEN
            MSG_G1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证数据字典:采购方式
        IF VALIDATE_M1 IS NOT NULL THEN
          IF VALIDATE_NUMBER5 < 1 THEN
            MSG_H1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA1
        
          INTO VALIDATE_A1,
               VALIDATE_B1,
               VALIDATE_C1,
               VALIDATE_D1,
               VALIDATE_E1,
               VALIDATE_F1,
               VALIDATE_G1,
               VALIDATE_H1,
               VALIDATE_I1,
               VALIDATE_J1,
               VALIDATE_K1,
               VALIDATE_L1,
               VALIDATE_M1,
               VALIDATE_N1,
               VALIDATE_O1,
               VALIDATE_P1,
               VALIDATE_Q1,
               VALIDATE_R1,
               VALIDATE_S1,
               VALIDATE_T1,
               VALIDATE_U1,
               VALIDATE_V1,
               VALIDATE_W1,
               VALIDATE_X1,
               VALIDATE_Y1;
      
      END LOOP;
      CLOSE CU_DATA1;
    
      IF MSG_A1 IS NOT NULL THEN
        MSG_A1 := MSG_A1 || '行 ; 合同编号,项目编号,供应商编号不能为空';
      END IF;
    
      IF MSG_B1 IS NOT NULL THEN
        MSG_B1 := MSG_B1 || '行 ; 供应商地点,物资来源,材料类别,是否暂估不能为空';
      END IF;
    
      IF MSG_C1 IS NOT NULL THEN
        MSG_C1 := MSG_C1 || '行 ; 记账日期,运输方式,采购方式,经办人不能为空';
      END IF;
    
      IF MSG_C1 IS NOT NULL THEN
        MSG_C1 := MSG_C1 || '行 ; 记账日期,运输方式,采购方式,经办人不能为空';
      END IF;
    
      IF MSG_D1 IS NOT NULL THEN
        MSG_D1 := MSG_D1 || '行 ; 物资来源不存在';
      END IF;
    
      IF MSG_E1 IS NOT NULL THEN
        MSG_E1 := MSG_E1 || '行 ; 材料类别不存在';
      END IF;
    
      IF MSG_F1 IS NOT NULL THEN
        MSG_F1 := MSG_F1 || '行 ; 是否暂估不存在';
      END IF;
    
      IF MSG_G1 IS NOT NULL THEN
        MSG_G1 := MSG_G1 || '行 ; 运输方式不存在';
      END IF;
    
      IF MSG_H1 IS NOT NULL THEN
        MSG_H1 := MSG_H1 || '行 ; 采购方式不存在';
      END IF;
    
    END IF;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '*编号类别' OR VALIDATE_B <> '*物料编码
(编号类别为中水码或者管道时，必填)' OR VALIDATE_C <> '*物料名称' OR VALIDATE_D <> '仓库' OR
         VALIDATE_E <> '货位' OR VALIDATE_F <> '管号' OR VALIDATE_G <> '炉号' OR
         VALIDATE_H <> '*发票数量(主)' OR VALIDATE_I <> '*本次入库数量' OR
         VALIDATE_J <> '单位' OR VALIDATE_K <> '发票数量(副)' OR
         VALIDATE_L <> '副单位' OR VALIDATE_M <> '外币单价(FOB)' OR
         VALIDATE_N <> '外币单价(CIF)(主)' OR VALIDATE_O <> '外币单价(CIF)(副)' OR
         VALIDATE_P <> '币种' OR VALIDATE_Q <> '单价(不含增值税)' OR
         VALIDATE_R <> '金额(不含增值税)' OR VALIDATE_S <> '*税率(%)' OR
         VALIDATE_T <> '进项税' OR VALIDATE_U <> '*含税单价' OR
         VALIDATE_V <> '价税合计' OR VALIDATE_W <> '生产厂家' OR VALIDATE_X <> '备注' OR
         VALIDATE_Y <> '合同编号' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y;
      WHILE CU_DATA%FOUND LOOP
      
        --验证单位是否在EBS存在
        IF VALIDATE_J IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER1
            FROM MTL_UNITS_OF_MEASURE T
           WHERE T.UNIT_OF_MEASURE = VALIDATE_J;
          IF VALIDATE_NUMBER1 < 1 THEN
            IF MSG_A IS NULL THEN
              MSG_A := CU_DATA%ROWCOUNT;
            ELSE
              MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        
        END IF;
      
        --验证含税单价不能为空
        IF VALIDATE_U IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证仓库不能为空
        IF VALIDATE_D IS NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证货位不能为空
        IF VALIDATE_E IS NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证入库数量不能为空
        IF VALIDATE_I IS NULL THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA%ROWCOUNT;
          ELSE
            MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --当编号类别为中水码或者四大管道码时 物料编码不能为空
        IF VALIDATE_A = '中水码' OR VALIDATE_A = '四大管道码' THEN
          IF VALIDATE_B IS NULL THEN
            IF MSG_G IS NULL THEN
              MSG_G := CU_DATA%ROWCOUNT;
            ELSE
              MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --当编号类别为中水码或者四大管道码时 物料编码不能为空
        IF VALIDATE_A = '流水码' THEN
          IF VALIDATE_B IS NOT NULL THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_A = '中水码' THEN
          IF VALIDATE_B IS NOT NULL THEN
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER4
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.SEGMENT1 = VALIDATE_B;
            IF VALIDATE_NUMBER4 = 0 THEN
              MSG_I := CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        /*        --验证仓库是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT COUNT(*) INTO VALIDATE_NUMBER6 FROM MTL_SECONDARY_INVENTORIES T WHERE T.DESCRIPTION=VALIDATE_D AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER6<1 THEN
                  MSG_J :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;
        
        --验证货位是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT  COUNT(*) INTO VALIDATE_NUMBER7  FROM   MTL_ITEM_LOCATIONS T WHERE (CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(T.INVENTORY_LOCATION_ID,'NAME'))=VALIDATE_E AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER7<1 THEN
                  MSG_K :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;*/
      
        --发票数量(主)不能为空
        IF VALIDATE_H IS NULL THEN
          IF MSG_L IS NULL THEN
            MSG_L := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --税率不能为空
        IF VALIDATE_S IS NULL THEN
          IF MSG_M IS NULL THEN
            MSG_M := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --物料名称不能为空
        IF VALIDATE_C IS NULL THEN
          IF MSG_N IS NULL THEN
            MSG_N := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA
        
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
               VALIDATE_V,
               VALIDATE_W,
               VALIDATE_X,
               VALIDATE_Y;
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ; 单位在EBS不存在，请检查 ';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 ; 入库单价不能为空 ';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 ; 仓库不能为空 ';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 ; 货位不能为空 ';
      END IF;
    
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 ; 本次入库数量不能为空 ';
      END IF;
    
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 ; 当编号类别为中水码或者四大管道码时,物料编码不能为空 ';
      END IF;
    
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 ; 当编号类别为流水码时,不可填写物料编码 ';
      END IF;
    
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 ; 当编号类别为中水码时,检查中水码是否正确 ';
      END IF;
    
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 ; 本组织下仓库不正确,请检查 ';
      END IF;
    
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 ; 本组织下货位不正确,请检查 ';
      END IF;
    
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 ; 发票数量(主)不能为空 ';
      END IF;
    
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 ; 税率不能为空(若无填写0) ';
      END IF;
    
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 ; 物料名称不能为空 ';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O || MSG_P || MSG_Q || MSG_R || MSG_A1 ||
               MSG_B1 || MSG_C1 || MSG_D1 || MSG_E1 || MSG_F1 || MSG_G1 ||
               MSG_H1 || MSG_I1 || MSG_J1
      
       ;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;

  --出库单导入IMPORT
  PROCEDURE DS_ODO_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2) IS
  
    --头信息1
    CURSOR CU_DATA IS
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
             TRIM(K)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '出库单头信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --行信息 2
    CURSOR CU_DATA1 IS
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
             TRIM(P)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '标的物'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --头信息定义变量1
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
  
    --行信息定义变量2
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
    VALIDATE_I1 VARCHAR2(2000);
    VALIDATE_J1 VARCHAR2(2000);
    VALIDATE_K1 VARCHAR2(2000);
    VALIDATE_L1 VARCHAR2(2000);
    VALIDATE_M1 VARCHAR2(2000);
    VALIDATE_N1 VARCHAR2(2000);
    VALIDATE_O1 VARCHAR2(2000);
    VALIDATE_P1 VARCHAR2(2000);
  
    V_INFO_ID       NUMBER;
    V_HT_ID         NUMBER;
    V_WAREHOUSE_ID  NUMBER;
    V_TARGET_ID     NUMBER;
    V_CONTRACT_ID   NUMBER;
    HAS_CONTRACT    NUMBER;
    CONTRACT_CODE_4 VARCHAR2(2000);
    MATRIAL_CODE_V  VARCHAR2(2000);
    SEQ_CODE        VARCHAR2(2000);
    HAS_CONTRACT1   NUMBER;
    V_SERIAL_NUMBER VARCHAR2(2000);
    P_TABLEID1      NUMBER;
    V_ODO_ID        NUMBER;
  
  BEGIN
  
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_K;
  
    OPEN CU_DATA1;
    FETCH CU_DATA1
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1,
           VALIDATE_I1,
           VALIDATE_J1,
           VALIDATE_K1,
           VALIDATE_L1,
           VALIDATE_M1,
           VALIDATE_N1,
           VALIDATE_O1,
           VALIDATE_P1;
  
    WHILE CU_DATA%FOUND LOOP
      SELECT T.CONTRACT_ID
        INTO V_HT_ID
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_B;
      --获取流水号
      SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_ODO',
                                                            'SPM_CON_ODO',
                                                            'ODO_CODE',
                                                            'FM00000')
        INTO V_SERIAL_NUMBER
        FROM DUAL;
    
      INSERT INTO SPM_CON_ODO
        (ODO_ID, --主键
         CONTRACT_ID, --合同ID
         CONTRACT_NAME, --合同名称
         CONTRACT_CODE, --合同编号
         PROJECT_ID,
         PROJECT_NAME,
         PROJECT_CODE,
         CUST_ID, --客户
         CUSTOMER,
         MATERIAL_TYPE, --材料类别2
         ODO_GRNI, --是否暂估5
         DIGEST, --摘要
         ODO_DATE,
         CREATION_DATE, --创建日期
         DEPT_ID, --部门
         ORG_ID, --组织
         CREATED_BY,
         ODO_CODE,
         ATTRIBUTE5,
         STATUS)
      VALUES
        (SPM_CON_ODO_SEQ.NEXTVAL,
         V_HT_ID,
         (SELECT T.CONTRACT_NAME
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_ID = V_HT_ID),
         VALIDATE_B,
         (SELECT T.PROJECT_ID
            FROM SPM_CON_PROJECT T
           WHERE T.PROJECT_CODE = VALIDATE_D),
         (SELECT T.PROJECT_NAME
            FROM SPM_CON_PROJECT T
           WHERE T.PROJECT_CODE = VALIDATE_D),
         VALIDATE_D,
         (SELECT T.CUST_ID
            FROM SPM_CON_CUST_INFO T
           WHERE T.CUST_CODE = VALIDATE_F),
         (SELECT T.CUST_NAME
            FROM SPM_CON_CUST_INFO T
           WHERE T.CUST_CODE = VALIDATE_F),
         GET_DICTCODE_BY_NAME('SPM_CON_MATERIAL_TYPE', VALIDATE_G),
         GET_DICTCODE_BY_NAME('SPM_CON_WAREHOUSE_GRNI', VALIDATE_H),
         VALIDATE_K, --摘要
         TO_DATE(SUBSTR(VALIDATE_I, 1, 10), 'YYYY-MM-DD'), --记账日期
         SYSDATE,
         (SELECT T.ORGANIZATION_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_J
             AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
         SPM_SSO_PKG.GETORGID,
         (SELECT T.USER_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_J
             AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
         V_SERIAL_NUMBER,
         'N',
         'A');
    
      FETCH CU_DATA
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
             VALIDATE_K;
    END LOOP;
  
    WHILE CU_DATA1%FOUND LOOP
      --出库单明细主键
      SELECT SPM_CON_ODO_DL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      --合同ID
      SELECT T.CONTRACT_ID
        INTO V_CONTRACT_ID
        FROM SPM_CON_ODO T
       WHERE T.CONTRACT_CODE = VALIDATE_A1
         AND T.ORG_ID = SPM_SSO_PKG.GETORGID;
      --出库单主键
      SELECT T.ODO_ID
        INTO V_ODO_ID
        FROM SPM_CON_ODO T
       WHERE T.CONTRACT_CODE = VALIDATE_A1;
    
      INSERT INTO SPM_CON_ODO_DL
        (SPM_CON_ODO_DL_ID, --主键
         ODO_ID,
         CONTRACT_ID,
         MATERIAL_CODE, --物资编码
         MATERIAL_NAME, --物料名称
         STORE_ROOM, --仓库
         STORE_ROOM_PATH, --仓库
         GOODS_LOCATION, --货位
         GOODS_LOCATION_PATH, --货位
         TARGET_COUNT, --合同数量
         UNIT, --单位
         THIS_ODO_NUMBER,
         ODO_UNIT_PRICE, --出库成本单价
         TAX_ODO_UNIT_PRICE, --销售单价
         TAX_RATE, --税率
         TARGET_AMOUNT, --出库成本金额
         TAX_AMOUNT, --销项税
         TAX_AMOUNT_COUNT, --价税合计
         CREATION_DATE,
         DEPT_ID, --部门ID
         ORG_ID)
      VALUES
        (V_INFO_ID,
         V_ODO_ID,
         V_CONTRACT_ID,
         VALIDATE_B1,
         VALIDATE_C1,
         (SELECT T.SECONDARY_INVENTORY_NAME
            FROM MTL_SECONDARY_INVENTORIES T
           WHERE T.DESCRIPTION = VALIDATE_D1
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID),
         VALIDATE_D1, --仓库
         (SELECT T.INVENTORY_LOCATION_ID
            FROM MTL_ITEM_LOCATIONS T
           WHERE T.SEGMENT1 || '.' || T.SEGMENT2 || '.' || T.SEGMENT3 || '.' ||
                 T.SEGMENT4 || '.' || T.SEGMENT5 || '.' || T.SEGMENT6 =
                 VALIDATE_E1
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID),
         VALIDATE_E1, --货位
         VALIDATE_F1, --合同数量
         VALIDATE_G1, --单位
         VALIDATE_H1, --本次出库数量
         VALIDATE_I1, --出库成本单价
         VALIDATE_J1, --销售单价
         VALIDATE_K1, --税率
         VALIDATE_H1 * VALIDATE_I1, --出库成本金额
         (VALIDATE_J1 / (1 + VALIDATE_K1 * 0.01) * VALIDATE_K1 *
         VALIDATE_H1 * 0.01), --销项税
         VALIDATE_H1 * VALIDATE_J1, --价税合计
         SYSDATE,
         (SELECT T.DEPT_ID FROM SPM_CON_ODO T WHERE T.ODO_ID = V_ODO_ID),
         SPM_SSO_PKG.GETORGID);
      --计算出库总额
      UPDATE SPM_CON_ODO AA
         SET AA.ODO_MONEY_AMOUNT =
             (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                    FROM SPM_CON_ODO_DL I
                   WHERE I.ODO_ID = AA.ODO_ID),
                  0))
       WHERE AA.ODO_ID = V_ODO_ID;
    
      FETCH CU_DATA1
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1,
             VALIDATE_I1,
             VALIDATE_J1,
             VALIDATE_K1,
             VALIDATE_L1,
             VALIDATE_M1,
             VALIDATE_N1,
             VALIDATE_O1,
             VALIDATE_P1;
    END LOOP;
    CLOSE CU_DATA;
    CLOSE CU_DATA1;
    COMMIT;
  END;

  --出库单验证VALIDATE
  PROCEDURE DS_ODO_VALIDATE(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2) IS
    --入库单头信息
    CURSOR CU_DATA IS
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
             TRIM(K)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '出库单头信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --标的物1
    CURSOR CU_DATA1 IS
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
             TRIM(P)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '标的物'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
  
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
    VALIDATE_I1 VARCHAR2(2000);
    VALIDATE_J1 VARCHAR2(2000);
    VALIDATE_K1 VARCHAR2(2000);
    VALIDATE_L1 VARCHAR2(2000);
    VALIDATE_M1 VARCHAR2(2000);
    VALIDATE_N1 VARCHAR2(2000);
    VALIDATE_O1 VARCHAR2(2000);
    VALIDATE_P1 VARCHAR2(2000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
    VALIDATE_NUMBER1    NUMBER;
    VALIDATE_NUMBER2    NUMBER;
    VALIDATE_NUMBER3    NUMBER;
    VALIDATE_NUMBER4    NUMBER;
    VALIDATE_NUMBER5    NUMBER;
    VALIDATE_NUMBER6    NUMBER;
    VALIDATE_NUMBER7    NUMBER;
    VALIDATE_NUMBER8    NUMBER;
    VALIDATE_NUMBER9    NUMBER;
    VALIDATE_NUMBER10   NUMBER;
    VALIDATE_NUMBER11   NUMBER;
    VALIDATE_NUMBER12   NUMBER;
    VALIDATE_NUMBER13   NUMBER;
    VALIDATE_NUMBER14   NUMBER;
    VALIDATE_NUMBER15   NUMBER;
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    MSG_L VARCHAR2(4000);
    MSG_M VARCHAR2(4000);
    MSG_N VARCHAR2(4000);
    MSG_O VARCHAR2(4000);
    MSG_P VARCHAR2(4000);
    MSG_Q VARCHAR2(4000);
    MSG_R VARCHAR2(4000);
  
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
    MSG_D1 VARCHAR2(4000);
    MSG_E1 VARCHAR2(4000);
    MSG_F1 VARCHAR2(4000);
    MSG_G1 VARCHAR2(4000);
    MSG_H1 VARCHAR2(4000);
    MSG_I1 VARCHAR2(4000);
    MSG_J1 VARCHAR2(4000);
    MSG_K1 VARCHAR2(4000);
    MSG_L1 VARCHAR2(4000);
    MSG_M1 VARCHAR2(4000);
    MSG_N1 VARCHAR2(4000);
    MSG_O1 VARCHAR2(4000);
    MSG_P1 VARCHAR2(4000);
    MSG_Q1 VARCHAR2(4000);
    MSG_R1 VARCHAR2(4000);
  
  BEGIN
    OPEN CU_DATA;
    OPEN CU_DATA1;
    FETCH CU_DATA
    
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
           VALIDATE_K;
  
    FETCH CU_DATA1
    
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1,
           VALIDATE_I1,
           VALIDATE_J1,
           VALIDATE_K1,
           VALIDATE_L1,
           VALIDATE_M1,
           VALIDATE_N1,
           VALIDATE_O1,
           VALIDATE_P1;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '合同名称' OR VALIDATE_B <> '*合同编号' OR
         VALIDATE_C <> '项目名称' OR VALIDATE_D <> '*项目编号' OR
         VALIDATE_E <> '客户' OR VALIDATE_F <> '*客户编号' OR
         VALIDATE_G <> '*材料类别' OR VALIDATE_H <> '*是否暂估' OR
         VALIDATE_I <> '*记账日期' OR VALIDATE_J <> '*经办人' OR
         VALIDATE_K <> '摘要' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
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
             VALIDATE_K;
    
      WHILE CU_DATA%FOUND LOOP
      
        --验证为空的 合同编号 项目编号 客户编号 第一批不为空
        IF VALIDATE_B IS NULL OR VALIDATE_D IS NULL OR VALIDATE_F IS NULL THEN
          MSG_A := CU_DATA%ROWCOUNT;
        END IF;
      
        --验证为空的  材料类别 是否暂估 记账日期 经办人  第二批不为空
        IF VALIDATE_G IS NULL OR VALIDATE_H IS NULL OR VALIDATE_I IS NULL OR
           VALIDATE_J IS NULL THEN
          MSG_B := CU_DATA%ROWCOUNT;
        END IF;
      
        --验证数据字典 物资来源
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_MATERIAL_TYPE',
                                                  VALIDATE_G)
          INTO VALIDATE_NUMBER1
          FROM DUAL;
        SELECT SPM_CON_VENDOR_PACKAGE.IS_HAD_DICT('SPM_CON_WAREHOUSE_GRNI',
                                                  VALIDATE_H)
          INTO VALIDATE_NUMBER2
          FROM DUAL;
      
        --验证数据字典:材料类别
        IF VALIDATE_G IS NOT NULL THEN
          IF VALIDATE_NUMBER1 < 1 THEN
            MSG_C := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证数据字典:是否暂估
        IF VALIDATE_H IS NOT NULL THEN
          IF VALIDATE_NUMBER2 < 1 THEN
            MSG_D := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        --验证经办人是否存在
        IF VALIDATE_J IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER3
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_J;
          IF VALIDATE_NUMBER3 < 1 THEN
            MSG_E := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA
        
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
               VALIDATE_K;
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ; 合同编号,项目编号,客户编号不能为空';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 ; 材料类别,是否暂估,记账日期,经办人不能为空';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 ; 材料类别不存在,请检查';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 ; 是否暂估不存在,请检查';
      END IF;
    
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 ; 经办人不存在';
      END IF;
    
    END IF;
  
    --验证导入字段名格式是否正确(第二部分)
    IF CU_DATA1%FOUND THEN
      IF VALIDATE_A1 <> '*合同编号' OR VALIDATE_B1 <> '*物料编码
(编号类别为中水码或者管道时，必填)' OR VALIDATE_C1 <> '*物料名称' OR
         VALIDATE_D1 <> '仓库' OR VALIDATE_E1 <> '货位' OR
         VALIDATE_F1 <> '合同数量' OR VALIDATE_G1 <> '*单位' OR
         VALIDATE_H1 <> '*本次出库数量' OR VALIDATE_I1 <> '*出库成本单价' OR
         VALIDATE_J1 <> '销售单价(含税)' OR VALIDATE_K1 <> '*税率(%)' OR
         VALIDATE_L1 <> '出库成本金额' OR VALIDATE_M1 <> '销项税' OR
         VALIDATE_N1 <> '价税合计' OR VALIDATE_O1 <> '生产厂家' OR
         VALIDATE_P1 <> '备注' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA1;
        RETURN;
      END IF;
      FETCH CU_DATA1
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1,
             VALIDATE_I1,
             VALIDATE_J1,
             VALIDATE_K1,
             VALIDATE_L1,
             VALIDATE_M1,
             VALIDATE_N1,
             VALIDATE_O1,
             VALIDATE_P1;
    
      WHILE CU_DATA1%FOUND LOOP
      
        --验证单位是否在EBS存在
        IF VALIDATE_G1 IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER4
            FROM MTL_UNITS_OF_MEASURE T
           WHERE T.UNIT_OF_MEASURE = VALIDATE_G1;
          IF VALIDATE_NUMBER4 < 1 THEN
            MSG_A1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证物料编码 物料名称 单位不能为空
        IF VALIDATE_B1 IS NULL OR VALIDATE_C1 IS NULL OR
           VALIDATE_G1 IS NULL THEN
          IF MSG_B1 IS NULL THEN
            MSG_B1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        --验证本次出库数量 税率不能为空
        IF VALIDATE_J1 IS NULL OR VALIDATE_K1 IS NULL THEN
          IF MSG_C1 IS NULL THEN
            MSG_C1 := CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        /*        --验证仓库是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT COUNT(*) INTO VALIDATE_NUMBER6 FROM MTL_SECONDARY_INVENTORIES T WHERE T.DESCRIPTION=VALIDATE_D AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER6<1 THEN
                  MSG_J :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;
        
        --验证货位是否存在
            IF VALIDATE_D IS NOT NULL   THEN
             SELECT  COUNT(*) INTO VALIDATE_NUMBER7  FROM   MTL_ITEM_LOCATIONS T WHERE (CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(T.INVENTORY_LOCATION_ID,'NAME'))=VALIDATE_E AND T.ORGANIZATION_ID=SPM_SSO_PKG.GETORGID;
             IF VALIDATE_NUMBER7<1 THEN
                  MSG_K :=CU_DATA%ROWCOUNT;
             END IF;
            END IF;*/
      
        FETCH CU_DATA1
        
          INTO VALIDATE_A1,
               VALIDATE_B1,
               VALIDATE_C1,
               VALIDATE_D1,
               VALIDATE_E1,
               VALIDATE_F1,
               VALIDATE_G1,
               VALIDATE_H1,
               VALIDATE_I1,
               VALIDATE_J1,
               VALIDATE_K1,
               VALIDATE_L1,
               VALIDATE_M1,
               VALIDATE_N1,
               VALIDATE_O1,
               VALIDATE_P1;
      
      END LOOP;
      CLOSE CU_DATA1;
    
      IF MSG_A1 IS NOT NULL THEN
        MSG_A1 := MSG_A1 || '行 ; 单位在EBS不存在，请检查 ';
      END IF;
    
      IF MSG_B1 IS NOT NULL THEN
        MSG_B1 := MSG_B1 || '行 ; 物料编码,物料名称,单位不能为空 ';
      END IF;
    
      IF MSG_C1 IS NOT NULL THEN
        MSG_C1 := MSG_C1 || '行 ; 本次出库数量,税率不能 ';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O || MSG_P || MSG_Q || MSG_R || MSG_A1 ||
               MSG_B1 || MSG_C1 || MSG_D1 || MSG_E1 || MSG_F1 || MSG_G1 ||
               MSG_H1 || MSG_I1 || MSG_J1
      
       ;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;

  --标的物导入
  PROCEDURE HT_TARGET_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
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
             TRIM(P)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A      VARCHAR2(2000);
    VALIDATE_B      VARCHAR2(2000);
    VALIDATE_C      VARCHAR2(2000);
    VALIDATE_D      VARCHAR2(2000);
    VALIDATE_E      VARCHAR2(2000);
    VALIDATE_F      VARCHAR2(2000);
    VALIDATE_G      VARCHAR2(2000);
    VALIDATE_H      VARCHAR2(2000);
    VALIDATE_I      VARCHAR2(2000);
    VALIDATE_J      VARCHAR2(2000);
    VALIDATE_K      VARCHAR2(2000);
    VALIDATE_L      VARCHAR2(2000);
    VALIDATE_M      VARCHAR2(2000);
    VALIDATE_N      VARCHAR2(2000);
    VALIDATE_O      VARCHAR2(2000);
    VALIDATE_P      VARCHAR2(2000);
    CONTRACT_CODE_4 VARCHAR2(40);
    MATRIAL_CODE_V  VARCHAR2(40);
    SEQ_CODE        VARCHAR2(40);
    HAS_CONTRACT    NUMBER;
  
    V_INFO_ID NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_P;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_HT_TARGET_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
    
      INSERT INTO SPM_CON_HT_TARGET T
        (TARGET_ID, --主键
         CONTRACT_ID,
         MATERIAL_NAME, --物料名称
         MATERIAL_CODE, --物料编码E
         CODE_TYPE, --F
         TARGET_SOURCE_TYPE, --类型G
         TARGET_UNIT, --单位H
         TARGET_COUNT, --数量I
         UNIT_PRICE, --单价J
         TARGET_AMOUNT, --金额K
         GOODS_WF_STATUS, --流程状态L
         PIPELINE_NUMBER, --L
         STOVE_NUMBER, --M
         CREATED_BY,
         CREATION_DATE,
         IS_DELETE)
      VALUES
        (V_INFO_ID,
         F_TABLEID,
         VALIDATE_A || '|' || VALIDATE_B || '|' || VALIDATE_C || '|' ||
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
         VALIDATE_P,
         SYSDATE,
         0);
      IF VALIDATE_F = '大流水码' THEN
        SELECT COUNT(*)
          INTO HAS_CONTRACT
          FROM SPM_CON_HT_TARGET O
         WHERE O.CONTRACT_ID = F_TABLEID
           AND O.CODE_TYPE = '大流水码';
        --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
        SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
          INTO CONTRACT_CODE_4
          FROM SPM_CON_HT_INFO O
         WHERE O.CONTRACT_ID = P_TABLEID;
        IF HAS_CONTRACT > 1 THEN
          SELECT MAX(MATERIAL_CODE)
            INTO MATRIAL_CODE_V
            FROM (SELECT T.MATERIAL_CODE
                    FROM SPM_CON_HT_TARGET T
                   WHERE T.CONTRACT_ID = P_TABLEID
                     AND LENGTH(T.MATERIAL_CODE) = 16);
          SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                LENGTH(MATRIAL_CODE_V) - 2,
                                                LENGTH(MATRIAL_CODE_V))) + 1）,
                               '000'))
            INTO SEQ_CODE
            FROM DUAL;
          UPDATE SPM_CON_HT_TARGET T
             SET T.MATERIAL_CODE = REPLACE(MATRIAL_CODE_V,
                                           SUBSTR(MATRIAL_CODE_V,
                                                  LENGTH(MATRIAL_CODE_V) - 2,
                                                  LENGTH(MATRIAL_CODE_V)),
                                           SEQ_CODE)
           WHERE T.TARGET_ID = V_INFO_ID;
        ELSE
          UPDATE SPM_CON_HT_TARGET T
             SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '001'
           WHERE T.TARGET_ID = V_INFO_ID;
        END IF;
      END IF;
      FETCH CU_DATA
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
             VALIDATE_P;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --标的物导入验证
  PROCEDURE HT_TARGET_VALIDATE(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(N)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000); --物料名称
    VALIDATE_B       VARCHAR2(2000); --规格型号
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
    VALIDATE_E       VARCHAR2(2000); --物料编码
    VALIDATE_F       VARCHAR2(2000); --编号类别
    VALIDATE_G       VARCHAR2(2000);
    VALIDATE_H       VARCHAR2(2000); --单位
    VALIDATE_I       VARCHAR2(2000); --数量
    VALIDATE_J       VARCHAR2(2000); --单价
    VALIDATE_K       VARCHAR2(2000);
    VALIDATE_L       VARCHAR2(2000);
    VALIDATE_M       VARCHAR2(2000);
    VALIDATE_N       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    MSG_A            VARCHAR2(4000); ----物料名称
    MSG_B            VARCHAR2(4000); ----规格型号
    MSG_C            VARCHAR2(4000);
    MSG_D            VARCHAR2(4000);
    MSG_E            VARCHAR2(4000); ----物料编码
    MSG_F            VARCHAR2(4000); --编号类别
    MSG_G            VARCHAR2(4000);
    MSG_H            VARCHAR2(4000); --单位
    MSG_I            VARCHAR2(4000); --数量
    MSG_J            VARCHAR2(4000); --单价
    MSG_K            VARCHAR2(4000);
    MSG_L            VARCHAR2(4000);
    MSG_M            VARCHAR2(4000);
    MSG_N            VARCHAR2(4000);
    MSG_O            VARCHAR2(4000);
    MSG_P            VARCHAR2(4000);
    MSG_Q            VARCHAR2(4000);
    MSG_R            VARCHAR2(4000);
    MSG_S            VARCHAR2(4000);
    MSG_T            VARCHAR2(4000);
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
      INTO VALIDATE_A, --物料名称
           VALIDATE_B, --规格型号
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E, --物料编码
           VALIDATE_F, --编号类别
           VALIDATE_G,
           VALIDATE_H, --单位
           VALIDATE_I, --数量
           VALIDATE_J, --单价
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           VALIDATE_N;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '物料名称' OR VALIDATE_B <> '规格型号' OR VALIDATE_C <> '图号' OR
         VALIDATE_D <> '材质' OR VALIDATE_E <> '物料编码' OR VALIDATE_F <> '编号类别' OR
         VALIDATE_G <> '所属类别' OR VALIDATE_H <> '单位' OR VALIDATE_I <> '数量' OR
         VALIDATE_J <> '单价' OR VALIDATE_K <> '金额' OR
         VALIDATE_L <> '交货计划流程状态' OR VALIDATE_M <> '管号' OR
         VALIDATE_N <> '炉号' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
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
             VALIDATE_N;
      WHILE CU_DATA%FOUND LOOP
        IF VALIDATE_A IS NULL OR VALIDATE_B IS NULL OR VALIDATE_C IS NULL OR
           VALIDATE_D IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F IS NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_G IS NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_H IS NULL THEN
          IF MSG_E IS NULL THEN
            MSG_E := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_I IS NULL THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA%ROWCOUNT;
          ELSE
            MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_J IS NULL THEN
          IF MSG_G IS NULL THEN
            MSG_G := CU_DATA%ROWCOUNT;
          ELSE
            MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_K IS NULL THEN
          IF MSG_H IS NULL THEN
            MSG_H := CU_DATA%ROWCOUNT;
          ELSE
            MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_L IS NULL THEN
          IF MSG_I IS NULL THEN
            MSG_I := CU_DATA%ROWCOUNT;
          ELSE
            MSG_I := MSG_I || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F = '四大管道编码' THEN
          IF VALIDATE_M IS NULL THEN
            IF MSG_J IS NULL THEN
              MSG_J := CU_DATA%ROWCOUNT;
            ELSE
              MSG_J := MSG_J || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
          IF VALIDATE_N IS NULL THEN
            IF MSG_K IS NULL THEN
              MSG_K := CU_DATA%ROWCOUNT;
            ELSE
              MSG_K := MSG_K || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_I IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_I)
            INTO VALIDATE_NUMBER
            FROM DUAL;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_L IS NULL THEN
              MSG_L := CU_DATA%ROWCOUNT;
            ELSE
              MSG_L := MSG_L || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_J IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_J)
            INTO VALIDATE_NUMBER1
            FROM DUAL;
          IF VALIDATE_NUMBER1 = 0 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_K IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_K)
            INTO VALIDATE_NUMBER2
            FROM DUAL;
          IF VALIDATE_NUMBER2 = 0 THEN
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA%ROWCOUNT;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_E IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER2
            FROM SPM_CON_HT_TARGET T
           WHERE T.MATERIAL_CODE = VALIDATE_E;
          IF VALIDATE_NUMBER2 > 0 THEN
            IF MSG_O IS NULL THEN
              MSG_O := CU_DATA%ROWCOUNT;
            ELSE
              MSG_O := MSG_O || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_L IS NOT NULL THEN
          IF VALIDATE_L <> '1' AND VALIDATE_L <> '2' THEN
            IF MSG_P IS NULL THEN
              MSG_P := CU_DATA%ROWCOUNT;
            ELSE
              MSG_P := MSG_P || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_F IS NOT NULL THEN
          IF VALIDATE_F <> '中水码' AND VALIDATE_F <> '四大管道编码' AND
             VALIDATE_F <> '大流水码' THEN
            MSG_Q := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F = '四大管道编码' THEN
          IF VALIDATE_E IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F = '中水码' THEN
          IF VALIDATE_E IS NOT NULL THEN
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER4
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.SEGMENT1 = VALIDATE_E;
            IF VALIDATE_NUMBER4 = 0 THEN
              MSG_R := CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        --如果不是中水码 则调用物料传EBS的存储过程
        IF VALIDATE_F <> '中水码' THEN
          CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO(P_TABLEID, MSG_T);
        END IF;
      
        FETCH CU_DATA
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
               VALIDATE_N;
      END LOOP;
    
      CLOSE CU_DATA;
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 物料名称不完整;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 编号类别不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 所属类别不能为空;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 单位不能为空;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 数量不能为空;  ';
      END IF;
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 单价不能为空;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 金额不能为空;  ';
      END IF;
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 交货计划不能为空;  ';
      END IF;
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 编码类别为四大管道时，管号不能为空;  ';
      END IF;
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 编码类别为四大管道时，炉号不能为空;  ';
      END IF;
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 单价格式不正确，应为数字; ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 单价格式不正确，应为数字; ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 金额格式不正确，应为数字; ';
      END IF;
      IF MSG_O IS NOT NULL THEN
        MSG_O := MSG_O || '行 该条记录已经导入,不能重复导入; ';
      END IF;
      IF MSG_P IS NOT NULL THEN
        MSG_P := MSG_P || '行 交货计划流程填写格式不正确,1代表启动,2代表未启动; ';
      END IF;
      IF MSG_Q IS NOT NULL THEN
        MSG_Q := MSG_Q || '行 编码类别填写不正确，应填写中水码，四大管道编码或大流水码; ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 编码类别为四大管道编码时，物料编码不能为空; ';
      END IF;
      IF MSG_R IS NOT NULL THEN
        MSG_R := MSG_R || '行 您所填写的中水码不存在,请重新检查; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_O || MSG_P || MSG_Q || MSG_R;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  
  END;
  --入库单验证VALIDATE
  PROCEDURE PERSON_SALARY_VALIDATE(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000);
    VALIDATE_B       VARCHAR2(2000);
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
    VALIDATE_E       VARCHAR2(2000);
    VALIDATE_F       VARCHAR2(2000);
    VALIDATE_G       VARCHAR2(2000);
    VALIDATE_H       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    MSG_A            VARCHAR2(4000);
    MSG_B            VARCHAR2(4000);
    MSG_C            VARCHAR2(4000);
    MSG_D            VARCHAR2(4000);
    MSG_E            VARCHAR2(4000);
    MSG_F            VARCHAR2(4000);
    MSG_G            VARCHAR2(4000);
    MSG_H            VARCHAR2(4000);
    MSG_I            VARCHAR2(4000);
    MSG_J            VARCHAR2(4000);
    MSG_K            VARCHAR2(4000);
    MSG_L            VARCHAR2(4000);
    MSG_M            VARCHAR2(4000);
    MSG_N            VARCHAR2(4000);
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
      INTO VALIDATE_A,
           VALIDATE_B,
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E,
           VALIDATE_F,
           VALIDATE_G,
           VALIDATE_H;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      RETURN;
      IF VALIDATE_A <> '物料编码' OR VALIDATE_B <> '物料名称' OR
         VALIDATE_C <> '所属类别' OR VALIDATE_D <> '单位' OR VALIDATE_E <> '数量' OR
         VALIDATE_F <> '单价' OR VALIDATE_G <> '金额' OR
         VALIDATE_H <> '交货计划流程状态' THEN
        P_MSG := '导入数据的字段名不符合格式';
        CLOSE CU_DATA;
      
      END IF;
      FETCH CU_DATA
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F,
             VALIDATE_G,
             VALIDATE_H;
      WHILE CU_DATA%FOUND LOOP
        IF VALIDATE_A IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_B IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_C IS NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D IS NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E IS NULL THEN
          IF MSG_E IS NULL THEN
            MSG_E := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F IS NULL THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA%ROWCOUNT;
          ELSE
            MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_G IS NULL THEN
          IF MSG_G IS NULL THEN
            MSG_G := CU_DATA%ROWCOUNT;
          ELSE
            MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_H IS NULL THEN
          IF MSG_H IS NULL THEN
            MSG_H := CU_DATA%ROWCOUNT;
          ELSE
            MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_E)
            INTO VALIDATE_NUMBER
            FROM DUAL;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_I IS NULL THEN
              MSG_I := CU_DATA%ROWCOUNT;
            ELSE
              MSG_I := MSG_I || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_F IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_F)
            INTO VALIDATE_NUMBER1
            FROM DUAL;
          IF VALIDATE_NUMBER1 = 0 THEN
            IF MSG_J IS NULL THEN
              MSG_J := CU_DATA%ROWCOUNT;
            ELSE
              MSG_J := MSG_J || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_G IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_G)
            INTO VALIDATE_NUMBER2
            FROM DUAL;
          IF VALIDATE_NUMBER2 = 0 THEN
            IF MSG_K IS NULL THEN
              MSG_K := CU_DATA%ROWCOUNT;
            ELSE
              MSG_K := MSG_K || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER2
            FROM SPM_CON_HT_TARGET T
           WHERE T.MATERIAL_CODE = VALIDATE_A;
          IF VALIDATE_NUMBER2 > 0 THEN
            IF MSG_L IS NULL THEN
              MSG_L := CU_DATA%ROWCOUNT;
            ELSE
              MSG_L := MSG_L || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_H IS NOT NULL THEN
          IF VALIDATE_H <> '1' AND VALIDATE_H <> '2' THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        FETCH CU_DATA
          INTO VALIDATE_A,
               VALIDATE_B,
               VALIDATE_C,
               VALIDATE_D,
               VALIDATE_E,
               VALIDATE_F,
               VALIDATE_G,
               VALIDATE_H;
      END LOOP;
      CLOSE CU_DATA;
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 物料编码不能为空;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 物料名称不能为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 所属类别不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 单位不能为空;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 数量不能为空;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 单价不能为空;  ';
      END IF;
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 金额不能为空;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 交货计划流程状态不能为空;  ';
      END IF;
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 数量格式不正确，应为数字;  ';
      END IF;
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 单价格式不正确，应为数字;  ';
      END IF;
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 金额格式不正确，应为数字;  ';
      END IF;
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 该条记录已经存在，不能重复提交; ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 流程状态格式不正确，1代表启动，2代表未启动; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M;
    
      RETURN;
    END IF;
  END;
  --标的物导入
  PROCEDURE PERSON_SALARY_IMPORT(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 F_TABLENAME VARCHAR2,
                                 F_TABLEID   VARCHAR2,
                                 P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z),
             TRIM(AA),
             TRIM(AB),
             TRIM(AC),
             TRIM(AD)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
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
    VALIDATE_X  VARCHAR2(2000);
    VALIDATE_Y  VARCHAR2(2000);
    VALIDATE_Z  VARCHAR2(2000);
    VALIDATE_AA VARCHAR2(2000);
    VALIDATE_AB VARCHAR2(2000);
    VALIDATE_AC VARCHAR2(2000);
    VALIDATE_AD VARCHAR2(2000);
  
    V_INFO_ID NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z,
           VALIDATE_AA,
           VALIDATE_AB,
           VALIDATE_AC,
           VALIDATE_AD;
  
    WHILE CU_DATA%FOUND LOOP
      IF LENGTH(VALIDATE_F) > 1 THEN
        INSERT INTO SPM_GZ_EMPLOYEE
          (PERSON_ID,
           CARD_ID,
           NAME,
           PERSON_KIND,
           EMPLOY_KIND,
           IDENTITY_ID,
           WAGE_BANK_CODE,
           WAGE_BANK_NAME,
           WAGE_BANK_ACCOUNT,
           SERVICE_STATUS_CODE,
           SERVICE_STATUS_NAME,
           DIMISSION_DATE,
           DESCRIPTION,
           SEX,
           DUTY,
           PROFESSIONAL_POST,
           ROLESALARY_RATE,
           SALARY_LEVEL,
           BONUS_RATE,
           BIRTHDAY,
           JOB_DATE,
           CORP_DATE,
           CHILD_BIRTHDAY,
           ORG_ID,
           DEPT_ID)
        VALUES
          (SPM_GZ_EMPLOYEE_SEQ.NEXTVAL,
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z,
           VALIDATE_AB,
           VALIDATE_AC,
           VALIDATE_AD,
           (SELECT N.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_A),
           (SELECT N.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_F));
      ELSE
        INSERT INTO SPM_GZ_EMPLOYEE
          (PERSON_ID,
           CARD_ID,
           NAME,
           PERSON_KIND,
           EMPLOY_KIND,
           IDENTITY_ID,
           WAGE_BANK_CODE,
           WAGE_BANK_NAME,
           WAGE_BANK_ACCOUNT,
           SERVICE_STATUS_CODE,
           SERVICE_STATUS_NAME,
           DIMISSION_DATE,
           DESCRIPTION,
           SEX,
           DUTY,
           PROFESSIONAL_POST,
           ROLESALARY_RATE,
           SALARY_LEVEL,
           BONUS_RATE,
           BIRTHDAY,
           JOB_DATE,
           CORP_DATE,
           CHILD_BIRTHDAY,
           ORG_ID,
           DEPT_ID)
        VALUES
          (SPM_GZ_EMPLOYEE_SEQ.NEXTVAL,
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z,
           VALIDATE_AB,
           VALIDATE_AC,
           VALIDATE_AD,
           (SELECT N.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_A),
           (SELECT N.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_D));
      END IF;
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z,
             VALIDATE_AA,
             VALIDATE_AB,
             VALIDATE_AC,
             VALIDATE_AD;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  PROCEDURE INSERT_ORGANIZATION(LINE NUMBER) IS
  BEGIN
    FOR C IN 1 .. LINE LOOP
      INSERT INTO SPM_GZ_ORGANIZATION
        (ORGANIZATION_ID)
      VALUES
        (SPM_GZ_ORGANIZATION_SEQ.NEXTVAL);
    END LOOP;
  END;
  --退货单审批HTML展现
  FUNCTION CLS_SALES_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG               VARCHAR2(20000);
    V_SALES_RETURN_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_SALES_RETURN_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<A HREF=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/SPMCONSALESRETURN/EDIT/' ||
                                                V_SALES_RETURN_ID,
                                                P_KEY) || '''>查看详情</A><BR>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --入库单审批HTML展现
  FUNCTION CLS_WAREHOUSE_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG           VARCHAR2(20000);
    V_WAREHOUE_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_WAREHOUE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<A HREF=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/SPMCONWAREHOUSE/EDIT/' ||
                                                V_WAREHOUE_ID,
                                                P_KEY) || '''>查看详情</A><BR>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --出库单审批HTML展现
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG      VARCHAR2(20000);
    V_ODO_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ODO_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<A HREF=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/SPMCONODO/EDIT/' ||
                                                V_ODO_ID,
                                                P_KEY) || '''>查看详情</A><BR>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --交货计划维护审批HTML展现
  FUNCTION CLS_GOODS_PLAN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                        POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG             VARCHAR2(20000);
    V_GOODS_PLAN_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_GOODS_PLAN_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<A HREF=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/SPMCONGOODSPLAN/EDIT/' ||
                                                V_GOODS_PLAN_ID,
                                                P_KEY) || '''>查看详情</A><BR>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --入库单流程通知生成回调
  PROCEDURE SPM_CON_WAREHOUSE_TZSC(P_NOTIFID    IN VARCHAR2,
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_WAREHOUSE',
                          'WAREHOUSE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_WAREHOUSE_TZSC;

  --入库单流程通知处理(后)回调
  PROCEDURE SPM_CON_WAREHOUSE_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_WAREHOUSE_TZH;

  --出库单流程通知生成回调
  PROCEDURE SPM_CON_ODO_TZSC(P_NOTIFID    IN VARCHAR2,
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_ODO',
                          'ODO_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_ODO_TZSC;

  --出库单流程通知处理(后)回调
  PROCEDURE SPM_CON_ODO_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    COMMIT;
    UPDATE SPM_CON_ODO T
       SET OUTPUT_OR_RETURN = '2'
     WHERE T.ITEM_KEY = P_KEY;
    COMMIT;
  END SPM_CON_ODO_TZH;

  --交货计划流程通知生成回调
  PROCEDURE SPM_CON_GOODS_PLAN_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_GOODS_PLAN',
                          'GOODS_PLAN_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_GOODS_PLAN_TZSC;

  --交货计划程通知处理(后)回调
  PROCEDURE SPM_CON_GOODS_PLAN_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_GOODS_PLAN_TZH;

  --退货单流程通知生成回调
  PROCEDURE SPM_CON_SALES_RETURN_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_SALES_RETURN',
                          'SALES_RETURN_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_SALES_RETURN_TZSC;

  --退货单流程通知处理(后)回调
  PROCEDURE SPM_CON_SALES_RETURN_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
    V_DD            NUMBER;
    V_DDD           NUMBER;
    V_SALES_RETURN  NUMBER;
    V_SALES_RETURN1 NUMBER;
    V_AAA           NUMBER;
    CURSOR CUR IS
      SELECT S.ODO_ID
        FROM SPM_CON_ODO_DL S, SPM_CON_SALES_RETURN F
       WHERE F.ITEM_KEY = P_KEY
         AND F.ODO_ID = S.ODO_ID;
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    SELECT F.ODO_ID
      INTO V_DD
      FROM SPM_CON_SALES_RETURN F
     WHERE F.ITEM_KEY = P_KEY;
  
    UPDATE SPM_CON_ODO SET OUTPUT_OR_RETURN = '1' WHERE ODO_ID = V_DD;
    FOR C IN CUR LOOP
      UPDATE SPM_CON_ODO_DL F
         SET F.THIS_ODO_NUMBER = F.THIS_ODO_NUMBER - F.SALES_RETURN
       WHERE F.ODO_ID = V_DD;
    END LOOP;
  
    /*
    SELECT ODO_ID INTO V_DDD FROM SPM_CON_SALES_RETURN F  WHERE F.ITEM_KEY = P_KEY;
    SELECT T.SALES_RETURN INTO V_SALES_RETURN FROM SPM_CON_ODO_DL T WHERE  T.ODO_ID=V_DDD;
    SELECT T.ED_SALES_RETURN INTO V_SALES_RETURN1 FROM SPM_CON_ODO_DL T WHERE  T.ODO_ID=V_DDD;
    V_SALES_RETURN1 :=V_SALES_RETURN+V_SALES_RETURN;
    UPDATE  SPM_CON_ODO_DL  E SET E.ED_SALES_RETURN=V_SALES_RETURN1;
    COMMIT;*/
  END SPM_CON_SALES_RETURN_TZH;

  --退货单
  PROCEDURE SPM_CON_COUNT_SALES_RETURN(ID NUMBER) AS
    V_ID      NUMBER;
    V_AMOUNT  NUMBER;
    V_AMOUNT1 NUMBER;
  
  BEGIN
    SELECT T.ODO_ID
      INTO V_ID
      FROM SPM_CON_SALES_RETURN T
     WHERE T.SALES_RETURN_ID = ID;
  
  END;

  --校验所有的物料编码都在EBS
  FUNCTION VALIDATE_EBSCODE(P_ID NUMBER) RETURN VARCHAR2 IS
    V_CODE VARCHAR2(200);
    MSG_A  VARCHAR2(2000);
    MSG_B  VARCHAR2(2000);
    MSG_C  VARCHAR2(2000);
    MSG_D  VARCHAR2(2000);
    R_TEXT VARCHAR2(200) := 'S';
  
    V_NUMBER  NUMBER;
    V_NUMBER1 NUMBER;
    V_NUMBER2 NUMBER;
    V_NUMBER3 NUMBER;
  
  BEGIN
  
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM SPM_CON_WAREHOUSE_DL D
     WHERE D.WAREHOUSE_ID = P_ID
       AND NOT EXISTS (SELECT *
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.ORGANIZATION_ID = D.ORG_ID
               AND D.MATERIAL_CODE = B.SEGMENT1);
  
    IF V_NUMBER <> 0 THEN
      R_TEXT := '该入库单下存在尚未传入ebs的物料!!!';
      RETURN R_TEXT;
    END IF;
  
    SELECT COUNT(*)
      INTO V_NUMBER1
      FROM SPM_CON_WAREHOUSE_DL D
     WHERE D.WAREHOUSE_ID = P_ID
       AND NOT EXISTS
     (SELECT *
              FROM MTL_SECONDARY_INVENTORIES T
             WHERE T.ORGANIZATION_ID = D.ORG_ID
               AND D.STORE_ROOM = T.SECONDARY_INVENTORY_NAME);
  
    IF V_NUMBER1 <> 0 THEN
      R_TEXT := '仓库在本组织下不存在';
      RETURN R_TEXT;
    END IF;
  
    SELECT COUNT(*)
      INTO V_NUMBER2
      FROM SPM_CON_WAREHOUSE_DL D
     WHERE D.WAREHOUSE_ID = P_ID
       AND NOT EXISTS
     (SELECT *
              FROM MTL_ITEM_LOCATIONS T
             WHERE T.ORGANIZATION_ID = D.ORG_ID
               AND D.GOODS_POSITION = T.INVENTORY_LOCATION_ID);
  
    IF V_NUMBER2 <> 0 THEN
      R_TEXT := '货位在本组织下不存在';
      RETURN R_TEXT;
    END IF;
  
    RETURN R_TEXT;
  
  END VALIDATE_EBSCODE;

  --校验退货单不能所有数量都为空
  PROCEDURE VALIDATE_SALES_RETURN(P_ID NUMBER, OUT_MSG OUT VARCHAR2) IS
    V_CODE    VARCHAR2(200);
    V_NUMBER  NUMBER;
    V_NUMBER1 NUMBER;
    V_1       NUMBER;
  
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_ODO_DL T
       WHERE T.ODO_ID = (SELECT F.ODO_ID
                           FROM SPM_CON_SALES_RETURN F
                          WHERE F.SALES_RETURN_ID = P_ID);
  
  BEGIN
    FOR C IN CUR LOOP
      SELECT COUNT(*)
        INTO V_NUMBER
        FROM SPM_CON_ODO_DL T
       WHERE T.SPM_CON_ODO_DL_ID = C.SPM_CON_ODO_DL_ID;
      SELECT T.SALES_RETURN
        INTO V_NUMBER
        FROM SPM_CON_ODO_DL T
       WHERE T.SPM_CON_ODO_DL_ID = C.SPM_CON_ODO_DL_ID;
      IF V_NUMBER1 = 0 THEN
        V_1 := V_1 + 1;
      END IF;
      IF V_1 = V_NUMBER THEN
        OUT_MSG := '不能所有的退货数量都为零';
      END IF;
    END LOOP;
  
  END;

  --标的物导入
  PROCEDURE HT_TARGET_IMPORT1(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), --物料名称
             TRIM(B), --规格型号
             TRIM(C), --物料编码
             TRIM(D), --编号类别
             TRIM(E), --单位
             TRIM(F), --数量
             TRIM(G), --单价
             TRIM(H),
             TRIM(I),
             TRIM(J),
             TRIM(K),
             TRIM(L),
             TRIM(M),
             TRIM(N),
             TRIM(O),
             TRIM(P)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A      VARCHAR2(2000);
    VALIDATE_B      VARCHAR2(2000);
    VALIDATE_C      VARCHAR2(2000);
    VALIDATE_D      VARCHAR2(2000);
    VALIDATE_E      VARCHAR2(2000);
    VALIDATE_F      VARCHAR2(2000);
    VALIDATE_G      VARCHAR2(2000);
    VALIDATE_H      VARCHAR2(2000);
    VALIDATE_I      VARCHAR2(2000);
    VALIDATE_J      VARCHAR2(2000);
    VALIDATE_K      VARCHAR2(2000);
    VALIDATE_L      VARCHAR2(2000);
    VALIDATE_M      VARCHAR2(2000);
    VALIDATE_N      VARCHAR2(2000);
    VALIDATE_O      VARCHAR2(2000);
    VALIDATE_P      VARCHAR2(2000);
    CONTRACT_CODE_4 VARCHAR2(40);
    MATRIAL_CODE_V  VARCHAR2(40);
    SEQ_CODE        VARCHAR2(40);
    HAS_CONTRACT    NUMBER;
  
    V_INFO_ID       NUMBER;
    V_GOODS_PLAN_ID NUMBER;
    MSG_T           VARCHAR2(4000);
    P_LINE          SPM_CON_HT_TARGET%ROWTYPE;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_P;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_HT_TARGET_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      SELECT SPM_CON_HT_GOODS_PLAN_SEQ.NEXTVAL
        INTO V_GOODS_PLAN_ID
        FROM DUAL;
    
      P_LINE.TARGET_ID           := V_INFO_ID; --主键
      P_LINE.CONTRACT_ID         := F_TABLEID; --合同主键
      P_LINE.CODE_TYPE           := VALIDATE_A; --编号类别F
      P_LINE.MATERIAL_NAME       := VALIDATE_C; --物料名称
      P_LINE.SPECIFICATION_MODEL := VALIDATE_D; --规格型号
      P_LINE.TARGET_UNIT         := VALIDATE_E; --单位
      P_LINE.TARGET_COUNT        := VALIDATE_F; --数量
      P_LINE.UNIT_PRICE          := VALIDATE_G; --单价
      P_LINE.TAX_CODE            := VALIDATE_H; --税收分类编码
      P_LINE.CREATED_BY          := SPM_SSO_PKG.GETUSERID; --创建人
      P_LINE.CREATION_DATE       := SYSDATE; --时间      
      P_LINE.IS_DELETE           := 0;
      P_LINE.TARGET_AMOUNT       := VALIDATE_F * VALIDATE_G;
    
      IF VALIDATE_A = '流水码' THEN
        P_LINE.MATERIAL_CODE := SPM_CON_HT_PKG.GET_TARGET_CODE(F_TABLEID); --物料编码
      END IF;
      INSERT INTO SPM_CON_HT_TARGET VALUES P_LINE;
    
      INSERT INTO SPM_CON_HT_GOODS_PLAN T
        (GOODS_PLAN_ID, --主键
         CONTRACT_ID, --合同ID
         TARGET_ID, --标的物ID
         MATERIAL_CODE, --物料编码E
         MATERIAL_NAME, --物料名称A
         CREATED_BY,
         CREATION_DATE,
         IS_TARGET_DEL)
      VALUES
        (V_GOODS_PLAN_ID, --主键
         F_TABLEID, --合同主键
         V_INFO_ID, --标的物ID
         (SELECT T.MATERIAL_CODE
            FROM SPM_CON_HT_TARGET T
           WHERE T.TARGET_ID = V_INFO_ID), --物料编码
         VALIDATE_C, --物料名称
         SPM_SSO_PKG.GETUSERID, --创建人
         SYSDATE, --时间
         0);
    
      IF VALIDATE_A = '四大管道码' THEN
        UPDATE SPM_CON_HT_TARGET T
           SET T.MATERIAL_CODE = NULL
         WHERE T.TARGET_ID = V_INFO_ID;
      
      END IF;
      /*         IF VALIDATE_A='流水码' THEN
         CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO(F_TABLEID,MSG_T);
      END IF;*/
    
      FETCH CU_DATA
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
             VALIDATE_P;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --标的物导入验证
  PROCEDURE HT_TARGET_VALIDATE1(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(N)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000); --物料名称
    VALIDATE_B       VARCHAR2(2000); --规格型号
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
    VALIDATE_E       VARCHAR2(2000); --物料编码
    VALIDATE_F       VARCHAR2(2000); --编号类别
    VALIDATE_G       VARCHAR2(2000);
    VALIDATE_H       VARCHAR2(2000); --单位
    VALIDATE_I       VARCHAR2(2000); --数量
    VALIDATE_J       VARCHAR2(2000); --单价
    VALIDATE_K       VARCHAR2(2000);
    VALIDATE_L       VARCHAR2(2000);
    VALIDATE_M       VARCHAR2(2000);
    VALIDATE_N       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    VALIDATE_NUMBER5 NUMBER;
    MSG_A            VARCHAR2(4000); ----物料名称
    MSG_B            VARCHAR2(4000); ----规格型号
    MSG_C            VARCHAR2(4000);
    MSG_D            VARCHAR2(4000);
    MSG_E            VARCHAR2(4000); ----物料编码
    MSG_F            VARCHAR2(4000); --编号类别
    MSG_G            VARCHAR2(4000);
    MSG_H            VARCHAR2(4000); --单位
    MSG_I            VARCHAR2(4000); --数量
    MSG_J            VARCHAR2(4000); --单价
    MSG_K            VARCHAR2(4000);
    MSG_L            VARCHAR2(4000);
    MSG_M            VARCHAR2(4000);
    MSG_N            VARCHAR2(4000);
    MSG_O            VARCHAR2(4000);
    MSG_P            VARCHAR2(4000);
    MSG_Q            VARCHAR2(4000);
    MSG_R            VARCHAR2(4000);
    MSG_S            VARCHAR2(4000);
    MSG_T            VARCHAR2(4000);
  
    V_COUNT NUMBER;
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
      INTO VALIDATE_A, --物料名称
           VALIDATE_B, --规格型号
           VALIDATE_C,
           VALIDATE_D,
           VALIDATE_E, --物料编码
           VALIDATE_F, --编号类别
           VALIDATE_G,
           VALIDATE_H, --单位
           VALIDATE_I, --数量
           VALIDATE_J, --单价
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           VALIDATE_N;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      /*      IF VALIDATE_A <> '*编号类别' OR VALIDATE_B <> '*物料编码
      (编号类别为中水码时，必填)' OR
               VALIDATE_C <> '*物料名称' OR VALIDATE_D <> '*规格型号' OR
               VALIDATE_E <> '*单位' OR VALIDATE_F <>'*数量' OR VALIDATE_G <>'*单价' THEN
             P_MSG := '导入数据的字段名不符合格式';
      
      
              CLOSE CU_DATA;
              RETURN;
            END IF;*/
      FETCH CU_DATA
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
             VALIDATE_N;
      WHILE CU_DATA%FOUND LOOP
        /*
        2018-11-01 欧榕
        增加EXCEL导入时，验证税收分类编码是否存在
        */
        IF VALIDATE_H IS NULL THEN
          /* 必录校验     
          IF MSG_H IS NULL THEN
            MSG_H1 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_H1 := MSG_H1 || ',' || CU_DATA%ROWCOUNT;
          END IF;*/
          NULL;
        ELSE
          SELECT COUNT(*)
            INTO V_COUNT
            FROM SPM_CON_TAX_CODE
           WHERE TAX_CODE = VALIDATE_H;
          IF V_COUNT <> 1 THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_A IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_F IS NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_G IS NULL THEN
          IF MSG_G IS NULL THEN
            MSG_G := CU_DATA%ROWCOUNT;
          ELSE
            MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_E IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER2
            FROM SPM_CON_HT_TARGET T
           WHERE T.MATERIAL_CODE = VALIDATE_B;
          IF VALIDATE_NUMBER2 > 0 THEN
            IF MSG_O IS NULL THEN
              MSG_O := CU_DATA%ROWCOUNT;
            ELSE
              MSG_O := MSG_O || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_L IS NOT NULL THEN
          IF VALIDATE_L <> '1' AND VALIDATE_L <> '2' THEN
            IF MSG_P IS NULL THEN
              MSG_P := CU_DATA%ROWCOUNT;
            ELSE
              MSG_P := MSG_P || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_A IS NOT NULL THEN
          IF VALIDATE_A <> '中水码' AND VALIDATE_A <> '四大管道码' AND
             VALIDATE_A <> '流水码' THEN
            MSG_Q := CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_A = '中水码' THEN
          IF VALIDATE_B IS NOT NULL THEN
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER4
              FROM MTL_SYSTEM_ITEMS_B B
             WHERE B.SEGMENT1 = VALIDATE_B;
            IF VALIDATE_NUMBER4 = 0 THEN
              MSG_R := CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        /*             --如果不是中水码 则调用物料传EBS的存储过程
        IF VALIDATE_A='流水码' THEN
            CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO(P_TABLEID,MSG_T);
         END IF;*/
        IF VALIDATE_E IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER5
            FROM MTL_UNITS_OF_MEASURE T
           WHERE T.UNIT_OF_MEASURE = VALIDATE_E;
          IF VALIDATE_NUMBER5 < 1 THEN
            IF MSG_T IS NULL THEN
              MSG_T := CU_DATA%ROWCOUNT;
            ELSE
              MSG_T := MSG_T || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        
        END IF;
      
        FETCH CU_DATA
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
               VALIDATE_N;
      END LOOP;
    
      CLOSE CU_DATA;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 税收分类编码不存在，请检查;  ';
      END IF;
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 编号类别为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 编号类别不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 所属类别不能为空;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 单位不能为空;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 数量不能为空;  ';
      END IF;
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 单价不能为空;  ';
      END IF;
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 编码类别为四大管道时，管号不能为空;  ';
      END IF;
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 编码类别为四大管道时，炉号不能为空;  ';
      END IF;
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 单价格式不正确，应为数字; ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 单价格式不正确，应为数字; ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 金额格式不正确，应为数字; ';
      END IF;
      IF MSG_O IS NOT NULL THEN
        MSG_O := MSG_O || '行 该条记录已经导入,不能重复导入; ';
      END IF;
    
      IF MSG_Q IS NOT NULL THEN
        MSG_Q := MSG_Q || '行 编码类别填写不正确，应填写中水码，四大管道编码或大流水码; ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 编码类别为四大管道编码时，物料编码不能为空; ';
      END IF;
      IF MSG_R IS NOT NULL THEN
        MSG_R := MSG_R || '行 您所填写的中水码不存在,请重新检查; ';
      END IF;
      IF MSG_T IS NOT NULL THEN
        MSG_T := MSG_T || '行 您所填写的单位在EBS不存在,请检查; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_O || MSG_P || MSG_Q || MSG_R || MSG_T;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  
  END;

  --序列
  PROCEDURE SEQ_RESET(V_SEQNAME VARCHAR2) AS
    N    NUMBER(10);
    TSQL VARCHAR2(100);
  BEGIN
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQNAME || '.NEXTVAL FROM DUAL'
      INTO N;
    N    := - (N - 1);
    TSQL := 'ALTER SEQUENCE ' || V_SEQNAME || ' INCREMENT BY ' || N;
    EXECUTE IMMEDIATE TSQL;
    EXECUTE IMMEDIATE 'SELECT ' || V_SEQNAME || '.NEXTVAL FROM DUAL'
      INTO N;
    TSQL := 'ALTER SEQUENCE ' || V_SEQNAME || ' INCREMENT BY 1';
    EXECUTE IMMEDIATE TSQL;
  END SEQ_RESET;

  --采购结果导入IMPORT
  PROCEDURE PURCHASE_RESULT_IMPORT(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   F_TABLENAME VARCHAR2,
                                   F_TABLEID   VARCHAR2,
                                   P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
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
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000); --合同签订情况
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
    VALIDATE_V VARCHAR2(2000);
    VALIDATE_W VARCHAR2(2000);
    VALIDATE_X VARCHAR2(2000);
    VALIDATE_Y VARCHAR2(2000);
    VALIDATE_Z VARCHAR2(2000);
  
    V_INFO_ID NUMBER;
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_PURCHASE_RESULT_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
    
      INSERT INTO SPM_CON_PURCHASE_RESULT
        (PURCHASE_RESULT_ID, --主键
         PURCHASE_RESULT_CODE, --编号
         CATEGORY, --类别
         PURCHASE_METHOD, --采购方式
         COMPANY_ID, --公司名称
         TARGET_NAME, --标的名称
         BIDDING_CANDIDATE, --中标候选人
         ESTIMATE, --概算
         PURCHASE_HT_AMOUNT, --采购合同金额(元)
         SALES_HT_AMOUNT, --销售合同金额
         PRICE_DIFFERENCE,
         AVERAGE_SAVING_RATE,
         METTING,
         AUDIT_OPINION,
         CONTRACT_SIGNING,
         CREATION_DATE,
         DEPT_ID,
         ORG_ID,
         CREATED_BY)
      VALUES
        (V_INFO_ID, --主键
         VALIDATE_A, --编号
         GET_DICTCODE_BY_NAME('SPM_CON_PURCHASE_RESULT_CATEGORY',
                              VALIDATE_B),
         GET_DICTCODE_BY_NAME('SPM_CON_PURCHASE_RESULT_TYPE', VALIDATE_C),
         (SELECT ORGANIZATION_ID
            FROM HR_OPERATING_UNITS
           WHERE NAME = VALIDATE_D),
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
         SYSDATE,
         SPM_EAM_COMMON_PKG.GET_DEPTID_BY_PERSONID(SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(SPM_SSO_PKG.GETUSERID)),
         SPM_SSO_PKG.GETORGID,
         SPM_SSO_PKG.GETUSERID);
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --采购结果验证
  PROCEDURE PURCHASE_RESULT_VALIDATE(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(N)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000); --合同签订情况
  
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    VALIDATE_NUMBER5 NUMBER;
    VALIDATE_NUMBER6 NUMBER;
    VALIDATE_NUMBER7 NUMBER;
    VALIDATE_NUMBER8 NUMBER;
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    MSG_L VARCHAR2(4000);
    MSG_M VARCHAR2(4000);
    MSG_N VARCHAR2(4000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
    
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
           VALIDATE_N; --合同签订情况
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '编号' OR VALIDATE_B <> '类别' OR VALIDATE_C <> '采购方式' OR
         VALIDATE_D <> '公司名称' OR VALIDATE_E <> '标的名称' OR
         VALIDATE_F <> '中标候选人' OR VALIDATE_G <> '概算
(万元)' OR VALIDATE_H <> '采购合同金额
（万元）' OR VALIDATE_I <> '销售合同金额
(万元)' OR VALIDATE_J <> '价差
（万元）' OR VALIDATE_K <> '平均节资率' OR VALIDATE_L <> '会议' OR
         VALIDATE_M <> '审核意见' OR VALIDATE_N <> '合同签订情况' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
    
      FETCH CU_DATA
      
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
             VALIDATE_N;
      WHILE CU_DATA%FOUND LOOP
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER
          FROM SPM_DICT T
         WHERE T.DICT_TYPE_ID =
               (SELECT F.DICT_TYPE_ID
                  FROM SPM_DICT_TYPE F
                 WHERE F.TYPE_CODE = 'SPM_CON_PURCHASE_RESULT_CATEGORY')
           AND T.DICT_NAME = VALIDATE_B;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER1
          FROM SPM_DICT T
         WHERE T.DICT_TYPE_ID =
               (SELECT F.DICT_TYPE_ID
                  FROM SPM_DICT_TYPE F
                 WHERE F.TYPE_CODE = 'SPM_CON_PURCHASE_RESULT_TYPE')
           AND T.DICT_NAME = VALIDATE_C;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER2
          FROM HR_OPERATING_UNITS T
         WHERE T.NAME = VALIDATE_D;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER7
          FROM SPM_CON_PURCHASE_RESULT T
         WHERE T.PURCHASE_RESULT_CODE = VALIDATE_A;
      
        --验证 A E F 不为空
        IF VALIDATE_A IS NULL OR VALIDATE_E IS NULL OR VALIDATE_F IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_B IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_B IS NOT NULL --验证类别是否存在
         THEN
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_C IS NULL THEN
              MSG_C := CU_DATA%ROWCOUNT;
            ELSE
              MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_A IS NOT NULL THEN
          --验证数据是否已经导入
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER8
            FROM SPM_CON_PURCHASE_RESULT M
           WHERE SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_PURCHASE_RESULT_CATEGORY',
                                                         M.CATEGORY) =
                 VALIDATE_B
             AND SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_PURCHASE_RESULT_TYPE',
                                                         M.PURCHASE_METHOD) =
                 VALIDATE_C
             AND M.TARGET_NAME = VALIDATE_E
             AND M.BIDDING_CANDIDATE = VALIDATE_F
             AND M.ESTIMATE = VALIDATE_G
             AND M.PURCHASE_HT_AMOUNT = VALIDATE_H
             AND M.SALES_HT_AMOUNT = VALIDATE_I
             AND M.AUDIT_OPINION = VALIDATE_M;
        
          IF VALIDATE_NUMBER8 > 0 THEN
            IF MSG_K IS NULL THEN
              MSG_K := CU_DATA%ROWCOUNT;
            ELSE
              MSG_K := MSG_K || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_C IS NOT NULL --验证采购方式是否存在
         THEN
          IF VALIDATE_NUMBER1 = 0 THEN
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA%ROWCOUNT;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_D IS NOT NULL --验证公司是否存在
         THEN
          IF VALIDATE_NUMBER2 = 0 THEN
            IF MSG_E IS NULL THEN
              MSG_E := CU_DATA%ROWCOUNT;
            ELSE
              MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_A IS NOT NULL --验证编号是否存在
         THEN
          IF VALIDATE_NUMBER7 > 0 THEN
            IF MSG_F IS NULL THEN
              MSG_F := CU_DATA%ROWCOUNT;
            ELSE
              MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_H IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_H)
            INTO VALIDATE_NUMBER3
            FROM DUAL;
          IF VALIDATE_NUMBER3 = 0 THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_I IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_I)
            INTO VALIDATE_NUMBER4
            FROM DUAL;
          IF VALIDATE_NUMBER4 = 0 THEN
            IF MSG_I IS NULL THEN
              MSG_I := CU_DATA%ROWCOUNT;
            ELSE
              MSG_I := MSG_I || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_J IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_J)
            INTO VALIDATE_NUMBER5
            FROM DUAL;
          IF VALIDATE_NUMBER5 = 0 THEN
            IF MSG_J IS NULL THEN
              MSG_J := CU_DATA%ROWCOUNT;
            ELSE
              MSG_J := MSG_J || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        /*
        IF VALIDATE_K IS NOT NULL THEN
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_K) INTO VALIDATE_NUMBER4 FROM DUAL;
        IF VALIDATE_NUMBER6=0 THEN
          IF MSG_K IS NULL THEN
            MSG_K :=CU_DATA%ROWCOUNT;
          ELSE
            MSG_K := MSG_K || ',' || CU_DATA%ROWCOUNT;
            END IF;
            END IF;
            END IF; */
      
        FETCH CU_DATA
          INTO VALIDATE_A,
               VALIDATE_B,
               VALIDATE_C,
               VALIDATE_D,
               VALIDATE_E,
               VALIDATE_F,
               VALIDATE_G,
               VALIDATE_H, --概算
               VALIDATE_I, --销售合同
               VALIDATE_J, --价差(万元)
               VALIDATE_K, --平均节资率
               VALIDATE_L, --会议
               VALIDATE_M, --审核意见
               VALIDATE_N; --合同签订情况
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 编号/采购方式/公司名称不完整;  ';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 采购方式不存在';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 类别不存在';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 采购方式不存在';
      END IF;
    
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 公司不存在';
      END IF;
    
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 编号已存在';
      END IF;
    
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 概算金额所填内容格式不正确;';
      END IF;
    
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 采购合同金额所填内容格式不正确;';
      END IF;
    
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_J || '行 销售合同金额所填内容格式不正确;';
      END IF;
    
      IF MSG_K IS NOT NULL THEN
        MSG_K := MSG_K || '行 该条记录已经存在，不能再次导入;  ';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_F || MSG_H ||
               MSG_I || MSG_J || MSG_K;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;

  --资产减值导入IMPORT
  PROCEDURE ASSETS_IMPAIRMENT_IMPORT(P_TABLENAME VARCHAR2,
                                     P_TABLEID   VARCHAR2,
                                     P_BATCHCODE VARCHAR2,
                                     F_TABLENAME VARCHAR2,
                                     F_TABLEID   VARCHAR2,
                                     P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G), --数量
             TRIM(H),
             TRIM(I),
             TRIM(J), --数量
             TRIM(K), --估价单价
             TRIM(L), --估价金额
             TRIM(M), --增减值
             TRIM(N), --增值率
             TRIM(O), --日期
             TRIM(P),
             TRIM(Q),
             TRIM(R),
             TRIM(S),
             TRIM(T),
             TRIM(U),
             TRIM(V),
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A     VARCHAR2(2000);
    VALIDATE_B     VARCHAR2(2000);
    VALIDATE_C     VARCHAR2(2000);
    VALIDATE_D     VARCHAR2(2000);
    VALIDATE_E     VARCHAR2(2000);
    VALIDATE_F     VARCHAR2(2000);
    VALIDATE_G     VARCHAR2(2000);
    VALIDATE_H     VARCHAR2(2000);
    VALIDATE_I     VARCHAR2(2000);
    VALIDATE_J     VARCHAR2(2000);
    VALIDATE_K     VARCHAR2(2000);
    VALIDATE_L     VARCHAR2(2000);
    VALIDATE_M     VARCHAR2(2000);
    VALIDATE_N     VARCHAR2(2000);
    VALIDATE_O     VARCHAR2(2000); --日期
    VALIDATE_P     VARCHAR2(2000);
    VALIDATE_Q     VARCHAR2(2000);
    VALIDATE_R     VARCHAR2(2000);
    VALIDATE_S     VARCHAR2(2000);
    VALIDATE_T     VARCHAR2(2000);
    VALIDATE_U     VARCHAR2(2000);
    VALIDATE_V     VARCHAR2(2000);
    VALIDATE_W     VARCHAR2(2000);
    VALIDATE_X     VARCHAR2(2000);
    VALIDATE_Y     VARCHAR2(2000);
    VALIDATE_Z     VARCHAR2(2000);
    VALIDATE_EXIST NUMBER;
    VALIDATE_ID    NUMBER;
  
    V_INFO_ID NUMBER;
    K_ORG_ID NUMBER;
    k_INVENTORY_ITEM_ID number;
    K_LOCATOR_ID NUMBER;
    K_ATTRIBUTE1 VARCHAR2(200);
    K_ATTRIBUTE2 VARCHAR2(200);
  
  BEGIN
    select SPM_SSO_PKG.GETORGID INTO K_ORG_ID FROM DUAL;
    OPEN CU_DATA;
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z;
  
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_ASSETS_IMPAIRMENT_SEQ.NEXTVAL
        INTO V_INFO_ID
        FROM DUAL;
        
      select T.INVENTORY_ITEM_ID, T.LOCATOR_ID, T.子库存代码, T.货位
        INTO K_INVENTORY_ITEM_ID, K_LOCATOR_ID, K_ATTRIBUTE1, K_ATTRIBUTE2
        from CUX_ITEM_XYL_QUERY_VK T
       WHERE T.物料代码 = VALIDATE_B
         AND T.物料名称 = VALIDATE_C
         AND T.子库存名称 = VALIDATE_D
         AND T.货位 = VALIDATE_E
         AND T.组织ID = K_ORG_ID;
    
      
    
      --如果存在已经导入历史的,将历史的版本号减一,保证最新的版本号永远是1
      UPDATE SPM_CON_ASSETS_IMPAIRMENT T
         SET T.VERSION_NUMBER = T.VERSION_NUMBER - 1
       WHERE T.INVENTORY_ITEM_ID = K_INVENTORY_ITEM_ID;
    
     
      INSERT INTO SPM_CON_ASSETS_IMPAIRMENT
        (ASSETS_IMPAIRMENT_ID, --主键
         INVENTORY_ITEM_ID,
         ASSETS_AMOUNT, --数量
         ESTIMATE_UNIT_PRICE, --估价单价
         ESTIMATE_AMOUNT, --估价金额
         DIFFERENCE_VALUE, --增减值
         DIFFERENCE_RATE, --增值率
         CREATION_DATE,
         DEPT_ID,
         ORG_ID,
         CREATED_BY,
         LOCATOR_ID,
         SUBINVENTORY_ID,
         ATTRIBUTE1,
         ATTRIBUTE2,
         ATTRIBUTE3,
         ASSETS_DATE,
         VERSION_NUMBER)
      VALUES
        (V_INFO_ID, --主键
         K_INVENTORY_ITEM_ID,
         VALIDATE_J, --数量
         VALIDATE_K, --估价单价
         VALIDATE_J * VALIDATE_K, --估价金额
         VALIDATE_J * VALIDATE_K - VALIDATE_I, --增减值
         (VALIDATE_J * VALIDATE_K - VALIDATE_I) / VALIDATE_I * 100, --增值率
         SYSDATE,
         SPM_EAM_COMMON_PKG.GET_DEPTID_BY_PERSONID(SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(SPM_SSO_PKG.GETUSERID)),
         SPM_SSO_PKG.GETORGID,
         SPM_SSO_PKG.GETUSERID,
         V_INFO_ID,
         k_LOCATOR_ID,
         K_ATTRIBUTE1,
         K_ATTRIBUTE2,
         (SELECT SYS_GUID() FROM DUAL),
         (NVL(TO_DATE(SUBSTR(VALIDATE_O, 1, 10), 'YYYY-MM-DD'), SYSDATE)), --时间
         1);
     
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --资产减值验证
  PROCEDURE ASSETS_IMPAIRMENT_VALIDATE(P_TABLENAME VARCHAR2,
                                       P_TABLEID   VARCHAR2,
                                       P_BATCHCODE VARCHAR2,
                                       P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(O)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000); --增值率
    VALIDATE_O VARCHAR2(2000); --日期
  
    VALIDATE_NUMBER            NUMBER;
    VALIDATE_NUMBER1           NUMBER;
    VALIDATE_NUMBER2           NUMBER;
    VALIDATE_NUMBER3           NUMBER;
    VALIDATE_NUMBER4           NUMBER;
    VALIDATE_NUMBER5           NUMBER;
    VALIDATE_NUMBER6           NUMBER;
    VALIDATE_NUMBER7           NUMBER;
    VALIDATE_NUMBER8           NUMBER;
    VALIDATE_NUMBER9           NUMBER;
    VALIDATE_NUMBER10          NUMBER;
    VALIDATE_INVENTORY_ITEM_ID NUMBER;
  
    VALIDATE_CATE1 VARCHAR2(4000);
    VALIDATE_CATE2 VARCHAR2(4000);
    VALIDATE_CATE3 VARCHAR2(4000);
  
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
    MSG_D VARCHAR2(4000);
    MSG_E VARCHAR2(4000);
    MSG_F VARCHAR2(4000);
    MSG_G VARCHAR2(4000);
    MSG_H VARCHAR2(4000);
    MSG_I VARCHAR2(4000);
    MSG_J VARCHAR2(4000);
    MSG_K VARCHAR2(4000);
    MSG_L VARCHAR2(4000);
    MSG_M VARCHAR2(4000);
    MSG_N VARCHAR2(4000);
    MSG_O VARCHAR2(4000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
    V_1                 NUMBER;
    V_2                 NUMBER;
    K_ORG_ID            NUMBER;
  
  BEGIN
    select  SPM_SSO_PKG.GETORGID INTO K_ORG_ID FROM DUAL;
    OPEN CU_DATA;
    FETCH CU_DATA
    
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
           VALIDATE_O;
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '序号' OR VALIDATE_B <> '物料编码' OR VALIDATE_C <> '物料名称' OR
         VALIDATE_D <> '仓库' OR VALIDATE_E <> '货位' OR VALIDATE_F <> '单位' OR
         VALIDATE_G <> '数量' OR VALIDATE_H <> '账面单价' OR VALIDATE_I <> '账面金额' OR
         VALIDATE_J <> '数量' OR VALIDATE_K <> '估价单价' OR VALIDATE_L <> '估价金额' OR
         VALIDATE_M <> '增减值' OR VALIDATE_N <> '增减率' OR VALIDATE_O <> '日期' THEN
        P_MSG := '导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
    
      FETCH CU_DATA
      
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
             VALIDATE_O;
    
      WHILE CU_DATA%FOUND LOOP
      
        --验证 A E F 不为空
        IF VALIDATE_K IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        /*          IF VALIDATE_B IS NOT NULL THEN
             SELECT COUNT(T.INVENTORY_ITEM_ID)
                    INTO VALIDATE_INVENTORY_ITEM_ID
            FROM SPM_CON_ASSETS_IMPAIRMENT T
           WHERE T.INVENTORY_ITEM_ID=
           (SELECT F.INVENTORY_ITEM_ID FROM CUX_ITEM_XYL_QUERY_V F
           WHERE F.物料代码=VALIDATE_B AND F.物料名称=VALIDATE_C AND F.子库存名称=VALIDATE_D
           AND F.货位=VALIDATE_E AND F.组织ID=SPM_SSO_PKG.GETORGID );
        
        
        END IF;*/
      
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_J)
          INTO VALIDATE_NUMBER8
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_K)
          INTO VALIDATE_NUMBER9
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_O)
          INTO VALIDATE_NUMBER10
          FROM DUAL;
      
        IF VALIDATE_B IS NOT NULL THEN
          SELECT COUNT(*)
            INTO V_1
            FROM CUX_ITEM_XYL_QUERY_VK F
           WHERE F.物料代码 = VALIDATE_B
             AND F.物料名称 = VALIDATE_C
             AND F.子库存名称 = VALIDATE_D
             AND F.货位 = VALIDATE_E
             AND F.组织ID = K_ORG_ID;
          IF V_1 < 1 THEN
            IF MSG_B IS NULL THEN
              MSG_B := CU_DATA%ROWCOUNT;
            ELSE
              MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        
        END IF;
      
        --验证数量
        IF VALIDATE_J IS NOT NULL THEN
          IF VALIDATE_NUMBER8 <> 1 THEN
            IF MSG_C IS NULL THEN
              MSG_C := CU_DATA%ROWCOUNT;
            ELSE
              MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证估价单价为数字
        IF VALIDATE_K IS NOT NULL THEN
          IF VALIDATE_NUMBER9 <> 1 THEN
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA%ROWCOUNT;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证日期格式
        IF VALIDATE_O IS NOT NULL THEN
          IF VALIDATE_NUMBER10 <> 1 THEN
            IF MSG_E IS NULL THEN
              MSG_E := CU_DATA%ROWCOUNT;
            ELSE
              MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_O IS NOT NULL THEN
          IF TO_DATE(SUBSTR(VALIDATE_O, 1, 10), 'yyyy-MM-dd') <
             TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD') THEN
            IF MSG_F IS NULL THEN
              MSG_F := CU_DATA%ROWCOUNT;
            ELSE
              MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA
          INTO VALIDATE_A,
               VALIDATE_B,
               VALIDATE_C,
               VALIDATE_D,
               VALIDATE_E,
               VALIDATE_F,
               VALIDATE_G,
               VALIDATE_H, --概算
               VALIDATE_I, --销售合同
               VALIDATE_J, --价差(万元)
               VALIDATE_K, --平均节资率
               VALIDATE_L, --会议
               VALIDATE_M, --审核意见
               VALIDATE_N, --合同签订情况
               VALIDATE_O; --合同签订情况
      
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 ;  ';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 此条物料数据在本组织下不存在,请检查';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 此条物料数量格式非法,请检查';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 此条物料数据估价单价格式非法,请检查';
      END IF;
    
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 此条物料数据日期需填写文本格式的日期,请检查';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 此条物料数据所填的日期不能晚于今天,请检查';
      END IF;
    
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 数据已导入,请勿重复导入;';
      END IF;
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_F || MSG_H ||
               MSG_I || MSG_J || MSG_M;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;

  --合同台账导入IMPORT
  PROCEDURE HT_IMPORT(P_TABLENAME VARCHAR2,
                      P_TABLEID   VARCHAR2,
                      P_BATCHCODE VARCHAR2,
                      F_TABLENAME VARCHAR2,
                      F_TABLEID   VARCHAR2,
                      P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G), --数量
             TRIM(H),
             TRIM(I),
             TRIM(J), --数量
             TRIM(K), --估价单价
             TRIM(L), --估价金额
             TRIM(M), --增减值
             TRIM(N), --增值率
             TRIM(O), --日期
             TRIM(P),
             TRIM(Q),
             TRIM(R),
             TRIM(S),
             TRIM(T),
             TRIM(U),
             TRIM(V),
             TRIM(W),
             TRIM(X),
             TRIM(Y),
             TRIM(Z)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '合同主信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --1.工程信息
    CURSOR CU_DATA1 IS
      SELECT TRIM(A), TRIM(B)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '工程信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --2.标的物信息
    CURSOR CU_DATA2 IS
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
             TRIM(K)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '标的物信息'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --3.收付款条款
    CURSOR CU_DATA3 IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H),
             TRIM(I),
             TRIM(J)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '收付款条款'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --4.交货计划
    CURSOR CU_DATA4 IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E), TRIM(F), TRIM(G)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '交货计划'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --5.客户或供应商
    CURSOR CU_DATA5 IS
      SELECT TRIM(A), TRIM(B)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '客户或供应商'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --6.附件信息
    CURSOR CU_DATA6 IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H),
             TRIM(I),
             TRIM(G),
             TRIM(K),
             TRIM(L),
             TRIM(M),
             TRIM(N)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '附件'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --7.关联关系
    CURSOR CU_DATA7 IS
      SELECT TRIM(A), TRIM(B)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '关联关系'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    CURSOR CUR(V_NAME VARCHAR2, V_AAA NUMBER) IS
      SELECT *
        FROM SPM_CON_CONTRACT_BASIS T
       WHERE T.CATEGORY_ID =
             (SELECT FF.CATEGORY_ID
                FROM SPM_CON_CONTRACT_CATEGORY FF
               WHERE FF.CATEGORY_NAME = V_NAME
                 AND FF.IS_END = '1'
                 AND FF.IN_OUT_TYPE =
                     (SELECT BB.IN_OUT_TYPE
                        FROM SPM_CON_HT_INFO BB
                       WHERE BB.CONTRACT_ID = V_AAA));
  
    VALIDATE_A             VARCHAR2(2000);
    VALIDATE_B             VARCHAR2(2000);
    VALIDATE_C             VARCHAR2(2000);
    VALIDATE_D             VARCHAR2(2000);
    VALIDATE_E             VARCHAR2(2000);
    VALIDATE_F             VARCHAR2(2000);
    VALIDATE_G             VARCHAR2(2000);
    VALIDATE_H             VARCHAR2(2000);
    VALIDATE_I             VARCHAR2(2000);
    VALIDATE_J             VARCHAR2(2000);
    VALIDATE_K             VARCHAR2(2000);
    VALIDATE_L             VARCHAR2(2000);
    VALIDATE_M             VARCHAR2(2000);
    VALIDATE_N             VARCHAR2(2000);
    VALIDATE_O             VARCHAR2(2000); --日期
    VALIDATE_P             VARCHAR2(2000);
    VALIDATE_Q             VARCHAR2(2000);
    VALIDATE_R             VARCHAR2(2000);
    VALIDATE_S             VARCHAR2(2000);
    VALIDATE_T             VARCHAR2(2000);
    VALIDATE_U             VARCHAR2(2000);
    VALIDATE_V             VARCHAR2(2000);
    VALIDATE_W             VARCHAR2(2000);
    VALIDATE_X             VARCHAR2(2000);
    VALIDATE_Y             VARCHAR2(2000);
    VALIDATE_Z             VARCHAR2(2000);
    VALIDATE_EXIST         NUMBER;
    VALIDATE_ID            NUMBER;
    VALIDATE_ID2           NUMBER;
    VALIDATE_PERSON_ID     NUMBER;
    VALIDATE_CLASS_ID      NUMBER;
    VALIDATE_USER_ID       NUMBER;
    VALIDATE_TARGET_ID     NUMBER;
    VALIDATE_JH_ID         NUMBER;
    VALIDATE_SF_ID         NUMBER;
    VALIDATE_KHGYS_ID      NUMBER;
    VALIDATE_IOT           NUMBER;
    VALIDATE_CONTRACT_CODE NUMBER;
  
    VALIDATE_CUSTINFO VARCHAR2(2000);
  
    VALIDATE_NUMBER1  NUMBER;
    VALIDATE_NUMBER2  NUMBER;
    VALIDATE_NUMBER3  NUMBER;
    VALIDATE_NUMBER4  NUMBER;
    VALIDATE_NUMBER5  NUMBER;
    VALIDATE_NUMBER6  NUMBER;
    VALIDATE_NUMBER7  NUMBER;
    VALIDATE_NUMBER8  NUMBER;
    VALIDATE_NUMBER9  NUMBER;
    VALIDATE_NUMBER10 NUMBER;
    VALIDATE_NUMBER20 NUMBER;
  
    VALIDATE_NUMBER30 NUMBER;
    VALIDATE_NUMBER31 NUMBER;
    VALIDATE_NUMBER32 NUMBER;
    VALIDATE_NUMBER33 NUMBER;
    VALIDATE_NUMBER34 NUMBER;
    VALIDATE_NUMBER35 NUMBER;
    VALIDATE_NUMBER36 NUMBER;
    VALIDATE_NUMBER37 NUMBER;
    VALIDATE_NUMBER38 NUMBER;
    VALIDATE_NUMBER39 NUMBER;
    VALIDATE_NUMBER40 NUMBER;
  
    VALIDATE_NUM1 NUMBER;
    VALIDATE_NUM2 NUMBER;
    VALIDATE_NUM3 NUMBER;
    VALIDATE_NUM4 NUMBER;
    VALIDATE_NUM5 NUMBER;
    VALIDATE_NUM6 NUMBER;
    VALIDATE_NUM7 NUMBER;
    VALIDATE_NUM8 NUMBER;
    VALIDATE_NUM9 NUMBER;
  
    VALIDATE_1     VARCHAR2(2000);
    VALIDATE_2     VARCHAR2(2000);
    VALIDATE_3     VARCHAR2(2000);
    VALIDATE_4     VARCHAR2(2000);
    VALIDATE_INOUT VARCHAR2(2000);
  
    VALIDATE_5 VARCHAR2(2000);
    VALIDATE_6 VARCHAR2(2000);
    --用于合同类型四段
    VALIDATE_7  VARCHAR2(2000);
    VALIDATE_8  VARCHAR2(2000);
    VALIDATE_9  VARCHAR2(2000);
    VALIDATE_10 VARCHAR2(2000);
  
    --1.工程信息
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
  
    --2.标的物信息-
    VALIDATE_A2 VARCHAR2(2000);
    VALIDATE_B2 VARCHAR2(2000);
    VALIDATE_C2 VARCHAR2(2000);
    VALIDATE_D2 VARCHAR2(2000);
    VALIDATE_E2 VARCHAR2(2000);
    VALIDATE_F2 VARCHAR2(2000);
    VALIDATE_G2 VARCHAR2(2000);
    VALIDATE_H2 VARCHAR2(2000);
    VALIDATE_I2 VARCHAR2(2000);
    VALIDATE_J2 VARCHAR2(2000);
    VALIDATE_K2 VARCHAR2(2000);
  
    --3.收付款条款
    VALIDATE_A3 VARCHAR2(2000);
    VALIDATE_B3 VARCHAR2(2000);
    VALIDATE_C3 VARCHAR2(2000);
    VALIDATE_D3 VARCHAR2(2000);
    VALIDATE_E3 VARCHAR2(2000);
    VALIDATE_F3 VARCHAR2(2000);
    VALIDATE_G3 VARCHAR2(2000);
    VALIDATE_H3 VARCHAR2(2000);
    VALIDATE_I3 VARCHAR2(2000);
    VALIDATE_J3 VARCHAR2(2000);
  
    --4.交货计划
    VALIDATE_A4 VARCHAR2(2000);
    VALIDATE_B4 VARCHAR2(2000);
    VALIDATE_C4 VARCHAR2(2000);
    VALIDATE_D4 VARCHAR2(2000);
    VALIDATE_E4 VARCHAR2(2000);
    VALIDATE_F4 VARCHAR2(2000);
    VALIDATE_G4 VARCHAR2(2000);
  
    --5.客户或供应商
    VALIDATE_A5 VARCHAR2(2000);
    VALIDATE_B5 VARCHAR2(2000);
    VALIDATE_C5 VARCHAR2(2000);
  
    --6.附件信息
    VALIDATE_A6 VARCHAR2(2000);
    VALIDATE_B6 VARCHAR2(2000);
    VALIDATE_C6 VARCHAR2(2000);
    VALIDATE_D6 VARCHAR2(2000);
    VALIDATE_E6 VARCHAR2(2000);
    VALIDATE_F6 VARCHAR2(2000);
    VALIDATE_G6 VARCHAR2(2000);
    VALIDATE_H6 VARCHAR2(2000);
    VALIDATE_I6 VARCHAR2(2000);
    VALIDATE_J6 VARCHAR2(2000);
    VALIDATE_K6 VARCHAR2(2000);
    VALIDATE_L6 VARCHAR2(2000);
    VALIDATE_M6 VARCHAR2(2000);
    VALIDATE_N6 VARCHAR2(2000);
  
    --7.关联关系
    VALIDATE_A7 VARCHAR2(2000);
    VALIDATE_B7 VARCHAR2(2000);
  
    V_INFO_ID        NUMBER;
    VALIDATE_FUJIAN  NUMBER;
    VALIDATE_FUJIAN2 NUMBER;
    VALIDATE_TARGET1 NUMBER;
    CONTRACT_CODE_4  VARCHAR2(2000);
    HAS_CONTRACT     NUMBER;
    MATRIAL_CODE_V   VARCHAR2(2000);
    SEQ_CODE         VARCHAR2(2000);
  
  BEGIN
    OPEN CU_DATA;
    OPEN CU_DATA1;
    OPEN CU_DATA2;
    OPEN CU_DATA3;
    OPEN CU_DATA4;
    OPEN CU_DATA5;
    OPEN CU_DATA6;
    OPEN CU_DATA7;
  
    FETCH CU_DATA
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
           VALIDATE_V,
           VALIDATE_W,
           VALIDATE_X,
           VALIDATE_Y,
           VALIDATE_Z;
  
    --工程信息
    FETCH CU_DATA1
      INTO VALIDATE_A1, VALIDATE_B1;
  
    --标的物信息
    FETCH CU_DATA2
      INTO VALIDATE_A2,
           VALIDATE_B2,
           VALIDATE_C2,
           VALIDATE_D2,
           VALIDATE_E2,
           VALIDATE_F2,
           VALIDATE_G2,
           VALIDATE_H2,
           VALIDATE_I2,
           VALIDATE_J2,
           VALIDATE_K2;
  
    --收付款条款信息
    FETCH CU_DATA3
      INTO VALIDATE_A3,
           VALIDATE_B3,
           VALIDATE_C3,
           VALIDATE_D3,
           VALIDATE_E3,
           VALIDATE_F3,
           VALIDATE_G3,
           VALIDATE_H3,
           VALIDATE_I3,
           VALIDATE_J3;
  
    --4.交货计划信息
    FETCH CU_DATA4
      INTO VALIDATE_A4,
           VALIDATE_B4,
           VALIDATE_C4,
           VALIDATE_D4,
           VALIDATE_E4,
           VALIDATE_F4,
           VALIDATE_G4;
  
    --5.客户或供应商
    FETCH CU_DATA5
      INTO VALIDATE_A5, VALIDATE_B5;
  
    --6.附件信息
    FETCH CU_DATA6
      INTO VALIDATE_A6,
           VALIDATE_B6,
           VALIDATE_C6,
           VALIDATE_D6,
           VALIDATE_E6,
           VALIDATE_F6,
           VALIDATE_G6,
           VALIDATE_H6,
           VALIDATE_I6,
           VALIDATE_J6,
           VALIDATE_K6,
           VALIDATE_L6,
           VALIDATE_M6,
           VALIDATE_N6;
  
    --7.关联关系
    FETCH CU_DATA7
      INTO VALIDATE_A7, VALIDATE_B7;
  
    VALIDATE_INOUT := VALIDATE_A;
    SELECT LENGTHB(VALIDATE_D) - LENGTHB(REPLACE(VALIDATE_D, '>', ''))
      INTO VALIDATE_NUMBER20
      FROM DUAL;
    SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_C, '>', 1)
      INTO VALIDATE_6
      FROM DUAL;
  
    WHILE CU_DATA%FOUND LOOP
      SELECT COUNT(*)
        INTO VALIDATE_CONTRACT_CODE
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_B;
      --如果合同已导入并且不是启动流程的,将子表全部删除
      IF VALIDATE_CONTRACT_CODE > 0 THEN
        SELECT T.CONTRACT_ID
          INTO VALIDATE_NUMBER30
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_B;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER31
          FROM SPM_CON_HT_PROJECT T
         WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER32
          FROM SPM_CON_HT_TARGET T
         WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER33
          FROM SPM_CON_HT_CLAUSE T
         WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER34
          FROM SPM_CON_HT_GOODS_PLAN T
         WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER35
          FROM SPM_CON_HT_MERCHANTS T
         WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
      
        IF VALIDATE_NUMBER31 > 0 THEN
          DELETE FROM SPM_CON_HT_PROJECT T
           WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
          COMMIT;
        END IF;
      
        IF VALIDATE_NUMBER32 > 0 THEN
          DELETE FROM SPM_CON_HT_TARGET T
           WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
          COMMIT;
        END IF;
      
        IF VALIDATE_NUMBER33 > 0 THEN
          DELETE FROM SPM_CON_HT_CLAUSE T
           WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
          COMMIT;
        END IF;
      
        IF VALIDATE_NUMBER34 > 0 THEN
          DELETE FROM SPM_CON_HT_GOODS_PLAN T
           WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
          COMMIT;
        END IF;
      
        IF VALIDATE_NUMBER35 > 0 THEN
          DELETE FROM SPM_CON_HT_MERCHANTS T
           WHERE T.CONTRACT_ID = VALIDATE_NUMBER30;
          COMMIT;
        END IF;
      
      END IF;
    
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
    
      IF VALIDATE_CONTRACT_CODE = 0 THEN
        INSERT INTO SPM_CON_HT_INFO
          (CONTRACT_ID, --主键
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编码
           BUSINESS_TYPE, --业务类型
           CONTRACT_CATEGORY, --合同类型
           MAIN_TARGET, --主要标的物
           IN_OUT_TYPE, --收支类型
           IS_PRODUCT_CATALOG, --目录范围内产品
           SUBJECT_DEPT_ID, --执行主体
           CONTRACT_FORM, --合同形式
           CONTRACT_AMOUNT, --合同金额
           CURRENCY_TYPE, --币种
           EXCHANGE_RATE, --汇率
           RMB_TOTAL,
           MORE_LESS_RATIO, --溢短装比例
           IS_ADVANCE, --是否垫资
           CONTRACT_CODE_OPPSITE, --对方合同编号
           PM_PERSON_ID, --项目经理
           CONTRACT_REMARK,
           START_DATE, --履行期限
           END_DATE, --到
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY, --USER_ID
           STATUS_CHANGE,
           CONTRACT_TYPE,
           IS_URGENT,
           STATUS,
           CONTRACT_VERSION, --合同版本
           STATUS_ARCHIVED,
           CONTRACT_FLAG,
           ATTRIBUTE3,
           LAST_UPDATE_DATE)
        VALUES
          (V_INFO_ID, --主键
           VALIDATE_A,
           VALIDATE_B,
           (SELECT T.BIS_TYPE_ID
              FROM SPM_CON_HT_BIS_TYPE T
             WHERE T.TYPE_NAME = VALIDATE_C),
           1,
           (SELECT T.MTARGET_ID
              FROM SPM_CON_HT_M_TARGET T
             WHERE T.MTARGET_NAME = VALIDATE_F),
           GET_DICTCODE_BY_NAME('SPM_CON_HT_INOUT_TYPE', VALIDATE_E),
           (CASE WHEN VALIDATE_G = '是' THEN '1' ELSE '0' END),
           (SELECT T.ORGANIZATION_ID
              FROM HR_OPERATING_UNITS T
             WHERE T.NAME = VALIDATE_H),
           GET_DICTCODE_BY_NAME('SPM_CON_HT_FORM', VALIDATE_I), --合同形式
           VALIDATE_J,
           (SELECT T.CURRENCY_CODE
              FROM FND_CURRENCIES_VL T
             WHERE T.ENABLED_FLAG = 'Y'
               AND T.NAME = VALIDATE_K),
           VALIDATE_L,
           VALIDATE_J * VALIDATE_L,
           VALIDATE_M,
           GET_DICTCODE_BY_NAME('SPM_CON_HT_IS_ADVANCE', VALIDATE_N), --合同形式
           VALIDATE_O,
           (SELECT T.USER_ID
              FROM SPM_CON_HT_PEOPLE_V T
             WHERE T.FULL_NAME = VALIDATE_P
               AND SPM_SSO_PKG.GETORGID = T.BELONGORGID), --项目经理
           VALIDATE_U,
           TO_DATE(SUBSTR(VALIDATE_S, 1, 10), 'YYYY-MM-DD'),
           TO_DATE(SUBSTR(VALIDATE_T, 1, 10), 'YYYY-MM-DD'),
           TO_DATE(SUBSTR(VALIDATE_R, 1, 10), 'YYYY-MM-DD'),
           (SELECT T.ORGANIZATION_ID
              FROM SPM_CON_HT_PEOPLE_V T
             WHERE T.FULL_NAME = VALIDATE_Q
               AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
           SPM_SSO_PKG.GETORGID,
           (SELECT T.USER_ID
              FROM SPM_CON_HT_PEOPLE_V T
             WHERE T.FULL_NAME = VALIDATE_Q
               AND SPM_SSO_PKG.GETORGID = T.BELONGORGID),
           '1',
           '1',
           '0',
           'A',
           '1',
           'J',
           (SELECT SYS_GUID() FROM DUAL),
           '1',
           SYSDATE);
      
        BEGIN
          FOR C IN CUR(VALIDATE_10, V_INFO_ID) LOOP
            INSERT INTO SPM_CON_HT_FILE T
              (T.FILE_ID,
               T.CONTRACT_ID,
               T.CATEGORY_ID,
               BASIS_TYPE,
               ATTRIBUTE1)
            VALUES
              (SPM_CON_HT_FILE_SEQ.NEXTVAL,
               V_INFO_ID,
               (SELECT AA.CATEGORY_ID
                  FROM SPM_CON_CONTRACT_CATEGORY AA
                 WHERE AA.CATEGORY_NAME = VALIDATE_10
                   AND AA.IS_END = '1'
                   AND AA.IN_OUT_TYPE =
                       (SELECT FF.IN_OUT_TYPE
                          FROM SPM_CON_HT_INFO FF
                         WHERE FF.CONTRACT_ID = V_INFO_ID)),
               C.BASIS_TYPE,
               '1');
            COMMIT;
          END LOOP;
        END;
      
        IF VALIDATE_NUMBER20 = 3 AND VALIDATE_CONTRACT_CODE = 0 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 2)
            INTO VALIDATE_9
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 3)
            INTO VALIDATE_10
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_10
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_9
                             AND T.PARENT_ID =
                                 (SELECT T.CATEGORY_ID
                                    FROM SPM_CON_CONTRACT_CATEGORY T
                                   WHERE T.CATEGORY_NAME = VALIDATE_8
                                     AND T.PARENT_ID =
                                         (SELECT T.CATEGORY_ID
                                            FROM SPM_CON_CONTRACT_CATEGORY T
                                           WHERE T.CATEGORY_NAME = VALIDATE_7))))
           WHERE F.CONTRACT_ID = V_INFO_ID;
        
        END IF;
      
        IF VALIDATE_NUMBER20 = 2 AND VALIDATE_CONTRACT_CODE = 0 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 2)
            INTO VALIDATE_9
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_9
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_8
                             AND T.PARENT_ID =
                                 (SELECT T.CATEGORY_ID
                                    FROM SPM_CON_CONTRACT_CATEGORY T
                                   WHERE T.CATEGORY_NAME = VALIDATE_7)))
           WHERE F.CONTRACT_ID = V_INFO_ID;
        
        END IF;
      
        IF VALIDATE_NUMBER20 = 1 AND VALIDATE_CONTRACT_CODE = 0 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_8
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_7))
           WHERE F.CONTRACT_ID = V_INFO_ID;
        
        END IF;
      END IF;
    
      IF VALIDATE_CONTRACT_CODE > 0 THEN
        UPDATE SPM_CON_HT_INFO
           SET CONTRACT_NAME         = VALIDATE_A,
               BUSINESS_TYPE        =
               (SELECT T.BIS_TYPE_ID
                  FROM SPM_CON_HT_BIS_TYPE T
                 WHERE T.TYPE_NAME = VALIDATE_C), --业务类型
               CONTRACT_CATEGORY     = 1,
               MAIN_TARGET          =
               (SELECT T.MTARGET_ID
                  FROM SPM_CON_HT_M_TARGET T
                 WHERE T.MTARGET_NAME = VALIDATE_F), --主要标的物
               IN_OUT_TYPE           = GET_DICTCODE_BY_NAME('SPM_CON_HT_INOUT_TYPE',
                                                            VALIDATE_E), --收支类型
               IS_PRODUCT_CATALOG = (CASE
                                      WHEN VALIDATE_G = '是' THEN
                                       '1'
                                      ELSE
                                       '0'
                                    END), --目录范围内产品
               SUBJECT_DEPT_ID      =
               (SELECT T.ORGANIZATION_ID
                  FROM HR_OPERATING_UNITS T
                 WHERE T.NAME = VALIDATE_H), --执行主体
               CONTRACT_FORM         = GET_DICTCODE_BY_NAME('SPM_CON_HT_FORM',
                                                            VALIDATE_I), --合同形式
               CONTRACT_AMOUNT       = VALIDATE_J, --合同金额
               CURRENCY_TYPE        =
               (SELECT T.CURRENCY_CODE
                  FROM FND_CURRENCIES_VL T
                 WHERE T.ENABLED_FLAG = 'Y'
                   AND T.NAME = VALIDATE_K), --币种
               EXCHANGE_RATE         = VALIDATE_L, --汇率
               RMB_TOTAL             = VALIDATE_J * VALIDATE_L,
               MORE_LESS_RATIO       = VALIDATE_M, --溢短装比例
               IS_ADVANCE            = GET_DICTCODE_BY_NAME('SPM_CON_HT_IS_ADVANCE',
                                                            VALIDATE_N), --是否垫资
               CONTRACT_CODE_OPPSITE = VALIDATE_O, --对方合同编号
               PM_PERSON_ID         =
               (SELECT T.USER_ID
                  FROM SPM_CON_HT_PEOPLE_V T
                 WHERE T.FULL_NAME = VALIDATE_P
                   AND SPM_SSO_PKG.GETORGID = T.BELONGORGID), --项目经理,--项目经理
               CONTRACT_REMARK       = VALIDATE_U,
               ATTRIBUTE3            = '1',
               LAST_UPDATE_DATE      = SYSDATE,
               DEPT_ID              =
               (SELECT T.ORGANIZATION_ID
                  FROM SPM_CON_HT_PEOPLE_V T
                 WHERE T.FULL_NAME = VALIDATE_Q
                   AND SPM_SSO_PKG.GETORGID = T.BELONGORGID), --部门
               ORG_ID                = SPM_SSO_PKG.GETORGID, --组织
               CREATED_BY           =
               (SELECT T.USER_ID
                  FROM SPM_CON_HT_PEOPLE_V T
                 WHERE T.FULL_NAME = VALIDATE_Q
                   AND SPM_SSO_PKG.GETORGID = T.BELONGORGID) --USER_ID
         WHERE CONTRACT_CODE = VALIDATE_B;
      
        /*    BEGIN
           FOR C IN CUR(VALIDATE_10) LOOP
             UPDATE  SPM_CON_HT_FILE T
                    SET
                        T.CATEGORY_ID= (SELECT T.CATEGORY_ID FROM SPM_CON_CONTRACT_CATEGORY T WHERE T.CATEGORY_NAME=VALIDATE_10 AND T.IS_END='1'),
                        T.BASIS_TYPE=C.BASIS_TYPE,
                        T.ATTRIBUTE1='1'
                        WHERE T.CONTRACT_ID=(SELECT F.CONTRACT_ID FROM SPM_CON_HT_INFO F WHERE F.CONTRACT_CODE=VALIDATE_B);
        
             COMMIT;
          END LOOP;
        END;*/
      
        IF VALIDATE_NUMBER20 = 3 AND VALIDATE_CONTRACT_CODE = 1 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 2)
            INTO VALIDATE_9
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 3)
            INTO VALIDATE_10
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_10
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_9
                             AND T.PARENT_ID =
                                 (SELECT T.CATEGORY_ID
                                    FROM SPM_CON_CONTRACT_CATEGORY T
                                   WHERE T.CATEGORY_NAME = VALIDATE_8
                                     AND T.PARENT_ID =
                                         (SELECT T.CATEGORY_ID
                                            FROM SPM_CON_CONTRACT_CATEGORY T
                                           WHERE T.CATEGORY_NAME = VALIDATE_7))))
           WHERE F.CONTRACT_ID =
                 (SELECT FF.CONTRACT_ID
                    FROM SPM_CON_HT_INFO FF
                   WHERE FF.CONTRACT_CODE = VALIDATE_B);
        
        END IF;
      
        IF VALIDATE_NUMBER20 = 2 AND VALIDATE_CONTRACT_CODE = 1 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 2)
            INTO VALIDATE_9
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_9
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_8
                             AND T.PARENT_ID =
                                 (SELECT T.CATEGORY_ID
                                    FROM SPM_CON_CONTRACT_CATEGORY T
                                   WHERE T.CATEGORY_NAME = VALIDATE_7)))
           WHERE F.CONTRACT_ID =
                 (SELECT FF.CONTRACT_ID
                    FROM SPM_CON_HT_INFO FF
                   WHERE FF.CONTRACT_CODE = VALIDATE_B);
        
        END IF;
      
        IF VALIDATE_NUMBER20 = 1 AND VALIDATE_CONTRACT_CODE = 1 THEN
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 0)
            INTO VALIDATE_7
            FROM DUAL;
          SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D, '>', 1)
            INTO VALIDATE_8
            FROM DUAL;
        
          UPDATE SPM_CON_HT_INFO F
             SET F.CONTRACT_CATEGORY =
                 (SELECT T.CATEGORY_ID
                    FROM SPM_CON_CONTRACT_CATEGORY T
                   WHERE T.CATEGORY_NAME = VALIDATE_8
                     AND T.PARENT_ID =
                         (SELECT T.CATEGORY_ID
                            FROM SPM_CON_CONTRACT_CATEGORY T
                           WHERE T.CATEGORY_NAME = VALIDATE_7))
           WHERE F.CONTRACT_ID =
                 (SELECT FF.CONTRACT_ID
                    FROM SPM_CON_HT_INFO FF
                   WHERE FF.CONTRACT_CODE = VALIDATE_B);
        
        END IF;
      
      END IF;
    
      --插入合同差异表 一条数据对应9条
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '履约主体', '1', '1');
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '供货范围', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '合同金额', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '法律纠纷解决', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '交货进度', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '技术要求', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '违约责任', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '付款方式', '1', '1');
    
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, V_INFO_ID, '其他', '1', '1');
    
      --EXEC  FUJIAN(V_INFO_ID,VALIDATE_10);
    
      FETCH CU_DATA
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
             VALIDATE_V,
             VALIDATE_W,
             VALIDATE_X,
             VALIDATE_Y,
             VALIDATE_Z;
    END LOOP;
  
    --工程导入 A1
    WHILE CU_DATA1%FOUND LOOP
      SELECT SPM_CON_HT_PROJECT_SEQ.NEXTVAL INTO VALIDATE_ID2 FROM DUAL;
      INSERT INTO SPM_CON_HT_PROJECT
        (CON_PRO_RELATION_ID,
         CONTRACT_ID,
         PROJECT_ID,
         CREATION_DATE /*,
                                                                                                                             DEPT_ID,
                                                                                                                             ORG_ID,
                                                                                                                             CREATED_BY*/)
      VALUES
        (VALIDATE_ID2,
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1), --主键
         (SELECT F.PROJECT_ID
            FROM SPM_CON_PROJECT F
           WHERE F.PROJECT_CODE = VALIDATE_B1),
         SYSDATE /*,
                                                                                                                             (SPM_EAM_COMMON_PKG.GET_DEPTID_BY_PERSONID(VALIDATE_PERSON_ID)),
                                                                                                                             (SELECT T.USER_ID FROM SPM_EAM_ALL_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_Q),
                                                                                                                             (SELECT T.ORGANIZATION_ID FROM SPM_EAM_ALL_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_Q)*/);
    
      FETCH CU_DATA1
        INTO VALIDATE_A1, VALIDATE_B1;
    
    END LOOP;
  
    --标的物导入  A2
    WHILE CU_DATA2%FOUND LOOP
    
      SELECT SPM_CON_HT_TARGET_SEQ.NEXTVAL
        INTO VALIDATE_TARGET_ID
        FROM DUAL;
      SELECT T.CONTRACT_ID
        INTO VALIDATE_TARGET1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_A2;
      SELECT SPM_CON_HT_GOODS_PLAN_SEQ.NEXTVAL
        INTO VALIDATE_JH_ID
        FROM DUAL;
    
      SELECT COUNT(*)
        INTO HAS_CONTRACT
        FROM SPM_CON_HT_TARGET O
       WHERE O.CONTRACT_ID = VALIDATE_TARGET1
         AND O.CODE_TYPE = '流水码'; --AND O.CODE_TYPE='流水码'
      SELECT SUBSTR(VALIDATE_A2, 10, LENGTH(VALIDATE_A2))
        INTO CONTRACT_CODE_4
        FROM SPM_CON_HT_INFO O
       WHERE O.CONTRACT_ID = VALIDATE_TARGET1;
      IF HAS_CONTRACT < 1 THEN
        INSERT INTO SPM_CON_HT_TARGET
          (TARGET_ID,
           CONTRACT_ID,
           IS_DELETE,
           MATERIAL_CODE,
           MATERIAL_NAME,
           SPECIFICATION_MODEL, --规格型号
           TARGET_UNIT, --单位
           TARGET_COUNT, --数量
           UNIT_PRICE, --单价
           TARGET_AMOUNT, --金额
           TAX_RATE, --税率
           TAX_AMOUNT, --税额
           NOTAX_AMOUNT, --不含税金额
           CODE_TYPE)
        VALUES
          (VALIDATE_TARGET_ID,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A2), --主键
           0,
           CONTRACT_CODE_4 || '001',
           VALIDATE_C2,
           VALIDATE_D2,
           VALIDATE_E2,
           VALIDATE_F2,
           VALIDATE_G2,
           VALIDATE_H2,
           VALIDATE_I2 * 100,
           VALIDATE_J2,
           VALIDATE_K2,
           '流水码');
      
        INSERT INTO SPM_CON_HT_GOODS_PLAN
          (GOODS_PLAN_ID,
           CONTRACT_ID,
           TARGET_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           IS_TARGET_DEL --未删除
           )
        VALUES
          (VALIDATE_JH_ID,
           VALIDATE_TARGET1,
           VALIDATE_TARGET_ID,
           CONTRACT_CODE_4 || '001',
           VALIDATE_C2,
           0);
      
      ELSE
        SELECT MAX(MATERIAL_CODE)
          INTO MATRIAL_CODE_V
          FROM (SELECT T.MATERIAL_CODE
                  FROM SPM_CON_HT_TARGET T
                 WHERE T.CONTRACT_ID = VALIDATE_TARGET1);
        SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                              LENGTH(MATRIAL_CODE_V) - 2,
                                              LENGTH(MATRIAL_CODE_V))) + 1）,
                             '000'))
          INTO SEQ_CODE
          FROM DUAL;
      
        INSERT INTO SPM_CON_HT_TARGET
          (TARGET_ID,
           CONTRACT_ID,
           IS_DELETE,
           MATERIAL_CODE,
           MATERIAL_NAME,
           SPECIFICATION_MODEL, --规格型号
           TARGET_UNIT, --单位
           TARGET_COUNT, --数量
           UNIT_PRICE, --单价
           TARGET_AMOUNT, --金额
           TAX_RATE, --税率
           TAX_AMOUNT, --税额
           NOTAX_AMOUNT, --不含税金额
           CODE_TYPE)
        VALUES
          (VALIDATE_TARGET_ID,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A2), --主键
           0,
           CONTRACT_CODE_4 || SEQ_CODE,
           VALIDATE_C2,
           VALIDATE_D2,
           VALIDATE_E2,
           VALIDATE_F2,
           VALIDATE_G2,
           VALIDATE_H2,
           VALIDATE_I2,
           NVL(VALIDATE_J2, 0),
           VALIDATE_K2,
           '流水码');
      
        INSERT INTO SPM_CON_HT_GOODS_PLAN
          (GOODS_PLAN_ID,
           CONTRACT_ID,
           TARGET_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           IS_TARGET_DEL --未删除
           )
        VALUES
          (VALIDATE_JH_ID,
           VALIDATE_TARGET1,
           VALIDATE_TARGET_ID,
           CONTRACT_CODE_4 || SEQ_CODE,
           VALIDATE_C2,
           0);
      
      END IF;
    
      FETCH CU_DATA2
        INTO VALIDATE_A2,
             VALIDATE_B2,
             VALIDATE_C2,
             VALIDATE_D2,
             VALIDATE_E2,
             VALIDATE_F2,
             VALIDATE_G2,
             VALIDATE_H2,
             VALIDATE_I2,
             VALIDATE_J2,
             VALIDATE_K2;
    
    END LOOP;
  
    --收付款计划 A3
    WHILE CU_DATA3%FOUND LOOP
      SELECT SPM_CON_HT_CLAUSE_SEQ.NEXTVAL INTO VALIDATE_SF_ID FROM DUAL;
      INSERT INTO SPM_CON_HT_CLAUSE
        (CLAUSE_ID,
         CONTRACT_ID,
         PAYMENT_TYPE, --收付款类型
         PAYMENT_CONDITION, --收付款条件
         PAY_DATE, --收付款日期
         PAYMENT_RATIO, --收付款比例
         CURRENCY_TYPE, --币种
         TOTAL_MONEY, --付款金额
         RMB_TOTAL, --折合人民币
         SETTLEMENT_METHOD, --结算方式
         IS_DELETE,
         IN_OUT_TYPE)
      VALUES
        (VALIDATE_SF_ID,
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3),
         GET_DICTCODE_BY_NAME('SPM_CON_HT_PAYMENT_TYPE', VALIDATE_B3),
         VALIDATE_C3,
         TO_DATE(SUBSTR(VALIDATE_D3, 1, 10), 'YYYY-MM-DD'),
         VALIDATE_E3,
         VALIDATE_F3,
         VALIDATE_G3,
         VALIDATE_H3,
         GET_DICTCODE_BY_NAME('SPM_CON_HT_SETTLEMENT_METHOD', VALIDATE_I3),
         0,
         (SELECT T.IN_OUT_TYPE
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3));
    
      FETCH CU_DATA3
        INTO VALIDATE_A3,
             VALIDATE_B3,
             VALIDATE_C3,
             VALIDATE_D3,
             VALIDATE_E3,
             VALIDATE_F3,
             VALIDATE_G3,
             VALIDATE_H3,
             VALIDATE_I3,
             VALIDATE_J3;
    END LOOP;
  
    WHILE CU_DATA4%FOUND LOOP
      SELECT SPM_CON_HT_GOODS_PLAN_SEQ.NEXTVAL
        INTO VALIDATE_JH_ID
        FROM DUAL;
      /*      INSERT INTO SPM_CON_HT_GOODS_PLAN
        (
        GOODS_PLAN_ID,
        CONTRACT_ID,
        MATERIAL_CODE,
        MATERIAL_NAME,
        PLAN_DATE,--预计交货时间
        GOODS_PLACE,--交货地点
        GOODS_MODE,--交货方式
        GOODS_CONDITION,--交货条件
        IS_TARGET_DEL --未删除
         )
      VALUES
        (VALIDATE_JH_ID,
        (SELECT T.CONTRACT_ID FROM SPM_CON_HT_INFO T WHERE T.CONTRACT_CODE=VALIDATE_A4),
        VALIDATE_B4,
        VALIDATE_C4,
        TO_DATE(SUBSTR(VALIDATE_D4, 1, 10), 'YYYY-MM-DD'),
        VALIDATE_E4,
        VALIDATE_F4,
        VALIDATE_G4,
        0
        );*/
    
      FETCH CU_DATA4
        INTO VALIDATE_A4,
             VALIDATE_B4,
             VALIDATE_C4,
             VALIDATE_D4,
             VALIDATE_E4,
             VALIDATE_F4,
             VALIDATE_G4;
    END LOOP;
  
    WHILE CU_DATA5%FOUND LOOP
      --查询插入客户供应商中间表的主键
      SELECT SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL
        INTO VALIDATE_KHGYS_ID
        FROM DUAL;
      --查询当前的收支类型
      SELECT T.IN_OUT_TYPE
        INTO VALIDATE_CUSTINFO
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_A5;
    
      IF VALIDATE_CUSTINFO = '1' THEN
        SELECT T.CUST_ID
          INTO VALIDATE_NUMBER1
          FROM SPM_CON_CUST_INFO T
         WHERE T.CUST_CODE = VALIDATE_B5;
        VALIDATE_IOT := VALIDATE_NUMBER1;
      ELSE
        SELECT T.VENDOR_ID
          INTO VALIDATE_NUMBER1
          FROM SPM_CON_VENDOR_INFO T
         WHERE T.VENDOR_CODE = VALIDATE_B5;
        VALIDATE_IOT := VALIDATE_NUMBER1;
      END IF;
    
      --插入客户或者供应商
      INSERT INTO SPM_CON_HT_MERCHANTS
        (CON_MERCHANTS_ID,
         MERCHANTS_ID,
         CONTRACT_ID,
         IN_OUT_TYPE,
         MERCHANTS_FLAG)
      VALUES
        (VALIDATE_KHGYS_ID,
         VALIDATE_NUMBER1, --18
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A5),
         VALIDATE_CUSTINFO,
         VALIDATE_CUSTINFO);
    
      FETCH CU_DATA5
        INTO VALIDATE_A5, VALIDATE_B5;
    END LOOP;
  
    --6.更新新附件信息
    WHILE CU_DATA6%FOUND LOOP
      SELECT T.CONTRACT_ID
        INTO VALIDATE_FUJIAN
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_A6;
      SELECT COUNT(*)
        INTO VALIDATE_NUMBER38
        FROM SPM_CON_HT_FILE T
       WHERE T.CONTRACT_ID = VALIDATE_FUJIAN;
      SELECT SPM_CON_HT_FILE_SEQ.NEXTVAL INTO VALIDATE_FUJIAN2 FROM DUAL;
    
      IF VALIDATE_NUMBER38 < 1 THEN
        INSERT INTO SPM_CON_HT_FILE T
          (FILE_ID, CONTRACT_ID, CATEGORY_ID, BASIS_TYPE)
        VALUES
          (VALIDATE_FUJIAN2, VALIDATE_FUJIAN, 100024, 10);
      END IF;
      UPDATE SPM_UPLOAD_FILE F
         SET F.ASS_TABLE_PRIKEY_ID = P_TABLEID + 1
       WHERE F.ASS_TABLE_NAME = 'SPM_CON_HT_IMPORT'
         AND F.ASS_TABLE_PRIKEY_ID = P_TABLEID
         AND F.FILE_ORG_NAME = VALIDATE_B6;
    
      FETCH CU_DATA6
        INTO VALIDATE_A6,
             VALIDATE_B6,
             VALIDATE_C6,
             VALIDATE_D6,
             VALIDATE_E6,
             VALIDATE_F6,
             VALIDATE_G6,
             VALIDATE_H6,
             VALIDATE_I6,
             VALIDATE_J6,
             VALIDATE_K6,
             VALIDATE_L6,
             VALIDATE_M6,
             VALIDATE_N6;
    END LOOP;
  
    --7.关联关系
    WHILE CU_DATA7%FOUND LOOP
      SELECT COUNT(*)
        INTO VALIDATE_NUM1
        FROM SPM_CON_HT_RELATION T
       WHERE T.CONTRACT_ID =
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_A7);
      SELECT COUNT(*)
        INTO VALIDATE_NUM2
        FROM SPM_CON_HT_RELATION T
       WHERE T.CONTRACT_ID =
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_B7);
    
      IF VALIDATE_NUM1 < 1 THEN
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           T.ORG_ID,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A7),
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_B7),
           '2',
           '1',
           '2',
           (SELECT T.ORG_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A7),
           '1');
        COMMIT;
      END IF;
    
      IF VALIDATE_NUM2 < 1 THEN
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           T.ORG_ID,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_B7),
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A7),
           '2',
           '1',
           '1',
           (SELECT T.ORG_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = VALIDATE_A7),
           '1');
      
      END IF;
      FETCH CU_DATA7
        INTO VALIDATE_A7, VALIDATE_B7;
    END LOOP;
  
    CLOSE CU_DATA;
    CLOSE CU_DATA1;
    CLOSE CU_DATA2;
    CLOSE CU_DATA3;
    CLOSE CU_DATA4;
    CLOSE CU_DATA5;
    CLOSE CU_DATA6;
    CLOSE CU_DATA7;
    COMMIT;
  
  END;

  PROCEDURE HT_VALIDATE(P_TABLENAME VARCHAR2,
                        P_TABLEID   VARCHAR2,
                        P_BATCHCODE VARCHAR2,
                        P_MSG       OUT VARCHAR2) IS
    CURSOR CU_DATA IS
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
             TRIM(U)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '合同主信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --1.工程信息
    CURSOR CU_DATA1 IS
      SELECT TRIM(A), TRIM(B)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '工程信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --2.标的物信息
    CURSOR CU_DATA2 IS
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
             TRIM(K)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '标的物信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --3.收付款条款
    CURSOR CU_DATA3 IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H),
             TRIM(I),
             TRIM(J)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '收付款条款'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --4.交货计划
    CURSOR CU_DATA4 IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E), TRIM(F), TRIM(G)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '交货计划'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --5.客户或供应商
    CURSOR CU_DATA5 IS
      SELECT TRIM(A), TRIM(B), TRIM(C)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '客户或供应商'
       ORDER BY TO_NUMBER(ROW_NUMBER);
    --6.附件
    CURSOR CU_DATA6 IS
      SELECT TRIM(A), TRIM(B)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '附件'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --变量
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
    VALIDATE_P VARCHAR2(2000);
    VALIDATE_Q VARCHAR2(2000);
    VALIDATE_R VARCHAR2(2000);
    VALIDATE_S VARCHAR2(2000);
    VALIDATE_T VARCHAR2(2000);
    VALIDATE_U VARCHAR2(2000);
  
    --1.工程信息
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
  
    --2.标的物信息
    VALIDATE_A2 VARCHAR2(2000);
    VALIDATE_B2 VARCHAR2(2000);
    VALIDATE_C2 VARCHAR2(2000);
    VALIDATE_D2 VARCHAR2(2000);
    VALIDATE_E2 VARCHAR2(2000);
    VALIDATE_F2 VARCHAR2(2000);
    VALIDATE_G2 VARCHAR2(2000);
    VALIDATE_H2 VARCHAR2(2000);
    VALIDATE_I2 VARCHAR2(2000);
    VALIDATE_J2 VARCHAR2(2000);
    VALIDATE_K2 VARCHAR2(2000);
  
    --3.收付款条款
    VALIDATE_A3 VARCHAR2(2000);
    VALIDATE_B3 VARCHAR2(2000);
    VALIDATE_C3 VARCHAR2(2000);
    VALIDATE_D3 VARCHAR2(2000);
    VALIDATE_E3 VARCHAR2(2000);
    VALIDATE_F3 VARCHAR2(2000);
    VALIDATE_G3 VARCHAR2(2000);
    VALIDATE_H3 VARCHAR2(2000);
    VALIDATE_I3 VARCHAR2(2000);
    VALIDATE_J3 VARCHAR2(2000);
  
    --4.交货计划
    VALIDATE_A4 VARCHAR2(2000);
    VALIDATE_B4 VARCHAR2(2000);
    VALIDATE_C4 VARCHAR2(2000);
    VALIDATE_D4 VARCHAR2(2000);
    VALIDATE_E4 VARCHAR2(2000);
    VALIDATE_F4 VARCHAR2(2000);
    VALIDATE_G4 VARCHAR2(2000);
  
    --5.客户或供应商
    VALIDATE_A5 VARCHAR2(2000);
    VALIDATE_B5 VARCHAR2(2000);
    VALIDATE_C5 VARCHAR2(2000);
  
    --6.附件信息
    VALIDATE_A6 VARCHAR2(2000);
    VALIDATE_B6 VARCHAR2(2000);
  
    VALIDATE_NUMBER   NUMBER;
    VALIDATE_NUMBER1  NUMBER;
    VALIDATE_NUMBER2  NUMBER;
    VALIDATE_NUMBER3  NUMBER;
    VALIDATE_NUMBER4  NUMBER;
    VALIDATE_NUMBER5  NUMBER;
    VALIDATE_NUMBER6  NUMBER;
    VALIDATE_NUMBER7  NUMBER;
    VALIDATE_NUMBER8  NUMBER;
    VALIDATE_NUMBER9  NUMBER;
    VALIDATE_NUMBER10 NUMBER;
    VALIDATE_NUMBER11 NUMBER;
    VALIDATE_NUMBER12 NUMBER;
    VALIDATE_NUMBER13 NUMBER;
    VALIDATE_NUMBER14 NUMBER;
    VALIDATE_NUMBER15 NUMBER;
    VALIDATE_NUMBER16 NUMBER;
    VALIDATE_NUMBER17 NUMBER;
    VALIDATE_NUMBER18 NUMBER;
    VALIDATE_NUMBER19 NUMBER;
    VALIDATE_NUMBER20 NUMBER;
    VALIDATE_NUMBER21 NUMBER;
    VALIDATE_NUMBER22 NUMBER;
    VALIDATE_NUMBER23 NUMBER;
    VALIDATE_NUMBER24 NUMBER;
    VALIDATE_NUMBER25 NUMBER;
    VALIDATE_NUMBER26 NUMBER;
    VALIDATE_NUMBER27 NUMBER;
    VALIDATE_NUMBER28 NUMBER;
    VALIDATE_NUMBER29 NUMBER;
    VALIDATE_NUMBER30 NUMBER;
    VALIDATE_NUMBER31 NUMBER;
    VALIDATE_NUMBER32 NUMBER;
    VALIDATE_NUMBER33 NUMBER;
    VALIDATE_NUMBER34 NUMBER;
    VALIDATE_NUMBER35 NUMBER;
    VALIDATE_NUMBER36 NUMBER;
    VALIDATE_NUMBER37 NUMBER;
    VALIDATE_NUMBER38 NUMBER;
    VALIDATE_NUMBER39 NUMBER;
    VALIDATE_NUMBER40 NUMBER;
    VALIDATE_NUMBER41 NUMBER;
    VALIDATE_NUMBER42 NUMBER;
    VALIDATE_NUMBER43 NUMBER;
    VALIDATE_NUMBER44 NUMBER;
    VALIDATE_NUMBER45 NUMBER;
    VALIDATE_NUMBER46 NUMBER;
    VALIDATE_NUMBER47 NUMBER;
    VALIDATE_NUMBER48 NUMBER;
    VALIDATE_NUMBER49 NUMBER;
    VALIDATE_NUMBER50 NUMBER;
    VALIDATE_NUMBER51 NUMBER;
    VALIDATE_NUMBER52 NUMBER;
    VALIDATE_NUMBER53 NUMBER;
    VALIDATE_NUMBER54 NUMBER;
    VALIDATE_NUMBER55 NUMBER;
    VALIDATE_NUMBER56 NUMBER;
    VALIDATE_NUMBER57 NUMBER;
    VALIDATE_FUJIAN   NUMBER;
  
    VALIDATE_INVENTORY_ITEM_ID NUMBER;
    VALIDATE_INOUT_TYPE        VARCHAR(200);
  
    --合同主信息
    MSG_A         VARCHAR2(4000);
    MSG_B         VARCHAR2(4000);
    MSG_C         VARCHAR2(4000);
    MSG_D         VARCHAR2(4000);
    MSG_E         VARCHAR2(4000);
    MSG_F         VARCHAR2(4000);
    MSG_G         VARCHAR2(4000);
    MSG_H         VARCHAR2(4000);
    MSG_I         VARCHAR2(4000);
    MSG_J         VARCHAR2(4000);
    MSG_K         VARCHAR2(4000);
    MSG_L         VARCHAR2(4000);
    MSG_M         VARCHAR2(4000);
    MSG_N         VARCHAR2(4000);
    MSG_O         VARCHAR2(4000);
    MSG_P         VARCHAR2(4000);
    MSG_Q         VARCHAR2(4000);
    MSG_R         VARCHAR2(4000);
    MSG_S         VARCHAR2(4000);
    MSG_T         VARCHAR2(4000);
    MSG_U         VARCHAR2(4000);
    MSG_USER      VARCHAR2(4000);
    VALIDATE_USER NUMBER;
  
    --1.工程信息
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
  
    --2.标的物信息
    MSG_A2 VARCHAR2(4000);
    MSG_B2 VARCHAR2(4000);
    MSG_C2 VARCHAR2(4000);
    MSG_D2 VARCHAR2(4000);
    MSG_E2 VARCHAR2(4000);
    MSG_F2 VARCHAR2(4000);
    MSG_G2 VARCHAR2(4000);
    MSG_H2 VARCHAR2(4000);
    MSG_I2 VARCHAR2(4000);
    MSG_J2 VARCHAR2(4000);
    MSG_K2 VARCHAR2(4000);
    MSG_L2 VARCHAR2(4000);
  
    --3.收付款信息
    MSG_A3 VARCHAR2(4000);
    MSG_B3 VARCHAR2(4000);
    MSG_C3 VARCHAR2(4000);
    MSG_D3 VARCHAR2(4000);
    MSG_E3 VARCHAR2(4000);
    MSG_F3 VARCHAR2(4000);
    MSG_G3 VARCHAR2(4000);
    MSG_H3 VARCHAR2(4000);
    MSG_I3 VARCHAR2(4000);
    MSG_J3 VARCHAR2(4000);
  
    --4.交货计划信息
    MSG_A4 VARCHAR2(4000);
    MSG_B4 VARCHAR2(4000);
    MSG_C4 VARCHAR2(4000);
    MSG_D4 VARCHAR2(4000);
    MSG_E4 VARCHAR2(4000);
    MSG_F4 VARCHAR2(4000);
    MSG_G4 VARCHAR2(4000);
    MSG_K4 VARCHAR2(4000);
  
    --5.客户供应信息
    MSG_A5 VARCHAR2(4000);
    MSG_B5 VARCHAR2(4000);
    MSG_C5 VARCHAR2(4000);
  
    --6.附件
    MSG_A6 VARCHAR2(4000);
    MSG_B6 VARCHAR2(4000);
  
    --报错提示信息
    P_MSG1 VARCHAR2(4000);
    P_MSG2 VARCHAR2(4000);
    P_MSG3 VARCHAR2(4000);
    P_MSG4 VARCHAR2(4000);
    P_MSG5 VARCHAR2(4000);
    P_MSG6 VARCHAR2(4000);
    P_MSG7 VARCHAR2(4000);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
    V_1                 VARCHAR2(200);
    V_2                 VARCHAR2(200);
    V_3                 VARCHAR2(200);
    VALIDATE_STAUTS     VARCHAR2(300);
    VALIDATE_STATUS1    VARCHAR2(300);
    VALIDATE_STATUS2    VARCHAR2(300);
    VALIDATE_STATUS3    VARCHAR2(300);
    VALIDATE_STATUS4    VARCHAR2(300);
    VALIDATE_STATUS5    VARCHAR2(300);
  
  BEGIN
    OPEN CU_DATA;
    OPEN CU_DATA1;
    OPEN CU_DATA2;
    OPEN CU_DATA3;
    OPEN CU_DATA4;
    OPEN CU_DATA5;
    OPEN CU_DATA6;
  
    FETCH CU_DATA
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
           VALIDATE_U;
  
    --工程信息
    FETCH CU_DATA1
      INTO VALIDATE_A1, VALIDATE_B1;
  
    --标的物信息
    FETCH CU_DATA2
      INTO VALIDATE_A2,
           VALIDATE_B2,
           VALIDATE_C2,
           VALIDATE_D2,
           VALIDATE_E2,
           VALIDATE_F2,
           VALIDATE_G2,
           VALIDATE_H2,
           VALIDATE_I2,
           VALIDATE_J2,
           VALIDATE_K2;
  
    --收付款条款信息
    FETCH CU_DATA3
      INTO VALIDATE_A3,
           VALIDATE_B3,
           VALIDATE_C3,
           VALIDATE_D3,
           VALIDATE_E3,
           VALIDATE_F3,
           VALIDATE_G3,
           VALIDATE_H3,
           VALIDATE_I3,
           VALIDATE_J3;
  
    --4.交货计划信息
    FETCH CU_DATA4
      INTO VALIDATE_A4,
           VALIDATE_B4,
           VALIDATE_C4,
           VALIDATE_D4,
           VALIDATE_E4,
           VALIDATE_F4,
           VALIDATE_G4;
  
    --5.客户或供应商
    FETCH CU_DATA5
      INTO VALIDATE_A5, VALIDATE_B5, VALIDATE_C5;
  
    --6.附件
    FETCH CU_DATA6
      INTO VALIDATE_A6, VALIDATE_B6;
  
    -------------------------------------合同主信息START-------------------------------------------
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '合同名称(*)' OR VALIDATE_B <> '合同编号(*)' OR
         VALIDATE_C <> '业务类型(*)' OR VALIDATE_D <> '合同类型(*)' OR
         VALIDATE_E <> '收支类型(*)' OR VALIDATE_F <> '主要标的物(*)' OR
         VALIDATE_G <> '目录范围内产品 (省级物资公司允许范围)(*)' OR VALIDATE_H <> '执行主体(*)' OR
         VALIDATE_I <> '合同形式(*)' OR VALIDATE_J <> '合同金额(*)' OR
         VALIDATE_K <> '币种' OR VALIDATE_L <> '汇率' OR VALIDATE_M <> '溢短装比例' OR
         VALIDATE_N <> '是否垫资(*)' OR VALIDATE_O <> '对方合同编号' OR
         VALIDATE_P <> '项目经理(*)' OR VALIDATE_Q <> '经办人' OR
         VALIDATE_R <> '创建时间' OR VALIDATE_S <> '履行期限(*)' OR
         VALIDATE_T <> '到(*)' OR VALIDATE_U <> '合同简介'
      
       THEN
        P_MSG := '合同主信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA;
        RETURN;
      END IF;
    
      FETCH CU_DATA
      
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
             VALIDATE_U;
    
      WHILE CU_DATA%FOUND LOOP
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER1
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_B;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER2
          FROM SPM_CON_HT_BIS_TYPE T
         WHERE T.TYPE_NAME = VALIDATE_C;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER3
          FROM SPM_CON_CONTRACT_CATEGORY T
         WHERE T.CATEGORY_NAME = VALIDATE_D;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER4
          FROM SPM_DICT T
         WHERE T.DICT_TYPE_ID =
               (SELECT F.DICT_TYPE_ID
                  FROM SPM_DICT_TYPE F
                 WHERE F.TYPE_CODE = 'SPM_CON_HT_INOUT_TYPE')
           AND T.DICT_NAME = VALIDATE_E;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER5
          FROM SPM_CON_HT_M_TARGET T
         WHERE T.MTARGET_NAME = VALIDATE_F;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER6
          FROM HR_OPERATING_UNITS T
         WHERE 1 = 1
           AND T.NAME = VALIDATE_H;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER7
          FROM SPM_DICT T
         WHERE T.DICT_TYPE_ID =
               (SELECT F.DICT_TYPE_ID
                  FROM SPM_DICT_TYPE F
                 WHERE F.TYPE_CODE = 'SPM_CON_HT_FORM')
           AND T.DICT_NAME = VALIDATE_I;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_J)
          INTO VALIDATE_NUMBER8
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_L)
          INTO VALIDATE_NUMBER9
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_M)
          INTO VALIDATE_NUMBER10
          FROM DUAL;
        --SELECT COUNT(*) INTO VALIDATE_NUMBER11 FROM SPM_CON_HT_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_P;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER12
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.FULL_NAME = VALIDATE_Q;
        SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_R)
          INTO VALIDATE_NUMBER13
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_S)
          INTO VALIDATE_NUMBER14
          FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_T)
          INTO VALIDATE_NUMBER15
          FROM DUAL;
      
        --验证主信息为空 MSG_A   VALIDATE_NUMBER1 已用
        /*         IF VALIDATE_A IS NULL OR VALIDATE_B IS NULL OR VALIDATE_C IS NULL OR VALIDATE_D IS NULL
            OR VALIDATE_E IS NULL OR VALIDATE_F IS NULL OR VALIDATE_G IS NULL OR VALIDATE_H IS NULL   OR VALIDATE_I IS NULL
            OR VALIDATE_J IS NULL OR VALIDATE_N IS NULL OR VALIDATE_S IS NULL OR VALIDATE_T IS NULL  THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A :=  MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;*/
      
        --验证编码已存在 MSG_B VALIDATE_NUMBER1已用
        /*         IF VALIDATE_A IS NOT  NULL  THEN
           IF VALIDATE_NUMBER1>0 THEN
             DELETE FROM SPM_CON_HT_INFO T WHERE T.CONTRACT_CODE=VALIDATE_B;
             COMMIT;
          END IF;
        END IF;*/
      
        --验证相同合同编号存在 不让导入
        IF VALIDATE_D IS NOT NULL THEN
          IF VALIDATE_NUMBER1 > 1 THEN
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA%ROWCOUNT;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证合同类型是否存在
        IF VALIDATE_B IS NOT NULL AND VALIDATE_NUMBER1 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STAUTS
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_B;
          IF VALIDATE_STAUTS <> 'A' THEN
            IF MSG_B IS NULL THEN
              MSG_B := CU_DATA%ROWCOUNT;
            ELSE
              MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证业务类型是否存在
        /*         IF VALIDATE_D IS NOT  NULL  THEN
           IF VALIDATE_NUMBER3<1 THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D :=  MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
          END IF;
        END IF;*/
      
        /*        --验证收支类型是否存在
         IF VALIDATE_E IS NOT  NULL  THEN
           IF VALIDATE_NUMBER4<1 THEN
          IF MSG_E IS NULL THEN
            MSG_E := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E :=  MSG_E || ',' || CU_DATA%ROWCOUNT;
          END IF;
          END IF;
        END IF;
        
        --验证主要标的物是否存在
         IF VALIDATE_F IS NOT  NULL  THEN
           IF VALIDATE_NUMBER5<1 THEN
          IF MSG_F IS NULL THEN
            MSG_F := CU_DATA%ROWCOUNT;
          ELSE
            MSG_F :=  MSG_F || ',' || CU_DATA%ROWCOUNT;
          END IF;
          END IF;
        END IF;*/
      
        --验证执行主体是否存在
        IF VALIDATE_H IS NOT NULL THEN
          IF VALIDATE_NUMBER6 < 1 THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        /*        --验证合同形式是否存在
         IF VALIDATE_I IS NOT  NULL  THEN
           IF VALIDATE_NUMBER7<1 THEN
          IF MSG_I IS NULL THEN
            MSG_I := CU_DATA%ROWCOUNT;
          ELSE
            MSG_I :=  MSG_I || ',' || CU_DATA%ROWCOUNT;
          END IF;
          END IF;
        END IF;*/
      
        --验证合同金额是否为数字
        IF VALIDATE_J IS NOT NULL THEN
          IF VALIDATE_NUMBER8 <> 1 THEN
            IF MSG_J IS NULL THEN
              MSG_J := CU_DATA%ROWCOUNT;
            ELSE
              MSG_J := MSG_J || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证汇率是否为数字
        IF VALIDATE_L IS NOT NULL THEN
          IF VALIDATE_NUMBER9 <> 1 THEN
            IF MSG_L IS NULL THEN
              MSG_L := CU_DATA%ROWCOUNT;
            ELSE
              MSG_L := MSG_L || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证溢短装比例是否为数字
        IF VALIDATE_M IS NOT NULL THEN
          IF VALIDATE_NUMBER10 <> 1 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证项目经理是否存在
        IF VALIDATE_P IS NOT NULL THEN
          IF VALIDATE_NUMBER11 < 1 THEN
            IF MSG_P IS NULL THEN
              MSG_P := CU_DATA%ROWCOUNT;
            ELSE
              MSG_P := MSG_P || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证经办人是否存在
        IF VALIDATE_Q IS NOT NULL THEN
          IF VALIDATE_NUMBER12 < 1 THEN
            IF MSG_Q IS NULL THEN
              MSG_Q := CU_DATA%ROWCOUNT;
            ELSE
              MSG_Q := MSG_Q || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证创建日期格式
        IF VALIDATE_R IS NOT NULL THEN
          IF VALIDATE_NUMBER13 <> 1 THEN
            IF MSG_R IS NULL THEN
              MSG_R := CU_DATA%ROWCOUNT;
            ELSE
              MSG_R := MSG_R || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证履行日期格式
        IF VALIDATE_S IS NOT NULL THEN
          IF VALIDATE_NUMBER14 <> 1 THEN
            IF MSG_S IS NULL THEN
              MSG_S := CU_DATA%ROWCOUNT;
            ELSE
              MSG_S := MSG_S || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证履行日期到格式
        IF VALIDATE_T IS NOT NULL THEN
          IF VALIDATE_NUMBER15 <> 1 THEN
            IF MSG_T IS NULL THEN
              MSG_T := CU_DATA%ROWCOUNT;
            ELSE
              MSG_T := MSG_T || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证经办人
        IF VALIDATE_Q IS NOT NULL THEN
        
          SELECT COUNT(*)
            INTO VALIDATE_USER
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.FULL_NAME = VALIDATE_Q
             AND SPM_SSO_PKG.GETORGID = T.BELONGORGID;
        
          IF VALIDATE_USER = 0 THEN
            IF MSG_USER IS NULL THEN
              MSG_USER := CU_DATA%ROWCOUNT;
            ELSE
              MSG_USER := MSG_USER || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA
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
               VALIDATE_U;
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 主合同信息必填项有未填写完整的,请检查;';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 合同已启用 请勿导入,请检查';
      END IF;
    
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 业务类型不存在';
      END IF;
    
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 变更状态或者归档 不允许导入';
      END IF;
    
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 收支类型不存在';
      END IF;
    
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 主要标的物不存在';
      END IF;
    
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 执行主体不存在';
      END IF;
    
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 合同形式不存在';
      END IF;
    
      IF MSG_J IS NOT NULL THEN
        MSG_J := MSG_I || '行 合同金额格式非法';
      END IF;
    
      IF MSG_L IS NOT NULL THEN
        MSG_L := MSG_L || '行 汇率格式非法';
      END IF;
    
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 溢短装比例非法';
      END IF;
    
      IF MSG_P IS NOT NULL THEN
        MSG_P := MSG_P || '行 项目经理不存在';
      END IF;
    
      IF MSG_Q IS NOT NULL THEN
        MSG_Q := MSG_Q || '行 经办人不存在';
      END IF;
    
      IF MSG_R IS NOT NULL THEN
        MSG_R := MSG_R || '行 创建日期格式非法';
      END IF;
    
      IF MSG_S IS NOT NULL THEN
        MSG_S := MSG_S || '行 履行日期格式非法';
      END IF;
    
      IF MSG_T IS NOT NULL THEN
        MSG_T := MSG_T || '行 履行格式日期到非法';
      END IF;
    
      IF MSG_USER IS NOT NULL THEN
        MSG_USER := MSG_USER || '行 该经办人在本组织下没有部门';
      END IF;
    
      /*     P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D  || MSG_E ||
               MSG_F || MSG_G || MSG_H || MSG_I || MSG_J ||MSG_K
               ||MSG_L ||MSG_M ||MSG_N ||MSG_O ||MSG_P ||MSG_Q
               ||MSG_R ||MSG_S ||MSG_T ||MSG_U  ;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;*/
    END IF;
    -------------------------------------合同主信息END-------------------------------------------
  
    ---------------------------------1.工程信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA1%FOUND THEN
      IF VALIDATE_A1 <> '合同编号(*)' OR VALIDATE_B1 <> '工程编号(*)' THEN
        P_MSG := '工程信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA1;
        RETURN;
      END IF;
    
      FETCH CU_DATA1
        INTO VALIDATE_A1, VALIDATE_B1;
    
      WHILE CU_DATA1%FOUND LOOP
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER16
          FROM SPM_CON_PROJECT T
         WHERE T.PROJECT_CODE = VALIDATE_B1;
      
        --验证工程是否存在
        IF VALIDATE_B1 IS NOT NULL THEN
          IF VALIDATE_NUMBER16 < 1 THEN
            IF MSG_B1 IS NULL THEN
              MSG_B1 := CU_DATA1%ROWCOUNT;
            ELSE
              MSG_B1 := MSG_B1 || ',' || CU_DATA1%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证工程是否为空
        IF VALIDATE_B1 IS NULL THEN
          IF MSG_A1 IS NULL THEN
            MSG_A1 := CU_DATA1%ROWCOUNT;
          ELSE
            MSG_A1 := MSG_A1 || ',' || CU_DATA1%ROWCOUNT;
          END IF;
        END IF;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER45
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_A1;
        --验证工程中合同编号是否在流程中
        IF VALIDATE_A1 IS NOT NULL AND VALIDATE_NUMBER45 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STATUS1
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1;
          IF VALIDATE_STATUS1 <> 'A' THEN
            IF MSG_C1 IS NULL THEN
              MSG_C1 := CU_DATA1%ROWCOUNT;
            ELSE
              MSG_C1 := MSG_C1 || ',' || CU_DATA1%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA1
          INTO VALIDATE_A1, VALIDATE_B1;
      
      END LOOP;
      CLOSE CU_DATA1;
    
      IF MSG_A1 IS NOT NULL THEN
        MSG_A1 := MSG_A1 || '行 工程信息未填写完整,请补充;';
      END IF;
    
      IF MSG_B1 IS NOT NULL THEN
        MSG_B1 := MSG_B1 || '行 工程不存在,请检查;';
      END IF;
    
      IF MSG_C1 IS NOT NULL THEN
        MSG_C1 := MSG_C1 || '行 合同已启动,请检查;';
      END IF;
    
    END IF;
    ---------------------------------1.工程信息END-------------------------------------------
  
    ---------------------------------2.标的物信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA2%FOUND THEN
      IF VALIDATE_A2 <> '合同编号' OR VALIDATE_B2 <> '物料编码' OR
         VALIDATE_C2 <> '物料名称' OR VALIDATE_D2 <> '规格型号' OR
         VALIDATE_E2 <> '单位' OR VALIDATE_F2 <> '数量' OR VALIDATE_G2 <> '单价' OR
         VALIDATE_H2 <> '金额' OR VALIDATE_I2 <> '税率' OR VALIDATE_J2 <> '税额' OR
         VALIDATE_K2 <> '不含税金额' THEN
        P_MSG := '标的物信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA2;
        RETURN;
      END IF;
    
      FETCH CU_DATA2
        INTO VALIDATE_A2,
             VALIDATE_B2,
             VALIDATE_C2,
             VALIDATE_D2,
             VALIDATE_E2,
             VALIDATE_F2,
             VALIDATE_G2,
             VALIDATE_H2,
             VALIDATE_I2,
             VALIDATE_J2,
             VALIDATE_K2;
    
      WHILE CU_DATA2%FOUND LOOP
      
        /*
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_F2) INTO VALIDATE_NUMBER17 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_G2) INTO VALIDATE_NUMBER18 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_H2) INTO VALIDATE_NUMBER19 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_I2) INTO VALIDATE_NUMBER20 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_J2) INTO VALIDATE_NUMBER21 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_K2) INTO VALIDATE_NUMBER22 FROM DUAL; */
      
        /*        --验证合同编码是否存在
              IF VALIDATE_A2 IS   NULL  THEN
               IF MSG_A2 IS NULL THEN
                 MSG_A2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_A2 :=  MSG_A2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
        
             --验证数量格式
              IF VALIDATE_F2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER17<>1 THEN
               IF MSG_F2 IS NULL THEN
                 MSG_F2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_F2 :=  MSG_F2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
            END IF;
        
        
             --验证单价格式
              IF VALIDATE_G2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER18<>1 THEN
               IF MSG_G2 IS NULL THEN
                 MSG_G2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_G2 :=  MSG_G2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
            END IF;
        
             --验证金额格式
              IF VALIDATE_H2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER19<>1 THEN
               IF MSG_H2 IS NULL THEN
                 MSG_H2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_H2 :=  MSG_H2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
            END IF;
        
             --验证税率格式
              IF VALIDATE_I2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER20<>1 THEN
               IF MSG_I2 IS NULL THEN
                 MSG_I2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_I2 :=  MSG_I2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
            END IF;
        
             --验证税额格式
              IF VALIDATE_J2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER21<>1 THEN
               IF MSG_J2 IS NULL THEN
                 MSG_J2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_J2 :=  MSG_J2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
        END IF;
        
             --验证不含税金额格式
              IF VALIDATE_K2 IS NOT  NULL  THEN
                IF VALIDATE_NUMBER22<>1 THEN
               IF MSG_K2 IS NULL THEN
                 MSG_K2 := CU_DATA2%ROWCOUNT;
               ELSE
                 MSG_K2 :=  MSG_K2 || ',' || CU_DATA2%ROWCOUNT;
               END IF;
             END IF;
            END IF;*/
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER46
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_A1;
        --验证工程中合同编号是否在流程中
        IF VALIDATE_A2 IS NOT NULL AND VALIDATE_NUMBER46 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STATUS2
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1;
          IF VALIDATE_STATUS2 <> 'A' THEN
            IF MSG_L2 IS NULL THEN
              MSG_L2 := CU_DATA2%ROWCOUNT;
            ELSE
              MSG_L2 := MSG_L2 || ',' || CU_DATA2%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA2
          INTO VALIDATE_A2,
               VALIDATE_B2,
               VALIDATE_C2,
               VALIDATE_D2,
               VALIDATE_E2,
               VALIDATE_F2,
               VALIDATE_G2,
               VALIDATE_H2,
               VALIDATE_I2,
               VALIDATE_J2,
               VALIDATE_K2;
      
      END LOOP;
      CLOSE CU_DATA2;
    
      IF MSG_A2 IS NOT NULL THEN
        MSG_A2 := MSG_A2 || '行 合同编号为空,请补充;';
      END IF;
    
      IF MSG_F2 IS NOT NULL THEN
        MSG_F2 := MSG_F2 || '行 数量格式不正确,请检查;';
      END IF;
    
      IF MSG_G2 IS NOT NULL THEN
        MSG_G2 := MSG_G2 || '行 单价格式不正确,请检查;';
      END IF;
    
      IF MSG_H2 IS NOT NULL THEN
        MSG_H2 := MSG_H2 || '行 金额格式不正确,请检查;';
      END IF;
    
      IF MSG_I2 IS NOT NULL THEN
        MSG_I2 := MSG_I2 || '行 税率格式不正确,请检查;';
      END IF;
    
      IF MSG_J2 IS NOT NULL THEN
        MSG_J2 := MSG_J2 || '行 税额格式不正确,请检查;';
      END IF;
    
      IF MSG_K2 IS NOT NULL THEN
        MSG_K2 := MSG_K2 || '行 不含税金额格式不正确,请检查;';
      END IF;
    
      IF MSG_L2 IS NOT NULL THEN
        MSG_L2 := MSG_L2 || '行 标的物明细中合同已启动,请检查;';
      END IF;
    
    END IF;
    ---------------------------------2.标的物信息END-------------------------------------------
  
    ---------------------------------3.收付款条款信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA3%FOUND THEN
      IF VALIDATE_A3 <> '合同编号' OR VALIDATE_B3 <> '收付款类型' OR
         VALIDATE_C3 <> '付款条件' OR VALIDATE_D3 <> '收付款时间' OR
         VALIDATE_E3 <> '收付款比例(%)' OR VALIDATE_F3 <> '币种' OR
         VALIDATE_G3 <> '收付款金额' OR VALIDATE_H3 <> '折合人民币' OR
         VALIDATE_I3 <> '结算方式' THEN
        P_MSG := '收付款条款信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA3;
        RETURN;
      END IF;
    
      FETCH CU_DATA3
        INTO VALIDATE_A3,
             VALIDATE_B3,
             VALIDATE_C3,
             VALIDATE_D3,
             VALIDATE_E3,
             VALIDATE_F3,
             VALIDATE_G3,
             VALIDATE_H3,
             VALIDATE_I3,
             VALIDATE_J3;
    
      WHILE CU_DATA3%FOUND LOOP
      
        /*              SELECT COUNT(*) INTO  VALIDATE_NUMBER23 FROM SPM_DICT T WHERE T.DICT_TYPE_ID=(SELECT F.DICT_TYPE_ID FROM SPM_DICT_TYPE F WHERE F.TYPE_CODE='SPM_CON_HT_PAYMENT_TYPE') AND T.DICT_NAME=VALIDATE_B3;
        SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_D3) INTO VALIDATE_NUMBER24 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_E3) INTO VALIDATE_NUMBER25 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_G3) INTO VALIDATE_NUMBER26 FROM DUAL;
        SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_H3) INTO VALIDATE_NUMBER27 FROM DUAL;
        SELECT COUNT(*) INTO  VALIDATE_NUMBER28 FROM SPM_DICT T WHERE T.DICT_TYPE_ID=(SELECT F.DICT_TYPE_ID FROM SPM_DICT_TYPE F WHERE F.TYPE_CODE='SPM_CON_HT_SETTLEMENT_METHOD') AND T.DICT_NAME=VALIDATE_I3;*/
      
        --验证合同编码是否存在
        IF VALIDATE_A3 IS NULL THEN
          IF MSG_A3 IS NULL THEN
            MSG_A3 := CU_DATA3%ROWCOUNT;
          ELSE
            MSG_A3 := MSG_A3 || ',' || CU_DATA3%ROWCOUNT;
          END IF;
        END IF;
      
        --验证收付款类型是否存在
        /* IF VALIDATE_B3 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER23<1 THEN
           IF MSG_B3 IS NULL THEN
             MSG_B3 := CU_DATA3%ROWCOUNT;
           ELSE
             MSG_B3 :=  MSG_B3 || ',' || CU_DATA3%ROWCOUNT;
           END IF;
         END IF;
        END IF;
        
         --验证结算方式是否存在
          IF VALIDATE_I3 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER28<1 THEN
           IF MSG_I3 IS NULL THEN
             MSG_I3 := CU_DATA3%ROWCOUNT;
           ELSE
             MSG_I3 :=  MSG_I3 || ',' || CU_DATA3%ROWCOUNT;
           END IF;
         END IF;
        END IF;
        
        
        --验证收付款日期格式
          IF VALIDATE_C3 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER24<>1 THEN
           IF MSG_C3 IS NULL THEN
             MSG_C3 := CU_DATA3%ROWCOUNT;
           ELSE
             MSG_C3 :=  MSG_C3 || ',' || CU_DATA3%ROWCOUNT;
           END IF;
         END IF;
        END IF;
        
        --验证收付款比例
          IF VALIDATE_E3 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER25<>1 THEN
           IF MSG_E3 IS NULL THEN
             MSG_E3 := CU_DATA3%ROWCOUNT;
           ELSE
             MSG_E3 :=  MSG_E3 || ',' || CU_DATA3%ROWCOUNT;
           END IF;
         END IF;
        END IF;
        
        
        --验证收付款金额格式
          IF VALIDATE_G3 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER26<>1 THEN
           IF MSG_G3 IS NULL THEN
             MSG_G3 := CU_DATA3%ROWCOUNT;
           ELSE
             MSG_G3 :=  MSG_G3 || ',' || CU_DATA3%ROWCOUNT;
           END IF;
         END IF;
        END IF;
         */
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER47
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_A1;
        --验证工程中合同编号是否在流程中
        IF VALIDATE_A3 IS NOT NULL AND VALIDATE_NUMBER47 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STATUS3
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1;
          IF VALIDATE_STATUS3 <> 'A' THEN
            IF MSG_J3 IS NULL THEN
              MSG_J3 := CU_DATA3%ROWCOUNT;
            ELSE
              MSG_J3 := MSG_J3 || ',' || CU_DATA3%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA3
          INTO VALIDATE_A3,
               VALIDATE_B3,
               VALIDATE_C3,
               VALIDATE_D3,
               VALIDATE_E3,
               VALIDATE_F3,
               VALIDATE_G3,
               VALIDATE_H3,
               VALIDATE_I3,
               VALIDATE_J3;
      
      END LOOP;
      CLOSE CU_DATA3;
    
      IF MSG_A3 IS NOT NULL THEN
        MSG_A3 := MSG_A3 || '行 合同编号为空,请补充;';
      END IF;
    
      IF MSG_B3 IS NOT NULL THEN
        MSG_B3 := MSG_B3 || '行 收付款类型不存在,请检查;';
      END IF;
    
      IF MSG_D3 IS NOT NULL THEN
        MSG_D3 := MSG_D3 || '行 收付款时间格式不正确,请检查;';
      END IF;
    
      IF MSG_E3 IS NOT NULL THEN
        MSG_E3 := MSG_E3 || '行 收付款比例格式不正确,请检查;';
      END IF;
    
      IF MSG_G3 IS NOT NULL THEN
        MSG_G3 := MSG_G3 || '行 收付款金额格式不正确,请检查;';
      END IF;
    
      IF MSG_I3 IS NOT NULL THEN
        MSG_I3 := MSG_I3 || '行 结算方式不存在,请检查;';
      END IF;
    
      IF MSG_J3 IS NOT NULL THEN
        MSG_J3 := MSG_J3 || '行 收付款条款合同已启动,请检查;';
      END IF;
    
    END IF;
    ---------------------------------3.收付款条款END-------------------------------------------
  
    ---------------------------------4.交货计划款信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA4%FOUND THEN
      IF VALIDATE_A4 <> '合同编号' OR VALIDATE_B4 <> '物料' OR
         VALIDATE_C4 <> '物料名称' OR VALIDATE_D4 <> '预计交货时间' OR
         VALIDATE_E4 <> '交货地点' OR VALIDATE_F4 <> '交货方式' OR
         VALIDATE_G4 <> '交货条件' THEN
        P_MSG := '交货计划信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA4;
        RETURN;
      END IF;
    
      FETCH CU_DATA4
        INTO VALIDATE_A4,
             VALIDATE_B4,
             VALIDATE_C4,
             VALIDATE_D4,
             VALIDATE_E4,
             VALIDATE_F4,
             VALIDATE_G4;
    
      WHILE CU_DATA4%FOUND LOOP
      
        /*              SELECT SPM_IMPORT_XLS_PKG.IS_DATE(VALIDATE_D4) INTO VALIDATE_NUMBER29 FROM DUAL;
        */
      
        --验证合同编码是否存在
        IF VALIDATE_A4 IS NULL THEN
          IF MSG_A4 IS NULL THEN
            MSG_A4 := CU_DATA4%ROWCOUNT;
          ELSE
            MSG_A4 := MSG_A4 || ',' || CU_DATA4%ROWCOUNT;
          END IF;
        END IF;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER48
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_A1;
        --验证工程中合同编号是否在流程中
        IF VALIDATE_A4 IS NOT NULL AND VALIDATE_NUMBER48 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STATUS4
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1;
          IF VALIDATE_STATUS4 <> 'A' THEN
            IF MSG_G4 IS NULL THEN
              MSG_G4 := CU_DATA4%ROWCOUNT;
            ELSE
              MSG_G4 := MSG_G4 || ',' || CU_DATA4%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        --验证预计交货时间日期格式
        /*         IF VALIDATE_D4 IS NOT  NULL  THEN
            IF VALIDATE_NUMBER29<>1 THEN
           IF MSG_D4 IS NULL THEN
             MSG_D4 := CU_DATA4%ROWCOUNT;
           ELSE
             MSG_D4 :=  MSG_D4 || ',' || CU_DATA4%ROWCOUNT;
           END IF;
         END IF;
        END IF;*/
      
        FETCH CU_DATA4
          INTO VALIDATE_A4,
               VALIDATE_B4,
               VALIDATE_C4,
               VALIDATE_D4,
               VALIDATE_E4,
               VALIDATE_F4,
               VALIDATE_G4;
      
      END LOOP;
      CLOSE CU_DATA4;
    
      IF MSG_A4 IS NOT NULL THEN
        MSG_A4 := MSG_A4 || '行 合同编号为空,请补充;';
      END IF;
    
      IF MSG_D4 IS NOT NULL THEN
        MSG_D4 := MSG_D4 || '行 预计交货时间不存在,请检查;';
      END IF;
    
      IF MSG_G4 IS NOT NULL THEN
        MSG_G4 := MSG_G4 || '行 交货计划合同已启动,请检查;';
      END IF;
    
    END IF;
    ---------------------------------4.交货计划END-------------------------------------------
  
    ---------------------------------5.客户供应商款信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA5%FOUND THEN
      IF VALIDATE_A5 <> '合同编号' OR VALIDATE_B5 <> '客商编码' OR
         VALIDATE_C5 <> '客商名称' THEN
        P_MSG := '客户或供应商信息导入数据的字段名不符合格式';
      
        CLOSE CU_DATA5;
        RETURN;
      END IF;
    
      FETCH CU_DATA5
        INTO VALIDATE_A5, VALIDATE_B5, VALIDATE_C5;
    
      WHILE CU_DATA5%FOUND LOOP
      
        IF VALIDATE_E IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER30
            FROM SPM_CON_CUST_INFO T
           WHERE T.CUST_CODE = VALIDATE_B5;
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER31
            FROM SPM_CON_VENDOR_INFO T
           WHERE T.VENDOR_CODE = VALIDATE_B5;
        END IF;
      
        --验证合同编码是否存在
        IF VALIDATE_A5 IS NULL THEN
          IF MSG_A5 IS NULL THEN
            MSG_A5 := CU_DATA5%ROWCOUNT;
          ELSE
            MSG_A5 := MSG_A5 || ',' || CU_DATA5%ROWCOUNT;
          END IF;
        END IF;
      
        --验证客户供应商编码是否存在
        IF VALIDATE_B5 IS NOT NULL THEN
          IF VALIDATE_NUMBER30 < 1 AND VALIDATE_NUMBER31 < 1 THEN
            IF MSG_B5 IS NULL THEN
              MSG_B5 := CU_DATA5%ROWCOUNT;
            ELSE
              MSG_B5 := MSG_B5 || ',' || CU_DATA5%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER49
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_A1;
        --验证工程中合同编号是否在流程中
        IF VALIDATE_A5 IS NOT NULL AND VALIDATE_NUMBER49 > 0 THEN
          SELECT T.STATUS
            INTO VALIDATE_STATUS5
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1;
          IF VALIDATE_STATUS5 <> 'A' THEN
            IF MSG_C5 IS NULL THEN
              MSG_C5 := CU_DATA5%ROWCOUNT;
            ELSE
              MSG_C5 := MSG_C5 || ',' || CU_DATA5%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA5
          INTO VALIDATE_A5, VALIDATE_B5, VALIDATE_C5;
      
      END LOOP;
      CLOSE CU_DATA5;
    
      IF MSG_A5 IS NOT NULL THEN
        MSG_A5 := MSG_A5 || '行 合同编号为空,请补充;';
      END IF;
    
      IF MSG_B5 IS NOT NULL THEN
        MSG_B5 := MSG_B5 || '行 客户供应商不存在请检查;';
      END IF;
    
      IF MSG_C5 IS NOT NULL THEN
        MSG_C5 := MSG_C5 || '行 客户供应商中合同已启动流程不存在请检查;';
      END IF;
    
    END IF;
    ---------------------------------5.客户供应商END-------------------------------------------
  
    ---------------------------------6.附件信息START-------------------------------------------
    --验证导入字段名格式是否正确
    IF CU_DATA6%FOUND THEN
      /*      IF VALIDATE_A6 <> '合同编号'  OR VALIDATE_B6 <> '附件名称'
       THEN
        P_MSG := '附件导入数据的字段名不符合格式';
      
        CLOSE CU_DATA6;
        RETURN;
      END IF;*/
    
      FETCH CU_DATA6
        INTO VALIDATE_A6, VALIDATE_B6;
    
      WHILE CU_DATA6%FOUND LOOP
        /*         IF P_TABLEID<>-1 THEN
           SELECT COUNT(*) INTO VALIDATE_FUJIAN FROM SPM_UPLOAD_FILE T WHERE T.ASS_TABLE_NAME='SPM_CON_HT_INFO' AND T.ASS_TABLE_PRIKEY_ID=(SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL FROM DUAL);
        --验证是否存入UPLOAD表中
         IF VALIDATE_A6 IS   NULL  THEN
          IF MSG_A6 IS NULL THEN
            MSG_A6 := CU_DATA5%ROWCOUNT;
          ELSE
            MSG_A6 :=  MSG_A6 || ',' || CU_DATA6%ROWCOUNT;
          END IF;
          END IF;
        END IF;*/
      
        FETCH CU_DATA6
          INTO VALIDATE_A6, VALIDATE_B6;
      
      END LOOP;
      CLOSE CU_DATA6;
    
      IF MSG_A6 IS NOT NULL THEN
        MSG_A6 := MSG_A6 || '行 UPLOAD表中没有数据;';
      END IF;
    
    END IF;
    ---------------------------------6.附件信息END-------------------------------------------
  
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
             MSG_N || MSG_O || MSG_P || MSG_Q || MSG_R || MSG_S || MSG_T ||
             MSG_U || MSG_USER || MSG_A1 || MSG_B1 || MSG_C1 || MSG_A2 ||
             MSG_B2 || MSG_C2 || MSG_D2 || MSG_E2 || MSG_F2 || MSG_G2 ||
             MSG_H2 || MSG_I2 || MSG_J2 || MSG_K2 || MSG_L2 || MSG_A3 ||
             MSG_B3 || MSG_C3 || MSG_D3 || MSG_E3 || MSG_F3 || MSG_G3 ||
             MSG_H3 || MSG_I3 || MSG_J3 || MSG_A4 || MSG_B4 || MSG_C4 ||
             MSG_D4 || MSG_E4 || MSG_F4 || MSG_G4 || MSG_A5 || MSG_B5 ||
             MSG_C5;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    
    END IF;
  
  END;

  PROCEDURE CHAYI IS
    AA NUMBER;
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_ID NOT IN
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_DIFF F
               WHERE 1 = 1
                 AND F.DIFF_ITEM = '履约主体')
         AND T.ATTRIBUTE3 = '1';
    --AND T.CONTRACT_CODE LIKE '18%';
  BEGIN
    FOR C IN CUR LOOP
      INSERT INTO SPM_CON_HT_DIFF T
        (T.DIFF_ID, T.CONTRACT_ID, T.DIFF_ITEM, DIFF_LEVEL, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_DIFF_SEQ.NEXTVAL, C.CONTRACT_ID, '履约主体', '1', '1');
      COMMIT;
    END LOOP;
  
  END;

  PROCEDURE RELATION IS
    AA        NUMBER;
    V_NUMBER1 NUMBER;
    V_NUMBER2 NUMBER;
    V_NUMBER3 NUMBER;
    CURSOR CUR IS
      SELECT T.HT_RELATION_ID, T.CONTRACT_CODE1, T.CONTRACT_CODE2
        FROM SPM_CON_RELATION11 T;
  
  BEGIN
    FOR C IN CUR LOOP
    
      SELECT COUNT(*)
        INTO V_NUMBER1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = C.CONTRACT_CODE1;
      SELECT COUNT(*)
        INTO V_NUMBER2
        FROM SPM_CON_HT_INFO F
       WHERE F.CONTRACT_CODE = C.CONTRACT_CODE2;
    
      IF V_NUMBER1 > 0 AND V_NUMBER2 > 0 THEN
      
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           T.ORG_ID,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE1),
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE2),
           '2',
           '1',
           '2',
           (SELECT T.ORG_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE1),
           '1');
        COMMIT;
      
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           T.ORG_ID,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE2),
           (SELECT T.CONTRACT_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE1),
           '2',
           '1',
           '1',
           (SELECT T.ORG_ID
              FROM SPM_CON_HT_INFO T
             WHERE T.CONTRACT_CODE = C.CONTRACT_CODE1),
           '1');
      
        COMMIT;
      
      END IF;
    END LOOP;
  
  END;

  --校验所有的物料编码都在EBS
  PROCEDURE FUJIAN(ID NUMBER, V_NAME VARCHAR2) IS
    V_CODE VARCHAR2(200);
    MSG_A  VARCHAR2(2000);
  
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_CONTRACT_BASIS T
       WHERE T.CATEGORY_ID = (SELECT T.CATEGORY_ID
                                FROM SPM_CON_CONTRACT_CATEGORY T
                               WHERE T.CATEGORY_NAME = V_NAME
                                 AND T.IS_END = '1');
  
  BEGIN
    FOR C IN CUR LOOP
      INSERT INTO SPM_CON_HT_FILE T
        (T.FILE_ID, T.CONTRACT_ID, T.CATEGORY_ID, ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_FILE_SEQ.NEXTVAL,
         ID,
         (SELECT T.CATEGORY_ID
            FROM SPM_CON_CONTRACT_CATEGORY T
           WHERE T.CATEGORY_NAME = V_NAME
             AND T.IS_END = '1'),
         '1');
      COMMIT;
    END LOOP;
  
  END;

  --自动生成采购订单
  PROCEDURE DSSM_TO_PUR_ORDER(P_MSG OUT VARCHAR2) IS
  
    V_ID                 NUMBER;
    V_1                  NUMBER;
    V_2                  NUMBER;
    V_3                  NUMBER;
    V_4                  NUMBER;
    V_5                  NUMBER;
    V_6                  NUMBER;
    V_OU                 NUMBER;
    V_ORG_COUNT          NUMBER;
    V_PROJECT_COUNT      NUMBER;
    V_HT_MERCHANTS_COUNT NUMBER;
    V_CONTRACT_ID        NUMBER;
    VALIDATE1            VARCHAR2(2000);
    V_PAY_IDENTIFY       VARCHAR2(200);
    CONTRACT_CODE_4      VARCHAR2(40);
    MATRIAL_CODE_V       VARCHAR2(40);
    SEQ_CODE             VARCHAR2(40);
    HAS_CONTRACT         NUMBER;
    V_INFO_ID            NUMBER;
    V_DEPT_ID            NUMBER;
    V_CREATED_BY         NUMBER;
    NEW_CODE             VARCHAR2(40);
  
    HT_INFO       SPM_CON_HT_INFO%ROWTYPE;
    V_IN_OUT_TYPE VARCHAR2(40);
    V_ORDER_TYPE  VARCHAR2(40);
  
    HT_PROJECT   SPM_CON_HT_PROJECT%ROWTYPE;
    V_PROJECT_ID NUMBER(15);
  
    HT_MERCHANTS SPM_CON_HT_MERCHANTS%ROWTYPE;
  
    HT_TARGET       SPM_CON_HT_TARGET%ROWTYPE;
    V_ORG_ID        NUMBER(15);
    V_A             NUMBER;
    V_B             NUMBER;
    KJ_HT_ID        NUMBER;
    KJ_COUNT        NUMBER;
    MSG_A           VARCHAR2(4000);
    MSG_B           VARCHAR2(4000);
    MSG_C           VARCHAR2(4000);
    k_repeat_number number; --重复商品编码数量
  
    --所有的中间表中的主表信息
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_MQ_SM_PUR_ORDER T
       WHERE 1 = 1
         AND NVL(T.ATTRIBUTE1, 0) <> 'ED'
         and nvl(t.attribute2, 0) <> 'A'
       ORDER BY T.ID DESC;
    --AND T.ID=3838;
    --去找到所有的标的物信息
    CURSOR CURHTTARGET(V_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_MQ_SM_PUR_ORDER_DTL S
       WHERE 1 = 1
         AND S.ORDER_ID = V_ID
       ORDER BY S.SKU_VALUE DESC;
  
  BEGIN
    FOR BB IN CUR LOOP
      --插入合同主表信息
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO V_CONTRACT_ID FROM DUAL;
      IF NVL(BB.ATTRIBUTE2, 0) <> 'A' THEN
      
        SELECT DECODE(SUBSTR(BB.ORDER_NO, -2), '-1', '2', '1')
          INTO V_IN_OUT_TYPE
          FROM DUAL;
        SELECT DECODE(SUBSTR(BB.ORDER_NO, -2), '-1', '2', '1')
          INTO V_ORDER_TYPE
          FROM DUAL;
        --change by ruankk 采购订单统一是未付款的，以我业财侧的状态为准
        SELECT 'NOT' INTO V_PAY_IDENTIFY FROM DUAL;
      
        --主键
        HT_INFO.CONTRACT_ID := V_CONTRACT_ID;
        --采购组织
        HT_INFO.PURCHASE_ORG := BB.ORG_NAME; --采购组织
        --合同名称
        HT_INFO.CONTRACT_NAME := BB.ORDER_NO; --合同名称
        --合同编码
        HT_INFO.CONTRACT_CODE := BB.ORDER_NO; --合同编号
        --收支类型
        HT_INFO.IN_OUT_TYPE := V_IN_OUT_TYPE; --收支类型
        --订单类别
        HT_INFO.ORDER_TYPE := V_ORDER_TYPE; --订单类别
        --供应商名称
        HT_INFO.VENDOR_NAME := BB.ENTERPRICE_NAME; --供应商名称(中间商)
        --采购员
        HT_INFO.BUYER_NAME := BB.PURCHASE_NAME; --采购员
        --采购员电话
        HT_INFO.BUYER_TEL := BB.PURCHASE_PHONE; --采购员电话
        --订单金额
        HT_INFO.CONTRACT_AMOUNT := BB.TOTAL_MONEY; --订单金额
        --币种
        HT_INFO.CURRENCY_TYPE := 'CNY'; --币种
        --折合人民币
        HT_INFO.RMB_TOTAL := BB.TOTAL_MONEY; --折合人民币
        --税率
        HT_INFO.TAX_RATE := 0; --税率
        --制单时间
        HT_INFO.CREATION_DATE := BB.ORDER_TIME; --TO_DATE(SUBSTR(BB.GMT_CREATE, 1, 10), 'YYYY-MM-DD'),--制单时间
        --订单简介
        HT_INFO.CONTRACT_REMARK := BB.MEMO; --备注
        --变更状态
        HT_INFO.STATUS_CHANGE := '1';
        --合同类型(1普通2订单)
        HT_INFO.CONTRACT_TYPE := '2';
        --是否执行过紧急流程(1是0否)
        HT_INFO.IS_URGENT := '0';
        --审批状态
        HT_INFO.STATUS := 'A';
        --版本
        HT_INFO.CONTRACT_VERSION := '1';
        --归档状态
        HT_INFO.STATUS_ARCHIVED := 'J';
        --合同标识，所有变更合同与原始合同一致
        HT_INFO.CONTRACT_FLAG := SYS_GUID();
      
        HT_INFO.ATTRIBUTE3 := '1';
        --是否付款标识
        HT_INFO.PAY_IDENTIFY := V_PAY_IDENTIFY;
      
        HT_INFO.LAST_UPDATE_DATE := SYSDATE;
      
        HT_INFO.ONLINE_RETAILERS := 'DSCG';
        HT_INFO.CREATION_DATE    := BB.ORDER_TIME;
      
        INSERT INTO SPM_CON_HT_INFO VALUES HT_INFO;
      
        UPDATE SPM_CON_MQ_SM_PUR_ORDER T
           SET T.ATTRIBUTE2 = 'A'
         WHERE T.ID = BB.ID;
      END IF;
    
      --修改组织 通过NY_middle id
      SELECT COUNT(*)
        INTO V_ORG_COUNT
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'org'
         AND T.DS_CODE = BB.NY_MIDDLEMAN_ID;
      IF V_ORG_COUNT = 0 THEN
        MSG_A := '组织在SPM_CON_VENDOR_COMPARE中未找到 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_ORG_COUNT = 1 THEN
        SELECT TO_NUMBER(T.YC_CODE)
          INTO HT_INFO.ORG_ID
          FROM SPM_CON_VENDOR_COMPARE T
         WHERE T.FIELD_NAME = 'org'
           AND T.DS_CODE = BB.NY_MIDDLEMAN_ID;
        UPDATE SPM_CON_HT_INFO T
           SET T.ORG_ID = HT_INFO.ORG_ID
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      --关联供应商 返回值V_1为供应商的ID如果为-1 -2 -3 -4则不正常
    
      SELECT COUNT(*)
        INTO V_HT_MERCHANTS_COUNT
        FROM SPM_CON_HT_MERCHANTS T
       WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      SELECT TO_NUMBER(SPM_CON_VENDOR_PACKAGE.QUERY_VENDOR_STATUS(TO_CHAR(BB.ENTERPRISEID),
                                                                  HT_INFO.ORG_ID))
        INTO V_1
        FROM DUAL;
    
      IF V_1 = -1 THEN
        MSG_B := '电商未推送该供应商或者推送数据不完整 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -2 THEN
        MSG_B := '电商已推送该供应商，尚未进入业财系统 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -3 THEN
        MSG_B := '供应商未完成审批 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -4 THEN
        MSG_B := '供应商未同步 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -5 THEN
        MSG_B := '查找对应的供应商发生异常，请联系系统管理员 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 > 0 THEN
      
        --查询是否已关联项目
        SELECT COUNT(*)
          INTO V_PROJECT_COUNT
          FROM SPM_CON_HT_PROJECT T
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      
        IF V_PROJECT_COUNT = 0 AND NVL(BB.ATTRIBUTE3, 0) <> 'A' THEN
        
          --框架合同
          SELECT COUNT(*)
            INTO KJ_COUNT
            FROM SPM_CON_HT_INFO      S,
                 SPM_CON_HT_PROJECT   T,
                 SPM_CON_PROJECT      D,
                 SPM_CON_VENDOR_INFO  E,
                 SPM_CON_HT_MERCHANTS A
           WHERE 1 = 1
                
             AND S.CONTRACT_ID = T.CONTRACT_ID
             AND T.PROJECT_ID = D.PROJECT_ID
             AND S.CONTRACT_ID = A.CONTRACT_ID
             AND E.VENDOR_ID = A.MERCHANTS_ID
             AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
             AND S.CONTRACT_FORM = '4'
             AND S.IN_OUT_TYPE = '2'
             AND S.ORG_ID = HT_INFO.ORG_ID
             AND S.START_DATE <= trunc(HT_INFO.CREATION_DATE,'dd')
             AND S.END_DATE >= trunc(HT_INFO.CREATION_DATE,'dd')
             AND E.VENDOR_ID = V_1;
        
          IF KJ_COUNT = 0 THEN
            MSG_C := '供应商未找到对应的框架合同 ';
            UPDATE SPM_CON_HT_INFO T
               SET T.ERROR_MSG = MSG_A || MSG_B || MSG_C
             WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          END IF;
        
          IF KJ_COUNT > 1 THEN
            MSG_C := '找到多条可匹配的框架，请手动选择确认要关联的框架 ';
            UPDATE SPM_CON_HT_INFO T
               SET T.ERROR_MSG = MSG_A || MSG_B || MSG_C
             WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          END IF;
        
          IF KJ_COUNT = 1 THEN
            SELECT MAX(D.PROJECT_ID),
                   MAX(S.DEPT_ID),
                   MAX(S.CREATED_BY),
                   MAX(S.CONTRACT_ID)
              INTO V_PROJECT_ID, V_DEPT_ID, V_CREATED_BY, KJ_HT_ID
              FROM SPM_CON_HT_INFO      S,
                   SPM_CON_HT_PROJECT   T,
                   SPM_CON_PROJECT      D,
                   SPM_CON_VENDOR_INFO  E,
                   SPM_CON_HT_MERCHANTS A
             WHERE 1 = 1
                  
               AND S.CONTRACT_ID = T.CONTRACT_ID
               AND T.PROJECT_ID = D.PROJECT_ID
               AND S.CONTRACT_ID = A.CONTRACT_ID
               AND E.VENDOR_ID = A.MERCHANTS_ID
               AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
               AND S.CONTRACT_FORM = '4'
               AND S.IN_OUT_TYPE = '2'
               AND S.ORG_ID = HT_INFO.ORG_ID
               AND S.START_DATE <= trunc(HT_INFO.CREATION_DATE,'dd')
               AND S.END_DATE >= trunc(HT_INFO.CREATION_DATE,'dd')
               AND E.VENDOR_ID = V_1;
          
            --插入项目
            --主键 
            HT_PROJECT.CON_PRO_RELATION_ID := SPM_CON_HT_PROJECT_SEQ.NEXTVAL;
            --合同ID                            
            HT_PROJECT.CONTRACT_ID := V_CONTRACT_ID;
            --项目ID 
            HT_PROJECT.PROJECT_ID := V_PROJECT_ID;
          
            HT_PROJECT.ATTRIBUTE1 := 'DSCG';
          
            INSERT INTO SPM_CON_HT_PROJECT VALUES HT_PROJECT;
          
            UPDATE SPM_CON_MQ_SM_PUR_ORDER T
               SET T.ATTRIBUTE3 = 'A'
             WHERE T.ID = BB.ID;
          
            --插入供应商
            -- 主键
            HT_MERCHANTS.CON_MERCHANTS_ID := SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL;
            --客户/供应商ID
            HT_MERCHANTS.MERCHANTS_ID := V_1;
            --NUMBER  客户/供应商
            HT_MERCHANTS.MERCHANTS_FLAG := 2;
            --收支类型 VARCHAR
            HT_MERCHANTS.IN_OUT_TYPE := '2';
            --合同主键
            HT_MERCHANTS.CONTRACT_ID := V_CONTRACT_ID;
            HT_MERCHANTS.ATTRIBUTE1  := 'DSCG';
          
            INSERT INTO SPM_CON_HT_MERCHANTS VALUES HT_MERCHANTS;
          
            UPDATE SPM_CON_MQ_SM_PUR_ORDER T
               SET T.ATTRIBUTE4 = 'A', T.ATTRIBUTE1 = 'ED'
             WHERE T.ID = BB.ID;
          
            begin
              select count(*)
                into k_repeat_number
                from spm_con_mq_sm_pur_order_dtl t
               where t.order_id = bb.id
                 and t.ny_datang_material_code is not null
               group by t.ny_datang_material_code
              having count(*) > 1;
            exception
              when others then
                k_repeat_number := 0;
            end;
          
            if k_repeat_number = 0 then
            
              UPDATE SPM_CON_HT_INFO FF
                 SET FF.VENDOR_NAME =
                     (SELECT SS.VENDOR_NAME
                        FROM SPM_CON_VENDOR_INFO SS
                       WHERE SS.VENDOR_ID = V_1),
                     FF.STATUS      = 'E',
                     FF.ERROR_MSG   = NULL
               WHERE FF.CONTRACT_ID = V_CONTRACT_ID;
            
            else
            
              update spm_con_ht_info f
                 set f.status = 'A', f.error_msg = '存在相同的商品编码'
               where f.contract_id = V_CONTRACT_ID;
            
            end if;
          
            --分配人员部门(取框架合同)
            UPDATE SPM_CON_HT_INFO T
               SET T.DEPT_ID = V_DEPT_ID, T.CREATED_BY = V_CREATED_BY
             WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          
            --关联框架协议
            INSERT INTO SPM_CON_HT_RELATION T
              (T.RELATION_ID,
               T.CONTRACT_ID,
               T.CONTRACT_ID_R,
               T.RELATION_SHIP,
               T.RELATION_BUSINESS,
               T.RELATION_ACTION,
               ATTRIBUTE1)
            VALUES
              (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
               V_CONTRACT_ID,
               KJ_HT_ID,
               '3',
               '3',
               '2',
               'DS');
          
            INSERT INTO SPM_CON_HT_RELATION T
              (T.RELATION_ID,
               T.CONTRACT_ID,
               T.CONTRACT_ID_R,
               T.RELATION_SHIP,
               T.RELATION_BUSINESS,
               T.RELATION_ACTION,
               ATTRIBUTE1)
            VALUES
              (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
               KJ_HT_ID,
               V_CONTRACT_ID,
               '3',
               '3',
               '1',
               'DS');
          
          END IF;
        END IF;
      END IF;
    
      --插入标的物信息
      FOR BBB IN CURHTTARGET(BB.ID) LOOP
        IF NVL(BBB.ATTRIBUTE1, 0) <> 'A' THEN
        
          SELECT F.ORG_ID
            INTO V_ORG_ID
            FROM SPM_CON_HT_INFO F
           WHERE F.CONTRACT_ID = V_CONTRACT_ID;
          --ID
          HT_TARGET.TARGET_ID := SPM_CON_HT_TARGET_SEQ.NEXTVAL;
          --合同ID
          HT_TARGET.CONTRACT_ID := V_CONTRACT_ID;
          --
          HT_TARGET.IS_DELETE := 0; --是否删除
          --商品小类
          HT_TARGET.GOODS_CLASS := '商品小类'; --商品小类
          --物料编码
          HT_TARGET.MATERIAL_CODE := BBB.NY_DATANG_MATERIAL_CODE; --物料编号
          --物料名称
          HT_TARGET.MATERIAL_NAME := BBB.PRODUCT_NAME; --物料名称
          --商品参数
          HT_TARGET.TARGET_PARAMS := BBB.NY_MATERIAL_QUALITY;
          --规格型号
          HT_TARGET.SPECIFICATION_MODEL := BBB.NY_SPECIFICATIONS_SIZE;
          --包装规格
          HT_TARGET.SPECIFICATION_PACKING := BBB.NY_FIGURE_NUMBER;
          --供货单位
          HT_TARGET.TARGET_UNIT := BBB.UNIT; --供货单位
          --订购数量
          HT_TARGET.TARGET_COUNT := BBB.QUANTITY; --订货数量 I
          --单价
          HT_TARGET.UNIT_PRICE := BBB.TAX_PRICE; --含税单价 J
          --金额=含税单价*数量
          HT_TARGET.TARGET_AMOUNT := BBB.QUANTITY * BBB.TAX_PRICE; --订货金额
          --税率
          HT_TARGET.TAX_RATE := BBB.TAX_RATE;
          --不含税金额
          HT_TARGET.NOTAX_AMOUNT := ROUND(HT_TARGET.TARGET_AMOUNT /
                                          (1 + BBB.TAX_RATE * 0.01),
                                          2); --不含税金额 
          --税额
          HT_TARGET.TAX_AMOUNT := HT_TARGET.TARGET_AMOUNT -
                                  HT_TARGET.NOTAX_AMOUNT; --税额
          --备注
          HT_TARGET.REMARK     := '备注'; --备注
          HT_TARGET.ORG_ID     := V_ORG_ID;
          HT_TARGET.ATTRIBUTE1 := 'DSCG';
          --商品SKU
          HT_TARGET.SKU_VALUE := BBB.SKU_VALUE;
        
          INSERT INTO SPM_CON_HT_TARGET VALUES HT_TARGET;
        
          UPDATE SPM_CON_MQ_SM_PUR_ORDER_DTL T
             SET T.ATTRIBUTE1 = 'A'
           WHERE T.ID = BBB.ID;
        
          --物料编码生成流水码
        
          IF BBB.NY_DATANG_MATERIAL_CODE IS NULL THEN
            NEW_CODE := SPM_CON_HT_PKG.GET_TARGET_CODE(V_CONTRACT_ID);
            UPDATE SPM_CON_HT_TARGET T
               SET T.MATERIAL_CODE = NEW_CODE, T.CODE_TYPE = '流水码'
             WHERE T.TARGET_ID = HT_TARGET.TARGET_ID;
          
          END IF;
        END IF;
      
        UPDATE SPM_CON_HT_INFO T
           SET T.TAX_RATE = BBB.TAX_RATE
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      
      END LOOP;
    
      COMMIT;
    
    END LOOP;
  END;

  --从MQ销售订单中间表到合同侧订单表存储过程

  PROCEDURE DSSM_TO_SALE_ORDER(P_MSG OUT VARCHAR2) IS
  
    V_ID                 NUMBER;
    V_1                  NUMBER;
    V_2                  NUMBER;
    V_3                  NUMBER;
    V_4                  NUMBER;
    V_5                  NUMBER;
    V_6                  NUMBER;
    V_ORG_ID             NUMBER(15);
    V_PROJECT_ID         NUMBER(15);
    V_HT_MERCHANTS_COUNT NUMBER;
    V_CONTRACT_ID        NUMBER;
    VALIDATE1            VARCHAR2(2000);
    HT_INFO_ROW          SPM_CON_HT_INFO%ROWTYPE;
    HT_INVOICE_ROW       SPM_CON_HT_INVOICE%ROWTYPE;
    HT_PROJECT_ROW       SPM_CON_HT_PROJECT%ROWTYPE;
    HT_MERCHANTS_ROW     SPM_CON_HT_MERCHANTS%ROWTYPE;
    BANK_ACOUNT_INFO_ROW SPM_CON_BANK_ACOUNT_INFO%ROWTYPE;
    HT_TARGET_ROW        SPM_CON_HT_TARGET%ROWTYPE;
    HT_RECEIVER_ROW      SPM_CON_HT_RECEIVER%ROWTYPE;
    V_ORDER_TYPE         VARCHAR2(10);
    V_PAY_IDENTIFY       VARCHAR2(10);
    IS_EXISTS            NUMBER;
    V_PROJECT_COUNT      NUMBER;
    V_CUST_COUNT         NUMBER;
    V_DEPT_ID            NUMBER;
    V_CREATED_BY         NUMBER;
    NEW_CODE             VARCHAR2(40);
  
    CONTRACT_CODE_4 VARCHAR2(40);
    MATRIAL_CODE_V  VARCHAR2(40);
    SEQ_CODE        VARCHAR2(40);
    HAS_CONTRACT    NUMBER;
    PROJECT_COUNT   NUMBER;
  
    V_A             NUMBER;
    V_B             NUMBER;
    KJ_HT_ID        NUMBER;
    KJ_COUNT        NUMBER;
    MSG_A           VARCHAR2(4000);
    MSG_B           VARCHAR2(4000);
    MSG_C           VARCHAR2(4000);
    k_repeat_number number;
  
    --所有的中间表中的主表信息
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_MQ_SM_SALE_ORDER T
       WHERE 1 = 1
            --AND T.ORDER_ID=586;
         AND NVL(T.ATTRIBUTE1, 0) <> 'ED'
         and nvl(t.attribute2, 0) <> 'A'
       ORDER BY T.ORDER_ID DESC;
    --去找到所有的标的物信息
    CURSOR CURHTTARGET(V_ID NUMBER) IS
      SELECT *
      
        FROM SPM_CON_MQ_SM_SALE_ORDER_DTL S
       WHERE 1 = 1
         AND S.ORDER_ID = V_ID
         AND NVL(S.ATTRIBUTE1,'b') <> 'A'
       ORDER BY S.WARE_CODE DESC;
  
  BEGIN
    FOR BB IN CUR LOOP
      --插入合同主表信息
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO V_CONTRACT_ID FROM DUAL;
    
      IF NVL(BB.ATTRIBUTE2, 0) <> 'A' THEN
      
        --收支类型从订单号中截取
        SELECT DECODE(SUBSTR(BB.ORDER_CODE, -2), '-1', '2', '1')
          INTO V_ORDER_TYPE
          FROM DUAL;
        --change by ruankk 是否已经收款字段取错了  2:已经收款  1：一单一付
        SELECT DECODE(BB.NY_PAYMENT_METHOD, '1', 'NOT', 'ED')
          INTO V_PAY_IDENTIFY
          FROM DUAL;
      
        BEGIN
          --获取订单对应组织
          SELECT COUNT(*)
            INTO IS_EXISTS
            FROM SPM_CON_VENDOR_COMPARE T
           WHERE T.FIELD_NAME = 'org'
             AND T.DS_CODE = BB.NY_MIDDLEMAN_ID;
          IF IS_EXISTS = 0 THEN
            MSG_A := 'spm_con_vendor_compare中未找到对应的组织';
            UPDATE SPM_CON_HT_INFO T
               SET T.ERROR_MSG = MSG_A
             WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          END IF;
        
          IF IS_EXISTS <> 0 THEN
            SELECT TO_NUMBER(T.YC_CODE)
              INTO V_ORG_ID
              FROM SPM_CON_VENDOR_COMPARE T
             WHERE T.FIELD_NAME = 'org'
               AND T.DS_CODE = BB.NY_MIDDLEMAN_ID
               AND ROWNUM = 1;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('获取订单对应组织信息报错');
            V_ORG_ID := -1;
        END;
      
        --主键
        HT_INFO_ROW.CONTRACT_ID := V_CONTRACT_ID;
        --采购组织
        HT_INFO_ROW.PURCHASE_ORG := BB.ASSIGN_PURORG_NAME;
        --合同名称
        HT_INFO_ROW.CONTRACT_NAME := BB.ORDER_CODE; --订单编码
        --合同编码
        HT_INFO_ROW.CONTRACT_CODE := BB.ORDER_CODE;
        --收支类型
        HT_INFO_ROW.IN_OUT_TYPE := V_ORDER_TYPE;
        --订单类别
        HT_INFO_ROW.ORDER_TYPE := V_ORDER_TYPE;
        --供应商名称
        HT_INFO_ROW.VENDOR_NAME := BB.NY_MIDDLEMAN_NAME;
        --采购员
        HT_INFO_ROW.BUYER_NAME := BB.PURCHASER_NAME;
        --采购员电话
        HT_INFO_ROW.BUYER_TEL := BB.PURCHASER_MOBILE;
        --采购部门
        HT_INFO_ROW.PURCHASE_DEPT := BB.PURCHASER_DEPT_NAME;
        --订单金额
        HT_INFO_ROW.CONTRACT_AMOUNT := BB.TAX_AMOUNT;
        --币种
        HT_INFO_ROW.CURRENCY_TYPE := 'CNY'; --币种
        --折合人民币
        HT_INFO_ROW.RMB_TOTAL := BB.TAX_AMOUNT; --折合人民币
        --税率
        HT_INFO_ROW.TAX_RATE := ROUND((BB.TAX_AMOUNT - BB.AMOUNT) /
                                      BB.AMOUNT * 100,
                                      2); --税率
        --创建时间
        HT_INFO_ROW.CREATION_DATE := BB.CREATATION_TIME; --TO_DATE(SUBSTR(BB.GMT_CREATE, 1, 10), 'YYYY-MM-DD'),--制单时间
        --订单简介
        HT_INFO_ROW.CONTRACT_REMARK := BB.MEMO; --备注
        --合同变更记录
        HT_INFO_ROW.STATUS_CHANGE := '1'; --未变更附'1'
        --合同类型
        HT_INFO_ROW.CONTRACT_TYPE := '2'; --合同类型(区分订单和普通)
      
        HT_INFO_ROW.IS_URGENT := '0';
        --流程状态
        HT_INFO_ROW.STATUS := 'A'; --新建
        --合同版本号
        HT_INFO_ROW.CONTRACT_VERSION := '1';
        --归档状态
        HT_INFO_ROW.STATUS_ARCHIVED := 'J';
      
        HT_INFO_ROW.CONTRACT_FLAG := SYS_GUID();
        --？
        HT_INFO_ROW.ATTRIBUTE3 := '1';
      
        HT_INFO_ROW.LAST_UPDATE_DATE := SYSDATE;
        --电商导入标识
        HT_INFO_ROW.ONLINE_RETAILERS := 'DSXS';
        --订单是否已支付标识
        HT_INFO_ROW.PAY_IDENTIFY := V_PAY_IDENTIFY;
        --订单组织
        HT_INFO_ROW.ORG_ID := V_ORG_ID;
        --付款方式
        HT_INFO_ROW.DS_PAYMENT_METHOD := TO_NUMBER(BB.NY_PAYMENT_METHOD);
      
        INSERT INTO SPM_CON_HT_INFO VALUES HT_INFO_ROW;
      
        UPDATE SPM_CON_MQ_SM_SALE_ORDER T
           SET T.ATTRIBUTE2 = 'A'
         WHERE T.ORDER_ID = BB.ORDER_ID;
      END IF;
    
      --插入收货人信息
      BEGIN
        HT_RECEIVER_ROW.RECEIVER_ID     := SPM_CON_HT_RECEIVER_SEQ.NEXTVAL;
        HT_RECEIVER_ROW.CONTRACT_ID     := V_CONTRACT_ID;
        HT_RECEIVER_ROW.RECEIVE_USER    := BB.CONSIGNEE_NAME;
        HT_RECEIVER_ROW.RECEIVE_ORG     := BB.CONSIGNEE_ORG_NAME;
        HT_RECEIVER_ROW.RECEIVE_TEL     := BB.CONSIGNEE_MOBILE;
        HT_RECEIVER_ROW.RECEIVE_ADDRESS := BB.CONSIGNEE_ADDRESS;
        HT_RECEIVER_ROW.ATTRIBUTE1      := 'DSXS';
      
        INSERT INTO SPM_CON_HT_RECEIVER VALUES HT_RECEIVER_ROW;
      
        UPDATE SPM_CON_MQ_SM_SALE_ORDER T
           SET T.ATTRIBUTE2 = 'A'
         WHERE T.ORDER_ID = BB.ORDER_ID;
      EXCEPTION
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('收货人信息插入报错');
      END;
    
      --插入开票信息
      IF NVL(BB.ATTRIBUTE3, 0) <> 'A' THEN
        --开票信息主键
        HT_INVOICE_ROW.INVOICE_ID := SPM_CON_HT_INVOICE_SEQ.NEXTVAL;
        --合同主键
        HT_INVOICE_ROW.CONTRACT_ID := V_CONTRACT_ID;
        --开票银行
        HT_INVOICE_ROW.INVOICE_BANK := BB.BILLING_BANK;
        --开票账号
        HT_INVOICE_ROW.INVOICE_ACCOUNT := BB.BILLING_ACCOUNT;
        --开票税号
        HT_INVOICE_ROW.INVOICE_RATE_NUMBER := BB.BILLING_NUMBER;
        --开票电话
        HT_INVOICE_ROW.INVOICE_TEL := BB.BILLING_PHONE;
        --开票联系人
        HT_INVOICE_ROW.INVOICE_USER := '开票联系人';
        --发票类型？
        HT_INVOICE_ROW.INVOICE_TYPE := '01';
        --开票地址
        HT_INVOICE_ROW.INVOICE_ADDRESS := BB.BILLING_ADDRESS;
        --发票备注
        HT_INVOICE_ROW.REMARK := '备注';
        --组织ORGID
        HT_INVOICE_ROW.ORG_ID := V_ORG_ID;
        --创建时间
        HT_INVOICE_ROW.CREATION_DATE := SYSDATE;
        --电商导入标识
        HT_INVOICE_ROW.ATTRIBUTE1 := 'DSXS';
      
        INSERT INTO SPM_CON_HT_INVOICE VALUES HT_INVOICE_ROW;
      
        UPDATE SPM_CON_MQ_SM_SALE_ORDER T
           SET T.ATTRIBUTE3 = 'A'
         WHERE T.ORDER_ID = BB.ORDER_ID;
      
      END IF;
    
      --关联客户
      SELECT COUNT(*)
        INTO V_HT_MERCHANTS_COUNT
        FROM SPM_CON_HT_MERCHANTS T
       WHERE T.CONTRACT_ID = V_CONTRACT_ID;
    
      --查询客户状态，如果不等于1-5，则返回值为CUSTID客户ID
      SELECT TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS(TO_CHAR(BB.ASSIGN_PURORG_ID),
                                                          V_ORG_ID))
        INTO V_1
        FROM DUAL;
    
      IF V_1 = -1 THEN
        MSG_B := '电商未推送该客户或推送信息不完整 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -2 THEN
        MSG_B := '电商已经推送该客户，还未进入业财系统 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -3 THEN
        MSG_B := '客户未完成审批 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -4 THEN
        MSG_B := '客户未同步 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 = -5 THEN
        MSG_B := '查找客户异常，请联系系统管理员 ';
        UPDATE SPM_CON_HT_INFO T
           SET T.ERROR_MSG = MSG_A || MSG_B
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
      END IF;
    
      IF V_1 > 0 THEN
      
        --关联项目
        SELECT COUNT(*)
          INTO V_PROJECT_COUNT
          FROM SPM_CON_HT_PROJECT T
         WHERE T.CONTRACT_ID = V_CONTRACT_ID;
        IF V_PROJECT_COUNT = 0 AND NVL(BB.ATTRIBUTE4, 0) <> 'A' THEN
        
          --查询框架的项目
          BEGIN
            SELECT COUNT(*)
              INTO PROJECT_COUNT
              FROM SPM_CON_HT_INFO      S,
                   SPM_CON_HT_PROJECT   T,
                   SPM_CON_PROJECT      D,
                   SPM_CON_CUST_INFO    E,
                   SPM_CON_HT_MERCHANTS A
             WHERE 1 = 1
                  
               AND S.CONTRACT_ID = T.CONTRACT_ID
               AND T.PROJECT_ID = D.PROJECT_ID
               AND S.CONTRACT_ID = A.CONTRACT_ID
               AND E.CUST_ID = A.MERCHANTS_ID
               AND (SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y' OR
                   SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_KJXY(S.CONTRACT_ID) = 'Y')
               AND S.CONTRACT_FORM = '4'
               AND S.IN_OUT_TYPE = '1'
               AND S.ORG_ID = HT_INFO_ROW.ORG_ID
               AND S.START_DATE <= trunc(HT_INFO_ROW.CREATION_DATE,'dd')
               AND S.END_DATE >= trunc(HT_INFO_ROW.CREATION_DATE,'dd')
               AND E.CUST_ID = V_1;
          
            IF PROJECT_COUNT = 0 THEN
              MSG_C := '未找到对应的框架合同 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A || MSG_B || MSG_C
               WHERE T.CONTRACT_ID = V_CONTRACT_ID;
            END IF;
          
            IF PROJECT_COUNT > 1 THEN
              MSG_C := '找到多条可匹配的框架，请手动选择确认要关联的框架 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A || MSG_B || MSG_C
               WHERE T.CONTRACT_ID = V_CONTRACT_ID;
            END IF;
          
            IF PROJECT_COUNT = 1 THEN
              SELECT MAX(D.PROJECT_ID),
                     MAX(S.DEPT_ID),
                     MAX(S.CREATED_BY),
                     MAX(S.CONTRACT_ID)
                INTO V_PROJECT_ID, V_DEPT_ID, V_CREATED_BY, KJ_HT_ID
                FROM SPM_CON_HT_INFO      S,
                     SPM_CON_HT_PROJECT   T,
                     SPM_CON_PROJECT      D,
                     SPM_CON_CUST_INFO    E,
                     SPM_CON_HT_MERCHANTS A
               WHERE 1 = 1
                    
                 AND S.CONTRACT_ID = T.CONTRACT_ID
                 AND T.PROJECT_ID = D.PROJECT_ID
                 AND S.CONTRACT_ID = A.CONTRACT_ID
                 AND E.CUST_ID = A.MERCHANTS_ID
                 AND (SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y' OR
                     SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_KJXY(S.CONTRACT_ID) = 'Y')
                 AND S.CONTRACT_FORM = '4'
                 AND S.IN_OUT_TYPE = '1'
                 AND S.ORG_ID = V_ORG_ID
                 AND E.CUST_ID = V_1;
            END IF;
          END;
          --主键
          IF PROJECT_COUNT = 1 THEN
          
            --关联项目
            HT_PROJECT_ROW.CON_PRO_RELATION_ID := SPM_CON_HT_PROJECT_SEQ.NEXTVAL;
            --合同主键
            HT_PROJECT_ROW.CONTRACT_ID := V_CONTRACT_ID;
            --关联项目ID
            HT_PROJECT_ROW.PROJECT_ID := V_PROJECT_ID;
            --OU
            HT_PROJECT_ROW.ORG_ID := V_ORG_ID;
            --电商导入标识
            HT_PROJECT_ROW.ATTRIBUTE1 := 'DSXS';
          
            INSERT INTO SPM_CON_HT_PROJECT VALUES HT_PROJECT_ROW;
            COMMIT;
          
            --关联客户 
            -- 主键
            HT_MERCHANTS_ROW.CON_MERCHANTS_ID := SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL;
            --客户/供应商ID
            HT_MERCHANTS_ROW.MERCHANTS_ID := V_1;
            --NUMBER  客户/供应商
            HT_MERCHANTS_ROW.MERCHANTS_FLAG := 1;
            --收支类型
            HT_MERCHANTS_ROW.IN_OUT_TYPE := '1';
            --合同ID
            HT_MERCHANTS_ROW.CONTRACT_ID := V_CONTRACT_ID;
            --电商导入标识
            HT_MERCHANTS_ROW.ATTRIBUTE1 := 'DSXS';
          
            INSERT INTO SPM_CON_HT_MERCHANTS VALUES HT_MERCHANTS_ROW;
            COMMIT;
          
            UPDATE SPM_CON_MQ_SM_SALE_ORDER T
               SET T.ATTRIBUTE5 = 'A'
             WHERE T.ORDER_ID = BB.ORDER_ID;
          
            begin
              select count(*)
                into k_repeat_number
                from spm_con_mq_sm_sale_order_dtl t
               where t.order_id = bb.order_id
                 and t.ny_datang_material_code is not null
               group by t.ny_datang_material_code
              having count(*) > 1;
            exception
              when others then
                k_repeat_number := 0;
            end;
          
            if k_repeat_number = 0 then
            
              UPDATE SPM_CON_HT_INFO T
                 SET T.DEPT_ID    = V_DEPT_ID,
                     T.CREATED_BY = V_CREATED_BY,
                     T.STATUS     = 'E',
                     T.ERROR_MSG  = NULL
               WHERE T.CONTRACT_ID = V_CONTRACT_ID;
            
            else
            
              update spm_con_ht_info f
                 set f.status = 'A', f.error_msg = '存在相同的商品编码'
               where f.contract_id = V_CONTRACT_ID;
            
            end if;
          
            UPDATE SPM_CON_MQ_SM_SALE_ORDER T
               SET T.ATTRIBUTE4 = 'A', T.ATTRIBUTE1 = 'ED'
             WHERE T.ORDER_ID = BB.ORDER_ID;
          END IF;
        
          --关联框架协议 
          IF PROJECT_COUNT = 1 THEN
            INSERT INTO SPM_CON_HT_RELATION T
              (T.RELATION_ID,
               T.CONTRACT_ID,
               T.CONTRACT_ID_R,
               T.RELATION_SHIP,
               T.RELATION_BUSINESS,
               T.RELATION_ACTION,
               ATTRIBUTE1)
            VALUES
              (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
               V_CONTRACT_ID,
               KJ_HT_ID,
               '3',
               '3',
               '2',
               'DS');
          
            INSERT INTO SPM_CON_HT_RELATION T
              (T.RELATION_ID,
               T.CONTRACT_ID,
               T.CONTRACT_ID_R,
               T.RELATION_SHIP,
               T.RELATION_BUSINESS,
               T.RELATION_ACTION,
               ATTRIBUTE1)
            VALUES
              (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
               KJ_HT_ID,
               V_CONTRACT_ID,
               '3',
               '3',
               '1',
               'DS');
          END IF;
        
        END IF;
      
      END IF;
    
      --防止往客户表插入多条数据
      IF V_1 > 0 THEN
        SELECT COUNT(*)
          INTO V_CUST_COUNT
          FROM SPM_CON_BANK_ACOUNT_INFO T
         WHERE T.CUST_ID = V_1
           AND T.BANK_ACOUNT = BB.BILLING_ACCOUNT;
      END IF;
    
      IF V_1 > 0 AND V_CUST_COUNT = 0 AND NVL(BB.SPARE1, 0) <> 'A' THEN
      
        BANK_ACOUNT_INFO_ROW.ACOUNT_ID := SPM_CON_BANK_ACOUNT_INFO_SEQ.NEXTVAL;
        --    客户主键
        BANK_ACOUNT_INFO_ROW.CUST_ID := V_1;
        --    账户
        BANK_ACOUNT_INFO_ROW.BANK_ACOUNT := BB.BILLING_ACCOUNT;
        --开票银行
        BANK_ACOUNT_INFO_ROW.OPENING_BANK := BB.BILLING_BANK;
        --是否为主开户行
        BANK_ACOUNT_INFO_ROW.IS_MAIN := 'Y';
        --账户类型
        BANK_ACOUNT_INFO_ROW.ACOUNT_TYPE := 'BA';
        --电商同步标识
        BANK_ACOUNT_INFO_ROW.ATTRIBUTE2 := '电商';
      
        BANK_ACOUNT_INFO_ROW.CREATION_DATE := SYSDATE;
        --组织
        BANK_ACOUNT_INFO_ROW.ORG_ID := V_ORG_ID;
        --所属类型，1：客户，2：供应商
        BANK_ACOUNT_INFO_ROW.ACOUNT_OWN_TYPE := '1';
      
        INSERT INTO SPM_CON_BANK_ACOUNT_INFO VALUES BANK_ACOUNT_INFO_ROW;
      
        UPDATE SPM_CON_MQ_SM_SALE_ORDER T
           SET T.SPARE1 = 'A'
         WHERE T.ORDER_ID = BB.ORDER_ID;
      
      END IF;
    
      --插入标的物信息
      FOR BBB IN CURHTTARGET(BB.ORDER_ID) LOOP
      
        BEGIN
        
          HT_TARGET_ROW.TARGET_ID   := SPM_CON_HT_TARGET_SEQ.NEXTVAL;
          HT_TARGET_ROW.CONTRACT_ID := V_CONTRACT_ID;
          HT_TARGET_ROW.IS_DELETE   := 0; --是否删除
          --HT_TARGET_ROW.GOODS_CLASS           := '商品小类'; --商品小类
          HT_TARGET_ROW.MATERIAL_CODE         := BBB.NY_DATANG_MATERIAL_CODE; --物料编号
          HT_TARGET_ROW.MATERIAL_NAME         := BBB.WARE_NAME; --物料名称
          HT_TARGET_ROW.TARGET_PARAMS         := BBB.NY_MATERIAL_QUALITY; --商品参数
          HT_TARGET_ROW.SPECIFICATION_MODEL   := BBB.NY_SPECIFICATIONS_SIZE; --规格型号
          HT_TARGET_ROW.SPECIFICATION_PACKING := BBB.NY_FIGURE_NUMBER; --包装规格
          HT_TARGET_ROW.TARGET_UNIT           := BBB.WARE_UNIT; --供货单位
          HT_TARGET_ROW.TARGET_COUNT          := BBB.QUANTITY; --订货数量
          --含税单价
          HT_TARGET_ROW.UNIT_PRICE    := BBB.TAX_PRICE; --电商订单行单价 J
          HT_TARGET_ROW.TARGET_AMOUNT := BBB.QUANTITY * BBB.TAX_PRICE; --订货金额
        
          --将税率修改为直接从NY_RATE字段中获取
          HT_TARGET_ROW.TAX_RATE := BBB.NY_RATE;
          --不含税金额
          HT_TARGET_ROW.NOTAX_AMOUNT := ROUND(HT_TARGET_ROW.TARGET_AMOUNT /
                                              (1 + 0.01 * BBB.NY_RATE),
                                              2);
          --税额
          HT_TARGET_ROW.TAX_AMOUNT := HT_TARGET_ROW.TARGET_AMOUNT -
                                      HT_TARGET_ROW.NOTAX_AMOUNT;
        
          HT_TARGET_ROW.REMARK     := '备注'; --备注          
          HT_TARGET_ROW.ORG_ID     := V_ORG_ID;
          HT_TARGET_ROW.ATTRIBUTE1 := 'DSCG'; --电商导入标识
          HT_TARGET_ROW.SKU_VALUE  := BBB.WARE_CODE;
          INSERT INTO SPM_CON_HT_TARGET VALUES HT_TARGET_ROW;
          
          update spm_con_mq_sm_sale_order_dtl t
             set t.attribute1 = 'A'
           where t.detail_id = bbb.detail_id;
        
          --物料编码生成流水码
        
          IF BBB.NY_DATANG_MATERIAL_CODE IS NULL THEN
            NEW_CODE := SPM_CON_HT_PKG.GET_TARGET_CODE(V_CONTRACT_ID);
            UPDATE SPM_CON_HT_TARGET T
               SET T.MATERIAL_CODE = NEW_CODE, T.CODE_TYPE = '流水码'
            
             WHERE T.TARGET_ID = HT_TARGET_ROW.TARGET_ID;
          
          END IF;
        
          UPDATE SPM_CON_HT_INFO H
             SET H.TAX_RATE = BBB.NY_RATE
           WHERE H.CONTRACT_ID = V_CONTRACT_ID;
        
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(BBB.NY_DATANG_MATERIAL_CODE || '物料插入报错');
            --继续其他物料的插入
            CONTINUE;
        END;
      
      END LOOP;
    
    END LOOP;
  END DSSM_TO_SALE_ORDER;

  --AUTO生成入库单第一版
  PROCEDURE AUTO_WAREHOUSE_BY_DHD(P_MSG OUT VARCHAR2) IS
    V_ID             NUMBER;
    V_1              NUMBER;
    V_2              NUMBER;
    V_CONTRACT_ID    NUMBER;
    V_SERIAL_NUMBER  VARCHAR2(2000);
    V_STRING         VARCHAR2(2000);
    MSG              VARCHAR2(2000);
    MSG_B            VARCHAR2(2000);
    V_DL_ID          NUMBER;
    MSG_T            VARCHAR2(2000);
    EBS_WAREHOUSE_ID NUMBER;
    V_EXCEPTION EXCEPTION;
    V_WAREHOUSE_ID    NUMBER;
    V_WAREHOUSE_DL_ID NUMBER;
    HAS_CONTRACT      NUMBER;
    HAS_CONTRACT1     NUMBER;
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    CONTRACT_CODE_4   VARCHAR2(2000);
    V_MQ_ID           NUMBER;
    HT_PRICE          NUMBER;
    HT_TAXPRICE       NUMBER;
    HT_TAX_RATE       NUMBER;
    HT_MATERIAL_CODE  VARCHAR2(200);
    UNIT_PRICE1       NUMBER;
    MSG_MATERIAL      VARCHAR2(200);
    MSG_ORDER         VARCHAR2(200);
  
    --1.去找到所有的头信息，通过到货单去找
    CURSOR CURORDER IS
      SELECT MAX(T.ARRIVE_ORDER_CODE) AS ARRIVE_ORDER_CODE,
             MAX(T.MQ_ID) AS MQ_ID,
             MAX(F.ORG_ID) AS ORG_ID,
             MAX(F.DEPT_ID) AS DEPT_ID,
             MAX(F.CREATED_BY) AS CREATED_BY,
             S.SALE_ORDER_CODE_DL AS SALE_ORDER_CODE_DL,
             MAX(F.CONTRACT_ID) CONTRACT_ID,
             MAX(F.CONTRACT_NAME) CONTRACT_NAME,
             MAX(F.CONTRACT_CODE) CONTRACT_CODE,
             (SELECT AA.PROJECT_ID
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_ID,
             
             (SELECT AA.PROJECT_NAME
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_NAME,
             
             (SELECT AA.PROJECT_CODE
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_CODE,
             
             (SELECT AA.VENDOR_ID
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_ID,
             (SELECT AA.VENDOR_NAME
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_NAME,
             (SELECT AA.VENDOR_CODE
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_CODE
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL     T,
             SPM_CON_MQ_GOODS_ARRIVAL_DTL S,
             SPM_CON_HT_INFO              F
       WHERE T.MQ_ID = S.ID
         AND F.CONTRACT_NAME = S.SALE_ORDER_CODE_DL
            --AND T.MQ_ID=V_ID
         AND T.ARRIVE_ORDER_CODE NOT IN
             (SELECT NVL(FF.THEIR_DEPARTMENT, 0) FROM SPM_CON_WAREHOUSE FF)
         AND NVL(T.ATTRIBUTE1, 0) <> 'ED'
            --AND T.ARRIVE_ORDER_CODE='O-CX-18-00001108-DHD001'
         AND SPM_SSO_PKG.GETORGID =
             (SELECT F.ORG_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_NAME = S.SALE_ORDER_CODE_DL)
       GROUP BY S.SALE_ORDER_CODE_DL;
  
    CURSOR CURHTTARGET(V_AAA NUMBER) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.MQ_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.ID ID,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.TAX_PRICE UNIT_PRICE,
             S.PRICE UNIT_PRICE1,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             S.SKU_VALUE,
             (SELECT ROUND((S.TAX_PRICE - S.PRICE) / S.PRICE, 2) * 100
                FROM DUAL) TAX_RATE,
             
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
       WHERE 1 = 1
         AND S.ID = V_AAA;
  BEGIN
  
    --第一层循环  通过合同ID去生成入库单主信息
    FOR CC IN CURORDER LOOP
    
      SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                            'SPM_CON_WAREHOUSE',
                                                            'WAREHOUSE_CODE',
                                                            'FM00000')
        INTO V_SERIAL_NUMBER
        FROM DUAL;
    
      SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL INTO V_WAREHOUSE_ID FROM DUAL;
      INSERT INTO SPM_CON_WAREHOUSE
        (WAREHOUSE_ID, --主键
         CONTRACT_ID, --合同ID
         CONTRACT_NAME, --合同名称
         CONTRACT_CODE, --合同编号
         PROJECT_ID,
         PROJECT_NAME,
         PROJECT_CODE,
         VENDOR_ID, --供应商
         VENDOR_NAME,
         VENDOR_POSITION, --供应商地点
         MATERIAL_ORIGIN, --物资来源1
         MATERIAL_TYPE, --材料类别2
         TRANSPORT_TYPE, --运输方式3
         BUY_TYPE, --采购方式4
         WAREHOUSE_GRNI, --是否暂估5
         WAREHOUSE_DATE,
         CREATION_DATE, --创建日期
         DEPT_ID, --部门
         ORG_ID, --组织
         CREATED_BY,
         WAREHOUSE_CODE,
         ATTRIBUTE5,
         STATUS,
         THEIR_DEPARTMENT
         
         )
      VALUES
        (V_WAREHOUSE_ID,
         CC.CONTRACT_ID,
         CC.CONTRACT_NAME,
         CC.CONTRACT_CODE,
         CC.PROJECT_ID,
         CC.PROJECT_NAME,
         CC.PROJECT_CODE,
         CC.VENDOR_ID,
         CC.VENDOR_NAME,
         (SELECT T.VENDOR_SITE_ID
            FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
           WHERE SPM_SSO_PKG.GETORGID() = T.ORG_ID
             AND T.VENDOR_ID = PP.VENDOR_ID
             AND PP.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND PP.SEGMENT1 = CC.VENDOR_CODE
             AND T.VENDOR_SITE_CODE = '商品暂估'
             AND T.ORG_ID = SPM_SSO_PKG.GETORGID),
         'A', --物资来源1
         '1', --材料类别2
         'A', --运输方式3
         'A', --采购方式4
         'B', --是否暂估5
         SYSDATE,
         SYSDATE,
         CC.DEPT_ID,
         CC.ORG_ID,
         CC.CREATED_BY,
         V_SERIAL_NUMBER,
         'N',
         'A',
         CC.ARRIVE_ORDER_CODE);
      UPDATE SPM_CON_MQ_GOODS_ARRIVAL T
         SET T.ATTRIBUTE1 = 'ED'
       WHERE T.MQ_ID = CC.MQ_ID;
      COMMIT;
    
      FOR CCC IN CURHTTARGET(CC.MQ_ID) LOOP
        BEGIN
          SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
            INTO V_WAREHOUSE_DL_ID
            FROM DUAL;
          DBMS_OUTPUT.PUT_LINE(CCC.MATERIAL_NAME);
          SELECT T.TAX_RATE,
                 T.UNIT_PRICE,
                 T.MATERIAL_CODE,
                 (T.UNIT_PRICE / (1 + T.TAX_RATE * 0.01))
            INTO HT_TAX_RATE, HT_TAXPRICE, HT_MATERIAL_CODE, UNIT_PRICE1
            FROM SPM_CON_HT_TARGET T
           WHERE --T.MATERIAL_NAME = CCC.MATERIAL_NAME
           T.SKU_VALUE = CCC.SKU_VALUE
           AND T.CONTRACT_ID = CC.CONTRACT_ID;
        
          INSERT INTO SPM_CON_WAREHOUSE_DL
            (WAREHOUSE_DL_ID, --主键
             WAREHOUSE_ID, --外键,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             DELIVERY_CARGO, --物料名称
             STORE_ROOM_NAME, --仓库
             GOODS_POSITION_NAME, --货位
             PURCHASE_AMOUNT, --总数量
             THIS_WAREHOUSE_NUMBER, --本次入库数量
             UNIT, --单位
             WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
             MONEY_AMOUNT, --金额(不含增值税)
             TAX_RATE, --税率
             TAX_AMOUNT, --进项税,
             TAX_UNIT_PRICE, --含税单价
             TAX_AMOUNT_COUNT, --价税合计
             DEPT_ID, --部门ID
             ORG_ID,
             CON_TARGET_ID,
             STORE_ROOM, --仓库
             GOODS_POSITION, --货位
             ATTRIBUTE2,
             ATTRIBUTE3)
          VALUES
            (V_WAREHOUSE_DL_ID,
             V_WAREHOUSE_ID,
             (SELECT T.CONTRACT_ID
                FROM SPM_CON_HT_INFO T
               WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
             HT_MATERIAL_CODE,
             CCC.MATERIAL_NAME,
             (SELECT DISTINCT I.DESCRIPTION
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                        'NAME')
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             CCC.TARGET_COUNT, --合同数量
             CCC.THIS_WAREHOUSE_NUMBER, --本次入库数量
             CCC.TARGET_UNIT, --单位
             UNIT_PRICE1, --不含税单价
             CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1, ----金额(不含增值税)
             CCC.TAX_RATE,
             UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
             UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
             CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
             CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1, --价税合计
             CC.CREATED_BY, --(SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.USER_ID=SPM_SSO_PKG.GETUSERID AND T.BELONGORGID=SPM_SSO_PKG.GETORGID ),
             CC.ORG_ID, --SPM_SSO_PKG.GETORGID,
             CCC.ID,
             (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             'DS',
             CCC.SKU_VALUE);
        END;
        COMMIT;
      
        UPDATE SPM_CON_WAREHOUSE AA
           SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                                I.WAREHOUSE_UNIT_PRICE,
                                                                2))
                                                 FROM SPM_CON_WAREHOUSE_DL I
                                                WHERE I.WAREHOUSE_ID =
                                                      AA.WAREHOUSE_ID),
                                               0)
         WHERE AA.WAREHOUSE_ID = V_WAREHOUSE_ID;
      
      END LOOP;
      BEGIN
        CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO_BY_ORDER(V_WAREHOUSE_ID,
                                                           MSG_MATERIAL);
        CUX_SPM_DATA_PO_PKG.IMPORT_ORDER_INFO(V_WAREHOUSE_ID, MSG_ORDER);
      
      END;
    END LOOP;
  
    MSG_B := MSG_B || '所选的采购订单已成功生成入库单';
    P_MSG := MSG_B || ',' || MSG_T;
  
  END;

  --根据入库单生成出库单自动版本
  PROCEDURE AUTO_CREATE_ODO_BY_WAREHOUSE(P_MSG OUT VARCHAR2) IS
    V_ID                 NUMBER;
    V_1                  NUMBER;
    V_2                  NUMBER;
    V_CONTRACT_ID        NUMBER;
    V_SERIAL_NUMBER      VARCHAR2(2000);
    V_STRING             VARCHAR2(2000);
    MSG                  VARCHAR2(2000);
    MSG_B                VARCHAR2(2000);
    V_DL_ID              NUMBER;
    V_ODO_ID             NUMBER;
    HT_PRICE             NUMBER;
    HT_TAXPRICE          NUMBER;
    HT_TAX_RATE          NUMBER;
    HT_MATERIAL_CODE     VARCHAR2(200);
    UNIT_PRICE1          NUMBER;
    HT_TARGET_UNIT_PRICE NUMBER;
    MSG_ZXCK             VARCHAR2(200);
    V_DEPT_ID            NUMBER(15);
  
    --1.去找到所有的头信息
    CURSOR CURORDER IS
    
      SELECT T.WAREHOUSE_CODE,
             T.CREATED_BY,
             T.ORG_ID,
             T.DEPT_ID,
             T.THEIR_DEPARTMENT,
             T.WAREHOUSE_ID,
             T.CONTRACT_ID,
             T.CONTRACT_NAME,
             T.CONTRACT_CODE,
             S.CONTRACT_CODE    AS CONTRACT_CODE1,
             S.CONTRACT_ID      AS CONTRACT_ID1,
             S.CONTRACT_NAME    AS CONTRACT_NAME1,
             A.PROJECT_ID,
             A.PROJECT_NAME,
             A.PROJECT_CODE,
             C.CUST_ID,
             C.CUST_NAME,
             T.EBS_PRODUCE
        FROM SPM_CON_WAREHOUSE    T,
             SPM_CON_HT_INFO      F, --采购订单合同
             SPM_CON_HT_INFO      S, --销售订单合同
             SPM_CON_HT_PROJECT   P,
             SPM_CON_PROJECT      A,
             SPM_CON_HT_MERCHANTS M,
             SPM_CON_CUST_INFO    C
       WHERE F.CONTRACT_ID = T.CONTRACT_ID
         AND T.ORG_ID = SPM_SSO_PKG.GETORGID
         AND (S.CONTRACT_CODE || '-1') = F.CONTRACT_CODE
         AND S.CONTRACT_ID = P.CONTRACT_ID
         AND P.PROJECT_ID = A.PROJECT_ID
         AND S.CONTRACT_ID = M.CONTRACT_ID
         AND M.MERCHANTS_ID = C.CUST_ID
         AND F.CONTRACT_TYPE = '2'
         AND T.WAREHOUSE_ID = 1008675
         AND NVL(T.THEIR_DEPARTMENT, 'A') NOT IN
             (SELECT NVL(FF.THEIR_DEPARTMENT, 0) FROM SPM_CON_ODO FF);
  
    CURSOR CURHTTARGET(V_CONTRACT_ID NUMBER) IS
    
      SELECT *
        FROM SPM_CON_WAREHOUSE_DL T
       WHERE T.WAREHOUSE_ID = V_CONTRACT_ID;
  
  BEGIN
  
    --第一层循环  通过合同ID去生成入库单主信息
    FOR CC IN CURORDER LOOP
    
      --出库单插入START
      --获取流水号
      SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_ODO',
                                                            'SPM_CON_ODO',
                                                            'ODO_CODE',
                                                            'FM00000')
        INTO V_SERIAL_NUMBER
        FROM DUAL;
    
      SELECT SPM_CON_ODO_SEQ.NEXTVAL INTO V_ODO_ID FROM DUAL;
      INSERT INTO SPM_CON_ODO
        (ODO_ID, --主键
         CONTRACT_ID, --合同ID
         CONTRACT_NAME, --合同名称
         CONTRACT_CODE, --合同编号
         PROJECT_ID,
         PROJECT_NAME,
         PROJECT_CODE,
         CUST_ID, --客户
         CUSTOMER,
         MATERIAL_TYPE, --材料类别2
         ODO_GRNI, --是否暂估5
         ODO_DATE,
         CREATION_DATE, --创建日期
         DEPT_ID, --部门
         ORG_ID, --组织
         CREATED_BY,
         ODO_CODE,
         ATTRIBUTE5,
         STATUS,
         LAST_UPDATE_DATE,
         THEIR_DEPARTMENT,
         EBS_PRODUCE)
      VALUES
        (V_ODO_ID,
         CC.CONTRACT_ID1, --合同ID
         CC.CONTRACT_NAME1, --合同名称
         CC.CONTRACT_CODE1, --合同编号
         CC.PROJECT_ID,
         CC.PROJECT_NAME,
         CC.PROJECT_CODE,
         CC.CUST_ID, --客户
         CC.CUST_NAME,
         'A', --材料类别
         'B', --是否暂估
         SYSDATE,
         SYSDATE,
         CC.DEPT_ID,
         CC.ORG_ID,
         CC.CREATED_BY,
         V_SERIAL_NUMBER, --出库单号
         'N',
         'A',
         SYSDATE,
         NVL(CC.THEIR_DEPARTMENT, 0),
         CC.EBS_PRODUCE
         );
    
      COMMIT;
      --出库单插入END
    
      --第二个循环开启 去寻找所有入库单行信息
      FOR CCC IN CURHTTARGET(CC.WAREHOUSE_ID) LOOP
        SELECT SPM_CON_ODO_DL_SEQ.NEXTVAL INTO V_DL_ID FROM DUAL;
      
        SELECT T.UNIT_PRICE, T.TAX_RATE
          INTO HT_TARGET_UNIT_PRICE, HT_TAX_RATE
          FROM SPM_CON_HT_TARGET T
         WHERE T.CONTRACT_ID = CC.CONTRACT_ID1
           AND T.SKU_VALUE = CCC.ATTRIBUTE3;
        --插入出库单行信息START
        INSERT INTO SPM_CON_ODO_DL
          (SPM_CON_ODO_DL_ID, --主键
           ODO_ID,
           CONTRACT_ID,
           MATERIAL_CODE, --物资编码
           MATERIAL_NAME, --物料名称
           TARGET_ID,
           STORE_ROOM, --仓库
           STORE_ROOM_PATH, --仓库
           GOODS_LOCATION, --货位
           GOODS_LOCATION_PATH, --货位
           TARGET_COUNT, --合同数量
           UNIT, --单位
           THIS_ODO_NUMBER,
           ODO_UNIT_PRICE, --出库成本单价
           TAX_ODO_UNIT_PRICE, --销售单价
           TAX_RATE, --税率
           TARGET_AMOUNT, --出库成本金额
           TAX_AMOUNT, --销项税
           TAX_AMOUNT_COUNT, --价税合计
           CREATION_DATE,
           ATTRIBUTE1,
           DEPT_ID, --部门ID
           ORG_ID,
           CREATED_BY)
        VALUES
          (V_DL_ID,
           V_ODO_ID,
           CC.CONTRACT_ID1,
           CCC.MATERIAL_CODE,
           CCC.DELIVERY_CARGO,
           CCC.CON_TARGET_ID,
           CCC.STORE_ROOM,
           CCC.STORE_ROOM_NAME,
           CCC.GOODS_POSITION,
           CCC.GOODS_POSITION_NAME,
           CCC.PURCHASE_AMOUNT, --合同数量
           CCC.UNIT, --单位
           CCC.THIS_WAREHOUSE_NUMBER, --出库数量
           CCC.WAREHOUSE_UNIT_PRICE, --出库成本单价
           HT_TARGET_UNIT_PRICE, --销售单价
           HT_TAX_RATE,
           CCC.THIS_WAREHOUSE_NUMBER * CCC.WAREHOUSE_UNIT_PRICE, --出库成本金额
           (HT_TARGET_UNIT_PRICE / (1 + HT_TAX_RATE * 0.01) * HT_TAX_RATE *
           CCC.THIS_WAREHOUSE_NUMBER * 0.01),
           CCC.THIS_WAREHOUSE_NUMBER * HT_TARGET_UNIT_PRICE, --价税合计
           SYSDATE,
           '1',
           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY);
      
      --插入出库单行信息END
      
      END LOOP;
      --杂项出库
      --CUX_SPM_DATA_PO_PKG.IMPORT_ZX_INFO(V_ODO_ID,MSG_ZXCK);
      UPDATE SPM_CON_ODO AA
         SET AA.ODO_MONEY_AMOUNT =
             (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                    FROM SPM_CON_ODO_DL I
                   WHERE I.ODO_ID = AA.ODO_ID),
                  0))
       WHERE AA.ODO_ID = V_ODO_ID;
      --插入出库单行信息END
    
    END LOOP;
    --杂项出库
    --CUX_SPM_DATA_PO_PKG.IMPORT_ZX_INFO(V_ODO_ID,MSG_ZXCK);
  
    MSG_B := MSG_B || '订单已成功生成出库单';
    P_MSG := MSG_B;
  END;

  PROCEDURE DSSM_TO_GOODS_ARRIVAL(P_MSG OUT VARCHAR2) IS
  
    V_ID              NUMBER;
    V_AAA             NUMBER;
    V_WAREHOUSE_DL_ID NUMBER;
    V_1               NUMBER;
    V_2               NUMBER;
    V_3               NUMBER;
    V_4               NUMBER;
    V_5               NUMBER;
    V_6               NUMBER;
    HAS_CONTRACT      NUMBER;
    HAS_CONTRACT1     NUMBER;
    V_COUNT           NUMBER;
    V_SERIAL_NUMBER   VARCHAR2(2000);
    V_CONTRACT_ID     NUMBER;
    V_WAREHOUSE_ID    NUMBER;
    VALIDATE1         VARCHAR2(2000);
    MSG_T             VARCHAR2(2000);
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    CONTRACT_CODE_4   VARCHAR2(2000);
  
    --所有的中间表中的主表信息
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_MQ_GOODS_ARRIVAL T
       WHERE 1 = 1
         AND NVL(T.ATTRIBUTE1, 0) <> '已处理';
    --AND T.MQ_ID=11111111;
  
    /*      CURSOR CURGOODSARRIVALDTL(V_AAA NUMBER) IS
         SELECT MAX(S.ARRIVE_ORDER_ID) TARGET_ID,
         MAX(S.ORDER_CODE_DL) ORDER_CODE_DL,
         MAX(S.SALE_ORDER_CODE_DL) SALE_ORDER_CODE_DL,
         MAX(S.ID) ID,
          MAX(S.MQ_ID) CONTRACT_ID,
          MAX(S.MATERIAL_CODE) MATERIAL_CODE,
          MAX(S.MATERIAL_NAME) MATERIAL_NAME,
          MAX(S.TAX_PRICE) UNIT_PRICE,
          MAX(S.PRICE)  UNIT_PRICE1,
          SUM(S.PURNUM) TARGET_COUNT,
          MAX(S.UNIT) TARGET_UNIT,
          MAX((SELECT ROUND((S.TAX_PRICE-S.PRICE)/S.PRICE,2) FROM DUAL)) TAX_RATE,
    
          MAX(S.SIGN_NUM) THIS_WAREHOUSE_NUMBER
    
     FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
    WHERE 1 = 1
      AND   S.ARRIVE_ORDER_ID=V_AAA
      GROUP BY S.MATERIAL_CODE;
      */
  
    CURSOR CURGOODSARRIVALDTL(V_AAA NUMBER) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.ID ID,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.TAX_PRICE UNIT_PRICE,
             S.PRICE UNIT_PRICE1,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             (SELECT ROUND((S.TAX_PRICE - S.PRICE) / S.PRICE, 2) * 100
                FROM DUAL) TAX_RATE,
             
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
       WHERE 1 = 1
         AND S.ID = V_AAA;
  
  BEGIN
    FOR BB IN CUR LOOP
      --插入入库单行信息
      FOR CCC IN CURGOODSARRIVALDTL(BB.MQ_ID) LOOP
      
        --插入入库单主表信息
        SELECT COUNT(*)
          INTO V_COUNT
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL;
      
        IF V_COUNT > 0 THEN
          SELECT T.CONTRACT_ID
            INTO V_CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL;
          SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                                'SPM_CON_WAREHOUSE',
                                                                'WAREHOUSE_CODE',
                                                                'FM00000')
            INTO V_SERIAL_NUMBER
            FROM DUAL;
        
          SELECT COUNT(*)
            INTO V_6
            FROM SPM_CON_WAREHOUSE T
           WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          IF V_6 = 0 THEN
            SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL
              INTO V_WAREHOUSE_ID
              FROM DUAL;
            INSERT INTO SPM_CON_WAREHOUSE
              (WAREHOUSE_ID, --主键
               CONTRACT_ID, --合同ID
               CONTRACT_NAME, --合同名称
               CONTRACT_CODE, --合同编号
               PROJECT_ID,
               PROJECT_NAME,
               PROJECT_CODE,
               VENDOR_ID, --供应商
               VENDOR_NAME,
               VENDOR_POSITION, --供应商地点
               MATERIAL_ORIGIN, --物资来源1
               MATERIAL_TYPE, --材料类别2
               TRANSPORT_TYPE, --运输方式3
               BUY_TYPE, --采购方式4
               WAREHOUSE_GRNI, --是否暂估5
               WAREHOUSE_DATE,
               CREATION_DATE, --创建日期
               DEPT_ID, --部门
               ORG_ID, --组织
               CREATED_BY,
               WAREHOUSE_CODE,
               ATTRIBUTE5,
               STATUS,
               ATTRIBUTE1)
            VALUES
              (V_WAREHOUSE_ID,
               (SELECT T.CONTRACT_ID
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.CONTRACT_NAME
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.CONTRACT_CODE
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.PROJECT_ID
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.PROJECT_NAME
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.PROJECT_CODE
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_ID
                  FROM SPM_CON_VENDOR_INFO T
                 WHERE T.VENDOR_ID =
                       (SELECT F.MERCHANTS_ID
                          FROM SPM_CON_HT_MERCHANTS F
                         WHERE F.CONTRACT_ID =
                               (SELECT DD.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO DD
                                 WHERE DD.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_NAME
                  FROM SPM_CON_VENDOR_INFO T
                 WHERE T.VENDOR_ID =
                       (SELECT F.MERCHANTS_ID
                          FROM SPM_CON_HT_MERCHANTS F
                         WHERE F.CONTRACT_ID =
                               (SELECT DD.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO DD
                                 WHERE DD.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_SITE_ID
                  FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
                 WHERE (SELECT T.ORG_ID
                          FROM SPM_CON_HT_INFO T
                         WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL) =
                       T.ORG_ID
                   AND T.VENDOR_ID = PP.VENDOR_ID
                   AND PP.ENABLED_FLAG = 'Y'
                   AND T.PURCHASING_SITE_FLAG = 'Y'
                   AND T.PAY_SITE_FLAG = 'Y'
                   AND PP.SEGMENT1 =
                       (SELECT T.VENDOR_CODE
                          FROM SPM_CON_VENDOR_INFO T
                         WHERE T.VENDOR_ID =
                               (SELECT F.MERCHANTS_ID
                                  FROM SPM_CON_HT_MERCHANTS F
                                 WHERE F.CONTRACT_ID =
                                       (SELECT DD.CONTRACT_ID
                                          FROM SPM_CON_HT_INFO DD
                                         WHERE DD.CONTRACT_CODE =
                                               CCC.SALE_ORDER_CODE_DL)))
                   AND T.VENDOR_SITE_CODE = '商品采购'
                
                ),
               'A', --物资来源1
               '1', --材料类别2
               'A', --运输方式3
               'A', --采购方式4
               'B', --是否暂估5
               SYSDATE,
               SYSDATE,
               303,
               89,
               1856,
               V_SERIAL_NUMBER,
               'N',
               'A',
               'DS');
            COMMIT;
          END IF;
        
          SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
            INTO V_WAREHOUSE_DL_ID
            FROM DUAL;
        
          INSERT INTO SPM_CON_WAREHOUSE_DL
            (WAREHOUSE_DL_ID, --主键
             WAREHOUSE_ID, --外键,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             DELIVERY_CARGO, --物料名称
             STORE_ROOM_NAME, --仓库
             GOODS_POSITION_NAME, --货位
             PURCHASE_AMOUNT, --总数量
             THIS_WAREHOUSE_NUMBER, --本次入库数量
             UNIT, --单位
             WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
             MONEY_AMOUNT, --金额(不含增值税)
             TAX_RATE, --税率
             TAX_AMOUNT, --进项税,
             TAX_UNIT_PRICE, --含税单价
             TAX_AMOUNT_COUNT, --价税合计
             DEPT_ID, --部门ID
             ORG_ID,
             CON_TARGET_ID,
             STORE_ROOM, --仓库
             GOODS_POSITION, --货位
             ATTRIBUTE2)
          VALUES
            (V_WAREHOUSE_DL_ID,
             V_WAREHOUSE_ID,
             (SELECT T.CONTRACT_ID
                FROM SPM_CON_HT_INFO T
               WHERE T.CONTRACT_CODE = CCC.ORDER_CODE_DL),
             CCC.MATERIAL_CODE,
             CCC.MATERIAL_NAME,
             (SELECT DISTINCT I.DESCRIPTION
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                        'NAME')
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             CCC.TARGET_COUNT, --合同数量
             CCC.THIS_WAREHOUSE_NUMBER, --本次入库数量
             CCC.TARGET_UNIT, --单位
             CCC.UNIT_PRICE1, --不含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, ----金额(不含增值税)
             CCC.TAX_RATE,
             CCC.UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
             CCC.UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, --价税合计
             303, --(SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.USER_ID=SPM_SSO_PKG.GETUSERID AND T.BELONGORGID=SPM_SSO_PKG.GETORGID ),
             89, --SPM_SSO_PKG.GETORGID,
             CCC.ID,
             (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             'DS');
          COMMIT;
        
          --
        
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                 'CWEME'
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          --物料编码如果为空 则按规则生成
          IF CCC.MATERIAL_CODE IS NULL THEN
          
            SELECT COUNT(*)
              INTO HAS_CONTRACT
              FROM SPM_CON_HT_TARGET O
             WHERE O.CONTRACT_ID = V_CONTRACT_ID
               AND O.CODE_TYPE = '流水码';
            SELECT COUNT(*)
              INTO HAS_CONTRACT1
              FROM SPM_CON_WAREHOUSE_DL O
             WHERE O.CONTRACT_ID = V_CONTRACT_ID
               AND O.ATTRIBUTE2 = '流水码';
            --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
          
            --合同中未导入物料编码 第一条数据
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '0001',
                     T.ATTRIBUTE2    = '流水码'
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
            --合同中未导入物料编码 第二条据
          
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 0 THEN
              SELECT MAX(MATERIAL_CODE)
                INTO MATRIAL_CODE_V
                FROM (SELECT T.MATERIAL_CODE
                        FROM SPM_CON_WAREHOUSE_DL T
                       WHERE T.CONTRACT_ID = V_CONTRACT_ID
                         AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
              SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                    LENGTH(MATRIAL_CODE_V) - 3,
                                                    LENGTH(MATRIAL_CODE_V))) + 1）,
                                   '0000'))
                INTO SEQ_CODE
                FROM DUAL;
              /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
              WHERE T.TARGET_ID=V_INFO_ID;*/
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
          
          END IF;
        
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.WAREHOUSE_ID =
                 (SELECT T.WAREHOUSE_ID
                    FROM SPM_CON_WAREHOUSE T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID)
           WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          COMMIT;
        
        END IF;
      END LOOP;
    END LOOP;
  END;

  PROCEDURE DSSM_TO_GOODS_ARRIVAL1(P_MSG OUT VARCHAR2) IS
  
    V_ID              NUMBER;
    V_AAA             NUMBER;
    V_WAREHOUSE_DL_ID NUMBER;
    V_1               NUMBER;
    V_2               NUMBER;
    V_3               NUMBER;
    V_4               NUMBER;
    V_5               NUMBER;
    V_6               NUMBER;
    HAS_CONTRACT      NUMBER;
    HAS_CONTRACT1     NUMBER;
    V_COUNT           NUMBER;
    V_SERIAL_NUMBER   VARCHAR2(2000);
    V_CONTRACT_ID     NUMBER;
    V_WAREHOUSE_ID    NUMBER;
    VALIDATE1         VARCHAR2(2000);
    MSG_T             VARCHAR2(2000);
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    CONTRACT_CODE_4   VARCHAR2(2000);
  
    --所有的中间表中的主表信息
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_MQ_GOODS_ARRIVAL T
       WHERE 1 = 1
         AND NVL(T.ATTRIBUTE1, 0) <> '已处理'
         AND T.MQ_ID = 11111111;
  
    /*      CURSOR CURGOODSARRIVALDTL(V_AAA NUMBER) IS
         SELECT MAX(S.ARRIVE_ORDER_ID) TARGET_ID,
         MAX(S.ORDER_CODE_DL) ORDER_CODE_DL,
         MAX(S.SALE_ORDER_CODE_DL) SALE_ORDER_CODE_DL,
         MAX(S.ID) ID,
          MAX(S.MQ_ID) CONTRACT_ID,
          MAX(S.MATERIAL_CODE) MATERIAL_CODE,
          MAX(S.MATERIAL_NAME) MATERIAL_NAME,
          MAX(S.TAX_PRICE) UNIT_PRICE,
          MAX(S.PRICE)  UNIT_PRICE1,
          SUM(S.PURNUM) TARGET_COUNT,
          MAX(S.UNIT) TARGET_UNIT,
          MAX((SELECT ROUND((S.TAX_PRICE-S.PRICE)/S.PRICE,2) FROM DUAL)) TAX_RATE,
    
          MAX(S.SIGN_NUM) THIS_WAREHOUSE_NUMBER
    
     FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
    WHERE 1 = 1
      AND   S.ARRIVE_ORDER_ID=V_AAA
      GROUP BY S.MATERIAL_CODE;
      */
  
    CURSOR CURGOODSARRIVALDTL(V_AAA NUMBER) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.ID ID,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.TAX_PRICE UNIT_PRICE,
             S.PRICE UNIT_PRICE1,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             (SELECT ROUND((S.TAX_PRICE - S.PRICE) / S.PRICE, 2) * 100
                FROM DUAL) TAX_RATE,
             
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
       WHERE 1 = 1
         AND S.ID = V_AAA;
  
  BEGIN
    FOR BB IN CUR LOOP
      --插入入库单行信息
      FOR CCC IN CURGOODSARRIVALDTL(BB.MQ_ID) LOOP
      
        --插入入库单主表信息
        SELECT COUNT(*)
          INTO V_COUNT
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL;
      
        IF V_COUNT > 0 THEN
          SELECT T.CONTRACT_ID
            INTO V_CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL;
          SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                                'SPM_CON_WAREHOUSE',
                                                                'WAREHOUSE_CODE',
                                                                'FM00000')
            INTO V_SERIAL_NUMBER
            FROM DUAL;
        
          SELECT COUNT(*)
            INTO V_6
            FROM SPM_CON_WAREHOUSE T
           WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          IF V_6 = 0 THEN
            SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL
              INTO V_WAREHOUSE_ID
              FROM DUAL;
            INSERT INTO SPM_CON_WAREHOUSE
              (WAREHOUSE_ID, --主键
               CONTRACT_ID, --合同ID
               CONTRACT_NAME, --合同名称
               CONTRACT_CODE, --合同编号
               PROJECT_ID,
               PROJECT_NAME,
               PROJECT_CODE,
               VENDOR_ID, --供应商
               VENDOR_NAME,
               VENDOR_POSITION, --供应商地点
               MATERIAL_ORIGIN, --物资来源1
               MATERIAL_TYPE, --材料类别2
               TRANSPORT_TYPE, --运输方式3
               BUY_TYPE, --采购方式4
               WAREHOUSE_GRNI, --是否暂估5
               WAREHOUSE_DATE,
               CREATION_DATE, --创建日期
               DEPT_ID, --部门
               ORG_ID, --组织
               CREATED_BY,
               WAREHOUSE_CODE,
               ATTRIBUTE5,
               STATUS,
               ATTRIBUTE1)
            VALUES
              (V_WAREHOUSE_ID,
               (SELECT T.CONTRACT_ID
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.CONTRACT_NAME
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.CONTRACT_CODE
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               (SELECT T.PROJECT_ID
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.PROJECT_NAME
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.PROJECT_CODE
                  FROM SPM_CON_PROJECT T
                 WHERE T.PROJECT_ID =
                       (SELECT F.PROJECT_ID
                          FROM SPM_CON_HT_PROJECT F
                         WHERE F.CONTRACT_ID =
                               (SELECT AA.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO AA
                                 WHERE AA.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_ID
                  FROM SPM_CON_VENDOR_INFO T
                 WHERE T.VENDOR_ID =
                       (SELECT F.MERCHANTS_ID
                          FROM SPM_CON_HT_MERCHANTS F
                         WHERE F.CONTRACT_ID =
                               (SELECT DD.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO DD
                                 WHERE DD.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_NAME
                  FROM SPM_CON_VENDOR_INFO T
                 WHERE T.VENDOR_ID =
                       (SELECT F.MERCHANTS_ID
                          FROM SPM_CON_HT_MERCHANTS F
                         WHERE F.CONTRACT_ID =
                               (SELECT DD.CONTRACT_ID
                                  FROM SPM_CON_HT_INFO DD
                                 WHERE DD.CONTRACT_CODE =
                                       CCC.SALE_ORDER_CODE_DL))),
               (SELECT T.VENDOR_SITE_ID
                  FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
                 WHERE (SELECT T.ORG_ID
                          FROM SPM_CON_HT_INFO T
                         WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL) =
                       T.ORG_ID
                   AND T.VENDOR_ID = PP.VENDOR_ID
                   AND PP.ENABLED_FLAG = 'Y'
                   AND T.PURCHASING_SITE_FLAG = 'Y'
                   AND T.PAY_SITE_FLAG = 'Y'
                   AND PP.SEGMENT1 =
                       (SELECT T.VENDOR_CODE
                          FROM SPM_CON_VENDOR_INFO T
                         WHERE T.VENDOR_ID =
                               (SELECT F.MERCHANTS_ID
                                  FROM SPM_CON_HT_MERCHANTS F
                                 WHERE F.CONTRACT_ID =
                                       (SELECT DD.CONTRACT_ID
                                          FROM SPM_CON_HT_INFO DD
                                         WHERE DD.CONTRACT_CODE =
                                               CCC.SALE_ORDER_CODE_DL)))
                   AND T.VENDOR_SITE_CODE = '商品采购'
                
                ),
               'A', --物资来源1
               '1', --材料类别2
               'A', --运输方式3
               'A', --采购方式4
               'B', --是否暂估5
               SYSDATE,
               SYSDATE,
               303,
               89,
               1856,
               V_SERIAL_NUMBER,
               'N',
               'A',
               'DS');
            COMMIT;
          END IF;
        
          SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
            INTO V_WAREHOUSE_DL_ID
            FROM DUAL;
        
          INSERT INTO SPM_CON_WAREHOUSE_DL
            (WAREHOUSE_DL_ID, --主键
             WAREHOUSE_ID, --外键,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             DELIVERY_CARGO, --物料名称
             STORE_ROOM_NAME, --仓库
             GOODS_POSITION_NAME, --货位
             PURCHASE_AMOUNT, --总数量
             THIS_WAREHOUSE_NUMBER, --本次入库数量
             UNIT, --单位
             WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
             MONEY_AMOUNT, --金额(不含增值税)
             TAX_RATE, --税率
             TAX_AMOUNT, --进项税,
             TAX_UNIT_PRICE, --含税单价
             TAX_AMOUNT_COUNT, --价税合计
             DEPT_ID, --部门ID
             ORG_ID,
             CON_TARGET_ID,
             STORE_ROOM, --仓库
             GOODS_POSITION, --货位
             ATTRIBUTE2)
          VALUES
            (V_WAREHOUSE_DL_ID,
             V_WAREHOUSE_ID,
             (SELECT T.CONTRACT_ID
                FROM SPM_CON_HT_INFO T
               WHERE T.CONTRACT_CODE = CCC.ORDER_CODE_DL),
             CCC.MATERIAL_CODE,
             CCC.MATERIAL_NAME,
             (SELECT DISTINCT I.DESCRIPTION
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                        'NAME')
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             CCC.TARGET_COUNT, --合同数量
             CCC.THIS_WAREHOUSE_NUMBER, --本次入库数量
             CCC.TARGET_UNIT, --单位
             CCC.UNIT_PRICE1, --不含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, ----金额(不含增值税)
             CCC.TAX_RATE,
             CCC.UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
             CCC.UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, --价税合计
             303, --(SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.USER_ID=SPM_SSO_PKG.GETUSERID AND T.BELONGORGID=SPM_SSO_PKG.GETORGID ),
             89, --SPM_SSO_PKG.GETORGID,
             CCC.ID,
             (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             'DS');
          COMMIT;
        
          --
        
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                 'CWEME'
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_CONTRACT_ID;
          --物料编码如果为空 则按规则生成
          IF CCC.MATERIAL_CODE IS NULL THEN
          
            SELECT COUNT(*)
              INTO HAS_CONTRACT
              FROM SPM_CON_HT_TARGET O
             WHERE O.CONTRACT_ID = V_CONTRACT_ID
               AND O.CODE_TYPE = '流水码';
            SELECT COUNT(*)
              INTO HAS_CONTRACT1
              FROM SPM_CON_WAREHOUSE_DL O
             WHERE O.CONTRACT_ID = V_CONTRACT_ID
               AND O.ATTRIBUTE2 = '流水码';
            --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
          
            --合同中未导入物料编码 第一条数据
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '0001',
                     T.ATTRIBUTE2    = '流水码'
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
            --合同中未导入物料编码 第二条据
          
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 0 THEN
              SELECT MAX(MATERIAL_CODE)
                INTO MATRIAL_CODE_V
                FROM (SELECT T.MATERIAL_CODE
                        FROM SPM_CON_WAREHOUSE_DL T
                       WHERE T.CONTRACT_ID = V_CONTRACT_ID
                         AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
              SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                    LENGTH(MATRIAL_CODE_V) - 3,
                                                    LENGTH(MATRIAL_CODE_V))) + 1）,
                                   '0000'))
                INTO SEQ_CODE
                FROM DUAL;
              /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
              WHERE T.TARGET_ID=V_INFO_ID;*/
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
          
          END IF;
        
          UPDATE SPM_CON_WAREHOUSE_DL T
             SET T.WAREHOUSE_ID =
                 (SELECT T.WAREHOUSE_ID
                    FROM SPM_CON_WAREHOUSE T
                   WHERE T.CONTRACT_ID = V_CONTRACT_ID)
           WHERE T.CONTRACT_ID = V_CONTRACT_ID;
          COMMIT;
        
        END IF;
      END LOOP;
    END LOOP;
  END;

  PROCEDURE DSSM_TO_CONNECT IS
    V_ID            NUMBER;
    V_1             NUMBER;
    V_2             NUMBER;
    V_3             NUMBER;
    V_HT_ID         NUMBER;
    V_CONTRACT_CODE VARCHAR2(2000);
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_HT_INFO T
       WHERE T.ONLINE_RETAILERS = 'DSXS'
         AND NVL(ATTRIBUTE2, 0) <> '已处理';
    --AND T.CONTRACT_NAME='O-CX-18-00001108';
  
    --找到所有标的物
    /*    CURSOR CURTARGET(V_HT_ID NUMBER) IS
    SELECT * FROM SPM_CON_HT_TARGET T WHERE T.CONTRACT_ID= V_HT_ID;*/
  
  BEGIN
    FOR C IN CUR LOOP
      SELECT COUNT(*)
        INTO V_1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = C.CONTRACT_CODE || '-1';
    
      IF V_1 = 1 THEN
        SELECT T.CONTRACT_ID
          INTO V_2
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = C.CONTRACT_CODE || '-1';
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           C.CONTRACT_ID,
           V_2,
           '2',
           '1',
           '2',
           'DS');
      
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           T.ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           V_2,
           C.CONTRACT_ID,
           '2',
           '1',
           '1',
           'DS');
      
        /*    FOR CC IN  CURTARGET(V_2) LOOP
        
        UPDATE SPM_CON_HT_TARGET FF
            SET FF.TARGET_PARAMS =
                (SELECT SS.TARGET_PARAMS
                   FROM SPM_CON_HT_TARGET SS
                  WHERE SS.CONTRACT_ID = C.CONTRACT_ID
                    AND SS.SKU_VALUE = CC.SKU_VALUE),
             FF.SPECIFICATION_MODEL =
                (SELECT SS.SPECIFICATION_MODEL
                   FROM SPM_CON_HT_TARGET SS
                  WHERE SS.CONTRACT_ID = C.CONTRACT_ID
                    AND SS.SKU_VALUE = CC.SKU_VALUE),
             FF.SPECIFICATION_PACKING =
                (SELECT SS.SPECIFICATION_PACKING
                   FROM SPM_CON_HT_TARGET SS
                  WHERE SS.CONTRACT_ID = C.CONTRACT_ID
                    AND SS.SKU_VALUE = CC.SKU_VALUE)
          WHERE FF.CONTRACT_ID = V_2
                AND FF.SKU_VALUE=CC.SKU_VALUE;
        
         END LOOP;*/
      
        UPDATE SPM_CON_HT_INFO T
           SET T.ATTRIBUTE2 = '已处理'
         WHERE T.CONTRACT_ID = C.CONTRACT_ID;
        COMMIT;
      
      END IF;
    
    END LOOP;
  
  END;
  --入库单自动同步ebs
  PROCEDURE DS_BATCH_ODO_TO_EBS IS
    V_ID            NUMBER;
    V_HT_ID         NUMBER;
    V_CONTRACT_CODE VARCHAR2(2000);
    MSG_T           VARCHAR2(200);
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_ODO T
       WHERE (T.ATTRIBUTE5 = 'N' OR T.ATTRIBUTE5 = 'F')
            --AND T.THEIR_DEPARTMENT IS NOT NULL
         AND T.STATUS = 'E';
  BEGIN
    FOR C IN CUR LOOP
      CUX_SPM_DATA_PO_PKG.IMPORT_ZX_INFO(C.ODO_ID, MSG_T);
      UPDATE SPM_CON_ODO O
         SET O.TO_EBS_ERROR = MSG_T
       WHERE O.ODO_ID = C.ODO_ID;
    END LOOP;
  END;
  --出库单自动同步ebs
  PROCEDURE DS_BATCH_WAREHOUSE_TO_EBS IS
    V_ID            NUMBER;
    V_HT_ID         NUMBER;
    V_CONTRACT_CODE VARCHAR2(2000);
    MSG_T           VARCHAR2(200);
    CURSOR CUR IS
      SELECT *
        FROM SPM_CON_WAREHOUSE T
       WHERE (T.ATTRIBUTE5 = 'N' OR T.ATTRIBUTE5 = 'F')
            --  AND T.THEIR_DEPARTMENT IS NOT NULL
         AND T.STATUS = 'E';
  BEGIN
    FOR C IN CUR LOOP
      CUX_SPM_DATA_PO_PKG.IMPORT_ORDER_INFO(C.WAREHOUSE_ID, MSG_T);
      UPDATE SPM_CON_WAREHOUSE S
         SET S.TO_EBS_ERROR = MSG_T
       WHERE S.WAREHOUSE_ID = C.WAREHOUSE_ID;
    END LOOP;
  END;

  --根据订单批量生成入库单(含有框架)
  PROCEDURE CREATE_WAREHOUSE_BY_HT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID             NUMBER;
    V_1              NUMBER;
    V_2              NUMBER;
    V_CONTRACT_ID    NUMBER;
    V_SERIAL_NUMBER  VARCHAR2(2000);
    V_STRING         VARCHAR2(2000);
    MSG              VARCHAR2(2000);
    MSG_B            VARCHAR2(2000);
    V_DL_ID          NUMBER;
    MSG_T            VARCHAR2(2000);
    EBS_WAREHOUSE_ID NUMBER;
    V_EXCEPTION EXCEPTION;
    V_WAREHOUSE_ID NUMBER;
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
    
      SELECT T.CONTRACT_ID,
             T.CONTRACT_NAME,
             T.CONTRACT_CODE,
             T.ATTRIBUTE2,
             T.DEPT_ID,
             T.ORG_ID,
             T.CREATED_BY,
             T.CREATION_DATE,
             D.PROJECT_ID,
             D.PROJECT_NAME,
             D.PROJECT_CODE,
             E.VENDOR_ID,
             E.VENDOR_CODE,
             E.VENDOR_NAME,
             F.MORE_LESS_RATIO
      
        FROM SPM_CON_HT_INFO      T,
             SPM_CON_HT_RELATION  R,
             SPM_CON_HT_INFO      F,
             SPM_CON_HT_PROJECT   P,
             SPM_CON_PROJECT      D,
             SPM_CON_VENDOR_INFO  E,
             SPM_CON_HT_MERCHANTS A
      
       WHERE T.CONTRACT_ID = R.CONTRACT_ID
         AND R.CONTRACT_ID_R = F.CONTRACT_ID
         AND F.CONTRACT_ID = P.CONTRACT_ID
         AND P.PROJECT_ID = D.PROJECT_ID
         AND F.CONTRACT_ID = A.CONTRACT_ID
         AND E.VENDOR_ID = A.MERCHANTS_ID
         AND T.CONTRACT_TYPE = '2'
         AND T.ORDER_TYPE = '2'
         AND SPM_SSO_PKG.GETORGID() = T.ORG_ID
         AND F.CONTRACT_CODE NOT LIKE '%-%'
         AND T.CONTRACT_ID = V_ID;
  
    --去找到所有的标的物信息
    CURSOR CURHTTARGET(V_CONTRACT_ID NUMBER) IS
      SELECT MAX(S.TARGET_ID) TARGET_ID,
             MAX(S.CONTRACT_ID) CONTRACT_ID,
             S.MATERIAL_CODE,
             MAX(S.MATERIAL_NAME) MATERIAL_NAME,
             SUM(S.TARGET_AMOUNT) TARGET_AMOUNT,
             MAX(S.UNIT_PRICE) UNIT_PRICE,
             MAX((S.UNIT_PRICE / (1 + ((CASE
                   WHEN S.TAX_RATE IS NULL THEN
                    0
                   ELSE
                    S.TAX_RATE
                 END)) * 0.01))) UNIT_PRICE1,
             SUM(S.TARGET_COUNT) TARGET_COUNT,
             MAX(S.TARGET_UNIT) TARGET_UNIT,
             MAX(S.TAX_RATE) TAX_RATE
      
        FROM SPM_CON_HT_TARGET S
       WHERE 1 = 1
         AND S.CONTRACT_ID = V_CONTRACT_ID
       GROUP BY S.MATERIAL_CODE;
  
    CURSOR CUREBS(V_ID NUMBER) IS
      SELECT T.WAREHOUSE_ID
        FROM SPM_CON_WAREHOUSE T
       WHERE T.WAREHOUSE_ID = V_ID;
  
  BEGIN
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.CONTRACT_ID
        INTO V_1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成入库单主信息
      FOR CC IN CURORDER(V_1) LOOP
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                              'SPM_CON_WAREHOUSE',
                                                              'WAREHOUSE_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL INTO V_WAREHOUSE_ID FROM DUAL;
        INSERT INTO SPM_CON_WAREHOUSE
          (WAREHOUSE_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           VENDOR_ID, --供应商
           VENDOR_NAME,
           VENDOR_POSITION, --供应商地点
           MATERIAL_ORIGIN, --物资来源1
           MATERIAL_TYPE, --材料类别2
           TRANSPORT_TYPE, --运输方式3
           BUY_TYPE, --采购方式4
           WAREHOUSE_GRNI, --是否暂估5
           WAREHOUSE_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           WAREHOUSE_CODE,
           ATTRIBUTE5,
           STATUS
           
           )
        VALUES
          (V_WAREHOUSE_ID,
           CC.CONTRACT_ID,
           CC.CONTRACT_NAME,
           CC.CONTRACT_CODE,
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.VENDOR_ID,
           CC.VENDOR_NAME,
           (SELECT T.VENDOR_SITE_ID
              FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
             WHERE SPM_SSO_PKG.GETORGID() = T.ORG_ID
               AND T.VENDOR_ID = PP.VENDOR_ID
               AND PP.ENABLED_FLAG = 'Y'
               AND T.PURCHASING_SITE_FLAG = 'Y'
               AND T.PAY_SITE_FLAG = 'Y'
               AND PP.SEGMENT1 = CC.VENDOR_CODE
               AND T.VENDOR_SITE_CODE = '商品采购'
               AND T.ORG_ID = SPM_SSO_PKG.GETORGID),
           'A', --物资来源1
           '1', --材料类别2
           'A', --运输方式3
           'A', --采购方式4
           'B', --是否暂估5
           SYSDATE,
           SYSDATE,
           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY,
           V_SERIAL_NUMBER,
           'N',
           'A');
        UPDATE SPM_CON_HT_INFO T
           SET T.ATTRIBUTE2 = '1'
         WHERE T.CONTRACT_ID = CC.CONTRACT_ID;
      
        COMMIT;
      
        FOR CCC IN CURHTTARGET(V_1) LOOP
          SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL INTO V_DL_ID FROM DUAL;
        
          --插入入库单行信息
          INSERT INTO SPM_CON_WAREHOUSE_DL
            (WAREHOUSE_DL_ID, --主键
             WAREHOUSE_ID, --外键,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             DELIVERY_CARGO, --物料名称
             STORE_ROOM_NAME, --仓库
             GOODS_POSITION_NAME, --货位
             PURCHASE_AMOUNT, --总数量
             THIS_WAREHOUSE_NUMBER, --本次入库数量
             UNIT, --单位
             WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
             MONEY_AMOUNT, --金额(不含增值税)
             TAX_RATE, --税率
             TAX_AMOUNT, --进项税,
             TAX_UNIT_PRICE, --含税单价
             TAX_AMOUNT_COUNT, --价税合计
             DEPT_ID, --部门ID
             ORG_ID,
             CON_TARGET_ID,
             STORE_ROOM, --仓库
             GOODS_POSITION, --货位
             ATTRIBUTE2)
          VALUES
            (V_DL_ID,
             V_WAREHOUSE_ID,
             CCC.CONTRACT_ID,
             CCC.MATERIAL_CODE,
             CCC.MATERIAL_NAME,
             (SELECT DISTINCT I.DESCRIPTION
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                        'NAME')
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             CCC.TARGET_COUNT, --合同数量
             CCC.TARGET_COUNT, --本次入库数量
             CCC.TARGET_UNIT, --单位
             CCC.UNIT_PRICE1, --不含税单价
             CCC.TARGET_COUNT * CCC.UNIT_PRICE1, ----金额(不含增值税)
             CCC.TAX_RATE, --税率
             CCC.UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
             CCC.UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
             CCC.TARGET_COUNT * CCC.UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
             CCC.TARGET_COUNT * CCC.UNIT_PRICE1, --价税合计
             (SELECT T.ORGANIZATION_ID
                FROM SPM_CON_HT_PEOPLE_V T
               WHERE T.USER_ID = SPM_SSO_PKG.GETUSERID
                 AND T.BELONGORGID = SPM_SSO_PKG.GETORGID),
             SPM_SSO_PKG.GETORGID,
             CCC.TARGET_ID,
             (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND S.DISABLE_DATE IS NULL
                 AND ROWNUM = 1),
             '1');
          COMMIT;
        
          UPDATE SPM_CON_WAREHOUSE AA
             SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                                  I.WAREHOUSE_UNIT_PRICE,
                                                                  2))
                                                   FROM SPM_CON_WAREHOUSE_DL I
                                                  WHERE I.WAREHOUSE_ID =
                                                        AA.WAREHOUSE_ID),
                                                 0)
           WHERE AA.WAREHOUSE_ID = V_WAREHOUSE_ID;
        
          /*          --物料传入EBS
          SELECT T.WAREHOUSE_ID INTO EBS_WAREHOUSE_ID FROM SPM_CON_WAREHOUSE T WHERE T.CONTRACT_ID=CCC.CONTRACT_ID;
          DBMS_OUTPUT.PUT_LINE(EBS_WAREHOUSE_ID);
           CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO(EBS_WAREHOUSE_ID,MSG_T);*/
          COMMIT;
        
        END LOOP;
      END LOOP;
    END LOOP;
  
    FOR EBS IN (SELECT COLUMN_VALUE PROVINCE
                  FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                        FROM DUAL)))) LOOP
    
      BEGIN
        SELECT T.WAREHOUSE_ID
          INTO EBS_WAREHOUSE_ID
          FROM SPM_CON_WAREHOUSE T
         WHERE T.CONTRACT_ID = EBS.PROVINCE;
        --DBMS_OUTPUT.PUT_LINE(EBS_WAREHOUSE_ID);
        CUX_SPM_DATA_PO_PKG.IMPORT_ITEM_CODE_INFO_BY_ORDER(EBS_WAREHOUSE_ID,
                                                           MSG_T);
        DBMS_OUTPUT.PUT('错误信息：' || MSG_T);
      END;
    END LOOP;
  
    MSG_B := MSG_B || '所选的采购订单已成功生成入库单';
    P_MSG := MSG_B || ',' || MSG_T;
  
  END;

  --根据订单批量生成入库单(2.0)
  PROCEDURE CREATE_WAREHOUSE_BY_DSHT_ORDER(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2) IS
    V_ID             NUMBER;
    V_1              NUMBER;
    V_2              NUMBER;
    V_CONTRACT_ID    NUMBER;
    V_SERIAL_NUMBER  VARCHAR2(2000);
    V_STRING         VARCHAR2(2000);
    MSG              VARCHAR2(2000);
    MSG_B            VARCHAR2(2000);
    V_DL_ID          NUMBER;
    MSG_T            VARCHAR2(2000);
    EBS_WAREHOUSE_ID NUMBER;
    V_EXCEPTION EXCEPTION;
    V_WAREHOUSE_ID    NUMBER;
    V_WAREHOUSE_DL_ID NUMBER;
    HAS_CONTRACT      NUMBER;
    HAS_CONTRACT1     NUMBER;
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    CONTRACT_CODE_4   VARCHAR2(2000);
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
    
      SELECT S.CONTRACT_ID,
             S.CONTRACT_NAME,
             S.CONTRACT_CODE,
             D.PROJECT_ID,
             D.PROJECT_NAME,
             D.PROJECT_CODE,
             E.VENDOR_ID,
             E.VENDOR_CODE,
             E.VENDOR_NAME,
             S.ATTRIBUTE2,
             S.CREATED_BY,
             S.DEPT_ID,
             S.ORG_ID
      
        FROM SPM_CON_HT_INFO      S,
             SPM_CON_HT_PROJECT   T,
             SPM_CON_PROJECT      D,
             SPM_CON_VENDOR_INFO  E,
             SPM_CON_HT_MERCHANTS A
       WHERE 1 = 1
            
         AND S.CONTRACT_ID = T.CONTRACT_ID
         AND T.PROJECT_ID = D.PROJECT_ID
         AND S.CONTRACT_ID = A.CONTRACT_ID
         AND E.VENDOR_ID = A.MERCHANTS_ID
         AND S.IN_OUT_TYPE = '2'
         AND S.CONTRACT_TYPE = '2'
         AND D.EBS_STATUS = 'S'
         AND S.ORG_ID = SPM_SSO_PKG.GETORGID()
         AND T.CONTRACT_ID = V_ID;
  
    CURSOR CURHTTARGET(V_AAA NUMBER) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.MQ_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.ID ID,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.TAX_PRICE UNIT_PRICE,
             S.PRICE UNIT_PRICE1,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             (SELECT ROUND((S.TAX_PRICE - S.PRICE) / S.PRICE, 2) * 100
                FROM DUAL) TAX_RATE,
             
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
       WHERE 1 = 1
         AND S.SALE_ORDER_CODE_DL =
             (SELECT T.CONTRACT_CODE
                FROM SPM_CON_HT_INFO T
               WHERE T.CONTRACT_ID = V_AAA)
         AND NVL(S.ATTRIBUTE1, 0) <> 'A';
  
  BEGIN
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.CONTRACT_ID
        INTO V_1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成入库单主信息
      FOR CC IN CURORDER(V_1) LOOP
      
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                              'SPM_CON_WAREHOUSE',
                                                              'WAREHOUSE_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL INTO V_WAREHOUSE_ID FROM DUAL;
        INSERT INTO SPM_CON_WAREHOUSE
          (WAREHOUSE_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           VENDOR_ID, --供应商
           VENDOR_NAME,
           VENDOR_POSITION, --供应商地点
           MATERIAL_ORIGIN, --物资来源1
           MATERIAL_TYPE, --材料类别2
           TRANSPORT_TYPE, --运输方式3
           BUY_TYPE, --采购方式4
           WAREHOUSE_GRNI, --是否暂估5
           WAREHOUSE_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           WAREHOUSE_CODE,
           ATTRIBUTE5,
           STATUS
           
           )
        VALUES
          (V_WAREHOUSE_ID,
           CC.CONTRACT_ID,
           CC.CONTRACT_NAME,
           CC.CONTRACT_CODE,
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.VENDOR_ID,
           CC.VENDOR_NAME,
           (SELECT T.VENDOR_SITE_ID
              FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
             WHERE SPM_SSO_PKG.GETORGID() = T.ORG_ID
               AND T.VENDOR_ID = PP.VENDOR_ID
               AND PP.ENABLED_FLAG = 'Y'
               AND T.PURCHASING_SITE_FLAG = 'Y'
               AND T.PAY_SITE_FLAG = 'Y'
               AND PP.SEGMENT1 = CC.VENDOR_CODE
               AND T.VENDOR_SITE_CODE = '商品采购'
               AND T.ORG_ID = SPM_SSO_PKG.GETORGID),
           'A', --物资来源1
           '1', --材料类别2
           'A', --运输方式3
           'A', --采购方式4
           'B', --是否暂估5
           SYSDATE,
           SYSDATE,
           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY,
           V_SERIAL_NUMBER,
           'N',
           'A');
      
        COMMIT;
      
        FOR CCC IN CURHTTARGET(V_1) LOOP
          SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
            INTO V_WAREHOUSE_DL_ID
            FROM DUAL;
        
          INSERT INTO SPM_CON_WAREHOUSE_DL
            (WAREHOUSE_DL_ID, --主键
             WAREHOUSE_ID, --外键,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             DELIVERY_CARGO, --物料名称
             STORE_ROOM_NAME, --仓库
             GOODS_POSITION_NAME, --货位
             PURCHASE_AMOUNT, --总数量
             THIS_WAREHOUSE_NUMBER, --本次入库数量
             UNIT, --单位
             WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
             MONEY_AMOUNT, --金额(不含增值税)
             TAX_RATE, --税率
             TAX_AMOUNT, --进项税,
             TAX_UNIT_PRICE, --含税单价
             TAX_AMOUNT_COUNT, --价税合计
             DEPT_ID, --部门ID
             ORG_ID,
             CON_TARGET_ID,
             STORE_ROOM, --仓库
             GOODS_POSITION, --货位
             ATTRIBUTE2)
          VALUES
            (V_WAREHOUSE_DL_ID,
             V_WAREHOUSE_ID,
             (SELECT T.CONTRACT_ID
                FROM SPM_CON_HT_INFO T
               WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
             CCC.MATERIAL_CODE,
             CCC.MATERIAL_NAME,
             (SELECT DISTINCT I.DESCRIPTION
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                        'NAME')
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             CCC.TARGET_COUNT, --合同数量
             CCC.THIS_WAREHOUSE_NUMBER, --本次入库数量
             CCC.TARGET_UNIT, --单位
             CCC.UNIT_PRICE1, --不含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, ----金额(不含增值税)
             CCC.TAX_RATE,
             CCC.UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
             CCC.UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, --价税合计
             303, --(SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.USER_ID=SPM_SSO_PKG.GETUSERID AND T.BELONGORGID=SPM_SSO_PKG.GETORGID ),
             89, --SPM_SSO_PKG.GETORGID,
             CCC.ID,
             (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
               WHERE 1 = 1
                 AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                 AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                 AND ROWNUM = 1),
             'DS');
          COMMIT;
          SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                 'CWEME'
            INTO CONTRACT_CODE_4
            FROM SPM_CON_HT_INFO O
           WHERE O.CONTRACT_ID = V_1;
        
          --记录此条数据已经处理
          UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL T
             SET T.ATTRIBUTE1 = 'A'
           WHERE T.MQ_ID = CCC.MQ_ID;
        
          --物料编码如果为空 则按规则生成
          IF CCC.MATERIAL_CODE IS NULL THEN
          
            SELECT COUNT(*)
              INTO HAS_CONTRACT
              FROM SPM_CON_HT_TARGET O
             WHERE O.CONTRACT_ID = V_1
               AND O.CODE_TYPE = '流水码';
            SELECT COUNT(*)
              INTO HAS_CONTRACT1
              FROM SPM_CON_WAREHOUSE_DL O
             WHERE O.CONTRACT_ID = V_1
               AND O.ATTRIBUTE2 = '流水码';
            --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
          
            --合同中未导入物料编码 第一条数据
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '0001',
                     T.ATTRIBUTE2    = '流水码'
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
            --合同中未导入物料编码 第二条据
          
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 0 THEN
              SELECT MAX(MATERIAL_CODE)
                INTO MATRIAL_CODE_V
                FROM (SELECT T.MATERIAL_CODE
                        FROM SPM_CON_WAREHOUSE_DL T
                       WHERE T.CONTRACT_ID = V_1
                         AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
              SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                    LENGTH(MATRIAL_CODE_V) - 3,
                                                    LENGTH(MATRIAL_CODE_V))) + 1）,
                                   '0000'))
                INTO SEQ_CODE
                FROM DUAL;
              /*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
              WHERE T.TARGET_ID=V_INFO_ID;*/
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
          
          END IF;
        
          UPDATE SPM_CON_WAREHOUSE AA
             SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                                  I.WAREHOUSE_UNIT_PRICE,
                                                                  2))
                                                   FROM SPM_CON_WAREHOUSE_DL I
                                                  WHERE I.WAREHOUSE_ID =
                                                        AA.WAREHOUSE_ID),
                                                 0)
           WHERE AA.WAREHOUSE_ID = V_WAREHOUSE_ID;
        
          COMMIT;
        
        END LOOP;
      END LOOP;
    END LOOP;
  
    MSG_B := MSG_B || '所选的采购订单已成功生成入库单';
    P_MSG := MSG_B || ',' || MSG_T;
  
  END;

  --根据订单批量生成入库单2.1
  PROCEDURE CREATE_WAREHOUSE_BY_DHD(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID             NUMBER;
    V_1              NUMBER;
    V_2              NUMBER;
    V_CONTRACT_ID    NUMBER;
    V_SERIAL_NUMBER  VARCHAR2(2000);
    V_STRING         VARCHAR2(2000);
    MSG              VARCHAR2(2000);
    MSG_B            VARCHAR2(2000);
    V_DL_ID          NUMBER;
    MSG_T            VARCHAR2(2000);
    EBS_WAREHOUSE_ID NUMBER;
    V_EXCEPTION EXCEPTION;
    V_WAREHOUSE_ID    NUMBER;
    V_WAREHOUSE_DL_ID NUMBER;
    HAS_CONTRACT      NUMBER;
    HAS_CONTRACT1     NUMBER;
    MATRIAL_CODE_V    VARCHAR2(2000);
    SEQ_CODE          VARCHAR2(2000);
    CONTRACT_CODE_4   VARCHAR2(2000);
    V_MQ_ID           NUMBER;
    HT_PRICE          NUMBER;
    HT_TAXPRICE       NUMBER;
    HT_TAX_RATE       NUMBER;
    HT_MATERIAL_CODE  VARCHAR2(200);
    UNIT_PRICE1       NUMBER;
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT MAX(T.ARRIVE_ORDER_CODE) AS ARRIVE_ORDER_CODE,
             MAX(T.MQ_ID) AS MQ_ID,
             MAX(F.ORG_ID) AS ORG_ID,
             MAX(F.DEPT_ID) AS DEPT_ID,
             MAX(F.CREATED_BY) AS CREATED_BY,
             S.SALE_ORDER_CODE_DL AS SALE_ORDER_CODE_DL,
             MAX(F.CONTRACT_ID) CONTRACT_ID,
             MAX(F.CONTRACT_NAME) CONTRACT_NAME,
             MAX(F.CONTRACT_CODE) CONTRACT_CODE,
             (SELECT AA.PROJECT_ID
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_ID,
             
             (SELECT AA.PROJECT_NAME
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_NAME,
             
             (SELECT AA.PROJECT_CODE
                FROM SPM_CON_PROJECT AA
               WHERE AA.PROJECT_ID =
                     (SELECT BB.PROJECT_ID
                        FROM SPM_CON_HT_PROJECT BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS PROJECT_CODE,
             
             (SELECT AA.VENDOR_ID
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_ID,
             (SELECT AA.VENDOR_NAME
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_NAME,
             (SELECT AA.VENDOR_CODE
                FROM SPM_CON_VENDOR_INFO AA
               WHERE AA.VENDOR_ID =
                     (SELECT BB.MERCHANTS_ID
                        FROM SPM_CON_HT_MERCHANTS BB
                       WHERE BB.CONTRACT_ID =
                             (SELECT CC.CONTRACT_ID
                                FROM SPM_CON_HT_INFO CC
                               WHERE CC.CONTRACT_NAME = S.SALE_ORDER_CODE_DL))) AS VENDOR_CODE
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL     T,
             SPM_CON_MQ_GOODS_ARRIVAL_DTL S,
             SPM_CON_HT_INFO              F
       WHERE T.MQ_ID = S.ID
         AND F.CONTRACT_NAME = S.SALE_ORDER_CODE_DL
         AND T.MQ_ID = V_ID
         AND SPM_SSO_PKG.GETORGID =
             (SELECT F.ORG_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_NAME = S.SALE_ORDER_CODE_DL)
       GROUP BY S.SALE_ORDER_CODE_DL;
  
    CURSOR CURHTTARGET(V_AAA NUMBER) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.MQ_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.TAX_PRICE UNIT_PRICE,
             S.PRICE UNIT_PRICE1,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             S.SKU_VALUE,
             (SELECT FF.TARGET_ID
                FROM SPM_CON_HT_TARGET FF
               WHERE FF.CONTRACT_ID =
                     (SELECT FFF.CONTRACT_ID
                        FROM SPM_CON_HT_INFO FFF
                       WHERE FFF.CONTRACT_NAME = S.SALE_ORDER_CODE_DL)
                 AND FF.SKU_VALUE = S.SKU_VALUE) AS HT_TARGET_ID,
             (SELECT FF.SPECIFICATION_MODEL
                FROM SPM_CON_HT_TARGET FF
               WHERE FF.CONTRACT_ID =
                     (SELECT FFF.CONTRACT_ID
                        FROM SPM_CON_HT_INFO FFF
                       WHERE FFF.CONTRACT_NAME = S.SALE_ORDER_CODE_DL)
                 AND FF.SKU_VALUE = S.SKU_VALUE) AS SPECIFICATION_MODEL,
             (SELECT ROUND((S.TAX_PRICE - S.PRICE) / S.PRICE, 2) * 100
                FROM DUAL) TAX_RATE,
             
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S
       WHERE 1 = 1
         AND S.ID = V_AAA;
  BEGIN
    --第一层循环 拿到到货单的ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.MQ_ID
        INTO V_1
        FROM SPM_CON_MQ_GOODS_ARRIVAL T
       WHERE T.MQ_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成入库单主信息
      FOR CC IN CURORDER(V_1) LOOP
      
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                              'SPM_CON_WAREHOUSE',
                                                              'WAREHOUSE_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL INTO V_WAREHOUSE_ID FROM DUAL;
        INSERT INTO SPM_CON_WAREHOUSE
          (WAREHOUSE_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           VENDOR_ID, --供应商
           VENDOR_NAME,
           VENDOR_POSITION, --供应商地点
           MATERIAL_ORIGIN, --物资来源1
           MATERIAL_TYPE, --材料类别2
           TRANSPORT_TYPE, --运输方式3
           BUY_TYPE, --采购方式4
           WAREHOUSE_GRNI, --是否暂估5
           WAREHOUSE_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           WAREHOUSE_CODE,
           ATTRIBUTE5,
           STATUS,
           THEIR_DEPARTMENT,
           EBS_DEPT_CODE)
        VALUES
          (V_WAREHOUSE_ID,
           CC.CONTRACT_ID,
           CC.CONTRACT_NAME,
           CC.CONTRACT_CODE,
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.VENDOR_ID,
           CC.VENDOR_NAME,
           (SELECT T.VENDOR_SITE_ID
              FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
             WHERE SPM_SSO_PKG.GETORGID() = T.ORG_ID
               AND T.VENDOR_ID = PP.VENDOR_ID
               AND PP.ENABLED_FLAG = 'Y'
               AND T.PURCHASING_SITE_FLAG = 'Y'
               AND T.PAY_SITE_FLAG = 'Y'
               AND PP.SEGMENT1 = CC.VENDOR_CODE
               AND T.VENDOR_SITE_CODE = '商品暂估'
               AND T.ORG_ID = SPM_SSO_PKG.GETORGID),
           'A', --物资来源1
           '1', --材料类别2
           'A', --运输方式3
           'A', --采购方式4
           'B', --是否暂估5
           SYSDATE,
           SYSDATE,
           /*           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY,*/
           (SELECT T.ORGANIZATION_ID
              FROM SPM_CON_HT_PEOPLE_V T
             WHERE T.USER_ID = SPM_SSO_PKG.GETUSERID
               AND T.BELONGORGID = SPM_SSO_PKG.GETORGID),
           SPM_SSO_PKG.GETORGID,
           SPM_SSO_PKG.GETUSERID,
           V_SERIAL_NUMBER,
           'N',
           'A',
           CC.ARRIVE_ORDER_CODE,
           (SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                                  SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(SPM_SSO_PKG.GETUSERID))
              FROM DUAL));
        DBMS_OUTPUT.PUT_LINE(CC.CONTRACT_ID);
        COMMIT;
      
        FOR CCC IN CURHTTARGET(V_1) LOOP
          BEGIN
            SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
              INTO V_WAREHOUSE_DL_ID
              FROM DUAL;
            DBMS_OUTPUT.PUT_LINE(CCC.MATERIAL_NAME);
            SELECT T.TAX_RATE,
                   T.UNIT_PRICE,
                   T.MATERIAL_CODE,
                   (T.UNIT_PRICE / (1 + T.TAX_RATE * 0.01))
              INTO HT_TAX_RATE, HT_TAXPRICE, HT_MATERIAL_CODE, UNIT_PRICE1
              FROM SPM_CON_HT_TARGET T
             WHERE --T.MATERIAL_NAME = CCC.MATERIAL_NAME
             T.SKU_VALUE = CCC.SKU_VALUE
             AND T.CONTRACT_ID = CC.CONTRACT_ID;
          
            INSERT INTO SPM_CON_WAREHOUSE_DL
              (WAREHOUSE_DL_ID, --主键
               WAREHOUSE_ID, --外键,
               CONTRACT_ID,
               MATERIAL_CODE, --物资编码
               DELIVERY_CARGO, --物料名称
               STORE_ROOM_NAME, --仓库
               GOODS_POSITION_NAME, --货位
               PURCHASE_AMOUNT, --总数量
               THIS_WAREHOUSE_NUMBER, --本次入库数量
               UNIT, --单位
               WAREHOUSE_UNIT_PRICE, --单价(不含增值税)
               MONEY_AMOUNT, --金额(不含增值税)
               TAX_RATE, --税率
               TAX_AMOUNT, --进项税,
               TAX_UNIT_PRICE, --含税单价
               TAX_AMOUNT_COUNT, --价税合计
               CREATED_BY,
               DEPT_ID, --部门ID
               ORG_ID,
               CREATION_DATE,
               CON_TARGET_ID,
               STORE_ROOM, --仓库
               GOODS_POSITION, --货位
               ATTRIBUTE2,
               ATTRIBUTE3)
            VALUES
              (V_WAREHOUSE_DL_ID,
               V_WAREHOUSE_ID,
               (SELECT T.CONTRACT_ID
                  FROM SPM_CON_HT_INFO T
                 WHERE T.CONTRACT_CODE = CCC.SALE_ORDER_CODE_DL),
               HT_MATERIAL_CODE,
               (SUBSTR(CCC.MATERIAL_NAME, 0, 75) || '|' ||
               SUBSTR(CCC.SPECIFICATION_MODEL, 0, 25) || '|' || '|'),
               (SELECT DISTINCT I.DESCRIPTION
                  FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
                 WHERE 1 = 1
                   AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                   AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND ROWNUM = 1),
               (SELECT DISTINCT CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                                          'NAME')
                  FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
                 WHERE 1 = 1
                   AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                   AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND ROWNUM = 1),
               CCC.TARGET_COUNT, --合同数量
               CCC.THIS_WAREHOUSE_NUMBER, --本次入库数量
               CCC.TARGET_UNIT, --单位
               UNIT_PRICE1, --不含税单价
               CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1, ----金额(不含增值税)
               CCC.TAX_RATE,
               UNIT_PRICE1 * CCC.TARGET_COUNT * CCC.TAX_RATE * 0.01, --进项税
               UNIT_PRICE1 * (1 + CCC.TAX_RATE * 0.01), --含税单价
               CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1 * CCC.TAX_RATE * 0.01 +
               CCC.THIS_WAREHOUSE_NUMBER * UNIT_PRICE1, --价税合计
               CC.CREATED_BY,
               CC.DEPT_ID, --(SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.USER_ID=SPM_SSO_PKG.GETUSERID AND T.BELONGORGID=SPM_SSO_PKG.GETORGID ),
               CC.ORG_ID, --SPM_SSO_PKG.GETORGID,
               SYSDATE,
               CCC.HT_TARGET_ID,
               (SELECT DISTINCT I.SECONDARY_INVENTORY_NAME
                  FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
                 WHERE 1 = 1
                   AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                   AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND ROWNUM = 1),
               (SELECT DISTINCT S.INVENTORY_LOCATION_ID
                  FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
                 WHERE 1 = 1
                   AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
                   AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
                   AND ROWNUM = 1),
               'DS',
               CCC.SKU_VALUE);
          END;
          COMMIT;
          /*                    SELECT SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                'CWEME'
           INTO CONTRACT_CODE_4
           FROM SPM_CON_HT_INFO O
          WHERE O.CONTRACT_ID = V_1;*/
        
          --记录此条数据已经处理
          UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL T
             SET T.ATTRIBUTE1 = 'A'
           WHERE T.MQ_ID = CCC.MQ_ID;
        
          /*           --物料编码如果为空 则按规则生成
          IF CCC.MATERIAL_CODE IS NULL THEN
          
            SELECT COUNT(*)
              INTO HAS_CONTRACT
              FROM SPM_CON_HT_TARGET O
             WHERE O.CONTRACT_ID = V_1
               AND O.CODE_TYPE = '流水码';
            SELECT COUNT(*)
              INTO HAS_CONTRACT1
              FROM SPM_CON_WAREHOUSE_DL O
             WHERE O.CONTRACT_ID = V_1
               AND O.ATTRIBUTE2 = '流水码';
            --SELECT S.SHORT_CODE INTO ORG_CODE FROM HR_OPERATING_UNITS S WHERE S.ORGANIZATION_ID=(SPM_SSO_PKG.GETORGID());
          
            --合同中未导入物料编码 第一条数据
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 < 2 THEN
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || '0001',
                     T.ATTRIBUTE2    = '流水码'
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
            --合同中未导入物料编码 第二条据
          
            IF HAS_CONTRACT < 1 AND HAS_CONTRACT1 > 0 THEN
              SELECT MAX(MATERIAL_CODE)
                INTO MATRIAL_CODE_V
                FROM (SELECT T.MATERIAL_CODE
                        FROM SPM_CON_WAREHOUSE_DL T
                       WHERE T.CONTRACT_ID = V_1
                         AND T.ATTRIBUTE2 = '流水码'); --AND LENGTH(T.MATERIAL_CODE)=18);
              SELECT TRIM(TO_CHAR（(TO_NUMBER(SUBSTR(MATRIAL_CODE_V,
                                                    LENGTH(MATRIAL_CODE_V) - 3,
                                                    LENGTH(MATRIAL_CODE_V))) + 1）,
                                   '0000'))
                INTO SEQ_CODE
                FROM DUAL;
              \*        UPDATE SPM_CON_HT_TARGET T SET T.MATERIAL_CODE=REPLACE(MATRIAL_CODE_V,SUBSTR(MATRIAL_CODE_V,LENGTH(MATRIAL_CODE_V)-2,LENGTH(MATRIAL_CODE_V)),SEQ_CODE)
              WHERE T.TARGET_ID=V_INFO_ID;*\
              UPDATE SPM_CON_WAREHOUSE_DL T
                 SET T.MATERIAL_CODE = CONTRACT_CODE_4 || SEQ_CODE
               WHERE T.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
            END IF;
          
          END IF;  */
        
          UPDATE SPM_CON_WAREHOUSE AA
             SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                                  I.WAREHOUSE_UNIT_PRICE,
                                                                  2))
                                                   FROM SPM_CON_WAREHOUSE_DL I
                                                  WHERE I.WAREHOUSE_ID =
                                                        AA.WAREHOUSE_ID),
                                                 0)
           WHERE AA.WAREHOUSE_ID = V_WAREHOUSE_ID;
        
          COMMIT;
        
        END LOOP;
      END LOOP;
    END LOOP;
  
    MSG_B := MSG_B || '所选的采购订单已成功生成入库单';
    P_MSG := MSG_B || ',' || MSG_T;
  
  END;

  --根据订单批量生成入库单(带框架)
  PROCEDURE CREATE_ODO_BY_HT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID            NUMBER;
    V_1             NUMBER;
    V_2             NUMBER;
    V_CONTRACT_ID   NUMBER;
    V_SERIAL_NUMBER VARCHAR2(2000);
    V_STRING        VARCHAR2(2000);
    MSG             VARCHAR2(2000);
    MSG_B           VARCHAR2(2000);
    V_DL_ID         NUMBER;
    V_ODO_ID        NUMBER;
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
    
      SELECT T.CONTRACT_ID,
             T.CONTRACT_NAME,
             T.CONTRACT_CODE,
             D.PROJECT_ID,
             D.PROJECT_NAME,
             D.PROJECT_CODE,
             E.CUST_ID,
             E.CUST_CODE,
             E.CUST_NAME,
             F.MORE_LESS_RATIO,
             T.CREATED_BY,
             T.ORG_ID,
             T.DEPT_ID
      
        FROM SPM_CON_HT_INFO      T, --销售订单
             SPM_CON_HT_RELATION  R,
             SPM_CON_HT_INFO      F, --采购订单
             SPM_CON_HT_PROJECT   P,
             SPM_CON_PROJECT      D,
             SPM_CON_CUST_INFO    E,
             SPM_CON_HT_MERCHANTS A
      
       WHERE T.CONTRACT_ID = R.CONTRACT_ID
         AND R.CONTRACT_ID_R = F.CONTRACT_ID
         AND F.CONTRACT_ID = P.CONTRACT_ID
         AND P.PROJECT_ID = D.PROJECT_ID
         AND F.CONTRACT_ID = A.CONTRACT_ID
         AND E.CUST_ID = A.MERCHANTS_ID
         AND T.CONTRACT_TYPE = '2'
         AND T.ORDER_TYPE = '1'
         AND SPM_SSO_PKG.GETORGID() = T.ORG_ID
         AND F.CONTRACT_CODE NOT LIKE '%-%'
         AND T.CONTRACT_ID = V_ID;
  
    --去找到所有的标的物信息
    CURSOR CURHTTARGET(V_CONTRACT_ID NUMBER) IS
      SELECT DISTINCT G.WAREHOUSE_DL_ID,
                      T.CONTRACT_ID,
                      G.DELIVERY_CARGO,
                      G.MATERIAL_CODE,
                      G.PURCHASE_AMOUNT,
                      G.STORE_ROOM,
                      G.STORE_ROOM_NAME,
                      G.THIS_WAREHOUSE_NUMBER,
                      G.ITEM,
                      G.TEXTURE,
                      G.WAREHOUSED_NUMBER,
                      G.CON_TARGET_ID,
                      G.GOODS_POSITION,
                      G.GOODS_POSITION_NAME,
                      G.TAX_RATE,
                      G.WAREHOUSE_UNIT_PRICE,
                      G.TAX_UNIT_PRICE,
                      F.WAREHOUSE_ID AS WAREHOUSE_ID1,
                      G.UNIT AS UNIT1,
                      G.DEPT_ID,
                      G.ORG_ID,
                      D.CONTRACT_NAME,
                      F.WAREHOUSE_CODE,
                      (SELECT MAX(FF.UNIT_PRICE)
                         FROM SPM_CON_HT_TARGET FF
                        WHERE FF.CONTRACT_ID = T.CONTRACT_ID
                          AND FF.MATERIAL_CODE IN G.MATERIAL_CODE
                        GROUP BY FF.MATERIAL_CODE) AS UNIT_PRICE1,
                      (SELECT MAX(FFF.TAX_RATE)
                         FROM SPM_CON_HT_TARGET FFF
                        WHERE FFF.CONTRACT_ID = T.CONTRACT_ID
                          AND FFF.MATERIAL_CODE IN G.MATERIAL_CODE
                        GROUP BY FFF.MATERIAL_CODE) AS TAX_RATE1
        FROM SPM_CON_HT_INFO      T, --采购订单
             SPM_CON_HT_RELATION  R,
             SPM_CON_HT_INFO      D, --销售订单
             SPM_CON_WAREHOUSE    F,
             SPM_CON_WAREHOUSE_DL G
       WHERE 1 = 1
         AND T.CONTRACT_ID = R.CONTRACT_ID
         AND R.CONTRACT_ID_R = D.CONTRACT_ID
         AND F.CONTRACT_ID = D.CONTRACT_ID
         AND F.WAREHOUSE_ID = G.WAREHOUSE_ID
         AND T.CONTRACT_CODE LIKE '%-%'
            /* AND F.STATUS = 'E'
            AND F.ATTRIBUTE5 = 'Y'*/
         AND T.CONTRACT_ID = V_CONTRACT_ID;
  
  BEGIN
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.CONTRACT_ID
        INTO V_1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成入库单主信息
      FOR CC IN CURORDER(V_1) LOOP
      
        --出库单插入START
        --获取流水号
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_ODO',
                                                              'SPM_CON_ODO',
                                                              'ODO_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_ODO_SEQ.NEXTVAL INTO V_ODO_ID FROM DUAL;
      
        INSERT INTO SPM_CON_ODO
          (ODO_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           CUST_ID, --客户
           CUSTOMER,
           MATERIAL_TYPE, --材料类别2
           ODO_GRNI, --是否暂估5
           ODO_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           ODO_CODE,
           ATTRIBUTE5,
           STATUS)
        VALUES
          (V_ODO_ID,
           CC.CONTRACT_ID, --合同ID
           CC.CONTRACT_NAME, --合同名称
           CC.CONTRACT_CODE, --合同编号
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.CUST_ID, --客户
           CC.CUST_NAME,
           'A', --材料类别
           'B', --是否暂估
           SYSDATE,
           SYSDATE,
           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY,
           V_SERIAL_NUMBER, --出库单号
           'N',
           'A');
      
        --回显给订单值
        UPDATE SPM_CON_HT_INFO T
           SET T.ATTRIBUTE2 = '1'
         WHERE T.CONTRACT_ID = CC.CONTRACT_ID;
      
        COMMIT;
        --出库单插入END
      
        --第三个循环开启 去寻找所有入库单行信息
        FOR CCC IN CURHTTARGET(V_1) LOOP
          SELECT SPM_CON_ODO_DL_SEQ.NEXTVAL INTO V_DL_ID FROM DUAL;
        
          --插入出库单行信息START
        
          INSERT INTO SPM_CON_ODO_DL
            (SPM_CON_ODO_DL_ID, --主键
             ODO_ID,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             MATERIAL_NAME, --物料名称
             TARGET_ID,
             STORE_ROOM, --仓库
             STORE_ROOM_PATH, --仓库
             GOODS_LOCATION, --货位
             GOODS_LOCATION_PATH, --货位
             TARGET_COUNT, --合同数量
             UNIT, --单位
             THIS_ODO_NUMBER,
             ODO_UNIT_PRICE, --出库成本单价
             TAX_ODO_UNIT_PRICE, --销售单价
             TAX_RATE, --税率
             TARGET_AMOUNT, --出库成本金额
             TAX_AMOUNT, --销项税
             TAX_AMOUNT_COUNT, --价税合计
             CREATION_DATE,
             ATTRIBUTE1,
             DEPT_ID, --部门ID
             ORG_ID)
          VALUES
            (V_DL_ID,
             V_ODO_ID,
             CCC.CONTRACT_ID,
             CCC.MATERIAL_CODE,
             CCC.DELIVERY_CARGO,
             CCC.CON_TARGET_ID,
             CCC.STORE_ROOM,
             CCC.STORE_ROOM_NAME,
             CCC.GOODS_POSITION,
             CCC.GOODS_POSITION_NAME,
             CCC.PURCHASE_AMOUNT, --合同数量
             CCC.UNIT1, --单位
             CCC.PURCHASE_AMOUNT, --出库数量
             CCC.WAREHOUSE_UNIT_PRICE, --出库成本单价
             CCC.UNIT_PRICE1, --销售单价
             CCC.TAX_RATE1,
             CCC.PURCHASE_AMOUNT * CCC.WAREHOUSE_UNIT_PRICE, --出库成本金额
             CCC.UNIT_PRICE1 / (1 + CCC.TAX_RATE1 * 0.01) * CCC.TAX_RATE1 *
             CCC.PURCHASE_AMOUNT * 0.01, --出库成本金额
             CCC.PURCHASE_AMOUNT * CCC.UNIT_PRICE1, --价税合计
             SYSDATE,
             '1',
             CCC.DEPT_ID,
             CCC.ORG_ID
             
             );
        
          UPDATE SPM_CON_ODO AA
             SET AA.ODO_MONEY_AMOUNT =
                 (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                        FROM SPM_CON_ODO_DL I
                       WHERE I.ODO_ID = AA.ODO_ID),
                      0))
           WHERE AA.ODO_ID = V_ODO_ID;
          --插入出库单行信息END
        
        END LOOP;
      END LOOP;
    END LOOP;
    MSG_B := MSG_B || '订单已成功生成出库单';
    P_MSG := MSG_B;
  END;

  --根据订单批量生成入库单(带框架)
  PROCEDURE CREATE_ODO_BY_DSHT_ORDER(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID            NUMBER;
    V_1             NUMBER;
    V_2             NUMBER;
    V_CONTRACT_ID   NUMBER;
    V_SERIAL_NUMBER VARCHAR2(2000);
    V_STRING        VARCHAR2(2000);
    MSG             VARCHAR2(2000);
    MSG_B           VARCHAR2(2000);
    V_DL_ID         NUMBER;
    V_ODO_ID        NUMBER;
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
    
      SELECT S.CONTRACT_ID,
             S.CONTRACT_NAME,
             S.CONTRACT_CODE,
             D.PROJECT_ID,
             D.PROJECT_NAME,
             D.PROJECT_CODE,
             E.CUST_ID,
             E.CUST_NAME,
             E.CUST_CODE,
             S.ATTRIBUTE2,
             S.CREATED_BY,
             S.DEPT_ID,
             S.ORG_ID
      
        FROM SPM_CON_HT_INFO      S,
             SPM_CON_HT_PROJECT   T,
             SPM_CON_PROJECT      D,
             SPM_CON_CUST_INFO    E,
             SPM_CON_HT_MERCHANTS A
       WHERE 1 = 1
            
         AND S.CONTRACT_ID = T.CONTRACT_ID
         AND T.PROJECT_ID = D.PROJECT_ID
         AND S.CONTRACT_ID = A.CONTRACT_ID
         AND E.CUST_ID = A.MERCHANTS_ID
         AND S.IN_OUT_TYPE = '1'
         AND S.CONTRACT_TYPE = '2'
         AND D.EBS_STATUS = 'S'
         AND S.ORG_ID = SPM_SSO_PKG.GETORGID()
         AND T.CONTRACT_ID = V_ID;
  
    --去找到所有的标的物信息
    CURSOR CURHTTARGET(V_CONTRACT_ID NUMBER) IS
      SELECT DISTINCT G.WAREHOUSE_DL_ID,
                      T.CONTRACT_ID,
                      G.DELIVERY_CARGO,
                      G.MATERIAL_CODE,
                      G.PURCHASE_AMOUNT,
                      G.STORE_ROOM,
                      G.STORE_ROOM_NAME,
                      G.THIS_WAREHOUSE_NUMBER,
                      G.ITEM,
                      G.TEXTURE,
                      G.WAREHOUSED_NUMBER,
                      G.CON_TARGET_ID,
                      G.GOODS_POSITION,
                      G.GOODS_POSITION_NAME,
                      G.TAX_RATE,
                      G.WAREHOUSE_UNIT_PRICE,
                      G.TAX_UNIT_PRICE,
                      F.WAREHOUSE_ID AS WAREHOUSE_ID1,
                      G.UNIT AS UNIT1,
                      G.DEPT_ID,
                      G.ORG_ID,
                      D.CONTRACT_NAME,
                      F.WAREHOUSE_CODE,
                      (SELECT MAX(FF.UNIT_PRICE)
                         FROM SPM_CON_HT_TARGET FF
                        WHERE FF.CONTRACT_ID = T.CONTRACT_ID
                          AND FF.MATERIAL_CODE IN G.MATERIAL_CODE
                        GROUP BY FF.MATERIAL_CODE) AS UNIT_PRICE1,
                      (SELECT MAX(FFF.TAX_RATE)
                         FROM SPM_CON_HT_TARGET FFF
                        WHERE FFF.CONTRACT_ID = T.CONTRACT_ID
                          AND FFF.MATERIAL_CODE IN G.MATERIAL_CODE
                        GROUP BY FFF.MATERIAL_CODE) AS TAX_RATE1
        FROM SPM_CON_HT_INFO      T, --采购订单
             SPM_CON_HT_RELATION  R,
             SPM_CON_HT_INFO      D, --销售订单
             SPM_CON_WAREHOUSE    F,
             SPM_CON_WAREHOUSE_DL G
       WHERE 1 = 1
         AND T.CONTRACT_ID = R.CONTRACT_ID
         AND R.CONTRACT_ID_R = D.CONTRACT_ID
         AND F.CONTRACT_ID = D.CONTRACT_ID
         AND F.WAREHOUSE_ID = G.WAREHOUSE_ID
         AND T.CONTRACT_CODE LIKE '%-%'
            /* AND F.STATUS = 'E'
            AND F.ATTRIBUTE5 = 'Y'*/
         AND T.CONTRACT_ID = V_CONTRACT_ID;
  
  BEGIN
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.CONTRACT_ID
        INTO V_1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成入库单主信息
      FOR CC IN CURORDER(V_1) LOOP
      
        --出库单插入START
        --获取流水号
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_ODO',
                                                              'SPM_CON_ODO',
                                                              'ODO_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_ODO_SEQ.NEXTVAL INTO V_ODO_ID FROM DUAL;
        INSERT INTO SPM_CON_ODO
          (ODO_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           CUST_ID, --客户
           CUSTOMER,
           MATERIAL_TYPE, --材料类别2
           ODO_GRNI, --是否暂估5
           ODO_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           ODO_CODE,
           ATTRIBUTE5,
           STATUS)
        VALUES
          (V_ODO_ID,
           CC.CONTRACT_ID, --合同ID
           CC.CONTRACT_NAME, --合同名称
           CC.CONTRACT_CODE, --合同编号
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.CUST_ID, --客户
           CC.CUST_NAME,
           'A', --材料类别
           'B', --是否暂估
           SYSDATE,
           SYSDATE,
           CC.DEPT_ID,
           CC.ORG_ID,
           CC.CREATED_BY,
           V_SERIAL_NUMBER, --出库单号
           'N',
           'A');
      
        --回显给订单值
        /*        UPDATE SPM_CON_HT_INFO T
          SET T.ATTRIBUTE2 = '1'
        WHERE T.CONTRACT_ID = CC.CONTRACT_ID;*/
      
        COMMIT;
        --出库单插入END
      
        --第三个循环开启 去寻找所有入库单行信息
        FOR CCC IN CURHTTARGET(V_1) LOOP
          SELECT SPM_CON_ODO_DL_SEQ.NEXTVAL INTO V_DL_ID FROM DUAL;
        
          --插入出库单行信息START
        
          INSERT INTO SPM_CON_ODO_DL
            (SPM_CON_ODO_DL_ID, --主键
             ODO_ID,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             MATERIAL_NAME, --物料名称
             TARGET_ID,
             STORE_ROOM, --仓库
             STORE_ROOM_PATH, --仓库
             GOODS_LOCATION, --货位
             GOODS_LOCATION_PATH, --货位
             TARGET_COUNT, --合同数量
             UNIT, --单位
             THIS_ODO_NUMBER,
             ODO_UNIT_PRICE, --出库成本单价
             TAX_ODO_UNIT_PRICE, --销售单价
             TAX_RATE, --税率
             TARGET_AMOUNT, --出库成本金额
             TAX_AMOUNT, --销项税
             TAX_AMOUNT_COUNT, --价税合计
             CREATION_DATE,
             ATTRIBUTE1,
             DEPT_ID, --部门ID
             ORG_ID)
          VALUES
            (V_DL_ID,
             V_ODO_ID,
             CCC.CONTRACT_ID,
             CCC.MATERIAL_CODE,
             CCC.DELIVERY_CARGO,
             CCC.CON_TARGET_ID,
             CCC.STORE_ROOM,
             CCC.STORE_ROOM_NAME,
             CCC.GOODS_POSITION,
             CCC.GOODS_POSITION_NAME,
             CCC.PURCHASE_AMOUNT, --合同数量
             CCC.UNIT1, --单位
             CCC.THIS_WAREHOUSE_NUMBER, --出库数量
             CCC.WAREHOUSE_UNIT_PRICE, --出库成本单价
             CCC.UNIT_PRICE1, --销售单价
             CCC.TAX_RATE1,
             CCC.THIS_WAREHOUSE_NUMBER * CCC.WAREHOUSE_UNIT_PRICE, --出库成本金额
             CCC.UNIT_PRICE1 / (1 + CCC.TAX_RATE1 * 0.01) * CCC.TAX_RATE1 *
             CCC.THIS_WAREHOUSE_NUMBER * 0.01, --出库成本金额
             CCC.THIS_WAREHOUSE_NUMBER * CCC.UNIT_PRICE1, --价税合计
             SYSDATE,
             '1',
             CCC.DEPT_ID,
             CCC.ORG_ID
             
             );
        
          UPDATE SPM_CON_ODO AA
             SET AA.ODO_MONEY_AMOUNT =
                 (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                        FROM SPM_CON_ODO_DL I
                       WHERE I.ODO_ID = AA.ODO_ID),
                      0))
           WHERE AA.ODO_ID = V_ODO_ID;
          --插入出库单行信息END
        
        END LOOP;
      END LOOP;
    END LOOP;
    MSG_B := MSG_B || '订单已成功生成出库单';
    P_MSG := MSG_B;
  END;

  --根据订单批量生成入库单(带框架)
  PROCEDURE CREATE_ODO_BY_WAREHOUSE(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID                 NUMBER;
    V_1                  NUMBER;
    V_2                  NUMBER;
    V_CONTRACT_ID        NUMBER;
    V_SERIAL_NUMBER      VARCHAR2(2000);
    V_STRING             VARCHAR2(2000);
    MSG                  VARCHAR2(2000);
    MSG_B                VARCHAR2(2000);
    V_DL_ID              NUMBER;
    V_ODO_ID             NUMBER;
    HT_PRICE             NUMBER;
    HT_TAXPRICE          NUMBER;
    HT_TAX_RATE          NUMBER;
    HT_MATERIAL_CODE     VARCHAR2(200);
    UNIT_PRICE1          NUMBER;
    HT_TARGET_UNIT_PRICE NUMBER;
    V_DEPT_ID            NUMBER(15);
  
    --1.去找到所有的头信息
    CURSOR CURORDER(V_ID NUMBER) IS
    
      SELECT T.WAREHOUSE_CODE,
             T.CREATED_BY,
             T.ORG_ID,
             T.DEPT_ID,
             T.WAREHOUSE_ID,
             T.CONTRACT_ID,
             T.THEIR_DEPARTMENT,
             T.CONTRACT_NAME,
             T.CONTRACT_CODE,
             S.CONTRACT_CODE    AS CONTRACT_CODE1,
             S.CONTRACT_ID      AS CONTRACT_ID1,
             S.CONTRACT_NAME    AS CONTRACT_NAME1,
             A.PROJECT_ID,
             A.PROJECT_NAME,
             A.PROJECT_CODE,
             C.CUST_ID,
             C.CUST_NAME,
             T.EBS_PRODUCE
        FROM SPM_CON_WAREHOUSE    T,
             SPM_CON_HT_INFO      F, --采购订单合同
             SPM_CON_HT_INFO      S, --销售订单合同
             SPM_CON_HT_PROJECT   P,
             SPM_CON_PROJECT      A,
             SPM_CON_HT_MERCHANTS M,
             SPM_CON_CUST_INFO    C
       WHERE F.CONTRACT_ID = T.CONTRACT_ID
         AND T.ORG_ID = SPM_SSO_PKG.GETORGID
         AND (S.CONTRACT_CODE || '-1') = F.CONTRACT_CODE
         AND S.CONTRACT_ID = P.CONTRACT_ID
         AND P.PROJECT_ID = A.PROJECT_ID
         AND S.CONTRACT_ID = M.CONTRACT_ID
         AND M.MERCHANTS_ID = C.CUST_ID
         AND T.WAREHOUSE_ID = V_ID;
  
    CURSOR CURHTTARGET(V_CONTRACT_ID NUMBER) IS
    
      SELECT *
        FROM SPM_CON_WAREHOUSE_DL T
       WHERE T.WAREHOUSE_ID = V_CONTRACT_ID;
  
  BEGIN
    --附加（人员信息及仓库货位的查询）
    SELECT V.ORGANIZATION_ID
      INTO V_DEPT_ID
    
      FROM SPM_CON_HT_PEOPLE_V V
     WHERE V.USER_ID = SPM_SSO_PKG.GETUSERID
       AND V.BELONGORGID = SPM_SSO_PKG.GETORGID;
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      SELECT T.WAREHOUSE_ID
        INTO V_1
        FROM SPM_CON_WAREHOUSE T
       WHERE T.WAREHOUSE_ID = TO_NUMBER(C.PROVINCE);
    
      --第二层循环  通过合同ID去生成出库单主信息
      FOR CC IN CURORDER(V_1) LOOP
      
        --出库单插入START
        --获取流水号
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_ODO',
                                                              'SPM_CON_ODO',
                                                              'ODO_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
      
        SELECT SPM_CON_ODO_SEQ.NEXTVAL INTO V_ODO_ID FROM DUAL;
        INSERT INTO SPM_CON_ODO
          (ODO_ID, --主键
           CONTRACT_ID, --合同ID
           CONTRACT_NAME, --合同名称
           CONTRACT_CODE, --合同编号
           PROJECT_ID,
           PROJECT_NAME,
           PROJECT_CODE,
           CUST_ID, --客户
           CUSTOMER,
           MATERIAL_TYPE, --材料类别2
           ODO_GRNI, --是否暂估5
           ODO_DATE,
           CREATION_DATE, --创建日期
           DEPT_ID, --部门
           ORG_ID, --组织
           CREATED_BY,
           ODO_CODE,
           ATTRIBUTE5,
           STATUS,
           THEIR_DEPARTMENT,
           LAST_UPDATE_DATE,
           EBS_DEPT_CODE,
           EBS_PRODUCE)
        VALUES
          (V_ODO_ID,
           CC.CONTRACT_ID1, --合同ID
           CC.CONTRACT_NAME1, --合同名称
           CC.CONTRACT_CODE1, --合同编号
           CC.PROJECT_ID,
           CC.PROJECT_NAME,
           CC.PROJECT_CODE,
           CC.CUST_ID, --客户
           CC.CUST_NAME,
           'A', --材料类别
           'B', --是否暂估
           SYSDATE,
           SYSDATE,
           V_DEPT_ID,
           SPM_SSO_PKG.GETORGID,
           SPM_SSO_PKG.GETUSERID,
           V_SERIAL_NUMBER, --出库单号
           'N',
           'A',
           NVL(CC.THEIR_DEPARTMENT, 0),
           SYSDATE,
           (select SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.getOrgId,
                                                                  spm_eam_common_pkg.Get_Personid_By_Userid(spm_sso_pkg.getUserId))
              from dual),
            CC.EBS_PRODUCE);
      
        COMMIT;
        --出库单插入END
      
        --第三个循环开启 去寻找所有入库单行信息
        FOR CCC IN CURHTTARGET(V_1) LOOP
          SELECT SPM_CON_ODO_DL_SEQ.NEXTVAL INTO V_DL_ID FROM DUAL;
        
          SELECT T.UNIT_PRICE, T.TAX_RATE
            INTO HT_TARGET_UNIT_PRICE, HT_TAX_RATE
            FROM SPM_CON_HT_TARGET T
           WHERE T.CONTRACT_ID = CC.CONTRACT_ID1
                --AND T.MATERIAL_NAME = CCC.DELIVERY_CARGO;
             AND T.SKU_VALUE = CCC.ATTRIBUTE3;
          --插入出库单行信息START
        
          INSERT INTO SPM_CON_ODO_DL
            (SPM_CON_ODO_DL_ID, --主键
             ODO_ID,
             CONTRACT_ID,
             MATERIAL_CODE, --物资编码
             MATERIAL_NAME, --物料名称
             TARGET_ID,
             STORE_ROOM, --仓库
             STORE_ROOM_PATH, --仓库
             GOODS_LOCATION, --货位
             GOODS_LOCATION_PATH, --货位
             TARGET_COUNT, --合同数量
             UNIT, --单位
             THIS_ODO_NUMBER,
             ODO_UNIT_PRICE, --出库成本单价
             TAX_ODO_UNIT_PRICE, --销售单价
             TAX_RATE, --税率
             TARGET_AMOUNT, --出库成本金额
             TAX_AMOUNT, --销项税
             TAX_AMOUNT_COUNT, --价税合计
             CREATION_DATE,
             ATTRIBUTE1,
             DEPT_ID, --部门ID
             ORG_ID,
             CREATED_BY,
             REMARK, --入库单号码
             WAREHOUSE_DL_ID,--入库单行信息主键
             WAREHOUSED_NUMBER--已入库数量
             ) 
          VALUES
            (V_DL_ID,
             V_ODO_ID,
             CC.CONTRACT_ID1,
             CCC.MATERIAL_CODE,
             CCC.DELIVERY_CARGO,
             CCC.CON_TARGET_ID,
             CCC.STORE_ROOM,
             CCC.STORE_ROOM_NAME,
             CCC.GOODS_POSITION,
             CCC.GOODS_POSITION_NAME,
             CCC.PURCHASE_AMOUNT, --合同数量
             CCC.UNIT, --单位
             CCC.THIS_WAREHOUSE_NUMBER, --出库数量
             CCC.WAREHOUSE_UNIT_PRICE, --出库成本单价
             HT_TARGET_UNIT_PRICE, --销售单价
             HT_TAX_RATE,
             CCC.THIS_WAREHOUSE_NUMBER * CCC.WAREHOUSE_UNIT_PRICE, --出库成本金额
             (HT_TARGET_UNIT_PRICE / (1 + HT_TAX_RATE * 0.01) * HT_TAX_RATE *
             CCC.THIS_WAREHOUSE_NUMBER * 0.01),
             CCC.THIS_WAREHOUSE_NUMBER * HT_TARGET_UNIT_PRICE, --价税合计
             SYSDATE,
             '1',
             V_DEPT_ID,
             SPM_SSO_PKG.GETORGID,
             SPM_SSO_PKG.GETUSERID,
             CC.WAREHOUSE_CODE, --入库单编号
             CCC.WAREHOUSE_DL_ID,--入库单行信息主键
             CCC.THIS_WAREHOUSE_NUMBER); 
        
        END LOOP;
        UPDATE SPM_CON_ODO AA
           SET AA.ODO_MONEY_AMOUNT =
               (NVL((SELECT SUM(I.TAX_ODO_UNIT_PRICE * I.THIS_ODO_NUMBER)
                      FROM SPM_CON_ODO_DL I
                     WHERE I.ODO_ID = AA.ODO_ID),
                    0))
         WHERE AA.ODO_ID = V_ODO_ID;
        --插入出库单行信息END
      END LOOP;
    END LOOP;
    MSG_B := MSG_B || '订单已成功生成出库单';
    P_MSG := MSG_B;
  END;

  --批量审批入库单
  PROCEDURE GENERATE_WAREHOUSE_STATUS_TO_C(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_B VARCHAR2(2000);
  
    --找到所有选中的入库单
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS FROM SPM_CON_WAREHOUSE T WHERE T.WAREHOUSE_ID = V_ID;
  
  BEGIN
    --拿到所有入库单主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_WAREHOUSE T
         SET T.STATUS = 'C'
       WHERE T.WAREHOUSE_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的入库单成功提交审批';
    P_MSG := MSG_B;
  END;

  --批量审批入库单
  PROCEDURE GENERATE_WAREHOUSE_STATUS_TO_E(IDS   VARCHAR2,
                                           P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_B VARCHAR2(2000);
  
    --找到所有选中的入库单
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS FROM SPM_CON_WAREHOUSE T WHERE T.WAREHOUSE_ID = V_ID;
  
  BEGIN
    --拿到所有入库单主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_WAREHOUSE T
         SET T.STATUS = 'E'
       WHERE T.WAREHOUSE_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的入库单已审批完成';
    P_MSG := MSG_B;
  END;

  -- --批量审批出库单
  PROCEDURE GENERATE_ODO_STATUS_TO_C(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_B VARCHAR2(2000);
  
    --找到所选中的出库单
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS FROM SPM_CON_WAREHOUSE T WHERE T.WAREHOUSE_ID = V_ID;
  
  BEGIN
    --拿到所有出库单主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_ODO T SET T.STATUS = 'C' WHERE T.ODO_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的出库单已审批完成';
    P_MSG := MSG_B;
  END;

  -- --批量审批出库单
  PROCEDURE GENERATE_ODO_STATUS_TO_E(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_B VARCHAR2(2000);
  
    --找到所选中的出库单
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS FROM SPM_CON_WAREHOUSE T WHERE T.WAREHOUSE_ID = V_ID;
  
  BEGIN
    --拿到所有出库单主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_ODO T
         SET T.STATUS = 'E', T.OUTPUT_OR_RETURN = '2'
       WHERE T.ODO_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的出库单已审批完成';
    P_MSG := MSG_B;
  END;

  -- --批量提交销项发票
  PROCEDURE GENERATE_OUTPUT_STATUS_TO_C(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID    NUMBER;
    MSG_B   VARCHAR2(2000);
    V_COUNT NUMBER;
    MSG_A   VARCHAR2(2000);
  
    --去找到所有销项发票
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS
        FROM SPM_CON_OUTPUT_INVOICE T
       WHERE T.OUTPUT_INVOICE_ID = V_ID;
  
  BEGIN
    --拿到所有销项发票的ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_OUTPUT_INVOICE T
         SET T.STATUS = 'C'
       WHERE T.OUTPUT_INVOICE_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的销项发票已提交审批';
    P_MSG := MSG_B;
  END;

  --批量审批销项发票
  PROCEDURE GENERATE_OUTPUT_STATUS_TO_E(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_B VARCHAR2(2000);
  
    --去找到所有销项发票
    CURSOR CURORDER(V_ID NUMBER) IS
      SELECT T.STATUS
        FROM SPM_CON_OUTPUT_INVOICE T
       WHERE T.OUTPUT_INVOICE_ID = V_ID;
  
  BEGIN
    --拿到所有销项发票的ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
    
      UPDATE SPM_CON_OUTPUT_INVOICE T
         SET T.STATUS = 'E'
       WHERE T.OUTPUT_INVOICE_ID = C.PROVINCE;
    
    END LOOP;
    MSG_B := MSG_B || '所选的销项发票已审批通过';
    P_MSG := MSG_B;
  END;

  --批量认领并生效合同
  PROCEDURE BATCH_CLAIM(IDS VARCHAR2, P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
  
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
  
    MSG_A2 VARCHAR2(4000);
    MSG_B2 VARCHAR2(4000);
    MSG_C2 VARCHAR2(4000);
  
    PROJECT_COUNT       NUMBER;
    PROJECT_COUNT1      NUMBER;
    HT_MERCHANTS_COUNT  NUMBER;
    HT_MERCHANTS_COUNT1 NUMBER;
    TARGET_COUNT        NUMBER;
    V_CUST_INFO         VARCHAR2(2000);
    DD_CREATION_DATE    DATE;
    V_1                 NUMBER;
    V_2                 NUMBER;
    V_PROJECT_ID        NUMBER;
    V_DEPT_ID           NUMBER;
    V_CREATED_BY        NUMBER;
    ENTERPRISEID        NUMBER;
    ASSIGN_PURORG_ID    NUMBER;
    KJ_CONTRACT_ID      NUMBER;
  
    HT_PROJECT   SPM_CON_HT_PROJECT%ROWTYPE;
    HT_MERCHANTS SPM_CON_HT_MERCHANTS%ROWTYPE;
  
    k_repeat_number number;
    K_order_id      number;
  
    --1.去找到所有的头信息
    CURSOR CURHTORDER(V_ID NUMBER) IS
    
      SELECT T.CONTRACT_ID,
             T.CONTRACT_CODE,
             T.CONTRACT_NAME,
             T.IN_OUT_TYPE,
             T.START_DATE,
             T.END_DATE,
             T.ORG_ID,
             T.CREATION_DATE
      
        FROM SPM_CON_HT_INFO T
       WHERE T.ONLINE_RETAILERS LIKE '%DS%'
         AND T.DEPT_ID IS NULL
         AND T.CREATED_BY IS NULL
         AND T.CONTRACT_ID = V_ID
         AND (T.ORG_ID IS NULL OR T.ORG_ID = SPM_SSO_PKG.GETORGID);
  
  BEGIN
    --第一层循环 拿到所有订单合同的主键ID
    FOR C IN (SELECT COLUMN_VALUE PROVINCE
                FROM TABLE(STRSPLIT((SELECT SUBSTR(IDS, 1, LENGTH(IDS) - 1)
                                      FROM DUAL)))) LOOP
      FOR CC IN CURHTORDER(C.PROVINCE) LOOP
        IF CC.IN_OUT_TYPE = '2' THEN
          --先查一下此条合同是否关联了项目和供应商
          SELECT COUNT(*)
            INTO PROJECT_COUNT1
            FROM SPM_CON_HT_PROJECT T
           WHERE T.CONTRACT_ID = C.PROVINCE;
        
          SELECT COUNT(*)
            INTO HT_MERCHANTS_COUNT1
            FROM SPM_CON_HT_MERCHANTS T
           WHERE T.CONTRACT_ID = C.PROVINCE;
        
          SELECT T.ENTERPRISEID
            INTO ENTERPRISEID
            FROM SPM_CON_MQ_SM_PUR_ORDER T
           WHERE T.ORDER_NO = CC.CONTRACT_CODE;
        
          IF PROJECT_COUNT1 = 0 AND HT_MERCHANTS_COUNT1 = 0 THEN
            SELECT TO_NUMBER(SPM_CON_VENDOR_PACKAGE.QUERY_VENDOR_STATUS(TO_CHAR(ENTERPRISEID),
                                                                        CC.ORG_ID))
              INTO V_1
              FROM DUAL;
          
            IF V_1 = -1 THEN
              MSG_A  := CC.CONTRACT_CODE || '电商未推送该供应商，或推送信息不完整 ' || MSG_A;
              MSG_A1 := '电商未推送该供应商，或推送信息不完整';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A1
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -2 THEN
              MSG_A  := CC.CONTRACT_CODE || '电商已推送供应商，还未进入业财系统 ' || MSG_A;
              MSG_A1 := '电商已推送供应商，还未进入业财系统 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A1
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -3 THEN
              MSG_A  := CC.CONTRACT_CODE || '供应商审核未完成 ' || MSG_A;
              MSG_A1 := '供应商审核未完成 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A1
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -4 THEN
              MSG_A  := CC.CONTRACT_CODE || '供应商未同步 ' || MSG_A;
              MSG_A1 := '供应商未同步 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A1
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -5 THEN
              MSG_A  := CC.CONTRACT_CODE || '查找供应商异常，请联系系统管理员 ' || MSG_A;
              MSG_A1 := '查找供应商异常，请联系系统管理员 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A1
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 > 0 THEN
              --查一下是否有这个框架合同
            
              SELECT COUNT(*)
                INTO V_2
                FROM SPM_CON_HT_INFO      S,
                     SPM_CON_HT_PROJECT   T,
                     SPM_CON_PROJECT      D,
                     SPM_CON_VENDOR_INFO  E,
                     SPM_CON_HT_MERCHANTS A
               WHERE 1 = 1
                    
                 AND S.CONTRACT_ID = T.CONTRACT_ID
                 AND T.PROJECT_ID = D.PROJECT_ID
                 AND S.CONTRACT_ID = A.CONTRACT_ID
                 AND E.VENDOR_ID = A.MERCHANTS_ID
                 AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
                 AND S.CONTRACT_FORM = '4'
                 AND S.IN_OUT_TYPE = '2'
                 AND S.ORG_ID = CC.ORG_ID
                 AND S.START_DATE <= trunc(cc.CREATION_DATE,'dd')
                 AND S.END_DATE >= trunc(cc.CREATION_DATE,'dd')
                 AND E.VENDOR_ID = V_1;
            
              IF V_2 = 0 THEN
                MSG_A  := CC.CONTRACT_CODE || '采购订单认领失败，未找到框架协议' || MSG_A;
                MSG_B1 := '采购订单认领失败，未找到框架协议';
                UPDATE SPM_CON_HT_INFO T
                   SET T.ERROR_MSG = MSG_A1 || MSG_B1
                 WHERE T.CONTRACT_ID = C.PROVINCE;
              END IF;
            
              IF V_2 > 1 THEN
                MSG_A  := CC.CONTRACT_CODE ||
                          '采购订单认领失败，找到多条可匹配的框架，请手动选择确认要关联的框架' || MSG_A;
                MSG_B1 := '采购订单认领失败，找到多条可匹配的框架，请手动选择确认要关联的框架';
                UPDATE SPM_CON_HT_INFO T
                   SET T.ERROR_MSG = MSG_A1 || MSG_B1
                 WHERE T.CONTRACT_ID = C.PROVINCE;
              END IF;
            
              IF V_2 = 1 THEN
                --框架合同
                SELECT MAX(D.PROJECT_ID),
                       MAX(S.DEPT_ID),
                       MAX(S.CREATED_BY),
                       MAX(S.CONTRACT_ID)
                  INTO V_PROJECT_ID,
                       V_DEPT_ID,
                       V_CREATED_BY,
                       KJ_CONTRACT_ID
                  FROM SPM_CON_HT_INFO      S,
                       SPM_CON_HT_PROJECT   T,
                       SPM_CON_PROJECT      D,
                       SPM_CON_VENDOR_INFO  E,
                       SPM_CON_HT_MERCHANTS A
                 WHERE 1 = 1
                      
                   AND S.CONTRACT_ID = T.CONTRACT_ID
                   AND T.PROJECT_ID = D.PROJECT_ID
                   AND S.CONTRACT_ID = A.CONTRACT_ID
                   AND E.VENDOR_ID = A.MERCHANTS_ID
                   AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
                   AND S.CONTRACT_FORM = '4'
                   AND S.IN_OUT_TYPE = '2'
                   AND S.ORG_ID = CC.ORG_ID
                   AND S.START_DATE <= trunc(cc.CREATION_DATE,'dd')
                   AND S.END_DATE >= trunc(cc.CREATION_DATE,'dd')
                   AND E.VENDOR_ID = V_1;
              
                --插入项目
                --主键
                INSERT INTO SPM_CON_HT_PROJECT
                  (CON_PRO_RELATION_ID,
                   CONTRACT_ID,
                   PROJECT_ID,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_PROJECT_SEQ.NEXTVAL,
                   CC.CONTRACT_ID,
                   V_PROJECT_ID,
                   'DSCG');
              
                --插入供应商
                -- 主键
                INSERT INTO SPM_CON_HT_MERCHANTS
                  (CON_MERCHANTS_ID,
                   MERCHANTS_ID,
                   CONTRACT_ID,
                   MERCHANTS_FLAG,
                   IN_OUT_TYPE,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
                   V_1,
                   CC.CONTRACT_ID,
                   2,
                   '2',
                   'DSCG');
              
                --关联框架协议
                INSERT INTO SPM_CON_HT_RELATION T
                  (T.RELATION_ID,
                   T.CONTRACT_ID,
                   T.CONTRACT_ID_R,
                   T.RELATION_SHIP,
                   T.RELATION_BUSINESS,
                   T.RELATION_ACTION,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
                   C.PROVINCE,
                   KJ_CONTRACT_ID,
                   '3',
                   '3',
                   '2',
                   'DS');
              
                INSERT INTO SPM_CON_HT_RELATION T
                  (T.RELATION_ID,
                   T.CONTRACT_ID,
                   T.CONTRACT_ID_R,
                   T.RELATION_SHIP,
                   T.RELATION_BUSINESS,
                   T.RELATION_ACTION,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
                   KJ_CONTRACT_ID,
                   C.PROVINCE,
                   '3',
                   '3',
                   '1',
                   'DS');
              
                select t.id
                  into K_order_id
                  from spm_con_mq_sm_pur_order t
                 where t.order_no = CC.CONTRACT_CODE;
              
                begin
                  select count(*)
                    into k_repeat_number
                    from spm_con_mq_sm_pur_order_dtl t
                   where t.order_id = K_order_id
                     and t.ny_datang_material_code is not null
                   group by t.ny_datang_material_code
                  having count(*) > 1;
                exception
                  when others then
                    k_repeat_number := 0;
                end;
              
                if k_repeat_number = 0 then
                
                  --合同表加入人员和部门(框架合同)
                  UPDATE SPM_CON_HT_INFO T
                     SET T.DEPT_ID          = V_DEPT_ID,
                         T.CREATED_BY       = V_CREATED_BY,
                         T.STATUS           = 'E',
                         T.ERROR_MSG        = NULL,
                         T.LAST_UPDATE_DATE = SYSDATE,
                         T.LAST_UPDATED_BY  = SPM_SSO_PKG.GETUSERID
                   WHERE T.CONTRACT_ID = CC.CONTRACT_ID;
                
                else
                
                  update spm_con_ht_info f
                     set f.status = 'A', f.error_msg = '存在相同的商品编码'
                   where f.contract_id = CC.CONTRACT_ID;
                
                end if;
              
                UPDATE SPM_CON_MQ_SM_PUR_ORDER T
                   SET T.ATTRIBUTE1 = 'ED'
                 WHERE T.ID =
                       (SELECT FF.ID
                          FROM SPM_CON_MQ_SM_PUR_ORDER FF
                         WHERE FF.ORDER_NO = CC.CONTRACT_CODE);
              
                MSG_A := CC.CONTRACT_CODE || '采购订单认领成功';
              
              END IF;
            
            END IF;
          ELSE
            MSG_A := CC.CONTRACT_CODE || '已关联框架或者供应商，数据异常，请联系系统管理员';
          END IF;
        
        END IF;
      
        IF CC.IN_OUT_TYPE = '1' THEN
        
          --先查一下此条合同是否关联了项目和供应商
          SELECT COUNT(*)
            INTO PROJECT_COUNT1
            FROM SPM_CON_HT_PROJECT T
           WHERE T.CONTRACT_ID = C.PROVINCE;
        
          SELECT COUNT(*)
            INTO HT_MERCHANTS_COUNT1
            FROM SPM_CON_HT_MERCHANTS T
           WHERE T.CONTRACT_ID = C.PROVINCE;
          IF PROJECT_COUNT1 > 0 OR HT_MERCHANTS_COUNT1 > 0 THEN
            MSG_B  := CC.CONTRACT_CODE || '已有项目或者关联的客户，数据异常，请联系系统管理员 ' ||
                      MSG_B;
            MSG_C2 := '已有项目或者关联的客户，数据异常，请联系系统管理员 ';
          END IF;
        
          SELECT T.ASSIGN_PURORG_ID
            INTO ASSIGN_PURORG_ID
            FROM SPM_CON_MQ_SM_SALE_ORDER T
           WHERE T.ORDER_CODE = CC.CONTRACT_CODE;
        
          IF PROJECT_COUNT1 = 0 AND HT_MERCHANTS_COUNT1 = 0 THEN
            SELECT TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS(TO_CHAR(ASSIGN_PURORG_ID),
                                                                CC.ORG_ID))
              INTO V_1
              FROM DUAL;
          
            IF V_1 = -1 THEN
              MSG_B  := CC.CONTRACT_CODE || '电商未推送该客户或者推送信息不完整 ' || MSG_B;
              MSG_A2 := '电商未推送该客户或者推送信息不完整 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A2 || MSG_C2
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -2 THEN
              MSG_B  := CC.CONTRACT_CODE || '电商已推送该客户，尚未进入业财系统 ' || MSG_B;
              MSG_A2 := '电商已推送该客户，尚未进入业财系统 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A2 || MSG_C2
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -3 THEN
              MSG_B  := CC.CONTRACT_CODE || '客户审核未完成 ' || MSG_B;
              MSG_A2 := '客户审核未完成 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A2 || MSG_C2
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -4 THEN
              MSG_B  := CC.CONTRACT_CODE || '客户在当前组织下未同步 ' || MSG_B;
              MSG_A2 := '客户在当前组织下未同步 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A2 || MSG_C2
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 = -5 THEN
              MSG_B  := CC.CONTRACT_CODE || '查找客户异常，请联系系统管理员 ' || MSG_B;
              MSG_A2 := '查找客户异常，请联系系统管理员 ';
              UPDATE SPM_CON_HT_INFO T
                 SET T.ERROR_MSG = MSG_A2 || MSG_C2
               WHERE T.CONTRACT_ID = C.PROVINCE;
            END IF;
          
            IF V_1 > 0 THEN
              --查一下是否有这个框架合同
            
              SELECT COUNT(*)
                INTO V_2
                FROM SPM_CON_HT_INFO      S,
                     SPM_CON_HT_PROJECT   T,
                     SPM_CON_PROJECT      D,
                     SPM_CON_CUST_INFO    E,
                     SPM_CON_HT_MERCHANTS A
               WHERE 1 = 1
                    
                 AND S.CONTRACT_ID = T.CONTRACT_ID
                 AND T.PROJECT_ID = D.PROJECT_ID
                 AND S.CONTRACT_ID = A.CONTRACT_ID
                 AND E.CUST_ID = A.MERCHANTS_ID
                 AND (SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y' OR
                     SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_KJXY(S.CONTRACT_ID) = 'Y')
                 AND S.CONTRACT_FORM = '4'
                 AND S.IN_OUT_TYPE = '1'
                 AND S.ORG_ID = CC.ORG_ID
                 AND S.START_DATE <= trunc(CC.CREATION_DATE,'dd')
                 AND S.END_DATE >= trunc(CC.CREATION_DATE,'dd')
                 AND E.CUST_ID = V_1;
            
              IF V_2 = 0 THEN
                MSG_B  := CC.CONTRACT_CODE || '销售订单认领失败，未找到框架协议' || MSG_B;
                MSG_B2 := '销售订单认领失败，未找到框架协议';
                UPDATE SPM_CON_HT_INFO T
                   SET T.ERROR_MSG = MSG_A2 || MSG_C2 || MSG_B2
                 WHERE T.CONTRACT_ID = C.PROVINCE;
              
              END IF;
            
              IF V_2 > 1 THEN
                MSG_B  := CC.CONTRACT_CODE ||
                          '销售订单认领失败，找到多条可匹配的框架，请手动选择确认要关联的框架' || MSG_B;
                MSG_B2 := '销售订单认领失败，找到多条可匹配的框架，请手动选择确认要关联的框架';
                UPDATE SPM_CON_HT_INFO T
                   SET T.ERROR_MSG = MSG_A2 || MSG_C2 || MSG_B2
                 WHERE T.CONTRACT_ID = C.PROVINCE;
              
              END IF;
              --找到多条可匹配的框架，请手动选择确认要关联的框架
              IF V_2 = 1 THEN
                --框架合同
                SELECT MAX(D.PROJECT_ID),
                       MAX(S.DEPT_ID),
                       MAX(S.CREATED_BY),
                       MAX(S.CONTRACT_ID)
                  INTO V_PROJECT_ID,
                       V_DEPT_ID,
                       V_CREATED_BY,
                       KJ_CONTRACT_ID
                  FROM SPM_CON_HT_INFO      S,
                       SPM_CON_HT_PROJECT   T,
                       SPM_CON_PROJECT      D,
                       SPM_CON_CUST_INFO    E,
                       SPM_CON_HT_MERCHANTS A
                 WHERE 1 = 1
                      
                   AND S.CONTRACT_ID = T.CONTRACT_ID
                   AND T.PROJECT_ID = D.PROJECT_ID
                   AND S.CONTRACT_ID = A.CONTRACT_ID
                   AND E.CUST_ID = A.MERCHANTS_ID
                   AND (SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y' OR
                       SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_KJXY(S.CONTRACT_ID) = 'Y')
                   AND S.CONTRACT_FORM = '4'
                   AND S.IN_OUT_TYPE = '1'
                   AND S.ORG_ID = CC.ORG_ID
                   AND S.START_DATE <= trunc(CC.CREATION_DATE,'dd')
                   AND S.END_DATE >= trunc(CC.CREATION_DATE,'dd')
                   AND E.CUST_ID = V_1;
              
                --插入项目
                --主键
                INSERT INTO SPM_CON_HT_PROJECT
                  (CON_PRO_RELATION_ID,
                   CONTRACT_ID,
                   PROJECT_ID,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_PROJECT_SEQ.NEXTVAL,
                   CC.CONTRACT_ID,
                   V_PROJECT_ID,
                   'DSXS');
              
                --插入供应商
                -- 主键
                INSERT INTO SPM_CON_HT_MERCHANTS
                  (CON_MERCHANTS_ID,
                   MERCHANTS_ID,
                   CONTRACT_ID,
                   MERCHANTS_FLAG,
                   IN_OUT_TYPE,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
                   V_1,
                   CC.CONTRACT_ID,
                   1,
                   '1',
                   'DSXS');
                --关联框架协议
                INSERT INTO SPM_CON_HT_RELATION T
                  (T.RELATION_ID,
                   T.CONTRACT_ID,
                   T.CONTRACT_ID_R,
                   T.RELATION_SHIP,
                   T.RELATION_BUSINESS,
                   T.RELATION_ACTION,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
                   C.PROVINCE,
                   KJ_CONTRACT_ID,
                   '3',
                   '3',
                   '2',
                   'DS');
              
                INSERT INTO SPM_CON_HT_RELATION T
                  (T.RELATION_ID,
                   T.CONTRACT_ID,
                   T.CONTRACT_ID_R,
                   T.RELATION_SHIP,
                   T.RELATION_BUSINESS,
                   T.RELATION_ACTION,
                   ATTRIBUTE1)
                VALUES
                  (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
                   KJ_CONTRACT_ID,
                   C.PROVINCE,
                   '3',
                   '3',
                   '1',
                   'DS');
              
                select t.order_id
                  into K_order_id
                  from spm_con_mq_sm_sale_order t
                 where t.order_code = CC.CONTRACT_CODE;
              
                begin
                  select count(*)
                    into k_repeat_number
                    from spm_con_mq_sm_sale_order_dtl t
                   where t.order_id = K_order_id
                     and t.ny_datang_material_code is not null
                   group by t.ny_datang_material_code
                  having count(*) > 1;
                exception
                  when others then
                    k_repeat_number := 0;
                end;
              
                if k_repeat_number = 0 then
                
                  --合同表加入人员和部门(框架合同)
                  UPDATE SPM_CON_HT_INFO T
                     SET T.DEPT_ID          = V_DEPT_ID,
                         T.CREATED_BY       = V_CREATED_BY,
                         T.STATUS           = 'E',
                         T.ERROR_MSG        = NULL,
                         T.LAST_UPDATE_DATE = SYSDATE,
                         T.LAST_UPDATED_BY  = SPM_SSO_PKG.GETUSERID
                   WHERE T.CONTRACT_ID = CC.CONTRACT_ID;
                
                else
                
                  update spm_con_ht_info f
                     set f.status = 'A', f.error_msg = '存在相同的商品编码'
                   where f.contract_id = CC.CONTRACT_ID;
                
                end if;
              
                UPDATE SPM_CON_MQ_SM_SALE_ORDER T
                   SET T.ATTRIBUTE1 = 'ED'
                 WHERE T.ORDER_ID =
                       (SELECT FF.ORDER_ID
                          FROM SPM_CON_MQ_SM_SALE_ORDER FF
                         WHERE FF.ORDER_CODE = CC.CONTRACT_CODE);
              
                MSG_B := CC.CONTRACT_CODE || '销售订单认领成功' || MSG_B;
              
              END IF;
            
            END IF;
          END IF;
        
        END IF;
      
      END LOOP;
    END LOOP;
  
    P_MSG := MSG_A || MSG_B;
  END;

  --合同台账导入IMPORT
  PROCEDURE HT_ORDER_IMPORT(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            F_TABLENAME VARCHAR2,
                            F_TABLEID   VARCHAR2,
                            P_MSG       OUT VARCHAR2) IS
  
    --订单台账-主信息
    CURSOR CU_DATA IS
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
             TRIM(M), --
             TRIM(N), --
             TRIM(O), --制单时间
             TRIM(P) --备注
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '订单台账-主信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --订单台账-主信息(关联关系)
    CURSOR CU_DATAS IS
      SELECT TRIM(A), TRIM(B)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '订单台账-主信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --1.订单台账-标的物信息
    CURSOR CU_DATA1 IS
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
             TRIM(M), --
             TRIM(N), --
             TRIM(O)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
         AND SHEET_NAME = '订单台账-标的物信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --2.订单台账-收货人信息
    CURSOR CU_DATA2 IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-收货人信息'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --3.订单台账-开票人信息
    CURSOR CU_DATA3 IS
      SELECT TRIM(A),
             TRIM(B),
             TRIM(C),
             TRIM(D),
             TRIM(E),
             TRIM(F),
             TRIM(G),
             TRIM(H),
             TRIM(I)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-开票人信息'
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000); --日期
    VALIDATE_P VARCHAR2(2000);
  
    VALIDATE_AS VARCHAR2(2000);
    VALIDATE_BS VARCHAR2(2000);
  
    VALIDATE_EXIST    NUMBER;
    VALIDATE_ID       NUMBER;
    VALIDATE_ID2      NUMBER;
    V_INFO_ID         NUMBER;
    VALIDATE_NUMBER1  NUMBER;
    VALIDATE_NUMBER2  NUMBER;
    VALIDATE_NUMBER3  NUMBER;
    VALIDATE_NUMBER4  NUMBER;
    VALIDATE_NUMBER5  NUMBER;
    VALIDATE_NUMBER6  NUMBER;
    VALIDATE_NUMBER7  NUMBER;
    VALIDATE_NUMBER8  NUMBER;
    VALIDATE_NUMBER9  NUMBER;
    VALIDATE_NUMBER10 NUMBER;
    TAX_RATE1         NUMBER;
  
    --1.订单台账-标的物信息
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
    VALIDATE_C1 VARCHAR2(2000);
    VALIDATE_D1 VARCHAR2(2000);
    VALIDATE_E1 VARCHAR2(2000);
    VALIDATE_F1 VARCHAR2(2000);
    VALIDATE_G1 VARCHAR2(2000);
    VALIDATE_H1 VARCHAR2(2000);
    VALIDATE_I1 VARCHAR2(2000);
    VALIDATE_J1 VARCHAR2(2000);
    VALIDATE_K1 VARCHAR2(2000);
    VALIDATE_L1 VARCHAR2(2000);
    VALIDATE_M1 VARCHAR2(2000);
    VALIDATE_N1 VARCHAR2(2000);
    VALIDATE_O1 VARCHAR2(2000);
  
    --2.订单台账-收货人信息
    VALIDATE_A2 VARCHAR2(2000);
    VALIDATE_B2 VARCHAR2(2000);
    VALIDATE_C2 VARCHAR2(2000);
    VALIDATE_D2 VARCHAR2(2000);
    VALIDATE_E2 VARCHAR2(2000);
  
    --3.订单台账-收货人信息
    VALIDATE_A3 VARCHAR2(2000);
    VALIDATE_B3 VARCHAR2(2000);
    VALIDATE_C3 VARCHAR2(2000);
    VALIDATE_D3 VARCHAR2(2000);
    VALIDATE_E3 VARCHAR2(2000);
    VALIDATE_F3 VARCHAR2(2000);
    VALIDATE_G3 VARCHAR2(2000);
    VALIDATE_H3 VARCHAR2(2000);
    VALIDATE_I3 VARCHAR2(2000);
  
  BEGIN
    OPEN CU_DATA;
    OPEN CU_DATAS;
    OPEN CU_DATA1;
    OPEN CU_DATA2;
    OPEN CU_DATA3;
  
    --订单台账-主信息
    FETCH CU_DATA
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
           VALIDATE_P;
  
    --订单台账-主信息
    FETCH CU_DATAS
      INTO VALIDATE_AS, VALIDATE_BS;
  
    --1.订单台账-标的物信息
    FETCH CU_DATA1
      INTO VALIDATE_A1,
           VALIDATE_B1,
           VALIDATE_C1,
           VALIDATE_D1,
           VALIDATE_E1,
           VALIDATE_F1,
           VALIDATE_G1,
           VALIDATE_H1,
           VALIDATE_I1,
           VALIDATE_J1,
           VALIDATE_K1,
           VALIDATE_L1,
           VALIDATE_M1,
           VALIDATE_N1,
           VALIDATE_O1;
  
    --2.订单台账-收货人信息
    FETCH CU_DATA2
      INTO VALIDATE_A2, VALIDATE_B2, VALIDATE_C2, VALIDATE_D2, VALIDATE_E2;
  
    --3.订单台账-收货人信息
    FETCH CU_DATA3
      INTO VALIDATE_A3,
           VALIDATE_B3,
           VALIDATE_C3,
           VALIDATE_D3,
           VALIDATE_E3,
           VALIDATE_F3,
           VALIDATE_G3,
           VALIDATE_H3,
           VALIDATE_I3;
  
    WHILE CU_DATA%FOUND LOOP
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_M IS NULL THEN
        VALIDATE_M := 0;
      END IF;
    
      INSERT INTO SPM_CON_HT_INFO
        (CONTRACT_ID, --主键
         PURCHASE_ORG, --采购组织
         CONTRACT_NAME, --合同名称
         CONTRACT_CODE, --合同编码
         IN_OUT_TYPE, --收支类型
         ORDER_TYPE, --订单类别
         VENDOR_NAME, --供应商名称
         BUYER_NAME,
         PURCHASE_DEPT, --采购部门
         BUYER_TEL, --采购员电话
         CONTRACT_AMOUNT, --订单金额
         CURRENCY_TYPE, --币种
         RMB_TOTAL, --折合人民币
         TAX_RATE, --税率
         CREATION_DATE, --制单时间
         CONTRACT_REMARK, --订单简介
         DEPT_ID, --部门
         ORG_ID, --组织
         CREATED_BY, --USER_ID
         STATUS_CHANGE,
         CONTRACT_TYPE, --合同类型(区分订单和普通)
         IS_URGENT,
         STATUS,
         CONTRACT_VERSION, --合同版本
         STATUS_ARCHIVED,
         CONTRACT_FLAG,
         ATTRIBUTE3,
         LAST_UPDATE_DATE,
         ATTRIBUTE1)
      VALUES
        (V_INFO_ID, --主键
         VALIDATE_A, --采购组织
         VALIDATE_C, --合同名称
         VALIDATE_B, --合同编号
         --GET_DICTCODE_BY_NAME('SPM_CON_HT_INOUT_TYPE',VALIDATE_D),--收支类型
         --(CASE WHEN VALIDATE_B LIKE '-1%' THEN '2' ELSE  '1' END),--订单类别
         (CASE WHEN (SELECT SUBSTR(VALIDATE_B， - 2) FROM DUAL) = '-1' THEN '2' ELSE '1' END), --收支类型
         (CASE WHEN (SELECT SUBSTR(VALIDATE_B， - 2) FROM DUAL) = '-1' THEN '2' ELSE '1' END), --收支类型
         VALIDATE_F, --供应商名称
         VALIDATE_G, --采购员
         VALIDATE_H, --采购部门
         VALIDATE_I, --采购员电话
         VALIDATE_J, --订单金额
         --(SELECT T.CURRENCY_CODE FROM FND_CURRENCIES_VL T WHERE T.ENABLED_FLAG = 'Y' AND T.NAME=VALIDATE_K) ,
         --(SELECT T.CURRENCY_CODE  FROM FND_CURRENCIES_VL T WHERE T.ENABLED_FLAG = 'Y' AND (T.END_DATE_ACTIVE IS NULL OR T.END_DATE_ACTIVE > SYSDATE) AND T.NAME=VALIDATE_K),--币种 取EBS
         (CASE WHEN VALIDATE_K LIKE '%人民%' THEN 'CNY' ELSE 'USD' END), --收支类型
         VALIDATE_L, --折合人民币
         --(CASE WHEN VALIDATE_M LIKE '%%%' THEN (SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_M,'%',0) FROM DUAL) ELSE  VALIDATE_M END),
         VALIDATE_M,
         TO_DATE(SUBSTR(VALIDATE_N, 1, 10), 'YYYY-MM-DD'), --制单时间
         VALIDATE_O, --备注
         /*         SPM_EAM_COMMON_PKG.GET_DEPTID_BY_PERSONID(SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(SPM_SSO_PKG.GETUSERID)),
         SPM_SSO_PKG.GETORGID,
         SPM_SSO_PKG.GETUSERID,*/
         (SELECT T.ORGANIZATION_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE T.USER_ID = SPM_SSO_PKG.GETUSERID
             AND T.BELONGORGID = SPM_SSO_PKG.GETORGID),
         SPM_SSO_PKG.GETORGID,
         SPM_SSO_PKG.GETUSERID,
         '1',
         '2',
         '0',
         'E',
         '1',
         'J',
         (SELECT SYS_GUID() FROM DUAL),
         '1',
         SYSDATE,
         '1'
         
         );
      COMMIT;
    
      /*  IF VALIDATE_B NOT LIKE '-1%'  THEN
      SELECT COUNT(*) INTO VALIDATE_NUMBER2 FROM SPM_CON_HT_INFO T WHERE T.CONTRACT_CODE=VALIDATE_B;
      SELECT COUNT(*) INTO VALIDATE_NUMBER3 FROM SPM_CON_HT_INFO T WHERE T.CONTRACT_CODE=VALIDATE_B||'-1';
      IF VALIDATE_NUMBER2>0 AND  VALIDATE_NUMBER3>0 THEN
          INSERT INTO SPM_CON_HT_RELATION T
            (
            RELATION_ID  ,  --N      主键
            CONTRACT_ID  ,  --N      合同主键
            CONTRACT_ID_R  ,  --Y      关联合同编号
            --RELATION_SHIP,  --Y      关联关系
            --RELATION_BUSINESS, --  Y      业务关系
            RELATION_ACTION,  --Y      关联方(1我方2对方)
            ATTRIBUTE1
            )
            VALUES
            (
            SPM_CON_HT_RELATION_SEQ.NEXTVAL,
            (SELECT F.CONTRACT_ID FROM SPM_CON_HT_INFO F WHERE F.CONTRACT_CODE=VALIDATE_B),
            (SELECT F.CONTRACT_ID FROM SPM_CON_HT_INFO F WHERE F.CONTRACT_CODE=VALIDATE_B||'-1'),
            '1',
            '订单标识'
            );
      
            INSERT INTO SPM_CON_HT_RELATION T
            (
            RELATION_ID  ,  --N      主键
            CONTRACT_ID  ,  --N      合同主键
            CONTRACT_ID_R  ,  --Y      关联合同编号
            --RELATION_SHIP,  --Y      关联关系
            --RELATION_BUSINESS, --  Y      业务关系
            RELATION_ACTION,  --Y      关联方(1我方2对方)
            ATTRIBUTE1
            )
            VALUES
            (
            SPM_CON_HT_RELATION_SEQ.NEXTVAL,
            (SELECT F.CONTRACT_ID FROM SPM_CON_HT_INFO F WHERE F.CONTRACT_CODE=VALIDATE_B||'-1'),
            (SELECT F.CONTRACT_ID FROM SPM_CON_HT_INFO F WHERE F.CONTRACT_CODE=VALIDATE_B),
            '2',
            '订单标识'
            );
      
          END IF;
            END IF;*/
    
      /*    --合同存在时UPDATE 第一种情况
            IF VALIDATE_NUMBER1=3 AND VALIDATE_CONTRACT_CODE=1  THEN
            SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D,'>',0) INTO VALIDATE_7 FROM DUAL;
            SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D,'>',1) INTO VALIDATE_8 FROM DUAL;
            SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D,'>',2) INTO VALIDATE_9 FROM DUAL;
            SELECT SPM_CON_ODO_PKG.GET_STRARRAYSTROFINDEX(VALIDATE_D,'>',3) INTO VALIDATE_10 FROM DUAL;
      
           UPDATE SPM_CON_HT_INFO  SET
              CONTRACT_NAME = VALIDATE_A,
              BUSINESS_TYPE = (SELECT T.BIS_TYPE_ID FROM SPM_CON_HT_BIS_TYPE T WHERE T.TYPE_NAME=VALIDATE_C),--业务类型
              CONTRACT_CATEGORY = (SELECT T.CATEGORY_ID FROM SPM_CON_CONTRACT_CATEGORY T WHERE T.CATEGORY_NAME=VALIDATE_10 AND T.PARENT_ID=(SELECT T.CATEGORY_ID FROM SPM_CON_CONTRACT_CATEGORY T WHERE T.CATEGORY_NAME=VALIDATE_9 AND T.PARENT_ID=(SELECT T.CATEGORY_ID FROM SPM_CON_CONTRACT_CATEGORY T WHERE T.CATEGORY_NAME=VALIDATE_8 AND T.PARENT_ID=(SELECT T.CATEGORY_ID FROM SPM_CON_CONTRACT_CATEGORY T WHERE T.CATEGORY_NAME=VALIDATE_7)))),--合同类型
              MAIN_TARGET = (SELECT T.MTARGET_ID FROM SPM_CON_HT_M_TARGET T WHERE T.MTARGET_NAME=VALIDATE_F),--主要标的物
              IN_OUT_TYPE = GET_DICTCODE_BY_NAME('SPM_CON_HT_INOUT_TYPE',VALIDATE_E),--收支类型
              IS_PRODUCT_CATALOG = (CASE WHEN VALIDATE_G='是' THEN '1' ELSE  '0' END),--目录范围内产品
              SUBJECT_DEPT_ID = (SELECT T.ORGANIZATION_ID FROM HR_OPERATING_UNITS T  WHERE T.NAME=VALIDATE_H),--执行主体
              CONTRACT_FORM = GET_DICTCODE_BY_NAME('SPM_CON_HT_FORM',VALIDATE_I),--合同形式
              CONTRACT_AMOUNT = VALIDATE_J,--合同金额
              CURRENCY_TYPE = (SELECT T.CURRENCY_CODE FROM FND_CURRENCIES_VL T WHERE T.ENABLED_FLAG = 'Y' AND T.NAME=VALIDATE_K),--币种
              EXCHANGE_RATE = VALIDATE_L,--汇率
              RMB_TOTAL = VALIDATE_J*VALIDATE_L,
              MORE_LESS_RATIO = VALIDATE_M,--溢短装比例
              IS_ADVANCE = GET_DICTCODE_BY_NAME('SPM_CON_HT_IS_ADVANCE',VALIDATE_N),--是否垫资
              CONTRACT_CODE_OPPSITE = VALIDATE_O,--对方合同编号
              PM_PERSON_ID = (SELECT T.USER_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_P AND SPM_SSO_PKG.GETORGID=T.BELONGORGID),--项目经理,--项目经理
              CONTRACT_REMARK = VALIDATE_U,
              ATTRIBUTE3='1',
              LAST_UPDATE_DATE=SYSDATE,
      \*        START_DATE = TO_DATE(SUBSTR(VALIDATE_S, 1, 10), 'YYYY-MM-DD'),--履行期限
              END_DATE = TO_DATE(SUBSTR(VALIDATE_T, 1, 10), 'YYYY-MM-DD'),--到
              CREATION_DATE = TO_DATE(SUBSTR(VALIDATE_R, 1, 10), 'YYYY-MM-DD'),--创建日期*\
              DEPT_ID = (SELECT T.ORGANIZATION_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_Q AND SPM_SSO_PKG.GETORGID=T.BELONGORGID),--部门
              ORG_ID = SPM_SSO_PKG.GETORGID,--组织
              CREATED_BY = (SELECT T.USER_ID FROM SPM_CON_HT_PEOPLE_V T WHERE T.FULL_NAME=VALIDATE_Q AND SPM_SSO_PKG.GETORGID=T.BELONGORGID)--USER_ID
              WHERE CONTRACT_CODE=VALIDATE_B;
       END IF;*/
    
      FETCH CU_DATA
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
             VALIDATE_P;
    
    END LOOP;
  
    --1.关联关系
    WHILE CU_DATAS%FOUND LOOP
      IF VALIDATE_BS NOT LIKE '-1%' THEN
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER2
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_BS;
        SELECT COUNT(*)
          INTO VALIDATE_NUMBER3
          FROM SPM_CON_HT_INFO T
         WHERE T.CONTRACT_CODE = VALIDATE_BS || '-1';
        IF VALIDATE_NUMBER2 > 0 AND VALIDATE_NUMBER3 > 0 THEN
          INSERT INTO SPM_CON_HT_RELATION T
            (RELATION_ID, --N      主键
             CONTRACT_ID, --N      合同主键
             CONTRACT_ID_R, --Y      关联合同编号
             --RELATION_SHIP,  --Y      关联关系
             --RELATION_BUSINESS, --  Y      业务关系
             RELATION_ACTION, --Y      关联方(1我方2对方)
             ATTRIBUTE1)
          VALUES
            (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_BS),
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_BS || '-1'),
             '1',
             '订单标识');
        
          INSERT INTO SPM_CON_HT_RELATION T
            (RELATION_ID, --N      主键
             CONTRACT_ID, --N      合同主键
             CONTRACT_ID_R, --Y      关联合同编号
             --RELATION_SHIP,  --Y      关联关系
             --RELATION_BUSINESS, --  Y      业务关系
             RELATION_ACTION, --Y      关联方(1我方2对方)
             ATTRIBUTE1)
          VALUES
            (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_BS || '-1'),
             (SELECT F.CONTRACT_ID
                FROM SPM_CON_HT_INFO F
               WHERE F.CONTRACT_CODE = VALIDATE_BS),
             '2',
             '订单标识');
        
        END IF;
      END IF;
    
      FETCH CU_DATAS
        INTO VALIDATE_AS, VALIDATE_BS;
    
    END LOOP;
  
    --1.订单台账-标的物信息
    WHILE CU_DATA1%FOUND LOOP
    
      SELECT T.TAX_RATE
        INTO TAX_RATE1
        FROM SPM_CON_HT_INFO T
       WHERE T.CONTRACT_CODE = VALIDATE_A1;
    
      INSERT INTO SPM_CON_HT_TARGET
        (TARGET_ID, --ID
         CONTRACT_ID, --合同ID
         IS_DELETE,
         GOODS_CLASS, --商品小类
         MATERIAL_CODE, --合同编码
         MATERIAL_NAME, --合同名称
         TARGET_PARAMS, --商品参数
         SPECIFICATION_MODEL, --规格型号
         SPECIFICATION_PACKING, --包装规格
         TARGET_UNIT, --供货单位
         TARGET_COUNT, --订购数量
         UNIT_PRICE, --单价
         TARGET_AMOUNT, --金额
         TAX_RATE, --税率
         TAX_AMOUNT, --税额
         NOTAX_AMOUNT, --不含税金额
         REMARK, --备注
         ORG_ID,
         ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_TARGET_SEQ.NEXTVAL,
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A1), --合同主键
         0, --是否删除
         VALIDATE_B1, --商品小类
         VALIDATE_C1, --合同编号
         VALIDATE_D1, --合同名称
         VALIDATE_E1, --商品参数
         VALIDATE_F1, --规格型号
         VALIDATE_G1, --包装规格
         VALIDATE_H1, --供货单位
         VALIDATE_I1, --订货数量
         VALIDATE_J1, --单价
         VALIDATE_I1 * VALIDATE_J1, --订货金额
         -- VALIDATE_L1,--税率
         --(VALIDATE_I1*VALIDATE_J1 - VALIDATE_I1*VALIDATE_J1 / (1+VALIDATE_L1 / 100)),--税额
         --(VALIDATE_I1*VALIDATE_J1 / (1+VALIDATE_L1 / 100)),--不含税金额
         TAX_RATE1,
         (VALIDATE_I1 * VALIDATE_J1 -
         VALIDATE_I1 * VALIDATE_J1 / (1 + TAX_RATE1 / 100)), --税额
         (VALIDATE_I1 * VALIDATE_J1 / (1 + TAX_RATE1 / 100)), --不含税金额
         VALIDATE_O1, --备注
         SPM_SSO_PKG.GETORGID,
         '1');
    
      FETCH CU_DATA1
        INTO VALIDATE_A1,
             VALIDATE_B1,
             VALIDATE_C1,
             VALIDATE_D1,
             VALIDATE_E1,
             VALIDATE_F1,
             VALIDATE_G1,
             VALIDATE_H1,
             VALIDATE_I1,
             VALIDATE_J1,
             VALIDATE_K1,
             VALIDATE_L1,
             VALIDATE_M1,
             VALIDATE_N1,
             VALIDATE_O1;
    END LOOP;
  
    --订单台账-收货人信息  A2
    WHILE CU_DATA2%FOUND LOOP
      INSERT INTO SPM_CON_HT_RECEIVER
        (RECEIVER_ID, --  10000017
         CONTRACT_ID, --  10093297
         RECEIVE_USER, --付晓升
         RECEIVE_ORG, --中国水利电力物资集团有限公司本部
         RECEIVE_TEL, --0313-7033102
         RECEIVE_ADDRESS, --  河北省张家口市宣化区河子西乡朱家庄大唐国际张家口发电厂
         ORG_ID, --81
         DEPT_ID, --141
         CREATED_BY, --3640
         CREATION_DATE, --2018/5/17 14:11:52
         ATTRIBUTE1
         
         )
      VALUES
        (SPM_CON_HT_RECEIVER_SEQ.NEXTVAL,
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A2), --主键
         VALIDATE_B2,
         VALIDATE_C2, --收货单位
         VALIDATE_D2, --收货电话
         VALIDATE_E2, --收货地址
         (SELECT T.ORG_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A2),
         (SELECT T.DEPT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A2),
         (SELECT T.CREATED_BY
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A2),
         (SELECT T.CREATION_DATE
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A2),
         '1');
    
      FETCH CU_DATA2
        INTO VALIDATE_A2,
             VALIDATE_B2,
             VALIDATE_C2,
             VALIDATE_D2,
             VALIDATE_E2;
    END LOOP;
  
    --订单台账-开票人信息
    WHILE CU_DATA3%FOUND LOOP
      INSERT INTO SPM_CON_HT_INVOICE
        (INVOICE_ID, --  10000017
         CONTRACT_ID, --  10093297
         INVOICE_BANK, --  工行樱桃园支行
         INVOICE_ACCOUNT, --  0200000609002700631
         INVOICE_RATE_NUMBER, --  110104101625739
         INVOICE_TEL, --  010-68777673
         INVOICE_USER, --
         INVOICE_TYPE, --  01
         INVOICE_ADDRESS, --  北京市石景山区政达路6号院3号楼北方国际大厦
         REMARK, --  SS
         ORG_ID, --  81
         DEPT_ID, --  141
         CREATED_BY, --  3640
         CREATION_DATE, --  2018/5/17 14:11:52
         ATTRIBUTE1)
      VALUES
        (SPM_CON_HT_INVOICE_SEQ.NEXTVAL,
         (SELECT T.CONTRACT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3), --主键
         VALIDATE_B3, --开票银行
         VALIDATE_C3, --开票账号
         VALIDATE_D3, --开票税号
         VALIDATE_E3, --开票电话
         VALIDATE_F3, --开票联系人
         GET_DICTCODE_BY_NAME('SPM_CON_HT_INVOICE_TYPE', VALIDATE_G3), --收支类型,--发票类型
         VALIDATE_H3, --开票地址
         VALIDATE_I3, --发票备注
         (SELECT T.ORG_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3),
         (SELECT T.DEPT_ID
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3),
         (SELECT T.CREATED_BY
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3),
         (SELECT T.CREATION_DATE
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_A3),
         '1');
    
      FETCH CU_DATA3
        INTO VALIDATE_A3,
             VALIDATE_B3,
             VALIDATE_C3,
             VALIDATE_D3,
             VALIDATE_E3,
             VALIDATE_F3,
             VALIDATE_G3,
             VALIDATE_H3,
             VALIDATE_I3;
    
    END LOOP;
  
    CLOSE CU_DATA;
    CLOSE CU_DATAS;
    CLOSE CU_DATA1;
    CLOSE CU_DATA2;
    CLOSE CU_DATA3;
  
    COMMIT;
  
  END;

  PROCEDURE HT_ORDER_VALIDATE(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              P_MSG       OUT VARCHAR2) IS
    --订单台账-主信息
    CURSOR CU_DATA IS
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
             TRIM(O)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-主信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --1.订单台账-标的物信息
    CURSOR CU_DATA1 IS
      SELECT TRIM(A), TRIM(B)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-标的物信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --2.订单台账-收货人信息
    CURSOR CU_DATA2 IS
      SELECT TRIM(A), TRIM(B)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-收货人信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --3.订单台账-开票人信息
    CURSOR CU_DATA3 IS
      SELECT TRIM(A), TRIM(B)
      
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND SHEET_NAME = '订单台账-开票人信息'
       ORDER BY TO_NUMBER(ROW_NUMBER);
  
    --变量
    VALIDATE_A VARCHAR2(2000);
    VALIDATE_B VARCHAR2(2000);
    VALIDATE_C VARCHAR2(2000);
    VALIDATE_D VARCHAR2(2000);
    VALIDATE_E VARCHAR2(2000);
    VALIDATE_F VARCHAR2(2000);
    VALIDATE_G VARCHAR2(2000);
    VALIDATE_H VARCHAR2(2000);
    VALIDATE_I VARCHAR2(2000);
    VALIDATE_J VARCHAR2(2000);
    VALIDATE_K VARCHAR2(2000);
    VALIDATE_L VARCHAR2(2000);
    VALIDATE_M VARCHAR2(2000);
    VALIDATE_N VARCHAR2(2000);
    VALIDATE_O VARCHAR2(2000);
  
    --1.工程信息
    VALIDATE_A1 VARCHAR2(2000);
    VALIDATE_B1 VARCHAR2(2000);
  
    --2.标的物信息
    VALIDATE_A2 VARCHAR2(2000);
    VALIDATE_B2 VARCHAR2(2000);
  
    --3.收付款条款
    VALIDATE_A3 VARCHAR2(2000);
    VALIDATE_B3 VARCHAR2(2000);
  
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    VALIDATE_NUMBER5 NUMBER;
  
    --合同主信息
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
  
    --1.工程信息
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
  
    --2.标的物信息
    MSG_A2 VARCHAR2(4000);
    MSG_B2 VARCHAR2(4000);
  
    --3.收付款信息
    MSG_A3 VARCHAR2(4000);
    MSG_B3 VARCHAR2(4000);
  
    --报错提示信息
    P_MSG1 VARCHAR2(4000);
    P_MSG2 VARCHAR2(4000);
    P_MSG3 VARCHAR2(4000);
  
  BEGIN
    OPEN CU_DATA;
  
    FETCH CU_DATA
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
           VALIDATE_O;
  
    /*          --工程信息
    FETCH CU_DATA1
         INTO VALIDATE_A1,
              VALIDATE_B1;
    
    --工程信息
    FETCH CU_DATA2
         INTO VALIDATE_A2,
              VALIDATE_B2;
    
    --工程信息
    FETCH CU_DATA3
         INTO VALIDATE_A3,
              VALIDATE_B3;*/
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
    
      FETCH CU_DATA
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
             VALIDATE_O;
    
      WHILE CU_DATA%FOUND LOOP
      
        --验证相同合同编号存在 不让导入
        IF VALIDATE_E <> '采购订单' AND VALIDATE_E <> '销售订单' THEN
          MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
        END IF;
      
        IF VALIDATE_B IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER3
            FROM SPM_CON_HT_INFO T
           WHERE T.CONTRACT_CODE = VALIDATE_B;
          IF VALIDATE_NUMBER3 > 0 THEN
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA
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
               VALIDATE_O;
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '行 必须填写采购订单或者销售订单;';
      END IF;
    
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 订单合同已导入,请勿重复导入;';
      END IF;
    
    END IF;
  
    P_MSG := P_MSG || MSG_A || MSG_B;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    
    END IF;
  
  END;
  --入库单均摊成本计算
  FUNCTION WAREHOUSE_COST_SHARING(V_WAREHOUSE_DL_ID NUMBER) RETURN NUMBER IS
  
    V_SHARE_UNIT_PRICE   NUMBER := 0;
    WAREHOUSE_DL_INF     SPM_CON_WAREHOUSE_DL%ROWTYPE;
    WAREHOUSE_INF        SPM_CON_WAREHOUSE%ROWTYPE;
    V_WAREHOUSE_DL_LINE  NUMBER;
    V_COST_SHARING_PART1 NUMBER;
    V_COST_SHARING_PART2 NUMBER;
    V_COST_SHARING_PART3 NUMBER;
    V_NUMBER             NUMBER;
    LINE_MONEY           NUMBER;
    P92_MONEY            NUMBER;
  BEGIN
    --入库子表信息
    SELECT S.*
      INTO WAREHOUSE_DL_INF
      FROM SPM_CON_WAREHOUSE_DL S
     WHERE S.WAREHOUSE_DL_ID = V_WAREHOUSE_DL_ID;
    --入库主表信息
    SELECT *
      INTO WAREHOUSE_INF
      FROM SPM_CON_WAREHOUSE S
     WHERE S.WAREHOUSE_ID = WAREHOUSE_DL_INF.WAREHOUSE_ID;
    --查询子表行数
    SELECT COUNT(*)
      INTO V_WAREHOUSE_DL_LINE
      FROM SPM_CON_WAREHOUSE_DL S
     WHERE S.WAREHOUSE_ID = WAREHOUSE_DL_INF.WAREHOUSE_ID;
    --查询子表入库金额
    SELECT SUM(S.MONEY_AMOUNT)
      INTO LINE_MONEY
      FROM SPM_CON_WAREHOUSE_DL S
     WHERE S.WAREHOUSE_ID = WAREHOUSE_DL_INF.WAREHOUSE_ID;
    /*IF V_WAREHOUSE_DL_LINE = 0 THEN
      RETURN v_share_unit_price;
    END IF;*/
    --验证均摊成本是否初始化
    IF WAREHOUSE_DL_INF.SHARE_UNIT_PRICE <> 0 THEN
      RETURN WAREHOUSE_DL_INF.SHARE_UNIT_PRICE;
    END IF;
    --均摊成本有三部分组成，第一部分=（国内运输费+国内保险费+港杂费）/行数量
    V_COST_SHARING_PART1 :=  --国内运输费
     ROUND((NVL(WAREHOUSE_INF.TRAFFIC_EXPENSE, 0) +
                                  --国内保险费
                                  NVL(WAREHOUSE_INF.PREMIUM_AMOUNT, 0) +
                                  --港杂费
                                  NVL(WAREHOUSE_INF.PORT_SURCHARGE, 0)),
                                  2) / V_WAREHOUSE_DL_LINE;
    --第二部分，进口关税按照行入库金额加权平均算出，=进口关税*入库金额（本行）/（入库总金额）
    V_COST_SHARING_PART2 :=  --进口关税
     ROUND(NVL(WAREHOUSE_INF.IMPORT_TARIFF, 0) *
                                  NVL(WAREHOUSE_DL_INF.MONEY_AMOUNT, 0) /
                                  NVL(LINE_MONEY, 0),
                                  2);
    /*第三部分，特别关税按照材质为P92时，按行入库行金额加权平均算出，
    =特别关税*入库金额（本行）/（入库总金额）（材质为P92的行）*/
    --验证材质是否为P92
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM DUAL
     WHERE WAREHOUSE_DL_INF.DELIVERY_CARGO LIKE '%P92%';
    --P92行的总金额
    SELECT SUM(S.MONEY_AMOUNT)
      INTO P92_MONEY
      FROM SPM_CON_WAREHOUSE_DL S
     WHERE S.DELIVERY_CARGO LIKE '%P92%'
       AND S.WAREHOUSE_ID = WAREHOUSE_DL_INF.WAREHOUSE_ID;
    IF V_NUMBER <> 0 THEN
      V_COST_SHARING_PART3 := ROUND(NVL(WAREHOUSE_INF.SPECIAL_TARIFF, 0) *
                                    NVL(WAREHOUSE_DL_INF.MONEY_AMOUNT, 0) /
                                    NVL(P92_MONEY, 0),
                                    2);
    ELSE
      V_COST_SHARING_PART3 := 0;
    END IF;
    V_SHARE_UNIT_PRICE := V_COST_SHARING_PART1 + V_COST_SHARING_PART2 +
                          V_COST_SHARING_PART3;
    RETURN V_SHARE_UNIT_PRICE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN V_SHARE_UNIT_PRICE;
  END;
  --多个框架时生效订单合同
  PROCEDURE BATCH_CLAIM_MANY_KJ(HT_ID VARCHAR2,
                                KJ_ID VARCHAR2,
                                P_MSG OUT VARCHAR2) IS
    V_ID  NUMBER;
    MSG_A VARCHAR2(4000);
    MSG_B VARCHAR2(4000);
    MSG_C VARCHAR2(4000);
  
    MSG_A1 VARCHAR2(4000);
    MSG_B1 VARCHAR2(4000);
    MSG_C1 VARCHAR2(4000);
  
    MSG_A2 VARCHAR2(4000);
    MSG_B2 VARCHAR2(4000);
    MSG_C2 VARCHAR2(4000);
  
    PROJECT_COUNT       NUMBER;
    PROJECT_COUNT1      NUMBER;
    HT_MERCHANTS_COUNT  NUMBER;
    HT_MERCHANTS_COUNT1 NUMBER;
    TARGET_COUNT        NUMBER;
    V_CUST_INFO         VARCHAR2(2000);
    DD_CREATION_DATE    DATE;
    V_1                 NUMBER;
    V_2                 NUMBER;
    V_PROJECT_ID        NUMBER;
    V_DEPT_ID           NUMBER;
    V_CREATED_BY        NUMBER;
    ENTERPRISEID        NUMBER;
    ASSIGN_PURORG_ID    NUMBER;
    KJ_CONTRACT_ID      NUMBER;
  
    T_CONTRACT_CODE VARCHAR2(200); --合同编号
    T_CONTRACT_NAME VARCHAR2(200); --合同名称
    T_IN_OUT_TYPE   VARCHAR2(4); --收支类型
    T_START_DATE    DATE; --开始时间
    T_END_DATE      DATE; --结束时间
    T_ORG_ID        NUMBER; --组织id
    T_CREATION_DATE DATE; --创建时间
    T_CONTRACT_ID   NUMBER; --合同主键
  
  BEGIN
  
    SELECT T.CONTRACT_ID,
           T.CONTRACT_CODE,
           T.CONTRACT_NAME,
           T.IN_OUT_TYPE,
           T.START_DATE,
           T.END_DATE,
           T.ORG_ID,
           T.CREATION_DATE
      INTO T_CONTRACT_ID,
           T_CONTRACT_CODE,
           T_CONTRACT_NAME,
           T_IN_OUT_TYPE,
           T_START_DATE,
           T_END_DATE,
           T_ORG_ID,
           T_CREATION_DATE
    
      FROM SPM_CON_HT_INFO T
     WHERE T.ONLINE_RETAILERS LIKE '%DS%'
       AND T.DEPT_ID IS NULL
       AND T.CREATED_BY IS NULL
       AND T.CONTRACT_ID = TO_NUMBER(HT_ID)
       AND (T.ORG_ID IS NULL OR T.ORG_ID = SPM_SSO_PKG.GETORGID);
  
    IF T_IN_OUT_TYPE = '2' THEN
      --先查一下此条合同是否关联了项目和供应商
      SELECT COUNT(*)
        INTO PROJECT_COUNT1
        FROM SPM_CON_HT_PROJECT T
       WHERE T.CONTRACT_ID = HT_ID;
    
      SELECT COUNT(*)
        INTO HT_MERCHANTS_COUNT1
        FROM SPM_CON_HT_MERCHANTS T
       WHERE T.CONTRACT_ID = HT_ID;
    
      IF PROJECT_COUNT1 = 0 AND HT_MERCHANTS_COUNT1 = 0 THEN
      
        SELECT T.ENTERPRISEID
          INTO ENTERPRISEID
          FROM SPM_CON_MQ_SM_PUR_ORDER T
         WHERE T.ORDER_NO = T_CONTRACT_CODE;
      
        SELECT TO_NUMBER(SPM_CON_VENDOR_PACKAGE.QUERY_VENDOR_STATUS(TO_CHAR(ENTERPRISEID),
                                                                    T_ORG_ID))
          INTO V_1
          FROM DUAL;
      
        --框架合同
        SELECT D.PROJECT_ID, S.DEPT_ID, S.CREATED_BY, S.CONTRACT_ID
          INTO V_PROJECT_ID, V_DEPT_ID, V_CREATED_BY, KJ_CONTRACT_ID
          FROM SPM_CON_HT_INFO S, SPM_CON_HT_PROJECT T, SPM_CON_PROJECT D
         WHERE 1 = 1
           AND S.CONTRACT_ID = T.CONTRACT_ID
           AND T.PROJECT_ID = D.PROJECT_ID
           AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
           AND S.CONTRACT_FORM = '4'
           AND S.IN_OUT_TYPE = '2'
           AND S.ORG_ID = T_ORG_ID
           AND S.START_DATE <= trunc(T_CREATION_DATE,'dd')
           AND S.END_DATE >= trunc(T_CREATION_DATE,'dd')
           AND S.CONTRACT_ID = KJ_ID;
      
        --插入项目
        --主键
        INSERT INTO SPM_CON_HT_PROJECT
          (CON_PRO_RELATION_ID, CONTRACT_ID, PROJECT_ID, ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_PROJECT_SEQ.NEXTVAL,
           T_CONTRACT_ID,
           V_PROJECT_ID,
           'DSCG');
      
        --插入供应商
        -- 主键
        INSERT INTO SPM_CON_HT_MERCHANTS
          (CON_MERCHANTS_ID,
           MERCHANTS_ID,
           CONTRACT_ID,
           MERCHANTS_FLAG,
           IN_OUT_TYPE,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
           V_1,
           T_CONTRACT_ID,
           2,
           '2',
           'DSCG');
      
        --关联框架协议
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           HT_ID,
           KJ_CONTRACT_ID,
           '3',
           '3',
           '2',
           'DS');
      
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           KJ_CONTRACT_ID,
           HT_ID,
           '3',
           '3',
           '1',
           'DS');
      
        --合同表加入人员和部门(框架合同)
        UPDATE SPM_CON_HT_INFO T
           SET T.DEPT_ID          = V_DEPT_ID,
               T.CREATED_BY       = V_CREATED_BY,
               T.STATUS           = 'E',
               T.ERROR_MSG        = NULL,
               T.LAST_UPDATE_DATE = SYSDATE,
               T.LAST_UPDATED_BY  = SPM_SSO_PKG.GETUSERID
         WHERE T.CONTRACT_ID = HT_ID;
      
        UPDATE SPM_CON_MQ_SM_PUR_ORDER T
           SET T.ATTRIBUTE1 = 'ED'
         WHERE T.ID = (SELECT FF.ID
                         FROM SPM_CON_MQ_SM_PUR_ORDER FF
                        WHERE FF.ORDER_NO = T_CONTRACT_CODE);
      
        MSG_A := T_CONTRACT_CODE || '采购订单认领成功';
      
      ELSE
        MSG_A := T_CONTRACT_CODE || '采购订单认领失败，已经关联了项目或供应商,请联系系统管理员';
      END IF;
    
    END IF;
  
    IF T_IN_OUT_TYPE = '1' THEN
    
      --先查一下此条合同是否关联了项目和供应商
      SELECT COUNT(*)
        INTO PROJECT_COUNT1
        FROM SPM_CON_HT_PROJECT T
       WHERE T.CONTRACT_ID = HT_ID;
    
      SELECT COUNT(*)
        INTO HT_MERCHANTS_COUNT1
        FROM SPM_CON_HT_MERCHANTS T
       WHERE T.CONTRACT_ID = HT_ID;
      IF PROJECT_COUNT1 > 0 OR HT_MERCHANTS_COUNT1 > 0 THEN
        MSG_B  := T_CONTRACT_CODE || '已有项目或者客户，数据异常，请联系系统管理员 ' || MSG_B;
        MSG_C2 := '已有项目或者客户，数据异常，请联系系统管理员 ';
      END IF;
    
      SELECT T.ASSIGN_PURORG_ID
        INTO ASSIGN_PURORG_ID
        FROM SPM_CON_MQ_SM_SALE_ORDER T
       WHERE T.ORDER_CODE = T_CONTRACT_CODE;
    
      IF PROJECT_COUNT1 = 0 AND HT_MERCHANTS_COUNT1 = 0 THEN
        SELECT TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS(TO_CHAR(ASSIGN_PURORG_ID),
                                                            T_ORG_ID))
          INTO V_1
          FROM DUAL;
      
        --框架合同
        SELECT D.PROJECT_ID, S.DEPT_ID, S.CREATED_BY, S.CONTRACT_ID
          INTO V_PROJECT_ID, V_DEPT_ID, V_CREATED_BY, KJ_CONTRACT_ID
          FROM SPM_CON_HT_INFO S, SPM_CON_HT_PROJECT T, SPM_CON_PROJECT D
         WHERE 1 = 1
           AND S.CONTRACT_ID = T.CONTRACT_ID
           AND T.PROJECT_ID = D.PROJECT_ID
           AND (SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y' OR
               SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_KJXY(S.CONTRACT_ID) = 'Y')
           AND S.CONTRACT_FORM = '4'
           AND S.IN_OUT_TYPE = '1'
           AND S.ORG_ID = T_ORG_ID
           AND S.START_DATE <= T_CREATION_DATE
           AND S.END_DATE >= T_CREATION_DATE
           AND S.CONTRACT_ID = KJ_ID;
      
        --插入项目
        --主键
        INSERT INTO SPM_CON_HT_PROJECT
          (CON_PRO_RELATION_ID, CONTRACT_ID, PROJECT_ID, ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_PROJECT_SEQ.NEXTVAL,
           T_CONTRACT_ID,
           V_PROJECT_ID,
           'DSXS');
      
        --插入供应商
        -- 主键
        INSERT INTO SPM_CON_HT_MERCHANTS
          (CON_MERCHANTS_ID,
           MERCHANTS_ID,
           CONTRACT_ID,
           MERCHANTS_FLAG,
           IN_OUT_TYPE,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
           V_1,
           T_CONTRACT_ID,
           1,
           '1',
           'DSXS');
        --关联框架协议
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           HT_ID,
           KJ_CONTRACT_ID,
           '3',
           '3',
           '2',
           'DS');
      
        INSERT INTO SPM_CON_HT_RELATION T
          (T.RELATION_ID,
           T.CONTRACT_ID,
           T.CONTRACT_ID_R,
           T.RELATION_SHIP,
           T.RELATION_BUSINESS,
           T.RELATION_ACTION,
           ATTRIBUTE1)
        VALUES
          (SPM_CON_HT_RELATION_SEQ.NEXTVAL,
           KJ_CONTRACT_ID,
           HT_ID,
           '3',
           '3',
           '1',
           'DS');
      
        --合同表加入人员和部门(框架合同)
        UPDATE SPM_CON_HT_INFO T
           SET T.DEPT_ID          = V_DEPT_ID,
               T.CREATED_BY       = V_CREATED_BY,
               T.STATUS           = 'E',
               T.ERROR_MSG        = NULL,
               T.LAST_UPDATE_DATE = SYSDATE,
               T.LAST_UPDATED_BY  = SPM_SSO_PKG.GETUSERID
         WHERE T.CONTRACT_ID = T_CONTRACT_ID;
      
        UPDATE SPM_CON_MQ_SM_SALE_ORDER T
           SET T.ATTRIBUTE1 = 'ED'
         WHERE T.ORDER_ID =
               (SELECT FF.ORDER_ID
                  FROM SPM_CON_MQ_SM_SALE_ORDER FF
                 WHERE FF.ORDER_CODE = T_CONTRACT_CODE);
      
        MSG_B := T_CONTRACT_CODE || '销售订单认领成功' || MSG_B;
      
      END IF;
    
    END IF;
  
    P_MSG := MSG_A || MSG_B;
  END;

  /*查询出库单行中剩余金额
  by mcq
  20180906*/
  FUNCTION GET_WAREHOUSE_DL_MONEY(V_ID IN NUMBER) RETURN NUMBER IS
    SUM_AMOUNT    NUMBER;
    ODO_AMOUNT    NUMBER;
    RETURN_AMOUNT NUMBER;
  BEGIN
    --查询入库总金额
    SELECT WD.THIS_WAREHOUSE_NUMBER
      INTO SUM_AMOUNT
      FROM SPM_CON_WAREHOUSE_DL WD
     WHERE WD.WAREHOUSE_DL_ID = V_ID;
    --查询对应出库金额
    SELECT SUM(OD.THIS_ODO_NUMBER)
      INTO ODO_AMOUNT
      FROM SPM_CON_ODO_DL OD
     WHERE OD.WAREHOUSE_DL_ID = V_ID;
    --查询对应退货金额
    --CHANGE BY RK  2019/05/13  加上退货成功标志
    SELECT SUM(OD.SALES_RETURN)
      INTO RETURN_AMOUNT
      FROM SPM_CON_ODO_DL OD, SPM_CON_SALES_RETURN T
     WHERE OD.WAREHOUSE_DL_ID = V_ID
       AND OD.ODO_ID = T.ODO_ID
       AND T.ATTRIBUTE5 = 'Y';
  
    RETURN NVL(SUM_AMOUNT, 0) - NVL(ODO_AMOUNT, 0) + NVL(RETURN_AMOUNT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END GET_WAREHOUSE_DL_MONEY;

  FUNCTION GET_WAGEHOUSE_DL_F(V_ID IN NUMBER) RETURN NUMBER IS
  
    SUM_AMOUNT NUMBER;
    ODO_AMOUNT NUMBER;
  
  BEGIN
    --查询入库数量(副)
    SELECT WD.DEPUTY_UNIT_AMOUNT
      INTO SUM_AMOUNT
      FROM SPM_CON_WAREHOUSE_DL WD
     WHERE WD.WAREHOUSE_DL_ID = V_ID;
    --查询对应出库数量(副)
    SELECT SUM(OD.THIS_ODO_NUMBER_F)
      INTO ODO_AMOUNT
      FROM SPM_CON_ODO_DL OD
     WHERE OD.WAREHOUSE_DL_ID = V_ID;
  
    RETURN NVL(SUM_AMOUNT, 0) - NVL(ODO_AMOUNT, 0);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END GET_WAGEHOUSE_DL_F;

  /*查询出库单对应销售合同的税率
  V_ID HT_ID 合同ID
  by mcq
  20180906*/
  FUNCTION GET_ODO_HT_TARGET_INFO(V_ID IN NUMBER, V_TYPE VARCHAR2)
    RETURN NUMBER IS
    V_RESULT NUMBER := 0;
  BEGIN
    IF V_TYPE = 'P' THEN
      --查询最大单价
      SELECT MAX(HT.UNIT_PRICE)
        INTO V_RESULT
        FROM SPM_CON_ODO O, SPM_CON_ODO_DL OD, SPM_CON_HT_TARGET HT
       WHERE O.CONTRACT_ID = HT.CONTRACT_ID
         AND OD.ODO_ID = O.ODO_ID
         AND HT.MATERIAL_CODE = OD.MATERIAL_CODE
         AND OD.SPM_CON_ODO_DL_ID = V_ID;
    ELSE
      --查询最大税率
      SELECT MAX(HT.TAX_RATE)
        INTO V_RESULT
        FROM SPM_CON_ODO O, SPM_CON_ODO_DL OD, SPM_CON_HT_TARGET HT
       WHERE O.CONTRACT_ID = HT.CONTRACT_ID
         AND OD.ODO_ID = O.ODO_ID
         AND HT.MATERIAL_CODE = OD.MATERIAL_CODE
         AND OD.SPM_CON_ODO_DL_ID = V_ID;
    END IF;
    RETURN V_RESULT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END GET_ODO_HT_TARGET_INFO;

  /*
    根据到货单信息生成对应入库单信息
    BY MCQ
    20180911
  */
  PROCEDURE CREATE_WAREHOUSE_BY_MQ_GOODS(P_IDS IN VARCHAR2,
                                         P_MSG OUT VARCHAR2) IS
    IS_EXISTS         NUMBER;
    IDS               SPM_TYPE_TBL;
    V_DEPT_ID         NUMBER(15); --部门id
    V_PERSON_ID       NUMBER(15); --人员ID
    V_USER_ID         NUMBER(15); --人员ID
    P_ERR_MSG         VARCHAR2(2000);
    P_MQ_ID           NUMBER;
    P_HT_ID           NUMBER(15); --记录在游标中对应订单合同ID
    P_PRO_ID          NUMBER(15); --记录在游标中对应项目ID
    P_PRO_NAME        VARCHAR2(200);
    P_PRO_CODE        VARCHAR2(200);
    P_VEN_ID          NUMBER(15); --记录在游标中对应供应商ID
    P_VEN_CODE        VARCHAR2(40);
    P_SITE_ID         NUMBER(15); --记录供应商地点
    P_VEN_NAME        VARCHAR2(200); --记录供应商名称
    V_SERIAL_NUMBER   VARCHAR2(40); --入库单编号
    V_WAREHOUSE_ID    NUMBER(15); --出库单主键
    V_WAREHOUSE_DL_ID NUMBER(15); --出库单明细主键
    H_LINE            SPM_CON_WAREHOUSE%ROWTYPE;
    D_LINE            SPM_CON_WAREHOUSE_DL%ROWTYPE;
  
    V_THEIR_DEPARTMENT VARCHAR2(40);
  
    HT_MATERIAL_CODE VARCHAR2(200); --物料编码
    HT_UNIT_PRICE    NUMBER; --不含税单价
    HT_TAX_RATE      NUMBER; --订单行税率
  
    V_STORE_ROOM_NAME     VARCHAR2(200); --仓库名称
    V_GOODS_POSITION_NAME VARCHAR2(200); --货位 
    V_STORE_ROOM          VARCHAR2(40); --仓库名称
    V_GOODS_POSITION      VARCHAR2(40); --货位 
  
    P_FLAG VARCHAR2(40) DEFAULT 'S';
  
    --到货单明细按照合同编号进行分组
    CURSOR CUR_H(P_ID NUMBER) IS
      SELECT DL.SALE_ORDER_CODE_DL CONTRACT_CODE
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL DL
       WHERE DL.ID = P_ID
       GROUP BY DL.SALE_ORDER_CODE_DL;
  
    --到货单明细的游标
    CURSOR CUR_DL(P_ID NUMBER, P_HT_CODE VARCHAR2) IS
      SELECT S.ARRIVE_ORDER_ID TARGET_ID,
             S.MQ_ID,
             S.ORDER_CODE_DL ORDER_CODE_DL,
             S.SALE_ORDER_CODE_DL SALE_ORDER_CODE_DL,
             S.MQ_ID CONTRACT_ID,
             S.MATERIAL_CODE MATERIAL_CODE,
             S.MATERIAL_NAME MATERIAL_NAME,
             S.PURNUM TARGET_COUNT,
             S.UNIT TARGET_UNIT,
             S.SKU_VALUE,
             S.SIGN_NUM THIS_WAREHOUSE_NUMBER,
             HT.TAX_RATE,
             HT.UNIT_PRICE,
             ROUND(UNIT_PRICE / (1 + HT.TAX_RATE * 0.01), 7) NO_TAX_PRICE, --不含税单价 标的物中含税/(1+税率）
             HT.SPECIFICATION_MODEL SPECIFICATION_MODEL,
             HT.TARGET_ID HT_TARGET_ID,
             H.STATUS,
             S.ATTRIBUTE1
      
        FROM SPM_CON_MQ_GOODS_ARRIVAL_DTL S,
             SPM_CON_HT_TARGET            HT,
             SPM_CON_HT_INFO              H
       WHERE 1 = 1
         AND S.ID = P_ID
         AND S.SALE_ORDER_CODE_DL = P_HT_CODE
         AND HT.CONTRACT_ID = H.CONTRACT_ID
         AND S.SALE_ORDER_CODE_DL = H.CONTRACT_CODE
         AND HT.SKU_VALUE = S.SKU_VALUE
            --避免重复生成
         AND NVL(S.ATTRIBUTE1, 'N') <> 'A';
  
  BEGIN
    --附加（人员信息及仓库货位的查询）
    SELECT V.ORGANIZATION_ID, V.USER_ID, V.PERSON_ID
      INTO V_DEPT_ID, V_USER_ID, V_PERSON_ID
    
      FROM SPM_CON_HT_PEOPLE_V V
     WHERE V.USER_ID = SPM_SSO_PKG.GETUSERID
       AND V.BELONGORGID = SPM_SSO_PKG.GETORGID;
  
    SELECT I.DESCRIPTION,
           CUX_SPM_DATA_PO_PKG.GET_ITEM_LOCATIONS_ID(S.INVENTORY_LOCATION_ID,
                                                     'NAME'),
           I.SECONDARY_INVENTORY_NAME,
           S.INVENTORY_LOCATION_ID
      INTO V_STORE_ROOM_NAME,
           V_GOODS_POSITION_NAME,
           V_STORE_ROOM,
           V_GOODS_POSITION
      FROM MTL_SECONDARY_INVENTORIES I, MTL_ITEM_LOCATIONS S
     WHERE 1 = 1
       AND I.SECONDARY_INVENTORY_NAME = S.SUBINVENTORY_CODE
       AND S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
       AND I.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID
       AND ROWNUM = 1;
  
    --1.解析Java传入的mq中间表id字符串
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(SUBSTR(P_IDS,
                                                  1,
                                                  LENGTH(P_IDS) - 1))
      INTO IDS
      FROM DUAL;
  
    --2.遍历mqid 
    FOR I IN 1 .. IDS.COUNT LOOP
      P_MQ_ID := TO_NUMBER(IDS(I));
      --3.根据mqid 对到货单明细按照订单编号进行分组
      SELECT M.ARRIVE_ORDER_CODE
        INTO V_THEIR_DEPARTMENT
        FROM SPM_CON_MQ_GOODS_ARRIVAL M
       WHERE M.MQ_ID = P_MQ_ID;
    
      --3.1判断该到货单号是否重复生成入库单
      SELECT COUNT(*)
        INTO IS_EXISTS
        FROM SPM_CON_WAREHOUSE W
       WHERE W.THEIR_DEPARTMENT = V_THEIR_DEPARTMENT;
    
      IF IS_EXISTS <> 0 THEN
        P_ERR_MSG := '该到货单已经生成入库单，不允许重复生成';
        UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL D
           SET D.ERROR_MESSAGE = P_ERR_MSG
         WHERE D.ID = P_MQ_ID
           AND D.ATTRIBUTE1 <> 'A';
      
        P_FLAG := 'E';
        CONTINUE;
      END IF;
    
      FOR REC_H IN CUR_H(P_MQ_ID) LOOP
        --4.进行数据验证       
      
        --4.1判断订单是否存在
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_HT_INFO H
         WHERE H.CONTRACT_CODE = REC_H.CONTRACT_CODE;
      
        IF IS_EXISTS = 0 THEN
          P_ERR_MSG := '业财系统中不存在' || REC_H.CONTRACT_CODE ||
                       '的订单合同，请联系电商平台推送';
          UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL D
             SET D.ERROR_MESSAGE = P_ERR_MSG
           WHERE D.ID = P_MQ_ID
             AND D.SALE_ORDER_CODE_DL = REC_H.CONTRACT_CODE;
        
          P_FLAG := 'E';
          CONTINUE;
        END IF;
        --4.2 订单是否生效 
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_HT_INFO H
         WHERE H.CONTRACT_CODE = REC_H.CONTRACT_CODE
           AND H.STATUS = 'E';
        IF IS_EXISTS = 0 THEN
          P_ERR_MSG := '业财系统中' || REC_H.CONTRACT_CODE ||
                       '的订单合同未生效，请在订单浏览界面按照提示信息手动生效';
          UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL D
             SET D.ERROR_MESSAGE = P_ERR_MSG
           WHERE D.ID = P_MQ_ID
             AND D.SALE_ORDER_CODE_DL = REC_H.CONTRACT_CODE;
          P_FLAG := 'E';
          CONTINUE;
        END IF;
        --4.3记录订单合同id
        SELECT H.CONTRACT_ID
          INTO P_HT_ID
          FROM SPM_CON_HT_INFO H
         WHERE H.CONTRACT_CODE = REC_H.CONTRACT_CODE
           AND H.STATUS = 'E';
      
        --4.4 获取订单合同关联的项目
        SELECT HP.PROJECT_ID, P.PROJECT_NAME, P.PROJECT_CODE
          INTO P_PRO_ID, P_PRO_NAME, P_PRO_CODE
          FROM SPM_CON_HT_PROJECT HP, SPM_CON_PROJECT P
         WHERE HP.CONTRACT_ID = P_HT_ID
           AND HP.PROJECT_ID = P.PROJECT_ID
           AND ROWNUM = 1;
        --4.5 获取订单合同关联的供应商
        SELECT H.MERCHANTS_ID, V.VENDOR_CODE, V.VENDOR_NAME
          INTO P_VEN_ID, P_VEN_CODE, P_VEN_NAME
          FROM SPM_CON_HT_MERCHANTS H, SPM_CON_VENDOR_INFO V
         WHERE H.CONTRACT_ID = P_HT_ID
           AND H.MERCHANTS_ID = V.VENDOR_ID
           AND ROWNUM = 1;
        --4.6 获取对应供应商地点
        BEGIN
          SELECT T.VENDOR_SITE_ID
            INTO P_SITE_ID
            FROM PO_VENDOR_SITES_ALL T,
                 PO_VENDORS          PP,
                 SPM_CON_VENDOR_INFO V
           WHERE 1 = 1
             AND V.VENDOR_ID = P_VEN_ID
             AND V.VENDOR_CODE = PP.SEGMENT1
             AND T.VENDOR_ID = PP.VENDOR_ID
             AND PP.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND T.VENDOR_SITE_CODE = '商品暂估'
             AND T.ORG_ID = SPM_SSO_PKG.GETORGID;
        EXCEPTION
          WHEN OTHERS THEN
            SELECT V.VENDOR_NAME
              INTO P_VEN_NAME
              FROM SPM_CON_VENDOR_INFO V
             WHERE V.VENDOR_ID = P_VEN_ID;
            P_ERR_MSG := '业财系统中' || P_VEN_NAME ||
                         '的供应商在当前组织下没有商品暂估的地点，请在供应商界面手动维护并同步';
            UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL D
               SET D.ERROR_MESSAGE = P_ERR_MSG
             WHERE D.ID = P_MQ_ID
               AND D.SALE_ORDER_CODE_DL = REC_H.CONTRACT_CODE;
          
            P_FLAG := 'E';
            CONTINUE;
        END;
      
        SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_WAREHOUSE',
                                                              'SPM_CON_WAREHOUSE',
                                                              'WAREHOUSE_CODE',
                                                              'FM00000')
          INTO V_SERIAL_NUMBER
          FROM DUAL;
        SELECT SPM_CON_WAREHOUSE_SEQ.NEXTVAL INTO V_WAREHOUSE_ID FROM DUAL;
      
        H_LINE.WAREHOUSE_ID     := V_WAREHOUSE_ID;
        H_LINE.CONTRACT_ID      := P_HT_ID;
        H_LINE.CONTRACT_NAME    := REC_H.CONTRACT_CODE;
        H_LINE.CONTRACT_CODE    := REC_H.CONTRACT_CODE;
        H_LINE.PROJECT_ID       := P_PRO_ID;
        H_LINE.PROJECT_NAME     := P_PRO_NAME;
        H_LINE.PROJECT_CODE     := P_PRO_CODE;
        H_LINE.VENDOR_ID        := P_VEN_ID;
        H_LINE.VENDOR_NAME      := P_VEN_NAME;
        H_LINE.VENDOR_POSITION  := P_SITE_ID;
        H_LINE.MATERIAL_ORIGIN  := 'A'; --物资来源1    
        H_LINE.MATERIAL_TYPE    := '1'; --材料类别2
        H_LINE.TRANSPORT_TYPE   := 'A'; --运输方式3
        H_LINE.BUY_TYPE         := 'A'; --采购方式4
        H_LINE.WAREHOUSE_GRNI   := 'B'; --是否暂估5
        H_LINE.WAREHOUSE_DATE   := SYSDATE;
        H_LINE.CREATION_DATE    := SYSDATE;
        H_LINE.DEPT_ID          := V_DEPT_ID;
        H_LINE.ORG_ID           := SPM_SSO_PKG.GETORGID;
        H_LINE.CREATED_BY       := V_USER_ID;
        H_LINE.WAREHOUSE_CODE   := V_SERIAL_NUMBER;
        H_LINE.ATTRIBUTE5       := 'N';
        H_LINE.STATUS           := 'A';
        H_LINE.THEIR_DEPARTMENT := V_THEIR_DEPARTMENT;
        H_LINE.EBS_DEPT_CODE    := SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                                                  V_PERSON_ID);
      
        FOR REC_DL IN CUR_DL(P_MQ_ID, REC_H.CONTRACT_CODE) LOOP
        
          BEGIN
          
            SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL
              INTO V_WAREHOUSE_DL_ID
              FROM DUAL;
            SELECT T.MATERIAL_CODE
              INTO HT_MATERIAL_CODE
              FROM SPM_CON_HT_TARGET T
             WHERE --T.MATERIAL_NAME = CCC.MATERIAL_NAME
             T.SKU_VALUE = REC_DL.SKU_VALUE
             AND T.CONTRACT_ID = P_HT_ID;
          
            D_LINE.WAREHOUSE_DL_ID := V_WAREHOUSE_DL_ID;
            D_LINE.WAREHOUSE_ID    := V_WAREHOUSE_ID;
            D_LINE.CONTRACT_ID     := P_HT_ID;
            D_LINE.MATERIAL_CODE   := HT_MATERIAL_CODE; --物资编码
            D_LINE.DELIVERY_CARGO  := (SUBSTR(REC_DL.MATERIAL_NAME, 0, 75) || '|' ||
                                      SUBSTR(REC_DL.SPECIFICATION_MODEL,
                                              0,
                                              25) || '|' || '|'); --物料名称
          
            D_LINE.PURCHASE_AMOUNT       := REC_DL.TARGET_COUNT; --总数量
            D_LINE.THIS_WAREHOUSE_NUMBER := REC_DL.THIS_WAREHOUSE_NUMBER; --本次入库数量
            D_LINE.UNIT                  := REC_DL.TARGET_UNIT; --单位
            D_LINE.WAREHOUSE_UNIT_PRICE  := REC_DL.NO_TAX_PRICE;
            D_LINE.MONEY_AMOUNT          := REC_DL.THIS_WAREHOUSE_NUMBER *
                                            REC_DL.NO_TAX_PRICE; --金额(不含增值税)
            D_LINE.TAX_RATE              := REC_DL.TAX_RATE; --税率
            D_LINE.TAX_AMOUNT            := REC_DL.UNIT_PRICE *
                                            REC_DL.THIS_WAREHOUSE_NUMBER -
                                            REC_DL.NO_TAX_PRICE *
                                            REC_DL.THIS_WAREHOUSE_NUMBER; --进项税,
            D_LINE.TAX_UNIT_PRICE        := REC_DL.UNIT_PRICE; --含税单价
            D_LINE.TAX_AMOUNT_COUNT      := REC_DL.UNIT_PRICE *
                                            REC_DL.THIS_WAREHOUSE_NUMBER; --价税合计
            D_LINE.CREATED_BY            := V_USER_ID;
            D_LINE.DEPT_ID               := V_DEPT_ID;
            D_LINE.ORG_ID                := SPM_SSO_PKG.GETORGID;
            D_LINE.CREATION_DATE         := SYSDATE;
          
            D_LINE.CON_TARGET_ID := REC_DL.HT_TARGET_ID;
          
            D_LINE.STORE_ROOM          := V_STORE_ROOM; --仓库
            D_LINE.GOODS_POSITION      := V_GOODS_POSITION; --货位
            D_LINE.STORE_ROOM_NAME     := V_STORE_ROOM_NAME; --仓库名称
            D_LINE.GOODS_POSITION_NAME := V_GOODS_POSITION_NAME; --货位名称
          
            D_LINE.ATTRIBUTE2 := 'DS';
            D_LINE.ATTRIBUTE3 := REC_DL.SKU_VALUE;
          
            INSERT INTO SPM_CON_WAREHOUSE_DL VALUES D_LINE;
            --记录此条数据已经处理
            UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL T
               SET T.ATTRIBUTE1 = 'A', T.ERROR_MESSAGE = ''
             WHERE T.MQ_ID = REC_DL.MQ_ID;
          
          EXCEPTION
            WHEN OTHERS THEN
            
              P_ERR_MSG := REC_H.CONTRACT_CODE || '订单合同的行信息不符合规范';
              UPDATE SPM_CON_MQ_GOODS_ARRIVAL_DTL D
                 SET D.ERROR_MESSAGE = P_ERR_MSG
               WHERE D.ID = P_MQ_ID
                 AND D.SALE_ORDER_CODE_DL = REC_H.CONTRACT_CODE;
            
              P_FLAG := 'E';
              --跳至外层循环的下一次
              EXIT;
          END;
        
        END LOOP;
      
        INSERT INTO SPM_CON_WAREHOUSE VALUES H_LINE;
      
        --更新入库单金额
        UPDATE SPM_CON_WAREHOUSE AA
           SET AA.WAREHOUSE_AMOUNT_MONEY = NVL((SELECT SUM(ROUND(I.THIS_WAREHOUSE_NUMBER *
                                                                I.WAREHOUSE_UNIT_PRICE,
                                                                2))
                                                 FROM SPM_CON_WAREHOUSE_DL I
                                                WHERE I.WAREHOUSE_ID =
                                                      AA.WAREHOUSE_ID),
                                               0)
         WHERE AA.WAREHOUSE_ID = V_WAREHOUSE_ID;
      
      END LOOP;
    
    END LOOP;
    P_MSG := P_FLAG;
  
  EXCEPTION
    WHEN OTHERS THEN
      P_MSG := 'E';
    
  END CREATE_WAREHOUSE_BY_MQ_GOODS;
  PROCEDURE SEND_COST_INVENTORY_TO_EBS(WAREHOUSE_ID NUMBER,
                                       DEPT_CODE    VARCHAR,
                                       SUB_CODE     VARCHAR,
                                       SUCESS_FLAG  OUT VARCHAR,
                                       OUT_MESSGGE  OUT VARCHAR2) IS
  BEGIN
  
    FOR I IN (SELECT A.WAREHOUSE_DATE, --入账时间
                     A.EBS_DEPT_CODE, --EBS部门--(SELECT ass_attribute2 FROM PER_ALL_ASSIGNMENTS_F WHERE ass_attribute1=A.DEPT_ID)
                     B.MATERIAL_CODE, --物料编码
                     WAREHOUSE_COST_SHARING(B.WAREHOUSE_DL_ID), --均摊成本
                     A.EBS_DEPT_CODE SEGMENT2, --ebs部门，行弹性域
                     A.WAREHOUSE_CODE, --入库单号
                     (SELECT CONTRACT_CODE
                        FROM SPM_CON_HT_INFO
                       WHERE CONTRACT_ID = A.CONTRACT_ID) CONTRACT_CODE, --合同编号
                     A.CONTRACT_NAME --合同名称
                FROM SPM_CON_WAREHOUSE A, SPM_CON_WAREHOUSE_DL B
               WHERE A.WAREHOUSE_ID = B.WAREHOUSE_ID
                 AND A.WAREHOUSE_STATUS = 'Y'
                 AND A.STATUS = 'E') LOOP
      DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
    END LOOP;
  
  END;

  -- 出库单出库
  PROCEDURE GENERATE_SALE_ORDER(V_ID            IN NUMBER,
                                V_USER_ID       IN NUMBER,
                                V_RESP_ID       IN NUMBER,
                                V_RESP_APP_ID   IN NUMBER,
                                V_ORG_ID        IN NUMBER,
                                V_RETURN_STATUS OUT VARCHAR2) IS
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    MO_GLOBAL.SET_POLICY_CONTEXT('S', V_ORG_ID);
    UPDATE SPM_CON_ODO O
       SET O.OUTPUT_OR_RETURN = '2'
     WHERE O.ODO_ID = V_ID;
    CUX_SPM_DATA_PO_PKG.IMPORT_ZX_INFO(P_ID    => V_ID,
                                       OUT_MSG => V_RETURN_STATUS);
  
  END GENERATE_SALE_ORDER;

  -- 入库单入库
  PROCEDURE GENERATE_PURCHASING_ORDER(V_ID            IN NUMBER,
                                      V_USER_ID       IN NUMBER,
                                      V_RESP_ID       IN NUMBER,
                                      V_RESP_APP_ID   IN NUMBER,
                                      V_ORG_ID        IN NUMBER,
                                      V_RETURN_STATUS OUT VARCHAR2) IS
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    MO_GLOBAL.SET_POLICY_CONTEXT('S', V_ORG_ID);
    CUX_SPM_DATA_PO_PKG.IMPORT_ORDER_INFO(P_ID    => V_ID,
                                          OUT_MSG => V_RETURN_STATUS);
  
  END GENERATE_PURCHASING_ORDER;

  --平均成本更新
  PROCEDURE AVERAGE_COST_RENEWAL(V_ID            IN NUMBER,
                                 KMCODE          IN VARCHAR2, --科目段
                                 XMCODE          IN VARCHAR2, --项目段
                                 V_RETURN_STATUS OUT VARCHAR2,
                                 V_RETURN_MSG    OUT VARCHAR2) IS
  
    G_USER_ID CONSTANT NUMBER := FND_GLOBAL.USER_ID;
    L_INTERFACE_ROW       INV.MTL_TRANSACTIONS_INTERFACE%ROWTYPE;
    L_INTERFACE_HEADER_ID NUMBER;
    G_ORG_ID CONSTANT NUMBER := FND_GLOBAL.ORG_ID;
    G_EBS_DEPT     VARCHAR2(40); --部门段
    G_EBS_PRODECT  VARCHAR2(40); --产品段
    G_HT_NAME      VARCHAR2(200); --合同名称
    G_HT_CODE      VARCHAR2(100); --合同编号
    G_WARE_CODE    VARCHAR2(40); --入库单编号
    G_PROJECT_CODE VARCHAR2(40); --项目编号
    G_COSE_STATUS  VARCHAR2(40); --平均成本更新状态
    G_ATTRIBUTE5   VARCHAR2(40); --入库状态
    V_DATE         DATE;--入库时间
  
    G_ORG      NUMBER; --所属组织
    G_MER_TYPE VARCHAR2(40); --物料类型
  
    STRINGS VARCHAR2(200); --十段结构拼接
  
    G_ORG_CODE VARCHAR2(40); --组织编码  
  
    L_COST_GROUP_ID NUMBER;
    G_CCID          NUMBER; ---------**********尚未添加  科目段
  
    CURSOR LINES(V_ID_P NUMBER, V_ORG_IDS NUMBER) IS
      SELECT T.INVENTORY_ITEM_ID,
             DL.SHARE_UNIT_PRICE,
             DL.WAREHOUSE_DL_ID,
             T.PRIMARY_UOM_CODE
        FROM SPM_CON_WAREHOUSE_DL DL, INV.MTL_SYSTEM_ITEMS_B T
       WHERE DL.MATERIAL_CODE = T.SEGMENT1
         AND T.ORGANIZATION_ID = V_ORG_IDS
         AND DL.WAREHOUSE_ID = V_ID_P;
  
  BEGIN
  
    SELECT W.EBS_DEPT_CODE,
           W.EBS_PRODUCE,
           F.CONTRACT_NAME,
           F.CONTRACT_CODE,
           W.WAREHOUSE_CODE,
           W.PROJECT_CODE,
           W.AVERAGE_COST,
           W.ATTRIBUTE5,
           W.ORG_ID,
           W.MATERIAL_TYPE,
           W.WAREHOUSE_DATE
      INTO G_EBS_DEPT,
           G_EBS_PRODECT,
           G_HT_NAME,
           G_HT_CODE,
           G_WARE_CODE,
           G_PROJECT_CODE,
           G_COSE_STATUS,
           G_ATTRIBUTE5,
           G_ORG,
           G_MER_TYPE,
           V_DATE
      FROM SPM_CON_WAREHOUSE W, SPM_CON_HT_INFO F
     WHERE W.CONTRACT_ID = F.CONTRACT_ID
       AND W.WAREHOUSE_ID = V_ID;
  
    IF G_COSE_STATUS IS NOT NULL THEN
      V_RETURN_STATUS := 'E';
      V_RETURN_MSG    := '该入库单已经进行了平均成本更新申请';
      RETURN;
    END IF;
  
    IF G_ATTRIBUTE5 <> 'Y' THEN
      V_RETURN_STATUS := 'E';
      V_RETURN_MSG    := '该入库单尚未进行入库操作';
      RETURN;
    END IF;
  
    IF (G_ORG <> 81 OR G_MER_TYPE <> '2') THEN
      V_RETURN_STATUS := 'E';
      V_RETURN_MSG    := '非重工管道业务不存在此项操作';
      RETURN;
    END IF;
  
    SELECT P.DEFAULT_COST_GROUP_ID
      INTO L_COST_GROUP_ID
      FROM MTL_PARAMETERS P
     WHERE P.ORGANIZATION_ID = G_ORG;
  
    SELECT U.SHORT_CODE
      INTO G_ORG_CODE
      FROM HR_OPERATING_UNITS U
     WHERE U.ORGANIZATION_ID = G_ORG;
  
    STRINGS := G_ORG_CODE || '.' || G_EBS_DEPT || '.' || KMCODE ||
               '.00.00.00.' || XMCODE || '.00.00.00';
  
    G_CCID := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(STRINGS);
  
    IF (G_CCID IS NULL OR G_CCID = 0) THEN
      V_RETURN_STATUS := 'E';
      V_RETURN_MSG    := '十段组合不对,未找到ccid,请检查产品段/项目段/部门段';
      RETURN;
    END IF;
  
    FOR LINE IN LINES(V_ID, G_ORG) LOOP
    
      L_INTERFACE_ROW := NULL;
    
      SELECT INV.MTL_MATERIAL_TRANSACTIONS_S.NEXTVAL
        INTO L_INTERFACE_HEADER_ID
        FROM DUAL;
    
      L_INTERFACE_ROW.TRANSACTION_INTERFACE_ID   := L_INTERFACE_HEADER_ID;
      L_INTERFACE_ROW.TRANSACTION_HEADER_ID      := L_INTERFACE_HEADER_ID;
      L_INTERFACE_ROW.CREATION_DATE              := SYSDATE;
      L_INTERFACE_ROW.CREATED_BY                 := G_USER_ID;
      L_INTERFACE_ROW.LAST_UPDATE_DATE           := SYSDATE;
      L_INTERFACE_ROW.LAST_UPDATED_BY            := G_USER_ID;
      L_INTERFACE_ROW.PROGRAM_UPDATE_DATE        := SYSDATE;
      L_INTERFACE_ROW.PROCESS_FLAG               := 1;
      L_INTERFACE_ROW.TRANSACTION_MODE           := 3;
      L_INTERFACE_ROW.LOCK_FLAG                  := 2;
      L_INTERFACE_ROW.MATERIAL_ACCOUNT           := G_CCID;
      L_INTERFACE_ROW.MATERIAL_OVERHEAD_ACCOUNT  := G_CCID;
      L_INTERFACE_ROW.RESOURCE_ACCOUNT           := G_CCID;
      L_INTERFACE_ROW.OUTSIDE_PROCESSING_ACCOUNT := G_CCID;
      L_INTERFACE_ROW.OVERHEAD_ACCOUNT           := G_CCID;
      L_INTERFACE_ROW.ORG_COST_GROUP_ID          := L_COST_GROUP_ID;
      L_INTERFACE_ROW.COST_GROUP_ID              := L_COST_GROUP_ID;
      L_INTERFACE_ROW.PERCENTAGE_CHANGE          := NULL;
      L_INTERFACE_ROW.VALUE_CHANGE               := LINE.SHARE_UNIT_PRICE; --要更新的金额
      L_INTERFACE_ROW.INVENTORY_ITEM_ID          := LINE.INVENTORY_ITEM_ID; -------EBS物料ID
      L_INTERFACE_ROW.TRANSACTION_UOM            := LINE.PRIMARY_UOM_CODE; --单位
      L_INTERFACE_ROW.TRANSACTION_QUANTITY       := 0;
      L_INTERFACE_ROW.PRIMARY_QUANTITY           := 0;
      L_INTERFACE_ROW.TRANSACTION_ACTION_ID      := 24;
      L_INTERFACE_ROW.TRANSACTION_TYPE_ID        := 80;
      L_INTERFACE_ROW.SOURCE_HEADER_ID           := 1;
      L_INTERFACE_ROW.SOURCE_CODE                := '平均成本更新';
      L_INTERFACE_ROW.SOURCE_LINE_ID             := 1;
      L_INTERFACE_ROW.ORGANIZATION_ID            := G_ORG;
      L_INTERFACE_ROW.TRANSACTION_DATE           := V_DATE;
    
      L_INTERFACE_ROW.ATTRIBUTE1 := G_EBS_DEPT;
      L_INTERFACE_ROW.ATTRIBUTE2 := G_HT_CODE;
      L_INTERFACE_ROW.ATTRIBUTE3 := G_HT_NAME;
      L_INTERFACE_ROW.ATTRIBUTE4 := G_WARE_CODE;
      L_INTERFACE_ROW.ATTRIBUTE5 := G_PROJECT_CODE;
      L_INTERFACE_ROW.ATTRIBUTE6 := G_EBS_PRODECT;
      --L_INTERFACE_ROW.ATTRIBUTE7 := V_ID;
      --L_INTERFACE_ROW.ATTRIBUTE8 := LINE.WAREHOUSE_DL_ID;
    
      INSERT INTO INV.MTL_TRANSACTIONS_INTERFACE VALUES L_INTERFACE_ROW;
    
      /*L_COUNT := SQL%ROWCOUNT;*/
    
      INSERT INTO INV.MTL_TXN_COST_DET_INTERFACE
        (TRANSACTION_INTERFACE_ID,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         CREATION_DATE,
         CREATED_BY,
         ORGANIZATION_ID,
         LEVEL_TYPE,
         VALUE_CHANGE,
         COST_ELEMENT_ID)
      VALUES
        (L_INTERFACE_HEADER_ID,
         SYSDATE, --RUN DATE
         G_USER_ID, --USER_ID
         SYSDATE, --RUN DATE
         G_USER_ID, --USER_ID
         G_ORG, --ORGANIZATION ID
         1, --LEVEL TYPE
         LINE.SHARE_UNIT_PRICE, --金额
         1 --COST ELEMENT ID
         );
    
    /*L_COUNT := SQL%ROWCOUNT;*/
    
    END LOOP;
  
    V_RETURN_STATUS := 'S';
    V_RETURN_MSG    := '提交申请成功';
  
    UPDATE SPM_CON_WAREHOUSE W
       SET W.AVERAGE_COST = 'ING'
     WHERE W.WAREHOUSE_ID = V_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_STATUS := 'E';
      V_RETURN_MSG    := '执行存储过程异常,请联系开发人员解决';
      RETURN;
    
  END AVERAGE_COST_RENEWAL;

END SPM_CON_ODO_PKG;
/
