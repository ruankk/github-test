CREATE OR REPLACE PACKAGE "SPM_GZ_GZGL_INS_PKG" IS
  --Global Char
  /*
  ȡ��ʹ��ȫ�ֱ�����ʹ�ú�ᵼ��Ƶ������ʧ�����
  G_INTERFACE_ERROR   CONSTANT VARCHAR2(1) := 'E';
  G_INTERFACE_SUCCESS CONSTANT VARCHAR2(1) := 'S';*/
  /*=================================================================
  *   PROGRAM NAME: SPM_GZ_AP_INFO_IMP
  *
  *   DESCRIPTION: SPM �� EBS AP��Ʊ�ӿ��м��ͬ���Ĵ洢����
  *   ARGUMENT:
  *   PARAM : V_ID ������Ҫͬ���ķ�Ʊid��v_Return_Code ��Ҫ���ص�ִ������� v_Return_Message��Ҫ���صĴ���ԭ��
  *   HISTORY:
  *     1.0  20171018   MCQ           Created
  * ===============================================================*/
  /*PROCEDURE SPM_GZ_AP_INFO_IMP_OFFICE(\*V_ID             IN NUMBER,*\
  V_MAIN_ID        IN  NUMBER, --��������
  V_GLDATE         IN  VARCHAR2, --��������
  V_PERIODDATE     IN  VARCHAR2, --�ڼ�
  V_DQYEAR         IN  VARCHAR2, -- ��ǰ��
  V_DQMONTH        IN  VARCHAR2, -- ��ǰ��
  V_DQNUM          IN  VARCHAR2, --��ǰ��
  v_Return_Code    OUT VARCHAR2,
  v_Return_Message OUT VARCHAR2);*/

  /*PROCEDURE SPM_GZ_AP_INFO_IMP_DEPT(\*V_ID             IN NUMBER,*\
  V_MAIN_ID        IN NUMBER, --��������
  V_GLDATE         IN VARCHAR2, --��������
  V_PERIODDATE     IN VARCHAR2, --�ڼ�
  V_DQYEAR         IN  VARCHAR2, -- ��ǰ��
  V_DQMONTH        IN  VARCHAR2, -- ��ǰ��
  V_DQNUM          IN  VARCHAR2, --��ǰ��
  v_Return_Code    OUT VARCHAR2,
  v_Return_Message OUT VARCHAR2);*/
  --ר����ѯ�ѵ����������ƾ֤
  PROCEDURE SPM_EXPERT_FEE_CREATE_CERT( /*V_ID             IN NUMBER,*/V_MAIN_ID IN NUMBER, --��������
                                       --V_DEPTCODE         IN VARCHAR2, --���Ŷ�
                                       /*V_PERIODDATE     IN VARCHAR2, --�ڼ�
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQYEAR         IN  VARCHAR2, -- ��ǰ��
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQMONTH        IN  VARCHAR2, -- ��ǰ��
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                V_DQNUM          IN  VARCHAR2, --��ǰ��*/
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);

  --�������Ʊ��֤                              
  PROCEDURE BATCH_INPUT_VALIDATE(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 P_MSG       OUT VARCHAR2);
  -- �������Ʊ����                                
  PROCEDURE BATCH_INPUT_IMPORT(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               F_TABLENAME VARCHAR2,
                               F_TABLEID   VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  /*�ɹ�������Ʊ��Ϣ��������Ϣ�м��*/
  PROCEDURE SPM_CON_SYNC_INVOICEINFO(V_ID             IN VARCHAR2,
                                     V_MSG            IN CLOB,
                                     V_RETURN_CODE    OUT VARCHAR2,
                                     V_RETURN_MESSAGE OUT VARCHAR2);
  /*���ݲɹ��������ɽ��Ʊ*/
  PROCEDURE CREATE_INPUT_INVOICE(V_IDS         IN VARCHAR2,
                                 V_RETURN_CODE OUT VARCHAR2,
                                 V_RETURN_MSG  OUT VARCHAR2);

  --�ʽ�ƻ���� ���ۺϲ�ѯ��ȡ����ֵ
  FUNCTION SPM_CAPITAL_FIND_AMOUNT(P_PERIOD_YEAR  IN NUMBER, --���
                                   P_PERIOD_NUM_F IN NUMBER, --�·�
                                   P_PERIOD_NUM_T IN NUMBER, --�·�
                                   P_KM           IN SPM_TYPE_TBL, --��Ŀ                                
                                   P_GS           IN VARCHAR2, --��˾��  
                                   DEPTCODE       IN VARCHAR2, --���Ŷ� 
                                   P_VALTYPE      IN VARCHAR2, --ȡֵ����   
                                   ORGID          IN VARCHAR2) RETURN NUMBER;
  --���ݴ��İ���id �������ʽ�������id
  FUNCTION GET_CAPITAL_ID(P_DEPT_ID VARCHAR2) RETURN NUMBER;

  --�ʽ�ƻ������ϸ ��������ʱ �����û���� �ϻ����Ӷ� ����������  �����ʽ�ƻ����                                
  PROCEDURE SPM_CON_CAPITAL_QUOTA_UPDATE(ID NUMBER);

  --�ʽ�ƻ���� ��������
  PROCEDURE SPM_CAPITAL_COPY_DATA(CAPITALID IN NUMBER,
                                  V_STATUS  OUT VARCHAR2,
                                  V_MESSAGE OUT VARCHAR2);
  --����ɨ�跢Ʊ��Ϣ ������Ʊ��                             
  PROCEDURE INSERT_INPUTINVOICE_INFO(V_IDS         IN VARCHAR2,
                                     V_RETURN_CODE OUT VARCHAR2,
                                     V_RETURN_MSG  OUT VARCHAR2);
  --��������ƾ֤ģ����������ƾ֤����
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
   --�����ύ�Լ���֤ʱУ���ʽ�ƻ�����Ƿ��㹻
   --K_PAYMENT_IDS �������s   K_TYPE ����  1:�ύ   2:����
   FUNCTION CHECK_CAPITAL_BALANCE_FOR_PAY(K_PAYMENT_IDS VARCHAR2,K_TYPE VARCHAR2) RETURN VARCHAR2;
   --У����Ʊ�ύʱ ��Ӧ��Ʊʣ�����Ƿ����  Y:����  N:
   FUNCTION CHECK_RETURN_INVOICE_SUBMIT(K_OUTPUT_ID NUMBER) RETURN VARCHAR2;
   --����ҵ���տ�������Ʊ
   PROCEDURE CANCEL_YW_RECEIPT_INVOICE(K_RECEIPT_INVOICE_IDS IN VARCHAR2,
                                       MSG OUT VARCHAR2);

END SPM_GZ_GZGL_INS_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_GZ_GZGL_INS_PKG" AS

  /*=================================================================
  *   PROGRAM NAME: SPM_GZ_AP_INFO_IMP
  *
  *   DESCRIPTION: SPM �� EBS AP���ʽӿ��м��ͬ���Ĵ洢����
  *   ARGUMENT:
  *   PARAM : V_ID ������Ҫͬ���ķ�Ʊid��v_Return_Code ��Ҫ���ص�ִ������� v_Return_Message��Ҫ���صĴ���ԭ��
  *   HISTORY:
  *     1.0  20171122   YJ          Created
  * ===============================================================*/
  /* PROCEDURE SPM_GZ_AP_INFO_IMP_OFFICE(--\*V_ID             IN NUMBER,*\
                                V_MAIN_ID        IN  NUMBER, --��������
                                V_GLDATE         IN  VARCHAR2, --��������
                                V_PERIODDATE     IN  VARCHAR2, --�ڼ�
                                V_DQYEAR         IN  VARCHAR2, -- ��ǰ��
                                V_DQMONTH        IN  VARCHAR2, -- ��ǰ��
                                V_DQNUM          IN  VARCHAR2, --��ǰ��
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
     JBGZ_KMJE         NUMBER; --�������ʵȿ�Ŀ���  �跽
     JJIN_KMJE         NUMBER; --\*�½��ȿ�Ŀ��� �跽*\
     DSZNF_KMJE        NUMBER; --\*���� �в���Ŀ��� �跽*\
     FSJWF_KMJE        NUMBER; --\*����¿�Ŀ��� �跽*\
     
     JBYANGLBX_KMJE    NUMBER; --\*�ۻ������Ͽ�Ŀ��� ����*\
     JBYILBX_KMJE      NUMBER; --\*��ҽ�Ʊ��տ�Ŀ��� ����*\
     KSY_KMJE          NUMBER; --\*��ʧҵ��Ŀ��� ����*\
     ZFGJJ_KMJE        NUMBER; --\*��ס���������Ŀ��� ����*\
     QYNJ_KMJE         NUMBER; ---\*����ҵ����Ŀ��� ����*\
     JJ_KMJE_DAI       NUMBER; --\*���¼ٿ�Ŀ��� ����*\
     GRSDS_KMJE        NUMBER; --\*����˰��Ŀ��� ����*\
     JBH_KMJE          NUMBER; --\*��������Ŀ��ʵ�����ʣ�����*\
     
     JBGZ_KMJE_BM      NUMBER; --\*�������ʵȿ�Ŀ����*\
     JJIN_KMJE_BM      NUMBER; --\*�½��ȿ�Ŀ����*\
     DSZNF_KMJE_BM     NUMBER;-- \*���� �в��ȿ�Ŀ����*\
     FSJWF_KMJE_BM     NUMBER;-- \*����¿�Ŀ����*\
     JBYANGLBX_KMJE_BM NUMBER; --\*�ۻ������Ͽ�Ŀ����*\
     JBYILBX_KMJE_BM   NUMBER; --\*��ҽ�Ʊ��տ�Ŀ����*\
     --BCYLBX_KMJE_BM    NUMBER; \*����ҽ�Ʊ��տ�Ŀ����*\
     KSY_KMJE_BM       NUMBER; --\*��ʧҵ��Ŀ����*\
     ZFGJJ_KMJE_BM     NUMBER; --\*��ס���������Ŀ����*\
     QYNJ_KMJE_BM      NUMBER; --\*����ҵ����Ŀ����*\
     JJ_KMJE_DAI_BM    NUMBER; --\*���¼ٿ�Ŀ���� ����*\
     GRSDS_KMJE_BM     NUMBER; --\*����˰��Ŀ����*\
     JBH_KMJE_BM       NUMBER; --\*��������Ŀ���루ʵ�����ʣ�*\
     T_DATA_ID         NUMBER;
     V_IDS               VARCHAR2(200);
     IDS                 SPM_TYPE_TBL;
   
     --����main_id��ȡ���ұ���
     
     CURSOR CUR_1(P_MAIN_ID NUMBER) IS
        SELECT DISTINCT OFFICECODE AS OFFICE_CODE
         FROM SPM_GZ_WAGEDATA W
        WHERE MAIN_ID = P_MAIN_ID;
     REC_1 CUR_1%ROWTYPE;
   
     --���մ��ҷ��飬��ѯ���ұ���͸���Ŀ���
     CURSOR CUR_2(P_OFFICE_CODE VARCHAR2) IS
       SELECT *
         FROM (SELECT SUM(WA.GZYF_01+WA.GZYF_02+WA.GZYF_03) AS JBGZ_KMJE,--�������ʵȽ��
                      SUM(WA.GZYF_04+WA.GZYF_06 +WA.GZYF_07 
                       +WA.GZYF_10 + WA.GZYF_11 + WA.GZYF_48 + WA.GZYF_49
                      ) AS JJIN_KMJE,--�½��Ƚ��
                      SUM(WA.GZYF_08+ WA.GZYF_09) DSZNF_KMJE,--���� �в��Ƚ��
                      SUM(WA.GZYF_12+WA.GZYF_19) FSJWF_KMJE,--����µȽ��
                      SUM(WA.GZKJ_01) JBYANGLBX_KMJE,--�ۻ������Ͻ��
                      SUM(WA.GZKJ_02+WA.GZKJ_03) JBYILBX_KMJE,--��ҽ�Ʊ��� �۴��ҽ�ƽ��
                      --SUM(WA.GZKJ_03) BCYLBX_KMJE,--ȥ��
                      SUM(WA.GZKJ_04) KSY_KMJE,--��ʧҵ���
                      SUM(WA.GZKJ_05) ZFGJJ_KMJE,--��ס����������
                      SUM(WA.GZKJ_06) QYNJ_KMJE,--����ҵ�����
                      SUM(WA.GZKJ_07 + WA.GZKJ_08) JJ_KMJE_DAI,--���¼� �۲��ٽ��
                      SUM(WA.WAGE_TAX1) GRSDS_KMJE,--����˰���
                      SUM(WA.WAGE_FACT) JBH_KMJE,--ʵ�����ʽ��
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
       V_RETURN_MESSAGE := '��ǰ�Ĺ��������Ѿ�ִ����ͬ���������';
       DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
       RETURN;
     END IF;
   
      T_NUMLINE := 0;
      
     --��ʼѭ��
     OPEN CUR_1(V_MAIN_ID);
     loop
   
       FETCH CUR_1
         INTO REC_1;
         exit when CUR_1%notfound;
   
       --��ȡ��˾���� ������ �޸���id �޸���
       SELECT DISTINCT WA.ORGCODE,WA.CREATED_BY,WA.LAST_UPDATE_LOGIN,WA.LAST_UPDATED_BY
         INTO T_ORG_CODE,T_CREATED_BY,T_LAST_UPDATE_LOGIN,T_LAST_UPDATED_BY
         FROM SPM_GZ_WAGEDATA WA
        WHERE WA.MAIN_ID = V_MAIN_ID;
        --���ʮ����Ŀ�εĿ�Ŀ���      
         SELECT c.subject_com
         INTO V_IDS
         FROM spm_gz_createcert c
         WHERE c.wagetype_code='017';
         
         SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS, '.') INTO IDS FROM DUAL;
         
           DBMS_OUTPUT.PUT_LINE(IDS(1));
           DBMS_OUTPUT.PUT_LINE(IDS(4));
       -- ��ȡϵͳʱ��
       SELECT TO_CHAR(sysdate, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
       T_OFFICE_CODE := REC_1.OFFICE_CODE;
       
       --�����α�2
       FOR REC_2 IN CUR_2(T_OFFICE_CODE) LOOP
                   
         BEGIN
           
   
           -- ��ȡ����ͷ��Ϣ����������id
           SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
             INTO T_HEADERS_ID
             FROM DUAL;
           DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
         T_NUMLINE    :=  T_NUMLINE+1;
        
         
         if REC_2.JBGZ_KMJE <>0 then 
           --�����м��  ���ҵ�һ��
           SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '��������';
   
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
              LAST_UPDATE_DATE,--�޸�����
              LAST_UPDATED_BY, --�޸���
              LAST_UPDATE_LOGIN, --��¼��id
              CREATION_DATE, --��������
              CREATED_BY)    --������
           VALUES
             (T_HEADERS_ID,
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              REC_2.JBGZ_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
           --�����м��  ���ҵڶ���
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '�½�';      
            T_NUMLINE    := T_NUMLINE+1;
            
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              REC_2.JJIN_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�����
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '����';          
         T_NUMLINE    := T_NUMLINE+1;
         
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              REC_2.DSZNF_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�����
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '�����';      
         T_NUMLINE    := T_NUMLINE+1;
         
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              REC_2.FSJWF_KMJE,
              0,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
            
           --�����м��  ���ҵ�����
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '�ۻ�������';         
         T_NUMLINE    := T_NUMLINE+1;
         
           -- ��ȡ����ͷ��Ϣ����������id
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
               'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.JBYANGLBX_KMJE,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�����
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '��ҽ�Ʊ���';         
           T_NUMLINE  :=  T_NUMLINE+1;
          
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.JBYILBX_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
               V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ����� 
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '��ʧҵ';               
           T_NUMLINE    :=  T_NUMLINE+1;
           
           -- ��ȡ����ͷ��Ϣ����������id
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
               'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.KSY_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵڰ���
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '��ס��������';        
          T_NUMLINE    :=  T_NUMLINE+1;
          
           -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
             T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.ZFGJJ_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵھ���
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '����ҵ���';        
          T_NUMLINE    :=  T_NUMLINE+1;
          
           -- ��ȡ����ͷ��Ϣ����������id
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
               'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
             T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.QYNJ_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�ʮ��
             SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '�۲���';         
            T_NUMLINE    :=  T_NUMLINE+1;
           
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.JJ_KMJE_DAI,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�ʮһ��
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = '����˰';         
            T_NUMLINE    :=  T_NUMLINE+1;
            
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
             T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.GRSDS_KMJE,
              'NEW',
              V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
   
           --�����м��  ���ҵ�ʮ����
            SELECT V.LOOKUP_CODE
             INTO JBGZ_KMJE_BM
             FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
              WHERE V.MEANING = 'ʵ������';         
            T_NUMLINE    :=  T_NUMLINE+1;
            
           -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
              T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
              V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
              '����',   --
              '����' || V_DQMONTH || '�¹���',--
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
              'CNY',
              T_NUMLINE,
              '���ű��¹���',
              0,
              REC_2.JBH_KMJE,
              'NEW',
              V_MAIN_ID,
               TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
              '�û�',
              '�˹�',
              '����',
              V_PERIODDATE,--�ڼ�
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
                             p_data_source    => 'SPMϵͳ',
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
     DBMS_OUTPUT.PUT_LINE('����״̬Ϊ��');
     DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
     DBMS_OUTPUT.PUT_LINE('����ԭ��Ϊ��');
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
                               V_MAIN_ID        IN  NUMBER, --��������
                               V_GLDATE         IN  VARCHAR2, --��������
                               V_PERIODDATE     IN  VARCHAR2, --�ڼ�
                               V_DQYEAR         IN  VARCHAR2, -- ��ǰ��
                               V_DQMONTH        IN  VARCHAR2, -- ��ǰ��
                               V_DQNUM          IN  VARCHAR2, --��ǰ��
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
    JBGZ_KMJE         NUMBER; \*�������ʵȿ�Ŀ���*\
    JJIN_KMJE         NUMBER; \*�½��ȿ�Ŀ��� �跽*\
    DSZNF_KMJE        NUMBER; \*���� �в���Ŀ���*\
    FSJWF_KMJE        NUMBER; \*����¿�Ŀ���*\
    JBYANGLBX_KMJE    NUMBER; \*�ۻ������Ͽ�Ŀ���*\
    JBYILBX_KMJE      NUMBER; \*��ҽ�Ʊ��տ�Ŀ���*\
    --BCYLBX_KMJE       NUMBER; \*����ҽ�Ʊ��տ�Ŀ���*\
    KSY_KMJE          NUMBER; \*��ʧҵ��Ŀ���*\
    ZFGJJ_KMJE        NUMBER; \*��ס���������Ŀ���*\
    QYNJ_KMJE         NUMBER; \*����ҵ����Ŀ���*\
    JJ_KMJE_DAI       NUMBER; \*���¼ٿ�Ŀ��� ����*\
    GRSDS_KMJE        NUMBER; \*����˰��Ŀ���*\
    JBH_KMJE          NUMBER; \*��������Ŀ��ʵ�����ʣ�*\
    
    JBGZ_KMJE_BM      NUMBER; \*�������ʵȿ�Ŀ����*\
    JJIN_KMJE_BM      NUMBER; \*�½��ȿ�Ŀ����*\
    DSZNF_KMJE_BM     NUMBER; \*���� �в��ȿ�Ŀ����*\
    FSJWF_KMJE_BM     NUMBER; \*����¿�Ŀ����*\
    JBYANGLBX_KMJE_BM NUMBER; \*�ۻ������Ͽ�Ŀ����*\
    JBYILBX_KMJE_BM   NUMBER; \*��ҽ�Ʊ��տ�Ŀ����*\
    --BCYLBX_KMJE_BM    NUMBER; \*����ҽ�Ʊ��տ�Ŀ����*\
    KSY_KMJE_BM       NUMBER; \*��ʧҵ��Ŀ����*\
    ZFGJJ_KMJE_BM     NUMBER; \*��ס���������Ŀ����*\
    QYNJ_KMJE_BM      NUMBER; \*����ҵ����Ŀ����*\
    JJ_KMJE_DAI_BM    NUMBER; \*���¼ٿ�Ŀ���� ����*\
    GRSDS_KMJE_BM     NUMBER; \*����˰��Ŀ����*\
    JBH_KMJE_BM       NUMBER; \*��������Ŀ���루ʵ�����ʣ�*\
    T_DATA_ID         NUMBER;
  
    --����main_id��ȡ���ұ���
    
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
       SELECT DISTINCT DEPTCODE AS DEPT_CODE
        FROM SPM_GZ_WAGEDATA W
       WHERE MAIN_ID = P_MAIN_ID;
    REC_1 CUR_1%ROWTYPE;
  
    --���մ��ҷ��飬��ѯ���ұ���͸���Ŀ���
    CURSOR CUR_2(P_DEPT_CODE VARCHAR2) IS
      SELECT *
        FROM (SELECT SUM(WA.GZYF_01+WA.GZYF_02 + WA.GZYF_03) AS JBGZ_KMJE,--�������ʵȽ��
                     SUM(WA.GZYF_04 + WA.GZYF_05 +WA.GZYF_06 + WA.GZYF_07 
                         + WA.GZYF_10 + WA.GZYF_11 + WA.GZYF_48 + WA.GZYF_49
                     ) AS JJIN_KMJE,--�½��Ƚ��
                     SUM(WA.GZYF_08+ WA.GZYF_09) DSZNF_KMJE,--���� �в��Ƚ��
                     SUM(WA.GZYF_12+WA.GZYF_19) FSJWF_KMJE,--����µȽ��
                     SUM(WA.GZKJ_01) JBYANGLBX_KMJE,--�ۻ������Ͻ��
                     SUM(WA.GZKJ_02+WA.GZKJ_03) JBYILBX_KMJE,--��ҽ�Ʊ��� �۴��ҽ�ƽ��
                     --SUM(WA.GZKJ_03) BCYLBX_KMJE,--ȥ��
                     SUM(WA.GZKJ_04) KSY_KMJE,--��ʧҵ���
                     SUM(WA.GZKJ_05) ZFGJJ_KMJE,--��ס����������
                     SUM(WA.GZKJ_06) QYNJ_KMJE,--����ҵ�����
                     SUM(WA.GZKJ_07 + WA.GZKJ_08) JJ_KMJE_DAI,--���¼� �۲��ٽ��
                     SUM(WA.WAGE_TAX1) GRSDS_KMJE,--����˰���
                     SUM(WA.WAGE_FACT) JBH_KMJE,--ʵ�����ʽ��
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
      V_RETURN_MESSAGE := '��ǰ�Ĺ��������Ѿ�ִ����ͬ���������';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
     T_NUMLINE := 0;
  
    --��ʼѭ��
    OPEN CUR_1(V_MAIN_ID);
    loop
  
      FETCH CUR_1
        INTO REC_1;
        exit when CUR_1%notfound;
  
      --��ȡ��˾���� ������ �޸���id �޸���
      SELECT DISTINCT WA.ORGCODE,WA.CREATED_BY,WA.LAST_UPDATE_LOGIN,WA.LAST_UPDATED_BY
        INTO T_ORG_CODE,T_CREATED_BY,T_LAST_UPDATE_LOGIN,T_LAST_UPDATED_BY
        FROM SPM_GZ_WAGEDATA WA
       WHERE WA.MAIN_ID = V_MAIN_ID;
  
      -- ��ȡϵͳʱ��
      SELECT TO_CHAR(sysdate, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      T_DEPT_CODE := REC_1.DEPT_CODE;
       
      FOR REC_2 IN CUR_2(T_DEPT_CODE) LOOP
                  
        BEGIN
  
          -- ��ȡ����ͷ��Ϣ����������id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
        T_NUMLINE    :=  T_NUMLINE+1;
        
        if REC_2.JBGZ_KMJE <>0 then 
          --�����м��  ���ҵ�һ��
          SELECT V.FLEX_VALUE 
            INTO JBGZ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '��������';
  
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
             LAST_UPDATE_DATE,--�޸�����
             LAST_UPDATED_BY, --�޸���
             LAST_UPDATE_LOGIN, --��¼��id
             CREATION_DATE, --��������
             CREATED_BY)    --������
          VALUES
            (T_HEADERS_ID,
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             REC_2.JBGZ_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
          --�����м��  ���ҵڶ���
         SELECT V.FLEX_VALUE 
            INTO JJIN_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '�½�';
           T_NUMLINE    := T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             REC_2.JJIN_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�����
          SELECT V.FLEX_VALUE 
            INTO DSZNF_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '����';        
           T_NUMLINE    := T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             REC_2.DSZNF_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�����
           SELECT V.FLEX_VALUE 
            INTO FSJWF_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '�����';         
        T_NUMLINE    := T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             REC_2.FSJWF_KMJE,
             0,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�����
           SELECT V.FLEX_VALUE 
            INTO JBYANGLBX_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '�ۻ�������';         
        T_NUMLINE    := T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.JBYANGLBX_KMJE,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�����
          SELECT V.FLEX_VALUE 
            INTO JBYILBX_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '��ҽ�Ʊ���';           
          T_NUMLINE  :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.JBYILBX_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
              V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�����       
           SELECT V.FLEX_VALUE 
            INTO KSY_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '��ʧҵ';        
          T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.KSY_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵڰ���
           SELECT V.FLEX_VALUE 
            INTO ZFGJJ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '��ס��������';         
         T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
            'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
            T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.ZFGJJ_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵھ���
           SELECT V.FLEX_VALUE 
            INTO QYNJ_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '����ҵ���';         
         T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
              'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
            T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.QYNJ_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�ʮ��
           SELECT V.FLEX_VALUE 
            INTO JJ_KMJE_DAI_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '�۲���';        
           T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.JJ_KMJE_DAI,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�ʮһ��
           SELECT V.FLEX_VALUE 
            INTO GRSDS_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = '����˰';         
           T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
            T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.GRSDS_KMJE,
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
  
          --�����м��  ���ҵ�ʮ����
          SELECT V.FLEX_VALUE 
            INTO JBH_KMJE_BM
            FROM SPM_GZGL_KJKMDZ_DETAIL_V V                   
             WHERE V.SEGMENT_VALUE_LOOKUP = 'ʵ������';          
           T_NUMLINE    :=  T_NUMLINE+1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             T_ORG_CODE || V_DQYEAR || V_DQMONTH || V_DQNUM,-- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || V_DQNUM || '�ι���', --
             '����',   --
             '����' || V_DQMONTH || '�¹���',--
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'),-- ��������
             'CNY',
             T_NUMLINE,
             '���ű��¹���',
             0,
             REC_2.JBH_KMJE,
             'NEW',
             V_MAIN_ID,
              TO_DATE(V_GLDATE, 'YYYY-MM-DD'),
             '�û�',
             '�˹�',
             '����',
             V_PERIODDATE,--�ڼ�
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
                            p_data_source    => 'SPMϵͳ',
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
    DBMS_OUTPUT.PUT_LINE('����״̬Ϊ��');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE('����ԭ��Ϊ��');*\
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
  --ר����ѯ�ѵ����������ƾ֤
  PROCEDURE SPM_EXPERT_FEE_CREATE_CERT(V_MAIN_ID        IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2) IS
    T_HEADERS_ID        NUMBER;
    T_NUMLINE           NUMBER;
    T_RETURN_CODE       VARCHAR2(40);
    T_RETURN_MESSAGE    VARCHAR2(4000);
    T_SYSDATE           VARCHAR2(20);
    V_GLDATE            VARCHAR2(40); --��������
    V_PERIODNAME        VARCHAR2(40); --�ڼ�
    T_ORG_CODE          VARCHAR2(20);
    V_DEPTCODE          VARCHAR2(20);
    T_CON_NAME          VARCHAR2(90);
    T_CREATED_BY        NUMBER; --������
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
    
    V_MATCH_DEPT          VARCHAR2(40); --�ʽ�ʹ����Ŀ
    V_MATCH_PROJECT       VARCHAR2(40); --�ʽ�ʹ�ò���
    
    V_KM     VARCHAR2(40);--���ɿ�Ŀ
    K_PROJECT VARCHAR2(40);--��Ŀ��

    --����main_id��ȡ���ұ���
  
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
      SELECT SUM(D.FACT_AMOUNT) AS YHCKJE, --���д����
             SUM(D.TAX_AMOUNT) AS YJSFJE, --Ӧ����������˰���
             SUM(D.PAY_AMOUNT) AS ZXFWFJE --��ѯ����ѽ��
        FROM SPM_EXPERT_FEE_DETAIL D
       WHERE D.FEE_MAIN_ID = P_MAIN_ID;
    REC_1 CUR_1%ROWTYPE;
  
  BEGIN
    --Ĭ��ֵ   50010625
    V_KM := '50010625';
    
    /*select P.PROJECT_CODE
      INTO K_PROJECT
      from SPM_CON_PROJECT P, SPM_EXPERT_FEE F
     WHERE P.ORG_ID = F.ORG_ID
       AND P.PROJECT_NAME like '%�޹���-%'
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
      --˵���Ѿ������
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '��ǰ�Ĺ��������Ѿ�ִ����ͬ���������';
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
      --˵���д����������м��
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID;
    END IF;
  
    T_NUMLINE := 0;
    BEGIN
      --��ʼѭ��
      OPEN CUR_1(V_MAIN_ID);
      LOOP
      
        FETCH CUR_1
          INTO REC_1;
        EXIT WHEN CUR_1%NOTFOUND;
      
        --��ȡ�������ơ����ŶΡ����п�Ŀ�Ρ�����ʱ�� ������ �޸���id �޸���
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
        --��ȡ������      
        CREATEDBYNAME := SPM_EAM_COMMON_PKG.GET_FULLNAME_BY_USERID(T_CREATED_BY);
        --��ȡ��˾�� 
        SELECT OU.SHORT_CODE
          INTO T_ORG_CODE
          FROM HR_OPERATING_UNITS OU
         WHERE OU.ORGANIZATION_ID = V_ORG_ID;
      
        -- ��ȡϵͳʱ��
        SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      
        -- ��ȡ����ͷ��Ϣ����������id
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
        DBMS_OUTPUT.PUT_LINE(T_HEADERS_ID);
        T_NUMLINE  := T_NUMLINE + 1;
        V_JE_NAME  := T_ORG_CODE || V_DQYEAR || V_DQMONTH || T_CON_NAME ||
                      V_MAIN_ID;
        V_GROUP_ID := V_MAIN_ID || V_DQYEAR || V_DQMONTH;
        IF REC_1.ZXFWFJE <> 0 THEN
          --�����м��  ��ѯ����ѵ�һ��
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
             LAST_UPDATE_DATE, --�޸�����
             LAST_UPDATED_BY, --�޸���
             LAST_UPDATE_LOGIN, --��¼��id
             CREATION_DATE, --��������
             CREATED_BY, --������
             GROUP_ID) --GROUP_ID
          VALUES
            (T_HEADERS_ID,
             'SPMϵͳ',
             V_JE_NAME, -- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || T_CON_NAME ||
             'ר����ѯ�ѱ�����', --
             'ר����ѯ��', --
             '����' || T_CON_NAME || 'ר����ѯ��', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '����' || T_CON_NAME || 'ר����ѯ��', --ժҪ
             REC_1.ZXFWFJE, --�跽���
             0, --�������
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             '�û�',
             'ר����ѯ��',
             '����',
             V_PERIODNAME, --�ڼ�
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
          --�����м��  Ӧ��˰�ѵڶ���       
          T_NUMLINE := T_NUMLINE + 1;
          -- ��ȡ����ͷ��Ϣ����������id
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
             'SPMϵͳ',
             V_JE_NAME, -- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || T_CON_NAME ||
             'ר����ѯ�ѱ�����', --
             'ר����ѯ��', --
             '����' || T_CON_NAME || 'ר����ѯ��', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '����' || T_CON_NAME || 'ר����ѯ��', --ժҪ
             0, --�跽���
             REC_1.YJSFJE, --�������                      
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             '�û�',
             'ר����ѯ��',
             '����',
             V_PERIODNAME, --�ڼ�
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
        
          --�����м��  ���д�������                  
          T_NUMLINE := T_NUMLINE + 1;
          -- ��ȡ����ͷ��Ϣ����������id
          SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL
            INTO T_HEADERS_ID
            FROM DUAL;
          --��ѯ���жο�Ŀ���
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
             'SPMϵͳ',
             V_JE_NAME, -- ������
             V_DQYEAR || '��' || V_DQMONTH || '��' || T_CON_NAME ||
             'ר����ѯ�ѱ�����', --
             'ר����ѯ��', --
             '����' || T_CON_NAME || 'ר����ѯ��', --
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '����' || T_CON_NAME || 'ר����ѯ��', --ժҪ
             0, --�跽���
             REC_1.YHCKJE, --�������            
             'NEW',
             V_MAIN_ID,
             TO_DATE(V_GLDATE, 'YYYY-MM-DD'), -- ��������
             '�û�',
             'ר����ѯ��',
             '����',
             V_PERIODNAME, --�ڼ�
             2021,
             V_CASH_FLOW,
             T_ORG_CODE,
             '00',
             V_BANKCAPTION, --���п�Ŀ           
             '00',
             '00',
             '00',
             '00',
             '00',
             YHDKMBM, --���ж�
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
                           P_DATA_SOURCE   => 'SPMϵͳ',
                           P_JE_BATCH_NAME => V_JE_NAME,
                           P_REPEANT       => 'Y');
    IF T_RETURN_CODE = 'S' THEN
      --T_RETURN_CODE := G_INTERFACE_SUCCESS;
      V_RETURN_CODE := T_RETURN_CODE;
    
      BEGIN
        -- �����ֽ���
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
      
        -- ����groupId
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
    DBMS_OUTPUT.PUT_LINE('����״̬Ϊ��');
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE('����ԭ��Ϊ��');*/
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

  --���Ʊ��֤
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
         AND SHEET_NAME = '��Ʊ����Ϣ'
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
         AND SHEET_NAME = '��Ʊ����Ϣ'
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
    KMDNUMBER        NUMBER; --��Ŀ��ֵcount
    --��¼���������ĺ�ͬ����Ŀ���ͻ�
    V_CONTRACT_ID NUMBER(15);
    V_PROJECT_ID  NUMBER(15);
    V_CUST_ID     NUMBER(15);
    V_USER_ID     NUMBER(15);
    V_DEPT_ID     NUMBER(15);
    V_VENDOR_ID   NUMBER(15); --��Ӧ��id
  
    P_MSG_H     VARCHAR2(2000) := 'ͷ��';
    P_MSG_L     VARCHAR2(2000) := '�б�';
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
    --��֤ EBS��Ʊ�����ڱ����Ƿ��Ѿ�����  
    SELECT COUNT(*)
      INTO INVOICENUMBER1
      FROM SPM_CON_INPUT_INVOICE I
     WHERE 1 = 1
       AND EXISTS (SELECT 1
              FROM SPM_IMPORT_TEMP_D D
             WHERE D.A = I.INVOICE_CODE
               AND D.TEMP_M_ID = P_BATCHCODE);
    --��Ϊ0ʱ �Ѿ����� 
    IF INVOICENUMBER1 <> 0 THEN
      P_MSG := 'EBS��Ʊ�����ϵͳ��ĺ������ظ�';
      RETURN;
    END IF;
    --��֤��EBS��Ʊ���������ͬ�����ʱ����ͬ����Ƿ���ͬ
    /* SELECT COUNT(1) INTO COUNTNUMBER1 FROM 
     (SELECT DISTINCT D.A FROM SPM_IMPORT_TEMP_D D 
       WHERE TEMP_M_ID = P_BATCHCODE
        AND SHEET_NAME = '��Ʊ����Ϣ'
        AND TO_NUMBER(ROW_NUMBER) >= 2
        AND D.A)
      WHERE 1 = 1;
    SELECT COUNT(1) INTO COUNTNUMBER2 FROM 
     (SELECT DISTINCT D.D FROM SPM_IMPORT_TEMP_D D 
       WHERE TEMP_M_ID = P_BATCHCODE
        AND SHEET_NAME = '��Ʊ����Ϣ'
        AND TO_NUMBER(ROW_NUMBER) >= 2)
      WHERE 1 = 1;
     IF COUNTNUMBER1 <> COUNTNUMBER2 THEN
        P_MSG := 'EBS��Ʊ������ͬʱ����ͬ������������д��ڲ���ͬ�����';
     RETURN;
    END IF;*/
    --��֤����Ϣ��EBS��Ʊ�����Ƿ񶼴���������ϢEBS��Ʊ����   
    SELECT COUNT(*)
      INTO INVOICENUMBER2
      FROM (SELECT DISTINCT D.A
              FROM SPM_IMPORT_TEMP_D D
             WHERE 1 = 1
               AND D.TEMP_M_ID = P_BATCHCODE
               AND D.SHEET_NAME = '��Ʊ����Ϣ'
               AND TO_NUMBER(ROW_NUMBER) >= 2) DL
     WHERE 1 = 1
       AND NOT EXISTS (SELECT 1
              FROM (SELECT DISTINCT D.A
                      FROM SPM_IMPORT_TEMP_D D
                     WHERE 1 = 1
                       AND D.TEMP_M_ID = P_BATCHCODE
                       AND D.SHEET_NAME = '��Ʊ����Ϣ'
                       AND TO_NUMBER(ROW_NUMBER) >= 2) DH
             WHERE DH.A = DL.A);
    --��Ϊ0ʱ �к����в���������������
    IF INVOICENUMBER2 <> 0 THEN
      P_MSG := '��Ʊ����Ϣ��EBS��Ʊ����������Ϣ�Աȴ��ڶ���ķ�Ʊ����';
      RETURN;
    END IF;
  
    --��֤����Ϣ�ĺ�ͬ����Ƿ񶼴���������Ϣ��ͬ�����
    SELECT COUNT(*)
      INTO CONCODENUMBER
      FROM (SELECT DISTINCT D.B
              FROM SPM_IMPORT_TEMP_D D
             WHERE 1 = 1
               AND D.TEMP_M_ID = P_BATCHCODE
               AND D.SHEET_NAME = '��Ʊ����Ϣ'
               AND TO_NUMBER(ROW_NUMBER) >= 2
               AND D.B IS NOT NULL) DL
     WHERE 1 = 1
       AND NOT EXISTS (SELECT 1
              FROM (SELECT DISTINCT D.D
                      FROM SPM_IMPORT_TEMP_D D
                     WHERE 1 = 1
                       AND D.TEMP_M_ID = P_BATCHCODE
                       AND D.SHEET_NAME = '��Ʊ����Ϣ'
                       AND TO_NUMBER(ROW_NUMBER) >= 2
                       AND D.B IS NOT NULL) DH
             WHERE DH.D = DL.B);
    --��Ϊ0ʱ �к�ͬ����в�������Ϣ��ͬ���������
    IF CONCODENUMBER <> 0 THEN
      P_MSG := '��Ʊ����Ϣ��ͺ�ͬ�����������������Ϣ�Աȴ��ڶ���ĺ�ͬ���';
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
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA_HEAD%FOUND THEN
    
      IF VALIDATE_A <> 'EBS��Ʊ����' OR VALIDATE_B <> '��Ʊ����' OR
         VALIDATE_C <> '��Ʊ����' OR VALIDATE_D <> '��ͬ�����������' OR
         VALIDATE_E <> '��ͬ����' OR VALIDATE_F <> '��Ŀ����' OR
         VALIDATE_G <> '��λ����' OR VALIDATE_H <> '��Ʊ����' OR
         VALIDATE_I <> '��Ʊ����' OR VALIDATE_J <> 'ժҪ' OR VALIDATE_K <> '�Ǽ�ʱ��' OR
         VALIDATE_L <> '��Ӧ�̵ص�' OR VALIDATE_M <> '��Ʊ���' OR
         VALIDATE_N <> '˰��' OR VALIDATE_O <> '˰��' OR VALIDATE_P <> '��Ʒ����' OR
         VALIDATE_Q <> '����˰����' OR VALIDATE_R <> '���㲿��' OR
         VALIDATE_S <> '��ע' OR VALIDATE_T <> '��ݵ���' OR VALIDATE_U <> '�ռ���' THEN
        P_MSG := '�������ݵ����������ϸ�ʽ';
        CLOSE CU_DATA_HEAD;
        RETURN;
      END IF;
    
      IF CU_DATA_LINE%FOUND THEN
        IF VALIDATE_A1 <> 'EBS��Ʊ����' OR VALIDATE_B1 <> '��ͬ�����������' OR
           VALIDATE_C1 <> '��ⵥ��' OR VALIDATE_D1 <> '����˰���' OR
           VALIDATE_E1 <> 'ժҪ' OR VALIDATE_F1 <> '��Ŀ��' THEN
          P_MSG := '�������ݵ��б����������ϸ�ʽ';
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
      
        -- ��֤A��B C ��G��H��I��J��M��N��O P �Ƿ�Ϊ��
        IF VALIDATE_A IS NULL THEN
          --EBS��Ʊ�����Ƿ�Ϊ��
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_B IS NULL THEN
          --��Ʊ�����Ƿ�Ϊ��
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_C IS NULL THEN
          --��Ʊ�����Ƿ�Ϊ��
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
          --��λ�����Ƿ�Ϊ��
          IF MSG_G IS NULL THEN
            MSG_G := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_G := MSG_G || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_H IS NULL THEN
          --��Ʊ�����Ƿ�Ϊ��
          IF MSG_H IS NULL THEN
            MSG_H := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_H := MSG_H || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_I IS NULL THEN
          --��Ʊ�����Ƿ�Ϊ��  
          IF MSG_I IS NULL THEN
            MSG_I := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_I := MSG_I || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_J IS NULL THEN
          --ժҪ�Ƿ�Ϊ��
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
          --��Ʊ����Ƿ�Ϊ��
          IF MSG_M IS NULL THEN
            MSG_M := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_M := MSG_M || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_N IS NULL THEN
          --˰���Ƿ�Ϊ��
          IF MSG_N IS NULL THEN
            MSG_N := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_N := MSG_N || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_O IS NULL THEN
          --˰���Ƿ�Ϊ��
          IF MSG_O IS NULL THEN
            MSG_O := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_O := MSG_O || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        IF VALIDATE_P IS NULL THEN
          --��Ʒ�����Ƿ�Ϊ��
          IF MSG_P IS NULL THEN
            MSG_P := CU_DATA_HEAD%ROWCOUNT + 1;
          ELSE
            MSG_P := MSG_P || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
          END IF;
        END IF;
        -- ��Ʊ�����ظ�����֤
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
        -- ��ͬ�����֤
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
            --��֤��ͬ���Ƶ�һ����
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
      
        --��Ŀ������֤
        IF VALIDATE_F IS NOT NULL THEN
          --��֤�ù�˾��00��Ŀ
          IF VALIDATE_F = '00' THEN
            SELECT COUNT(1)
              INTO VALIDATE_NUMBER
              FROM SPM_CON_PROJECT P
             WHERE P.PROJECT_NAME LIKE '%�޹���-%'
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
              --��¼���������Ĺ���ID
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
      
        -- ��Ӧ�� ��λ������֤
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
      
        -- ��Ʊ������֤
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
      
        -- ��Ʊʱ���ʽУ��
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
      
        -- �Ǽ�ʱ���ʽУ��
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
      
        -- ��Ӧ�̵ص��Ƿ������֤
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
        -- ��Ʊ���������֤
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
      
        --У��˰�ʣ�%���Ƿ�Ϊ�̶�ֵ
        IF VALIDATE_N IS NOT NULL THEN
          SELECT COUNT(*)
            INTO VALIDATE_NUMBER2
            FROM DUAL
           WHERE VALIDATE_N IN (0��3��5��10��11��16��17);
          IF VALIDATE_NUMBER2 = 0 THEN
            --���ڹ̶�ֵ��Χ��
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          ELSE
            IF VALIDATE_H = '��ֵ˰ר�÷�Ʊ' AND VALIDATE_N = '0' THEN
              IF MSG_N1 IS NULL THEN
                MSG_N1 := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_N1 := MSG_N1 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            END IF;
            IF VALIDATE_H = '����' AND VALIDATE_N <> '0' THEN
              IF MSG_N2 IS NULL THEN
                MSG_N2 := CU_DATA_HEAD%ROWCOUNT + 1;
              ELSE
                MSG_N2 := MSG_N2 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
              END IF;
            END IF;
          END IF;
        END IF;
      
        -- ˰��������֤
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
          IF VALIDATE_P <> '����' AND VALIDATE_P <> '����' THEN
            IF MSG_P1 IS NULL THEN
              MSG_P1 := CU_DATA_HEAD%ROWCOUNT + 1;
            ELSE
              MSG_P1 := MSG_P1 || ',' || CU_DATA_HEAD%ROWCOUNT + 1;
            END IF;
          END IF;
        END IF;
        --����˰������ֵ��֤
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
        -- ���㲿����֤
        IF VALIDATE_R IS NOT NULL THEN
          SELECT COUNT(1)
            INTO VALIDATE_NUMBER
            FROM FND_FLEX_VALUES_VL V
           WHERE FLEX_VALUE_SET_ID =
                 (SELECT F.FLEX_VALUE_SET_ID
                    FROM FND_FLEX_VALUE_SETS F
                   WHERE F.FLEX_VALUE_SET_NAME = 'DT ����')
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
      
        -- ��֤��ͬ����Ŀ�빩Ӧ�̵Ĺ�����ϵ
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
      --��������֤
      IF VALIDATE_A1 IS NULL THEN
        --EBS��Ʊ�����Ƿ�Ϊ��
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
           AND D.SHEET_NAME = '��Ʊ����Ϣ'
           AND D.TEMP_M_ID = P_BATCHCODE;
      END IF;
      IF SERVICETYPE = '����' THEN
        IF VALIDATE_B1 IS NULL AND VALIDATE_C1 IS NULL THEN
          IF MSG_B1 IS NULL THEN
            MSG_B1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_B1 := MSG_B1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      IF SERVICETYPE = '����' THEN
        ---��Ʒ����Ϊ����ʱ ����˰����Ƿ�Ϊ��
        IF VALIDATE_D1 IS NULL THEN
          IF MSG_D1 IS NULL THEN
            MSG_D1 := CU_DATA_LINE%ROWCOUNT + 1;
          ELSE
            MSG_D1 := MSG_D1 || ',' || CU_DATA_LINE%ROWCOUNT + 1;
          END IF;
        END IF;
      END IF;
      IF VALIDATE_E1 IS NULL THEN
        --ժҪ�Ƿ�Ϊ��
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
    
      -- ����Ϣ ��Ʊ�����ظ�����֤
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
      --��ⵥ����Ч����֤
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
      -- ����˰���������֤
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
      --��Ŀ����֤ 
      IF VALIDATE_F1 IS NOT NULL THEN
        SELECT COUNT(1)
          INTO KMDNUMBER --��Ŀ��ֵcount
          FROM (SELECT V.FLEX_VALUE AS VALUE, V.DESCRIPTION AS NAME
                  FROM FND_FLEX_VALUES_VL V
                 WHERE FLEX_VALUE_SET_ID =
                       (SELECT F.FLEX_VALUE_SET_ID
                          FROM FND_FLEX_VALUE_SETS F
                         WHERE F.FLEX_VALUE_SET_NAME = 'DT ��Ŀ')
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
      MSG_A := MSG_A || '�� EBS��Ʊ����Ϊ��;';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '�� ��Ʊ����Ϊ��;';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '�� ��Ʊ����Ϊ��;';
    END IF;
    IF MSG_D IS NOT NULL THEN
      MSG_D := MSG_D || '�� ��ͬ�����д����;';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '�� ��ͬ������д��������ͬ��Ų���Ӧ;';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '�� δ�ҵ���Ӧ��Ŀ;';
    END IF;
    IF MSG_FF IS NOT NULL THEN
      MSG_FF := MSG_FF || '�� δ�ҵ���Ӧ���޹���;';
    END IF;
    IF MSG_G IS NOT NULL THEN
      MSG_G := MSG_G || '�� ��λ����Ϊ�ջ���д����;';
    END IF;
    IF MSG_H IS NOT NULL THEN
      MSG_H := MSG_H || '�� ��Ʊ����Ϊ�ջ���д����;';
    END IF;
    IF MSG_I IS NOT NULL THEN
      MSG_I := MSG_I || '�� ��Ʊʱ��Ϊ�ջ��ʽ����;';
    END IF;
    IF MSG_J IS NOT NULL THEN
      MSG_J := MSG_J || '�� ժҪΪ�ջ���д����;';
    END IF;
    IF MSG_K IS NOT NULL THEN
      MSG_K := MSG_K || '�� �Ǽ�ʱ���ʽ����;';
    END IF;
    IF MSG_L IS NOT NULL THEN
      MSG_L := MSG_L || '�� ��Ӧ����д����;';
    END IF;
    IF MSG_M IS NOT NULL THEN
      MSG_M := MSG_M || '�� ��Ʊ���Ϊ�ջ���д��ʽ����;';
    END IF;
    IF MSG_N IS NOT NULL THEN
      MSG_N := MSG_N || '�� ˰�ʲ��ھ���ֵ������0,3,5,10,11,16,17����Χ��;';
    END IF;
    IF MSG_N1 IS NOT NULL THEN
      MSG_N1 := MSG_N1 || '�� ��Ʊ����Ϊ��ֵ˰ר�÷�Ʊʱ��������˰��Ϊ0;';
    END IF;
    IF MSG_N2 IS NOT NULL THEN
      MSG_N2 := MSG_N2 || '�� ��Ʊ����Ϊ����ʱ��˰��ֻ����Ϊ0;';
    END IF;
    IF MSG_O IS NOT NULL THEN
      MSG_O := MSG_O || '�� ˰��Ϊ�ջ���д��ʽ����;';
    END IF;
    IF MSG_P IS NOT NULL THEN
      MSG_P := MSG_P || '�� ��Ʒ����Ϊ��;';
    END IF;
    IF MSG_P1 IS NOT NULL THEN
      MSG_P1 := MSG_P1 || '�� ��Ʒ����ֻ��Ϊ��������;';
    END IF;
    IF MSG_Q IS NOT NULL THEN
      MSG_Q := MSG_Q || '�� ����˰������д��ʽ����;';
    END IF;
    IF MSG_R IS NOT NULL THEN
      MSG_R := MSG_R || '�� δ�ҵ���Ӧ�ĺ��㲿��;';
    END IF;
    IF MSG_S IS NOT NULL THEN
      MSG_S := MSG_S || '�� ��ͬ����Ŀ�빩Ӧ�̵Ĺ�����ϵ����Ӧ;';
    END IF;
  
    --����Ϣ  
    IF MSG_A1 IS NOT NULL THEN
      MSG_A1 := MSG_A1 || '�� ��Ʊ����Ϊ�ջ���д����;';
    END IF;
    /* IF MSG_B1 IS NOT NULL THEN
      MSG_B1 := MSG_B1 || '�� ������������Ϊ�ջ���д����;';
    END IF;*/
    IF MSG_B1 IS NOT NULL THEN
      MSG_B1 := MSG_B1 || '�� ��Ʒ����Ϊ����ʱ����ͬ����������š���ⵥ�����߲���ȫΪ��;';
    END IF;
    IF MSG_C1 IS NOT NULL THEN
      MSG_C1 := MSG_C1 || '�� ��ⵥ����д����;';
    END IF;
    IF MSG_D1 IS NOT NULL THEN
      MSG_D1 := MSG_D1 || '�� ����˰���Ϊ�ջ���д��ʽ����;';
    END IF;
    IF MSG_D2 IS NOT NULL THEN
      MSG_D2 := MSG_D2 || '�� ����˰������Ϊ0��ֵ;';
    END IF;
    IF MSG_E1 IS NOT NULL THEN
      MSG_E1 := MSG_E1 || '�� ժҪΪ�ջ���д����;';
    END IF;
    IF MSG_F1 IS NOT NULL THEN
      MSG_F1 := MSG_F1 || '�� ��Ŀ����д����;';
    END IF;
  
    P_MSG_H := P_MSG_H || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E ||
               MSG_F || MSG_FF || MSG_G || MSG_H || MSG_I || MSG_J || MSG_K ||
               MSG_L || MSG_M || MSG_N || MSG_N1 || MSG_N2 || MSG_O ||
               MSG_P || MSG_P1 || MSG_Q || MSG_R || MSG_S;
  
    P_MSG_L := P_MSG_L || MSG_A1 || MSG_B1 || MSG_C1 || MSG_D1 || MSG_D2 ||
               MSG_E1 || MSG_F1;
  
    IF P_MSG_H = 'ͷ��' THEN
      P_MSG_H := NULL;
    END IF;
  
    IF P_MSG_L = '�б�' THEN
      P_MSG_L := NULL;
    END IF;
  
    P_MSG := P_MSG_H || P_MSG_L;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END BATCH_INPUT_VALIDATE;

  -- ���Ʊ����
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
         AND SHEET_NAME = '��Ʊ����Ϣ'
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
         AND SHEET_NAME = '��Ʊ����Ϣ'
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
    --��¼���������ĺ�ͬ����Ŀ���ͻ�(��Ӧ��)
    V_CONTRACT_ID           NUMBER(15);
    V_PROJECT_ID            NUMBER(15);
    V_CUST_ID               NUMBER(15);
    V_VENDOR_ID             NUMBER(15);
    V_VENDOR_SITE_ID        NUMBER(15); --��Ӧ�̵ص�id
    V_GYSID                 NUMBER(15); --��Ӧ�̵ص�
    V_USER_ID               NUMBER(15);
    V_DEPT_ID               NUMBER(15);
    V_PERSON_ID             NUMBER(15); --
    V_INVOICE_SERIAL_NUMBER VARCHAR2(100);
    V_INVOICETYPE           VARCHAR2(5); --��Ʊ����
    INVOICETAXAMOUNT        NUMBER; --����˰��� ���ܽ�
    WHAMOUNTMONEY           NUMBER; --��ⵥ�µĲ���˰��� 
    NOTAXDIF                NUMBER; --����˰����
    NOCONTRACT              VARCHAR2(2);
    V_INPUT_INVOICE_ID      NUMBER(15); --���Ʊ����
    CONTRACTID              NUMBER(15);
    WAREHOUSEID             NUMBER(15);
    EBSDEPTCODE             VARCHAR2(40); --���㲿��code
    PAYMENTSTATUS           VARCHAR2(40); --�������
    SERVICETYPE             VARCHAR2(40); --��Ʒ����
    DEPTSEC                 VARCHAR2(40); --���Ŷ� 
    SUBSEC                  VARCHAR2(40); --��Ŀ��
    DEALINGSSEC             VARCHAR2(40); --������
    PROJECTSEC              VARCHAR2(40); --��Ŀ��
    PRODUCTSEC              VARCHAR2(40); --��Ʒ��
    VENDORNAME              VARCHAR2(200); --��λ����
    PROJECTNAME             VARCHAR2(200); --��Ŀ����
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
               FROM ����
              GROUP BY NAMEC, MEDICINEMODEL, OUTLOOKC, MEMO2
              ORDER BY BIDPRICE)
      WHERE ROWNUM = 1;*/
      IF VALIDATE_D IS NOT NULL AND VALIDATE_E IS NOT NULL THEN
        --��ͬ
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
        --��Ŀ��֤�Ƿ����
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
         WHERE P.PROJECT_NAME LIKE '%�޹���-%'
           AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
      END IF;
      -- ��Ӧ������ת����id
      SELECT VI.VENDOR_ID
        INTO V_VENDOR_ID
        FROM SPM_CON_VENDOR_INFO VI
       WHERE 1 = 1
         AND VI.VENDOR_NAME = VALIDATE_G
         AND VI.STATUS = 'E';
    
      IF VALIDATE_L IS NOT NULL THEN
        --��Ӧ�̵ص�ID
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
           AND T.VENDOR_SITE_CODE = '��Ʒ�ɹ�'
           AND PP.VENDOR_NAME = VALIDATE_G
           AND ROWNUM = 1;
        V_VENDOR_SITE_ID := V_GYSID;
      END IF;
      --�жϷ�Ʊ����   
      IF VALIDATE_H = '��ֵ˰ר�÷�Ʊ' THEN
        V_INVOICETYPE := 'A';
      ELSIF VALIDATE_H = '��ֵ˰��ͨ��Ʊ' THEN
        V_INVOICETYPE := 'B';
      ELSE
        V_INVOICETYPE := 'C';
      END IF;
      --�жϲ�Ʒ����
      IF VALIDATE_P = '����' THEN
        PAYMENTSTATUS := 'F';
        NOTAXDIF      := '';
        --����˰������
        SELECT VALIDATE_M - VALIDATE_O INTO INVOICETAXAMOUNT FROM DUAL; --��Ʊ���-˰��-����˰����
      ELSE
        --������
        PAYMENTSTATUS := 'Y';
        IF VALIDATE_Q IS NULL THEN
          NOTAXDIF := 0;
        ELSE
          NOTAXDIF := VALIDATE_Q;
        END IF;
        --����˰������
        SELECT VALIDATE_M - VALIDATE_O - NOTAXDIF
          INTO INVOICETAXAMOUNT
          FROM DUAL; --��Ʊ���-˰��-����˰����
      END IF;
      --����Ǽ�ʱ��Ϊ�� ȡϵͳ��ǰʱ��
      IF VALIDATE_K IS NULL THEN
        VALIDATE_K := SYSDATE;
      END IF;
      --�Ƿ��޺�ͬ
      IF VALIDATE_D IS NULL THEN
        NOCONTRACT := 'Y';
      ELSE
        NOCONTRACT := '';
      END IF;
      --���ݵ�¼��userid ��ȡpersonid 
      SELECT T.PERSON_ID
        INTO V_PERSON_ID
        FROM SPM_EAM_ALL_PEOPLE_V T
       WHERE T.USER_ID = V_USER_ID;
      --���㲿��
      IF VALIDATE_R IS NOT NULL THEN
        SELECT FLEX_VALUE
          INTO EBSDEPTCODE
          FROM FND_FLEX_VALUES_VL V
         WHERE FLEX_VALUE_SET_ID =
               (SELECT F.FLEX_VALUE_SET_ID
                  FROM FND_FLEX_VALUE_SETS F
                 WHERE F.FLEX_VALUE_SET_NAME = 'DT ����')
           AND V.ENABLED_FLAG = 'Y'
           AND DESCRIPTION = VALIDATE_R;
      ELSE
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
      END IF;
    
      --��������
      INSERT INTO SPM_CON_INPUT_INVOICE
        (INPUT_INVOICE_ID, --���Ʊ��������
         VENDOR_ID, --��Ӧ��id
         INVOICE_CONTENT, --ժҪ
         INVOICE_TYPE, --��Ʊ����
         INVOICE_CODE, --��Ʊ����
         INVOICE_AMOUNT, --��Ʊ���
         CURRENCY_TYPE, --��Ʊ������
         PROJECT_ID, --������ĿID
         CONTRACT_ID, --������ͬID       
         VERIFIC_IMPREST_AMOUNT, --����Ԥ������
         CREATED_BY, --�ǼǾ�����
         CREATION_DATE, --�Ǽ�����
         LAST_UPDATE_DATE, -- ����޸�ʱ��     
         STATUS, --����״̬
         ORG_ID, --��������ID
         DEPT_ID, --��������ID
         RESIDUAL_AMOUNT, --ʣ����
         BILLING_DATE, --��Ʊ����
         PAYMENT_TERM, --��������
         PAYMENT_TYPE, --���ʽ
         VENDOR_SITE_ID, --��Ӧ�̵ص�ID
         TAX_AMOUNT, --˰��
         INVOICETAX_AMOUNT, --�ܽ�� ����˰���
         TAX_RATE, --˰��
         NO_TAX_DIF, --����˰������
         NO_CONTRACT, --�Ƿ��޺�ͬ
         EBS_DEPT_CODE, --���㲿��code
         PAYMENT_STATUS, --�������        
         EBS_STATUS, --EBSͬ��״̬
         EBS_TYPE --��Ʊ����EBS
         )
      VALUES
        (SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL,
         V_VENDOR_ID, --��Ӧ��id
         VALIDATE_J, --ժҪ        
         V_INVOICETYPE, --��Ʊ����
         VALIDATE_A, --EBS��Ʊ����
         ROUND(VALIDATE_M, 2), --��Ʊ���
         'CNY', --��Ʊ������
         V_PROJECT_ID, --������ĿID
         V_CONTRACT_ID, --������ͬID
         0, -- --����Ԥ������
         V_USER_ID, --�ǼǾ�����  
         SYSDATE,
         --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--�Ǽ����� 
         SYSDATE, --����޸�ʱ��
         'A', --����״̬
         SPM_SSO_PKG.GETORGID, --��������ID
         V_DEPT_ID, --��������ID
         ROUND(VALIDATE_M, 2), --ʣ����        
         TO_DATE(SUBSTR(VALIDATE_I, 1, 10), 'yyyy-mm-dd'), --��Ʊ����
         '10000', --��������
         'WIRE', --���ʽ
         V_VENDOR_SITE_ID, --��Ӧ�̵ص�ID
         ROUND(VALIDATE_O, 2), --˰��
         ROUND(INVOICETAXAMOUNT, 2), --�ܽ�� ����˰���
         VALIDATE_N, --˰��
         NOTAXDIF, --0, --����˰������
         NOCONTRACT, --�Ƿ��޺�ͬ
         EBSDEPTCODE, --���㲿��
         PAYMENTSTATUS, --�������
         'N', --EBSͬ��״̬
         'STANDARD' --��Ʊ����EBS
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
    
      --�������ƱID
      SELECT I.INPUT_INVOICE_ID
        INTO V_INPUT_INVOICE_ID
        FROM SPM_CON_INPUT_INVOICE I
       WHERE I.INVOICE_CODE = VALIDATE_A1
         AND I.ORG_ID = SPM_SSO_PKG.GETORGID;
      --�����ͬ����������� ��Ϊ��ʱ  ���ݺ�ͬ����Ȳ鵽��ͬid  �ٸ��ݺ�ͬid ȥ��ⵥ�������ⵥid
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
        --�����ⵥ�Ų�Ϊ�� ������ⵥ�Ų�ѯ��ⵥid 
        SELECT WH.WAREHOUSE_ID
          INTO WAREHOUSEID
          FROM SPM_CON_WAREHOUSE WH
         WHERE WH.WAREHOUSE_CODE = VALIDATE_C1;
      ELSIF VALIDATE_B1 IS NULL AND VALIDATE_C1 IS NULL THEN
        WAREHOUSEID := '';
      END IF;
      --�����ⵥ�Ų�Ϊ��,������ⵥ�Ų�ѯ����˰������
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
          INTO SERVICETYPE, VENDORNAME, PROJECTNAME --��Ʒ����
          FROM SPM_IMPORT_TEMP_D D
         WHERE D.A = VALIDATE_A1
           AND D.SHEET_NAME = '��Ʊ����Ϣ'
           AND D.TEMP_M_ID = P_BATCHCODE;
      END IF;
      IF SERVICETYPE = '����' THEN
        DEPTSEC     := '';
        SUBSEC      := '';
        DEALINGSSEC := '';
        PROJECTSEC  := '';
        PRODUCTSEC  := '';
      END IF;
      IF SERVICETYPE = '����' THEN
        PRODUCTSEC := '00';
        --���ݵ�¼��userid ��ȡpersonid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --��ȡ���Ŷ�
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO DEPTSEC
          FROM DUAL;
        IF DEPTSEC IS NULL THEN
          DEPTSEC := '00';
        END IF;
        --��ȡ������
        SELECT V.VALUE
          INTO DEALINGSSEC
          FROM (SELECT FLEX_VALUE AS VALUE, DESCRIPTION AS NAME
                  FROM FND_FLEX_VALUES_VL
                 WHERE FLEX_VALUE_SET_ID =
                       (SELECT F.FLEX_VALUE_SET_ID
                          FROM FND_FLEX_VALUE_SETS F
                         WHERE F.FLEX_VALUE_SET_NAME = 'DT ����')
                 ORDER BY FLEX_VALUE) V
         WHERE 1 = 1
           AND (V.NAME = VENDORNAME); -- OR V.VALUE = '00')
        IF DEALINGSSEC IS NULL THEN
          DEALINGSSEC := '00';
        END IF;
        --��ȡ��Ŀ��
        IF PROJECTNAME IS NOT NULL THEN
          SELECT V.VALUE
            INTO PROJECTSEC
            FROM (SELECT D.��Ŀ��� AS VALUE, D.��Ŀ���� AS NAME
                    FROM DT_PROJECT D) V
           WHERE 1 = 1
             AND V.NAME = PROJECTNAME;
        ELSE
          SELECT P.PROJECT_CODE
            INTO PROJECTSEC
            FROM SPM_CON_PROJECT P
           WHERE P.PROJECT_NAME LIKE '%�޹���-%'
             AND P.ORG_ID = SPM_SSO_PKG.GETORGID;
        END IF;
        --��ȡ��Ŀ��
        IF VALIDATE_F1 IS NOT NULL THEN
          SELECT KM.VALUE
            INTO SUBSEC
            FROM (SELECT V.FLEX_VALUE AS VALUE, V.DESCRIPTION AS NAME
                    FROM FND_FLEX_VALUES_VL V
                   WHERE FLEX_VALUE_SET_ID =
                         (SELECT F.FLEX_VALUE_SET_ID
                            FROM FND_FLEX_VALUE_SETS F
                           WHERE F.FLEX_VALUE_SET_NAME = 'DT ��Ŀ')
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
        (INPUT_WAREHOUSE_ID, --����
         INPUT_INVOICE_ID, --���Ʊ����
         WAREHOUSE_ID, --��ⵥ����ID
         CREATED_BY, --������
         CREATION_DATE, --����ʱ��
         LAST_UPDATE_DATE, --����޸�ʱ��
         ORG_ID, --��������id
         DEPT_ID, --��������ID
         REMARK, --ժҪ        
         MONEY_AMOUNT, --�н��  ����˰���
         DEPT_SEC, --���Ŷ�
         SUB_SEC, --��Ŀ��
         DEALINGS_SEC, --������
         PROJECT_SEC, --��Ŀ��
         PRODUCT_SEC --��Ʒ��
         )
      VALUES
        (SPM_CON_INPUT_WAREHOUSE_SEQ.NEXTVAL, --����
         V_INPUT_INVOICE_ID, --���Ʊ����
         WAREHOUSEID, --��ⵥ����ID
         V_USER_ID, --������
         SYSDATE, --����ʱ��
         SYSDATE, ----����޸�ʱ��
         SPM_SSO_PKG.GETORGID, --��������id
         V_DEPT_ID, --��������ID
         VALIDATE_E1, --ժҪ
         ROUND(WHAMOUNTMONEY, 2), --�н��  ����˰���  
         DEPTSEC, --���Ŷ�
         SUBSEC, --��Ŀ��
         DEALINGSSEC, --������
         PROJECTSEC, --��Ŀ��
         PRODUCTSEC --��Ʒ��              
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

  /*�ɹ�������Ʊ��Ϣ��������Ϣ�м��*/
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
      (SPM_CON_MQ_MESSAGE_SEQ.NEXTVAL, --����
       --V_CONFIGURE_ID, --���ñ�id
       122,
       'SPM_CON_INPUT_INVOICE', --ҵ���
       'POINVOICESYNC', --ҵ���ʶ
       V_ID, --ҵ��id
       V_MSG, ----��Ϣ����
       V_CREATEDBY, --������
       V_CREATION_DATE, --��������
       V_LAST_UPDATED_BY, --�޸���
       V_LAST_UPDATE_DATE, --�޸�����
       V_LAST_UPDATE_LOGIN, --login
       V_ORG_ID, --������֯id
       V_DEPT_ID, --��������id       
       '�ɹ�������Ʊ��Ϣͬ��' --��ע                    
       );
    COMMIT;
    V_RETURN_CODE    := 'S';
    V_RETURN_MESSAGE := '�����м��ɹ�';
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE    := 'E';
      V_RETURN_MESSAGE := '�����м������쳣������ϵ����Ա';
      RETURN;
  END;
  --END SPM_CON_SYNC_INVOICEINFO;

  /*���ݲɹ��������ɽ��Ʊ*/
  PROCEDURE CREATE_INPUT_INVOICE(V_IDS         IN VARCHAR2,
                                 V_RETURN_CODE OUT VARCHAR2,
                                 V_RETURN_MSG  OUT VARCHAR2) IS
    IDS              SPM_TYPE_TBL;
    V_CODE           VARCHAR2(40);
    V_USER_ID        NUMBER := SPM_SSO_PKG.GETUSERID;
    V_ORG_ID         NUMBER := SPM_SSO_PKG.GETORGID;
    V_DEPT_ID        NUMBER;
    V_INVOICECODE    VARCHAR2(40); --��Ʊ����
    EBSDEPTCODE      VARCHAR2(40); --���㲿��code
    V_TAXRATE        VARCHAR2(40); --˰��
    V_PERSON_ID      NUMBER(15); --
    V_VENDOR_SITE_ID NUMBER(15); --��Ӧ�̵ص�id
    V_CONTRACT_ID    NUMBER(15);
    V_PROJECT_ID     NUMBER(15);
    V_VENDOR_ID      NUMBER(15);
    V_VENDORNAME     VARCHAR2(40);
    INVOICETAXAMOUNT NUMBER; --����˰��� ���ܽ�
    V_TAXAMOUNT      NUMBER; --˰��
    V_INVOICEAMOUNT  NUMBER; --��Ʊ���
    V_NUMBER1        NUMBER;
    V_CODE_PRE       VARCHAR2(40);
  BEGIN
    -- ������Ϣ
    SELECT T.ORGANIZATION_ID
      INTO V_DEPT_ID
      FROM SPM_CON_HT_PEOPLE_V T
     WHERE ROWNUM < 2
       AND T.BELONGORGID = 89 --V_ORG_ID
       AND T.PERSON_ID = SPM_EAM_COMMON_PKG.GET_PERSONID_BY_USERID(1851); --V_USER_ID);
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_INPUT_CODE');
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        SELECT M.CONTRACT_CODE
          INTO V_CODE
          FROM SPM_CON_HT_INFO M
         WHERE M.CONTRACT_ID = IDS(I);
        --��ȡ��ͬid ��Ŀid ��Ӧ��id ��Ӧ������ ˰��
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
        --������ˮ�Ź������ɷ�Ʊ���� 
        V_INVOICECODE := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_INPUT_INVOICE',
                                                            'INVOICE_CODE',
                                                            'FM000000',
                                                            V_CODE_PRE);
      
        --���ݵ�¼��userid ��ȡpersonid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --���㲿��                         
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
        --��Ӧ�̵ص�
        /* SELECT T.VENDOR_SITE_ID
         INTO V_VENDOR_SITE_ID
         FROM PO_VENDOR_SITES_ALL T, PO_VENDORS PP
        WHERE 1 = 1
          AND T.ORG_ID = 89--SPM_SSO_PKG.GETORGID
          AND T.VENDOR_ID = PP.VENDOR_ID
          AND PP.ENABLED_FLAG = 'Y'
          AND T.PURCHASING_SITE_FLAG = 'Y'
          AND T.PAY_SITE_FLAG = 'Y'
          AND T.VENDOR_SITE_CODE = '��Ʒ�ɹ�'
          AND PP.VENDOR_NAME = V_VENDORNAME
          AND ROWNUM = 1;*/
      
        --��ѯ��ⵥ�²���˰���  
        --���ж϶������Ƿ�����ⵥ 
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
          --����ⵥ
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
        
          --˰�����
          SELECT TO_NUMBER(INVOICETAXAMOUNT) * TO_NUMBER(V_TAXRATE)
            INTO V_TAXAMOUNT
            FROM DUAL; --����˰���*˰��
          --��Ʊ������
          SELECT INVOICETAXAMOUNT + V_TAXAMOUNT
            INTO V_INVOICEAMOUNT
            FROM DUAL; --����˰���*˰��
          /*ELSE 
          V_RETURN_CODE := 'F';
          V_RETURN_MSG := '���Ϊ' || V_CODE || '�ĺ�ͬ��δ������ⵥ�������ɷ�Ʊ';
          RETURN;*/
        END IF;
      
        --��������
        INSERT INTO SPM_CON_INPUT_INVOICE
          (INPUT_INVOICE_ID, --���Ʊ��������
           VENDOR_ID, --��Ӧ��id
           INVOICE_CONTENT, --ժҪ
           INVOICE_TYPE, --��Ʊ����
           INVOICE_CODE, --��Ʊ����
           INVOICE_AMOUNT, --��Ʊ���
           CURRENCY_TYPE, --��Ʊ������
           PROJECT_ID, --������ĿID
           CONTRACT_ID, --������ͬID       
           VERIFIC_IMPREST_AMOUNT, --����Ԥ������
           CREATED_BY, --�ǼǾ�����
           CREATION_DATE, --�Ǽ�����
           LAST_UPDATE_DATE, -- ����޸�ʱ��     
           STATUS, --����״̬
           ORG_ID, --��������ID
           DEPT_ID, --��������ID
           RESIDUAL_AMOUNT, --ʣ����
           BILLING_DATE, --��Ʊ����
           PAYMENT_TERM, --��������
           PAYMENT_TYPE, --���ʽ
           VENDOR_SITE_ID, --��Ӧ�̵ص�ID
           TAX_AMOUNT, --˰��
           INVOICETAX_AMOUNT, --�ܽ�� ����˰���
           TAX_RATE, --˰��
           NO_TAX_DIF, --����˰������
           NO_CONTRACT, --�Ƿ��޺�ͬ
           EBS_DEPT_CODE, --���㲿��code
           PAYMENT_STATUS, --�������        
           EBS_STATUS, --EBSͬ��״̬
           GL_DATE, --��������
           EBS_TYPE --��Ʊ����EBS
           )
        VALUES
          (SPM_CON_INPUT_INVOICE_SEQ.NEXTVAL,
           V_VENDOR_ID, --��Ӧ��id
           V_INVOICECODE, --VALIDATE_J, --ժҪ        
           'A', --V_INVOICETYPE, --��Ʊ����
           V_INVOICECODE, --EBS��Ʊ����
           ROUND(V_INVOICEAMOUNT, 2), --��Ʊ���
           'CNY', --��Ʊ������
           V_PROJECT_ID, --������ĿID
           V_CONTRACT_ID, --������ͬID
           0, -- --����Ԥ������
           V_USER_ID, --�ǼǾ�����                       
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--�Ǽ����� 
           SYSDATE, --����޸�ʱ��
           'A', --����״̬
           SPM_SSO_PKG.GETORGID, --��������ID
           V_DEPT_ID, --��������ID
           ROUND(V_INVOICEAMOUNT, 2), --ʣ����  ͬ��Ʊ���      
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_I, 1, 10), 'yyyy-mm-dd'), --��Ʊ����
           '10000', --��������
           'WIRE', --���ʽ
           200761, --V_VENDOR_SITE_ID,--��Ӧ�̵ص�ID
           ROUND(V_TAXAMOUNT, 2), --˰��
           ROUND(INVOICETAXAMOUNT, 2), --�ܽ�� ����˰���
           V_TAXRATE, --˰��
           0, --NOTAXDIF, --����˰������
           '', --NOCONTRACT, --�Ƿ��޺�ͬ        
           EBSDEPTCODE, --���㲿��         
           'Y', --�������
           'N', --EBSͬ��״̬
           SYSDATE, --��������
           'STANDARD' --��Ʊ����EBS
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
      V_RETURN_MSG := '���Ϊ' || V_RETURN_MSG || '�ĺ�ͬ���ɷ�Ʊʧ��';
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '����ִ���쳣';
  END CREATE_INPUT_INVOICE;

  --�ʽ�ƻ���� ���ۺϲ�ѯ��ȡ����ֵ
  FUNCTION SPM_CAPITAL_FIND_AMOUNT(P_PERIOD_YEAR  IN NUMBER, --���
                                   P_PERIOD_NUM_F IN NUMBER, --�·�
                                   P_PERIOD_NUM_T IN NUMBER, --�·�
                                   P_KM           IN SPM_TYPE_TBL, --��Ŀ                                
                                   P_GS           IN VARCHAR2, --��˾��  
                                   DEPTCODE       IN VARCHAR2, --���Ŷ� 
                                   P_VALTYPE      IN VARCHAR2, --ȡֵ����  
                                   ORGID          IN VARCHAR2) RETURN NUMBER IS
    QCYEAMOUNT  NUMBER;
    BQJFAMOUNT  NUMBER;
    BQDFAMOUNT  NUMBER;
    VRETURND    NUMBER;
    VRETURNC    NUMBER;
    V_SMALLCODE SPM_TYPE_TBL;
    BACKAMOUNT  NUMBER;
  BEGIN
    --���ݴ���code ��ѯ���µ�С���Ž����
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    IF ORGID = 81 THEN
      --���������Ŷ�     
      SELECT NVL(SUM(GJL.ACCOUNTED_DR), 0), NVL(SUM(GJL.ACCOUNTED_CR), 0)
        INTO VRETURND, VRETURNC
        FROM GL.GL_JE_LINES       GJL,
             GL.GL_JE_HEADERS     GJH,
             APPS.CUX_DIQ_GL_CCID RGC
       WHERE GJL.JE_HEADER_ID = GJH.JE_HEADER_ID
         AND RGC.CODE_COMBINATION_ID = GJL.CODE_COMBINATION_ID
         AND GJH.ACTUAL_FLAG = 'A'
         AND RGC.SEG1 = P_GS
         AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
            --AND GJH.CURRENCY_CODE = P_CURRENCY
         AND RGC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY'), 0)) =
             NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
         AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM'), 0)) <=
             NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
         AND TO_NUMBER(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM')) >=
             NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
         AND GJH.STATUS <> 'P'
         AND GJH.LEDGER_ID = '2021';
      ---�ڳ����
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
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
      ----���ڽ跽
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
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
      ---���ڴ���
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
         AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
      ------�Ǳ����������Ŷ�
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
              -- AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--С���Ŷ�
              --AND GJH.CURRENCY_CODE = P_CURRENCY
           AND RGC.SEG3 LIKE (SELECT COLUMN_VALUE FROM TABLE(P_KM)) || '%' --��Ŀֵ
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
              -- AND RGC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--С���Ŷ�
              --AND GJH.CURRENCY_CODE = P_CURRENCY
           AND RGC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'YYYY'), 0)) =
               NVL(TO_NUMBER(P_PERIOD_YEAR), 2000)
           AND TO_NUMBER(NVL(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM'), 0)) <=
               NVL(TO_NUMBER(P_PERIOD_NUM_T), 14)
           AND TO_NUMBER(TO_CHAR(GJH.DEFAULT_EFFECTIVE_DATE, 'MM')) >=
               NVL(TO_NUMBER(P_PERIOD_NUM_F), 0)
           AND GJH.STATUS <> 'P'
           AND GJH.LEDGER_ID = '2021';
      END IF;
      ---�ڳ����
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
            --AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
      ----���ڽ跽
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
            -- AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
      ---���ڴ���
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
            -- AND GLC.SEG2 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))--С���Ŷ�
         AND GLC.SEG3 IN (SELECT COLUMN_VALUE FROM TABLE(P_KM)) --��Ŀֵ
         AND GB.LEDGER_ID = '2021';
    END IF;
  
    --��ѯ�Ľ��ֵ
    IF P_VALTYPE = 'NONPAYCOST' THEN
      --�Ǹ���
      SELECT BQJFAMOUNT - BQDFAMOUNT INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'REPORTPROFITDF' THEN
      --��������  ����     
      SELECT BQDFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'REPORTPROFITJF' THEN
      --��������  �跽     
      SELECT BQJFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSIF P_VALTYPE = 'TAXSYXX' THEN
      --��������
      SELECT BQDFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    ELSE
      --���½���
      SELECT BQJFAMOUNT - 0 INTO BACKAMOUNT FROM DUAL;
    END IF;
    RETURN BACKAMOUNT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END SPM_CAPITAL_FIND_AMOUNT;

  --���ݴ��İ���id �������ʽ�������id
  FUNCTION GET_CAPITAL_ID(P_DEPT_ID VARCHAR2) RETURN NUMBER IS
    LAST_RECEIVE_MONTH NUMBER;
    CAPITAL_QUOTA      NUMBER;
    ORGANID            NUMBER(15);
    V_DEPT_CODE        VARCHAR2(20);
    V_CAPITAL_ID       NUMBER(15);
    T_SYSDATE          VARCHAR2(50);
  BEGIN
    -- ��ȡϵͳʱ��
    SELECT TO_CHAR(SYSDATE, 'YYYY-MM') INTO T_SYSDATE FROM DUAL;
    --δ����ŵ� ��ʱ�鲻��V_DEPT_CODE
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

  --�ʽ�ƻ������ϸ ��������ʱ �����û���� �ϻ����Ӷ� ����������  �����ʽ�ƻ����   
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
    V_CAPITALQUOTA     NUMBER; --������ϸ��Ⱥ�
    V_THISMONTHBALANCE NUMBER; --������ϸ��Ⱥ�
  BEGIN
    --����ϻ����Ӷ���ܽ��  ������������ܽ��
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
    --�ϻ��ܶ� ���� �������ܽ��  ��ϸ����ܽ�� 
    SELECT V_AMOUNT1 + V_AMOUNT2 INTO V_AMOUNTSUM FROM DUAL;
    --��ѯ����ԭ���Ľ������
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
    --���¼��� �ʽ�ƻ���� 
    SELECT RECEIVEAMOUNT - NONPAYCOST - REPORTPROFIT - TAXAMOUNT +
           CAPITALBALANCE
      INTO CAPITALQUOTA
      FROM DUAL;
    --���¼��� ���½����
    SELECT CAPITALQUOTA - PAYAMOUNT INTO THISMONTHBALANCE FROM DUAL;
    --���� ��ϸ����� �ʽ�ƻ����  ���½����
    SELECT CAPITALQUOTA + V_AMOUNTSUM INTO V_CAPITALQUOTA FROM DUAL;
    SELECT THISMONTHBALANCE + V_AMOUNTSUM
      INTO V_THISMONTHBALANCE
      FROM DUAL;
    --�޸��ʽ�ƻ����
    UPDATE SPM_CON_CAPITAL_PLAN P
       SET P.CAPITAL_QUOTA      = V_CAPITALQUOTA,
           P.THIS_MONTH_BALANCE = V_THISMONTHBALANCE
     WHERE P.CAPITAL_ID = ID;
  END;

  --�ʽ�ƻ���� ��������
  PROCEDURE SPM_CAPITAL_COPY_DATA(CAPITALID IN NUMBER,
                                  V_STATUS  OUT VARCHAR2,
                                  V_MESSAGE OUT VARCHAR2) IS
    CAPITALBALANCE     NUMBER; --���¶����ȱ
    RECEIVEAMOUNT      NUMBER; --�����տ���
    NONPAYCOST         NUMBER; --���·Ǹ��ֳɱ�
    REPORTPROFIT       NUMBER; --���±�������
    TAXAMOUNT          NUMBER; --����Ӧ��˰
    CAPITALQUOTA       NUMBER; --�ʽ�ƻ����
    PAYAMOUNT          NUMBER; --���¸�����
    THISMONTHBALANCE   NUMBER; --���½����
    SYXXAMOUNT         NUMBER; --����������
    SYJXAMOUNT         NUMBER; --���½�����
    EXCHANGEREC        NUMBER; --����Ӧ�ս��
    EXCHANGEPAY        NUMBER; --����Ӧ�����
    V_QUOTAMONTH_LAST  VARCHAR2(10); --��һ�� 2018-06
    V_QUOTAMONTH       VARCHAR2(10); --��ǰ�� 2018-07
    V_MONTHLAST        VARCHAR2(10); --��һ�� -06
    V_YEAR             VARCHAR2(10); --��ǰ�� -2018
    FIRSTMONTH         VARCHAR2(20); --�����³� 2018-07-01
    ENDMONTH           VARCHAR2(20); --����ĩ 2018-07-31
    V_NUMBER1          NUMBER;
    V_NUMBER2          NUMBER;
    V_ORGID            NUMBER(15);
    V_DEPTCODE         VARCHAR2(10);
    V_DEPTID           NUMBER(15);
    V_THISMONTHBALANCE NUMBER; --���½����
    V_ORGCODE          VARCHAR2(20);
    V_VALTYPE1         VARCHAR2(50); --ȡֵ������  �Ǹ���
    V_VALTYPE2         VARCHAR2(50); --ȡֵ������  ��������
    V_VALTYPE3         VARCHAR2(50); --ȡֵ������  ��������
    V_VALTYPE4         VARCHAR2(50); --ȡֵ������  ���½���
    V_SMALLCODE        SPM_TYPE_TBL := SPM_TYPE_TBL();
    V_KMZH             SPM_TYPE_TBL := SPM_TYPE_TBL(); --�Ǹ��ֳɱ��Ŀ�Ŀ���
    V_KMBBLR           SPM_TYPE_TBL := SPM_TYPE_TBL(); --���±�������Ŀ�Ŀ���
    V_KMYNSXX          SPM_TYPE_TBL := SPM_TYPE_TBL(); --����Ӧ��˰�����������Ŀ���
    V_KMYNSJX          SPM_TYPE_TBL := SPM_TYPE_TBL(); --����Ӧ��˰�����½����Ŀ���
  BEGIN
    --����ѡ�����ݵ�id ��ѯ�����ֶ�����
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
    --��ѯ��˾��
    SELECT OU.SHORT_CODE
      INTO V_ORGCODE
      FROM HR_OPERATING_UNITS OU
     WHERE OU.ORGANIZATION_ID = V_ORGID;
    --���ݴ���code ��ѯ���µ�С���Ž����
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(V_DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    --
    SELECT TO_CHAR(SYSDATE, 'yyyy-mm') INTO V_QUOTAMONTH FROM DUAL; --��ǰ���� 2018-07
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL; --��һ���� 2018-06
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'mm')
      INTO V_MONTHLAST
      FROM DUAL; --��һ�� 06*/
    SELECT TO_CHAR(SYSDATE, 'yyyy') INTO V_YEAR FROM DUAL; --��ǰ�� 2018
    -- SELECT to_char(sysdate, 'yyyy-mm') INTO V_QUOTAMONTH from dual; 
    -- select to_char(add_months(trunc(sysdate),-1),'yyyy-mm') INTO V_QUOTAMONTH_LAST from dual;
    --�����³�  ��ĩ
    SELECT TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -2) + 1, 'yyyy-mm-dd'),
           TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -1), 'yyyy-mm-dd')
      INTO FIRSTMONTH, ENDMONTH
      FROM DUAL;
    --��ѯ�ò��ű����Ƿ�����ʽ�ƻ�
    SELECT COUNT(P.CAPITAL_ID)
      INTO V_NUMBER2
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.DEPT_CODE = V_DEPTCODE
       AND P.QUOTA_MONTH = V_QUOTAMONTH;
    IF V_NUMBER2 = 1 THEN
      V_STATUS  := 'ERROR';
      V_MESSAGE := '�ò��ű�������ʽ�ƻ�';
    ELSE
      --��ѯ �����տ���  
      IF V_ORGID = 81 THEN
        SELECT NVL(SUM(R.MONEY_AMOUNT), 0) --���� ����Ӧ��
          INTO EXCHANGEREC
          FROM SPM_CON_RECEIPT R
         WHERE R.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND R.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND R.RECEIPT_DEPT IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
           AND R.EBS_STATUS = 'US';
        SELECT NVL(SUM(I.INVOICE_AMOUNT), 0) --���� ����Ӧ��
          INTO EXCHANGEPAY
          FROM SPM_CON_INPUT_INVOICE I
         WHERE I.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND I.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND I.EBS_DEPT_CODE IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
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
      --��ѯ���·Ǹ��ֳɱ����  
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
      --��ѯ���±�������
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
      --��ѯ����Ӧ��˰ 
      --��������      
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
      --���½���
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
      SELECT SYXXAMOUNT + SYJXAMOUNT INTO TAXAMOUNT FROM DUAL; --��������Ӧ��˰��
      --�����ʽ�ƻ����
      SELECT RECEIVEAMOUNT - NONPAYCOST - REPORTPROFIT - TAXAMOUNT +
             V_THISMONTHBALANCE
        INTO CAPITALQUOTA
        FROM DUAL;
      INSERT INTO SPM_CON_CAPITAL_PLAN
        (CAPITAL_ID,
         CAPITAL_BALANCE, --���¶����ȱ
         QUOTA_MONTH, --���·�
         ORG_ID,
         DEPT_CODE,
         DEPT_ID,
         RECEIVE_AMOUNT, --�����տ���
         NON_PAY_COST, --���·Ǹ��ֳɱ�
         REPORT_PROFIT, --���±�������
         TAX_AMOUNT, --����Ӧ���ɵ���ֵ˰
         CAPITAL_QUOTA, --�ʽ�ƻ����
         QUOTA_YEAR,
         PAY_AMOUNT, --���¸�����
         THIS_MONTH_BALANCE, --���½����
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
      V_MESSAGE := '�����ɹ���';
    END IF;
  END SPM_CAPITAL_COPY_DATA;

  --����ɨ�跢Ʊ��Ϣ ������Ʊ��
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
    V_INVOICECODE         VARCHAR2(40); --��Ʊ����
    EBSDEPTCODE           VARCHAR2(40); --���㲿��code
    V_TAXRATE             NUMBER; --˰��
    V_PERSON_ID           NUMBER(15); --
    V_VENDOR_SITE_ID      NUMBER(15); --��Ӧ�̵ص�id
    V_CONTRACT_ID         NUMBER(15);
    V_PROJECT_ID          NUMBER(15);
    V_VENDOR_ID           NUMBER(15);
    V_VENDORNAME          VARCHAR2(100);
    INVOICETAXAMOUNT      NUMBER; --����˰��� ���ܽ�
    V_TAXAMOUNT           NUMBER; --˰��
    V_INVOICEAMOUNT       NUMBER; --��Ʊ���
    V_NUMBER1             NUMBER;
    V_NUMLICODE           NUMBER;
    V_RATENUM             NUMBER;
    V_CODE_PRE            VARCHAR2(40);
    V_BILLING_DATE        VARCHAR2(100); --��Ʊ����
    V_CONTRACT_CODE       VARCHAR2(100);
    V_INVOICE_TYPE        VARCHAR2(100);
    V_INVOICE_RATE_NUMBER VARCHAR2(100); --��֤��һ��
    L_MONEYAMOUNT         NUMBER; --����Ϣ ����˰���
    L_TAXRATE             NUMBER; --����Ϣ ˰��
    L_TAXAMOUNT           NUMBER; --����Ϣ ˰��
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
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(V_IDS) INTO IDS FROM DUAL;
    V_CODE_PRE := SPM_CON_SERIAL_PKG.VALUE('SPM_CON_INPUT_CODE');
    --����
    FOR I IN 1 .. IDS.COUNT LOOP
      BEGIN
        --����ѡ�������mq_id ��ѯ������Ϣ
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
            V_RETURN_MSG := V_RETURN_MSG || '��';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE || '��Ӧ�̿�Ʊ˰����ϢΪ��';
          UPDATE SPM_DB_IN_INVOICE_VIEW VI
             SET VI.ATTRIBUTE5 = '��Ӧ�̿�Ʊ˰����ϢΪ��'
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
            X_ERROR_MSG   := '��ȡ��Ӧ�̡�' || V_VENDORNAME || '��' ||
                             V_INVOICE_RATE_NUMBER || '��������ʧ�ܣ�';
          
            IF V_VENDOR_ID = -1 THEN
              X_ERROR_MSG := X_ERROR_MSG || '���̹�Ӧ���м�����ڸ�����¼������ϵ������������';
            ELSIF V_VENDOR_ID = -2 THEN
              X_ERROR_MSG := X_ERROR_MSG || '��δ����ҵ������';
            ELSIF V_VENDOR_ID = -3 THEN
              X_ERROR_MSG := X_ERROR_MSG || '�ù�Ӧ��δ��Ч';
            ELSIF V_VENDOR_ID = -5 THEN
              X_ERROR_MSG := X_ERROR_MSG || '��ȡ�����쳣������ϵϵͳ����Ա';
            END IF;
          
            IF V_RETURN_MSG IS NOT NULL THEN
              V_RETURN_MSG := V_RETURN_MSG || '��';
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
        --������ˮ�Ź������ɷ�Ʊ���� 
        V_INVOICECODE := SPM_CON_SERIAL_PKG.GET_SERIAL_CODE('SPM_CON_INPUT_INVOICE',
                                                            'INVOICE_CODE',
                                                            'FM000000',
                                                            V_CODE_PRE);
        --���ݵ�¼��userid ��ȡpersonid 
        SELECT T.PERSON_ID
          INTO V_PERSON_ID
          FROM SPM_EAM_ALL_PEOPLE_V T
         WHERE T.USER_ID = V_USER_ID;
        --���㲿��                         
        SELECT SPM_CON_UTIL_PKG.GET_EBS_DEPT_CODE_BY_PERSONID(SPM_SSO_PKG.GETORGID,
                                                              V_PERSON_ID)
          INTO EBSDEPTCODE
          FROM DUAL;
        --����˰������
        SELECT V_INVOICEAMOUNT - V_TAXAMOUNT
          INTO INVOICETAXAMOUNT
          FROM DUAL; --��Ʊ���-˰��
        --˰�ʼ���
        --SELECT V_TAXAMOUNT / INVOICETAXAMOUNT INTO V_TAXRATE FROM DUAL;--˰�� / ����˰��� 
        --�жϷ�Ʊ����
        IF V_INVOICE_TYPE = 0 THEN
          V_INVOICETYPE := 'A';
        ELSIF V_INVOICE_TYPE = 3 THEN
          V_INVOICETYPE := 'B';
        ELSE
          V_INVOICETYPE := 'C';
        END IF;
        --��ȡ����Ϣ��˰�� 
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
        --��������
        INSERT INTO SPM_CON_INPUT_INVOICE
          (INPUT_INVOICE_ID, --���Ʊ��������
           VENDOR_ID, --��Ӧ��id
           INVOICE_CONTENT, --ժҪ
           INVOICE_TYPE, --��Ʊ����
           INVOICE_CODE, --��Ʊ����
           INVOICE_AMOUNT, --��Ʊ���
           CURRENCY_TYPE, --��Ʊ������
           PROJECT_ID, --������ĿID
           CONTRACT_ID, --������ͬID       
           VERIFIC_IMPREST_AMOUNT, --����Ԥ������
           CREATED_BY, --�ǼǾ�����
           CREATION_DATE, --�Ǽ�����
           LAST_UPDATE_DATE, -- ����޸�ʱ��     
           STATUS, --����״̬
           ORG_ID, --��������ID
           DEPT_ID, --��������ID
           RESIDUAL_AMOUNT, --ʣ����
           BILLING_DATE, --��Ʊ����
           PAYMENT_TERM, --��������
           PAYMENT_TYPE, --���ʽ
           VENDOR_SITE_ID, --��Ӧ�̵ص�ID
           TAX_AMOUNT, --˰��
           INVOICETAX_AMOUNT, --�ܽ�� ����˰���
           TAX_RATE, --˰��
           NO_TAX_DIF, --����˰������
           NO_CONTRACT, --�Ƿ��޺�ͬ
           EBS_DEPT_CODE, --���㲿��code
           PAYMENT_STATUS, --�������        
           EBS_STATUS, --EBSͬ��״̬
           GL_DATE, --��������
           EBS_TYPE --��Ʊ����EBS
           )
        VALUES
          (V_INVOICE_ID,
           V_VENDOR_ID, --��Ӧ��id
           'ժҪ', --VALIDATE_J, --ժҪ        
           V_INVOICETYPE, --��Ʊ����
           V_INVOICECODE, --EBS��Ʊ����
           ROUND(V_INVOICEAMOUNT, 2), --��Ʊ���
           'CNY', --��Ʊ������
           V_PROJECT_ID, --������ĿID
           V_CONTRACT_ID, --������ͬID
           0, -- --����Ԥ������
           V_USER_ID, --�ǼǾ�����                       
           SYSDATE, --TO_DATE(SUBSTR(VALIDATE_K, 1, 10), 'yyyy-mm-dd'),--�Ǽ����� 
           SYSDATE, --����޸�ʱ��
           'A', --����״̬
           V_ORG_ID, --��������ID
           V_DEPT_ID, --��������ID
           ROUND(V_INVOICEAMOUNT, 2), --ʣ����  ͬ��Ʊ���      
           TO_DATE(V_BILLING_DATE, 'YYYY-MM-DD'), --��Ʊ����
           '10000', --��������
           'WIRE', --���ʽ
           200761, --V_VENDOR_SITE_ID,--��Ӧ�̵ص�ID
           ROUND(V_TAXAMOUNT, 2), --˰��
           ROUND(INVOICETAXAMOUNT, 2), --�ܽ�� ����˰���
           V_TAXRATE, --˰��
           0, --NOTAXDIF, --����˰������
           '', --NOCONTRACT, --�Ƿ��޺�ͬ        
           EBSDEPTCODE, --���㲿��         
           'Y', --�������
           'N', --EBSͬ��״̬
           SYSDATE, --��������
           'STANDARD' --��Ʊ����EBS
           );
      
      EXCEPTION
        WHEN OTHERS THEN
          V_RETURN_CODE := 'F';
        
          IF V_RETURN_MSG IS NOT NULL THEN
            V_RETURN_MSG := V_RETURN_MSG || '��';
          END IF;
          V_RETURN_MSG := V_RETURN_MSG || V_CONTRACT_CODE || '���ɷ�Ʊ�����쳣';
          UPDATE SPM_DB_IN_INVOICE_VIEW VI
             SET VI.ATTRIBUTE5 = '���ɷ�Ʊ�����쳣'
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
          --����˰��
          SELECT L_MONEYAMOUNT * L_TAXRATE INTO L_TAXAMOUNT FROM DUAL; --����˰���*˰��
          INSERT INTO SPM_CON_PAPER_INVOICE
            (PAPER_INVOICE_ID, --������ 
             INVOICE_ID, --���
             INVOICE_CODE, --��Ʊ����
             INVOICE_NUMBER, --��Ʊ����
             INVOICE_TYPE, --��Ʊ���� ap
             ORG_ID,
             DEPT_ID,
             REMARK,
             MONEY_AMOUNT, --����˰���
             TAX_AMOUNT, --˰��
             INVOICE_URL, --���ӷ�Ʊ��ַ
             INVALID_FLAG --����Ʊ���ϱ�ʶ
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
             L_MONEYAMOUNT, --����˰���
             L_TAXAMOUNT, --˰��
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
      V_RETURN_MSG := '���׵���' || V_RETURN_MSG || '���ݻ�ȡʧ��';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      V_RETURN_CODE := 'F';
      V_RETURN_MSG  := '����ִ���쳣';
  END INSERT_INPUTINVOICE_INFO;
  /*=================================================================
  *   PROGRAM NAME: IMPORT_GL_CRRT_BY_TEMPLATE
  *
  *   DESCRIPTION: ��������ƾ֤ģ����������ƾ֤����
  *   ARGUMENT:
  *   PARAM : P_TEMPLATE_CODE��ģ��CODE,P_VERSION_NUMBER:�������ɵ��������α�ʶ��P_GL_DATE���������ڣ���ʽ:yyyy-mm-dd ������Ҫͬ���ķ�Ʊid��
  *  P_PARAM��ģ�������OUT_SUCESS_FLAG������������ɹ���ʶ��S:�ɹ���E:ʧ�ܣ� OUT_MESSAGE����������Ϣ
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
    PARAM_ARRAY     SPM_TYPE_TBL; --��һ�ηָ�ɵ�����
    PARAM_VARCHAR   VARCHAR(4000); --��һ�ν�ȡ�ַ�
    V_TEMPLATE_NAME VARCHAR2(200); --ģ������
    V_LINE_NUMBER   NUMBER(3); --ebs�к�
    V_ORG_CODE      VARCHAR(20); --��˾����
    V_DEPT_CODE     VARCHAR(50); --���ű���
    V_PRO_CODE      VARCHAR(50); --��Ŀ����
    V_PARAM_TEMP    VARCHAR(4000); --��������
    V_PARAMS        VARCHAR(4000); --��������
    V_PARAMS_CNT    NUMBER(2); --SQLZ�в������������Ÿ�����
    V_PARAM         VARCHAR(50); --����
    V_ATTACH_CNT    NUMBER(5); --��������
    V_PARAMS_ARRAY  SPM_TYPE_TBL; --��������
    --V_SQL_CNT                  NUMBER(3);-- ȡֵ����ΪSQL��ģ����ϸ����
    V_SQL VARCHAR(4000); --��ȡ����SQL
    --V_ITEM_CNT           NUMBER(3);--ģ����ϸ����
    --V_INDEX              NUMBER(3):=0;--��ȡ���SQL�в�������
    V_AMOUNT NUMBER(20, 2); --���յõ��Ľ��
    --V_SUBJECT_COM        VARCHAR(200);--�������ɵĿ�Ŀ���
    V_DATA_CNT       NUMBER(3); --�����������ڽӿڱ��е����� 
    V_ERROR_DATA_CNT NUMBER(3); --�����������ڽӿڱ��е����� --����ʫ��
    --T_HEADERS_ID        NUMBER; --�м������
    V_GL_DATE       DATE; --��������
    V_JE_BATCH_NAME VARCHAR2(500); --����������
    V_DR_AMOUNT     NUMBER(18, 2) := 0; --�跽�ܽ��
    V_CR_AMOUNT     NUMBER(18, 2) := 0; --�����ܽ��
    V_CERT_NUMBER   VARCHAR2(100); --����ƾ֤
    V_JE_BATCH_ID   VARCHAR(20); --����ID
    V_REQUEST_ID    NUMBER(20); --����ID   
    V_HEADER_ID     NUMBER(20); --����ͷID
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
        OUT_MESSAGE     := 'û���ҵ���ģ���Ӧ��ģ����ϸ��Ϣ';
        --������־
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
  
    --��ѯ
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
       AND CD.JE_BATCH_NAME LIKE '%' || V_TEMPLATE_NAME || '%'
       AND CD.DATA_STATUS = 'IMPORT';
    IF V_DATA_CNT <> 0 THEN
      --˵���Ѿ������
      OUT_SUCESS_FLAG := 'E';
      OUT_MESSAGE     := '��ǰ�������Ѿ�ִ����ͬ���������';
      DBMS_OUTPUT.PUT_LINE(OUT_MESSAGE);
      --������־
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
      --˵���д����������м��
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER;
    END IF;
  
    BEGIN
    
      SELECT NVL(P_ATTACH_CNT, 0) INTO V_ATTACH_CNT FROM DUAL;
      --�ֽ�ԭ���ļ�¼ɾ��
      DELETE FROM SPM_GZ_CERT_ITEM_TEMP;
      --��ģ���е����ݳ��뵽��ʱ����
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
      --���� --����EBS�к�
      FOR I IN 1 .. PARAM_ARRAY.COUNT LOOP
        PARAM_VARCHAR := PARAM_ARRAY(I);
        --DBMS_OUTPUT.put_line(PARAM_VARCHAR);
        --��ȡEBS�к�
        V_LINE_NUMBER := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                             INSTR(PARAM_VARCHAR, ':') + 1,
                                             INSTR(PARAM_VARCHAR, ',') -
                                             (INSTR(PARAM_VARCHAR, ':') + 1))),
                                 '''',
                                 '');
        -- DBMS_OUTPUT.PUT_LINE('�кţ�'||V_LINE_NUMBER);
        V_DEPT_CODE := '';
        V_PRO_CODE  := '';
        --��ȡ���ű���
        V_DEPT_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                           INSTR(PARAM_VARCHAR, ':', 1, 2) + 1,
                                           INSTR(PARAM_VARCHAR, ',', 1, 2) -
                                           (INSTR(PARAM_VARCHAR, ':', 1, 2) + 1))),
                               '''');
        --��ȡ��Ŀ��
        V_PRO_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                          INSTR(PARAM_VARCHAR, ':', 1, 3) + 1,
                                          INSTR(PARAM_VARCHAR, ',', 1, 3) -
                                          (INSTR(PARAM_VARCHAR, ':', 1, 3) + 1))),
                              '''');
        IF LENGTH(NVL(V_DEPT_CODE, '')) > 0 OR
           LENGTH(NVL(V_PRO_CODE, '')) > 0 THEN
          -- 10000629.00.100202.00.T.00.00.00.00.00
          --����Ŀ�����Ϣ�еĲ��Ŷθ���Ϊ�������Ĳ��Ŷ�
        
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
        --��ȡ�������
        V_PARAM_TEMP := TRIM(SUBSTR(PARAM_VARCHAR,
                                    INSTR(PARAM_VARCHAR, ':', 1, 4) + 1));
        --ȥ�����һλ}
        IF SUBSTR(V_PARAM_TEMP, LENGTH(V_PARAM_TEMP)) = '}' THEN
          V_PARAMS := SUBSTR(V_PARAM_TEMP, 1, LENGTH(V_PARAM_TEMP) - 1);
        ELSE
          V_PARAMS := V_PARAM_TEMP;
        END IF;
        --����ģ��CODE��EBS�кŲ�ѯģ����ϸ��Ϣ
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET SQL_PARAMS = V_PARAMS
         WHERE VALUE_TYPE = '1'
           AND LINE_NUMBER = V_LINE_NUMBER;
      END LOOP;
      COMMIT;
      --��ȡֵ����ΪSQLʱ
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '1') LOOP
        V_SQL      := I.AMOUNT;
        V_ORG_CODE := I.SEGMENT1;
        --�õ���������
        DBMS_OUTPUT.PUT_LINE('SQL_PARAMS:' || I.SQL_PARAMS);
        SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(I.SQL_PARAMS), ',')
          INTO V_PARAMS_ARRAY
          FROM DUAL;
      
        SELECT LENGTH(REGEXP_REPLACE(V_SQL, '[^?��]', ''))
          INTO V_PARAMS_CNT
          FROM DUAL;
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_ARRAY.COUNT:'||V_PARAMS_ARRAY.COUNT);
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_CNT:'||V_PARAMS_CNT);
        IF V_PARAMS_ARRAY.COUNT <> V_PARAMS_CNT THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '����������SQL�еĲ���������ƥ��';
          --������־
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
        --����
        FOR J IN 1 .. V_PARAMS_ARRAY.COUNT LOOP
          V_PARAM := V_PARAMS_ARRAY(J);
          --  V_INDEX:=V_INDEX+1;
          --�滻SQL�еģ���
          --SELECT  REGEXP_REPLACE(V_SQL,'[?]',V_PARAM,1,V_INDEX) INTO V_SQL  FROM DUAL;
          SELECT REGEXP_REPLACE(V_SQL, '[?��]', V_PARAM, 1, 1)
            INTO V_SQL
            FROM DUAL;
        END LOOP;
      
        DBMS_OUTPUT.PUT_LINE('SQL��' || V_SQL);
        --ִ��sql
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO V_AMOUNT;
        EXCEPTION
          WHEN OTHERS THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := 'ִ�л�ȡ���SQL����ԭ��' || SQLERRM;
            --������־
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
        -- DBMS_OUTPUT.put_line('��'||V_AMOUNT);
        --���½��
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = NVL(V_AMOUNT, 0)
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      --��ȡֵ����Ϊ��Ӧ�к�ʱ   
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '2') LOOP
        SELECT SUM(AMOUNT)
          INTO V_AMOUNT
          FROM SPM_GZ_CERT_ITEM_TEMP
         WHERE DRCR_TYPE <> I.DRCR_TYPE
           AND CORRESPOND_LINE = I.AMOUNT;
        --���½��
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = V_AMOUNT
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      COMMIT;
      --�жϽ���ܽ���Ƿ����
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
        OUT_MESSAGE     := '����ܽ���ȡ�';
        --������־
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
      --������������
      V_JE_BATCH_NAME := V_ORG_CODE || TO_CHAR(V_GL_DATE, 'YYYY') ||
                         TO_CHAR(V_GL_DATE, 'MM') ||
                         TO_CHAR(V_GL_DATE, 'DD') || V_TEMPLATE_NAME ||
                         P_VERSION_NUMBER;
      --����ʱ���е����ݲ��뵽�����м��
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
          FROM (SELECT 'SPMϵͳ',
                       V_JE_BATCH_NAME, -- ������
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
                       '�û�',
                       '�˹�',
                       '����',
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
      --ִ����������ƾ֤����
      CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => OUT_MESSAGE,
                             RETCODE         => OUT_SUCESS_FLAG,
                             P_DATA_SOURCE   => 'SPMϵͳ',
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
      
        --��ѯ���ɺ��������
        SELECT JE_BATCH_ID, NAME
          INTO V_JE_BATCH_ID, V_JE_BATCH_NAME
          FROM GL_JE_BATCHES
         WHERE NAME LIKE '%' || V_JE_BATCH_NAME || '%';
      
        V_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('SQLGL',
                                                   'GLPPOSS',
                                                   '�Զ�����',
                                                   NULL,
                                                   FALSE,
                                                   2021,
                                                   1000, -- NEW PARAMETER
                                                   50348,
                                                   V_JE_BATCH_ID,
                                                   CHR(0));
        IF V_REQUEST_ID <= 0 THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '�Զ����˲��������ύʧ��';
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
          IF L_CHILD_STATUS <> INITCAP('����') THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '�Զ����˲��������ύʧ��';
            RETURN;
          ELSE
            OUT_SUCESS_FLAG := 'S';
            OUT_MESSAGE     := '��������ƾ֤���ݳɹ�';
          END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('V_JE_BATCH_ID:' || V_JE_BATCH_ID);
        --ƾ֤�� ֻ�й��˺��������ƾ֤�� 
        SELECT JH.EXTERNAL_REFERENCE, JB.NAME, JH.JE_HEADER_ID
          INTO V_CERT_NUMBER, V_JE_BATCH_NAME, V_HEADER_ID
          FROM GL_JE_BATCHES JB, GL_JE_HEADERS JH
         WHERE JH.JE_BATCH_ID = JB.JE_BATCH_ID
           AND JB.JE_BATCH_ID = V_JE_BATCH_ID;
        DBMS_OUTPUT.PUT_LINE('V_HEADER_ID:' || V_HEADER_ID);
      
        --���¸�������
        UPDATE GL_JE_HEADERS GJH
           SET ATTRIBUTE1 = V_ATTACH_CNT
         WHERE GJH.JE_HEADER_ID = V_HEADER_ID;
        --��������ͷ���е��ֽ�����Ϣ
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
        OUT_MESSAGE     := '��������ƾ֤����ʧ�ܣ�ԭ��' || SQLERRM;
        -- RETURN;
    END;
    DBMS_OUTPUT.PUT_LINE('OUT_MESSAGE:' || OUT_MESSAGE);
    DBMS_OUTPUT.PUT_LINE('OUT_SUCESS_FLAG:' || OUT_SUCESS_FLAG);
  
    --������־
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
    PARAM_ARRAY     SPM_TYPE_TBL; --��һ�ηָ�ɵ�����
    PARAM_VARCHAR   VARCHAR(4000); --��һ�ν�ȡ�ַ�
    V_TEMPLATE_NAME VARCHAR2(200); --ģ������
    V_LINE_NUMBER   NUMBER(3); --ebs�к�
    V_ORG_CODE      VARCHAR(20); --��˾����
    V_DEPT_CODE     VARCHAR(50); --���ű���
    V_PRO_CODE      VARCHAR(50); --��Ŀ����
    V_PARAM_TEMP    VARCHAR(4000); --��������
    V_PARAMS        VARCHAR(4000); --��������
    V_PARAMS_CNT    NUMBER(2); --SQLZ�в������������Ÿ�����
    V_PARAM         VARCHAR(50); --����
    V_ATTACH_CNT    NUMBER(5); --��������
    V_PARAMS_ARRAY  SPM_TYPE_TBL; --��������
    --V_SQL_CNT                  NUMBER(3);-- ȡֵ����ΪSQL��ģ����ϸ����
    V_SQL VARCHAR(4000); --��ȡ����SQL
    --V_ITEM_CNT           NUMBER(3);--ģ����ϸ����
    --V_INDEX              NUMBER(3):=0;--��ȡ���SQL�в�������
    V_AMOUNT NUMBER(20, 2); --���յõ��Ľ��
    --V_SUBJECT_COM        VARCHAR(200);--�������ɵĿ�Ŀ���
    V_DATA_CNT       NUMBER(3); --�����������ڽӿڱ��е����� 
    V_ERROR_DATA_CNT NUMBER(3); --�����������ڽӿڱ��е����� --����ʫ��
    --T_HEADERS_ID        NUMBER; --�м������
    V_GL_DATE       DATE; --��������
    V_JE_BATCH_NAME VARCHAR2(500); --����������
    V_DR_AMOUNT     NUMBER(18, 2) := 0; --�跽�ܽ��
    V_CR_AMOUNT     NUMBER(18, 2) := 0; --�����ܽ��
    V_CERT_NUMBER   VARCHAR2(100); --����ƾ֤
    V_JE_BATCH_ID   VARCHAR(20); --����ID
    V_REQUEST_ID    NUMBER(20); --����ID   
    V_HEADER_ID     NUMBER(20); --����ͷID
    L_WAIT_REQ      BOOLEAN;
    L_CHILD_PHASE   VARCHAR2(20);
    L_CHILD_STATUS  VARCHAR2(20);
    L_DEV_PHASE     VARCHAR2(20);
    L_DEV_STATUS    VARCHAR2(20);
    L_MESSAGE       VARCHAR2(20);
    K_UPDATE_WAGEITEMS  VARCHAR2(400);--Ҫ�滻Ϊ1�Ĺ�����Ŀ
    K_UPDATE_WAGEDEPTS  VARCHAR2(400);--Ҫ�滻Ϊ2�Ĺ��ʲ���
    K_SQL               VARCHAR2(4000);--���յ�sql
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
        OUT_MESSAGE     := 'û���ҵ���ģ���Ӧ��ģ����ϸ��Ϣ';
        --������־
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
  
    --��ѯ
    SELECT COUNT(CD.GL_DATA_ID)
      INTO V_DATA_CNT
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = P_VERSION_NUMBER
       AND CD.JE_BATCH_NAME LIKE '%' || V_TEMPLATE_NAME || '%'
       AND CD.DATA_STATUS = 'IMPORT';
    IF V_DATA_CNT <> 0 THEN
      --˵���Ѿ������
      OUT_SUCESS_FLAG := 'E';
      OUT_MESSAGE     := '��ǰ�������Ѿ�ִ����ͬ���������';
      DBMS_OUTPUT.PUT_LINE(OUT_MESSAGE);
      --������־
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
      --˵���д����������м��
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = OBJECT_VERSION_NUMBER;
    END IF;
  
    BEGIN
    
      SELECT NVL(P_ATTACH_CNT, 0) INTO V_ATTACH_CNT FROM DUAL;
      --�ֽ�ԭ���ļ�¼ɾ��
      DELETE FROM SPM_GZ_CERT_ITEM_TEMP;
      --��ģ���е����ݳ��뵽��ʱ����
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
      --���� --����EBS�к�
      FOR I IN 1 .. PARAM_ARRAY.COUNT LOOP
        PARAM_VARCHAR := PARAM_ARRAY(I);
        --DBMS_OUTPUT.put_line(PARAM_VARCHAR);
        --��ȡEBS�к�
        V_LINE_NUMBER := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                             INSTR(PARAM_VARCHAR, ':') + 1,
                                             INSTR(PARAM_VARCHAR, ',') -
                                             (INSTR(PARAM_VARCHAR, ':') + 1))),
                                 '''',
                                 '');
        -- DBMS_OUTPUT.PUT_LINE('�кţ�'||V_LINE_NUMBER);
        V_DEPT_CODE := '';
        V_PRO_CODE  := '';
        --��ȡ���ű���
        V_DEPT_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                           INSTR(PARAM_VARCHAR, ':', 1, 2) + 1,
                                           INSTR(PARAM_VARCHAR, ',', 1, 2) -
                                           (INSTR(PARAM_VARCHAR, ':', 1, 2) + 1))),
                               '''');
        --��ȡ��Ŀ��
        V_PRO_CODE := REPLACE(TRIM(SUBSTR(PARAM_VARCHAR,
                                          INSTR(PARAM_VARCHAR, ':', 1, 3) + 1,
                                          INSTR(PARAM_VARCHAR, ',', 1, 3) -
                                          (INSTR(PARAM_VARCHAR, ':', 1, 3) + 1))),
                              '''');
        IF LENGTH(NVL(V_DEPT_CODE, '')) > 0 OR
           LENGTH(NVL(V_PRO_CODE, '')) > 0 THEN
          -- 10000629.00.100202.00.T.00.00.00.00.00
          --����Ŀ�����Ϣ�еĲ��Ŷθ���Ϊ�������Ĳ��Ŷ�
        
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
        --��ȡ�������
        V_PARAM_TEMP := TRIM(SUBSTR(PARAM_VARCHAR,
                                    INSTR(PARAM_VARCHAR, ':', 1, 4) + 1));
        --ȥ�����һλ}
        IF SUBSTR(V_PARAM_TEMP, LENGTH(V_PARAM_TEMP)) = '}' THEN
          V_PARAMS := SUBSTR(V_PARAM_TEMP, 1, LENGTH(V_PARAM_TEMP) - 1);
        ELSE
          V_PARAMS := V_PARAM_TEMP;
        END IF;
        --����ģ��CODE��EBS�кŲ�ѯģ����ϸ��Ϣ
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET SQL_PARAMS = V_PARAMS
         WHERE VALUE_TYPE = '1'
           AND LINE_NUMBER = V_LINE_NUMBER;
          
         /*************�滻sql�еĲ���*************/
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
      --��ȡֵ����ΪSQLʱ
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '1') LOOP
        V_SQL      := I.AMOUNT;
        V_ORG_CODE := I.SEGMENT1;
        --�õ���������
        DBMS_OUTPUT.PUT_LINE('SQL_PARAMS:' || I.SQL_PARAMS);
        SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TRIM(I.SQL_PARAMS), ',')
          INTO V_PARAMS_ARRAY
          FROM DUAL;
      
        SELECT LENGTH(REGEXP_REPLACE(V_SQL, '[^?��]', ''))
          INTO V_PARAMS_CNT
          FROM DUAL;
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_ARRAY.COUNT:'||V_PARAMS_ARRAY.COUNT);
        --DBMS_OUTPUT.PUT_LINE('V_PARAMS_CNT:'||V_PARAMS_CNT);
        IF V_PARAMS_ARRAY.COUNT <> V_PARAMS_CNT THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '����������SQL�еĲ���������ƥ��';
          --������־
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
        --����
        FOR J IN 1 .. V_PARAMS_ARRAY.COUNT LOOP
          V_PARAM := V_PARAMS_ARRAY(J);
          --  V_INDEX:=V_INDEX+1;
          --�滻SQL�еģ���
          --SELECT  REGEXP_REPLACE(V_SQL,'[?]',V_PARAM,1,V_INDEX) INTO V_SQL  FROM DUAL;
          SELECT REGEXP_REPLACE(V_SQL, '[?��]', V_PARAM, 1, 1)
            INTO V_SQL
            FROM DUAL;
        END LOOP;
      
        DBMS_OUTPUT.PUT_LINE('SQL��' || V_SQL);
        --ִ��sql
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO V_AMOUNT;
        EXCEPTION
          WHEN OTHERS THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := 'ִ�л�ȡ���SQL����ԭ��' || SQLERRM;
            --������־
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
        -- DBMS_OUTPUT.put_line('��'||V_AMOUNT);
        --���½��
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = NVL(V_AMOUNT, 0)
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      --��ȡֵ����Ϊ��Ӧ�к�ʱ   
      FOR I IN (SELECT B.*
                  FROM SPM_GZ_CERT_ITEM_TEMP B
                 WHERE VALUE_TYPE = '2') LOOP
        SELECT SUM(AMOUNT)
          INTO V_AMOUNT
          FROM SPM_GZ_CERT_ITEM_TEMP
         WHERE DRCR_TYPE <> I.DRCR_TYPE
           AND CORRESPOND_LINE = I.AMOUNT;
        --���½��
        UPDATE SPM_GZ_CERT_ITEM_TEMP
           SET AMOUNT = V_AMOUNT
         WHERE ITEM_ID = I.ITEM_ID
           AND LINE_NUMBER = I.LINE_NUMBER;
      END LOOP;
      COMMIT;
      --�жϽ���ܽ���Ƿ����
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
        OUT_MESSAGE     := '����ܽ���ȡ�';
        --������־
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
      --������������
      V_JE_BATCH_NAME := V_ORG_CODE || TO_CHAR(V_GL_DATE, 'YYYY') ||
                         TO_CHAR(V_GL_DATE, 'MM') ||
                         TO_CHAR(V_GL_DATE, 'DD') || V_TEMPLATE_NAME ||
                         P_VERSION_NUMBER;
      --����ʱ���е����ݲ��뵽�����м��
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
          FROM (SELECT 'SPMϵͳ',
                       V_JE_BATCH_NAME, -- ������
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
                       '�û�',
                       '����ϵͳ',
                       '����',
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
      --ִ����������ƾ֤����
      CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => OUT_MESSAGE,
                             RETCODE         => OUT_SUCESS_FLAG,
                             P_DATA_SOURCE   => 'SPMϵͳ',
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
      
        --��ѯ���ɺ��������
        SELECT JE_BATCH_ID, NAME
          INTO V_JE_BATCH_ID, V_JE_BATCH_NAME
          FROM GL_JE_BATCHES
         WHERE NAME LIKE '%' || V_JE_BATCH_NAME || '%';
      
        V_REQUEST_ID := FND_REQUEST.SUBMIT_REQUEST('SQLGL',
                                                   'GLPPOSS',
                                                   '�Զ�����',
                                                   NULL,
                                                   FALSE,
                                                   2021,
                                                   1000, -- NEW PARAMETER
                                                   50348,
                                                   V_JE_BATCH_ID,
                                                   CHR(0));
        IF V_REQUEST_ID <= 0 THEN
          OUT_SUCESS_FLAG := 'E';
          OUT_MESSAGE     := '�Զ����˲��������ύʧ��';
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
          IF L_CHILD_STATUS <> INITCAP('����') THEN
            OUT_SUCESS_FLAG := 'E';
            OUT_MESSAGE     := '�Զ����˲��������ύʧ��';
            RETURN;
          ELSE
            OUT_SUCESS_FLAG := 'S';
            OUT_MESSAGE     := '��������ƾ֤���ݳɹ�';
          END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE('V_JE_BATCH_ID:' || V_JE_BATCH_ID);
        --ƾ֤�� ֻ�й��˺��������ƾ֤�� 
        SELECT JH.EXTERNAL_REFERENCE, JB.NAME, JH.JE_HEADER_ID
          INTO V_CERT_NUMBER, V_JE_BATCH_NAME, V_HEADER_ID
          FROM GL_JE_BATCHES JB, GL_JE_HEADERS JH
         WHERE JH.JE_BATCH_ID = JB.JE_BATCH_ID
           AND JB.JE_BATCH_ID = V_JE_BATCH_ID;
        DBMS_OUTPUT.PUT_LINE('V_HEADER_ID:' || V_HEADER_ID);
      
        --���¸�������
        UPDATE GL_JE_HEADERS GJH
           SET ATTRIBUTE1 = V_ATTACH_CNT
         WHERE GJH.JE_HEADER_ID = V_HEADER_ID;
        --��������ͷ���е��ֽ�����Ϣ
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
        OUT_MESSAGE     := '��������ƾ֤����ʧ�ܣ�ԭ��' || SQLERRM;
        -- RETURN;
    END;
    DBMS_OUTPUT.PUT_LINE('OUT_MESSAGE:' || OUT_MESSAGE);
    DBMS_OUTPUT.PUT_LINE('OUT_SUCESS_FLAG:' || OUT_SUCESS_FLAG);
  
    --������־
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
--�����ύ�Լ���֤ʱУ���ʽ�ƻ�����Ƿ��㹻
--K_PAYMENT_IDS �������S   K_TYPE ����  1:�ύ   2:����
--�����ύ�Լ��������Ҫԭ������Ϊ�ύ��ʱ��û����¼���ӱ���Ϣ
FUNCTION CHECK_CAPITAL_BALANCE_FOR_PAY(K_PAYMENT_IDS VARCHAR2,
                                       K_TYPE        VARCHAR2)
  RETURN VARCHAR2 IS
  RE_MEG                VARCHAR2(2); --���ص�У����   ������ :Y ,���� :N
  K_CAPITAL_ID          NUMBER; --�ʽ�ƻ��������
  K_NUMBER              NUMBER; --��ֵ
  K_DEPT_ID             VARCHAR2(40);
  IDS                   SPM_TYPE_TBL;
  K_PAY_PURPOSE         VARCHAR(40); --������;,�б�--������ 24 ������У��
  K_PLAN_FLAG           VARCHAR(40); --�������� �����¾ɸ���  'Y' :�¸���  'N':�ɸ��� Ϊ�����ָ����˻���ͷ��������Ϣ��
  K_PAY_BANK_ACCOUNT_ID NUMBER; --�������� 11002 ��У��
  JS_NUMBER             NUMBER;
  USED_NUMBER           NUMBER;--�Ѿ����ύռ�ö��
  /*K_DEPT_ID             NUMBER;*/
  BIG_DEPT_CODE         VARCHAR2(40);--���ű��
  K_CHECK               VARCHAR2(40);
BEGIN

  --1.���ݵ�¼�˵Ĳ���������ȡ�ʽ�ƻ��������
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
    --2.��ȡ�ʽ�ƻ����ʣ��ֵ
    SELECT P.THIS_MONTH_BALANCE
      INTO K_NUMBER
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.CAPITAL_ID = K_CAPITAL_ID;*/
     
     K_CHECK :='N';--Ĭ��δ����У��
  
    --IDS(I)  24 �б�--������ 
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(K_PAYMENT_IDS)
      INTO IDS
      FROM DUAL;
  
    --3.1�����У��
    IF K_TYPE = '2' THEN
    
      FOR I IN 1 .. IDS.COUNT LOOP
        --�Ƿ������� 24 ҵ�� 
        SELECT P.PAY_PURPOSE, --������;
               NVL(P.PLAN_FLAG, 'N'), --�¾ɸ���
               NVL(P.PAY_BANK_ACCOUNT_ID, 0), --��������
               TO_CHAR(P.DEPT_ID) --����
          INTO K_PAY_PURPOSE, K_PLAN_FLAG, K_PAY_BANK_ACCOUNT_ID, K_DEPT_ID
          FROM SPM_CON_PAYMENT P
         WHERE P.PAYMENT_ID = IDS(I);
        
        --ȡ���ʽ�ƻ�ʣ����
        IF K_NUMBER IS NULL THEN
           K_CAPITAL_ID := SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(K_DEPT_ID);
            IF K_CAPITAL_ID IS NULL THEN
              /*RE_MEG := 'N';
              RETURN RE_MEG;*/
              --������ʽ�ƻ����޷�����ת�����������ʽ�ʣ���ȸ�0
              K_NUMBER := 0;
            ELSE
              --2.��ȡ�ʽ�ƻ����ʣ��ֵ
              SELECT P.THIS_MONTH_BALANCE
                INTO K_NUMBER
                FROM SPM_CON_CAPITAL_PLAN P
               WHERE P.CAPITAL_ID = K_CAPITAL_ID;
            END IF;
        END IF;
      
       /* IF K_PAY_PURPOSE = '24' THEN
          CONTINUE;
        ELSE*/
          --�ɸ���
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
          --�¸���
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
    
      --3.2�ύ��У�� 
    ELSE
    
      FOR I IN 1 .. IDS.COUNT LOOP
        --�Ƿ������� 24 ҵ�� 
        SELECT P.PAY_PURPOSE,
               NVL(P.PLAN_FLAG, 'N'),
               NVL(P.PAY_BANK_ACCOUNT_ID, 0), --��������
               TO_CHAR(P.DEPT_ID) --����
          INTO K_PAY_PURPOSE, K_PLAN_FLAG, K_PAY_BANK_ACCOUNT_ID, K_DEPT_ID
          FROM SPM_CON_PAYMENT P
         WHERE P.PAYMENT_ID = IDS(I);
         
         --ȡ���ʽ�ƻ�ʣ����
        IF K_NUMBER IS NULL THEN
           K_CAPITAL_ID := SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(K_DEPT_ID);
            IF K_CAPITAL_ID IS NULL THEN
              RE_MEG := 'N';
              RETURN RE_MEG;
            ELSE
              --2.��ȡ���ʽ�ƻ�-��֤��ȣ�������
              SELECT P.CAPITAL_QUOTA - P.PAY_AMOUNT
                INTO K_NUMBER
                FROM SPM_CON_CAPITAL_PLAN P
               WHERE P.CAPITAL_ID = K_CAPITAL_ID;
               
               --��ѯ�Ѿ�������ύռ�õĽ��
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
          --�ɸ���
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
            --�¸���
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
/*--У����Ʊ�ύʱ ��Ӧ��Ʊʣ�����Ƿ����  Y:����  N:*/
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
    --�����Ʊ��ȴ���ʣ����
    IF SP.USED_AMOUNT > SP.RESIDUAL_AMOUNT THEN
      RETURN_MSG := RETURN_MSG || '���ݺ�Ϊ' || sp.invoice_serial_number ||
                    '�����Ʊʣ�����;';
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

--����ҵ���տ�������Ʊ
PROCEDURE CANCEL_YW_RECEIPT_INVOICE(K_RECEIPT_INVOICE_IDS IN VARCHAR2,
                                    MSG                   OUT VARCHAR2)

 IS
  IDS       SPM_TYPE_TBL;
  JS_AMOUNT NUMBER;--�������
  OUT_ID    NUMBER;--���Ʊ����
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
    MSG := '�洢����ִ���쳣';
END CANCEL_YW_RECEIPT_INVOICE;

END SPM_GZ_GZGL_INS_PKG;
/
