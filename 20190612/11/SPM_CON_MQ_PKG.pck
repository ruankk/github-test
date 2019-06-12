CREATE OR REPLACE PACKAGE SPM_CON_MQ_PKG AS

  --通过接口编号查出配置表ID
  FUNCTION SPM_MQ_CONFIGURE_ID(V_INTERFACE_CODE IN VARCHAR2) RETURN NUMBER;

  --查询中间件消息表是否有重复数据
  FUNCTION SPM_MQ_REPEAT_VALIDATE(V_BUSINESS_NAME   IN VARCHAR2,
                                  V_BUSINESS_CHARAC IN VARCHAR2,
                                  V_BUSINESS_ID     IN NUMBER) RETURN CHAR;

  /*保证金从中间表保存至数据表*/
  PROCEDURE INSERT_MARGIN(V_IDS         IN VARCHAR2,
                          V_RETURN_CODE OUT VARCHAR2,
                          V_RETURN_MSG  OUT VARCHAR2);

  /*中标服务费从中间表保存至数据表*/
  PROCEDURE INSERT_BID_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2);

  /*中标服务费审批完成批量生成过度付款等数据*/
  PROCEDURE GENERATE_BIDFEE_DATA_BATCH(V_INVOICE_IDS IN VARCHAR2);

  /*中标服务费审批完成生成过度付款等数据*/
  PROCEDURE GENERATE_BIDFEE_DATA(V_INVOICE_ID IN NUMBER);

  /*中标服务费审批接口*/
  PROCEDURE BID_FEE_SEND(V_ID           IN NUMBER,
                         V_AUDIT_STATUS IN VARCHAR2,
                         V_AUDIT_REASON IN VARCHAR2);

  /*采购订单付款状态同步电商接口*/
  PROCEDURE SPM_CON_PAYMENT_STATUS(O_PAYMENT_ID IN VARCHAR2);

  /*采购订单发票信息同步电商接口*/
  PROCEDURE SPM_CON_SYNC_INVOICEINFO(V_ID             IN VARCHAR2,
                                     V_MSG            IN CLOB,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2);

  /*插入标书费*/
  PROCEDURE INSERT_TENDER_FEE(V_IDS         IN VARCHAR2,
                              V_RETURN_CODE OUT VARCHAR2,
                              V_RETURN_MSG  OUT VARCHAR2);

  /*退保证金审批电商接口*/
  PROCEDURE SPM_CON_MARGIN_APPROVAL(O_INPUT_INVOICE_ID IN NUMBER,
                                    O_INVOICE_CODE     IN VARCHAR2,
                                    O_AUDIT_STATUS     IN VARCHAR2,
                                    O_AUDIT_INFO       IN VARCHAR2,
                                    O_CREATED_BY       IN NUMBER,
                                    O_CREATION_DATE    IN DATE,
                                    O_ORG_ID           IN NUMBER,
                                    O_DEPT_ID          IN NUMBER);

  /*订单取消接口*/
  PROCEDURE ORDER_CANCEL(V_CODE IN VARCHAR2);

  /*批量订单取消接口*/
  PROCEDURE BATCH_ORDER_CANCEL;

  --电商退保证金申请
  PROCEDURE SPM_CON_MQ_PAYMENTMARGIN(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2);

  /*获取ou、人员、部门信息*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE   IN VARCHAR2,
                         MANAGER      IN VARCHAR2,
                         MANAGER_CODE IN VARCHAR2,
                         V_ORG_ID     OUT NUMBER,
                         V_USER_ID    OUT NUMBER,
                         V_DEPT_ID    OUT NUMBER);

  /*获取ou、人员、部门信息（包含部门code）*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE      IN VARCHAR2,
                         MANAGER         IN VARCHAR2,
                         MANAGER_CODE    IN VARCHAR2,
                         DEPARTMENT      IN VARCHAR2,
                         DEPARTMENT_CODE IN VARCHAR2,
                         V_ORG_ID        OUT NUMBER,
                         V_USER_ID       OUT NUMBER,
                         V_DEPT_ID       OUT NUMBER);

  --收款电商接口（预存款收款信息同步、销售订单收款状态同步）
  PROCEDURE SPM_CON_MONEY_RECEIPT(V_ID IN VARCHAR2);

  /*会员费从中间表保存至数据表*/
  PROCEDURE INSERT_VIP_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2);

  /*交易佣金从中间表保存至数据表*/
  PROCEDURE INSERT_DEAL_FEE(V_IDS         IN VARCHAR2,
                            V_RETURN_CODE OUT VARCHAR2,
                            V_RETURN_MSG  OUT VARCHAR2);
  --北京公司到款自动匹配框架
  PROCEDURE MONEY_REG_MATCH_FRAMEWORK(V_IDS IN VARCHAR2);

  /*大贲回传邮寄信息接口*/
  PROCEDURE DB_INVOICE_EXPRESS;

  /*开票结果电子链接*/
  PROCEDURE SPM_CON_SEND_OPENRESULT(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2);

  --进项发票提交流程时判断是否符合条件
  FUNCTION QUERY_CONDITION_FLAG(INPUT_ID NUMBER) RETURN VARCHAR2;

  --添加工具方法，整合流水号生成 by mcq 20190116
  FUNCTION CREATE_SERIAL_CODE_UTIL(P_SERIAL_CODE VARCHAR2,
                                   P_TABLE_NAME  VARCHAR2,
                                   P_FIELD_NAME  VARCHAR2,
                                   P_FORMAT_CODE VARCHAR2,
                                   P_USER_ID     NUMBER,
                                   P_ORG_ID      NUMBER) RETURN VARCHAR2;
  --收款获取默认配置                                
  FUNCTION GET_RECEIPT_DEFAULT_CONFIGURE(K_RECEIPT_TYPE VARCHAR2,
                                         K_FIELD_TYPE   VARCHAR2,
                                         K_ORG_ID       NUMBER,
                                         K_USER_ID      NUMBER)
    RETURN VARCHAR2;

END SPM_CON_MQ_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_CON_MQ_PKG AS

  --通过接口编号查出配置表ID
  FUNCTION SPM_MQ_CONFIGURE_ID(V_INTERFACE_CODE IN VARCHAR2) RETURN NUMBER IS
    V_CONFIGURE_ID NUMBER(15);
  BEGIN
    SELECT S.CONFIGURE_ID
      INTO V_CONFIGURE_ID
      FROM SPM_CON_MQ_CONFIGURE S
     WHERE S.INTERFACE_CODE = V_INTERFACE_CODE;
    RETURN V_CONFIGURE_ID;
  EXCEPTION
    WHEN OTHERS THEN
      V_CONFIGURE_ID := '';
      RETURN V_CONFIGURE_ID;
  END;

  --查询中间件消息表是否有重复数据
  FUNCTION SPM_MQ_REPEAT_VALIDATE(V_BUSINESS_NAME   IN VARCHAR2,
                                  V_BUSINESS_CHARAC IN VARCHAR2,
                                  V_BUSINESS_ID     IN NUMBER) RETURN CHAR IS
  
    V_STATUS CHAR(1);
    V_NUMBER NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM SPM_CON_MQ_MESSAGE S
     WHERE S.BUSINESS_NAME = V_BUSINESS_NAME
       AND S.BUSINESS_CHARAC = V_BUSINESS_CHARAC
       AND S.BUSINESS_ID = V_BUSINESS_ID;
    IF V_NUMBER = 0 THEN
      V_STATUS := 'Y';
    ELSE
      V_STATUS := 'N';
    END IF;
    RETURN V_STATUS;
  EXCEPTION
    WHEN OTHERS THEN
      V_STATUS := 'N';
      RETURN V_STATUS;
  END;

  /*保证金从中间表保存至数据表*/
  PROCEDURE INSERT_MARGIN(V_IDS         IN VARCHAR2,
                          V_RETURN_CODE OUT VARCHAR2,
                          V_RETURN_MSG  OUT VARCHAR2) IS
    IDS                SPM_TYPE_TBL;
    V_ID               VARCHAR2(200);
    V_VENDOR_ID        NUMBER;
    V_BILLING_DATE     DATE;
    V_OPERATE_TYPE     VARCHAR2(10);
    V_PROJECT_ID       NUMBER;
    V_VENDOR_SITE_ID   NUMBER;
    V_L_ID             NUMBER;
    V_INPUT_INVOICE_ID NUMBER;
    X_ERROR_MSG        VARCHAR2(4000);
    X_ORG_ID           NUMBER(15);
    X_USER_ID          NUMBER(15);
    X_PERSON_ID        NUMBER(15);
    X_DEPT_ID          NUMBER(15);
    V_COUNT            NUMBER;
    V_EBS_STATUS       VARCHAR2(40);
    X_EBS_DEPT_CODE    VARCHAR2(40);
  
    CURSOR CUR1(V_MQ_ID NUMBER) IS
    
      SELECT M.TRANS_NUMBER,
             M.PACKAGE_NO,
             M.PACKAGE_NAME,
             M.OPERATE_TYPE,
             TO_NUMBER(SPM_CON_VENDOR_PACKAGE.QUERY_VENDOR_STATUS_BY_CODE(M.SUPPLIER_CODE)) V_VENDOR_ID,
             M.INDATE V_BILLING_DATE,
             M.REAL_AMOUNT,
             M.BANK_NAME,
             M.BANK_ACCOUNT,
             M.AGENT_CODE,
             M.AGENT_NAME,
             M.MANAGER_CODE,
             M.MANAGER,
             M.SUPPLIER,
             M.SUPPLIER_CODE,
             M.ACCOUNT_NO,
             M.DEPARTMENT,
             M.DEPARTMENT_CODE
        FROM SPM_CON_MQ_MARGIN M
       WHERE M.MQ_ID = V_MQ_ID;
    REC1 CUR1%ROWTYPE;
  
    CURSOR CUR2(V_ID NUMBER) IS
      SELECT GL.SEGMENT2,
             GL.SEGMENT3,
             GL.SEGMENT4,
             GL.SEGMENT5,
             GL.SEGMENT7,
             GL.SEGMENT10,
             GL.SEGMENT9
        FROM AR_RECEIPT_METHOD_ACCOUNTS_ALL AM,
             CE_BANK_ACCT_USES_ALL          CU,
             CE_BANK_ACCOUNTS               CA,
             GL_CODE_COMBINATIONS_KFV       GL,
             SPM_CON_MQ_MARGIN              MR
       WHERE AM.REMIT_BANK_ACCT_USE_ID = CU.BANK_ACCT_USE_ID
         AND CU.BANK_ACCOUNT_ID = CA.BANK_ACCOUNT_ID
         AND AM.CASH_CCID = GL.CODE_COMBINATION_ID
         AND AM.ORG_ID = X_ORG_ID
         AND CA.BANK_ACCOUNT_NUM = MR.ACCOUNT_NO
         AND MR.MQ_ID = V_ID;
    REC2 CUR2%ROWTYPE;
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        X_ERROR_MSG := '';
      
        UPDATE SPM_CON_MQ_MARGIN M
           SET M.LAST_UPDATE_DATE = SYSDATE
         WHERE M.MQ_ID = IDS(I);
      
        OPEN CUR1(IDS(I));
        FETCH CUR1
          INTO REC1;
        CLOSE CUR1;
      
        V_ID           := REC1.TRANS_NUMBER;
        V_OPERATE_TYPE := REC1.OPERATE_TYPE;
      
        -- 获取组织、人员、部门信息
        GET_ODU_INFO(AGENT_CODE      => REC1.AGENT_CODE,
                     MANAGER         => REC1.MANAGER,
                     MANAGER_CODE    => REC1.MANAGER_CODE,
                     DEPARTMENT      => REC1.DEPARTMENT,
                     DEPARTMENT_CODE => REC1.DEPARTMENT_CODE,
                     V_ORG_ID        => X_ORG_ID,
                     V_USER_ID       => X_USER_ID,
                     V_DEPT_ID       => X_DEPT_ID);
      
        IF X_ORG_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取组织“' || REC1.AGENT_NAME || '（' ||
                           REC1.AGENT_CODE || '）”信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC1.MANAGER || '（' ||
                           REC1.MANAGER_CODE ||
                           '）”信息：请先到【电商业财人员对照】模块维护对应关系';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC1.MANAGER || '（' ||
                           REC1.MANAGER_CODE || '）”信息：用户代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC1.MANAGER || '（' ||
                           REC1.MANAGER_CODE || '）”信息：用户姓名为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC1.DEPARTMENT || '（' ||
                           REC1.DEPARTMENT_CODE || '）”信息：请联系系统管理员';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC1.DEPARTMENT || '（' ||
                           REC1.DEPARTMENT_CODE || '）”信息：部门代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC1.DEPARTMENT || '（' ||
                           REC1.DEPARTMENT_CODE || '）”信息，部门名称为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        UPDATE SPM_CON_MQ_MARGIN T
           SET T.ORG_ID          = X_ORG_ID,
               T.DEPT_ID         = X_DEPT_ID,
               T.CREATED_BY      = X_USER_ID,
               T.LAST_UPDATED_BY = X_USER_ID
         WHERE T.MQ_ID = IDS(I);
      
        BEGIN
          -- 获取本组织无工程
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '无工程-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '本组织下无对应的无工程';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        -- 供应商
        IF REC1.V_VENDOR_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取供应商“' || REC1.SUPPLIER || '（' ||
                           REC1.SUPPLIER_CODE || '）”数据失败：';
        
          IF REC1.V_VENDOR_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '电商中间表不存在该条记录，请联系电商推送数据';
          ELSIF REC1.V_VENDOR_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '尚未生成业务数据';
          ELSIF REC1.V_VENDOR_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '该供应商未完成审核';
          ELSIF REC1.V_VENDOR_ID = -4 THEN
            X_ERROR_MSG := X_ERROR_MSG || '该供应商未同步';
          ELSIF REC1.V_VENDOR_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '获取过程异常，请联系系统管理员';
          END IF;
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        -- 投标保证金
        BEGIN
          SELECT T.VENDOR_SITE_ID
            INTO V_VENDOR_SITE_ID
            FROM PO_VENDOR_SITES_ALL T,
                 PO_VENDORS          V,
                 SPM_CON_VENDOR_INFO VI
           WHERE T.VENDOR_ID = V.VENDOR_ID
             AND VI.VENDOR_CODE = V.SEGMENT1
             AND V.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND T.ORG_ID = X_ORG_ID
             AND VI.VENDOR_ID = REC1.V_VENDOR_ID
             AND T.VENDOR_SITE_CODE = '投标保证金';
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '供应商“' || REC1.SUPPLIER || '（' ||
                             REC1.SUPPLIER_CODE || '）”没有对应的投标保证金地点';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        BEGIN
          SELECT T.PERSON_ID
            INTO X_PERSON_ID
            FROM SPM_EAM_ALL_PEOPLE_V T
           WHERE T.USER_ID = X_USER_ID;
        
          SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(X_ORG_ID,
                                                                X_PERSON_ID)
            INTO X_EBS_DEPT_CODE
            FROM DUAL;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '未获取到人员“' || REC1.MANAGER || '（' ||
                             REC1.MANAGER_CODE || '）”对应的部门段值信息，请到HR维护信息';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        V_INPUT_INVOICE_ID := SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL;
        IF V_OPERATE_TYPE = 'update' THEN
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_INPUT_INVOICE I
           WHERE I.INVOICE_CODE = REC1.TRANS_NUMBER;
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '未找到号码为' || REC1.TRANS_NUMBER || '的发票';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          ELSE
            SELECT NVL(I.EBS_STATUS, 'N')
              INTO V_EBS_STATUS
              FROM SPM_CON_INPUT_INVOICE I
             WHERE I.INVOICE_CODE = REC1.TRANS_NUMBER;
          
            IF V_EBS_STATUS <> 'N' AND V_EBS_STATUS <> 'E' THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '发票已经同步财务，无法更改';
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              CONTINUE;
            END IF;
          END IF;
        
          BEGIN
            SELECT I.INPUT_INVOICE_ID, W.INPUT_WAREHOUSE_ID
              INTO V_INPUT_INVOICE_ID, V_L_ID
              FROM SPM_CON_INPUT_INVOICE I, SPM_CON_INPUT_WAREHOUSE W
             WHERE I.INPUT_INVOICE_ID = W.INPUT_INVOICE_ID
               AND I.INVOICE_CODE = REC1.TRANS_NUMBER;
          
            --更新主表
            UPDATE SPM_CON_INPUT_INVOICE I
               SET I.CREATED_BY       = X_USER_ID,
                   I.LAST_UPDATED_BY  = X_ORG_ID,
                   I.ORG_ID           = X_ORG_ID,
                   I.DEPT_ID          = X_DEPT_ID,
                   I.LAST_UPDATE_DATE = SYSDATE,
                   I.VENDOR_ID        = REC1.V_VENDOR_ID,
                   I.PACKAGE_NO       = REC1.PACKAGE_NO,
                   I.PACKAGE_NAME     = REC1.PACKAGE_NAME,
                   I.INVOICE_AMOUNT   = REC1.REAL_AMOUNT,
                   I.BILLING_DATE     = REC1.V_BILLING_DATE,
                   I.OPENING_BANK     = REC1.BANK_NAME,
                   I.BANK_ACCOUNT     = REC1.BANK_ACCOUNT,
                   I.VENDOR_SITE_ID   = V_VENDOR_SITE_ID,
                   I.EBS_DEPT_CODE    = X_EBS_DEPT_CODE
             WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
          
            OPEN CUR2(IDS(I));
            FETCH CUR2
              INTO REC2;
            IF CUR2%NOTFOUND THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '未获取到段值信息，请检查传递银行账号' || REC1.ACCOUNT_NO ||
                               '是否正确';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '；';
              END IF;
              V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              CONTINUE;
            END IF;
            CLOSE CUR2;
          
            -- 更新段值信息
            UPDATE SPM_CON_INPUT_WAREHOUSE W
               SET DEPT_SEC     = REC2.SEGMENT2,
                   SUB_SEC      = REC2.SEGMENT3,
                   DEALINGS_SEC = REC2.SEGMENT4,
                   PROJECT_SEC  = REC2.SEGMENT5,
                   PRODUCT_SEC  = REC2.SEGMENT7,
                   ASSIST_SEC   = REC2.SEGMENT10,
                   BANK_SEC     = REC2.SEGMENT9
             WHERE W.INPUT_WAREHOUSE_ID = V_L_ID;
          
            --将头信息中金额及人员信息更新到行信息中
            UPDATE SPM_CON_INPUT_WAREHOUSE
               SET (MONEY_AMOUNT,
                    CREATED_BY,
                    CREATION_DATE,
                    ORG_ID,
                    DEPT_ID,
                    REMARK) =
                   (SELECT I.INVOICE_AMOUNT,
                           I.CREATED_BY,
                           I.CREATION_DATE,
                           I.ORG_ID,
                           I.DEPT_ID,
                           I.INVOICE_CONTENT
                      FROM SPM_CON_INPUT_INVOICE I
                     WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID)
             WHERE INPUT_WAREHOUSE_ID = V_L_ID;
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '更新信息失败';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '；';
              END IF;
              V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              CONTINUE;
          END;
        ELSE
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_INPUT_INVOICE I
           WHERE I.INVOICE_CODE = REC1.TRANS_NUMBER;
          IF V_COUNT > 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '已存在号码为' || REC1.TRANS_NUMBER || '的发票';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          BEGIN
            INSERT INTO SPM_CON_INPUT_INVOICE
              (INPUT_INVOICE_ID,
               INVOICE_CODE,
               PROJECT_ID,
               CREATED_BY,
               LAST_UPDATED_BY,
               ORG_ID,
               DEPT_ID,
               CREATION_DATE,
               LAST_UPDATE_DATE,
               VENDOR_ID,
               PACKAGE_NO,
               PACKAGE_NAME,
               INVOICE_AMOUNT,
               VERIFIC_IMPREST_AMOUNT,
               RESIDUAL_AMOUNT,
               TAX_AMOUNT,
               INVOICETAX_AMOUNT,
               NOTAX_RESIDUAL_AMOUNT,
               CURRENCY_TYPE,
               BILLING_DATE,
               ATTRIBUTE5,
               EBS_TYPE,
               PAYMENT_TYPE,
               OPENING_BANK,
               BANK_ACCOUNT,
               PAYMENT_STATUS,
               INVOICE_TYPE,
               NO_CONTRACT,
               INVOICE_CONTENT,
               EBS_STATUS,
               VENDOR_SITE_ID,
               TAX_RATE,
               PAYMENT_TERM,
               EBS_DEPT_CODE,
               CASH_FLOW)
            VALUES
              (V_INPUT_INVOICE_ID,
               REC1.TRANS_NUMBER,
               V_PROJECT_ID,
               X_USER_ID,
               X_USER_ID,
               X_ORG_ID,
               X_DEPT_ID,
               SYSDATE,
               SYSDATE,
               REC1.V_VENDOR_ID,
               REC1.PACKAGE_NO,
               REC1.PACKAGE_NAME,
               REC1.REAL_AMOUNT,
               0,
               REC1.REAL_AMOUNT,
               0,
               REC1.REAL_AMOUNT,
               REC1.REAL_AMOUNT,
               'CNY',
               REC1.V_BILLING_DATE,
               'BZJ',
               'STANDARD',
               'WIRE',
               REC1.BANK_NAME,
               REC1.BANK_ACCOUNT,
               'F',
               'C',
               'Y',
               '保证金-' || REC1.SUPPLIER,
               'N',
               V_VENDOR_SITE_ID,
               0,
               10000,
               X_EBS_DEPT_CODE,
               '113');
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '生成' || REC1.TRANS_NUMBER || '发票主表数据失败';
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              CONTINUE;
          END;
        
          BEGIN
            V_L_ID := SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL;
          
            OPEN CUR2(IDS(I));
            FETCH CUR2
              INTO REC2;
            IF CUR2%NOTFOUND THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '未获取到段值信息，请检查传递银行账号' || REC1.ACCOUNT_NO ||
                               '是否正确';
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
            
              DELETE FROM SPM_CON_INPUT_INVOICE I
               WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
              CONTINUE;
            END IF;
            CLOSE CUR2;
          
            --行信息
            INSERT INTO SPM_CON_INPUT_WAREHOUSE
              (INPUT_WAREHOUSE_ID,
               INPUT_INVOICE_ID,
               DEPT_SEC,
               SUB_SEC,
               DEALINGS_SEC,
               PROJECT_SEC,
               PRODUCT_SEC,
               ASSIST_SEC,
               BANK_SEC)
            VALUES
              (V_L_ID,
               V_INPUT_INVOICE_ID,
               REC2.SEGMENT2,
               REC2.SEGMENT3,
               REC2.SEGMENT4,
               REC2.SEGMENT5,
               REC2.SEGMENT7,
               REC2.SEGMENT10,
               REC2.SEGMENT9);
          
            --将头信息中金额及人员信息更新到行信息中
            UPDATE SPM_CON_INPUT_WAREHOUSE
               SET (MONEY_AMOUNT,
                    CREATED_BY,
                    CREATION_DATE,
                    ORG_ID,
                    DEPT_ID,
                    REMARK) =
                   (SELECT I.INVOICE_AMOUNT,
                           I.CREATED_BY,
                           I.CREATION_DATE,
                           I.ORG_ID,
                           I.DEPT_ID,
                           I.INVOICE_CONTENT
                      FROM SPM_CON_INPUT_INVOICE I
                     WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID)
             WHERE INPUT_WAREHOUSE_ID = V_L_ID;
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '生成' || REC1.TRANS_NUMBER || '发票子表数据失败';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '；';
              END IF;
              V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
            
              DELETE FROM SPM_CON_INPUT_INVOICE I
               WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
              CONTINUE;
          END;
        END IF;
      
        UPDATE SPM_CON_MQ_MARGIN M
           SET M.GENERATE_FLAG = 'Y', M.ERROR_MESSAGE = ''
         WHERE M.MQ_ID = IDS(I);
      
      EXCEPTION
        WHEN OTHERS THEN
        
          DBMS_OUTPUT.PUT_LINE('sqlcode : ' || SQLCODE);
          DBMS_OUTPUT.PUT_LINE('sqlerrm : ' || SQLERRM);
        
          UPDATE SPM_CON_MQ_MARGIN M
             SET M.GENERATE_FLAG = 'N'
           WHERE M.MQ_ID = IDS(I);
        
          V_RETURN_CODE := 'F';
          /*IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || ',';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || SQLERRM;*/
      END;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      V_RETURN_CODE := 'S';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行异常';
  END INSERT_MARGIN;

  /*中标服务费从中间表保存至数据表*/
  PROCEDURE INSERT_BID_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2) IS
    IDS           SPM_TYPE_TBL;
    V_ID          VARCHAR2(40);
    V_SERVICE_ID  VARCHAR2(40);
    X_ORG_ID      NUMBER(15);
    X_USER_ID     NUMBER(15);
    X_DEPT_ID     NUMBER(15);
    V_CUST_ID     NUMBER;
    V_PROJECT_ID  NUMBER;
    V_OPRATE_TYPE VARCHAR2(10);
    V_INVOICE_ID  NUMBER(15);
    V_ITEM_ID     NUMBER(15);
    V_TAX_AMOUNT  NUMBER;
    X_ERROR_MSG   VARCHAR2(4000);
    V_COUNT       NUMBER;
    K_EBS_DEPT     VARCHAR2(40);
  
    -- 客户银行信息
    CURSOR CUR1(VC_ID NUMBER) IS
      SELECT CCI.CUST_CODE,
             CCI.TELEPHONE,
             CCI.CUST_ADDRESS,
             CCI.TAXPAYER_CODE,
             R.OPENING_BANK,
             R.BANK_ACOUNT
        FROM SPM_CON_CUST_INFO CCI
        LEFT JOIN SPM_CON_BANK_ACOUNT_INFO R
          ON CCI.CUST_ID = R.CUST_ID
       WHERE 1 = 1
         AND CCI.STATUS = 'E'
         AND CCI.CUST_ID = VC_ID;
    REC1 CUR1%ROWTYPE;
  
    CURSOR CUR2(V_MQ_ID VARCHAR2) IS
    
      SELECT M.TOTAL_FEE,
             M.PACKAGE_NO,
             M.PACKAGE_NAME,
             M.TRANS_NUMBER,
             M.OPERATE_TYPE,
             M.ID,
             M.FEE_NAME,
             M.FEE_CODE,
             M.AGENT_CODE,
             M.AGENT_NAME,
             M.MANAGER_CODE,
             M.MANAGER,
             M.SUPPLIER,
             M.SUPPLIER_CODE,
             M.INVOICE_TYPE,
             M.DEPARTMENT,
             M.DEPARTMENT_CODE,
             TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS_BY_CODE(M.SUPPLIER_CODE)) V_CUST_ID
        FROM SPM_CON_MQ_BIDFEE M
       WHERE M.MQ_ID = V_MQ_ID;
    REC2 CUR2%ROWTYPE;
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
      
        UPDATE SPM_CON_MQ_BIDFEE M
           SET M.LAST_UPDATE_DATE = SYSDATE
         WHERE M.MQ_ID = IDS(I);
      
        SAVEPOINT SP_GENERATE_ERROR;
      
        OPEN CUR2(IDS(I));
        FETCH CUR2
          INTO REC2;
      
        V_ID          := REC2.TRANS_NUMBER;
        V_OPRATE_TYPE := REC2.OPERATE_TYPE;
        V_SERVICE_ID  := REC2.ID;
      
        -- 获取组织、人员、部门信息
        GET_ODU_INFO(AGENT_CODE      => REC2.AGENT_CODE,
                     MANAGER         => REC2.MANAGER,
                     MANAGER_CODE    => REC2.MANAGER_CODE,
                     DEPARTMENT      => REC2.DEPARTMENT,
                     DEPARTMENT_CODE => REC2.DEPARTMENT_CODE,
                     V_ORG_ID        => X_ORG_ID,
                     V_USER_ID       => X_USER_ID,
                     V_DEPT_ID       => X_DEPT_ID);
      
        IF X_ORG_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取组织“' || REC2.AGENT_NAME || '（' ||
                           REC2.AGENT_CODE || '）”信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE ||
                           '）”信息：请先到【电商业财人员对照】模块维护对应关系';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE || '）”信息：用户代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE || '）”信息：用户姓名为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC2.DEPARTMENT || '（' ||
                           REC2.DEPARTMENT_CODE || '）”信息：请联系系统管理员';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC2.DEPARTMENT || '（' ||
                           REC2.DEPARTMENT_CODE || '）”信息：部门代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || REC2.DEPARTMENT || '（' ||
                           REC2.DEPARTMENT_CODE || '）”信息，部门名称为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        UPDATE SPM_CON_MQ_BIDFEE T
           SET T.ORG_ID          = X_ORG_ID,
               T.DEPT_ID         = X_DEPT_ID,
               T.CREATED_BY      = X_USER_ID,
               T.LAST_UPDATED_BY = X_USER_ID
         WHERE T.MQ_ID = IDS(I);
      
        BEGIN
          -- 获取本组织无工程
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '无工程-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '本组织下无对应的无工程';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        IF REC2.V_CUST_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取客户“' || REC2.SUPPLIER || '（' ||
                           REC2.SUPPLIER_CODE || '）”数据失败：';
        
          IF REC2.V_CUST_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '电商中间表不存在该条记录，请联系电商推送数据';
          ELSIF REC2.V_CUST_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '尚未生成业务数据';
          ELSIF REC2.V_CUST_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '该客户未生效';
          ELSIF REC2.V_CUST_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '获取过程异常，请联系系统管理员';
          END IF;
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        OPEN CUR1(REC2.V_CUST_ID);
        FETCH CUR1
          INTO REC1;
      
        IF V_OPRATE_TYPE = 'update' THEN
          --数据类型为更新
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_OUTPUT_INVOICE O
           WHERE O.SERVICE_ID = V_SERVICE_ID;
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '未找到需要更改的源数据';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_OUTPUT_INVOICE O
           WHERE O.SERVICE_ID = V_SERVICE_ID
             AND O.STATUS IN ('A', 'D');
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '该数据已经进入审批流程，无法更改';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          BEGIN
            SELECT O.OUTPUT_INVOICE_ID, I.OUTPUT_ITEM_ID
              INTO V_INVOICE_ID, V_ITEM_ID
              FROM SPM_CON_OUTPUT_INVOICE O, SPM_CON_OUTPUT_ITEM I
             WHERE O.OUTPUT_INVOICE_ID = I.OUTPUT_INVOICE_ID
               AND O.SERVICE_ID = V_SERVICE_ID;
          
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.CUST_ID          = REC2.V_CUST_ID,
                   O.INVOICE_AMOUNT   = REC2.TOTAL_FEE,
                   O.PACKAGE_NO       = REC2.PACKAGE_NO,
                   O.PACKAGE_NAME     = REC2.PACKAGE_NAME,
                   O.CREATED_BY       = X_USER_ID,
                   O.ORG_ID           = X_ORG_ID,
                   O.DEPT_ID          = X_DEPT_ID,
                   O.SERVICE_ID       = REC2.ID,
                   O.SERVICE_CODE     = REC2.TRANS_NUMBER,
                   O.OPENING_BANK     = REC1.OPENING_BANK,
                   O.BANK_ACCOUNT     = REC1.BANK_ACOUNT,
                   O.CUST_ADDRESS     = REC1.CUST_ADDRESS,
                   O.TELEPHONE        = REC1.TELEPHONE,
                   O.TAXPAYER_ID_CODE = REC1.CUST_CODE,
                   O.PROJECT_ID       = V_PROJECT_ID,
                   O.LAST_UPDATE_DATE = SYSDATE
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
          
            V_TAX_AMOUNT := REC2.TOTAL_FEE / 1.06 * 0.06;
            UPDATE SPM_CON_OUTPUT_ITEM I
               SET MATERIAL_CODE    = REC2.FEE_NAME,
                   ITEM_FORMAT      = REC2.FEE_NAME,
                   UNIT_PRICE       = REC2.TOTAL_FEE,
                   MONEY_AMOUNT     = REC2.TOTAL_FEE,
                   TAX_AMOUNT       = V_TAX_AMOUNT,
                   CREATED_BY       = X_USER_ID,
                   LAST_UPDATE_DATE = SYSDATE,
                   LAST_UPDATED_BY  = X_USER_ID,
                   ORG_ID           = X_ORG_ID,
                   DEPT_ID          = X_DEPT_ID,
                   TAX_CODE         = REC2.FEE_CODE
             WHERE I.OUTPUT_ITEM_ID = V_ITEM_ID;
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '更新数据时发生错误';
            
              UPDATE SPM_CON_MQ_BIDFEE T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              ROLLBACK TO SP_GENERATE_ERROR;
              CONTINUE;
          END;
        
        ELSE
          --数据类型为新增
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_INPUT_INVOICE T
           WHERE T.INVOICE_CODE = V_ID
             AND ROWNUM = 1;
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '未匹配到号码为' || V_ID || '的保证金';
            -- 拼接提示信息
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_OUTPUT_INVOICE O
           WHERE O.SERVICE_ID = V_SERVICE_ID;
          IF V_COUNT > 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '号码重复';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          -- 新增销项发票主表
          BEGIN
            V_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
            
            select SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(X_ORG_ID,
                                                                  (select DISTINCT P.PERSON_ID
                                                                     from SPM_CON_HT_PEOPLE_V P
                                                                    WHERE P.USER_ID =
                                                                          X_USER_ID))
              INTO K_EBS_DEPT
              FROM DUAL;
              
            INSERT INTO SPM_CON_OUTPUT_INVOICE
              (OUTPUT_INVOICE_ID,
               CUST_ID,
               INVOICE_AMOUNT,
               PACKAGE_NO,
               PACKAGE_NAME,
               CREATED_BY,
               ORG_ID,
               DEPT_ID,
               CREATION_DATE,
               LAST_UPDATE_DATE,
               STATUS,
               EBS_STATUS,
               EBS_TYPE,
               IS_DISCOUNT,
               COST_TYPE,
               NO_CONTRACT,
               OWNED_GROUP,
               INVOICE_SOURCE,
               INVOICE_BILL,
               INVOICE_TYPE,
               PROJECT_ID,
               SERVICE_CODE,
               OPENING_BANK,
               BANK_ACCOUNT,
               INVOICE_SERIAL_NUMBER,
               CUST_ADDRESS,
               TELEPHONE,
               TAXPAYER_ID_CODE,
               SERVICE_ID,
               DS_FLAG,
               INVOICE_CATEGORY,
               EBS_DEPT_CODE)
            VALUES
              (V_INVOICE_ID,
               REC2.V_CUST_ID,
               REC2.TOTAL_FEE,
               REC2.PACKAGE_NO,
               REC2.PACKAGE_NAME,
               X_USER_ID,
               X_ORG_ID,
               X_DEPT_ID,
               SYSDATE,
               SYSDATE,
               'A',
               'N',
               'INV',
               'Y',
               'N',
               'Y',
               1,
               '手工发票',
               '发票',
               '主营业务结算',
               V_PROJECT_ID,
               REC2.TRANS_NUMBER,
               REC1.OPENING_BANK || '|' || REC1.BANK_ACOUNT,
               REC1.BANK_ACOUNT,
               REC2.TRANS_NUMBER,
               REC1.CUST_ADDRESS || '|' || REC1.TELEPHONE,
               REC1.TELEPHONE,
               REC1.CUST_CODE,
               REC2.ID,
               'ZB',
               REC2.INVOICE_TYPE,
               K_EBS_DEPT);
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '生成主表数据失败';
            
              UPDATE SPM_CON_MQ_BIDFEE T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              ROLLBACK TO SP_GENERATE_ERROR;
              CONTINUE;
          END;
        
          -- 新增销项发票子表
          BEGIN
            V_ITEM_ID    := SPM_CON_OUTPUT_ITEM_SEQ.NEXTVAL;
            V_TAX_AMOUNT := REC2.TOTAL_FEE / 1.06 * 0.06;
            INSERT INTO SPM_CON_OUTPUT_ITEM
              (OUTPUT_ITEM_ID,
               OUTPUT_INVOICE_ID,
               MATERIAL_CODE,
               ITEM_UNIT,
               ITEM_FORMAT,
               ITEM_AMOUNT,
               UNIT_PRICE,
               MONEY_AMOUNT,
               TAX_TATE,
               TAX_AMOUNT,
               CREATED_BY,
               CREATION_DATE,
               LAST_UPDATE_DATE,
               LAST_UPDATED_BY,
               ORG_ID,
               DEPT_ID,
               TAX_CODE)
            VALUES
              (V_ITEM_ID,
               V_INVOICE_ID,
               REC2.FEE_NAME,
               '元',
               REC2.FEE_NAME,
               1,
               REC2.TOTAL_FEE,
               REC2.TOTAL_FEE,
               6,
               V_TAX_AMOUNT,
               X_USER_ID,
               SYSDATE,
               SYSDATE,
               X_USER_ID,
               X_ORG_ID,
               X_DEPT_ID,
               REC2.FEE_CODE);
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '生成行数据失败';
            
              UPDATE SPM_CON_MQ_BIDFEE T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              ROLLBACK TO SP_GENERATE_ERROR;
              CONTINUE;
          END;
        
        END IF;
      
        UPDATE SPM_CON_MQ_BIDFEE M
           SET M.GENERATE_FLAG = 'Y', M.ERROR_MESSAGE = ''
         WHERE M.MQ_ID = IDS(I);
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '过程执行异常，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
      END;
    
      CLOSE CUR1;
      CLOSE CUR2;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      V_RETURN_CODE := 'S';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行异常，请联系系统管理员';
  END INSERT_BID_FEE;

  --中标服务费生成生成中转付款
  PROCEDURE GENERATE_BIDFEE_DATA_BATCH(V_INVOICE_IDS IN VARCHAR2) IS
    IDS SPM_TYPE_TBL;
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_INVOICE_IDS)
      INTO IDS
      FROM DUAL;
  
    FOR I IN 1 .. IDS.COUNT LOOP
      GENERATE_BIDFEE_DATA(V_INVOICE_ID => IDS(I));
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLCODE);
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END GENERATE_BIDFEE_DATA_BATCH;

  PROCEDURE GENERATE_BIDFEE_DATA(V_INVOICE_ID IN NUMBER) IS
    V_PAYMENT_ID         NUMBER(15);
    V_MONEY_REG_ID       NUMBER(15);
    V_RECEIPT_ID         NUMBER(15);
    V_RECEIPT_INVOCIE_ID NUMBER(15);
    V_CUST_NAME          VARCHAR2(200);
    PAY_BANK_ACCOUNT_ID  NUMBER;
    V_CAPITAL_ID         NUMBER;
    V_RESIDUAL_AMOUNT    NUMBER;
    SPM_CON_PAYMENT_INFO SPM_CON_PAYMENT%ROWTYPE;
    CAPITAL_PLAN_INFO    SPM_CON_CAPITAL_PLAN%ROWTYPE;
    V_SERIAL_CODE        VARCHAR2(200);
  
    -- 查询保证金
    CURSOR CUR_INPUT(TRANS_NUMBER VARCHAR2) IS
      SELECT *
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INVOICE_CODE = TRANS_NUMBER;
    REC_INPUT CUR_INPUT%ROWTYPE;
  
    -- 查询中标服务费
    CURSOR CUR_OUTPUT(OUTPUT_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_OUTPUT_INVOICE O
       WHERE O.OUTPUT_INVOICE_ID = OUTPUT_ID
         AND O.STATUS IN ('E', 'N');
    REC_OUTPUT CUR_OUTPUT%ROWTYPE;
  
  BEGIN
    SAVEPOINT SP;
  
    --查询可用的中标服务费数据
    OPEN CUR_OUTPUT(V_INVOICE_ID);
    FETCH CUR_OUTPUT
      INTO REC_OUTPUT;
  
    IF CUR_OUTPUT%FOUND THEN
      CLOSE CUR_OUTPUT;
    
      --查询可用的保证金数据
      OPEN CUR_INPUT(REC_OUTPUT.INVOICE_SERIAL_NUMBER);
      FETCH CUR_INPUT
        INTO REC_INPUT;
      IF CUR_INPUT%FOUND THEN
        CLOSE CUR_INPUT;
      
        BEGIN
          --获取付款账号ID
          SELECT A.BANK_ACCOUNT_ID
            INTO PAY_BANK_ACCOUNT_ID
            FROM CE.CE_BANK_ACCOUNTS A
           INNER JOIN CE.CE_BANK_ACCT_USES_ALL U
              ON A.BANK_ACCOUNT_ID = U.BANK_ACCOUNT_ID
           WHERE A.END_DATE IS NULL
             AND U.END_DATE IS NULL
             AND U.ORG_ID = REC_OUTPUT.ORG_ID
             AND A.MASKED_ACCOUNT_NUM =
                 (SELECT S.BANK_SEC
                    FROM SPM_CON_INPUT_WAREHOUSE S
                   WHERE S.INPUT_INVOICE_ID = REC_INPUT.INPUT_INVOICE_ID
                     AND ROWNUM = 1);
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '获取付款账号失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        -- 获取资金计划主键
        BEGIN
          SELECT SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(REC_OUTPUT.DEPT_ID)
            INTO V_CAPITAL_ID
            FROM DUAL;
        
          SELECT *
            INTO CAPITAL_PLAN_INFO
            FROM SPM_CON_CAPITAL_PLAN C
           WHERE C.CAPITAL_ID = V_CAPITAL_ID;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '获取资金计划信息失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        SELECT (NVL(I.RESIDUAL_AMOUNT, 0) -
               NVL(REC_OUTPUT.INVOICE_AMOUNT, 0))
          INTO V_RESIDUAL_AMOUNT
          FROM SPM_CON_INPUT_INVOICE I
         WHERE I.INPUT_INVOICE_ID = REC_INPUT.INPUT_INVOICE_ID;
        IF V_RESIDUAL_AMOUNT < 0 THEN
          ROLLBACK TO SP;
          UPDATE SPM_CON_OUTPUT_INVOICE O
             SET O.SYNC_ERROR = '保证金剩余金额不足'
           WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
          RETURN;
        END IF;
      
        -- 获取对应付款流水号
        BEGIN
          SELECT CREATE_SERIAL_CODE_UTIL('SPM_CON_PAYMENT_CODE_JZ',
                                         'SPM_CON_PAYMENT',
                                         'PAYMENT_CODE',
                                         'FM000000',
                                         REC_OUTPUT.CREATED_BY,
                                         REC_OUTPUT.ORG_ID)
            INTO V_SERIAL_CODE
            FROM DUAL;
        
          IF V_SERIAL_CODE = '00' THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成退保证金流水号失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
          
            RETURN;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成退保证金流水号失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          SELECT SPM_CON_PAYMENT_SEQ.NEXTVAL INTO V_PAYMENT_ID FROM DUAL;
          --生成付款-发票关联关系                  
          INSERT INTO SPM_CON_PAYMENT_INVOICE
            (PAYMENT_INVOICE_ID,
             PAYMENT_ID,
             INPUT_INVOICE_ID,
             MONEY_AMOUNT,
             CREATED_BY,
             CREATION_DATE,
             ORG_ID,
             DEPT_ID)
          VALUES
            (SPM_CON_PAYMENT_INVOICE_SEQ.NEXTVAL,
             V_PAYMENT_ID,
             REC_INPUT.INPUT_INVOICE_ID,
             REC_OUTPUT.INVOICE_AMOUNT,
             REC_OUTPUT.CREATED_BY,
             SYSDATE,
             REC_OUTPUT.ORG_ID,
             REC_OUTPUT.DEPT_ID);
          --核销发票，更新发票信息
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.RESIDUAL_AMOUNT = V_RESIDUAL_AMOUNT
           WHERE I.INPUT_INVOICE_ID = REC_INPUT.INPUT_INVOICE_ID;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '付款关联保证金失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
        
          -- 付款单主键  
          SPM_CON_PAYMENT_INFO.PAYMENT_ID := V_PAYMENT_ID;
          -- 付款来源：电商
          SPM_CON_PAYMENT_INFO.PAYMENT_SOURCE := 'DS';
          -- 资金计划付款
          SPM_CON_PAYMENT_INFO.PLAN_FLAG := 'Y';
          -- 上会
          SPM_CON_PAYMENT_INFO.IS_MEETING  := 'N';
          SPM_CON_PAYMENT_INFO.HAS_MEETING := 'N';
          -- 垫资
          SPM_CON_PAYMENT_INFO.WEATHER_DZ := 'N';
          -- 收款单位ID                                   
          SPM_CON_PAYMENT_INFO.VENDOR_ID := REC_INPUT.VENDOR_ID;
          --  项目id 
          SPM_CON_PAYMENT_INFO.PROJECT_ID := REC_INPUT.PROJECT_ID;
          --  付款单号 
          SPM_CON_PAYMENT_INFO.PAYMENT_CODE := V_SERIAL_CODE;
          --保证金单号
          SPM_CON_PAYMENT_INFO.OTHERS_SYSTEM_CODE := REC_INPUT.INVOICE_CODE;
          --  供应商地点 
          SPM_CON_PAYMENT_INFO.VENDOR_SITE_ID := REC_INPUT.VENDOR_SITE_ID;
          --  付款用途 
          SPM_CON_PAYMENT_INFO.PAY_PURPOSE := '24';
          --  付款类别 
          SPM_CON_PAYMENT_INFO.PAY_CATEGORY := '7';
          --  现金流 
          SPM_CON_PAYMENT_INFO.CASH_FLOW_ID := '124';
          --  付款银行账户 
          SPM_CON_PAYMENT_INFO.PAY_BANK_ACCOUNT_ID := PAY_BANK_ACCOUNT_ID;
          --  申请付款金额 
          SPM_CON_PAYMENT_INFO.MONEY_AMOUNT := REC_OUTPUT.INVOICE_AMOUNT;
          --  开户行名称 
          SPM_CON_PAYMENT_INFO.BANK_NAME := REC_INPUT.OPENING_BANK;
          --  收款方账号 
          SPM_CON_PAYMENT_INFO.BANK_ACCOUNT_NUM := REC_INPUT.BANK_ACCOUNT;
          --  付款币种 
          SPM_CON_PAYMENT_INFO.CURRENCY_TYPE := REC_INPUT.CURRENCY_TYPE;
          --  资金使用项目 
          SPM_CON_PAYMENT_INFO.MATCH_PROJECT := REC_INPUT.MATCH_PROJECT;
          --填摘要
          SPM_CON_PAYMENT_INFO.REMARK := REC_INPUT.REMARK;
          --  所属机构id 
          SPM_CON_PAYMENT_INFO.ORG_ID := REC_OUTPUT.ORG_ID;
          --  经办人 
          SPM_CON_PAYMENT_INFO.CREATED_BY := REC_OUTPUT.CREATED_BY;
          --  申请时间 
          SPM_CON_PAYMENT_INFO.CREATION_DATE := SYSDATE;
          --  修改时间 
          SPM_CON_PAYMENT_INFO.LAST_UPDATE_DATE := SYSDATE;
          --  所属部门id 
          SPM_CON_PAYMENT_INFO.DEPT_ID := REC_OUTPUT.DEPT_ID;
          --  核算部门 
          SPM_CON_PAYMENT_INFO.EBS_DEPT_CODE := REC_INPUT.EBS_DEPT_CODE;
          --  资金使用部门
          SPM_CON_PAYMENT_INFO.MATCH_DEPT := REC_INPUT.MATCH_DEPT;
          -- 审批状态
          SPM_CON_PAYMENT_INFO.STATUS := 'E';
          -- 同步状态
          SPM_CON_PAYMENT_INFO.EBS_STATUS := 'N';
          -- 付款状态
          SPM_CON_PAYMENT_INFO.PAY_STATUS := '0';
          -- 付款方法 
          SPM_CON_PAYMENT_INFO.PAY_METHODS := 'WIRE';
          -- 汇率类型
          SPM_CON_PAYMENT_INFO.EXCHANGE_TYPE := 'User';
          -- 汇率时间
          SPM_CON_PAYMENT_INFO.EXCHANGE_DATE := SYSDATE;
          -- 资金计划信息
          SPM_CON_PAYMENT_INFO.MONTH_DETAIL_ID    := CAPITAL_PLAN_INFO.CAPITAL_ID;
          SPM_CON_PAYMENT_INFO.THIS_MONTH_BALANCE := CAPITAL_PLAN_INFO.THIS_MONTH_BALANCE;
        
          INSERT INTO SPM_CON_PAYMENT VALUES SPM_CON_PAYMENT_INFO;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成中转付款单失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
        
          --新增到款数据
          V_MONEY_REG_ID := SPM_CON_MONEY_REG_SEQ.NEXTVAL;
          SELECT C.CUST_NAME
            INTO V_CUST_NAME
            FROM SPM_CON_CUST_INFO C
           WHERE C.CUST_ID = REC_OUTPUT.CUST_ID
             AND ROWNUM = 1;
        
          INSERT INTO SPM_CON_MONEY_REG
            (MONEY_REG_ID,
             SERIAL_NUMBER,
             CUST_ID,
             ACCOUNT_NAME,
             RECEIPT_ACCOUNT,
             MONEY_ACCOUNT,
             CURRENCY_TYPE,
             COLLECTION_DATE,
             REMARK,
             ORG_ID,
             DEPT_ID,
             STATUS,
             RECEIPT_NAME,
             RECEIPT_METHOD,
             RESIDUAL_AMOUNT,
             DEPOSIT_BANK,
             CREATED_BY,
             CREATION_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_DATE,
             REG_TYPE)
          VALUES
            (V_MONEY_REG_ID,
             REC_OUTPUT.INVOICE_SERIAL_NUMBER,
             REC_OUTPUT.CUST_ID,
             V_CUST_NAME,
             REC_OUTPUT.BANK_ACCOUNT,
             REC_OUTPUT.INVOICE_AMOUNT,
             'CNY',
             REC_OUTPUT.BILLING_DATE,
             '中标服务费',
             REC_OUTPUT.ORG_ID,
             REC_OUTPUT.DEPT_ID,
             'A',
             (SELECT V.ORG_NAME
                FROM SPM_EAM_ALL_ORG_DEPT_V V
               WHERE V.ORG_ID = REC_OUTPUT.ORG_ID),
             '中转收款',
             0,
             REC_OUTPUT.OPENING_BANK,
             REC_OUTPUT.CREATED_BY,
             SYSDATE,
             REC_OUTPUT.CREATED_BY,
             SYSDATE,
             'ar');
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成中转到款失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          --新增收款数据
          V_RECEIPT_ID := SPM_CON_RECEIPT_SEQ.NEXTVAL;
          INSERT INTO SPM_CON_RECEIPT
            (RECEIPT_ID,
             MONEY_REG_ID,
             RECEIPT_CODE,
             MONEY_AMOUNT,
             CURRENCY_TYPE,
             RMB_TOTAL,
             PROJECT_ID,
             RECEIPT_TYPE,
             CREATION_DATE,
             REMARK,
             STATUS,
             ORG_ID,
             RESIDUAL_AMOUNT,
             DEPT_ID,
             EBS_STATUS,
             CREATED_BY,
             LAST_UPDATED_BY,
             LAST_UPDATE_DATE)
          VALUES
            (V_RECEIPT_ID,
             V_MONEY_REG_ID,
             REC_OUTPUT.INVOICE_SERIAL_NUMBER,
             REC_OUTPUT.INVOICE_AMOUNT,
             'CNY',
             REC_OUTPUT.INVOICE_AMOUNT,
             REC_OUTPUT.PROJECT_ID,
             'I',
             SYSDATE,
             '中标服务费',
             'A',
             REC_OUTPUT.ORG_ID,
             0,
             REC_OUTPUT.DEPT_ID,
             'N',
             REC_OUTPUT.CREATED_BY,
             REC_OUTPUT.CREATED_BY,
             SYSDATE);
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成中转收款失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          --新增收款核销发票数据
          V_RECEIPT_INVOCIE_ID := SPM_CON_RECEIPT_INVOICE_SEQ.NEXTVAL;
          INSERT INTO SPM_CON_RECEIPT_INVOICE
            (RECEIPT_INVOICE_ID,
             RECEIPT_ID,
             OUTPUT_INVOICE_ID,
             MONEY_AMOUNT,
             ORG_ID,
             DEPT_ID,
             CREATED_BY,
             CREATION_DATE,
             LAST_UPDATED_BY,
             LAST_UPDATE_DATE,
             EBS_STATUS,
             REMARK)
          VALUES
            (V_RECEIPT_INVOCIE_ID,
             V_RECEIPT_ID,
             V_INVOICE_ID,
             REC_OUTPUT.INVOICE_AMOUNT,
             REC_OUTPUT.ORG_ID,
             REC_OUTPUT.DEPT_ID,
             REC_OUTPUT.CREATED_BY,
             SYSDATE,
             REC_OUTPUT.CREATED_BY,
             SYSDATE,
             'N',
             '中标服务费');
        
          UPDATE SPM_CON_OUTPUT_INVOICE O
             SET O.RESIDUAL_AMOUNT = O.INVOICE_AMOUNT -
                                     (SELECT NVL(SUM(R.MONEY_AMOUNT), 0)
                                        FROM SPM_CON_RECEIPT_INVOICE R
                                       WHERE R.OUTPUT_INVOICE_ID =
                                             V_INVOICE_ID)
           WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '生成中转收款核销发票失败'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
      END IF;
    END IF;
    UPDATE SPM_CON_OUTPUT_INVOICE O
       SET O.SYNC_ERROR = ''
     WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK TO SP;
      UPDATE SPM_CON_OUTPUT_INVOICE O
         SET O.SYNC_ERROR = '过程异常'
       WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
  END GENERATE_BIDFEE_DATA;

  /*中标服务费审批接口*/
  PROCEDURE BID_FEE_SEND(V_ID           IN NUMBER,
                         V_AUDIT_STATUS IN VARCHAR2,
                         V_AUDIT_REASON IN VARCHAR2) IS
    V_REPEAT CHAR(1);
    V_MSG    VARCHAR2(4000);
  BEGIN
  
    SELECT '{"id":"' || O.SERVICE_ID || '",
           "auditStatus":"' || V_AUDIT_STATUS || '",
           "auditReason":"' || V_AUDIT_REASON || '"}'
      INTO V_MSG
      FROM SPM_CON_OUTPUT_INVOICE O
     WHERE O.OUTPUT_INVOICE_ID = V_ID;
  
    V_REPEAT := SPM_MQ_REPEAT_VALIDATE('SPM_MQ_BIDFEE_SEND', 'Y', V_ID);
  
    IF V_REPEAT = 'Y' THEN
      INSERT INTO SPM_CON_MQ_MESSAGE
        (MESSAGE_ID,
         CONFIGURE_ID,
         BUSINESS_NAME,
         BUSINESS_CHARAC,
         BUSINESS_ID,
         MESSAGE_CONTENT,
         CREATION_DATE,
         LAST_UPDATE_DATE)
      VALUES
        (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
         SPM_MQ_CONFIGURE_ID('SPM_CON_MQ_BIDFEE'),
         'SPM_MQ_BIDFEE_SEND',
         'SPM_MQ_BIDFEE_SEND',
         V_ID,
         V_MSG,
         SYSDATE,
         SYSDATE);
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END BID_FEE_SEND;

  /*采购订单付款状态同步电商接口*/
  PROCEDURE SPM_CON_PAYMENT_STATUS(O_PAYMENT_ID IN VARCHAR2) IS
  
    ID_NUM            NUMBER;
    J                 INT := 1;
    V_CONFIGURE_ID    NUMBER(15);
    V_PAYMENT_ID      NUMBER(15);
    V_REPEAT_VALIDATE CHAR(1);
    V_JSON            CLOB;
    V_INVOICE_AMOUNT  NUMBER;
    V_CONTRACT_AMOUNT NUMBER;
    V_CONTRACT_CODE   VARCHAR2(100);
    V_CREATED_BY      NUMBER(15);
    V_CREATION_DATE   DATE;
    V_ORG_ID          NUMBER(15);
    V_DEPT_ID         NUMBER(15);
    V_CONTRACT_TYPE   NUMBER;
    CURSOR CU_DATA IS
      SELECT T.CONTRACT_ID
        FROM SPM_CON_PAYMENT_INVOICE S, SPM_CON_INPUT_INVOICE T
       WHERE S.PAYMENT_ID = V_PAYMENT_ID
         AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID
       GROUP BY T.CONTRACT_ID;
  BEGIN
  
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(O_PAYMENT_ID) - LENGTH(REPLACE(O_PAYMENT_ID, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(O_PAYMENT_ID, '[^,]+', 1, J))
        INTO V_PAYMENT_ID
        FROM DUAL;
      J := J + 1;
    
      --验证当前付款对应的订单是否全部付款完成
      BEGIN
        FOR V_CURROW IN CU_DATA LOOP
          BEGIN
            --验证当前合同是否为订单合同
            SELECT S.CONTRACT_TYPE
              INTO V_CONTRACT_TYPE
              FROM SPM_CON_HT_INFO S
             WHERE S.CONTRACT_ID = V_CURROW.CONTRACT_ID;
            IF V_CONTRACT_TYPE != 2 THEN
              CONTINUE;
            END IF;
          
            SELECT NVL(SUM(S.INVOICE_AMOUNT), 0)
              INTO V_INVOICE_AMOUNT
              FROM SPM_CON_INPUT_INVOICE   S,
                   SPM_CON_PAYMENT_INVOICE T,
                   SPM_CON_PAYMENT         PP
             WHERE 1 = 1
               AND S.CONTRACT_ID = V_CURROW.CONTRACT_ID
               AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID
               AND PP.PAYMENT_ID = T.PAYMENT_ID
               AND (PP.PAY_STATUS = 1 OR PP.PAY_STATUS = 2);
            SELECT NVL(S.CONTRACT_AMOUNT, 0),
                   S.CONTRACT_CODE,
                   S.CREATED_BY,
                   S.CREATION_DATE,
                   S.ORG_ID,
                   S.DEPT_ID
              INTO V_CONTRACT_AMOUNT,
                   V_CONTRACT_CODE,
                   V_CREATED_BY,
                   V_CREATION_DATE,
                   V_ORG_ID,
                   V_DEPT_ID
              FROM SPM_CON_HT_INFO S
             WHERE S.CONTRACT_ID = V_CURROW.CONTRACT_ID;
            --当前订单全部付款完成
            IF V_INVOICE_AMOUNT >= V_CONTRACT_AMOUNT THEN
              V_REPEAT_VALIDATE := SPM_MQ_REPEAT_VALIDATE('SPM_CON_HT_INFO',
                                                          'PAYMENT_STATUS',
                                                          V_CURROW.CONTRACT_ID);
              --验证订单信息是否在中间件消息表没有记录
              IF V_REPEAT_VALIDATE = 'Y' THEN
                V_CONFIGURE_ID := SPM_MQ_CONFIGURE_ID('SPM_CON_PRCHS_ORDER_PAYMENT_STATUS');
                V_JSON         := '{ "operationType":"insert" ,"contractCode":"' ||
                                  V_CONTRACT_CODE ||
                                  '","paymentStatus":"01"}';
                INSERT INTO SPM_CON_MQ_MESSAGE
                  (MESSAGE_ID,
                   CONFIGURE_ID,
                   BUSINESS_NAME,
                   BUSINESS_CHARAC,
                   BUSINESS_ID,
                   CREATED_BY,
                   CREATION_DATE,
                   ORG_ID,
                   DEPT_ID,
                   MESSAGE_CONTENT,
                   REMARK)
                VALUES
                  (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
                   V_CONFIGURE_ID,
                   'SPM_CON_HT_INFO',
                   'PAYMENT_STATUS',
                   V_CURROW.CONTRACT_ID,
                   V_CREATED_BY,
                   V_CREATION_DATE,
                   V_ORG_ID,
                   V_DEPT_ID,
                   V_JSON,
                   '采购订单付款状态同步');
                --更新订单付款状态
                UPDATE SPM_CON_HT_INFO S
                   SET S.PAY_IDENTIFY = 'ED'
                 WHERE S.CONTRACT_ID = V_CURROW.CONTRACT_ID;
              END IF;
            END IF;
            COMMIT;
          EXCEPTION
            WHEN OTHERS THEN
              DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
              DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
          END;
        END LOOP;
      END;
    END LOOP;
  END;

  /*采购订单发票信息同步电商接口*/
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
      (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
       V_CONFIGURE_ID,
       'SPM_CON_INPUT_INVOICE',
       'POINVOICESYNC',
       V_ID,
       V_MSG,
       V_CREATEDBY,
       V_CREATION_DATE,
       V_LAST_UPDATED_BY,
       V_LAST_UPDATE_DATE,
       V_LAST_UPDATE_LOGIN,
       V_ORG_ID,
       V_DEPT_ID,
       '采购订单发票信息同步');
    COMMIT;
    V_RETURN_CODE    := 'S';
    V_RETURN_MESSAGE := '插入中间表成功';
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '插入中间表出现异常，请联系管理员';
      RETURN;
  END;

  /*插入标书费*/
  PROCEDURE INSERT_TENDER_FEE(V_IDS         IN VARCHAR2,
                              V_RETURN_CODE OUT VARCHAR2,
                              V_RETURN_MSG  OUT VARCHAR2) IS
    IDS          SPM_TYPE_TBL;
    V_ID         VARCHAR2(40);
    V_CUST_ID    NUMBER;
    V_PROJECT_ID NUMBER;
    V_INVOICE_ID NUMBER(15);
    V_ITEM_ID    NUMBER(15);
    V_TAX_AMOUNT NUMBER;
    X_ERROR_MSG  VARCHAR2(4000);
    X_ORG_ID     NUMBER(15);
    X_USER_ID    NUMBER(15);
    X_DEPT_ID    NUMBER(15);
    V_COUNT      NUMBER;
  
    CURSOR CUR2(V_MQ_ID VARCHAR2) IS
    
      SELECT NVL(T.AMOUNT, 0) AMOUNT,
             T.INVOICE_TYPE,
             T.INVOICE_BANK_NAME,
             T.INVOICE_BANK_ACCOUNT,
             T.IDENTITY_NUMBER,
             T.INVOICE_ADDRESS,
             T.INVOICE_PHONE,
             T.PAY_ORDER_NO,
             T.PACKAGE_NO,
             T.PACKAGE_NAME,
             T.SUPPLIER,
             T.CREATE_TIME,
             T.FEE_CODE,
             T.AGENT_NAME,
             T.AGENT_CODE,
             T.MANAGER,
             T.MANAGER_CODE,
             TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS_BY_CODE(T.SUPPLIER_CODE)) V_CUST_ID,
             T.SUPPLIER_CODE
        FROM SPM_CON_MQ_TENDER_FEE T
       WHERE T.MQ_ID = V_MQ_ID;
    REC2 CUR2%ROWTYPE;
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
      
        UPDATE SPM_CON_MQ_TENDER_FEE M
           SET M.LAST_UPDATE_DATE = SYSDATE
         WHERE M.MQ_ID = IDS(I);
      
        OPEN CUR2(IDS(I));
        FETCH CUR2
          INTO REC2;
        CLOSE CUR2;
      
        V_ID := REC2.PAY_ORDER_NO;
      
        -- 获取组织、人员、部门信息
        GET_ODU_INFO(AGENT_CODE   => REC2.AGENT_CODE,
                     MANAGER      => REC2.MANAGER,
                     MANAGER_CODE => REC2.MANAGER_CODE,
                     V_ORG_ID     => X_ORG_ID,
                     V_USER_ID    => X_USER_ID,
                     V_DEPT_ID    => X_DEPT_ID);
      
        IF X_ORG_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取组织“' || REC2.AGENT_NAME || '（' ||
                           REC2.AGENT_CODE || '）”信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE ||
                           '）”信息：请先到【电商业财人员对照】模块维护对应关系';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE || '）”信息：用户代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE || '）”信息：用户姓名为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询“' || REC2.MANAGER || '（' ||
                           REC2.MANAGER_CODE || '）”在“' || REC2.AGENT_NAME || '（' ||
                           REC2.AGENT_CODE || '）”下的部门到息，请检查数据是否正确';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        UPDATE SPM_CON_MQ_TENDER_FEE T
           SET T.ORG_ID          = X_ORG_ID,
               T.DEPT_ID         = X_DEPT_ID,
               T.CREATED_BY      = X_USER_ID,
               T.LAST_UPDATED_BY = X_USER_ID
         WHERE T.MQ_ID = IDS(I);
      
        BEGIN
          -- 获取本组织无工程
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '无工程-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '本组织下无对应的无工程';
            /*IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '；';
            END IF;
            V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
          
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        IF REC2.V_CUST_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取客户“' || REC2.SUPPLIER || '（' ||
                           REC2.SUPPLIER_CODE || '）”数据失败：';
        
          IF REC2.V_CUST_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '电商中间表不存在该条记录，请联系电商推送数据';
          ELSIF REC2.V_CUST_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '尚未生成业务数据';
          ELSIF REC2.V_CUST_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '该客户未生效';
          ELSIF REC2.V_CUST_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '获取过程异常，请联系系统管理员';
          END IF;
        
          /*IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        SELECT COUNT(1)
          INTO V_COUNT
          FROM SPM_CON_OUTPUT_INVOICE O
         WHERE O.INVOICE_SERIAL_NUMBER = REC2.PAY_ORDER_NO;
        IF V_COUNT > 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '已存在号码为“' || REC2.PAY_ORDER_NO || '”的发票';
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        BEGIN
          V_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
          INSERT INTO SPM_CON_OUTPUT_INVOICE
            (OUTPUT_INVOICE_ID,
             INVOICE_AMOUNT,
             INVOICE_TYPE,
             INVOICE_CATEGORY,
             OPENING_BANK,
             BANK_ACCOUNT,
             TAXPAYER_ID_CODE,
             CUST_ADDRESS,
             TELEPHONE,
             CREATED_BY,
             ORG_ID,
             DEPT_ID,
             CREATION_DATE,
             LAST_UPDATE_DATE,
             INVOICE_SERIAL_NUMBER,
             PACKAGE_NO,
             PACKAGE_NAME,
             CUST_ID,
             STATUS,
             EBS_STATUS,
             EBS_TYPE,
             IS_DISCOUNT,
             COST_TYPE,
             NO_CONTRACT,
             INVOICE_SOURCE,
             INVOICE_BILL,
             OWNED_GROUP,
             PROJECT_ID,
             REMARK,
             DS_FLAG)
          VALUES
            (V_INVOICE_ID,
             REC2.AMOUNT,
             '主营业务结算',
             REC2.INVOICE_TYPE,
             REC2.INVOICE_BANK_NAME,
             REC2.INVOICE_BANK_ACCOUNT,
             REC2.SUPPLIER_CODE,
             REC2.INVOICE_ADDRESS,
             REC2.INVOICE_PHONE,
             X_USER_ID,
             X_ORG_ID,
             X_DEPT_ID,
             SYSDATE,
             SYSDATE,
             REC2.PAY_ORDER_NO,
             REC2.PACKAGE_NO,
             REC2.PACKAGE_NAME,
             REC2.V_CUST_ID,
             'E',
             'N',
             'INV',
             'N',
             'Y',
             'Y',
             '手工发票',
             '发票',
             1,
             V_PROJECT_ID,
             '标书费',
             'BS');
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '生成主表数据失败';
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        BEGIN
          V_ITEM_ID    := SPM_CON_OUTPUT_ITEM_SEQ.NEXTVAL;
          V_TAX_AMOUNT := REC2.AMOUNT / 1.06 * 0.06;
        
          INSERT INTO SPM_CON_OUTPUT_ITEM
            (OUTPUT_ITEM_ID,
             OUTPUT_INVOICE_ID,
             MATERIAL_CODE,
             ITEM_UNIT,
             ITEM_FORMAT,
             ITEM_AMOUNT,
             UNIT_PRICE,
             MONEY_AMOUNT,
             TAX_TATE,
             TAX_AMOUNT,
             CREATED_BY,
             CREATION_DATE,
             LAST_UPDATE_DATE,
             LAST_UPDATED_BY,
             ORG_ID,
             DEPT_ID,
             TAX_CODE)
          VALUES
            (V_ITEM_ID,
             V_INVOICE_ID,
             '标书费',
             '元',
             '标书费',
             1,
             REC2.AMOUNT,
             REC2.AMOUNT,
             6,
             ROUND(V_TAX_AMOUNT, 2),
             X_USER_ID,
             SYSDATE,
             SYSDATE,
             X_USER_ID,
             X_ORG_ID,
             X_DEPT_ID,
             REC2.FEE_CODE);
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '生成子表表数据失败';
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
          
            DELETE FROM SPM_CON_OUTPUT_INVOICE O
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            CONTINUE;
        END;
      
        BEGIN
          INSERT INTO SPM_CON_MONEY_REG
            (MONEY_REG_ID,
             SERIAL_NUMBER,
             CUST_ID,
             ACCOUNT_NAME,
             MONEY_ACCOUNT,
             RESIDUAL_AMOUNT,
             COLLECTION_DATE,
             CREATED_BY,
             ORG_ID,
             DEPT_ID,
             CREATION_DATE,
             LAST_UPDATE_DATE,
             REMARK)
          VALUES
            (SPM_CON_MONEY_REG_SEQ.NEXTVAL,
             REC2.PAY_ORDER_NO,
             REC2.V_CUST_ID,
             REC2.SUPPLIER,
             REC2.AMOUNT,
             0,
             REC2.CREATE_TIME,
             X_USER_ID,
             X_ORG_ID,
             X_DEPT_ID,
             SYSDATE,
             SYSDATE,
             '标书费');
        
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
          
            /*IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '；';
            END IF;
            V_RETURN_MSG := V_RETURN_MSG || V_ID || '生成到款数据异常';*/
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = '生成到款数据异常'
             WHERE T.MQ_ID = IDS(I);
          
            DELETE FROM SPM_CON_OUTPUT_INVOICE O
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            DELETE FROM SPM_CON_OUTPUT_ITEM I
             WHERE I.OUTPUT_ITEM_ID = V_ITEM_ID;
            CONTINUE;
        END;
      
        UPDATE SPM_CON_MQ_TENDER_FEE M
           SET M.GENERATE_FLAG = 'Y', M.ERROR_MESSAGE = ''
         WHERE M.MQ_ID = IDS(I);
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
        
          /*IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '生成发票数据异常';*/
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = '过程执行异常'
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      V_RETURN_CODE := 'S';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行异常';
  END INSERT_TENDER_FEE;

  /*退保证金审批电商接口*/
  PROCEDURE SPM_CON_MARGIN_APPROVAL(O_INPUT_INVOICE_ID IN NUMBER,
                                    O_INVOICE_CODE     IN VARCHAR2,
                                    O_AUDIT_STATUS     IN VARCHAR2,
                                    O_AUDIT_INFO       IN VARCHAR2,
                                    O_CREATED_BY       IN NUMBER,
                                    O_CREATION_DATE    IN DATE,
                                    O_ORG_ID           IN NUMBER,
                                    O_DEPT_ID          IN NUMBER) IS
    V_CONFIGURE_ID NUMBER(15);
    /*V_REPEAT_VALIDATE CHAR;*/
    V_JSON            CLOB;
    V_BUSINESS_CHARAC VARCHAR2(20);
  BEGIN
  
    --标志审批通过还是驳回
    IF O_AUDIT_STATUS = '01' THEN
      V_BUSINESS_CHARAC := 'MARGIN_TG';
    ELSIF O_AUDIT_STATUS = '02' THEN
      V_BUSINESS_CHARAC := 'MARGIN_BH';
    ELSE
      RETURN;
    END IF;
  
    /*V_REPEAT_VALIDATE := SPM_MQ_REPEAT_VALIDATE('SPM_CON_INPUT_INVOICE',
    V_BUSINESS_CHARAC,
    O_INPUT_INVOICE_ID);*/
    /*--验证退保证金信息是否在中间件消息表没有记录
    IF V_REPEAT_VALIDATE = 'Y' THEN*/
  
    V_CONFIGURE_ID := SPM_MQ_CONFIGURE_ID('SPM_CON_MARGIN_APPROVAL');
  
    V_JSON := '{ "transNumber":"' || O_INVOICE_CODE || '" ,"auditStatus":"' ||
              O_AUDIT_STATUS || '","auditReason":"' || O_AUDIT_INFO || '"}';
    INSERT INTO SPM_CON_MQ_MESSAGE
      (MESSAGE_ID,
       CONFIGURE_ID,
       BUSINESS_NAME,
       BUSINESS_CHARAC,
       BUSINESS_ID,
       CREATED_BY,
       CREATION_DATE,
       ORG_ID,
       DEPT_ID,
       MESSAGE_CONTENT,
       REMARK)
    VALUES
      (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
       V_CONFIGURE_ID,
       'SPM_CON_INPUT_INVOICE',
       V_BUSINESS_CHARAC,
       O_INPUT_INVOICE_ID,
       O_CREATED_BY,
       O_CREATION_DATE,
       O_ORG_ID,
       O_DEPT_ID,
       V_JSON,
       '退保证金审批接口');
    /*END IF;*/
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
  END;

  /*订单取消接口*/
  PROCEDURE ORDER_CANCEL(V_CODE IN VARCHAR2) IS
    IS_EXISTS NUMBER;
  BEGIN
    UPDATE SPM_CON_HT_INFO H
       SET H.STATUS = 'IZ'
     WHERE H.CONTRACT_CODE IN (V_CODE, V_CODE || '-1');
  
    SELECT COUNT(1)
      INTO IS_EXISTS
      FROM SPM_CON_HT_INFO H
     WHERE H.CONTRACT_CODE IN (V_CODE, V_CODE || '-1');
  
    -- 若查询有一对订单，则赋值状态已取消
    IF IS_EXISTS = 2 THEN
      UPDATE SPM_CON_MQ_ORDER_CANCEL C
         SET C.ATTRIBUTE1 = 'C'
       WHERE C.ATTRIBUTE1 IS NULL
         AND C.ORDER_CODE = V_CODE;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END ORDER_CANCEL;

  /*批量订单取消接口*/
  PROCEDURE BATCH_ORDER_CANCEL IS
    IS_EXISTS NUMBER;
    V_CODE    VARCHAR2(200);
  
    CURSOR CUR1 IS
      SELECT C.ORDER_CODE
        FROM SPM_CON_MQ_ORDER_CANCEL C
       WHERE C.ATTRIBUTE1 IS NULL;
  BEGIN
    OPEN CUR1;
    FETCH CUR1
      INTO V_CODE;
    WHILE CUR1%FOUND LOOP
      UPDATE SPM_CON_HT_INFO H
         SET H.STATUS = 'IZ'
       WHERE H.CONTRACT_CODE IN (V_CODE, V_CODE || '-1');
    
      SELECT COUNT(1)
        INTO IS_EXISTS
        FROM SPM_CON_HT_INFO H
       WHERE H.CONTRACT_CODE IN (V_CODE, V_CODE || '-1')
         AND H.STATUS = 'IZ';
    
      -- 若查询有一对订单，则赋值状态已取消
      IF IS_EXISTS = 2 THEN
        UPDATE SPM_CON_MQ_ORDER_CANCEL C
           SET C.ATTRIBUTE1 = 'C'
         WHERE C.ATTRIBUTE1 IS NULL
           AND C.ORDER_CODE = V_CODE;
      END IF;
    
      FETCH CUR1
        INTO V_CODE;
    END LOOP;
    CLOSE CUR1;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END BATCH_ORDER_CANCEL;

  --电商退保证金申请
  PROCEDURE SPM_CON_MQ_PAYMENTMARGIN(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2) IS
    IDS                    SPM_TYPE_TBL;
    V_COUNT                NUMBER;
    V_ID                   NUMBER;
    V_TRANS_NUMBER         VARCHAR2(200);
    V_PAYMENT_ID           NUMBER(15);
    V_OPERATE_TYPE         VARCHAR2(10);
    X_ERROR_MSG            VARCHAR2(4000);
    X_ORG_ID               NUMBER(15);
    X_USER_ID              NUMBER(15);
    X_DEPT_ID              NUMBER(15);
    PAY_BANK_ACCOUNT_ID    NUMBER;
    V_CAPITAL_ID           NUMBER(15);
    SPM_CON_PAYMENT_INFO   SPM_CON_PAYMENT%ROWTYPE;
    MQ_PAYMENT_MARGIN_INFO SPM_CON_MQ_PAYMENT_MARGIN%ROWTYPE;
    INPUT_INVOICE_INFO     SPM_CON_INPUT_INVOICE%ROWTYPE;
    CAPITAL_PLAN_INFO      SPM_CON_CAPITAL_PLAN%ROWTYPE;
  
    V_SERIAL_CODE VARCHAR2(200); --流水号
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
      
        UPDATE SPM_CON_MQ_PAYMENT_MARGIN M
           SET M.LAST_UPDATE_DATE = SYSDATE
         WHERE M.MQ_ID = IDS(I);
      
        SELECT *
          INTO MQ_PAYMENT_MARGIN_INFO
          FROM SPM_CON_MQ_PAYMENT_MARGIN S
         WHERE S.MQ_ID = IDS(I);
      
        BEGIN
          SELECT *
            INTO INPUT_INVOICE_INFO
            FROM SPM_CON_INPUT_INVOICE T
           WHERE T.INVOICE_CODE = MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER
             AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                             '未匹配到对应保证金';
            -- 拼接提示信息
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        SELECT COUNT(1)
          INTO V_COUNT
          FROM SPM_CON_PAYMENT         P,
               SPM_CON_PAYMENT_INVOICE T,
               SPM_CON_INPUT_INVOICE   I
         WHERE P.PAYMENT_ID = T.PAYMENT_ID
           AND T.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
           AND I.RESIDUAL_AMOUNT <= 0 
           AND I.INVOICE_CODE = MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
        IF V_COUNT <> 0 THEN
          SELECT P.PAYMENT_CODE
            INTO X_ERROR_MSG
            FROM SPM_CON_PAYMENT         P,
                 SPM_CON_PAYMENT_INVOICE T,
                 SPM_CON_INPUT_INVOICE   I
           WHERE P.PAYMENT_ID = T.PAYMENT_ID
             AND T.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
             AND I.INVOICE_CODE = MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
        
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '已生成关联保证金为' ||
                           MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                           '的付款数据，关联付款单号为：' || X_ERROR_MSG;
          -- 拼接提示信息
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        SELECT NVL(I.RESIDUAL_AMOUNT, 0) -
               NVL(MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT, 0)
          INTO V_COUNT
          FROM SPM_CON_INPUT_INVOICE I
         WHERE I.INPUT_INVOICE_ID = INPUT_INVOICE_INFO.INPUT_INVOICE_ID;
        IF V_COUNT < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '保证金' || MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                           '剩余金额不足';
          -- 拼接提示信息
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        V_TRANS_NUMBER := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
        V_OPERATE_TYPE := MQ_PAYMENT_MARGIN_INFO.OPERATE_TYPE;
      
        -- 获取组织、人员、部门信息
        GET_ODU_INFO(AGENT_CODE      => MQ_PAYMENT_MARGIN_INFO.AGENT_CODE,
                     MANAGER         => MQ_PAYMENT_MARGIN_INFO.MANAGER,
                     MANAGER_CODE    => MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE,
                     DEPARTMENT      => MQ_PAYMENT_MARGIN_INFO.DEPARTMENT,
                     DEPARTMENT_CODE => MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE,
                     V_ORG_ID        => X_ORG_ID,
                     V_USER_ID       => X_USER_ID,
                     V_DEPT_ID       => X_DEPT_ID);
      
        IF X_ORG_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取组织“' || MQ_PAYMENT_MARGIN_INFO.AGENT_NAME || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.AGENT_CODE ||
                           '）”信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '）”信息：请先到【电商业财人员对照】模块维护对应关系';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '）”信息：用户代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到人员“' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '）”信息：用户姓名为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '）”信息：请联系系统管理员';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '）”信息：部门代码为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未查询到部门“' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '（' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '）”信息，部门名称为空，请联系电商核对';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
           SET T.ORG_ID          = X_ORG_ID,
               T.DEPT_ID         = X_DEPT_ID,
               T.CREATED_BY      = X_USER_ID,
               T.LAST_UPDATED_BY = X_USER_ID
         WHERE T.MQ_ID = IDS(I);
      
        BEGIN
          IF V_OPERATE_TYPE = 'insert' THEN
          
            BEGIN
              --获取付款账号ID
              SELECT A.BANK_ACCOUNT_ID
                INTO PAY_BANK_ACCOUNT_ID
                FROM CE.CE_BANK_ACCOUNTS A
               INNER JOIN CE.CE_BANK_ACCT_USES_ALL U
                  ON A.BANK_ACCOUNT_ID = U.BANK_ACCOUNT_ID
               WHERE A.END_DATE IS NULL
                 AND U.END_DATE IS NULL
                 AND U.ORG_ID = X_ORG_ID
                 AND A.MASKED_ACCOUNT_NUM =
                     (SELECT S.BANK_SEC
                        FROM SPM_CON_INPUT_WAREHOUSE S
                       WHERE S.INPUT_INVOICE_ID =
                             INPUT_INVOICE_INFO.INPUT_INVOICE_ID
                         AND ROWNUM = 1);
            EXCEPTION
              WHEN OTHERS THEN
                V_RETURN_CODE := 'F';
                X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                                 '获取付款账号失败';
                -- 拼接提示信息
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            -- 获取资金计划主键
            BEGIN
              SELECT SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(X_DEPT_ID)
                INTO V_CAPITAL_ID
                FROM DUAL;
            
              SELECT *
                INTO CAPITAL_PLAN_INFO
                FROM SPM_CON_CAPITAL_PLAN C
               WHERE C.CAPITAL_ID = V_CAPITAL_ID;
            EXCEPTION
              WHEN OTHERS THEN
                V_RETURN_CODE := 'F';
                X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                                 '获取资金计划信息失败';
                -- 拼接提示信息
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            -- 获取对应付款流水号
            BEGIN
              SELECT CREATE_SERIAL_CODE_UTIL('SPM_CON_PAYMENT_CODE_JT',
                                             'SPM_CON_PAYMENT',
                                             'PAYMENT_CODE',
                                             'FM000000',
                                             X_USER_ID,
                                             X_ORG_ID)
                INTO V_SERIAL_CODE
                FROM DUAL;
              IF V_SERIAL_CODE = '00' THEN
                V_RETURN_CODE := 'F';
                X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                                 '生成退保证金流水号失败';
                -- 拼接提示信息
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
              END IF;
            
            EXCEPTION
              WHEN OTHERS THEN
                V_RETURN_CODE := 'F';
                X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                                 '生成退保证金流水号失败';
                -- 拼接提示信息
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            SELECT SPM_CON_PAYMENT_SEQ.NEXTVAL INTO V_PAYMENT_ID FROM DUAL;
          
            --生成付款-发票关联关系                  
            INSERT INTO SPM_CON_PAYMENT_INVOICE
              (PAYMENT_INVOICE_ID,
               PAYMENT_ID,
               INPUT_INVOICE_ID,
               MONEY_AMOUNT,
               CREATED_BY,
               CREATION_DATE,
               ORG_ID,
               DEPT_ID)
            VALUES
              (SPM_CON_PAYMENT_INVOICE_SEQ.NEXTVAL,
               V_PAYMENT_ID,
               INPUT_INVOICE_INFO.INPUT_INVOICE_ID,
               MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT,
               X_USER_ID,
               SYSDATE,
               X_ORG_ID,
               X_DEPT_ID);
            --核销发票，更新发票信息
            UPDATE SPM_CON_INPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT =
                   (NVL(I.RESIDUAL_AMOUNT, 0) -
                   NVL(MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT, 0))
             WHERE I.INPUT_INVOICE_ID = INPUT_INVOICE_INFO.INPUT_INVOICE_ID;
          
            -- 付款单主键  
            SPM_CON_PAYMENT_INFO.PAYMENT_ID := V_PAYMENT_ID;
            -- 付款来源：电商
            SPM_CON_PAYMENT_INFO.PAYMENT_SOURCE := 'DS';
            -- 资金计划付款
            SPM_CON_PAYMENT_INFO.PLAN_FLAG := 'Y';
            -- 上会
            SPM_CON_PAYMENT_INFO.IS_MEETING  := 'N';
            SPM_CON_PAYMENT_INFO.HAS_MEETING := 'N';
            -- 垫资
            SPM_CON_PAYMENT_INFO.WEATHER_DZ := 'N';
            -- 收款单位ID                                   
            SPM_CON_PAYMENT_INFO.VENDOR_ID := INPUT_INVOICE_INFO.VENDOR_ID;
            --  项目id 
            SPM_CON_PAYMENT_INFO.PROJECT_ID := INPUT_INVOICE_INFO.PROJECT_ID;
            --  付款单号 
            SPM_CON_PAYMENT_INFO.PAYMENT_CODE := V_SERIAL_CODE;
            -- 第三系统标识
            SPM_CON_PAYMENT_INFO.OTHERS_SYSTEM_CODE := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
            --  供应商地点 
            SPM_CON_PAYMENT_INFO.VENDOR_SITE_ID := INPUT_INVOICE_INFO.VENDOR_SITE_ID;
            --  付款用途 
            SPM_CON_PAYMENT_INFO.PAY_PURPOSE := '51';
            --  付款类别 
            SPM_CON_PAYMENT_INFO.PAY_CATEGORY := '7';
            --  现金流 
            SPM_CON_PAYMENT_INFO.CASH_FLOW_ID := '124';
            --  付款银行账户 
            SPM_CON_PAYMENT_INFO.PAY_BANK_ACCOUNT_ID := PAY_BANK_ACCOUNT_ID;
            --  申请付款金额 
            SPM_CON_PAYMENT_INFO.MONEY_AMOUNT := MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT;
            --  开户行名称 
            SPM_CON_PAYMENT_INFO.BANK_NAME := INPUT_INVOICE_INFO.OPENING_BANK;
            --  收款方账号 
            SPM_CON_PAYMENT_INFO.BANK_ACCOUNT_NUM := INPUT_INVOICE_INFO.BANK_ACCOUNT;
            --  付款日期 
            SPM_CON_PAYMENT_INFO.PAY_DATE := MQ_PAYMENT_MARGIN_INFO.APPLY_TIME;
            --  付款币种 
            SPM_CON_PAYMENT_INFO.CURRENCY_TYPE := INPUT_INVOICE_INFO.CURRENCY_TYPE;
            --  资金使用项目 
            SPM_CON_PAYMENT_INFO.MATCH_PROJECT := INPUT_INVOICE_INFO.MATCH_PROJECT;
            --填摘要
            SPM_CON_PAYMENT_INFO.REMARK := INPUT_INVOICE_INFO.REMARK;
            --  所属机构id 
            SPM_CON_PAYMENT_INFO.ORG_ID := X_ORG_ID;
            --  经办人 
            SPM_CON_PAYMENT_INFO.CREATED_BY := X_USER_ID;
            --  申请时间 
            SPM_CON_PAYMENT_INFO.CREATION_DATE := SYSDATE;
            --  修改时间 
            SPM_CON_PAYMENT_INFO.LAST_UPDATE_DATE := SYSDATE;
            --  所属部门id 
            SPM_CON_PAYMENT_INFO.DEPT_ID := X_DEPT_ID;
            --  核算部门 
            SPM_CON_PAYMENT_INFO.EBS_DEPT_CODE := INPUT_INVOICE_INFO.EBS_DEPT_CODE;
            --  资金使用部门
            SPM_CON_PAYMENT_INFO.MATCH_DEPT := INPUT_INVOICE_INFO.MATCH_DEPT;
            -- 审批状态
            SPM_CON_PAYMENT_INFO.STATUS := 'A';
            -- 同步状态
            SPM_CON_PAYMENT_INFO.EBS_STATUS := 'N';
            -- 付款状态
            SPM_CON_PAYMENT_INFO.PAY_STATUS := '0';
            -- 付款方法 
            SPM_CON_PAYMENT_INFO.PAY_METHODS := 'WIRE';
            -- 汇率类型
            SPM_CON_PAYMENT_INFO.EXCHANGE_TYPE := 'User';
            -- 汇率时间
            SPM_CON_PAYMENT_INFO.EXCHANGE_DATE := SYSDATE;
            -- 资金计划信息
            SPM_CON_PAYMENT_INFO.MONTH_DETAIL_ID    := CAPITAL_PLAN_INFO.CAPITAL_ID;
            SPM_CON_PAYMENT_INFO.THIS_MONTH_BALANCE := CAPITAL_PLAN_INFO.THIS_MONTH_BALANCE;
            -- 退保证金标识
            SPM_CON_PAYMENT_INFO.ATTRIBUTE5 := 'BZJ';
          
            --生成付款单信息
            INSERT INTO SPM_CON_PAYMENT VALUES SPM_CON_PAYMENT_INFO;
            --标志该消息已被消费
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN S
               SET S.GENERATE_FLAG = 'Y'
             WHERE S.MQ_ID = IDS(I);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                             '生成付款数据异常，请联系系统管理员';
            -- 拼接提示信息
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        BEGIN
          IF V_OPERATE_TYPE = 'update' THEN
          
            SELECT T.PAYMENT_ID
              INTO V_PAYMENT_ID
              FROM SPM_CON_INPUT_INVOICE S, SPM_CON_PAYMENT_INVOICE T
             WHERE S.INVOICE_CODE = V_TRANS_NUMBER
               AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID
               AND ROWNUM = 1;
            --更新付款单字段
            UPDATE SPM_CON_PAYMENT S
               SET S.PACKAGE_NO   = MQ_PAYMENT_MARGIN_INFO.PACKAGE_NO,
                   S.PACKAGE_NAME = MQ_PAYMENT_MARGIN_INFO.PACKAGE_NAME,
                   S.MONEY_AMOUNT = MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT,
                   S.PAY_DATE     = MQ_PAYMENT_MARGIN_INFO.APPLY_TIME
             WHERE S.PAYMENT_ID = V_PAYMENT_ID;
            --标志该消息已被消费
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN S
               SET S.GENERATE_FLAG = 'Y', S.ERROR_MESSAGE = ''
             WHERE S.MQ_ID = V_ID;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                             '更新付款单异常，请联系系统管理员';
            -- 拼接提示信息
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '程序异常，请联系系统管理员';
          -- 拼接提示信息
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
  END;

  /*获取ou、人员、部门信息*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE   IN VARCHAR2,
                         MANAGER      IN VARCHAR2,
                         MANAGER_CODE IN VARCHAR2,
                         V_ORG_ID     OUT NUMBER,
                         V_USER_ID    OUT NUMBER,
                         V_DEPT_ID    OUT NUMBER) IS
    V_COUNT NUMBER;
  BEGIN
    -- 获取OU
    BEGIN
      SELECT TO_NUMBER(H.ORGANIZATION_ID)
        INTO V_ORG_ID
        FROM HR_OPERATING_UNITS H
       WHERE H.SHORT_CODE = AGENT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_ORG_ID := NULL;
    END;
  
    -- 获取人员
    BEGIN
      SELECT TO_NUMBER(T.YC_CODE)
        INTO V_USER_ID
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'user'
         AND T.DS_CODE = MANAGER_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_USER_ID := NULL;
    END;
  
    -- Code为空返回-1
    IF MANAGER_CODE IS NULL THEN
      V_USER_ID := -1;
    END IF;
    -- 姓名为空返回-2
    IF MANAGER IS NULL THEN
      V_USER_ID := -2;
    END IF;
  
    -- 获取不到userId时插入对照表数据
    IF V_USER_ID IS NULL THEN
      SELECT COUNT(1)
        INTO V_COUNT
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'user'
         AND T.DS_CODE = MANAGER_CODE;
      IF V_COUNT = 0 THEN
        BEGIN
          INSERT INTO SPM_CON_VENDOR_COMPARE
            (COMPARE_ID, FIELD_NAME, DS_NAME, DS_CODE)
          VALUES
            (SPM_CON_VENDOR_COMPARE_SEQ.NEXTVAL,
             'user',
             MANAGER,
             MANAGER_CODE);
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('错误代码：' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('错误信息：' || SQLERRM);
        END;
      END IF;
    END IF;
  
    -- 获取部门
    BEGIN
      IF V_USER_ID IS NOT NULL AND V_ORG_ID IS NOT NULL THEN
        SELECT T.ORGANIZATION_ID
          INTO V_DEPT_ID
          FROM SPM_CON_HT_PEOPLE_V T
         WHERE ROWNUM < 2
           AND T.BELONGORGID = V_ORG_ID
           AND T.PERSON_ID =
               SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(V_USER_ID);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        V_DEPT_ID := NULL;
    END;
  END GET_ODU_INFO;

  /*获取ou、人员、部门信息*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE      IN VARCHAR2,
                         MANAGER         IN VARCHAR2,
                         MANAGER_CODE    IN VARCHAR2,
                         DEPARTMENT      IN VARCHAR2,
                         DEPARTMENT_CODE IN VARCHAR2,
                         V_ORG_ID        OUT NUMBER,
                         V_USER_ID       OUT NUMBER,
                         V_DEPT_ID       OUT NUMBER) IS
    V_COUNT NUMBER;
  BEGIN
    -- 获取OU
    BEGIN
      SELECT TO_NUMBER(H.ORGANIZATION_ID)
        INTO V_ORG_ID
        FROM HR_OPERATING_UNITS H
       WHERE H.SHORT_CODE = AGENT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_ORG_ID := NULL;
    END;
  
    -- 获取部门
    BEGIN
      SELECT TO_NUMBER(T.YC_CODE)
        INTO V_DEPT_ID
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'dept'
         AND T.DS_CODE = DEPARTMENT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_DEPT_ID := NULL;
    END;
  
    -- Code为空返回-1
    IF DEPARTMENT_CODE IS NULL THEN
      V_DEPT_ID := -1;
    END IF;
    -- 部门为空返回-2
    /*IF DEPARTMENT IS NULL THEN
      V_DEPT_ID := -2;
    END IF;*/
  
    -- 获取不到userId时插入对照表数据
    IF V_DEPT_ID IS NULL THEN
      SELECT COUNT(1)
        INTO V_COUNT
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'dept'
         AND T.DS_CODE = MANAGER_CODE;
      IF V_COUNT = 0 THEN
        BEGIN
          INSERT INTO SPM_CON_VENDOR_COMPARE
            (COMPARE_ID, FIELD_NAME, DS_NAME, DS_CODE)
          VALUES
            (SPM_CON_VENDOR_COMPARE_SEQ.NEXTVAL,
             'dept',
             DEPARTMENT,
             DEPARTMENT_CODE);
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('错误代码：' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('错误信息：' || SQLERRM);
        END;
      END IF;
    END IF;
  
    -- 获取人员
    BEGIN
      SELECT TO_NUMBER(T.YC_CODE)
        INTO V_USER_ID
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'user'
         AND T.DS_CODE = MANAGER_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_USER_ID := NULL;
    END;
  
    -- Code为空返回-1
    IF MANAGER_CODE IS NULL THEN
      V_USER_ID := -1;
    END IF;
    -- 姓名为空返回-2
    IF MANAGER IS NULL THEN
      V_USER_ID := -2;
    END IF;
  
    -- 获取不到userId时插入对照表数据
    IF V_USER_ID IS NULL THEN
      SELECT COUNT(1)
        INTO V_COUNT
        FROM SPM_CON_VENDOR_COMPARE T
       WHERE T.FIELD_NAME = 'user'
         AND T.DS_CODE = MANAGER_CODE;
      IF V_COUNT = 0 THEN
        BEGIN
          INSERT INTO SPM_CON_VENDOR_COMPARE
            (COMPARE_ID, FIELD_NAME, DS_NAME, DS_CODE)
          VALUES
            (SPM_CON_VENDOR_COMPARE_SEQ.NEXTVAL,
             'user',
             MANAGER,
             MANAGER_CODE);
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('错误代码：' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('错误信息：' || SQLERRM);
        END;
      END IF;
    END IF;
  END GET_ODU_INFO;

  --收款电商接口（预存款收款信息同步、销售订单收款状态同步）
  PROCEDURE SPM_CON_MONEY_RECEIPT(V_ID IN VARCHAR2) IS
  
    V_OPERATION_TYPE  VARCHAR2(40) := 'insert';
    V_SERIAL_NUMBER   VARCHAR2(40);
    V_REMARK          VARCHAR2(400);
    V_ORG_ID          NUMBER(15);
    V_CUST_ID         NUMBER(15);
    V_COLLECTION_DATE VARCHAR2(40);
    V_ACCOUNT_NAME    VARCHAR2(200);
    V_PAYMENT_ACCOUNT VARCHAR2(40);
    V_MONEY_ACCOUNT   NUMBER;
    V_RECEIPT_NAME    VARCHAR2(200);
    V_RECEIPT_ACCOUNT VARCHAR2(40);
    V_DEPOSIT_BANK    VARCHAR2(400);
    V_CONTRACT_FORM   VARCHAR2(40);
    V_JSON            CLOB;
    V_RECEIPT_ID      NUMBER(15);
    V_RECEIPT_TYPE    VARCHAR2(40);
    V_CONTRACT_TYPE   NUMBER;
    V_RMB_TOTAL       NUMBER;
    V_CONTRACT_ID     NUMBER(15);
    V_REG_MONEY       NUMBER;
    V_CONTRACT_CODE   VARCHAR2(100);
    V_MONEY_REG_ID    NUMBER(15);
  
    O_ORG_ID    NUMBER;
    O_ORG_CODE  VARCHAR2(400);
    O_ORG_NAME  VARCHAR2(400);
    O_CUST_ID   NUMBER;
    O_CUST_CODE VARCHAR2(400);
    O_CUST_NAME VARCHAR2(400);
    O_STUTAS    VARCHAR2(40);
  
    V_REPEAT_VALIDATE CHAR;
    V_CONFIGURE_ID    NUMBER(15);
  
    V_CREATED_BY    NUMBER(15);
    V_CREATION_DATE DATE;
    V_DEPT_ID       NUMBER(15);
    V_NUMBER        NUMBER;
    P_DATA_TYPE     VARCHAR2(40);
    IDS           SPM_TYPE_TBL;
  BEGIN
    
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_ID) INTO IDS FROM DUAL;
    
     --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      
        SELECT A.SERIAL_NUMBER,
           A.REMARK,
           A.ORG_ID,
           A.CUST_ID,
           TO_CHAR(A.COLLECTION_DATE, 'YYYY-MM-DD HH:MI:SS'),
           A.ACCOUNT_NAME,
           A.PAYMENT_ACCOUNT,
           A.MONEY_ACCOUNT,
           A.RECEIPT_NAME,
           A.RECEIPT_ACCOUNT,
           A.DEPOSIT_BANK,
           T.CONTRACT_FORM,
           S.RECEIPT_ID,
           S.CREATED_BY,
           S.CREATION_DATE,
           A.DEPT_ID,
           S.RECEIPT_TYPE,
           T.CONTRACT_TYPE,
           T.RMB_TOTAL,
           S.CONTRACT_ID,
           T.CONTRACT_CODE,
           A.MONEY_REG_ID,
           NVL(S.DATA_TYPE, 'YW')
           
      INTO V_SERIAL_NUMBER,
           V_REMARK,
           V_ORG_ID,
           V_CUST_ID,
           V_COLLECTION_DATE,
           V_ACCOUNT_NAME,
           V_PAYMENT_ACCOUNT,
           V_MONEY_ACCOUNT,
           V_RECEIPT_NAME,
           V_RECEIPT_ACCOUNT,
           V_DEPOSIT_BANK,
           V_CONTRACT_FORM,
           V_RECEIPT_ID,
           V_CREATED_BY,
           V_CREATION_DATE,
           V_DEPT_ID,
           V_RECEIPT_TYPE,
           V_CONTRACT_TYPE,
           V_RMB_TOTAL,
           V_CONTRACT_ID,
           V_CONTRACT_CODE,
           V_MONEY_REG_ID,
           P_DATA_TYPE
      FROM SPM_CON_RECEIPT S, SPM_CON_HT_INFO T, SPM_CON_MONEY_REG A
     WHERE S.RECEIPT_ID = IDS(I)
       AND S.MONEY_REG_ID = A.MONEY_REG_ID
       AND S.CONTRACT_ID = T.CONTRACT_ID;

   --如果不是业务收款，直接跳出
   IF P_DATA_TYPE <> 'YW' THEN
      CONTINUE;
   END IF;
  
    --转换为电商中间商信息
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM SPM_CON_MQ_CUST T, HR_OPERATING_UNITS S
     WHERE S.ORGANIZATION_ID = V_ORG_ID
       AND S.SHORT_CODE = T.ORG_CODE
       AND ROWNUM = 1;
    IF V_NUMBER <> 1 THEN
      O_ORG_ID   := '00';
      O_ORG_CODE := '00';
      O_ORG_NAME := '00';
    ELSE
      SELECT T.ID, T.ORG_CODE, T.ORG_NAME
        INTO O_ORG_ID, O_ORG_CODE, O_ORG_NAME
        FROM SPM_CON_MQ_CUST T, HR_OPERATING_UNITS S
       WHERE S.ORGANIZATION_ID = V_ORG_ID
         AND S.SHORT_CODE = T.ORG_CODE
         AND ROWNUM = 1;
    END IF;
  
    --转换为电商电厂信息  
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM SPM_CON_MQ_CUST T, SPM_CON_CUST_INFO S
     WHERE S.CUST_ID = V_CUST_ID
       AND S.CUST_CODE = T.THREE_CERTIFICATES
       AND ROWNUM = 1;
    IF V_NUMBER <> 1 THEN
      O_CUST_ID   := '00';
      O_CUST_CODE := '00';
      O_CUST_NAME := '00';
    ELSE
      SELECT T.ID, T.ORG_CODE, T.ORG_NAME
        INTO O_CUST_ID, O_CUST_CODE, O_CUST_NAME
        FROM SPM_CON_MQ_CUST T, SPM_CON_CUST_INFO S
       WHERE S.CUST_ID = V_CUST_ID
         AND S.CUST_CODE = T.THREE_CERTIFICATES
         AND ROWNUM = 1;
    END IF;
  
    BEGIN
      --认领为预收款，并与某个销售框架合同关联
      IF V_CONTRACT_FORM = 4 AND V_RECEIPT_TYPE IN ('A', '预收款') THEN
      
        IF O_CUST_ID > 0 THEN
          --找到客户才向电商发送 
        
          V_REPEAT_VALIDATE := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_RECEIPT',
                                                                     'PREDEPOSIT_RECEIVE',
                                                                     V_RECEIPT_ID);
          IF V_REPEAT_VALIDATE = 'Y' THEN
            V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('SPM_CON_PREDEPOSIT_RECEIVE');
          
            V_JSON := '{ "operationType":"' || V_OPERATION_TYPE ||
                      '" ,"serialNumber":"' || V_SERIAL_NUMBER ||
                      '","remark":"' || V_REMARK || '","regId":"' ||
                      O_ORG_ID || '","regCode":"' || O_ORG_CODE ||
                      '","regName":"' || O_ORG_NAME || '","payId":"' ||
                      O_CUST_ID || '","payCode":"' || O_CUST_CODE ||
                      '","payName":"' || O_CUST_NAME ||
                      '","collectionDate":"' || V_COLLECTION_DATE ||
                      '","accountName":"' || V_ACCOUNT_NAME ||
                      '","paymentAccount":"' || V_PAYMENT_ACCOUNT ||
                      '","moneyAccount":"' || V_MONEY_ACCOUNT ||
                      '","receiptName":"' || V_RECEIPT_NAME ||
                      '","receiptAccount":"' || V_RECEIPT_ACCOUNT ||
                      '","depositBank":"' || V_DEPOSIT_BANK || '"}';
          
            INSERT INTO SPM_CON_MQ_MESSAGE
              (MESSAGE_ID,
               CONFIGURE_ID,
               BUSINESS_NAME,
               BUSINESS_CHARAC,
               BUSINESS_ID,
               CREATED_BY,
               CREATION_DATE,
               ORG_ID,
               DEPT_ID,
               MESSAGE_CONTENT,
               REMARK)
            VALUES
              (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
               V_CONFIGURE_ID,
               'SPM_CON_RECEIPT',
               'PREDEPOSIT_RECEIVE',
               V_RECEIPT_ID,
               V_CREATED_BY,
               V_CREATION_DATE,
               V_ORG_ID,
               V_DEPT_ID,
               V_JSON,
               '预存款收款信息同步');
          
            --推送成功后给收款单加标识
            UPDATE SPM_CON_RECEIPT T
               SET T.EBS_STATUS = 'OR'
             WHERE T.RECEIPT_ID = V_RECEIPT_ID
             AND NOT EXISTS
             (SELECT 1
                      FROM AR_CASH_RECEIPTS_ALL ARA
                     WHERE ARA.RECEIPT_NUMBER = T.RECEIPT_CODE);
          
          END IF;
        
        ELSE
          --否则只是在信息表中留存一条数据记录以供客户查看
          INSERT INTO SPM_CON_MQ_MESSAGE
            (MESSAGE_ID, SEND_STATUS, BUSINESS_ID, ORG_ID, REMARK)
          VALUES
            (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
             'Y',
             V_RECEIPT_ID,
             V_ORG_ID,
             '预存款失败');
        END IF;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
    END;
  
    --认领为某个订单的到款
    BEGIN
      IF V_RECEIPT_TYPE IN ('B', '预收款') AND V_CONTRACT_TYPE = 2 THEN
      
        --验证带订单的到款是否已经推送电商 
        SELECT COUNT(*)
          INTO V_NUMBER
          FROM SPM_CON_MQ_MESSAGE S
         WHERE S.BUSINESS_NAME = 'SPM_CON_MONEY_REG'
           AND S.BUSINESS_CHARAC = 'ORDER_RECIVE_STATUS'
           AND S.BUSINESS_ID = V_RECEIPT_ID;
      
        IF V_NUMBER <> 0 THEN
          CONTINUE;
        END IF;
        
        --验证订单状态是否是已作废
        select F.STATUS
          INTO O_STUTAS
          from SPM_CON_HT_INFO F
         WHERE F.CONTRACT_ID = V_CONTRACT_ID;
        
        IF O_STUTAS = 'IZ' THEN 
          CONTINUE;
         END IF;
      
        SELECT SUM(S.MONEY_AMOUNT)
          INTO V_REG_MONEY
          FROM SPM_CON_RECEIPT S
         WHERE S.CONTRACT_ID = V_CONTRACT_ID;
        --订单全部收款完成
        IF V_REG_MONEY = V_RMB_TOTAL THEN
          --修改订单已收款状态
          UPDATE SPM_CON_HT_INFO S
             SET S.PAY_IDENTIFY = 'ED'
           WHERE S.CONTRACT_ID = V_CONTRACT_ID;
        
          V_REPEAT_VALIDATE := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_RECEIPT',
                                                                     'MONEYREG_ORDER',
                                                                     V_RECEIPT_ID);
          IF V_REPEAT_VALIDATE = 'Y' THEN
            V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('spm_con_money_receive');
          
            V_JSON := '{ "operationType":"insert","contractCode":"' ||
                      V_CONTRACT_CODE || '","receiptStatus":"01"}';
          
            INSERT INTO SPM_CON_MQ_MESSAGE
              (MESSAGE_ID,
               CONFIGURE_ID,
               BUSINESS_NAME,
               BUSINESS_CHARAC,
               BUSINESS_ID,
               CREATED_BY,
               CREATION_DATE,
               ORG_ID,
               DEPT_ID,
               MESSAGE_CONTENT,
               REMARK)
            VALUES
              (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
               V_CONFIGURE_ID,
               'SPM_CON_RECEIPT',
               'MONEYREG_ORDER',
               V_RECEIPT_ID,
               V_CREATED_BY,
               V_CREATION_DATE,
               V_ORG_ID,
               V_DEPT_ID,
               V_JSON,
               '销售订单收款状态同步');
          
            --推送成功后给收款单加标识
            UPDATE SPM_CON_RECEIPT T
               SET T.EBS_STATUS = 'OR'
             WHERE T.RECEIPT_ID = V_RECEIPT_ID
               AND NOT EXISTS
             (SELECT 1
                      FROM AR_CASH_RECEIPTS_ALL ARA
                     WHERE ARA.RECEIPT_NUMBER = T.RECEIPT_CODE);
          
          END IF;
        END IF;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
    END;    
    
    END LOOP;
  
    
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
  END;

  /*会员费从中间表保存至数据表  */
  PROCEDURE INSERT_VIP_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2) IS
    IDS          SPM_TYPE_TBL;
    V_ID         VARCHAR2(40);
    V_USER_ID    NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID     NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID    NUMBER;
    V_CUST_ID    NUMBER;
    V_PROJECT_ID NUMBER;
    V_INVOICE_ID NUMBER(15);
    V_ITEM_ID    NUMBER(15);
    --V_TAX_AMOUNT    NUMBER;
    V_ERROR_MESSAGE VARCHAR2(4000);
  
    CURSOR CUR1(V_MQ_ID VARCHAR2) IS
    
      SELECT V.REC_NO, --收款单号
             V.PAY_ORDER_NO,
             V.RECE_ORG_NAME,
             V.AGENT_CODE,
             V.RECEIPT_ACCOUNT,
             V.RECEIPT_NAME,
             V.SUPPLIER,
             V.LICENSE_NO,
             V.BUSINESS_TYPE,
             V.PAYABLE_AMOUN,
             V.CREATE_TIME,
             V.COST_START_TIME,
             V.COST_BY_TIME,
             V.NOTIFY_TIME,
             V.INVOICE_TYPE,
             V.INVOICE_BANK_NAME,
             V.INVOICE_BANK_ACCOUNT,
             V.INVOICE_TITILE,
             V.IDENTITY_NUMBER,
             V.INVOICE_PHONE,
             V.INVOICE_ADDRESS,
             V.PAYMENT_STATE,
             V.FEE_CATEGORY,
             V.CONTACTS_NUMBE,
             V.MAILING_ADDRESS,
             V.POST_CODE,
             V.CONTACTS,
             V.BILL_TYPE_NOTE,
             V.FEE_CODE,
             TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS_BY_CODE(V.LICENSE_NO)) V_CUST_ID
        FROM SPM_CON_MQ_VIPFEEIN V
       WHERE V.MQ_ID = V_MQ_ID;
    REC1 CUR1%ROWTYPE;
  BEGIN
  
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
    
    EXCEPTION
      WHEN OTHERS THEN
        V_RETURN_CODE := 'F';
        IF V_DEPT_ID IS NULL THEN
          V_RETURN_MSG := '获取部门信息失败';
        ELSIF V_PROJECT_ID IS NULL THEN
          V_RETURN_MSG := '本组织下无对应的无工程';
        END IF;
      
        UPDATE SPM_CON_MQ_VIPFEEIN V
           SET V.ERROR_MESSAGE = V_RETURN_MSG
         WHERE V.MQ_ID IN V_IDS;
        RETURN;
    END;
    --
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        OPEN CUR1(IDS(I));
        FETCH CUR1
          INTO REC1;
        CLOSE CUR1;
        V_ID := REC1.PAY_ORDER_NO;
      
        IF REC1.V_CUST_ID < 0 OR REC1.V_CUST_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          V_RETURN_MSG  := V_ID || '获取客户信息失败';
        
          IF REC1.V_CUST_ID = -1 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '电商中间表不存在该条记录，请联系电商推送数据';
          ELSIF REC1.V_CUST_ID = -2 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '尚未生成业务数据';
          ELSIF REC1.V_CUST_ID = -3 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '该客户未生效';
          ELSIF REC1.V_CUST_ID = -5 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '获取过程异常，请联系系统管理员';
          END IF;
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || V_ERROR_MESSAGE;
          UPDATE SPM_CON_MQ_VIPFEEIN V
             SET V.ERROR_MESSAGE = V_ERROR_MESSAGE
           WHERE V.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        V_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
        INSERT INTO SPM_CON_OUTPUT_INVOICE
          (OUTPUT_INVOICE_ID,
           INVOICE_AMOUNT,
           INVOICE_TYPE,
           INVOICE_CATEGORY,
           OPENING_BANK,
           BANK_ACCOUNT,
           TAXPAYER_ID_CODE,
           CUST_ADDRESS,
           TELEPHONE,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           INVOICE_SERIAL_NUMBER,
           --PACKAGE_NO,--标段标号
           --PACKAGE_NAME,--标段名字
           CUST_ID,
           STATUS,
           EBS_STATUS,
           EBS_TYPE,
           IS_DISCOUNT,
           COST_TYPE,
           NO_CONTRACT,
           INVOICE_SOURCE,
           INVOICE_BILL,
           OWNED_GROUP,
           PROJECT_ID,
           REMARK,
           DS_FLAG)
        VALUES
          (V_INVOICE_ID,
           REC1.PAYABLE_AMOUN,
           '主营业务结算',
           REC1.INVOICE_TYPE,
           REC1.INVOICE_BANK_NAME,
           REC1.INVOICE_BANK_ACCOUNT,
           REC1.IDENTITY_NUMBER,
           REC1.INVOICE_ADDRESS,
           REC1.INVOICE_PHONE,
           V_USER_ID,
           V_ORG_ID,
           V_DEPT_ID,
           SYSDATE,
           SYSDATE,
           REC1.PAY_ORDER_NO,
           --REC1.PACKAGE_NO,
           --REC1.PACKAGE_NAME,
           REC1.V_CUST_ID,
           'E',
           'N',
           'INV',
           'N',
           'Y',
           'Y',
           '手工发票',
           '发票',
           1,
           V_PROJECT_ID,
           '会员费',
           'HY');
      
        V_ITEM_ID := SPM_CON_OUTPUT_ITEM_SEQ.NEXTVAL;
      
        INSERT INTO SPM_CON_OUTPUT_ITEM
          (OUTPUT_ITEM_ID,
           OUTPUT_INVOICE_ID,
           MATERIAL_CODE,
           ITEM_UNIT,
           ITEM_FORMAT,
           ITEM_AMOUNT,
           UNIT_PRICE,
           MONEY_AMOUNT,
           TAX_TATE,
           TAX_AMOUNT,
           CREATED_BY,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           LAST_UPDATED_BY,
           ORG_ID,
           DEPT_ID,
           TAX_CODE)
        VALUES
          (V_ITEM_ID,
           V_INVOICE_ID,
           '会员费',
           '元',
           '会员费',
           1,
           REC1.PAYABLE_AMOUN,
           REC1.PAYABLE_AMOUN,
           0,
           0,
           V_USER_ID,
           SYSDATE,
           SYSDATE,
           V_USER_ID,
           V_ORG_ID,
           V_DEPT_ID,
           REC1.FEE_CODE);
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '生成发票数据异常';
          UPDATE SPM_CON_MQ_VIPFEEIN V
             SET V.ERROR_MESSAGE = '生成发票数据异常'
           WHERE V.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      BEGIN
        INSERT INTO SPM_CON_MONEY_REG
          (MONEY_REG_ID,
           SERIAL_NUMBER,
           CUST_ID,
           ACCOUNT_NAME,
           MONEY_ACCOUNT,
           COLLECTION_DATE,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE)
        VALUES
          (SPM_CON_MONEY_REG_SEQ.NEXTVAL,
           REC1.PAY_ORDER_NO,
           REC1.V_CUST_ID,
           REC1.SUPPLIER,
           REC1.PAYABLE_AMOUN,
           REC1.CREATE_TIME,
           V_USER_ID,
           V_ORG_ID,
           V_DEPT_ID,
           SYSDATE,
           SYSDATE);
      
        UPDATE SPM_CON_MQ_VIPFEEIN V
           SET V.GENERATE_FLAG = 'Y', V.ERROR_MESSAGE = ''
         WHERE V.MQ_ID = IDS(I);
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '；';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '生成到款数据异常';
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = '生成到款数据异常'
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    END LOOP;
  
    IF V_RETURN_CODE IS NULL THEN
      V_RETURN_CODE := 'S';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行异常';
  END INSERT_VIP_FEE;

  /*交易佣金费从中间表保存至数据表  */
  PROCEDURE INSERT_DEAL_FEE(V_IDS         IN VARCHAR2,
                            V_RETURN_CODE OUT VARCHAR2,
                            V_RETURN_MSG  OUT VARCHAR2) IS
    IDS                 SPM_TYPE_TBL;
    V_USER_ID           NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID            NUMBER;
    V_DEPT_ID           NUMBER;
    V_CUST_ID           NUMBER;
    V_PROJECT_ID        NUMBER;
    V_OUTPUT_INVOICE_ID NUMBER;
    X_ERROR_MSG         VARCHAR2(2000);
  
    --获取供应商银行信息
    CURSOR CUR1(VC_ID NUMBER) IS
      SELECT CCI.VENDOR_CODE,
             CCI.OFFICE_PHONE,
             CCI.VENDOR_ADDRESS,
             CCI.TAXPAYER_CODE,
             R.OPENING_BANK,
             R.BANK_ACOUNT
        FROM SPM_CON_VENDOR_INFO CCI
        LEFT JOIN SPM_CON_BANK_ACOUNT_INFO R
          ON CCI.VENDOR_ID = R.VENDOR_ID
       WHERE 1 = 1
         AND CCI.STATUS = 'E'
         AND CCI.VENDOR_ID = VC_ID;
    REC1 CUR1%ROWTYPE;
  
    CURSOR CUR2(V_MQ_ID VARCHAR2) IS
      SELECT NVL(T.AMOUNT, 0) AMOUNT,
             T.INVOICE_TYPE,
             T.INVOICE_BANK_NAME,
             T.IDENTITY_NUMBER,
             T.INVOICE_ADDRESS,
             T.PAY_ORDER_NO,
             T.SUPPLIER,
             T.CREATE_TIME,
             T.FEE_CODE,
             T.RECE_ORG_NAME,
             T.RECE_ORG_CODE,
             T.BILL_TYPE_NOTE,
             T.NOTIFY_TIME,
             TO_NUMBER(SPM_CON_CUST_PKG.QUERY_CUST_STATUS_BY_CODE(T.SUPPLIER_CODE)) V_CUST_ID,
             T.SUPPLIER_CODE
        FROM SPM_CON_MQ_DEALFEEIN T
       WHERE T.MQ_ID = V_MQ_ID;
    REC2 CUR2%ROWTYPE;
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      OPEN CUR2(IDS(I));
      FETCH CUR2
        INTO REC2;
      CLOSE CUR2;
    
      UPDATE SPM_CON_MQ_DEALFEEIN M
         SET M.LAST_UPDATE_DATE = SYSDATE
       WHERE M.MQ_ID = IDS(I);
    
      -- 获取OU
      BEGIN
        SELECT TO_NUMBER(H.ORGANIZATION_ID)
          INTO V_ORG_ID
          FROM HR_OPERATING_UNITS H
         WHERE H.SHORT_CODE = SUBSTR(REC2.RECE_ORG_CODE, 0, 8);
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取组织“' || REC2.RECE_ORG_NAME || '（' ||
                           SUBSTR(REC2.RECE_ORG_CODE, 0, 8) ||
                           '）”信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      -- 部门信息
      BEGIN
        SELECT T.ORGANIZATION_ID
          INTO V_DEPT_ID
          FROM SPM_CON_HT_PEOPLE_V T
         WHERE ROWNUM < 2
           AND T.BELONGORGID = V_ORG_ID
           AND T.PERSON_ID =
               SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(V_USER_ID);
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '获取部门信息失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      -- 获取本组织无工程
      BEGIN
        SELECT P.PROJECT_ID
          INTO V_PROJECT_ID
          FROM SPM_CON_PROJECT P
         WHERE P.PROJECT_NAME LIKE '无工程-%'
           AND P.ORG_ID = V_ORG_ID;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '未获取到组织“' || REC2.RECE_ORG_NAME || '（' ||
                           SUBSTR(REC2.RECE_ORG_CODE, 0, 8) ||
                           '）”下的无工程信息，请检查数据';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      IF REC2.V_CUST_ID < 0 THEN
        V_RETURN_CODE := 'F';
        X_ERROR_MSG   := '获取客户“' || REC2.SUPPLIER || '（' ||
                         REC2.SUPPLIER_CODE || '）”数据失败：';
      
        IF REC2.V_CUST_ID = -1 THEN
          X_ERROR_MSG := X_ERROR_MSG || '电商中间表不存在该条记录，请联系电商推送数据';
        ELSIF REC2.V_CUST_ID = -2 THEN
          X_ERROR_MSG := X_ERROR_MSG || '尚未生成业务数据';
        ELSIF REC2.V_CUST_ID = -3 THEN
          X_ERROR_MSG := X_ERROR_MSG || '该客户未生效';
        ELSIF REC2.V_CUST_ID = -5 THEN
          X_ERROR_MSG := X_ERROR_MSG || '获取过程异常，请联系系统管理员';
        END IF;
      
        UPDATE SPM_CON_MQ_DEALFEEIN T
           SET T.ERROR_MESSAGE = X_ERROR_MSG
         WHERE T.MQ_ID = IDS(I);
        CONTINUE;
      END IF;
    
      OPEN CUR1(V_CUST_ID);
      FETCH CUR1
        INTO REC1;
      CLOSE CUR1;
    
      BEGIN
        V_OUTPUT_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
        INSERT INTO SPM_CON_OUTPUT_INVOICE
          (OUTPUT_INVOICE_ID,
           INVOICE_AMOUNT,
           INVOICE_TYPE,
           INVOICE_CATEGORY,
           OPENING_BANK,
           BANK_ACCOUNT,
           TAXPAYER_ID_CODE,
           CUST_ADDRESS,
           TELEPHONE,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           INVOICE_SERIAL_NUMBER,
           CUST_ID,
           STATUS,
           EBS_STATUS,
           EBS_TYPE,
           IS_DISCOUNT,
           COST_TYPE,
           NO_CONTRACT,
           INVOICE_BILL,
           OWNED_GROUP,
           PROJECT_ID,
           REMARK,
           DS_FLAG)
        VALUES
          (V_OUTPUT_INVOICE_ID,
           REC2.AMOUNT,
           '主营业务结算',
           REC2.INVOICE_TYPE,
           REC1.OPENING_BANK,
           REC1.BANK_ACOUNT,
           REC1.TAXPAYER_CODE,
           REC1.VENDOR_ADDRESS,
           REC1.OFFICE_PHONE,
           V_USER_ID,
           V_ORG_ID,
           V_DEPT_ID,
           SYSDATE,
           SYSDATE,
           REC2.PAY_ORDER_NO,
           V_CUST_ID,
           'A',
           'N',
           'INV',
           'N',
           'Y',
           'Y',
           '发票',
           '2',
           V_PROJECT_ID,
           '交易佣金费' || REC2.BILL_TYPE_NOTE,
           'JY');
      
        INSERT INTO SPM_CON_MONEY_REG
          (MONEY_REG_ID,
           SERIAL_NUMBER,
           CUST_ID,
           ACCOUNT_NAME,
           MONEY_ACCOUNT,
           COLLECTION_DATE,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE)
        VALUES
          (SPM_CON_MONEY_REG_SEQ.NEXTVAL,
           REC2.PAY_ORDER_NO,
           V_CUST_ID,
           REC2.SUPPLIER,
           REC2.AMOUNT,
           REC2.NOTIFY_TIME,
           V_USER_ID,
           V_ORG_ID,
           V_DEPT_ID,
           SYSDATE,
           SYSDATE);
      
        UPDATE SPM_CON_MQ_DEALFEEIN D
           SET D.ATTRIBUTE1 = 'S'
         WHERE D.ATTRIBUTE1 IS NULL
           AND D.MQ_ID = IDS(I);
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '生成数据失败，请联系系统管理员';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      --执行成功
      UPDATE SPM_CON_MQ_DEALFEEIN T
         SET T.GENERATE_FLAG = 'Y', T.ERROR_MESSAGE = ''
       WHERE T.MQ_ID = IDS(I);
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '过程执行执行异常';
  END INSERT_DEAL_FEE;

  --北京公司到款自动匹配框架
  PROCEDURE MONEY_REG_MATCH_FRAMEWORK(V_IDS IN VARCHAR2) AS
    ID_NUM                 NUMBER;
    J                      INT := 1;
    V_ID                   NUMBER;
    V_NUMBER               NUMBER;
    V_CONTRACT_ID          NUMBER := NULL;
    V_RECEIPT_CODE         VARCHAR2(40);
    V_PROJECT_ID           NUMBER;
    V_EBS_DEPT_CODE        VARCHAR2(40);
    V_DEPT_ID              NUMBER;
    V_CREATED_BY           NUMBER;
    SPM_CON_MONEY_REG_INFO SPM_CON_MONEY_REG%ROWTYPE;
    SPM_CON_RECEIPT_INFO   SPM_CON_RECEIPT%ROWTYPE;
  BEGIN
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(V_IDS) - LENGTH(REPLACE(V_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(V_IDS, '[^,]+', 1, J)) INTO V_ID FROM DUAL;
      J := J + 1;
    
      V_CONTRACT_ID := NULL;
      BEGIN
      
        SELECT *
          INTO SPM_CON_MONEY_REG_INFO
          FROM SPM_CON_MONEY_REG S
         WHERE S.MONEY_REG_ID = V_ID
           AND S.REG_TYPE = 'ar'
           AND S.ORDER_CODE IS NULL;
        --判断收款是否已全部签收
        IF SPM_CON_MONEY_REG_INFO.RESIDUAL_AMOUNT = 0 THEN
          CONTINUE;
        END IF;
        --判断是否为北京公司 、中油公司、本部公司
        IF (SPM_CON_MONEY_REG_INFO.ORG_ID <> 87 AND
           SPM_CON_MONEY_REG_INFO.ORG_ID <> 84) OR
           SPM_CON_MONEY_REG_INFO.CUST_ID IS NULL THEN
          CONTINUE;
        END IF;
        --如果是客户
        IF SPM_CON_MONEY_REG_INFO.REG_TYPE = 'ar' THEN
          SELECT COUNT(*)
            INTO V_NUMBER
            FROM SPM_CON_HT_INFO S, SPM_CON_HT_MERCHANTS H
           WHERE 1 = 1
             AND S.CONTRACT_ID = H.CONTRACT_ID
             AND H.MERCHANTS_ID = SPM_CON_MONEY_REG_INFO.CUST_ID
             AND S.CONTRACT_FORM = 4
             AND H.MERCHANTS_FLAG = 1
             AND (S.START_DATE <= SYSDATE AND S.END_DATE >= SYSDATE)
             AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
             AND S.ORG_ID = SPM_SSO_PKG.GETORGID
             AND ROWNUM = 1;
          IF V_NUMBER <> 0 THEN
            SELECT S.CONTRACT_ID
              INTO V_CONTRACT_ID
              FROM SPM_CON_HT_INFO S, SPM_CON_HT_MERCHANTS H
             WHERE 1 = 1
               AND S.CONTRACT_ID = H.CONTRACT_ID
               AND H.MERCHANTS_ID = SPM_CON_MONEY_REG_INFO.CUST_ID
               AND S.CONTRACT_FORM = 4
               AND H.MERCHANTS_FLAG = 1
               AND (S.START_DATE <= SYSDATE AND S.END_DATE >= SYSDATE)
               AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
               AND S.ORG_ID = SPM_SSO_PKG.GETORGID
               AND ROWNUM = 1;
          END IF;
        END IF;
        --如果是供应商
        IF SPM_CON_MONEY_REG_INFO.REG_TYPE = 'ap' THEN
          SELECT COUNT(*)
            INTO V_NUMBER
            FROM SPM_CON_HT_INFO S, SPM_CON_HT_MERCHANTS H
           WHERE 1 = 1
             AND S.CONTRACT_ID = H.CONTRACT_ID
             AND H.MERCHANTS_ID = SPM_CON_MONEY_REG_INFO.CUST_ID
             AND S.CONTRACT_FORM = 4
             AND H.MERCHANTS_FLAG = 2
             AND (S.START_DATE <= SYSDATE AND S.END_DATE >= SYSDATE)
             AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
             AND S.ORG_ID = SPM_SSO_PKG.GETORGID
             AND ROWNUM = 1;
          IF V_NUMBER <> 0 THEN
            SELECT S.CONTRACT_ID
              INTO V_CONTRACT_ID
              FROM SPM_CON_HT_INFO S, SPM_CON_HT_MERCHANTS H
             WHERE 1 = 1
               AND S.CONTRACT_ID = H.CONTRACT_ID
               AND H.MERCHANTS_ID = SPM_CON_MONEY_REG_INFO.CUST_ID
               AND S.CONTRACT_FORM = 4
               AND H.MERCHANTS_FLAG = 2
               AND (S.START_DATE <= SYSDATE AND S.END_DATE >= SYSDATE)
               AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(S.CONTRACT_ID) = 'Y'
               AND S.ORG_ID = SPM_SSO_PKG.GETORGID
               AND ROWNUM = 1;
          END IF;
        END IF;
      
        IF V_CONTRACT_ID IS NOT NULL THEN
          --付款单编号生成
          SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_RECEIPT_NUM',
                                                                'SPM_CON_RECEIPT',
                                                                'RECEIPT_CODE',
                                                                'FM000000')
            INTO V_RECEIPT_CODE
            FROM DUAL;
        
          --填充合同关联项目
          SELECT S.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_HT_PROJECT S
           WHERE S.CONTRACT_ID = V_CONTRACT_ID
             AND ROWNUM = 1;
        
          --获取框架经办人、经办部门
          SELECT S.CREATED_BY, S.DEPT_ID
            INTO V_CREATED_BY, V_DEPT_ID
            FROM SPM_CON_HT_INFO S
           WHERE S.CONTRACT_ID = V_CONTRACT_ID;
        
          BEGIN
            --填充核算部门       
            SELECT S.EBS_DEPT_CODE
              INTO V_EBS_DEPT_CODE
              FROM SPM_CON_EBS_PEOPLE_V S
             WHERE S.USER_ID = V_CREATED_BY
               AND S.ORG_ID = SPM_SSO_PKG.GETORGID;
          EXCEPTION
            WHEN OTHERS THEN
              V_EBS_DEPT_CODE := '00';
          END;
        
          SPM_CON_RECEIPT_INFO.RECEIPT_ID    := SPM_CON_RECEIPT_SEQ.NEXTVAL;
          SPM_CON_RECEIPT_INFO.MONEY_REG_ID  := V_ID;
          SPM_CON_RECEIPT_INFO.RECEIPT_CODE  := V_RECEIPT_CODE;
          SPM_CON_RECEIPT_INFO.CONTRACT_ID   := V_CONTRACT_ID;
          SPM_CON_RECEIPT_INFO.PROJECT_ID    := V_PROJECT_ID;
          SPM_CON_RECEIPT_INFO.MONEY_AMOUNT  := SPM_CON_MONEY_REG_INFO.RESIDUAL_AMOUNT;
          SPM_CON_RECEIPT_INFO.Residual_Amount  := SPM_CON_MONEY_REG_INFO.RESIDUAL_AMOUNT;
          SPM_CON_RECEIPT_INFO.DEPT_ID       := V_DEPT_ID;
          SPM_CON_RECEIPT_INFO.RECEIPT_DEPT  := V_EBS_DEPT_CODE;
          SPM_CON_RECEIPT_INFO.CREATED_BY    := V_CREATED_BY;
          SPM_CON_RECEIPT_INFO.ORG_ID        := SPM_CON_MONEY_REG_INFO.ORG_ID;
          SPM_CON_RECEIPT_INFO.CREATION_DATE := SYSDATE;
          SPM_CON_RECEIPT_INFO.EBS_STATUS    := 'N';
          SPM_CON_RECEIPT_INFO.RECEIPT_TYPE  := NULL;
          SPM_CON_RECEIPT_INFO.ATTRIBUTE5    := '自动签收';
        
          INSERT INTO SPM_CON_RECEIPT VALUES SPM_CON_RECEIPT_INFO;
          --核销剩余金额
          UPDATE SPM_CON_MONEY_REG S
             SET S.RESIDUAL_AMOUNT = 0
           WHERE S.MONEY_REG_ID = V_ID;
        
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          CONTINUE;
      END;
    END LOOP;
  END;

  /*大贲回传邮寄信息接口*/
  PROCEDURE DB_INVOICE_EXPRESS IS
  
    V_NUMBER NUMBER;
    CURSOR REC1 IS
      SELECT * FROM SPM_DB_INVOICE_EXPRESS_VIEW;
  BEGIN
    FOR DB_INVOICE_EXPRESS IN REC1 LOOP
      --验证销项发票及邮寄信息是否已存在
      SELECT COUNT(*)
        INTO V_NUMBER
        FROM SPM_CON_OUTPUT_INVOICE S
       WHERE S.INVOICE_SERIAL_NUMBER = DB_INVOICE_EXPRESS.CONTRACT_CODE
         AND S.EXPRESS_NUMBER IS NULL;
    
      IF V_NUMBER <> 0 THEN
        UPDATE SPM_CON_OUTPUT_INVOICE S
           SET S.EXPRESS_COMPANY    = 'ems', --目前固定ems
               S.EXPRESS_NUMBER     = DB_INVOICE_EXPRESS.EXPRESS_NUMBER,
               S.RECIPIENTS_NAME    = DB_INVOICE_EXPRESS.RECIPIENTS_NAME,
               S.RECIPIENTS_ADDRESS = DB_INVOICE_EXPRESS.PAYMENT_ACCOUNT,
               S.TEL_NO             = DB_INVOICE_EXPRESS.TEL_NO,
               S.DELIVER_TIME       = DB_INVOICE_EXPRESS.DELIVER_TIME
         WHERE S.INVOICE_SERIAL_NUMBER = DB_INVOICE_EXPRESS.CONTRACT_CODE;
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
  END;

  /*开票结果电子链接*/
  PROCEDURE SPM_CON_SEND_OPENRESULT(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    IDS            SPM_TYPE_TBL;
    V_CONFIGURE_ID NUMBER(15); --配置表id
    V_REPEAT       VARCHAR2(20);
    V_OUTINVOICEID NUMBER(15);
    V_CONTRACTCODE VARCHAR2(100); --发票号码
    V_DS_FLAG      VARCHAR2(10);
    V_MSG          CLOB;
    V_URL          VARCHAR2(2000);
  
    CURSOR CUR1(V_OUTID VARCHAR2) IS
      SELECT P.INVOICE_NUMBER, P.INVOICE_URL
        FROM SPM_CON_PAPER_INVOICE P
       WHERE P.INVOICE_ID = V_OUTID;
    REC1 CUR1%ROWTYPE;
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    --遍历
    FOR I IN 1 .. IDS.COUNT LOOP
      --去重验证 ：为Y 无重复
      V_REPEAT := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_PAPER_INVOICE',
                                                        'SPM_CON_OPEN_INVOICE',
                                                        IDS(I));
      IF V_REPEAT <> 'Y' THEN
        V_RETURN_CODE    := 'E';
        V_RETURN_MESSAGE := '存在重复性信息，无法插入到中间表';
        CONTINUE;
      END IF;
    
      SELECT O.OUTPUT_INVOICE_ID,
             (CASE
               WHEN O.DS_FLAG = 'ZB' THEN
                O.SERVICE_ID
               ELSE
                O.INVOICE_SERIAL_NUMBER
             END),
             O.DS_FLAG
        INTO V_OUTINVOICEID, V_CONTRACTCODE, V_DS_FLAG
        FROM SPM_CON_OUTPUT_INVOICE O
       WHERE O.OUTPUT_INVOICE_ID = IDS(I);
    
      BEGIN
        OPEN CUR1(V_OUTINVOICEID);
        FETCH CUR1
          INTO REC1;
        WHILE CUR1%FOUND LOOP
          V_URL := V_URL || ',{"invoiceUrl":"' || REC1.INVOICE_URL ||
                   '","invoiceCode":"' || REC1.INVOICE_NUMBER || '"}';
          FETCH CUR1
            INTO REC1;
        END LOOP;
        CLOSE CUR1;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := 'E';
          V_RETURN_MESSAGE := '拼接url信息异常，请联系管理员';
          RETURN;
      END;
      V_MSG := '{"id":"' || V_CONTRACTCODE || '","invoiceType":"' ||
               V_DS_FLAG || '","urls":' || '[' || SUBSTR(V_URL, 2) || ']}';
      --配置表ID查询
      V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('SPM_CON_OPEN_INVOICE');
      INSERT INTO SPM.SPM_CON_MQ_MESSAGE
        (MESSAGE_ID, --消息表ID
         CONFIGURE_ID, --配置表ID
         BUSINESS_NAME, --业务表
         BUSINESS_CHARAC, --业务标识
         BUSINESS_ID, --业务ID
         MESSAGE_CONTENT, --消息内容     
         REMARK --备注       
         )
      VALUES
        (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
         V_CONFIGURE_ID,
         'SPM_CON_PAPER_INVOICE',
         'SPM_CON_OPEN_INVOICE',
         IDS(I),
         V_MSG,
         '开票结果电子链接推送');
      UPDATE SPM_CON_OUTPUT_INVOICE O
         SET O.DS_FLAG = O.DS_FLAG || '_S'
       WHERE O.OUTPUT_INVOICE_ID = IDS(I);
      COMMIT;
      V_RETURN_CODE    := 'S';
      V_RETURN_MESSAGE := '插入中间表成功';
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '插入中间表出现异常，请联系管理员';
      RETURN;
  END SPM_CON_SEND_OPENRESULT;

  --进项发票提交流程时判断是否符合条件
  FUNCTION QUERY_CONDITION_FLAG(INPUT_ID NUMBER) RETURN VARCHAR2 IS
    RETURN_STRING VARCHAR2(2) := 'Y'; --默认符合条件
    NUMBER1       NUMBER; --入库单明细行总数量
    NUMBER2       NUMBER; --物理发票明细行总数量
    NUMBER3       NUMBER; --数量和前五个字符一致的明细行数量
  
    NUMBER4 NUMBER; --是否存在物理发票 用来区分是否是票据中心进项发票
  
    MONEY1 NUMBER; --进项发票不含税金额
    MONEY2 NUMBER; --入库单不含税金额合计
  
    R_TYPE VARCHAR2(2); --进项发票类型  货物或者服务
  
  BEGIN
    --查询进项发票类型
    SELECT T.PAYMENT_STATUS
      INTO R_TYPE
      FROM SPM_CON_INPUT_INVOICE T
     WHERE T.INPUT_INVOICE_ID = INPUT_ID;
  
    --0.如果是服务类的,直接返回符合条件
    IF R_TYPE = 'F' THEN
      RETURN RETURN_STRING;
    END IF;
  
    --查询是否有物理发票;
    SELECT COUNT(*)
      INTO NUMBER4
      FROM SPM_CON_PAPER_INVOICE P
     WHERE P.INVOICE_TYPE = 'AP'
       AND P.INVOICE_ID = INPUT_ID;
  
    --0.如果是非票据中心,直接返回符合条件
    IF NUMBER4 = 0 THEN
      RETURN RETURN_STRING;
    END IF;
  
    --查询入库单明细行总数量
    SELECT COUNT(DL.WAREHOUSE_DL_ID)
      INTO NUMBER1
      FROM SPM_CON_WAREHOUSE_DL DL
     WHERE DL.WAREHOUSE_ID IN
           (SELECT W.WAREHOUSE_ID
              FROM SPM_CON_INPUT_WAREHOUSE W
             WHERE W.INPUT_INVOICE_ID = INPUT_ID
               AND W.WAREHOUSE_ID IS NOT NULL);
  
    --查询物理发票明细行总数量
    SELECT COUNT(C.PAPER_INVOICE_CHILD_ID)
      INTO NUMBER2
      FROM SPM_CON_PAPER_INVOICE_CHILD C
     WHERE C.PAPER_INVOICE_ID IN
           (SELECT P.PAPER_INVOICE_ID
              FROM SPM_CON_PAPER_INVOICE P
             WHERE P.INVOICE_TYPE = 'AP'
               AND P.INVOICE_ID = INPUT_ID);
    --1.判断明细行数量是否一致
    IF NUMBER1 <> NUMBER2 THEN
      RETURN 'N';
    END IF;
  
    --查询进项发票不含税金额
    SELECT I.INVOICETAX_AMOUNT
      INTO MONEY1
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = INPUT_ID;
  
    --查询关联的入库单不含税金额合计 
    SELECT SUM(W.MONEY_AMOUNT)
      INTO MONEY2
      FROM SPM_CON_INPUT_WAREHOUSE W
     WHERE W.INPUT_INVOICE_ID = INPUT_ID
       AND W.WAREHOUSE_ID IS NOT NULL;
  
    --2.判断不含税金额差异是否小于0.2
    IF ABS(MONEY1 - MONEY2) > 0.2 THEN
      RETURN 'N';
    END IF;
  
    --查询数量和前五个字符一致的明细行数量
  
    SELECT COUNT(DL.WAREHOUSE_DL_ID)
      INTO NUMBER3
      FROM SPM_CON_WAREHOUSE_DL DL
     WHERE DL.WAREHOUSE_ID IN
           (SELECT W.WAREHOUSE_ID
              FROM SPM_CON_INPUT_WAREHOUSE W
             WHERE W.INPUT_INVOICE_ID = INPUT_ID
               AND W.WAREHOUSE_ID IS NOT NULL)
       AND SUBSTR(DL.DELIVERY_CARGO, 0, 5) || DL.THIS_WAREHOUSE_NUMBER IN
           (SELECT SUBSTR(C.XMMC, INSTR(C.XMMC, '*', 2) + 1, 5) || C.XMSL
              FROM SPM_CON_PAPER_INVOICE_CHILD C
             WHERE C.PAPER_INVOICE_ID IN
                   (SELECT P.PAPER_INVOICE_ID
                      FROM SPM_CON_PAPER_INVOICE P
                     WHERE P.INVOICE_TYPE = 'AP'
                       AND P.INVOICE_ID = INPUT_ID));
  
    --3.判断名称前五个字符和数量是否一致  
    IF NUMBER3 <> NUMBER1 THEN
      RETURN 'N';
    END IF;
    --4.校验全部通过返回Y
    RETURN RETURN_STRING;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'E';
  END QUERY_CONDITION_FLAG;

  --添加工具方法，整合流水号生成 by mcq 20190116
  FUNCTION CREATE_SERIAL_CODE_UTIL(P_SERIAL_CODE VARCHAR2,
                                   P_TABLE_NAME  VARCHAR2,
                                   P_FIELD_NAME  VARCHAR2,
                                   P_FORMAT_CODE VARCHAR2,
                                   P_USER_ID     NUMBER,
                                   P_ORG_ID      NUMBER) RETURN VARCHAR2 IS
    P_LEN  VARCHAR2(200);
    P_CODE VARCHAR2(200);
  BEGIN
  
    select SPM_CON_SERIAL_PKG.value_NEW(P_SERIAL_CODE, P_ORG_ID, P_USER_ID)
      INTO P_LEN
      from dual;
    select SPM_CON_SERIAL_PKG.get_serial_code(P_TABLE_NAME,
                                              P_FIELD_NAME,
                                              P_FORMAT_CODE,
                                              P_LEN)
      INTO P_CODE
      from dual;
    RETURN P_CODE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '00';
    
  END CREATE_SERIAL_CODE_UTIL;
  
  FUNCTION GET_RECEIPT_DEFAULT_CONFIGURE(K_RECEIPT_TYPE VARCHAR2,
                                         K_FIELD_TYPE   VARCHAR2,
                                         K_ORG_ID       NUMBER,
                                         K_USER_ID      NUMBER)
    RETURN VARCHAR2 IS
    QUERY_SQL    VARCHAR2(2000);
    RECEIPT_TYPE VARCHAR(40); --收款类型 银行或者票据
    FIELD_TYPE   VARCHAR(40); --字段类型 
    RE_MSG       VARCHAR(40);
    --核算部门        receiptDept
    --产品段          ebsProduce
    --现金流量表      cashFlow
    --资金使用部门    matchDept
    --资金使用项目    matchProject
  
    -- A 票据  D 银行
  BEGIN
  
    IF K_RECEIPT_TYPE = 'A' THEN
      RECEIPT_TYPE := 'RECEIPT_CONFIGURE_PJ';
    ELSIF K_RECEIPT_TYPE = 'D' THEN
      RECEIPT_TYPE := 'RECEIPT_CONFIGURE_YH';
    END IF;
    --ATTRABUTE1
    --ATTRIBUTE1
    IF K_FIELD_TYPE = 'receiptDept' THEN
      FIELD_TYPE := 'ATTRABUTE1';
    ELSIF K_FIELD_TYPE = 'ebsProduce' THEN
      FIELD_TYPE := 'ATTRABUTE2';
    ELSIF K_FIELD_TYPE = 'cashFlow' THEN
      FIELD_TYPE := 'ATTRABUTE3';
    ELSIF K_FIELD_TYPE = 'matchDept' THEN
      FIELD_TYPE := 'ATTRABUTE4';
    ELSIF K_FIELD_TYPE = 'matchProject' THEN
      FIELD_TYPE := 'ATTRABUTE5';
    END IF;
  
    QUERY_SQL := 'SELECT  NVL(T.' || FIELD_TYPE ||
                 ',NULL) FROM SPM_DICT T,SPM_DICT_TYPE TY WHERE TY.DICT_TYPE_ID = T.DICT_TYPE_ID ' ||
                 ' AND TY.TYPE_CODE = ' || '''' || RECEIPT_TYPE || '''' ||
                 ' AND T.ORG_ID = ' || K_ORG_ID;
  
    EXECUTE IMMEDIATE QUERY_SQL
      INTO RE_MSG;
    RETURN RE_MSG;
    
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_RECEIPT_DEFAULT_CONFIGURE;

END SPM_CON_MQ_PKG;
/
