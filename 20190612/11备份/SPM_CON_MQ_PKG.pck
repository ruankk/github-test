CREATE OR REPLACE PACKAGE SPM_CON_MQ_PKG AS

  --ͨ���ӿڱ�Ų�����ñ�ID
  FUNCTION SPM_MQ_CONFIGURE_ID(V_INTERFACE_CODE IN VARCHAR2) RETURN NUMBER;

  --��ѯ�м����Ϣ���Ƿ����ظ�����
  FUNCTION SPM_MQ_REPEAT_VALIDATE(V_BUSINESS_NAME   IN VARCHAR2,
                                  V_BUSINESS_CHARAC IN VARCHAR2,
                                  V_BUSINESS_ID     IN NUMBER) RETURN CHAR;

  /*��֤����м���������ݱ�*/
  PROCEDURE INSERT_MARGIN(V_IDS         IN VARCHAR2,
                          V_RETURN_CODE OUT VARCHAR2,
                          V_RETURN_MSG  OUT VARCHAR2);

  /*�б����Ѵ��м���������ݱ�*/
  PROCEDURE INSERT_BID_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2);

  /*�б�������������������ɹ��ȸ��������*/
  PROCEDURE GENERATE_BIDFEE_DATA_BATCH(V_INVOICE_IDS IN VARCHAR2);

  /*�б���������������ɹ��ȸ��������*/
  PROCEDURE GENERATE_BIDFEE_DATA(V_INVOICE_ID IN NUMBER);

  /*�б����������ӿ�*/
  PROCEDURE BID_FEE_SEND(V_ID           IN NUMBER,
                         V_AUDIT_STATUS IN VARCHAR2,
                         V_AUDIT_REASON IN VARCHAR2);

  /*�ɹ���������״̬ͬ�����̽ӿ�*/
  PROCEDURE SPM_CON_PAYMENT_STATUS(O_PAYMENT_ID IN VARCHAR2);

  /*�ɹ�������Ʊ��Ϣͬ�����̽ӿ�*/
  PROCEDURE SPM_CON_SYNC_INVOICEINFO(V_ID             IN VARCHAR2,
                                     V_MSG            IN CLOB,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2);

  /*��������*/
  PROCEDURE INSERT_TENDER_FEE(V_IDS         IN VARCHAR2,
                              V_RETURN_CODE OUT VARCHAR2,
                              V_RETURN_MSG  OUT VARCHAR2);

  /*�˱�֤���������̽ӿ�*/
  PROCEDURE SPM_CON_MARGIN_APPROVAL(O_INPUT_INVOICE_ID IN NUMBER,
                                    O_INVOICE_CODE     IN VARCHAR2,
                                    O_AUDIT_STATUS     IN VARCHAR2,
                                    O_AUDIT_INFO       IN VARCHAR2,
                                    O_CREATED_BY       IN NUMBER,
                                    O_CREATION_DATE    IN DATE,
                                    O_ORG_ID           IN NUMBER,
                                    O_DEPT_ID          IN NUMBER);

  /*����ȡ���ӿ�*/
  PROCEDURE ORDER_CANCEL(V_CODE IN VARCHAR2);

  /*��������ȡ���ӿ�*/
  PROCEDURE BATCH_ORDER_CANCEL;

  --�����˱�֤������
  PROCEDURE SPM_CON_MQ_PAYMENTMARGIN(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2);

  /*��ȡou����Ա��������Ϣ*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE   IN VARCHAR2,
                         MANAGER      IN VARCHAR2,
                         MANAGER_CODE IN VARCHAR2,
                         V_ORG_ID     OUT NUMBER,
                         V_USER_ID    OUT NUMBER,
                         V_DEPT_ID    OUT NUMBER);

  /*��ȡou����Ա��������Ϣ����������code��*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE      IN VARCHAR2,
                         MANAGER         IN VARCHAR2,
                         MANAGER_CODE    IN VARCHAR2,
                         DEPARTMENT      IN VARCHAR2,
                         DEPARTMENT_CODE IN VARCHAR2,
                         V_ORG_ID        OUT NUMBER,
                         V_USER_ID       OUT NUMBER,
                         V_DEPT_ID       OUT NUMBER);

  --�տ���̽ӿڣ�Ԥ����տ���Ϣͬ�������۶����տ�״̬ͬ����
  PROCEDURE SPM_CON_MONEY_RECEIPT(V_ID IN VARCHAR2);

  /*��Ա�Ѵ��м���������ݱ�*/
  PROCEDURE INSERT_VIP_FEE(V_IDS         IN VARCHAR2,
                           V_RETURN_CODE OUT VARCHAR2,
                           V_RETURN_MSG  OUT VARCHAR2);

  /*����Ӷ����м���������ݱ�*/
  PROCEDURE INSERT_DEAL_FEE(V_IDS         IN VARCHAR2,
                            V_RETURN_CODE OUT VARCHAR2,
                            V_RETURN_MSG  OUT VARCHAR2);
  --������˾�����Զ�ƥ����
  PROCEDURE MONEY_REG_MATCH_FRAMEWORK(V_IDS IN VARCHAR2);

  /*���ڻش��ʼ���Ϣ�ӿ�*/
  PROCEDURE DB_INVOICE_EXPRESS;

  /*��Ʊ�����������*/
  PROCEDURE SPM_CON_SEND_OPENRESULT(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2);

  --���Ʊ�ύ����ʱ�ж��Ƿ��������
  FUNCTION QUERY_CONDITION_FLAG(INPUT_ID NUMBER) RETURN VARCHAR2;

  --��ӹ��߷�����������ˮ������ by mcq 20190116
  FUNCTION CREATE_SERIAL_CODE_UTIL(P_SERIAL_CODE VARCHAR2,
                                   P_TABLE_NAME  VARCHAR2,
                                   P_FIELD_NAME  VARCHAR2,
                                   P_FORMAT_CODE VARCHAR2,
                                   P_USER_ID     NUMBER,
                                   P_ORG_ID      NUMBER) RETURN VARCHAR2;
  --�տ��ȡĬ������                                
  FUNCTION GET_RECEIPT_DEFAULT_CONFIGURE(K_RECEIPT_TYPE VARCHAR2,
                                         K_FIELD_TYPE   VARCHAR2,
                                         K_ORG_ID       NUMBER,
                                         K_USER_ID      NUMBER)
    RETURN VARCHAR2;

END SPM_CON_MQ_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_CON_MQ_PKG AS

  --ͨ���ӿڱ�Ų�����ñ�ID
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

  --��ѯ�м����Ϣ���Ƿ����ظ�����
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

  /*��֤����м���������ݱ�*/
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
  
    --����
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
      
        -- ��ȡ��֯����Ա��������Ϣ
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
          X_ERROR_MSG   := '��ȡ��֯��' || REC1.AGENT_NAME || '��' ||
                           REC1.AGENT_CODE || '������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC1.MANAGER || '��' ||
                           REC1.MANAGER_CODE ||
                           '������Ϣ�����ȵ�������ҵ����Ա���ա�ģ��ά����Ӧ��ϵ';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC1.MANAGER || '��' ||
                           REC1.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC1.MANAGER || '��' ||
                           REC1.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC1.DEPARTMENT || '��' ||
                           REC1.DEPARTMENT_CODE || '������Ϣ������ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC1.DEPARTMENT || '��' ||
                           REC1.DEPARTMENT_CODE || '������Ϣ�����Ŵ���Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC1.DEPARTMENT || '��' ||
                           REC1.DEPARTMENT_CODE || '������Ϣ����������Ϊ�գ�����ϵ���̺˶�';
        
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
          -- ��ȡ����֯�޹���
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '�޹���-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '����֯���޶�Ӧ���޹���';
          
            UPDATE SPM_CON_MQ_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        -- ��Ӧ��
        IF REC1.V_VENDOR_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '��ȡ��Ӧ�̡�' || REC1.SUPPLIER || '��' ||
                           REC1.SUPPLIER_CODE || '��������ʧ�ܣ�';
        
          IF REC1.V_VENDOR_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�����м�����ڸ�����¼������ϵ������������';
          ELSIF REC1.V_VENDOR_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��δ����ҵ������';
          ELSIF REC1.V_VENDOR_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�ù�Ӧ��δ������';
          ELSIF REC1.V_VENDOR_ID = -4 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�ù�Ӧ��δͬ��';
          ELSIF REC1.V_VENDOR_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��ȡ�����쳣������ϵϵͳ����Ա';
          END IF;
        
          UPDATE SPM_CON_MQ_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        -- Ͷ�걣֤��
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
             AND T.VENDOR_SITE_CODE = 'Ͷ�걣֤��';
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '��Ӧ�̡�' || REC1.SUPPLIER || '��' ||
                             REC1.SUPPLIER_CODE || '����û�ж�Ӧ��Ͷ�걣֤��ص�';
          
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
            X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC1.MANAGER || '��' ||
                             REC1.MANAGER_CODE || '������Ӧ�Ĳ��Ŷ�ֵ��Ϣ���뵽HRά����Ϣ';
          
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
            X_ERROR_MSG   := 'δ�ҵ�����Ϊ' || REC1.TRANS_NUMBER || '�ķ�Ʊ';
          
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
              X_ERROR_MSG   := '��Ʊ�Ѿ�ͬ�������޷�����';
            
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
          
            --��������
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
              X_ERROR_MSG   := 'δ��ȡ����ֵ��Ϣ�����鴫�������˺�' || REC1.ACCOUNT_NO ||
                               '�Ƿ���ȷ';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '��';
              END IF;
              V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              CONTINUE;
            END IF;
            CLOSE CUR2;
          
            -- ���¶�ֵ��Ϣ
            UPDATE SPM_CON_INPUT_WAREHOUSE W
               SET DEPT_SEC     = REC2.SEGMENT2,
                   SUB_SEC      = REC2.SEGMENT3,
                   DEALINGS_SEC = REC2.SEGMENT4,
                   PROJECT_SEC  = REC2.SEGMENT5,
                   PRODUCT_SEC  = REC2.SEGMENT7,
                   ASSIST_SEC   = REC2.SEGMENT10,
                   BANK_SEC     = REC2.SEGMENT9
             WHERE W.INPUT_WAREHOUSE_ID = V_L_ID;
          
            --��ͷ��Ϣ�н���Ա��Ϣ���µ�����Ϣ��
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
              X_ERROR_MSG   := '������Ϣʧ��';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '��';
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
            X_ERROR_MSG   := '�Ѵ��ں���Ϊ' || REC1.TRANS_NUMBER || '�ķ�Ʊ';
          
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
               '��֤��-' || REC1.SUPPLIER,
               'N',
               V_VENDOR_SITE_ID,
               0,
               10000,
               X_EBS_DEPT_CODE,
               '113');
          EXCEPTION
            WHEN OTHERS THEN
              V_RETURN_CODE := 'F';
              X_ERROR_MSG   := '����' || REC1.TRANS_NUMBER || '��Ʊ��������ʧ��';
            
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
              X_ERROR_MSG   := 'δ��ȡ����ֵ��Ϣ�����鴫�������˺�' || REC1.ACCOUNT_NO ||
                               '�Ƿ���ȷ';
            
              UPDATE SPM_CON_MQ_MARGIN T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
            
              DELETE FROM SPM_CON_INPUT_INVOICE I
               WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
              CONTINUE;
            END IF;
            CLOSE CUR2;
          
            --����Ϣ
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
          
            --��ͷ��Ϣ�н���Ա��Ϣ���µ�����Ϣ��
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
              X_ERROR_MSG   := '����' || REC1.TRANS_NUMBER || '��Ʊ�ӱ�����ʧ��';
              /*IF V_RETURN_MSG IS NOT NULL THEN
                V_RETURN_MSG := V_RETURN_MSG || '��';
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
      V_RETURN_MSG  := '����ִ���쳣';
  END INSERT_MARGIN;

  /*�б����Ѵ��м���������ݱ�*/
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
  
    -- �ͻ�������Ϣ
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
    --����
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
      
        -- ��ȡ��֯����Ա��������Ϣ
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
          X_ERROR_MSG   := '��ȡ��֯��' || REC2.AGENT_NAME || '��' ||
                           REC2.AGENT_CODE || '������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE ||
                           '������Ϣ�����ȵ�������ҵ����Ա���ա�ģ��ά����Ӧ��ϵ';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC2.DEPARTMENT || '��' ||
                           REC2.DEPARTMENT_CODE || '������Ϣ������ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC2.DEPARTMENT || '��' ||
                           REC2.DEPARTMENT_CODE || '������Ϣ�����Ŵ���Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_BIDFEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || REC2.DEPARTMENT || '��' ||
                           REC2.DEPARTMENT_CODE || '������Ϣ����������Ϊ�գ�����ϵ���̺˶�';
        
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
          -- ��ȡ����֯�޹���
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '�޹���-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '����֯���޶�Ӧ���޹���';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        IF REC2.V_CUST_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '��ȡ�ͻ���' || REC2.SUPPLIER || '��' ||
                           REC2.SUPPLIER_CODE || '��������ʧ�ܣ�';
        
          IF REC2.V_CUST_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�����м�����ڸ�����¼������ϵ������������';
          ELSIF REC2.V_CUST_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��δ����ҵ������';
          ELSIF REC2.V_CUST_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�ÿͻ�δ��Ч';
          ELSIF REC2.V_CUST_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��ȡ�����쳣������ϵϵͳ����Ա';
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
          --��������Ϊ����
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_OUTPUT_INVOICE O
           WHERE O.SERVICE_ID = V_SERVICE_ID;
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := 'δ�ҵ���Ҫ���ĵ�Դ����';
          
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
            X_ERROR_MSG   := '�������Ѿ������������̣��޷�����';
          
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
              X_ERROR_MSG   := '��������ʱ��������';
            
              UPDATE SPM_CON_MQ_BIDFEE T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              ROLLBACK TO SP_GENERATE_ERROR;
              CONTINUE;
          END;
        
        ELSE
          --��������Ϊ����
        
          SELECT COUNT(1)
            INTO V_COUNT
            FROM SPM_CON_INPUT_INVOICE T
           WHERE T.INVOICE_CODE = V_ID
             AND ROWNUM = 1;
          IF V_COUNT = 0 THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := 'δƥ�䵽����Ϊ' || V_ID || '�ı�֤��';
            -- ƴ����ʾ��Ϣ
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
            X_ERROR_MSG   := '�����ظ�';
          
            UPDATE SPM_CON_MQ_BIDFEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
          END IF;
        
          -- �������Ʊ����
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
               '�ֹ���Ʊ',
               '��Ʊ',
               '��Ӫҵ�����',
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
              X_ERROR_MSG   := '������������ʧ��';
            
              UPDATE SPM_CON_MQ_BIDFEE T
                 SET T.ERROR_MESSAGE = X_ERROR_MSG
               WHERE T.MQ_ID = IDS(I);
              ROLLBACK TO SP_GENERATE_ERROR;
              CONTINUE;
          END;
        
          -- �������Ʊ�ӱ�
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
               'Ԫ',
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
              X_ERROR_MSG   := '����������ʧ��';
            
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
          X_ERROR_MSG   := '����ִ���쳣������ϵϵͳ����Ա';
        
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
      V_RETURN_MSG  := '����ִ���쳣������ϵϵͳ����Ա';
  END INSERT_BID_FEE;

  --�б���������������ת����
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
  
    -- ��ѯ��֤��
    CURSOR CUR_INPUT(TRANS_NUMBER VARCHAR2) IS
      SELECT *
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INVOICE_CODE = TRANS_NUMBER;
    REC_INPUT CUR_INPUT%ROWTYPE;
  
    -- ��ѯ�б�����
    CURSOR CUR_OUTPUT(OUTPUT_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_OUTPUT_INVOICE O
       WHERE O.OUTPUT_INVOICE_ID = OUTPUT_ID
         AND O.STATUS IN ('E', 'N');
    REC_OUTPUT CUR_OUTPUT%ROWTYPE;
  
  BEGIN
    SAVEPOINT SP;
  
    --��ѯ���õ��б���������
    OPEN CUR_OUTPUT(V_INVOICE_ID);
    FETCH CUR_OUTPUT
      INTO REC_OUTPUT;
  
    IF CUR_OUTPUT%FOUND THEN
      CLOSE CUR_OUTPUT;
    
      --��ѯ���õı�֤������
      OPEN CUR_INPUT(REC_OUTPUT.INVOICE_SERIAL_NUMBER);
      FETCH CUR_INPUT
        INTO REC_INPUT;
      IF CUR_INPUT%FOUND THEN
        CLOSE CUR_INPUT;
      
        BEGIN
          --��ȡ�����˺�ID
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
               SET O.SYNC_ERROR = '��ȡ�����˺�ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        -- ��ȡ�ʽ�ƻ�����
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
               SET O.SYNC_ERROR = '��ȡ�ʽ�ƻ���Ϣʧ��'
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
             SET O.SYNC_ERROR = '��֤��ʣ�����'
           WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
          RETURN;
        END IF;
      
        -- ��ȡ��Ӧ������ˮ��
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
               SET O.SYNC_ERROR = '�����˱�֤����ˮ��ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
          
            RETURN;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '�����˱�֤����ˮ��ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          SELECT SPM_CON_PAYMENT_SEQ.NEXTVAL INTO V_PAYMENT_ID FROM DUAL;
          --���ɸ���-��Ʊ������ϵ                  
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
          --������Ʊ�����·�Ʊ��Ϣ
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.RESIDUAL_AMOUNT = V_RESIDUAL_AMOUNT
           WHERE I.INPUT_INVOICE_ID = REC_INPUT.INPUT_INVOICE_ID;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '���������֤��ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
        
          -- �������  
          SPM_CON_PAYMENT_INFO.PAYMENT_ID := V_PAYMENT_ID;
          -- ������Դ������
          SPM_CON_PAYMENT_INFO.PAYMENT_SOURCE := 'DS';
          -- �ʽ�ƻ�����
          SPM_CON_PAYMENT_INFO.PLAN_FLAG := 'Y';
          -- �ϻ�
          SPM_CON_PAYMENT_INFO.IS_MEETING  := 'N';
          SPM_CON_PAYMENT_INFO.HAS_MEETING := 'N';
          -- ����
          SPM_CON_PAYMENT_INFO.WEATHER_DZ := 'N';
          -- �տλID                                   
          SPM_CON_PAYMENT_INFO.VENDOR_ID := REC_INPUT.VENDOR_ID;
          --  ��Ŀid 
          SPM_CON_PAYMENT_INFO.PROJECT_ID := REC_INPUT.PROJECT_ID;
          --  ����� 
          SPM_CON_PAYMENT_INFO.PAYMENT_CODE := V_SERIAL_CODE;
          --��֤�𵥺�
          SPM_CON_PAYMENT_INFO.OTHERS_SYSTEM_CODE := REC_INPUT.INVOICE_CODE;
          --  ��Ӧ�̵ص� 
          SPM_CON_PAYMENT_INFO.VENDOR_SITE_ID := REC_INPUT.VENDOR_SITE_ID;
          --  ������; 
          SPM_CON_PAYMENT_INFO.PAY_PURPOSE := '24';
          --  ������� 
          SPM_CON_PAYMENT_INFO.PAY_CATEGORY := '7';
          --  �ֽ��� 
          SPM_CON_PAYMENT_INFO.CASH_FLOW_ID := '124';
          --  ���������˻� 
          SPM_CON_PAYMENT_INFO.PAY_BANK_ACCOUNT_ID := PAY_BANK_ACCOUNT_ID;
          --  ���븶���� 
          SPM_CON_PAYMENT_INFO.MONEY_AMOUNT := REC_OUTPUT.INVOICE_AMOUNT;
          --  ���������� 
          SPM_CON_PAYMENT_INFO.BANK_NAME := REC_INPUT.OPENING_BANK;
          --  �տ�˺� 
          SPM_CON_PAYMENT_INFO.BANK_ACCOUNT_NUM := REC_INPUT.BANK_ACCOUNT;
          --  ������� 
          SPM_CON_PAYMENT_INFO.CURRENCY_TYPE := REC_INPUT.CURRENCY_TYPE;
          --  �ʽ�ʹ����Ŀ 
          SPM_CON_PAYMENT_INFO.MATCH_PROJECT := REC_INPUT.MATCH_PROJECT;
          --��ժҪ
          SPM_CON_PAYMENT_INFO.REMARK := REC_INPUT.REMARK;
          --  ��������id 
          SPM_CON_PAYMENT_INFO.ORG_ID := REC_OUTPUT.ORG_ID;
          --  ������ 
          SPM_CON_PAYMENT_INFO.CREATED_BY := REC_OUTPUT.CREATED_BY;
          --  ����ʱ�� 
          SPM_CON_PAYMENT_INFO.CREATION_DATE := SYSDATE;
          --  �޸�ʱ�� 
          SPM_CON_PAYMENT_INFO.LAST_UPDATE_DATE := SYSDATE;
          --  ��������id 
          SPM_CON_PAYMENT_INFO.DEPT_ID := REC_OUTPUT.DEPT_ID;
          --  ���㲿�� 
          SPM_CON_PAYMENT_INFO.EBS_DEPT_CODE := REC_INPUT.EBS_DEPT_CODE;
          --  �ʽ�ʹ�ò���
          SPM_CON_PAYMENT_INFO.MATCH_DEPT := REC_INPUT.MATCH_DEPT;
          -- ����״̬
          SPM_CON_PAYMENT_INFO.STATUS := 'E';
          -- ͬ��״̬
          SPM_CON_PAYMENT_INFO.EBS_STATUS := 'N';
          -- ����״̬
          SPM_CON_PAYMENT_INFO.PAY_STATUS := '0';
          -- ����� 
          SPM_CON_PAYMENT_INFO.PAY_METHODS := 'WIRE';
          -- ��������
          SPM_CON_PAYMENT_INFO.EXCHANGE_TYPE := 'User';
          -- ����ʱ��
          SPM_CON_PAYMENT_INFO.EXCHANGE_DATE := SYSDATE;
          -- �ʽ�ƻ���Ϣ
          SPM_CON_PAYMENT_INFO.MONTH_DETAIL_ID    := CAPITAL_PLAN_INFO.CAPITAL_ID;
          SPM_CON_PAYMENT_INFO.THIS_MONTH_BALANCE := CAPITAL_PLAN_INFO.THIS_MONTH_BALANCE;
        
          INSERT INTO SPM_CON_PAYMENT VALUES SPM_CON_PAYMENT_INFO;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK TO SP;
            UPDATE SPM_CON_OUTPUT_INVOICE O
               SET O.SYNC_ERROR = '������ת���ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
        
          --������������
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
             '�б�����',
             REC_OUTPUT.ORG_ID,
             REC_OUTPUT.DEPT_ID,
             'A',
             (SELECT V.ORG_NAME
                FROM SPM_EAM_ALL_ORG_DEPT_V V
               WHERE V.ORG_ID = REC_OUTPUT.ORG_ID),
             '��ת�տ�',
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
               SET O.SYNC_ERROR = '������ת����ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          --�����տ�����
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
             '�б�����',
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
               SET O.SYNC_ERROR = '������ת�տ�ʧ��'
             WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
            RETURN;
        END;
      
        BEGIN
          --�����տ������Ʊ����
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
             '�б�����');
        
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
               SET O.SYNC_ERROR = '������ת�տ������Ʊʧ��'
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
         SET O.SYNC_ERROR = '�����쳣'
       WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
  END GENERATE_BIDFEE_DATA;

  /*�б����������ӿ�*/
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

  /*�ɹ���������״̬ͬ�����̽ӿ�*/
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
  
    -- ���㱻','�ָ���γɵ��ַ�������
    SELECT (LENGTH(O_PAYMENT_ID) - LENGTH(REPLACE(O_PAYMENT_ID, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- ѭ������
    WHILE J <= ID_NUM LOOP
      -- ��ID�ַ������ݶ��ŷָ�
      SELECT TRIM(REGEXP_SUBSTR(O_PAYMENT_ID, '[^,]+', 1, J))
        INTO V_PAYMENT_ID
        FROM DUAL;
      J := J + 1;
    
      --��֤��ǰ�����Ӧ�Ķ����Ƿ�ȫ���������
      BEGIN
        FOR V_CURROW IN CU_DATA LOOP
          BEGIN
            --��֤��ǰ��ͬ�Ƿ�Ϊ������ͬ
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
            --��ǰ����ȫ���������
            IF V_INVOICE_AMOUNT >= V_CONTRACT_AMOUNT THEN
              V_REPEAT_VALIDATE := SPM_MQ_REPEAT_VALIDATE('SPM_CON_HT_INFO',
                                                          'PAYMENT_STATUS',
                                                          V_CURROW.CONTRACT_ID);
              --��֤������Ϣ�Ƿ����м����Ϣ��û�м�¼
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
                   '�ɹ���������״̬ͬ��');
                --���¶�������״̬
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

  /*�ɹ�������Ʊ��Ϣͬ�����̽ӿ�*/
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
    V_CONFIGURE_ID      NUMBER(15); --���ñ�id
    V_REPEAT            VARCHAR2(20);
  
  BEGIN
    --ȥ����֤ ��ΪY ���ظ�
    V_REPEAT := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_INPUT_INVOICE',
                                                      'POINVOICESYNC',
                                                      V_ID);
    IF V_REPEAT <> 'Y' THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '�����ظ�����Ϣ���޷����뵽�м��';
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
  
    --���ñ�ID��ѯ
    V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('POINVOICEINFO');
    INSERT INTO SPM.SPM_CON_MQ_MESSAGE
      (MESSAGE_ID, --��Ϣ��ID
       CONFIGURE_ID, --���ñ�ID
       BUSINESS_NAME, --ҵ���
       BUSINESS_CHARAC, --ҵ���ʶ
       BUSINESS_ID, --ҵ��ID
       MESSAGE_CONTENT, --��Ϣ����
       CREATED_BY, --������
       CREATION_DATE, --��������
       LAST_UPDATED_BY, --�޸���        
       LAST_UPDATE_DATE, --�޸�����
       LAST_UPDATE_LOGIN, --LOGIN
       ORG_ID, --������֯id
       DEPT_ID, --��������id
       REMARK --��ע       
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
       '�ɹ�������Ʊ��Ϣͬ��');
    COMMIT;
    V_RETURN_CODE    := 'S';
    V_RETURN_MESSAGE := '�����м��ɹ�';
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '�����м������쳣������ϵ����Ա';
      RETURN;
  END;

  /*��������*/
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
  
    --����
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
      
        -- ��ȡ��֯����Ա��������Ϣ
        GET_ODU_INFO(AGENT_CODE   => REC2.AGENT_CODE,
                     MANAGER      => REC2.MANAGER,
                     MANAGER_CODE => REC2.MANAGER_CODE,
                     V_ORG_ID     => X_ORG_ID,
                     V_USER_ID    => X_USER_ID,
                     V_DEPT_ID    => X_DEPT_ID);
      
        IF X_ORG_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '��ȡ��֯��' || REC2.AGENT_NAME || '��' ||
                           REC2.AGENT_CODE || '������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE ||
                           '������Ϣ�����ȵ�������ҵ����Ա���ա�ģ��ά����Ӧ��ϵ';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE || '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ��' || REC2.MANAGER || '��' ||
                           REC2.MANAGER_CODE || '�����ڡ�' || REC2.AGENT_NAME || '��' ||
                           REC2.AGENT_CODE || '�����µĲ��ŵ�Ϣ�����������Ƿ���ȷ';
        
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
          -- ��ȡ����֯�޹���
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '�޹���-%'
             AND P.ORG_ID = X_ORG_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '����֯���޶�Ӧ���޹���';
            /*IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '��';
            END IF;
            V_RETURN_MSG := V_RETURN_MSG || V_ID || X_ERROR_MSG;*/
          
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      
        IF REC2.V_CUST_ID < 0 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '��ȡ�ͻ���' || REC2.SUPPLIER || '��' ||
                           REC2.SUPPLIER_CODE || '��������ʧ�ܣ�';
        
          IF REC2.V_CUST_ID = -1 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�����м�����ڸ�����¼������ϵ������������';
          ELSIF REC2.V_CUST_ID = -2 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��δ����ҵ������';
          ELSIF REC2.V_CUST_ID = -3 THEN
            X_ERROR_MSG := X_ERROR_MSG || '�ÿͻ�δ��Ч';
          ELSIF REC2.V_CUST_ID = -5 THEN
            X_ERROR_MSG := X_ERROR_MSG || '��ȡ�����쳣������ϵϵͳ����Ա';
          END IF;
        
          /*IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '��';
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
          X_ERROR_MSG   := '�Ѵ��ں���Ϊ��' || REC2.PAY_ORDER_NO || '���ķ�Ʊ';
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
             '��Ӫҵ�����',
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
             '�ֹ���Ʊ',
             '��Ʊ',
             1,
             V_PROJECT_ID,
             '�����',
             'BS');
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := '������������ʧ��';
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
             '�����',
             'Ԫ',
             '�����',
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
            X_ERROR_MSG   := '�����ӱ������ʧ��';
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
             '�����');
        
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
          
            /*IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '��';
            END IF;
            V_RETURN_MSG := V_RETURN_MSG || V_ID || '���ɵ��������쳣';*/
            UPDATE SPM_CON_MQ_TENDER_FEE T
               SET T.ERROR_MESSAGE = '���ɵ��������쳣'
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
            V_RETURN_MSG := V_RETURN_MSG || '��';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '���ɷ�Ʊ�����쳣';*/
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = '����ִ���쳣'
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
      V_RETURN_MSG  := '����ִ���쳣';
  END INSERT_TENDER_FEE;

  /*�˱�֤���������̽ӿ�*/
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
  
    --��־����ͨ�����ǲ���
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
    /*--��֤�˱�֤����Ϣ�Ƿ����м����Ϣ��û�м�¼
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
       '�˱�֤�������ӿ�');
    /*END IF;*/
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
  END;

  /*����ȡ���ӿ�*/
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
  
    -- ����ѯ��һ�Զ�������ֵ״̬��ȡ��
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

  /*��������ȡ���ӿ�*/
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
    
      -- ����ѯ��һ�Զ�������ֵ״̬��ȡ��
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

  --�����˱�֤������
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
  
    V_SERIAL_CODE VARCHAR2(200); --��ˮ��
  
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --����
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
                             'δƥ�䵽��Ӧ��֤��';
            -- ƴ����ʾ��Ϣ
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
          X_ERROR_MSG   := '�����ɹ�����֤��Ϊ' ||
                           MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                           '�ĸ������ݣ����������Ϊ��' || X_ERROR_MSG;
          -- ƴ����ʾ��Ϣ
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
          X_ERROR_MSG   := '��֤��' || MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                           'ʣ�����';
          -- ƴ����ʾ��Ϣ
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        V_TRANS_NUMBER := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
        V_OPERATE_TYPE := MQ_PAYMENT_MARGIN_INFO.OPERATE_TYPE;
      
        -- ��ȡ��֯����Ա��������Ϣ
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
          X_ERROR_MSG   := '��ȡ��֯��' || MQ_PAYMENT_MARGIN_INFO.AGENT_NAME || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.AGENT_CODE ||
                           '������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_USER_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '������Ϣ�����ȵ�������ҵ����Ա���ա�ģ��ά����Ӧ��ϵ';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_USER_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����Ա��' || MQ_PAYMENT_MARGIN_INFO.MANAGER || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.MANAGER_CODE ||
                           '������Ϣ���û�����Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        END IF;
      
        IF X_DEPT_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '������Ϣ������ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -1 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '������Ϣ�����Ŵ���Ϊ�գ�����ϵ���̺˶�';
        
          UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
        ELSIF X_DEPT_ID = -2 THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ѯ�����š�' || MQ_PAYMENT_MARGIN_INFO.DEPARTMENT || '��' ||
                           MQ_PAYMENT_MARGIN_INFO.DEPARTMENT_CODE ||
                           '������Ϣ����������Ϊ�գ�����ϵ���̺˶�';
        
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
              --��ȡ�����˺�ID
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
                                 '��ȡ�����˺�ʧ��';
                -- ƴ����ʾ��Ϣ
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            -- ��ȡ�ʽ�ƻ�����
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
                                 '��ȡ�ʽ�ƻ���Ϣʧ��';
                -- ƴ����ʾ��Ϣ
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            -- ��ȡ��Ӧ������ˮ��
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
                                 '�����˱�֤����ˮ��ʧ��';
                -- ƴ����ʾ��Ϣ
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
              END IF;
            
            EXCEPTION
              WHEN OTHERS THEN
                V_RETURN_CODE := 'F';
                X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                                 '�����˱�֤����ˮ��ʧ��';
                -- ƴ����ʾ��Ϣ
                UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
                   SET T.ERROR_MESSAGE = X_ERROR_MSG
                 WHERE T.MQ_ID = IDS(I);
                CONTINUE;
            END;
          
            SELECT SPM_CON_PAYMENT_SEQ.NEXTVAL INTO V_PAYMENT_ID FROM DUAL;
          
            --���ɸ���-��Ʊ������ϵ                  
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
            --������Ʊ�����·�Ʊ��Ϣ
            UPDATE SPM_CON_INPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT =
                   (NVL(I.RESIDUAL_AMOUNT, 0) -
                   NVL(MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT, 0))
             WHERE I.INPUT_INVOICE_ID = INPUT_INVOICE_INFO.INPUT_INVOICE_ID;
          
            -- �������  
            SPM_CON_PAYMENT_INFO.PAYMENT_ID := V_PAYMENT_ID;
            -- ������Դ������
            SPM_CON_PAYMENT_INFO.PAYMENT_SOURCE := 'DS';
            -- �ʽ�ƻ�����
            SPM_CON_PAYMENT_INFO.PLAN_FLAG := 'Y';
            -- �ϻ�
            SPM_CON_PAYMENT_INFO.IS_MEETING  := 'N';
            SPM_CON_PAYMENT_INFO.HAS_MEETING := 'N';
            -- ����
            SPM_CON_PAYMENT_INFO.WEATHER_DZ := 'N';
            -- �տλID                                   
            SPM_CON_PAYMENT_INFO.VENDOR_ID := INPUT_INVOICE_INFO.VENDOR_ID;
            --  ��Ŀid 
            SPM_CON_PAYMENT_INFO.PROJECT_ID := INPUT_INVOICE_INFO.PROJECT_ID;
            --  ����� 
            SPM_CON_PAYMENT_INFO.PAYMENT_CODE := V_SERIAL_CODE;
            -- ����ϵͳ��ʶ
            SPM_CON_PAYMENT_INFO.OTHERS_SYSTEM_CODE := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER;
            --  ��Ӧ�̵ص� 
            SPM_CON_PAYMENT_INFO.VENDOR_SITE_ID := INPUT_INVOICE_INFO.VENDOR_SITE_ID;
            --  ������; 
            SPM_CON_PAYMENT_INFO.PAY_PURPOSE := '51';
            --  ������� 
            SPM_CON_PAYMENT_INFO.PAY_CATEGORY := '7';
            --  �ֽ��� 
            SPM_CON_PAYMENT_INFO.CASH_FLOW_ID := '124';
            --  ���������˻� 
            SPM_CON_PAYMENT_INFO.PAY_BANK_ACCOUNT_ID := PAY_BANK_ACCOUNT_ID;
            --  ���븶���� 
            SPM_CON_PAYMENT_INFO.MONEY_AMOUNT := MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT;
            --  ���������� 
            SPM_CON_PAYMENT_INFO.BANK_NAME := INPUT_INVOICE_INFO.OPENING_BANK;
            --  �տ�˺� 
            SPM_CON_PAYMENT_INFO.BANK_ACCOUNT_NUM := INPUT_INVOICE_INFO.BANK_ACCOUNT;
            --  �������� 
            SPM_CON_PAYMENT_INFO.PAY_DATE := MQ_PAYMENT_MARGIN_INFO.APPLY_TIME;
            --  ������� 
            SPM_CON_PAYMENT_INFO.CURRENCY_TYPE := INPUT_INVOICE_INFO.CURRENCY_TYPE;
            --  �ʽ�ʹ����Ŀ 
            SPM_CON_PAYMENT_INFO.MATCH_PROJECT := INPUT_INVOICE_INFO.MATCH_PROJECT;
            --��ժҪ
            SPM_CON_PAYMENT_INFO.REMARK := INPUT_INVOICE_INFO.REMARK;
            --  ��������id 
            SPM_CON_PAYMENT_INFO.ORG_ID := X_ORG_ID;
            --  ������ 
            SPM_CON_PAYMENT_INFO.CREATED_BY := X_USER_ID;
            --  ����ʱ�� 
            SPM_CON_PAYMENT_INFO.CREATION_DATE := SYSDATE;
            --  �޸�ʱ�� 
            SPM_CON_PAYMENT_INFO.LAST_UPDATE_DATE := SYSDATE;
            --  ��������id 
            SPM_CON_PAYMENT_INFO.DEPT_ID := X_DEPT_ID;
            --  ���㲿�� 
            SPM_CON_PAYMENT_INFO.EBS_DEPT_CODE := INPUT_INVOICE_INFO.EBS_DEPT_CODE;
            --  �ʽ�ʹ�ò���
            SPM_CON_PAYMENT_INFO.MATCH_DEPT := INPUT_INVOICE_INFO.MATCH_DEPT;
            -- ����״̬
            SPM_CON_PAYMENT_INFO.STATUS := 'A';
            -- ͬ��״̬
            SPM_CON_PAYMENT_INFO.EBS_STATUS := 'N';
            -- ����״̬
            SPM_CON_PAYMENT_INFO.PAY_STATUS := '0';
            -- ����� 
            SPM_CON_PAYMENT_INFO.PAY_METHODS := 'WIRE';
            -- ��������
            SPM_CON_PAYMENT_INFO.EXCHANGE_TYPE := 'User';
            -- ����ʱ��
            SPM_CON_PAYMENT_INFO.EXCHANGE_DATE := SYSDATE;
            -- �ʽ�ƻ���Ϣ
            SPM_CON_PAYMENT_INFO.MONTH_DETAIL_ID    := CAPITAL_PLAN_INFO.CAPITAL_ID;
            SPM_CON_PAYMENT_INFO.THIS_MONTH_BALANCE := CAPITAL_PLAN_INFO.THIS_MONTH_BALANCE;
            -- �˱�֤���ʶ
            SPM_CON_PAYMENT_INFO.ATTRIBUTE5 := 'BZJ';
          
            --���ɸ����Ϣ
            INSERT INTO SPM_CON_PAYMENT VALUES SPM_CON_PAYMENT_INFO;
            --��־����Ϣ�ѱ�����
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN S
               SET S.GENERATE_FLAG = 'Y'
             WHERE S.MQ_ID = IDS(I);
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                             '���ɸ��������쳣������ϵϵͳ����Ա';
            -- ƴ����ʾ��Ϣ
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
            --���¸���ֶ�
            UPDATE SPM_CON_PAYMENT S
               SET S.PACKAGE_NO   = MQ_PAYMENT_MARGIN_INFO.PACKAGE_NO,
                   S.PACKAGE_NAME = MQ_PAYMENT_MARGIN_INFO.PACKAGE_NAME,
                   S.MONEY_AMOUNT = MQ_PAYMENT_MARGIN_INFO.RECEIVE_AMOUNT,
                   S.PAY_DATE     = MQ_PAYMENT_MARGIN_INFO.APPLY_TIME
             WHERE S.PAYMENT_ID = V_PAYMENT_ID;
            --��־����Ϣ�ѱ�����
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN S
               SET S.GENERATE_FLAG = 'Y', S.ERROR_MESSAGE = ''
             WHERE S.MQ_ID = V_ID;
          END IF;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_CODE := 'F';
            X_ERROR_MSG   := MQ_PAYMENT_MARGIN_INFO.TRANS_NUMBER ||
                             '���¸���쳣������ϵϵͳ����Ա';
            -- ƴ����ʾ��Ϣ
            UPDATE SPM_CON_MQ_PAYMENT_MARGIN T
               SET T.ERROR_MESSAGE = X_ERROR_MSG
             WHERE T.MQ_ID = IDS(I);
            CONTINUE;
        END;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '�����쳣������ϵϵͳ����Ա';
          -- ƴ����ʾ��Ϣ
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

  /*��ȡou����Ա��������Ϣ*/
  PROCEDURE GET_ODU_INFO(AGENT_CODE   IN VARCHAR2,
                         MANAGER      IN VARCHAR2,
                         MANAGER_CODE IN VARCHAR2,
                         V_ORG_ID     OUT NUMBER,
                         V_USER_ID    OUT NUMBER,
                         V_DEPT_ID    OUT NUMBER) IS
    V_COUNT NUMBER;
  BEGIN
    -- ��ȡOU
    BEGIN
      SELECT TO_NUMBER(H.ORGANIZATION_ID)
        INTO V_ORG_ID
        FROM HR_OPERATING_UNITS H
       WHERE H.SHORT_CODE = AGENT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_ORG_ID := NULL;
    END;
  
    -- ��ȡ��Ա
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
  
    -- CodeΪ�շ���-1
    IF MANAGER_CODE IS NULL THEN
      V_USER_ID := -1;
    END IF;
    -- ����Ϊ�շ���-2
    IF MANAGER IS NULL THEN
      V_USER_ID := -2;
    END IF;
  
    -- ��ȡ����userIdʱ������ձ�����
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
            DBMS_OUTPUT.PUT_LINE('������룺' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('������Ϣ��' || SQLERRM);
        END;
      END IF;
    END IF;
  
    -- ��ȡ����
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

  /*��ȡou����Ա��������Ϣ*/
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
    -- ��ȡOU
    BEGIN
      SELECT TO_NUMBER(H.ORGANIZATION_ID)
        INTO V_ORG_ID
        FROM HR_OPERATING_UNITS H
       WHERE H.SHORT_CODE = AGENT_CODE;
    EXCEPTION
      WHEN OTHERS THEN
        V_ORG_ID := NULL;
    END;
  
    -- ��ȡ����
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
  
    -- CodeΪ�շ���-1
    IF DEPARTMENT_CODE IS NULL THEN
      V_DEPT_ID := -1;
    END IF;
    -- ����Ϊ�շ���-2
    /*IF DEPARTMENT IS NULL THEN
      V_DEPT_ID := -2;
    END IF;*/
  
    -- ��ȡ����userIdʱ������ձ�����
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
            DBMS_OUTPUT.PUT_LINE('������룺' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('������Ϣ��' || SQLERRM);
        END;
      END IF;
    END IF;
  
    -- ��ȡ��Ա
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
  
    -- CodeΪ�շ���-1
    IF MANAGER_CODE IS NULL THEN
      V_USER_ID := -1;
    END IF;
    -- ����Ϊ�շ���-2
    IF MANAGER IS NULL THEN
      V_USER_ID := -2;
    END IF;
  
    -- ��ȡ����userIdʱ������ձ�����
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
            DBMS_OUTPUT.PUT_LINE('������룺' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('������Ϣ��' || SQLERRM);
        END;
      END IF;
    END IF;
  END GET_ODU_INFO;

  --�տ���̽ӿڣ�Ԥ����տ���Ϣͬ�������۶����տ�״̬ͬ����
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
    
     --����
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

   --�������ҵ���տֱ������
   IF P_DATA_TYPE <> 'YW' THEN
      CONTINUE;
   END IF;
  
    --ת��Ϊ�����м�����Ϣ
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
  
    --ת��Ϊ���̵糧��Ϣ  
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
      --����ΪԤ�տ����ĳ�����ۿ�ܺ�ͬ����
      IF V_CONTRACT_FORM = 4 AND V_RECEIPT_TYPE IN ('A', 'Ԥ�տ�') THEN
      
        IF O_CUST_ID > 0 THEN
          --�ҵ��ͻ�������̷��� 
        
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
               'Ԥ����տ���Ϣͬ��');
          
            --���ͳɹ�����տ�ӱ�ʶ
            UPDATE SPM_CON_RECEIPT T
               SET T.EBS_STATUS = 'OR'
             WHERE T.RECEIPT_ID = V_RECEIPT_ID
             AND NOT EXISTS
             (SELECT 1
                      FROM AR_CASH_RECEIPTS_ALL ARA
                     WHERE ARA.RECEIPT_NUMBER = T.RECEIPT_CODE);
          
          END IF;
        
        ELSE
          --����ֻ������Ϣ��������һ�����ݼ�¼�Թ��ͻ��鿴
          INSERT INTO SPM_CON_MQ_MESSAGE
            (MESSAGE_ID, SEND_STATUS, BUSINESS_ID, ORG_ID, REMARK)
          VALUES
            (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
             'Y',
             V_RECEIPT_ID,
             V_ORG_ID,
             'Ԥ���ʧ��');
        END IF;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
    END;
  
    --����Ϊĳ�������ĵ���
    BEGIN
      IF V_RECEIPT_TYPE IN ('B', 'Ԥ�տ�') AND V_CONTRACT_TYPE = 2 THEN
      
        --��֤�������ĵ����Ƿ��Ѿ����͵��� 
        SELECT COUNT(*)
          INTO V_NUMBER
          FROM SPM_CON_MQ_MESSAGE S
         WHERE S.BUSINESS_NAME = 'SPM_CON_MONEY_REG'
           AND S.BUSINESS_CHARAC = 'ORDER_RECIVE_STATUS'
           AND S.BUSINESS_ID = V_RECEIPT_ID;
      
        IF V_NUMBER <> 0 THEN
          CONTINUE;
        END IF;
        
        --��֤����״̬�Ƿ���������
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
        --����ȫ���տ����
        IF V_REG_MONEY = V_RMB_TOTAL THEN
          --�޸Ķ������տ�״̬
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
               '���۶����տ�״̬ͬ��');
          
            --���ͳɹ�����տ�ӱ�ʶ
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

  /*��Ա�Ѵ��м���������ݱ�  */
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
    
      SELECT V.REC_NO, --�տ��
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
      -- ������Ϣ
      SELECT T.ORGANIZATION_ID
        INTO V_DEPT_ID
        FROM SPM_CON_HT_PEOPLE_V T
       WHERE ROWNUM < 2
         AND T.BELONGORGID = V_ORG_ID
         AND T.PERSON_ID =
             SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(V_USER_ID);
    
      -- ��ȡ����֯�޹���
      SELECT P.PROJECT_ID
        INTO V_PROJECT_ID
        FROM SPM_CON_PROJECT P
       WHERE P.PROJECT_NAME LIKE '�޹���-%'
         AND P.ORG_ID = V_ORG_ID;
    
    EXCEPTION
      WHEN OTHERS THEN
        V_RETURN_CODE := 'F';
        IF V_DEPT_ID IS NULL THEN
          V_RETURN_MSG := '��ȡ������Ϣʧ��';
        ELSIF V_PROJECT_ID IS NULL THEN
          V_RETURN_MSG := '����֯���޶�Ӧ���޹���';
        END IF;
      
        UPDATE SPM_CON_MQ_VIPFEEIN V
           SET V.ERROR_MESSAGE = V_RETURN_MSG
         WHERE V.MQ_ID IN V_IDS;
        RETURN;
    END;
    --
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        OPEN CUR1(IDS(I));
        FETCH CUR1
          INTO REC1;
        CLOSE CUR1;
        V_ID := REC1.PAY_ORDER_NO;
      
        IF REC1.V_CUST_ID < 0 OR REC1.V_CUST_ID IS NULL THEN
          V_RETURN_CODE := 'F';
          V_RETURN_MSG  := V_ID || '��ȡ�ͻ���Ϣʧ��';
        
          IF REC1.V_CUST_ID = -1 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '�����м�����ڸ�����¼������ϵ������������';
          ELSIF REC1.V_CUST_ID = -2 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '��δ����ҵ������';
          ELSIF REC1.V_CUST_ID = -3 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '�ÿͻ�δ��Ч';
          ELSIF REC1.V_CUST_ID = -5 THEN
            V_ERROR_MESSAGE := V_ERROR_MESSAGE || '��ȡ�����쳣������ϵϵͳ����Ա';
          END IF;
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '��';
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
           --PACKAGE_NO,--��α��
           --PACKAGE_NAME,--�������
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
           '��Ӫҵ�����',
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
           '�ֹ���Ʊ',
           '��Ʊ',
           1,
           V_PROJECT_ID,
           '��Ա��',
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
           '��Ա��',
           'Ԫ',
           '��Ա��',
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
            V_RETURN_MSG := V_RETURN_MSG || '��';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '���ɷ�Ʊ�����쳣';
          UPDATE SPM_CON_MQ_VIPFEEIN V
             SET V.ERROR_MESSAGE = '���ɷ�Ʊ�����쳣'
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
            V_RETURN_MSG := V_RETURN_MSG || '��';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_ID || '���ɵ��������쳣';
          UPDATE SPM_CON_MQ_TENDER_FEE T
             SET T.ERROR_MESSAGE = '���ɵ��������쳣'
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
      V_RETURN_MSG  := '����ִ���쳣';
  END INSERT_VIP_FEE;

  /*����Ӷ��Ѵ��м���������ݱ�  */
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
  
    --��ȡ��Ӧ��������Ϣ
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
  
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      OPEN CUR2(IDS(I));
      FETCH CUR2
        INTO REC2;
      CLOSE CUR2;
    
      UPDATE SPM_CON_MQ_DEALFEEIN M
         SET M.LAST_UPDATE_DATE = SYSDATE
       WHERE M.MQ_ID = IDS(I);
    
      -- ��ȡOU
      BEGIN
        SELECT TO_NUMBER(H.ORGANIZATION_ID)
          INTO V_ORG_ID
          FROM HR_OPERATING_UNITS H
         WHERE H.SHORT_CODE = SUBSTR(REC2.RECE_ORG_CODE, 0, 8);
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := '��ȡ��֯��' || REC2.RECE_ORG_NAME || '��' ||
                           SUBSTR(REC2.RECE_ORG_CODE, 0, 8) ||
                           '������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      -- ������Ϣ
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
          X_ERROR_MSG   := '��ȡ������Ϣʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      -- ��ȡ����֯�޹���
      BEGIN
        SELECT P.PROJECT_ID
          INTO V_PROJECT_ID
          FROM SPM_CON_PROJECT P
         WHERE P.PROJECT_NAME LIKE '�޹���-%'
           AND P.ORG_ID = V_ORG_ID;
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
          X_ERROR_MSG   := 'δ��ȡ����֯��' || REC2.RECE_ORG_NAME || '��' ||
                           SUBSTR(REC2.RECE_ORG_CODE, 0, 8) ||
                           '�����µ��޹�����Ϣ����������';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      IF REC2.V_CUST_ID < 0 THEN
        V_RETURN_CODE := 'F';
        X_ERROR_MSG   := '��ȡ�ͻ���' || REC2.SUPPLIER || '��' ||
                         REC2.SUPPLIER_CODE || '��������ʧ�ܣ�';
      
        IF REC2.V_CUST_ID = -1 THEN
          X_ERROR_MSG := X_ERROR_MSG || '�����м�����ڸ�����¼������ϵ������������';
        ELSIF REC2.V_CUST_ID = -2 THEN
          X_ERROR_MSG := X_ERROR_MSG || '��δ����ҵ������';
        ELSIF REC2.V_CUST_ID = -3 THEN
          X_ERROR_MSG := X_ERROR_MSG || '�ÿͻ�δ��Ч';
        ELSIF REC2.V_CUST_ID = -5 THEN
          X_ERROR_MSG := X_ERROR_MSG || '��ȡ�����쳣������ϵϵͳ����Ա';
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
           '��Ӫҵ�����',
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
           '��Ʊ',
           '2',
           V_PROJECT_ID,
           '����Ӷ���' || REC2.BILL_TYPE_NOTE,
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
          X_ERROR_MSG   := '��������ʧ�ܣ�����ϵϵͳ����Ա';
        
          UPDATE SPM_CON_MQ_DEALFEEIN T
             SET T.ERROR_MESSAGE = X_ERROR_MSG
           WHERE T.MQ_ID = IDS(I);
          CONTINUE;
      END;
    
      --ִ�гɹ�
      UPDATE SPM_CON_MQ_DEALFEEIN T
         SET T.GENERATE_FLAG = 'Y', T.ERROR_MESSAGE = ''
       WHERE T.MQ_ID = IDS(I);
    END LOOP;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '����ִ��ִ���쳣';
  END INSERT_DEAL_FEE;

  --������˾�����Զ�ƥ����
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
    -- ���㱻','�ָ���γɵ��ַ�������
    SELECT (LENGTH(V_IDS) - LENGTH(REPLACE(V_IDS, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
    -- ѭ������
    WHILE J <= ID_NUM LOOP
      -- ��ID�ַ������ݶ��ŷָ�
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
        --�ж��տ��Ƿ���ȫ��ǩ��
        IF SPM_CON_MONEY_REG_INFO.RESIDUAL_AMOUNT = 0 THEN
          CONTINUE;
        END IF;
        --�ж��Ƿ�Ϊ������˾ �����͹�˾��������˾
        IF (SPM_CON_MONEY_REG_INFO.ORG_ID <> 87 AND
           SPM_CON_MONEY_REG_INFO.ORG_ID <> 84) OR
           SPM_CON_MONEY_REG_INFO.CUST_ID IS NULL THEN
          CONTINUE;
        END IF;
        --����ǿͻ�
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
        --����ǹ�Ӧ��
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
          --����������
          SELECT SPM_CON_IMPORT_PKG.CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_RECEIPT_NUM',
                                                                'SPM_CON_RECEIPT',
                                                                'RECEIPT_CODE',
                                                                'FM000000')
            INTO V_RECEIPT_CODE
            FROM DUAL;
        
          --����ͬ������Ŀ
          SELECT S.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_HT_PROJECT S
           WHERE S.CONTRACT_ID = V_CONTRACT_ID
             AND ROWNUM = 1;
        
          --��ȡ��ܾ����ˡ����첿��
          SELECT S.CREATED_BY, S.DEPT_ID
            INTO V_CREATED_BY, V_DEPT_ID
            FROM SPM_CON_HT_INFO S
           WHERE S.CONTRACT_ID = V_CONTRACT_ID;
        
          BEGIN
            --�����㲿��       
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
          SPM_CON_RECEIPT_INFO.ATTRIBUTE5    := '�Զ�ǩ��';
        
          INSERT INTO SPM_CON_RECEIPT VALUES SPM_CON_RECEIPT_INFO;
          --����ʣ����
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

  /*���ڻش��ʼ���Ϣ�ӿ�*/
  PROCEDURE DB_INVOICE_EXPRESS IS
  
    V_NUMBER NUMBER;
    CURSOR REC1 IS
      SELECT * FROM SPM_DB_INVOICE_EXPRESS_VIEW;
  BEGIN
    FOR DB_INVOICE_EXPRESS IN REC1 LOOP
      --��֤���Ʊ���ʼ���Ϣ�Ƿ��Ѵ���
      SELECT COUNT(*)
        INTO V_NUMBER
        FROM SPM_CON_OUTPUT_INVOICE S
       WHERE S.INVOICE_SERIAL_NUMBER = DB_INVOICE_EXPRESS.CONTRACT_CODE
         AND S.EXPRESS_NUMBER IS NULL;
    
      IF V_NUMBER <> 0 THEN
        UPDATE SPM_CON_OUTPUT_INVOICE S
           SET S.EXPRESS_COMPANY    = 'ems', --Ŀǰ�̶�ems
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

  /*��Ʊ�����������*/
  PROCEDURE SPM_CON_SEND_OPENRESULT(V_IDS            IN VARCHAR2,
                                    V_RETURN_CODE    OUT VARCHAR2,
                                    V_RETURN_MESSAGE OUT VARCHAR2) IS
  
    IDS            SPM_TYPE_TBL;
    V_CONFIGURE_ID NUMBER(15); --���ñ�id
    V_REPEAT       VARCHAR2(20);
    V_OUTINVOICEID NUMBER(15);
    V_CONTRACTCODE VARCHAR2(100); --��Ʊ����
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
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      --ȥ����֤ ��ΪY ���ظ�
      V_REPEAT := SPM_CON_MQ_PKG.SPM_MQ_REPEAT_VALIDATE('SPM_CON_PAPER_INVOICE',
                                                        'SPM_CON_OPEN_INVOICE',
                                                        IDS(I));
      IF V_REPEAT <> 'Y' THEN
        V_RETURN_CODE    := 'E';
        V_RETURN_MESSAGE := '�����ظ�����Ϣ���޷����뵽�м��';
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
          V_RETURN_MESSAGE := 'ƴ��url��Ϣ�쳣������ϵ����Ա';
          RETURN;
      END;
      V_MSG := '{"id":"' || V_CONTRACTCODE || '","invoiceType":"' ||
               V_DS_FLAG || '","urls":' || '[' || SUBSTR(V_URL, 2) || ']}';
      --���ñ�ID��ѯ
      V_CONFIGURE_ID := SPM_CON_MQ_PKG.SPM_MQ_CONFIGURE_ID('SPM_CON_OPEN_INVOICE');
      INSERT INTO SPM.SPM_CON_MQ_MESSAGE
        (MESSAGE_ID, --��Ϣ��ID
         CONFIGURE_ID, --���ñ�ID
         BUSINESS_NAME, --ҵ���
         BUSINESS_CHARAC, --ҵ���ʶ
         BUSINESS_ID, --ҵ��ID
         MESSAGE_CONTENT, --��Ϣ����     
         REMARK --��ע       
         )
      VALUES
        (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL,
         V_CONFIGURE_ID,
         'SPM_CON_PAPER_INVOICE',
         'SPM_CON_OPEN_INVOICE',
         IDS(I),
         V_MSG,
         '��Ʊ���������������');
      UPDATE SPM_CON_OUTPUT_INVOICE O
         SET O.DS_FLAG = O.DS_FLAG || '_S'
       WHERE O.OUTPUT_INVOICE_ID = IDS(I);
      COMMIT;
      V_RETURN_CODE    := 'S';
      V_RETURN_MESSAGE := '�����м��ɹ�';
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '�����м������쳣������ϵ����Ա';
      RETURN;
  END SPM_CON_SEND_OPENRESULT;

  --���Ʊ�ύ����ʱ�ж��Ƿ��������
  FUNCTION QUERY_CONDITION_FLAG(INPUT_ID NUMBER) RETURN VARCHAR2 IS
    RETURN_STRING VARCHAR2(2) := 'Y'; --Ĭ�Ϸ�������
    NUMBER1       NUMBER; --��ⵥ��ϸ��������
    NUMBER2       NUMBER; --����Ʊ��ϸ��������
    NUMBER3       NUMBER; --������ǰ����ַ�һ�µ���ϸ������
  
    NUMBER4 NUMBER; --�Ƿ��������Ʊ ���������Ƿ���Ʊ�����Ľ��Ʊ
  
    MONEY1 NUMBER; --���Ʊ����˰���
    MONEY2 NUMBER; --��ⵥ����˰���ϼ�
  
    R_TYPE VARCHAR2(2); --���Ʊ����  ������߷���
  
  BEGIN
    --��ѯ���Ʊ����
    SELECT T.PAYMENT_STATUS
      INTO R_TYPE
      FROM SPM_CON_INPUT_INVOICE T
     WHERE T.INPUT_INVOICE_ID = INPUT_ID;
  
    --0.����Ƿ������,ֱ�ӷ��ط�������
    IF R_TYPE = 'F' THEN
      RETURN RETURN_STRING;
    END IF;
  
    --��ѯ�Ƿ�������Ʊ;
    SELECT COUNT(*)
      INTO NUMBER4
      FROM SPM_CON_PAPER_INVOICE P
     WHERE P.INVOICE_TYPE = 'AP'
       AND P.INVOICE_ID = INPUT_ID;
  
    --0.����Ƿ�Ʊ������,ֱ�ӷ��ط�������
    IF NUMBER4 = 0 THEN
      RETURN RETURN_STRING;
    END IF;
  
    --��ѯ��ⵥ��ϸ��������
    SELECT COUNT(DL.WAREHOUSE_DL_ID)
      INTO NUMBER1
      FROM SPM_CON_WAREHOUSE_DL DL
     WHERE DL.WAREHOUSE_ID IN
           (SELECT W.WAREHOUSE_ID
              FROM SPM_CON_INPUT_WAREHOUSE W
             WHERE W.INPUT_INVOICE_ID = INPUT_ID
               AND W.WAREHOUSE_ID IS NOT NULL);
  
    --��ѯ����Ʊ��ϸ��������
    SELECT COUNT(C.PAPER_INVOICE_CHILD_ID)
      INTO NUMBER2
      FROM SPM_CON_PAPER_INVOICE_CHILD C
     WHERE C.PAPER_INVOICE_ID IN
           (SELECT P.PAPER_INVOICE_ID
              FROM SPM_CON_PAPER_INVOICE P
             WHERE P.INVOICE_TYPE = 'AP'
               AND P.INVOICE_ID = INPUT_ID);
    --1.�ж���ϸ�������Ƿ�һ��
    IF NUMBER1 <> NUMBER2 THEN
      RETURN 'N';
    END IF;
  
    --��ѯ���Ʊ����˰���
    SELECT I.INVOICETAX_AMOUNT
      INTO MONEY1
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = INPUT_ID;
  
    --��ѯ��������ⵥ����˰���ϼ� 
    SELECT SUM(W.MONEY_AMOUNT)
      INTO MONEY2
      FROM SPM_CON_INPUT_WAREHOUSE W
     WHERE W.INPUT_INVOICE_ID = INPUT_ID
       AND W.WAREHOUSE_ID IS NOT NULL;
  
    --2.�жϲ���˰�������Ƿ�С��0.2
    IF ABS(MONEY1 - MONEY2) > 0.2 THEN
      RETURN 'N';
    END IF;
  
    --��ѯ������ǰ����ַ�һ�µ���ϸ������
  
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
  
    --3.�ж�����ǰ����ַ��������Ƿ�һ��  
    IF NUMBER3 <> NUMBER1 THEN
      RETURN 'N';
    END IF;
    --4.У��ȫ��ͨ������Y
    RETURN RETURN_STRING;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'E';
  END QUERY_CONDITION_FLAG;

  --��ӹ��߷�����������ˮ������ by mcq 20190116
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
    RECEIPT_TYPE VARCHAR(40); --�տ����� ���л���Ʊ��
    FIELD_TYPE   VARCHAR(40); --�ֶ����� 
    RE_MSG       VARCHAR(40);
    --���㲿��        receiptDept
    --��Ʒ��          ebsProduce
    --�ֽ�������      cashFlow
    --�ʽ�ʹ�ò���    matchDept
    --�ʽ�ʹ����Ŀ    matchProject
  
    -- A Ʊ��  D ����
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
