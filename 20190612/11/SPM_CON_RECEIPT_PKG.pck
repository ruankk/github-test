CREATE OR REPLACE PACKAGE SPM_CON_RECEIPT_PKG IS

  --入库单保存数据插入总金额
  PROCEDURE SPM_CON_WARE_HOUSE_CC(V_ID NUMBER);

  --出库单保存数据插入总金额
  PROCEDURE SPM_CON_ODO_CC(ID NUMBER);

  --出库单保存库存序列
  PROCEDURE SPM_CON_ASSETS_CC(ID NUMBER);

  --退货单保存数据插入总金额
  PROCEDURE SPM_CON_SALES_RETURN_CC(ID NUMBER);
  --是否关联发票
  FUNCTION SPM_CON_WAREHOUSE_CONNECT(ID NUMBER) RETURN VARCHAR2;

  --对审批通过的入库单进行修改 释放数量
  PROCEDURE EMPTY_SPM_CON_WAREHOUSE_DL(P_ID NUMBER, OUT_MSG OUT VARCHAR2);

  --收款审批工作流HTML信息展现
  FUNCTION CLS_RECEIPT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --收款审批工作流HTML信息展现
  FUNCTION CLS_MONEY_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
  PROCEDURE SET_GOODS_WF_STATUS_TO_1(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --付款审批流程
  FUNCTION CLS_PAYMENT_ORDER_WF_HTML(P_KEY IN VARCHAR2,
                                     
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --付款审批流程发起
  PROCEDURE SPM_CON_WF_PAYMENT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER);
  --付款驳回回调
  PROCEDURE SPM_CON_WF_PAYMENT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --付款审批批准回调
  PROCEDURE SPM_CON_WF_PAYMENT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2);
  --付款审批通过回调
  PROCEDURE SPM_CON_WF_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --入库单流程发起
  PROCEDURE SPM_CON_WF_WAREHOUSE_TJ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER);

  --入库单驳回回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_BH(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);
  --入库单批准回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_PZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    VPOSITOIN_ID IN VARCHAR2);
  --入库单通过回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);

  --收款单通过回调
  PROCEDURE SPM_CON_WF_RECEIPT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --撤销认定通过回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_TG(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2);
  --收款审批批准回调
  PROCEDURE SPM_CON_WF_RECEIPT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2);
  --撤销认定批准回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_PZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       VPOSITOIN_ID IN VARCHAR2);

  --收款单驳回回调
  PROCEDURE SPM_CON_WF_RECEIPT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --撤销认定驳回回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_BH(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2);
  --出库单流程发起
  PROCEDURE SPM_CON_WF_ODO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER);

  --出库单驳回回调
  PROCEDURE SPM_CON_WF_ODO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);
  --出库单通过回调
  PROCEDURE SPM_CON_WF_ODO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --出库单批准回调
  PROCEDURE SPM_CON_WF_ODO_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2);
  --退货单审批html展现
  FUNCTION CLS_SALES_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

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

  --收款单发起流程
  PROCEDURE SPM_CON_WF_RECEIPT_FQ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER);
  --撤销认定流程发起
  PROCEDURE SPM_CON_WF_MONEY_RETURN_FQ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
  PROCEDURE SPM_CON_WF_GOODS_PLAN_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER);

  --交货计划驳回回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --交货计划批准回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2);

  --交货计划通过回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);

  /* --合同交接流程发起
   procedure spm_con_WF_TRANS_FQ(itemkey      in varchar2,
                                         otypecode    in varchar2,
                                         pPosition_id in number);
  
   --合同交接流程批准回调
  procedure spm_con_wf_TRANS_PZ(itemkey   IN VARCHAR2,
                                         otypecode In VARCHAR2,
                                         vPositoin_id in VARCHAR2
                                         );
    --合同交接流程通过回调
  procedure spm_con_wf_TRANS_TG(v_itemkey   IN VARCHAR2,
                                      v_otypecode In VARCHAR2);
    --合同交接驳回回调
  procedure spm_con_wf_TRANS_BH(itemkey   IN VARCHAR2,
                                         otypecode In VARCHAR2);*/
  --合同交接信息展现
  FUNCTION CLS_TRANS_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --验证到款登记单信息录入有效性
  PROCEDURE MONEY_REG_VALIDATE(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  --验证银行到款登记单信息录入
  PROCEDURE MONEY_REG_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);

  --入库单审批流程
  FUNCTION CLS_WAREHOUSE_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --出库单审批流程
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --交货计划维护审批流程
  FUNCTION CLS_GOODS_PLAN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                        POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION FN_ISDATE(V_DATESTR IN VARCHAR2) RETURN NUMBER;

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
  --根据供应商/客户类型给履约详情赋值
  PROCEDURE INSERT_EVALUATE_TYPE(EVALUATEID NUMBER, FLAG NUMBER);
  PROCEDURE INSERT_EVALUATE_TYPE_1(EVALUATEIDS VARCHAR2);

  --根据评价得分情况判断等级
  FUNCTION GET_EVALUATE_SCORE(MERCHANTID IN NUMBER, CONID IN NUMBER)
    RETURN VARCHAR2;

  --设置合同综合评分
  PROCEDURE SET_CON_EVALUATE_SCORE(CONID NUMBER);

  PROCEDURE SALES_ORDER_PERSON_PR(P_KEY                  VARCHAR2,
                                  POTYPE_CODE            VARCHAR2,
                                  VGROUP_ID              NUMBER,
                                  VPOSITION_STRUCTURE_ID NUMBER,
                                  VPOSITOIN_ID           VARCHAR2);
  --合同交接必填验证
  /*PROCEDURE SPM_CON_HT_TRANS_VALID(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --收款单同步EBS
  PROCEDURE SPM_CON_AR_RECEIPT(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2);
  --核销发票接口
  PROCEDURE SPM_CON_AR_INVOICE(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2);
  --同步EBS接口表中收款核销应收发票记录 by mcq
  PROCEDURE SYNC_RECEIPT_INVOICE(V_ID             IN NUMBER,
                                 V_RETURN_CODE    OUT VARCHAR2,
                                 V_RETURN_MESSAGE OUT VARCHAR2);

  PROCEDURE SPM_CON_AR_RECE_ACCOUNIT(V_ID          IN NUMBER,
                                     V_USER_ID     IN NUMBER,
                                     V_RESP_ID     IN NUMBER,
                                     V_RESP_APP_ID IN NUMBER,
                                     A_RETURN_CODE OUT VARCHAR2,
                                     A_RETURN_MSG  OUT VARCHAR2);
  PROCEDURE SPM_CON_AR_INVOICE_ACCOUNIT(V_ID          IN NUMBER,
                                        V_USER_ID     IN NUMBER,
                                        V_RESP_ID     IN NUMBER,
                                        V_RESP_APP_ID IN NUMBER,
                                        A_RETURN_CODE OUT VARCHAR2,
                                        A_RETURN_MSG  OUT VARCHAR2);
  --获取到款单同步状态
  FUNCTION GET_STATUS(MONEYREG_ID NUMBER) RETURN VARCHAR2;
  --获取财务到款同步状态
  FUNCTION GET_EBS_STATUS(MONEYREG_ID NUMBER) RETURN VARCHAR2;
  --获取银行ID
  FUNCTION GET_NUMBER(P_ORG_ID           IN NUMBER,
                      P_CURRENCY_CODE    IN VARCHAR2,
                      P_RECEIPT_METHODS  IN VARCHAR2,
                      P_BANK_BRANCH_NAME IN VARCHAR2,
                      P_BANK_ACCOUNT_NUM IN VARCHAR2) RETURN NUMBER;
  --判断是否有导入权限
  FUNCTION IS_CASHIER(RESPONSE_ID NUMBER) RETURN VARCHAR2;
  --合同新建流程必填验证(通知回调)
  PROCEDURE SPM_CON_HT_WF_TRANS_VALID(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --合同交接新建流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_TRANS_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --合同交接流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_TRANS_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);
  --合同交接流程通过回调
  PROCEDURE SPM_CON_WF_TRANS_TG(V_ITEMKEY   IN VARCHAR2,
                                V_OTYPECODE IN VARCHAR2);
  FUNCTION VALIDATE_STATUS(STATUS VARCHAR2) RETURN VARCHAR2;

  FUNCTION GET_LEVAL_BY_SCORE(EVALUATEID IN NUMBER) RETURN VARCHAR2;

  FUNCTION GET_OVER_ALL_LEVAL(MERCHANTSID NUMBER) RETURN VARCHAR2;
  /*procedure receipt_sync;
  procedure receipt_validate;*/

  --批量创建分录
  PROCEDURE BATCH_CREATE_ACCOUNT(V_USER_ID     IN NUMBER,
                                 V_RESP_ID     IN NUMBER,
                                 V_RESP_APP_ID IN NUMBER,
                                 RETURN_MSG    OUT VARCHAR2);
  --查询EBS侧当前收款单剩余金额 by mcq
  FUNCTION GET_EBS_RECEIPT_APPLIED_AMOUNT(P_RECEIPT_CODE VARCHAR2,
                                          P_ORG_ID       NUMBER)
    RETURN NUMBER;
END SPM_CON_RECEIPT_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_CON_RECEIPT_PKG IS
  --获取业务实体id
  FUNCTION GET_ORG_ID(P_ORG_NAME IN VARCHAR2) RETURN NUMBER AS
    L_ORG_ID NUMBER;
  BEGIN
    SELECT ORGANIZATION_ID
      INTO L_ORG_ID
      FROM HR_ALL_ORGANIZATION_UNITS
     WHERE NAME = P_ORG_NAME;
  
    RETURN L_ORG_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
    
  END GET_ORG_ID;
  --取汇款银行
  FUNCTION GET_REMITTANCE_BANK_ACCOUNT_ID(P_ORG_ID           IN NUMBER,
                                          P_RECEIPT_DATE     IN DATE,
                                          P_CURRENCY_CODE    IN VARCHAR2,
                                          P_RECEIPT_METHODS  IN VARCHAR2,
                                          P_BANK_BRANCH_NAME IN VARCHAR2,
                                          P_BANK_ACCOUNT_NUM IN VARCHAR2)
    RETURN NUMBER AS
    L_REMITTANCE_BANK_ACCOUNT_ID NUMBER;
  BEGIN
    SELECT BA.BANK_ACCT_USE_ID
      INTO L_REMITTANCE_BANK_ACCOUNT_ID
      FROM AR_RECEIPT_METHODS             RM,
           AR_RECEIPT_CLASSES             RC,
           AR_LOOKUPS                     L,
           CE_BANK_ACCOUNTS               CBA,
           CE_BANK_ACCT_USES_ALL          BA,
           CE_BANK_BRANCHES_V             BB,
           AR_RECEIPT_METHOD_ACCOUNTS_ALL RMA,
           HR_OPERATING_UNITS             HR
     WHERE RM.RECEIPT_CLASS_ID = RC.RECEIPT_CLASS_ID
       AND RMA.ORG_ID = BA.ORG_ID
       AND HR.ORGANIZATION_ID = RMA.ORG_ID
          -------CZY
          --AND mo_global.check_access(hr.organization_id) = 'Y'
          --  AND rma.org_id = nvl( /*:ar_batches_sum.org_id*/ NULL, rma.org_id)
          -------CZY
       AND RC.CREATION_STATUS = L.LOOKUP_CODE
       AND L.LOOKUP_TYPE = 'RECEIPT_CREATION_STATUS'
       AND (P_RECEIPT_DATE BETWEEN RM.START_DATE AND
           NVL(RM.END_DATE, P_RECEIPT_DATE))
       AND RC.CREATION_METHOD_CODE = 'MANUAL'
       AND CBA.ACCOUNT_CLASSIFICATION = 'INTERNAL'
       AND NVL(BA.END_DATE, TO_DATE(P_RECEIPT_DATE) + 1) >
          
           P_RECEIPT_DATE
       AND
          /*Bug 2392508 to check if the bank is inactive*/
           NVL(BB.END_DATE, P_RECEIPT_DATE + 1) >
          
           P_RECEIPT_DATE
       AND P_RECEIPT_DATE BETWEEN RMA.START_DATE AND
           NVL(RMA.END_DATE, P_RECEIPT_DATE)
          /*Bug 6531114 if currency is not entered in the receipt form then all currencies receipt methods are displayed*/
       AND CBA.CURRENCY_CODE =
           DECODE(CBA.RECEIPT_MULTI_CURRENCY_FLAG,
                  'Y',
                  CBA.CURRENCY_CODE,
                  NVL(P_CURRENCY_CODE, CBA.CURRENCY_CODE))
       AND CBA.BANK_BRANCH_ID = BB.BRANCH_PARTY_ID
       AND RM.RECEIPT_METHOD_ID = RMA.RECEIPT_METHOD_ID
       AND CBA.BANK_ACCOUNT_ID = BA.BANK_ACCOUNT_ID
       AND CBA.AR_USE_ALLOWED_FLAG = 'Y'
       AND NVL(BA.AR_USE_ENABLE_FLAG, 'N') = 'Y'
       AND RMA.REMIT_BANK_ACCT_USE_ID = BA.BANK_ACCT_USE_ID
       AND RM.RECEIPT_CLASS_ID NOT IN
           (SELECT ARC.RECEIPT_CLASS_ID
              FROM AR_RECEIPT_CLASSES ARC
             WHERE ARC.NOTES_RECEIVABLE = 'Y'
                OR ARC.BILL_OF_EXCHANGE_FLAG = 'Y')
       AND RM.NAME = P_RECEIPT_METHODS
       AND RMA.ORG_ID = P_ORG_ID
          --AND bb.bank_branch_name = p_bank_branch_name
       AND CE_BANK_AND_ACCOUNT_UTIL.GET_MASKED_BANK_ACCT_NUM(CBA.BANK_ACCOUNT_ID) =
           P_BANK_ACCOUNT_NUM;
  
    RETURN L_REMITTANCE_BANK_ACCOUNT_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_REMITTANCE_BANK_ACCOUNT_ID;
  --入库单保存数据插入
  PROCEDURE SPM_CON_WARE_HOUSE_CC(V_ID NUMBER) AS
  
    V_AMOUNT NUMBER;
    V_ROWNUM NUMBER; --总支数
    V_TAX    NUMBER; --总税额
  BEGIN
    --查询入库总金额（包括均摊成本）
    SELECT NVL(SUM(ROUND(I.THIS_WAREHOUSE_NUMBER * I.WAREHOUSE_UNIT_PRICE,
                         2)),
               0)
      INTO V_AMOUNT
      FROM SPM_CON_WAREHOUSE_DL I
     WHERE I.WAREHOUSE_ID = V_ID;
  
    SELECT V_AMOUNT + NVL(A.TRAFFIC_EXPENSE, 0) + NVL(A.PREMIUM_AMOUNT, 0) +
           NVL(A.PORT_SURCHARGE, 0) + NVL(A.IMPORT_TARIFF, 0) +
           NVL(A.SPECIAL_TARIFF, 0)
      INTO V_AMOUNT
      FROM SPM_CON_WAREHOUSE A
     WHERE A.WAREHOUSE_ID = V_ID;
  
    --add by ruankk to_do: 保存总支数信息  
    -- 保存总税额  保存价税合计
    --总支数 
    SELECT COUNT(D.WAREHOUSE_DL_ID)
      INTO V_ROWNUM
      FROM SPM_CON_WAREHOUSE_DL D
     WHERE D.WAREHOUSE_ID = V_ID;
  
    --总税额
    SELECT NVL(W.IMPORT_VAT, 0) + NVL(W.TRAFFIC_EXPENSE_TAX, 0) +
           NVL(W.PREMIUM_AMOUNT_TAX, 0) + NVL(W.PORT_SURCHARGE_TAX, 0)
      INTO V_TAX
      FROM SPM_CON_WAREHOUSE W
     WHERE W.WAREHOUSE_ID = V_ID;
  
    --修改入库单的入库金额
    UPDATE SPM_CON_WAREHOUSE A
       SET A.WAREHOUSE_AMOUNT_MONEY = V_AMOUNT,
           A.EDITABLE_AMOUNT        = V_AMOUNT,
           A.WAREHOUSE_AMOUNT_TAX   = V_TAX,
           A.WAREHOUSE_AMOUNT_ALL   = V_AMOUNT + V_TAX,
           A.ROWS_NUMBER            = V_ROWNUM
     WHERE A.WAREHOUSE_ID = V_ID;
  END;

  --出库单保存数据插入
  PROCEDURE SPM_CON_ODO_CC(ID NUMBER) AS
  
    V_AMOUNT NUMBER;
  BEGIN
    --查出总金额
    SELECT ROUND(NVL(SUM(I.TAX_AMOUNT_COUNT), 0), 2)
      INTO V_AMOUNT
      FROM SPM_CON_ODO_DL I
     WHERE 1 = 1
       AND I.ODO_ID = ID;
  
    --修改出库单的出库金额
    UPDATE SPM_CON_ODO A
       SET A.ODO_MONEY_AMOUNT = V_AMOUNT
     WHERE A.ODO_ID = ID;
  END;

  --出库单保存数据插入
  PROCEDURE SPM_CON_ASSETS_CC(ID NUMBER) AS
  
    V_1      NUMBER;
    V_AMOUNT NUMBER;
    CURSOR CUR IS
      SELECT * FROM SPM_CON_ODO_DL T WHERE T.ODO_ID = ID;
  
  BEGIN
  
    FOR C IN CUR LOOP
    
      --查询是否来自库存减值
      SELECT COUNT(*)
        INTO V_1
        FROM CUX_ITEM_XYL_QUERY_V T
       WHERE 1 = 1
         AND T.物料代码 = C.MATERIAL_CODE
         AND T.物料名称 = C.MATERIAL_NAME
         AND T.子库存代码 = C.STORE_ROOM
         AND T.LOCATOR_ID = C.GOODS_LOCATION
         AND T.INVENTORY_ITEM_ID = C.TARGET_ID
         AND T.组织ID = SPM_SSO_PKG.GETORGID;
    
      IF V_1 > 0 THEN
        UPDATE SPM_CON_ODO_DL T
           SET T.ATTRIBUTE3 =
               (SELECT F.ATTRIBUTE3
                  FROM SPM_CON_ASSETS_IMPAIRMENT F
                 WHERE F.INVENTORY_ITEM_ID = C.TARGET_ID
                   AND F.ATTRIBUTE1 = C.STORE_ROOM
                   AND F.ATTRIBUTE2 = C.GOODS_LOCATION_PATH
                   AND F.VERSION_NUMBER = 1)
         WHERE T.ODO_ID = C.ODO_ID;
      
        SELECT DISTINCT SUM((SELECT T.THIS_ODO_NUMBER
                               FROM SPM_CON_ODO_DL T
                              WHERE T.ODO_ID = D.ODO_ID
                                AND T.ATTRIBUTE3 = T1.ATTRIBUTE3
                                AND T.TARGET_ID = F.INVENTORY_ITEM_ID
                                AND T.TARGET_ID = F.INVENTORY_ITEM_ID
                                AND T.MATERIAL_CODE = F.物料代码
                                AND F.子库存代码 = T.STORE_ROOM
                                AND F.货位 = T.GOODS_LOCATION_PATH) *
                            (T1.ESTIMATE_UNIT_PRICE - F.单价))
          INTO V_AMOUNT
          FROM CUX_ITEM_XYL_QUERY_V F
          LEFT JOIN SPM_CON_ASSETS_IMPAIRMENT T1
            ON F.INVENTORY_ITEM_ID = T1.INVENTORY_ITEM_ID
           AND F.子库存代码 = T1.ATTRIBUTE1
           AND F.货位 = T1.ATTRIBUTE2, SPM_CON_ODO D
         WHERE 1 = 1
           AND SPM_SSO_PKG.GETORGID = F.组织ID
           AND T1.INVENTORY_ITEM_ID IN
               (SELECT TARGET_ID FROM SPM_CON_ODO_DL)
           AND T1.INVENTORY_ITEM_ID =
               (SELECT AA.TARGET_ID
                  FROM SPM_CON_ODO_DL AA
                 WHERE AA.ODO_ID = D.ODO_ID
                   AND T1.ATTRIBUTE3 = AA.ATTRIBUTE3
                   AND AA.STORE_ROOM = F.子库存代码
                   AND AA.MATERIAL_CODE = F.物料代码
                   AND AA.GOODS_LOCATION = F.LOCATOR_ID)
           AND ((SELECT T.CREATION_DATE
                   FROM SPM_CON_ODO_DL T
                  WHERE T.ODO_ID = D.ODO_ID
                    AND T.ATTRIBUTE3 = T.ATTRIBUTE3
                    AND T.TARGET_ID = F.INVENTORY_ITEM_ID
                    AND T.MATERIAL_CODE = F.物料代码
                    AND F.子库存代码 = T.STORE_ROOM
                    AND F.货位 = T.GOODS_LOCATION_PATH)) > T1.CREATION_DATE
           AND D.ODO_ID = ID;
      END IF;
      UPDATE SPM_CON_ODO T
         SET T.ASSETS_AMOUNT = V_AMOUNT
       WHERE T.ODO_ID = ID;
    
    END LOOP;
  
  END;

  --退货单单保存数据插入
  PROCEDURE SPM_CON_SALES_RETURN_CC(ID NUMBER) AS
  
    V_AMOUNT NUMBER;
  BEGIN
    --查出总金额
    SELECT DISTINCT (NVL((SELECT SUM(I.SALES_RETURN * I.TAX_ODO_UNIT_PRICE)
                           FROM SPM_CON_ODO_DL I
                          WHERE I.ODO_ID = A.ODO_ID),
                         0))
      INTO V_AMOUNT
      FROM SPM_CON_SALES_RETURN A
     WHERE A.SALES_RETURN_ID = ID;
  
    --修改退货单的出库金额
    UPDATE SPM_CON_SALES_RETURN A
       SET A.SALES_RETURN_AMOUNT_MONEY = V_AMOUNT
     WHERE A.SALES_RETURN_ID = ID;
    COMMIT;
  
  END;

  --是否关联发票
  FUNCTION SPM_CON_WAREHOUSE_CONNECT(ID NUMBER) RETURN VARCHAR2 AS
    V_IS_CONNECT_INVOICE VARCHAR2(40);
    V_NUMBER             NUMBER;
  BEGIN
    --查询
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM SPM_CON_WAREHOUSE T
      LEFT JOIN SPM_CON_INPUT_WAREHOUSE D
        ON T.WAREHOUSE_ID = D.WAREHOUSE_ID
     WHERE 1 = 1
       AND T.WAREHOUSE_ID = ID
       AND D.WAREHOUSE_ID > 0;
    --给isconnectinvoice赋值
    IF V_NUMBER = 0 THEN
      RETURN '未关联';
    ELSE
      RETURN '已关联';
    END IF;
  END;
  --对审批通过的入库单进行修改 释放数量
  PROCEDURE EMPTY_SPM_CON_WAREHOUSE_DL(P_ID NUMBER, OUT_MSG OUT VARCHAR2) IS
    K_NUMBER NUMBER; --已经被出库单引用
  BEGIN
    SELECT COUNT(D.SPM_CON_ODO_DL_ID)
      INTO K_NUMBER
      FROM SPM_CON_ODO_DL D
     WHERE D.WAREHOUSE_DL_ID IN
           (SELECT T.WAREHOUSE_DL_ID
              FROM SPM_CON_WAREHOUSE_DL T
             WHERE T.WAREHOUSE_ID = P_ID)
    AND NVL(D.SALES_RETURN,0) = 0 ;
    --即使被关联了,但是发生了退库,所以查出来应该还是0,允许撤销;
    
    IF K_NUMBER = 0 THEN
      UPDATE SPM_CON_WAREHOUSE_DL D
         SET D.THIS_WAREHOUSE_NUMBER = NULL, D.CON_TARGET_ID = NULL
       WHERE D.WAREHOUSE_ID =
             (SELECT T.WAREHOUSE_ID
                FROM SPM_CON_WAREHOUSE T
               WHERE T.WAREHOUSE_ID = P_ID);
      UPDATE SPM_CON_WAREHOUSE T
         SET T.ATTRIBUTE2 = '1'
       WHERE T.WAREHOUSE_ID = P_ID;
      COMMIT;
      OUT_MSG := 'Y-释放成功';
    ELSE
      OUT_MSG := 'N-释放失败,该入库单已经被出库单关联,不允许释放';
    END IF;
  END;

  --收款单审批HTML展现
  FUNCTION CLS_RECEIPT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG          VARCHAR2(20000);
    V_RECEIPT_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_RECEIPT_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConReceipt/edit/' ||
                                                V_RECEIPT_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --撤销认定审批HTML展现
  FUNCTION CLS_MONEY_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG            VARCHAR2(20000);
    V_MONEY_REG_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_MONEY_REG_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConMoneyReg/edit/' ||
                                                V_MONEY_REG_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --付款审批流程
  FUNCTION CLS_PAYMENT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG          VARCHAR2(20000);
    V_PAYMENT_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_PAYMENT_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConPayment/edit/' ||
                                                V_PAYMENT_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --付款审批流程发起
  PROCEDURE SPM_CON_WF_PAYMENT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_PAYMENT
       SET STATUS = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                   PPOSITION_ID)
     WHERE PAYMENT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --付款驳回回调
  PROCEDURE SPM_CON_WF_PAYMENT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_PAYMENT SET STATUS = 'D' WHERE PAYMENT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         '',
                                         'JOB_ID',
                                         'PAYMENT_ID');
  
  END;
  --付款审批批准回调
  PROCEDURE SPM_CON_WF_PAYMENT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PAYMENT_ID');
    UPDATE SPM_CON_ENG E
       SET E.ENG_NAME = '我进来了'
     WHERE E.ENG_ID = '1000024';
  END;
  --付款审批通过回调
  PROCEDURE SPM_CON_WF_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_PAYMENT SET STATUS = 'E' WHERE PAYMENT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         '',
                                         'JOB_ID',
                                         'PAYMENT_ID');
  END;
  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
  PROCEDURE SET_GOODS_WF_STATUS_TO_1(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_HT_TARGET T
       SET T.GOODS_WF_STATUS = '1'
     WHERE T.TARGET_ID = (SELECT R.TARGET_ID
                            FROM SPM_CON_GOODS_PLAN R
                           INNER JOIN SPM_CON_HT_TARGET I
                              ON I.TARGET_ID = R.TARGET_ID
                             AND R.ITEM_KEY = ITEMKEY);
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- 回滚事务
      ROLLBACK;
  END;

  --入库单流程发起
  PROCEDURE SPM_CON_WF_WAREHOUSE_TJ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_WAREHOUSE
       SET STATUS = 'C', ITEM_KEY = ITEMKEY
     WHERE WAREHOUSE_ID = V_ID;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --入库单驳回回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_BH(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_WAREHOUSE SET STATUS = 'D' WHERE WAREHOUSE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_WAREHOUSE',
                                         '',
                                         'JOB_ID',
                                         'WAREHOUSE_ID');
    COMMIT;
  
  END;

  --入库单批准回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_PZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PAYMENT_ID');
    COMMIT;
  
  END;

  --入库单通过回调
  PROCEDURE SPM_CON_WF_WAREHOUSE_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_WAREHOUSE SET STATUS = 'E' WHERE WAREHOUSE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_WAREHOUSE',
                                         '',
                                         'JOB_ID',
                                         'WAREHOUSE_ID');
    COMMIT;
  
  END;

  --收款单通过回调
  PROCEDURE SPM_CON_WF_RECEIPT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_RECEIPT SET STATUS = 'E' WHERE RECEIPT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'RECEIPT_ID');
  END;
  --撤销认定通过回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_TG(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_MONEY_REG SET STATUS = 'E' WHERE MONEY_REG_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'MONEY_REG_ID');
  END;
  --收款审批批准回调
  PROCEDURE SPM_CON_WF_RECEIPT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_RECEIPT',
                                         'STATUS',
                                         'JOB_ID',
                                         'RECEIPT_ID');
  END;
  --撤销认定批准回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_PZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_MONEY_REG',
                                         'STATUS',
                                         'JOB_ID',
                                         'MONEY_REG_ID');
  END;
  --收款单驳回回调
  PROCEDURE SPM_CON_WF_RECEIPT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_RECEIPT SET STATUS = 'D' WHERE RECEIPT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'RECEIPT_ID');
  
  END;
  --收款单驳回回调
  PROCEDURE SPM_CON_WF_MONEY_RETURN_BH(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_MONEY_REG SET STATUS = 'D' WHERE MONEY_REG_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'RECEIPT_ID');
  
  END;
  --出库单流程发起
  PROCEDURE SPM_CON_WF_ODO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_ODO
       SET STATUS = 'C', ITEM_KEY = ITEMKEY
     WHERE ODO_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --出库单驳回回调
  PROCEDURE SPM_CON_WF_ODO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_ODO SET STATUS = 'D' WHERE ODO_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ODO',
                                         '',
                                         'JOB_ID',
                                         'ODO_ID');
    COMMIT;
  
  END;
  --出库单批准回调
  PROCEDURE SPM_CON_WF_ODO_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PAYMENT_ID');
    COMMIT;
  
  END;

  --出库单通过回调
  PROCEDURE SPM_CON_WF_ODO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程批准后,将业务表状态更改为E
    UPDATE SPM_CON_ODO SET OUTPUT_OR_RETURN = '2' WHERE ODO_ID = V_ID;
    COMMIT;
  END;

  --退货单审批html展现
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
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConSalesReturn/edit/' ||
                                                V_SALES_RETURN_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

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
    COMMIT;
  
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
  
    COMMIT;
  END;

  --退货单通过回调
  PROCEDURE SPM_CON_WF_SALES_RETURN_TG(ITEMKEY   IN VARCHAR2,
                                       OTYPECODE IN VARCHAR2) AS
    V_ID            VARCHAR2(40);
    V_DD            VARCHAR2(40);
    V_SALES_RETURN  NUMBER;
    V_SALES_RETURN1 NUMBER;
  
    CURSOR CUR IS
      SELECT S.ODO_ID
        FROM SPM_CON_ODO_DL S, SPM_CON_SALES_RETURN F
       WHERE F.ITEM_KEY = ITEMKEY
         AND F.ODO_ID = S.ODO_ID;
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT F.ODO_ID
      INTO V_DD
      FROM SPM_CON_SALES_RETURN F
     WHERE F.ITEM_KEY = ITEMKEY;
    UPDATE SPM_CON_ODO SET OUTPUT_OR_RETURN = '1' WHERE ODO_ID = V_DD;
  
    /*      for c in cur loop
    update  spm_con_odo_dl f set f.this_odo_number=f.this_odo_number-f.sales_return where
     f.odo_id=v_dd;
    end loop;*/
  
    --update SPM_CON_ODO_DL E SET E.ED_SALES_RETURN=v_sales_return1 WHERE E.ODO_ID=v_Id;
    COMMIT;
    /*      SELECT odo_id into v_dd FROM SPM_CON_SALES_RETURN  WHERE SALES_RETURN_ID = v_Id;
    SELECT t.sales_return into v_sales_return from spm_con_odo_dl t where  t.odo_id=v_dd;
    SELECT t.ed_sales_return into v_sales_return1 from spm_con_odo_dl t where  t.odo_id=v_dd;
    v_sales_return1 :=v_sales_return+v_sales_return;
    commit;*/
  
  END;
  /*--合同交接流程审批启动后，将对应标的物的状态更新为：C
    procedure spm_con_wf_TRANS_FQ(itemkey      in varchar2,
                                       otypecode    in varchar2,
                                       pPosition_id in number) as
      v_Id VARCHAR2(40);
  
  
  
  
    begin
      SELECT I.JOB_ID
        INTO v_Id
        FROM SPM_CON_WF_ACTIVITY I
       WHERE I.ITEM_KEY = itemkey;
  
      --流程发起后,将业务表状态更改为C 发起状态
      UPDATE SPM_CON_HT_TRANS S SET S.STATUS = 'C',S.TRANSFER_DATE=SYSDATE,S.ITEM_KEY = itemkey WHERE HT_TRANSFER_ID = v_Id;
  
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
  
    END;
  
    --合同交接批准回调
  procedure spm_con_wf_TRANS_PZ(itemkey      IN VARCHAR2,
                                    otypecode    In VARCHAR2,
                                    vPositoin_id in VARCHAR2) AS
    BEGIN
      --保存到流程记录表
      SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                           otypecode,
                                           'SPM_CON_HT_TRANS',
                                           'STATUS',
                                           'JOB_ID',
                                           'HT_TRANSFER_ID');
  
    END;
      --退货单驳回回调
    procedure spm_con_wf_TRANS_BH(itemkey   IN VARCHAR2,
                                      otypecode In VARCHAR2) AS
      v_Id VARCHAR2(40);
    BEGIN
  
      SELECT I.JOB_ID
        INTO v_Id
        FROM SPM_CON_WF_ACTIVITY I
       WHERE I.ITEM_KEY = itemkey;
  
      --流程驳回后,将业务表状态更改为D
      UPDATE SPM_CON_HT_TRANS SET STATUS = 'D' WHERE HT_TRANSFER_ID= v_Id;
      --保存到流程记录表
      SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                           otypecode,
                                           'SPM_CON_HT_TRANS',
                                           '',
                                           'JOB_ID',
                                           'HT_TRANSFER_ID');
  
    END;
       --合同交接通过回调
    procedure spm_con_wf_TRANS_TG(v_itemkey   IN VARCHAR2,
                                      v_otypecode In VARCHAR2) AS
      v_Id       VARCHAR2(40);
      userid     number;
      username   varchar2(200);
      personId   number;
      deptid     number;
      cursor transdecur is select contract_id from spm_con_ht_trans_detail l where
      l.ht_transfer_id=(select s.ht_transfer_id from spm_con_ht_trans s where s.item_key=v_itemkey);
    BEGIN
      SELECT I.JOB_ID
        INTO v_Id
        FROM SPM_CON_WF_ACTIVITY I
       WHERE I.ITEM_KEY = v_itemkey;
  
      --流程通过后,将业务表状态更改为E
      UPDATE SPM_CON_HT_TRANS SET STATUS = 'E',RECEIPT_DATE=SYSDATE WHERE HT_TRANSFER_ID = v_Id;
      --保存到流程记录表
      SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(v_itemkey,
                                           v_otypecode,
                                           'SPM_CON_HT_TRANS',
                                           '',
                                           'JOB_ID',
                                           'HT_TRANSFER_ID');
       select user_name into username from ccm_wf_user_group p where p.itemkey=v_itemkey \*and rownum =1*\ ;
       --查出接收人的userid
       select distinct user_id into userid  from spm_all_people_v v where v.USER_NAME=username;
       for c in transdecur loop
         update spm_con_ht_info o set o.created_by=userid where o.contract_id=c.contract_id;
         end loop;
  
  
    END;
  */
  --合同交接新建流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_TRANS_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.GENERATE_HISTORY_INFO(P_NOTIFID,
                                               P_ITEMKEY,
                                               P_OTYPE_CODE,
                                               'SPM_CON_HT_TRANS',
                                               'HT_TRANSFER_ID',
                                               'STATUS',
                                               'ITEM_KEY',
                                               'D',
                                               'E');
    UPDATE SPM_CON_HT_TRANS S
       SET S.TRANSFER_DATE = SYSDATE
     WHERE S.ITEM_KEY = P_ITEMKEY;
  END SPM_CON_HT_WF_TRANS_TZSC;

  --合同交接流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_TRANS_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
    CURSOR TRANSDECUR IS
      SELECT CONTRACT_ID
        FROM SPM_CON_HT_TRANS_DETAIL L
       WHERE L.HT_TRANSFER_ID =
             (SELECT S.HT_TRANSFER_ID
                FROM SPM_CON_HT_TRANS S
               WHERE S.ITEM_KEY = P_KEY);
    USERNAME VARCHAR2(200);
    USERID   NUMBER;
  BEGIN
    SELECT USER_NAME
      INTO USERNAME
      FROM CCM_WF_USER_GROUP P
     WHERE P.ITEMKEY = P_KEY
       AND ROWNUM = 1;
    --查出接收人的userid
    SELECT DISTINCT USER_ID
      INTO USERID
      FROM SPM_ALL_PEOPLE_V V
     WHERE V.USER_NAME = USERNAME;
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT); --修改流程
    UPDATE SPM_CON_HT_TRANS S
       SET RECEIPT_DATE = SYSDATE
     WHERE S.ITEM_KEY = P_KEY;
    --遍历选择的合同，修改合同的经办人
    FOR C IN TRANSDECUR LOOP
      UPDATE SPM_CON_HT_INFO O
         SET O.CREATED_BY = USERID
       WHERE O.CONTRACT_ID = C.CONTRACT_ID;
    END LOOP;
  END SPM_CON_HT_WF_TRANS_TZH;

  --付款审批流程
  FUNCTION CLS_TRANS_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG              VARCHAR2(20000);
    V_HT_TRANSFER_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_HT_TRANSFER_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConHtTrans/edit/' ||
                                                V_HT_TRANSFER_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --收款单流程发起
  PROCEDURE SPM_CON_WF_RECEIPT_FQ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_RECEIPT SET STATUS = 'C' WHERE RECEIPT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --收款单流程发起
  PROCEDURE SPM_CON_WF_MONEY_RETURN_FQ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_MONEY_REG SET STATUS = 'C' WHERE MONEY_REG_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
  PROCEDURE SPM_CON_WF_GOODS_PLAN_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_GOODS_PLAN
       SET STATUS = 'C', ITEM_KEY = ITEMKEY
     WHERE GOODS_PLAN_ID = V_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --交货计划驳回回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_GOODS_PLAN SET STATUS = 'D' WHERE GOODS_PLAN_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_GOODS_PLAN',
                                         '',
                                         'JOB_ID',
                                         'GOODS_PLAN_ID');
    COMMIT;
  END;
  --交货计划批准回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PAYMENT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PAYMENT_ID');
    COMMIT;
  
  END;

  --交货计划通过回调
  PROCEDURE SPM_CON_WF_GOODS_PLAN_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程批准后,将业务表状态更改为E
    UPDATE SPM_CON_GOODS_PLAN SET STATUS = 'E' WHERE GOODS_PLAN_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_GOODS_PLAN',
                                         '',
                                         'JOB_ID',
                                         'GOODS_PLAN_ID');
    COMMIT;
  
  END;

  --验证到款登记单信息录入
  PROCEDURE MONEY_REG_VALIDATE(P_TABLENAME VARCHAR2,
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
             TRIM(M)
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
    VALIDATE_I       VARCHAR2(2000);
    VALIDATE_J       VARCHAR2(2000);
    VALIDATE_K       VARCHAR2(2000);
    VALIDATE_L       VARCHAR2(2000);
    VALIDATE_M       VARCHAR2(2000);
    VALIDATE_N       VARCHAR2(2000);
    VALIDATE_O       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    VALIDATE_NUMBER5 NUMBER;
    VALIDATE_NUMBER6 NUMBER;
    VALIDATE_NUMBER7 NUMBER;
    VALIDATE_NUMBER8 NUMBER;
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
    MSG_O            VARCHAR2(4000);
    MSG_P            VARCHAR2(4000);
    MSG_Q            VARCHAR2(4000);
    MSG_R            VARCHAR2(4000);
    MSG_S            VARCHAR2(4000);
    MSG_T            VARCHAR2(4000);
  
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
           VALIDATE_M;
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_A <> '流水号' OR VALIDATE_B <> '对方户名' OR VALIDATE_C <> '金额' OR
         VALIDATE_D <> '币种' OR VALIDATE_E <> '付款日期' OR VALIDATE_F <> '摘要' OR
         VALIDATE_G <> '收款银行' OR VALIDATE_H <> '收款账号' OR
         VALIDATE_I <> '收款单位' OR VALIDATE_J <> '收款方法' THEN
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
             VALIDATE_M;
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
        IF VALIDATE_I IS NULL THEN
          IF MSG_I IS NULL THEN
            MSG_I := CU_DATA%ROWCOUNT;
          ELSE
            MSG_I := MSG_I || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_J IS NULL THEN
          IF MSG_J IS NULL THEN
            MSG_J := CU_DATA%ROWCOUNT;
          ELSE
            MSG_J := MSG_J || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_B IS NOT NULL THEN
          --查询客户是否存在
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER4
            FROM APPS.AR_CUSTOMERS           AC,
                 APPS.HZ_CUST_ACCOUNTS       HCA,
                 APPS.HZ_CUST_ACCT_SITES_ALL HCAS,
                 APPS.HZ_CUST_SITE_USES_ALL  HCSU
           WHERE AC.CUSTOMER_NUMBER = HCA.ACCOUNT_NUMBER
             AND HCA.CUST_ACCOUNT_ID = HCAS.CUST_ACCOUNT_ID
             AND HCAS.CUST_ACCT_SITE_ID = HCSU.CUST_ACCT_SITE_ID
             AND HCSU.SITE_USE_CODE = 'BILL_TO'
             AND AC.CUSTOMER_NAME = VALIDATE_B;
          IF VALIDATE_NUMBER4 = 0 THEN
            IF MSG_K IS NULL THEN
              MSG_K := CU_DATA%ROWCOUNT;
            ELSE
              MSG_K := MSG_K || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_C IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_C)
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
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(M.SERIAL_NUMBER)
            INTO VALIDATE_NUMBER1
            FROM SPM_CON_MONEY_REG M
           WHERE M.SERIAL_NUMBER = VALIDATE_A;
          IF VALIDATE_NUMBER1 > 0 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_E IS NOT NULL THEN
          VALIDATE_NUMBER2 := SPM_CON_UTIL_PKG.IS_DATE(SUBSTR(VALIDATE_E,
                                                              0,
                                                              10),
                                                       'YYYY-MM-DD');
          IF VALIDATE_NUMBER2 = 0 THEN
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA%ROWCOUNT;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_J IS NOT NULL THEN
          IF GET_NUMBER(P_ORG_ID           => NULL,
                        P_CURRENCY_CODE    => NULL,
                        P_RECEIPT_METHODS  => VALIDATE_J,
                        P_BANK_BRANCH_NAME => NULL,
                        P_BANK_ACCOUNT_NUM => NULL) IS NULL THEN
            IF MSG_O IS NULL THEN
              MSG_O := CU_DATA%ROWCOUNT;
            ELSE
              MSG_O := MSG_O || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_H IS NOT NULL THEN
          IF GET_NUMBER(P_ORG_ID           => NULL,
                        P_CURRENCY_CODE    => NULL,
                        P_RECEIPT_METHODS  => NULL,
                        P_BANK_BRANCH_NAME => NULL,
                        P_BANK_ACCOUNT_NUM => VALIDATE_H) IS NULL THEN
            IF MSG_P IS NULL THEN
              MSG_P := CU_DATA%ROWCOUNT;
            ELSE
              MSG_P := MSG_P || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_G IS NOT NULL THEN
          IF GET_NUMBER(P_ORG_ID           => NULL,
                        P_CURRENCY_CODE    => NULL,
                        P_RECEIPT_METHODS  => NULL,
                        P_BANK_BRANCH_NAME => VALIDATE_G,
                        P_BANK_ACCOUNT_NUM => NULL) IS NULL THEN
            IF MSG_Q IS NULL THEN
              MSG_Q := CU_DATA%ROWCOUNT;
            ELSE
              MSG_Q := MSG_Q || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_G IS NOT NULL AND VALIDATE_H IS NOT NULL AND
           VALIDATE_J IS NOT NULL THEN
          IF GET_REMITTANCE_BANK_ACCOUNT_ID(P_ORG_ID           => GET_ORG_ID(P_ORG_NAME => VALIDATE_I),
                                            P_RECEIPT_DATE     => SYSDATE,
                                            P_CURRENCY_CODE    => NULL,
                                            P_RECEIPT_METHODS  => VALIDATE_J,
                                            P_BANK_BRANCH_NAME => VALIDATE_G,
                                            P_BANK_ACCOUNT_NUM => VALIDATE_H) IS NULL THEN
            IF MSG_S IS NULL THEN
              MSG_S := CU_DATA%ROWCOUNT;
            ELSE
              MSG_S := MSG_S || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_I IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER6
            FROM SPM_ALL_PEOPLE_V V
           WHERE V.USER_ID = TO_NUMBER(VALIDATE_L)
             AND V.ORG_NAME = VALIDATE_I;
          IF VALIDATE_NUMBER6 = 0 THEN
            IF MSG_R IS NULL THEN
              MSG_R := CU_DATA%ROWCOUNT;
            ELSE
              MSG_R := MSG_R || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_B IS NOT NULL THEN
          IF GET_ORG_ID(VALIDATE_B) IS NULL THEN
            IF MSG_T IS NULL THEN
              MSG_T := CU_DATA%ROWCOUNT;
            ELSE
              MSG_T := MSG_T || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        --if validate_g is not null then
        -- select count(name) into validate_number3 from (select d.dict_name as name from spm_dict d inner join spm_dict_type dt on d.dict_type_id=dt.dict_type_id where dt.type_code='PAY_WAY_DICT') a
        --where a.name=validate_g;
        --if validate_number3=0 then
        --msg_l:=msg_l||','||cu_data%rowcount||'行,付款方式不正确,付款方式包括：现金，信用证，电汇';
        -- end if;
        --end if;
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
               VALIDATE_M;
      END LOOP;
      CLOSE CU_DATA;
    END IF;
    IF MSG_A IS NOT NULL THEN
      MSG_A := MSG_A || '行 编号不能为空;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '行 对方户名不能为空;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '行 金额不能为空;  ';
    END IF;
    IF MSG_D IS NOT NULL THEN
      MSG_D := MSG_D || '行 币种不能为空;  ';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '行 付款日期不能为空;  ';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '行 摘要不能为空;  ';
    END IF;
    IF MSG_G IS NOT NULL THEN
      MSG_G := MSG_G || '行 收款银行不能为空;  ';
    END IF;
    IF MSG_H IS NOT NULL THEN
      MSG_H := MSG_H || '行 收款账号不能为空;  ';
    END IF;
    IF MSG_I IS NOT NULL THEN
      MSG_I := MSG_I || '行 收款账户不能为空;  ';
    END IF;
    IF MSG_J IS NOT NULL THEN
      MSG_J := MSG_J || '行 收款方法不能为空;  ';
    END IF;
    IF MSG_K IS NOT NULL THEN
      MSG_K := MSG_K || '行 该客户不存在;  ';
    END IF;
    IF MSG_L IS NOT NULL THEN
      MSG_L := MSG_L || '行 金额格式不正确;  ';
    END IF;
    IF MSG_M IS NOT NULL THEN
      MSG_M := MSG_M || '行 该条记录已经存在，不能再次导入;  ';
    END IF;
    IF MSG_N IS NOT NULL THEN
      MSG_N := MSG_N || '行,日期格式不正确。正确格式例：2013-04-12';
    END IF;
    IF MSG_O IS NOT NULL THEN
      MSG_O := MSG_O || '行 该收款方法不存在;  ';
    END IF;
    IF MSG_P IS NOT NULL THEN
      MSG_P := MSG_P || '行 该收款账号不存在;  ';
    END IF;
    IF MSG_Q IS NOT NULL THEN
      MSG_Q := MSG_Q || '行 该收款银行不存在;  ';
    END IF;
    IF MSG_R IS NOT NULL THEN
      MSG_R := MSG_R || '行 你没有导入该单位到款的权限;  ';
    END IF;
    IF MSG_S IS NOT NULL THEN
      MSG_S := MSG_S || '行 无法获取银行帐户;  ';
    END IF;
    IF MSG_T IS NOT NULL THEN
      MSG_T := MSG_T || '行 无法获取客户id;  ';
    END IF;
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;
  --验证银行到款登记单信息录入

  PROCEDURE MONEY_REG_IMPORT(P_TABLENAME VARCHAR2,
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
             TRIM(N)
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
    V_INFO_ID  NUMBER;
  
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
           VALIDATE_N;
    WHILE CU_DATA%FOUND LOOP
      --主键
      SELECT SPM_CON_MONEY_REG_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
    
      INSERT INTO SPM_CON_MONEY_REG
        (MONEY_REG_ID,
         SERIAL_NUMBER,
         ACCOUNT_NAME,
         MONEY_ACCOUNT,
         RESIDUAL_AMOUNT,
         CURRENCY_TYPE,
         COLLECTION_DATE,
         REMARK,
         DEPOSIT_BANK,
         RECEIPT_ACCOUNT,
         RECEIPT_NAME,
         RECEIPT_METHOD,
         DEPT_ID,
         CREATED_BY,
         ORG_ID,
         /*CUST_ID,*/ --对客户ID的赋值移到出纳认定类型操作里
         CREATION_DATE,
         LAST_UPDATE_DATE,
         STATUS)
      VALUES
        (V_INFO_ID,
         VALIDATE_A,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_C,
         VALIDATE_D,
         TO_DATE(SUBSTR(VALIDATE_E, 0, 10), 'yyyy-mm-dd'),
         VALIDATE_F,
         VALIDATE_G,
         VALIDATE_H,
         VALIDATE_I,
         VALIDATE_J,
         VALIDATE_K,
         VALIDATE_L,
         SPM_SSO_PKG.GETORGID,
         /*(SELECT CUST_ID
          FROM SPM_CON_CUST_INFO O
         WHERE O.CUST_NAME = VALIDATE_B
           AND ROWNUM = 1),*/
         SYSDATE,
         SYSDATE,
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
             VALIDATE_K,
             VALIDATE_L,
             VALIDATE_M,
             VALIDATE_N;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --入库单审批html展现
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
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConWarehouse/edit/' ||
                                                V_WAREHOUE_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --出库单审批html展现
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG      VARCHAR2(20000);
    V_ODO_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ODO_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConOdo/edit/' ||
                                                V_ODO_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --交货计划维护审批html展现
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
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConGoodsPlan/edit/' ||
                                                V_GOODS_PLAN_ID,
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --验证日期函数 xgh
  FUNCTION FN_ISDATE(V_DATESTR VARCHAR2 --日期入参
                     ) RETURN NUMBER -- 返回1为正确，0为错误。
   AS
    /*------------------------------------------------------------------------
    公用函数：日期检查函数
    调用范例: select FN_ISDATE('20140501') from dual;
    ------------------------------------------------------------------------*/
    I_YEAR  NUMBER; --年
    I_MONTH NUMBER; --月
    I_DAY   NUMBER; --日
    D_TJRQ  DATE; --日期类型的日期
  BEGIN
  
    IF V_DATESTR IS NULL THEN
      RETURN 0;
    END IF;
  
    IF LENGTH(TRIM(V_DATESTR)) <> 8 THEN
      RETURN 0;
    END IF;
  
    -- 判断日期由数字组成
    IF REGEXP_SUBSTR(TRIM(V_DATESTR), '[[:digit:]]+') IS NULL THEN
      RETURN 0;
    END IF;
  
    -- 截取出年份
    I_YEAR := TO_NUMBER(SUBSTR(RTRIM(V_DATESTR), 1, 4));
  
    -- 截取出月份
    I_MONTH := TO_NUMBER(SUBSTR(RTRIM(V_DATESTR), 5, 2));
  
    -- 截取出日期
    I_DAY := TO_NUMBER(SUBSTR(RTRIM(V_DATESTR), 7, 2));
  
    -- 对月份进行判断，必须在1月到12月范围之内
    IF I_MONTH NOT BETWEEN 1 AND 12 THEN
      BEGIN
        RETURN 0;
      END;
    END IF;
  
    -- 对日期的判断，1，3，5，7，8，10，12月最大日为31，4，6，9，11月最大日为30，2月若为闰年则为29，其它年则为28.
    IF I_DAY BETWEEN 1 AND 31 THEN
      BEGIN
        IF I_DAY = 31 AND I_MONTH NOT IN (1, 3, 5, 7, 8, 10, 12) THEN
          BEGIN
            RETURN 0;
          END;
        END IF;
        IF I_MONTH = 2 THEN
          BEGIN
            -- Rules 1：普通年能被4整除且不能被100整除的为闰年。
            -- Rules 2：世纪年能被400整除的是闰年。
            -- Rules 3：对于数值很大的年份,这年如果能整除3200,并且能整除172800则是闰年。如172800年是闰年，86400年不是闰年。
            IF ((MOD(I_YEAR, 4) = 0 AND MOD(I_YEAR, 100) <> 0) OR
               MOD(I_YEAR, 400) = 0 OR
               (MOD(I_YEAR, 3200) = 0 AND MOD(I_YEAR, 172800) = 0)) THEN
              BEGIN
                --若为闰年，则2月份最大日为29
                IF I_DAY > 29 THEN
                  BEGIN
                    RETURN 0;
                  END;
                END IF;
              END;
            ELSE
              BEGIN
                --若不为闰年，则2月份最大日为28
                IF I_DAY > 28 THEN
                  BEGIN
                    RETURN 0;
                  END;
                END IF;
              END;
            END IF;
          END;
        END IF;
        RETURN 1;
      END;
    ELSE
      RETURN 0;
    END IF;
  END;

  --将客户或供应商数据字典项的内容加入到评价详情表中
  PROCEDURE INSERT_EVALUATE_TYPE(EVALUATEID NUMBER, FLAG NUMBER) AS
    CURSOR VONDER_CURSOR IS
      SELECT D.DICT_NAME
        FROM SPM_DICT D
        LEFT JOIN SPM_DICT_TYPE DT
          ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
       WHERE DT.TYPE_CODE = 'VENDOR_EVALUATE_TYPE';
    CURSOR CUST_CURSOR IS
      SELECT D.DICT_NAME
        FROM SPM_DICT D
        LEFT JOIN SPM_DICT_TYPE DT
          ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
       WHERE DT.TYPE_CODE = 'CUST_EVALUATE_TYPE';
  BEGIN
    IF FLAG = 2 THEN
      FOR C IN VONDER_CURSOR LOOP
        INSERT INTO SPM_CON_HT_EVALUATE_DETAIL
          (EVALUATE_DETAIL_ID, EVALUATE_ID, EVALUATE_CONTENT_TYPE)
        VALUES
          (SPM_CON_EVALUATE_DETAIL_SEQ.NEXTVAL, EVALUATEID, C.DICT_NAME);
      END LOOP;
    ELSE
      FOR D IN CUST_CURSOR LOOP
        INSERT INTO SPM_CON_HT_EVALUATE_DETAIL
          (EVALUATE_DETAIL_ID, EVALUATE_ID, EVALUATE_CONTENT_TYPE)
        VALUES
          (SPM_CON_EVALUATE_DETAIL_SEQ.NEXTVAL, EVALUATEID, D.DICT_NAME);
      END LOOP;
    END IF;
  END;
  --将客户或供应商数据字典项的内容加入到评价详情表中上一个函数改进版
  PROCEDURE INSERT_EVALUATE_TYPE_1(EVALUATEIDS VARCHAR2) AS
    FLAG NUMBER;
    CURSOR VONDER_CURSOR IS
      SELECT D.DICT_NAME
        FROM SPM_DICT D
        LEFT JOIN SPM_DICT_TYPE DT
          ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
       WHERE DT.TYPE_CODE = 'VENDOR_EVALUATE_TYPE';
    CURSOR CUST_CURSOR IS
      SELECT D.DICT_NAME
        FROM SPM_DICT D
        LEFT JOIN SPM_DICT_TYPE DT
          ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
       WHERE DT.TYPE_CODE = 'CUST_EVALUATE_TYPE';
    IDS SPM_TYPE_TBL;
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(EVALUATEIDS) INTO IDS FROM DUAL;
    FOR I IN 1 .. IDS.COUNT LOOP
    
      SELECT E.MERCHANTS_FLAG
        INTO FLAG
        FROM SPM_CON_HT_EVALUATE E
       WHERE E.EVALUATE_ID = IDS(I);
      IF FLAG = 1 THEN
        FOR C IN CUST_CURSOR LOOP
          INSERT INTO SPM_CON_HT_EVALUATE_DETAIL
            (EVALUATE_DETAIL_ID, EVALUATE_ID, EVALUATE_CONTENT_TYPE)
          VALUES
            (SPM_CON_EVALUATE_DETAIL_SEQ.NEXTVAL, IDS(I), C.DICT_NAME);
        END LOOP;
      ELSE
        FOR D IN VONDER_CURSOR LOOP
          INSERT INTO SPM_CON_HT_EVALUATE_DETAIL
            (EVALUATE_DETAIL_ID, EVALUATE_ID, EVALUATE_CONTENT_TYPE)
          VALUES
            (SPM_CON_EVALUATE_DETAIL_SEQ.NEXTVAL, IDS(I), D.DICT_NAME);
        END LOOP;
      END IF;
    END LOOP;
  END;

  --入库单导入import
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
  
    V_INFO_ID   NUMBER;
    V_TARGET_ID NUMBER;
  
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
      SELECT SPM_CON_WAREHOUSE_DL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      --入库单contargetid
      SELECT SPM_CON_TARGET_CD_SEQ.NEXTVAL INTO V_TARGET_ID FROM DUAL;
    
      INSERT INTO SPM_CON_WAREHOUSE_DL
        (WAREHOUSE_DL_ID, --主键
         MATERIAL_FLOW_NUMBER, --流水号
         MATERIAL_CODE, --大唐物资编号
         DELIVERY_CARGO, --货物名称
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
         ATTRIBUTE1, --入库单编号
         DEPT_ID, --部门ID
         WAREHOUSE_ID, --外键,
         ORG_ID,
         CON_TARGET_ID,
         STORE_ROOM, --仓库
         GOODS_POSITION --货位
         
         )
      VALUES
        (V_INFO_ID,
         VALIDATE_A,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_D, --仓库
         VALIDATE_E, --货位
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
         (SELECT T.DEPT_ID
            FROM SPM_CON_WAREHOUSE T
           WHERE T.WAREHOUSE_ID = F_TABLEID),
         F_TABLEID,
         SPM_SSO_PKG.GETORGID,
         V_TARGET_ID,
         (SELECT T.SECONDARY_INVENTORY_NAME
            FROM MTL_SECONDARY_INVENTORIES T
           WHERE T.DESCRIPTION = 'validate_d'
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID),
         (SELECT T.INVENTORY_LOCATION_ID
            FROM MTL_ITEM_LOCATIONS T
           WHERE T.SEGMENT1 || '.' || T.SEGMENT2 || '.' || T.SEGMENT3 || '.' ||
                 T.SEGMENT4 || '.' || T.SEGMENT5 || '.' || T.SEGMENT6 =
                 VALIDATE_E
             AND T.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID)
         
         );
    
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

  --入库单验证validate
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
    MSG_P VARCHAR2(4000);
  
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
      IF VALIDATE_A <> '物资流水号' OR VALIDATE_B <> '大唐物资编号' OR
         VALIDATE_C <> '货物名称' OR VALIDATE_D <> '仓库' OR VALIDATE_E <> '货位' OR
         VALIDATE_F <> '管号' OR VALIDATE_G <> '炉号' OR
         VALIDATE_H <> '发票数量(主)' OR VALIDATE_I <> '本次入库数量' OR
         VALIDATE_J <> '单位' OR VALIDATE_K <> '发票数量(副)' OR
         VALIDATE_L <> '副单位' OR VALIDATE_M <> '外币单价(FOB)' OR
         VALIDATE_N <> '外币单价(CIF)(主)' OR VALIDATE_O <> '外币单价(CIF)(副)' OR
         VALIDATE_P <> '币种' OR VALIDATE_Q <> '单价(不含增值税)' OR
         VALIDATE_R <> '金额(不含增值税)' OR VALIDATE_S <> '税率(%)' OR
         VALIDATE_T <> '进项税' OR VALIDATE_U <> '含税单价' OR
         VALIDATE_V <> '价税合计' OR VALIDATE_W <> '生产厂家' OR VALIDATE_X <> '备注' OR
         VALIDATE_Y <> '入库单编号' THEN
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
      
        --验证单位是否在ebs存在
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
      
        --验证单价不能为空
        IF VALIDATE_Q IS NULL THEN
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
        MSG_A := MSG_A || '行 ; 单位在ebs不存在，请检查 ';
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
    
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      
      END IF;
    END IF;
  END;

  --根据评价得分情况判断等级
  FUNCTION GET_EVALUATE_SCORE(MERCHANTID IN NUMBER, CONID IN NUMBER)
    RETURN VARCHAR2 IS
    TYPE TYPE_EVALUATE IS TABLE OF SPM_CON_HT_EVALUATE%ROWTYPE INDEX BY BINARY_INTEGER;
    EVALARR TYPE_EVALUATE;
    RV      NUMBER := 0; --日常分
    LV      NUMBER := 0; --最近一次的评分
    ZV      NUMBER := 0; --综合得分 = 0.75*日常平均得分+0.25*最近一次得分
  BEGIN
    --倒序获得评价分数
    SELECT * BULK COLLECT
      INTO EVALARR
      FROM SPM_CON_HT_EVALUATE S
     WHERE S.MERCHANTS_ID = MERCHANTID
       AND S.CONTRACT_ID = CONID
       AND S.EVALUATE_STATUS = 'B' --未生效的评价不参与综合计算
     ORDER BY S.CREATION_DATE DESC;
    --
    FOR I IN 1 .. EVALARR.COUNT LOOP
      IF I = 1 THEN
        LV := EVALARR(I).EVALUATE_SCORE;
      END IF;
      RV := RV + EVALARR(I).EVALUATE_SCORE;
    END LOOP;
    ZV := 0.75 * RV + 0.25 * LV;
    RETURN ZV;
  END GET_EVALUATE_SCORE;

  --设置合同综合评分
  PROCEDURE SET_CON_EVALUATE_SCORE(CONID NUMBER) IS
    TYPE TYPE_MERCHANTS IS TABLE OF NUMBER;
    MIDS TYPE_MERCHANTS;
    ZV   NUMBER := 0; --总分
    ES   NUMBER := 0; --综合得分
    ER   VARCHAR2(32) := '--';
  BEGIN
    SELECT S.MERCHANTS_ID BULK COLLECT
      INTO MIDS
      FROM SPM_CON_HT_MERCHANTS S
     WHERE S.CONTRACT_ID = CONID;
    FOR I IN 1 .. MIDS.COUNT LOOP
      ZV := ZV + GET_EVALUATE_SCORE(MIDS(I), CONID);
    END LOOP;
    ES := ROUND(ZV / MIDS.COUNT, 1);
    IF ES < 6 THEN
      ER := '差';
    ELSIF ES >= 6 AND ES < 7 THEN
      ER := '及格';
    ELSIF ES >= 7 AND ES < 8 THEN
      ER := '中';
    ELSIF ES >= 8 AND ES < 9 THEN
      ER := '良';
    ELSIF ES >= 9 THEN
      ER := '优';
    END IF;
    UPDATE SPM_CON_HT_INFO S
       SET S.EVALUATE_SCORE = ES, S.EVALUATE_RESULT = ER
     WHERE S.CONTRACT_ID = CONID;
  END;

  --选择审核人员回调方法
  PROCEDURE SALES_ORDER_PERSON_PR(P_KEY                  VARCHAR2,
                                  POTYPE_CODE            VARCHAR2,
                                  VGROUP_ID              NUMBER,
                                  VPOSITION_STRUCTURE_ID NUMBER,
                                  VPOSITOIN_ID           VARCHAR2) IS
    STATUSFLAG VARCHAR2(10);
    TABLENAME  VARCHAR2(50);
    KEYNAME    VARCHAR2(50);
    VSQL       VARCHAR2(2000);
    CSQL       VARCHAR2(2000);
    Q_ID       NUMBER;
    JOB_ID     NUMBER;
    COU        NUMBER;
  BEGIN
  
    SELECT WF_TAB_NAME, WF_TAB_KEYNAME
      INTO TABLENAME, KEYNAME
      FROM SPM_WF_REGINFO
     WHERE WF_CODE = POTYPE_CODE;
    -- insert into spm_debug values('888#',tableName,sysdate);
    -- insert into spm_debug values('999#',keyName,sysdate);
    VSQL := 'SELECT ' || KEYNAME || ', nvl(status,''A''),job_id  FROM ' ||
            TABLENAME || ' WHERE item_key=' || '''' || P_KEY || '''';
    -- insert into spm_debug values('000#',vSql,sysdate);
    EXECUTE IMMEDIATE VSQL
      INTO Q_ID, STATUSFLAG, JOB_ID;
  
    CSQL := 'select count(1) from ' || TABLENAME || ' where job_id=' ||
            JOB_ID || ' and wf_code=' || '''' || POTYPE_CODE || '''' ||
            ' and item_key=' || '''' || P_KEY || '''';
    EXECUTE IMMEDIATE CSQL
      INTO COU;
    -- select t.sales_order_id,nvl(t.status,'A') into q_id,statusFlag from spm_con_sales_order t where t.item_key = p_key;
    --insert into spm_debug values('1#1',statusFlag,sysdate);
    --检查是否为第一环节
  
    IF (STATUSFLAG = 'A' OR STATUSFLAG = 'C') AND COU = 1 THEN
      /**
      动态指定审批人员时 先删掉特定配置的审批人员
      可指定在流程某些审批节点下需要采用动态选人
      动态选审批人员时调用此代码
      **/
      DELETE CCM_WF_USER_GROUP CG WHERE CG.ITEMKEY = P_KEY;
      --写入人员
      INSERT INTO CCM_WF_USER_GROUP
        (GROUP_ID,
         POSITION_STRUCTURE_ID,
         ITEMKEY,
         USER_NAME,
         LAST_UPDATE_DATE,
         LAST_UPDATED_BY,
         LAST_UPDATE_LOGIN,
         CREATION_DATE,
         CREATED_BY)
        SELECT VGROUP_ID,
               VPOSITION_STRUCTURE_ID,
               P_KEY,
               SPM_EAM_COMMON_PKG.GET_USERNAME_BY_PERSONID(T.ASS_ID),
               SYSDATE,
               0,
               0,
               SYSDATE,
               0
          FROM SPM_WF_RECEIVER T
         WHERE T.POSITION_ID = VPOSITOIN_ID
           AND T.RECEIVER_ID = JOB_ID
           AND T.OTYPE_CODE = POTYPE_CODE
           AND T.ITEM_KEY IS NULL;
    
    END IF;
    COMMIT;
  END;
  /*    --合同新建流程必填验证(通知回调)
  PROCEDURE SPM_CON_HT_TRANS_VALID(p_Key        In Varchar2,
                                     p_Otype_Code In VARCHAR2,
                                     p_notifid In VARCHAR2,
                                     p_oper_result In VARCHAR2)
  AS
  PERSONID NUMBER;
  BEGIN
     SELECT S.RECEIPT_PERSON_ID INTO PERSONID  FROM SPM_CON_HT_TRANS S WHERE S.ITEM_KEY=p_Key;
     IF p_oper_result = 'Y' THEN
       IF PERSONID IS NULL THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '合同交接需要您需要您签名');
          APP_EXCEPTION.RAISE_EXCEPTION;
       END IF;
     END IF;
  END;*/
  --合同新建流程必填验证(通知回调)
  PROCEDURE SPM_CON_HT_WF_TRANS_VALID(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
    PERSONID NUMBER;
  BEGIN
    SELECT S.RECEIPT_PERSON_ID
      INTO PERSONID
      FROM SPM_CON_HT_TRANS S
     WHERE S.ITEM_KEY = P_KEY;
    IF P_OPER_RESULT = 'Y' THEN
      IF PERSONID IS NULL THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '合同交接需要您需要您签名');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_TRANS_VALID;
  --收款单同步EBS
  PROCEDURE SPM_CON_AR_RECEIPT(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXIST          NUMBER;
    V_BANK_NAME       VARCHAR2(40);
    RECEIPT_CODE      VARCHAR2(40);
    PROJECT_CODE_V    VARCHAR2(40); --项目段
    CONTRACT_CODE_V   VARCHAR2(40); --合同段
    COME_GO_V         VARCHAR2(40); --往来段
    DEPT_V            VARCHAR2(40); --部门段
    V_RECIEPT_CODE    VARCHAR2(200);
    V_TRANSACTION_NUM VARCHAR2(200);
    P_FLAG            VARCHAR2(10);
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    L_IFACE_REC CUX.CUX_AR_RECEIPTS%ROWTYPE;
    CURSOR CUR1(C_RECEIPT_ID NUMBER) IS
      SELECT M.ACCOUNT_NAME,
             M.RECEIPT_NAME,
             M.RECEIPT_METHOD,
             M.DEPOSIT_BANK,
             M.PAYMENT_ACCOUNT,
             M.RECEIPT_ACCOUNT,
             M.COLLECTION_DATE,
             M.ORG_ID
        FROM SPM_CON_MONEY_REG M, SPM_CON_RECEIPT R
       WHERE M.MONEY_REG_ID = R.MONEY_REG_ID
         AND R.RECEIPT_ID = C_RECEIPT_ID;
  
    REC_1 CUR1%ROWTYPE;
    CURSOR CUR2(C_RECEIPT_ID NUMBER) IS
      SELECT R.*, H.CONTRACT_CODE
        FROM SPM_CON_RECEIPT R
        LEFT JOIN SPM_CON_HT_INFO H
          ON R.CONTRACT_ID = H.CONTRACT_ID
       WHERE R.RECEIPT_ID = C_RECEIPT_ID;
  BEGIN
  
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --如果非启用财务收款的组织，直接返回，并将原财务收款单删除
    P_FLAG := SPM_CON_INVOICE_PKG.IS_ENABLE_FINANCIAL_RECEIPT(SPM_SSO_PKG.getOrgId);
  
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
        --获取对应银行
        /*select distinct(bb.bank_branch_name)
         INTO V_BANK_NAME
         from ce.ce_bank_accounts   t,
              ce_bank_acct_uses_all T2,
              ce_bank_branches_v    bb
        WHERE T2.bank_account_id = T.bank_account_id
          AND t.bank_branch_id = bb.branch_party_id
          AND T2.ORG_ID = 81
          AND T.BANK_ACCOUNT_NUM = REC_1.PAYMENT_ACCOUNT;*/
        SELECT FLEX_VALUE
          INTO COME_GO_V
          FROM FND_FLEX_VALUES_VL
         WHERE FLEX_VALUE_SET_ID =
               (SELECT F.FLEX_VALUE_SET_ID
                  FROM FND_FLEX_VALUE_SETS F
                 WHERE F.FLEX_VALUE_SET_NAME = 'DT 往来')
           AND DESCRIPTION = TRIM(REC_1.ACCOUNT_NAME);
      EXCEPTION
        WHEN OTHERS THEN
          COME_GO_V := '00';
      END;
    
      BEGIN
        L_IFACE_REC.CUSTOMER_NAME    := TRIM(REC_1.ACCOUNT_NAME);
        L_IFACE_REC.BANK_BRANCH_NAME := REC_1.DEPOSIT_BANK;
        L_IFACE_REC.BANK_ACCOUNT_NUM := REC_1.RECEIPT_ACCOUNT;
        L_IFACE_REC.RECEIPT_METHODS  := REC_1.RECEIPT_METHOD;
        L_IFACE_REC.ORG_NAME         := SPM_EAM_COMMON_PKG.GETDEPORGNAME(REC_1.ORG_ID);
      
        L_IFACE_REC.ATTRIBUTE9 := COME_GO_V;
        DBMS_OUTPUT.PUT_LINE(TRIM(REC_1.ACCOUNT_NAME));
      
        FOR REC_2 IN CUR2(V_ID) LOOP
           --p_plag => y 启用 N 未启用
          IF (P_FLAG <> 'Y' AND REC_2.DATA_TYPE = 'CW') THEN
            V_RETURN_MESSAGE := '当前组织未启用财务默认收款，不允许导入财务签收数据';
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            RETURN;
          
          ELSIF P_FLAG <> 'N' AND REC_2.DATA_TYPE = 'YW' THEN
          
            V_RETURN_MESSAGE := '当前组织已启用财务默认收款，不允许导入业务签收数据！';
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            RETURN;
          
          END IF;
        
          -- L_IFACE_REC.RECEIPT_METHODS         := REC_2.Collection_Method;
          --L_IFACE_REC.DEPOSIT_DATE            := REC_2.COLLECTION_DATE;
          --L_IFACE_REC.ORG_NAME                := REC_2.;--现金流
          PROJECT_CODE_V := SPM_CON_INVOICE_INF_PKG.GET_EBS_PROJECT_CODE(V_PROJECT_ID => REC_2.PROJECT_ID);
          RECEIPT_CODE   := REC_2.RECEIPT_CODE;
          --组织名称
          L_IFACE_REC.RECEIPT_NUMBER         := REC_2.RECEIPT_CODE; --收款编号，未安装EBS规则
          L_IFACE_REC.CURRENCY_CODE          := UPPER('CNY'); --币种取
          L_IFACE_REC.AMOUNT                 := REC_2.MONEY_AMOUNT; --以人民币传入
          L_IFACE_REC.TYPE                   := UPPER('STANDARD'); --合同侧只有标准类型，没有杂项
          L_IFACE_REC.RECEIPT_DATE           := REC_1.COLLECTION_DATE;
          L_IFACE_REC.GL_DATE                := REC_2.GL_DATE;
          L_IFACE_REC.MATURITY_DATE          := REC_2.GL_DATE; --取总账日期
          L_IFACE_REC.FACTOR_DISCOUNT_AMOUNT := 0; --手续费默认取0
          /*                  L_IFACE_REC.EXCHANGE_RATE_TYPE      := 'User';
          L_IFACE_REC.EXCHANGE_RATE           := 1;
          L_IFACE_REC.EXCHANGE_DATE           := REC_2.CREATION_DATE;*/
          L_IFACE_REC.DEPOSIT_DATE      := REC_2.CREATION_DATE;
          L_IFACE_REC.CREATION_DATE     := SYSDATE;
          
          IF (REC_2.CREATED_BY IS NULL OR REC_2.CREATED_BY = 0) THEN
            L_IFACE_REC.CREATED_BY := V_USER_ID;
            UPDATE SPM_CON_RECEIPT R
               SET R.CREATED_BY = V_USER_ID
             WHERE R.RECEIPT_ID = V_ID;
          ELSE
            L_IFACE_REC.CREATED_BY := REC_2.CREATED_BY;
          END IF;
          
          L_IFACE_REC.LAST_UPDATE_DATE  := REC_2.LAST_UPDATE_DATE;
          L_IFACE_REC.LAST_UPDATED_BY   := REC_2.LAST_UPDATED_BY;
          L_IFACE_REC.LAST_UPDATE_LOGIN := REC_2.LAST_UPDATE_LOGIN;
          L_IFACE_REC.PROCESS_STATUS    := UPPER('PENDING');
          L_IFACE_REC.ATTRIBUTE3        := REC_2.RECEIPT_DEPT;
          L_IFACE_REC.ATTRIBUTE5        := PROJECT_CODE_V;
          L_IFACE_REC.ATTRIBUTE7        := REC_2.EBS_PRODUCE;
          L_IFACE_REC.ATTRIBUTE6        := REC_2.CONTRACT_CODE;
          L_IFACE_REC.DOCUMENT_NUM := REC_2.RECEIPT_CODE;
          
          IF REC_1.RECEIPT_METHOD <> '中转收款' and REC_1.RECEIPT_METHOD <> '票据收款' THEN
          L_IFACE_REC.ATTRIBUTE1        := REC_2.MATCH_DEPT;
          L_IFACE_REC.ATTRIBUTE2        := REC_2.MATCH_PROJECT;
          L_IFACE_REC.ATTRIBUTE4  := REC_2.CASH_FLOW;
          END IF;    
          
          L_IFACE_REC.ATTRIBUTE13 := SPM_CON_INVOICE_PKG.GET_TRANSACTION_NUMBER(REC_2.TRANSACTION_NUM);
          L_IFACE_REC.COMMENTS    := REC_2.REMARK;
        
          INSERT INTO CUX.CUX_AR_RECEIPTS VALUES L_IFACE_REC;
        
          V_RECIEPT_CODE    := REC_2.RECEIPT_CODE;
          V_TRANSACTION_NUM := SPM_CON_INVOICE_PKG.GET_TRANSACTION_NUMBER(REC_2.TRANSACTION_NUM);
        END LOOP;
      END;
      BEGIN
        CUX_AR_RECEIPT_PKG.IMPORT_AR_RECEIPT(ERRBUF           => V_RETURN_MESSAGE,
                                             RETCODE          => V_RETURN_CODE,
                                             P_RECEIPT_NUMBER => RECEIPT_CODE);
      END;
      UPDATE AR_CASH_RECEIPTS_ALL R
         SET R.ATTRIBUTE13 = V_TRANSACTION_NUM
       WHERE R.RECEIPT_NUMBER = V_RECIEPT_CODE;
    ELSE
      CLOSE CUR1;
    END IF;
  END SPM_CON_AR_RECEIPT;
  --发票核销EBS
  --发票核销EBS
  PROCEDURE SPM_CON_AR_INVOICE(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXIST       NUMBER;
    V_BANK_NAME    VARCHAR2(40);
    L_IFACE_INV    CUX.CUX_AR_RECEIPT_APPLIES%ROWTYPE;
    INVOICE_ID     NUMBER;
    RECEIPT_NUMBER VARCHAR2(40);
  
    CURSOR CUR1(C_INVOICE_ID NUMBER) IS
      SELECT C.RECEIPT_CODE,
             (SELECT E.INVOICE_CODE
                FROM SPM_CON_OUTPUT_INVOICE E
               WHERE E.OUTPUT_INVOICE_ID =
                     (SELECT O.OUTPUT_INVOICE_ID
                        FROM SPM_CON_RECEIPT_INVOICE O
                       WHERE O.RECEIPT_INVOICE_ID = C_INVOICE_ID)) INVOICE_CODE,
             I.CREATION_DATE,
             I.MONEY_AMOUNT,
             I.CREATED_BY,
             I.LAST_UPDATED_BY,
             I.GL_DATE,
             I.LAST_UPDATE_DATE
        FROM SPM_CON_RECEIPT C, SPM_CON_RECEIPT_INVOICE I
       WHERE C.RECEIPT_ID = I.RECEIPT_ID
         AND I.RECEIPT_INVOICE_ID = C_INVOICE_ID;
  
    REC_1 CUR1%ROWTYPE;
    CURSOR CUR2(C_INVOICE_ID NUMBER) IS
      SELECT R.*, (SPM_EAM_COMMON_PKG.GETDEPORGNAME(R.ORG_ID)) AS ORG_NAME
        FROM SPM_CON_RECEIPT_INVOICE R
       WHERE R.RECEIPT_INVOICE_ID = C_INVOICE_ID;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    SELECT E.OUTPUT_INVOICE_ID
      INTO INVOICE_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.RECEIPT_INVOICE_ID = V_ID;
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
        L_IFACE_INV.RECEIPT_NUMBER   := REC_1.RECEIPT_CODE;
        L_IFACE_INV.TRX_NUMBER       := REC_1.INVOICE_CODE;
        L_IFACE_INV.APPLY_DATE       := REC_1.CREATION_DATE;
        L_IFACE_INV.GL_DATE          := REC_1.GL_DATE;
        L_IFACE_INV.AMOUNT_APPLIED   := REC_1.MONEY_AMOUNT;
        L_IFACE_INV.CREATION_DATE    := REC_1.CREATION_DATE;
        L_IFACE_INV.DOCUMENT_NUM     := REC_1.INVOICE_CODE;
        L_IFACE_INV.LAST_UPDATE_DATE := REC_1.LAST_UPDATE_DATE;
        L_IFACE_INV.LAST_UPDATED_BY  := REC_1.LAST_UPDATED_BY;
        L_IFACE_INV.PROCESS_STATUS   := UPPER('PENDING');
        L_IFACE_INV.CREATED_BY       := REC_1.CREATED_BY;
        RECEIPT_NUMBER               := REC_1.RECEIPT_CODE;
        FOR REC_2 IN CUR2(V_ID) LOOP
        
          -- L_IFACE_REC.RECEIPT_METHODS         := REC_2.Collection_Method;
          --L_IFACE_REC.DEPOSIT_DATE            := REC_2.COLLECTION_DATE;
          --L_IFACE_REC.ORG_NAME                := REC_2.;--现金流
          L_IFACE_INV.ORG_NAME := REC_2.ORG_NAME; --组织名称
        END LOOP;
        INSERT INTO CUX.CUX_AR_RECEIPT_APPLIES VALUES L_IFACE_INV;
        COMMIT;
      END;
      BEGIN
        CUX_AR_RECEIPT_APPLY_PKG.AR_RECEIPT_APPLY(ERRBUF           => V_RETURN_MESSAGE,
                                                  RETCODE          => V_RETURN_CODE,
                                                  P_RECEIPT_NUMBER => RECEIPT_NUMBER);
      END;
    ELSE
      CLOSE CUR1;
    END IF;
  END SPM_CON_AR_INVOICE;

  --同步EBS接口表中收款核销应收发票记录 by mcq
  PROCEDURE SYNC_RECEIPT_INVOICE(V_ID             IN NUMBER,
                                 V_RETURN_CODE    OUT VARCHAR2,
                                 V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXIST            NUMBER;
    P_RECEIPT_CODE      VARCHAR2(40);
    P_ORG_ID            VARCHAR2(40);
    P_NO_APPLIED_AMOUNT NUMBER; --剩余金额
  
  BEGIN
  
    SELECT R.RECEIPT_CODE, R.ORG_ID
      INTO P_RECEIPT_CODE, P_ORG_ID
      FROM SPM_CON_RECEIPT R
     WHERE R.RECEIPT_ID = V_ID;
  
    --检验余额
    P_NO_APPLIED_AMOUNT := GET_EBS_RECEIPT_APPLIED_AMOUNT(P_RECEIPT_CODE,
                                                          P_ORG_ID);
    IF P_NO_APPLIED_AMOUNT <= 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前收款单金额已经被全部核销完！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    BEGIN
      CUX_AR_RECEIPT_APPLY_PKG.ar_receipt_apply_spm(ERRBUF           => V_RETURN_MESSAGE,
                                                    RETCODE          => V_RETURN_CODE,
                                                    P_RECEIPT_NUMBER => P_RECEIPT_CODE);
    
      --执行成功后，删除中间表中的数据                                          
      IF V_RETURN_CODE = 'S' THEN
        DELETE FROM CUX_SPM_AR_RECEIPT_APPLIES A
         WHERE A.RECEIPT_NUMBER = P_RECEIPT_CODE;
      END IF;
    
    END;
  
  END SYNC_RECEIPT_INVOICE;

  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_RECE_ACCOUNIT(V_ID          IN NUMBER,
                                     V_USER_ID     IN NUMBER,
                                     V_RESP_ID     IN NUMBER,
                                     V_RESP_APP_ID IN NUMBER,
                                     A_RETURN_CODE OUT VARCHAR2,
                                     A_RETURN_MSG  OUT VARCHAR2) IS
    V_RECEIPT_ID NUMBER;
    V_MODE       VARCHAR2(40) := 'P';
    V_ORG_ID     NUMBER;
  BEGIN
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --查询对应发票ID
    SELECT A.CASH_RECEIPT_ID, I.ORG_ID
      INTO V_RECEIPT_ID, V_ORG_ID
      FROM AR_CASH_RECEIPTS_ALL A, SPM_CON_RECEIPT I
     WHERE A.RECEIPT_NUMBER = I.RECEIPT_CODE
       AND I.RECEIPT_ID = V_ID;
    MO_GLOBAL.SET_POLICY_CONTEXT('S', V_ORG_ID);
    /*--创建会计科目
                    p_accounting_mode:= 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*/
    CUX_AR_RECEIPT_PKG.P_AR_CASH_ACCOUNT(P_CASH_RECEIPT_ID => V_RECEIPT_ID,
                                         P_ACCOUNTING_MODE => V_MODE,
                                         P_ORG_ID          => V_ORG_ID,
                                         X_STATUS          => A_RETURN_CODE,
                                         X_ERROR_MESSAGE   => A_RETURN_MSG);
  END SPM_CON_AR_RECE_ACCOUNIT;
  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_INVOICE_ACCOUNIT(V_ID          IN NUMBER,
                                        V_USER_ID     IN NUMBER,
                                        V_RESP_ID     IN NUMBER,
                                        V_RESP_APP_ID IN NUMBER,
                                        A_RETURN_CODE OUT VARCHAR2,
                                        A_RETURN_MSG  OUT VARCHAR2) IS
  
    V_RECEIPT_ID                NUMBER;
    EBS_RECEIPT_ID              NUMBER;
    V_INVOICE_ID                NUMBER;
    EBS_INVOICE_ID              NUMBER;
    L_RECEIVABLE_APPLICATION_ID NUMBER;
    V_MODE                      VARCHAR2(40) := 'P';
    V_ORG_ID                    NUMBER;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    SELECT E.ORG_ID
      INTO V_ORG_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.RECEIPT_INVOICE_ID = V_ID;
    --查询spm侧收款ID，销项发票ID
    SELECT E.RECEIPT_ID, E.OUTPUT_INVOICE_ID
      INTO V_RECEIPT_ID, V_INVOICE_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.RECEIPT_INVOICE_ID = V_ID;
    --查询EBS侧收款ID
    SELECT L.CASH_RECEIPT_ID
      INTO EBS_RECEIPT_ID
      FROM AR.AR_CASH_RECEIPTS_ALL L, SPM_CON_RECEIPT T
     WHERE T.RECEIPT_ID = V_RECEIPT_ID
       AND T.RECEIPT_CODE = L.RECEIPT_NUMBER;
    --查询EBS侧发票ID
    SELECT T.CUSTOMER_TRX_ID
      INTO EBS_INVOICE_ID
      FROM AR.RA_CUSTOMER_TRX_ALL T, SPM_CON_OUTPUT_INVOICE E
     WHERE T.TRX_NUMBER = E.INVOICE_CODE
       AND E.OUTPUT_INVOICE_ID = V_INVOICE_ID;
    --查询对应发票ID
    SELECT RECEIVABLE_APPLICATION_ID
      INTO L_RECEIVABLE_APPLICATION_ID
      FROM AR_RECEIVABLE_APPLICATIONS_ALL
     WHERE CASH_RECEIPT_ID = EBS_RECEIPT_ID
       AND APPLIED_CUSTOMER_TRX_ID = EBS_INVOICE_ID
       AND STATUS = 'APP'
       AND DISPLAY = 'Y';
    MO_GLOBAL.SET_POLICY_CONTEXT('S', V_ORG_ID);
    /*--创建会计科目
                    p_accounting_mode:= 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*/
    CUX_AR_RECEIPT_PKG.P_AR_APPLY_ACCOUNT(P_RECEIVABLE_APPLICATION_ID => L_RECEIVABLE_APPLICATION_ID,
                                          P_ACCOUNTING_MODE           => V_MODE,
                                          P_ORG_ID                    => V_ORG_ID,
                                          X_STATUS                    => A_RETURN_CODE,
                                          X_ERROR_MESSAGE             => A_RETURN_MSG);
  END SPM_CON_AR_INVOICE_ACCOUNIT;

  --获取到款同步状态
  FUNCTION GET_STATUS(MONEYREG_ID NUMBER) RETURN VARCHAR2 IS
    STATUS           VARCHAR2(40);
    NUMBER1          NUMBER;
    number2          number;
    number3          number;
    V_REG_TYPE       VARCHAR2(40);
    V_REMARK         VARCHAR2(4000);
    V_RESIDUAL_MONEY NUMBER;
  
    --获取收款单主键
    CURSOR RECEIPTIDS IS
      SELECT RECEIPT_ID, T.EBS_STATUS
        FROM SPM_CON_RECEIPT T
       WHERE T.MONEY_REG_ID = MONEYREG_ID
         AND T.EBS_STATUS <> 'R';
    --获取核销记录的状态
    /* CURSOR EBS_STATUS(RECEIPTID NUMBER) IS
    SELECT E.EBS_STATUS, E.MONEY_AMOUNT
      FROM SPM_CON_RECEIPT_INVOICE E, SPM_CON_RECEIPT I
     WHERE E.RECEIPT_ID = I.RECEIPT_ID
       AND E.RECEIPT_ID = RECEIPTID
       AND I.RECEIPT_TYPE <> 'A'
       AND E.EBS_STATUS <> 'R';*/
    --获取应付状态
    /* CURSOR AP_EBS_STATUS IS
    SELECT I.EBS_STATUS
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.MONEY_REG_ID = MONEYREG_ID
       AND I.EBS_STATUS <> 'R';*/
  BEGIN
    STATUS := '已完成';
  
    SELECT R.REMARK, R.REG_TYPE, R.RESIDUAL_AMOUNT
      INTO V_REMARK, V_REG_TYPE, V_RESIDUAL_MONEY
      FROM SPM_CON_MONEY_REG R
     WHERE 1 = 1
       AND R.MONEY_REG_ID = MONEYREG_ID;
    --判断是否为历史数据
    IF V_REMARK = '历史数据' THEN
      RETURN STATUS;
    END IF;
    --判断是否尚有余额
    IF V_RESIDUAL_MONEY <> 0 THEN
      STATUS := '未完成';
      RETURN STATUS;
    END IF;
  
    IF V_REG_TYPE = 'ar' THEN
      FOR C IN RECEIPTIDS LOOP
        IF C.EBS_STATUS <> 'US' THEN
          STATUS := '未完成';
          RETURN STATUS;
        END IF;
      
        --判断是否有状态不等于us的
        SELECT COUNT(*)
          INTO NUMBER2
          FROM SPM_CON_RECEIPT_INVOICE E, SPM_CON_RECEIPT I
         WHERE E.RECEIPT_ID = I.RECEIPT_ID
           AND E.RECEIPT_ID = C.RECEIPT_ID
           AND I.RECEIPT_TYPE <> 'A'
           AND E.EBS_STATUS <> 'R'
           AND E.EBS_STATUS <> 'US';
      
        IF NUMBER2 > 0 THEN
          STATUS := '未完成';
          RETURN STATUS;
        END IF;
      
      /*FOR D IN EBS_STATUS(C.RECEIPT_ID) LOOP
                                                                                                                      IF D.EBS_STATUS <> 'US' THEN
                                                                                                                        STATUS := '未完成';
                                                                                                                        RETURN STATUS;
                                                                                                                      END IF;
                                                                                                                    END LOOP;*/
      
      END LOOP;
    ELSE
    
      SELECT COUNT(*)
        INTO NUMBER3
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.MONEY_REG_ID = MONEYREG_ID
         AND I.EBS_STATUS <> 'R'
         AND I.EBS_STATUS <> 'US';
    
      IF NUMBER3 > 0 THEN
        STATUS := '未完成';
        RETURN STATUS;
      END IF;
    
      /*FOR E IN AP_EBS_STATUS LOOP
        IF E.EBS_STATUS <> 'US' THEN
          STATUS := '未完成';
          RETURN STATUS;
        END IF;
      END LOOP;*/
    
    END IF;
    RETURN STATUS;
  END;
  
    --获取财务到款同步状态
  FUNCTION GET_EBS_STATUS(MONEYREG_ID NUMBER) RETURN VARCHAR2 IS
    STATUS           VARCHAR2(40);
    IS_EXISTS          NUMBER;
    V_REG_TYPE       VARCHAR2(40);
    V_REMARK         VARCHAR2(4000);
    V_TOTAL_MONEY    NUMBER;
    V_RESIDUAL_MONEY NUMBER;
  
  BEGIN
    STATUS := '已完成';
  
    SELECT R.REMARK, R.REG_TYPE, R.Money_Account
      INTO V_REMARK, V_REG_TYPE, V_TOTAL_MONEY
      FROM SPM_CON_MONEY_REG R
     WHERE 1 = 1
       AND R.MONEY_REG_ID = MONEYREG_ID;
    --判断是否为历史数据
    IF V_REMARK = '历史数据' THEN
      RETURN STATUS;
    END IF;
  
    IF V_REG_TYPE = 'ar' THEN
    
      SELECT NVL(SUM(T.MONEY_AMOUNT), 0) - V_TOTAL_MONEY
        INTO V_RESIDUAL_MONEY
        FROM SPM_CON_RECEIPT T
       WHERE T.MONEY_REG_ID = MONEYREG_ID
         AND T.EBS_STATUS = 'US';
    
      IF V_RESIDUAL_MONEY < 0 THEN
      
        STATUS := '未完成';
      END IF;
    ELSIF V_REG_TYPE = 'ap' then
      SELECT COUNT(*)
        INTO IS_EXISTS
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.MONEY_REG_ID = MONEYREG_ID
         AND I.EBS_STATUS <> 'R'
         AND I.EBS_STATUS <> 'US';
    
      IF IS_EXISTS > 0 THEN
        STATUS := '未完成';
      END IF;
    ELSE
      STATUS := '未完成';
    END IF;
    RETURN STATUS;
  END;

  --获取银行id
  FUNCTION GET_NUMBER(P_ORG_ID           IN NUMBER,
                      P_CURRENCY_CODE    IN VARCHAR2,
                      P_RECEIPT_METHODS  IN VARCHAR2,
                      P_BANK_BRANCH_NAME IN VARCHAR2,
                      P_BANK_ACCOUNT_NUM IN VARCHAR2) RETURN NUMBER AS
    L_REMITTANCE_BANK_ACCOUNT_ID NUMBER;
  BEGIN
    SELECT BA.BANK_ACCT_USE_ID
      INTO L_REMITTANCE_BANK_ACCOUNT_ID
      FROM AR_RECEIPT_METHODS             RM,
           AR_RECEIPT_CLASSES             RC,
           AR_LOOKUPS                     L,
           CE_BANK_ACCOUNTS               CBA,
           CE_BANK_ACCT_USES_ALL          BA,
           CE_BANK_BRANCHES_V             BB,
           AR_RECEIPT_METHOD_ACCOUNTS_ALL RMA,
           HR_OPERATING_UNITS             HR
     WHERE RM.RECEIPT_CLASS_ID = RC.RECEIPT_CLASS_ID
       AND RMA.ORG_ID = BA.ORG_ID
       AND HR.ORGANIZATION_ID = RMA.ORG_ID
          -------CZY
          --AND mo_global.check_access(hr.organization_id) = 'Y'
          --  AND rma.org_id = nvl( /*:ar_batches_sum.org_id*/ NULL, rma.org_id)
          -------CZY
       AND RC.CREATION_STATUS = L.LOOKUP_CODE
       AND L.LOOKUP_TYPE = 'RECEIPT_CREATION_STATUS'
       AND RC.CREATION_METHOD_CODE = 'MANUAL'
       AND CBA.ACCOUNT_CLASSIFICATION = 'INTERNAL'
       AND CBA.BANK_BRANCH_ID = BB.BRANCH_PARTY_ID
       AND RM.RECEIPT_METHOD_ID = RMA.RECEIPT_METHOD_ID
       AND CBA.BANK_ACCOUNT_ID = BA.BANK_ACCOUNT_ID
       AND CBA.AR_USE_ALLOWED_FLAG = 'Y'
       AND NVL(BA.AR_USE_ENABLE_FLAG, 'N') = 'Y'
       AND RMA.REMIT_BANK_ACCT_USE_ID = BA.BANK_ACCT_USE_ID
       AND RM.RECEIPT_CLASS_ID NOT IN
           (SELECT ARC.RECEIPT_CLASS_ID
              FROM AR_RECEIPT_CLASSES ARC
             WHERE ARC.NOTES_RECEIVABLE = 'Y'
                OR ARC.BILL_OF_EXCHANGE_FLAG = 'Y')
       AND (CASE
             WHEN P_RECEIPT_METHODS IS NOT NULL THEN
              P_RECEIPT_METHODS
             ELSE
              RM.NAME
           END) = RM.NAME
       AND (CASE
             WHEN P_ORG_ID IS NOT NULL THEN
              P_ORG_ID
             ELSE
              RMA.ORG_ID
           END) = RMA.ORG_ID
       AND (CASE
             WHEN P_BANK_BRANCH_NAME IS NOT NULL THEN
              P_BANK_BRANCH_NAME
             ELSE
              BB.BANK_BRANCH_NAME
           END) = BB.BANK_BRANCH_NAME
       AND (CASE
             WHEN P_BANK_ACCOUNT_NUM IS NOT NULL THEN
              P_BANK_ACCOUNT_NUM
             ELSE
              CE_BANK_AND_ACCOUNT_UTIL.GET_MASKED_BANK_ACCT_NUM(CBA.BANK_ACCOUNT_ID)
           END) =
           CE_BANK_AND_ACCOUNT_UTIL.GET_MASKED_BANK_ACCT_NUM(CBA.BANK_ACCOUNT_ID)
          /*AND (sysdate BETWEEN rm.start_date AND
          nvl(rm.end_date, sysdate))*/
       AND ROWNUM = 1;
    RETURN L_REMITTANCE_BANK_ACCOUNT_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_NUMBER;
  --判断是否有导入权限
  FUNCTION IS_CASHIER(RESPONSE_ID NUMBER) RETURN VARCHAR2 AS
    RESULT_V    VARCHAR2(40);
    HAS_CASHIER NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO HAS_CASHIER
      FROM FND_USER_RESP_GROUPS_DIRECT T,
           FND_RESPONSIBILITY_VL       R,
           SPM_DICT                    D,
           SPM_DICT_TYPE               E
     WHERE T.RESPONSIBILITY_ID = R.RESPONSIBILITY_ID
       AND E.DICT_TYPE_ID = D.DICT_TYPE_ID
       AND E.DICT_TYPE_ID = 17130
       AND R.RESPONSIBILITY_ID = RESPONSE_ID
       AND R.RESPONSIBILITY_KEY = D.DICT_CODE;
    IF HAS_CASHIER > 0 THEN
      RESULT_V := 'S';
    ELSE
      RESULT_V := 'F';
    END IF;
    RETURN RESULT_V;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'F';
  END IS_CASHIER;

  --合同交接通过回调
  PROCEDURE SPM_CON_WF_TRANS_TG(V_ITEMKEY   IN VARCHAR2,
                                V_OTYPECODE IN VARCHAR2) AS
    DEPTID   NUMBER;
    CONFLAG  VARCHAR2(32);
    K_ORG_ID NUMBER;
    CURSOR TRANSDECUR IS
      SELECT CONTRACT_ID
        FROM SPM_CON_HT_TRANS_DETAIL L
       WHERE L.HT_TRANSFER_ID =
             (SELECT S.HT_TRANSFER_ID
                FROM SPM_CON_HT_TRANS S
               WHERE S.ITEM_KEY = V_ITEMKEY);
  BEGIN
  
    --ruankk 2019/02/12 解决合同移交合同部门不正确的问题
    SELECT S.ORG_ID
      INTO K_ORG_ID
      FROM SPM_CON_HT_TRANS S
     WHERE S.ITEM_KEY = V_ITEMKEY;
  
    /*
    2018-10-29 
    欧榕
    修复合同移交成功时，如果用户有多个组织，会取到不正确组织的BUG
    */
    /*    SELECT ORGANIZATION_ID
      INTO DEPTID
    FROM SPM_EAM_PEOPLE_V T
    WHERE T.USER_ID = fnd_global.USER_ID;*/
    SELECT T.ORGANIZATION_ID
      INTO DEPTID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = K_ORG_ID
       AND T.USER_ID = FND_GLOBAL.USER_ID;
  
    FOR C IN TRANSDECUR LOOP
      UPDATE SPM_CON_HT_INFO O
         SET O.CREATED_BY = FND_GLOBAL.USER_ID, O.DEPT_ID = DEPTID
       WHERE O.CONTRACT_ID = C.CONTRACT_ID;
      --修改变更过的合同
      SELECT S.CONTRACT_FLAG
        INTO CONFLAG
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_ID = C.CONTRACT_ID;
      UPDATE SPM_CON_HT_INFO O
         SET O.CREATED_BY = FND_GLOBAL.USER_ID, O.DEPT_ID = DEPTID
       WHERE O.CONTRACT_FLAG = CONFLAG;
    END LOOP;
  END;
  FUNCTION VALIDATE_STATUS(STATUS IN VARCHAR2) RETURN VARCHAR2 IS
    FLAG VARCHAR2(40);
  BEGIN
    IF STATUS = 'JZ' OR STATUS = 'Z' OR STATUS = 'IZ' THEN
      FLAG := 'N';
    ELSE
      FLAG := 'Y';
    END IF;
    RETURN FLAG;
  END VALIDATE_STATUS;

  FUNCTION GET_LEVAL_BY_SCORE(EVALUATEID IN NUMBER) RETURN VARCHAR2 IS
    AVERAGE NUMBER;
    LEVAL   VARCHAR2(40);
  BEGIN
    SELECT AVG(L.EVALUATE_SCORE)
      INTO AVERAGE
      FROM SPM_CON_HT_EVALUATE_DETAIL L
     WHERE L.EVALUATE_ID = EVALUATEID;
    IF AVERAGE = 0 THEN
      LEVAL := '0';
    ELSIF AVERAGE < 5 THEN
      LEVAL := '1';
    ELSIF AVERAGE < 8 THEN
      LEVAL := '2';
    ELSIF AVERAGE < 9 THEN
      LEVAL := '3';
    ELSE
      LEVAL := '4';
    END IF;
    IF AVERAGE IS NULL THEN
      LEVAL := '0';
    END IF;
    RETURN LEVAL;
  END;
  FUNCTION GET_OVER_ALL_LEVAL(MERCHANTSID NUMBER) RETURN VARCHAR2 IS
    CURSOR CUR_EVALUATEIDS IS
      SELECT E.EVALUATE_ID
        FROM SPM_CON_HT_EVALUATE E
       WHERE E.MERCHANTS_ID = MERCHANTSID
         AND E.EVALUATE_STATUS = 'B';
    SCORE    NUMBER := 0;
    NUMBER1  NUMBER := 0;
    AVGSCORE NUMBER := 0;
    LEVAL    VARCHAR2(40);
  BEGIN
    FOR C IN CUR_EVALUATEIDS LOOP
      SCORE   := SCORE + TO_NUMBER(GET_LEVAL_BY_SCORE(C.EVALUATE_ID));
      NUMBER1 := NUMBER1 + 1;
    END LOOP;
    AVGSCORE := ROUND(SCORE / NUMBER1, 2);
    IF AVGSCORE < 2AND AVGSCORE > 0 THEN
      LEVAL := '差';
    ELSE
      IF AVGSCORE < 3 THEN
        LEVAL := '中';
      ELSE
        IF AVGSCORE < 4 THEN
          LEVAL := '良';
        ELSE
          LEVAL := '优';
        END IF;
      END IF;
    END IF;
    IF AVGSCORE = 0 THEN
      LEVAL := '未评分';
    END IF;
    RETURN LEVAL;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '--';
  END;
  /*procedure receipt_sync is
    begin
      insert into spm_con_receipt t
      (t.receipt_id,
       t.money_reg_id,
       t.receipt_code,
       t.money_amount,
       t.contract_id,
       t.project_id,
       t.receipt_type)
      select spm_con_receipt_seq.nextval,
             (select g.money_reg_id from spm_con_money_reg g where g.serial_number=p.到款单流水号) money_reg_id,
             p.收款单编号,
             p.金额,
             (select o.contract_id from spm_con_ht_info o where o.contract_name=p.合同名称) contract_id,
             (select c.project_id from spm_con_project c where c.project_name=p.项目名称) project_id,
             spm_eam_common_pkg.Get_Dictcode_By_Name('RECEIPT_TYPE_DICT',p.收款类型) as receipt_type
             from spm_con_receipt_temp p
             where p.error_message is null
             and p.收款单编号 not in (select receipt_code from spm_con_receipt);
       delete from spm_con_receipt_temp p where p.error_message is null;
  end receipt_sync;
  procedure receipt_validate is
    cursor cur_temp is select * from spm_con_receipt_temp p where p.error_message is null;
    error_message_v varchar2(40);
    if_exist number;
    begin
      for c in cur_temp loop
       select count(g.money_reg_id) into if_exist from spm_con_money_reg g where g.serial_number=c.到款单流水号;
       if if_exist=0 then
         if error_message_v is not null then
         error_message_v:=error_message_v||'该到款单不存在';
         else
           error_message_v:='|该到款单不存在';
         end if;
         end if;
       select count(o.contract_id) into if_exist from spm_con_ht_info o where o.contract_name=c.合同名称;
       if if_exist=0 then
         if error_message_v is not null then
         error_message_v:=error_message_v||'|该合同不存在';
         else
           error_message_v:='该合同不存在';
         end if;
       end if;
       select count(t.project_id) into if_exist from spm_con_project t where t.project_name=c.项目名称;
       if if_exist=0 then
         if error_message_v is not null then
         error_message_v:=error_message_v||'|该项目不存在';
         else
         error_message_v:='该项目不存在';
         end if;
       end if;
       update spm_con_receipt_temp m set m.error_message=error_message_v where m.收款单编号=c.收款单编号;
       end loop;
  end receipt_validate;*/

  --批量创建分录
  PROCEDURE BATCH_CREATE_ACCOUNT(V_USER_ID     IN NUMBER,
                                 V_RESP_ID     IN NUMBER,
                                 V_RESP_APP_ID IN NUMBER,
                                 RETURN_MSG    OUT VARCHAR2) IS
  
    V_RETURN_CODE VARCHAR2(40);
    V_RETURN_MSG  VARCHAR2(2000);
    --查询所有的未成功创建分录的导入收款单
    CURSOR CUR_1 IS
      SELECT R.RECEIPT_ID, R.RECEIPT_CODE, R.EBS_STATUS
        FROM SPM_CON_RECEIPT R
       WHERE R.RECEIPT_CODE LIKE 'BATCH%'
         AND R.EBS_STATUS <> 'US'
         AND R.ORG_ID = SPM_SSO_PKG.GETORGID;
  
    --查询导入收款单的所有未创建分录的核销记录
    CURSOR CUR_2 IS
      SELECT I.RECEIPT_INVOICE_ID,
             I.EBS_STATUS,
             R.RECEIPT_CODE,
             O.INVOICE_CODE
        FROM SPM_CON_RECEIPT_INVOICE I,
             SPM_CON_RECEIPT         R,
             SPM_CON_OUTPUT_INVOICE  O
       WHERE I.RECEIPT_ID = R.RECEIPT_ID
         AND I.OUTPUT_INVOICE_ID = O.OUTPUT_INVOICE_ID
         AND I.EBS_STATUS <> 'US'
         AND R.RECEIPT_CODE LIKE 'BATCH%'
         AND R.ORG_ID = SPM_SSO_PKG.GETORGID;
  BEGIN
  
    --创建收款分录
    FOR REC_1 IN CUR_1 LOOP
      --定义是否成功同步标识位
      V_RETURN_CODE := 'F';
      IF REC_1.EBS_STATUS IN ('N', 'E') THEN
        BEGIN
          SPM_CON_AR_RECEIPT(V_ID             => REC_1.RECEIPT_ID,
                             V_USER_ID        => V_USER_ID,
                             V_RESP_ID        => V_RESP_ID,
                             V_RESP_APP_ID    => V_RESP_APP_ID,
                             V_RETURN_CODE    => V_RETURN_CODE,
                             V_RETURN_MESSAGE => V_RETURN_MSG);
        
          --更新状态，拼装返回信息
          IF V_RETURN_CODE <> 'S' THEN
            V_RETURN_MSG := '收款单号为' || REC_1.RECEIPT_CODE || '的收款同步失败，原因是：' ||
                            V_RETURN_MSG || '；';
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'E', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
          ELSE
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'S', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
          END IF;
        
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := '收款单号为' || REC_1.RECEIPT_CODE ||
                            '的收款同步失败，原因是：程序错误；';
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'E', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
        END;
        COMMIT;
        RETURN_MSG := RETURN_MSG || V_RETURN_MSG;
      END IF;
    
      IF REC_1.EBS_STATUS IN ('S', 'UE') OR V_RETURN_CODE = 'S' THEN
        BEGIN
          SPM_CON_AR_RECE_ACCOUNIT(V_ID          => REC_1.RECEIPT_ID,
                                   V_USER_ID     => V_USER_ID,
                                   V_RESP_ID     => V_RESP_ID,
                                   V_RESP_APP_ID => V_RESP_APP_ID,
                                   A_RETURN_CODE => V_RETURN_CODE,
                                   A_RETURN_MSG  => V_RETURN_MSG);
          --根据返回状态更新收款单
          IF V_RETURN_CODE <> 'S' THEN
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'UE', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
          
            V_RETURN_MSG := '收款单号为' || REC_1.RECEIPT_CODE ||
                            '的收款创建分录失败，原因是：' || V_RETURN_MSG || '；';
          ELSE
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'US', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            UPDATE SPM_CON_RECEIPT R
               SET R.EBS_STATUS = 'UE', R.OPERATION_TIME = SYSDATE
             WHERE R.RECEIPT_ID = REC_1.RECEIPT_ID;
            V_RETURN_MSG := '收款单号为' || REC_1.RECEIPT_CODE ||
                            '的收款创建分录失败，原因是：程序错误；';
        END;
        COMMIT;
        RETURN_MSG := RETURN_MSG || V_RETURN_MSG;
      END IF;
    END LOOP;
  
    FOR REC_2 IN CUR_2 LOOP
      --定义是否成功同步标识位
      V_RETURN_CODE := 'F';
      IF REC_2.EBS_STATUS IN ('N', 'E') THEN
        --同步核销记录
        BEGIN
          SPM_CON_AR_INVOICE(V_ID             => REC_2.RECEIPT_INVOICE_ID,
                             V_USER_ID        => V_USER_ID,
                             V_RESP_ID        => V_RESP_ID,
                             V_RESP_APP_ID    => V_RESP_APP_ID,
                             V_RETURN_CODE    => V_RETURN_CODE,
                             V_RETURN_MESSAGE => V_RETURN_MSG);
          --根据返回状态更新核销记录
          IF V_RETURN_CODE <> 'S' THEN
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'E', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          
            V_RETURN_MSG := '收款单号为' || REC_2.RECEIPT_CODE || '，发票号码为' ||
                            REC_2.INVOICE_CODE || '的核销记录同步失败，原因是：' ||
                            V_RETURN_MSG || '；';
          ELSE
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'S', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'E', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          
            V_RETURN_MSG := '收款单号为' || REC_2.RECEIPT_CODE || '，发票号码为' ||
                            REC_2.INVOICE_CODE || '的核销记录同步失败，原因是：程序错误；';
        END;
        COMMIT;
        RETURN_MSG := RETURN_MSG || V_RETURN_MSG;
      END IF;
    
      IF REC_2.EBS_STATUS = 'UE' OR V_RETURN_CODE = 'S' THEN
        --创建核销记录会计分录
        BEGIN
          SPM_CON_AR_INVOICE_ACCOUNIT(V_ID          => REC_2.RECEIPT_INVOICE_ID,
                                      V_USER_ID     => V_USER_ID,
                                      V_RESP_ID     => V_RESP_ID,
                                      V_RESP_APP_ID => V_RESP_APP_ID,
                                      A_RETURN_CODE => V_RETURN_CODE,
                                      A_RETURN_MSG  => V_RETURN_MSG);
          --根据返回状态更新核销记录
          IF V_RETURN_CODE <> 'S' THEN
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'UE', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          
            V_RETURN_MSG := '收款单号为' || REC_2.RECEIPT_CODE || '，发票号码为' ||
                            REC_2.INVOICE_CODE || '的核销记录创建会计分录失败，原因是：' ||
                            V_RETURN_MSG || '；';
          ELSE
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'US', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            UPDATE SPM_CON_RECEIPT_INVOICE R
               SET R.EBS_STATUS = 'UE', R.EBS_SYNC_DATE = SYSDATE
             WHERE R.RECEIPT_INVOICE_ID = REC_2.RECEIPT_INVOICE_ID;
          
            V_RETURN_MSG := '收款单号为' || REC_2.RECEIPT_CODE || '，发票号码为' ||
                            REC_2.INVOICE_CODE || '的核销记录创建会计分录失败，原因是：程序错误；';
        END;
        COMMIT;
        RETURN_MSG := RETURN_MSG || V_RETURN_MSG;
      END IF;
    END LOOP;
  END BATCH_CREATE_ACCOUNT;

  --查询EBS侧当前收款单剩余金额 by mcq
  FUNCTION GET_EBS_RECEIPT_APPLIED_AMOUNT(P_RECEIPT_CODE VARCHAR2,
                                          P_ORG_ID       NUMBER)
    RETURN NUMBER IS
    P_APPLIED_AMOUNT NUMBER DEFAULT 0; --已核销金额
    P_SUM_AMOUNT     NUMBER DEFAULT 0; --收款单总金额
  
  BEGIN
    --总金额
    SELECT ACA.AMOUNT
      INTO P_SUM_AMOUNT
      FROM AR_CASH_RECEIPTS_ALL ACA
     WHERE ACA.RECEIPT_NUMBER = P_RECEIPT_CODE
       AND ACA.ORG_ID = P_ORG_ID;
    BEGIN
    
      --已核销金额
      SELECT NVL(SUM(DECODE(ACRA.CURRENCY_CODE,
                            'CNY',
                            NVL(ARAA.AMOUNT_APPLIED *
                                NVL(ARAA.TRANS_TO_RECEIPT_RATE, 1),
                                0),
                            NVL(ARAA.AMOUNT_APPLIED, 0) * ACRA.EXCHANGE_RATE *
                            NVL(ARAA.TRANS_TO_RECEIPT_RATE, 1))),
                 0)
        INTO P_APPLIED_AMOUNT
        FROM AR_CASH_RECEIPTS_ALL           ACRA,
             AR_CASH_RECEIPT_HISTORY_ALL    ACRHA,
             AR_RECEIVABLE_APPLICATIONS_ALL ARAA
       WHERE (((ACRA.RECEIPT_METHOD_ID = 1042 AND
             ACRHA.STATUS NOT IN
             ('REMITTED', 'CLEARED' ， 'RISK_ELIMINATED') AND
             NVL(ACRHA.CURRENT_RECORD_FLAG, 'Y') = 'Y')) OR
             (ACRA.RECEIPT_METHOD_ID <> 1042 AND
             NVL(ACRHA.CURRENT_RECORD_FLAG, 'N') = 'Y'))
         AND EXISTS (SELECT 'A'
                FROM AR_CASH_RECEIPT_HISTORY_ALL T
               WHERE T.CASH_RECEIPT_ID = ACRHA.CASH_RECEIPT_ID
                 AND T.CURRENT_RECORD_FLAG = 'Y'
                 AND T.STATUS != 'REVERSED')
         AND ACRA.CASH_RECEIPT_ID = ACRHA.CASH_RECEIPT_ID
         AND UPPER(ACRHA.STATUS) != 'REVERSED'
         AND ARAA.CASH_RECEIPT_ID = ACRA.CASH_RECEIPT_ID
         AND ARAA.DISPLAY = 'Y'
            -- AND ARAA.GL_DATE <= TO_DATE('&deadline_date', 'yyyy-mm-dd') 
            --AND ARAA.APPLIED_CUSTOMER_TRX_ID <> -1
         AND ACRA.ORG_ID = P_ORG_ID
            -- AND ACRA.RECEIPT_NUMBER = p_receipt_number
         AND ACRA.CASH_RECEIPT_ID = P_RECEIPT_CODE;
    
    EXCEPTION
      WHEN OTHERS THEN
        P_APPLIED_AMOUNT := 0;
    END;
    RETURN P_SUM_AMOUNT - P_APPLIED_AMOUNT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END SPM_CON_RECEIPT_PKG;
/
