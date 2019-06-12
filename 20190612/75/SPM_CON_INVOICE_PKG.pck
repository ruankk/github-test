CREATE OR REPLACE PACKAGE "SPM_CON_INVOICE_PKG" IS

  --Global Char
  /*  ȡ��ʹ��ȫ�ֱ�����������ɶ�������  by mcq
  G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
  G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';*/
  --��Ʊ��Ʊ����htmlչ��
  FUNCTION SPM_CON_RETURN_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  ---------------------------------------------------------------------------------------
  --���Ʊ��Ʊ������������ͨ���󣬽���Ӧ��Ʊ��״̬����Ϊ�����˻ء�R��
  PROCEDURE SET_INVOICE_STATUS_TO_R(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);
  --Ԥ���Ʊ���̷���
  PROCEDURE SPM_CON_WF_IMP_INVOICE_TJ(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2,
                                      
                                      PPOSITION_ID IN NUMBER);

  --Ԥ���Ʊͨ���ص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --Ԥ���Ʊ��׼�ص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_PZ(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --Ԥ���Ʊ���ػص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --Ԥ���Ʊ��������htmlչ��
  FUNCTION SPM_CON_IMP_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  /*   -- ���ƱΨһ���
  function spm_con_invoice_only_code(P_id  in number,
                                                         p_code in varchar2,
                                                         p_number in varchar2)
    return varchar2;*/

  ---------------------------------------------------------------------------------------
  --���Ʊ���̷���
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);
  --���Ʊ��׼�ص�
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2);
  --���Ʊ���ػص�
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --���Ʊͨ����˺󣬽��������ݺ�����Ԥ�տ��д��Ԥ�տ�ʣ������
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --���Ʊ��������htmlչ��
  FUNCTION SPM_CON_OUTPUT_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ѯԤ������ý�ʣ���� - ����״̬��Ԥ���������
  FUNCTION SPM_CON_QUERY_LOCKED_MONEY(RECEIPT_ID IN NUMBER) RETURN NUMBER;

  --����Ԥ�տ�ʣ����÷���
  PROCEDURE UPDATE_RESIDUAL_RECEIPT_AMOUNT(V_RECEIPT_ID   IN NUMBER,
                                           V_THIS_MONEY   IN NUMBER,
                                           V_THIS_VERSION IN VARCHAR2);
  --����Ԥ�տ�ʣ����÷���
  /*PARAMS��
  v_root_id in number Դ��ID
   v_this_money  in number,������Ҫ�����Ľ���ֵΪ��Ȼ����ֵΪ�������
   v_this_version in Varchar2 ���β�ѯ�������汾��
   v_type         in varchar2 ��ǰ�������Ʊ������A:��׼B:Ԥ����
   */

  --����VALUE��ö�Ӧ���ֽ��� BY MCQ
  FUNCTION GET_EBS_CASH_FLOW_BY_VAL(V_ID NUMBER) RETURN VARCHAR2;

  --���¸���븶��Ʊ���м��Ľ��
  PROCEDURE SPM_CON_UPDATE_PAYMENT_MONEY(I_INVOICE_ID IN NUMBER);

  --���Ʊ����Ԥ���Ʊ�ӱ���ǰ��֤
  PROCEDURE VALIDATE_INPUT_VERIFIC_AMOUNT(P_ID     IN NUMBER,
                                          V_MSG    OUT VARCHAR2,
                                          V_STATUS OUT VARCHAR2);

  --���������������
  PROCEDURE SET_BATCH_MONEY_TYPE(V_IDS    IN VARCHAR2,
                                 V_TYPE   IN VARCHAR2,
                                 R_STATUS OUT VARCHAR2,
                                 R_REASON OUT VARCHAR2);

  -- ��������ڳ���Ʊ
  PROCEDURE PAYMENT_INTIAL_INVOICE(V_PAYMENT_ID  IN NUMBER,
                                   V_RETURN_CODE OUT VARCHAR2,
                                   V_RETURN_MSG  OUT VARCHAR2);

  -- ������ʷ���Ʊ
  PROCEDURE VERITY_HISTORY_OUTPUT_INVOICE(V_RECEIPT_ID IN NUMBER,
                                          V_STATUS     OUT VARCHAR2,
                                          V_REASON     OUT VARCHAR2);
  --�������ͨ���ص��¼�
  PROCEDURE SPM_CON_WF_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);

  --���ݸ����Ϣ���ɶ�Ӧ����ָ�����   YSQ
  PROCEDURE CREATE_INSTRUCT_BY_PAYMENT_NEW(V_PAYMENT_ID IN NUMBER);

  --���ݸ����Ϣ���ɶ�Ӧ����ָ�����
  PROCEDURE CREATE_INSTRUCT_BY_PAYMENT(V_PAYMENT_ID IN NUMBER);

  --��ˮ������
  FUNCTION CREATE_SERIAL_DYNAMIC_VALUE(SERIAL_CODE VARCHAR2,
                                       TABLE_NAME  VARCHAR2,
                                       FIELD_NAME  VARCHAR2,
                                       FORMAT_CODE VARCHAR2) RETURN VARCHAR2;

  --����ID���ɶ�Ӧҵ��������
  PROCEDURE CREATE_APPLY_CODE(V_IDS        IN VARCHAR2,
                              V_STATUS     OUT VARCHAR2,
                              V_STATUS_DEC OUT VARCHAR2);

  /*  ����EBS�෢Ʊ����ͬ��ҵ������
  V_IDS EBS������
  V_TYPE_CODE ����Ӧ��Ӧ�����ֶ� APӦ��ARӦ��*/
  PROCEDURE SPM_CON_COPY_EBS_INVOICE(V_IDS         IN VARCHAR2,
                                     V_TYPE_CODE   IN VARCHAR2,
                                     V_STATUS      OUT VARCHAR2,
                                     V_STATUS_DEC  OUT VARCHAR2,
                                     V_INVOICE_IDS OUT VARCHAR2);
  --����ѡ����Ʊʱ������ֻ�������Ŀ���ѡ��δͬ���ģ������ı���ͬ����������ƿ�Ŀ������ѡ��
  FUNCTION SPM_CON_INVOICE_PERMISSION(V_STATUS VARCHAR2) RETURN VARCHAR2;

  --��ѯӦ����Ʊ���
  FUNCTION MEW_GET_APINVOICE_BALANCE_F(P_INVOICE_ID NUMBER) RETURN NUMBER;

  --��ȡ���������Ŀ�ܺ�ͬID���Ƕ�������ԭID��null
  FUNCTION GET_FRAME_ID(V_ID IN NUMBER) RETURN NUMBER;

  --��ȡ��ܺ�ͬ�����Ķ�����ͬID���Ƕ�������ԭID��null
  FUNCTION GET_ORDER_ID(V_ID IN NUMBER) RETURN VARCHAR2;

  --����ָ���ѯ������ɹ���Ϣ
  PROCEDURE SPM_CON_QUERY_TRADE_APPLY(V_APPLY_CODE IN VARCHAR2);
  --�������ϱ�� ��֯id�Զ���ȡ˰�շ������
  FUNCTION GET_TAX_CODE(V_MATERIAL_CODE VARCHAR2, V_ORG_ID NUMBER)
    RETURN VARCHAR2;
  /*���ݶ����������Ʊ*/
  PROCEDURE GENERATE_ORDERS_INVOICE(V_IDS         IN VARCHAR2,
                                    V_RETURN_CODE OUT VARCHAR2,
                                    V_RETURN_MSG  OUT VARCHAR2);
  --���ݳ��ⵥ�������Ʊ ������˾������ 20190524rkk
  PROCEDURE GENERATE_ODOS_INVOICE(V_IDS         IN VARCHAR2,
                                  V_RETURN_MSG  OUT VARCHAR2);
  --���������жϵ�ǰ�������뵥�Ƿ����ϻ�
  FUNCTION JUDGET_IS_MEETING(V_PAYMENT_ID VARCHAR2, V_WEATHER_DZ VARCHAR2)
    RETURN VARCHAR2;

  --���������жϵ�ǰ�������뵥��Ӧ������Ԥ��
  FUNCTION JUDGET_IS_PAYABLE(V_ID NUMBER) RETURN VARCHAR2;

  --�����ʽ�ʣ����
  PROCEDURE REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID NUMBER, V_TYPE VARCHAR2);

  --��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  FUNCTION FINANCE_DEPT_PERMISSION(V_HT_DEPT NUMBER) RETURN SPM_TYPE_TBL;

  --���ݴ���code��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  FUNCTION FINANCE_DEPT_PERMISSION_B(V_HT_DEPT_B VARCHAR2)
    RETURN SPM_TYPE_TBL;

  --���ݴ���code��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  --���⴦������Э�Ͳִ�ʱ��ȡ����
  FUNCTION FINANCE_DEPT_PERMISSION_T(V_HT_DEPT_B VARCHAR2)
    RETURN SPM_TYPE_TBL;

  --���ݸ��ID���ض�ӦEBS��ID
  FUNCTION GET_EBS_PAYMENT_ID(V_ID VARCHAR2) RETURN VARCHAR2;

  --����ȡ���ʽ������
  PROCEDURE BATCH_CANCEL_PAYMENT(V_IDS         IN VARCHAR2,
                                 V_CANCEL_TIME IN DATE,
                                 V_STATUS      OUT VARCHAR2,
                                 V_REASON      OUT VARCHAR2);
  --���Ӧ������Ԥ��������ϵͳ���  BY ruankk
  FUNCTION GET_PAYABLE_UNPAYABLE_BY_ID(V_ID NUMBER, V_FLAG NUMBER)
    RETURN NUMBER;

  --��鵱ǰ��巢Ʊ���������Ʊʣ�����Ƿ��㹻
  FUNCTION CHECK_CM_INVOICE_AMOUNT_ENOUGH(P_ID NUMBER) RETURN VARCHAR2;

  --��巢Ʊ�ύ�ɹ��󣬺�����Ӧ���Ʊʣ����
  PROCEDURE CM_VERIFIC_OUTPUT_INVOICE(P_ID IN NUMBER, P_TYPE IN VARCHAR2);

  --���ɶ�Ӧ��巢Ʊ��������Ʊ����ˮ��
  PROCEDURE CREATE_SERIAL_CODE_FOR_CM(P_ID IN NUMBER);

  -- Ʊ�����Ľӿڱ����ɽ��Ʊҵ������
  PROCEDURE GENERATE_INTERFACE_INVOICE(INTERFACE_IDS  IN VARCHAR2,
                                       V_CONTRACT_ID  IN NUMBER,
                                       V_WAREHOUSE_ID IN VARCHAR2,
                                       V_RETURN_MSG   OUT VARCHAR2);

  -- ��ȡ���׵�����
  FUNCTION GET_TRANSACTION_NUMBER(V_ID IN VARCHAR2) RETURN VARCHAR2;
  --У�����Ʊ��ϸ����ⵥ��ϸ�Ƿ�ȷƥ��
  FUNCTION CHECK_MATCH_ODO(V_ID NUMBER) RETURN VARCHAR2;

  --��ȡ�¸�������С����ʱ��c
  FUNCTION GET_PAYMENT_GL_DATE(V_ID NUMBER) RETURN DATE;

  --���ݵ�����Ϣ�����տ����
  PROCEDURE CREATE_RECEIPT_FINANCE_INFO(V_ID IN NUMBER);

  --�Ƿ����ò����տ� Y���� N������
  --by mcq
  FUNCTION IS_ENABLE_FINANCIAL_RECEIPT(P_ORG_ID NUMBER) RETURN VARCHAR2;
  --�����������Ʊ�ύ֮ǰУ�����ͬ�Ľ���Լ�����������Ƿ񳬶�
  --by rkk 20190527
  FUNCTION CHECK_MONEY_NUMBER_OUTPUT(K_OUTPUT_ID NUMBER) RETURN VARCHAR2;
END SPM_CON_INVOICE_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_INVOICE_PKG" AS
  --��Ʊ��Ʊ����htmlչ��
  FUNCTION SPM_CON_RETURN_INVOICE_WF_HTML(P_KEY IN VARCHAR2,
                                          
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG               VARCHAR2(20000);
    RETURN_INVOICE_ID NUMBER;
  BEGIN
    SELECT RETURN_INVOICE_ID
      INTO RETURN_INVOICE_ID
      FROM SPM_CON_RETURN_INVOICE
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConReturnInvoice/edit/' ||
                                                RETURN_INVOICE_ID,
                                                P_KEY) || '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  -------------------------------------------------------------------------------

  --Ԥ���Ʊ���̷���
  PROCEDURE SPM_CON_WF_IMP_INVOICE_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_INPUT_INVOICE
       SET STATUS = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                   PPOSITION_ID)
     WHERE INPUT_INVOICE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  /*-- ���ƱΨһ���
  function spm_con_invoice_only_code(P_id     in number,
                                     p_code   in varchar2,
                                     p_number in varchar2) return varchar2 is
    v_inputinvoice number;
    v_data         varchar2(40);
  
  begin
    select e.input_invoice_id
      into v_inputinvoice
      from spm_con_input_invoice e
     where e.invoice_code = p_code
       and e.invoice_number = p_number;
    if p_id is null then
  
      if v_inputinvoice is null then
        v_data := 'true';
        return v_data;
      else
        v_data := 'false';
        return v_data;
      end if;
    else
      if v_inputinvoice is null then
        v_data := 'true';
        return v_data;
      else
        if v_inputinvoice = p_id then
          v_data := 'true';
          return v_data;
        else
          v_data := 'false';
          return v_data;
        end if;
      end if;
    end if;
    return v_data;
  end;*/

  --Ԥ���Ʊͨ���ص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_INPUT_INVOICE
       SET STATUS = 'N'
     WHERE INPUT_INVOICE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_INPUT_INVOICE',
                                         '',
                                         'JOB_ID',
                                         'INPUT_INVOICE_ID');
  END;

  --Ԥ���Ʊͨ���ص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_PZ(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_INPUT_INVOICE
       SET STATUS = 'E'
     WHERE INPUT_INVOICE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_INPUT_INVOICE',
                                         '',
                                         'JOB_ID',
                                         'INPUT_INVOICE_ID');
  END;

  --Ԥ���Ʊ���ػص�
  PROCEDURE SPM_CON_WF_IMP_INVOICE_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_INPUT_INVOICE
       SET STATUS = 'D'
     WHERE INPUT_INVOICE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_INPUT_INVOICE',
                                         '',
                                         'JOB_ID',
                                         'INPUT_INVOICE_ID');
  
  END;
  -----------------------------------------------------------------------------------------------
  --���Ʊ��Ʊ������������ͨ���󣬽���Ӧ��Ʊ��״̬����Ϊ�����˻ء�R��
  PROCEDURE SET_INVOICE_STATUS_TO_R(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) IS
  BEGIN
    --���浽���̼�¼��
    /*    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
    itemkey,
    'SPM_CON_OUTPUT_INVOICE',
    'STATUS',
    'JOB_ID');*/
    UPDATE SPM_CON_OUTPUT_INVOICE V
       SET V.STATUS = 'R'
     WHERE V.OUTPUT_INVOICE_ID =
           (SELECT I.OUTPUT_INVOICE_ID
              FROM SPM_CON_OUTPUT_INVOICE I
             INNER JOIN SPM_CON_RETURN_INVOICE R
                ON I.OUTPUT_INVOICE_ID = R.OUTPUT_INVOICE_ID
               AND R.ITEM_KEY = ITEMKEY);
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;

  --���Ʊ���̷���
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_OUTPUT_INVOICE
       SET STATUS = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                   PPOSITION_ID)
     WHERE OUTPUT_INVOICE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --���Ʊ��׼�ص�
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_OUTPUT_INVOICE',
                                         'STATUS',
                                         'JOB_ID',
                                         'OUTPUT_INVOICE_ID');
  END;
  --���Ʊ���ػص�
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_OUTPUT_INVOICE
       SET STATUS = 'D'
     WHERE OUTPUT_INVOICE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_OUTPUT_INVOICE',
                                         '',
                                         'JOB_ID',
                                         'OUTPUT_INVOICE_ID');
  
  END;
  --���Ʊͨ����˺󣬽��������ݺ�����Ԥ�տ��д��Ԥ�տ�ʣ������
  PROCEDURE SPM_CON_WF_OUTPUT_INVOICE_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --��������ͨ����,��ҵ���״̬����ΪN(δ��Ʊ)
    UPDATE SPM_CON_OUTPUT_INVOICE
       SET STATUS = 'E'
     WHERE OUTPUT_INVOICE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_OUTPUT_INVOICE',
                                         '',
                                         'JOB_ID',
                                         'OUTPUT_INVOICE_ID');
  END;
  --���Ʊ��������htmlչ��
  FUNCTION SPM_CON_OUTPUT_INVOICE_WF_HTML(P_KEY IN VARCHAR2,
                                          
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG               VARCHAR2(20000);
    OUTPUT_INVOICE_ID NUMBER;
    V_STATUS          VARCHAR2(10); --����״̬
    V_REC_ID          NUMBER(15); --������id
  BEGIN
    SELECT W.JOB_ID
      INTO OUTPUT_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    --��ȡ����״̬
    SELECT T.STATUS
      INTO V_STATUS
      FROM SPM_CON_OUTPUT_INVOICE T, SPM_CON_WF_ACTIVITY W
     WHERE T.OUTPUT_INVOICE_ID = W.JOB_ID
       AND W.ITEM_KEY = P_KEY;
  
    --�鿴��ǰ���̴�����Ϣ������userid
    SELECT V.USER_ID
      INTO V_REC_ID
      FROM WF_NOTIFICATIONS WF, SPM_EAM_ALL_PEOPLE_V V
     WHERE WF.RECIPIENT_ROLE = V.USER_NAME
       AND WF.NOTIFICATION_ID =
           (SELECT MAX(N.NOTIFICATION_ID)
              FROM WF_NOTIFICATIONS N
             WHERE N.ITEM_KEY = P_KEY);
  
    --״̬��cѡĬ��ְ���ʱ��Ĭ��ѡ������¼org_id ��Ӧ��ְ��
    --���ҵ�ǰ�����˾��Ǵ�����Ϣ������
    IF (V_STATUS = 'C') AND V_REC_ID = SPM_SSO_PKG.GETUSERID THEN
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConOutputInvoice/edit/' ||
                                                       OUTPUT_INVOICE_ID,
                                                       P_KEY) ||
             '''>�鿴����</a><br>';
    ELSE
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                     'WF_URL=/spmConOutputInvoice/edit/' ||
                                                     OUTPUT_INVOICE_ID,
                                                     P_KEY) ||
             '''>�鿴����</a><br>';
    END IF;
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --Ԥ���Ʊ����htmlչ��
  FUNCTION SPM_CON_IMP_INVOICE_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG              VARCHAR2(20000);
    INPUT_INVOICE_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO INPUT_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConImprestInvoice/edit/' ||
                                                INPUT_INVOICE_ID,
                                                P_KEY) || '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  --��ѯԤ������ý�ʣ���� - ����״̬��Ԥ���������
  FUNCTION SPM_CON_QUERY_LOCKED_MONEY(RECEIPT_ID IN NUMBER) RETURN NUMBER IS
    LOCKED_MONEY NUMBER;
    REST_MONEY   NUMBER;
    MONEY        NUMBER;
  BEGIN
    SELECT SUM(CASE
                 WHEN V.MATCH_IMPREST_AMOUNT IS NULL THEN
                  0
                 ELSE
                  V.MATCH_IMPREST_AMOUNT
               END)
      INTO LOCKED_MONEY
      FROM SPM_CON_OUTPUT_INVOICE I
     INNER JOIN SPM_CON_OUTPUT_VERIFIC V
        ON I.OUTPUT_INVOICE_ID = V.OUTPUT_INVOICE_ID
     WHERE I.STATUS NOT IN ('N', 'R', 'E')
       AND V.RECEIPT_ID = RECEIPT_ID
     GROUP BY V.RECEIPT_ID;
    SELECT S.RESIDUAL_AMOUNT
      INTO REST_MONEY
      FROM SPM_CON_RECEIPT S
     WHERE S.RECEIPT_ID = RECEIPT_ID;
  
    SELECT (REST_MONEY - LOCKED_MONEY) INTO MONEY FROM DUAL;
    RETURN MONEY;
  END;

  --����Ԥ�տ�ʣ����÷���
  PROCEDURE UPDATE_RESIDUAL_RECEIPT_AMOUNT(V_RECEIPT_ID   IN NUMBER,
                                           V_THIS_MONEY   IN NUMBER,
                                           V_THIS_VERSION IN VARCHAR2) IS
    NOW_VERSION  VARCHAR2(40);
    NOW_RESIDUAL NUMBER;
    NEW_AMOUNT   NUMBER;
    OLD_VERSION  VARCHAR2(40);
  BEGIN
  
    SELECT R.MONEY_VERSION, R.RESIDUAL_AMOUNT
      INTO NOW_VERSION, NOW_RESIDUAL
      FROM SPM_CON_RECEIPT R
     WHERE R.RECEIPT_ID = V_RECEIPT_ID;
    --�����ǰ�汾�������ݿ��еİ汾��һֱ����ֱ�Ӽ���
    IF V_THIS_VERSION = NOW_VERSION THEN
      OLD_VERSION := V_THIS_VERSION + 1;
      UPDATE SPM_CON_RECEIPT
         SET RESIDUAL_AMOUNT =
             (RESIDUAL_AMOUNT - V_THIS_MONEY),
             MONEY_VERSION   = OLD_VERSION
       WHERE RECEIPT_ID = V_RECEIPT_ID;
    
      DBMS_OUTPUT.PUT_LINE('�����汾��һ��');
    ELSIF NOW_RESIDUAL > V_THIS_MONEY THEN
      NEW_AMOUNT  := NOW_RESIDUAL - V_THIS_MONEY;
      NOW_VERSION := NOW_VERSION + 1;
      UPDATE SPM_CON_RECEIPT
         SET RESIDUAL_AMOUNT = NEW_AMOUNT, MONEY_VERSION = NOW_VERSION
       WHERE RECEIPT_ID = V_RECEIPT_ID;
      DBMS_OUTPUT.PUT_LINE('�����汾�Ų�һ�µ��ǹ���');
    ELSE
      DBMS_OUTPUT.PUT_LINE('������ִ�в���');
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;
  --����Ԥ�տ�ʣ����÷���
  /*PARAMS��
  v_root_id in number Դ��ID
   v_this_money  in number,������Ҫ�����Ľ���ֵΪ��Ȼ����ֵΪ�������
   v_this_version in Varchar2 ���β�ѯ�������汾��
   v_type         in varchar2 ��ǰ�������Ʊ������A:��׼B:Ԥ����
   */

  --����VALUE��ö�Ӧ���ֽ��� BY MCQ
  FUNCTION GET_EBS_CASH_FLOW_BY_VAL(V_ID NUMBER) RETURN VARCHAR2 IS
    RET VARCHAR2(240);
  BEGIN
  
    SELECT T.DESCRIPTION
      INTO RET
      FROM FND_FLEX_VALUES_TL T, FND_FLEX_VALUES B
     WHERE B.FLEX_VALUE_ID = T.FLEX_VALUE_ID
       AND T.LANGUAGE = 'ZHS'
       AND B.FLEX_VALUE_SET_ID = 1014929
       AND B.ENABLED_FLAG = 'Y'
       AND T.FLEX_VALUE_ID = V_ID;
    RETURN RET;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_EBS_CASH_FLOW_BY_VAL;

  PROCEDURE SPM_CON_UPDATE_PAYMENT_MONEY(I_INVOICE_ID IN NUMBER) AS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_INVOICE_AMOUNT     NUMBER;
    V_PAYMENT_ID         NUMBER;
    V_PAYMENT_INVOICE_ID NUMBER;
    V_COUNT              NUMBER;
  BEGIN
    --��ѯ��ǰ����Ԥ����Ľ�Ԫ��
    SELECT I.INVOICE_AMOUNT
      INTO V_INVOICE_AMOUNT
      FROM SPM_CON_INPUT_INVOICE I
     WHERE I.INPUT_INVOICE_ID = I_INVOICE_ID;
  
    --��ѯ��ǰԤ�����Ƿ��븶�����
    SELECT COUNT(PI.PAYMENT_INVOICE_ID)
      INTO V_COUNT
      FROM SPM_CON_PAYMENT_INVOICE PI
     WHERE PI.INPUT_INVOICE_ID = I_INVOICE_ID;
  
    IF V_COUNT > 0 THEN
      --��ѯ������ĸ��ID�����м��ID
      SELECT PI.PAYMENT_ID, PI.PAYMENT_INVOICE_ID
        INTO V_PAYMENT_ID, V_PAYMENT_INVOICE_ID
        FROM SPM_CON_PAYMENT_INVOICE PI
       WHERE PI.INPUT_INVOICE_ID = I_INVOICE_ID
         AND ROWNUM = 1;
    
      --�����м��������
      UPDATE SPM_CON_PAYMENT_INVOICE PI
         SET PI.MONEY_AMOUNT = V_INVOICE_AMOUNT
       WHERE PI.PAYMENT_INVOICE_ID = V_PAYMENT_INVOICE_ID;
      --���¸�����ܽ��
      UPDATE SPM_CON_PAYMENT P
         SET P.MONEY_AMOUNT =
             (SELECT SUM(I.MONEY_AMOUNT)
                FROM SPM_CON_PAYMENT_INVOICE I
               WHERE I.PAYMENT_ID = V_PAYMENT_ID
               GROUP BY I.PAYMENT_ID)
       WHERE P.PAYMENT_ID = V_PAYMENT_ID;
    
    END IF;
  
  END;
  --���Ʊ����Ԥ���Ʊ�ӱ���ǰ��֤
  PROCEDURE VALIDATE_INPUT_VERIFIC_AMOUNT(P_ID     IN NUMBER,
                                          V_MSG    OUT VARCHAR2,
                                          V_STATUS OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    V_COUNT NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO V_COUNT
      FROM SPM_CON_INPUT_VERIFIC V
     WHERE V.INPUT_INVOICE_ID = P_ID;
    IF V_COUNT <> 0 THEN
      BEGIN
        SELECT COUNT(P.INVOICE_ID)
          INTO V_COUNT
          FROM SPM_CON_INPUT_VERIFIC V, SPM_CON_AP_PREPAYMENT_V P
         WHERE V.IMPREST_INVOICE_ID = P.INVOICE_ID
           AND V.INPUT_INVOICE_ID = P_ID
         GROUP BY P.INVOICE_ID, P.PREPAYMENT_AMOUNT
        HAVING P.PREPAYMENT_AMOUNT < SUM(V.VERIFIC_IMPREST_AMOUNT);
      
        /* 1.��֤��ǰ������ap��Ʊ��EBS�������Ƿ����С�ڱ��κ����������*/
        IF V_COUNT <> 0 THEN
          V_STATUS := G_INTERFACE_ERROR;
          V_MSG    := '��ǰ���ں���������Ԥ���Ʊ���ý��������������ѡ��!';
          RETURN;
        END IF;
        /* 2.��������,�����;���*/
      
      EXCEPTION
      
        WHEN OTHERS THEN
        
          V_STATUS := G_INTERFACE_SUCCESS;
          RETURN;
      END;
    ELSE
      V_STATUS := G_INTERFACE_SUCCESS;
      RETURN;
    END IF;
  END VALIDATE_INPUT_VERIFIC_AMOUNT;

  --���������������
  PROCEDURE SET_BATCH_MONEY_TYPE(V_IDS    IN VARCHAR2,
                                 V_TYPE   IN VARCHAR2,
                                 R_STATUS OUT VARCHAR2,
                                 R_REASON OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IDS              SPM_TYPE_TBL;
    V_COUNT          NUMBER;
    V_SERIAL_NUMBER  VARCHAR2(100);
    V_CUST_ID        NUMBER(15);
    V_U_MONEY        NUMBER;
    V_REASON         VARCHAR2(3000);
    V_STATUS         VARCHAR2(50) := G_INTERFACE_SUCCESS;
    V_ORG_ID         NUMBER(15);
    V_H_TEXT         VARCHAR2(50) := '���Ϊ��';
    V_M_TEXT         VARCHAR2(50) := '�������ʧ�ܣ�ԭ��Ϊ:';
    V_BEFORE_TYPE    VARCHAR2(40); --֮ǰ�ķ������
    V_RECEIPT_STATUS VARCHAR2(40); --�տ�״̬
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --����V_TYPE�ж��ǽ��й�Ӧ����֤�����ǿͻ���֤
    IF V_TYPE = 'ar' THEN
    
      FOR I IN 1 .. IDS.COUNT LOOP
        V_CUST_ID := NULL;
        SELECT R.SERIAL_NUMBER,
               (R.MONEY_ACCOUNT - R.RESIDUAL_AMOUNT) AS USERD_MONEY
          INTO V_SERIAL_NUMBER, V_U_MONEY
          FROM SPM_CON_MONEY_REG R
         WHERE R.MONEY_REG_ID = IDS(I);
      
        IF V_U_MONEY <> 0 THEN
          V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                      V_M_TEXT || '�ñʵ����Ѿ������죬�봦������·���';
        
          V_STATUS := G_INTERFACE_ERROR;
        
        ELSE
        
          --�жϵ�ǰ�ͻ������ں�ͬ���Ƿ����
          SELECT COUNT(C.CUST_ID)
            INTO V_COUNT
            FROM SPM_CON_CUST_INFO C, SPM_CON_MONEY_REG M
           WHERE C.CUST_NAME = M.ACCOUNT_NAME
             AND M.MONEY_REG_ID = IDS(I)
             AND C.STATUS = 'E';
          IF V_COUNT = 0 THEN
            V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                        V_M_TEXT || '�ÿͻ��ں�ͬ�಻���ڻ�δͨ�����';
            V_STATUS := G_INTERFACE_ERROR;
            UPDATE SPM_CON_MONEY_REG R
               SET R.REG_TYPE = G_INTERFACE_ERROR, R.CUST_ID = V_CUST_ID
             WHERE R.MONEY_REG_ID = IDS(I);
            COMMIT;
          ELSE
            --��¼�ͻ�ID
            SELECT C.CUST_ID
              INTO V_CUST_ID
              FROM SPM_CON_CUST_INFO C, SPM_CON_MONEY_REG M
             WHERE C.CUST_NAME = M.ACCOUNT_NAME
               AND M.MONEY_REG_ID = IDS(I)
               AND C.STATUS = 'E';
            --��ѯ�ͻ��Ƿ����
            SELECT COUNT(*)
              INTO V_COUNT
              FROM /*APPS.AR_CUSTOMERS           AC,*/ APPS.HZ_PARTIES             HP,
                   APPS.HZ_CUST_ACCOUNTS       HCA,
                   APPS.HZ_CUST_ACCT_SITES_ALL HCAS,
                   APPS.HZ_CUST_SITE_USES_ALL  HCSU,
                   SPM.SPM_CON_MONEY_REG       SCMR
             WHERE HP.PARTY_ID = HCA.PARTY_ID
               AND HCA.CUST_ACCOUNT_ID = HCAS.CUST_ACCOUNT_ID
               AND HCAS.CUST_ACCT_SITE_ID = HCSU.CUST_ACCT_SITE_ID
               AND HCSU.SITE_USE_CODE = 'BILL_TO'
               AND HP.PARTY_NAME = SCMR.ACCOUNT_NAME
               AND HCAS.ORG_ID = SCMR.ORG_ID
               AND SCMR.MONEY_REG_ID = IDS(I);
          
            IF V_COUNT = 0 THEN
              V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                          '�����ʧ�ܣ�ԭ��Ϊ:' || '�ÿͻ���EBS�಻����';
              V_STATUS := G_INTERFACE_ERROR;
              UPDATE SPM_CON_MONEY_REG R
                 SET R.REG_TYPE = G_INTERFACE_ERROR, R.CUST_ID = V_CUST_ID
               WHERE R.MONEY_REG_ID = IDS(I);
              COMMIT;
            
            ELSE
              --��֤�������˻��ڸ���֯�����տ���Ƿ���ڶ�Ӧ
              SELECT COUNT(SCMR.MONEY_REG_ID)
                INTO V_COUNT
                FROM APPS.AR_RECEIPT_METHOD_ACCOUNTS_ALL ARMA,
                     APPS.AR_RECEIPT_METHODS             ARM,
                     APPS.AR_RECEIPT_CLASSES             ARC,
                     APPS.HR_OPERATING_UNITS             HOU,
                     APPS.CE_BANK_ACCT_USES_ALL          CBAU,
                     APPS.CE_BANK_ACCOUNTS               CBA,
                     APPS.AR_RECEIVABLES_TRX_ALL         ART,
                     APPS.AR_RECEIVABLES_TRX_ALL         ART1,
                     SPM.SPM_CON_MONEY_REG               SCMR
              
               WHERE HOU.ORGANIZATION_ID = ARMA.ORG_ID
                 AND ARM.RECEIPT_METHOD_ID = ARMA.RECEIPT_METHOD_ID
                 AND ARC.RECEIPT_CLASS_ID = ARM.RECEIPT_CLASS_ID
                 AND ARMA.EDISC_RECEIVABLES_TRX_ID = ART.RECEIVABLES_TRX_ID
                 AND ARMA.UNEDISC_RECEIVABLES_TRX_ID =
                     ART1.RECEIVABLES_TRX_ID
                 AND CBAU.BANK_ACCT_USE_ID = ARMA.REMIT_BANK_ACCT_USE_ID
                 AND CBAU.ORG_ID = ARMA.ORG_ID
                 AND CBAU.BANK_ACCOUNT_ID = CBA.BANK_ACCOUNT_ID
                 AND ARM.END_DATE IS NULL --�����Ч����֤
                 AND SCMR.RECEIPT_ACCOUNT = CBA.BANK_ACCOUNT_NUM --�����˻�
                 AND SCMR.ORG_ID = CBAU.ORG_ID --��֯����
                 AND SCMR.RECEIPT_METHOD = ARM.NAME --�տ��
                 AND SCMR.MONEY_REG_ID = IDS(I);
            
              IF V_COUNT = 0 THEN
                V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                            V_M_TEXT || '��ǰ��֯�¸������˻����տ����ƥ��';
                V_STATUS := G_INTERFACE_ERROR;
                UPDATE SPM_CON_MONEY_REG R
                   SET R.REG_TYPE = G_INTERFACE_ERROR,
                       R.CUST_ID  = V_CUST_ID
                 WHERE R.MONEY_REG_ID = IDS(I);
                COMMIT;
              ELSE
                --ִ�и��²���
                UPDATE SPM_CON_MONEY_REG R
                   SET R.REG_TYPE = V_TYPE, R.CUST_ID = V_CUST_ID
                 WHERE R.MONEY_REG_ID = IDS(I);
                --���ɲ����տ by mcq 20190215
                CREATE_RECEIPT_FINANCE_INFO(IDS(I));
                COMMIT;
              END IF;
            END IF;
          
          END IF;
        END IF;
      END LOOP;
    
    ELSE
      FOR I IN 1 .. IDS.COUNT LOOP
        V_CUST_ID := NULL;
        SELECT R.SERIAL_NUMBER,
               R.ORG_ID,
               (R.MONEY_ACCOUNT - R.RESIDUAL_AMOUNT) AS USERD_MONEY
          INTO V_SERIAL_NUMBER, V_ORG_ID, V_U_MONEY
          FROM SPM_CON_MONEY_REG R
         WHERE R.MONEY_REG_ID = IDS(I);
        IF V_U_MONEY <> 0 THEN
          V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                      V_M_TEXT || '�ñʵ����Ѿ������죬�봦������·���';
        ELSE
        
          --�жϵ�ǰ��Ӧ�������ں�ͬ���Ƿ����
          SELECT COUNT(V.VENDOR_ID)
            INTO V_COUNT
            FROM SPM_CON_VENDOR_INFO V, SPM_CON_MONEY_REG M
           WHERE V.VENDOR_NAME = M.ACCOUNT_NAME
             AND M.MONEY_REG_ID = IDS(I)
                
             AND V.STATUS = 'E';
          IF V_COUNT = 0 THEN
            V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                        V_M_TEXT || '�ù�Ӧ���ں�ͬ�಻���ڻ�δͨ�����';
            V_STATUS := G_INTERFACE_ERROR;
            UPDATE SPM_CON_MONEY_REG R
               SET R.REG_TYPE = G_INTERFACE_ERROR, R.CUST_ID = V_CUST_ID
             WHERE R.MONEY_REG_ID = IDS(I);
            COMMIT;
          ELSE
          
            SELECT V.VENDOR_ID
              INTO V_CUST_ID
              FROM SPM_CON_VENDOR_INFO V, SPM_CON_MONEY_REG M
             WHERE V.VENDOR_NAME = M.ACCOUNT_NAME
               AND M.MONEY_REG_ID = IDS(I)
               AND V.STATUS = 'E';
            --��ѯ��ǰou��Ӧ�������˻��Ƿ����
          
            SELECT COUNT(SCMR.MONEY_REG_ID)
              INTO V_COUNT
              FROM CE.CE_BANK_ACCT_USES_ALL T,
                   CE_BANK_ACCOUNTS         B,
                   HR_OPERATING_UNITS       HOU,
                   SPM_CON_MONEY_REG        SCMR
             WHERE T.BANK_ACCOUNT_ID = B.BANK_ACCOUNT_ID
               AND HOU.ORGANIZATION_ID = T.ORG_ID
               AND SCMR.RECEIPT_ACCOUNT = B.BANK_ACCOUNT_NUM
               AND SCMR.ORG_ID = T.ORG_ID
               AND SCMR.MONEY_REG_ID = IDS(I);
          
            IF V_COUNT = 0 THEN
              V_REASON := V_REASON || ';' || V_H_TEXT || V_SERIAL_NUMBER ||
                          '�����ʧ�ܣ�ԭ��Ϊ:' || '�������˺���EBS�಻����';
              V_STATUS := G_INTERFACE_ERROR;
              UPDATE SPM_CON_MONEY_REG R
                 SET R.REG_TYPE = G_INTERFACE_ERROR, R.CUST_ID = V_CUST_ID
               WHERE R.MONEY_REG_ID = IDS(I);
              COMMIT;
            ELSE
            
              SELECT NVL(G.REG_TYPE, 'KK')
                INTO V_BEFORE_TYPE
                FROM SPM_CON_MONEY_REG G
               WHERE G.MONEY_REG_ID = IDS(I);
            
              IF V_BEFORE_TYPE = 'KK' OR V_BEFORE_TYPE = 'ap' OR
                 V_BEFORE_TYPE = 'E' THEN
                --ִ�и��²���
                UPDATE SPM_CON_MONEY_REG R
                   SET R.REG_TYPE = V_TYPE, R.CUST_ID = V_CUST_ID
                 WHERE R.MONEY_REG_ID = IDS(I);
                COMMIT;
              ELSE
                --20190520 rk ������ڸ�����¼ʱ�ᱨ��
                BEGIN
                  SELECT DISTINCT NVL(R.EBS_STATUS, 'KK')
                    INTO V_RECEIPT_STATUS
                    FROM SPM_CON_RECEIPT R
                   WHERE R.MONEY_REG_ID = IDS(I);
                EXCEPTION
                  WHEN OTHERS THEN
                    V_RECEIPT_STATUS := 'KK';
                END;
              
                IF V_RECEIPT_STATUS = 'S' OR V_RECEIPT_STATUS = 'US' OR
                   V_RECEIPT_STATUS = 'UE' THEN
                
                  V_REASON := V_REASON || ';' || V_H_TEXT ||
                              V_SERIAL_NUMBER || '�����ʧ�ܣ�ԭ��Ϊ:' ||
                              '�õ����Ӧ���տ��Ѿ�ͬ���򴴽���Ʒ�¼';
                  V_STATUS := G_INTERFACE_ERROR;
                  UPDATE SPM_CON_MONEY_REG R
                     SET R.REG_TYPE = G_INTERFACE_ERROR,
                         R.CUST_ID  = V_CUST_ID
                   WHERE R.MONEY_REG_ID = IDS(I);
                  COMMIT;
                ELSE
                  DELETE SPM_CON_RECEIPT T WHERE T.MONEY_REG_ID = IDS(I);
                  --ִ�и��²���
                  UPDATE SPM_CON_MONEY_REG R
                     SET R.REG_TYPE = V_TYPE, R.CUST_ID = V_CUST_ID
                   WHERE R.MONEY_REG_ID = IDS(I);
                  COMMIT;
                END IF;
              END IF;
            
            END IF;
          
          END IF;
        END IF;
      END LOOP;
    END IF;
  
    R_STATUS := V_STATUS;
    R_REASON := V_REASON;
    --�쳣����
  EXCEPTION
    WHEN OTHERS THEN
    
      R_STATUS := G_INTERFACE_ERROR;
      R_REASON := V_REASON || ';' || '�洢����ִ���쳣������ϵ������Ա!';
    
  END SET_BATCH_MONEY_TYPE;

  -- ��������ڳ���Ʊ
  PROCEDURE PAYMENT_INTIAL_INVOICE(V_PAYMENT_ID  IN NUMBER,
                                   V_RETURN_CODE OUT VARCHAR2,
                                   V_RETURN_MSG  OUT VARCHAR2) IS
  
    CURSOR GETINPUTINFO(I_CONTRACT_ID NUMBER,
                        I_PROJECT_ID  NUMBER,
                        I_VENDOR_ID   NUMBER) IS
      SELECT I.INPUT_INVOICE_ID, I.RESIDUAL_AMOUNT
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.RESIDUAL_AMOUNT > 0
         AND I.CONTRACT_ID = I_CONTRACT_ID
         AND I.PROJECT_ID = I_PROJECT_ID
         AND I.VENDOR_ID = I_VENDOR_ID
         AND I.EBS_STATUS = 'LS';
  
    CURSOR GETPAYMENTINVOICEINFO(I_PAYMENT_ID NUMBER) IS
      SELECT PI.PAYMENT_INVOICE_ID, PI.INPUT_INVOICE_ID, PI.MONEY_AMOUNT
        FROM SPM_CON_PAYMENT_INVOICE PI, SPM_CON_INPUT_INVOICE I
       WHERE PI.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
         AND I.EBS_STATUS = 'LS'
         AND PI.PAYMENT_ID = I_PAYMENT_ID;
  
    V_CONTRACT_ID           NUMBER;
    V_PROJECT_ID            NUMBER;
    V_VENDOR_ID             NUMBER;
    V_MONEY_AMOUNT          NUMBER;
    V_VERIFIC_AMOUNT        NUMBER;
    V_VERIFIC_AMOUNT_TOTAL  NUMBER;
    V_INPUT_INVOICE_ID      NUMBER;
    V_INPUT_RESIDUAL_AMOUNT NUMBER;
    V_PAYMENT_INVOICE_ID    NUMBER;
  BEGIN
    SELECT P.CONTRACT_ID, P.PROJECT_ID, P.VENDOR_ID
      INTO V_CONTRACT_ID, V_PROJECT_ID, V_VENDOR_ID
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    -- ��ѯ�ܺ������
    SELECT NVL(SUM(PI.MONEY_AMOUNT), 0)
      INTO V_MONEY_AMOUNT
      FROM SPM_CON_PAYMENT_INVOICE PI
     WHERE PI.INPUT_INVOICE_ID IN
           (SELECT I.INPUT_INVOICE_ID
              FROM SPM_CON_INPUT_INVOICE I
             WHERE I.VENDOR_ID = V_VENDOR_ID
               AND I.CONTRACT_ID IS NULL
               AND I.PROJECT_ID IS NULL)
       AND PI.PAYMENT_ID = V_PAYMENT_ID;
  
    -- ��ѯ�Ѻ������
    SELECT NVL(SUM(PI.MONEY_AMOUNT), 0)
      INTO V_VERIFIC_AMOUNT_TOTAL
      FROM SPM_CON_PAYMENT_INVOICE PI, SPM_CON_INPUT_INVOICE I
     WHERE PI.INPUT_INVOICE_ID = I.INPUT_INVOICE_ID
       AND I.EBS_STATUS = 'LS'
       AND PI.PAYMENT_ID = V_PAYMENT_ID;
  
    -- ���ܺ����������Ѻ������
    IF V_MONEY_AMOUNT > V_VERIFIC_AMOUNT_TOTAL THEN
      -- ��ֵʣ��������
      V_MONEY_AMOUNT := V_MONEY_AMOUNT - V_VERIFIC_AMOUNT_TOTAL;
      -- ѭ������ʷ������ȡֵ
      OPEN GETINPUTINFO(V_CONTRACT_ID, V_PROJECT_ID, V_VENDOR_ID);
      FETCH GETINPUTINFO
        INTO V_INPUT_INVOICE_ID, V_INPUT_RESIDUAL_AMOUNT;
      WHILE GETINPUTINFO%FOUND AND V_MONEY_AMOUNT > 0 LOOP
        SELECT SPM_CON_PAYMENT_INVOICE_SEQ.NEXTVAL
          INTO V_PAYMENT_INVOICE_ID
          FROM DUAL;
      
        -- ʣ���������뵱ǰ��Ʊʣ����ֱ�ԱȲ���ֵ����
        IF V_MONEY_AMOUNT > V_INPUT_RESIDUAL_AMOUNT THEN
          INSERT INTO SPM_CON_PAYMENT_INVOICE
            (PAYMENT_INVOICE_ID,
             PAYMENT_ID,
             INPUT_INVOICE_ID,
             MONEY_AMOUNT,
             REMARK)
          VALUES
            (V_PAYMENT_INVOICE_ID,
             V_PAYMENT_ID,
             V_INPUT_INVOICE_ID,
             V_INPUT_RESIDUAL_AMOUNT,
             'LS');
        
          -- ����ʣ����
          V_MONEY_AMOUNT := V_MONEY_AMOUNT - V_INPUT_RESIDUAL_AMOUNT;
          UPDATE SPM_CON_INPUT_INVOICE
             SET RESIDUAL_AMOUNT = 0
           WHERE INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
        ELSE
          INSERT INTO SPM_CON_PAYMENT_INVOICE
            (PAYMENT_INVOICE_ID,
             PAYMENT_ID,
             INPUT_INVOICE_ID,
             MONEY_AMOUNT,
             REMARK)
          VALUES
            (V_PAYMENT_INVOICE_ID,
             V_PAYMENT_ID,
             V_INPUT_INVOICE_ID,
             V_MONEY_AMOUNT,
             'LS');
        
          -- ����ʣ����
          V_INPUT_RESIDUAL_AMOUNT := V_INPUT_RESIDUAL_AMOUNT -
                                     V_MONEY_AMOUNT;
          V_MONEY_AMOUNT          := 0;
          UPDATE SPM_CON_INPUT_INVOICE
             SET RESIDUAL_AMOUNT = V_INPUT_RESIDUAL_AMOUNT
           WHERE INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
        END IF;
        FETCH GETINPUTINFO
          INTO V_INPUT_INVOICE_ID, V_INPUT_RESIDUAL_AMOUNT;
      END LOOP;
      CLOSE GETINPUTINFO;
    
    ELSIF V_MONEY_AMOUNT < V_VERIFIC_AMOUNT_TOTAL THEN
      -- ���������
      V_INPUT_RESIDUAL_AMOUNT := V_VERIFIC_AMOUNT_TOTAL - V_MONEY_AMOUNT;
      -- ѭ����ȡ�Ѻ�������
      OPEN GETPAYMENTINVOICEINFO(V_PAYMENT_ID);
      FETCH GETPAYMENTINVOICEINFO
        INTO V_PAYMENT_INVOICE_ID, V_INPUT_INVOICE_ID, V_VERIFIC_AMOUNT;
      WHILE GETPAYMENTINVOICEINFO%FOUND AND V_INPUT_RESIDUAL_AMOUNT > 0 LOOP
      
        -- ��ǰ����������С�ڸ÷�Ʊ���Ѻ�������ֱ�ӹ黹
        IF V_INPUT_RESIDUAL_AMOUNT < V_VERIFIC_AMOUNT THEN
          UPDATE SPM_CON_PAYMENT_INVOICE PI
             SET PI.MONEY_AMOUNT =
                 (V_VERIFIC_AMOUNT - V_INPUT_RESIDUAL_AMOUNT)
           WHERE PI.PAYMENT_INVOICE_ID = V_PAYMENT_INVOICE_ID;
        
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.RESIDUAL_AMOUNT =
                 (I.RESIDUAL_AMOUNT + V_INPUT_RESIDUAL_AMOUNT)
           WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
          V_INPUT_RESIDUAL_AMOUNT := 0;
        ELSE
          -- ���·�Ʊʣ����
          UPDATE SPM_CON_INPUT_INVOICE I
             SET I.RESIDUAL_AMOUNT =
                 (I.RESIDUAL_AMOUNT + V_VERIFIC_AMOUNT)
           WHERE I.INPUT_INVOICE_ID = V_INPUT_INVOICE_ID;
          V_INPUT_RESIDUAL_AMOUNT := V_INPUT_RESIDUAL_AMOUNT -
                                     V_VERIFIC_AMOUNT;
          -- ɾ���м�������¼
          DELETE FROM SPM_CON_PAYMENT_INVOICE
           WHERE PAYMENT_INVOICE_ID = V_PAYMENT_INVOICE_ID;
        END IF;
      
        FETCH GETPAYMENTINVOICEINFO
          INTO V_PAYMENT_INVOICE_ID, V_INPUT_INVOICE_ID, V_VERIFIC_AMOUNT;
      END LOOP;
      CLOSE GETPAYMENTINVOICEINFO;
    END IF;
    V_RETURN_CODE := 'S';
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '����ʧ��';
  END PAYMENT_INTIAL_INVOICE;

  -- ������ʷ���Ʊ
  PROCEDURE VERITY_HISTORY_OUTPUT_INVOICE(V_RECEIPT_ID IN NUMBER,
                                          V_STATUS     OUT VARCHAR2,
                                          V_REASON     OUT VARCHAR2) IS
    V_HIS_MONEY       NUMBER DEFAULT 0;
    V_QC_MONEY        NUMBER DEFAULT 0;
    V_RESIDUAL_AMOUNT NUMBER DEFAULT 0;
    V_SUCCESS_FLAG CONSTANT VARCHAR2(1) := 'S';
    V_ERROR_FLAG   CONSTANT VARCHAR2(1) := 'E';
    IS_EXISTS NUMBER;
  
    --�����ѯ����������ʷ���Ʊ�α�
    CURSOR CUR1(P_ID NUMBER) IS
      SELECT OI.*
        FROM SPM_CON_OUTPUT_INVOICE OI,
             SPM_CON_RECEIPT        CR,
             SPM_CON_MONEY_REG      MR
       WHERE 1 = 1
         AND MR.MONEY_REG_ID = CR.RECEIPT_ID
         AND OI.PROJECT_ID = CR.PROJECT_ID
         AND OI.CONTRACT_ID = CR.CONTRACT_ID
         AND OI.CUST_ID = MR.CUST_ID
         AND MR.REG_TYPE = 'ar'
         AND CR.RECEIPT_ID = P_ID
       ORDER BY OI.BILLING_DATE; --���տ�Ʊʱ����������
    --�����ѯ����������ʷ���Ʊ�α�
    CURSOR CUR2(P_ID NUMBER) IS
      SELECT RI.*
        FROM SPM_CON_RECEIPT_INVOICE RI, SPM_CON_OUTPUT_INVOICE OI
       WHERE 1 = 1
         AND RI.OUTPUT_INVOICE_ID = OI.OUTPUT_INVOICE_ID
         AND RI.RECEIPT_ID = P_ID
       ORDER BY OI.BILLING_DATE;
  BEGIN
  
    --1.��ѯ�տ������Ѿ�������������ʷ���Ʊ���
    SELECT COUNT(1)
      INTO IS_EXISTS
      FROM SPM_CON_RECEIPT_INVOICE RI, SPM_CON_OUTPUT_INVOICE OI
     WHERE 1 = 1
       AND RI.OUTPUT_INVOICE_ID = OI.OUTPUT_INVOICE_ID
       AND OI.EBS_STATUS = 'LS'
       AND RI.RECEIPT_ID = V_RECEIPT_ID;
    --����ʱ����ѯ�ѹ����������ڣ�ֱ��ȡĬ��ֵ
    IF IS_EXISTS <> 0 THEN
      SELECT SUM(RI.MONEY_AMOUNT)
        INTO V_HIS_MONEY
        FROM SPM_CON_RECEIPT_INVOICE RI, SPM_CON_OUTPUT_INVOICE OI
       WHERE 1 = 1
         AND RI.OUTPUT_INVOICE_ID = OI.OUTPUT_INVOICE_ID
         AND OI.EBS_STATUS = 'LS'
         AND RI.RECEIPT_ID = V_RECEIPT_ID;
    END IF;
  
    --2.��ѯ�տ����µ�ǰ�����������޺�ͬ������Ŀ���޿ͻ����ڳ���Ʊ���
    SELECT COUNT(1)
      INTO IS_EXISTS
      FROM SPM_CON_RECEIPT_INVOICE RI, SPM_CON_OUTPUT_INVOICE OI
     WHERE 1 = 1
       AND RI.OUTPUT_INVOICE_ID = OI.OUTPUT_INVOICE_ID
       AND OI.EBS_STATUS = 'US'
       AND OI.CONTRACT_ID IS NULL
       AND OI.PROJECT_ID IS NULL
       AND OI.CUST_ID IS NULL
       AND RI.RECEIPT_ID = V_RECEIPT_ID;
    --����ʱ����ѯ�ѹ����������ڣ�ֱ��ȡĬ��ֵ
  
    IF IS_EXISTS <> 0 THEN
      SELECT SUM(RI.MONEY_AMOUNT)
        INTO V_QC_MONEY
        FROM SPM_CON_RECEIPT_INVOICE RI, SPM_CON_OUTPUT_INVOICE OI
       WHERE 1 = 1
         AND RI.OUTPUT_INVOICE_ID = OI.OUTPUT_INVOICE_ID
         AND OI.EBS_STATUS = 'US'
         AND OI.CONTRACT_ID IS NULL
         AND OI.PROJECT_ID IS NULL
         AND OI.CUST_ID IS NULL
         AND RI.RECEIPT_ID = V_RECEIPT_ID;
    END IF;
  
    --3.������жϴ����߼�
  
    /*a. ��ǰ�����ڳ���Ʊ������ѹ�����ʷ��Ʊ�����ȣ�������Ϊ0�����
    ���β���Ҫ�����κβ���������״̬S*/
  
    IF V_QC_MONEY = V_HIS_MONEY THEN
    
      V_STATUS := V_SUCCESS_FLAG;
    
    ELSIF V_QC_MONEY > V_HIS_MONEY THEN
      /*b.��ǰ�����ڳ���Ʊ�������ѹ�����ʷ��Ʊ���
      ��Ҫ����һ������ʷ��Ʊ��� */
      BEGIN
      
        --������Ҫ��������ʣ����
        V_RESIDUAL_AMOUNT := V_QC_MONEY - V_HIS_MONEY;
        --ѭ������������������ʷ��Ʊ��������ʣ����
        FOR REC1 IN CUR1(V_RECEIPT_ID) LOOP
          --�Ƚϲ�ѯ������ʷ��Ʊ����뵱ǰ������ʣ����
          --part1 ʣ����С�ڵ��ڲ�ѯ������ʷ��Ʊ���
          IF V_RESIDUAL_AMOUNT <= REC1.RESIDUAL_AMOUNT THEN
            --������ʷ��Ʊ��ʣ����
            UPDATE SPM_CON_OUTPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT =
                   (REC1.RESIDUAL_AMOUNT - V_RESIDUAL_AMOUNT)
             WHERE I.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
            --Ϊ�տ�������Ʊ�����/����һ��������¼   
            SELECT COUNT(1)
              INTO IS_EXISTS
              FROM SPM_CON_RECEIPT_INVOICE RI
             WHERE 1 = 1
               AND RI.RECEIPT_ID = V_RECEIPT_ID
               AND RI.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
            --����Ѿ����ڵ�ǰ�տ��£���ͬ���Ʊ�ļ�¼��ֱ�Ӹ��²���
            IF IS_EXISTS <> 0 THEN
              UPDATE SPM_CON_RECEIPT_INVOICE RI
                 SET RI.MONEY_AMOUNT =
                     (RI.MONEY_AMOUNT + V_RESIDUAL_AMOUNT)
               WHERE 1 = 1
                 AND RI.RECEIPT_ID = V_RECEIPT_ID
                 AND RI.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
            ELSE
              INSERT INTO SPM_CON_RECEIPT_INVOICE
                (RECEIPT_INVOICE_ID,
                 RECEIPT_ID,
                 OUTPUT_INVOICE_ID,
                 MONEY_AMOUNT,
                 EBS_STATUS)
              VALUES
                (SPM_CON_RECEIPT_INVOICE_SEQ.NEXTVAL,
                 V_RECEIPT_ID,
                 REC1.OUTPUT_INVOICE_ID,
                 V_RESIDUAL_AMOUNT,
                 'LS');
            END IF;
            V_RESIDUAL_AMOUNT := 0;
          
            --���β�����ϣ�����forѭ��
            EXIT;
          ELSE
            --part2 ʣ������ڲ�ѯ������ʷ��Ʊ���(����ʣ����)
            V_RESIDUAL_AMOUNT := V_RESIDUAL_AMOUNT - REC1.RESIDUAL_AMOUNT;
          
            --Ϊ�տ�������Ʊ�����/����һ��������¼   
            SELECT COUNT(1)
              INTO IS_EXISTS
              FROM SPM_CON_RECEIPT_INVOICE RI
             WHERE 1 = 1
               AND RI.RECEIPT_ID = V_RECEIPT_ID
               AND RI.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
            --����Ѿ����ڵ�ǰ�տ��£���ͬ���Ʊ�ļ�¼��ֱ�Ӹ��²���
            IF IS_EXISTS <> 0 THEN
              UPDATE SPM_CON_RECEIPT_INVOICE RI
                 SET RI.MONEY_AMOUNT =
                     (RI.MONEY_AMOUNT + REC1.RESIDUAL_AMOUNT)
               WHERE 1 = 1
                 AND RI.RECEIPT_ID = V_RECEIPT_ID
                 AND RI.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
            ELSE
              INSERT INTO SPM_CON_RECEIPT_INVOICE
                (RECEIPT_INVOICE_ID,
                 RECEIPT_ID,
                 OUTPUT_INVOICE_ID,
                 MONEY_AMOUNT,
                 EBS_STATUS)
              VALUES
                (SPM_CON_RECEIPT_INVOICE_SEQ.NEXTVAL,
                 V_RECEIPT_ID,
                 REC1.OUTPUT_INVOICE_ID,
                 REC1.RESIDUAL_AMOUNT,
                 'LS');
            END IF;
            --������ʷ��Ʊ��ʣ���ȫ��������
            UPDATE SPM_CON_OUTPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT = 0
             WHERE I.OUTPUT_INVOICE_ID = REC1.OUTPUT_INVOICE_ID;
          
          END IF;
        END LOOP;
      EXCEPTION
        WHEN OTHERS THEN
          V_STATUS := V_ERROR_FLAG;
          V_REASON := '�����ڳ���Ʊ�������ѹ�����ʷ��Ʊ��������������⣬����ϵ������Ա';
      END;
    ELSE
      /*c.��ǰ�����ڳ���Ʊ���С���ѹ�����ʷ��Ʊ���
      ��Ҫ����һ������ʷ��Ʊ��� */
      BEGIN
        V_RESIDUAL_AMOUNT := V_HIS_MONEY - V_QC_MONEY;
        FOR REC2 IN CUR2(V_RECEIPT_ID) LOOP
          --part1 ʣ����С�ڵ��ڲ�ѯ���Ĺ�����ʷ��Ʊ��¼���
          IF REC2.MONEY_AMOUNT >= V_RESIDUAL_AMOUNT THEN
            --�������Ʊʣ����(ԭ���Ʊʣ����+������Ҫ�۳��Ľ��)
            UPDATE SPM_CON_OUTPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT =
                   (I.RESIDUAL_AMOUNT + V_RESIDUAL_AMOUNT)
             WHERE I.OUTPUT_INVOICE_ID = REC2.OUTPUT_INVOICE_ID;
            --�����տ������Ʊ��¼���
            UPDATE SPM_CON_RECEIPT_INVOICE RI
               SET RI.MONEY_AMOUNT =
                   (RI.MONEY_AMOUNT - V_RESIDUAL_AMOUNT)
             WHERE RI.RECEIPT_INVOICE_ID = REC2.RECEIPT_INVOICE_ID;
            V_RESIDUAL_AMOUNT := 0;
            --part2 ʣ������ڲ�ѯ���Ĺ�����ʷ��Ʊ��¼���
          ELSE
            --����ѭ�����ʣ����
            V_RESIDUAL_AMOUNT := V_RESIDUAL_AMOUNT - REC2.MONEY_AMOUNT;
            --�������Ʊʣ����(ԭ���Ʊʣ����-��ǰ�տ�����ĸ���ʷ���Ʊ��¼���)
            UPDATE SPM_CON_OUTPUT_INVOICE I
               SET I.RESIDUAL_AMOUNT =
                   (I.RESIDUAL_AMOUNT + REC2.MONEY_AMOUNT)
             WHERE I.OUTPUT_INVOICE_ID = REC2.OUTPUT_INVOICE_ID;
            --ɾ���ñ��տ������Ʊ��¼���
            DELETE FROM SPM_CON_RECEIPT_INVOICE RI
             WHERE RI.RECEIPT_INVOICE_ID = REC2.RECEIPT_INVOICE_ID;
          
          END IF;
        END LOOP;
      EXCEPTION
        WHEN OTHERS THEN
          V_STATUS := V_ERROR_FLAG;
          V_REASON := '�����ڳ���Ʊ���С���ѹ�����ʷ��Ʊ��������������⣬����ϵ������Ա';
      END;
    END IF;
  END VERITY_HISTORY_OUTPUT_INVOICE;

  --�������ͨ���ص��¼�
  PROCEDURE SPM_CON_WF_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) IS
    P_PAYMENT_ID NUMBER(15);
  
  BEGIN
  
    --1.����ITEMKEY�ҵ���Ӧ���
  
    SELECT P.PAYMENT_ID
      INTO P_PAYMENT_ID
      FROM SPM_CON_PAYMENT P, SPM_CON_WF_ACTIVITY W
     WHERE P.PAYMENT_ID = W.JOB_ID
       AND W.ITEM_KEY = ITEMKEY;
  
    --2.�������ɸ���ָ�����
    CREATE_INSTRUCT_BY_PAYMENT(V_PAYMENT_ID => P_PAYMENT_ID);
  
  END SPM_CON_WF_PAYMENT_TG;

  --���ݸ����Ϣ���ɶ�Ӧ����ָ�����   YSQ
  PROCEDURE CREATE_INSTRUCT_BY_PAYMENT_NEW(V_PAYMENT_ID IN NUMBER) AS
  
    IS_EXISTS          NUMBER;
    IS_IN              NUMBER; --�Ƿ��ڲ��˻�  0������  1 ����
    V_VENDOR_NAME      VARCHAR2(200);
    L_PAYMENT_INFO     SPM_CON_PAYMENT%ROWTYPE;
    L_INSTRUCT         SPM_CON_TRANSFER_INSTRUCT%ROWTYPE;
    L_ACCOUNT          SPM_CON_ORIENTATION_ACCOUNT%ROWTYPE;
    V_BANK_ACCOUNT_NUM VARCHAR2(30);
    V_NUMBER           NUMBER;
  
    CURSOR PAYMENT_CHILD IS
      SELECT *
        FROM SPM_CON_PAYMENT_CHILD S
       WHERE S.PAYMENT_ID = V_PAYMENT_ID;
  BEGIN
  
    --1.����ID�ҵ���Ӧ������տ�˻���
  
    SELECT P.*
      INTO L_PAYMENT_INFO
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    SELECT V.VENDOR_NAME
      INTO V_VENDOR_NAME
      FROM SPM_CON_VENDOR_INFO V
     WHERE V.VENDOR_ID = L_PAYMENT_INFO.VENDOR_ID;
  
    --2.���ݸ����Ϣ���ɶ�Ӧ��������
    --���ݵ�ǰ�տ��˻��Ƿ�Ϊ�ڲ��˻��жϣ��ǣ���Ϊ��ת������Ϊ���и���
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = L_PAYMENT_INFO.PAYMENT_ID
       AND P.BANK_ACCOUNT_NUM LIKE '01-10%';
    IS_IN := IS_EXISTS;
    IF IS_EXISTS = 0 THEN
      L_INSTRUCT.TRANS_TYPE := 'YHFK';
    ELSE
      L_INSTRUCT.TRANS_TYPE := 'BZ';
    END IF;
  
    --3.����֧��ָ���,�����ɽ��ױ���Ƶ����ýӿ�ʱ
    /* --��ȡ��ˮ�� 
    
    L_INSTRUCT.APPLY_CODE := CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_APPLY_CODE',
                                                         'SPM_CON_TRANSFER_INSTRUCT',
                                                         'APPLY_CODE',
                                                         'FM00000');*/
  
    --4.����OU���ɶ�Ӧ�ͻ����,�����˻�
    BEGIN
      SELECT H.ATTRIBUTE4, H.ATTRIBUTE5
        INTO L_INSTRUCT.CLIENT_CODE, L_INSTRUCT.PAYER_ACCT_NO
        FROM HR_ALL_ORGANIZATION_UNITS H
       WHERE H.ORGANIZATION_ID = L_PAYMENT_INFO.ORG_ID
         AND H.ATTRIBUTE1 = 'org';
    EXCEPTION
      WHEN OTHERS THEN
        L_INSTRUCT.CLIENT_CODE   := '00';
        L_INSTRUCT.PAYER_ACCT_NO := '00';
      
    END;
  
    --5.У�鹩Ӧ���˺��Ƿ�Ϊ�����˻���������ǣ������һ�������˻�����
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_ORIENTATION_ACCOUNT A
     WHERE 1 = 1
       AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
       AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
  
    IF IS_EXISTS <> 0 THEN
      --������ڣ������տ��˻���ȡ��Ӧ�����˻���Ϣ
      SELECT *
        INTO L_ACCOUNT
        FROM SPM_CON_ORIENTATION_ACCOUNT A
       WHERE 1 = 1
         AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
         AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
    
      IF L_ACCOUNT.STATUS = 'S' THEN
      
        L_INSTRUCT.PAYEE_ACCT_NAME  := L_ACCOUNT.VENDOR_NAME;
        L_INSTRUCT.REMIT_BANK_NAME  := L_ACCOUNT.BANK_NAME;
        L_INSTRUCT.REMIT_BANK_CNAPS := L_ACCOUNT.BIG_ACCOUNT_NUMBER;
        L_INSTRUCT.REMIT_PROVINCE   := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_AREA',
                                                                                       L_ACCOUNT.PROVINCE_CODE),
                                               'ʡ',
                                               '');
        L_INSTRUCT.REMIT_CITY       := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_CITY',
                                                                                       L_ACCOUNT.CITY_CODE),
                                               '��',
                                               '');
      END IF;
    
    ELSE
      --ֻ�з��ڲ��˻��Ų��붨���˻���Ϣ
      IF IS_IN = 0 THEN
      
        --��������ڣ������һ�������˻���Ϣ
        L_ACCOUNT.ACCOUNT_ID    := SPM_CON_OR_ACCOUNT_SEQ.NEXTVAL;
        L_ACCOUNT.BANK_ACCOUNT  := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
        L_ACCOUNT.VENDOR_NAME   := V_VENDOR_NAME;
        L_ACCOUNT.BANK_NAME     := L_PAYMENT_INFO.BANK_NAME;
        L_ACCOUNT.CREATED_BY    := L_PAYMENT_INFO.CREATED_BY;
        L_ACCOUNT.CREATION_DATE := SYSDATE;
        L_ACCOUNT.DEPT_ID       := L_PAYMENT_INFO.DEPT_ID;
        L_ACCOUNT.ORG_ID        := L_PAYMENT_INFO.ORG_ID;
        L_ACCOUNT.STATUS        := 'A';
        L_ACCOUNT.CLIENT_CODE   := L_INSTRUCT.CLIENT_CODE;
      
        INSERT INTO SPM_CON_ORIENTATION_ACCOUNT VALUES L_ACCOUNT;
        COMMIT;
      
      END IF;
    
    END IF;
  
    FOR PAYMENT_CHILD_INFO IN PAYMENT_CHILD LOOP
    
      --��֤�Ƿ�Ϊ����˾�˻�
      SELECT A.BANK_ACCOUNT_NUM
        INTO V_BANK_ACCOUNT_NUM
        FROM CE.CE_BANK_ACCOUNTS A
       WHERE A.BANK_ACCOUNT_ID = PAYMENT_CHILD_INFO.PAY_BANK_ACCOUNT_ID;
    
      SELECT COUNT(*)
        INTO V_NUMBER
        FROM SPM_DICT_TYPE S, SPM_DICT T
       WHERE S.TYPE_CODE = 'SPM_CON_IS_FINANCIAL BANK'
         AND S.DICT_TYPE_ID = T.DICT_TYPE_ID
         AND T.DICT_NAME = V_BANK_ACCOUNT_NUM;
    
      IF V_NUMBER <> 0 THEN
      
        --6.���ݸ���ӱ���Ϣ����һ��֧��ָ��
      
        L_INSTRUCT.INSTRUCT_ID     := SPM_CON_TR_INSTRUCT_SEQ.NEXTVAL;
        L_INSTRUCT.AMOUNT          := PAYMENT_CHILD_INFO.MONEY_AMOUNT;
        L_INSTRUCT.EXCUTE_DATE     := SYSDATE;
        L_INSTRUCT.PAYEE_ACCT_NO   := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
        L_INSTRUCT.PAYEE_ACCT_NAME := V_VENDOR_NAME;
        L_INSTRUCT.REMIT_BANK_NAME := L_PAYMENT_INFO.BANK_NAME;
        L_INSTRUCT.PAY_SUBJECT_NO  := PAYMENT_CHILD_INFO.MATCH_PROJECT;
      
        L_INSTRUCT.CREATED_BY       := L_PAYMENT_INFO.CREATED_BY;
        L_INSTRUCT.DEPT_ID          := L_PAYMENT_INFO.DEPT_ID;
        L_INSTRUCT.ORG_ID           := L_PAYMENT_INFO.ORG_ID;
        L_INSTRUCT.CREATION_DATE    := L_PAYMENT_INFO.CREATION_DATE;
        L_INSTRUCT.LAST_UPDATE_DATE := L_PAYMENT_INFO.LAST_UPDATE_DATE;
        L_INSTRUCT.PAYMENT_ID       := L_PAYMENT_INFO.PAYMENT_ID;
        L_INSTRUCT.PURPOSE          := L_PAYMENT_INFO.PAY_PURPOSE;
      
        INSERT INTO SPM_CON_TRANSFER_INSTRUCT VALUES L_INSTRUCT;
      
      END IF;
    
    END LOOP;
  
  END;

  --���ݸ����Ϣ���ɶ�Ӧ����ָ�����
  PROCEDURE CREATE_INSTRUCT_BY_PAYMENT(V_PAYMENT_ID IN NUMBER) AS
  
    IS_EXISTS      NUMBER;
    IS_IN          NUMBER; --�Ƿ��ڲ��˻�  0������  1 ����
    V_VENDOR_NAME  VARCHAR2(200);
    L_PAYMENT_INFO SPM_CON_PAYMENT%ROWTYPE;
    L_INSTRUCT     SPM_CON_TRANSFER_INSTRUCT%ROWTYPE;
    L_ACCOUNT      SPM_CON_ORIENTATION_ACCOUNT%ROWTYPE;
  BEGIN
  
    --1.����ID�ҵ���Ӧ������տ�˻���
  
    SELECT P.*
      INTO L_PAYMENT_INFO
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    SELECT V.VENDOR_NAME
      INTO V_VENDOR_NAME
      FROM SPM_CON_VENDOR_INFO V
     WHERE V.VENDOR_ID = L_PAYMENT_INFO.VENDOR_ID;
  
    --2.���ݸ����Ϣ���ɶ�Ӧ��������
    --���ݵ�ǰ�տ��˻��Ƿ�Ϊ�ڲ��˻��жϣ��ǣ���Ϊ��ת������Ϊ���и���
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = L_PAYMENT_INFO.PAYMENT_ID
       AND P.BANK_ACCOUNT_NUM LIKE '01-10%';
  
    IS_IN := IS_EXISTS;
    IF IS_EXISTS = 0 THEN
      L_INSTRUCT.TRANS_TYPE := 'YHFK';
    ELSE
      L_INSTRUCT.TRANS_TYPE := 'BZ';
    END IF;
  
    --3.����֧��ָ���,�����ɽ��ױ���Ƶ����ýӿ�ʱ
    /* --��ȡ��ˮ�� 
    
    L_INSTRUCT.APPLY_CODE := CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_APPLY_CODE',
                                                         'SPM_CON_TRANSFER_INSTRUCT',
                                                         'APPLY_CODE',
                                                         'FM00000');*/
  
    --4.����OU���ɶ�Ӧ�ͻ����,�����˻�
    BEGIN
      SELECT H.ATTRIBUTE4, H.ATTRIBUTE5
        INTO L_INSTRUCT.CLIENT_CODE, L_INSTRUCT.PAYER_ACCT_NO
        FROM HR_ALL_ORGANIZATION_UNITS H
       WHERE H.ORGANIZATION_ID = L_PAYMENT_INFO.ORG_ID
         AND H.ATTRIBUTE1 = 'org';
    EXCEPTION
      WHEN OTHERS THEN
        L_INSTRUCT.CLIENT_CODE   := '00';
        L_INSTRUCT.PAYER_ACCT_NO := '00';
      
    END;
    --5.У�鹩Ӧ���˺��Ƿ�Ϊ�����˻���������ǣ������һ�������˻�����
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_ORIENTATION_ACCOUNT A
     WHERE 1 = 1
       AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
       AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
  
    IF IS_EXISTS <> 0 THEN
      --������ڣ������տ��˻���ȡ��Ӧ�����˻���Ϣ
      SELECT *
        INTO L_ACCOUNT
        FROM SPM_CON_ORIENTATION_ACCOUNT A
       WHERE 1 = 1
         AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
         AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
    
      IF L_ACCOUNT.STATUS = 'S' THEN
      
        L_INSTRUCT.PAYEE_ACCT_NAME  := L_ACCOUNT.VENDOR_NAME;
        L_INSTRUCT.REMIT_BANK_NAME  := L_ACCOUNT.BANK_NAME;
        L_INSTRUCT.REMIT_BANK_CNAPS := L_ACCOUNT.BIG_ACCOUNT_NUMBER;
        L_INSTRUCT.REMIT_PROVINCE   := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_AREA',
                                                                                       L_ACCOUNT.PROVINCE_CODE),
                                               'ʡ',
                                               '');
        L_INSTRUCT.REMIT_CITY       := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_CITY',
                                                                                       L_ACCOUNT.CITY_CODE),
                                               '��',
                                               '');
      END IF;
    
    ELSE
      --ֻ�з��ڲ��˻��Ų��붨���˻���Ϣ
      IF IS_IN = 0 THEN
      
        --��������ڣ������һ�������˻���Ϣ
        L_ACCOUNT.ACCOUNT_ID    := SPM_CON_OR_ACCOUNT_SEQ.NEXTVAL;
        L_ACCOUNT.BANK_ACCOUNT  := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
        L_ACCOUNT.VENDOR_NAME   := V_VENDOR_NAME;
        L_ACCOUNT.BANK_NAME     := L_PAYMENT_INFO.BANK_NAME;
        L_ACCOUNT.CREATED_BY    := L_PAYMENT_INFO.CREATED_BY;
        L_ACCOUNT.CREATION_DATE := SYSDATE;
        L_ACCOUNT.DEPT_ID       := L_PAYMENT_INFO.DEPT_ID;
        L_ACCOUNT.ORG_ID        := L_PAYMENT_INFO.ORG_ID;
        L_ACCOUNT.STATUS        := 'A';
        L_ACCOUNT.CLIENT_CODE   := L_INSTRUCT.CLIENT_CODE;
      
        INSERT INTO SPM_CON_ORIENTATION_ACCOUNT VALUES L_ACCOUNT;
        COMMIT;
      
      END IF;
    
    END IF;
  
    --6.���ݸ����Ϣ����һ��֧��ָ��
  
    L_INSTRUCT.INSTRUCT_ID     := SPM_CON_TR_INSTRUCT_SEQ.NEXTVAL;
    L_INSTRUCT.AMOUNT          := L_PAYMENT_INFO.MONEY_AMOUNT;
    L_INSTRUCT.EXCUTE_DATE     := SYSDATE;
    L_INSTRUCT.PAYEE_ACCT_NO   := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
    L_INSTRUCT.PAYEE_ACCT_NAME := V_VENDOR_NAME;
    L_INSTRUCT.REMIT_BANK_NAME := L_PAYMENT_INFO.BANK_NAME;
    L_INSTRUCT.PAY_SUBJECT_NO  := L_PAYMENT_INFO.MATCH_PROJECT;
  
    L_INSTRUCT.CREATED_BY       := L_PAYMENT_INFO.CREATED_BY;
    L_INSTRUCT.DEPT_ID          := L_PAYMENT_INFO.DEPT_ID;
    L_INSTRUCT.ORG_ID           := L_PAYMENT_INFO.ORG_ID;
    L_INSTRUCT.CREATION_DATE    := L_PAYMENT_INFO.CREATION_DATE;
    L_INSTRUCT.LAST_UPDATE_DATE := L_PAYMENT_INFO.LAST_UPDATE_DATE;
    L_INSTRUCT.PAYMENT_ID       := L_PAYMENT_INFO.PAYMENT_ID;
    L_INSTRUCT.PURPOSE          := L_PAYMENT_INFO.PAY_PURPOSE;
  
    INSERT INTO SPM_CON_TRANSFER_INSTRUCT VALUES L_INSTRUCT;
  END CREATE_INSTRUCT_BY_PAYMENT;

  --��ˮ������
  FUNCTION CREATE_SERIAL_DYNAMIC_VALUE(SERIAL_CODE VARCHAR2,
                                       TABLE_NAME  VARCHAR2,
                                       FIELD_NAME  VARCHAR2,
                                       FORMAT_CODE VARCHAR2) RETURN VARCHAR2 IS
    RESULT_CODE VARCHAR2(100) DEFAULT '00';
  BEGIN
    --���ö���Ĺ������ɶ�Ӧ��ˮ�Ź̶�����
    SELECT SPM_CON_SERIAL_PKG.VALUE(SERIAL_CODE)
      INTO RESULT_CODE
      FROM DUAL;
  
    --Ϊ��֯�������ǰ��λ
    RESULT_CODE := '1000' || RESULT_CODE;
    --���ݹ̶����ֻ�ȡ��Ӧ��ˮ��
    SELECT SPM_CON_SERIAL_PKG.GET_SERIAL_CODE(TABLE_NAME,
                                              FIELD_NAME,
                                              FORMAT_CODE,
                                              RESULT_CODE)
      INTO RESULT_CODE
      FROM DUAL;
  
    RETURN RESULT_CODE;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '00';
    
  END CREATE_SERIAL_DYNAMIC_VALUE;

  --����ID���ɶ�Ӧҵ��������
  PROCEDURE CREATE_APPLY_CODE(V_IDS        IN VARCHAR2,
                              V_STATUS     OUT VARCHAR2,
                              V_STATUS_DEC OUT VARCHAR2) IS
    G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
    G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';
    IS_EXISTS    NUMBER;
    IDS          SPM_TYPE_TBL;
    V_APPLY_CODE VARCHAR2(40);
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
    
      --��ȡ��ˮ��
    
      V_APPLY_CODE := CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_APPLY_CODE',
                                                  'SPM_CON_TRANSFER_INSTRUCT',
                                                  'APPLY_CODE',
                                                  'FM00000');
    
      UPDATE SPM_CON_TRANSFER_INSTRUCT I
         SET I.APPLY_CODE = V_APPLY_CODE
       WHERE I.INSTRUCT_ID = IDS(I);
    
    END LOOP;
    V_STATUS := G_INTERFACE_SUCCESS;
  
  EXCEPTION
    WHEN OTHERS THEN
    
      V_STATUS := G_INTERFACE_ERROR;
  END CREATE_APPLY_CODE;

  /*  ����EBS�෢Ʊ����ͬ��ҵ������
  V_IDS EBS������
  V_TYPE_CODE ����Ӧ��Ӧ�����ֶ� APӦ��ARӦ��*/
  PROCEDURE SPM_CON_COPY_EBS_INVOICE(V_IDS         IN VARCHAR2,
                                     V_TYPE_CODE   IN VARCHAR2,
                                     V_STATUS      OUT VARCHAR2,
                                     V_STATUS_DEC  OUT VARCHAR2,
                                     V_INVOICE_IDS OUT VARCHAR2) IS
    IDS          SPM_TYPE_TBL;
    V_USER_ID    NUMBER(15);
    V_DEPT_ID    NUMBER(15);
    V_INVOICE_ID NUMBER(15);
  
  BEGIN
  
    --1.������idsƴ�ӵ��ַ���תΪ���飬��������
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    --2.��ѯ��ǰ��֯�¶�Ӧadmin�û�����Ϣ
    SELECT HP.USER_ID, HP.ORGANIZATION_ID
      INTO V_USER_ID, V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V HP
     WHERE HP.USER_NAME LIKE '%ADMIN%'
       AND HP.BELONGORGID = SPM_SSO_PKG.GETORGID;
  
    --3.ѭ����
    FOR I IN 1 .. IDS.COUNT LOOP
      --3.1 �жϴ���ҵ�����ͣ���������������Ӧ����AP_INVOICES������Ӧ��(TRANSACTIONS)
      --3.2 ����ҵ������+ou+id ȷ��Ψһһ�����ݣ�������insert����  
      IF V_TYPE_CODE = 'AP_INVOICES' THEN
        V_INVOICE_ID  := SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL;
        V_INVOICE_IDS := V_INVOICE_IDS || ',' || V_INVOICE_ID;
        BEGIN
          INSERT INTO SPM_CON_INPUT_INVOICE
            (INPUT_INVOICE_ID,
             VENDOR_ID,
             CONTRACT_ID,
             PROJECT_ID,
             INVOICE_CONTENT,
             INVOICE_TYPE,
             INVOICE_CODE,
             INVOICE_AMOUNT,
             CURRENCY_TYPE,
             PAYMENT_STATUS,
             VERIFIC_IMPREST_AMOUNT,
             CREATED_BY,
             CREATION_DATE,
             STATUS,
             ORG_ID,
             RESIDUAL_AMOUNT,
             BILLING_DATE,
             PAYMENT_TERM,
             PAYMENT_TYPE,
             EBS_TYPE,
             VENDOR_SITE_ID,
             GL_DATE,
             TAX_AMOUNT,
             INVOICETAX_AMOUNT,
             NOTAX_RESIDUAL_AMOUNT,
             TAX_RATE,
             EBS_STATUS,
             EBS_SYNC_DATE,
             LAST_UPDATE_DATE,
             EBS_DEPT_CODE,
             ORIGINAL_AMOUNT,
             EXCHANGE_RATE,
             EBS_ID,
             CREATE_ACCOUNT_BY,
             DEPT_ID)
            SELECT *
              FROM (WITH HT AS (SELECT HI.CONTRACT_ID, HI.CONTRACT_CODE
                                  FROM SPM_CON_HT_INFO HI
                                 WHERE 1 = 1
                                   AND (HI.ATTRIBUTE4 IN ('E', 'Z') OR
                                       SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(HI.CONTRACT_ID) = 'Y')), SP AS (SELECT VI.VENDOR_ID,
                                                                                                                          SU.VENDOR_ID AS EBS_V_ID
                                                                                                                     FROM SPM_CON_VENDOR_INFO VI,
                                                                                                                          AP_SUPPLIERS        SU
                                                                                                                    WHERE VI.VENDOR_CODE =
                                                                                                                          SU.SEGMENT1)
                     SELECT V_INVOICE_ID,
                            SP.VENDOR_ID AS VENDOR_ID,
                            (CASE
                              WHEN A.ATTRIBUTE2 IS NULL THEN
                               NULL
                              ELSE
                               (SELECT HT.CONTRACT_ID
                                  FROM HT
                                 WHERE HT.CONTRACT_CODE = A.ATTRIBUTE2)
                            END) AS CONTRACT_ID,
                            (CASE
                              WHEN A.ATTRIBUTE5 IS NULL THEN
                               NULL
                              WHEN A.ATTRIBUTE5 = '00' THEN
                               NULL
                              ELSE
                               (SELECT P.PROJECT_ID
                                  FROM SPM_CON_PROJECT P
                                 WHERE P.PROJECT_CODE = A.ATTRIBUTE5)
                            END) AS PROJECT_ID,
                            A.DESCRIPTION AS INVOICE_CONTENT,
                            'B' AS INVOICE_TYPE,
                            A.INVOICE_NUM AS INVOICE_CODE,
                            A.INVOICE_AMOUNT AS INVOICE_AMOUNT,
                            'CNY' AS CURRENCY_TYPE,
                            (CASE A.INVOICE_TYPE_LOOKUP_CODE
                              WHEN 'STANDARD' THEN
                               'F'
                              WHEN 'PREPAYMENT' THEN
                               'I'
                            END) AS PAYMENT_STATUS,
                            0 AS VERIFIC_IMPREST_AMOUNT,
                            V_USER_ID AS CREATED_BY,
                            A.CREATION_DATE AS CREATION_DATE,
                            'E' AS STATUS,
                            A.ORG_ID AS ORG_ID,
                            SPM_CON_INVOICE_PKG.MEW_GET_APINVOICE_BALANCE_F(A.INVOICE_ID) AS RESIDUAL_AMOUNT,
                            A.INVOICE_DATE AS BILLING_DATE,
                            A.TERMS_ID AS PAYMENT_TERM,
                            A.PAYMENT_METHOD_CODE AS PAYMENT_TYPE,
                            A.INVOICE_TYPE_LOOKUP_CODE AS EBS_TYPE,
                            A.VENDOR_SITE_ID AS VENDOR_SITE_ID,
                            A.GL_DATE AS GL_DATE,
                            0 AS TAX_AMOUNT,
                            A.INVOICE_AMOUNT AS INVOICETAX_AMOUNT,
                            A.INVOICE_AMOUNT AS NOTAX_RESIDUAL_AMOUNT,
                            0 AS TAX_RATE,
                            'US' AS EBS_STATUS,
                            A.CREATION_DATE AS EBS_SYNC_DATE,
                            A.CREATION_DATE AS LAST_UPDATE_DATE,
                            A.ATTRIBUTE3 AS EBS_DEPT_CODE,
                            A.INVOICE_AMOUNT AS ORIGINAL_AMOUNT,
                            1 AS EXCHANGE_RATE,
                            A.INVOICE_ID AS EBS_ID,
                            V_USER_ID AS CREATE_ACCOUNT_BY,
                            V_DEPT_ID AS DEPT_ID
                     
                       FROM AP_INVOICES_ALL A, SP
                     
                      WHERE 1 = 1
                        AND SP.EBS_V_ID = A.VENDOR_ID
                        AND A.INVOICE_ID = IDS(I));
        
        
        EXCEPTION
          WHEN OTHERS THEN
            V_STATUS     := 'E';
            V_STATUS_DEC := '�������ݳ����쳣������ϵ����Ա';
            RETURN;
        END;
      ELSIF V_TYPE_CODE = 'TRANSACTIONS' THEN
        V_INVOICE_ID  := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
        V_INVOICE_IDS := V_INVOICE_IDS || ',' || V_INVOICE_ID;
      
        --�������Ʊ����
        BEGIN
          INSERT INTO SPM_CON_OUTPUT_INVOICE
            (OUTPUT_INVOICE_ID,
             INVOICE_TYPE,
             CONTRACT_ID,
             PROJECT_ID,
             CUST_ID,
             INVOICE_CODE,
             INVOICE_AMOUNT,
             RECEIVABLE_AMOUNT,
             RESIDUAL_AMOUNT,
             STATUS,
             ORG_ID,
             CREATED_BY,
             DEPT_ID,
             INVOICE_SOURCE,
             INVOICE_BILL,
             BILLING_DATE,
             EBS_SYNC_DATE,
             LAST_UPDATE_DATE,
             EBS_STATUS,
             EBS_PRODUCE,
             EBS_DEPT_CODE,
             EBS_VERIFIC_STATUS,
             IS_DISCOUNT,
             COST_TYPE,
             CREATE_ACCOUNT_BY,
             EBS_ID,
             INVOICE_SERIAL_NUMBER,
             CREATION_DATE,
             EBS_TYPE,
             TAXPAYER_ID_CODE)
            SELECT *
              FROM (WITH CUS AS (SELECT T.CUSTOMER_TRX_ID,
                                        SUM(TL.EXTENDED_AMOUNT) AS INVOICE_AMOUNT
                                 
                                   FROM RA_CUSTOMER_TRX_LINES_ALL TL,
                                        RA_CUSTOMER_TRX_ALL       T
                                  WHERE T.CUSTOMER_TRX_ID =
                                        TL.CUSTOMER_TRX_ID
                                    AND RPT_DIS_PKG.GET_TOTAL_BALANCE(T.CUSTOMER_TRX_ID) > 0
                                    AND T.ORG_ID = SPM_SSO_PKG.GETORGID
                                    AND NOT EXISTS
                                  (SELECT *
                                           FROM SPM_CON_OUTPUT_INVOICE I
                                          WHERE I.INVOICE_CODE = T.TRX_NUMBER)
                                  GROUP BY T.CUSTOMER_TRX_ID), HT AS (SELECT HI.CONTRACT_ID,
                                                                             HI.CONTRACT_CODE
                                                                        FROM SPM_CON_HT_INFO HI
                                                                       WHERE 1 = 1
                                                                         AND (HI.ATTRIBUTE4 = 'E' OR
                                                                             SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(HI.CONTRACT_ID) = 'Y')), SCU AS (SELECT C.CUST_ID,
                                                                                                                                                                 HCA.CUST_ACCOUNT_ID,
                                                                                                                                                                 HCA.ACCOUNT_NUMBER
                                                                                                                                                            FROM SPM_CON_CUST_INFO C,
                                                                                                                                                                 HZ_CUST_ACCOUNTS  HCA
                                                                                                                                                           WHERE C.CUST_CODE =
                                                                                                                                                                 HCA.ACCOUNT_NUMBER)
                   
                     SELECT V_INVOICE_ID,
                            CTT.NAME AS INVOICE_TYPE,
                            (CASE
                              WHEN RCTA.ATTRIBUTE6 IS NULL THEN
                               NULL
                              ELSE
                               (SELECT HT.CONTRACT_ID
                                  FROM HT
                                 WHERE HT.CONTRACT_CODE = RCTA.ATTRIBUTE6)
                            END) AS CONTRACT_ID,
                            (CASE
                              WHEN RCTA.ATTRIBUTE5 IS NULL THEN
                               NULL
                              WHEN RCTA.ATTRIBUTE5 = '00' THEN
                               NULL
                              ELSE
                               (SELECT P.PROJECT_ID
                                  FROM SPM_CON_PROJECT P
                                 WHERE P.PROJECT_CODE = RCTA.ATTRIBUTE5)
                            END) AS PROJECT_ID,
                            SCU.CUST_ID AS CUST_ID,
                            RCTA.TRX_NUMBER AS INVOICE_CODE,
                            CUS.INVOICE_AMOUNT,
                            (CUS.INVOICE_AMOUNT -
                            RPT_DIS_PKG.GET_TOTAL_BALANCE(CUS.CUSTOMER_TRX_ID)) AS RECEIVABLE_AMOUNT,
                            RPT_DIS_PKG.GET_TOTAL_BALANCE(CUS.CUSTOMER_TRX_ID) AS RESIDUAL_AMOUNT,
                            'N' AS STATUS,
                            RCTA.ORG_ID AS ORG_ID,
                            V_USER_ID AS CREATED_BY,
                            V_DEPT_ID AS DEPT_ID,
                            '�ֹ���Ʊ' AS INVOICE_SOURCE,
                            '��Ʊ' AS INVOICE_BILL,
                            RCTA.TRX_DATE AS BILLING_DATE,
                            RCTA.CREATION_DATE AS EBS_SYNC_DATE,
                            RCTA.CREATION_DATE AS LAST_UPDATE_DATE,
                            'US' AS EBS_STATUS,
                            RCTA.ATTRIBUTE7 AS EBS_PRODUCE,
                            RCTA.ATTRIBUTE2 AS EBS_DEPT_CODE,
                            'A' AS EBS_VERIFIC_STATUS,
                            'N' AS IS_DISCOUNT,
                            'N' AS COST_TYPECOST_TYPE,
                            V_USER_ID AS CREATE_ACCOUNT_BY,
                            RCTA.CUSTOMER_TRX_ID AS EBS_ID,
                            'QC' || RCTA.CUSTOMER_TRX_ID AS INVOICE_SERIAL_NUMBER,
                            RCTA.CREATION_DATE AS CREATION_DATE,
                            'INV',
                            SCU.ACCOUNT_NUMBER AS TAXPAYER_ID_CODE
                     
                       FROM CUS,
                            RA_CUSTOMER_TRX_ALL   RCTA,
                            RA_CUST_TRX_TYPES_ALL CTT,
                            SCU
                      WHERE CUS.CUSTOMER_TRX_ID = RCTA.CUSTOMER_TRX_ID
                        AND RCTA.CUST_TRX_TYPE_ID = CTT.CUST_TRX_TYPE_ID
                        AND CTT.TYPE = 'INV'
                        AND SCU.CUST_ACCOUNT_ID = RCTA.BILL_TO_CUSTOMER_ID
                        AND RCTA.CUSTOMER_TRX_ID = IDS(I));
        
        
        EXCEPTION
          WHEN OTHERS THEN
            V_STATUS     := 'E';
            V_STATUS_DEC := '�������ݳ����쳣������ϵ����Ա';
            RETURN;
          
        END;
      END IF;
    END LOOP;
    V_INVOICE_IDS := SUBSTR(V_INVOICE_IDS, 2);
  END SPM_CON_COPY_EBS_INVOICE;

  --����ѡ����Ʊʱ������ֻ�������Ŀ���ѡ��δͬ���ģ������ı���ͬ����������ƿ�Ŀ������ѡ��
  FUNCTION SPM_CON_INVOICE_PERMISSION(V_STATUS VARCHAR2) RETURN VARCHAR2 IS
    IS_EXISTS NUMBER;
  BEGIN
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM DUAL
     WHERE SPM_SSO_PKG.GETORGID IN (81, 82);
  
    IF IS_EXISTS = 0 THEN
      IF V_STATUS <> 'US' THEN
        RETURN 'N';
      END IF;
      RETURN 'Y';
    END IF;
    RETURN 'Y';
  
  END SPM_CON_INVOICE_PERMISSION;

  --��ѯӦ����Ʊ���
  FUNCTION MEW_GET_APINVOICE_BALANCE_F(P_INVOICE_ID NUMBER) RETURN NUMBER IS
    V_INVOICE_AMOUNT           NUMBER;
    V_PAYMENT_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT1          NUMBER;
    V_INVOICE_TYPE_LOOKUP_CODE VARCHAR2(30);
    V_FLAG                     VARCHAR2(10);
  BEGIN
    --1��Ʊ���
    SELECT AIA.INVOICE_AMOUNT, AIA.INVOICE_TYPE_LOOKUP_CODE
      INTO V_INVOICE_AMOUNT, V_INVOICE_TYPE_LOOKUP_CODE
      FROM AP_INVOICES_ALL AIA
     WHERE AIA.INVOICE_ID = P_INVOICE_ID;
    --2����������
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
  
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      --�ж�Ԥ���Ʊ�Ƿ��Ѿ��������Ѿ�������ֱ�ӷ���0
      SELECT NVL(A.PAYMENT_STATUS_FLAG, 'N'), A.INVOICE_AMOUNT
        INTO V_FLAG, V_PREPAID_AMOUNT
        FROM AP_INVOICES_ALL A
       WHERE A.INVOICE_ID = P_INVOICE_ID;
    
      IF V_FLAG <> 'Y' THEN
      
        --Ԥ���Ʊ������ͨ��Ʊ�Ľ��
        SELECT (-1) * SUM(AID1.AMOUNT) PREPAY_AMOUNT_APPLIED
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
      --��ͨ��Ʊ����Ԥ���Ʊ�Ľ��
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
    
      RETURN NVL(V_PAYMENT_AMOUNT, 0) - NVL(V_PREPAID_AMOUNT, 0);
    ELSE
      RETURN NVL(V_INVOICE_AMOUNT, 0) - NVL(V_PAYMENT_AMOUNT, 0) - NVL(V_PREPAID_AMOUNT,
                                                                       0);
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END;

  --��ȡ���������Ŀ�ܺ�ͬID���Ƕ�������ԭID��null
  FUNCTION GET_FRAME_ID(V_ID IN NUMBER) RETURN NUMBER IS
    V_TYPE      VARCHAR2(10);
    V_RETURN_ID NUMBER;
  BEGIN
    --��ѯ��ͬ����
    SELECT H.CONTRACT_TYPE
      INTO V_TYPE
      FROM SPM_CON_HT_INFO H
     WHERE H.CONTRACT_ID = V_ID;
    --��ͨ��ͬ
    IF V_TYPE = '1' THEN
      V_RETURN_ID := V_ID;
      --������ͬ������������Ŀ�ܺ�ͬID
    ELSE
      SELECT H.CONTRACT_ID
        INTO V_RETURN_ID
        FROM SPM_CON_HT_INFO H, SPM_CON_HT_RELATION R
       WHERE H.CONTRACT_ID = R.CONTRACT_ID_R
         AND R.CONTRACT_ID = V_ID
         AND H.CONTRACT_FORM = '4';
    END IF;
    RETURN V_RETURN_ID;
  
    --���쳣
  EXCEPTION
    WHEN OTHERS THEN
      RETURN V_ID;
  END GET_FRAME_ID;

  --��ȡ��ܺ�ͬ�����Ķ�����ͬID���Ƕ�������ԭID��null
  FUNCTION GET_ORDER_ID(V_ID IN NUMBER) RETURN VARCHAR2 IS
    V_TYPE       VARCHAR2(10);
    V_RETURN_IDS VARCHAR2(4000) := TO_CHAR(V_ID);
    V_RETURN_MSG VARCHAR2(4000);
  BEGIN
  
    SELECT LISTAGG(R.CONTRACT_ID, ',') WITHIN GROUP(ORDER BY R.CONTRACT_ID)
      INTO V_RETURN_MSG
      FROM SPM_CON_HT_INFO H, SPM_CON_HT_RELATION R
     WHERE H.CONTRACT_ID = R.CONTRACT_ID_R
       AND H.CONTRACT_TYPE = '2';
  
    IF V_RETURN_MSG <> '' THEN
      V_RETURN_IDS := TO_CHAR(V_ID) || ',' || V_RETURN_MSG;
    END IF;
  
    RETURN V_RETURN_IDS;
  
    --���쳣
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END GET_ORDER_ID;

  --����ָ���ѯ������ɹ���Ϣ
  PROCEDURE SPM_CON_QUERY_TRADE_APPLY(V_APPLY_CODE IN VARCHAR2) AS
    ID_NUM       NUMBER;
    J            INT := 1;
    I_APPLY_CODE VARCHAR2(200);
    V_PAYMENT_ID NUMBER(15);
  BEGIN
    -- ���㱻','�ָ���γɵ��ַ�������
    SELECT (LENGTH(V_APPLY_CODE) - LENGTH(REPLACE(V_APPLY_CODE, ',', '')) + 1)
      INTO ID_NUM
      FROM DUAL;
  
    -- ѭ������
    WHILE J <= ID_NUM LOOP
      -- ��ID�ַ������ݶ��ŷָ�
      SELECT TRIM(REGEXP_SUBSTR(V_APPLY_CODE, '[^,]+', 1, J))
        INTO I_APPLY_CODE
        FROM DUAL;
      J := J + 1;
    
      SELECT S.PAYMENT_ID
        INTO V_PAYMENT_ID
        FROM SPM_CON_TRANSFER_INSTRUCT S
       WHERE S.APPLY_CODE = I_APPLY_CODE;
    
      IF V_PAYMENT_ID IS NOT NULL THEN
        UPDATE SPM_CON_PAYMENT P
           SET P.PAY_STATUS = '2'
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;
        BEGIN
          SPM_CON_MQ_PKG.SPM_CON_PAYMENT_STATUS(O_PAYMENT_ID => V_PAYMENT_ID);
          --���쳣
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR CODE = ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('ERROR MESSAGE = ' || SQLERRM);
        END;
      END IF;
    END LOOP;
  END;
  --�������ϱ�� ��֯id�Զ���ȡ˰�շ������
  FUNCTION GET_TAX_CODE(V_MATERIAL_CODE VARCHAR2, V_ORG_ID NUMBER)
    RETURN VARCHAR2 IS
    V_TAX_ID   NUMBER(15);
    V_NUMBER   NUMBER;
    V_TAX_CODE VARCHAR2(20);
  BEGIN
    --�������ϱ�� ��֯id��ѯ˰�շ������
    SELECT COUNT(D.TAX_ID)
      INTO V_NUMBER
      FROM SPM_CON_TAX_CODE_DEL D
     WHERE D.MATERIAL_CODE = V_MATERIAL_CODE
       AND D.ORG_ID = V_ORG_ID;
    IF V_NUMBER = 1 THEN
      SELECT D.TAX_ID
        INTO V_TAX_ID
        FROM SPM_CON_TAX_CODE_DEL D
       WHERE D.MATERIAL_CODE = V_MATERIAL_CODE
         AND D.ORG_ID = V_ORG_ID;
      SELECT C.TAX_CODE
        INTO V_TAX_CODE
        FROM SPM_CON_TAX_CODE C
       WHERE C.TAX_ID = V_TAX_ID;
    ELSE
      V_TAX_CODE := '';
    END IF;
    RETURN V_TAX_CODE;
  END GET_TAX_CODE;
  
  --���ݳ��ⵥ�������Ʊ ������˾������ 20190524rkk
  PROCEDURE GENERATE_ODOS_INVOICE(V_IDS        IN VARCHAR2,
                                  V_RETURN_MSG OUT VARCHAR2) IS
    IDS            SPM_TYPE_TBL;
    V_USER_ID      NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID       NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID      NUMBER;
    V_CODE_PRE     VARCHAR2(40);
    V_INVOICE_TYPE VARCHAR2(40);
    N_CUST_ID      NUMBER;
    NEW_CUST_CODE  VARCHAR2(40);
    V_OUTPUT_INVOICE_ID NUMBER;
    V_SERIAL_NUMBER     VARCHAR2(40);
  BEGIN
    --0.�ж���֯
    IF V_ORG_ID <> 87 THEN
      V_RETURN_MSG := '�Ǳ�����˾�����ڴ˲���';
      RETURN;
    END IF;
  
    -- ������Ϣ  ԭ�з���ʹ�õ���personid�����ر����
    SELECT T.ORGANIZATION_ID
      INTO V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = V_ORG_ID
       AND T.USER_ID = V_USER_ID;
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_OUT_INVOICE_CODE');
  
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        --1.��ȡ��Ʊ����
        select R.INVOICE_TYPE
          INTO V_INVOICE_TYPE
          from SPM_CON_ODO O, SPM_CON_MQ_SM_SALE_ORDER R
         WHERE O.CONTRACT_CODE = R.ORDER_CODE
           AND ROWNUM = 1
           AND O.ODO_ID = IDS(I);
      
        IF V_INVOICE_TYPE = '1' THEN
          V_INVOICE_TYPE := '2';
        ELSIF V_INVOICE_TYPE = '2' THEN
          V_INVOICE_TYPE := '0';
        END IF;
      
        -- ���������к�
        V_OUTPUT_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
        V_SERIAL_NUMBER     := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_OUTPUT_INVOICE',
                                                                  'INVOICE_SERIAL_NUMBER',
                                                                  'FM000000',
                                                                  V_CODE_PRE);
      
        --��ȡ�ͻ�����                                                        
        select M.MERCHANTS_ID
          INTO N_CUST_ID
          from SPM_CON_HT_MERCHANTS M, SPM_CON_ODO F
         WHERE M.CONTRACT_ID = F.CONTRACT_ID
           AND F.ODO_ID = IDS(I);
        --��ѯ�����ֵ�����Ƿ�ά�����µ�����˰�� 
        BEGIN
          SELECT T.ATTRABUTE2
            INTO NEW_CUST_CODE
            FROM SPM_DICT_TYPE TY, SPM_DICT T
           WHERE TY.TYPE_CODE = 'SPM_CON_CUST_CODE'
             AND TY.DICT_TYPE_ID = T.DICT_TYPE_ID
             AND T.ORG_ID = V_ORG_ID || ''
             AND T.ATTRABUTE1 = N_CUST_ID || '';
        EXCEPTION
          WHEN OTHERS THEN
            NEW_CUST_CODE := NULL;
        END;
      
        --��������
        INSERT INTO SPM_CON_OUTPUT_INVOICE
          (OUTPUT_INVOICE_ID,
           CONTRACT_ID,
           INVOICE_TYPE,
           PROJECT_ID,
           CUST_ID,
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
           STATUS,
           EBS_STATUS,
           EBS_TYPE,
           IS_DISCOUNT,
           COST_TYPE,
           INVOICE_SOURCE,
           INVOICE_BILL,
           OWNED_GROUP,
           INVOICE_SERIAL_NUMBER,
           DS_FLAG,
           REMARK,
           INVOICE_CATEGORY,
           INVOICE_AMOUNT)
          SELECT V_OUTPUT_INVOICE_ID,
                 H.CONTRACT_ID,
                 '��Ӫҵ�����',
                 P.PROJECT_ID,
                 M.MERCHANTS_ID,
                 I.INVOICE_BANK || ' ' || I.INVOICE_ACCOUNT,
                 I.INVOICE_ACCOUNT,
                 NVL(NEW_CUST_CODE, I.INVOICE_RATE_NUMBER),
                 I.INVOICE_ADDRESS || ' ' || I.INVOICE_TEL,
                 I.INVOICE_TEL,
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE,
                 'A',
                 'N',
                 'INV',
                 'N',
                 'N',
                 '�ֹ���Ʊ',
                 '��Ʊ',
                 1,
                 V_SERIAL_NUMBER,
                 'Y',
                 H.CONTRACT_CODE,
                 V_INVOICE_TYPE, --���Ʊ����
                 (SELECT NVL(SUM(T.TAX_AMOUNT_COUNT), 0)
                    FROM SPM_CON_ODO_DL T
                   WHERE T.ODO_ID = IDS(I))
            FROM SPM_CON_HT_INFO      H,
                 SPM_CON_HT_PROJECT   P,
                 SPM_CON_HT_MERCHANTS M,
                 SPM_CON_HT_INVOICE   I,
                 SPM_CON_ODO          O
           WHERE O.ODO_ID = IDS(I)
             AND O.CONTRACT_ID = H.CONTRACT_ID
             AND H.CONTRACT_ID = P.CONTRACT_ID
             AND H.CONTRACT_ID = M.CONTRACT_ID
             AND H.CONTRACT_ID = I.CONTRACT_ID;
             
      --�����ӱ�
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
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           TAX_CODE)
          SELECT SPM_CON_OUTPUT_ITEM_SEQ.NEXTVAL,
                 V_OUTPUT_INVOICE_ID,
                 T.MATERIAL_CODE,
                 T.UNIT,
                 h.specification_model,
                 T.THIS_ODO_NUMBER,
                 T.TAX_ODO_UNIT_PRICE,
                 T.TAX_AMOUNT_COUNT,
                 T.TAX_RATE,
                 T.TAX_AMOUNT,
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE,
                 GET_TAX_CODE(T.MATERIAL_CODE, V_ORG_ID)
            FROM SPM_CON_ODO_DL T,Spm_Con_Ht_Target h 
           WHERE  T.ODO_ID = IDS(I)
           and t.target_id = h.target_id(+);
           
      --���䣺����������ⵥ by mcq
        INSERT INTO SPM_CON_OUTPUT_ODO
          (OUTPUT_ODO_ID,
           OUTPUT_INVOICE_ID,
           ODO_ID,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE)
          SELECT SPM_CON_OUTPUT_ODO_SEQ.NEXTVAL,
                 V_OUTPUT_INVOICE_ID,
                 IDS(I),
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE
            FROM DUAL;
            
      --��־�Ѿ����������Ʊ
      UPDATE SPM_CON_ODO O
         SET O.ATTRIBUTE3 = V_OUTPUT_INVOICE_ID
       WHERE O.ODO_ID = IDS(I);
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_MSG := 'ѭ�����ɷ�Ʊ�����쳣:' || IDS(I);
          RETURN;
      END;
    END LOOP;
    
    --ȫ��ѭ��ִ�����,���쳣,����Y
    V_RETURN_MSG :='Y';
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_MSG := '���̷����쳣';
      RETURN;
    
  END GENERATE_ODOS_INVOICE;

  /*���ݶ����������Ʊ*/
  PROCEDURE GENERATE_ORDERS_INVOICE(V_IDS         IN VARCHAR2,
                                    V_RETURN_CODE OUT VARCHAR2,
                                    V_RETURN_MSG  OUT VARCHAR2) IS
    IDS                 SPM_TYPE_TBL;
    V_CODE              VARCHAR2(40);
    V_USER_ID           NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID            NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID           NUMBER;
    V_OUTPUT_INVOICE_ID NUMBER;
    V_SERIAL_NUMBER     VARCHAR2(40);
    V_CODE_PRE          VARCHAR2(40);
    NEW_CUST_CODE       VARCHAR2(40);
    N_CUST_ID           NUMBER;
    V_INVOICE_TYPE      VARCHAR2(40);
  
  BEGIN
    -- ������Ϣ
    SELECT T.ORGANIZATION_ID
      INTO V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = V_ORG_ID
       AND T.PERSON_ID =
           SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(V_USER_ID);
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
  
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_OUT_INVOICE_CODE');
  
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        SELECT M.CONTRACT_CODE
          INTO V_CODE
          FROM SPM_CON_HT_INFO M
         WHERE M.CONTRACT_ID = IDS(I);
      
        --add by ruankk 2019-01-17 to do ���ӿ�Ʊ����
        --ҵ��ϵͳ רƱ0 ��Ʊ2
        --����ϵͳ רƱ2 ��Ʊ1
      
        SELECT NVL(O.INVOICE_TYPE, '0')
          INTO V_INVOICE_TYPE
          FROM SPM_CON_MQ_SM_SALE_ORDER O
         WHERE O.ORDER_CODE = V_CODE;
      
        IF V_INVOICE_TYPE = '1' THEN
          V_INVOICE_TYPE := '2';
        ELSIF V_INVOICE_TYPE = '2' THEN
          V_INVOICE_TYPE := '0';
        END IF;
      
        -- ���������к�
        V_OUTPUT_INVOICE_ID := SPM_CON_OUTPUT_INVOICE_SEQ.NEXTVAL;
        V_SERIAL_NUMBER     := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_OUTPUT_INVOICE',
                                                                  'INVOICE_SERIAL_NUMBER',
                                                                  'FM000000',
                                                                  V_CODE_PRE);
      
        --��ȡ�ͻ�����                                                        
        select M.MERCHANTS_ID
          INTO N_CUST_ID
          from SPM_CON_HT_MERCHANTS M, SPM_CON_HT_INFO F
         WHERE M.CONTRACT_ID = F.CONTRACT_ID
           AND M.CONTRACT_ID = IDS(I);
        --��ѯ�����ֵ�����Ƿ�ά�����µ�����˰�� 
        BEGIN
          SELECT T.ATTRABUTE2
            INTO NEW_CUST_CODE
            FROM SPM_DICT_TYPE TY, SPM_DICT T
           WHERE TY.TYPE_CODE = 'SPM_CON_CUST_CODE'
             AND TY.DICT_TYPE_ID = T.DICT_TYPE_ID
             AND T.ORG_ID = V_ORG_ID || ''
             AND T.ATTRABUTE1 = N_CUST_ID || '';
        EXCEPTION
          WHEN OTHERS THEN
            NEW_CUST_CODE := NULL;
        END;
      
        INSERT INTO SPM_CON_OUTPUT_INVOICE
          (OUTPUT_INVOICE_ID,
           CONTRACT_ID,
           INVOICE_TYPE,
           PROJECT_ID,
           CUST_ID,
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
           STATUS,
           EBS_STATUS,
           EBS_TYPE,
           IS_DISCOUNT,
           COST_TYPE,
           INVOICE_SOURCE,
           INVOICE_BILL,
           OWNED_GROUP,
           INVOICE_SERIAL_NUMBER,
           DS_FLAG,
           REMARK,
           INVOICE_CATEGORY,
           INVOICE_AMOUNT)
          SELECT V_OUTPUT_INVOICE_ID,
                 H.CONTRACT_ID,
                 '��Ӫҵ�����',
                 P.PROJECT_ID,
                 M.MERCHANTS_ID,
                 I.INVOICE_BANK || ' ' || I.INVOICE_ACCOUNT,
                 I.INVOICE_ACCOUNT,
                 NVL(NEW_CUST_CODE, I.INVOICE_RATE_NUMBER),
                 I.INVOICE_ADDRESS || ' ' || I.INVOICE_TEL,
                 I.INVOICE_TEL,
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE,
                 'A',
                 'N',
                 'INV',
                 'N',
                 'N',
                 '�ֹ���Ʊ',
                 '��Ʊ',
                 1,
                 V_SERIAL_NUMBER,
                 'Y',
                 H.CONTRACT_CODE,
                 V_INVOICE_TYPE, --���Ʊ����
                 (SELECT NVL(SUM(T.TARGET_AMOUNT), 0)
                    FROM SPM_CON_HT_TARGET T
                   WHERE T.CONTRACT_ID = H.CONTRACT_ID)
            FROM SPM_CON_HT_INFO      H,
                 SPM_CON_HT_PROJECT   P,
                 SPM_CON_HT_MERCHANTS M,
                 SPM_CON_HT_INVOICE   I
           WHERE H.CONTRACT_ID = IDS(I)
             AND H.ONLINE_RETAILERS = 'DSXS'
             AND SPM_CON_CONTRACT_PKG.GET_EFFECTIVE_CONTRACT(H.CONTRACT_ID) = 'Y'
             AND H.CONTRACT_ID = P.CONTRACT_ID
             AND H.CONTRACT_ID = M.CONTRACT_ID
             AND H.CONTRACT_ID = I.CONTRACT_ID
             AND M.IN_OUT_TYPE = '1';
      
        /* �Ƴ�����ӵ���insert ����� by mcq 20190218
        IF NEW_CUST_CODE IS NOT NULL THEN
        
          UPDATE SPM_CON_OUTPUT_INVOICE C
             SET C.TAXPAYER_ID_CODE = NEW_CUST_CODE
           WHERE C.OUTPUT_INVOICE_ID = V_OUTPUT_INVOICE_ID;
        
        END IF;*/
      
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
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           TAX_CODE)
          SELECT SPM_CON_OUTPUT_ITEM_SEQ.NEXTVAL,
                 V_OUTPUT_INVOICE_ID,
                 T.MATERIAL_CODE,
                 T.TARGET_UNIT,
                 T.SPECIFICATION_MODEL,
                 T.TARGET_COUNT,
                 T.UNIT_PRICE,
                 T.TARGET_AMOUNT,
                 T.TAX_RATE,
                 T.TAX_AMOUNT,
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE,
                 GET_TAX_CODE(T.MATERIAL_CODE, V_ORG_ID)
            FROM SPM_CON_HT_TARGET T
           WHERE T.IS_DELETE = 0
             AND T.CONTRACT_ID = IDS(I);
      
        --���䣺����������ⵥ by mcq
        INSERT INTO SPM_CON_OUTPUT_ODO
          (OUTPUT_ODO_ID,
           OUTPUT_INVOICE_ID,
           ODO_ID,
           CREATED_BY,
           ORG_ID,
           DEPT_ID,
           CREATION_DATE,
           LAST_UPDATE_DATE)
          SELECT SPM_CON_OUTPUT_ODO_SEQ.NEXTVAL,
                 V_OUTPUT_INVOICE_ID,
                 o.odo_id,
                 V_USER_ID,
                 V_ORG_ID,
                 V_DEPT_ID,
                 SYSDATE,
                 SYSDATE
            FROM SPM_CON_ODO O
           where O.ATTRIBUTE5 = 'Y'
             AND O.CONTRACT_ID = IDS(I);
      
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
      V_RETURN_MSG := '���Ϊ' || V_RETURN_MSG || '�ĺ�ͬ���ɷ�Ʊʧ��';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '����ִ���쳣';
  END GENERATE_ORDERS_INVOICE;

  --���������жϵ�ǰ�������뵥�Ƿ����ϻ�
  FUNCTION JUDGET_IS_MEETING(V_PAYMENT_ID VARCHAR2, V_WEATHER_DZ VARCHAR2)
    RETURN VARCHAR2 IS
    IS_EXISTS       NUMBER;
    IS_PAYABLE      VARCHAR2(10) DEFAULT 'N'; --Ĭ��ΪԤ��
    V_IS_MEETING    VARCHAR2(40) DEFAULT 'N'; --Ĭ��Ϊ����Ҫ�ϻ�
    V_CAPITAL_QUOTA NUMBER; --�����ʽ�ƻ����
    V_PAY_AMOUNT    NUMBER;
    V_ID            NUMBER(15);
  BEGIN
    --��ǰ̨�����ID�ַ�������
    SELECT TO_NUMBER(V_PAYMENT_ID) INTO V_ID FROM DUAL;
    SELECT P.MONEY_AMOUNT
      INTO V_PAY_AMOUNT
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_ID;
  
    --1.�ж���Ӧ���˿��Ԥ��
    IS_PAYABLE := JUDGET_IS_PAYABLE(V_ID);
  
    --2.����Ӧ����Ԥ���ж��Ƿ���Ҫ�ϻ�
    IF IS_PAYABLE <> 'N' THEN
      --�����Ӧ������Ҫ�ڱȽ��ʽ�ƻ����
      --change by ruankk   ���ҵ���ʣ���ȣ����Ǽƻ����
      SELECT CP.THIS_MONTH_BALANCE
        INTO V_CAPITAL_QUOTA
        FROM SPM_CON_PAYMENT P, SPM_CON_CAPITAL_PLAN CP
       WHERE P.MONTH_DETAIL_ID = CP.CAPITAL_ID
         AND P.PAYMENT_ID = V_ID;
      IF V_CAPITAL_QUOTA < V_PAY_AMOUNT THEN
        --����������ʽ�ƻ���ȣ�����Ҫ�ϻ�
        V_IS_MEETING := 'Y';
      ELSE
        --���δ�����ʽ�ƻ���ȣ����������������Ҫ�ϻ�
        IF V_PAY_AMOUNT < 5000000 THEN
          V_IS_MEETING := 'N';
        ELSE
          V_IS_MEETING := 'Y';
        END IF;
      END IF;
    
    ELSE
      --Ԥ��
    
      --�����Ԥ�����ж��Ƿ���ʣ����ʵĻ��ϻᣬ�������ٽ�����Ӧ���ж�
      IF V_WEATHER_DZ = 'Y' THEN
        V_IS_MEETING := 'Y';
      ELSE
        SELECT CP.THIS_MONTH_BALANCE
          INTO V_CAPITAL_QUOTA
          FROM SPM_CON_PAYMENT P, SPM_CON_CAPITAL_PLAN CP
         WHERE P.MONTH_DETAIL_ID = CP.CAPITAL_ID
           AND P.PAYMENT_ID = V_ID;
        IF V_CAPITAL_QUOTA < V_PAY_AMOUNT THEN
          --����������ʽ�ƻ���ȣ�����Ҫ�ϻ�
          V_IS_MEETING := 'Y';
        ELSE
          --���δ�����ʽ�ƻ���ȣ����������������Ҫ�ϻ�
          IF V_PAY_AMOUNT < 5000000 THEN
            V_IS_MEETING := 'N';
          ELSE
            V_IS_MEETING := 'Y';
          END IF;
        END IF;
      END IF;
    
    END IF;
  
    RETURN V_IS_MEETING;
  
  END JUDGET_IS_MEETING;

  --���������жϵ�ǰ�������뵥��Ӧ������Ԥ��
  FUNCTION JUDGET_IS_PAYABLE(V_ID NUMBER) RETURN VARCHAR2 IS
    IS_EXISTS      NUMBER;
    IS_PAYABLE     VARCHAR2(10) := 'N'; --Ĭ��ΪԤ��
    SYS_SUM_AMOUNT NUMBER DEFAULT 0; --ϵͳ���
    V_MONEY_AMOUNT NUMBER DEFAULT 0; --����������
    V_RES_AMOUNT   NUMBER DEFAULT 0; --�ȽϽ��
  
  BEGIN
    --��ȡϵͳ���
    SYS_SUM_AMOUNT := GET_PAYABLE_UNPAYABLE_BY_ID(V_ID, 3);
  
    --��ñ��θ�����
    SELECT P.MONEY_AMOUNT
      INTO V_MONEY_AMOUNT
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_ID;
  
    --�Ƚ����������ϵͳ���С�ڱ��θ��������Ԥ��������ΪӦ��
    V_RES_AMOUNT := NVL(SYS_SUM_AMOUNT, 0) - NVL(V_MONEY_AMOUNT, 0);
    IF V_RES_AMOUNT < 0 THEN
      IS_PAYABLE := 'N';
    ELSE
      IS_PAYABLE := 'Y';
    END IF;
  
    RETURN IS_PAYABLE;
  END JUDGET_IS_PAYABLE;

  --�����ʽ�ʣ����
  PROCEDURE REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID NUMBER, V_TYPE VARCHAR2) IS
    IS_EXISTS            NUMBER;
    V_PAY_AMOUNT         NUMBER; --������
    V_SUM_AMOUNT         NUMBER; --���ܺ������
    V_CAPITAL_QUOTA      NUMBER; --�ʽ���
    V_THIS_MONTH_BALANCE NUMBER; --ʣ����
    V_CAPITAL_ID         NUMBER(15);
    V_ADD_AMOUNT         VARCHAR2(50); --��¼7�� 1-15�Ÿ�����
  BEGIN
    --��ѯ��Ӧ�ʽ���ID���������
     SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_CAPITAL_PLAN CP, SPM_CON_PAYMENT P
     WHERE 1 = 1
       AND P.PAYMENT_ID = V_PAYMENT_ID
       AND CP.CAPITAL_ID = SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(P.DEPT_ID);
    IF IS_EXISTS = 0 THEN   
       RETURN;
    END IF;
    
    --20190418����Ĭ�ϵ�ǰʱ�䣬��ǰ���ſ϶������ʽ�ƻ�����Ϊ�����ťʱ�Ѿ�У��
    SELECT CP.CAPITAL_ID,
           P.CANCEL_AMOUNT, --��Ϊ���պ��������ȡֵ
           CP.CAPITAL_QUOTA,
           TO_NUMBER(CP.ATTRIBUTE5)
      INTO V_CAPITAL_ID, V_PAY_AMOUNT, V_CAPITAL_QUOTA, V_ADD_AMOUNT
      FROM SPM_CON_CAPITAL_PLAN CP, SPM_CON_PAYMENT P
     WHERE 1 = 1
       AND P.PAYMENT_ID = V_PAYMENT_ID
       AND CP.CAPITAL_ID = SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(P.DEPT_ID);
  
    IF V_TYPE = 'A' THEN
      --�������м�����һ������
      INSERT INTO SPM_CON_CAPITAL_PLAN_DEL
        (DEL_ID,
         CAPITAL_ID,
         ORG_ID,
         TYPE_CODE,
         MONEY_AMOUNT,
         JOB_ID,
         CREATION_DATE)
      VALUES
        (SPM_CON_CAPITAL_PLAN_DEL_SEQ.NEXTVAL,
         V_CAPITAL_ID,
         SPM_SSO_PKG.GETORGID,
         'SPM_CON_PLAN_PAYMENT',
         V_PAY_AMOUNT,
         V_PAYMENT_ID,
         SYSDATE);
    ELSIF V_TYPE = 'D' THEN
    
      DELETE FROM SPM_CON_CAPITAL_PLAN_DEL DL
       WHERE DL.JOB_ID = V_PAYMENT_ID
         AND DL.TYPE_CODE = 'SPM_CON_PLAN_PAYMENT';
    ELSIF V_TYPE = 'C' THEN
    
      UPDATE SPM_CON_CAPITAL_PLAN_DEL DL
         SET DL.MONEY_AMOUNT = V_PAY_AMOUNT
       WHERE DL.JOB_ID = V_PAYMENT_ID
         AND DL.TYPE_CODE = 'SPM_CON_PLAN_PAYMENT';
    END IF;
  
    SELECT NVL(SUM(P.MONEY_AMOUNT),0)
      INTO V_SUM_AMOUNT
      FROM SPM_CON_CAPITAL_PLAN_DEL P
     WHERE 1 = 1
       AND P.CAPITAL_ID = V_CAPITAL_ID;
  
    --����ʣ���� : �ʽ��� - ֧����ȣ�������;��
    V_THIS_MONTH_BALANCE := V_CAPITAL_QUOTA - V_SUM_AMOUNT - V_ADD_AMOUNT;
  
    UPDATE SPM_CON_CAPITAL_PLAN C
       SET C.THIS_MONTH_BALANCE = V_THIS_MONTH_BALANCE,
           C.PAY_AMOUNT         = V_SUM_AMOUNT
     WHERE C.CAPITAL_ID = V_CAPITAL_ID;
  
  END REFRESH_CAPITAL_QUOTA;

  --��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  FUNCTION FINANCE_DEPT_PERMISSION(V_HT_DEPT NUMBER) RETURN SPM_TYPE_TBL IS
    IS_EXISTS NUMBER;
    --�����ʼ��������ᱨ����δ��ʼ�����ռ�
    IDS SPM_TYPE_TBL := SPM_TYPE_TBL();
    TYPE FLEX_TAB IS TABLE OF FND_FLEX_VALUES_VL%ROWTYPE;
    MY_FLEX FLEX_TAB;
    V_COUNT NUMBER DEFAULT 0;
    CURSOR CUR(V_HT_DEPT NUMBER) IS
      SELECT V.*
        FROM HR_ALL_ORGANIZATION_UNITS S,
             FND_FLEX_VALUES_VL        V,
             FND_FLEX_VALUE_SETS       F
       WHERE S.ORGANIZATION_ID = V_HT_DEPT
         AND S.ATTRIBUTE6 IS NOT NULL
         AND V.FLEX_VALUE LIKE S.ATTRIBUTE6 || '%'
         AND F.FLEX_VALUE_SET_ID = V.FLEX_VALUE_SET_ID
         AND F.FLEX_VALUE_SET_NAME = 'DT ����'
         AND V.ENABLED_FLAG = 'Y'
         AND V.SUMMARY_FLAG = 'N'
         AND V.COMPILED_VALUE_ATTRIBUTES NOT LIKE '%N%';
  BEGIN
  
    --���ݺ�ͬ������ѯ�����Ŷζ��ڴ���
    OPEN CUR(V_HT_DEPT);
    LOOP
      FETCH CUR BULK COLLECT
        INTO MY_FLEX;
      FOR I IN 1 .. MY_FLEX.COUNT LOOP
        --��չ�ռ䣬����ᱨָ��Խ��        
        IDS.EXTEND;
        IDS(I) := MY_FLEX(I).FLEX_VALUE;
        V_COUNT := I;
      END LOOP;
      EXIT WHEN CUR%NOTFOUND;
    END LOOP;
    --����00��ֵ
    IDS.EXTEND;
    IDS(V_COUNT + 1) := '00';
    RETURN IDS;
  
  END FINANCE_DEPT_PERMISSION;

  --���ݴ���code��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  FUNCTION FINANCE_DEPT_PERMISSION_B(V_HT_DEPT_B VARCHAR2)
    RETURN SPM_TYPE_TBL IS
    IS_EXISTS NUMBER;
    --�����ʼ��������ᱨ����δ��ʼ�����ռ�
    IDS SPM_TYPE_TBL := SPM_TYPE_TBL();
    TYPE FLEX_TAB IS TABLE OF FND_FLEX_VALUES_VL%ROWTYPE;
    MY_FLEX FLEX_TAB;
    V_COUNT NUMBER DEFAULT 0;
    CURSOR CUR(V_HT_DEPT_B VARCHAR2) IS
      SELECT V.*
        FROM FND_FLEX_VALUES_VL V, FND_FLEX_VALUE_SETS F
       WHERE V.FLEX_VALUE LIKE V_HT_DEPT_B || '%'
         AND F.FLEX_VALUE_SET_ID = V.FLEX_VALUE_SET_ID
         AND F.FLEX_VALUE_SET_NAME = 'DT ����'
         AND V.ENABLED_FLAG = 'Y'
         AND V.SUMMARY_FLAG = 'N'
         AND V.COMPILED_VALUE_ATTRIBUTES NOT LIKE '%N%';
  
  BEGIN
    IF V_HT_DEPT_B <> '00' THEN
      --���ݺ�ͬ������ѯ�����Ŷζ��ڴ���
      OPEN CUR(V_HT_DEPT_B);
      LOOP
        FETCH CUR BULK COLLECT
          INTO MY_FLEX;
        FOR I IN 1 .. MY_FLEX.COUNT LOOP
          --��չ�ռ䣬����ᱨָ��Խ��        
          IDS.EXTEND;
          IDS(I) := MY_FLEX(I).FLEX_VALUE;
          V_COUNT := I;
        END LOOP;
        EXIT WHEN CUR%NOTFOUND;
      END LOOP;
      RETURN IDS;
    END IF;
  
    --��������00��ֵ by mcq 20180816
    IDS.EXTEND;
    IDS(V_COUNT + 1) := '00';
    RETURN IDS;
  
  END FINANCE_DEPT_PERMISSION_B;

  --���ݴ���code��ѯ��ͬ�ಿ�Ŷ�ӦEBS������������в��Ŷ�ֵ
  --���⴦������Э�Ͳִ�ʱ��ȡ����
  FUNCTION FINANCE_DEPT_PERMISSION_T(V_HT_DEPT_B VARCHAR2)
    RETURN SPM_TYPE_TBL IS
    IS_EXISTS NUMBER;
    --�����ʼ��������ᱨ����δ��ʼ�����ռ�
    IDS   SPM_TYPE_TBL := SPM_TYPE_TBL();
    DEPTS SPM_TYPE_TBL := SPM_TYPE_TBL();
    TYPE FLEX_TAB IS TABLE OF FND_FLEX_VALUES_VL%ROWTYPE;
    MY_FLEX FLEX_TAB;
    V_COUNT NUMBER DEFAULT 1;
    CURSOR CUR(V_HT_DEPT_B VARCHAR2) IS
      SELECT V.*
        FROM FND_FLEX_VALUES_VL V, FND_FLEX_VALUE_SETS F
       WHERE V.FLEX_VALUE LIKE V_HT_DEPT_B || '%'
         AND F.FLEX_VALUE_SET_ID = V.FLEX_VALUE_SET_ID
         AND F.FLEX_VALUE_SET_NAME = 'DT ����'
            --AND V.ENABLED_FLAG = 'Y' ����ƥ����Լ�����ʧЧ���ŵķ�Ʊ
         AND V.SUMMARY_FLAG = 'N'
         AND V.COMPILED_VALUE_ATTRIBUTES NOT LIKE '%N%';
  BEGIN
  
    IF V_HT_DEPT_B = '10000616A3' OR V_HT_DEPT_B = '10001438' THEN
      DEPTS.EXTEND;
      DEPTS(1) := '10000616A3';
      DEPTS.EXTEND;
      DEPTS(2) := '10001438';
    ELSE
      DEPTS.EXTEND;
      DEPTS(1) := V_HT_DEPT_B;
    END IF;
  
    FOR I IN 1 .. DEPTS.COUNT LOOP
    
      FOR REC IN CUR(DEPTS(I)) LOOP
        --��չ�ռ䣬����ᱨָ��Խ��        
        IDS.EXTEND;
        IDS(V_COUNT) := REC.FLEX_VALUE;
        V_COUNT := V_COUNT + 1;
      END LOOP;
    
    END LOOP;
    IDS.EXTEND;
    IDS(IDS.COUNT) := '00';
    RETURN IDS;
  
  END FINANCE_DEPT_PERMISSION_T;

  --���ݸ��ID���ض�ӦEBS��ID
  FUNCTION GET_EBS_PAYMENT_ID(V_ID VARCHAR2) RETURN VARCHAR2 IS
    IS_EXISTS NUMBER;
    V_FLAG    VARCHAR2(4000);
    V_EBS_IDS VARCHAR2(4000);
  BEGIN
  
    SELECT TO_CHAR(P.EBS_ID), NVL(P.PLAN_FLAG, 'N')
      INTO V_EBS_IDS, V_FLAG
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_ID;
  
    IF V_FLAG = 'Y' THEN
    
      SELECT LISTAGG(C.EBS_ID, ',') WITHIN GROUP(ORDER BY C.PAYMENT_CHILD_ID)
        INTO V_EBS_IDS
        FROM SPM_CON_PAYMENT P, SPM_CON_PAYMENT_CHILD C
       WHERE P.PAYMENT_ID = C.PAYMENT_ID
         AND P.PAYMENT_ID = V_ID;
    END IF;
  
    RETURN V_EBS_IDS;
  END;

  --����ȡ���ʽ������
  PROCEDURE BATCH_CANCEL_PAYMENT(V_IDS         IN VARCHAR2,
                                 V_CANCEL_TIME IN DATE,
                                 V_STATUS      OUT VARCHAR2,
                                 V_REASON      OUT VARCHAR2) IS
    IDS                     SPM_TYPE_TBL;
    V_CHILD_EBS_ID          NUMBER;
    V_COUNT                 NUMBER;
    X_STATUS                VARCHAR2(40);
    X_REASON                VARCHAR2(4000);
    V_PAYMENT_CANCEL_STATUS VARCHAR2(40);
    P_MSG                   VARCHAR(400);
    V_GL_DATE    DATE;
  
    CURSOR CUR1(V_PAYMENT_ID NUMBER) IS
      SELECT C.EBS_ID,
             C.PAYMENT_CODE,
             C.PAYMENT_CHILD_ID,
             ACA.CHECK_ID,
             ACA.ORG_ID,
             ACA.ATTRIBUTE1,
             ACA.ATTRIBUTE2,
             ACA.ATTRIBUTE4,
             ACA.AMOUNT,
             ACA.EXCHANGE_RATE,
             C.PAY_BANK_ACCOUNT_ID
        FROM SPM_CON_PAYMENT       P,
             SPM_CON_PAYMENT_CHILD C,
             AP.AP_CHECKS_ALL      ACA
       WHERE P.PAYMENT_ID = V_PAYMENT_ID
         AND C.PAYMENT_ID = P.PAYMENT_ID
         AND C.EBS_ID = ACA.CHECK_ID
         AND C.STATUS = 'US';
    REC1 CUR1%ROWTYPE;
  BEGIN
    V_STATUS := 'S';
    --����
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    FOR I IN 1 .. IDS.COUNT LOOP
      V_PAYMENT_CANCEL_STATUS := 'S';
      OPEN CUR1(IDS(I));
      FETCH CUR1
        INTO REC1;
    
      WHILE CUR1%FOUND LOOP
        /*�ʽ�ƻ�����У��20190426 by mcq start*/
        IF REC1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
          --1.�жϵ�ǰ����Ƿ�������Ǵ���֪ͨ������������Ϊ����,ATTRIBUTE2(�ʽ�ʹ����Ŀ)
          IF REC1.AMOUNT < 0 AND NVL(REC1.ATTRIBUTE2, '0') <> '0' THEN
            DELETE FROM CUX.CUX_CP_FACT_ALL CCF
             WHERE CCF.SOURCE = 'AP_ZS_CHECK'
               AND CCF.SOURCE_ID = REC1.PAYMENT_CHILD_ID;
            DELETE FROM CUX.CUX_CP_FACT_ALL_NEG CFA
             WHERE CFA.SOURCE = 'AP_ZS_CHECK'
               AND CFA.SOURCE_ID = REC1.PAYMENT_CHILD_ID;
            --���²���ۼ�
            CUX_CP_VALIDAT_PKG.CUX_INSERT_CP_ACT('AP_ZS_CHECK',
                                                 REC1.PAYMENT_CHILD_ID,
                                                 TO_NUMBER(REC1.ATTRIBUTE1),
                                                 TO_NUMBER(REC1.ATTRIBUTE2),
                                                 TRUNC(SYSDATE),
                                                 (-1) * NVL(REC1.AMOUNT, 0),
                                                 NULL,
                                                 REC1.ATTRIBUTE4,
                                                 'N');
          
            --�жϵ�ǰ��֯�Ƿ������ʽ����
            SELECT COUNT(*)
              INTO V_COUNT
              FROM CUX.CUX_CP_ZZJG_TREE_CONFIG CCT
             WHERE CCT.ORG_ID = REC1.ORG_ID
               AND NVL(CCT.ATTRIBUTE3, 'N') = 'Y'; --��֯У��
            IF V_COUNT > 0 THEN
              CUX_CP_VALIDAT_PKG.CUX_VALIDAT_CP_YE(REC1.ORG_ID,
                                                   TO_NUMBER(REC1.ATTRIBUTE1),
                                                   TO_NUMBER(REC1.ATTRIBUTE2),
                                                   TRUNC(SYSDATE),
                                                   (-1) * NVL(REC1.AMOUNT, 0),
                                                   P_MSG);
              --���δУ��ɹ�����ع�
              IF P_MSG IS NOT NULL THEN
                ROLLBACK;
                V_STATUS := 'E';
                V_REASON := V_REASON || 'ȡ�����' || REC1.PAYMENT_CODE ||
                            'ʧ�ܣ�ԭ��' || P_MSG || '<br />';
                RETURN;
                --GOTO ENDS;
              
              END IF;
            
            END IF;
          
          END IF;
        END IF;
        /*�ʽ�ƻ�����У��20190426 by mcq end*/
      
        CUX_EXP_INVOICES_PKG.CANCLE_EBS_PAYMENT(REC1.EBS_ID,
                                                V_CANCEL_TIME,
                                                REC1.EBS_ID,
                                                X_STATUS,
                                                X_REASON);
        IF X_STATUS = 'E' THEN
          V_PAYMENT_CANCEL_STATUS := 'E';
          V_STATUS                := 'E';
          V_REASON                := V_REASON || 'ȡ�����' ||
                                     REC1.PAYMENT_CODE || 'ʧ�ܣ�ԭ��' ||
                                     X_REASON || '<br />';
        ELSE
          UPDATE SPM_CON_PAYMENT_CHILD C
             SET C.STATUS = 'R'
           WHERE C.PAYMENT_CHILD_ID = REC1.PAYMENT_CHILD_ID;
        END IF;
        
        /*�ʽ�ƻ�����У��20190426 by mcq START*/
        IF REC1.PAY_BANK_ACCOUNT_ID <> 11002 THEN
        
          --����ֱ������EBS������ʷ�����ж��Ƿ�ȡ���ɹ�
          SELECT COUNT(*)
            INTO V_COUNT
            FROM AP_PAYMENT_HISTORY_ALL A
           WHERE A.CHECK_ID = REC1.CHECK_ID
             AND TRANSACTION_TYPE = 'PAYMENT CANCELLED';
          --ȡ���ɹ�   
          IF V_COUNT <> 0 THEN
            --���ݵ�ǰȡ�������Ƿ�Ϊȡ����������ȡ����
            IF NVL(REC1.AMOUNT, 0) > 0 THEN
              BEGIN
                SELECT CCF.GL_DATE
                  INTO V_GL_DATE
                  FROM CUX.CUX_CP_FACT_ALL CCF
                 WHERE CCF.SOURCE = 'AP_CHECK'
                   AND CCF.SOURCE_ID = REC1.CHECK_ID
                   AND ROWNUM < 2;
              EXCEPTION
                WHEN OTHERS THEN
                  V_GL_DATE := TRUNC(SYSDATE);
              END;
            ELSE
              V_GL_DATE := TRUNC(SYSDATE);
            
            END IF;
          
            IF NVL(REC1.ATTRIBUTE2, '0') <> '0' THEN
              CUX_CP_VALIDAT_PKG.CUX_INSERT_CP_ACT('AP_CHECK',
                                                   REC1.CHECK_ID,
                                                   TO_NUMBER(REC1.ATTRIBUTE1),
                                                   TO_NUMBER(REC1.ATTRIBUTE2),
                                                   TRUNC(V_GL_DATE), --����ʱ����ʱ��
                                                   (-1) * NVL(REC1.AMOUNT *
                                                              NVL(REC1.EXCHANGE_RATE,
                                                                  1),
                                                              0),
                                                   NULL,
                                                   REC1.ATTRIBUTE4,
                                                   (CASE
                                                     WHEN NVL(REC1.AMOUNT, 0) > 0 THEN
                                                      'Y'
                                                     ELSE
                                                      'N'
                                                   END));
            END IF;
            --������û��ȡ���ɹ�������Ҫɾ���ۼ� 
            DELETE FROM cux.cux_cp_fact_all ccf
             WHERE ccf.source = 'AP_ZS_CHECK'
               AND ccf.source_id = REC1.CHECK_ID;
            DELETE FROM cux.cux_cp_fact_all_neg cfa
             WHERE cfa.source = 'AP_ZS_CHECK'
               AND cfa.source_id = REC1.CHECK_ID;
            COMMIT;
          
          END IF;
        END IF;
        /*�ʽ�ƻ�����У��20190426 by mcq END*/
        FETCH CUR1
          INTO REC1;
      END LOOP;
      CLOSE CUR1;
    
      IF V_PAYMENT_CANCEL_STATUS = 'S' THEN
        UPDATE SPM_CON_PAYMENT P
           SET P.EBS_STATUS = 'R'
         WHERE P.PAYMENT_ID = IDS(I);
      END IF;
    END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
      V_STATUS := 'E';
      V_REASON := '�洢���̴���';
  END BATCH_CANCEL_PAYMENT;

  /*  ���ݸ����Ϣ���ɶ�Ӧ����ָ�����
  �����Ϣ�ɸ���ӱ��л�ȡ*/
  PROCEDURE CREATE_INSTRUCT_BY_PAY_CHILD(V_PAYMENT_ID IN NUMBER) AS
  
    IS_EXISTS      NUMBER;
    V_VENDOR_NAME  VARCHAR2(200);
    L_PAYMENT_INFO SPM_CON_PAYMENT%ROWTYPE;
    L_INSTRUCT     SPM_CON_TRANSFER_INSTRUCT%ROWTYPE;
    L_ACCOUNT      SPM_CON_ORIENTATION_ACCOUNT%ROWTYPE;
  BEGIN
  
    --1.����ID�ҵ���Ӧ������տ�˻���
  
    SELECT P.*
      INTO L_PAYMENT_INFO
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    SELECT V.VENDOR_NAME
      INTO V_VENDOR_NAME
      FROM SPM_CON_VENDOR_INFO V
     WHERE V.VENDOR_ID = L_PAYMENT_INFO.VENDOR_ID;
  
    --2.���ݸ����Ϣ���ɶ�Ӧ��������
    --���ݵ�ǰ�տ��˻��Ƿ�Ϊ�ڲ��˻��жϣ��ǣ���Ϊ��ת������Ϊ���и���
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = L_PAYMENT_INFO.PAYMENT_ID
       AND P.BANK_ACCOUNT_NUM LIKE '01-10%';
  
    IF IS_EXISTS = 0 THEN
      L_INSTRUCT.TRANS_TYPE := 'YHFK';
    ELSE
      L_INSTRUCT.TRANS_TYPE := 'BZ';
    END IF;
  
    --3.����֧��ָ���,�����ɽ��ױ���Ƶ����ýӿ�ʱ
    /* --��ȡ��ˮ�� 
    
    L_INSTRUCT.APPLY_CODE := CREATE_SERIAL_DYNAMIC_VALUE('SPM_CON_APPLY_CODE',
                                                         'SPM_CON_TRANSFER_INSTRUCT',
                                                         'APPLY_CODE',
                                                         'FM00000');*/
  
    --4.����OU���ɶ�Ӧ�ͻ����,�����˻�
    BEGIN
      SELECT H.ATTRIBUTE4, H.ATTRIBUTE5
        INTO L_INSTRUCT.CLIENT_CODE, L_INSTRUCT.PAYER_ACCT_NO
        FROM HR_ALL_ORGANIZATION_UNITS H
       WHERE H.ORGANIZATION_ID = L_PAYMENT_INFO.ORG_ID
         AND H.ATTRIBUTE1 = 'org';
    EXCEPTION
      WHEN OTHERS THEN
        L_INSTRUCT.CLIENT_CODE   := '00';
        L_INSTRUCT.PAYER_ACCT_NO := '00';
      
    END;
    --5.У�鹩Ӧ���˺��Ƿ�Ϊ�����˻���������ǣ������һ�������˻�����
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_CON_ORIENTATION_ACCOUNT A
     WHERE 1 = 1
       AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
       AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
  
    IF IS_EXISTS <> 0 THEN
      --������ڣ������տ��˻���ȡ��Ӧ�����˻���Ϣ
      SELECT *
        INTO L_ACCOUNT
        FROM SPM_CON_ORIENTATION_ACCOUNT A
       WHERE 1 = 1
         AND A.BANK_ACCOUNT = L_PAYMENT_INFO.BANK_ACCOUNT_NUM
         AND A.ORG_ID = L_PAYMENT_INFO.ORG_ID;
    
      IF L_ACCOUNT.STATUS = 'S' THEN
      
        L_INSTRUCT.PAYEE_ACCT_NAME  := L_ACCOUNT.VENDOR_NAME;
        L_INSTRUCT.REMIT_BANK_NAME  := L_ACCOUNT.BANK_NAME;
        L_INSTRUCT.REMIT_BANK_CNAPS := L_ACCOUNT.BIG_ACCOUNT_NUMBER;
        L_INSTRUCT.REMIT_PROVINCE   := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_AREA',
                                                                                       L_ACCOUNT.PROVINCE_CODE),
                                               'ʡ',
                                               '');
        L_INSTRUCT.REMIT_CITY       := REPLACE(SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_CITY',
                                                                                       L_ACCOUNT.CITY_CODE),
                                               '��',
                                               '');
      END IF;
    
    ELSE
    
      --��������ڣ������һ�������˻���Ϣ
      L_ACCOUNT.ACCOUNT_ID    := SPM_CON_OR_ACCOUNT_SEQ.NEXTVAL;
      L_ACCOUNT.BANK_ACCOUNT  := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
      L_ACCOUNT.VENDOR_NAME   := V_VENDOR_NAME;
      L_ACCOUNT.BANK_NAME     := L_PAYMENT_INFO.BANK_NAME;
      L_ACCOUNT.CREATED_BY    := L_PAYMENT_INFO.CREATED_BY;
      L_ACCOUNT.CREATION_DATE := SYSDATE;
      L_ACCOUNT.DEPT_ID       := L_PAYMENT_INFO.DEPT_ID;
      L_ACCOUNT.ORG_ID        := L_PAYMENT_INFO.ORG_ID;
      L_ACCOUNT.STATUS        := 'A';
      L_ACCOUNT.CLIENT_CODE   := L_INSTRUCT.CLIENT_CODE;
    
      INSERT INTO SPM_CON_ORIENTATION_ACCOUNT VALUES L_ACCOUNT;
      COMMIT;
    
    END IF;
  
    --6.���ݸ����Ϣ����һ��֧��ָ��
  
    L_INSTRUCT.INSTRUCT_ID     := SPM_CON_TR_INSTRUCT_SEQ.NEXTVAL;
    L_INSTRUCT.AMOUNT          := L_PAYMENT_INFO.MONEY_AMOUNT;
    L_INSTRUCT.EXCUTE_DATE     := SYSDATE;
    L_INSTRUCT.PAYEE_ACCT_NO   := L_PAYMENT_INFO.BANK_ACCOUNT_NUM;
    L_INSTRUCT.PAYEE_ACCT_NAME := V_VENDOR_NAME;
    L_INSTRUCT.REMIT_BANK_NAME := L_PAYMENT_INFO.BANK_NAME;
    L_INSTRUCT.PAY_SUBJECT_NO  := L_PAYMENT_INFO.MATCH_PROJECT;
  
    L_INSTRUCT.CREATED_BY       := L_PAYMENT_INFO.CREATED_BY;
    L_INSTRUCT.DEPT_ID          := L_PAYMENT_INFO.DEPT_ID;
    L_INSTRUCT.ORG_ID           := L_PAYMENT_INFO.ORG_ID;
    L_INSTRUCT.CREATION_DATE    := L_PAYMENT_INFO.CREATION_DATE;
    L_INSTRUCT.LAST_UPDATE_DATE := L_PAYMENT_INFO.LAST_UPDATE_DATE;
    L_INSTRUCT.PAYMENT_ID       := L_PAYMENT_INFO.PAYMENT_ID;
    L_INSTRUCT.PURPOSE          := L_PAYMENT_INFO.PAY_PURPOSE;
  
    INSERT INTO SPM_CON_TRANSFER_INSTRUCT VALUES L_INSTRUCT;
  END CREATE_INSTRUCT_BY_PAY_CHILD;
  --���Ӧ������Ԥ��������ϵͳ���   BY ruankk
  --V_FLAG 1�� Ӧ�� 2Ԥ�� 3 �� ϵͳ���
  FUNCTION GET_PAYABLE_UNPAYABLE_BY_ID(V_ID NUMBER, V_FLAG NUMBER)
    RETURN NUMBER IS
    IS_EXISTS              NUMBER;
    IS_PAYABLE             VARCHAR2(10) := 'N'; --Ĭ��ΪԤ��
    V_PO_ID                NUMBER(15); --��ӦEBS����ID
    PAYABLE_SUM_AMOUNT     NUMBER DEFAULT 0; --����Ӧ�����
    UNPAYABLE_SUM_AMOUNT   NUMBER DEFAULT 0; --����Ԥ�����
    V_MONEY_AMOUNT         NUMBER DEFAULT 0; --����������
    V_DEPT_ID              NUMBER(15); --ҵ�����ݶ�Ӧ����ID
    IDS                    SPM_TYPE_TBL; --���Ŷμ���
    V_APPROVAL_AMOUNT      NUMBER; --�����еĽ��
    V_PREPAID_AMOUNT       NUMBER DEFAULT 0; --Ԥ������
    V_PREPAID_AMOUNT_PAIED NUMBER DEFAULT 0; --����Ԥ������
    V_INVOICE_AMOUNT       NUMBER DEFAULT 0; --��Ʊ���
    V_PAYMENT_AMOUNT       NUMBER DEFAULT 0; --������
    V_ORG_ID               NUMBER(15) DEFAULT 81; --��֯����Ĭ��81
  BEGIN
  
    --1.���ݸ����ð���ID
    SELECT P.DEPT_ID, P.ORG_ID
      INTO V_DEPT_ID, V_ORG_ID
      FROM SPM_CON_PAYMENT P
     WHERE P.PAYMENT_ID = V_ID;
  
    --2.��ѯ��Ӧ���������в��Ŷ�ֵ
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION(V_DEPT_ID)
      INTO IDS
      FROM DUAL;
  
    --3.��ѯ�������뵥��Ӧ������λEBS ID
    SELECT PV.VENDOR_ID, P.MONEY_AMOUNT
      INTO V_PO_ID, V_MONEY_AMOUNT
      FROM SPM_CON_PAYMENT P, SPM_CON_VENDOR_INFO VI, PO_VENDORS PV
     WHERE P.VENDOR_ID = VI.VENDOR_ID
       AND VI.VENDOR_CODE = PV.SEGMENT1
       AND P.PAYMENT_ID = V_ID;
    --4.��ѯԤ�����
    IF V_FLAG = 2 OR V_FLAG = 3 THEN
      BEGIN
        --Ԥ������
        SELECT NVL(SUM(AP.AMOUNT), 0)
          INTO V_PREPAID_AMOUNT
          FROM APPS.AP_INVOICE_PAYMENTS_ALL AP,
               APPS.AP_INVOICES_ALL         AH,
               PO_VENDORS                   S
         WHERE AH.INVOICE_ID = AP.INVOICE_ID
           AND AH.PARTY_ID = S.PARTY_ID
           AND S.VENDOR_ID = V_PO_ID
           AND AH.ORG_ID = V_ORG_ID
           AND AH.INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT'
           AND EXISTS
         (SELECT 1 FROM TABLE(IDS) WHERE COLUMN_VALUE = AH.ATTRIBUTE3);
      
        --����Ԥ������
        SELECT NVL(SUM(ADA.AMOUNT), 0) * -1
          INTO V_PREPAID_AMOUNT_PAIED
          FROM APPS.AP_INVOICE_DISTRIBUTIONS_ALL ADA,
               APPS.AP_INVOICES_ALL              AH,
               PO_VENDORS                        PV
         WHERE AH.INVOICE_ID = ADA.INVOICE_ID
           AND AH.PARTY_ID = PV.PARTY_ID
           AND PV.VENDOR_ID = V_PO_ID
           AND AH.ORG_ID = V_ORG_ID
           AND AH.INVOICE_TYPE_LOOKUP_CODE <> 'PREPAYMENT'
           AND ADA.PREPAY_DISTRIBUTION_ID IS NOT NULL
           AND EXISTS
         (SELECT 1 FROM TABLE(IDS) WHERE COLUMN_VALUE = AH.ATTRIBUTE3);
      
        --����Ԥ�����
        SELECT V_PREPAID_AMOUNT - V_PREPAID_AMOUNT_PAIED
          INTO UNPAYABLE_SUM_AMOUNT
          FROM DUAL;
      
      EXCEPTION
        WHEN OTHERS THEN
          UNPAYABLE_SUM_AMOUNT := 0;
      END;
    
    END IF;
    --5.��ѯӦ�����
    IF V_FLAG = 1 OR V_FLAG = 3 THEN
    
      BEGIN
        --��ѯ��Ʊ���
        SELECT NVL(SUM(ADA.AMOUNT), 0)
          INTO V_INVOICE_AMOUNT
          FROM APPS.AP_INVOICE_DISTRIBUTIONS_ALL ADA,
               APPS.AP_INVOICES_ALL              AH,
               PO_VENDORS                        PV
         WHERE AH.INVOICE_ID = ADA.INVOICE_ID
           AND AH.PARTY_ID = PV.PARTY_ID
           AND PV.VENDOR_ID = V_PO_ID
           AND AH.ORG_ID = V_ORG_ID
           AND AH.INVOICE_TYPE_LOOKUP_CODE <>
               DECODE('vendor', 'vendor', 'PREPAYMENT', '1')
           AND ADA.PREPAY_DISTRIBUTION_ID IS NULL
           AND EXISTS
         (SELECT 1 FROM TABLE(IDS) WHERE COLUMN_VALUE = AH.ATTRIBUTE3);
      
        --��ѯ�Ѹ�����
        SELECT NVL(SUM(APA.AMOUNT), 0)
          INTO V_PAYMENT_AMOUNT
          FROM APPS.AP_INVOICES_ALL         AH,
               APPS.AP_INVOICE_PAYMENTS_ALL APA,
               PO_VENDORS                   PV
         WHERE APA.INVOICE_ID = AH.INVOICE_ID
           AND AH.PARTY_ID = PV.PARTY_ID
           AND PV.VENDOR_ID = V_PO_ID
           AND AH.ORG_ID = V_ORG_ID
           AND AH.INVOICE_TYPE_LOOKUP_CODE <>
               DECODE('vendor', 'vendor', 'PREPAYMENT', '1')
           AND EXISTS
         (SELECT 1 FROM TABLE(IDS) WHERE COLUMN_VALUE = AH.ATTRIBUTE3);
      
        --��ѯӦ�����
        SELECT V_INVOICE_AMOUNT - V_PAYMENT_AMOUNT
          INTO PAYABLE_SUM_AMOUNT
          FROM DUAL;
      
      EXCEPTION
        WHEN OTHERS THEN
          PAYABLE_SUM_AMOUNT := 0;
      END;
    
    END IF;
  
    --��ѯ�������еĸ����� 
    IF V_FLAG = 3 THEN
      BEGIN
      
        SELECT NVL(SUM(P.MONEY_AMOUNT), 0)
          INTO V_APPROVAL_AMOUNT
          FROM SPM_CON_PAYMENT P
         WHERE 1 = 1
           AND P.MONTH_DETAIL_ID =
               (SELECT CP.CAPITAL_ID
                  FROM SPM_CON_CAPITAL_PLAN CP, SPM_CON_PAYMENT SCP
                 WHERE SCP.MONTH_DETAIL_ID = CP.CAPITAL_ID
                   AND SCP.PAYMENT_ID = V_ID)
           AND P.PAYMENT_ID <> V_ID
           AND P.STATUS NOT IN ('A', 'D')
           AND P.EBS_STATUS NOT IN ('US','R')
           AND EXISTS (SELECT *
                  FROM SPM_CON_PAYMENT SCP
                 WHERE SCP.VENDOR_ID = P.VENDOR_ID
                   AND SCP.PAYMENT_ID = V_ID);
      EXCEPTION
        WHEN OTHERS THEN
          V_APPROVAL_AMOUNT := 0;
      END;
    
    END IF;
  
    IF V_FLAG = 1 THEN
      --1:Ӧ��
      RETURN PAYABLE_SUM_AMOUNT;
    ELSIF V_FLAG = 2 THEN
      --2Ԥ��
      RETURN UNPAYABLE_SUM_AMOUNT;
    ELSE
      --3.ϵͳ��� = ��Ʊ��� - ������ - ����Ԥ������ - ��Ԥ���Ʊ��� - ����Ԥ���Ʊ��
      --�� ��Ʊ��� - ������ - Ԥ���Ʊ���
      RETURN(PAYABLE_SUM_AMOUNT - V_PREPAID_AMOUNT - V_APPROVAL_AMOUNT);
    END IF;
  END GET_PAYABLE_UNPAYABLE_BY_ID;

  -- Ʊ�����Ľӿڱ����ɽ��Ʊҵ������
  PROCEDURE GENERATE_INTERFACE_INVOICE(INTERFACE_IDS  IN VARCHAR2,
                                       V_CONTRACT_ID  IN NUMBER,
                                       V_WAREHOUSE_ID IN VARCHAR2,
                                       V_RETURN_MSG   OUT VARCHAR2) AS
  
    IDS                SPM_TYPE_TBL;
    WAREHOUSE_IDS      SPM_TYPE_TBL;
    V_DEPT_ID          NUMBER(15);
    V_VENDOR_ID        NUMBER(15);
    V_VENDOR_SITE_ID   NUMBER(15);
    V_PROJECT_ID       NUMBER(15);
    V_INPUT_INVOICE_ID NUMBER(15);
    V_PAPER_INVOICE_ID NUMBER(15);
    V_INVOICE_CODE     VARCHAR2(40);
    V_EBS_DEPT_CODE    VARCHAR2(40);
  
    IDS_COUNT               NUMBER := 0;
    V_INVOICE_TOTAL_AMOUNT  NUMBER := 0;
    V_INVOICE_AMOUNT        NUMBER := 0;
    V_TAX_AMOUNT            NUMBER := 0;
    V_TAX_RATE              NUMBER := 0;
    V_WAREHOUSE_MONEY       NUMBER := 0;
    V_WAREHOUSE_TOTAL_MONEY NUMBER := 0;
  
    L_INTERFACE       SPM_CON_INPUT_INTERFACE%ROWTYPE;
    L_INVOICE         SPM_CON_INPUT_INVOICE%ROWTYPE;
    L_INPUT_WAREHOUSE SPM_CON_INPUT_WAREHOUSE%ROWTYPE;
    L_PAPER_INVOICE   SPM_CON_PAPER_INVOICE%ROWTYPE;
    L_PAPER_CHILD     SPM_CON_PAPER_INVOICE_CHILD%ROWTYPE;
    L_ITEM_INTERFACE  SPM_CON_INPUT_ITEM_INTERFACE%ROWTYPE;
  
    CURSOR CUR_ITEM(C_INTERFACE_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_INPUT_ITEM_INTERFACE I
       WHERE I.INTERFACE_ID = C_INTERFACE_ID;
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(INTERFACE_IDS)
      INTO IDS
      FROM DUAL;
  
    V_INPUT_INVOICE_ID := SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL;
    IDS_COUNT          := IDS.COUNT;
    FOR I IN 1 .. IDS_COUNT LOOP
      SELECT *
        INTO L_INTERFACE
        FROM SPM_CON_INPUT_INTERFACE I
       WHERE I.INTERFACE_ID = IDS(I);
    
      IF I = 1 THEN
        BEGIN
          SELECT V.ORGANIZATION_ID
            INTO V_DEPT_ID
            FROM SPM_CON_HT_PEOPLE_V V
           WHERE V.USER_ID = SPM_SSO_PKG.GETUSERID
             AND V.BELONGORGID = SPM_SSO_PKG.GETORGID
             AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := '��ȡ������Ϣʧ��';
            RETURN;
        END;
      
        BEGIN
          SELECT V.VENDOR_ID
            INTO V_VENDOR_ID
            FROM SPM_CON_VENDOR_INFO V
           WHERE V.VENDOR_CODE = L_INTERFACE.XSF_NSRSBH;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := '��ȡ��Ӧ��ʧ�ܣ���˶Թ�Ӧ��' || L_INTERFACE.XSF_MC || '��' ||
                            L_INTERFACE.XSF_NSRSBH || '���Ƿ���Ч';
            RETURN;
        END;
      
        BEGIN
          SELECT T.VENDOR_SITE_ID
            INTO V_VENDOR_SITE_ID
            FROM PO_VENDOR_SITES_ALL T, PO_VENDORS V
           WHERE T.VENDOR_ID = V.VENDOR_ID
             AND T.ORG_ID = SPM_SSO_PKG.GETORGID
             AND V.ENABLED_FLAG = 'Y'
             AND T.PURCHASING_SITE_FLAG = 'Y'
             AND T.PAY_SITE_FLAG = 'Y'
             AND T.VENDOR_SITE_CODE != 'OFFICE'
             AND T.VENDOR_SITE_CODE = '��Ʒ�ɹ�'
             AND V.SEGMENT1 = L_INTERFACE.XSF_NSRSBH;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := 'δ��ȡ����Ӧ��' || L_INTERFACE.XSF_MC || '��' ||
                            L_INTERFACE.XSF_NSRSBH || '���µġ���Ʒ�ɹ����ص㣬��˶�';
            RETURN;
        END;
      
        BEGIN
          SELECT P.PROJECT_ID
            INTO V_PROJECT_ID
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '�޹���-%'
             AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := 'δ��ȡ������֯�µ���Ч�޹��̣���˶�';
            RETURN;
        END;
      
        BEGIN
          SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                                P.PERSON_ID)
            INTO V_EBS_DEPT_CODE
            FROM SPM_EAM_ALL_PEOPLE_V P
           WHERE P.USER_ID = SPM_SSO_PKG.GETUSERID;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := 'δ��ȡ����Ч�ĺ��㲿�ţ���˶�';
            RETURN;
        END;
      
        BEGIN
          SELECT NVL(I.SL, 0) * 100
            INTO V_TAX_RATE
            FROM SPM_CON_INPUT_ITEM_INTERFACE I
           WHERE I.INTERFACE_ID = IDS(I)
             AND ROWNUM = 1;
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := '��ȡ˰����Ϣʧ��';
            RETURN;
        END;
      
        BEGIN
          SELECT I.FP_DM || I.FP_HM || '-' || IDS_COUNT
            INTO V_INVOICE_CODE
            FROM SPM_CON_INPUT_INTERFACE I
           WHERE I.INTERFACE_ID = IDS(I);
        EXCEPTION
          WHEN OTHERS THEN
            V_RETURN_MSG := '���ɷ�Ʊ����ʧ��';
            RETURN;
        END;
      
        -- ����
        L_INVOICE.INPUT_INVOICE_ID := V_INPUT_INVOICE_ID;
        -- ��Ӧ��ID
        L_INVOICE.VENDOR_ID := V_VENDOR_ID;
        -- ��Ӧ�̵ص�
        L_INVOICE.VENDOR_SITE_ID := V_VENDOR_SITE_ID;
        -- ��Ʊ����
        L_INVOICE.INVOICE_CONTENT := L_INTERFACE.BZ;
        -- ��Ʊ����
        IF L_INTERFACE.FPLX = 1 THEN
          L_INVOICE.INVOICE_TYPE := 'C';
        ELSIF L_INTERFACE.FPLX = 3 THEN
          L_INVOICE.INVOICE_TYPE := 'B';
        ELSIF L_INTERFACE.FPLX = 4 THEN
          L_INVOICE.INVOICE_TYPE := 'A';
        END IF;
        -- ��Ʊ����
        L_INVOICE.INVOICE_CODE := V_INVOICE_CODE;
        -- ˰��
        L_INVOICE.TAX_RATE := V_TAX_RATE;
        -- ��Ʊ������
        L_INVOICE.CURRENCY_TYPE := 'CNY';
        -- �Ƿ��޺�ͬ
        IF V_CONTRACT_ID IS NULL THEN
          L_INVOICE.NO_CONTRACT := 'Y';
        ELSE
          L_INVOICE.NO_CONTRACT := 'N';
        END IF;
        -- ������ͬID
        L_INVOICE.CONTRACT_ID := V_CONTRACT_ID;
        -- ������ĿID
        L_INVOICE.PROJECT_ID := V_PROJECT_ID;
        -- �������
        IF V_WAREHOUSE_ID IS NULL THEN
          L_INVOICE.PAYMENT_STATUS := 'F';
        ELSE
          L_INVOICE.PAYMENT_STATUS := 'Y';
        END IF;
        -- �ǼǾ�����
        L_INVOICE.CREATED_BY      := SPM_SSO_PKG.GETUSERID;
        L_INVOICE.LAST_UPDATED_BY := SPM_SSO_PKG.GETUSERID;
        -- �Ǽ�����
        L_INVOICE.CREATION_DATE    := SYSDATE;
        L_INVOICE.LAST_UPDATE_DATE := SYSDATE;
        -- ��֯
        L_INVOICE.ORG_ID := SPM_SSO_PKG.GETORGID;
        -- ����
        L_INVOICE.DEPT_ID := V_DEPT_ID;
        -- ����״̬
        L_INVOICE.STATUS := 'A';
        -- ͬ��״̬
        L_INVOICE.EBS_STATUS := 'N';
        -- ��Ʊ����
        L_INVOICE.BILLING_DATE := SYSDATE;
        -- ���㲿��
        L_INVOICE.EBS_DEPT_CODE := V_EBS_DEPT_CODE;
        -- ��Ʊ����-Ĭ����������
        L_INVOICE.PAYMENT_TERM := '10000';
        -- ��Ʊ����-Ĭ�ϱ�׼
        L_INVOICE.EBS_TYPE := 'STANDARD';
        -- ��Ʊ��ʽ-Ĭ�ϵ��
        L_INVOICE.PAYMENT_TYPE := 'WIRE';
        -- ����ʱ��
        L_INVOICE.GL_DATE := SYSDATE;
        -- ˰��Ŀ
        L_INVOICE.EBS_TAX_SUB_CODE := 2221010101;
      
        /*����Ϣ*/
        IF V_WAREHOUSE_ID IS NULL THEN
          -- ����
          -- ����          
          L_INPUT_WAREHOUSE.INPUT_WAREHOUSE_ID := SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL;
          -- ͷ������
          L_INPUT_WAREHOUSE.INPUT_INVOICE_ID := V_INPUT_INVOICE_ID;
          -- ������
          L_INPUT_WAREHOUSE.CREATED_BY      := SPM_SSO_PKG.GETUSERID;
          L_INPUT_WAREHOUSE.LAST_UPDATED_BY := SPM_SSO_PKG.GETUSERID;
          -- ����ʱ��
          L_INPUT_WAREHOUSE.CREATION_DATE    := SYSDATE;
          L_INPUT_WAREHOUSE.LAST_UPDATE_DATE := SYSDATE;
        ELSE
          SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_WAREHOUSE_ID)
            INTO WAREHOUSE_IDS
            FROM DUAL;
        
          --����
          FOR I IN 1 .. WAREHOUSE_IDS.COUNT LOOP
            BEGIN
              SELECT NVL(SUM(D.MONEY_AMOUNT), 0)
                INTO V_WAREHOUSE_MONEY
                FROM SPM_CON_WAREHOUSE_DL D
               WHERE D.WAREHOUSE_ID = WAREHOUSE_IDS(I);
            EXCEPTION
              WHEN OTHERS THEN
                V_RETURN_MSG := '��ȡ��ⵥ��Ϣʧ��';
                RETURN;
            END;
            -- ����          
            L_INPUT_WAREHOUSE.INPUT_WAREHOUSE_ID := SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL;
            -- ͷ������
            L_INPUT_WAREHOUSE.INPUT_INVOICE_ID := V_INPUT_INVOICE_ID;
            -- ��ⵥ����
            L_INPUT_WAREHOUSE.WAREHOUSE_ID := WAREHOUSE_IDS(I);
            -- ������
            L_INPUT_WAREHOUSE.CREATED_BY      := SPM_SSO_PKG.GETUSERID;
            L_INPUT_WAREHOUSE.LAST_UPDATED_BY := SPM_SSO_PKG.GETUSERID;
            -- ����ʱ��
            L_INPUT_WAREHOUSE.CREATION_DATE    := SYSDATE;
            L_INPUT_WAREHOUSE.LAST_UPDATE_DATE := SYSDATE;
            -- ����˰���
            L_INPUT_WAREHOUSE.MONEY_AMOUNT := V_WAREHOUSE_MONEY;
          
            V_WAREHOUSE_TOTAL_MONEY := V_WAREHOUSE_TOTAL_MONEY +
                                       V_WAREHOUSE_MONEY;
          
            --��������
            INSERT INTO SPM_CON_INPUT_WAREHOUSE VALUES L_INPUT_WAREHOUSE;
          END LOOP;
        END IF;
      END IF;
      -- ��Ʊͷ����
      V_INVOICE_TOTAL_AMOUNT := V_INVOICE_TOTAL_AMOUNT +
                                NVL(L_INTERFACE.JSHJ, 0);
      V_INVOICE_AMOUNT       := V_INVOICE_AMOUNT + NVL(L_INTERFACE.HJJE, 0);
      V_TAX_AMOUNT           := V_TAX_AMOUNT + NVL(L_INTERFACE.HJSE, 0);
    
      /*����Ʊ*/
      -- ��Ʊ����
      V_PAPER_INVOICE_ID               := SPM_CON_PAPER_INVOICE_SEQ.NEXTVAL;
      L_PAPER_INVOICE.PAPER_INVOICE_ID := V_PAPER_INVOICE_ID;
      -- ͷ������
      L_PAPER_INVOICE.INVOICE_ID := V_INPUT_INVOICE_ID;
      -- ��Ʊ����
      L_PAPER_INVOICE.INVOICE_TYPE := 'AP';
      -- ����˰���
      L_PAPER_INVOICE.MONEY_AMOUNT := L_INTERFACE.HJJE;
      -- ˰��
      L_PAPER_INVOICE.TAX_AMOUNT := L_INTERFACE.HJSE;
      -- ��Ʊ����
      L_PAPER_INVOICE.INVOICE_CODE := L_INTERFACE.FP_DM;
      -- ��Ʊ����
      L_PAPER_INVOICE.INVOICE_NUMBER := L_INTERFACE.FP_HM;
      -- ��������ID
      L_PAPER_INVOICE.ORG_ID := SPM_SSO_PKG.GETORGID;
      -- ��������ID
      L_PAPER_INVOICE.DEPT_ID := V_DEPT_ID;
      -- ������
      L_PAPER_INVOICE.CREATED_BY      := SPM_SSO_PKG.GETUSERID;
      L_PAPER_INVOICE.LAST_UPDATED_BY := SPM_SSO_PKG.GETUSERID;
      -- ����ʱ��
      L_PAPER_INVOICE.CREATION_DATE    := SYSDATE;
      L_PAPER_INVOICE.LAST_UPDATE_DATE := SYSDATE;
      -- ��Ʊ�Ƿ����� 
      L_PAPER_INVOICE.INVALID_FLAG := 'N';
      -- �ӿ�-��Ʊ����
      L_PAPER_INVOICE.FPMW := L_INTERFACE.FP_MW;
      -- �ӿ�-У����
      L_PAPER_INVOICE.JYM := L_INTERFACE.JYM;
      -- �ӿ�-��Ʊ����
      L_PAPER_INVOICE.KPRQ := L_INTERFACE.KPRQ;
      -- �ӿ�-���򷽵�ַ�绰
      L_PAPER_INVOICE.GMFDZDH := L_INTERFACE.GMF_DZDH;
      -- �ӿ�-��������
      L_PAPER_INVOICE.GMFMC := L_INTERFACE.GMF_MC;
      -- �ӿ�-������˰��ʶ���
      L_PAPER_INVOICE.GMFNSRSBH := L_INTERFACE.GMF_NSRSBH;
      -- �ӿ�-���������˺�
      L_PAPER_INVOICE.GMFYHZH := L_INTERFACE.GMF_YHZH;
      -- �ӿ�-���۷���ַ�绰
      L_PAPER_INVOICE.XSFDZDH := L_INTERFACE.XSF_DZDH;
      -- �ӿ�-���۷�����
      L_PAPER_INVOICE.XSFMC := L_INTERFACE.XSF_MC;
      -- �ӿ�-���۷���˰��ʶ���
      L_PAPER_INVOICE.XSFNSRSBH := L_INTERFACE.XSF_NSRSBH;
      -- �ӿ�-���۷������˺�
      L_PAPER_INVOICE.XSFYHZH := L_INTERFACE.XSF_YHZH;
      -- �ӿ�-ԭ��Ʊ����
      L_PAPER_INVOICE.YFPDM := L_INTERFACE.YFP_DM;
      -- �ӿ�-ԭ��Ʊ����
      L_PAPER_INVOICE.YFPHM := L_INTERFACE.YFP_HM;
      -- �ӿ�-��˰�ϼ�
      L_PAPER_INVOICE.JSHJ := L_INTERFACE.JSHJ;
      -- �ӿ�-��Ʊ��
      L_PAPER_INVOICE.KPR := L_INTERFACE.KPR;
      -- �ӿ�-������
      L_PAPER_INVOICE.FHR := L_INTERFACE.FHR;
      -- �ӿ�-�տ���
      L_PAPER_INVOICE.SKR := L_INTERFACE.SKR;
    
      -- ��������
      INSERT INTO SPM_CON_PAPER_INVOICE P VALUES L_PAPER_INVOICE;
    
      -- ����Ʊ����Ϣ
      FOR L_ITEM_INTERFACE IN CUR_ITEM(IDS(I)) LOOP
        -- ����
        L_PAPER_CHILD.PAPER_INVOICE_CHILD_ID := PAPER_INVOICE_CHILD_SEQ.NEXTVAL;
        -- ����Ʊ����
        L_PAPER_CHILD.PAPER_INVOICE_ID := V_PAPER_INVOICE_ID;
        -- ��Ŀ����
        L_PAPER_CHILD.XMMC := L_ITEM_INTERFACE.XMMC;
        -- ����ͺ�
        L_PAPER_CHILD.GGXH := L_ITEM_INTERFACE.GGXH;
        -- ��λ
        L_PAPER_CHILD.DW := L_ITEM_INTERFACE.DW;
        -- ��Ŀ����
        L_PAPER_CHILD.XMSL := L_ITEM_INTERFACE.XMSL;
        -- ��Ŀ����
        L_PAPER_CHILD.XMDJ := L_ITEM_INTERFACE.XMDJ;
        -- ��Ŀ���
        L_PAPER_CHILD.XMJE := L_ITEM_INTERFACE.XMJE;
        -- ˰��
        L_PAPER_CHILD.SL := L_ITEM_INTERFACE.SL;
        -- ˰��
        L_PAPER_CHILD.SE := L_ITEM_INTERFACE.SE;
        -- ��������ID
        L_PAPER_CHILD.ORG_ID := SPM_SSO_PKG.GETORGID;
        -- ��������ID
        L_PAPER_CHILD.DEPT_ID := V_DEPT_ID;
        -- ������
        L_PAPER_CHILD.CREATED_BY      := SPM_SSO_PKG.GETUSERID;
        L_PAPER_CHILD.LAST_UPDATED_BY := SPM_SSO_PKG.GETUSERID;
        -- ����ʱ��
        L_PAPER_CHILD.CREATION_DATE    := SYSDATE;
        L_PAPER_CHILD.LAST_UPDATE_DATE := SYSDATE;
      
        -- ��������
        INSERT INTO SPM_CON_PAPER_INVOICE_CHILD VALUES L_PAPER_CHILD;
      END LOOP;
    END LOOP;
  
    -- ���½��
    L_INVOICE.INVOICE_AMOUNT    := V_INVOICE_TOTAL_AMOUNT;
    L_INVOICE.INVOICETAX_AMOUNT := V_INVOICE_AMOUNT;
    L_INVOICE.TAX_AMOUNT        := V_TAX_AMOUNT;
    IF V_WAREHOUSE_ID IS NULL THEN
      L_INPUT_WAREHOUSE.MONEY_AMOUNT := V_INVOICE_AMOUNT;
      INSERT INTO SPM_CON_INPUT_WAREHOUSE VALUES L_INPUT_WAREHOUSE;
    ELSE
      /*      V_RETURN_MSG := '��ⵥ����˰����뷢Ʊ����˰��һ��';
      Rollback;
      RETURN;*/
      L_INVOICE.NO_TAX_DIF := ROUND(V_INVOICE_AMOUNT -
                                    V_WAREHOUSE_TOTAL_MONEY,
                                    2);
    END IF;
  
    --��������
    INSERT INTO SPM_CON_INPUT_INVOICE VALUES L_INVOICE;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_MSG := '�洢�����쳣';
      Rollback;
  END GENERATE_INTERFACE_INVOICE;

  --��鵱ǰ��巢Ʊ���������Ʊʣ�����Ƿ��㹻
  FUNCTION CHECK_CM_INVOICE_AMOUNT_ENOUGH(P_ID NUMBER) RETURN VARCHAR2 IS
    CURSOR CUR(C_ID NUMBER) IS
      SELECT R.OUTPUT_INVOICE_ID,
             NVL(SUM(P.MONEY_AMOUNT) + SUM(P.TAX_AMOUNT), 0) MONEY_AMOUNT
        FROM SPM_CON_OUTPAPER_RETURN R, SPM_CON_PAPER_INVOICE P
       WHERE R.PAPER_INVOICE_ID = P.PAPER_INVOICE_ID
         AND P.INVOICE_TYPE = 'AR'
         AND R.OUTPUT_INVOICE_ID = C_ID
       GROUP BY R.OUTPUT_INVOICE_ID;
    P_RES_AMOUNT  NUMBER;
    P_RETURN_TEXT VARCHAR2(100);
  BEGIN
    FOR REC IN CUR(P_ID) LOOP
      SELECT I.RESIDUAL_AMOUNT
        INTO P_RES_AMOUNT
        FROM SPM_CON_OUTPUT_INVOICE I
       WHERE I.OUTPUT_INVOICE_ID = REC.OUTPUT_INVOICE_ID;
    
      IF P_RES_AMOUNT + REC.MONEY_AMOUNT < 0 THEN
        SELECT O.INVOICE_SERIAL_NUMBER || 'ʣ����㣬�����Ѻ����տ���'
          INTO P_RETURN_TEXT
          FROM SPM_CON_OUTPUT_INVOICE O
         WHERE O.OUTPUT_INVOICE_ID = REC.OUTPUT_INVOICE_ID;
        RETURN P_RETURN_TEXT;
      END IF;
    
    END LOOP;
    RETURN 'S';
  END CHECK_CM_INVOICE_AMOUNT_ENOUGH;

  --��巢Ʊ�ύ�ɹ��󣬺�����Ӧ���Ʊʣ����
  PROCEDURE CM_VERIFIC_OUTPUT_INVOICE(P_ID IN NUMBER, P_TYPE IN VARCHAR2) AS
    CURSOR CUR(C_ID NUMBER) IS
      SELECT P.INVOICE_ID,
             NVL(SUM(P.MONEY_AMOUNT) + SUM(P.TAX_AMOUNT), 0) MONEY_AMOUNT
        FROM SPM_CON_OUTPAPER_RETURN R, SPM_CON_PAPER_INVOICE P
       WHERE R.PAPER_INVOICE_ID = P.PAPER_INVOICE_ID
         AND P.INVOICE_TYPE = 'AR'
         AND R.OUTPUT_INVOICE_ID = C_ID
       GROUP BY P.INVOICE_ID;
  
  BEGIN
    FOR REC IN CUR(P_ID) LOOP
      --�ύʱ�˼�����Ӧ�ĺ��ռ�ý��
      IF P_TYPE = 'TJ' THEN
        UPDATE SPM_CON_OUTPUT_INVOICE O
           SET O.RESIDUAL_AMOUNT =
               (O.RESIDUAL_AMOUNT - REC.MONEY_AMOUNT)
         WHERE O.OUTPUT_INVOICE_ID = REC.INVOICE_ID;
      ELSE
        --����ʱ��ԭ����Ӧ�ĺ��ռ�ý��
        UPDATE SPM_CON_OUTPUT_INVOICE O
           SET O.RESIDUAL_AMOUNT =
               (O.RESIDUAL_AMOUNT + REC.MONEY_AMOUNT)
         WHERE O.OUTPUT_INVOICE_ID = REC.INVOICE_ID;
      
      END IF;
    
    END LOOP;
  
  END CM_VERIFIC_OUTPUT_INVOICE;

  --���ɶ�Ӧ��巢Ʊ��������Ʊ����ˮ��
  PROCEDURE CREATE_SERIAL_CODE_FOR_CM(P_ID IN NUMBER) AS
    P_CODE        VARCHAR2(40);
    P_IDX         NUMBER := 1;
    P_SERIAL_CODE VARCHAR2(100);
    CURSOR CUR(V_ID NUMBER) IS
      SELECT *
        FROM SPM_CON_OUTPAPER_RETURN R
       WHERE R.OUTPUT_INVOICE_ID = V_ID;
  BEGIN
    SELECT O.INVOICE_SERIAL_NUMBER
      INTO P_CODE
      FROM SPM_CON_OUTPUT_INVOICE O
     WHERE O.OUTPUT_INVOICE_ID = P_ID;
    FOR REC IN CUR(P_ID) LOOP
      P_SERIAL_CODE := P_CODE || TO_CHAR(P_IDX, 'FM00');
    
      --����Ʊ������ˮ�Ÿ��µ��������
      UPDATE SPM_CON_OUTPAPER_RETURN R
         SET R.SERIAL_CODE = P_SERIAL_CODE
       WHERE R.PAPER_RETURN_ID = REC.PAPER_RETURN_ID;
      --Ϊ����Ʊ�����һ�����ݣ���������ص�������¿�Ʊ��Ϣ  
      INSERT INTO SPM_CON_PAPER_INVOICE
        (PAPER_INVOICE_ID, INVOICE_ID, INVOICE_TYPE, ORG_ID, FPQQLSH)
      VALUES
        (SPM_CON_PAPER_INVOICE_SEQ.NEXTVAL,
         P_ID,
         'AR',
         REC.ORG_ID,
         P_SERIAL_CODE);
    
      P_IDX := P_IDX + 1;
    END LOOP;
  
  END CREATE_SERIAL_CODE_FOR_CM;

  -- ��ȡ���׵�����
  FUNCTION GET_TRANSACTION_NUMBER(V_ID IN VARCHAR2) RETURN VARCHAR2 IS
    TRANSACTION_NUM VARCHAR2(300);
  BEGIN
    SELECT J.F_DJBH
      INTO TRANSACTION_NUM
      FROM CUX.JYDJXX J
     WHERE J.SEQ_ID = V_ID;
    RETURN TRANSACTION_NUM;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '';
  END GET_TRANSACTION_NUMBER;

  --У�����Ʊ��ϸ����ⵥ��ϸ�Ƿ�ȷƥ��
  FUNCTION CHECK_MATCH_ODO(V_ID NUMBER) RETURN VARCHAR2 IS
    P_COUNT NUMBER; --������ʶ1
    R_COUNT NUMBER; --������ʾ2
    P_FLAG  VARCHAR2(40) DEFAULT 'S';
  
  BEGIN
  
    SELECT COUNT(*)
      INTO P_COUNT
      FROM (SELECT I.MATERIAL_CODE, I.ITEM_AMOUNT, I.MONEY_AMOUNT
              FROM SPM_CON_OUTPUT_ITEM I
             WHERE I.OUTPUT_INVOICE_ID = V_ID
            MINUS
            SELECT D.MATERIAL_CODE,
                   D.THIS_ODO_NUMBER  ITEM_AMOUNT,
                   D.TAX_AMOUNT_COUNT MONEY_AMOUNT
              FROM SPM_CON_OUTPUT_ODO I, SPM_CON_ODO_DL D
             WHERE I.ODO_ID = D.ODO_ID
               AND I.OUTPUT_INVOICE_ID = V_ID) T1;
  
    SELECT COUNT(*)
      INTO R_COUNT
      FROM (SELECT D.MATERIAL_CODE,
                   D.THIS_ODO_NUMBER  ITEM_AMOUNT,
                   D.TAX_AMOUNT_COUNT MONEY_AMOUNT
              FROM SPM_CON_OUTPUT_ODO I, SPM_CON_ODO_DL D
             WHERE I.ODO_ID = D.ODO_ID
               AND I.OUTPUT_INVOICE_ID = V_ID
            MINUS
            SELECT I.MATERIAL_CODE, I.ITEM_AMOUNT, I.MONEY_AMOUNT
              FROM SPM_CON_OUTPUT_ITEM I
             WHERE I.OUTPUT_INVOICE_ID = V_ID) T2;
  
    IF P_COUNT + R_COUNT <> 0 THEN
      P_FLAG := 'E';
    
    END IF;
    RETURN P_FLAG;
  END CHECK_MATCH_ODO;

  --��ȡ�¸�������С����ʱ��c
  FUNCTION GET_PAYMENT_GL_DATE(V_ID NUMBER) RETURN DATE IS
    P_GL_DATE DATE;
  BEGIN
  
    SELECT MIN(PAY_DATE)
      INTO P_GL_DATE
      FROM SPM_CON_PAYMENT_CHILD PC
     WHERE PC.PAYMENT_ID = V_ID;
  
    RETURN P_GL_DATE;
  
  EXCEPTION
    WHEN OTHERS THEN
      P_GL_DATE := NULL;
    
  END GET_PAYMENT_GL_DATE;

  --���ݵ�����Ϣ�����տ����
  PROCEDURE CREATE_RECEIPT_FINANCE_INFO(V_ID IN NUMBER) IS
    IS_EXISTS      NUMBER;
    P_ID           NUMBER; --�տ����
    P_RECEIPT_CODE VARCHAR2(50);
    RECEIPT_ROW    SPM_CON_RECEIPT%ROWTYPE;
    MONEY_REG_ROW  SPM_CON_MONEY_REG%ROWTYPE;
    K_IS_HAD       NUMBER;
    P_FLAG         VARCHAR2(10);
  BEGIN
    --��������ò����տ����֯��ֱ�ӷ��أ�����ԭ�����տɾ��
    P_FLAG := IS_ENABLE_FINANCIAL_RECEIPT(SPM_SSO_PKG.getOrgId);
    IF P_FLAG <> 'Y' THEN
      DELETE FROM SPM_CON_RECEIPT R
       WHERE R.MONEY_REG_ID = V_ID
         AND R.DATA_TYPE = 'CW';
      RETURN;
    END IF;
    --����У��,����Ѿ����˲����տ,ֱ�ӷ���
    SELECT COUNT(*)
      INTO K_IS_HAD
      FROM SPM_CON_RECEIPT T
     WHERE T.MONEY_REG_ID = V_ID
       AND T.DATA_TYPE = 'CW';
  
    IF K_IS_HAD > 0 THEN
      RETURN;
    END IF;
  
    SELECT *
      INTO MONEY_REG_ROW
      FROM SPM_CON_MONEY_REG
     WHERE MONEY_REG_ID = V_ID;
  
    SELECT DECODE(MONEY_REG_ROW.RECEIPT_METHOD, 'Ʊ���տ�', 'A', 'D')
      INTO P_FLAG
      FROM DUAL;
  
    SELECT SPM_CON_RECEIPT_SEQ.NEXTVAL INTO P_ID FROM DUAL;
    P_RECEIPT_CODE := SPM_CON_MQ_PKG.CREATE_SERIAL_CODE_UTIL(P_SERIAL_CODE => 'SPM_CON_RECEIPT_NUM_F',
                                                             P_TABLE_NAME  => 'SPM_CON_RECEIPT',
                                                             P_FIELD_NAME  => 'RECEIPT_CODE',
                                                             P_FORMAT_CODE => 'FM000000',
                                                             P_USER_ID     => MONEY_REG_ROW.CREATED_BY,
                                                             P_ORG_ID      => MONEY_REG_ROW.ORG_ID);
  
    RECEIPT_ROW.RECEIPT_ID      := P_ID;
    RECEIPT_ROW.MONEY_REG_ID    := V_ID;
    RECEIPT_ROW.RECEIPT_CODE    := P_RECEIPT_CODE;
    RECEIPT_ROW.MONEY_AMOUNT    := MONEY_REG_ROW.MONEY_ACCOUNT;
    RECEIPT_ROW.CURRENCY_TYPE   := 'CNY';
    RECEIPT_ROW.RMB_TOTAL       := MONEY_REG_ROW.MONEY_ACCOUNT;
    RECEIPT_ROW.GL_DATE         := MONEY_REG_ROW.COLLECTION_DATE;
    RECEIPT_ROW.REMARK          := MONEY_REG_ROW.Remark;
    RECEIPT_ROW.ORG_ID          := MONEY_REG_ROW.Org_Id;
    RECEIPT_ROW.RESIDUAL_AMOUNT := MONEY_REG_ROW.MONEY_ACCOUNT;
    RECEIPT_ROW.Ebs_Status      := 'N';
    RECEIPT_ROW.DATA_TYPE       := 'CW'; --�����ʶ 
    RECEIPT_ROW.RECEIPT_DEPT    := SPM_CON_MQ_PKG.GET_RECEIPT_DEFAULT_CONFIGURE(P_FLAG,
                                                                                'receiptDept',
                                                                                MONEY_REG_ROW.ORG_ID,
                                                                                NULL); -- Ĭ��00��
    RECEIPT_ROW.CASH_FLOW       := SPM_CON_MQ_PKG.GET_RECEIPT_DEFAULT_CONFIGURE(P_FLAG,
                                                                                'cashFlow',
                                                                                MONEY_REG_ROW.ORG_ID,
                                                                                NULL);
    RECEIPT_ROW.EBS_PRODUCE     := SPM_CON_MQ_PKG.GET_RECEIPT_DEFAULT_CONFIGURE(P_FLAG,
                                                                                'ebsProduce',
                                                                                MONEY_REG_ROW.ORG_ID,
                                                                                NULL);
    RECEIPT_ROW.Match_Dept      := SPM_CON_MQ_PKG.GET_RECEIPT_DEFAULT_CONFIGURE(P_FLAG,
                                                                                'matchDept',
                                                                                MONEY_REG_ROW.ORG_ID,
                                                                                NULL);
    RECEIPT_ROW.Match_Project   := SPM_CON_MQ_PKG.GET_RECEIPT_DEFAULT_CONFIGURE(P_FLAG,
                                                                                'matchProject',
                                                                                MONEY_REG_ROW.ORG_ID,
                                                                                NULL);
  
    RECEIPT_ROW.Creation_Date := sysdate;
    RECEIPT_ROW.CREATED_BY := MONEY_REG_ROW.CREATED_BY;
  
    INSERT INTO SPM_CON_RECEIPT VALUES RECEIPT_ROW;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('����ʧ�ܣ�');
  END;

  --�Ƿ����ò����տ� Y���� N������
  --by mcq
  FUNCTION IS_ENABLE_FINANCIAL_RECEIPT(P_ORG_ID NUMBER) RETURN VARCHAR2 IS
    IS_EXISTS NUMBER;
    P_FLAG    VARCHAR2(10) DEFAULT 'N';
  BEGIN
  
    SELECT COUNT(*)
      INTO IS_EXISTS
      FROM SPM_DICT_TYPE DT, SPM_DICT D
     WHERE DT.DICT_TYPE_ID = D.DICT_TYPE_ID
       AND DT.TYPE_CODE = 'SPM_CON_MONEY_REG_ORG'
       AND D.DICT_CODE = TO_CHAR(P_ORG_ID);
    IF IS_EXISTS <> 0 THEN
      P_FLAG := 'Y';
    END IF;
  
    RETURN P_FLAG;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
    
  END IS_ENABLE_FINANCIAL_RECEIPT;
  
  FUNCTION CHECK_MONEY_NUMBER_OUTPUT(K_OUTPUT_ID NUMBER) RETURN VARCHAR2 IS
    CURSOR TARGETS(P_OUTPUT_ID NUMBER) IS
      select T.TARGET_ID, T.MATERIAL_NAME,T.MATERIAL_CODE,T.TARGET_COUNT
        from SPM_CON_OUTPUT_INVOICE I,
             SPM_CON_HT_INFO        F,
             SPM_CON_HT_TARGET      T
       WHERE I.CONTRACT_ID = F.CONTRACT_ID
         AND F.CONTRACT_ID = T.CONTRACT_ID
         AND I.OUTPUT_INVOICE_ID = P_OUTPUT_ID;
     K_HT_ID NUMBER;
     K_AMOUNT NUMBER;--��Ʊ���
     K_HT_AMOUNT NUMBER;--��ͬ���
     
     K_Z_NUMBER  NUMBER;--�ۻ���Ʊ����
  BEGIN
    
  select T.CONTRACT_ID, f.rmb_total
    INTO K_HT_ID, K_HT_AMOUNT
    from SPM_CON_OUTPUT_INVOICE T, spm_con_ht_info f
   WHERE T.OUTPUT_INVOICE_ID = K_OUTPUT_ID
     and t.contract_id = f.contract_id;
   
   select sum(t.invoice_amount)
     into K_AMOUNT
     from spm_con_output_invoice t
    where t.contract_id = K_HT_ID;
   
   --1.У���ܽ��
   IF K_AMOUNT  > K_HT_AMOUNT THEN 
     RETURN '�ö����ۻ���Ʊ�����ڶ������!';
    END IF;
   --2.У������
   FOR HH IN TARGETS(K_OUTPUT_ID) LOOP
     select NVL(SUM(T.ITEM_AMOUNT), 0) INTO K_Z_NUMBER
       from spm_con_output_item t, spm_con_output_invoice i
      where i.output_invoice_id = t.output_invoice_id
        and i.contract_id = K_HT_ID
        AND T.MATERIAL_CODE = HH.MATERIAL_CODE;
        
      IF   K_Z_NUMBER > HH.TARGET_COUNT THEN 
        RETURN HH.MATERIAL_NAME || '�����ϵĿ�Ʊ�������ڶ���������!';
      END IF;
    END LOOP;
    
    RETURN 'Y';
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '���������쳣';
  END CHECK_MONEY_NUMBER_OUTPUT;

END SPM_CON_INVOICE_PKG;
/
