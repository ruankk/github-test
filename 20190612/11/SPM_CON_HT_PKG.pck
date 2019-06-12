CREATE OR REPLACE PACKAGE SPM_CON_HT_PKG
/**
 * @author ������
 * @date 2017.08.23
 * @desc �����ͬ�������
 */
 AS
  /**
  * Todo : ��ȡ����
  */
  FUNCTION GET_EXCHANGE_RATE(TCURRENCYCODE IN VARCHAR2) RETURN NUMBER;

  /**
  * ��ȡ��ͬ�����
  */
  FUNCTION GET_CONTRACT_DIFF(CONID IN NUMBER, WFTYPE VARCHAR2)
    RETURN VARCHAR2;

  /**
  * ���ɺ�ͬ���
  */
  FUNCTION GENERATE_CONTRACT_CODE(CONID NUMBER) RETURN VARCHAR2;

  /**
  * ��ͬ�޸�ʱ�������ɺ�ͬ���
  */
  FUNCTION GET_NEW_CONTRACT_CODE(CONID NUMBER, CATEGORYID NUMBER)
    RETURN VARCHAR2;

  /**
  * ��������ͬ��Ϣ���޸ġ�ɾ������ʱ,���ô洢���̸����໥�����ĺ�ͬ��Ϣ
  * @param operationType 1�޸� 2ɾ��
  * @param ids Ҫ�޸Ļ���ɾ����ID
  */
  PROCEDURE MERGE_HT_RELATION_INFO(OPERATIONTYPE IN NUMBER,
                                   RELATIONIDS   IN VARCHAR2);

  /**
  * ��ͬ�½�ʱ�ж����̵ȼ�
  * D���̴���Ϊ11 SPM_CON_PROCESS_TYPE
  * 1:�Ƿ�Ŀ¼��Χ�ڲ�Ʒ,��:D ����
  * 2:�ѹ�����ͬ�Ƿ��Ѿ�������� ��:D ����
  * 3:�ܷ��ṩ��ͬ������˵�� ��:���ղ���˵���ж�;��:ʵ���Բ���
  */
  FUNCTION GET_CREATION_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2;

  /**
  * ��ͬ���ʱ�ж����̵ȼ�
  * D���̴���Ϊ11 SPM_CON_PROCESS_TYPE
  * ��ͬ���ʱ,�������޲���
  * ����Ƿ�ʵ���Ա��,��D����
  * �����ʵ���Ա��,��ԭ������
  */
  FUNCTION GET_CHANGE_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2;

  /**
  * ��ͬ�����,�Զ����ɺ�ͬ�����ͺ�ͬ������Ϣ
  * operation SAVE:��ͬ����,UPDATE:��ͬ�޸�
  **/
  PROCEDURE GENERATE_OTHER_INFO(CONID IN NUMBER, OPERATION IN VARCHAR2);

  /**
  * ��ͬ�ر�ʱ�����ɹر�����
  **/
  PROCEDURE GENERATE_CLOSE_EVALUATE(CONID IN NUMBER);

  /**
  * ��ɾ��
  **/
  PROCEDURE FALSE_DELETION(TABLENAME IN VARCHAR2,
                           DELIDS    IN VARCHAR2,
                           COLNAME   IN VARCHAR2,
                           COLVAL    IN VARCHAR2);

  /**
  * ��ͬ�������ʱ,�����ӱ���Ϣ
  **/
  PROCEDURE SAVE_CONTRACT_CHANGE_INFO(OLDID IN NUMBER, NEWID IN NUMBER);

  /**
  * ����ĺ�ͬ��Чʱ,�����¾ɺ�ͬ��Ϣ
  **/
  PROCEDURE EXCHANGE_CONTRACT_CHANGE_INFO(NEWID IN NUMBER);

  --������ͬ��֤
  PROCEDURE ORDER_CONTRACT_VALIDATE(P_TABLENAME VARCHAR2,
                                    P_TABLEID   VARCHAR2,
                                    P_BATCHCODE VARCHAR2,
                                    P_MSG       OUT VARCHAR2);
  --������ͬ����
  PROCEDURE ORDER_CONTRACT_IMPORT(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  F_TABLENAME VARCHAR2,
                                  F_TABLEID   VARCHAR2,
                                  P_MSG       OUT VARCHAR2);

  --�ж϶�����ͬ�Ƿ��ѹ������Э��
  FUNCTION ORDER_CONTRACT_KJXY(CONID NUMBER) RETURN NUMBER;

  /*
  * ��ȡ���������Ŀ��Э��ID�ͱ��
  * ���ظ�ʽΪ'ID,CODE'����ȡ��������'-1,-1'
  */
  FUNCTION GET_ORDER_KJXY(CONID NUMBER) RETURN VARCHAR2;

  FUNCTION GET_CHANGE_WF_CONTRACT_ID(P_ID NUMBER) RETURN VARCHAR2;

  /*
    ���ݺ�ͬID��ȡ���µ�������ˮ��
    BY MCQ
    20180910
    BUG 001
    �ع��²��䵱��ͬ����Ϊ������ͬʱ����Ҫ���ݶ������ͣ����ۺͲɹ�����ƴ��
    ������ˮ�Ź��� �ɹ�������ţ���ȡ��ǰʮλ��ȡʣ�ಿ�֣�+ ȫ����ˮ�ţ���⡢���⡢��ͬ��ϸ��
    ���۶�����ţ���ȡ��ǰʮλ��ȡʣ�ಿ�֣�+ -1 + ȫ����ˮ�ţ���⡢���⡢��ͬ��ϸ��
    20181120 BY MCQ
  */
  FUNCTION GET_TARGET_CODE(P_ID NUMBER) RETURN VARCHAR2;
  /*
   ��ͬ������ʷ�����ȷ�ĺ�ͬ����  (�ؼ���:��������,�汾��)
   rkk
   20190607
  */
  FUNCTION GET_WF_HISTORY_ID(NOW_HT_ID NUMBER) RETURN NUMBER;

END SPM_CON_HT_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_CON_HT_PKG AS

  FUNCTION GET_EXCHANGE_RATE(TCURRENCYCODE IN VARCHAR2) RETURN NUMBER AS
    RATE NUMBER;
  BEGIN
    SELECT RATE_RMB
      INTO RATE
      FROM SPM_CON_EXCHANGE_RATE
     WHERE CURRENCY_CODE = TCURRENCYCODE;
    RETURN RATE;
  END GET_EXCHANGE_RATE;

  /**
  * ��ȡ��ͬ�����
  * ���غ�ͬID
  */
  FUNCTION GET_CONTRACT_DIFF(CONID IN NUMBER, WFTYPE VARCHAR2)
    RETURN VARCHAR2 AS
    VRESULT    NUMBER;
    CONFLAG    VARCHAR2(40);
    CONVERSION NUMBER;
  BEGIN
    IF WFTYPE = 'CHANGE' THEN
      SELECT S.CONTRACT_FLAG, S.CONTRACT_VERSION
        INTO CONFLAG, CONVERSION
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_ID = CONID;
    
      SELECT CONTRACT_ID
        INTO VRESULT
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_FLAG = CONFLAG
         AND S.CONTRACT_VERSION = CONVERSION - 1;
    
    ELSIF WFTYPE = 'CREATION' THEN
      VRESULT := CONID;
    END IF;
    RETURN VRESULT;
  END;

  /**���ɺ�ͬ���*/
  FUNCTION GENERATE_CONTRACT_CODE(CONID NUMBER) RETURN VARCHAR2 AS
    A         VARCHAR2(32); --���(4λ)
    B         VARCHAR2(32) := 'CWEME'; --���ʼ��ű�ʶ(5λ)
    C         VARCHAR2(32) := '0000'; --���쵥λ��ʶ(4λ)
    D         VARCHAR2(32); --��ͬҵ������
    E         VARCHAR2(32); --��ˮ��
    F         VARCHAR2(32) := 'CN'; --������
    MAXCODE   VARCHAR2(32);
    IS_EXISTS NUMBER; -- ��������������
  BEGIN
    --a���
    SELECT TO_CHAR(SYSDATE, 'YYYY') INTO A FROM DUAL;
    --c���쵥λ��ʶ
    SELECT SUBSTR(S.SHORT_CODE, 5)
      INTO C
      FROM HR_OPERATING_UNITS S
     WHERE S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID;
    --d��ͬҵ������
    SELECT SUBSTR(C.CATEGORY_CODE, 0, 4)
      INTO D
      FROM SPM_CON_CONTRACT_CATEGORY C, SPM_CON_HT_INFO I
     WHERE C.CATEGORY_ID = I.CONTRACT_CATEGORY
       AND I.CONTRACT_ID = CONID;
  
    --e��ˮ��
    E := A || B || C || D;
  
    --����쳣�������δ��ѯ����Ӧ���ݣ���̬��ˮ��Ĭ�ϴ�00001��ʼ
    BEGIN
      SELECT COUNT(1)
        INTO IS_EXISTS
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE LIKE E || '%';
      IF IS_EXISTS <> 0 THEN
        SELECT TO_CHAR(TO_NUMBER(SUBSTR(S.CONTRACT_CODE, 18, 5)) + 1,
                       'FM00000')
          INTO E
          FROM SPM_CON_HT_INFO S
         WHERE S.CONTRACT_CODE =
               (SELECT MAX(CONTRACT_CODE)
                  FROM SPM_CON_HT_INFO
                 WHERE CONTRACT_CODE LIKE E || '%'
                   AND LENGTH(CONTRACT_CODE) = 24)
           AND ROWNUM = 1;
      ELSE
        E := '00001';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        E := '00001';
      
    END;
    RETURN A || B || C || D || E || F;
  
  END GENERATE_CONTRACT_CODE;

  /**
  * ��������ͬ��Ϣ���޸ġ�ɾ������ʱ,���ô洢���̸����໥�����ĺ�ͬ��Ϣ
  * @param operationType 1�޸� 2ɾ��
  * @param ids Ҫ�޸Ļ���ɾ����ID
  */
  PROCEDURE MERGE_HT_RELATION_INFO(OPERATIONTYPE IN NUMBER,
                                   RELATIONIDS   IN VARCHAR2) AS
    IDS      SPM_TYPE_TBL;
    CONID    NUMBER(15);
    CONIDR   NUMBER(15);
    RELASHIP VARCHAR2(40);
    RELABUSS VARCHAR2(40);
    CHANGE   VARCHAR2(40);
    OCONID   NUMBER(15); --�Ϻ�ͬid
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(RELATIONIDS) INTO IDS FROM DUAL;
    IF OPERATIONTYPE = 1 THEN
      FOR I IN 1 .. IDS.COUNT LOOP
        --����relationID��ѯ����ǰ�����ĺ�ͬ
        SELECT S.CONTRACT_ID,
               S.CONTRACT_ID_R,
               S.RELATION_SHIP,
               S.RELATION_BUSINESS
          INTO CONIDR, CONID, RELASHIP, RELABUSS
          FROM SPM_CON_HT_RELATION S
         WHERE S.RELATION_ID = IDS(I);
        --�޸���Ϣ
        UPDATE SPM_CON_HT_RELATION S
           SET S.RELATION_SHIP     = DECODE(RELASHIP, 1, 3, 2, 2, 3, 1),
               S.RELATION_BUSINESS = RELABUSS
         WHERE S.CONTRACT_ID = CONID
           AND S.CONTRACT_ID_R = CONIDR;
      END LOOP;
      --COMMIT;
    ELSIF OPERATIONTYPE = 2 THEN
      FOR I IN 1 .. IDS.COUNT LOOP
        --����relationID��ѯ����ǰ�����ĺ�ͬ
        SELECT S.CONTRACT_ID, S.CONTRACT_ID_R
          INTO CONIDR, CONID
          FROM SPM_CON_HT_RELATION S
         WHERE S.RELATION_ID = IDS(I);
        --�޸���Ϣ
        DELETE FROM SPM_CON_HT_RELATION
         WHERE CONTRACT_ID = CONID
           AND CONTRACT_ID_R = CONIDR;
        --add by ruankk 2018/11/13 ��������ͬɾ��������ϵʱ��һ��������ϵδɾ����bug
        SELECT F.STATUS_CHANGE
          INTO CHANGE
          FROM SPM_CON_HT_INFO F
         WHERE F.CONTRACT_ID = CONIDR;
        --����е�
        IF CHANGE = '2' THEN
          SELECT F.CONTRACT_ID
            INTO OCONID
            FROM SPM_CON_HT_INFO F
           WHERE F.CONTRACT_CODE =
                 (SELECT T.CONTRACT_CODE
                    FROM SPM_CON_HT_INFO T
                   WHERE T.CONTRACT_ID = CONIDR)
             AND F.STATUS_CHANGE = '1';
        
          DELETE FROM SPM_CON_HT_RELATION
           WHERE CONTRACT_ID = CONID
             AND CONTRACT_ID_R = OCONID;
        
        END IF;
      
      END LOOP;
      -- COMMIT;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END MERGE_HT_RELATION_INFO;

  /**
  * ��ͬ�޸�ʱ�������ɺ�ͬ���
  */
  FUNCTION GET_NEW_CONTRACT_CODE(CONID NUMBER, CATEGORYID NUMBER)
    RETURN VARCHAR2 IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    OLDCATEGORYID NUMBER;
    OLDCODE       VARCHAR2(32);
    NEWCODE       VARCHAR2(32) := '';
    A             VARCHAR2(32); --���(4λ)
    B             VARCHAR2(32) := 'CWEME'; --���ʼ��ű�ʶ(5λ)
    C             VARCHAR2(32) := '0000'; --���쵥λ��ʶ(4λ)
    D             VARCHAR2(32); --��ͬҵ������
    E             VARCHAR2(32); --��ˮ��
    F             VARCHAR2(32) := 'CN'; --������
    MAXCODE       VARCHAR2(32);
    VCOU          NUMBER;
    IS_EXISTS     NUMBER; -- ��������������
    TYPE SPM_CON_HT_FILE_TYPE IS TABLE OF SPM_CON_HT_FILE%ROWTYPE INDEX BY BINARY_INTEGER;
    OLDFILE SPM_CON_HT_FILE_TYPE;
    TYPE SPM_CON_CONTRACT_BASIS_TYPE IS TABLE OF NUMBER;
    NEWFILE SPM_CON_CONTRACT_BASIS_TYPE;
  BEGIN
    --���жϺ�ͬ�޸ĺ�ǰ��ID�Ƿ����仯
    SELECT S.CONTRACT_CODE, S.CONTRACT_CATEGORY
      INTO OLDCODE, OLDCATEGORYID
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID;
  
    /**
    * ���:
    * 1.��ͬ��ŷ�ƽ̨����
    * 2.��ͬ����ǰ��δ�����仯
    * 3.����δ�����ͬ����
    * ��ֱ�ӷ���ԭ��ͬ���
    */
    IF LENGTH(OLDCODE) < 24 OR CATEGORYID = OLDCATEGORYID OR
       CATEGORYID IS NULL THEN
      NEWCODE := OLDCODE;
    END IF;
    IF NEWCODE IS NULL THEN
      --�����µĺ�ͬ�����������ɱ��
      --a���
      SELECT TO_CHAR(SYSDATE, 'YYYY') INTO A FROM DUAL;
      --c���쵥λ��ʶ
      SELECT SUBSTR(S.SHORT_CODE, 5)
        INTO C
        FROM HR_OPERATING_UNITS S
       WHERE S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID;
      --d��ͬҵ������
      SELECT SUBSTR(C.CATEGORY_CODE, 0, 4)
        INTO D
        FROM SPM_CON_CONTRACT_CATEGORY C
       WHERE C.CATEGORY_ID = CATEGORYID;
    
      --��ͬ���ͷ����仯��,�������ɸ�����,�Ѿ��ϴ���������,����ɾ��
      SELECT * BULK COLLECT
        INTO OLDFILE
        FROM SPM_CON_HT_FILE S
       WHERE S.CONTRACT_ID = CONID;
      FOR I IN 1 .. OLDFILE.COUNT LOOP
        SELECT SPM_COMMON_PKG.GET_UPLOADFILE_COUNT('SPM_CON_HT_FILE',
                                                   OLDFILE(I).FILE_ID)
          INTO VCOU
          FROM DUAL;
        IF VCOU = 0 THEN
          --��δ�ϴ�����������,ɾ��
          DELETE FROM SPM_CON_HT_FILE S
           WHERE S.FILE_ID = OLDFILE(I).FILE_ID;
          COMMIT;
        END IF;
      END LOOP;
      SELECT S.BASIS_TYPE BULK COLLECT
        INTO NEWFILE
        FROM SPM_CON_CONTRACT_BASIS S
       WHERE S.CATEGORY_ID = CATEGORYID
       ORDER BY S.BASISTYPE_ID;
      FOR I IN 1 .. NEWFILE.COUNT LOOP
        --�ж�Ҫ�����ĸ�������,�Ƿ���ԭ��ͬ�������Ѿ����ڲ������ϴ�������
        SELECT COUNT(*)
          INTO VCOU
          FROM SPM_CON_HT_FILE S
         WHERE S.CONTRACT_ID = CONID
           AND S.BASIS_TYPE = NEWFILE(I);
        IF VCOU = 0 THEN
          INSERT INTO SPM_CON_HT_FILE
            (FILE_ID, CONTRACT_ID, CATEGORY_ID, BASIS_TYPE)
            SELECT SPM_CON_HT_FILE_SEQ.NEXTVAL,
                   CONID,
                   CATEGORYID,
                   NEWFILE(I)
              FROM DUAL;
          COMMIT;
        END IF;
      END LOOP;
      --e��ˮ��
      E := A || B || C || D;
    
      --����쳣�������δ��ѯ����Ӧ���ݣ���̬��ˮ��Ĭ�ϴ�00001��ʼ
      BEGIN
        SELECT COUNT(1)
          INTO IS_EXISTS
          FROM SPM_CON_HT_INFO S
         WHERE S.CONTRACT_CODE LIKE E || '%';
        IF IS_EXISTS <> 0 THEN
          SELECT TO_CHAR(TO_NUMBER(SUBSTR(S.CONTRACT_CODE, 18, 5)) + 1,
                         'FM00000')
            INTO E
            FROM SPM_CON_HT_INFO S
           WHERE S.CONTRACT_CODE =
                 (SELECT MAX(CONTRACT_CODE)
                    FROM SPM_CON_HT_INFO
                   WHERE CONTRACT_CODE LIKE E || '%'
                     AND LENGTH(CONTRACT_CODE) = 24);
        ELSE
          E := '00001';
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          E := '00001';
      END;
      NEWCODE := A || B || C || D || E || F;
    END IF;
    RETURN NEWCODE;
  END;

  /**
  * ��ͬ�½�ʱ�ж����̵ȼ�
  * D���̴���Ϊ11 SPM_CON_PROCESS_TYPE
  * 1:�Ƿ�Ŀ¼��Χ�ڲ�Ʒ,��:D ����
  * 2:�ѹ�����ͬ�Ƿ��Ѿ�������� ��:D ����
  * 3:�ܷ��ṩ��ͬ������˵�� ��:���ղ���˵���ж�;��:ʵ���Բ���
  */
  FUNCTION GET_CREATION_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2 AS
  
    DIFFLEVEL  NUMBER := -1;
    WFLEVELSTR VARCHAR2(100);
    VSTATUS    VARCHAR2(32);
    COU        NUMBER;
    ISWFEXIST  NUMBER := 1;
    DLEVEL     NUMBER := 11; --D�����̴���
  
    HT     SPM_CON_HT_INFO%ROWTYPE;
    OLD_HT SPM_CON_HT_INFO%ROWTYPE;
  
    TYPE SPM_CON_HT_DIFF_TYPE IS TABLE OF SPM_CON_HT_DIFF%ROWTYPE INDEX BY BINARY_INTEGER;
    DIFF SPM_CON_HT_DIFF_TYPE;
  
    TYPE SPM_CON_HT_RELATION_TYPE IS TABLE OF SPM_CON_HT_RELATION%ROWTYPE INDEX BY BINARY_INTEGER;
    RELA SPM_CON_HT_RELATION_TYPE;
  
    TYPE SPM_CON_CONTRACT_PROCESS_TYPE IS TABLE OF SPM_CON_CONTRACT_PROCESS%ROWTYPE INDEX BY BINARY_INTEGER;
    WF_CONF SPM_CON_CONTRACT_PROCESS_TYPE;
  
    TYPE TYPE_ARRAY IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    VAR_ARRAY TYPE_ARRAY;
  
    V_WF_CONF1 VARCHAR2(10);
    V_WF_CONF2 VARCHAR2(10);
    V_WF_CONF3 VARCHAR2(10);
  
  BEGIN
    /**
    * ����ֵ�����5�������,˳������
    * 0 �ж�����
    * 1 �жϽ��(�ܷ��ѯ����Ӧ����������) 1����,0������
    * 2 ���̵ȼ�
    * 3 ��������
    * 4 ��ͬ���켶��
    */
  
    SELECT * INTO HT FROM SPM_CON_HT_INFO S WHERE S.CONTRACT_ID = CONID;
  
    IF HT.IS_PRODUCT_CATALOG = 1 THEN
      --�����ϵͳ��ר��ܿ�Ŀ¼�������ԭ�����ǡ��ĳɡ��񡱰��ա��񡱴������ԭ���ǡ��񡱱��Ϊ���ǡ����ա��񡱴���
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_HT_INFO
       WHERE CONTRACT_FLAG = HT.CONTRACT_FLAG
         AND CONTRACT_VERSION = HT.CONTRACT_VERSION - 1;
    
      IF COU = 1 THEN
        SELECT *
          INTO OLD_HT
          FROM SPM_CON_HT_INFO
         WHERE CONTRACT_FLAG = HT.CONTRACT_FLAG
           AND CONTRACT_VERSION = HT.CONTRACT_VERSION - 1;
      
        IF OLD_HT.IS_PRODUCT_CATALOG = 0 THEN
          WFLEVELSTR := NULL;
        ELSE
          WFLEVELSTR := 'PRODUCT,';
        END IF;
      ELSE
        --Step1.�Ƿ�Ŀ¼��Χ�ڲ�Ʒ,��:D���� ����
        WFLEVELSTR := 'PRODUCT,';
      END IF;
    
    END IF;
  
    --Step2.�ѹ����ĺ�ͬ�Ƿ�������ϣ���D����
    /* ��ʱȡ��Step2
    SELECT *
      INTO RELA
      FROM SPM_CON_HT_RELATION S
     WHERE S.CONTRACT_ID = CONID;
    
    IF RELA.COUNT = 0 THEN
      WFLEVELSTR := '';
    ELSE
      WFLEVELSTR := 'RELATION,';
      FOR I IN 1 .. RELA.COUNT LOOP
        SELECT STATUS
          INTO VSTATUS
          FROM SPM_CON_HT_INFO S
         WHERE S.CONTRACT_ID = RELA(I).CONTRACT_ID_R;
        IF VSTATUS < 'AZ' OR VSTATUS = 'D' THEN
          WFLEVELSTR := '';
          EXIT;
        END IF;
      END LOOP;
    END IF;*/
  
    /*
    2018=11-01 ŷ��
    --Step3.��ѯ��ͬ���͵���������,�����ƥ��
    W,0,100
    W,100,300
    W,300
    */
    IF WFLEVELSTR IS NULL THEN
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_CONTRACT_PROCESS S
       WHERE S.CATEGORY_ID = HT.CONTRACT_CATEGORY;
    
      IF COU > 0 THEN
        SELECT * BULK COLLECT
          INTO WF_CONF
          FROM SPM_CON_CONTRACT_PROCESS S
         WHERE S.CATEGORY_ID = HT.CONTRACT_CATEGORY;
      
        FOR I IN 1 .. WF_CONF.COUNT LOOP
          IF INSTR(WF_CONF(I).CONTRACT_DIFFERENCE, ',') > 0 THEN
            --�����˽��
            V_WF_CONF1 := NULL;
            V_WF_CONF2 := NULL;
            V_WF_CONF3 := NULL;
          
            V_WF_CONF1 := SUBSTR(WF_CONF(I).CONTRACT_DIFFERENCE, 1, 1);
            V_WF_CONF2 := SUBSTR(WF_CONF(I).CONTRACT_DIFFERENCE, 3);
          
            IF INSTR(V_WF_CONF2, ',') > 0 THEN
              V_WF_CONF3 := SUBSTR(V_WF_CONF2, INSTR(V_WF_CONF2, ',') + 1);
              V_WF_CONF2 := SUBSTR(V_WF_CONF2,
                                   1,
                                   INSTR(V_WF_CONF2, ',') - 1);
            END IF;
          
            --��������
            /*
            * 2018-11-05 ŷ��
              ��ȡ��ͬ��ȡ����ҽ��
            */
            IF V_WF_CONF1 = 'W' THEN
              IF HT.RMB_TOTAL / 10000 > V_WF_CONF2 THEN
                IF V_WF_CONF3 IS NULL THEN
                  --���ƥ��
                  WFLEVELSTR := 'JE_W,';
                  DLEVEL     := WF_CONF(I).PROCESS_TYPE;
                ELSE
                  IF HT.RMB_TOTAL / 10000 <= V_WF_CONF3 THEN
                    --���ƥ��
                    WFLEVELSTR := 'JE_W,';
                    DLEVEL     := WF_CONF(I).PROCESS_TYPE;
                  END IF;
                END IF;
              END IF;
            
            ELSE
              --������
              NULL;
            END IF;
          END IF;
        END LOOP;
      
      END IF;
    END IF;
  
    IF WFLEVELSTR IS NULL THEN
      --Step4.�ܷ��ṩ������˵��
      IF HT.NO_DIFF_REMARKS = 1 THEN
        --��:ʵ���Բ���,ʵ���Բ������Ϊ3
        DIFFLEVEL  := 3;
        WFLEVELSTR := 'DIFF_N,';
      ELSE
        --��:���ݺ�ͬ������жϺ�ͬ����
        SELECT * BULK COLLECT
          INTO DIFF
          FROM SPM_CON_HT_DIFF S
         WHERE S.CONTRACT_ID = CONID;
      
        FOR I IN 1 .. DIFF.COUNT LOOP
          IF SPM_CON_UTIL_PKG.IS_NUMBER(DIFF(I).DIFF_LEVEL, 'I') = 1 THEN
            /*�ж��Ƿ�����*/
            IF TO_NUMBER(DIFF(I).DIFF_LEVEL) > DIFFLEVEL THEN
              DIFFLEVEL := TO_NUMBER(DIFF(I).DIFF_LEVEL);
            END IF;
          END IF;
        END LOOP;
        WFLEVELSTR := 'DIFF_Y,';
      END IF;
      --��ȡ�ò��������Ƿ���������
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_CONTRACT_PROCESS S
       WHERE S.CATEGORY_ID = TO_NUMBER(HT.CONTRACT_CATEGORY)
         AND S.CONTRACT_DIFFERENCE = TO_CHAR(DIFFLEVEL);
    
      IF COU = 1 THEN
        SELECT S.PROCESS_TYPE
          INTO DLEVEL
          FROM SPM_CON_CONTRACT_PROCESS S
         WHERE S.CATEGORY_ID = TO_NUMBER(HT.CONTRACT_CATEGORY)
           AND S.CONTRACT_DIFFERENCE = TO_CHAR(DIFFLEVEL);
      ELSE
        IF COU = 0 THEN
          WFLEVELSTR := WFLEVELSTR || '1,Y0,-,' || DIFFLEVEL; --��ѯ����
        ELSIF COU > 1 THEN
          WFLEVELSTR := WFLEVELSTR || '1,Y1,-,' || DIFFLEVEL; --������Ϣ����
        END IF;
        RETURN WFLEVELSTR;
      END IF;
    END IF;
    --�ж�isWfExist,����������Ϣ�Ƿ����
  
    --�Ѿ��жϳ����̵ȼ�,�������жϸõȼ������Ƿ��ж�Ӧ����
    WFLEVELSTR := WFLEVELSTR || ISWFEXIST || ',' || DLEVEL || ',' ||
                  SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_PROCESS_TYPE',
                                                          DLEVEL) || ',' ||
                  DIFFLEVEL;
  
    RETURN WFLEVELSTR;
  END GET_CREATION_WF_LEVEL;

  /**
  * ��ͬ���ʱ�ж����̵ȼ�
  * D���̴���Ϊ11 SPM_CON_PROCESS_TYPE
  * ��ͬ���ʱ,�������޲���
  * ����Ƿ�ʵ���Ա��,��D����
  * �����ʵ���Ա��,��ԭ������
  */
  FUNCTION GET_CHANGE_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2 AS
    DIFFLEVEL  NUMBER := -1;
    WFLEVELSTR VARCHAR2(100);
    VSTATUS    VARCHAR2(32);
    COU        NUMBER;
    ISWFEXIST  NUMBER := 1;
    DLEVEL     NUMBER := 11; --D�����̴���
  
    TYPE SPM_CON_HT_INFO_TYPE IS TABLE OF SPM_CON_HT_INFO%ROWTYPE INDEX BY BINARY_INTEGER;
    HT SPM_CON_HT_INFO_TYPE;
  
    TYPE SPM_CON_HT_DIFF_TYPE IS TABLE OF SPM_CON_HT_DIFF%ROWTYPE INDEX BY BINARY_INTEGER;
    DIFF SPM_CON_HT_DIFF_TYPE;
  
  BEGIN
    SELECT * BULK COLLECT
      INTO DIFF
      FROM SPM_CON_HT_DIFF S
     WHERE S.CONTRACT_ID = CONID;
  
    FOR I IN 1 .. DIFF.COUNT LOOP
      IF SPM_CON_UTIL_PKG.IS_NUMBER(DIFF(I).DIFF_LEVEL, 'I') = 1 THEN
        IF TO_NUMBER(DIFF(I).DIFF_LEVEL) > DIFFLEVEL THEN
          DIFFLEVEL := TO_NUMBER(DIFF(I).DIFF_LEVEL);
        END IF;
      END IF;
    END LOOP;
  
    /**
    * 2018=11-01 ŷ��
    * ��ͬ���ʱ,�������޲���
    * ����Ƿ�ʵ���Ա��,��D����
    * �����ʵ���Ա��,��ԭ������
    */
    IF DIFFLEVEL = 1 THEN
      WFLEVELSTR := 'N,0';
      RETURN WFLEVELSTR;
    
    ELSIF DIFFLEVEL = 2 THEN
      WFLEVELSTR := 'Y,' || ISWFEXIST || ',' || DLEVEL || ',' ||
                    SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_PROCESS_TYPE',
                                                            DLEVEL) || ',' ||
                    DIFFLEVEL;
      RETURN WFLEVELSTR;
    
    ELSIF DIFFLEVEL = 3 THEN
      RETURN GET_CREATION_WF_LEVEL(CONID);
    
    END IF;
    /*
      --Step1.�Ƿ�Ŀ¼��Χ�ڲ�Ʒ,��:D���� ����
      SELECT * BULK COLLECT
        INTO ht
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_ID = conId;
    
      IF ht(1).IS_PRODUCT_CATALOG = 1 THEN
        wfLevelStr := 'PRODUCT,';
      ELSE
        --Step2.�ѹ����ĺ�ͬ�Ƿ��������
        SELECT * BULK COLLECT
          INTO rela
          FROM SPM_CON_HT_RELATION S
         WHERE S.CONTRACT_ID = conId;
    
        wfLevelStr := 'RELATION,';
        IF rela.COUNT = 0 THEN
          wfLevelStr := '';
        ELSE
          FOR i IN 1 .. rela.COUNT LOOP
            SELECT STATUS
              INTO vStatus
              FROM SPM_CON_HT_INFO S
             WHERE S.CONTRACT_ID = rela(i).CONTRACT_ID_R;
            IF vStatus < 'AZ' OR vStatus = 'D' THEN
              wfLevelStr := '';
              EXIT;
            END IF;
          END LOOP;
        END IF;
    
        IF wfLevelStr IS NULL THEN
          --Step3.ʵ���Բ���
          --��ȡ�ò��������Ƿ���������
    
          SELECT COUNT(1)
            INTO cou
            FROM SPM_CON_CONTRACT_PROCESS S
           WHERE S.CATEGORY_ID = ht(1).CONTRACT_CATEGORY
             AND S.CONTRACT_DIFFERENCE = diffLevel;
          wfLevelStr := 'DIFF,';
          IF cou = 1 THEN
            SELECT S.PROCESS_TYPE
              INTO dLevel
              FROM SPM_CON_CONTRACT_PROCESS S
             WHERE S.CATEGORY_ID = ht(1).CONTRACT_CATEGORY
               AND S.CONTRACT_DIFFERENCE = diffLevel;
          ELSE
            IF cou = 0 THEN
              wfLevelStr := wfLevelStr || '1,Y0,-,' || diffLevel; --��ѯ����
            ELSIF cou > 1 THEN
              wfLevelStr := wfLevelStr || '1,Y1,-,' || diffLevel; --������Ϣ����
            END IF;
            RETURN wfLevelStr;
          END IF;
        END IF;
      END IF;
    END IF;
    
    --�ж�isWfExist,����������Ϣ�Ƿ����
    
    --�Ѿ��жϳ����̵ȼ�,�������жϸõȼ������Ƿ��ж�Ӧ����
    SELECT wfLevelStr || isWfExist || ',' || dLevel || ',' ||
           SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_PROCESS_TYPE',
                                                   dLevel) || ',' ||
           diffLevel
      INTO wfLevelStr
      FROM DUAL;
    
    RETURN wfLevelStr;*/
  
  END GET_CHANGE_WF_LEVEL;

  /**
  * ��ͬ�����,�Զ����ɺ�ͬ�����,��ͬ������Ϣ,��ͬ�鵵���ϱ�
  * operation SAVE:��ͬ����,UPDATE:��ͬ�޸�
  **/
  PROCEDURE GENERATE_OTHER_INFO(CONID IN NUMBER, OPERATION IN VARCHAR2) AS
    SV      NUMBER;
    CC      NUMBER;
    V_CCODE VARCHAR2(100);
    DICT    SPM_TYPE_TBL;
    ARCH    SPM_TYPE_TBL;
    --���ַ�ʽ���Ի�ȡ���ȫ����Ϣ����ȻҲ�����ö��SPM_TYPE_TBLȥ�洢������Ϣ
    TYPE BASIC_TABLE_TYPE IS TABLE OF SPM_CON_CONTRACT_BASIS%ROWTYPE INDEX BY BINARY_INTEGER;
    BT BASIC_TABLE_TYPE;
  BEGIN
    --��ȡ������ͬ�ĺ�ͬ����
    SELECT S.CONTRACT_CATEGORY
      INTO CC
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID;
  
    --�������ֵ���ȡ��ͬ��������
    SELECT D.DICT_NAME BULK COLLECT
      INTO DICT
      FROM SPM_DICT D, SPM_DICT_TYPE T
     WHERE T.TYPE_CODE = 'SPM_CON_HT_DIFF_ITEM'
       AND D.DICT_TYPE_ID = T.DICT_TYPE_ID
     ORDER BY D.DISPLAY_ORDER;
  
    --�������ֵ���ȡҪ�鵵����������
    SELECT D.DICT_NAME BULK COLLECT
      INTO ARCH
      FROM SPM_DICT D, SPM_DICT_TYPE T
     WHERE T.TYPE_CODE = 'SPM_CON_HT_ARCHIVE_LIST'
       AND D.DICT_TYPE_ID = T.DICT_TYPE_ID
     ORDER BY D.DISPLAY_ORDER;
  
    SELECT * BULK COLLECT
      INTO BT
      FROM SPM_CON_CONTRACT_BASIS S
     WHERE S.CATEGORY_ID = CC
     ORDER BY S.BASISTYPE_ID;
  
    IF OPERATION = 'SAVE' THEN
    
      --���ɺ�ͬ���
    
      SELECT GENERATE_CONTRACT_CODE(CONID) INTO V_CCODE FROM DUAL;
    
      UPDATE SPM_CON_HT_INFO S
         SET S.CONTRACT_CODE = V_CCODE
       WHERE S.CONTRACT_ID = CONID;
    
      --������ͬ�����
      FOR I IN 1 .. DICT.COUNT LOOP
        SELECT SPM_CON_HT_DIFF_SEQ.NEXTVAL INTO SV FROM DUAL;
        INSERT INTO SPM_CON_HT_DIFF
          (DIFF_ID, CONTRACT_ID, DIFF_ITEM)
          SELECT SV, CONID, DICT(I) FROM DUAL;
      END LOOP;
    
      --������ͬ������
      FOR I IN 1 .. BT.COUNT LOOP
        SELECT SPM_CON_HT_FILE_SEQ.NEXTVAL INTO SV FROM DUAL;
        INSERT INTO SPM_CON_HT_FILE
          (FILE_ID, CONTRACT_ID, CATEGORY_ID, BASIS_TYPE)
          SELECT SV, CONID, CC,BT(I).BASIS_TYPE FROM DUAL;
      END LOOP;
    
      /*
      * ������ͬ�鵵���ϱ�
      *  ATTRIBUTE5����ͨ�������ֵ佨����,�޷�ɾ��
      */
      FOR I IN 1 .. ARCH.COUNT LOOP
        SELECT SPM_CON_HT_ARCHIVED_SEQ.NEXTVAL INTO SV FROM DUAL;
        INSERT INTO SPM_CON_HT_ARCHIVED
          (ARCHIVED_ID,
           CONTRACT_ID,
           ARCHIVED_DATA,
           IS_TRANSFER,
           IS_RECEIVE,
           IS_ARCHIVED,
           IS_PUBLIC)
          SELECT SV, CONID, ARCH(I), 0, 0, 0, 1 FROM DUAL;
      END LOOP;
    
      --COMMIT;
    ELSIF OPERATION = 'UPDATE' THEN
      DBMS_OUTPUT.PUT_LINE('');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
    
  END GENERATE_OTHER_INFO;

  /**
  * ��ͬ�ر�ʱ�����ɹر�����
  **/
  PROCEDURE GENERATE_CLOSE_EVALUATE(CONID IN NUMBER) AS
    TYPE MERCHANTS_TYPE IS TABLE OF SPM_CON_HT_MERCHANTS%ROWTYPE INDEX BY BINARY_INTEGER;
    MER      MERCHANTS_TYPE;
    DICT     SPM_TYPE_TBL;
    EID      NUMBER;
    DID      NUMBER;
    DICTCODE VARCHAR2(100);
  BEGIN
    SELECT * BULK COLLECT
      INTO MER
      FROM SPM_CON_HT_MERCHANTS S
     WHERE S.CONTRACT_ID = CONID;
  
    FOR I IN 1 .. MER.COUNT LOOP
      --����������Ϣ
      SELECT SPM_CON_HT_EVALUATE_SEQ.NEXTVAL INTO EID FROM DUAL;
      INSERT INTO SPM_CON_HT_EVALUATE
        (EVALUATE_ID,
         CONTRACT_ID,
         MERCHANTS_FLAG,
         EVALUATE_TYPE,
         EVALUATE_DATE,
         MERCHANTS_ID,
         CREATION_DATE,
         EVALUATE_STATUS)
        SELECT EID,
               MER(I).CONTRACT_ID,
               MER(I).MERCHANTS_FLAG,
               'B',
               TRUNC(SYSDATE),
               MER(I).MERCHANTS_ID,
               SYSDATE,
               'A'
          FROM DUAL;
      --������������
      IF MER(I).MERCHANTS_FLAG = '1' THEN
        DICTCODE := 'CUST_EVALUATE_TYPE';
      ELSIF MER(I).MERCHANTS_FLAG = '2' THEN
        DICTCODE := 'VENDOR_EVALUATE_TYPE';
      END IF;
    
      SELECT D.DICT_NAME BULK COLLECT
        INTO DICT
        FROM SPM_DICT D, SPM_DICT_TYPE T
       WHERE T.TYPE_CODE = DICTCODE
         AND D.DICT_TYPE_ID = T.DICT_TYPE_ID
       ORDER BY D.DISPLAY_ORDER;
    
      FOR I IN 1 .. DICT.COUNT LOOP
        SELECT SPM_CON_EVALUATE_DETAIL_SEQ.NEXTVAL INTO DID FROM DUAL;
        INSERT INTO SPM_CON_HT_EVALUATE_DETAIL
          (EVALUATE_DETAIL_ID,
           EVALUATE_ID,
           EVALUATE_CONTENT_TYPE,
           EVALUATE_CONTET_DETAIL,
           EVALUATE_SCORE)
          SELECT DID, EID, DICT(I), '', 0 FROM DUAL;
      END LOOP;
    
    END LOOP;
  
  END GENERATE_CLOSE_EVALUATE;

  /**
  * ��ɾ��
  **/
  PROCEDURE FALSE_DELETION(TABLENAME IN VARCHAR2,
                           DELIDS    IN VARCHAR2,
                           COLNAME   IN VARCHAR2,
                           COLVAL    IN VARCHAR2) AS
    IDS  SPM_TYPE_TBL;
    VSQL VARCHAR2(2000);
  BEGIN
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(DELIDS) INTO IDS FROM DUAL;
    FOR I IN 1 .. IDS.COUNT LOOP
      VSQL := 'UPDATE ' || TABLENAME || ' SET ' || COLNAME || ' = ' ||
              COLVAL || ' WHERE ';
    END LOOP;
  END FALSE_DELETION;

  /**
  * ��ͬ�������ʱ,�����ӱ���Ϣ
  * ��Ŀ
  * �����
  * �ո�������
  * �����ƻ�
  * �෽����
  * ������ͬ
  * ��ͬ�����
  * �ͻ���Ӧ��
  * ��ͬ�ı�������
  **/
  PROCEDURE SAVE_CONTRACT_CHANGE_INFO(OLDID IN NUMBER, NEWID IN NUMBER) AS
    TYPE FILE_TYPE IS TABLE OF SPM_CON_HT_FILE%ROWTYPE INDEX BY BINARY_INTEGER;
    FILE   FILE_TYPE;
    FILEID NUMBER;
    CURSOR CUR_TARGET IS
      SELECT * FROM SPM_CON_HT_TARGET WHERE CONTRACT_ID = OLDID;
    V_GOODS_PLAN     SPM_CON_HT_GOODS_PLAN%ROWTYPE;
    V_COUNT          NUMBER;
    V_TARGET_SEQ     NUMBER;
    V_GOODS_PLAN_SEQ NUMBER;
  BEGIN
    --Step1.������Ŀ
    INSERT INTO SPM_CON_HT_PROJECT
      (CON_PRO_RELATION_ID,
       CONTRACT_ID,
       PROJECT_ID,
       ORG_ID,
       DEPT_ID,
       CREATED_BY)
      SELECT SPM_CON_HT_PROJECT_SEQ.NEXTVAL,
             NEWID,
             PROJECT_ID,
             ORG_ID,
             DEPT_ID,
             CREATED_BY
        FROM SPM_CON_HT_PROJECT
       WHERE CONTRACT_ID = OLDID;
  
    --Step2.���Ʊ����
    /*2018-10-26 ŷ��
    �޸�����ĺ�ͬ����ɾ�������ʱ����Ӧ�Ľ����ƻ����Զ�ɾ����BUG��
    1�������ͽ����ƻ��й�������Ҫһ���ơ�
    2�����н����ƻ����е�TAGET_ID�ǽ����ƻ���Ӧ�ı�����ID����ɾ�������ʱ��ɾ����Ӧ�Ľ����ƻ���
    3�������ڸ��Ʊ����ͽ����ƻ�ʱ����Ҫ���½���������
    */
    FOR V_TARGET IN CUR_TARGET LOOP
      SELECT COUNT(*)
        INTO V_COUNT
        FROM SPM_CON_HT_GOODS_PLAN
       WHERE CONTRACT_ID = V_TARGET.CONTRACT_ID
         AND TARGET_ID = V_TARGET.TARGET_ID;
      IF V_COUNT > 0 THEN
        SELECT *
          INTO V_GOODS_PLAN
          FROM SPM_CON_HT_GOODS_PLAN
         WHERE CONTRACT_ID = V_TARGET.CONTRACT_ID
           AND TARGET_ID = V_TARGET.TARGET_ID;
      
        V_TARGET_SEQ     := SPM_CON_HT_TARGET_SEQ.NEXTVAL;
        V_GOODS_PLAN_SEQ := SPM_CON_HT_GOODS_PLAN_SEQ.NEXTVAL;
      
        V_GOODS_PLAN.GOODS_PLAN_ID := V_GOODS_PLAN_SEQ;
        V_GOODS_PLAN.CONTRACT_ID   := NEWID;
        V_GOODS_PLAN.TARGET_ID     := V_TARGET_SEQ;
      
        V_TARGET.TARGET_ID   := V_TARGET_SEQ;
        V_TARGET.CONTRACT_ID := NEWID;
      
        INSERT INTO SPM_CON_HT_TARGET
          (TARGET_ID,
           CONTRACT_ID,
           PURCHASE_ORDER_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           TARGET_UNIT,
           TARGET_COUNT,
           UNIT_PRICE,
           TARGET_AMOUNT,
           TAX_RATE,
           TAX_AMOUNT,
           NOTAX_AMOUNT,
           IS_DELETE,
           REMARK,
           PIPELINE_NUMBER,
           STOVE_NUMBER,
           CODE_TYPE,
           GOODS_CLASS,
           SPECIFICATION_MODEL,
           SPECIFICATION_PACKING,
           TARGET_PARAMS,
           ORG_ID,
           CREATED_BY,
           TAX_CODE)
        VALUES
          (V_TARGET.TARGET_ID,
           V_TARGET.CONTRACT_ID,
           V_TARGET.PURCHASE_ORDER_ID,
           V_TARGET.MATERIAL_CODE,
           V_TARGET.MATERIAL_NAME,
           V_TARGET.TARGET_UNIT,
           V_TARGET.TARGET_COUNT,
           V_TARGET.UNIT_PRICE,
           V_TARGET.TARGET_AMOUNT,
           V_TARGET.TAX_RATE,
           V_TARGET.TAX_AMOUNT,
           V_TARGET.NOTAX_AMOUNT,
           V_TARGET.IS_DELETE,
           V_TARGET.REMARK,
           V_TARGET.PIPELINE_NUMBER,
           V_TARGET.STOVE_NUMBER,
           V_TARGET.CODE_TYPE,
           V_TARGET.GOODS_CLASS,
           V_TARGET.SPECIFICATION_MODEL,
           V_TARGET.SPECIFICATION_PACKING,
           V_TARGET.TARGET_PARAMS,
           V_TARGET.ORG_ID,
           V_TARGET.CREATED_BY,
           V_TARGET.TAX_CODE);
      
        INSERT INTO SPM_CON_HT_GOODS_PLAN
          (GOODS_PLAN_ID,
           CONTRACT_ID,
           TARGET_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           PLAN_DATE,
           GOODS_PLACE,
           GOODS_MODE,
           GOODS_CONDITION,
           IS_TARGET_DEL,
           ORG_ID,
           DEPT_ID,
           CREATED_BY)
        VALUES
          (V_GOODS_PLAN.GOODS_PLAN_ID,
           V_GOODS_PLAN.CONTRACT_ID,
           V_GOODS_PLAN.TARGET_ID,
           V_GOODS_PLAN.MATERIAL_CODE,
           V_GOODS_PLAN.MATERIAL_NAME,
           V_GOODS_PLAN.PLAN_DATE,
           V_GOODS_PLAN.GOODS_PLACE,
           V_GOODS_PLAN.GOODS_MODE,
           V_GOODS_PLAN.GOODS_CONDITION,
           V_GOODS_PLAN.IS_TARGET_DEL,
           V_GOODS_PLAN.ORG_ID,
           V_GOODS_PLAN.DEPT_ID,
           V_GOODS_PLAN.CREATED_BY);
      
      END IF;
    END LOOP;
    /*
        INSERT INTO SPM_CON_HT_TARGET
          (TARGET_ID,
           CONTRACT_ID,
           PURCHASE_ORDER_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           TARGET_UNIT,
           TARGET_COUNT,
           UNIT_PRICE,
           TARGET_AMOUNT,
           TAX_RATE,
           TAX_AMOUNT,
           NOTAX_AMOUNT,
           IS_DELETE,
           REMARK,
           PIPELINE_NUMBER,
           STOVE_NUMBER,
           CODE_TYPE,
           GOODS_CLASS,
           SPECIFICATION_MODEL,
           SPECIFICATION_PACKING,
           TARGET_PARAMS,
           ORG_ID,
           CREATED_BY,
           TAX_CODE)
          SELECT SPM_CON_HT_TARGET_SEQ.NEXTVAL,
                 newId,
                 PURCHASE_ORDER_ID,
                 MATERIAL_CODE,
                 MATERIAL_NAME,
                 TARGET_UNIT,
                 TARGET_COUNT,
                 UNIT_PRICE,
                 TARGET_AMOUNT,
                 TAX_RATE,
                 TAX_AMOUNT,
                 NOTAX_AMOUNT,
                 IS_DELETE,
                 REMARK,
                 PIPELINE_NUMBER,
                 STOVE_NUMBER,
                 CODE_TYPE,
                 GOODS_CLASS,
                 SPECIFICATION_MODEL,
                 SPECIFICATION_PACKING,
                 TARGET_PARAMS,
                 ORG_ID,
                 CREATED_BY,
                 TAX_CODE
            FROM SPM_CON_HT_TARGET
           WHERE CONTRACT_ID = oldId;
        --Step4.���ƽ����ƻ�
        INSERT INTO SPM_CON_HT_GOODS_PLAN
          (GOODS_PLAN_ID,
           CONTRACT_ID,
           MATERIAL_CODE,
           MATERIAL_NAME,
           PLAN_DATE,
           GOODS_PLACE,
           GOODS_MODE,
           GOODS_CONDITION,
           IS_TARGET_DEL,
           ORG_ID,
           DEPT_ID,
           CREATED_BY)
          SELECT SPM_CON_HT_GOODS_PLAN_SEQ.NEXTVAL,
                 newId,
                 MATERIAL_CODE,
                 MATERIAL_NAME,
                 PLAN_DATE,
                 GOODS_PLACE,
                 GOODS_MODE,
                 GOODS_CONDITION,
                 IS_TARGET_DEL,
                 ORG_ID,
                 DEPT_ID,
                 CREATED_BY
            FROM SPM_CON_HT_GOODS_PLAN
           WHERE CONTRACT_ID = oldId;
    */
    --Step3.�����ո�������
    INSERT INTO SPM_CON_HT_CLAUSE
      (CLAUSE_ID,
       CONTRACT_ID,
       PAYMENT_TYPE,
       PAYMENT_CONDITION,
       PAYMENT_RATIO,
       CURRENCY_TYPE,
       IN_OUT_TYPE,
       TOTAL_MONEY,
       RMB_TOTAL,
       SETTLEMENT_METHOD,
       PAY_ORG_ID,
       IS_DELETE,
       ORG_ID,
       DEPT_ID,
       CREATED_BY)
      SELECT SPM_CON_HT_CLAUSE_SEQ.NEXTVAL,
             NEWID,
             PAYMENT_TYPE,
             PAYMENT_CONDITION,
             PAYMENT_RATIO,
             CURRENCY_TYPE,
             IN_OUT_TYPE,
             TOTAL_MONEY,
             RMB_TOTAL,
             SETTLEMENT_METHOD,
             PAY_ORG_ID,
             IS_DELETE,
             ORG_ID,
             DEPT_ID,
             CREATED_BY
        FROM SPM_CON_HT_CLAUSE
       WHERE CONTRACT_ID = OLDID;
  
    --�����ո��������
    INSERT INTO SPM_CON_HT_CLAUSE_FILE
      (CLAUSE_FILE_ID,
       CONTRACT_ID,
       CLAUSE_ID,
       PAYMENT_TYPE,
       FILE_TYPE,
       IS_REQUIRED)
      SELECT SPM_CON_HT_CLAUSE_FILE_SEQ.NEXTVAL,
             NEWID,
             CLAUSE_ID,
             PAYMENT_TYPE,
             FILE_TYPE,
             IS_REQUIRED
        FROM SPM_CON_HT_CLAUSE_FILE
       WHERE CONTRACT_ID = OLDID;
  
    --Step5.���ƶ෽����
    INSERT INTO SPM_CON_HT_SUBJECT
      (SUBJECT_ID, CONTRACT_ID, SUBJECT_DEPT_ID, ORG_ID, CREATED_BY)
      SELECT SPM_CON_HT_SUBJECT_SEQ.NEXTVAL,
             NEWID,
             SUBJECT_DEPT_ID,
             ORG_ID,
             CREATED_BY
        FROM SPM_CON_HT_SUBJECT
       WHERE CONTRACT_ID = OLDID;
  
    --Step6.���ƹ�����ͬ
    INSERT INTO SPM_CON_HT_RELATION
      (RELATION_ID,
       CONTRACT_ID,
       CONTRACT_ID_R,
       RELATION_SHIP,
       RELATION_BUSINESS,
       RELATION_ACTION,
       ORG_ID,
       DEPT_ID,
       CREATED_BY)
      SELECT SPM_CON_HT_RELATION_SEQ.NEXTVAL,
             NEWID,
             CONTRACT_ID_R,
             RELATION_SHIP,
             RELATION_BUSINESS,
             RELATION_ACTION,
             ORG_ID,
             DEPT_ID,
             CREATED_BY
        FROM SPM_CON_HT_RELATION
       WHERE CONTRACT_ID = OLDID;
  
    --Step7.��������õĺ�ͬ�����
    INSERT INTO SPM_CON_HT_DIFF
      (DIFF_ID, CONTRACT_ID, DIFF_ITEM, ORG_ID, CREATED_BY)
      SELECT SPM_CON_HT_DIFF_SEQ.NEXTVAL,
             NEWID,
             DIFF_ITEM,
             ORG_ID,
             CREATED_BY
        FROM SPM_CON_HT_DIFF
       WHERE CONTRACT_ID = OLDID;
  
    --Step8.���ƿͻ�/��Ӧ��
    INSERT INTO SPM_CON_HT_MERCHANTS
      (CON_MERCHANTS_ID,
       CONTRACT_ID,
       MERCHANTS_ID,
       MERCHANTS_FLAG,
       IN_OUT_TYPE,
       ORG_ID,
       CREATED_BY)
      SELECT SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
             NEWID,
             MERCHANTS_ID,
             MERCHANTS_FLAG,
             IN_OUT_TYPE,
             ORG_ID,
             CREATED_BY
        FROM SPM_CON_HT_MERCHANTS
       WHERE CONTRACT_ID = OLDID;
  
    --Step9.���ƺ�ͬ�ı�������
  
    SELECT * BULK COLLECT
      INTO FILE
      FROM SPM_CON_HT_FILE S
     WHERE S.CONTRACT_ID = OLDID;
  
    FOR I IN 1 .. FILE.COUNT LOOP
      SELECT SPM_CON_HT_FILE_SEQ.NEXTVAL INTO FILEID FROM DUAL;
      INSERT INTO SPM_CON_HT_FILE
        (FILE_ID,
         CONTRACT_ID,
         CATEGORY_ID,
         QR_CODE,
         BASIS_TYPE,
         BASIS_NAME,
         FILE_REMARK,
         ORG_ID,
         DEPT_ID,
         CREATED_BY)
        SELECT FILEID,
               NEWID,
               CATEGORY_ID,
               QR_CODE,
               BASIS_TYPE,
               BASIS_NAME,
               FILE_REMARK,
               ORG_ID,
               DEPT_ID,
               CREATED_BY
          FROM SPM_CON_HT_FILE
         WHERE FILE_ID = FILE(I).FILE_ID;
    
      INSERT INTO SPM_UPLOAD_FILE
        (FILE_ID,
         FILE_ORG_NAME,
         FILE_PATH_NAME,
         FILE_EXTENSION,
         MIME_TYPE,
         ASS_TABLE_NAME,
         ASS_TABLE_PRIKEY_ID,
         REMARK,
         CREATED_BY,
         FILE_CATEGORY,
         ASS_ID1,
         ASS_ID2,
         ASS_ID3,
         ASS_ID4)
        SELECT SPM_UPLOAD_FILE_SEQ.NEXTVAL,
               FILE_ORG_NAME,
               FILE_PATH_NAME,
               FILE_EXTENSION,
               MIME_TYPE,
               ASS_TABLE_NAME,
               FILEID,
               REMARK,
               CREATED_BY,
               FILE_CATEGORY,
               ASS_ID1,
               ASS_ID2,
               ASS_ID3,
               ASS_ID4
          FROM SPM_UPLOAD_FILE
         WHERE ASS_TABLE_NAME = 'SPM_CON_HT_FILE'
           AND ASS_TABLE_PRIKEY_ID = FILE(I).FILE_ID;
    END LOOP;
  
  END SAVE_CONTRACT_CHANGE_INFO;

  /**
  * ����ĺ�ͬ��Чʱ,�����¾ɺ�ͬ��Ϣ
  **/
  PROCEDURE EXCHANGE_CONTRACT_CHANGE_INFO(NEWID IN NUMBER) AS
    OLDID   NUMBER;
    CONFLAG VARCHAR2(40);
  BEGIN
    --��ȡ��ͬ��ʶ
    SELECT CONTRACT_FLAG
      INTO CONFLAG
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_ID = NEWID
       AND ROWNUM < 2;
  
    SELECT CONTRACT_ID
      INTO OLDID
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_FLAG = CONFLAG
       AND STATUS_CHANGE = 1;
  
    --Step1.����������Ϣ(����ID��ͬʱ����"���ɱ����Ϣ��)
    --STATUS_CHANGE 1���ú�ͬ 2���(������) 3���(��ʷ)
    UPDATE SPM_CON_HT_INFO S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END),
           S.CHANGE_REMARK = (CASE
                               WHEN CONTRACT_ID = OLDID THEN
                                (SELECT CHANGE_REMARK
                                   FROM SPM_CON_HT_INFO
                                  WHERE CONTRACT_ID = NEWID)
                               ELSE
                                (SELECT CHANGE_REMARK
                                   FROM SPM_CON_HT_INFO
                                  WHERE CONTRACT_ID = OLDID)
                             END),
           S.STATUS_CHANGE = (CASE
                               WHEN CONTRACT_ID = OLDID THEN
                                3
                               ELSE
                                1
                             END),
           S.ITEM_KEY = (CASE
                          WHEN CONTRACT_ID = OLDID THEN
                           (SELECT ITEM_KEY
                              FROM SPM_CON_HT_INFO
                             WHERE CONTRACT_ID = NEWID)
                          ELSE
                           (SELECT ITEM_KEY
                              FROM SPM_CON_HT_INFO
                             WHERE CONTRACT_ID = OLDID)
                        END),
           S.STATUS = (CASE
                        WHEN CONTRACT_ID = OLDID THEN
                         (SELECT STATUS
                            FROM SPM_CON_HT_INFO
                           WHERE CONTRACT_ID = NEWID)
                        ELSE
                         (SELECT STATUS
                            FROM SPM_CON_HT_INFO
                           WHERE CONTRACT_ID = OLDID)
                      END),
           S.STATUS_ARCHIVED = (CASE
                                 WHEN CONTRACT_ID = OLDID THEN
                                  (SELECT STATUS_ARCHIVED
                                     FROM SPM_CON_HT_INFO
                                    WHERE CONTRACT_ID = NEWID)
                                 ELSE
                                  (SELECT STATUS_ARCHIVED
                                     FROM SPM_CON_HT_INFO
                                    WHERE CONTRACT_ID = OLDID)
                               END),
           S.IS_URGENT = (CASE
                           WHEN CONTRACT_ID = OLDID THEN
                            (SELECT IS_URGENT
                               FROM SPM_CON_HT_INFO
                              WHERE CONTRACT_ID = NEWID)
                           ELSE
                            (SELECT IS_URGENT
                               FROM SPM_CON_HT_INFO
                              WHERE CONTRACT_ID = OLDID)
                         END),
           S.LAST_UPDATE_DATE = SYSDATE,
           S.STATUS_URGENT = (CASE
                               WHEN CONTRACT_ID = OLDID THEN
                                (SELECT STATUS_URGENT
                                   FROM SPM_CON_HT_INFO
                                  WHERE CONTRACT_ID = NEWID)
                               ELSE
                                (SELECT STATUS_URGENT
                                   FROM SPM_CON_HT_INFO
                                  WHERE CONTRACT_ID = OLDID)
                             END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step2.������Ŀ��Ϣ
    UPDATE SPM_CON_HT_PROJECT S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step3.�����������Ϣ
    UPDATE SPM_CON_HT_TARGET S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step4.�����ո���������Ϣ
    UPDATE SPM_CON_HT_CLAUSE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
    --�����ո����������Ϣ
    UPDATE SPM_CON_HT_CLAUSE_FILE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step5.���������ƻ���Ϣ
    UPDATE SPM_CON_HT_GOODS_PLAN S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step6.�����෽������Ϣ
    UPDATE SPM_CON_HT_SUBJECT S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step7.����������ͬ��Ϣ
    UPDATE SPM_CON_HT_RELATION S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
    --add by ruankk 2018/11/13 �������еĺ�ͬ������ͬʱ���ֵ�bug
    UPDATE SPM_CON_HT_RELATION S
       SET S.CONTRACT_ID_R = OLDID
     WHERE S.CONTRACT_ID_R = NEWID;
  
    --Step8.������ͬ�������Ϣ
    UPDATE SPM_CON_HT_DIFF S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step9.�����ͻ�/��Ӧ����Ϣ
    UPDATE SPM_CON_HT_MERCHANTS S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step10.������ͬ�ı���������Ϣ
    UPDATE SPM_CON_HT_FILE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    UPDATE SPM_UPLOAD_FILE S
       SET S.ASS_TABLE_PRIKEY_ID = (CASE
                                     WHEN ASS_TABLE_PRIKEY_ID = OLDID THEN
                                      NEWID
                                     ELSE
                                      OLDID
                                   END)
     WHERE S.ASS_TABLE_NAME = 'SPM_CON_HT_FILE'
       AND S.ASS_TABLE_PRIKEY_ID = OLDID
        OR S.ASS_TABLE_PRIKEY_ID = NEWID;
  
    --Step11.����������Ϣ (������Ϣ����Ҫ����)
    UPDATE SPM_CON_HT_EFFECTIVE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step12.����������ʷ
    /*UPDATE SPM_CON_HT_WF_ACTIVITY S
    SET S.JOB_ID = (CASE WHEN JOB_ID = oldId THEN newId ELSE oldId END)
    WHERE S.JOB_ID = oldId OR S.JOB_ID = newId
    AND S.WF_CODE IN ('SPM_CON_HT_CREATION','SPM_CON_HT_CREATION_URGENT','SPM_CON_HT_EFFECTIVE');
    
    UPDATE SPM_CON_WF_HISTORY S
    SET S.ASS_TABLE_PRIKEY_ID = (CASE WHEN ASS_TABLE_PRIKEY_ID = oldId THEN newId ELSE oldId END)
    WHERE S.ASS_TABLE_PRIKEY_ID = oldId OR S.ASS_TABLE_PRIKEY_ID = newId
    AND S.WF_CODE IN ('SPM_CON_HT_CREATION','SPM_CON_HT_CREATION_URGENT','SPM_CON_HT_EFFECTIVE');
    */
  END;

  --������ͬ��֤
  PROCEDURE ORDER_CONTRACT_VALIDATE(P_TABLENAME VARCHAR2,
                                    P_TABLEID   VARCHAR2,
                                    P_BATCHCODE VARCHAR2,
                                    P_MSG       OUT VARCHAR2) AS
    COU       NUMBER;
    TC        NUMBER;
    TP        NUMBER;
    IDEN      NUMBER := 1;
    ORDERTYPE NUMBER := 0; --1�ɹ�0����
    ORDERNAME VARCHAR2(4000);
    CGCODE    VARCHAR2(4000);
    XSCODE    VARCHAR2(4000);
    VSQL      VARCHAR2(4000);
    TITLE     VARCHAR2(4000);
    VSTR      VARCHAR2(4000);
    COLLEN    NUMBER;
    VNUM      NUMBER;
    VSTATUS   VARCHAR2(32);
    TITLES    SPM_TYPE_TBL;
    TYPE SPM_IMPORT_TEMP_D_TYPE IS TABLE OF SPM_IMPORT_TEMP_D%ROWTYPE INDEX BY BINARY_INTEGER;
    ST SPM_IMPORT_TEMP_D_TYPE;
    --�ɹ������۶�����һ���ɹ��������
    XSARR      SPM_TYPE_TBL := SPM_TYPE_TBL('���۶������',
                                            '��������',
                                            '��Ӧ������',
                                            '�ɹ���֯',
                                            '�ɹ�����',
                                            '�ɹ�Ա',
                                            '�ɹ�Ա�绰',
                                            '˰��',
                                            '����',
                                            '�ܽ��',
                                            '�Ƶ�ʱ��',
                                            '������ע');
    XSCOLARR   SPM_TYPE_TBL := SPM_TYPE_TBL('CONTRACT_CODE',
                                            'CONTRACT_NAME',
                                            'VENDOR_NAME',
                                            'PURCHASE_ORG',
                                            'PURCHASE_DEPT',
                                            'BUYER_NAME',
                                            'BUYER_TEL',
                                            'TAX_RATE',
                                            'CURRENCY_TYPE',
                                            'CONTRACT_AMOUNT',
                                            'CREATION_DATE',
                                            'CONTRACT_REMARK');
    CGARR      SPM_TYPE_TBL := SPM_TYPE_TBL('�ɹ��������',
                                            '���۶������',
                                            '��������',
                                            '��Ӧ������',
                                            '�ɹ���֯',
                                            '�ɹ�����',
                                            '�ɹ�Ա',
                                            '�ɹ�Ա�绰',
                                            '˰��',
                                            '����',
                                            '�ܽ��',
                                            '�Ƶ�ʱ��',
                                            '������ע');
    CGCOLARR   SPM_TYPE_TBL := SPM_TYPE_TBL('CONTRACT_CODE',
                                            'CONTRACT_CODE',
                                            'CONTRACT_NAME',
                                            'VENDOR_NAME',
                                            'PURCHASE_ORG',
                                            'PURCHASE_DEPT',
                                            'BUYER_NAME',
                                            'BUYER_TEL',
                                            'TAX_RATE',
                                            'CURRENCY_TYPE',
                                            'CONTRACT_AMOUNT',
                                            'CREATION_DATE',
                                            'CONTRACT_REMARK');
    SHRARR     SPM_TYPE_TBL := SPM_TYPE_TBL('�ջ���',
                                            '�ջ���λ',
                                            '�ջ��˵绰',
                                            '�ջ��˵�ַ');
    SHRCOLARR  SPM_TYPE_TBL := SPM_TYPE_TBL('RECEIVE_USER',
                                            'RECEIVE_ORG',
                                            'RECEIVE_TEL',
                                            'RECEIVE_ADDRESS');
    KPARR      SPM_TYPE_TBL := SPM_TYPE_TBL('��Ʊ����',
                                            '��Ʊ�˺�',
                                            '��Ʊ˰��',
                                            '��Ʊ�绰',
                                            '��Ʊ��ϵ��',
                                            '��Ʊ����',
                                            '��Ʊ��ַ',
                                            '��Ʊ��ע');
    KPCOLARR   SPM_TYPE_TBL := SPM_TYPE_TBL('INVOICE_BANK',
                                            'INVOICE_ACCOUNT',
                                            'INVOICE_RATE_NUMBER',
                                            'INVOICE_TEL',
                                            'INVOICE_USER',
                                            'INVOICE_TYPE',
                                            'INVOICE_ADDRESS',
                                            'REMARK');
    WLARR      SPM_TYPE_TBL := SPM_TYPE_TBL('���',
                                            '��ƷС��',
                                            '��Ӧ����Ʒ����',
                                            '��Ʒ����',
                                            '��Ʒ����',
                                            '��Ʒ����',
                                            '����ͺ�',
                                            '��װ���',
                                            '��������',
                                            'ͼ��',
                                            '����',
                                            '������λ',
                                            '��������',
                                            '���ۣ�Ԫ��',
                                            '�ϼƣ�Ԫ��',
                                            '��ע');
    INFOARR    SPM_TYPE_TBL;
    INFOCOLARR SPM_TYPE_TBL;
  BEGIN
  
    --Step1.�жϵ������Ϣ�Ƿ������ƽ̨������һ��
    --�жϵ����xls�ǲɹ��������۶���
    SELECT COUNT(1)
      INTO ORDERTYPE
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ��������'
     ORDER BY S.TEMP_D_ID;
    IF ORDERTYPE > 0 THEN
      INFOARR    := CGARR;
      INFOCOLARR := CGCOLARR;
    ELSE
      INFOARR    := XSARR;
      INFOCOLARR := XSCOLARR;
    END IF;
    --�ж϶�����Ϣ�Ƿ�ȱ����Ϣ
    FOR I IN 1 .. INFOARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = INFOARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '��������Ϣ����ȱ��[' || INFOARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '��������Ϣ����[' || INFOARR(I) || ']���ڶ���\n';
      END IF;
    END LOOP;
  
    --�ж��ջ�����Ϣ�Ƿ�ȱ����Ϣ
    FOR I IN 1 .. SHRARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = SHRARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '���ջ�����Ϣ����ȱ��[' || SHRARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '���ջ�����Ϣ����[' || SHRARR(I) || ']���ڶ���\n';
      END IF;
    END LOOP;
    --�жϿ�Ʊ��Ϣʦ��ȱ����Ϣ
    FOR I IN 1 .. KPARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = KPARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '����Ʊ��Ϣ����ȱ��[' || KPARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '����Ʊ��Ϣ����[' || KPARR(I) || ']���ڶ���\n';
      END IF;
    END LOOP;
    --�жϲɹ�������Ϣ�Ƿ�ȱ����Ϣ
    COU := WLARR.COUNT + 2;
    SELECT 'SELECT ' || LISTAGG(COLUMN_NAME, '||'',''||') WITHIN GROUP(ORDER BY S.COLUMN_ID) || ' FROM SPM_IMPORT_TEMP_D WHERE TEMP_M_ID = ' || P_BATCHCODE || ' AND A = ''���'''
      INTO VSQL
      FROM USER_TAB_COLS S
     WHERE S.TABLE_NAME = 'SPM_IMPORT_TEMP_D'
       AND S.COLUMN_ID BETWEEN 3 AND COU
     ORDER BY S.COLUMN_ID;
  
    EXECUTE IMMEDIATE VSQL
      INTO TITLE;
  
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(TITLE) INTO TITLES FROM DUAL;
  
    IF TITLES.COUNT = WLARR.COUNT THEN
      FOR I IN 1 .. TITLES.COUNT LOOP
        IF TITLES(I) <> WLARR(I) THEN
          P_MSG := P_MSG || '���ɹ�������Ϣ������ӳ��е����Ĳ�һ��;\n';
          EXIT;
        END IF;
      END LOOP;
    ELSE
      P_MSG := P_MSG || '���ɹ�������Ϣ������ӳ��е����Ĳ�һ��;\n';
    END IF;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  
    --Step2.��֤����������Ƿ����SPM���ҵ��Ҫ��
    /**
    * �򶩵�����ʱ��Ҫ���������ϵ
    * ���Դ���һ���Ⱥ��������
    * ��Ϊ����������δ����,�����ȵ���Ķ����Ҳ�������������ID
    * ����,�ڵ��붩��ʱ,���˵��붩����ȫ����Ϣ��,
    * ����������ɹ�������,����CONTRACT_ID��CONTARCT_CODE
    * ������CONTRACT_NAME
    */
    --��֤������Ϣ-�������
    IF ORDERTYPE = 1 THEN
      SELECT B
        INTO CGCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '�ɹ��������';
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = CGCODE
         AND S.CONTRACT_NAME IS NOT NULL;
      IF COU > 0 THEN
        P_MSG := P_MSG || '��������Ϣ��[�ɹ��������]' || CGCODE || '�Ѵ���,�����ظ�����;\n';
        RETURN;
      ELSE
        IF TRIM(CGCODE) IS NULL THEN
          P_MSG := P_MSG || '��������Ϣ��[�ɹ��������]������Ϊ��;\n';
        ELSE
          COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                       'SPM_CON_HT_INFO',
                                                       'CONTRACT_CODE');
          IF LENGTH(CGCODE) > FLOOR(COLLEN / 2) THEN
            P_MSG := P_MSG || '��������Ϣ��[�ɹ��������]�������ַ�Ϊ' || FLOOR(COLLEN / 2) ||
                     ';\n';
          ELSIF REGEXP_REPLACE(CGCODE, '[0-9]|[a-z]|[A-Z]|[-]', '') IS NOT NULL THEN
            P_MSG := P_MSG || '��������Ϣ��[�ɹ��������]ֻ���������֡���ĸ��\"-\"���;\n';
          END IF;
        END IF;
      END IF;
      --�жϲɹ�������ź����۶�������Ƿ��ж�Ӧ��ϵ
      SELECT B
        INTO XSCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '���۶������';
    
      IF XSCODE || '-1' <> CGCODE THEN
        P_MSG := P_MSG || '��������Ϣ����[���۶������]��[�ɹ��������]�����ɶ�Ӧ��ϵ;\n';
      ELSE
        BEGIN
          SELECT S.STATUS
            INTO VSTATUS
            FROM SPM_CON_HT_INFO S
           WHERE S.CONTRACT_CODE = XSCODE;
        EXCEPTION
          WHEN OTHERS THEN
            VSTATUS := '';
        END;
        IF VSTATUS LIKE 'I%' THEN
          P_MSG := '��������Ϣ����[���۶������]' || XSCODE ||
                   '�����������ϻ���������,�޷��������������;\n';
        END IF;
      END IF;
    ELSIF ORDERTYPE = 0 THEN
      SELECT B
        INTO XSCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '���۶������';
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = XSCODE
         AND S.CONTRACT_NAME IS NOT NULL;
      IF COU > 0 THEN
        P_MSG := P_MSG || '��������Ϣ��[���۶������]' || XSCODE || '�Ѵ���,�����ظ�����;\n';
        RETURN;
      ELSE
        IF TRIM(XSCODE) IS NULL THEN
          P_MSG := P_MSG || '��������Ϣ��[���۶������]������Ϊ��;\n';
        ELSE
          COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                       'SPM_CON_HT_INFO',
                                                       'CONTRACT_CODE');
          IF LENGTH(XSCODE) > FLOOR(COLLEN / 2) THEN
            P_MSG := P_MSG || '��������Ϣ��[���۶������]�������ַ�Ϊ' || FLOOR(COLLEN / 2) ||
                     ';\n';
          ELSIF REGEXP_REPLACE(XSCODE, '[0-9]|[a-z]|[A-Z]|[-]', '') IS NOT NULL THEN
            P_MSG := P_MSG || '��������Ϣ��[���۶������]ֻ���������֡���ĸ��\"-\"���;\n';
          ELSE
            BEGIN
              SELECT S.STATUS
                INTO VSTATUS
                FROM SPM_CON_HT_INFO S
               WHERE S.CONTRACT_CODE = XSCODE || '-1';
            EXCEPTION
              WHEN OTHERS THEN
                VSTATUS := '';
            END;
            IF VSTATUS LIKE 'I%' THEN
              P_MSG := '��������Ϣ����[���۶������]' || XSCODE ||
                       '�������Ĳɹ����������������ϻ���������,�޷��������������;\n';
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    --��֤ʣ����Ϣ
    FOR I IN 1 .. INFOARR.COUNT LOOP
      SELECT B
        INTO VSTR
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = INFOARR(I);
      --��������:�ǿ���֤
      IF INFOARR(I) = '��������' THEN
        IF VSTR IS NULL THEN
          P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']������Ϊ��;\n';
        END IF;
      END IF;
      --��Ӧ������:�������
      IF INFOARR(I) = '��Ӧ����Ϣ' THEN
        IF ORDERTYPE = 1 THEN
          --�ͻ�
          SELECT COUNT(1)
            INTO COU
            FROM AR_CUSTOMERS S
           WHERE S.CUSTOMER_NAME = VSTR;
          IF COU = 0 THEN
            P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']��EBS�в�����;\n';
          END IF;
        ELSE
          SELECT COUNT(1)
            INTO COU
            FROM AP_SUPPLIERS S
           WHERE S.VENDOR_NAME = VSTR;
          IF COU = 0 THEN
            P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']��EBS�в�����;\n';
          END IF;
        END IF;
      END IF;
      --˰�ʱ���������
      IF INFOARR(I) = '˰��' THEN
        IF VSTR IS NOT NULL THEN
          IF SPM_CON_UTIL_PKG.IS_NUMBER(VSTR, '') = 0 THEN
            P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']ֻ������������;\n';
          END IF;
        END IF;
      END IF;
      --������ұ���Ϊ����
      IF INFOARR(I) = '�ܽ��' THEN
        IF VSTR IS NULL THEN
          P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']������Ϊ��;\n';
        ELSE
          IF SPM_CON_UTIL_PKG.IS_NUMBER(SUBSTR(VSTR, 0, LENGTH(VSTR) - 1),
                                        '') = 0 THEN
            P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']ֻ������������;\n';
          END IF;
        END IF;
      END IF;
      --��֤�����Ƿ����Ҫ��
    
      --��֤����
      IF INFOARR(I) = '�Ƶ�ʱ��' THEN
        IF SPM_CON_UTIL_PKG.IS_DATE(VSTR, 'YYYY-MM-DD') = 0 THEN
          P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']������Ҫ��' ||
                   FLOOR(COLLEN / 2) || ';\n';
        END IF;
      ELSE
        COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                     'SPM_CON_HT_INFO',
                                                     INFOCOLARR(I));
        IF LENGTH(VSTR) > FLOOR(COLLEN / 2) THEN
          P_MSG := P_MSG || '��������Ϣ��[' || INFOARR(I) || ']�������ַ�Ϊ' ||
                   FLOOR(COLLEN / 2) || ';\n';
        END IF;
      END IF;
    END LOOP;
  
    --�ջ�����Ϣ
    FOR I IN 1 .. SHRARR.COUNT LOOP
      SELECT B
        INTO VSTR
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = SHRARR(I);
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_RECEIVER',
                                                   SHRCOLARR(I));
      IF LENGTH(VSTR) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ջ�����Ϣ��[' || SHRARR(I) || ']�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  
    --��Ʊ��Ϣ
    FOR I IN 1 .. KPARR.COUNT LOOP
      SELECT B
        INTO VSTR
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = KPARR(I);
    
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_INVOICE',
                                                   KPCOLARR(I));
      IF LENGTH(VSTR) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '����Ʊ��Ϣ��[' || KPARR(I) || ']�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  
    --�ɹ�������Ϣ
    SELECT * BULK COLLECT
      INTO ST
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND SPM_CON_UTIL_PKG.IS_NUMBER(S.A, 'I') = 1
     ORDER BY S.TEMP_D_ID;
  
    FOR I IN 1 .. ST.COUNT LOOP
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'GOODS_CLASS');
      IF LENGTH(ST(I).B) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��ƷС��](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'MATERIAL_CODE');
      IF LENGTH(ST(I).D) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��Ʒ����](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'MATERIAL_NAME');
      IF LENGTH(ST(I).E) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��Ʒ����](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_PARAMS');
      IF LENGTH(ST(I).F) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��Ʒ����](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'SPECIFICATION_MODEL');
      IF LENGTH(ST(I).G) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[����ͺ�](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'SPECIFICATION_PACKING');
      IF LENGTH(ST(I).H) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��װ���](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_UNIT');
      IF LENGTH(ST(I).L) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[������λ](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_COUNT');
      IF LENGTH(ST(I).M) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��������](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).M, '') = 0 THEN
          P_MSG := P_MSG || '���ɹ�������Ϣ��[��������](���' || I || ')ֻ������������;\n';
        ELSE
          TC := TO_NUMBER(ST(I).M);
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'UNIT_PRICE');
      IF LENGTH(ST(I).N) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[���ۣ�Ԫ��](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).N, '') = 0 THEN
          P_MSG := P_MSG || '���ɹ�������Ϣ��[���ۣ�Ԫ��](���' || I || ')ֻ������������;\n';
        ELSE
          TP := TO_NUMBER(ST(I).N);
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_AMOUNT');
      IF LENGTH(ST(I).O) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[�ϼƣ�Ԫ��](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).O, '') = 0 THEN
          P_MSG := P_MSG || '���ɹ�������Ϣ��[�ϼƣ�Ԫ��](���' || I || ')ֻ������������;\n';
        ELSE
          IF TC * TP <> TO_NUMBER(ST(I).O) THEN
            P_MSG := P_MSG || '���ɹ�������Ϣ��[�ϼƣ�Ԫ��](���' || I ||
                     ') �� ���������ۣ�Ԫ��;\n';
          END IF;
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'REMARK');
      IF LENGTH(ST(I).P) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '���ɹ�������Ϣ��[��ע](���' || I || ')�������ַ�Ϊ' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  END ORDER_CONTRACT_VALIDATE;

  --������ͬ����
  PROCEDURE ORDER_CONTRACT_IMPORT(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  F_TABLENAME VARCHAR2,
                                  F_TABLEID   VARCHAR2,
                                  P_MSG       OUT VARCHAR2) AS
    CONID            NUMBER;
    COU              NUMBER;
    CONCODE          VARCHAR2(100);
    RELACODE         VARCHAR2(100); --������ͬ���
    CHILDID          NUMBER;
    TAXRATE          NUMBER;
    INOUTTYPE        NUMBER;
    ORDERTYPE        NUMBER;
    ORDERID          NUMBER;
    ISREALORDEREXIST NUMBER := 0;
    A                VARCHAR2(4000);
    B                VARCHAR2(4000);
    C                VARCHAR2(4000);
    D                VARCHAR2(4000);
    E                VARCHAR2(4000);
    F                VARCHAR2(4000);
    G                VARCHAR2(4000);
    H                VARCHAR2(4000);
    I                VARCHAR2(4000);
    J                VARCHAR2(4000);
    K                VARCHAR2(4000);
    L                VARCHAR2(4000);
    M                VARCHAR2(4000);
    N                VARCHAR2(4000);
    MERID            NUMBER;
    DEPTID           NUMBER;
    TYPE SPM_IMPORT_TEMP_D_TYPE IS TABLE OF SPM_IMPORT_TEMP_D%ROWTYPE INDEX BY BINARY_INTEGER;
    ST SPM_IMPORT_TEMP_D_TYPE;
  BEGIN
    /**
    * �򶩵�����ʱ��Ҫ���������ϵ
    * ���Դ���һ���Ⱥ��������
    * ��Ϊ����������δ����,�����ȵ���Ķ����Ҳ�������������ID
    * ����,�ڵ��붩��ʱ,���˵��붩����ȫ����Ϣ��,
    * ����������ɹ�������,����CONTRACT_ID��CONTARCT_CODE
    * ������CONTRACT_NAME
    */
  
    --Step1.�ж��ǲɹ������������۶���
    SELECT COUNT(1)
      INTO ORDERTYPE
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ��������'
     ORDER BY S.TEMP_D_ID;
    IF ORDERTYPE = 1 THEN
      SELECT S.B
        INTO CONCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '�ɹ��������'
       ORDER BY S.TEMP_D_ID;
      RELACODE := SUBSTR(CONCODE, 1, LENGTH(CONCODE) - 2);
    ELSE
      SELECT S.B
        INTO CONCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '���۶������'
       ORDER BY S.TEMP_D_ID;
      RELACODE := CONCODE || '-1';
    END IF;
  
    --Step2.���붩����Ϣ
    --�жϹ��������Ƿ��Ѿ�Ԥ����
    SELECT COUNT(1)
      INTO ISREALORDEREXIST
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_CODE = RELACODE;
    --��ȡ������Ϣ
    SELECT S.B, S.Q
      INTO A, L
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��������';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ӧ������';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ���֯';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ�����';
    SELECT S.B
      INTO E
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ�Ա';
    SELECT S.B
      INTO F
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ɹ�Ա�绰';
    SELECT S.B
      INTO G
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '˰��';
    SELECT S.B
      INTO H
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '����';
    SELECT S.B
      INTO I
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ܽ��';
    SELECT S.B
      INTO J
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�Ƶ�ʱ��';
    SELECT S.B
      INTO K
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '������ע';
    TAXRATE := TO_NUMBER(NVL(G, 0)) * 100;
    DEPTID  := TO_NUMBER(L);
    IF ISREALORDEREXIST = 0 THEN
      --��������δ����,˵����һ�Թ��������ǵ�1˳����
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO CONID FROM DUAL;
      INSERT INTO SPM_CON_HT_INFO
        (CONTRACT_ID,
         CONTRACT_NAME,
         CONTRACT_CODE,
         CONTRACT_CATEGORY,
         IN_OUT_TYPE,
         CONTRACT_AMOUNT,
         CURRENCY_TYPE,
         RMB_TOTAL,
         CONTRACT_REMARK,
         CONTRACT_TYPE,
         BUYER_NAME,
         BUYER_TEL,
         VENDOR_NAME,
         PURCHASE_ORG,
         PURCHASE_DEPT,
         ORDER_TYPE,
         TAX_RATE,
         CONTRACT_FLAG,
         CONTRACT_VERSION,
         STATUS_CHANGE,
         STATUS,
         STATUS_ARCHIVED,
         IS_URGENT,
         ORG_ID,
         DEPT_ID,
         CREATED_BY,
         CREATION_DATE)
      VALUES
        (CONID,
         A,
         CONCODE,
         DECODE(ORDERTYPE, 0, 1000232, 1, 1000240),
         DECODE(ORDERTYPE, 0, 1, 1, 2),
         TO_NUMBER(I),
         'CNY',
         TO_NUMBER(I),
         K,
         2,
         E,
         F,
         B,
         C,
         D,
         DECODE(ORDERTYPE, 0, 1, 1, 2),
         TAXRATE,
         SYS_GUID(),
         1,
         1,
         'E',
         'J',
         0,
         SPM_SSO_PKG.GETORGID,
         DEPTID,
         FND_GLOBAL.USER_ID,
         TO_DATE(J, 'YYYY-MM-DD HH24:MI:SS'));
    ELSE
      --˵���ǲɹ�/���۶����ǵ�2˳�����
      SELECT CONTRACT_ID
        INTO CONID
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = CONCODE;
    
      UPDATE SPM_CON_HT_INFO
         SET CONTRACT_NAME     = A,
             CONTRACT_CATEGORY = DECODE(ORDERTYPE, 0, 1000232, 1, 1000240),
             IN_OUT_TYPE       = DECODE(ORDERTYPE, 0, 1, 1, 2),
             CONTRACT_AMOUNT   = TO_NUMBER(I),
             CURRENCY_TYPE     = 'CNY',
             RMB_TOTAL         = TO_NUMBER(I),
             CONTRACT_REMARK   = K,
             CONTRACT_TYPE     = 2,
             BUYER_NAME        = E,
             BUYER_TEL         = F,
             VENDOR_NAME       = B,
             PURCHASE_ORG      = C,
             PURCHASE_DEPT     = D,
             ORDER_TYPE        = DECODE(ORDERTYPE, 0, 1, 1, 2),
             TAX_RATE          = TAXRATE,
             CONTRACT_FLAG     = SYS_GUID(),
             CONTRACT_VERSION  = 1,
             STATUS_CHANGE     = 1,
             STATUS            = 'E',
             STATUS_ARCHIVED   = 'J',
             IS_URGENT         = 0,
             ORG_ID            = SPM_SSO_PKG.GETORGID,
             DEPT_ID           = DEPTID,
             CREATED_BY        = FND_GLOBAL.USER_ID,
             CREATION_DATE     = TO_DATE(J, 'YYYY-MM-DD HH24:MI:SS')
       WHERE CONTRACT_ID = CONID;
    END IF;
    --Step.M���빩Ӧ�̿ͻ���Ϣ(��)
    IF ORDERTYPE = 1 THEN
      SELECT S.VENDOR_ID
        INTO MERID
        FROM SPM_CON_VENDOR_INFO S
       WHERE S.VENDOR_NAME = B;
    ELSE
      SELECT S.CUST_ID
        INTO MERID
        FROM SPM_CON_CUST_INFO S
       WHERE S.CUST_NAME = B;
    END IF;
    INSERT INTO SPM_CON_HT_MERCHANTS
      (CON_MERCHANTS_ID,
       MERCHANTS_ID,
       MERCHANTS_FLAG,
       IN_OUT_TYPE,
       CONTRACT_ID,
       ORG_ID,
       CREATED_BY,
       CREATION_DATE)
    VALUES
      (SPM_CON_HT_MERCHANTS_SEQ.NEXTVAL,
       MERID,
       DECODE(ORDERTYPE, 0, 1, 1, 2),
       DECODE(ORDERTYPE, 0, 1, 1, 2),
       CONID,
       SPM_SSO_PKG.GETORGID,
       FND_GLOBAL.USER_ID,
       TO_DATE(J, 'YYYY-MM-DD HH24:MI:SS'));
    --Step.P���빩Ӧ�̿ͻ���Ϣ(��)
    SELECT S.PROJECT_ID
      INTO MERID
      FROM SPM_CON_PROJECT S
     WHERE S.ORG_ID = SPM_SSO_PKG.GETORGID
       AND S.PROJECT_NAME LIKE '�޹���%';
    INSERT INTO SPM_CON_HT_PROJECT
      (CON_PRO_RELATION_ID, PROJECT_ID, CONTRACT_ID)
    VALUES
      (SPM_CON_HT_PROJECT_SEQ.NEXTVAL, MERID, CONID);
  
    --Step3.�����ջ�����Ϣ
    SELECT S.B
      INTO A
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ջ���';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ջ���λ';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ջ��˵绰';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '�ջ��˵�ַ';
  
    SELECT SPM_CON_HT_RECEIVER_SEQ.NEXTVAL INTO CHILDID FROM DUAL;
    INSERT INTO SPM_CON_HT_RECEIVER
      (RECEIVER_ID,
       CONTRACT_ID,
       RECEIVE_USER,
       RECEIVE_ORG,
       RECEIVE_TEL,
       RECEIVE_ADDRESS,
       ORG_ID,
       DEPT_ID,
       CREATED_BY,
       CREATION_DATE)
    VALUES
      (CHILDID,
       CONID,
       A,
       B,
       C,
       D,
       SPM_SSO_PKG.GETORGID,
       DEPTID,
       FND_GLOBAL.USER_ID,
       SYSDATE);
  
    --Step4.���뿪Ʊ��Ϣ
    SELECT S.B
      INTO A
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ����';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ�˺�';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ˰��';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ�绰';
    SELECT S.B
      INTO E
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ��ϵ��';
    SELECT S.B
      INTO F
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ����';
    SELECT S.B
      INTO G
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ��ַ';
    SELECT S.B
      INTO H
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '��Ʊ��ע';
  
    SELECT SPM_CON_HT_INVOICE_SEQ.NEXTVAL INTO CHILDID FROM DUAL;
    INSERT INTO SPM_CON_HT_INVOICE
      (INVOICE_ID,
       CONTRACT_ID,
       INVOICE_BANK,
       INVOICE_ACCOUNT,
       INVOICE_RATE_NUMBER,
       INVOICE_TEL,
       INVOICE_USER,
       INVOICE_TYPE,
       INVOICE_ADDRESS,
       REMARK,
       ORG_ID,
       DEPT_ID,
       CREATED_BY,
       CREATION_DATE)
    VALUES
      (CHILDID,
       CONID,
       A,
       B,
       C,
       D,
       E,
       SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_CON_HT_INVOICE_TYPE', F),
       G,
       H,
       SPM_SSO_PKG.GETORGID,
       DEPTID,
       FND_GLOBAL.USER_ID,
       SYSDATE);
  
    --Step5.����ɹ�������Ϣ
    SELECT * BULK COLLECT
      INTO ST
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND SPM_CON_UTIL_PKG.IS_NUMBER(S.A, 'I') = 1
     ORDER BY S.TEMP_D_ID;
  
    FOR I IN 1 .. ST.COUNT LOOP
      SELECT SPM_CON_HT_TARGET_SEQ.NEXTVAL INTO CHILDID FROM DUAL;
      INSERT INTO SPM_CON_HT_TARGET
        (TARGET_ID,
         CONTRACT_ID,
         MATERIAL_CODE,
         MATERIAL_NAME,
         TARGET_UNIT,
         TARGET_COUNT,
         UNIT_PRICE,
         TARGET_AMOUNT,
         TAX_RATE,
         TAX_AMOUNT,
         NOTAX_AMOUNT,
         IS_DELETE,
         REMARK,
         GOODS_CLASS,
         SPECIFICATION_MODEL,
         SPECIFICATION_PACKING,
         TARGET_PARAMS,
         ORG_ID,
         CREATED_BY,
         CREATION_DATE)
      VALUES
        (CHILDID,
         CONID,
         ST(I).D,
         ST(I).E,
         ST(I).L,
         TO_NUMBER(ST(I).M),
         TO_NUMBER(ST(I).N),
         TO_NUMBER(ST(I).O),
         TAXRATE,
         (ST(I).O - ST(I).O / (1 + TAXRATE / 100)),
         (ST(I).O / (1 + TAXRATE / 100)),
         0,
         ST(I).P,
         ST(I).B,
         ST(I).G,
         ST(I).H,
         ST(I).F,
         SPM_SSO_PKG.GETORGID,
         FND_GLOBAL.USER_ID,
         SYSDATE);
    END LOOP;
  
    --Step6.���òɹ�/���۶����Ĺ�����ϵ
    IF ISREALORDEREXIST = 0 THEN
      /**
      * �������Ĺ�������������ʱ,������������,ֻ����ID�ͱ��
      * �������Ķ�������ʱ,��Ҫ����UPDATE����,������INSERT
      * ���ɹ�������ʱ,���������/�ɹ�����,��ô�������ǲɹ�/���۶���
      */
      SELECT SPM_CON_HT_INFO_SEQ.NEXTVAL INTO ORDERID FROM DUAL;
      INSERT INTO SPM_CON_HT_INFO
        (CONTRACT_ID,
         CONTRACT_CODE,
         CONTRACT_TYPE,
         IN_OUT_TYPE,
         ORDER_TYPE,
         STATUS)
      VALUES
        (ORDERID,
         RELACODE,
         2,
         DECODE(ORDERTYPE, 0, 2, 1, 1),
         DECODE(ORDERTYPE, 0, 1, 1, 2),
         'E');
    ELSE
      SELECT CONTRACT_ID
        INTO ORDERID
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = RELACODE;
    END IF;
  
    --����/�ɹ�������ϵID
    SELECT SPM_CON_HT_RELATION_SEQ.NEXTVAL INTO CHILDID FROM DUAL;
  
    --�������������ϵ
    INSERT INTO SPM_CON_HT_RELATION
      (RELATION_ID,
       CONTRACT_ID,
       CONTRACT_ID_R,
       RELATION_SHIP,
       RELATION_BUSINESS,
       ORG_ID,
       DEPT_ID,
       CREATED_BY,
       CREATION_DATE)
    VALUES
      (CHILDID,
       CONID,
       ORDERID,
       2,
       SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_CON_HT_RELATION_BUSINESS',
                                               '�����ɶ�'),
       SPM_SSO_PKG.GETORGID,
       DEPTID,
       FND_GLOBAL.USER_ID,
       SYSDATE);
  
  END ORDER_CONTRACT_IMPORT;

  --�ж϶�����ͬ�Ƿ��ѹ������Э��
  FUNCTION ORDER_CONTRACT_KJXY(CONID NUMBER) RETURN NUMBER AS
    TYPE HT_RELATION_TYPE IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    R HT_RELATION_TYPE;
  
    KJXYCOU NUMBER := 0;
  BEGIN
  
    --��ȡ��ǰ��ͬ�ѹ�����ID��Ϣ
    SELECT S.CONTRACT_ID_R BULK COLLECT
      INTO R
      FROM SPM_CON_HT_RELATION S
     WHERE S.CONTRACT_ID = CONID;
    FOR I IN 1 .. R.COUNT LOOP
      SELECT COUNT(1)
        INTO KJXYCOU
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_FORM = 4
         AND S.STATUS_CHANGE = 1
         AND S.CONTRACT_ID = R(1);
      IF KJXYCOU > 0 THEN
        KJXYCOU := 1;
        EXIT;
      END IF;
    END LOOP;
    RETURN KJXYCOU;
  END ORDER_CONTRACT_KJXY;

  /*
  * ��ȡ���������Ŀ��Э��ID�ͱ��
  * ���ظ�ʽΪ'ID,CODE'����ȡ��������'-1,-1'
  */
  FUNCTION GET_ORDER_KJXY(CONID NUMBER) RETURN VARCHAR2 AS
    TYPE HT_RELATION_TYPE IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    R       HT_RELATION_TYPE;
    RESTR   VARCHAR2(1000) := '-1,-1';
    KJXYCOU NUMBER := 0;
    VCOU    NUMBER;
  BEGIN
  
    SELECT COUNT(1)
      INTO VCOU
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_TYPE = 2
       AND S.CONTRACT_ID = CONID;
    IF VCOU = 0 THEN
      RETURN RESTR;
    END IF;
    --��ȡ��ǰ��ͬ�ѹ�����ID��Ϣ
    SELECT S.CONTRACT_ID_R BULK COLLECT
      INTO R
      FROM SPM_CON_HT_RELATION S
     WHERE S.CONTRACT_ID = CONID;
    FOR I IN 1 .. R.COUNT LOOP
      BEGIN
        SELECT S.CONTRACT_ID || ',' || S.CONTRACT_CODE
          INTO RESTR
          FROM SPM_CON_HT_INFO S
         WHERE S.CONTRACT_FORM = 4
           AND S.STATUS_CHANGE = 1
           AND S.CONTRACT_ID = R(I);
      EXCEPTION
        WHEN OTHERS THEN
          RESTR := '-1,-1';
      END;
      IF RESTR <> '-1,-1' THEN
        EXIT;
      END IF;
    END LOOP;
    RETURN RESTR;
  END GET_ORDER_KJXY;

  FUNCTION GET_CHANGE_WF_CONTRACT_ID(P_ID NUMBER) RETURN VARCHAR2 AS
    WF_CONTRACT_ID VARCHAR2(100);
    V_COUNT        NUMBER;
    V_FLAG         VARCHAR2(100);
  BEGIN
    SELECT CONTRACT_FLAG
      INTO V_FLAG
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_ID = P_ID;
  
    SELECT COUNT(*)
      INTO V_COUNT
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_FLAG = V_FLAG;
  
    IF (V_COUNT = 1) THEN
      WF_CONTRACT_ID := P_ID;
    ELSIF (V_COUNT > 1) THEN
      SELECT MAX(CONTRACT_ID)
        INTO WF_CONTRACT_ID
        FROM SPM_CON_HT_INFO
       WHERE CONTRACT_FLAG = V_FLAG;
    END IF;
    RETURN WF_CONTRACT_ID;
  END GET_CHANGE_WF_CONTRACT_ID;

  /*
    ���ݺ�ͬID��ȡ���µ�������ˮ��
    BY MCQ
    20180910
    �ع��²��䵱��ͬ����Ϊ������ͬʱ����Ҫ���ݶ������ͣ����ۺͲɹ�����ƴ��
    ������ˮ�Ź��� �ɹ�������ţ���ȡ��ǰʮλ��ȡʣ�ಿ�֣�+ 'CWEME' + ȫ����ˮ�ţ���⡢���⡢��ͬ��ϸ��
    ���۶�����ţ���ȡ��ǰʮλ��ȡʣ�ಿ�֣�+ '-1CWEME' + ȫ����ˮ�ţ���⡢���⡢��ͬ��ϸ��
    20181120 BY MCQ
  */
  FUNCTION GET_TARGET_CODE(P_ID NUMBER) RETURN VARCHAR2 IS
    IS_EXISTS     NUMBER;
    P_CON_CODE    VARCHAR2(100);
    P_SERIAL_CODE VARCHAR2(10) DEFAULT '0001';
    P_TARGET_CODE VARCHAR2(100);
    P_MAX_NUM     NUMBER;
    P_MAX_CODE    VARCHAR2(100);
    P_FORMAT_CODE VARCHAR2(10) DEFAULT '0000';
  BEGIN
    --���䶩����ͬ���
  
    SELECT CASE H.CONTRACT_TYPE
             WHEN 1 THEN
              SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE))
             ELSE
              DECODE(ORDER_TYPE,
                     '1',
                     SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                     '-1CWEME',
                     SUBSTR(CONTRACT_CODE, 10, LENGTH(CONTRACT_CODE)) ||
                     'CWEME')
           END
      INTO P_CON_CODE
      FROM SPM_CON_HT_INFO H
     WHERE H.CONTRACT_ID = P_ID;
    WITH HR AS
     (SELECT H2.CONTRACT_ID
        FROM SPM_CON_HT_INFO H1, SPM_CON_HT_INFO H2
       WHERE H1.CONTRACT_ID = P_ID
         AND H2.CONTRACT_FLAG = H1.CONTRACT_FLAG)
    SELECT COUNT (1)
      INTO IS_EXISTS
      FROM (SELECT HT.MATERIAL_CODE
              FROM SPM_CON_HT_TARGET HT, HR
             WHERE HT.CONTRACT_ID = HR.CONTRACT_ID(+)
               AND HT.CODE_TYPE = '��ˮ��'
               AND HT.MATERIAL_CODE LIKE P_CON_CODE || '%'
            UNION
            SELECT WD.MATERIAL_CODE
              FROM SPM_CON_WAREHOUSE W, SPM_CON_WAREHOUSE_DL WD, HR
             WHERE W.WAREHOUSE_ID = WD.WAREHOUSE_ID
               AND WD.MATERIAL_CODE LIKE P_CON_CODE || '%'
               AND W.CONTRACT_ID = HR.CONTRACT_ID(+)
            UNION
            SELECT OD.MATERIAL_CODE
              FROM SPM_CON_ODO O, SPM_CON_ODO_DL OD, HR
             WHERE O.ODO_ID = OD.ODO_ID
               AND O.CONTRACT_ID = HR.CONTRACT_ID(+)
               AND OD.MATERIAL_CODE LIKE P_CON_CODE || '%');
    --��������ڣ��򴴽��µ���ˮ��   
    --����Ѿ����ڣ�����Ҫ������ˮ���������
    IF IS_EXISTS <> 0 THEN
    
      --ȡ������ˮ��
      WITH HR AS
       (SELECT H2.CONTRACT_ID
          FROM SPM_CON_HT_INFO H1, SPM_CON_HT_INFO H2
         WHERE H1.CONTRACT_ID = P_ID
           AND H2.CONTRACT_FLAG = H1.CONTRACT_FLAG)
      SELECT MAX (TO_NUMBER(SUBSTR(MATERIAL_CODE, LENGTH(P_CON_CODE) + 1)))
        INTO P_MAX_NUM
        FROM (SELECT HT.MATERIAL_CODE
                FROM SPM_CON_HT_TARGET HT, HR
               WHERE 1 = 1
                 AND HT.CONTRACT_ID = HR.CONTRACT_ID(+)
                 AND HT.CODE_TYPE = '��ˮ��'
                 AND HT.MATERIAL_CODE LIKE P_CON_CODE || '%'
              UNION
              SELECT WD.MATERIAL_CODE
                FROM SPM_CON_WAREHOUSE W, SPM_CON_WAREHOUSE_DL WD, HR
               WHERE W.WAREHOUSE_ID = WD.WAREHOUSE_ID
                 AND WD.MATERIAL_CODE LIKE P_CON_CODE || '%'
                 AND W.CONTRACT_ID = HR.CONTRACT_ID(+)
              UNION
              SELECT OD.MATERIAL_CODE
                FROM SPM_CON_ODO O, SPM_CON_ODO_DL OD, HR
               WHERE O.ODO_ID = OD.ODO_ID
                 AND O.CONTRACT_ID = HR.CONTRACT_ID(+)
                 AND OD.MATERIAL_CODE LIKE P_CON_CODE || '%');
      P_MAX_NUM  := P_MAX_NUM + 1;
      P_MAX_CODE := TO_CHAR(P_MAX_NUM);
    
      --�����ˮ��С��100�����ʽ��Ϊ3λ��ˮ,�����ȴ���2���Զ������ַ����Ƚ��б���
      IF LENGTH(P_MAX_CODE) > 2 THEN
      
        FOR I IN 4 .. LENGTH(P_MAX_CODE) LOOP
          P_FORMAT_CODE := P_FORMAT_CODE || '0';
        END LOOP;
      
      END IF;
    
      --��ʽ��������ˮ��
      SELECT TRIM(TO_CHAR(P_MAX_NUM, P_FORMAT_CODE))
        INTO P_SERIAL_CODE
        FROM DUAL;
    
    END IF;
  
    P_TARGET_CODE := P_CON_CODE || P_SERIAL_CODE;
  
    RETURN P_TARGET_CODE;
  END GET_TARGET_CODE;
  
  
  /*
   ��ͬ������ʷ�����ȷ�ĺ�ͬ����  (�ؼ���:��������,�汾��)
   rkk
   20190607
  */
  FUNCTION GET_WF_HISTORY_ID(NOW_HT_ID NUMBER) RETURN NUMBER IS
    HT_FLAG    VARCHAR2(40); --UUID
    HT_VERSION NUMBER; --�汾��
    RE_ID      NUMBER; --�����ص�����
  BEGIN
    SELECT F.CONTRACT_FLAG, TO_NUMBER(F.CONTRACT_VERSION)
      INTO HT_FLAG, HT_VERSION
      FROM SPM_CON_HT_INFO F
     WHERE F.CONTRACT_ID = NOW_HT_ID;
  
    select B.CONTRACT_ID
      INTO RE_ID
      from (select A.CONTRACT_ID, ROWNUM NUM
              from (select F.CONTRACT_ID
                      from SPM_CON_HT_INFO F
                     WHERE F.CONTRACT_FLAG = HT_FLAG
                     ORDER BY F.CONTRACT_ID) A) B
     WHERE B.NUM = HT_VERSION;
  
    RETURN RE_ID;
  END GET_WF_HISTORY_ID;

END SPM_CON_HT_PKG;
/
