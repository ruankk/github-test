CREATE OR REPLACE PACKAGE "SPM_CON_INVOICE_INF_PKG" IS
  --Global Char
  /* 
  取消使用全局变量，在java调用时，容易引起丢包现象
  G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
  G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';*/
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: SPM 与 EBS AP发票接口中间表同步的存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message需要返回的错误原因
  *   HISTORY:
  *     1.0  20171018   MCQ           Created
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_IMP(V_ID             IN NUMBER,
                                   V_USER_ID        IN NUMBER,
                                   V_RESP_ID        IN NUMBER,
                                   V_RESP_APP_ID    IN NUMBER,
                                   V_RETURN_CODE    OUT VARCHAR2,
                                   V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: 预付款发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message需要返回的错误原因
  *   HISTORY:
  *     1.0  20171030   MCQ           Created
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_IMPREST_INVOICE(V_ID             IN NUMBER,
                                       V_USER_ID        IN NUMBER,
                                       V_RESP_ID        IN NUMBER,
                                       V_RESP_APP_ID    IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_F_IMP
  *
  *   DESCRIPTION: 服务类进项发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171211   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_F_IMP(V_ID             IN NUMBER,
                                     V_USER_ID        IN NUMBER,
                                     V_RESP_ID        IN NUMBER,
                                     V_RESP_APP_ID    IN NUMBER,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2);

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_APPLAY
  *
  *   DESCRIPTION: 进项发票核销预付款发票存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 进项发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_APPLAY(V_ID             IN NUMBER,
                                      V_USER_ID        IN NUMBER,
                                      V_RESP_ID        IN NUMBER,
                                      V_RESP_APP_ID    IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2);

  /*=================================================================
  *   批量付款单导入
  *   HISTORY:
  *     1.0  20180518   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_PAYMENT_TO_EBS(V_IDS            IN VARCHAR2,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: AP付款模块同步EBS接口中间表
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           Created
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_PAYMENT_TO_EBS(V_ID             IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_INVOICE
  *
  *   DESCRIPTION: 销项发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_INVOICE(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_RETURN_INVOICE
  *
  *   DESCRIPTION: 销项红冲发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次退票操作ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_RETURN_INVOICE(V_ID             IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_INVOICE
  *
  *   DESCRIPTION: 销项发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_RECEIPT(V_ID             IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2);

  --获取预付款的科目组合
  FUNCTION GET_SEGMENT_FOR_IMPREST(V_ID   NUMBER,
                                   V_TYPE VARCHAR2 DEFAULT 'PRE')
    RETURN VARCHAR2;

  --获取服务类进项发票的科目组合
  FUNCTION GET_SEGMENT_FOR_INPUT_F(V_ITEM_ID NUMBER) RETURN VARCHAR2;
  --发票验证通用方法
  PROCEDURE SPM_CON_APPROVE_INVOICE(A_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2);
  --创建会计科目
  PROCEDURE SPM_CON_CREATE_ACCOUNIT(V_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2);
  --根据进项发票的ID获取税分类代码
  FUNCTION GET_TAX_COMBINATION_ID(V_ID NUMBER) RETURN NUMBER;

  --根据SPM侧项目ID获取对应EBS侧的项目段即项目编号
  FUNCTION GET_EBS_PROJECT_CODE(V_PROJECT_ID NUMBER) RETURN VARCHAR2;
  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_TRX_ACCOUNIT(V_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2);
  --AR红冲发票创建会计科目
  PROCEDURE SPM_CON_AR_RETURN_TRX_ACCOUNIT(V_ID          IN NUMBER,
                                           A_RETURN_CODE OUT VARCHAR2,
                                           A_RETURN_MSG  OUT VARCHAR2);
  --付款创建会计科目
  PROCEDURE SPM_CON_AP_PAY_ACCOUNT(V_ID          IN NUMBER,
                                   A_RETURN_CODE OUT VARCHAR2,
                                   A_RETURN_MSG  OUT VARCHAR2);

  /* --销项发票核销收款单
  PROCEDURE SPM_CON_AR_IMPREST(V_ID             IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2);
  
  --销项发票创建核销会计科目
  PROCEDURE SPM_CON_AR_IMPREST_ACCOUNIT(V_ID          IN NUMBER,
                                        A_return_code OUT VARCHAR2,
                                        A_RETURN_MSG  OUT VARCHAR2);*/
  --检查用户是否有导入EBS权限
  FUNCTION CHECK_SYNC_PERMISSIONS(V_ID NUMBER) RETURN VARCHAR2;
  -- 检查用户是否有导入EBS权限 精确查找添加org参数 -by mcq
  FUNCTION CHECK_SYNC_PERMISSIONS(P_USER_ID NUMBER, P_ORG_ID NUMBER)
    RETURN VARCHAR2;

  --组装查看总账凭证路径
  PROCEDURE FIND_GLPZ_URL(V_ID         IN NUMBER,
                          V_TYPE       IN VARCHAR2,
                          V_RETURN_URL OUT VARCHAR2);
  --组装查看总账凭证路径
  PROCEDURE FIND_GLPZ_URL(V_IDS        IN VARCHAR2,
                          V_TYPE       IN VARCHAR2,
                          V_RETURN_URL OUT VARCHAR2);

  --发票核销EBS
  PROCEDURE SPM_CON_AR_INVOICE_CAV(V_ID             IN NUMBER,
                                   V_RETURN_CODE    OUT VARCHAR2,
                                   V_RETURN_MESSAGE OUT VARCHAR2);

  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_INVOICE_ACCOUNIT(V_ID          IN NUMBER,
                                        A_RETURN_CODE OUT VARCHAR2,
                                        A_RETURN_MSG  OUT VARCHAR2);

  --保证金签收根据到款的银行账户默认生成对应行信息
  PROCEDURE CREATE_LINE_INFO_BY_ID(GROUP_ID       IN VARCHAR2,
                                   RETURN_STATUS  OUT VARCHAR2,
                                   RETURN_MESSAGE OUT VARCHAR2);

  -- 批量执行同步验证创建分录操作
  PROCEDURE SPM_CON_AP_INVOICE_SYNC(V_IDS            IN VARCHAR2,
                                    V_USER_ID        IN NUMBER,
                                    V_RESP_ID        IN NUMBER,
                                    V_RESP_APP_ID    IN NUMBER,
                                    V_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   批量付款匹配发票
  *   HISTORY:
  *     1.0  20180525   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_MAT_INVOICE(O_RULE           IN VARCHAR2,
                                    O_IDS            IN VARCHAR2,
                                    O_RETURN_MESSAGE OUT VARCHAR2);
  /*=================================================================
  *   批量付款匹配发票规则
  *   HISTORY:
  *     1.0  20180525   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_MAT_RULE(V_RULE           IN VARCHAR2,
                                 V_ID             IN VARCHAR2,
                                 V_RETURN_MESSAGE OUT VARCHAR2);
  --根据进项发票的ID获取对应不含税差异科目代码
  FUNCTION GET_NO_TAX_DIF_COMBINATION_ID(V_ID NUMBER) RETURN NUMBER;

  --导入财务之前的验证
  PROCEDURE PAYMENT_TO_EBS_VALIDATA(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2);
  --导入到中间表
  PROCEDURE PAYMENT_TO_EBS_IMPORT(V_ID             IN NUMBER,
                                  S_ID             IN NUMBER,
                                  T_HAD            IN NUMBER,
                                  T_INV_ID         IN NUMBER,
                                  V_RETURN_CODE    OUT VARCHAR2,
                                  V_RETURN_MESSAGE OUT VARCHAR2);
  --自动匹配发票                                  
  FUNCTION PAYMENT_TO_EBS_MATCH_INV(V_ID NUMBER, S_ID NUMBER) RETURN VARCHAR2;
  /*
    自动匹配规则
    V_TYPE_CODE :匹配规则 A ： MATCH_AP_INVOICE_TYPE_RANDOM B ：MATCH_AP_INVOICE_TYPE_DEFAULT
    V_PAYMENT_ID ： 付款单ID
    
  */
  PROCEDURE MATCH_AP_INVOICE_FOR_PAYMENT(V_PAYMENT_ID     IN NUMBER,
                                         V_TYPE_CODE      IN VARCHAR2,
                                         V_RETURN_CODE    OUT VARCHAR2,
                                         V_RETURN_MESSAGE OUT VARCHAR2);
  /*
    第一种自动匹配规则
    1.优先匹配当前大部门下的金额一致的预付款发票
    2.从当前大部门下有余额的发票中按照入账时间匹配
    V_PAYMENT_ID 付款单ID
    V_RETURN_CODE 返回状态
    V_RETURN_MESSAGE 错误原因
    by mcq
  */
  PROCEDURE MATCH_AP_INVOICE_TYPE_RANDOM(V_PAYMENT_ID     IN NUMBER,
                                         V_RETURN_CODE    OUT VARCHAR2,
                                         V_RETURN_MESSAGE OUT VARCHAR2);
  /*
  20180720
  根据招标公司需要添加的一种默认匹配规则
  默认自动匹配业务人员选择的发票
  V_PAYMENT_ID 付款单ID
  V_RETURN_CODE 返回状态
  V_RETURN_MESSAGE 错误原因
  by mcq
  */
  PROCEDURE MATCH_AP_INVOICE_TYPE_DEFAULT(V_PAYMENT_ID     IN NUMBER,
                                          V_RETURN_CODE    OUT VARCHAR2,
                                          V_RETURN_MESSAGE OUT VARCHAR2);

  --查询应付发票余额
  FUNCTION MEW_GET_APINVOICE_BALANCE_F(P_INVOICE_ID NUMBER) RETURN NUMBER;

  -- 付款查询可用发票余额
  FUNCTION MEW_GET_APINVOICE_BALANCE_P(P_INVOICE_ID NUMBER) RETURN NUMBER;
  /*
    往付款核销发票接口表插入数据
    V_PAYMENT_ID 合同侧付款子表ID
    V_INVOICE_ID EBS发票ID
    V_MONEY_AMOUNT 核销金额
  by mcq
  */

  PROCEDURE INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       NUMBER,
                                       V_VENDOR_ID    NUMBER,
                                       V_INVOICE_ID   NUMBER,
                                       V_MONEY_AMOUNT NUMBER);

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: 从接口中间表往EBS侧付款表同步数据
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE CUX_SPM_CON_PAYMENT_TO_EBS(S_ID             IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);

  --验证资金管理付款关联发票与合同条款
  PROCEDURE JUDGE_PAYMENT_CLAUSE(V_ID     IN NUMBER,
                                 V_STATUS OUT VARCHAR2,
                                 V_REASON OUT VARCHAR2);

  --验证资金管理付款关联发票与合同条款
  FUNCTION JUDGE_PAYMENT_CLAUSE_F(V_ID IN NUMBER) RETURN BOOLEAN;

  /*=================================================================
  *   PROGRAM NAME: GENERATE_SALE_ORDER
  *
  *   DESCRIPTION: 出库单插入接口表
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要接口表的出库单ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE GENERATE_SALE_ORDER(V_ID             IN NUMBER,
                                V_RETURN_CODE    OUT VARCHAR2,
                                V_RETURN_MESSAGE OUT VARCHAR2);

  -- 批量出库单出库
  PROCEDURE BATCH_GENERATE_SALE_ORDER(V_ORG_ID IN NUMBER);
  /**
  * 收款自动匹配ebs发票
  * K_RECEIPT_ID  收款主键
  * K_RETURN_CODE 存储过程执行结果  error:异常发生 success:正常执行结束
  * K_RETURN_MESSAGE 反馈信息  
  **/
  PROCEDURE MATCH_AR_INVOICE_FOR_RECEIPT(K_RECEIPT_ID     IN NUMBER,
                                         K_RETURN_CODE    OUT VARCHAR2,
                                         K_RETURN_MESSAGE OUT VARCHAR2);
  --保存收款自动匹配ebs发票的匹配结果
  /**
  *P_HX_AMOUNT       核销金额
  *P_RECEIPT_NUMBER  收款编号
  *P_INVOICE_CODE    发票编号
  *P_ORG_ID          组织id
  **/
  PROCEDURE INSERT_AR_INVOICE_FOR_RECEIPT(P_HX_AMOUNT      IN NUMBER,
                                          P_RECEIPT_NUMBER IN VARCHAR2,
                                          P_INVOICE_CODE   IN VARCHAR2,
                                          P_ORG_ID         IN NUMBER);
                                          
  --重写查询余额的计算方法,考虑到中间表中已经被核销的金额
  FUNCTION QUERY_RESIDUAL_AMOUNT(K_ID NUMBER) RETURN NUMBER;
END SPM_CON_INVOICE_INF_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_INVOICE_INF_PKG" AS

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: SPM 与 EBS AP发票接口中间表同步的存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票id；v_Return_Code 需要返回的执行情况； v_Return_Message需要返回的错误原因
  *   HISTORY:
  *     1.0  20171018   MCQ           Created
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_IMP(V_ID             IN NUMBER,
                                   V_USER_ID        IN NUMBER,
                                   V_RESP_ID        IN NUMBER,
                                   V_RESP_APP_ID    IN NUMBER,
                                   V_RETURN_CODE    OUT VARCHAR2,
                                   V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    L_IFACE_REC       CUX_AP_INV_HEADERS_INTF%ROWTYPE;
    L_IFACE_LINES_REC CUX_AP_INV_LINES_INTF%ROWTYPE;
    L_IFACE_LINES_TAX CUX_AP_INV_LINES_INTF%ROWTYPE;
    T_HEADERS_ID      NUMBER;
    T_LINES_ID        NUMBER;
    T_RETURN_CODE     VARCHAR2(1);
    T_RETURN_MESSAGE  VARCHAR2(4000);
    T_INVOICE_ID      NUMBER;
    T_VENDOR_ID       NUMBER;
    T_COUNT           NUMBER;
    V_LINE_NUM        NUMBER;
  
    L_USER_ID               NUMBER;
    L_RESP_ID               NUMBER;
    L_RESP_APPL_ID          NUMBER;
    V_TAX_CCID              NUMBER; --税行对应的CCID
    DEALING_CODE            VARCHAR2(40); --往来段
    V_DIF_CCID              NUMBER; --不含税差异科目对应的CCID
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    I_CCID                  NUMBER;
  
    --进项发票主表信息
    CURSOR CUR_1(G_INVOICE_ID NUMBER) IS
      SELECT I.*,
             P.PROJECT_CODE,
             (SELECT H.CONTRACT_CODE
                FROM SPM_CON_HT_INFO H
               WHERE I.CONTRACT_ID = H.CONTRACT_ID) AS CONTRACT_CODE
        FROM SPM_CON_INPUT_INVOICE I
        LEFT JOIN SPM_CON_PROJECT P
          ON I.PROJECT_ID = P.PROJECT_ID
       WHERE 1 = 1
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
    REC_1 CUR_1%ROWTYPE;
    --进项发票关联的采购订单明细(EBS采购订单与SPM侧的入库单11对应)
    CURSOR CUR_2(G_INVOICE_ID NUMBER) IS
      SELECT W.INPUT_WAREHOUSE_ID,
             W.INPUT_INVOICE_ID,
             D.WAREHOUSE_ID,
             D.WAREHOUSE_DL_ID,
             ROW_NUMBER() OVER(ORDER BY D.WAREHOUSE_DL_ID) AS LINE_NUMBER,
             ROUND(D.MONEY_AMOUNT, 2) MONEY_AMOUNT,
             L.ITEM_ID,
             D.THIS_WAREHOUSE_NUMBER,
             L.UNIT_MEAS_LOOKUP_CODE UNIT, --修改为取采购订单上的单位
             D.WAREHOUSE_UNIT_PRICE,
             L.PO_HEADER_ID,
             L.PO_LINE_ID,
             T.TRANSACTION_ID,
             T.PO_LINE_LOCATION_ID,
             T.PO_DISTRIBUTION_ID,
             W.CREATED_BY,
             W.CREATION_DATE,
             W.LAST_UPDATE_DATE,
             W.LAST_UPDATE_LOGIN,
             W.REMARK,
             W.LAST_UPDATED_BY
      
        FROM SPM_CON_INPUT_WAREHOUSE W
       INNER JOIN SPM_CON_WAREHOUSE_DL D
          ON W.WAREHOUSE_ID = D.WAREHOUSE_ID
       INNER JOIN PO_LINES_ALL L
          ON D.WAREHOUSE_DL_ID = L.ATTRIBUTE15
       INNER JOIN RCV_TRANSACTIONS T
          ON T.PO_LINE_ID = L.PO_LINE_ID
       WHERE 1 = 1
         AND T.TRANSACTION_TYPE = 'RECEIVE'
         AND W.INPUT_INVOICE_ID = G_INVOICE_ID;
    CURSOR CUR_3(G_INVOICE_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_INPUT_INVOICE I
       WHERE 1 = 1
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
    CURSOR CUR_4(G_INVOICE_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_INPUT_INVOICE I
       WHERE 1 = 1
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID
         AND NVL(I.NO_TAX_DIF, 0) <> 0;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --基本验证
    --验证当前发票是否已同步
    /*
          1、修改逻辑判断：判断是否同步验证EBS 应付发票表
          2、清空中间表中原有错误数据
          by mcq 20180130
    */
  
    SELECT COUNT(A.INVOICE_ID)
      INTO T_COUNT
      FROM AP_INVOICES_ALL A, SPM_CON_INPUT_INVOICE I
     WHERE 1 = 1
       AND A.INVOICE_NUM = TRIM(I.INVOICE_CODE)
       AND I.INPUT_INVOICE_ID = V_ID;
  
    IF T_COUNT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前选择的发票已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    ELSE
    
      DELETE FROM CUX_AP_INV_LINES_INTF L
       WHERE 1 = 1
         AND EXISTS
       (SELECT 1
                FROM CUX_AP_INV_HEADERS_INTF H, SPM_CON_INPUT_INVOICE S
               WHERE S.INVOICE_CODE = H.INVOICE_NUM
                 AND L.INTERFACE_HEADER_ID = H.INTERFACE_HEADER_ID
                 AND S.INPUT_INVOICE_ID = V_ID);
      DELETE FROM CUX_AP_INV_HEADERS_INTF I
       WHERE 1 = 1
         AND EXISTS (SELECT 1
                FROM SPM_CON_INPUT_INVOICE S
               WHERE S.INVOICE_CODE = I.INVOICE_NUM
                 AND S.INPUT_INVOICE_ID = V_ID);
      COMMIT;
    END IF;
  
    --开始循环
    OPEN CUR_1(V_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
      
        --根据供应商CODE查询供应商ID
        SELECT P.VENDOR_ID, P.ATTRIBUTE4
          INTO T_VENDOR_ID, DEALING_CODE
          FROM PO_VENDORS P
         INNER JOIN SPM_CON_VENDOR_INFO V
            ON P.SEGMENT1 = V.VENDOR_CODE
         WHERE V.VENDOR_ID = REC_1.VENDOR_ID;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '选择的供应商未同步至财务';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
      BEGIN
      
        --判断当前关联的入库单是否全部传入EBS
        SELECT COUNT(W.WAREHOUSE_ID)
          INTO T_COUNT
          FROM SPM_CON_INPUT_WAREHOUSE I
         INNER JOIN SPM_CON_WAREHOUSE W
            ON I.WAREHOUSE_ID = W.WAREHOUSE_ID
         WHERE I.INPUT_INVOICE_ID = V_ID;
        IF T_COUNT = 0 THEN
        
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前选择的进项发票未关联入库单';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        
        ELSE
          SELECT (T_COUNT - COUNT(W.INPUT_INVOICE_ID))
            INTO T_COUNT
            FROM PO_HEADERS_ALL P
           INNER JOIN SPM_CON_INPUT_WAREHOUSE W
              ON P.ATTRIBUTE15 = W.WAREHOUSE_ID
           WHERE 1 = 1
             AND P.CANCEL_FLAG = 'N'
             AND W.INPUT_INVOICE_ID = V_ID;
        
          IF T_COUNT <> 0 THEN
          
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '当前选择的进项发票关联的入库单未全部同步至财务，请检查';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
          END IF;
        END IF;
      END;
      --查询对应的头组合ID
      V_CONCATENATED_SEGMENTS := GET_SEGMENT_FOR_IMPREST(REC_1.INPUT_INVOICE_ID,
                                                         'ACCTS');
      I_CCID                  := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
      IF I_CCID = 0 THEN
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '未查询到对应的头科目组合，请检查段值信息！';
        DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        RETURN;
      END IF;
    
      -- 获取本次头信息的主键
      SELECT AP_INVOICES_INTERFACE_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
    
      L_IFACE_REC.INTERFACE_HEADER_ID           := T_HEADERS_ID;
      L_IFACE_REC.ORG_ID                        := REC_1.ORG_ID;
      L_IFACE_REC.INVOICE_NUM                   := REC_1.INVOICE_CODE;
      L_IFACE_REC.INVOICE_TYPE                  := REC_1.EBS_TYPE;
      L_IFACE_REC.VENDOR_ID                     := T_VENDOR_ID;
      L_IFACE_REC.VENDOR_SITE_ID                := REC_1.VENDOR_SITE_ID;
      L_IFACE_REC.INVOICE_DATE                  := REC_1.BILLING_DATE;
      L_IFACE_REC.INVOICE_CURRENCY_CODE         := 'CNY';
      L_IFACE_REC.EXCHANGE_RATE_TYPE            := 'user';
      L_IFACE_REC.EXCHANGE_RATE                 := 1;
      L_IFACE_REC.EXCHANGE_DATE                 := REC_1.CREATION_DATE;
      L_IFACE_REC.TERMS_ID                      := REC_1.PAYMENT_TERM;
      L_IFACE_REC.GL_DATE                       := REC_1.GL_DATE;
      L_IFACE_REC.PROCESS_STATUS                := 'PENDING';
      L_IFACE_REC.CREATION_DATE                 := REC_1.CREATION_DATE;
      L_IFACE_REC.CREATED_BY                    := REC_1.CREATED_BY;
      L_IFACE_REC.LAST_UPDATED_BY               := REC_1.LAST_UPDATED_BY;
      L_IFACE_REC.LAST_UPDATE_DATE              := REC_1.LAST_UPDATE_DATE;
      L_IFACE_REC.LAST_UPDATE_LOGIN             := REC_1.LAST_UPDATE_LOGIN;
      L_IFACE_REC.BATCH_NAME                    := TO_CHAR(SYSDATE(),
                                                           'YY/MM/DD HH24:MI:SS'); --用系统时间作为批名
      L_IFACE_REC.ACCTS_PAY_CODE_COMBINATION_ID := I_CCID; --头ccid
    
      L_IFACE_REC.ATTRIBUTE2 := REC_1.CONTRACT_CODE;
      L_IFACE_REC.ATTRIBUTE3 := REC_1.EBS_DEPT_CODE;
      L_IFACE_REC.ATTRIBUTE4 := DEALING_CODE;
      L_IFACE_REC.ATTRIBUTE5 := REC_1.PROJECT_CODE;
    
      L_IFACE_REC.ATTRIBUTE15 := REC_1.INVOICE_CONTENT; --进项发票摘要
      L_IFACE_REC.ATTRIBUTE14 := V_ID; --存放SPM侧的发票主键
      L_IFACE_REC.ATTRIBUTE12 := SPM_CON_INVOICE_PKG.GET_TRANSACTION_NUMBER(REC_1.TRANSACTION_NUM); --存放关联交易单号
      --插入主表
      INSERT INTO CUX_AP_INV_HEADERS_INTF VALUES L_IFACE_REC;
    
      --遍历子表
      FOR REC_2 IN CUR_2(V_ID) LOOP
      
        IF REC_2.TRANSACTION_ID IS NULL THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前选择的进项发票关联的入库单无对应接收';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
        SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
          INTO T_LINES_ID
          FROM DUAL;
      
        L_IFACE_LINES_REC.INTERFACE_LINE_ID     := T_LINES_ID;
        L_IFACE_LINES_REC.INTERFACE_HEADER_ID   := T_HEADERS_ID;
        L_IFACE_LINES_REC.LINE_NUMBER           := REC_2.LINE_NUMBER;
        L_IFACE_LINES_REC.LINE_TYPE_LOOKUP_CODE := 'ITEM';
        L_IFACE_LINES_REC.AMOUNT                := REC_2.MONEY_AMOUNT;
        L_IFACE_LINES_REC.INVENTORY_ITEM_ID     := REC_2.ITEM_ID;
        L_IFACE_LINES_REC.QUANTITY_INVOICED     := REC_2.THIS_WAREHOUSE_NUMBER;
        L_IFACE_LINES_REC.UNIT_MEAS_LOOKUP_CODE := REC_2.UNIT;
        L_IFACE_LINES_REC.UNIT_PRICE            := REC_2.WAREHOUSE_UNIT_PRICE;
        L_IFACE_LINES_REC.PO_HEADER_ID          := REC_2.PO_HEADER_ID;
        L_IFACE_LINES_REC.PO_LINE_ID            := REC_2.PO_LINE_ID;
        L_IFACE_LINES_REC.RCV_TRANSACTION_ID    := REC_2.TRANSACTION_ID;
        L_IFACE_LINES_REC.PO_LINE_LOCATION_ID   := REC_2.PO_LINE_LOCATION_ID;
        L_IFACE_LINES_REC.PO_DISTRIBUTION_ID    := REC_2.PO_DISTRIBUTION_ID;
        --L_IFACE_LINES_REC.ATTRIBUTE1            := REC_2.INPUT_INVOICE_ID;
        --L_IFACE_LINES_REC.ATTRIBUTE2            := REC_2.INPUT_WAREHOUSE_ID;
        L_IFACE_LINES_REC.PROCESS_STATUS        := 'PENDING';
        L_IFACE_LINES_REC.CREATION_DATE         := REC_2.CREATION_DATE;
        L_IFACE_LINES_REC.CREATED_BY            := REC_2.CREATED_BY;
        L_IFACE_LINES_REC.LAST_UPDATED_BY       := REC_2.LAST_UPDATED_BY;
        L_IFACE_LINES_REC.LAST_UPDATE_DATE      := REC_2.LAST_UPDATE_DATE;
        L_IFACE_LINES_REC.LAST_UPDATE_LOGIN     := REC_2.LAST_UPDATE_LOGIN;
        V_LINE_NUM                              := REC_2.LINE_NUMBER;
        L_IFACE_LINES_REC.DESCRIPTION           := REC_2.REMARK;
        INSERT INTO CUX_AP_INV_LINES_INTF VALUES L_IFACE_LINES_REC;
      
      END LOOP;
      --遍历税行
      FOR REC_3 IN CUR_3(V_ID) LOOP
      
        -- 判断当前发票类别，如果是普通发票:B 则不传税行
        IF REC_1.INVOICE_TYPE = 'B' THEN
          EXIT;
        END IF;
      
        -- 获取本次发票传输的税行CCID
        SELECT GET_TAX_COMBINATION_ID(V_ID) INTO V_TAX_CCID FROM DUAL;
        IF V_TAX_CCID = 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '未查询到税行信息对应的科目组合！';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
        SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
          INTO T_LINES_ID
          FROM DUAL;
        V_LINE_NUM                                 := V_LINE_NUM + 1;
        L_IFACE_LINES_TAX.INTERFACE_LINE_ID        := T_LINES_ID;
        L_IFACE_LINES_TAX.INTERFACE_HEADER_ID      := T_HEADERS_ID;
        L_IFACE_LINES_TAX.LINE_NUMBER              := V_LINE_NUM; -- 行号
        L_IFACE_LINES_TAX.LINE_TYPE_LOOKUP_CODE    := 'ITEM';
        L_IFACE_LINES_TAX.AMOUNT                   := REC_3.TAX_AMOUNT;
        L_IFACE_LINES_TAX.TAX_CLASSIFICATION_CODE  := REC_3.TAX_RATE;
        L_IFACE_LINES_TAX.DIST_CODE_COMBINATION_ID := V_TAX_CCID;
        L_IFACE_LINES_TAX.PROCESS_STATUS           := 'PENDING';
        L_IFACE_LINES_TAX.CREATION_DATE            := REC_3.CREATION_DATE;
        L_IFACE_LINES_TAX.CREATED_BY               := REC_3.CREATED_BY;
        L_IFACE_LINES_TAX.LAST_UPDATED_BY          := REC_3.LAST_UPDATED_BY;
        L_IFACE_LINES_TAX.LAST_UPDATE_DATE         := REC_3.LAST_UPDATE_DATE;
        L_IFACE_LINES_TAX.LAST_UPDATE_LOGIN        := REC_3.LAST_UPDATE_LOGIN;
       --L_IFACE_LINES_TAX.ATTRIBUTE1               := REC_3.INPUT_INVOICE_ID;
        L_IFACE_LINES_TAX.ATTRIBUTE14              := 'TAX'; --区分税行
      
        INSERT INTO CUX_AP_INV_LINES_INTF VALUES L_IFACE_LINES_TAX;
      
      END LOOP;
    
      --遍历不含税金额差异
      FOR REC_4 IN CUR_4(V_ID) LOOP
      
        -- 判断当前发票业务类型，如果不是货物类，则不传不含税金额差异
        IF REC_1.PAYMENT_STATUS <> 'Y' THEN
          EXIT;
        END IF;
      
        -- 获取本次发票传输的不含税金额差异CCID
        SELECT GET_NO_TAX_DIF_COMBINATION_ID(V_ID)
          INTO V_DIF_CCID
          FROM DUAL;
        IF V_DIF_CCID = 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '未查询到对应不含税差异科目组合！';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
        SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
          INTO T_LINES_ID
          FROM DUAL;
        V_LINE_NUM                                 := V_LINE_NUM + 1;
        L_IFACE_LINES_TAX.INTERFACE_LINE_ID        := T_LINES_ID;
        L_IFACE_LINES_TAX.INTERFACE_HEADER_ID      := T_HEADERS_ID;
        L_IFACE_LINES_TAX.LINE_NUMBER              := V_LINE_NUM; -- 行号
        L_IFACE_LINES_TAX.LINE_TYPE_LOOKUP_CODE    := 'ITEM';
        L_IFACE_LINES_TAX.AMOUNT                   := REC_4.NO_TAX_DIF;
        L_IFACE_LINES_TAX.TAX_CLASSIFICATION_CODE  := REC_4.TAX_RATE;
        L_IFACE_LINES_TAX.DIST_CODE_COMBINATION_ID := V_DIF_CCID;
        L_IFACE_LINES_TAX.PROCESS_STATUS           := 'PENDING';
        L_IFACE_LINES_TAX.CREATION_DATE            := REC_4.CREATION_DATE;
        L_IFACE_LINES_TAX.CREATED_BY               := REC_4.CREATED_BY;
        L_IFACE_LINES_TAX.LAST_UPDATED_BY          := REC_4.LAST_UPDATED_BY;
        L_IFACE_LINES_TAX.LAST_UPDATE_DATE         := REC_4.LAST_UPDATE_DATE;
        L_IFACE_LINES_TAX.LAST_UPDATE_LOGIN        := REC_4.LAST_UPDATE_LOGIN;
        --L_IFACE_LINES_TAX.ATTRIBUTE1               := REC_4.INPUT_INVOICE_ID;
        L_IFACE_LINES_TAX.ATTRIBUTE14              := 'TAX'; --区分税行
      
        INSERT INTO CUX_AP_INV_LINES_INTF VALUES L_IFACE_LINES_TAX;
      
      END LOOP;
    
      COMMIT;
    ELSE
      CLOSE CUR_1;
    END IF;
  
    BEGIN
      --STEP4 调用从中间表插入接口表的存储过程
      /*SELECT FUR.USER_ID, FUR.RESPONSIBILITY_ID, FRV.APPLICATION_ID
       INTO L_USER_ID, L_RESP_ID, L_RESP_APPL_ID
       FROM FND_USER_RESP_GROUPS_DIRECT FUR,
            FND_RESPONSIBILITY_VL       FRV,
            HR_OPERATING_UNITS          HOU
      WHERE FRV.RESPONSIBILITY_ID = FUR.RESPONSIBILITY_ID
        AND FRV.RESPONSIBILITY_NAME LIKE '%AP%超级%'
        AND HOU.ORGANIZATION_ID = SPM_SSO_PKG.getOrgId
      
        AND SUBSTR(FRV.RESPONSIBILITY_NAME, 1, 8) = HOU.SHORT_CODE
        AND ROWNUM = 1;*/
    
      /*      FND_GLOBAL.APPS_INITIALIZE(USER_ID      => L_USER_ID, --FND_GLOBAL.USER_ID,--7102
      RESP_ID      => L_RESP_ID, --FND_GLOBAL.RESP_ID --50623
      RESP_APPL_ID => L_RESP_APPL_ID --FND_GLOBAL.RESP_APPL_ID --50623
      );*/
    
      CUX_AP_INVOICE_INTF_PKG.IMPORT_AP_INVOICE(X_RETURN_CODE         => T_RETURN_CODE,
                                                X_RETURN_MESSAGE      => T_RETURN_MESSAGE,
                                                X_INVOICE_ID          => T_INVOICE_ID,
                                                P_INTERFACE_HEADER_ID => T_HEADERS_ID,
                                                P_ORG_ID              => SPM_SSO_PKG.GETORGID,
                                                P_USER_NAME           => 'FIN_BUFC');
    END;
  
    DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
    DBMS_OUTPUT.PUT_LINE('返回状态为：');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE('错误原因为：');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);
    V_RETURN_CODE    := T_RETURN_CODE;
    V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  
    IF V_RETURN_CODE <> 'S' THEN
      UPDATE CUX_AP_INV_HEADERS_INTF
         SET PROCESS_STATUS = 'ERROR'
       WHERE INVOICE_ID = T_HEADERS_ID;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AP_INVOICE_IMP;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: 预付款发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171030   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_IMPREST_INVOICE(V_ID             IN NUMBER,
                                       V_USER_ID        IN NUMBER,
                                       V_RESP_ID        IN NUMBER,
                                       V_RESP_APP_ID    IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    L_IFACE_REC      CUX_AP_INVOICES_INTERFACE%ROWTYPE;
    L_IFACE_LINE_REC CUX_AP_INVOICE_LINES_INTERFACE%ROWTYPE;
    ISEXIT           NUMBER;
    T_VENDOR_ID      NUMBER;
    V_INVOICE_ID     NUMBER;
    V_USER_NAME      VARCHAR2(40) := 'FIN_BUFC';
    V_ORG_ID         NUMBER;
  
    L_USER_ID      NUMBER;
    L_RESP_ID      NUMBER;
    L_RESP_APPL_ID NUMBER;
  
    T_RETURN_CODE           VARCHAR2(1);
    T_RETURN_MESSAGE        VARCHAR2(4000);
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    I_CCID                  NUMBER;
    DEALING_CODE            VARCHAR2(40); --往来段
    T_HEADERS_ID            NUMBER;
    T_LINES_ID              NUMBER;
  
    CURSOR CUR_1(G_INVOICE_ID NUMBER) IS
      SELECT I.*,
             P.PROJECT_CODE,
             (SELECT H.CONTRACT_CODE
                FROM SPM_CON_HT_INFO H
               WHERE H.CONTRACT_ID = I.CONTRACT_ID) AS CONTRACT_CODE
        FROM SPM_CON_INPUT_INVOICE I
        LEFT JOIN SPM_CON_PROJECT P
          ON I.PROJECT_ID = P.PROJECT_ID
       WHERE 1 = 1
         AND I.PAYMENT_STATUS = 'I'
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
    REC_1 CUR_1%ROWTYPE;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    --基本验证
    --验证当前发票是否已同步
  
    /*
          1、修改逻辑判断：判断是否同步验证EBS 应付发票表
          2、清空中间表中原有错误数据
          by mcq 20180111
    */
    SELECT COUNT(P.INVOICE_ID)
      INTO ISEXIT
      FROM AP_INVOICES_ALL P, SPM_CON_INPUT_INVOICE I
     WHERE P.INVOICE_NUM = TRIM(I.INVOICE_CODE)
       AND I.INPUT_INVOICE_ID = V_ID;
  
    IF ISEXIT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前的发票已执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    --预付款发票关联的付款申请单未到“制证会计”节点不能操作导入财务
    SELECT COUNT(*)
      INTO ISEXIT
      FROM SPM_CON_PAYMENT P, SPM_CON_PAYMENT_INVOICE PI
     WHERE P.PAYMENT_ID = PI.PAYMENT_ID
       AND P.STATUS <> 'C'
       AND PI.INPUT_INVOICE_ID = V_ID;
  
    IF ISEXIT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '预付款发票关联的付款申请单未到“制证会计”节点不能操作导入财务';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    DELETE FROM CUX_AP_INVOICE_LINES_INTERFACE L
     WHERE 1 = 1
       AND EXISTS
     (SELECT 1
              FROM CUX_AP_INVOICES_INTERFACE H, SPM_CON_INPUT_INVOICE I
             WHERE H.INVOICE_NUM = I.INVOICE_CODE
               AND L.INVOICE_ID = H.INVOICE_ID
               AND I.INPUT_INVOICE_ID = V_ID);
  
    DELETE FROM CUX_AP_INVOICES_INTERFACE C
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_CON_INPUT_INVOICE I
             WHERE C.INVOICE_NUM = I.INVOICE_CODE
               AND I.INPUT_INVOICE_ID = V_ID);
  
    COMMIT;
  
    OPEN CUR_1(V_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
        --根据供应商CODE查询供应商ID
        SELECT P.VENDOR_ID, P.ATTRIBUTE4
          INTO T_VENDOR_ID, DEALING_CODE
          FROM PO_VENDORS P
         INNER JOIN SPM_CON_VENDOR_INFO V
            ON P.SEGMENT1 = V.VENDOR_CODE
         WHERE V.VENDOR_ID = REC_1.VENDOR_ID;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '选择的供应商未同步至财务';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
      BEGIN
      
        --验证当前发票是否有ORGID
        SELECT COUNT(H.ORGANIZATION_ID)
          INTO ISEXIT
          FROM HR_OPERATING_UNITS H
         WHERE H.ORGANIZATION_ID = REC_1.ORG_ID;
        IF ISEXIT <> 1 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '选择的发票组织机构信息不全';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
        --获取头段值组合
        V_CONCATENATED_SEGMENTS := GET_SEGMENT_FOR_IMPREST(V_ID, 'ACCTS');
        I_CCID                  := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
        IF I_CCID = 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '未查到对应的头科目组合！';
          RETURN;
        END IF;
        -- '%10000616.00.112306.00.00.20171206.10000616D17JG004.00.00.00%'
      
        -- 获取本次头信息的主键
        SELECT AP_INVOICES_INTERFACE_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
      
        --执行头表的赋值操作
        L_IFACE_REC.INVOICE_ID                    := T_HEADERS_ID;
        L_IFACE_REC.INVOICE_NUM                   := REC_1.INVOICE_CODE;
        L_IFACE_REC.INVOICE_TYPE_LOOKUP_CODE      := REC_1.EBS_TYPE;
        L_IFACE_REC.VENDOR_ID                     := T_VENDOR_ID;
        L_IFACE_REC.VENDOR_SITE_ID                := REC_1.VENDOR_SITE_ID;
        L_IFACE_REC.INVOICE_AMOUNT                := REC_1.INVOICE_AMOUNT;
        L_IFACE_REC.INVOICE_CURRENCY_CODE         := UPPER('CNY');
        L_IFACE_REC.TERMS_ID                      := REC_1.PAYMENT_TERM;
        L_IFACE_REC.INVOICE_DATE                  := REC_1.CREATION_DATE;
        L_IFACE_REC.DESCRIPTION                   := REC_1.INVOICE_CONTENT;
        L_IFACE_REC.ORG_ID                        := REC_1.ORG_ID;
        L_IFACE_REC.EXCHANGE_DATE                 := REC_1.CREATION_DATE;
        L_IFACE_REC.EXCHANGE_RATE_TYPE            := 'USER';
        L_IFACE_REC.EXCHANGE_RATE                 := 1;
        L_IFACE_REC.GL_DATE                       := REC_1.GL_DATE;
        L_IFACE_REC.PAYMENT_METHOD_LOOKUP_CODE    := 'WIRE'; --固定传电汇
        L_IFACE_REC.CREATION_DATE                 := REC_1.CREATION_DATE;
        L_IFACE_REC.CREATED_BY                    := REC_1.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_DATE              := REC_1.LAST_UPDATE_DATE;
        L_IFACE_REC.LAST_UPDATED_BY               := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN             := REC_1.LAST_UPDATE_LOGIN;
        L_IFACE_REC.ATTRIBUTE2                    := REC_1.CONTRACT_CODE;
        L_IFACE_REC.ATTRIBUTE3                    := REC_1.EBS_DEPT_CODE;
        L_IFACE_REC.ATTRIBUTE4                    := DEALING_CODE;
        L_IFACE_REC.ATTRIBUTE5                    := REC_1.PROJECT_CODE;
        L_IFACE_REC.ACCTS_PAY_CODE_COMBINATION_ID := I_CCID; --头ccid
      
        L_IFACE_REC.ATTRIBUTE15 := REC_1.INVOICE_CONTENT;
        V_ORG_ID                := REC_1.ORG_ID;
      
        --获取行段值组合
        V_CONCATENATED_SEGMENTS := GET_SEGMENT_FOR_IMPREST(V_ID);
        I_CCID                  := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
        IF I_CCID = 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '未查到对应的行科目组合！';
          RETURN;
        END IF;
      
        SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
          INTO T_LINES_ID
          FROM DUAL;
      
        --执行行表的赋值操作
        L_IFACE_LINE_REC.INVOICE_ID               := T_HEADERS_ID;
        L_IFACE_LINE_REC.INVOICE_LINE_ID          := T_LINES_ID;
        L_IFACE_LINE_REC.LINE_NUMBER              := 1;
        L_IFACE_LINE_REC.LINE_TYPE_LOOKUP_CODE    := UPPER('ITEM');
        L_IFACE_LINE_REC.AMOUNT                   := REC_1.INVOICE_AMOUNT;
        L_IFACE_LINE_REC.ACCOUNTING_DATE          := REC_1.CREATION_DATE;
        L_IFACE_LINE_REC.DESCRIPTION              := REC_1.INVOICE_CONTENT;
        L_IFACE_LINE_REC.TAX_CODE                 := REC_1.TAX_RATE;
        L_IFACE_LINE_REC.DIST_CODE_COMBINATION_ID := I_CCID; --行ccid
        L_IFACE_LINE_REC.ORG_ID                   := REC_1.ORG_ID;
      
        INSERT INTO CUX_AP_INVOICES_INTERFACE VALUES L_IFACE_REC;
        INSERT INTO CUX_AP_INVOICE_LINES_INTERFACE VALUES L_IFACE_LINE_REC;
      
        COMMIT;
      END;
      BEGIN
      
        /*        SELECT FUR.USER_ID, FUR.RESPONSIBILITY_ID, FRV.APPLICATION_ID
          INTO L_USER_ID, L_RESP_ID, L_RESP_APPL_ID
          FROM FND_USER_RESP_GROUPS_DIRECT FUR,
               FND_RESPONSIBILITY_VL       FRV,
               HR_OPERATING_UNITS          HOU
         WHERE FRV.RESPONSIBILITY_ID = FUR.RESPONSIBILITY_ID
           AND FRV.RESPONSIBILITY_NAME LIKE '%AP%超级%'
           AND HOU.ORGANIZATION_ID = SPM_SSO_PKG.getOrgId
        
           AND SUBSTR(FRV.RESPONSIBILITY_NAME, 1, 8) = HOU.SHORT_CODE
           AND ROWNUM = 1;
        
        FND_GLOBAL.APPS_INITIALIZE(USER_ID      => L_USER_ID, --FND_GLOBAL.USER_ID,--7102
                                   RESP_ID      => L_RESP_ID, --FND_GLOBAL.RESP_ID --50623
                                   RESP_APPL_ID => L_RESP_APPL_ID --FND_GLOBAL.RESP_APPL_ID --50623
                                   );*/
        /*FND_GLOBAL.APPS_INITIALIZE(1150,
        resp_id      => 50642,
        resp_appl_id => 200);*/
      
        CUX_AP_INVOICE_INTF_PKG.IMPORT_AP_INV_INTERFACE(X_RETURN_CODE    => T_RETURN_CODE,
                                                        X_RETURN_MESSAGE => T_RETURN_MESSAGE,
                                                        X_INVOICE_ID     => V_INVOICE_ID,
                                                        P_INVOICE_ID     => T_HEADERS_ID,
                                                        P_ORG_ID         => V_ORG_ID,
                                                        P_USER_NAME      => V_USER_NAME);
      
      END;
      V_RETURN_CODE    := T_RETURN_CODE;
      V_RETURN_MESSAGE := T_RETURN_MESSAGE;
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
    ELSE
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '未在数据库中查看到该发票数据';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      CLOSE CUR_1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
    
  END SPM_CON_AP_IMPREST_INVOICE;
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_F_IMP
  *
  *   DESCRIPTION: 服务类进项发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171211   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_F_IMP(V_ID             IN NUMBER,
                                     V_USER_ID        IN NUMBER,
                                     V_RESP_ID        IN NUMBER,
                                     V_RESP_APP_ID    IN NUMBER,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    L_IFACE_REC      CUX_AP_INVOICES_INTERFACE%ROWTYPE;
    L_IFACE_LINE_REC CUX_AP_INVOICE_LINES_INTERFACE%ROWTYPE;
    L_IFACE_LINE_TAX CUX_AP_INVOICE_LINES_INTERFACE%ROWTYPE;
  
    ISEXIT       NUMBER;
    T_VENDOR_ID  NUMBER;
    V_INVOICE_ID NUMBER;
    V_USER_NAME  VARCHAR2(40) := 'FIN_BUFC';
    V_ORG_ID     NUMBER;
    T_HEADERS_ID NUMBER;
    T_LINES_ID   NUMBER;
    V_LINE_NUM   NUMBER;
  
    L_USER_ID      NUMBER;
    L_RESP_ID      NUMBER;
    L_RESP_APPL_ID NUMBER;
  
    T_RETURN_CODE           VARCHAR2(1);
    T_RETURN_MESSAGE        VARCHAR2(4000);
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    I_CCID                  NUMBER;
    V_TAX_CCID              NUMBER;
    DEALING_CODE            VARCHAR2(40); --往来段
  
    CURSOR CUR_1(G_INVOICE_ID NUMBER) IS
      SELECT I.*,
             P.PROJECT_CODE,
             (SELECT H.CONTRACT_CODE
                FROM SPM_CON_HT_INFO H
               WHERE H.CONTRACT_ID = I.CONTRACT_ID) AS CONTRACT_CODE
        FROM SPM_CON_INPUT_INVOICE I
        LEFT JOIN SPM_CON_PROJECT P
          ON I.PROJECT_ID = P.PROJECT_ID
       WHERE 1 = 1
         AND I.PAYMENT_STATUS = 'F'
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
    REC_1 CUR_1%ROWTYPE;
    CURSOR CUR_2(G_INVOICE_ID NUMBER) IS
      SELECT W.*,
             ROW_NUMBER() OVER(ORDER BY W.INPUT_WAREHOUSE_ID) AS LINE_NUMBER
        FROM SPM_CON_INPUT_WAREHOUSE W
       WHERE 1 = 1
         AND W.INPUT_INVOICE_ID = G_INVOICE_ID;
    CURSOR CUR_3(G_INVOICE_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_INPUT_INVOICE I
       WHERE 1 = 1
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    --基本验证
    --验证当前发票是否已同步
    /*
          1、修改逻辑判断：判断是否同步验证EBS 应付发票表
          2、清空中间表中原有错误数据
          by mcq 20180111
    */
    SELECT COUNT(P.INVOICE_ID)
      INTO ISEXIT
      FROM AP_INVOICES_ALL P, SPM_CON_INPUT_INVOICE I
     WHERE P.INVOICE_NUM = TRIM(I.INVOICE_CODE)
       AND I.INPUT_INVOICE_ID = V_ID;
  
    IF ISEXIT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前的发票已执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    DELETE FROM CUX_AP_INVOICE_LINES_INTERFACE L
     WHERE 1 = 1
       AND EXISTS
     (SELECT 1
              FROM CUX_AP_INVOICES_INTERFACE H, SPM_CON_INPUT_INVOICE I
             WHERE H.INVOICE_NUM = I.INVOICE_CODE
               AND L.INVOICE_ID = H.INVOICE_ID
               AND I.INPUT_INVOICE_ID = V_ID);
  
    DELETE FROM CUX_AP_INVOICES_INTERFACE C
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_CON_INPUT_INVOICE I
             WHERE C.INVOICE_NUM = I.INVOICE_CODE
               AND I.INPUT_INVOICE_ID = V_ID);
  
    COMMIT;
  
    OPEN CUR_1(V_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
        --根据供应商CODE查询供应商ID
        SELECT P.VENDOR_ID, P.ATTRIBUTE4
          INTO T_VENDOR_ID, DEALING_CODE
          FROM PO_VENDORS P
         INNER JOIN SPM_CON_VENDOR_INFO V
            ON P.SEGMENT1 = V.VENDOR_CODE
         WHERE V.VENDOR_ID = REC_1.VENDOR_ID;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '选择的供应商未同步至财务';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
      --添加对于从电商接收到的保证金对于资金使用部门和项目的校验
      IF REC_1.ATTRIBUTE5 = 'BZJ' AND
         (REC_1.MATCH_DEPT IS NULL OR REC_1.MATCH_PROJECT IS NULL) THEN
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '招标公司传入保证金必须录入资金使用项目和资金使用部门';
        DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        RETURN;
      END IF;
    
      BEGIN
      
        --验证当前发票是否有ORGID
        SELECT COUNT(H.ORGANIZATION_ID)
          INTO ISEXIT
          FROM HR_OPERATING_UNITS H
         WHERE H.ORGANIZATION_ID = REC_1.ORG_ID;
        IF ISEXIT <> 1 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '选择的发票组织机构信息不全';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
        --查询对应的头组合ID
        V_CONCATENATED_SEGMENTS := GET_SEGMENT_FOR_IMPREST(REC_1.INPUT_INVOICE_ID,
                                                           'ACCTS');
        I_CCID                  := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
        IF I_CCID = 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '未查询到对应的头科目组合，请检查段值信息！';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
        SELECT AP_INVOICES_INTERFACE_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
        --执行头表的赋值操作
        L_IFACE_REC.INVOICE_ID                    := T_HEADERS_ID;
        L_IFACE_REC.INVOICE_NUM                   := REC_1.INVOICE_CODE;
        L_IFACE_REC.INVOICE_TYPE_LOOKUP_CODE      := REC_1.EBS_TYPE;
        L_IFACE_REC.VENDOR_ID                     := T_VENDOR_ID;
        L_IFACE_REC.VENDOR_SITE_ID                := REC_1.VENDOR_SITE_ID;
        L_IFACE_REC.INVOICE_AMOUNT                := REC_1.INVOICE_AMOUNT;
        L_IFACE_REC.INVOICE_CURRENCY_CODE         := UPPER('CNY');
        L_IFACE_REC.TERMS_ID                      := REC_1.PAYMENT_TERM;
        L_IFACE_REC.INVOICE_DATE                  := REC_1.BILLING_DATE;
        L_IFACE_REC.TERMS_DATE                    := REC_1.CREATION_DATE;
        L_IFACE_REC.DESCRIPTION                   := REC_1.INVOICE_CONTENT;
        L_IFACE_REC.ORG_ID                        := REC_1.ORG_ID;
        L_IFACE_REC.EXCHANGE_DATE                 := REC_1.CREATION_DATE;
        L_IFACE_REC.EXCHANGE_RATE_TYPE            := 'USER';
        L_IFACE_REC.EXCHANGE_RATE                 := 1;
        L_IFACE_REC.GL_DATE                       := REC_1.GL_DATE;
        L_IFACE_REC.PAYMENT_METHOD_LOOKUP_CODE    := REC_1.PAYMENT_TYPE;
        L_IFACE_REC.CREATION_DATE                 := REC_1.CREATION_DATE;
        L_IFACE_REC.CREATED_BY                    := REC_1.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_DATE              := REC_1.LAST_UPDATE_DATE;
        L_IFACE_REC.LAST_UPDATED_BY               := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN             := REC_1.LAST_UPDATE_LOGIN;
        L_IFACE_REC.ACCTS_PAY_CODE_COMBINATION_ID := I_CCID; --头ccid
      
        L_IFACE_REC.ATTRIBUTE2 := REC_1.CONTRACT_CODE;
        L_IFACE_REC.ATTRIBUTE4 := DEALING_CODE;
        L_IFACE_REC.ATTRIBUTE3 := REC_1.EBS_DEPT_CODE;
        L_IFACE_REC.ATTRIBUTE5 := REC_1.PROJECT_CODE;
      
        L_IFACE_REC.ATTRIBUTE15 := REC_1.INVOICE_CONTENT;
        L_IFACE_REC.ATTRIBUTE12 := SPM_CON_INVOICE_PKG.GET_TRANSACTION_NUMBER(REC_1.TRANSACTION_NUM); --关联交易单
        V_ORG_ID                := REC_1.ORG_ID;
      
        INSERT INTO CUX_AP_INVOICES_INTERFACE VALUES L_IFACE_REC;
        --执行行表的赋值操作
        --获取科目组合
        FOR REC_2 IN CUR_2(V_ID) LOOP
          SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
            INTO T_LINES_ID
            FROM DUAL;
        
          V_CONCATENATED_SEGMENTS := GET_SEGMENT_FOR_INPUT_F(REC_2.INPUT_WAREHOUSE_ID);
          --查询对应的行组合ID
          SELECT CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS)
            INTO I_CCID
            FROM DUAL;
          IF I_CCID = 0 THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '未查询到对应的科目组合，请检查行信息段值！';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
          END IF;
        
          L_IFACE_LINE_REC.INVOICE_ID               := T_HEADERS_ID;
          L_IFACE_LINE_REC.INVOICE_LINE_ID          := T_LINES_ID;
          L_IFACE_LINE_REC.LINE_NUMBER              := REC_2.LINE_NUMBER;
          L_IFACE_LINE_REC.LINE_TYPE_LOOKUP_CODE    := UPPER('ITEM');
          L_IFACE_LINE_REC.AMOUNT                   := REC_2.MONEY_AMOUNT;
          L_IFACE_LINE_REC.ACCOUNTING_DATE          := REC_2.CREATION_DATE;
          L_IFACE_LINE_REC.DESCRIPTION              := REC_2.REMARK;
          L_IFACE_LINE_REC.DIST_CODE_COMBINATION_ID := I_CCID;
          L_IFACE_LINE_REC.ORG_ID                   := REC_2.ORG_ID;
          L_IFACE_LINE_REC.ATTRIBUTE1               := REC_1.MATCH_DEPT;
          L_IFACE_LINE_REC.ATTRIBUTE2               := REC_1.MATCH_PROJECT;
          L_IFACE_LINE_REC.ATTRIBUTE4               := REC_1.CASH_FLOW;
          V_LINE_NUM                                := REC_2.LINE_NUMBER;
        
          INSERT INTO CUX_AP_INVOICE_LINES_INTERFACE
          VALUES L_IFACE_LINE_REC;
        END LOOP;
      
        --遍历税行
        FOR REC_3 IN CUR_3(V_ID) LOOP
        
          -- 判断当前发票类别，如果是普通发票:B 则不传税行
          IF REC_1.INVOICE_TYPE != 'A' THEN
            EXIT;
          END IF;
          -- 获取本次发票传输的税行CCID
          SELECT GET_TAX_COMBINATION_ID(V_ID) INTO V_TAX_CCID FROM DUAL;
          IF V_TAX_CCID = 0 THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '未查询到税行信息对应的科目组合！';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
          END IF;
        
          SELECT AP_INVOICE_LINES_INTERFACE_S.NEXTVAL
            INTO T_LINES_ID
            FROM DUAL;
        
          V_LINE_NUM                                := V_LINE_NUM + 1;
          L_IFACE_LINE_TAX.INVOICE_LINE_ID          := T_LINES_ID;
          L_IFACE_LINE_TAX.INVOICE_ID               := T_HEADERS_ID;
          L_IFACE_LINE_TAX.LINE_NUMBER              := V_LINE_NUM; -- 行号
          L_IFACE_LINE_TAX.LINE_TYPE_LOOKUP_CODE    := 'ITEM';
          L_IFACE_LINE_TAX.AMOUNT                   := REC_3.TAX_AMOUNT;
          L_IFACE_LINE_TAX.TAX_CLASSIFICATION_CODE  := REC_3.TAX_RATE;
          L_IFACE_LINE_TAX.DIST_CODE_COMBINATION_ID := V_TAX_CCID;
          L_IFACE_LINE_TAX.CREATION_DATE            := REC_3.CREATION_DATE;
          L_IFACE_LINE_TAX.CREATED_BY               := REC_3.CREATED_BY;
          L_IFACE_LINE_TAX.LAST_UPDATED_BY          := REC_3.LAST_UPDATED_BY;
          L_IFACE_LINE_TAX.LAST_UPDATE_DATE         := REC_3.LAST_UPDATE_DATE;
          L_IFACE_LINE_TAX.LAST_UPDATE_LOGIN        := REC_3.LAST_UPDATE_LOGIN;
          L_IFACE_LINE_TAX.ATTRIBUTE1               := REC_1.MATCH_DEPT;
          L_IFACE_LINE_TAX.ATTRIBUTE2               := REC_1.MATCH_PROJECT;
          L_IFACE_LINE_TAX.ATTRIBUTE4               := REC_1.CASH_FLOW;
          L_IFACE_LINE_TAX.ATTRIBUTE14              := 'TAX'; --区分税行
        
          INSERT INTO CUX_AP_INVOICE_LINES_INTERFACE
          VALUES L_IFACE_LINE_TAX;
        END LOOP;
      
        COMMIT;
      END;
      BEGIN
      
        /*        SELECT FUR.USER_ID, FUR.RESPONSIBILITY_ID, FRV.APPLICATION_ID
          INTO L_USER_ID, L_RESP_ID, L_RESP_APPL_ID
          FROM FND_USER_RESP_GROUPS_DIRECT FUR,
               FND_RESPONSIBILITY_VL       FRV,
               HR_OPERATING_UNITS          HOU
         WHERE FRV.RESPONSIBILITY_ID = FUR.RESPONSIBILITY_ID
           AND FRV.RESPONSIBILITY_NAME LIKE '%AP%超级%'
           AND HOU.ORGANIZATION_ID = SPM_SSO_PKG.getOrgId
        
           AND SUBSTR(FRV.RESPONSIBILITY_NAME, 1, 8) = HOU.SHORT_CODE
           AND ROWNUM = 1;
        
        FND_GLOBAL.APPS_INITIALIZE(USER_ID      => L_USER_ID, --FND_GLOBAL.USER_ID,--7102
                                   RESP_ID      => L_RESP_ID, --FND_GLOBAL.RESP_ID --50623
                                   RESP_APPL_ID => L_RESP_APPL_ID --FND_GLOBAL.RESP_APPL_ID --50623
                                   );*/
        /*FND_GLOBAL.APPS_INITIALIZE(1150,
        resp_id      => 50642,
        resp_appl_id => 200);*/
      
        CUX_AP_INVOICE_INTF_PKG.IMPORT_AP_INV_INTERFACE(X_RETURN_CODE    => T_RETURN_CODE,
                                                        X_RETURN_MESSAGE => T_RETURN_MESSAGE,
                                                        X_INVOICE_ID     => V_INVOICE_ID,
                                                        P_INVOICE_ID     => T_HEADERS_ID,
                                                        P_ORG_ID         => V_ORG_ID,
                                                        P_USER_NAME      => V_USER_NAME);
      
      END;
      V_RETURN_CODE    := T_RETURN_CODE;
      V_RETURN_MESSAGE := T_RETURN_MESSAGE;
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
    ELSE
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '未在数据库中查看到该发票数据';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      CLOSE CUR_1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AP_INVOICE_F_IMP;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_APPLAY
  *
  *   DESCRIPTION: 进项发票核销预付款发票存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 进项发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_INVOICE_APPLAY(V_ID             IN NUMBER,
                                      V_USER_ID        IN NUMBER,
                                      V_RESP_ID        IN NUMBER,
                                      V_RESP_APP_ID    IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    INPUT_EBS_ID         NUMBER; --进项发票对应EBS侧的ID
    IMPREST_EBS_ID       NUMBER; --核销的预付款发票对应的EBS ID
    IMPREST_EBS_LINES_ID NUMBER; --核销的预付款对应的行号
    VERIFIC_AMOUNT       NUMBER; --核销金额
    V_GL_DATE            DATE; --核销总账日期
    V_ORG_ID             NUMBER; --组织机构
  
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    RETURN_CODE    VARCHAR2(40) := G_INTERFACE_ERROR;
    RETURN_MESSAGE VARCHAR2(200);
  
    CURSOR CUR_1(G_INVOICE_ID NUMBER) IS
      SELECT I.GL_DATE, I.ORG_ID, A.INVOICE_ID
      
        FROM SPM_CON_INPUT_INVOICE I, AP_INVOICES_ALL A
       WHERE 1 = 1
         AND I.INVOICE_CODE = A.INVOICE_NUM
         AND I.INPUT_INVOICE_ID = G_INVOICE_ID;
    REC_1 CUR_1%ROWTYPE;
    CURSOR CUR_2(G_INVOICE_ID NUMBER) IS
      SELECT V.VERIFIC_IMPREST_AMOUNT, V.IMPREST_INVOICE_ID, L.LINE_NUMBER
        FROM SPM_CON_INPUT_VERIFIC V, AP_INVOICE_LINES_ALL L
       WHERE 1 = 1
         AND V.IMPREST_INVOICE_ID = L.INVOICE_ID
         AND V.INPUT_INVOICE_ID = G_INVOICE_ID;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
    OPEN CUR_1(V_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
        V_GL_DATE    := REC_1.GL_DATE;
        V_ORG_ID     := REC_1.ORG_ID;
        INPUT_EBS_ID := REC_1.INVOICE_ID;
        --遍历子表
        FOR REC_2 IN CUR_2(V_ID) LOOP
          VERIFIC_AMOUNT       := REC_2.VERIFIC_IMPREST_AMOUNT;
          IMPREST_EBS_ID       := REC_2.IMPREST_INVOICE_ID;
          IMPREST_EBS_LINES_ID := REC_2.LINE_NUMBER;
          --调用接口
          CUX_AP_INVOICE_INTF_PKG.P_AP_INVOICE_APPLAY(P_PREPAY_INVOICE_ID => IMPREST_EBS_ID,
                                                      P_PREPAY_LINE_NUM   => IMPREST_EBS_LINES_ID,
                                                      P_INVOICE_ID        => INPUT_EBS_ID,
                                                      P_APPLY_AMOUNT      => VERIFIC_AMOUNT,
                                                      P_GL_DATE           => V_GL_DATE,
                                                      P_ORG_ID            => V_ORG_ID,
                                                      X_STATUS            => RETURN_CODE,
                                                      X_ERROR_MESSAGE     => RETURN_MESSAGE);
          --返回状态
          DBMS_OUTPUT.PUT_LINE(V_ID);
          DBMS_OUTPUT.PUT_LINE('返回状态为：');
          DBMS_OUTPUT.PUT_LINE(RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE('原因为：');
          DBMS_OUTPUT.PUT_LINE(RETURN_MESSAGE);
          V_RETURN_CODE    := RETURN_CODE;
          V_RETURN_MESSAGE := RETURN_MESSAGE;
        
        END LOOP;
      
      END;
    ELSE
      CLOSE CUR_1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AP_INVOICE_APPLAY;

  /*=================================================================
  *   批量付款单导入
  *   HISTORY:
  *     1.0  20180518   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_PAYMENT_TO_EBS(V_IDS            IN VARCHAR2,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2) IS
    ID_NUM                NUMBER;
    J                     INT := 1;
    O_RETURN_CODE         VARCHAR2(4000);
    O_RETURN_MESSAGE      VARCHAR2(4000);
    O_ID                  NUMBER;
    O_CHECK_ID            NUMBER;
    O_PAYMENT_CODE        VARCHAR2(40);
    O_EBS_STATUS          VARCHAR2(40);
    O_PAY_DATE            DATE;
    O_PAY_BANK_ACCOUNT_ID NUMBER(15);
    O_PAY_METHODS         VARCHAR2(200);
    O_DESCRIPTION         VARCHAR2(2000);
    O_INVOICE_NUMBER      NUMBER;
    INVOICE_STATUS_NUMBER NUMBER;
    K_CAPTIAL             VARCHAR2(2);
  BEGIN
  
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(V_IDS) - LENGTH(REPLACE(V_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      O_RETURN_CODE    := '';
      O_RETURN_MESSAGE := '';
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(V_IDS, '[^,]+', 1, J)) INTO O_ID FROM DUAL;
      J := J + 1;
      BEGIN
        --导入前验证
        SELECT S.PAYMENT_CODE,
               S.EBS_STATUS,
               S.PAY_DATE,
               S.PAY_METHODS,
               S.PAY_BANK_ACCOUNT_ID,
               nvl(S.DESCRIPTION,'-5555')
          INTO O_PAYMENT_CODE,
               O_EBS_STATUS,
               O_PAY_DATE,
               O_PAY_METHODS,
               O_PAY_BANK_ACCOUNT_ID,
               O_DESCRIPTION
          FROM SPM_CON_PAYMENT S
         WHERE S.PAYMENT_ID = O_ID;
        ---验证资金剩余额度
        K_CAPTIAL := SPM_GZ_GZGL_INS_PKG.CHECK_CAPITAL_BALANCE_FOR_PAY(O_ID,
                                                                       '2');
        IF K_CAPTIAL = 'N' THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '资金计划额度不足,请联系资金处增加后重试';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --验证凭证摘要必填
        IF O_DESCRIPTION = '-5555' THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '凭证摘要必填';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --付款同步状态验证
        IF O_EBS_STATUS = 'US' THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '当前选择的付款已经执行了同步财务操作';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --付款时间验证
        IF O_PAY_DATE IS NULL THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款时间';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --付款方式验证
        IF O_PAY_METHODS IS NULL THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款方式';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --付款银行验证
        IF O_PAY_BANK_ACCOUNT_ID IS NULL THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款银行';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
        --关联发票验证
        SELECT COUNT(*)
          INTO O_INVOICE_NUMBER
          FROM SPM_CON_PAYMENT_INVOICE S
         WHERE S.PAYMENT_ID = O_ID;
        IF O_INVOICE_NUMBER = 0 THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '未关联发票信息';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
      
        --关联发票状态查询
        SELECT COUNT(*)
          INTO INVOICE_STATUS_NUMBER
          FROM SPM_CON_PAYMENT_INVOICE S, SPM_CON_INPUT_INVOICE T
         WHERE S.PAYMENT_ID = O_ID
           AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID
           AND T.EBS_STATUS = 'US';
        IF INVOICE_STATUS_NUMBER <> O_INVOICE_NUMBER THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '关联发票尚未创建会计分录';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          CONTINUE;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          O_RETURN_MESSAGE := O_PAYMENT_CODE || '验证异常';
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          CONTINUE;
      END;
    
      BEGIN
        SPM_CON_AP_PAYMENT_TO_EBS(V_ID             => O_ID,
                                  V_RETURN_CODE    => O_RETURN_CODE,
                                  V_RETURN_MESSAGE => O_RETURN_MESSAGE);
      
        --付款导入成功                       
        IF O_RETURN_CODE = 'S' THEN
          --查询对应EBS侧模块表ID
          SELECT A.CHECK_ID
            INTO O_CHECK_ID
            FROM SPM_CON_PAYMENT P, AP_CHECKS_ALL A
           WHERE A.CHECK_NUMBER = TO_NUMBER(SUBSTR(P.PAYMENT_CODE, 3))
             AND P.PAYMENT_ID = O_ID;
        
          --调用刷新资金剩余额度过程20190416移至创建会计科目事件
          --更新核销资金额度
          UPDATE SPM_CON_PAYMENT P
             SET P.CANCEL_AMOUNT    =
                 (SELECT SUM(PC.MONEY_AMOUNT)
                    FROM SPM_CON_PAYMENT PC
                   WHERE PC.PAYMENT_ID = P.PAYMENT_ID
                     AND PC.PAY_BANK_ACCOUNT_ID <> 11002),
                 P.CANCEL_DATE       = SYSDATE,
                 P.EBS_ID            = O_CHECK_ID,
                 P.EBS_STATUS        = 'US',
                 P.CREATE_ACCOUNT_BY = SPM_SSO_PKG.GETUSERID
           WHERE P.PAYMENT_ID = O_ID;
        
          SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(O_ID, 'A');
        ELSE
          UPDATE SPM_CON_PAYMENT S
             SET S.EBS_STATUS = 'UE'
           WHERE S.PAYMENT_ID = O_ID;
          -- 拼接提示信息
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
          END IF;
          V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_PAYMENT_CODE ||
                              O_RETURN_MESSAGE;
        END IF;
      
      END;
    END LOOP;
  END;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: AP付款模块同步EBS接口中间表
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AP_PAYMENT_TO_EBS(V_ID             IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_H_ID            NUMBER;
    V_L_ID            NUMBER;
    L_IFACE_REC       CUX.CUX_SPM_EXPENSE_MANAGE_PAY%ROWTYPE;
    L_IFACE_LINES_REC CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D%ROWTYPE;
    ISEXIT            NUMBER;
    V_RETURN_ID       NUMBER;
    V_VENDOR_ID       NUMBER; --SPM侧供应商ID
    E_VENDOR_ID       NUMBER; --EBS侧供应商ID
    E_INVOICE_ID      NUMBER; --EBS侧发票ID
  
    L_USER_ID      NUMBER;
    L_RESP_ID      NUMBER;
    L_RESP_APPL_ID NUMBER;
  
    CURSOR CUR_1(G_PAYMENT_ID NUMBER) IS
      SELECT P.*, A.BANK_ACCT_USE_ID
      
        FROM SPM_CON_PAYMENT P
        LEFT JOIN CE.CE_BANK_ACCT_USES_ALL A
          ON P.PAY_BANK_ACCOUNT_ID = A.BANK_ACCOUNT_ID
         AND P.ORG_ID = A.ORG_ID
       WHERE P.PAYMENT_ID = G_PAYMENT_ID;
    REC_1 CUR_1%ROWTYPE;
    CURSOR CUR_2(G_PAYMENT_ID NUMBER) IS
      SELECT A.INVOICE_ID, --EBS侧发票ID
             P.PAYMENT_INVOICE_ID AS PAY_D_ID, --行信息关联ID
             P.MONEY_AMOUNT, --针对此发票的付款金额
             P.ORG_ID,
             P.INPUT_INVOICE_ID, --SPM侧发票ID
             P.REMARK             AS COMMENTS --备注
        FROM SPM_CON_PAYMENT_INVOICE P,
             AP_INVOICES_ALL         A,
             SPM_CON_INPUT_INVOICE   I
       WHERE 1 = 1
         AND I.INVOICE_CODE = A.INVOICE_NUM
         AND P.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
         AND P.PAYMENT_ID = G_PAYMENT_ID;
  BEGIN
    /*
          1、修改逻辑判断：判断是否同步验证EBS 应付表
          2、清空中间表中原有错误数据
          by mcq 20180111
    */
  
    SELECT COUNT(A.CHECK_ID)
      INTO ISEXIT
      FROM AP_CHECKS_ALL A, SPM_CON_PAYMENT P
     WHERE A.CHECK_NUMBER = TO_NUMBER(SUBSTR(P.PAYMENT_CODE, 3))
       AND P.PAYMENT_ID = V_ID;
    IF ISEXIT <> 0 THEN
    
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前选择的付款已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
     WHERE 1 = 1
       AND EXISTS
     (SELECT 1
              FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY H, SPM_CON_PAYMENT P
             WHERE H.VOUCHER_NUM = P.PAYMENT_CODE
               AND D.PAY_H_ID = H.ID
               AND P.PAYMENT_ID = V_ID);
  
    DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY H
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_CON_PAYMENT P
             WHERE H.VOUCHER_NUM = P.PAYMENT_CODE
               AND P.PAYMENT_ID = V_ID);
    COMMIT;
  
    OPEN CUR_1(V_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
      
        --查询对应的供应商ID及EBS发票ID
        BEGIN
          SELECT A.VENDOR_ID
            INTO E_VENDOR_ID
            FROM SPM_CON_VENDOR_INFO I
           INNER JOIN PO_VENDORS A
              ON I.VENDOR_CODE = A.SEGMENT1
           WHERE I.VENDOR_ID = REC_1.VENDOR_ID;
        
          IF E_VENDOR_ID IS NULL THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
        END;
      
        SELECT CUX_EXPENSE_MANAGE_PAY_S.NEXTVAL INTO V_H_ID FROM DUAL;
        --执行头表赋值
        L_IFACE_REC.ID                := V_H_ID;
        L_IFACE_REC.PAY_DATE          := REC_1.PAY_DATE;
        L_IFACE_REC.DEPT_ID           := REC_1.DEPT_ID;
        L_IFACE_REC.AMOUNT            := REC_1.MONEY_AMOUNT;
        L_IFACE_REC.BANK_ACCOUNT_ID   := REC_1.PAY_BANK_ACCOUNT_ID;
        L_IFACE_REC.PAY_METHODS       := 'WIRE'; --固定传电汇
        L_IFACE_REC.CASH_FLOW         := REC_1.CASH_FLOW_ID;
        L_IFACE_REC.ORG_ID            := REC_1.ORG_ID;
        L_IFACE_REC.ACC_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.PAY_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.BANK_ID           := REC_1.BANK_ACCT_USE_ID;
        L_IFACE_REC.COMMENTS          := REC_1.DESCRIPTION;
        L_IFACE_REC.VENDOR_SITE_ID    := REC_1.VENDOR_SITE_ID;
        L_IFACE_REC.APPLY_ID          := REC_1.PAYMENT_ID;
        L_IFACE_REC.CREATION_DATE     := REC_1.CREATION_DATE;
        L_IFACE_REC.CREATED_BY        := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_DATE  := REC_1.LAST_UPDATE_DATE;
        L_IFACE_REC.LAST_UPDATED_BY   := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN := REC_1.LAST_UPDATE_LOGIN;
        L_IFACE_REC.VENDOR_ID         := E_VENDOR_ID;
        L_IFACE_REC.VOUCHER_NUM       := SUBSTR(REC_1.PAYMENT_CODE, 3); --付款编号待确认
        L_IFACE_REC.ATTRIBUTE4        := REC_1.CASH_FLOW_ID;
        IF REC_1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
          L_IFACE_REC.ATTRIBUTE1        := REC_1.MATCH_DEPT;
          L_IFACE_REC.ATTRIBUTE2        := REC_1.MATCH_PROJECT;
        END IF;
      
        INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY VALUES L_IFACE_REC;
      
        FOR REC_2 IN CUR_2(V_ID) LOOP
        
          SELECT CUX_EXPENSE_MANAGE_PAY_D_S.NEXTVAL INTO V_L_ID FROM DUAL;
          --执行行表赋值
          L_IFACE_LINES_REC.PAY_D_ID         := V_L_ID;
          L_IFACE_LINES_REC.PAY_H_ID         := V_H_ID;
          L_IFACE_LINES_REC.INVOICE_ID       := REC_2.INVOICE_ID;
          L_IFACE_LINES_REC.COMMENTS         := REC_2.COMMENTS;
          L_IFACE_LINES_REC.ORG_ID           := REC_2.ORG_ID;
          L_IFACE_LINES_REC.THIS_AMOUNT      := REC_2.MONEY_AMOUNT;
          L_IFACE_LINES_REC.ATTRIBUTE1       := REC_2.INPUT_INVOICE_ID;
          L_IFACE_LINES_REC.PAYMENT_CHILD_ID := V_ID;
          INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D
          VALUES L_IFACE_LINES_REC;
        
        END LOOP;
      
        COMMIT;
      EXCEPTION
      
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '有空值';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
    
      BEGIN
        /*
        SELECT FUR.USER_ID, FUR.RESPONSIBILITY_ID, FRV.APPLICATION_ID
          INTO L_USER_ID, L_RESP_ID, L_RESP_APPL_ID
          FROM FND_USER_RESP_GROUPS_DIRECT FUR,
               FND_RESPONSIBILITY_VL       FRV,
               HR_OPERATING_UNITS          HOU
         WHERE FRV.RESPONSIBILITY_ID = FUR.RESPONSIBILITY_ID
           AND FRV.RESPONSIBILITY_NAME LIKE '%AP%超级%'
           AND HOU.ORGANIZATION_ID = SPM_SSO_PKG.getOrgId
        
           AND SUBSTR(FRV.RESPONSIBILITY_NAME, 1, 8) = HOU.SHORT_CODE
           AND ROWNUM = 1;
        
        FND_GLOBAL.APPS_INITIALIZE(USER_ID      => L_USER_ID, --FND_GLOBAL.USER_ID,--7102
                                   RESP_ID      => L_RESP_ID, --FND_GLOBAL.RESP_ID --50623
                                   RESP_APPL_ID => L_RESP_APPL_ID --FND_GLOBAL.RESP_APPL_ID --50623
                                   );*/
      
        CUX_SPM_EXP_IMPORT_PAYMENT_PKG.IMPORT_PAYMENT(P_MANAGE_PAY_ID => V_H_ID,
                                                      P_MSG           => V_RETURN_MESSAGE,
                                                      P_CHECK_ID      => V_RETURN_ID);
      
        /* 导入付款，返回EBS付款ID，如果返回就是导入成功，否则看错误信息   */
        IF V_RETURN_ID IS NULL THEN
          V_RETURN_CODE := G_INTERFACE_ERROR;
          RETURN;
        ELSE
          V_RETURN_CODE := G_INTERFACE_SUCCESS;
        
          DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
           WHERE D.PAYMENT_CHILD_ID = V_ID;
          RETURN;
        END IF;
      END;
    
    ELSE
      CLOSE CUR_1;
      V_RETURN_CODE := G_INTERFACE_ERROR;
      V_RETURN_CODE := '未查询到对应付款数据';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AP_PAYMENT_TO_EBS;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_INVOICE
  *
  *   DESCRIPTION: 销项发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_INVOICE(V_ID             IN NUMBER,
                               V_USER_ID        IN NUMBER,
                               V_RESP_ID        IN NUMBER,
                               V_RESP_APP_ID    IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXIST     NUMBER;
    E_CUST_ID    NUMBER;
    DEALING_CODE VARCHAR2(40);
    S_CUST_NAME  VARCHAR2(300);
    S_CUST_CODE  VARCHAR2(40);
    S_HT_CODE    VARCHAR2(40);
    V_SE_5       VARCHAR2(40); --项目段
    V_IMP_ID     NUMBER; --导入iD
    R_BALANCE    NUMBER;
    R_ONE        NUMBER;
    R_TWO        NUMBER;
    R_HC_FLAG    VARCHAR2(10);
  
    L_IFACE_REC CUX.CUX_FILE_UPLOAD_LINE_TEMP%ROWTYPE;
    CURSOR CUR1(C_INVOICE_ID NUMBER) IS
      SELECT H.*, C.CONTRACT_CODE
        FROM SPM_CON_OUTPUT_INVOICE H
        LEFT JOIN SPM_CON_HT_INFO C
          ON H.CONTRACT_ID = C.CONTRACT_ID
       WHERE 1 = 1
         AND H.OUTPUT_INVOICE_ID = C_INVOICE_ID;
    REC_1 CUR1%ROWTYPE;
  
    CURSOR CUR2(C_INVOICE_ID NUMBER) IS
      SELECT H.*, T.TAX_RATE_CODE
        FROM SPM_CON_OUTPUT_ITEM H
        LEFT JOIN ZX.ZX_RATES_B T
          ON H.TAX_TATE = T.PERCENTAGE_RATE
       WHERE 1 = 1
            -- and t.tax_rate_id = 10103 --迁移到正式环境需要去掉
         AND H.OUTPUT_INVOICE_ID = C_INVOICE_ID;
  BEGIN
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --清空temp表数据
    DELETE FROM CUX.CUX_FILE_UPLOAD_LINE_TEMP;
    COMMIT;
  
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      --BY MCQ
      MO_GLOBAL.SET_POLICY_CONTEXT('S', REC_1.ORG_ID);
    
      SELECT T.HAS_SEND
        INTO R_HC_FLAG
        FROM SPM_CON_OUTPUT_INVOICE T
       WHERE T.OUTPUT_INVOICE_ID = V_ID;
    
      IF R_HC_FLAG = 'K' THEN
      
        SELECT SUM(T.TAX_AMOUNT)
          INTO R_ONE
          FROM SPM_CON_OUTPUT_ITEM T
         WHERE T.OUTPUT_INVOICE_ID = V_ID;
      
        SELECT SUM(S.TAX_AMOUNT)
          INTO R_TWO
          FROM SPM_CON_PAPER_INVOICE S
         WHERE S.INVOICE_TYPE = 'AR'
           AND S.INVOICE_ID = V_ID
           AND NVL(S.INVALID_FLAG, 'N') <> 'Y'; --物理发票未作废的
      
        IF R_ONE - R_TWO <> 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '物理发票的税额合计必须等于行上税额合计';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        END IF;
      
      END IF;
      --检验当前关联的客户是否已经同步至财务
      SELECT C.CUST_CODE, C.CUST_NAME
        INTO S_CUST_CODE, S_CUST_NAME
        FROM SPM_CON_OUTPUT_INVOICE I, SPM_CON_CUST_INFO C
       WHERE C.CUST_ID = I.CUST_ID
         AND I.OUTPUT_INVOICE_ID = V_ID;
      --客户对应的往来段值存在AR_CUSTOMERS 的attribute4中
      SELECT COUNT(*)
        INTO IS_EXIST
        FROM AR_CUSTOMERS CUS
       WHERE 1 = 1
         AND CUS.CUSTOMER_NUMBER = S_CUST_CODE;
      IF IS_EXIST = 0 THEN
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '当前客户在EBS侧不存在,请联系客服人员';
        DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        RETURN;
      END IF;
    
      BEGIN
      
        --客户对应的往来段值存在AR_CUSTOMERS 的attribute4中
        SELECT CUS.CUSTOMER_ID, CUS.ATTRIBUTE4
          INTO E_CUST_ID, DEALING_CODE
          FROM AR_CUSTOMERS CUS, HZ_CUST_ACCT_SITES_ALL C
         WHERE C.CUST_ACCOUNT_ID = CUS.CUSTOMER_ID
           AND C.ORG_ID = REC_1.ORG_ID
           AND CUS.CUSTOMER_NUMBER = S_CUST_CODE
           AND ROWNUM = 1;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前客户未在EBS侧维护对应客户地点，请联系客服人员';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
        
      END;
    
      BEGIN
      
        --查询当前销项发票对应的项目段
        V_SE_5               := GET_EBS_PROJECT_CODE(REC_1.PROJECT_ID);
        L_IFACE_REC.FIELD_49 := REC_1.EBS_TYPE;
        L_IFACE_REC.FIELD_01 := REC_1.INVOICE_SOURCE;
        L_IFACE_REC.FIELD_02 := REC_1.INVOICE_BILL;
        L_IFACE_REC.FIELD_03 := REC_1.INVOICE_TYPE;
        L_IFACE_REC.FIELD_04 := TO_CHAR(REC_1.BILLING_DATE, 'YYYY-MM-DD');
        L_IFACE_REC.FIELD_05 := TO_CHAR(REC_1.GL_DATE, 'YYYY-MM-DD');
        L_IFACE_REC.FIELD_48 := REC_1.REMARK;
      
        L_IFACE_REC.FIELD_31 := REC_1.INVOICE_CODE;
      
        L_IFACE_REC.FIELD_21 := '00';
        L_IFACE_REC.FIELD_22 := REC_1.EBS_DEPT_CODE; --ebs部门段
        L_IFACE_REC.FIELD_23 := '00';
        L_IFACE_REC.FIELD_24 := DEALING_CODE; --往来段默认00
        L_IFACE_REC.FIELD_25 := V_SE_5; --ebs项目段
        L_IFACE_REC.FIELD_26 := REC_1.CONTRACT_CODE; --合同段
        L_IFACE_REC.FIELD_27 := REC_1.EBS_PRODUCE; --ebs产品段
        L_IFACE_REC.FIELD_28 := '00';
      
        IF E_CUST_ID IS NOT NULL THEN
          FOR REC_2 IN CUR2(V_ID) LOOP
          
            SELECT CUX_FILE_UPLOAD_LINE_SEQ.NEXTVAL
              INTO V_IMP_ID
              FROM DUAL;
          
            L_IFACE_REC.IMPORT_ID := V_ID;
            L_IFACE_REC.LINE_NO   := REC_2.OUTPUT_ITEM_ID;
            L_IFACE_REC.FIELD_08  := S_CUST_NAME;
            L_IFACE_REC.FIELD_09  := S_CUST_NAME;
            L_IFACE_REC.FIELD_11  := REC_2.MATERIAL_CODE; --物料
            L_IFACE_REC.FIELD_12  := REC_2.ITEM_AMOUNT; --数量
            L_IFACE_REC.FIELD_13  := REC_2.UNIT_PRICE; --单价
            L_IFACE_REC.FIELD_16  := REC_2.TAX_RATE_CODE; --税率
            L_IFACE_REC.FIELD_34  := REC_2.OUTPUT_ITEM_ID; --子表ID
            L_IFACE_REC.FIELD_35  := V_IMP_ID; --导入序列，排序
            L_IFACE_REC.FIELD_44  := REC_2.TAX_AMOUNT; --20180808添加税额
            L_IFACE_REC.FIELD_45  := REC_2.MONEY_AMOUNT - REC_2.TAX_AMOUNT; --20180808添加不含税金额
          
            INSERT INTO CUX.CUX_FILE_UPLOAD_LINE_TEMP VALUES L_IFACE_REC;
            /*INSERT INTO CUX.cux_file_upload_line_temp2 select  *  from  CUX.cux_file_upload_line_temp;
            INSERT INTO CUX.cux_file_upload_line_temp3 VALUES L_IFACE_REC;*/
          
          END LOOP;
          COMMIT;
        
        ELSE
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前发票选择的客户未同步至财务';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        END IF;
      END;
      BEGIN
        /* INSERT INTO CUX.cux_file_upload_line_temp3
        select * from CUX.cux_file_upload_line_temp;*/
      
        CUX_AR_TRX_IMPORT_PKG.MAIN(RETCODE    => V_RETURN_CODE,
                                   ERRBUF     => V_RETURN_MESSAGE,
                                   P_GROUP_ID => V_ID,
                                   P_RESP_ID  => SPM_SSO_PKG.GETRESPID);
      END;
    ELSE
      CLOSE CUR1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AR_INVOICE;
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_RETURN_INVOICE
  *
  *   DESCRIPTION: 销项红冲发票同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次退票操作ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_RETURN_INVOICE(V_ID             IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXIST     NUMBER;
    E_CUST_ID    NUMBER;
    DEALING_CODE VARCHAR2(40);
    S_CUST_NAME  VARCHAR2(300);
    S_CUST_CODE  VARCHAR2(40);
    S_HT_CODE    VARCHAR2(40);
    V_SE_5       VARCHAR2(40); --项目段
    V_IMP_ID     NUMBER; --导入iD
    V_BILL_TYPE  VARCHAR2(40) := '贷项通知单';
    V_R_ID       NUMBER; --需要执行退票的发票ID
  
    L_IFACE_REC CUX.CUX_FILE_UPLOAD_LINE_TEMP%ROWTYPE;
    CURSOR CUR1(C_INVOICE_ID NUMBER) IS
      SELECT R.*,
             H.EBS_PRODUCE,
             H.EBS_DEPT_CODE,
             H.PROJECT_ID,
             H.INVOICE_SOURCE,
             H.REMARK AS INVOICE_CONTENT,
             C.CONTRACT_CODE
        FROM SPM_CON_RETURN_INVOICE R, SPM_CON_OUTPUT_INVOICE H
        LEFT JOIN SPM_CON_HT_INFO C
          ON H.CONTRACT_ID = C.CONTRACT_ID
       WHERE 1 = 1
         AND R.OUTPUT_INVOICE_ID = H.OUTPUT_INVOICE_ID
         AND R.RETURN_INVOICE_ID = C_INVOICE_ID;
    REC_1 CUR1%ROWTYPE;
  
    CURSOR CUR2(C_INVOICE_ID NUMBER) IS
      SELECT H.OUTPUT_ITEM_ID,
             H.OUTPUT_INVOICE_ID,
             H.MATERIAL_CODE,
             H.ITEM_UNIT,
             H.ITEM_FORMAT,
             (ABS(H.UNIT_PRICE) * (-1)) AS UNIT_PRICE,
             H.ITEM_AMOUNT,
             H.TAX_TATE,
             T.TAX_RATE_CODE,
             H.TAX_AMOUNT,
             H.MONEY_AMOUNT
        FROM SPM_CON_OUTPUT_ITEM H
        LEFT JOIN ZX.ZX_RATES_B T
          ON H.TAX_TATE = T.PERCENTAGE_RATE
       WHERE 1 = 1
         AND H.OUTPUT_INVOICE_ID = C_INVOICE_ID;
  BEGIN
    /*    FND_GLOBAL.APPS_INITIALIZE(1150, resp_id => 50642, resp_appl_id => 200);
    */
  
    SELECT R.OUTPUT_INVOICE_ID
      INTO V_R_ID
      FROM SPM_CON_RETURN_INVOICE R
     WHERE R.RETURN_INVOICE_ID = V_ID;
  
    --清空temp表数据
    DELETE FROM CUX.CUX_FILE_UPLOAD_LINE_TEMP;
    COMMIT;
  
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
      
        --检验当前关联的客户是否已经同步至财务
        SELECT C.CUST_CODE, C.CUST_NAME
          INTO S_CUST_CODE, S_CUST_NAME
          FROM SPM_CON_OUTPUT_INVOICE I, SPM_CON_CUST_INFO C
         WHERE C.CUST_ID = I.CUST_ID
           AND I.OUTPUT_INVOICE_ID = V_R_ID;
      
        --客户对应的往来段值存在AR_CUSTOMERS 的attribute4中
        SELECT CUS.CUSTOMER_ID, CUS.ATTRIBUTE4
          INTO E_CUST_ID, DEALING_CODE
          FROM AR_CUSTOMERS CUS, HZ_CUST_ACCT_SITES_ALL C
         WHERE C.CUST_ACCOUNT_ID = CUS.CUSTOMER_ID
           AND C.ORG_ID = REC_1.ORG_ID
           AND CUS.CUSTOMER_NUMBER = S_CUST_CODE
           AND ROWNUM = 1;
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前客户在EBS侧不存在对应的组合分配';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
    
      BEGIN
      
        --查询当前销项发票对应的项目段
        V_SE_5               := GET_EBS_PROJECT_CODE(REC_1.PROJECT_ID);
        L_IFACE_REC.FIELD_49 := 'CM'; --贷项通知单
        L_IFACE_REC.FIELD_01 := REC_1.INVOICE_SOURCE;
        L_IFACE_REC.FIELD_02 := V_BILL_TYPE;
        L_IFACE_REC.FIELD_03 := REC_1.INVOICE_TYPE;
        L_IFACE_REC.FIELD_04 := TO_CHAR(REC_1.DRAW_UP_DATE, 'YYYY-MM-DD');
        L_IFACE_REC.FIELD_05 := TO_CHAR(REC_1.GL_DATE, 'YYYY-MM-DD');
        L_IFACE_REC.FIELD_06 := REC_1.CONTRACT_CODE;
        L_IFACE_REC.FIELD_31 := REC_1.RETURN_CODE;
        L_IFACE_REC.FIELD_48 := REC_1.INVOICE_CONTENT;
      
        L_IFACE_REC.FIELD_21 := '00';
        L_IFACE_REC.FIELD_22 := REC_1.EBS_DEPT_CODE; --ebs部门段
        L_IFACE_REC.FIELD_23 := '00';
        L_IFACE_REC.FIELD_24 := DEALING_CODE; --往来段默认00
        L_IFACE_REC.FIELD_25 := V_SE_5; --ebs项目段
        L_IFACE_REC.FIELD_26 := REC_1.CONTRACT_CODE; --合同段
        L_IFACE_REC.FIELD_27 := REC_1.EBS_PRODUCE; --ebs产品段
        L_IFACE_REC.FIELD_28 := '00';
      
        IF E_CUST_ID IS NOT NULL THEN
          FOR REC_2 IN CUR2(V_R_ID) LOOP
          
            SELECT CUX_FILE_UPLOAD_LINE_SEQ.NEXTVAL
              INTO V_IMP_ID
              FROM DUAL;
          
            L_IFACE_REC.IMPORT_ID := V_ID; --退票ID
            L_IFACE_REC.LINE_NO   := REC_2.OUTPUT_ITEM_ID;
            L_IFACE_REC.FIELD_08  := S_CUST_NAME;
            L_IFACE_REC.FIELD_09  := S_CUST_NAME;
            L_IFACE_REC.FIELD_11  := REC_2.MATERIAL_CODE; --物料
            L_IFACE_REC.FIELD_12  := REC_2.ITEM_AMOUNT; --数量
            L_IFACE_REC.FIELD_13  := REC_2.UNIT_PRICE; --单价
            L_IFACE_REC.FIELD_16  := REC_2.TAX_RATE_CODE; --税率
            L_IFACE_REC.FIELD_34  := REC_2.OUTPUT_ITEM_ID; --税率
            L_IFACE_REC.FIELD_35  := V_IMP_ID; --导入序列，排序
            L_IFACE_REC.FIELD_36  := V_R_ID; --执行退票的发票ID
            L_IFACE_REC.FIELD_44  := REC_2.TAX_AMOUNT; --20180808添加税额
            L_IFACE_REC.FIELD_45  := REC_2.MONEY_AMOUNT - REC_2.TAX_AMOUNT; --20180808添加不含税金额
          
            INSERT INTO CUX.CUX_FILE_UPLOAD_LINE_TEMP VALUES L_IFACE_REC;
          
          END LOOP;
          COMMIT;
        
        ELSE
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前发票选择的客户未同步至财务';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        END IF;
      END;
      BEGIN
      
        /* INSERT INTO CUX.cux_file_upload_line_temp3
        select * from CUX.cux_file_upload_line_temp;*/
        CUX_AR_TRX_IMPORT_PKG.MAIN(RETCODE    => V_RETURN_CODE,
                                   ERRBUF     => V_RETURN_MESSAGE,
                                   P_GROUP_ID => V_ID,
                                   P_RESP_ID  => SPM_SSO_PKG.GETRESPID);
      END;
    ELSE
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '未查询到该发票的相关数据！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      CLOSE CUR1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END SPM_CON_AR_RETURN_INVOICE;
  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AR_INVOICE
  *
  *   DESCRIPTION: 收款同步EBS中间表存储过程
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE需要返回的错误原因
  *   HISTORY:
  *     1.0  20171120   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_AR_RECEIPT(V_ID             IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXIST    NUMBER;
    V_BANK_NAME VARCHAR2(40);
    L_IFACE_REC CUX.CUX_AR_RECEIPTS%ROWTYPE;
    CURSOR CUR1(C_RECEIPT_ID NUMBER) IS
      SELECT M.ACCOUNT_NAME, M.PAYMENT_ACCOUNT
        FROM SPM_CON_MONEY_REG M, SPM_CON_RECEIPT R
       WHERE M.MONEY_REG_ID = R.MONEY_REG_ID
         AND R.RECEIPT_ID = C_RECEIPT_ID;
  
    REC_1 CUR1%ROWTYPE;
  
    CURSOR CUR2(C_RECEIPT_ID NUMBER) IS
      SELECT R.*, (SPM_EAM_COMMON_PKG.GETDEPORGNAME(R.ORG_ID)) AS ORG_NAME
        FROM SPM_CON_RECEIPT R
       WHERE R.RECEIPT_ID = C_RECEIPT_ID;
  BEGIN
  
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
        --获取对应银行
        SELECT BB.BANK_BRANCH_NAME
          INTO V_BANK_NAME
          FROM CE.CE_BANK_ACCOUNTS   T,
               CE_BANK_ACCT_USES_ALL T2,
               CE_BANK_BRANCHES_V    BB
         WHERE T2.BANK_ACCOUNT_ID = T.BANK_ACCOUNT_ID
           AND T.BANK_BRANCH_ID = BB.BRANCH_PARTY_ID
           AND T2.ORG_ID = SPM_SSO_PKG.GETORGID
           AND T.BANK_ACCOUNT_NUM = REC_1.PAYMENT_ACCOUNT;
      
        L_IFACE_REC.CUSTOMER_NAME := TRIM(REC_1.ACCOUNT_NAME);
      
        L_IFACE_REC.BANK_BRANCH_NAME := V_BANK_NAME;
        L_IFACE_REC.BANK_ACCOUNT_NUM := REC_1.PAYMENT_ACCOUNT;
        DBMS_OUTPUT.PUT_LINE(TRIM(REC_1.ACCOUNT_NAME));
      
        FOR REC_2 IN CUR2(V_ID) LOOP
        
          -- L_IFACE_REC.RECEIPT_METHODS         := REC_2.Collection_Method;
          --L_IFACE_REC.DEPOSIT_DATE            := REC_2.COLLECTION_DATE;
          --L_IFACE_REC.ORG_NAME                := REC_2.;--现金流
          L_IFACE_REC.ORG_NAME               := REC_2.ORG_NAME; --组织名称
          L_IFACE_REC.RECEIPT_NUMBER         := V_ID; --收款编号，未安装EBS规则
          L_IFACE_REC.CURRENCY_CODE          := UPPER('CNY'); --币种取
          L_IFACE_REC.AMOUNT                 := REC_2.RMB_TOTAL; --以人民币传入
          L_IFACE_REC.TYPE                   := UPPER('STANDARD'); --合同侧只有标准类型，没有杂项
          L_IFACE_REC.RECEIPT_DATE           := REC_2.CREATION_DATE;
          L_IFACE_REC.GL_DATE                := REC_2.GL_DATE;
          L_IFACE_REC.MATURITY_DATE          := REC_2.GL_DATE; --取总账日期
          L_IFACE_REC.FACTOR_DISCOUNT_AMOUNT := 0; --手续费默认取0
          /*                  L_IFACE_REC.EXCHANGE_RATE_TYPE      := 'User';
          L_IFACE_REC.EXCHANGE_RATE           := 1;
          L_IFACE_REC.EXCHANGE_DATE           := REC_2.CREATION_DATE;*/
          L_IFACE_REC.CREATION_DATE     := REC_2.CREATION_DATE;
          L_IFACE_REC.CREATED_BY        := REC_2.CREATED_BY;
          L_IFACE_REC.LAST_UPDATE_DATE  := REC_2.LAST_UPDATE_DATE;
          L_IFACE_REC.LAST_UPDATED_BY   := REC_2.LAST_UPDATED_BY;
          L_IFACE_REC.LAST_UPDATE_LOGIN := REC_2.LAST_UPDATE_LOGIN;
          L_IFACE_REC.PROCESS_STATUS    := UPPER('PENDING');
        
          INSERT INTO CUX.CUX_AR_RECEIPTS VALUES L_IFACE_REC;
        END LOOP;
        COMMIT;
      END;
      BEGIN
        CUX_AR_RECEIPT_PKG.IMPORT_AR_RECEIPT(ERRBUF           => V_RETURN_MESSAGE,
                                             RETCODE          => V_RETURN_CODE,
                                             P_RECEIPT_NUMBER => V_ID);
      END;
    ELSE
      CLOSE CUR1;
    END IF;
  END SPM_CON_AR_RECEIPT;
  --根据十段获取科目组合ID
  FUNCTION GET_CODE_COMBINATION_ID(P_CONCATENATED_SEGMENTS IN VARCHAR2)
    RETURN NUMBER IS
    L_CCID             NUMBER;
    L_STRUCTURE_NUMBER NUMBER;
  BEGIN
    SELECT T.CHART_OF_ACCOUNTS_ID
      INTO L_STRUCTURE_NUMBER
      FROM GL_LEDGERS T
     WHERE ROWNUM = 1;
    L_CCID := FND_FLEX_EXT.GET_CCID('SQLGL',
                                    'GL#',
                                    L_STRUCTURE_NUMBER,
                                    TO_CHAR(SYSDATE, 'yyyy/dd hh24:mi:ss'),
                                    P_CONCATENATED_SEGMENTS);
    RETURN L_CCID;
  END GET_CODE_COMBINATION_ID;

  --获取预付款的科目组合
  FUNCTION GET_SEGMENT_FOR_IMPREST(V_ID   NUMBER,
                                   V_TYPE VARCHAR2 DEFAULT 'PRE')
    RETURN VARCHAR2 IS
    I_CCID                  NUMBER;
    V_SE_1                  VARCHAR2(40) := '00'; -- 公司段
    V_SE_2                  VARCHAR2(40) := '00'; -- 部门段
    V_SE_3                  VARCHAR2(40) := '00'; -- 科目段
    V_SE_9                  VARCHAR2(40) := '00'; -- 银行段
    V_SE_10                 VARCHAR2(40) := '00'; -- 辅助段
    V_SE_4                  VARCHAR2(40) := '00'; -- 往来段
    V_SE_5                  VARCHAR2(40) := '00'; -- 项目段
    V_SE_6                  VARCHAR2(40) := '00'; -- 机组段
    V_SE_7                  VARCHAR2(40) := '00'; -- 产品段
    V_SE_8                  VARCHAR2(40) := '00'; -- 预留段
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    TYPE INVOICE_TAB IS TABLE OF SPM_CON_INPUT_INVOICE%ROWTYPE INDEX BY BINARY_INTEGER;
    INVOICE_DATA INVOICE_TAB;
  BEGIN
  
    SELECT * BULK COLLECT
      INTO INVOICE_DATA
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = V_ID;
    --根据供应商地点获取SEGMENT1,SEGMENT3
    BEGIN
      IF V_TYPE = 'PRE' THEN
        SELECT A.PREPAY_CODE_COMBINATION_ID
          INTO I_CCID
          FROM PO_VENDOR_SITES_ALL A
         WHERE A.VENDOR_SITE_ID = INVOICE_DATA(1).VENDOR_SITE_ID;
      ELSIF V_TYPE = 'ACCTS' THEN
        SELECT A.ACCTS_PAY_CODE_COMBINATION_ID
          INTO I_CCID
          FROM PO_VENDOR_SITES_ALL A
         WHERE A.VENDOR_SITE_ID = INVOICE_DATA(1).VENDOR_SITE_ID;
      END IF;
      SELECT SEGMENT1, SEGMENT3
        INTO V_SE_1, V_SE_3
        FROM GL_CODE_COMBINATIONS G
       WHERE G.CODE_COMBINATION_ID = I_CCID;
    EXCEPTION
      WHEN OTHERS THEN
        V_SE_1 := '00';
        V_SE_3 := '00';
        DBMS_OUTPUT.PUT_LINE('获取供应商地点科目组合异常：');
    END;
    -- 获取部门段
    BEGIN
      V_SE_2 := INVOICE_DATA(1).EBS_DEPT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_SE_2 := '00';
        DBMS_OUTPUT.PUT_LINE('获取部门段异常：');
    END;
    --根据供应商名称获取往来段
    --获取供应商名称
    BEGIN
      /*修改往来段段值的方法 BY mcq 通过EBS侧维护的弹性域4*/
    
      SELECT PV.ATTRIBUTE4
        INTO V_SE_4
        FROM SPM_CON_VENDOR_INFO VI, PO_VENDORS PV
       WHERE VI.VENDOR_CODE = PV.SEGMENT1
         AND VI.VENDOR_ID = INVOICE_DATA(1).VENDOR_ID;
      /*
      SELECT V.FLEX_VALUE
        INTO V_SE_4
        FROM FND_FLEX_VALUES_VL V, SPM_CON_VENDOR_INFO I
       WHERE 1 = 1
         AND FLEX_VALUE_SET_ID =
             (SELECT F.FLEX_VALUE_SET_ID
                FROM FND_FLEX_VALUE_SETS F
               WHERE F.FLEX_VALUE_SET_NAME = 'DT 往来')
         AND V.ENABLED_FLAG = 'Y'
         AND V.DESCRIPTION = I.VENDOR_NAME
         AND I.VENDOR_ID = INVOICE_DATA(1).VENDOR_ID;*/
    
    EXCEPTION
      WHEN OTHERS THEN
        V_SE_4 := '00';
        DBMS_OUTPUT.PUT_LINE('获取往来段异常：');
    END;
    --项目段
    --可能会出现查不到数据的情况
    BEGIN
      SELECT P.PROJECT_CODE
        INTO V_SE_5
        FROM SPM_CON_PROJECT P
       WHERE P.PROJECT_ID = INVOICE_DATA(1).PROJECT_ID;
    
    EXCEPTION
      WHEN OTHERS THEN
        V_SE_5 := '00';
        DBMS_OUTPUT.PUT_LINE('获取项目段异常：');
    END;
    --拼接账户
    SELECT (V_SE_1 || '.' || V_SE_2 || '.' || V_SE_3 || '.' || V_SE_9 || '.' ||
           V_SE_10 || '.' || V_SE_4 || '.' || V_SE_5 || '.' || V_SE_6 || '.' ||
           V_SE_7 || '.' || V_SE_8)
      INTO V_CONCATENATED_SEGMENTS
      FROM DUAL;
  
    RETURN V_CONCATENATED_SEGMENTS;
  END GET_SEGMENT_FOR_IMPREST;

  --获取服务类进项发票的科目组合
  FUNCTION GET_SEGMENT_FOR_INPUT_F(V_ITEM_ID NUMBER) RETURN VARCHAR2 IS
    I_CCID                  NUMBER;
    V_SE_1                  VARCHAR2(40) := '00'; -- 公司段
    V_SE_2                  VARCHAR2(40) := '00'; -- 部门段
    V_SE_3                  VARCHAR2(40) := '00'; -- 科目段
    V_SE_9                  VARCHAR2(40) := '00'; -- 银行段
    V_SE_10                 VARCHAR2(40) := '00'; -- 辅助段
    V_SE_4                  VARCHAR2(40) := '00'; -- 往来段
    V_SE_5                  VARCHAR2(40) := '00'; -- 项目段
    V_SE_6                  VARCHAR2(40) := '00'; -- 机组段
    V_SE_7                  VARCHAR2(40) := '00'; -- 产品段
    V_SE_8                  VARCHAR2(40) := '00'; -- 预留段
    V_ORG_ID                NUMBER;
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    TYPE LINE_TAB IS TABLE OF SPM_CON_INPUT_WAREHOUSE%ROWTYPE INDEX BY BINARY_INTEGER;
    LINE_DATA LINE_TAB;
  BEGIN
  
    SELECT * BULK COLLECT
      INTO LINE_DATA
      FROM SPM_CON_INPUT_WAREHOUSE W
     WHERE W.INPUT_WAREHOUSE_ID = V_ITEM_ID;
  
    BEGIN
      --根据主表数据获取SEGMENT1,SEGMENT3
      SELECT I.ORG_ID
        INTO V_ORG_ID
        FROM SPM_CON_INPUT_INVOICE I, SPM_CON_INPUT_WAREHOUSE W
       WHERE I.INPUT_INVOICE_ID = W.INPUT_INVOICE_ID
         AND W.INPUT_WAREHOUSE_ID = V_ITEM_ID;
    
      SELECT U.SHORT_CODE
        INTO V_SE_1
        FROM HR_OPERATING_UNITS U
       WHERE U.ORGANIZATION_ID = V_ORG_ID;
    
      IF V_SE_1 IS NULL THEN
        V_SE_1 := '00';
      END IF;
    
      --部门段,科目段，往来段，项目段，产品段,银行段
      IF LINE_DATA(1).DEPT_SEC IS NOT NULL THEN
        V_SE_2 := LINE_DATA(1).DEPT_SEC;
      END IF;
    
      --科目
      IF LINE_DATA(1).SUB_SEC IS NOT NULL THEN
        V_SE_3 := LINE_DATA(1).SUB_SEC;
      END IF;
    
      --往来
      IF LINE_DATA(1).DEALINGS_SEC IS NOT NULL THEN
        V_SE_4 := LINE_DATA(1).DEALINGS_SEC;
      END IF;
    
      --项目
      IF LINE_DATA(1).PROJECT_SEC IS NOT NULL THEN
        V_SE_5 := LINE_DATA(1).PROJECT_SEC;
      END IF;
    
      --产品
      IF LINE_DATA(1).PRODUCT_SEC IS NOT NULL THEN
        V_SE_7 := LINE_DATA(1).PRODUCT_SEC;
      END IF;
    
      --银行
      IF LINE_DATA(1).BANK_SEC IS NOT NULL THEN
        V_SE_9 := LINE_DATA(1).BANK_SEC;
      END IF;
    
      --辅助
      IF LINE_DATA(1).ASSIST_SEC IS NOT NULL THEN
        V_SE_10 := LINE_DATA(1).ASSIST_SEC;
      END IF;
      /*SELECT LINE_DATA(1).DEPT_SEC,
             LINE_DATA(1).SUB_SEC,
             LINE_DATA(1).DEALINGS_SEC,
             LINE_DATA(1).PROJECT_SEC,
             LINE_DATA(1).PRODUCT_SEC,
             LINE_DATA(1).BANK_SEC
        INTO V_SE_2, V_SE_3, V_SE_4, V_SE_5, V_SE_7, V_SE_9
        FROM DUAL;
      EXCEPTION WHEN OTHERS THEN V_SE_2 := '00'; V_SE_3 := '00'; V_SE_4 := '00'; V_SE_5 := '00'; V_SE_7 := '00'; V_SE_9 := '00';*/
    END;
  
    --拼接账户
    SELECT (V_SE_1 || '.' || V_SE_2 || '.' || V_SE_3 || '.' || V_SE_9 || '.' ||
           V_SE_10 || '.' || V_SE_4 || '.' || V_SE_5 || '.' || V_SE_6 || '.' ||
           V_SE_7 || '.' || V_SE_8)
      INTO V_CONCATENATED_SEGMENTS
      FROM DUAL;
  
    RETURN V_CONCATENATED_SEGMENTS;
  END GET_SEGMENT_FOR_INPUT_F;

  --发票验证通用方法
  PROCEDURE SPM_CON_APPROVE_INVOICE(A_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2) IS
    V_INVOICE_NUMBER VARCHAR2(50);
    V_INVOICE_ID     NUMBER;
    V_TYPE_CODE      VARCHAR2(40);
    V_ORG_ID         NUMBER;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    SELECT I.INVOICE_CODE, I.ORG_ID
      INTO V_INVOICE_NUMBER, V_ORG_ID
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = A_ID;
    SELECT A.INVOICE_ID, A.INVOICE_TYPE_LOOKUP_CODE
      INTO V_INVOICE_ID, V_TYPE_CODE
      FROM AP_INVOICES_ALL A
     WHERE A.INVOICE_NUM = V_INVOICE_NUMBER;
    --验证AP发票
    CUX_AP_INVOICE_INTF_PKG.P_VALIDATE_IMPORTED_INVOICES(P_INVOIE_ID     => V_INVOICE_ID,
                                                         P_ORG_ID        => V_ORG_ID,
                                                         X_STATUS        => A_RETURN_CODE,
                                                         X_ERROR_MESSAGE => A_RETURN_MSG);
  
  END SPM_CON_APPROVE_INVOICE;

  --创建会计科目
  PROCEDURE SPM_CON_CREATE_ACCOUNIT(V_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2) IS
    V_INVOICE_ID NUMBER;
    V_MODE       VARCHAR2(40) := 'P';
    V_ORG_ID     NUMBER;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --查询对应发票ID
    SELECT A.INVOICE_ID, I.ORG_ID
      INTO V_INVOICE_ID, V_ORG_ID
      FROM AP_INVOICES_ALL A, SPM_CON_INPUT_INVOICE I
     WHERE A.INVOICE_NUM = I.INVOICE_CODE
       AND I.INPUT_INVOICE_ID = V_ID;
    --创建会计科目
    /*                     p_accounting_mode： 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*/
    CUX_AP_INVOICE_INTF_PKG.P_AP_INVOICE_ACCOUNT(P_INVOICE_ID      => V_INVOICE_ID,
                                                 P_ACCOUNTING_MODE => V_MODE,
                                                 P_ORG_ID          => V_ORG_ID,
                                                 X_STATUS          => A_RETURN_CODE,
                                                 X_ERROR_MESSAGE   => A_RETURN_MSG);
  END SPM_CON_CREATE_ACCOUNIT;

  --根据进项发票的ID获取税分类代码
  FUNCTION GET_TAX_COMBINATION_ID(V_ID NUMBER) RETURN NUMBER IS
    I_CCID                  NUMBER;
    V_ORG_ID                NUMBER;
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    V_SE_1                  VARCHAR2(40) := '00'; -- 公司段
    V_SE_2                  VARCHAR2(40) := '00'; -- 部门段
    V_SE_3                  VARCHAR2(40) := '2221010101'; -- 科目段，税科目
    V_SE_9                  VARCHAR2(40) := '00'; -- 银行段
    V_SE_10                 VARCHAR2(40) := '00'; -- 辅助段
    V_SE_4                  VARCHAR2(40) := '00'; -- 往来段
    V_SE_5                  VARCHAR2(40) := '00'; -- 项目段
    V_SE_6                  VARCHAR2(40) := '00'; -- 机组段
    V_SE_7                  VARCHAR2(40) := '00'; -- 产品段
    V_SE_8                  VARCHAR2(40) := '00'; -- 预留段
    V_TAX_NAME              VARCHAR2(40);
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_TAX_CODE',
                                                   I.TAX_RATE),
           I.ORG_ID,
           I.EBS_TAX_SUB_CODE
      INTO V_TAX_NAME, V_ORG_ID, V_SE_3
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = V_ID;
  
    --根据税科目和辅助段描述确定辅助段值
    SELECT V.FLEX_VALUE
      INTO V_SE_10
      FROM FND_FLEX_VALUES_VL V
     WHERE V.FLEX_VALUE_SET_ID =
           (SELECT F.FLEX_VALUE_SET_ID
              FROM FND_FLEX_VALUE_SETS F
             WHERE F.FLEX_VALUE_SET_NAME = 'DT 辅助')
       AND V.ENABLED_FLAG = 'Y'
       AND V.SUMMARY_FLAG = 'N'
       AND V.FLEX_VALUE != '00'
       AND (PARENT_FLEX_VALUE_LOW = '2221010101')
       AND V.DESCRIPTION = V_TAX_NAME
     ORDER BY FLEX_VALUE;
  
    --获取公司段
    SELECT U.SHORT_CODE
      INTO V_SE_1
      FROM HR_OPERATING_UNITS U
     WHERE U.ORGANIZATION_ID = V_ORG_ID;
    --拼接组合
    SELECT (V_SE_1 || '.' || V_SE_2 || '.' || V_SE_3 || '.' || V_SE_9 || '.' ||
           V_SE_10 || '.' || V_SE_4 || '.' || V_SE_5 || '.' || V_SE_6 || '.' ||
           V_SE_7 || '.' || V_SE_8)
      INTO V_CONCATENATED_SEGMENTS
      FROM DUAL;
    --获取组合ID
    I_CCID := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
    RETURN I_CCID;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 00;
  END GET_TAX_COMBINATION_ID;

  --根据SPM侧项目ID获取对应EBS侧的项目段即项目编号
  FUNCTION GET_EBS_PROJECT_CODE(V_PROJECT_ID NUMBER) RETURN VARCHAR2 IS
    V_SE_5 VARCHAR2(40); --项目段
  BEGIN
    SELECT A.SEGMENT1
      INTO V_SE_5
      FROM SPM_CON_PROJECT P, PA_PROJECTS_ALL A
     WHERE P.PROJECT_CODE = A.SEGMENT1
       AND P.PROJECT_ID = V_PROJECT_ID;
  
    RETURN V_SE_5;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '00';
  END;

  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_TRX_ACCOUNIT(V_ID          IN NUMBER,
                                    V_USER_ID     IN NUMBER,
                                    V_RESP_ID     IN NUMBER,
                                    V_RESP_APP_ID IN NUMBER,
                                    A_RETURN_CODE OUT VARCHAR2,
                                    A_RETURN_MSG  OUT VARCHAR2) IS
    V_INVOICE_ID NUMBER;
    V_MODE       VARCHAR2(40) := 'P';
    V_ORG_ID     NUMBER;
  BEGIN
    -- 模拟登录
    FND_GLOBAL.APPS_INITIALIZE(USER_ID      => V_USER_ID,
                               RESP_ID      => V_RESP_ID,
                               RESP_APPL_ID => V_RESP_APP_ID);
  
    --查询对应发票ID
    SELECT A.CUSTOMER_TRX_ID, I.ORG_ID
      INTO V_INVOICE_ID, V_ORG_ID
      FROM RA_CUSTOMER_TRX_ALL A, SPM_CON_OUTPUT_INVOICE I
     WHERE A.TRX_NUMBER = I.INVOICE_CODE
       AND I.OUTPUT_INVOICE_ID = V_ID;
    --创建会计科目
    /*                     p_accounting_mode： 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*/
    CUX_AR_RECEIPT_PKG.P_AR_TRX_ACCOUNT(P_CUSTOMER_TRX_ID => V_INVOICE_ID,
                                        P_ACCOUNTING_MODE => V_MODE,
                                        P_ORG_ID          => V_ORG_ID,
                                        X_STATUS          => A_RETURN_CODE,
                                        X_ERROR_MESSAGE   => A_RETURN_MSG);
  END SPM_CON_AR_TRX_ACCOUNIT;

  --AR红冲发票创建会计科目
  PROCEDURE SPM_CON_AR_RETURN_TRX_ACCOUNIT(V_ID          IN NUMBER,
                                           A_RETURN_CODE OUT VARCHAR2,
                                           A_RETURN_MSG  OUT VARCHAR2) IS
    V_INVOICE_ID NUMBER;
    V_MODE       VARCHAR2(40) := 'P';
    V_ORG_ID     NUMBER;
  BEGIN
  
    --查询对应发票ID
    SELECT A.CUSTOMER_TRX_ID, I.ORG_ID
      INTO V_INVOICE_ID, V_ORG_ID
      FROM RA_CUSTOMER_TRX_ALL A, SPM_CON_RETURN_INVOICE I
     WHERE A.TRX_NUMBER = I.RETURN_CODE
       AND I.RETURN_INVOICE_ID = V_ID;
    --创建会计科目
    /*                     p_accounting_mode： 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*/
    CUX_AR_RECEIPT_PKG.P_AR_TRX_ACCOUNT(P_CUSTOMER_TRX_ID => V_INVOICE_ID,
                                        P_ACCOUNTING_MODE => V_MODE,
                                        P_ORG_ID          => V_ORG_ID,
                                        X_STATUS          => A_RETURN_CODE,
                                        X_ERROR_MESSAGE   => A_RETURN_MSG);
  END SPM_CON_AR_RETURN_TRX_ACCOUNIT;
  --付款创建会计科目
  PROCEDURE SPM_CON_AP_PAY_ACCOUNT(V_ID          IN NUMBER,
                                   A_RETURN_CODE OUT VARCHAR2,
                                   A_RETURN_MSG  OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_PAYMENT_ID NUMBER;
    V_CHECK_ID   NUMBER;
    V_MODE       VARCHAR2(40) := 'P';
    V_ORG_ID     NUMBER;
  BEGIN
  
    --查询对应发票ID
    SELECT A.CHECK_ID, P.ORG_ID
      INTO V_CHECK_ID, V_ORG_ID
      FROM AP_CHECKS_ALL A, SPM_CON_PAYMENT P
     WHERE A.CHECK_NUMBER = TO_NUMBER(SUBSTR(P.PAYMENT_CODE, 3))
       AND P.PAYMENT_ID = V_ID;
  
    SELECT P.INVOICE_PAYMENT_ID
      INTO V_PAYMENT_ID
      FROM AP_INVOICE_PAYMENTS_ALL P
     WHERE P.CHECK_ID = V_CHECK_ID;
  
    --创建会计科目
    /*                     p_accounting_mode： 'D' --创建到拟定
    'F' --创建到最终
    'P' --创建到最终过账*/
    CUX_AR_RECEIPT_PKG.P_AP_PAY_ACCOUNT(P_INVOICE_PAYMENT_ID => V_PAYMENT_ID,
                                        P_ACCOUNTING_MODE    => V_MODE,
                                        P_ORG_ID             => V_ORG_ID,
                                        X_STATUS             => A_RETURN_CODE,
                                        X_ERROR_MESSAGE      => A_RETURN_MSG);
  EXCEPTION
    WHEN OTHERS THEN
    
      A_RETURN_CODE := G_INTERFACE_ERROR;
      A_RETURN_MSG  := '未查询到对应数据';
    
  END SPM_CON_AP_PAY_ACCOUNT;

  /*--销项发票核销收款单
  PROCEDURE SPM_CON_AR_IMPREST(V_ID             IN NUMBER,
                               V_RETURN_CODE    OUT VARCHAR2,
                               V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXIST       NUMBER;
    V_BANK_NAME    VARCHAR2(40);
    L_IFACE_INV    CUX.CUX_AR_RECEIPT_APPLIES%ROWTYPE;
    INVOICE_ID     NUMBER;
    receipt_number VARCHAR2(40);
  
    CURSOR CUR1(C_INVOICE_ID NUMBER) IS
      SELECT C.RECEIPT_CODE,
             (SELECT E.INVOICE_CODE
                FROM SPM_CON_OUTPUT_INVOICE E
               WHERE E.OUTPUT_INVOICE_ID =
                     (SELECT O.OUTPUT_INVOICE_ID
                        FROM SPM_CON_RECEIPT_INVOICE O
                       WHERE O.OUTPUT_INVOICE_ID = C_INVOICE_ID)) INVOICE_CODE,
             I.CREATION_DATE,
             I.MONEY_AMOUNT,
             I.CREATED_BY,
             I.LAST_UPDATED_BY,
             I.LAST_UPDATE_DATE
        FROM SPM_CON_RECEIPT C, SPM_CON_RECEIPT_INVOICE I
       WHERE C.RECEIPT_ID = I.RECEIPT_ID
         AND I.OUTPUT_INVOICE_ID = C_INVOICE_ID;
  
    REC_1 CUR1%ROWTYPE;
    CURSOR CUR2(C_INVOICE_ID NUMBER) IS
      SELECT R.*, (SPM_EAM_COMMON_PKG.getDepOrgName(R.ORG_ID)) AS ORG_NAME
        FROM SPM_CON_RECEIPT_INVOICE R
       WHERE R.OUTPUT_INVOICE_ID = C_INVOICE_ID;
  BEGIN
    SELECT E.OUTPUT_INVOICE_ID
      INTO INVOICE_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.OUTPUT_INVOICE_ID = V_ID;
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
        L_IFACE_INV.RECEIPT_NUMBER   := REC_1.RECEIPT_CODE;
        L_IFACE_INV.TRX_NUMBER       := REC_1.INVOICE_CODE;
        L_IFACE_INV.APPLY_DATE       := REC_1.CREATION_DATE;
        L_IFACE_INV.GL_DATE          := REC_1.CREATION_DATE;
        L_IFACE_INV.AMOUNT_APPLIED   := REC_1.MONEY_AMOUNT;
        L_IFACE_INV.CREATION_DATE    := REC_1.CREATION_DATE;
        L_IFACE_INV.DOCUMENT_NUM     := REC_1.INVOICE_CODE;
        L_IFACE_INV.LAST_UPDATE_DATE := REC_1.LAST_UPDATE_DATE;
        L_IFACE_INV.LAST_UPDATED_BY  := REC_1.LAST_UPDATED_BY;
        L_IFACE_INV.PROCESS_STATUS   := UPPER('PENDING');
        L_IFACE_INV.Created_By       := REC_1.CREATED_BY;
        receipt_number               := REC_1.RECEIPT_CODE;
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
        cux_ar_receipt_apply_pkg.ar_receipt_apply(errbuf           => V_RETURN_MESSAGE,
                                                  retcode          => V_RETURN_CODE,
                                                  P_RECEIPT_NUMBER => receipt_number);
      END;
    ELSE
      CLOSE CUR1;
    END IF;
  END SPM_CON_AR_IMPREST;
  
  --销项发票创建核销会计科目
  PROCEDURE SPM_CON_AR_IMPREST_ACCOUNIT(V_ID          IN NUMBER,
                                        A_return_code OUT VARCHAR2,
                                        A_RETURN_MSG  OUT VARCHAR2) IS
  
    V_RECEIPT_ID                NUMBER;
    EBS_RECEIPT_ID              NUMBER;
    V_INVOICE_ID                NUMBER;
    EBS_INVOICE_ID              NUMBER;
    l_receivable_application_id NUMBER;
    V_MODE                      VARCHAR2(40) := 'P';
    v_org_id                    number;
  BEGIN
    --查询ORG_ID
    SELECT E.ORG_ID
      INTO V_ORG_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.OUTPUT_INVOICE_ID = V_ID;
    --查询spm侧收款ID，销项发票ID
    SELECT E.RECEIPT_ID, E.OUTPUT_INVOICE_ID
      INTO V_RECEIPT_ID, V_INVOICE_ID
      FROM SPM_CON_RECEIPT_INVOICE E
     WHERE E.OUTPUT_INVOICE_ID = V_ID;
    --查询EBS侧收款ID
    select L.CASH_RECEIPT_ID
      INTO EBS_RECEIPT_ID
      from ar.ar_cash_receipts_all L, SPM_CON_RECEIPT T
     WHERE T.RECEIPT_CODE = L.RECEIPT_NUMBER
       AND t.receipt_id = V_RECEIPT_ID;
    --查询EBS侧发票ID
    select t.customer_trx_id
      into EBS_INVOICE_ID
      from ar.ra_customer_trx_all t, spm_con_output_invoice e
     where t.trx_number = e.invoice_code
       and e.output_invoice_id = V_INVOICE_ID;
    --查询对应发票ID
    SELECT receivable_application_id
      INTO l_receivable_application_id
      FROM ar_receivable_applications_all
     WHERE cash_receipt_id = EBS_RECEIPT_ID
       AND applied_customer_trx_id = EBS_INVOICE_ID
       AND status = 'APP'
       AND display = 'Y';
    \*--创建会计科目
                    p_accounting_mode:= 'D' --创建到拟定
    'F' --创建到最终
     'P' --创建到最终过账*\
    cux_ar_receipt_pkg.P_ar_cash_account(P_CASH_RECEIPT_ID => l_receivable_application_id,
                                         p_accounting_mode => V_MODE,
                                         p_org_id          => v_org_id,
                                         X_STATUS          => A_return_code,
                                         X_ERROR_MESSAGE   => A_RETURN_MSG);
  END SPM_CON_AR_IMPREST_ACCOUNIT;*/

  --查询对应的往来段

  -- 检查用户是否有导入EBS权限
  FUNCTION CHECK_SYNC_PERMISSIONS(V_ID NUMBER) RETURN VARCHAR2 IS
    PERMISSION VARCHAR2(40); --导入权限
    V_FLAG     VARCHAR2(40); --返回状态
  BEGIN
    SELECT P.IMPORT_PERMISSIONS
      INTO PERMISSION
      FROM SPM_CON_EBS_PEOPLE_V P
     WHERE P.USER_ID = V_ID
       AND ROWNUM = 1;
  
    IF PERMISSION IS NOT NULL AND PERMISSION = 'Y' THEN
      V_FLAG := 'S';
    ELSE
      V_FLAG := 'F';
    END IF;
    RETURN V_FLAG;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'F';
    
  END CHECK_SYNC_PERMISSIONS;

  -- 检查用户是否有导入EBS权限
  FUNCTION CHECK_SYNC_PERMISSIONS(P_USER_ID NUMBER, P_ORG_ID NUMBER)
    RETURN VARCHAR2 IS
    PERMISSION VARCHAR2(40); --导入权限
    V_FLAG     VARCHAR2(40); --返回状态
  BEGIN
    SELECT P.IMPORT_PERMISSIONS
      INTO PERMISSION
      FROM SPM_CON_EBS_PEOPLE_V P
     WHERE P.USER_ID = P_USER_ID
       AND P.org_id = P_ORG_ID
       AND ROWNUM = 1;
  
    IF PERMISSION IS NOT NULL AND PERMISSION = 'Y' THEN
      V_FLAG := 'S';
    ELSE
      V_FLAG := 'F';
    END IF;
    RETURN V_FLAG;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'F';
    
  END CHECK_SYNC_PERMISSIONS;

  --组装查看总账凭证路径
  PROCEDURE FIND_GLPZ_URL(V_ID         IN NUMBER,
                          V_TYPE       IN VARCHAR2,
                          V_RETURN_URL OUT VARCHAR2) IS
    V_BATCH_IDS VARCHAR2(100) := '';
    V_URL       VARCHAR2(400);
    VCURR_URL   VARCHAR2(50);
    CURSOR CUR1(V_ID NUMBER, V_TYPE VARCHAR2) IS
      SELECT DISTINCT JH.JE_HEADER_ID
        FROM GL_JE_LINES                  JL,
             GL_IMPORT_REFERENCES         GIR,
             XLA_AE_LINES                 XAL,
             XLA_AE_HEADERS               XAH,
             XLA.XLA_TRANSACTION_ENTITIES XTE,
             GL_JE_BATCHES                JB,
             GL_JE_HEADERS                JH
       WHERE 1 = 1
            
         AND JH.JE_BATCH_ID = JB.JE_BATCH_ID
         AND JH.JE_HEADER_ID = JL.JE_HEADER_ID
         AND JL.JE_HEADER_ID = GIR.JE_HEADER_ID
         AND JL.JE_LINE_NUM = GIR.JE_LINE_NUM
         AND GIR.GL_SL_LINK_ID = XAL.GL_SL_LINK_ID
         AND GIR.GL_SL_LINK_TABLE = XAL.GL_SL_LINK_TABLE
         AND XAL.APPLICATION_ID = XAH.APPLICATION_ID
         AND XAL.AE_HEADER_ID = XAH.AE_HEADER_ID
         AND XAH.APPLICATION_ID = XTE.APPLICATION_ID
            --AND XAH.GL_TRANSFER_STATUS_CODE = 'Y' --已过账
         AND XAL.DISPLAYED_LINE_NUMBER > 0 --判断是否废弃
         AND XAH.ENTITY_ID = XTE.ENTITY_ID
         AND XTE.ENTITY_CODE = V_TYPE
         AND XTE.SOURCE_ID_INT_1 = V_ID;
  
  BEGIN
    VCURR_URL := FND_PROFILE.VALUE('APPS_SERVLET_AGENT');
  
    --1.根据子分类数据源ID获取对应总账批ID
    FOR REC_1 IN CUR1(V_ID, V_TYPE) LOOP
      V_BATCH_IDS := V_BATCH_IDS || ';' || REC_1.JE_HEADER_ID;
    END LOOP;
  
    /*    V_URL := SPM_SSO_PKG.get_run_ebs_function_url('SPM_R1_PZDY','pProcParam1='||SUBSTR(V_BATCH_IDS, 2));
    */ /*    V_URL        := vcurr_Url ||
                                                                                                                                                                                                                                                                                                                                                                    '/OA.jsp?OAFunc=CUX_OAF_PRINT&CuxPEO=PZSINGL&CuxPType=xsl&CuxPDatasouce=plsql&pProcParam1=' ||
                                                                                                                                                                                                                                                                                                                                                                    SUBSTR(V_BATCH_IDS, 2) || '&pProcParam2=GL';*/
    V_RETURN_URL := SUBSTR(V_BATCH_IDS, 2);
  
  END FIND_GLPZ_URL;

  --组装查看总账凭证路径
  PROCEDURE FIND_GLPZ_URL(V_IDS        IN VARCHAR2,
                          V_TYPE       IN VARCHAR2,
                          V_RETURN_URL OUT VARCHAR2) IS
    V_BATCH_IDS VARCHAR2(100) := '';
    V_URL       VARCHAR2(400);
    VCURR_URL   VARCHAR2(50);
    V_H_ID      VARCHAR2(100); --总账ID
    IDS         SPM_TYPE_TBL;
  
  BEGIN
    VCURR_URL := FND_PROFILE.VALUE('APPS_SERVLET_AGENT');
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    FOR I IN 1 .. IDS.COUNT LOOP
      SELECT LISTAGG(JE_HEADER_ID, ';') WITHIN GROUP(ORDER BY JE_HEADER_ID)
        INTO V_H_ID
        FROM (SELECT DISTINCT JH.JE_HEADER_ID
                FROM GL_JE_LINES                  JL,
                     GL_IMPORT_REFERENCES         GIR,
                     XLA_AE_LINES                 XAL,
                     XLA_AE_HEADERS               XAH,
                     XLA.XLA_TRANSACTION_ENTITIES XTE,
                     GL_JE_BATCHES                JB,
                     GL_JE_HEADERS                JH
               WHERE 1 = 1
                    
                 AND JH.JE_BATCH_ID = JB.JE_BATCH_ID
                 AND JH.JE_HEADER_ID = JL.JE_HEADER_ID
                 AND JL.JE_HEADER_ID = GIR.JE_HEADER_ID
                 AND JL.JE_LINE_NUM = GIR.JE_LINE_NUM
                 AND GIR.GL_SL_LINK_ID = XAL.GL_SL_LINK_ID
                 AND GIR.GL_SL_LINK_TABLE = XAL.GL_SL_LINK_TABLE
                 AND XAL.APPLICATION_ID = XAH.APPLICATION_ID
                 AND XAL.AE_HEADER_ID = XAH.AE_HEADER_ID
                 AND XAH.APPLICATION_ID = XTE.APPLICATION_ID
                    --AND XAH.GL_TRANSFER_STATUS_CODE = 'Y' --已过账
                 AND XAL.DISPLAYED_LINE_NUMBER > 0 --判断是否废弃
                 AND XAH.ENTITY_ID = XTE.ENTITY_ID
                 AND XTE.ENTITY_CODE = V_TYPE
                 AND XTE.SOURCE_ID_INT_1 = IDS(I));
      --1.根据子分类数据源ID获取对应总账批ID
      V_BATCH_IDS := V_BATCH_IDS || ';' || V_H_ID;
    END LOOP;
  
    /*    V_URL := SPM_SSO_PKG.get_run_ebs_function_url('SPM_R1_PZDY','pProcParam1='||SUBSTR(V_BATCH_IDS, 2));
    */ /*    V_URL        := vcurr_Url ||
                                                                                                                                                                                                                                                                                                                                                                    '/OA.jsp?OAFunc=CUX_OAF_PRINT&CuxPEO=PZSINGL&CuxPType=xsl&CuxPDatasouce=plsql&pProcParam1=' ||
                                                                                                                                                                                                                                                                                                                                                                    SUBSTR(V_BATCH_IDS, 2) || '&pProcParam2=GL';*/
    V_RETURN_URL := SUBSTR(V_BATCH_IDS, 2);
  
  END FIND_GLPZ_URL;

  --发票核销EBS
  PROCEDURE SPM_CON_AR_INVOICE_CAV(V_ID             IN NUMBER,
                                   V_RETURN_CODE    OUT VARCHAR2,
                                   V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXIST       NUMBER;
    V_BANK_NAME    VARCHAR2(40);
    L_IFACE_INV    CUX.CUX_AR_RECEIPT_APPLIES%ROWTYPE;
    INVOICE_ID     NUMBER;
    RECEIPT_NUMBER VARCHAR2(40);
  
    CURSOR CUR1(C_INVOICE_ID NUMBER) IS
      SELECT C.RECEIPT_NUMBER RECEIPT_CODE,
             I.INVOICE_CODE,
             V.CREATION_DATE,
             V.MATCH_IMPREST_AMOUNT,
             V.CREATED_BY,
             V.LAST_UPDATED_BY,
             V.LAST_UPDATE_DATE,
             V.ORG_ID,
             I.GL_DATE,
             (SPM_EAM_COMMON_PKG.GETDEPORGNAME(V.ORG_ID)) AS ORG_NAME
        FROM AR_CASH_RECEIPTS_ALL   C,
             SPM_CON_OUTPUT_VERIFIC V,
             SPM_CON_OUTPUT_INVOICE I
       WHERE C.CASH_RECEIPT_ID = V.RECEIPT_ID
         AND V.OUTPUT_INVOICE_ID = I.OUTPUT_INVOICE_ID
         AND V.OUTPUT_VERIFIC_ID = C_INVOICE_ID;
  
    REC_1 CUR1%ROWTYPE;
  BEGIN
    SELECT E.OUTPUT_INVOICE_ID
      INTO INVOICE_ID
      FROM SPM_CON_OUTPUT_VERIFIC E
     WHERE E.OUTPUT_VERIFIC_ID = V_ID;
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC_1;
    IF CUR1%FOUND THEN
      CLOSE CUR1;
      BEGIN
        L_IFACE_INV.RECEIPT_NUMBER   := REC_1.RECEIPT_CODE;
        L_IFACE_INV.TRX_NUMBER       := REC_1.INVOICE_CODE;
        L_IFACE_INV.APPLY_DATE       := REC_1.GL_DATE;
        L_IFACE_INV.GL_DATE          := REC_1.GL_DATE;
        L_IFACE_INV.AMOUNT_APPLIED   := REC_1.MATCH_IMPREST_AMOUNT;
        L_IFACE_INV.CREATION_DATE    := REC_1.CREATION_DATE;
        L_IFACE_INV.DOCUMENT_NUM     := REC_1.INVOICE_CODE;
        L_IFACE_INV.LAST_UPDATE_DATE := REC_1.LAST_UPDATE_DATE;
        L_IFACE_INV.LAST_UPDATED_BY  := REC_1.LAST_UPDATED_BY;
        L_IFACE_INV.PROCESS_STATUS   := UPPER('PENDING');
        L_IFACE_INV.CREATED_BY       := REC_1.CREATED_BY;
        RECEIPT_NUMBER               := REC_1.RECEIPT_CODE;
        L_IFACE_INV.ORG_NAME         := REC_1.ORG_NAME; --组织名称
      
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
  END SPM_CON_AR_INVOICE_CAV;
  --AR事务处理创建会计科目
  PROCEDURE SPM_CON_AR_INVOICE_ACCOUNIT(V_ID          IN NUMBER,
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
  
    --查询中间表存储的EBS侧收款ID及SPM侧销项发票ID
    SELECT E.OUTPUT_INVOICE_ID, E.RECEIPT_ID, E.ORG_ID
      INTO V_INVOICE_ID, EBS_RECEIPT_ID, V_ORG_ID
      FROM SPM_CON_OUTPUT_VERIFIC E
     WHERE E.OUTPUT_VERIFIC_ID = V_ID;
  
    --查询EBS侧发票ID
    SELECT T.CUSTOMER_TRX_ID
      INTO EBS_INVOICE_ID
      FROM AR.RA_CUSTOMER_TRX_ALL T, SPM_CON_OUTPUT_INVOICE E
     WHERE T.TRX_NUMBER = E.INVOICE_CODE
       AND E.OUTPUT_INVOICE_ID = V_INVOICE_ID;
  
    --查询对应接收ID
    SELECT RECEIVABLE_APPLICATION_ID
      INTO L_RECEIVABLE_APPLICATION_ID
      FROM AR_RECEIVABLE_APPLICATIONS_ALL
     WHERE CASH_RECEIPT_ID = EBS_RECEIPT_ID
       AND APPLIED_CUSTOMER_TRX_ID = EBS_INVOICE_ID
       AND STATUS = 'APP'
       AND DISPLAY = 'Y';
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

  --保证金签收根据到款的银行账户默认生成对应行信息
  PROCEDURE CREATE_LINE_INFO_BY_ID(GROUP_ID       IN VARCHAR2,
                                   RETURN_STATUS  OUT VARCHAR2,
                                   RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IDS            SPM_TYPE_TBL;
    V_R_ID         NUMBER(15);
    V_MONEY_AMOUNT NUMBER;
    V_L_ID         NUMBER(15);
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(GROUP_ID) INTO IDS FROM DUAL;
    FOR I IN 1 .. IDS.COUNT LOOP
      SELECT I.MONEY_REG_ID
        INTO V_R_ID
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INPUT_INVOICE_ID = IDS(I);
    
      SELECT SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL INTO V_L_ID FROM DUAL;
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
        SELECT V_L_ID,
               IDS(I),
               GL.SEGMENT2,
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
               SPM_CON_MONEY_REG              MR
         WHERE AM.REMIT_BANK_ACCT_USE_ID = CU.BANK_ACCT_USE_ID
           AND CU.BANK_ACCOUNT_ID = CA.BANK_ACCOUNT_ID
           AND AM.CASH_CCID = GL.CODE_COMBINATION_ID
           AND AM.ORG_ID = SPM_SSO_PKG.GETORGID
           AND CA.BANK_ACCOUNT_NUM = MR.RECEIPT_ACCOUNT
           AND MR.MONEY_REG_ID = V_R_ID;
    
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
               WHERE I.INPUT_INVOICE_ID = IDS(I))
       WHERE INPUT_WAREHOUSE_ID = V_L_ID;
    END LOOP;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN_STATUS  := G_INTERFACE_ERROR;
      RETURN_MESSAGE := '当前组织下无对应银行账户的科目组合！';
      DBMS_OUTPUT.PUT_LINE(RETURN_MESSAGE);
  END CREATE_LINE_INFO_BY_ID;

  -- 批量执行同步验证创建分录操作
  PROCEDURE SPM_CON_AP_INVOICE_SYNC(V_IDS            IN VARCHAR2,
                                    V_USER_ID        IN NUMBER,
                                    V_RESP_ID        IN NUMBER,
                                    V_RESP_APP_ID    IN NUMBER,
                                    V_RETURN_MESSAGE OUT VARCHAR2) IS
    J                INT := 1;
    V_INVOICE_ID     NUMBER;
    V_INVOICE_CODE   VARCHAR2(2000);
    V_INVOICE_PAYSTA VARCHAR2(2000);
    V_INVOICE_EBSSTA VARCHAR2(2000);
    V_GL_DATE        DATE;
    GL_OPEN          VARCHAR2(2000);
    ID_NUM           NUMBER;
    V_RETURN_CODE    VARCHAR2(2000);
    T_RETURN_CODE    VARCHAR2(2000);
    T_RETURN_MESSAGE VARCHAR2(4000);
    O_RETURN_MESSAGE VARCHAR2(4000);
  BEGIN
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(V_IDS) - LENGTH(REPLACE(V_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      V_RETURN_CODE    := '';
      O_RETURN_MESSAGE := '';
    
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(V_IDS, '[^,]+', 1, J))
        INTO V_INVOICE_ID
        FROM DUAL;
    
      SELECT I.INVOICE_CODE, I.PAYMENT_STATUS, I.EBS_STATUS, I.GL_DATE
        INTO V_INVOICE_CODE, V_INVOICE_PAYSTA, V_INVOICE_EBSSTA, V_GL_DATE
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INPUT_INVOICE_ID = V_INVOICE_ID;
    
      -- 判断入账日期是否符合要求
      SELECT SPM_CON_UTIL_PKG.IS_GL_DATE(V_GL_DATE) INTO GL_OPEN FROM DUAL;
      IF GL_OPEN IS NOT NULL AND GL_OPEN = 'S' THEN
        -- 判断该票据状态，并根据票据状态与返回值判断是否进行下一步操作
        IF V_INVOICE_EBSSTA IN ('N', 'E') OR V_INVOICE_EBSSTA IS NULL THEN
          BEGIN
            IF V_INVOICE_PAYSTA = 'Y' THEN
              SPM_CON_AP_INVOICE_IMP(V_ID             => V_INVOICE_ID,
                                     V_USER_ID        => V_USER_ID,
                                     V_RESP_ID        => V_RESP_ID,
                                     V_RESP_APP_ID    => V_RESP_APP_ID,
                                     V_RETURN_CODE    => T_RETURN_CODE,
                                     V_RETURN_MESSAGE => T_RETURN_MESSAGE);
            ELSE
              SPM_CON_AP_INVOICE_F_IMP(V_ID             => V_INVOICE_ID,
                                       V_USER_ID        => V_USER_ID,
                                       V_RESP_ID        => V_RESP_ID,
                                       V_RESP_APP_ID    => V_RESP_APP_ID,
                                       V_RETURN_CODE    => T_RETURN_CODE,
                                       V_RETURN_MESSAGE => T_RETURN_MESSAGE);
            END IF;
          END;
        
          IF T_RETURN_CODE IS NULL OR T_RETURN_CODE <> 'S' THEN
            T_RETURN_CODE := 'E';
          END IF;
          V_RETURN_CODE    := T_RETURN_CODE;
          O_RETURN_MESSAGE := SUBSTR(T_RETURN_MESSAGE, 0, 100);
        
          -- 执行更新操作
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.EBS_STATUS = V_RETURN_CODE, I.EBS_SYNC_DATE = SYSDATE
           WHERE I.INPUT_INVOICE_ID = V_INVOICE_ID;
        END IF;
      
        IF V_RETURN_CODE = 'S' OR V_INVOICE_EBSSTA = 'AE' THEN
          BEGIN
            SPM_CON_APPROVE_INVOICE(A_ID          => V_INVOICE_ID,
                                    V_USER_ID     => V_USER_ID,
                                    V_RESP_ID     => V_RESP_ID,
                                    V_RESP_APP_ID => V_RESP_APP_ID,
                                    A_RETURN_CODE => T_RETURN_CODE,
                                    A_RETURN_MSG  => T_RETURN_MESSAGE);
          
          END;
        
          IF T_RETURN_CODE IS NULL OR T_RETURN_CODE <> 'S' THEN
            T_RETURN_CODE := 'E';
          END IF;
          V_RETURN_CODE    := 'A' || T_RETURN_CODE;
          O_RETURN_MESSAGE := SUBSTR(T_RETURN_MESSAGE, 0, 100);
        
          -- 执行更新操作
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.EBS_STATUS = V_RETURN_CODE, I.EBS_SYNC_DATE = SYSDATE
           WHERE I.INPUT_INVOICE_ID = V_INVOICE_ID;
        END IF;
      
        IF V_RETURN_CODE = 'AS' OR V_INVOICE_EBSSTA = 'UE' THEN
          BEGIN
            SPM_CON_CREATE_ACCOUNIT(V_ID          => V_INVOICE_ID,
                                    V_USER_ID     => V_USER_ID,
                                    V_RESP_ID     => V_RESP_ID,
                                    V_RESP_APP_ID => V_RESP_APP_ID,
                                    A_RETURN_CODE => T_RETURN_CODE,
                                    A_RETURN_MSG  => T_RETURN_MESSAGE);
          
          END;
        
          IF T_RETURN_CODE IS NULL OR T_RETURN_CODE <> 'S' THEN
            T_RETURN_CODE := 'E';
          END IF;
          V_RETURN_CODE    := 'U' || T_RETURN_CODE;
          O_RETURN_MESSAGE := SUBSTR(T_RETURN_MESSAGE, 0, 100);
        
          -- 执行更新操作
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.EBS_STATUS = V_RETURN_CODE, I.EBS_SYNC_DATE = SYSDATE
           WHERE I.INPUT_INVOICE_ID = V_INVOICE_ID;
        END IF;
      
        IF V_RETURN_CODE <> 'US' THEN
          O_RETURN_MESSAGE := '发票号码为' || V_INVOICE_CODE || '的发票操作失败，原因是：' ||
                              O_RETURN_MESSAGE;
        ELSE
          O_RETURN_MESSAGE := '';
        END IF;
      ELSE
        O_RETURN_MESSAGE := '发票号码为' || V_INVOICE_CODE ||
                            '的发票操作失败，原因是：入账日期不在总账日期打开范围内';
      END IF;
    
      -- 拼接提示信息
      IF V_RETURN_MESSAGE <> '' THEN
        V_RETURN_MESSAGE := '<br />';
      END IF;
      V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
    
      J := J + 1;
    END LOOP;
  END SPM_CON_AP_INVOICE_SYNC;

  /*=================================================================
  *   批量付款匹配发票
  *   HISTORY:
  *     1.0  20180525   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_MAT_INVOICE(O_RULE           IN VARCHAR2,
                                    O_IDS            IN VARCHAR2,
                                    O_RETURN_MESSAGE OUT VARCHAR2) IS
    ID_NUM           NUMBER;
    J                INT := 1;
    I_RETURN_MESSAGE VARCHAR2(4000);
    O_ID             NUMBER;
  BEGIN
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(O_IDS) - LENGTH(REPLACE(O_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      I_RETURN_MESSAGE := '';
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(O_IDS, '[^,]+', 1, J)) INTO O_ID FROM DUAL;
      J := J + 1;
      BEGIN
        SPM_CON_BAT_MAT_RULE(V_RULE           => O_RULE,
                             V_ID             => O_ID,
                             V_RETURN_MESSAGE => I_RETURN_MESSAGE);
      
        -- 拼接提示信息
        IF O_RETURN_MESSAGE IS NOT NULL THEN
          O_RETURN_MESSAGE := O_RETURN_MESSAGE || '<br />';
        END IF;
        O_RETURN_MESSAGE := O_RETURN_MESSAGE || I_RETURN_MESSAGE;
      END;
    END LOOP;
  END;

  /*=================================================================
  *   批量付款匹配发票规则
  *   HISTORY:
  *     1.0  20180525   YSQ           CREATED
  * ===============================================================*/
  PROCEDURE SPM_CON_BAT_MAT_RULE(V_RULE           IN VARCHAR2,
                                 V_ID             IN VARCHAR2,
                                 V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    O_CONTRACT_ID    NUMBER(15);
    O_PROJECT_ID     NUMBER(15);
    O_PAYMENT_ID     NUMBER(15);
    O_PAYMENT_CODE   VARCHAR2(40);
    O_VENDOR_ID      NUMBER(15);
    O_VENDOR_SITE_ID NUMBER(15);
    O_MONEY_AMOUNT   NUMBER;
    O_PAY_DATE       DATE;
    O_ORG_ID         NUMBER(15);
    O_DEPT_ID        NUMBER(15);
    O_CREATED_BY     NUMBER(15);
    O_EBS_DEPT_CODE  VARCHAR2(40);
  
    V_SQL1 VARCHAR2(4000);
    V_SQL2 VARCHAR2(4000);
    V_SQL3 VARCHAR2(4000);
    V_SQL4 VARCHAR2(4000);
  
    V_EBS_DEPT_CODE    VARCHAR2(150); --默认核算部门
    V_NUMBER           NUMBER;
    V_NUMBER1          NUMBER;
    V_INPUT_INVOICE_ID NUMBER(15);
  
    I_CONTRACT_ID    NUMBER(15);
    I_PROJECT_ID     NUMBER(15);
    I_VENDOR_SITE_ID NUMBER(15);
    I_EBS_DEPT_CODE  VARCHAR2(40);
    I_PAYMENT_SOURCE VARCHAR2(40) := NULL;
  
    STUTAS_E VARCHAR2(2);
  BEGIN
    --默认核算部门
    SELECT S.ORG_ID, S.DEPT_ID, S.CREATED_BY
      INTO O_ORG_ID, O_DEPT_ID, O_CREATED_BY
      FROM SPM_CON_PAYMENT S
     WHERE S.PAYMENT_ID = V_ID;
  
    SELECT S.EBS_DEPT_CODE
      INTO V_EBS_DEPT_CODE
      FROM SPM_CON_EBS_PEOPLE_V S
     WHERE S.USER_ID = O_CREATED_BY
       AND S.ORG_ID = O_ORG_ID;
  
    SELECT S.CONTRACT_ID,
           S.PROJECT_ID,
           S.PAYMENT_ID,
           S.PAYMENT_CODE,
           S.VENDOR_ID,
           S.VENDOR_SITE_ID,
           NVL(S.MONEY_AMOUNT, 0),
           NVL(S.PAY_DATE, SYSDATE),
           NVL(S.EBS_DEPT_CODE, V_EBS_DEPT_CODE)
      INTO O_CONTRACT_ID,
           O_PROJECT_ID,
           O_PAYMENT_ID,
           O_PAYMENT_CODE,
           O_VENDOR_ID,
           O_VENDOR_SITE_ID,
           O_MONEY_AMOUNT,
           O_PAY_DATE,
           O_EBS_DEPT_CODE
      FROM SPM_CON_PAYMENT S
     WHERE S.PAYMENT_ID = V_ID;
  
    --基本查询条件（合同项目暂未加入基本查询条件）
    V_SQL1 := 'SELECT COUNT(*) FROM SPM_CON_INPUT_INVOICE T
                 WHERE 1 = 1 AND T.STATUS = ' || STUTAS_E ||
              ' AND T.RESIDUAL_AMOUNT = ' || O_MONEY_AMOUNT || '
                 AND T.VENDOR_ID = ' || O_VENDOR_ID || '
                 AND T.GL_DATE < ''' || O_PAY_DATE || '''
                 AND T.ORG_ID = ' || O_ORG_ID;
  
    V_SQL2 := 'SELECT T.INPUT_INVOICE_ID FROM SPM_CON_INPUT_INVOICE T
                 WHERE 1 = 1 AND T.STATUS = ' || STUTAS_E ||
              '  AND T.RESIDUAL_AMOUNT = ' || O_MONEY_AMOUNT || '
                 AND T.VENDOR_ID = ' || O_VENDOR_ID || '
                 AND T.GL_DATE < ''' || O_PAY_DATE || '''
                 AND T.ORG_ID = ' || O_ORG_ID;
  
    V_SQL3 := 'SELECT COUNT(*) FROM SPM_CON_INPUT_INVOICE T
                 WHERE 1 = 1 AND T.STATUS = ' || STUTAS_E ||
              '  AND T.RESIDUAL_AMOUNT > ' || O_MONEY_AMOUNT || '
                 AND T.VENDOR_ID = ' || O_VENDOR_ID || '
                 AND T.GL_DATE < ''' || O_PAY_DATE || '''
                 AND T.ORG_ID = ' || O_ORG_ID;
  
    V_SQL4 := 'SELECT T.INPUT_INVOICE_ID FROM SPM_CON_INPUT_INVOICE T
                 WHERE 1 = 1 AND T.STATUS = ' || STUTAS_E ||
              '  AND T.RESIDUAL_AMOUNT > ' || O_MONEY_AMOUNT || '
                 AND T.VENDOR_ID = ' || O_VENDOR_ID || '
                 AND T.GL_DATE < ''' || O_PAY_DATE || '''
                 AND T.ORG_ID = ' || O_ORG_ID;
  
    /*匹配规则A：核算部门+供应商地点 与 发票核算部门+发票供应商地点 一致 ，
    付款金额小于等于发票未付金额（仅存在一笔）*/
    IF V_RULE = 'A' THEN
      IF O_VENDOR_SITE_ID IS NULL THEN
        V_RETURN_MESSAGE := O_PAYMENT_CODE || '供应商地点为空';
        RETURN;
      END IF;
    
      V_SQL1 := V_SQL1 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE ||
                ' AND 
                             T.VENDOR_SITE_ID = ' ||
                O_VENDOR_SITE_ID;
      V_SQL2 := V_SQL2 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE ||
                ' AND 
                             T.VENDOR_SITE_ID = ' ||
                O_VENDOR_SITE_ID;
      V_SQL3 := V_SQL3 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE ||
                ' AND 
                             T.VENDOR_SITE_ID = ' ||
                O_VENDOR_SITE_ID;
      V_SQL4 := V_SQL4 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE ||
                ' AND 
                             T.VENDOR_SITE_ID = ' ||
                O_VENDOR_SITE_ID;
      /*匹配规则B：核算部门 与 发票核算部门 一致 ，
      付款金额小于等于发票未付金额（仅存在一笔）*/
    ELSIF V_RULE = 'B' THEN
      V_SQL1 := V_SQL1 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE;
      V_SQL2 := V_SQL2 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE;
      V_SQL3 := V_SQL3 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE;
      V_SQL4 := V_SQL4 || ' AND T.EBS_DEPT_CODE = ' || O_EBS_DEPT_CODE;
    
    END IF;
  
    --发票金额等于付款金额
    EXECUTE IMMEDIATE V_SQL1
      INTO V_NUMBER;
    DBMS_OUTPUT.PUT_LINE(V_SQL1);
  
    IF V_NUMBER = 1 THEN
      --金额相等发票只存在一张 
      EXECUTE IMMEDIATE V_SQL2
        INTO V_INPUT_INVOICE_ID;
      DBMS_OUTPUT.PUT_LINE(V_SQL2);
    ELSIF V_NUMBER = 0 THEN
      --不存在金额相等的发票
      --发票金额大于付款金额
      EXECUTE IMMEDIATE V_SQL3
        INTO V_NUMBER1;
      DBMS_OUTPUT.PUT_LINE(V_SQL3);
      IF V_NUMBER1 = 1 THEN
        -- 发票金额大于付款金额只存在一张
        EXECUTE IMMEDIATE V_SQL4
          INTO V_INPUT_INVOICE_ID;
        DBMS_OUTPUT.PUT_LINE(V_SQL4);
      ELSE
        -- 发票金额大于付款金额存在多张，不匹配
        V_INPUT_INVOICE_ID := NULL;
      END IF;
    ELSE
      -- 金额相等发票存在多张 不进行匹配
      V_INPUT_INVOICE_ID := NULL;
    END IF;
  
    --自动匹配出的发票仅存在一张
    IF V_INPUT_INVOICE_ID IS NOT NULL THEN
    
      SELECT S.CONTRACT_ID, S.PROJECT_ID, S.VENDOR_SITE_ID, S.EBS_DEPT_CODE
        INTO I_CONTRACT_ID, I_PROJECT_ID, I_VENDOR_SITE_ID, I_EBS_DEPT_CODE
        FROM SPM_CON_INPUT_INVOICE S
       WHERE S.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
    
      --无合同结算
      IF I_CONTRACT_ID IS NULL THEN
        I_PAYMENT_SOURCE := 'NC';
      END IF;
    
      --无工程
      IF I_PROJECT_ID IS NULL THEN
        SELECT S.PROJECT_ID
          INTO I_PROJECT_ID
          FROM SPM_CON_PROJECT S
         WHERE S.PROJECT_NAME LIKE '%无工程-%'
           AND S.ORG_ID = O_ORG_ID
           AND ROWNUM = 1;
      END IF;
    
      --生成付款-发票关联关系                  
      INSERT INTO SPM_CON_PAYMENT_INVOICE
        (PAYMENT_INVOICE_ID,
         PAYMENT_ID,
         INPUT_INVOICE_ID,
         MONEY_AMOUNT,
         REMARK,
         CREATED_BY,
         CREATION_DATE,
         ORG_ID,
         DEPT_ID)
      VALUES
        (SPM_CON_PAYMENT_INVOICE_SEQ.NEXTVAL,
         O_PAYMENT_ID,
         V_INPUT_INVOICE_ID,
         O_MONEY_AMOUNT,
         '历史数据',
         O_CREATED_BY,
         SYSDATE,
         O_ORG_ID,
         O_DEPT_ID);
      --核销发票，更新发票信息
      UPDATE SPM_CON_INPUT_INVOICE I
         SET I.RESIDUAL_AMOUNT =
             (I.RESIDUAL_AMOUNT - O_MONEY_AMOUNT)
       WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
      --更新付款单信息 
      UPDATE SPM_CON_PAYMENT S
         SET S.CONTRACT_ID    = I_CONTRACT_ID,
             S.PROJECT_ID     = I_PROJECT_ID,
             S.VENDOR_SITE_ID = I_VENDOR_SITE_ID,
             S.EBS_DEPT_CODE  = I_EBS_DEPT_CODE,
             S.PAYMENT_SOURCE = I_PAYMENT_SOURCE
       WHERE S.PAYMENT_ID = O_PAYMENT_ID;
    ELSE
    
      V_RETURN_MESSAGE := O_PAYMENT_CODE || '根据规则未查询出发票';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
    
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_MESSAGE := O_PAYMENT_CODE || '数据异常';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END;

  --根据进项发票的ID获取对应不含税差异科目代码
  FUNCTION GET_NO_TAX_DIF_COMBINATION_ID(V_ID NUMBER) RETURN NUMBER IS
    I_CCID                  NUMBER;
    V_ORG_ID                NUMBER;
    V_CONCATENATED_SEGMENTS VARCHAR2(400);
    V_SE_1                  VARCHAR2(40) := '00'; -- 公司段
    V_SE_2                  VARCHAR2(40) := '00'; -- 部门段
    V_SE_3                  VARCHAR2(40) := '140103'; -- 不含税差异科目
    V_SE_9                  VARCHAR2(40) := '00'; -- 银行段
    V_SE_10                 VARCHAR2(40) := '00'; -- 辅助段
    V_SE_4                  VARCHAR2(40) := '00'; -- 往来段
    V_SE_5                  VARCHAR2(40) := '00'; -- 项目段
    V_SE_6                  VARCHAR2(40) := '00'; -- 机组段
    V_SE_7                  VARCHAR2(40) := '00'; -- 产品段
    V_SE_8                  VARCHAR2(40) := '00'; -- 预留段
    V_TAX_NAME              VARCHAR2(40);
  BEGIN
    SELECT I.ORG_ID
      INTO V_ORG_ID
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = V_ID;
  
    --获取公司段
    SELECT U.SHORT_CODE
      INTO V_SE_1
      FROM HR_OPERATING_UNITS U
     WHERE U.ORGANIZATION_ID = V_ORG_ID;
    --拼接组合
    SELECT (V_SE_1 || '.' || V_SE_2 || '.' || V_SE_3 || '.' || V_SE_9 || '.' ||
           V_SE_10 || '.' || V_SE_4 || '.' || V_SE_5 || '.' || V_SE_6 || '.' ||
           V_SE_7 || '.' || V_SE_8)
      INTO V_CONCATENATED_SEGMENTS
      FROM DUAL;
    --获取组合ID
    I_CCID := CUX_GL_IMPORT_PKG.GET_CODE_COMBINATION_ID(V_CONCATENATED_SEGMENTS);
    RETURN I_CCID;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 00;
  END GET_NO_TAX_DIF_COMBINATION_ID;

  PROCEDURE PAYMENT_TO_EBS_VALIDATA(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    ID_NUM                NUMBER;
    J                     INT := 1;
    O_RETURN_CODE         VARCHAR2(4000);
    O_RETURN_MESSAGE      VARCHAR2(4000);
    O_ID                  NUMBER;
    O_CHECK_ID            NUMBER;
    O_PAYMENT_CODE        VARCHAR2(40);
    O_EBS_STATUS          VARCHAR2(40);
    O_PAY_DATE            DATE;
    O_PAY_BANK_ACCOUNT_ID NUMBER(15);
    O_PAY_METHODS         VARCHAR2(200);
    O_MATCH_DEPT          VARCHAR2(200);
    O_MATCH_PROJECT       VARCHAR2(200);
    O_DESCRIPTION         VARCHAR2(2000);
    O_INVOICE_NUMBER      NUMBER;
    INVOICE_STATUS_NUMBER NUMBER;
    ISEXSTS               NUMBER;
    K_CAPTIAL             VARCHAR2(2);
  
    SON_ID      NUMBER; --子表主键
    SON_ALL     NUMBER; --子表数量
    R_ALL_MONEY NUMBER; --所有加一起的金额
    --R_ORG_ID     NUMBER; --组织id
    --E_VENDOR_ID  NUMBER; --EBS id
    R_HAD        NUMBER; --是否存在该张发票
    R_EBS_INV_ID NUMBER := 0; --如果存在的话，ebs侧发票的id
    --R_DEPT_ID    NUMBER; --部门编号
  
    --子表游标
    CURSOR N_DATA(FATHER_ID VARCHAR2) IS
      SELECT S.PAYMENT_CHILD_ID,
             S.PAYMENT_CODE,
             S.STATUS,
             S.PAY_DATE,
             S.PAY_METHODS,
             S.PAY_BANK_ACCOUNT_ID,
             S.MATCH_DEPT,
             S.MATCH_PROJECT
        FROM SPM_CON_PAYMENT_CHILD S
       WHERE S.PAYMENT_ID = FATHER_ID
         AND S.STATUS IN ('N', 'UE'); --限制住是未同步或者同步失败的
  
  BEGIN
  
    -- 计算被','分割后形成的字符串数量
    SELECT (LENGTH(V_IDS) - LENGTH(REPLACE(V_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- 循环导入
    WHILE J <= ID_NUM LOOP
      O_RETURN_CODE    := '';
      O_RETURN_MESSAGE := '';
      -- 将ID字符串根据逗号分割
      SELECT TRIM(REGEXP_SUBSTR(V_IDS, '[^,]+', 1, J)) INTO O_ID FROM DUAL;
      J := J + 1;
    
      --(-1),校验资金计划额度是否充足
      --change by ruankk 2019/04/18
      K_CAPTIAL := SPM_GZ_GZGL_INS_PKG.CHECK_CAPITAL_BALANCE_FOR_PAY(O_ID,
                                                                     '2');
    
      IF K_CAPTIAL = 'N' THEN
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '资金计划额度不足，必须由资金处增加额度后继续';
        RETURN;
      END IF;
    
      --0.校验付款单凭证摘要是否存在
      select NVL(T.DESCRIPTION, '-5555')
        INTO O_DESCRIPTION
        from SPM_CON_PAYMENT T
       WHERE T.PAYMENT_ID = O_ID;
      IF O_DESCRIPTION = '-5555' THEN 
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '凭证摘要为空!!';
        RETURN;
      END IF;
      --1.校验付款单总金额与付款单子表总金额
      SELECT P.PAYMENT_CODE,
             NVL(P.MONEY_AMOUNT, 0) -
             (SELECT NVL(SUM(PC.MONEY_AMOUNT), 0)
                FROM SPM_CON_PAYMENT_CHILD PC
               WHERE PC.PAYMENT_ID = P.PAYMENT_ID)
        INTO O_PAYMENT_CODE, ISEXSTS
        FROM SPM_CON_PAYMENT P
       WHERE P.PAYMENT_ID = O_ID;
      IF ISEXSTS <> 0 THEN
        V_RETURN_MESSAGE := O_PAYMENT_CODE || '当前付款单金额与财务录入金额不一致';
        DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
        RETURN;
      END IF;
    
      SELECT COUNT(T.PAYMENT_CHILD_ID)
        INTO SON_ALL
        FROM SPM_CON_PAYMENT_CHILD T
       WHERE T.PAYMENT_ID = O_ID
         AND T.STATUS IN ('N', 'UE');
      --判断是否存在符合条件的子表信息
      IF SON_ALL = 0 THEN
        V_RETURN_CODE    := G_INTERFACE_ERROR;
        V_RETURN_MESSAGE := '未查询到符合条件的行信息';
        RETURN;
      ELSE
      
        --导入前验证
      
        OPEN N_DATA(O_ID);
      
        FETCH N_DATA
          INTO SON_ID,
               O_PAYMENT_CODE,
               O_EBS_STATUS,
               O_PAY_DATE,
               O_PAY_METHODS,
               O_PAY_BANK_ACCOUNT_ID,
               O_MATCH_DEPT,
               O_MATCH_PROJECT;
      
        WHILE N_DATA%FOUND LOOP
        
          ------填充----------
          BEGIN
            IF O_EBS_STATUS = 'US' THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '当前选择的付款已经执行了同步财务操作';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              CONTINUE;
            
            END IF;
            --付款时间验证
            IF O_PAY_DATE IS NULL THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款时间';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              RETURN;
            
            END IF;
            --付款方式验证
            IF O_PAY_METHODS IS NULL THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款方式';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              RETURN;
            
            END IF;
            --付款银行验证
            IF O_PAY_BANK_ACCOUNT_ID IS NULL THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入付款银行';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              RETURN;
            ELSIF O_PAY_BANK_ACCOUNT_ID <> 11002 AND
                  (O_MATCH_DEPT IS NULL OR O_MATCH_PROJECT IS NULL) THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '未录入资金使用项目或部门';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
            END IF;
            --关联发票验证
            SELECT COUNT(*)
              INTO O_INVOICE_NUMBER
              FROM SPM_CON_PAYMENT_INVOICE S
             WHERE S.PAYMENT_ID = O_ID;
            IF O_INVOICE_NUMBER = 0 THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '未关联发票信息';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              RETURN;
            
            END IF;
          EXCEPTION
            WHEN OTHERS THEN
              O_RETURN_MESSAGE := O_PAYMENT_CODE || '验证异常';
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_RETURN_MESSAGE;
              DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
              RETURN;
          END;
        
          BEGIN
            --检测是否存在   一张发票和总金额相等的
          
            /* --查询供应商id   组织id
            SELECT S.VENDOR_ID, T.ORG_ID
              INTO E_VENDOR_ID, R_ORG_ID
              FROM SPM_CON_PAYMENT T, SPM_CON_VENDOR_INFO V, PO_VENDORS S
             WHERE T.PAYMENT_ID = O_ID
               AND V.VENDOR_ID = T.VENDOR_ID
               AND S.SEGMENT1 = V.VENDOR_CODE;
            --查询部门id  
            SELECT T.DEPT_ID
              INTO R_DEPT_ID
              FROM SPM_CON_PAYMENT T
             WHERE T.PAYMENT_ID = O_ID;*/
          
            CUX_SPM_CON_PAYMENT_TO_EBS(S_ID             => SON_ID,
                                       V_RETURN_CODE    => O_RETURN_CODE,
                                       V_RETURN_MESSAGE => O_RETURN_MESSAGE);
          
            --付款导入成功                       
            IF O_RETURN_CODE = 'S' THEN
              --查询对应EBS侧模块表ID
              SELECT A.CHECK_ID
                INTO O_CHECK_ID
                FROM SPM_CON_PAYMENT_CHILD P, AP_CHECKS_ALL A
               WHERE A.CHECK_NUMBER = P.PAYMENT_CODE
                 AND P.PAYMENT_CHILD_ID = SON_ID;
            
              UPDATE SPM_CON_PAYMENT_CHILD S
                 SET S.EBS_ID = O_CHECK_ID, S.STATUS = 'US'
               WHERE S.PAYMENT_CHILD_ID = SON_ID;
            
              UPDATE SPM_CON_PAYMENT T
                 SET T.CREATE_ACCOUNT_BY = SPM_SSO_PKG.GETUSERID
               WHERE T.PAYMENT_ID = O_ID;
            
              DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
               WHERE D.PAYMENT_CHILD_ID = SON_ID;
            ELSE
              UPDATE SPM_CON_PAYMENT_CHILD S
                 SET S.STATUS = 'UE'
               WHERE S.PAYMENT_CHILD_ID = SON_ID;
              -- 拼接提示信息
              IF V_RETURN_MESSAGE IS NOT NULL THEN
                V_RETURN_MESSAGE := V_RETURN_MESSAGE || '<br />';
              END IF;
              V_RETURN_MESSAGE := V_RETURN_MESSAGE || O_PAYMENT_CODE ||
                                  O_RETURN_MESSAGE;
            END IF;
          
          END;
          ------------------
        
          FETCH N_DATA
            INTO SON_ID,
                 O_PAYMENT_CODE,
                 O_EBS_STATUS,
                 O_PAY_DATE,
                 O_PAY_METHODS,
                 O_PAY_BANK_ACCOUNT_ID,
                 O_MATCH_DEPT,
                 O_MATCH_PROJECT;
        
        END LOOP;
        CLOSE N_DATA;
      
        IF V_RETURN_MESSAGE IS NULL THEN
          /*          UPDATE SPM_CON_PAYMENT P
            SET P.EBS_STATUS = 'US'
          WHERE P.PAYMENT_ID = O_ID;*/
          --更新占用资金计划的金额，排除中转付款部分
          UPDATE SPM_CON_PAYMENT P
             SET P.CANCEL_AMOUNT =
                 (SELECT SUM(PC.MONEY_AMOUNT)
                    FROM SPM_CON_PAYMENT_CHILD PC
                   WHERE PC.PAYMENT_ID = P.PAYMENT_ID
                     AND PC.PAY_BANK_ACCOUNT_ID <> 11002),
                 P.CANCEL_DATE   = SYSDATE,
                 P.EBS_STATUS    = 'US'
           WHERE P.PAYMENT_ID = O_ID;
          --调用刷新资金剩余额度过程
          SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(O_ID, 'A');
        END IF;
      
      END IF;
    
    --付款同步状态验证
    
    END LOOP;
  END;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: AP付款模块同步EBS接口中间表
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE PAYMENT_TO_EBS_IMPORT(V_ID             IN NUMBER,
                                  S_ID             IN NUMBER,
                                  T_HAD            IN NUMBER,
                                  T_INV_ID         IN NUMBER,
                                  V_RETURN_CODE    OUT VARCHAR2,
                                  V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_H_ID            NUMBER;
    V_L_ID            NUMBER;
    L_IFACE_REC       CUX.CUX_SPM_EXPENSE_MANAGE_PAY%ROWTYPE;
    L_IFACE_LINES_REC CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D%ROWTYPE;
    ISEXIT            NUMBER;
    V_RETURN_ID       NUMBER;
    V_VENDOR_ID       NUMBER; --SPM侧供应商ID
    E_VENDOR_ID       NUMBER; --EBS侧供应商ID
    E_INVOICE_ID      NUMBER; --EBS侧发票ID
  
    L_USER_ID      NUMBER;
    L_RESP_ID      NUMBER;
    L_RESP_APPL_ID NUMBER;
  
    ----------------------
    MESSAGE     VARCHAR2(200); --返回的发票信息
    B_NUMBER    NUMBER; --是否包含错误信息
    ID_NUM      NUMBER; --字符串数量
    J           INT := 1;
    SUB_MESSAGE VARCHAR2(200); --分割后的字符信息
    EBS_INV_ID  NUMBER; --ebs侧发票id
    USE_ACOUNT  NUMBER; --消耗的金额
    R_ORG_ID    NUMBER; --组织id
    R_COMMENTS  VARCHAR2(200); --头摘要
  
    CURSOR CUR_1(G_PAYMENT_ID NUMBER, G_S_ID NUMBER) IS
      SELECT P.VENDOR_ID,
             S.PAY_DATE,
             P.DEPT_ID,
             S.MONEY_AMOUNT,
             S.PAY_BANK_ACCOUNT_ID,
             S.PAY_METHODS,
             S.CASH_FLOW_ID,
             P.ORG_ID,
             A.BANK_ACCT_USE_ID,
             P.REMARK,
             P.VENDOR_SITE_ID,
             S.PAYMENT_CHILD_ID AS PAYMENT_ID,
             S.CREATION_DATE,
             S.CREATED_BY,
             S.LAST_UPDATE_DATE,
             S.LAST_UPDATED_BY,
             S.LAST_UPDATE_LOGIN,
             S.PAYMENT_CODE,
             S.MATCH_DEPT,
             S.MATCH_PROJECT
        FROM SPM_CON_PAYMENT          P,
             CE.CE_BANK_ACCT_USES_ALL A,
             SPM_CON_PAYMENT_CHILD    S
       WHERE P.PAYMENT_ID = G_PAYMENT_ID
         AND S.PAYMENT_CHILD_ID = G_S_ID
         AND A.ORG_ID = P.ORG_ID
         AND A.BANK_ACCOUNT_ID = S.PAY_BANK_ACCOUNT_ID;
  
    REC_1 CUR_1%ROWTYPE;
  
  BEGIN
    /*
          1、修改逻辑判断：判断是否同步验证EBS 应付表
          2、清空中间表中原有错误数据
          by mcq 20180111
    */
    --此处的逻辑需要修改
    SELECT COUNT(A.CHECK_ID)
      INTO ISEXIT
      FROM AP_CHECKS_ALL A, SPM_CON_PAYMENT_CHILD P
     WHERE A.CHECK_NUMBER = P.PAYMENT_CODE
       AND P.PAYMENT_CHILD_ID = S_ID;
    IF ISEXIT <> 0 THEN
    
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前选择的付款已经执行了同步财务操作';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
     WHERE 1 = 1
       AND EXISTS
     (SELECT 1
              FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY H, SPM_CON_PAYMENT_CHILD P
             WHERE H.VOUCHER_NUM = P.PAYMENT_CODE
               AND D.PAY_H_ID = H.ID
               AND P.PAYMENT_CHILD_ID = S_ID);
  
    DELETE FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY H
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_CON_PAYMENT_CHILD P
             WHERE H.VOUCHER_NUM = P.PAYMENT_CODE
               AND P.PAYMENT_CHILD_ID = S_ID);
    COMMIT;
  
    OPEN CUR_1(V_ID, S_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
      
        --查询对应的供应商ID及EBS发票ID
        BEGIN
          SELECT A.VENDOR_ID
            INTO E_VENDOR_ID
            FROM SPM_CON_VENDOR_INFO I
           INNER JOIN PO_VENDORS A
              ON I.VENDOR_CODE = A.SEGMENT1
           WHERE I.VENDOR_ID = REC_1.VENDOR_ID;
        
          IF E_VENDOR_ID IS NULL THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
        END;
      
        SELECT CUX_EXPENSE_MANAGE_PAY_S.NEXTVAL INTO V_H_ID FROM DUAL;
        --执行头表赋值
        L_IFACE_REC.ID                := V_H_ID;
        L_IFACE_REC.PAY_DATE          := REC_1.PAY_DATE;
        L_IFACE_REC.DEPT_ID           := REC_1.DEPT_ID;
        L_IFACE_REC.AMOUNT            := REC_1.MONEY_AMOUNT;
        L_IFACE_REC.BANK_ACCOUNT_ID   := REC_1.PAY_BANK_ACCOUNT_ID;
        L_IFACE_REC.PAY_METHODS       := 'WIRE'; --固定传电汇
        L_IFACE_REC.CASH_FLOW         := REC_1.CASH_FLOW_ID;
        L_IFACE_REC.ORG_ID            := REC_1.ORG_ID;
        L_IFACE_REC.ACC_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.PAY_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.BANK_ID           := REC_1.BANK_ACCT_USE_ID;
        L_IFACE_REC.COMMENTS          := REC_1.REMARK;
        L_IFACE_REC.VENDOR_SITE_ID    := REC_1.VENDOR_SITE_ID;
        L_IFACE_REC.APPLY_ID          := REC_1.PAYMENT_ID;
        L_IFACE_REC.CREATION_DATE     := REC_1.CREATION_DATE;
        L_IFACE_REC.CREATED_BY        := REC_1.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_DATE  := REC_1.LAST_UPDATE_DATE;
        L_IFACE_REC.LAST_UPDATED_BY   := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN := REC_1.LAST_UPDATE_LOGIN;
        L_IFACE_REC.VENDOR_ID         := E_VENDOR_ID;
        L_IFACE_REC.VOUCHER_NUM       := REC_1.PAYMENT_CODE; --付款编号待确认
        L_IFACE_REC.ATTRIBUTE4        := REC_1.CASH_FLOW_ID;
        
        IF REC_1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
          L_IFACE_REC.ATTRIBUTE1        := REC_1.MATCH_DEPT;
          L_IFACE_REC.ATTRIBUTE2        := REC_1.MATCH_PROJECT;
        END IF;
      
        INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY VALUES L_IFACE_REC;
      
        IF T_HAD = 0 THEN
          --自动匹配ebs发票
          MESSAGE := PAYMENT_TO_EBS_MATCH_INV(V_ID, S_ID);
          --匹配是否成功
          SELECT INSTR(MESSAGE, 'error') INTO B_NUMBER FROM DUAL;
        
          IF B_NUMBER > 0 THEN
            --存在错误信息
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := MESSAGE;
            DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
          ELSE
            --正常返回
            ---------继续写分割循环
          
            -- 计算被'#'分割后形成的字符串数量
            SELECT (LENGTH(MESSAGE) - LENGTH(REPLACE(MESSAGE, '#', '')) + 1)
              INTO ID_NUM
              FROM DUAL;
          
            SELECT P.ORG_ID
              INTO R_ORG_ID
              FROM SPM_CON_PAYMENT P
             WHERE P.PAYMENT_ID = V_ID;
          
            WHILE J <= ID_NUM LOOP
            
              -- 将ID字符串根据逗号分割
              SELECT TRIM(REGEXP_SUBSTR(MESSAGE, '[^#]+', 1, J))
                INTO SUB_MESSAGE
                FROM DUAL;
              J := J + 1;
            
              IF SUB_MESSAGE IS NOT NULL THEN
                --获取发票id
                SELECT TO_NUMBER(TRIM(REGEXP_SUBSTR(SUB_MESSAGE,
                                                    '[^%]+',
                                                    1,
                                                    1)))
                  INTO EBS_INV_ID
                  FROM DUAL;
                --获取发票金额
                SELECT TO_NUMBER(TRIM(REGEXP_SUBSTR(SUB_MESSAGE,
                                                    '[^%]+',
                                                    1,
                                                    2)))
                  INTO USE_ACOUNT
                  FROM DUAL;
                --获取头摘要
                SELECT T.DESCRIPTION
                  INTO R_COMMENTS
                  FROM AP_INVOICES_ALL T
                 WHERE T.INVOICE_ID = EBS_INV_ID;
              
                --已经获取了ebs侧发票主键和占用的金额，向接口表中插入数据；
                SELECT CUX_EXPENSE_MANAGE_PAY_D_S.NEXTVAL
                  INTO V_L_ID
                  FROM DUAL;
              
                L_IFACE_LINES_REC.PAY_D_ID    := V_L_ID;
                L_IFACE_LINES_REC.PAY_H_ID    := V_H_ID;
                L_IFACE_LINES_REC.INVOICE_ID  := EBS_INV_ID; ---ebs侧发票id
                L_IFACE_LINES_REC.COMMENTS    := R_COMMENTS; --ebs侧发票头摘要
                L_IFACE_LINES_REC.ORG_ID      := R_ORG_ID; --组织id
                L_IFACE_LINES_REC.THIS_AMOUNT := USE_ACOUNT; --使用金额
              
                INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D
                VALUES L_IFACE_LINES_REC;
              
              END IF;
            END LOOP;
          
          END IF;
        
        ELSE
          --有总额等于的发票
          --获取头摘要
          SELECT T.DESCRIPTION
            INTO R_COMMENTS
            FROM AP_INVOICES_ALL T
           WHERE T.INVOICE_ID = T_INV_ID;
        
          SELECT P.ORG_ID
            INTO R_ORG_ID
            FROM SPM_CON_PAYMENT P
           WHERE P.PAYMENT_ID = V_ID;
        
          SELECT T.MONEY_AMOUNT
            INTO USE_ACOUNT
            FROM SPM_CON_PAYMENT_CHILD T
           WHERE T.PAYMENT_CHILD_ID = S_ID;
        
          SELECT CUX_EXPENSE_MANAGE_PAY_D_S.NEXTVAL INTO V_L_ID FROM DUAL;
        
          L_IFACE_LINES_REC.PAY_D_ID    := V_L_ID;
          L_IFACE_LINES_REC.PAY_H_ID    := V_H_ID;
          L_IFACE_LINES_REC.INVOICE_ID  := T_INV_ID; ---ebs侧发票id
          L_IFACE_LINES_REC.COMMENTS    := R_COMMENTS; --ebs侧发票头摘要
          L_IFACE_LINES_REC.ORG_ID      := R_ORG_ID; --组织id
          L_IFACE_LINES_REC.THIS_AMOUNT := USE_ACOUNT; --使用金额
        
          INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D
          VALUES L_IFACE_LINES_REC;
        
        END IF;
      
        COMMIT;
      EXCEPTION
      
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '有空值';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
    
      BEGIN
      
        CUX_SPM_EXP_IMPORT_PAYMENT_PKG.IMPORT_PAYMENT(P_MANAGE_PAY_ID => V_H_ID,
                                                      P_MSG           => V_RETURN_MESSAGE,
                                                      P_CHECK_ID      => V_RETURN_ID);
      
        /* 导入付款，返回EBS付款ID，如果返回就是导入成功，否则看错误信息   */
        IF V_RETURN_ID IS NULL THEN
          V_RETURN_CODE := G_INTERFACE_ERROR;
          RETURN;
        ELSE
          V_RETURN_CODE := G_INTERFACE_SUCCESS;
          RETURN;
        END IF;
      END;
    
    ELSE
      CLOSE CUR_1;
      V_RETURN_CODE := G_INTERFACE_ERROR;
      V_RETURN_CODE := '未查询到对应付款数据';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END PAYMENT_TO_EBS_IMPORT;

  --自动匹配发票                                  
  FUNCTION PAYMENT_TO_EBS_MATCH_INV(V_ID NUMBER, S_ID NUMBER) RETURN VARCHAR2 IS
  
    R_VENDOR_ID    NUMBER; --供应商id
    E_VENDOR_ID    NUMBER; --ebs供应商id
    R_ORG_ID       NUMBER; --组织id
    R_MONEY_ACOUNT NUMBER; --需要的发票金额
    R_ALL_ACOUNT   NUMBER; --可用的总金额
    R_NUMBER       NUMBER; --是否有金额正好匹配上的发票
    R_RETURN       VARCHAR2(4000); --要返回的信息
    R_NUM1         NUMBER := 0; --已经核销的金额总数
    R_NUM2         NUMBER; --未核销的金额余额
    R_TABLE        SPM_TYPE_TBL; --部门值集
    R_DEPT_ID      NUMBER; --部门编号
  
    CURSOR N_DATA(S_VENDOR_ID NUMBER,
                  S_ORG_ID    NUMBER,
                  S_TABLE     SPM_TYPE_TBL) IS
      SELECT T.INVOICE_ID ID, --EBS发票的id
             SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(T.INVOICE_ID) MONEY -- 剩余可用金额
        FROM AP_INVOICES_ALL T
       WHERE T.VENDOR_ID = S_VENDOR_ID --此处应该是ebs侧的供应商id
         AND T.ORG_ID = S_ORG_ID
         AND EXISTS
       (SELECT * FROM TABLE(S_TABLE) WHERE COLUMN_VALUE = T.ATTRIBUTE3)
         AND SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(T.INVOICE_ID) > 0
         AND AP_INVOICES_PKG.GET_APPROVAL_STATUS(T.INVOICE_ID,
                                                 T.INVOICE_AMOUNT,
                                                 T.PAYMENT_STATUS_FLAG,
                                                 T.INVOICE_TYPE_LOOKUP_CODE) IN
             ('APPROVED', 'UNPAID')
       ORDER BY T.GL_DATE;
  
    REC_1 N_DATA%ROWTYPE;
  
  BEGIN
  
    --获取需要的信息
    SELECT T.VENDOR_ID, P.ORG_ID, S.MONEY_AMOUNT, P.DEPT_ID
      INTO R_VENDOR_ID, R_ORG_ID, R_MONEY_ACOUNT, R_DEPT_ID
      FROM SPM_CON_PAYMENT       P,
           SPM_CON_PAYMENT_CHILD S,
           SPM_CON_VENDOR_INFO   V,
           PO_VENDORS            T
     WHERE P.PAYMENT_ID = V_ID
       AND S.PAYMENT_CHILD_ID = S_ID
       AND V.VENDOR_ID = P.VENDOR_ID
       AND T.SEGMENT1 = V.VENDOR_CODE;
  
    --获取部门集合
    R_TABLE := SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION(R_DEPT_ID);
  
    SELECT SUM(SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(T.INVOICE_ID))
      INTO R_ALL_ACOUNT
      FROM AP_INVOICES_ALL T
     WHERE T.VENDOR_ID = R_VENDOR_ID
       AND T.ORG_ID = R_ORG_ID
       AND EXISTS
     (SELECT * FROM TABLE(R_TABLE) WHERE COLUMN_VALUE = T.ATTRIBUTE3);
    --判断是否存在
    IF R_ALL_ACOUNT IS NULL THEN
      RETURN 'error不足金额：' || R_MONEY_ACOUNT;
    END IF;
    --判断金额是否足够
    IF R_ALL_ACOUNT < R_MONEY_ACOUNT THEN
      RETURN 'error不足金额：' ||(R_MONEY_ACOUNT - R_ALL_ACOUNT);
    END IF;
    --是否存在金额是否正好一致的
    SELECT COUNT(T.INVOICE_ID)
      INTO R_NUMBER
      FROM AP_INVOICES_ALL T
     WHERE T.VENDOR_ID = R_VENDOR_ID
       AND T.ORG_ID = R_ORG_ID
       AND SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(T.INVOICE_ID) =
           R_MONEY_ACOUNT
       AND AP_INVOICES_PKG.GET_APPROVAL_STATUS(T.INVOICE_ID,
                                               T.INVOICE_AMOUNT,
                                               T.PAYMENT_STATUS_FLAG,
                                               T.INVOICE_TYPE_LOOKUP_CODE) IN
           ('APPROVED', 'UNPAID')
       AND EXISTS
     (SELECT * FROM TABLE(R_TABLE) WHERE COLUMN_VALUE = T.ATTRIBUTE3);
    --存在返回一个
    IF R_NUMBER > 0 THEN
    
      SELECT T.INVOICE_ID
        INTO R_RETURN
        FROM AP_INVOICES_ALL T
       WHERE T.VENDOR_ID = R_VENDOR_ID
         AND T.ORG_ID = R_ORG_ID
         AND SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(T.INVOICE_ID) =
             R_MONEY_ACOUNT
         AND AP_INVOICES_PKG.GET_APPROVAL_STATUS(T.INVOICE_ID,
                                                 T.INVOICE_AMOUNT,
                                                 T.PAYMENT_STATUS_FLAG,
                                                 T.INVOICE_TYPE_LOOKUP_CODE) IN
             ('APPROVED', 'UNPAID')
         AND EXISTS
       (SELECT * FROM TABLE(R_TABLE) WHERE COLUMN_VALUE = T.ATTRIBUTE3)
         AND ROWNUM = 1;
    
      RETURN R_RETURN || '%' || R_MONEY_ACOUNT || '#';
    
    END IF;
  
    OPEN N_DATA(R_VENDOR_ID, R_ORG_ID, R_TABLE);
    FETCH N_DATA
      INTO REC_1;
  
    R_NUM2 := R_MONEY_ACOUNT;
  
    WHILE N_DATA%FOUND LOOP
      --发票金额大于剩余需要的金额
      IF REC_1.MONEY > R_NUM2 THEN
        R_RETURN := R_RETURN || '' || REC_1.ID || '%' || R_NUM2 || '#';
        CLOSE N_DATA;
        RETURN R_RETURN;
        --发票金额等于剩余需要的金额
      ELSIF REC_1.MONEY = R_NUM2 THEN
        R_RETURN := R_RETURN || '' || REC_1.ID || '%' || REC_1.MONEY || '#';
        CLOSE N_DATA;
        RETURN R_RETURN;
        --发票金额小于剩余需要的金额 
      ELSE
        R_RETURN := R_RETURN || '' || REC_1.ID || '%' || REC_1.MONEY || '#';
        R_NUM2   := R_NUM2 - REC_1.MONEY;
        R_NUM1   := R_NUM1 + REC_1.MONEY;
      END IF;
    
      FETCH N_DATA
        INTO REC_1;
    
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'error:程序发生异常';
    
  END;
  /*
    自动匹配规则
    V_TYPE_CODE :匹配规则 A ： MATCH_AP_INVOICE_TYPE_RANDOM B ：MATCH_AP_INVOICE_TYPE_DEFAULT
    V_PAYMENT_ID ： 付款单ID
    
  */
  PROCEDURE MATCH_AP_INVOICE_FOR_PAYMENT(V_PAYMENT_ID     IN NUMBER,
                                         V_TYPE_CODE      IN VARCHAR2,
                                         V_RETURN_CODE    OUT VARCHAR2,
                                         V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  BEGIN
    IF V_TYPE_CODE = 'A' THEN
    
      MATCH_AP_INVOICE_TYPE_RANDOM(V_PAYMENT_ID,
                                   V_RETURN_CODE,
                                   V_RETURN_MESSAGE);
    ELSIF V_TYPE_CODE = 'B' THEN
      MATCH_AP_INVOICE_TYPE_DEFAULT(V_PAYMENT_ID,
                                    V_RETURN_CODE,
                                    V_RETURN_MESSAGE);
    ELSE
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '无满足条件的自动匹配规则';
    END IF;
  
  END MATCH_AP_INVOICE_FOR_PAYMENT;
  /*
    第一种自动匹配规则
    1.优先匹配当前大部门下的金额一致的预付款发票
    2.从当前大部门下有余额的发票中按照入账时间匹配
    V_PAYMENT_ID 付款单ID
    V_RETURN_CODE 返回状态
    V_RETURN_MESSAGE 错误原因
    by mcq
  */
  PROCEDURE MATCH_AP_INVOICE_TYPE_RANDOM(V_PAYMENT_ID     IN NUMBER,
                                         V_RETURN_CODE    OUT VARCHAR2,
                                         V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXISTS          NUMBER;
    V_PAY_AMOUNT       NUMBER; --本次付款金额                     
    PO_VENDOR_ID       NUMBER; --EBS侧供应商ID
    AP_INVOICE_ID      NUMBER; --EBS侧发票ID
    V_DEPT_ID          NUMBER; --合同侧部门ID
    V_EBS_DEPTS        SPM_TYPE_TBL; --部门段数据集合
    V_RES_MONEY        NUMBER; --发票剩余金额
    V_PAYMENT_CHILD_ID NUMBER; --子表发票ID
    V_RESIDUAL_MOANEY  NUMBER; --未付金额
    V_ORG_ID           NUMBER(15); --组织ID
    TYPE AP_INVOICES_ALL_TBL_TYPE IS TABLE OF AP_INVOICES_ALL%ROWTYPE;
    AP_INVOICES_ALL_TBL       AP_INVOICES_ALL_TBL_TYPE;
    SPM_CON_PAYMENT_CHILD_TBL SPM_CON_PAYMENT_CHILD%ROWTYPE;
  
    CURSOR CUR_1 IS --复合条件的EBS侧发票
      SELECT *
        FROM AP_INVOICES_ALL T
       WHERE T.VENDOR_ID = PO_VENDOR_ID --此处应该是ebs侧的供应商id
         AND EXISTS (SELECT *
                FROM TABLE(V_EBS_DEPTS)
               WHERE COLUMN_VALUE = T.ATTRIBUTE3)
         AND MEW_GET_APINVOICE_BALANCE_P(T.INVOICE_ID) > 0
         AND T.ORG_ID = V_ORG_ID
         AND AP_INVOICES_PKG.GET_APPROVAL_STATUS(T.INVOICE_ID,
                                                 T.INVOICE_AMOUNT,
                                                 T.PAYMENT_STATUS_FLAG,
                                                 T.INVOICE_TYPE_LOOKUP_CODE) IN
             ('APPROVED', 'UNPAID')
       ORDER BY T.GL_DATE;
  
    CURSOR CUR_2 IS --合同侧财务付款
      SELECT *
        FROM SPM_CON_PAYMENT_CHILD PC
       WHERE PC.PAYMENT_ID = V_PAYMENT_ID
         AND PC.STATUS <> 'US';
  BEGIN
    V_RETURN_CODE    := G_INTERFACE_SUCCESS;
    V_RETURN_MESSAGE := '';
    --1.查询对应EBS侧往来ID
    SELECT PV.VENDOR_ID, P.MONEY_AMOUNT, P.DEPT_ID, P.ORG_ID
      INTO PO_VENDOR_ID, V_PAY_AMOUNT, V_DEPT_ID, V_ORG_ID
      FROM SPM_CON_PAYMENT P, SPM_CON_VENDOR_INFO VI, PO_VENDORS PV
     WHERE P.VENDOR_ID = VI.VENDOR_ID
       AND VI.VENDOR_CODE = PV.SEGMENT1
       AND P.PAYMENT_ID = V_PAYMENT_ID;
  
    --2.查询对应大部门下所有部门段值
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_T(H.ATTRIBUTE6)
      INTO V_EBS_DEPTS
      FROM HR_ALL_ORGANIZATION_UNITS H
     WHERE H.ORGANIZATION_ID = V_DEPT_ID;
    --V_EBS_DEPTS := SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION(V_DEPT_ID);
  
    --3.查询EBS侧与当前付款单金额及供应商一致的预付款
    --优先取主键小的一条
    BEGIN
    
      SELECT A.INVOICE_ID
        INTO AP_INVOICE_ID
        FROM AP_INVOICES_ALL A
       WHERE A.INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT'
         AND A.INVOICE_AMOUNT = V_PAY_AMOUNT
         AND A.PAYMENT_STATUS_FLAG = 'N' --未付款标识
         AND A.VENDOR_ID = PO_VENDOR_ID
         AND A.ORG_ID = V_ORG_ID
         AND EXISTS (SELECT *
                FROM TABLE(V_EBS_DEPTS)
               WHERE COLUMN_VALUE = A.ATTRIBUTE3) --当前大部门下的
         AND ROWNUM = 1
       ORDER BY A.INVOICE_ID ASC;
      --遍历付款管理发票子表
      FOR SPM_CON_PAYMENT_CHILD_TBL IN CUR_2 LOOP
      
        --查询未付金额
        SELECT SPM_CON_PAYMENT_CHILD_TBL.MONEY_AMOUNT -
               NVL(SUM(D.THIS_AMOUNT), 0)
          INTO V_RESIDUAL_MOANEY
          FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
         WHERE D.PAYMENT_CHILD_ID =
               SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID;
      
        IF V_RESIDUAL_MOANEY <= 0 THEN
          CONTINUE;
        END IF;
      
        --4.调用插入接口表数据存储过程，将付款ID、ap发票ID、核销金额插入表中
        SPM_CON_INVOICE_INF_PKG.INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       => SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID,
                                                           V_VENDOR_ID    => PO_VENDOR_ID,
                                                           V_INVOICE_ID   => AP_INVOICE_ID,
                                                           V_MONEY_AMOUNT => V_RESIDUAL_MOANEY);
        V_RETURN_CODE := G_INTERFACE_SUCCESS;
      
      END LOOP;
      RETURN;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('无满足条件的预付款发票');
    END;
  
    --5.将游标中数据全部取出
    OPEN CUR_1;
    LOOP
      --将符合条件的数据一次性取出20条，这样效率更高
      FETCH CUR_1 BULK COLLECT
        INTO AP_INVOICES_ALL_TBL LIMIT 20;
      --遍历付款管理发票子表
      FOR SPM_CON_PAYMENT_CHILD_TBL IN CUR_2 LOOP
      
        V_PAY_AMOUNT       := SPM_CON_PAYMENT_CHILD_TBL.MONEY_AMOUNT;
        V_PAYMENT_CHILD_ID := SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID;
      
        --查询未付金额
        SELECT V_PAY_AMOUNT - NVL(SUM(D.THIS_AMOUNT), 0)
          INTO V_RESIDUAL_MOANEY
          FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
         WHERE D.PAYMENT_CHILD_ID =
               SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID;
      
        IF V_RESIDUAL_MOANEY <= 0 THEN
          V_PAY_AMOUNT := 0;
          CONTINUE;
        END IF;
      
        FOR I IN 1 .. AP_INVOICES_ALL_TBL.COUNT LOOP
          --正式匹配发票
          --5.1 取出第一条符合条件的数据
          SELECT A.INVOICE_ID, MEW_GET_APINVOICE_BALANCE_P(A.INVOICE_ID)
            INTO AP_INVOICE_ID, V_RES_MONEY
            FROM AP_INVOICES_ALL A
           WHERE A.INVOICE_ID = AP_INVOICES_ALL_TBL(I).INVOICE_ID;
        
          DBMS_OUTPUT.PUT_LINE('值：' || V_RES_MONEY);
          --如果剩余金额为0，则直接跳过
          IF V_RES_MONEY = 0 THEN
            CONTINUE;
          END IF;
        
          --5.2比较当前发票剩余金额及代付款金额
          --如果待付款金额小于等于发票金额，则将待付款金额作为核销金额
          IF V_PAY_AMOUNT <= V_RES_MONEY THEN
            --调用插入接口表数据存储过程，将付款ID、ap发票ID、核销金额插入表中
            SPM_CON_INVOICE_INF_PKG.INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       => V_PAYMENT_CHILD_ID,
                                                               V_VENDOR_ID    => PO_VENDOR_ID,
                                                               V_INVOICE_ID   => AP_INVOICE_ID,
                                                               V_MONEY_AMOUNT => V_PAY_AMOUNT);
            V_PAY_AMOUNT := 0;
            EXIT;
          ELSE
            --如果待付款金额大于发票金额，则将发票剩余金额作为核销金额
            --调用插入接口表数据存储过程，将付款ID、ap发票ID、核销金额插入表中
            SPM_CON_INVOICE_INF_PKG.INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       => V_PAYMENT_CHILD_ID,
                                                               V_VENDOR_ID    => PO_VENDOR_ID,
                                                               V_INVOICE_ID   => AP_INVOICE_ID,
                                                               V_MONEY_AMOUNT => V_RES_MONEY);
            --待付款金额应该核减掉当前发票剩余金额
            V_PAY_AMOUNT := V_PAY_AMOUNT - V_RES_MONEY;
          END IF;
        
        END LOOP;
      
        --如果待付款金额未被全部核销，则直接跳出本次匹配，返回错误信息
        IF V_PAY_AMOUNT <> 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前满足条件的核销条件的发票余额不足';
          RETURN;
        END IF;
      
      END LOOP;
      EXIT WHEN CUR_1%NOTFOUND;
    
    END LOOP;
    V_RETURN_CODE := G_INTERFACE_SUCCESS;
  
  END MATCH_AP_INVOICE_TYPE_RANDOM;

  /*
  20180720
  根据招标公司需要添加一种默认匹配规则
  默认自动匹配业务人员选择的发票
  V_PAYMENT_ID 付款单ID
  V_RETURN_CODE 返回状态
  V_RETURN_MESSAGE 错误原因
  by mcq
  */
  PROCEDURE MATCH_AP_INVOICE_TYPE_DEFAULT(V_PAYMENT_ID     IN NUMBER,
                                          V_RETURN_CODE    OUT VARCHAR2,
                                          V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXISTS          NUMBER;
    V_PAY_AMOUNT       NUMBER; --本次付款金额        
    V_DEPT_ID          NUMBER; --合同侧部门ID             
    PO_VENDOR_ID       NUMBER; --EBS侧供应商ID
    AP_INVOICE_ID      NUMBER; --EBS侧发票ID
    P_INVOICE_CODE     VARCHAR2(100); --发票号码
    V_RES_MONEY        NUMBER; --发票剩余金额
    THIS_PAY_INVOICE   NUMBER; --本次针对此发票应该付的金额
    V_PAYMENT_CHILD_ID NUMBER; --子表发票ID
    V_RESIDUAL_MOANEY  NUMBER; --未付金额
    V_CUX_AMOUNT       NUMBER; --接口表中该付款单已核销发票金额
    TYPE AP_INVOICES_ALL_TBL_TYPE IS TABLE OF AP_INVOICES_ALL%ROWTYPE;
    AP_INVOICES_ALL_TBL       AP_INVOICES_ALL_TBL_TYPE;
    SPM_CON_PAYMENT_CHILD_TBL SPM_CON_PAYMENT_CHILD%ROWTYPE;
  
    CURSOR CUR_1 IS --复合条件的EBS侧发票
      SELECT *
        FROM AP_INVOICES_ALL T
       WHERE T.VENDOR_ID = PO_VENDOR_ID --此处应该是ebs侧的供应商id
         AND EXISTS (SELECT *
                FROM SPM_CON_PAYMENT         P,
                     SPM_CON_PAYMENT_INVOICE PI,
                     SPM_CON_INPUT_INVOICE   I
               WHERE P.PAYMENT_ID = PI.PAYMENT_ID
                 AND PI.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
                 AND P.ORG_ID = I.ORG_ID
                 AND I.EBS_ID = T.INVOICE_ID
                 AND P.PAYMENT_ID = V_PAYMENT_ID)
         AND MEW_GET_APINVOICE_BALANCE_P(T.INVOICE_ID) > 0
         AND AP_INVOICES_PKG.GET_APPROVAL_STATUS(T.INVOICE_ID,
                                                 T.INVOICE_AMOUNT,
                                                 T.PAYMENT_STATUS_FLAG,
                                                 T.INVOICE_TYPE_LOOKUP_CODE) IN
             ('APPROVED', 'UNPAID')
       ORDER BY T.GL_DATE;
  
    CURSOR CUR_2 IS --合同侧财务付款
      SELECT *
        FROM SPM_CON_PAYMENT_CHILD PC
       WHERE PC.PAYMENT_ID = V_PAYMENT_ID
         AND PC.STATUS <> 'US';
  BEGIN
    V_RETURN_CODE    := G_INTERFACE_SUCCESS;
    V_RETURN_MESSAGE := '';
  
    --1.查询对应EBS侧往来ID
    SELECT PV.VENDOR_ID, P.MONEY_AMOUNT, P.DEPT_ID
      INTO PO_VENDOR_ID, V_PAY_AMOUNT, V_DEPT_ID
      FROM SPM_CON_PAYMENT P, SPM_CON_VENDOR_INFO VI, PO_VENDORS PV
     WHERE P.VENDOR_ID = VI.VENDOR_ID
       AND VI.VENDOR_CODE = PV.SEGMENT1
       AND P.PAYMENT_ID = V_PAYMENT_ID;
  
    --2.将游标中数据全部取出
    OPEN CUR_1;
    LOOP
      --将符合条件的数据一次性取出20条，这样效率更高
      FETCH CUR_1 BULK COLLECT
        INTO AP_INVOICES_ALL_TBL LIMIT 100;
      --遍历付款管理发票子表
      FOR SPM_CON_PAYMENT_CHILD_TBL IN CUR_2 LOOP
      
        V_PAY_AMOUNT       := SPM_CON_PAYMENT_CHILD_TBL.MONEY_AMOUNT;
        V_PAYMENT_CHILD_ID := SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID;
      
        --查询未付金额
        SELECT V_PAY_AMOUNT - NVL(SUM(D.THIS_AMOUNT), 0)
          INTO V_RESIDUAL_MOANEY
          FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
         WHERE D.PAYMENT_CHILD_ID =
               SPM_CON_PAYMENT_CHILD_TBL.PAYMENT_CHILD_ID;
      
        IF V_RESIDUAL_MOANEY <= 0 THEN
          V_PAY_AMOUNT := 0;
          CONTINUE;
        END IF;
      
        FOR I IN 1 .. AP_INVOICES_ALL_TBL.COUNT LOOP
          --正式匹配发票
          --5.1 取出第一条符合条件的数据
          SELECT A.INVOICE_ID,
                 A.INVOICE_NUM,
                 MEW_GET_APINVOICE_BALANCE_P(A.INVOICE_ID)
            INTO AP_INVOICE_ID, P_INVOICE_CODE, V_RES_MONEY
            FROM AP_INVOICES_ALL A
           WHERE A.INVOICE_ID = AP_INVOICES_ALL_TBL(I).INVOICE_ID;
        
          DBMS_OUTPUT.PUT_LINE('值：' || V_RES_MONEY);
          --如果剩余金额为0，则直接跳过
          IF V_RES_MONEY = 0 THEN
            CONTINUE;
          END IF;
        
          --20180918添加逻辑，需要将业务人员选择核销发票考虑进去
          --如果业务人员针对该发票的付款金额大于EBS侧发票剩余金额，则本次可用付款金额为EBS侧发票剩余金额
          --反之 则取业务人员针对该发票的付款金额
          SELECT NVL(SUM(D.THIS_AMOUNT), 0)
            INTO V_CUX_AMOUNT
            FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D, AP_INVOICES_ALL A
           WHERE D.PAYMENT_CHILD_ID IN
                 (SELECT PC.PAYMENT_CHILD_ID
                    FROM SPM_CON_PAYMENT_CHILD PC
                   WHERE 1 = 1
                     AND PC.PAYMENT_ID = V_PAYMENT_ID)
                
             AND D.INVOICE_ID = A.INVOICE_ID
             AND A.INVOICE_NUM = P_INVOICE_CODE;
        
          SELECT DECODE(SIGN(PI.MONEY_AMOUNT - V_CUX_AMOUNT - V_RES_MONEY),
                        1,
                        V_RES_MONEY,
                        PI.MONEY_AMOUNT - V_CUX_AMOUNT)
            INTO THIS_PAY_INVOICE
            FROM SPM_CON_PAYMENT_INVOICE PI, SPM_CON_INPUT_INVOICE I
           WHERE PI.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
             AND I.INVOICE_CODE = P_INVOICE_CODE
             AND PI.PAYMENT_ID = V_PAYMENT_ID;
        
          IF THIS_PAY_INVOICE = 0 THEN
            CONTINUE;
          END IF;
        
          --5.2比较本次应该付款金额及代付款金额
          --V_PAY_AMOUNT 是财务录入的页签中的金额
          --THIS_PAY_INVOICE 是本次该发票付款金额
          --如果待付款金额小于等于本次该发票付款金额，则将待付款金额作为核销金额
          IF V_PAY_AMOUNT <= THIS_PAY_INVOICE THEN
            --调用插入接口表数据存储过程，将付款ID、ap发票ID、核销金额插入表中
            SPM_CON_INVOICE_INF_PKG.INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       => V_PAYMENT_CHILD_ID,
                                                               V_VENDOR_ID    => PO_VENDOR_ID,
                                                               V_INVOICE_ID   => AP_INVOICE_ID,
                                                               V_MONEY_AMOUNT => V_PAY_AMOUNT);
            V_PAY_AMOUNT := 0;
            EXIT;
          ELSE
          
            --如果待付款金额大于本次该发票付款金额，则将本次该发票付款金额作为核销金额
            --调用插入接口表数据存储过程，将付款ID、ap发票ID、核销金额插入表中
            SPM_CON_INVOICE_INF_PKG.INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       => V_PAYMENT_CHILD_ID,
                                                               V_VENDOR_ID    => PO_VENDOR_ID,
                                                               V_INVOICE_ID   => AP_INVOICE_ID,
                                                               V_MONEY_AMOUNT => THIS_PAY_INVOICE);
            --待付款金额应该核减掉当前发票剩余金额
            V_PAY_AMOUNT := V_PAY_AMOUNT - THIS_PAY_INVOICE;
          END IF;
        
        END LOOP;
      
        --如果待付款金额未被全部核销，则直接跳出本次匹配，返回错误信息
        IF V_PAY_AMOUNT <> 0 THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '当前满足条件的核销条件的发票余额不足,可能出现原因为 ：1. 当前发票未同步财务 2. 当前发票被其他付款占用';
          RETURN;
        END IF;
      
      END LOOP;
      EXIT WHEN CUR_1%NOTFOUND;
    
    END LOOP;
    CLOSE CUR_1;
    V_RETURN_CODE := G_INTERFACE_SUCCESS;
  
  END MATCH_AP_INVOICE_TYPE_DEFAULT;

  FUNCTION MEW_GET_APINVOICE_BALANCE_F(P_INVOICE_ID NUMBER) RETURN NUMBER IS
    V_INVOICE_AMOUNT           NUMBER;
    V_PAYMENT_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT1          NUMBER;
    V_INVOICE_TYPE_LOOKUP_CODE VARCHAR2(30);
    V_FLAG                     VARCHAR2(10);
    V_CUX_MONEY                NUMBER; --中间表核销金额
  BEGIN
    --1发票金额
    SELECT AIA.INVOICE_AMOUNT, AIA.INVOICE_TYPE_LOOKUP_CODE
      INTO V_INVOICE_AMOUNT, V_INVOICE_TYPE_LOOKUP_CODE
      FROM AP_INVOICES_ALL AIA
     WHERE AIA.INVOICE_ID = P_INVOICE_ID;
    --2正常付款金额
    BEGIN
      SELECT NVL(SUM(AIP.AMOUNT), 0) AMOUNT
        INTO V_PAYMENT_AMOUNT
        FROM AP_INVOICE_PAYMENTS_ALL AIP,
             AP_INVOICES_ALL         AI,
             AP_INVOICES_ALL         AI2,
             AP_CHECKS_ALL           AC
       WHERE AIP.INVOICE_ID = AI.INVOICE_ID
         AND AIP.OTHER_INVOICE_ID = AI2.INVOICE_ID(+)
         AND AIP.CHECK_ID = AC.CHECK_ID
         AND AIP.AMOUNT <> 0
         AND AIP.INVOICE_ID = P_INVOICE_ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_PAYMENT_AMOUNT := 0;
    END;
  
    --3中间表核销金额
    SELECT NVL(SUM(D.THIS_AMOUNT), 0)
      INTO V_CUX_MONEY
      FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
     WHERE D.INVOICE_ID = P_INVOICE_ID;
  
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      --判断预付款发票是否已经付款，如果已经付款则直接返回0
      SELECT NVL(A.PAYMENT_STATUS_FLAG, 'N'), A.INVOICE_AMOUNT
        INTO V_FLAG, V_PREPAID_AMOUNT
        FROM AP_INVOICES_ALL A
       WHERE A.INVOICE_ID = P_INVOICE_ID;
    
      IF V_FLAG <> 'Y' THEN
      
        --预付款发票核销普通发票的金额
        SELECT (-1) * NVL(SUM(AID1.AMOUNT), 0) PREPAY_AMOUNT_APPLIED
          INTO V_PREPAID_AMOUNT
          FROM AP_INVOICES_ALL              AI,
               AP_INVOICE_DISTRIBUTIONS_ALL AID1,
               AP_INVOICE_DISTRIBUTIONS_ALL AID2
         WHERE AID1.PREPAY_DISTRIBUTION_ID = AID2.INVOICE_DISTRIBUTION_ID
           AND AI.INVOICE_ID = AID1.INVOICE_ID
           AND AID1.AMOUNT < 0
           AND NVL(AID1.REVERSAL_FLAG, 'N') != 'Y'
           AND AID1.LINE_TYPE_LOOKUP_CODE = 'PREPAY'
           AND AI.INVOICE_TYPE_LOOKUP_CODE NOT IN
               ('PREPAYMENT', 'CREDIT', 'DEBIT')
           AND AID2.INVOICE_ID = P_INVOICE_ID;
      END IF;
    
    ELSE
      --普通发票核销预付款发票的金额
      SELECT (-1) * NVL(SUM(AID1.AMOUNT), 0) PREPAY_AMOUNT_APPLIED
        INTO V_PREPAID_AMOUNT
        FROM AP_INVOICES_ALL              AI,
             AP_INVOICE_DISTRIBUTIONS_ALL AID1,
             AP_INVOICE_DISTRIBUTIONS_ALL AID2
       WHERE AID1.PREPAY_DISTRIBUTION_ID = AID2.INVOICE_DISTRIBUTION_ID
         AND AI.INVOICE_ID = AID2.INVOICE_ID
         AND AID1.AMOUNT < 0
         AND NVL(AID1.REVERSAL_FLAG, 'N') != 'Y'
         AND AID1.LINE_TYPE_LOOKUP_CODE = 'PREPAY'
         AND AID1.INVOICE_ID = P_INVOICE_ID;
    
    END IF;
  
    /*DBMS_OUTPUT.PUT_LINE(' 1v_invoice_amount: ' || V_INVOICE_AMOUNT ||
    ' 2v_payment_amount: ' || V_PAYMENT_AMOUNT ||
    ' 3v_prepaid_amount: ' || V_PREPAID_AMOUNT);*/
  
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      RETURN V_PAYMENT_AMOUNT - V_PREPAID_AMOUNT;
    ELSE
      RETURN NVL(V_INVOICE_AMOUNT, 0) - V_PAYMENT_AMOUNT - V_PREPAID_AMOUNT - V_CUX_MONEY;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  -- 付款查询可用发票余额
  FUNCTION MEW_GET_APINVOICE_BALANCE_P(P_INVOICE_ID NUMBER) RETURN NUMBER IS
    V_INVOICE_AMOUNT           NUMBER;
    V_PAYMENT_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT1          NUMBER;
    V_INVOICE_TYPE_LOOKUP_CODE VARCHAR2(30);
    V_FLAG                     VARCHAR2(10);
    V_CUX_MONEY                NUMBER; --中间表核销金额
  BEGIN
    --1发票金额
    SELECT AIA.INVOICE_AMOUNT, AIA.INVOICE_TYPE_LOOKUP_CODE
      INTO V_INVOICE_AMOUNT, V_INVOICE_TYPE_LOOKUP_CODE
      FROM AP_INVOICES_ALL AIA
     WHERE AIA.INVOICE_ID = P_INVOICE_ID;
    --2正常付款金额
    BEGIN
      SELECT NVL(SUM(AIP.AMOUNT), 0) AMOUNT
        INTO V_PAYMENT_AMOUNT
        FROM AP_INVOICE_PAYMENTS_ALL AIP,
             AP_INVOICES_ALL         AI,
             AP_INVOICES_ALL         AI2,
             AP_CHECKS_ALL           AC
       WHERE AIP.INVOICE_ID = AI.INVOICE_ID
         AND AIP.OTHER_INVOICE_ID = AI2.INVOICE_ID(+)
         AND AIP.CHECK_ID = AC.CHECK_ID
         AND AIP.AMOUNT <> 0
         AND AIP.INVOICE_ID = P_INVOICE_ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_PAYMENT_AMOUNT := 0;
    END;
  
    --3中间表核销金额
    SELECT NVL(SUM(D.THIS_AMOUNT), 0)
      INTO V_CUX_MONEY
      FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
     WHERE D.INVOICE_ID = P_INVOICE_ID;
  
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      --判断预付款发票是否已经付款，如果已经付款则直接返回0
      SELECT NVL(A.PAYMENT_STATUS_FLAG, 'N'), A.INVOICE_AMOUNT
        INTO V_FLAG, V_PREPAID_AMOUNT
        FROM AP_INVOICES_ALL A
       WHERE A.INVOICE_ID = P_INVOICE_ID;
    
      IF V_FLAG = 'Y' THEN
        V_PREPAID_AMOUNT := 0;
      ELSE
        V_PREPAID_AMOUNT := V_PREPAID_AMOUNT;
      END IF;
    ELSE
      --普通发票核销预付款发票的金额
      SELECT (-1) * NVL(SUM(AID1.AMOUNT), 0) PREPAY_AMOUNT_APPLIED
        INTO V_PREPAID_AMOUNT
        FROM AP_INVOICES_ALL              AI,
             AP_INVOICE_DISTRIBUTIONS_ALL AID1,
             AP_INVOICE_DISTRIBUTIONS_ALL AID2
       WHERE AID1.PREPAY_DISTRIBUTION_ID = AID2.INVOICE_DISTRIBUTION_ID
         AND AI.INVOICE_ID = AID2.INVOICE_ID
         AND AID1.AMOUNT < 0
         AND NVL(AID1.REVERSAL_FLAG, 'N') != 'Y'
         AND AID1.LINE_TYPE_LOOKUP_CODE = 'PREPAY'
         AND AID1.INVOICE_ID = P_INVOICE_ID;
    
    END IF;
  
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      RETURN V_PREPAID_AMOUNT;
    ELSE
      RETURN NVL(V_INVOICE_AMOUNT, 0) - V_PAYMENT_AMOUNT - V_PREPAID_AMOUNT - V_CUX_MONEY;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END MEW_GET_APINVOICE_BALANCE_P;
  /*
    往付款核销发票接口表插入数据
    V_PAYMENT_ID 合同侧付款子表ID
    V_INVOICE_ID EBS发票ID
    V_MONEY_AMOUNT 核销金额
  by mcq
  */

  PROCEDURE INSERT_PAYMENT_INVOICE_IMP(V_PAY_ID       NUMBER,
                                       V_VENDOR_ID    NUMBER,
                                       V_INVOICE_ID   NUMBER,
                                       V_MONEY_AMOUNT NUMBER) IS
    IS_EXISTS         NUMBER;
    L_IFACE_REC       CUX.CUX_SPM_EXPENSE_MANAGE_PAY%ROWTYPE; --付款核销发票头表
    L_IFACE_LINES_REC CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D%ROWTYPE; --付款核销发票子表   
  
    AP_INVOICES_ALL_TBL       AP_INVOICES_ALL%ROWTYPE; --EBS侧发票表
    SPM_CON_PAYMENT_CHILD_TBL SPM_CON_PAYMENT_CHILD%ROWTYPE; --付款子表  
  
    V_H_ID NUMBER(15);
    V_L_ID NUMBER(15);
  
    CURSOR CUR_1(G_PAYMENT_ID NUMBER) IS
      SELECT P.VENDOR_ID,
             S.PAY_DATE,
             P.DEPT_ID,
             S.MONEY_AMOUNT,
             S.PAY_BANK_ACCOUNT_ID,
             S.PAY_METHODS,
             S.CASH_FLOW_ID,
             P.ORG_ID,
             A.BANK_ACCT_USE_ID,
             P.REMARK,
             P.VENDOR_SITE_ID,
             S.PAYMENT_CHILD_ID AS PAYMENT_ID,
             S.CREATION_DATE,
             S.CREATED_BY,
             S.LAST_UPDATE_DATE,
             S.LAST_UPDATED_BY,
             S.LAST_UPDATE_LOGIN,
             S.PAYMENT_CODE
        FROM SPM_CON_PAYMENT          P,
             CE.CE_BANK_ACCT_USES_ALL A,
             SPM_CON_PAYMENT_CHILD    S
       WHERE P.PAYMENT_ID = S.PAYMENT_ID
         AND S.PAYMENT_CHILD_ID = G_PAYMENT_ID
         AND A.ORG_ID = P.ORG_ID
         AND A.BANK_ACCOUNT_ID = S.PAY_BANK_ACCOUNT_ID;
    REC_1 CUR_1%ROWTYPE;
    CURSOR CUR_2(V_INVOICE_ID NUMBER) IS
      SELECT * FROM AP_INVOICES_ALL A WHERE A.INVOICE_ID = V_INVOICE_ID;
  
  BEGIN
    OPEN CUR_1(V_PAY_ID);
    FETCH CUR_1
      INTO REC_1;
    /*IF CUR_1%FOUND THEN
    CLOSE CUR_1;
    
    SELECT CUX_EXPENSE_MANAGE_PAY_S.NEXTVAL INTO V_H_ID FROM DUAL;
    --执行头表赋值
    L_IFACE_REC.ID                := V_H_ID;
    L_IFACE_REC.PAY_DATE          := REC_1.PAY_DATE;
    L_IFACE_REC.DEPT_ID           := REC_1.DEPT_ID;
    L_IFACE_REC.AMOUNT            := REC_1.MONEY_AMOUNT;
    L_IFACE_REC.BANK_ACCOUNT_ID   := REC_1.PAY_BANK_ACCOUNT_ID;
    L_IFACE_REC.PAY_METHODS       := REC_1.PAY_METHODS;
    L_IFACE_REC.CASH_FLOW         := REC_1.CASH_FLOW_ID;
    L_IFACE_REC.ORG_ID            := REC_1.ORG_ID;
    L_IFACE_REC.ACC_CURRENCY      := UPPER('CNY');
    L_IFACE_REC.PAY_CURRENCY      := UPPER('CNY');
    L_IFACE_REC.BANK_ID           := REC_1.BANK_ACCT_USE_ID;
    L_IFACE_REC.COMMENTS          := REC_1.REMARK;
    L_IFACE_REC.VENDOR_SITE_ID    := REC_1.VENDOR_SITE_ID;
    L_IFACE_REC.APPLY_ID          := REC_1.PAYMENT_ID;
    L_IFACE_REC.CREATION_DATE     := REC_1.CREATION_DATE;
    L_IFACE_REC.CREATED_BY        := REC_1.CREATED_BY;
    L_IFACE_REC.LAST_UPDATE_DATE  := REC_1.LAST_UPDATE_DATE;
    L_IFACE_REC.LAST_UPDATED_BY   := REC_1.LAST_UPDATED_BY;
    L_IFACE_REC.LAST_UPDATE_LOGIN := REC_1.LAST_UPDATE_LOGIN;
    L_IFACE_REC.VENDOR_ID         := V_VENDOR_ID;
    L_IFACE_REC.VOUCHER_NUM       := REC_1.PAYMENT_CODE; --付款编号待确认
    L_IFACE_REC.ATTRIBUTE4        := REC_1.CASH_FLOW_ID;
    
    INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY VALUES L_IFACE_REC;*/
  
    FOR AP_INVOICES_ALL_TBL IN CUR_2(V_INVOICE_ID) LOOP
    
      SELECT CUX_EXPENSE_MANAGE_PAY_D_S.NEXTVAL INTO V_L_ID FROM DUAL;
    
      L_IFACE_LINES_REC.PAY_D_ID         := V_L_ID;
      L_IFACE_LINES_REC.PAY_H_ID         := -1;
      L_IFACE_LINES_REC.INVOICE_ID       := V_INVOICE_ID; ---ebs侧发票id
      L_IFACE_LINES_REC.COMMENTS         := AP_INVOICES_ALL_TBL.DESCRIPTION; --ebs侧发票头摘要
      L_IFACE_LINES_REC.ORG_ID           := AP_INVOICES_ALL_TBL.ORG_ID; --组织id
      L_IFACE_LINES_REC.THIS_AMOUNT      := V_MONEY_AMOUNT; --使用金额
      L_IFACE_LINES_REC.PAYMENT_CHILD_ID := V_PAY_ID;
    
      INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D
      VALUES L_IFACE_LINES_REC;
    
    END LOOP;
    /*ELSE
      CLOSE CUR_1;
    END IF;*/
  
  END INSERT_PAYMENT_INVOICE_IMP;

  /*=================================================================
  *   PROGRAM NAME: SPM_CON_AP_INVOICE_IMP
  *
  *   DESCRIPTION: 从接口中间表往EBS侧付款表同步数据
  *   ARGUMENT:
  *   PARAM : V_ID 本次需要同步的发票ID；V_RETURN_CODE 需要返回的执行情况； V_RETURN_MESSAGE 需要返回的错误原因
  *   HISTORY:
  *     1.0  20171102   MCQ           CREATED
  * ===============================================================*/
  PROCEDURE CUX_SPM_CON_PAYMENT_TO_EBS(S_ID             IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_H_ID            NUMBER;
    V_L_ID            NUMBER;
    L_IFACE_REC       CUX.CUX_SPM_EXPENSE_MANAGE_PAY%ROWTYPE;
    L_IFACE_LINES_REC CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D%ROWTYPE;
    ISEXIT            NUMBER;
    V_RETURN_ID       NUMBER;
    V_VENDOR_ID       NUMBER; --SPM侧供应商ID
    E_VENDOR_ID       NUMBER; --EBS侧供应商ID
    E_INVOICE_ID      NUMBER; --EBS侧发票ID
  
    L_USER_ID        NUMBER;
    L_RESP_ID        NUMBER;
    L_RESP_APPL_ID   NUMBER;
    V_VENDOR_SITE_ID NUMBER(15); --发票上供应商地点ID
  
    ZJ_CHECK_ID NUMBER(15); --暂时先启用这个变量
  
    CURSOR CUR_1(G_PAYMENT_CHILD_ID NUMBER) IS
      SELECT PC.*,
             P.VENDOR_ID,
             A.BANK_ACCT_USE_ID,
             P.VENDOR_SITE_ID,
             P.DESCRIPTION COMMENTS
        FROM SPM_CON_PAYMENT          P,
             CE.CE_BANK_ACCT_USES_ALL A,
             SPM_CON_PAYMENT_CHILD    PC
       WHERE 1 = 1
         AND PC.PAY_BANK_ACCOUNT_ID = A.BANK_ACCOUNT_ID(+)
         AND P.PAYMENT_ID = PC.PAYMENT_ID
         AND P.ORG_ID = A.ORG_ID
         AND PC.PAYMENT_CHILD_ID = G_PAYMENT_CHILD_ID;
    REC_1 CUR_1%ROWTYPE;
  BEGIN
    --校验付款单号在EBS侧是否存在
    SELECT COUNT(*)
      INTO ISEXIT
      FROM SPM_CON_PAYMENT_CHILD C, AP_CHECKS_ALL ACA
     WHERE C.PAYMENT_CODE = TO_CHAR(ACA.CHECK_NUMBER)
       AND C.PAYMENT_CHILD_ID = S_ID;
    IF ISEXIT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '当前付款单号已经执行同步财务操作或出现重复编号！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    --校验接口中间表子表金额与付款单子表总金额是否一致
    --遍历付款管理发票子表
    SELECT NVL(C.MONEY_AMOUNT, 0) -
           (SELECT NVL(SUM(D.THIS_AMOUNT), 0)
              FROM CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
             WHERE D.PAYMENT_CHILD_ID = C.PAYMENT_CHILD_ID)
      INTO ISEXIT
      FROM SPM_CON_PAYMENT_CHILD C
     WHERE C.PAYMENT_CHILD_ID = S_ID;
    IF ISEXIT <> 0 THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '核销EBS侧金额与付款单财务录入行金额不一致';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    OPEN CUR_1(S_ID);
    FETCH CUR_1
      INTO REC_1;
    IF CUR_1%FOUND THEN
      CLOSE CUR_1;
      BEGIN
      
        --查询对应的供应商ID及EBS发票ID
        BEGIN
          SELECT A.VENDOR_ID
            INTO E_VENDOR_ID
            FROM SPM_CON_VENDOR_INFO I
           INNER JOIN PO_VENDORS A
              ON I.VENDOR_CODE = A.SEGMENT1
           WHERE I.VENDOR_ID = REC_1.VENDOR_ID;
        
          IF E_VENDOR_ID IS NULL THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '选择的供应商未同步至财务';
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
        END;
      
        --查询对应发票上的供应商地点
        SELECT II.VENDOR_SITE_ID
          INTO V_VENDOR_SITE_ID
          FROM SPM_CON_PAYMENT_CHILD   P,
               SPM_CON_PAYMENT_INVOICE PI,
               SPM_CON_INPUT_INVOICE   II
         WHERE P.PAYMENT_ID = PI.PAYMENT_ID(+)
           AND PI.INPUT_INVOICE_ID = II.INPUT_INVOICE_ID(+)
           AND P.PAYMENT_CHILD_ID = S_ID
           AND ROWNUM = 1;
      
        SELECT CUX_EXPENSE_MANAGE_PAY_S.NEXTVAL INTO V_H_ID FROM DUAL;
        --执行头表赋值
        L_IFACE_REC.ID                := V_H_ID;
        L_IFACE_REC.PAY_DATE          := REC_1.PAY_DATE;
        L_IFACE_REC.AMOUNT            := REC_1.MONEY_AMOUNT;
        L_IFACE_REC.BANK_ACCOUNT_ID   := REC_1.PAY_BANK_ACCOUNT_ID;
        L_IFACE_REC.PAY_METHODS       := 'WIRE'; --固定传电汇
        L_IFACE_REC.CASH_FLOW         := REC_1.CASH_FLOW_ID;
        L_IFACE_REC.ORG_ID            := REC_1.ORG_ID;
        L_IFACE_REC.ACC_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.PAY_CURRENCY      := UPPER('CNY');
        L_IFACE_REC.BANK_ID           := REC_1.BANK_ACCT_USE_ID;
        L_IFACE_REC.COMMENTS          := REC_1.COMMENTS;
        L_IFACE_REC.APPLY_ID          := REC_1.PAYMENT_ID;
        L_IFACE_REC.CREATION_DATE     := REC_1.CREATION_DATE;
        L_IFACE_REC.CREATED_BY        := REC_1.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_DATE  := REC_1.LAST_UPDATE_DATE;
        L_IFACE_REC.LAST_UPDATED_BY   := REC_1.LAST_UPDATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN := REC_1.LAST_UPDATE_LOGIN;
        L_IFACE_REC.VENDOR_ID         := E_VENDOR_ID;
        L_IFACE_REC.VENDOR_SITE_ID    := V_VENDOR_SITE_ID; --2018011修改
        L_IFACE_REC.VOUCHER_NUM       := REC_1.PAYMENT_CODE; --付款编号待确认
        L_IFACE_REC.ATTRIBUTE4        := REC_1.CASH_FLOW_ID;
        IF REC_1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
          L_IFACE_REC.ATTRIBUTE1        := REC_1.MATCH_DEPT;
          L_IFACE_REC.ATTRIBUTE2        := REC_1.MATCH_PROJECT;
        END IF;
      
        INSERT INTO CUX.CUX_SPM_EXPENSE_MANAGE_PAY VALUES L_IFACE_REC;
        UPDATE CUX.CUX_SPM_EXPENSE_MANAGE_PAY_D D
           SET D.PAY_H_ID = V_H_ID
         WHERE D.PAYMENT_CHILD_ID = S_ID;
      
      EXCEPTION
      
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '有空值';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_CODE);
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
          RETURN;
      END;
    
      /*资金预算控制部分20190426 by mcq -- start*/
      IF REC_1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
      BEGIN
      
        --1.删除资金表相关记录
        DELETE FROM CUX.CUX_CP_FACT_ALL CFA
         WHERE CFA.SOURCE = 'AP_ZS_CHECK'
           AND CFA.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
        DELETE FROM CUX.CUX_CP_FACT_ALL_NEG CFA
         WHERE CFA.SOURCE = 'AP_ZS_CHECK'
           AND CFA.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
        --2.验证并插入资金表
        CUX_CP_VALIDAT_PKG.CUX_INSERT_CP_ACT('AP_ZS_CHECK',
                                             REC_1.PAYMENT_CHILD_ID, --业务表
                                             REC_1.MATCH_DEPT, --资金计划部门ID
                                             REC_1.MATCH_PROJECT, --资金项目
                                             TRUNC(SYSDATE), --SYSDATE 占有时间
                                             NVL(REC_1.MONEY_AMOUNT, 0), --付款金额
                                             NULL,
                                             REC_1.CASH_FLOW_ID, --现金流
                                             (CASE WHEN
                                              NVL(REC_1.MONEY_AMOUNT, 0) < 0 THEN 'Y' ELSE 'N' END));
      
        --3.校验当前组织是否启用资金控制
        SELECT COUNT(*)
          INTO ISEXIT
          FROM CUX.CUX_CP_ZZJG_TREE_CONFIG CCT
         WHERE CCT.ORG_ID = REC_1.ORG_ID
           AND NVL(CCT.ATTRIBUTE3, 'N') = 'Y'; --组织校验
      
        --如果当前组织启用了资金控制并且当前付款金额大于0，调用余额校验
        IF ISEXIT > 0 AND NVL(REC_1.MONEY_AMOUNT, 0) > 0 THEN
          CUX_CP_VALIDAT_PKG.CUX_VALIDAT_CP_YE(REC_1.ORG_ID,
                                               REC_1.MATCH_DEPT,
                                               REC_1.MATCH_PROJECT,
                                               TRUNC(SYSDATE),
                                               NVL(REC_1.MONEY_AMOUNT, 0),
                                               V_RETURN_MESSAGE);
          --P_MSG := V_MSG;
          --4.判断当前验证返回内容
          --如果验证未通过，删除痕迹
          IF V_RETURN_MESSAGE IS NOT NULL THEN
            DELETE FROM CUX.CUX_CP_FACT_ALL CCF
             WHERE CCF.SOURCE = 'AP_ZS_CHECK'
               AND CCF.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
            DELETE FROM CUX.CUX_CP_FACT_ALL_NEG CFA
             WHERE CFA.SOURCE = 'AP_ZS_CHECK'
               AND CFA.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
            COMMIT;
            --返回错误信息
            V_RETURN_CODE := G_INTERFACE_ERROR;
            DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
            RETURN;
          
          END IF;
        
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE    := G_INTERFACE_ERROR;
          V_RETURN_MESSAGE := '资金预算校验异常，请联系运维人员！';
          DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      END;
      END IF;
      /*资金预算控制部分20190426 by mcq -- end*/
      
      BEGIN
      
        CUX_SPM_EXP_IMPORT_PAYMENT_PKG.IMPORT_PAYMENT(P_MANAGE_PAY_ID => V_H_ID,
                                                      P_MSG           => V_RETURN_MESSAGE,
                                                      P_CHECK_ID      => V_RETURN_ID);
      
        /*资金预算同步结束处理20190426 by mcq -- start*/
        IF REC_1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
          --如果同步EBS出现问题 ，首先删除痕迹,AP_ZS_CHECK是一个中间状态，所以痕迹表要及时删除
          DELETE FROM CUX.CUX_CP_FACT_ALL CFA
           WHERE CFA.SOURCE = 'AP_ZS_CHECK'
             AND CFA.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
          DELETE FROM CUX.CUX_CP_FACT_ALL_NEG CFA
           WHERE CFA.SOURCE = 'AP_ZS_CHECK'
             AND CFA.SOURCE_ID = REC_1.PAYMENT_CHILD_ID;
          COMMIT;
        
          --则需要判断下是否数据是否已经到AP_CHECKS_ALL
          SELECT COUNT(*)
            INTO ISEXIT
            FROM AP_CHECKS_ALL ACA
           WHERE ACA.CHECK_NUMBER = REC_1.PAYMENT_CODE;
          --如果存在，重新插入痕迹，标识为AP_CHECK
          IF ISEXIT <> 0 THEN
            SELECT ACA.CHECK_ID
              INTO ZJ_CHECK_ID
              FROM AP_CHECKS_ALL ACA
             WHERE ACA.CHECK_NUMBER = REC_1.PAYMENT_CODE
               AND ROWNUM = 1;
            CUX_CP_VALIDAT_PKG.CUX_INSERT_CP_ACT('AP_CHECK',
                                                 ZJ_CHECK_ID, --?这里是插入EBS侧CHECK_ID吧
                                                 REC_1.MATCH_DEPT,
                                                 REC_1.MATCH_PROJECT,
                                                 trunc(SYSDATE),
                                                 NVL(REC_1.MONEY_AMOUNT, 0),
                                                 NULL,
                                                 REC_1.CASH_FLOW_ID, --现金流
                                                 (CASE WHEN
                                                  NVL(REC_1.MONEY_AMOUNT, 0) < 0 THEN 'Y' ELSE 'N' END));
          
          END IF;
        END IF;
        /*资金预算同步结束处理20190426 by mcq -- end*/
      
        /* 导入付款，返回EBS付款ID，如果返回就是导入成功，否则看错误信息   */
        IF V_RETURN_ID IS NULL THEN
          V_RETURN_CODE := G_INTERFACE_ERROR;
          RETURN;
        ELSE
          V_RETURN_CODE := G_INTERFACE_SUCCESS;
          /*CUX_CP_VALIDAT_PKG.CUX_INSERT_CP_ACT('AP_CHECK',
          V_RETURN_ID, --?这里是插入EBS侧CHECK_ID吧
          REC_1.MATCH_DEPT,
          REC_1.MATCH_PROJECT,
          trunc(SYSDATE),
          NVL(REC_1.MONEY_AMOUNT, 0),
          NULL,
          REC_1.CASH_FLOW_ID, --现金流
          (CASE WHEN
           NVL(REC_1.MONEY_AMOUNT, 0) < 0 THEN 'Y' ELSE 'N' END));*/
        
          RETURN;
        END IF;
      END;
    
    ELSE
      CLOSE CUR_1;
      V_RETURN_CODE := G_INTERFACE_ERROR;
      V_RETURN_CODE := '未查询到对应付款数据';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := G_INTERFACE_ERROR;
      V_RETURN_MESSAGE := '存储过程调用异常，请刷新页面后再次尝试！';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
  END CUX_SPM_CON_PAYMENT_TO_EBS;

  --验证资金管理付款关联发票与合同条款
  PROCEDURE JUDGE_PAYMENT_CLAUSE(V_ID     IN NUMBER,
                                 V_STATUS OUT VARCHAR2,
                                 V_REASON OUT VARCHAR2) IS
    V_AMOUNT NUMBER;
  
    CURSOR CUR1(V_PAYMENT_ID NUMBER) IS
      SELECT H.CONTRACT_ID, SUM(P.MONEY_AMOUNT) MONEY_AMOUNT
        FROM SPM_CON_PAYMENT_INVOICE P,
             SPM_CON_INPUT_INVOICE   I,
             SPM_CON_HT_INFO         H
       WHERE P.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
         AND I.CONTRACT_ID = H.CONTRACT_ID
         AND P.PAYMENT_ID = V_PAYMENT_ID
         AND H.CONTRACT_FORM = '1'
         AND H.CONTRACT_TYPE = '1'
       GROUP BY (H.CONTRACT_ID);
    REC1 CUR1%ROWTYPE;
  BEGIN
    V_STATUS := 'S';
    --遍历
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC1;
    WHILE CUR1%FOUND LOOP
    
      -- 查询关联条款总金额与发票金额的差异
      SELECT NVL(SUM(H.RMB_TOTAL), 0) - REC1.MONEY_AMOUNT
        INTO V_AMOUNT
        FROM SPM_CON_PAYMENT_CLAUSE C,
             SPM_CON_HT_CLAUSE      H,
             SPM_CON_PAYMENT        P
       WHERE C.CLAUSE_ID = H.CLAUSE_ID
         AND C.PAYMENT_ID = P.PAYMENT_ID
         AND H.CONTRACT_ID = REC1.CONTRACT_ID
         AND P.PAYMENT_ID = V_ID;
    
      IF V_AMOUNT < 0 THEN
        V_STATUS := 'E';
        V_REASON := '核销发票金额不能超过关联合同条款的总金额';
        RETURN;
      END IF;
      FETCH CUR1
        INTO REC1;
    END LOOP;
    CLOSE CUR1;
  EXCEPTION
    WHEN OTHERS THEN
      V_STATUS := 'E';
      V_REASON := '存储过程执行错误';
  END JUDGE_PAYMENT_CLAUSE;

  --验证资金管理付款关联发票与合同条款
  FUNCTION JUDGE_PAYMENT_CLAUSE_F(V_ID IN NUMBER) RETURN BOOLEAN IS
    V_AMOUNT NUMBER;
  
    CURSOR CUR1(V_PAYMENT_ID NUMBER) IS
      SELECT H.CONTRACT_ID, SUM(P.MONEY_AMOUNT) MONEY_AMOUNT
        FROM SPM_CON_PAYMENT_INVOICE P,
             SPM_CON_INPUT_INVOICE   I,
             SPM_CON_HT_INFO         H
       WHERE P.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
         AND I.CONTRACT_ID = H.CONTRACT_ID
         AND P.PAYMENT_ID = V_PAYMENT_ID
         AND H.CONTRACT_FORM = '1'
         AND H.CONTRACT_TYPE = '1'
       GROUP BY (H.CONTRACT_ID);
    REC1 CUR1%ROWTYPE;
  BEGIN
    --遍历
    OPEN CUR1(V_ID);
    FETCH CUR1
      INTO REC1;
    WHILE CUR1%FOUND LOOP
    
      -- 查询关联条款总金额与发票金额的差异
      SELECT NVL(SUM(C.MONEY_AMOUNT), 0) - REC1.MONEY_AMOUNT
        INTO V_AMOUNT
        FROM SPM_CON_PAYMENT_CLAUSE C,
             SPM_CON_HT_CLAUSE      H,
             SPM_CON_PAYMENT        P
       WHERE C.CLAUSE_ID = H.CLAUSE_ID
         AND C.PAYMENT_ID = P.PAYMENT_ID
         AND H.CONTRACT_ID = REC1.CONTRACT_ID
         AND P.PAYMENT_ID = V_ID;
    
      IF V_AMOUNT < 0 THEN
        RETURN FALSE;
      END IF;
      FETCH CUR1
        INTO REC1;
    END LOOP;
    CLOSE CUR1;
    RETURN TRUE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END JUDGE_PAYMENT_CLAUSE_F;

  -- 出库单出库
  PROCEDURE GENERATE_SALE_ORDER(V_ID             IN NUMBER,
                                V_RETURN_CODE    OUT VARCHAR2,
                                V_RETURN_MESSAGE OUT VARCHAR2) IS
    IS_EXISTS   NUMBER;
    L_IFACE_REC MTL_TRANSACTIONS_INTERFACE%ROWTYPE; --中间表
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    V_TYPE_ID   NUMBER;
    V_SOUCRE_ID NUMBER;
    P_AMOUNT    NUMBER; --本次出库量
    V_NUMBER    VARCHAR2(200);
  
    V_SEG1  VARCHAR2(100);
    V_SEG2  VARCHAR2(100);
    V_SEG3  VARCHAR2(100);
    V_SEG4  VARCHAR2(100);
    V_SEG19 VARCHAR2(100);
    V_SEG20 VARCHAR2(100);
  
    V_ITEM_ID NUMBER;
    V_UOM     VARCHAR2(200);
  
    CURSOR CUR_1 IS
      SELECT O.*, H.CONTRACT_CODE HT_CODE
        FROM SPM_CON_ODO O, SPM_CON_HT_INFO H
       WHERE O.CONTRACT_ID = H.CONTRACT_ID
         AND O.ODO_ID = V_ID;
    CURSOR CUR_2 IS
      SELECT * FROM SPM_CON_ODO_DL D WHERE D.ODO_ID = V_ID;
  BEGIN
    FOR REC_1 IN CUR_1 LOOP
    
      --1.获取接口参数  
      --事务处理对应类型
      SELECT DT.TRANSACTION_TYPE_ID
        INTO V_TYPE_ID
        FROM MTL_TRANSACTION_TYPES DT
       WHERE DT.TRANSACTION_TYPE_NAME = '销售出库';
    
      --账户别名
      SELECT DD.DISPOSITION_ID
        INTO V_SOUCRE_ID
        FROM MTL_GENERIC_DISPOSITIONS DD
       WHERE DD.ORGANIZATION_ID = REC_1.ORG_ID
         AND DD.SEGMENT1 = '销售出库';
    
      --删除接口里的错误数据
      DELETE FROM MTL_TRANSACTIONS_INTERFACE M
       WHERE 1 = 1
         AND M.ATTRIBUTE13 = 'F'
         AND EXISTS
       (SELECT *
                FROM SPM_CON_ODO_DL O
               WHERE O.ODO_ID = V_ID
                 AND TO_NUMBER(M.ATTRIBUTE14) = O.SPM_CON_ODO_DL_ID);
    
      FOR REC_2 IN CUR_2 LOOP
      
        --2.校验过程
        --如果接口表中已经有了，则直接跳到下一次循环
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM MTL_TRANSACTIONS_INTERFACE T
         WHERE T.ATTRIBUTE14 = REC_2.SPM_CON_ODO_DL_ID
           AND SOURCE_CODE = '销售出库';
      
        IF IS_EXISTS <> 0 THEN
          CONTINUE;
        END IF;
      
        BEGIN
        
          SELECT MSIB.INVENTORY_ITEM_ID, MSIB.PRIMARY_UOM_CODE
            INTO V_ITEM_ID, V_UOM
            FROM MTL_SYSTEM_ITEMS_B MSIB
           WHERE MSIB.ORGANIZATION_ID = REC_1.ORG_ID
             AND MSIB.SEGMENT1 = TO_CHAR(REC_2.MATERIAL_CODE)
             AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '获取物料错误';
            RETURN;
        END;
      
        BEGIN
          SELECT MI.SEGMENT1,
                 MI.SEGMENT2,
                 MI.SEGMENT3,
                 MI.SEGMENT4,
                 MI.SEGMENT5,
                 MI.SEGMENT6
            INTO V_SEG1, V_SEG2, V_SEG3, V_SEG4, V_SEG19, V_SEG20
            FROM MTL_ITEM_LOCATIONS_KFV MI
           WHERE MI.INVENTORY_LOCATION_ID = REC_2.GOODS_LOCATION;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE    := G_INTERFACE_ERROR;
            V_RETURN_MESSAGE := '获取货位错误';
            RETURN;
        END;
      
        --销售出库即为负数
        P_AMOUNT := -1 * REC_2.THIS_ODO_NUMBER;
        V_NUMBER := CUX_INV_NUMBER_PKG.GET_ASSIGN_NUMBER('CKD',
                                                         REC_1.ORG_ID);
      
        L_IFACE_REC.SOURCE_CODE       := '销售出库';
        L_IFACE_REC.SOURCE_LINE_ID    := 0;
        L_IFACE_REC.SOURCE_HEADER_ID  := 0;
        L_IFACE_REC.PROCESS_FLAG      := 1;
        L_IFACE_REC.TRANSACTION_MODE  := 3;
        L_IFACE_REC.LOCK_FLAG         := 2;
        L_IFACE_REC.LAST_UPDATE_DATE  := SYSDATE;
        L_IFACE_REC.LAST_UPDATED_BY   := REC_2.LAST_UPDATED_BY;
        L_IFACE_REC.CREATION_DATE     := SYSDATE;
        L_IFACE_REC.CREATED_BY        := REC_2.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN := REC_2.LAST_UPDATE_LOGIN;
        L_IFACE_REC.INVENTORY_ITEM_ID := V_ITEM_ID;
        L_IFACE_REC.ORGANIZATION_ID   := REC_1.ORG_ID;
      
        L_IFACE_REC.TRANSACTION_QUANTITY  := P_AMOUNT; --TRANSACTION_QUANTITY
        L_IFACE_REC.PRIMARY_QUANTITY      := P_AMOUNT; --PRIMARY_QUANTITY
        L_IFACE_REC.TRANSACTION_UOM       := V_UOM; --TRANSACTION_UOM
        L_IFACE_REC.TRANSACTION_DATE      := REC_1.ODO_DATE; --事物日期
        L_IFACE_REC.SUBINVENTORY_CODE     := REC_2.STORE_ROOM; --SUBINVENTORY_CODE
        L_IFACE_REC.TRANSACTION_SOURCE_ID := V_SOUCRE_ID; --事物处理类型来源
        L_IFACE_REC.TRANSACTION_TYPE_ID   := V_TYPE_ID; --事物处理类型
        L_IFACE_REC.TRANSACTION_COST      := REC_2.ODO_UNIT_PRICE; --TRANSATION_COST  单价
        L_IFACE_REC.LOC_SEGMENT1          := V_SEG1;
        L_IFACE_REC.LOC_SEGMENT2          := V_SEG2;
        L_IFACE_REC.LOC_SEGMENT3          := V_SEG3;
        L_IFACE_REC.LOC_SEGMENT4          := V_SEG4;
        L_IFACE_REC.LOC_SEGMENT5          := V_SEG19;
        L_IFACE_REC.LOC_SEGMENT6          := V_SEG20;
        L_IFACE_REC.ATTRIBUTE14           := TO_CHAR(REC_2.SPM_CON_ODO_DL_ID);
        L_IFACE_REC.ATTRIBUTE15           := V_NUMBER;
        L_IFACE_REC.ATTRIBUTE13           := 'N'; --同步状态 BY MCQ
        L_IFACE_REC.ATTRIBUTE1            := REC_1.EBS_DEPT_CODE;
        L_IFACE_REC.ATTRIBUTE2            := REC_1.HT_CODE;
        L_IFACE_REC.ATTRIBUTE4            := REC_1.ODO_CODE;
      
      END LOOP;
    
    END LOOP;
  
    V_RETURN_CODE    := G_INTERFACE_SUCCESS;
    V_RETURN_MESSAGE := '插入接口表-成功';
  
  END GENERATE_SALE_ORDER;

  -- 批量出库单出库
  /*
    ATTRIBUTE1 部门段
    ATTRIBUTE2 合同编号
    ATTRIBUTE3 合同名称
    ATTRIBUTE4 出入库编号
    ATTRIBUTE5 项目编号
    ATTRIBUTE6 产品段
    ATTRIBUTE7 出库单对应入库单号
  */
  PROCEDURE BATCH_GENERATE_SALE_ORDER(V_ORG_ID IN NUMBER) IS
    IS_EXISTS   NUMBER;
    L_IFACE_REC MTL_TRANSACTIONS_INTERFACE%ROWTYPE; --中间表    
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
  
    V_TYPE_ID   NUMBER;
    V_SOUCRE_ID NUMBER;
    P_AMOUNT    NUMBER; --本次出库量
    V_NUMBER    VARCHAR2(200);
    P_BATCH_ID  NUMBER(15); --本次操作批次id  
  
    V_SEG1  VARCHAR2(100);
    V_SEG2  VARCHAR2(100);
    V_SEG3  VARCHAR2(100);
    V_SEG4  VARCHAR2(100);
    V_SEG19 VARCHAR2(100);
    V_SEG20 VARCHAR2(100);
  
    V_ITEM_ID NUMBER;
    V_UOM     VARCHAR2(200);
  
    --批量接口返回错误原因
    V_OUT_MAG        VARCHAR2(1000);
    V_RETURN_CODE    VARCHAR2(10);
    V_RETURN_MESSAGE VARCHAR2(1000);
  
    P_WARE_CODE VARCHAR2(100); --出库单明细对应入库单号
  
    CURSOR CUR_1(C_ORG_ID NUMBER) IS
      SELECT O.*,
             H.CONTRACT_CODE HT_CODE,
             H.CONTRACT_NAME HT_NAME,
             Q.QUEUE_ID
        FROM SPM_CON_ODO O, SPM_CON_HT_INFO H, SPM_CON_INV_QUEUE Q
       WHERE O.CONTRACT_ID = H.CONTRACT_ID
         AND Q.BUSINESS_ID = O.ODO_ID
         AND Q.BUSINESS_TYPE = 'ODO_SALE_ORDER'
         AND Q.SEND_STATUS = 'N'
         AND Q.ORG_ID = C_ORG_ID;
    REC_1 CUR_1%ROWTYPE;
    CURSOR CUR_2(C_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_ODO_DL D
       WHERE D.SYNC_STATUS <> 'S' --成功传过一次就不在同步
         AND D.ODO_ID = C_ID;
    CURSOR CUR_3(C_BATHC_ID NUMBER) IS
      SELECT O.*, Q.QUEUE_ID
        FROM SPM_CON_ODO O, SPM_CON_INV_QUEUE Q
       WHERE 1 = 1
         AND Q.BUSINESS_ID = O.ODO_ID
         AND Q.BUSINESS_TYPE = 'ODO_SALE_ORDER'
            --AND Q.SEND_STATUS = 'I'
         AND Q.BATCH_ID = C_BATHC_ID;
  BEGIN
  
    --获取本次操作的batch_id
    P_BATCH_ID := SPM_CON_QUEUE_BATCH_SEQ.NEXTVAL;
    --开始循环
    FOR REC_1 IN CUR_1(V_ORG_ID) LOOP
      --删除表中原错误数据
      DELETE FROM SPM_CON_INV_QUEUE Q
       WHERE Q.BUSINESS_ID = REC_1.ODO_ID
         AND Q.SEND_STATUS = 'I';
      --更新队列表中的批次，将状态修改为执行中
      UPDATE SPM_CON_INV_QUEUE Q
         SET Q.BATCH_ID = P_BATCH_ID, Q.SEND_STATUS = 'I'
       WHERE Q.QUEUE_ID = REC_1.QUEUE_ID;
    
      --1.获取接口参数  
      --事务处理对应类型
      SELECT DT.TRANSACTION_TYPE_ID
        INTO V_TYPE_ID
        FROM MTL_TRANSACTION_TYPES DT
       WHERE DT.transaction_type_name = '销售出库';
    
      --账户别名
      SELECT DD.DISPOSITION_ID
        INTO V_SOUCRE_ID
        FROM MTL_GENERIC_DISPOSITIONS DD
       WHERE DD.ORGANIZATION_ID = REC_1.ORG_ID
         AND DD.SEGMENT1 = '销售出库';
    
      --删除接口里的错误数据
      /*DELETE FROM MTL_TRANSACTIONS_INTERFACE M
      WHERE 1 = 1
        AND M.ATTRIBUTE13 = 'F'
        AND EXISTS
      (SELECT *
               FROM SPM_CON_ODO_DL O
              WHERE O.ODO_ID = REC_1.ODO_ID
                AND TO_NUMBER(M.ATTRIBUTE14) = O.SPM_CON_ODO_DL_ID);*/
    
      FOR REC_2 IN CUR_2(REC_1.ODO_ID) LOOP
      
        --2.校验过程
        --如果接口表中已经有了，则直接跳到下一次循环
        /*
          --没必要存在
          SELECT COUNT(*)
          INTO IS_EXISTS
          FROM MTL_TRANSACTIONS_INTERFACE T
         WHERE T.ATTRIBUTE14 = REC_2.SPM_CON_ODO_DL_ID
           AND SOURCE_CODE = '销售出库';
        
        IF IS_EXISTS <> 0 THEN
          CONTINUE;
        END IF;*/
      
        BEGIN
        
          SELECT MSIB.INVENTORY_ITEM_ID, MSIB.PRIMARY_UOM_CODE
            INTO V_ITEM_ID, V_UOM
            FROM MTL_SYSTEM_ITEMS_B MSIB
           WHERE MSIB.ORGANIZATION_ID = REC_1.ORG_ID
             AND MSIB.SEGMENT1 = TO_CHAR(REC_2.MATERIAL_CODE)
             AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
          
            --更新Queue表及业务表
            UPDATE SPM_CON_INV_QUEUE Q
               SET Q.SEND_STATUS = G_INTERFACE_ERROR
             WHERE Q.QUEUE_ID = REC_1.QUEUE_ID;
          
            UPDATE SPM_CON_ODO_DL O
               SET O.SYNC_STATUS = G_INTERFACE_ERROR,
                   O.SYNC_ERROR  = '获取物料错误'
             WHERE O.SPM_CON_ODO_DL_ID = REC_2.SPM_CON_ODO_DL_ID;
            EXIT;
        END;
      
        BEGIN
          SELECT MI.SEGMENT1,
                 MI.SEGMENT2,
                 MI.SEGMENT3,
                 MI.SEGMENT4,
                 MI.SEGMENT5,
                 MI.SEGMENT6
            INTO V_SEG1, V_SEG2, V_SEG3, V_SEG4, V_SEG19, V_SEG20
            FROM MTL_ITEM_LOCATIONS_KFV MI
           WHERE MI.INVENTORY_LOCATION_ID = REC_2.GOODS_LOCATION;
        EXCEPTION
          WHEN OTHERS THEN
            --删除接口表中的已经插入的该出库单数据
            DELETE FROM MTL_TRANSACTIONS_INTERFACE D
             WHERE D.ATTRIBUTE4 = REC_1.ODO_CODE;
          
            UPDATE SPM_CON_INV_QUEUE Q
               SET Q.SEND_STATUS = G_INTERFACE_ERROR
             WHERE Q.QUEUE_ID = REC_1.QUEUE_ID;
          
            UPDATE SPM_CON_ODO_DL O
               SET O.SYNC_STATUS = G_INTERFACE_ERROR,
                   O.SYNC_ERROR  = '获取货位错误'
             WHERE O.SPM_CON_ODO_DL_ID = REC_2.SPM_CON_ODO_DL_ID;
          
            EXIT; --如果一条子数据有问题，则直接执行下一条出库数据
        END;
      
        --获取对应的出库明细对应的入库单号
        P_WARE_CODE := '';
        BEGIN
          SELECT W.WAREHOUSE_CODE
            INTO P_WARE_CODE
            FROM SPM_CON_ODO_DL       OD,
                 SPM_CON_WAREHOUSE    W,
                 SPM_CON_WAREHOUSE_DL WD
           WHERE OD.WAREHOUSE_DL_ID = WD.WAREHOUSE_DL_ID
             AND W.WAREHOUSE_ID = WD.WAREHOUSE_ID
             AND OD.SPM_CON_ODO_DL_ID = REC_2.SPM_CON_ODO_DL_ID;
        EXCEPTION
          WHEN OTHERS THEN
            P_WARE_CODE := '';
        END;
      
        --销售出库即为负数
        P_AMOUNT := -1 * REC_2.THIS_ODO_NUMBER;
        V_NUMBER := CUX_INV_NUMBER_PKG.GET_ASSIGN_NUMBER('CKD',
                                                         REC_1.ORG_ID);
      
        L_IFACE_REC.SOURCE_CODE       := '销售出库';
        L_IFACE_REC.SOURCE_LINE_ID    := 0;
        L_IFACE_REC.SOURCE_HEADER_ID  := 0;
        L_IFACE_REC.PROCESS_FLAG      := 1;
        L_IFACE_REC.TRANSACTION_MODE  := 3;
        L_IFACE_REC.LOCK_FLAG         := 2;
        L_IFACE_REC.LAST_UPDATE_DATE  := SYSDATE;
        L_IFACE_REC.LAST_UPDATED_BY   := REC_2.LAST_UPDATED_BY;
        L_IFACE_REC.CREATION_DATE     := SYSDATE;
        L_IFACE_REC.CREATED_BY        := REC_2.CREATED_BY;
        L_IFACE_REC.LAST_UPDATE_LOGIN := REC_2.LAST_UPDATE_LOGIN;
        L_IFACE_REC.INVENTORY_ITEM_ID := V_ITEM_ID;
        L_IFACE_REC.ORGANIZATION_ID   := REC_1.ORG_ID;
      
        L_IFACE_REC.TRANSACTION_QUANTITY  := P_AMOUNT; --TRANSACTION_QUANTITY
        L_IFACE_REC.PRIMARY_QUANTITY      := P_AMOUNT; --PRIMARY_QUANTITY
        L_IFACE_REC.TRANSACTION_UOM       := V_UOM; --TRANSACTION_UOM
        L_IFACE_REC.TRANSACTION_DATE      := REC_1.ODO_DATE; --事物日期
        L_IFACE_REC.SUBINVENTORY_CODE     := REC_2.STORE_ROOM; --SUBINVENTORY_CODE
        L_IFACE_REC.TRANSACTION_SOURCE_ID := V_SOUCRE_ID; --事物处理类型来源
        L_IFACE_REC.TRANSACTION_TYPE_ID   := V_TYPE_ID; --事物处理类型
        L_IFACE_REC.TRANSACTION_COST      := REC_2.ODO_UNIT_PRICE; --TRANSATION_COST  单价
        L_IFACE_REC.LOC_SEGMENT1          := V_SEG1;
        L_IFACE_REC.LOC_SEGMENT2          := V_SEG2;
        L_IFACE_REC.LOC_SEGMENT3          := V_SEG3;
        L_IFACE_REC.LOC_SEGMENT4          := V_SEG4;
        L_IFACE_REC.LOC_SEGMENT5          := V_SEG19;
        L_IFACE_REC.LOC_SEGMENT6          := V_SEG20;
        L_IFACE_REC.ATTRIBUTE14           := TO_CHAR(REC_2.SPM_CON_ODO_DL_ID);
        L_IFACE_REC.ATTRIBUTE15           := V_NUMBER;
        L_IFACE_REC.ATTRIBUTE13           := TO_CHAR(P_BATCH_ID); --同步状态 BY MCQ
        L_IFACE_REC.ATTRIBUTE1            := REC_1.EBS_DEPT_CODE;
        L_IFACE_REC.ATTRIBUTE2            := REC_1.HT_CODE;
        L_IFACE_REC.ATTRIBUTE3            := REC_1.HT_NAME;
        L_IFACE_REC.ATTRIBUTE4            := REC_1.ODO_CODE;
        L_IFACE_REC.ATTRIBUTE5            := REC_1.Project_Code;
        L_IFACE_REC.ATTRIBUTE6            := REC_1.Ebs_Produce; --产品段
        L_IFACE_REC.ATTRIBUTE7            := P_WARE_CODE; --出库单明细对应的入库单号
      
        INSERT INTO MTL_TRANSACTIONS_INTERFACE VALUES L_IFACE_REC;
        INSERT INTO CUX_MTL_TRANS_INTERFACE_T VALUES L_IFACE_REC;
      
      END LOOP;
    
    --如果往接口表插入成功，则需要将队列中的状态修改为S
    /*IF V_RETURN_CODE = G_INTERFACE_SUCCESS THEN
                                            UPDATE SPM_CON_INV_QUEUE Q
                                               SET Q.SEND_STATUS = 'S'
                                             WHERE Q.QUEUE_ID = REC_1.QUEUE_ID;
                                          END IF;*/
    
    END LOOP;
  
    V_RETURN_CODE    := G_INTERFACE_SUCCESS;
    V_RETURN_MESSAGE := '插入接口表-成功';
  
    --判断有没有数据
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_INV_QUEUE Q
     WHERE Q.BATCH_ID = P_BATCH_ID;
  
    if is_exists <> 0 then
    
      --调用饶文佳的请求包 批量执行出库操作
      V_OUT_MAG := '';
      --cux_spm_data_po_pkg.commit_inv_request_new(V_ORG_ID, V_OUT_MAG);
    
      --如果请求返回成功
      --以接口表为准，成功后会删除
      --IF V_OUT_MAG = '物料事务处理成功' THEN
      UPDATE SPM_CON_ODO_DL O
         SET O.Sync_Status = 'S',
             O.LAST_UPDATE_DATE = SYSDATE
       WHERE 1 = 1
         AND NOT EXISTS (SELECT *
                FROM MTL_TRANSACTIONS_INTERFACE T
               WHERE 1 = 1
                 AND T.ATTRIBUTE13 = TO_CHAR(P_BATCH_ID))
         AND EXISTS (SELECT *
                FROM SPM_CON_INV_QUEUE Q
               WHERE Q.BATCH_ID = P_BATCH_ID
                 AND O.ODO_ID = Q.BUSINESS_ID);
    
      UPDATE SPM_CON_ODO_DL O
         SET O.Sync_Status = 'E',
             O.LAST_UPDATE_DATE = SYSDATE,
             O.SYNC_ERROR =
             (SELECT M.Error_Explanation
                FROM MTL_TRANSACTIONS_INTERFACE M
               WHERE M.ATTRIBUTE14 = TO_CHAR(O.SPM_CON_ODO_DL_ID)
                 AND M.ATTRIBUTE13 = TO_CHAR(P_BATCH_ID))
       WHERE 1 = 1
         AND EXISTS
       (SELECT *
                FROM MTL_TRANSACTIONS_INTERFACE M
               WHERE M.ATTRIBUTE14 = TO_CHAR(O.SPM_CON_ODO_DL_ID)
                 AND M.ATTRIBUTE15 = TO_CHAR(P_BATCH_ID))
         AND EXISTS (SELECT *
                FROM SPM_CON_INV_QUEUE Q
               WHERE Q.BATCH_ID = P_BATCH_ID
                 AND O.ODO_ID = Q.BUSINESS_ID);
    
      --更新主表状态
      FOR REC_3 IN CUR_3(P_BATCH_ID) LOOP
        --根据子表中是否存在状态为E的数据,如果不存在则更新出库单为出库成功
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_ODO_DL D
         WHERE 1 = 1
           AND EXISTS (SELECT *
                  FROM SPM_CON_INV_QUEUE Q, SPM_CON_ODO O
                 WHERE Q.BUSINESS_ID = O.ODO_ID
                   AND Q.BUSINESS_TYPE = 'ODO_SALE_ORDER'
                   AND Q.BATCH_ID = P_BATCH_ID)
           AND NVL(D.SYNC_STATUS, 'N') = 'E';
        IF IS_EXISTS <> 0 THEN
          UPDATE SPM_CON_ODO O
             SET O.ATTRIBUTE5 = 'F'
           WHERE O.ODO_ID = REC_3.ODO_ID;
        ELSE
          UPDATE SPM_CON_ODO O
             SET O.ATTRIBUTE5 = 'Y',
                 O.LAST_UPDATE_DATE = SYSDATE
           WHERE O.ODO_ID = REC_3.ODO_ID;
        END IF;
      
      END LOOP;
    END IF;
  
  END BATCH_GENERATE_SALE_ORDER;
  --收款自动匹配EBS发票
  PROCEDURE MATCH_AR_INVOICE_FOR_RECEIPT(K_RECEIPT_ID     IN NUMBER,
                                         K_RETURN_CODE    OUT VARCHAR2,
                                         K_RETURN_MESSAGE OUT VARCHAR2) IS
  
    K_RECEIPT_NUMBER VARCHAR2(40); --收款单编号
    K_RECEIPT_AMOUNT NUMBER; --收款单金额 
    K_REMAIN_NUMBER  NUMBER; --剩余未核销金额
    K_HX_AMOUNT      NUMBER; --单笔记录核销金额
    K_CUST_ID        NUMBER; --合同侧客户主键
    K_ORG_ID         NUMBER; --组织id
    K_EBS_STATUS         VARCHAR2(40);--ebs同步状态
  
    CURSOR AR_INVOICES(K_C_ID NUMBER, P_ORG_ID NUMBER) IS
      WITH CUS AS
       (SELECT T.CUSTOMER_TRX_ID,
               SUM(TL.EXTENDED_AMOUNT) AS INVOICE_AMOUNT,
               MAX(A.GL_DATE) GL_DATE
          FROM RA_CUSTOMER_TRX_LINES_ALL    TL,
               RA_CUSTOMER_TRX_ALL          T,
               RA_CUST_TRX_LINE_GL_DIST_ALL A
         WHERE T.CUSTOMER_TRX_ID = TL.CUSTOMER_TRX_ID
           AND QUERY_RESIDUAL_AMOUNT(T.CUSTOMER_TRX_ID) > 0
           AND T.CUSTOMER_TRX_ID = A.CUSTOMER_TRX_ID
           AND T.ORG_ID = P_ORG_ID
         GROUP BY T.CUSTOMER_TRX_ID),
      SCU AS
       (SELECT C.CUST_ID, HCA.CUST_ACCOUNT_ID, HCA.ACCOUNT_NUMBER
          FROM SPM_CON_CUST_INFO C, HZ_CUST_ACCOUNTS HCA
         WHERE C.CUST_CODE = HCA.ACCOUNT_NUMBER)
      
      SELECT QUERY_RESIDUAL_AMOUNT(CUS.CUSTOMER_TRX_ID) AS RESIDUAL_AMOUNT,
             RCTA.TRX_NUMBER AS INVOICE_CODE,
             CUS.GL_DATE
        FROM CUS,
             RA_CUSTOMER_TRX_ALL    RCTA,
             SCU,
             SPM_CON_PROJECT_V      SCP,
             CUX_PO_CONTRACT_INFO_V HT
       WHERE CUS.CUSTOMER_TRX_ID = RCTA.CUSTOMER_TRX_ID
         AND SCU.CUST_ACCOUNT_ID = RCTA.BILL_TO_CUSTOMER_ID
         AND SCP.PROJECT_CODE = RCTA.ATTRIBUTE5
         AND HT.CONTRACT_NUMBER(+) = RCTA.ATTRIBUTE6
         AND SCU.CUST_ID = K_C_ID
       ORDER BY CUS.GL_DATE;
  
  BEGIN
    --查找收款单编号/收款单金额/组织id
    SELECT T.RECEIPT_CODE, T.MONEY_AMOUNT, T.ORG_ID,T.EBS_STATUS
      INTO K_RECEIPT_NUMBER, K_RECEIPT_AMOUNT, K_ORG_ID,K_EBS_STATUS
      FROM SPM_CON_RECEIPT T
     WHERE T.RECEIPT_ID = K_RECEIPT_ID;
     
   IF K_EBS_STATUS <> 'S' THEN
      K_RETURN_CODE    := 'E';
      K_RETURN_MESSAGE := '财务收款尚未同步或已创建会计科目!!!';
      RETURN; 
   END IF ;
    --查找该收款单剩余未核销金额
   SELECT SPM_CON_RECEIPT_PKG.GET_EBS_RECEIPT_APPLIED_AMOUNT(K_RECEIPT_NUMBER,
                                                             K_ORG_ID) -
          (SELECT NVL(SUM(T.AMOUNT_APPLIED), 0)
             FROM CUX_SPM_AR_RECEIPT_APPLIES T
            WHERE T.RECEIPT_NUMBER = K_RECEIPT_NUMBER)
     INTO K_REMAIN_NUMBER
     FROM DUAL;
  
    IF K_REMAIN_NUMBER <= 0 THEN
      K_RETURN_CODE    := 'E';
      K_RETURN_MESSAGE := '该收款已经被全部核销';
      RETURN;
    ELSE
      --查找合同侧客户主键 
      SELECT M.CUST_ID
        INTO K_CUST_ID
        FROM SPM_CON_MONEY_REG M, SPM_CON_RECEIPT T
       WHERE M.MONEY_REG_ID = T.MONEY_REG_ID
         AND T.RECEIPT_ID = K_RECEIPT_ID;
    
      FOR TI IN AR_INVOICES(K_CUST_ID, K_ORG_ID) LOOP
        --保证有剩余金额
        IF K_REMAIN_NUMBER > 0 THEN
        
          IF TI.RESIDUAL_AMOUNT > 0 THEN
            --收款剩余未核销金额大于等于发票可核销金额   核销金额为发票可核销金额
            IF K_REMAIN_NUMBER >= TI.RESIDUAL_AMOUNT THEN
              K_HX_AMOUNT := TI.RESIDUAL_AMOUNT;
            
              --************执行插入操作
              INSERT_AR_INVOICE_FOR_RECEIPT(K_HX_AMOUNT,
                                            K_RECEIPT_NUMBER,
                                            TI.INVOICE_CODE,
                                            K_ORG_ID);
            
              --更新收款剩余未核销金额
              K_REMAIN_NUMBER := K_REMAIN_NUMBER - TI.RESIDUAL_AMOUNT;
              IF K_REMAIN_NUMBER = 0 THEN
                K_RETURN_CODE    := 'S';
                K_RETURN_MESSAGE := '自动匹配执行完毕';
                RETURN;
              END IF;
              --收款剩余未核销金额小于发票可核销金额   核销金额为收款剩余未核销金额
            ELSE
              K_HX_AMOUNT := K_REMAIN_NUMBER;
            
              --************执行插入操作
              INSERT_AR_INVOICE_FOR_RECEIPT(K_HX_AMOUNT,
                                            K_RECEIPT_NUMBER,
                                            TI.INVOICE_CODE,
                                            K_ORG_ID);
            
              K_RETURN_CODE    := 'S';
              K_RETURN_MESSAGE := '自动匹配执行完毕';
              RETURN;
            END IF;
          END IF;
        
        END IF;
      END LOOP;
      
      IF K_REMAIN_NUMBER > 0 THEN 
        K_RETURN_CODE    := 'S';
        K_RETURN_MESSAGE := '自动匹配执行完毕,发票不足';
        RETURN;
      END IF;
    
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      K_RETURN_CODE    := 'E';
      K_RETURN_MESSAGE := '执行存储过程异常,请联系运维人员';
      RETURN;
    
  END MATCH_AR_INVOICE_FOR_RECEIPT;

  --保存收款自动匹配ebs发票的匹配结果
  PROCEDURE INSERT_AR_INVOICE_FOR_RECEIPT(P_HX_AMOUNT      IN NUMBER,
                                          P_RECEIPT_NUMBER IN VARCHAR2,
                                          P_INVOICE_CODE   IN VARCHAR2,
                                          P_ORG_ID         IN NUMBER) IS
  BEGIN
  
    INSERT INTO CUX_SPM_AR_RECEIPT_APPLIES
      (RECEIPT_APPLIES_ID,
       ORG_NAME,
       RECEIPT_NUMBER,
       TRX_NUMBER,
       APPLY_DATE,
       AMOUNT_APPLIED,
       PROCESS_STATUS,
       CREATION_DATE,
       CREATED_BY,
       GL_DATE,
       DOCUMENT_NUM,
       LAST_UPDATE_DATE,
       LAST_UPDATED_BY)
      SELECT CUX_SPM_AR_RECEIPT_APPLIES_SEQ.NEXTVAL, --主键
             SPM_EAM_COMMON_PKG.GETDEPORGNAME(P_ORG_ID), --组织名称
             R.RECEIPT_CODE, --收款编号
             P_INVOICE_CODE, --发票编号
             R.GL_DATE,
             P_HX_AMOUNT, --核销金额
             'PENDING', --处理状态
             SYSDATE,
             SPM_SSO_PKG.GETUSERID, --创建人
             R.GL_DATE,
             P_INVOICE_CODE, --报销系统账号                        
             SYSDATE,
             SPM_SSO_PKG.GETUSERID
        FROM SPM_CON_RECEIPT R
       WHERE R.RECEIPT_CODE = P_RECEIPT_NUMBER;
  
  END INSERT_AR_INVOICE_FOR_RECEIPT;
  
  FUNCTION QUERY_RESIDUAL_AMOUNT(K_ID NUMBER) RETURN NUMBER IS
    RE_NUMBER      NUMBER; --返回的剩余金额
    K_INVOICE_CODE VARCHAR2(40); --发票编号
  BEGIN
    RE_NUMBER := RPT_DIS_PKG.GET_TOTAL_BALANCE(K_ID);
  
    SELECT T.TRX_NUMBER
      INTO K_INVOICE_CODE
      FROM AR.RA_CUSTOMER_TRX_ALL T
     WHERE T.CUSTOMER_TRX_ID = K_ID;
  
    SELECT RE_NUMBER - (SELECT NVL(SUM(T.AMOUNT_APPLIED), 0)
                          FROM CUX_SPM_AR_RECEIPT_APPLIES T
                         WHERE T.TRX_NUMBER = K_INVOICE_CODE)
      INTO RE_NUMBER
      FROM DUAL;
    RETURN RE_NUMBER;
  END QUERY_RESIDUAL_AMOUNT;

END SPM_CON_INVOICE_INF_PKG;
/
