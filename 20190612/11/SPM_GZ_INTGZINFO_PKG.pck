CREATE OR REPLACE PACKAGE SPM_GZ_INTGZINFO_PKG IS
  --SPM_GZ_INTGZINFO_PKGΪ����

  --��֤��������Ϣ¼����Ч��  ���ʱ༭ҳ�浼�� �ɳ����޸�
  PROCEDURE WAGE_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);

    --��֤��������Ϣ¼��  ���ʱ༭ҳ�浼�� �ɳ����޸�
  PROCEDURE WAGE_INFO_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);

  --��֤��������Ϣ¼����Ч��  ���ʱ༭ҳ�浼��
  PROCEDURE WAGE_INFO_VALIDATA_OLD(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);

    --��֤��������Ϣ¼��  ���ʱ༭ҳ�浼�� 
  PROCEDURE WAGE_INFO_IMPORT_OLD(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);
                             
  --��֤������֯��Ϣ¼����Ч�� ��֯��Ϣҳ��
  PROCEDURE GZORG_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);

  --��֤������֯��Ϣ¼��  ��֯��Ϣҳ��
  PROCEDURE GZORG_INFO_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);

  --��֤����Ա��¼����Ч��   Ա����Ϣҳ��
  PROCEDURE PERSON_SALARY_VALIDATA(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   P_MSG       OUT VARCHAR2);
  -- ���빤��Ա����Ϣ    Ա����Ϣҳ��
  PROCEDURE PERSON_SALARY_IMPORT(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 F_TABLENAME VARCHAR2,
                                 F_TABLEID   VARCHAR2,
                                 P_MSG       OUT VARCHAR2);

  --��֤������Ŀ¼����Ч��   ������Ŀ��Ϣҳ��
  PROCEDURE WAGETYPEITEMS_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                        P_TABLEID   VARCHAR2,
                                        P_BATCHCODE VARCHAR2,
                                        P_MSG       OUT VARCHAR2);
  -- ���빤����Ŀ��Ϣ     ������Ŀҳ��
  PROCEDURE WAGETYPEITEMS_INFO_IMPORT(P_TABLENAME VARCHAR2,
                                      P_TABLEID   VARCHAR2,
                                      P_BATCHCODE VARCHAR2,
                                      F_TABLENAME VARCHAR2,
                                      F_TABLEID   VARCHAR2,
                                      P_MSG       OUT VARCHAR2);

  FUNCTION GET_WAGETYPE_OBJECT_NAME( /*operationType In NUMBER,*/RELATIONIDS IN VARCHAR2)
    RETURN VARCHAR2;

  /**
  * ����spm_gz_createcert����洢��wagetype_code ��Ϣ��to_wageitems ��ѯ�����Ĺ�����Ŀ����
  * @param operationType 1
  * @param ids to_wageitems ������ĿӢ����Ϣ
  */
  FUNCTION GET_WAGEITEMS_NAME(RELATIONIDS  IN VARCHAR2,
                              WAGETYPECODE IN VARCHAR2) RETURN VARCHAR2;
  --�ַ���ת�ɶ��к���
  FUNCTION SPLIT_STRING_OBJECT(SPLIT_OBJECT   VARCHAR2,
                               SPLIT_OPERATOR VARCHAR2 DEFAULT ',')
    RETURN SPM_TYPE_TBL;

  --����spm_gz_employee����attribute5�洢�Ĵ���id��Ϣ ��ѯ��������������
  FUNCTION GET_EMP_OFFICE_NAME( /*operationType In NUMBER,*/OFFICEID IN VARCHAR2)
    RETURN VARCHAR2;
  --��������������ػص�����

  --���ʹ���htmlչ��
  FUNCTION SPM_GZ_SP_INFO_HTML(P_KEY IN VARCHAR2, POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --���ʹ������̷���
  PROCEDURE SPM_GZ_SP_INFO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER);
  --���ʹ���������׼�ص�����
  PROCEDURE SPM_GZ_SP_INFO_PZ(P_KEY        IN VARCHAR2,
                              P_OTYPE_CODE IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2);

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_GZ_SP_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                P_ITEMKEY    IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2);

  --��ͬ����֪ͨ����(��)�ص�
  PROCEDURE SPM_GZ_SP_INFO_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2);

  --���ʹ������̻�ǩ�ڵ���׼�ص�������֪ͨ�����
  PROCEDURE SPM_GZ_SP_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);
  --���ʹ������̲�����֤�ص�������֪ͨ����ǰ��
  /*PROCEDURE spm_gz_sp_info_TZ_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --���ʹ�������ͨ���ص�
  PROCEDURE SPM_GZ_SP_INFO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --���ʹ����ػص�
  PROCEDURE SPM_GZ_SP_INFO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);
  --��֤���Ԥ����Ϣ¼��
  PROCEDURE PRECONTROL_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);
  --�������Ԥ������                              
  PROCEDURE PRECONTROL_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);
  --��֤�쵼����Ԥ����Ϣ¼��
  PROCEDURE LEADER_VALIDATA(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2);
  --�����쵼����Ԥ������                              
  PROCEDURE LEADER_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2);

  --��֤ר����Ϣ¼����Ч��   ר����ѯ�ѷ�����ϸҳ��
  PROCEDURE EXPERT_FEE_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);
  -- ����ר����Ϣ    ר����ѯ�ѷ�����ϸҳ��
  PROCEDURE EXPERT_FEE_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);

  --�ɷѹ���htmlչ��
  FUNCTION SPM_EXPERT_FEE_INFO_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --�ɷѹ������̷���
  PROCEDURE SPM_EXPERT_FEE_INFO_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER);
  --�ɷѹ���������׼�ص�����
  PROCEDURE SPM_EXPERT_FEE_INFO_PZ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);

  --�ɷѹ�������֪ͨ���ɻص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --�ɷѹ�������֪ͨ����ǰ���ص�
  PROCEDURE SPM_EXPERT_FEE_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --�ɷѹ���֪ͨ����(��)�ص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --�ɷѹ������̻�ǩ�ڵ���׼�ص�������֪ͨ�����
  PROCEDURE SPM_EXPERT_FEE_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);
  --�ɷѹ������̲�����֤�ص�������֪ͨ����ǰ��
  /*PROCEDURE spm_gz_sp_info_TZ_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --�ɷѹ�������ͨ���ص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --�ɷѹ����ػص�
  PROCEDURE SPM_EXPERT_FEE_INFO_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --��֤ר����Ϣ¼����Ч��   ר����Ϣ�б�ҳ��
  PROCEDURE EXPERT_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 P_MSG       OUT VARCHAR2);
  -- ����ר����Ϣ    ר����Ϣ�б�ҳ��
  PROCEDURE EXPERT_INFO_IMPORT(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               F_TABLENAME VARCHAR2,
                               F_TABLEID   VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  --ר����ѯ����ϸ�������ݲ������븶����                                
  PROCEDURE SPM_EXPERT_FEE_MONEY_AMOUNT(ID NUMBER);
  --�ʽ�ƻ���� �Զ�ȡֵ
  PROCEDURE SPM_CAPITAL_GET_VAL(DEPTCODE       VARCHAR2,
                                ORGID          VARCHAR2,
                                CAPITALBALANCE OUT NUMBER,
                                RECEIVEAMOUNT  OUT NUMBER,
                                NONPAYCOST     OUT NUMBER,
                                REPORTPROFIT   OUT NUMBER,
                                TAXAMOUNT      OUT NUMBER);
END SPM_GZ_INTGZINFO_PKG;
/
CREATE OR REPLACE PACKAGE BODY SPM_GZ_INTGZINFO_PKG IS

--��������Ϣ��֤validate-2018-08-24�ɳ����޸�
  PROCEDURE WAGE_INFO_VALIDATA(P_TABLENAME VARCHAR2, --
                               P_TABLEID   VARCHAR2, --
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
             TRIM(Y),
             TRIM(Z),
             TRIM(AA),
             TRIM(AB),
             TRIM(AC),
             TRIM(AD),
             TRIM(AE),
             TRIM(AF),
             TRIM(AG),
             TRIM(AH),
             TRIM(AI)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    VALIDATE_R       VARCHAR2(2000);
    VALIDATE_S       VARCHAR2(2000);
    VALIDATE_T       VARCHAR2(2000);
    VALIDATE_U       VARCHAR2(2000);
    VALIDATE_V       VARCHAR2(2000);
    VALIDATE_W       VARCHAR2(2000);
    VALIDATE_X       VARCHAR2(2000);
    VALIDATE_Y       VARCHAR2(2000);
    VALIDATE_Z       VARCHAR2(2000);
    VALIDATE_AA      VARCHAR2(2000);
    VALIDATE_AB      VARCHAR2(2000);
    VALIDATE_AC      VARCHAR2(2000);
    VALIDATE_AD      VARCHAR2(2000);
    VALIDATE_AE      VARCHAR2(2000);
    VALIDATE_AF      VARCHAR2(2000);
    VALIDATE_AG      VARCHAR2(2000);
    VALIDATE_AH      VARCHAR2(2000);
    VALIDATE_AI      VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER; --
  
    MSG_C            VARCHAR2(4000);
    C_CNT            NUMBER(5);
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
           VALIDATE_AD,
           VALIDATE_AE,
           VALIDATE_AF,
           VALIDATE_AG,
           VALIDATE_AH,
           VALIDATE_AI;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF /*VALIDATE_A <> '����' OR VALIDATE_B <> '��' OR*/
         VALIDATE_C <> 'Ա�����' /*OR VALIDATE_D <> '����' */OR VALIDATE_E NOT IN  ('��������','�꽱','����') OR
         VALIDATE_F NOT IN  ('���乤��','Ӧ������','����') OR VALIDATE_G NOT IN  ('н�㹤��','�����/���ڷ�','��˰����') 
         OR VALIDATE_H NOT IN  ('����','˰��','��ͨ����') OR VALIDATE_I NOT IN ('ҽ�ƻ���','����1','����˰') 
         OR VALIDATE_J NOT IN ('���ⲹ��','ʵ������','����2') OR VALIDATE_K NOT IN ('����','����3') OR
         VALIDATE_L NOT IN ('�в�','����4') OR VALIDATE_M NOT IN ('��ͨ����','Ӧ������') OR VALIDATE_N <> '����' OR
         VALIDATE_O NOT IN ('�����ڼ���ֵ��','�ۻ�������') OR VALIDATE_P NOT IN ('�����','��ʧҵ') OR
          VALIDATE_Q NOT IN ('����','��ҽ�Ʊ���') OR VALIDATE_R NOT IN ('����','��ס��������') OR 
          VALIDATE_S NOT IN ('����1','��˰����') OR VALIDATE_T NOT IN ('����2','˰��') OR
         VALIDATE_U NOT IN ('����3','����˰') OR VALIDATE_V NOT IN ('����4','ʵ������') OR VALIDATE_W <> 'Ӧ������' OR
         VALIDATE_X <> '�ۻ�������' OR VALIDATE_Y <> '��ҽ�Ʊ���' OR VALIDATE_Z <> '�۴��ҽ��' OR
         VALIDATE_AA <> '��ʧҵ' OR VALIDATE_AB <> '��ס��������' OR VALIDATE_AC <> '�����' OR
         VALIDATE_AD <> '������' OR VALIDATE_AE <> '��˰����' OR VALIDATE_AF <> '����۳���' OR
         VALIDATE_AG <> '��˰��' OR VALIDATE_AH <> '��������˰' OR VALIDATE_AI <> 'ʵ������'  THEN
        P_MSG := '�������ݵ����������ϸ�ʽ��';
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
             VALIDATE_Y,
             VALIDATE_Z,
             VALIDATE_AA,
             VALIDATE_AB,
             VALIDATE_AC,
             VALIDATE_AD,
             VALIDATE_AE,
             VALIDATE_AF,
             VALIDATE_AG,
             VALIDATE_AH,
             VALIDATE_AI;
      WHILE CU_DATA%FOUND LOOP
        IF VALIDATE_C IS NULL THEN
          IF MSG_C IS NULL THEN
            MSG_C := CU_DATA%ROWCOUNT;
          ELSE
            MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
          END IF;
        ELSE
             --Ա����Ų�Ϊ�� ��ѯԱ�Ƿ����
           SELECT COUNT(*) INTO  C_CNT FROM SPM_GZ_EMPLOYEE WHERE CARD_ID=VALIDATE_C;
           IF C_CNT=0 THEN
              IF MSG_C IS NULL THEN
                MSG_C := CU_DATA%ROWCOUNT;
              ELSE
                MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
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
               VALIDATE_U,
               VALIDATE_V,
               VALIDATE_W,
               VALIDATE_X,
               VALIDATE_Y,
               VALIDATE_Z,
               VALIDATE_AA,
               VALIDATE_AB,
               VALIDATE_AC,
               VALIDATE_AD,
               VALIDATE_AE,
               VALIDATE_AF,
               VALIDATE_AG,
               VALIDATE_AH,
               VALIDATE_AI;
      END LOOP;
      CLOSE CU_DATA;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '�� Ա����Ų���Ϊ�ջ�Ա����SPMϵͳ�в�����;  ';
      END IF;
      P_MSG := P_MSG  || MSG_C;
    
      RETURN;
    END IF;
  END WAGE_INFO_VALIDATA;
  --��������Ϣ��֤validate
  PROCEDURE WAGE_INFO_VALIDATA_OLD(P_TABLENAME VARCHAR2, --
                               P_TABLEID   VARCHAR2, --
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
             TRIM(Y),
             TRIM(Z),
             TRIM(AA),
             TRIM(AB)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    VALIDATE_R       VARCHAR2(2000);
    VALIDATE_S       VARCHAR2(2000);
    VALIDATE_T       VARCHAR2(2000);
    VALIDATE_U       VARCHAR2(2000);
    VALIDATE_V       VARCHAR2(2000);
    VALIDATE_W       VARCHAR2(2000);
    VALIDATE_X       VARCHAR2(2000);
    VALIDATE_Y       VARCHAR2(2000);
    VALIDATE_Z       VARCHAR2(2000);
    VALIDATE_AA      VARCHAR2(2000);
    VALIDATE_AB      VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER; --
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
    MSG_N            VARCHAR2(4000); --
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
           VALIDATE_AB;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> 'Ա�����' OR VALIDATE_B <> 'Ա������' OR
         VALIDATE_C = 'Ӧ������' OR VALIDATE_C = '��˰����' OR VALIDATE_C = '����˰' OR
         VALIDATE_C = 'ʵ������' OR VALIDATE_D = 'Ӧ������' OR VALIDATE_D = '��˰����' OR
         VALIDATE_D = '����˰' OR VALIDATE_D = 'ʵ������' OR VALIDATE_E = 'Ӧ������' OR
         VALIDATE_E = '��˰����' OR VALIDATE_E = '����˰' OR VALIDATE_E = 'ʵ������' OR
         VALIDATE_F = 'Ӧ������' OR VALIDATE_F = '��˰����' OR VALIDATE_F = '����˰' OR
         VALIDATE_F = 'ʵ������' OR VALIDATE_G = 'Ӧ������' OR VALIDATE_G = '��˰����' OR
         VALIDATE_G = '����˰' OR VALIDATE_G = 'ʵ������' OR VALIDATE_H = 'Ӧ������' OR
         VALIDATE_H = '��˰����' OR VALIDATE_H = '����˰' OR VALIDATE_H = 'ʵ������' OR
         VALIDATE_I = 'Ӧ������' OR VALIDATE_I = '��˰����' OR VALIDATE_I = '����˰' OR
         VALIDATE_I = 'ʵ������' OR VALIDATE_J = 'Ӧ������' OR VALIDATE_J = '��˰����' OR
         VALIDATE_J = '����˰' OR VALIDATE_J = 'ʵ������' OR VALIDATE_K = 'Ӧ������' OR
         VALIDATE_K = '��˰����' OR VALIDATE_K = '����˰' OR VALIDATE_K = 'ʵ������' OR
         VALIDATE_L = 'Ӧ������' OR VALIDATE_L = '��˰����' OR VALIDATE_L = '����˰' OR
         VALIDATE_L = 'ʵ������' OR VALIDATE_M = 'Ӧ������' OR VALIDATE_M = '��˰����' OR
         VALIDATE_M = '����˰' OR VALIDATE_M = 'ʵ������' OR VALIDATE_N = 'Ӧ������' OR
         VALIDATE_N = '��˰����' OR VALIDATE_N = '����˰' OR VALIDATE_N = 'ʵ������' OR
         VALIDATE_O = 'Ӧ������' OR VALIDATE_O = '��˰����' OR VALIDATE_O = '����˰' OR
         VALIDATE_O = 'ʵ������' OR VALIDATE_P = 'Ӧ������' OR VALIDATE_P = '��˰����' OR
         VALIDATE_P = '����˰' OR VALIDATE_P = 'ʵ������' OR VALIDATE_Q = 'Ӧ������' OR
         VALIDATE_Q = '��˰����' OR VALIDATE_Q = '����˰' OR VALIDATE_Q = 'ʵ������' OR
         VALIDATE_R = 'Ӧ������' OR VALIDATE_R = '��˰����' OR VALIDATE_R = '����˰' OR
         VALIDATE_R = 'ʵ������' OR VALIDATE_S = 'Ӧ������' OR VALIDATE_S = '��˰����' OR
         VALIDATE_S = '����˰' OR VALIDATE_S = 'ʵ������' OR VALIDATE_T = 'Ӧ������' OR
         VALIDATE_T = '��˰����' OR VALIDATE_T = '����˰' OR VALIDATE_T = 'ʵ������' OR
         VALIDATE_U = 'Ӧ������' OR VALIDATE_U = '��˰����' OR VALIDATE_U = '����˰' OR
         VALIDATE_U = 'ʵ������' OR VALIDATE_V = 'Ӧ������' OR VALIDATE_V = '��˰����' OR
         VALIDATE_V = '����˰' OR VALIDATE_V = 'ʵ������' OR VALIDATE_W = 'Ӧ������' OR
         VALIDATE_W = '��˰����' OR VALIDATE_W = '����˰' OR VALIDATE_W = 'ʵ������' OR
         VALIDATE_X = 'Ӧ������' OR VALIDATE_X = '��˰����' OR VALIDATE_X = '����˰' OR
         VALIDATE_X = 'ʵ������' OR VALIDATE_Y = 'Ӧ������' OR VALIDATE_Y = '��˰����' OR
         VALIDATE_Y = '����˰' OR VALIDATE_Y = 'ʵ������' OR VALIDATE_Z = 'Ӧ������' OR
         VALIDATE_Z = '��˰����' OR VALIDATE_Z = '����˰' OR VALIDATE_Z = 'ʵ������' OR
         VALIDATE_AA = 'Ӧ������' OR VALIDATE_AA = '��˰����' OR
         VALIDATE_AA = '����˰' OR VALIDATE_AA = 'ʵ������' OR
         VALIDATE_AB = 'Ӧ������' OR VALIDATE_AB = '��˰����' OR
         VALIDATE_AB = '����˰' OR VALIDATE_AB = 'ʵ������' THEN
        P_MSG := '�������ݵ����������ϸ�ʽ����ڼ�����';
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
             VALIDATE_Y,
             VALIDATE_Z,
             VALIDATE_AA,
             VALIDATE_AB;
      WHILE CU_DATA%FOUND LOOP
        IF VALIDATE_B IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
       /* IF VALIDATE_E IS NOT NULL THEN
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
        END IF;*/
        /*IF VALIDATE_A IS NOT NULL THEN
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
               VALIDATE_AB;
      END LOOP;
      CLOSE CU_DATA;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '�� Ա����������Ϊ��;  ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M;
    
      RETURN;
    END IF;
  END;
 --�������ݵ��� 2018-08-24�ɳ����޸�
  PROCEDURE WAGE_INFO_IMPORT(P_TABLENAME VARCHAR2, --
                             P_TABLEID   VARCHAR2, ---
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2, ---�ӱ�main_id
                             -- f_wagecode  varchar2,--���ʷ��ŷ�������
                             F_TABLEID VARCHAR2, --
                             P_MSG     OUT VARCHAR2) IS
    --
  
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
             TRIM(AD),
             TRIM(AE),
             TRIM(AF),
             TRIM(AG),
             TRIM(AH),
             TRIM(AI)
             
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A    VARCHAR2(2000);
    VALIDATE_B    VARCHAR2(2000);
    VALIDATE_C    VARCHAR2(2000);
    VALIDATE_D    VARCHAR2(2000);
    VALIDATE_E    VARCHAR2(2000);
    VALIDATE_F    VARCHAR2(2000);
    VALIDATE_G    VARCHAR2(2000);
    VALIDATE_H    VARCHAR2(2000);
    VALIDATE_I    VARCHAR2(2000);
    VALIDATE_J    VARCHAR2(2000);
    VALIDATE_K    VARCHAR2(2000);
    VALIDATE_L    VARCHAR2(2000);
    VALIDATE_M    VARCHAR2(2000);
    VALIDATE_N    VARCHAR2(2000);
    VALIDATE_O    VARCHAR2(2000);
    VALIDATE_P    VARCHAR2(2000);
    VALIDATE_Q    VARCHAR2(2000);
    VALIDATE_R    VARCHAR2(2000);
    VALIDATE_S    VARCHAR2(2000);
    VALIDATE_T    VARCHAR2(2000);
    VALIDATE_U    VARCHAR2(2000);
    VALIDATE_V    VARCHAR2(2000);
    VALIDATE_W    VARCHAR2(2000);
    VALIDATE_X    VARCHAR2(2000);
    VALIDATE_Y    VARCHAR2(2000);
    VALIDATE_Z    VARCHAR2(2000);
    VALIDATE_AA   VARCHAR2(2000);
    VALIDATE_AB   VARCHAR2(2000);
    VALIDATE_AC   VARCHAR2(2000);
    VALIDATE_AD   VARCHAR2(2000);
    VALIDATE_AE   VARCHAR2(2000);
    VALIDATE_AF   VARCHAR2(2000);
    VALIDATE_AG   VARCHAR2(2000);
    VALIDATE_AH   VARCHAR2(2000);
    VALIDATE_AI   VARCHAR2(2000);
    CN_A    VARCHAR2(2000); --���Ĺ�����
    CN_B    VARCHAR2(2000);
    CN_C    VARCHAR2(2000);
    CN_D    VARCHAR2(2000);
    CN_E    VARCHAR2(2000);
    CN_F    VARCHAR2(2000);
    CN_G    VARCHAR2(2000);
    CN_H    VARCHAR2(2000);
    CN_I    VARCHAR2(2000);
    CN_J    VARCHAR2(2000);
    CN_K    VARCHAR2(2000);
    CN_L    VARCHAR2(2000);
    CN_M    VARCHAR2(2000);
    CN_N    VARCHAR2(2000);
    CN_O    VARCHAR2(2000);
    CN_P    VARCHAR2(2000);
    CN_Q    VARCHAR2(2000);
    CN_R    VARCHAR2(2000);
    CN_S    VARCHAR2(2000);
    CN_T    VARCHAR2(2000);
    CN_U    VARCHAR2(2000);
    CN_V    VARCHAR2(2000);
    CN_W    VARCHAR2(2000);
    CN_X    VARCHAR2(2000);
    CN_Y    VARCHAR2(2000);
    CN_Z    VARCHAR2(2000);
    CN_AA   VARCHAR2(2000);
    CN_AB   VARCHAR2(2000);
    CN_AC   VARCHAR2(2000);
    CN_AD   VARCHAR2(2000);
    CN_AE   VARCHAR2(2000);
    CN_AF   VARCHAR2(2000);
    CN_AG   VARCHAR2(2000);
    CN_AH   VARCHAR2(2000);
    CN_AI   VARCHAR2(2000);
    /*EN_A    VARCHAR2(2000);*/
    V_EN     VARCHAR2(200);--Ӣ�Ĺ�����
    V_CN     VARCHAR2(200);--���Ĺ�����
    V_I     VARCHAR(3);--��ͷ��ʶ
    V_VAL   NUMBER(20,2);--������Ŀֵ
  /*  EN_B    VARCHAR2(2000);
    EN_C    VARCHAR2(2000);
    EN_D    VARCHAR2(2000);
    EN_E    VARCHAR2(2000);
    EN_F    VARCHAR2(2000);
    EN_G    VARCHAR2(2000);
    EN_H    VARCHAR2(2000);
    EN_I    VARCHAR2(2000);
    EN_J    VARCHAR2(2000);
    EN_K    VARCHAR2(2000);
    EN_L    VARCHAR2(2000);
    EN_M    VARCHAR2(2000);
    EN_N    VARCHAR2(2000);
    EN_O    VARCHAR2(2000);
    EN_P    VARCHAR2(2000);
    EN_Q    VARCHAR2(2000);
    EN_R    VARCHAR2(2000);
    EN_S    VARCHAR2(2000);
    EN_T    VARCHAR2(2000);
    EN_U    VARCHAR2(2000);
    EN_V    VARCHAR2(2000);
    EN_W    VARCHAR2(2000);
    EN_X    VARCHAR2(2000);
    EN_Y    VARCHAR2(2000);
    EN_Z    VARCHAR2(2000);
    EN_AA   VARCHAR2(2000);
    EN_AB   VARCHAR2(2000);
    EN_AC   VARCHAR2(2000);
    EN_AD   VARCHAR2(2000);
    EN_AE   VARCHAR2(2000);
    EN_AF   VARCHAR2(2000);
    EN_AG   VARCHAR2(2000);
    EN_AH   VARCHAR2(2000);
    EN_AI   VARCHAR2(2000);*/
    V_SQL   VARCHAR(200);  --ƴ�Ӹ������sql
    
    V_EXEC_SQL   VARCHAR(10000); --ִ�и���sql;
    CARDID        VARCHAR2(50);
    WAGETYPECODE  VARCHAR2(50);
    V_INFO_ID     NUMBER; --
    V_ORG_ID      NUMBER; --
    V_ORGCODE     VARCHAR2(40); --
    V_DEPT_ID     NUMBER; --
    V_DEPTCODE    VARCHAR2(40); --
  BEGIN
   BEGIN
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
           TRIM(AD),
           TRIM(AE),
           TRIM(AF),
           TRIM(AG),
           TRIM(AH),
           TRIM(AI)
      INTO       CN_A,
                CN_B,
                CN_C,
                CN_D,
                CN_E,
                CN_F,
                CN_G,
                CN_H,
                CN_I,
                CN_J,
                CN_K,
                CN_L,
                CN_M,
                CN_N,
                CN_O,
                CN_P,
                CN_Q,
                CN_R,
                CN_S,
                CN_T,
                CN_U,
                CN_V,
                CN_W,
                CN_X,
                CN_Y,
                CN_Z,
                CN_AA,
                CN_AB,
                CN_AC,
                CN_AD,
                CN_AE,
                CN_AF,
                CN_AG,
                CN_AH,
                CN_AI   
      FROM SPM_IMPORT_TEMP_D
     WHERE TEMP_M_ID = P_BATCHCODE
       AND TO_NUMBER(ROW_NUMBER) = 1;
  
    SELECT DISTINCT W.WAGETYPE_CODE
      INTO WAGETYPECODE
      FROM SPM_GZ_WAGEDATA W
     WHERE W.MAIN_ID = F_TABLENAME;
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
           VALIDATE_AD,
           VALIDATE_AE,
           VALIDATE_AF, 
           VALIDATE_AG,
           VALIDATE_AH,
           VALIDATE_AI;
    WHILE CU_DATA%FOUND LOOP
    
    V_EXEC_SQL:='UPDATE SPM_GZ_WAGEDATA WA SET ';
    --ѭ���� E~Z
    FOR I IN  101..122 LOOP
      V_I:=UPPER(CHR(I));
      --��֪����ô�㶯̬����
      --������Ŀ����
      SELECT '''' || DECODE(V_I,'E',CN_E,'F',CN_F,'G',CN_G,'H',CN_H,'I',CN_I,'J',CN_J,'K',CN_K,'L',CN_L,'M',CN_M,'N',CN_N,'O',CN_O,'P',
      CN_P,'Q',CN_Q,'R',CN_R,'S',CN_S,'T',CN_T,'U',CN_U,'V',CN_V,'W',CN_W,'X',CN_X,'Y',CN_Y,'Z',CN_Z) ||'''' INTO V_CN FROM DUAL;
      --��Ԫ��ֵ
       SELECT DECODE(V_I,'E',VALIDATE_E,'F',VALIDATE_F,'G',VALIDATE_G,'H',VALIDATE_H,'I',VALIDATE_I,'J',VALIDATE_J,'K',VALIDATE_K,'L',VALIDATE_L,'M',VALIDATE_M,'N',VALIDATE_N,'O',VALIDATE_O,'P',
       VALIDATE_P,'Q',VALIDATE_Q,'R',VALIDATE_R,'S',VALIDATE_S,'T',VALIDATE_T,'U',VALIDATE_U,'V',VALIDATE_V,'W',VALIDATE_W,'X',VALIDATE_X,'Y',VALIDATE_Y,'Z',VALIDATE_Z) INTO V_VAL FROM DUAL;
       
      
      V_SQL:='SELECT  WT.WAGEITEM_ENAME  FROM SPM_GZ_WAGETYPEITEMS WT WHERE WT.WAGETYPE_CODE=''' || WAGETYPECODE || ''' AND WT.WAGEITEM_CNAME=' || V_CN;
     
      EXECUTE IMMEDIATE V_SQL INTO V_EN;
      V_EXEC_SQL:=V_EXEC_SQL || V_EN ||'='|| '' || NVL(V_VAL,0) ||',';
    END LOOP;
    DBMS_OUTPUT.put_line('V_EXEC_SQL:'||V_EXEC_SQL);
    --ѭ���� A~I
    FOR I IN  97..105 LOOP
      V_I:='A'||UPPER(CHR(I));
      --������Ŀ����
       SELECT '''' || DECODE(V_I,'AA',CN_AA,'AB',CN_AB,'AC',CN_AC,'AD',CN_AD,'AE',CN_AE,'AF',CN_AF,'AG',CN_AG,'AH',CN_AH,'AI',CN_AI) || '''' INTO V_CN FROM DUAL;
      
        --��Ԫ��ֵ
     SELECT DECODE(V_I,'AA',VALIDATE_AA,'AB',VALIDATE_AB,'AC',VALIDATE_AC,'AD',VALIDATE_AD,'AE',VALIDATE_AE,'AF',VALIDATE_AF,'AG',VALIDATE_AG,'AH',VALIDATE_AH,'AI',VALIDATE_AI) INTO V_VAL FROM DUAL;
      
      V_SQL:='SELECT  WT.WAGEITEM_ENAME  FROM SPM_GZ_WAGETYPEITEMS WT WHERE WT.WAGETYPE_CODE=''' || WAGETYPECODE || ''' AND WT.WAGEITEM_CNAME=' || V_CN;
      EXECUTE IMMEDIATE V_SQL INTO V_EN;
      V_EXEC_SQL:=V_EXEC_SQL || V_EN ||'='|| '' || NVL(V_VAL,0) ||',';
    END LOOP;
   
    --ȥ�����һ����,�š� 
    V_EXEC_SQL:=SUBSTR(V_EXEC_SQL,1,LENGTH(V_EXEC_SQL)-1);
    V_EXEC_SQL:=V_EXEC_SQL|| ' WHERE  WA.MAIN_ID =' ||  F_TABLENAME || ' AND WA.CARDID=' || VALIDATE_C;
    DBMS_OUTPUT.put_line('V_EXEC_SQL:'||V_EXEC_SQL);
    EXECUTE IMMEDIATE V_EXEC_SQL; 
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
             VALIDATE_AD,
             VALIDATE_AE,
             VALIDATE_AF,
             VALIDATE_AG,
             VALIDATE_AH,
             VALIDATE_AI;
             
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
    -- P_MSG:='���빤�����ݳɹ���';
   EXCEPTION WHEN OTHERS THEN
     P_MSG:='���빤�����ݳ���ԭ��'||SQLERRM;
   END;
  END;
  --�������ݵ���
  PROCEDURE WAGE_INFO_IMPORT_OLD(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 F_TABLENAME VARCHAR2, ---main_id
                                 F_TABLEID   VARCHAR2,
                                 P_MSG       OUT VARCHAR2) IS
  
    hasQuery number;
    --
  
    CURSOR CU_DATA IS
      SELECT TRIM(A),
             TRIM(B),
             NVL(TRIM(C),0),
             NVL(TRIM(D),0),
             NVL(TRIM(E),0),
             NVL(TRIM(F),0),
             NVL(TRIM(G),0),
             NVL(TRIM(H),0),
             NVL(TRIM(I),0),
             NVL(TRIM(J),0),
             NVL(TRIM(K),0),
             NVL(TRIM(L),0),
             NVL(TRIM(M),0),
             NVL(TRIM(N),0),
             NVL(TRIM(O),0),
             NVL(TRIM(P),0),
             NVL(TRIM(Q),0),
             NVL(TRIM(R),0),
             NVL(TRIM(S),0),
             NVL(TRIM(T),0),
             NVL(TRIM(U),0),
             NVL(TRIM(V),0),
             NVL(TRIM(W),0),
             NVL(TRIM(X),0),
             NVL(TRIM(Y),0),
             NVL(TRIM(Z),0),
             NVL(TRIM(AA),0),
             NVL(TRIM(AB),0)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A    VARCHAR2(2000);
    VALIDATE_B    VARCHAR2(2000);
    VALIDATE_C    VARCHAR2(2000);
    VALIDATE_D    VARCHAR2(2000);
    VALIDATE_E    VARCHAR2(2000);
    VALIDATE_F    VARCHAR2(2000);
    VALIDATE_G    VARCHAR2(2000);
    VALIDATE_H    VARCHAR2(2000);
    VALIDATE_I    VARCHAR2(2000);
    VALIDATE_J    VARCHAR2(2000);
    VALIDATE_K    VARCHAR2(2000);
    VALIDATE_L    VARCHAR2(2000);
    VALIDATE_M    VARCHAR2(2000);
    VALIDATE_N    VARCHAR2(2000);
    VALIDATE_O    VARCHAR2(2000);
    VALIDATE_P    VARCHAR2(2000);
    VALIDATE_Q    VARCHAR2(2000);
    VALIDATE_R    VARCHAR2(2000);
    VALIDATE_S    VARCHAR2(2000);
    VALIDATE_T    VARCHAR2(2000);
    VALIDATE_U    VARCHAR2(2000);
    VALIDATE_V    VARCHAR2(2000);
    VALIDATE_W    VARCHAR2(2000);
    VALIDATE_X    VARCHAR2(2000);
    VALIDATE_Y    VARCHAR2(2000);
    VALIDATE_Z    VARCHAR2(2000);
    VALIDATE_AA   VARCHAR2(2000);
    VALIDATE_AB   VARCHAR2(2000);
    EXCELCOL03    VARCHAR2(2000); --���Ĺ�����
    EXCELCOL04    VARCHAR2(2000);
    EXCELCOL05    VARCHAR2(2000);
    EXCELCOL06    VARCHAR2(2000);
    EXCELCOL07    VARCHAR2(2000);
    EXCELCOL08    VARCHAR2(2000);
    EXCELCOL09    VARCHAR2(2000);
    EXCELCOL10    VARCHAR2(2000);
    EXCELCOL11    VARCHAR2(2000);
    EXCELCOL12    VARCHAR2(2000);
    EXCELCOL13    VARCHAR2(2000);
    EXCELCOL14    VARCHAR2(2000);
    EXCELCOL15    VARCHAR2(2000);
    EXCELCOL16    VARCHAR2(2000);
    EXCELCOL17    VARCHAR2(2000);
    EXCELCOL18    VARCHAR2(2000);
    EXCELCOL19    VARCHAR2(2000);
    EXCELCOL20    VARCHAR2(2000);
    EXCELCOL21    VARCHAR2(2000);
    EXCELCOL22    VARCHAR2(2000);
    EXCELCOL23    VARCHAR2(2000);
    EXCELCOL24    VARCHAR2(2000);
    EXCELCOL25    VARCHAR2(2000);
    EXCELCOL26    VARCHAR2(2000);
    EXCELCOL27    VARCHAR2(2000);
    EXCELCOL28    VARCHAR2(2000);
    COL03WAGEITEM VARCHAR2(200); --Ӣ�Ĺ�����
    COL04WAGEITEM VARCHAR2(200);
    COL05WAGEITEM VARCHAR2(200);
    COL06WAGEITEM VARCHAR2(200);
    COL07WAGEITEM VARCHAR2(200);
    COL08WAGEITEM VARCHAR2(200);
    COL09WAGEITEM VARCHAR2(200);
    COL10WAGEITEM VARCHAR2(200);
    COL11WAGEITEM VARCHAR2(200);
    COL12WAGEITEM VARCHAR2(200);
    COL13WAGEITEM VARCHAR2(200);
    COL14WAGEITEM VARCHAR2(200);
    COL15WAGEITEM VARCHAR2(200);
    COL16WAGEITEM VARCHAR2(200);
    COL17WAGEITEM VARCHAR2(200);
    COL18WAGEITEM VARCHAR2(200);
    COL19WAGEITEM VARCHAR2(200);
    COL20WAGEITEM VARCHAR2(200);
    COL21WAGEITEM VARCHAR2(200);
    COL22WAGEITEM VARCHAR2(200);
    COL23WAGEITEM VARCHAR2(200);
    COL24WAGEITEM VARCHAR2(200);
    COL25WAGEITEM VARCHAR2(200);
    COL26WAGEITEM VARCHAR2(200);
    COL27WAGEITEM VARCHAR2(200);
    COL28WAGEITEM VARCHAR2(200);
    VSQL03        VARCHAR2(2000);
    VSQL04        VARCHAR2(2000);
    VSQL05        VARCHAR2(2000);
    VSQL06        VARCHAR2(2000);
    VSQL07        VARCHAR2(2000);
    VSQL08        VARCHAR2(2000);
    VSQL09        VARCHAR2(2000);
    VSQL10        VARCHAR2(2000);
    VSQL11        VARCHAR2(2000);
    VSQL12        VARCHAR2(2000);
    VSQL13        VARCHAR2(2000);
    VSQL14        VARCHAR2(2000);
    VSQL15        VARCHAR2(2000);
    VSQL16        VARCHAR2(2000);
    VSQL17        VARCHAR2(2000);
    VSQL18        VARCHAR2(2000);
    VSQL19        VARCHAR2(2000);
    VSQL20        VARCHAR2(2000);
    VSQL21        VARCHAR2(2000);
    VSQL22        VARCHAR2(2000);
    VSQL23        VARCHAR2(2000);
    VSQL24        VARCHAR2(2000);
    VSQL25        VARCHAR2(2000);
    VSQL26        VARCHAR2(2000);
    VSQL27        VARCHAR2(2000);
    VSQL28        VARCHAR2(2000);
    PERSONNAME    VARCHAR2(2000);
    CARDID        VARCHAR2(50);
    WAGETYPECODE  VARCHAR2(50);
    V_INFO_ID     NUMBER; --
    V_ORG_ID      NUMBER; --
    V_ORGCODE     VARCHAR2(40); --
    V_DEPT_ID     NUMBER; --
    V_DEPTCODE    VARCHAR2(40); --
  
    number3  number;
    number4  number;
    number5  number;
    number6  number;
    number7  number;
    number8  number;
    number9  number;
    number10 number;
    number11 number;
    number12 number;
    number13 number;
    number14 number;
    number15 number;
    number16 number;
    number17 number;
    number18 number;
    number19 number;
    number20 number;
    number21 number;
    number22 number;
    number23 number;
    number24 number;
    number25 number;
    number26 number;
    number27 number;
    number28 number;
  
  BEGIN
  
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
           TRIM(AB)
      INTO CARDID,
           PERSONNAME,
           EXCELCOL03,
           EXCELCOL04,
           EXCELCOL05,
           EXCELCOL06,
           EXCELCOL07,
           EXCELCOL08,
           EXCELCOL09,
           EXCELCOL10,
           EXCELCOL11,
           EXCELCOL12,
           EXCELCOL13,
           EXCELCOL14,
           EXCELCOL15,
           EXCELCOL16,
           EXCELCOL17,
           EXCELCOL18,
           EXCELCOL19,
           EXCELCOL20,
           EXCELCOL21,
           EXCELCOL22,
           EXCELCOL23,
           EXCELCOL24,
           EXCELCOL25,
           EXCELCOL26,
           EXCELCOL27,
           EXCELCOL28
      FROM SPM_IMPORT_TEMP_D
     WHERE TEMP_M_ID = P_BATCHCODE
       AND TO_NUMBER(ROW_NUMBER) = 1;
  
    --����main_id ��ѯ���ʷ��������
    select t.wagetype_code
      INTO WAGETYPECODE
      from spm_gz_wagedata_main t
     where t.id = to_number(F_TABLENAME);
  
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
           VALIDATE_AB;
  
    WHILE CU_DATA%FOUND LOOP
      --��д,�жϹ��ʷ������е���Ŀֻ��ѯһ��,���������е�ѭ����ȥ��ѯ
    
      --1.�����־Ϊ�ս��в�ѯ
      if hasQuery is null then
      
        hasQuery := 1;
      
        SELECT count(*)
          into number3
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL03
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number3 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL03WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL03
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL03WAGEITEM || ' = ' ||
                 VALIDATE_C || '  where wa.personname = ''' || VALIDATE_B ||
                 '''  and wa.main_id =' || F_TABLENAME || ' '
            INTO VSQL03
            FROM DUAL;
        
          EXECUTE IMMEDIATE VSQL03;
        
        end if;
      
        SELECT count(*)
          into number4
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL04
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number4 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL04WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL04
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL04WAGEITEM || ' = ' ||
                 VALIDATE_D || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL04
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL04;
        
        end if;
      
        SELECT count(*)
          into number5
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL05
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number5 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL05WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL05
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL05WAGEITEM || ' = ' ||
                 VALIDATE_E || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL05
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL05;
        
        end if;
      
        SELECT count(*)
          into number6
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL06
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number6 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL06WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL06
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL06WAGEITEM || ' = ' ||
                 VALIDATE_F || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL06
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL06;
        
        end if;
      
        --------------
        SELECT count(*)
          into number7
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL07
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number7 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL07WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL07
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL07WAGEITEM || ' = ' ||
                 VALIDATE_G || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL07
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL07;
        
        end if;
      
        SELECT count(*)
          into number8
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL08
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number8 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL08WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL08
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL08WAGEITEM || ' = ' ||
                 VALIDATE_H || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL08
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL08;
        
        end if;
      
        SELECT count(*)
          into number9
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL09
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number9 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL09WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL09
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL09WAGEITEM || ' = ' ||
                 VALIDATE_I || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL09
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL09;
        
        end if;
      
        SELECT count(*)
          into number10
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL10
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number10 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL10WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL10
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL10WAGEITEM || ' = ' ||
                 VALIDATE_J || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL10
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL10;
        
        end if;
      
        SELECT count(*)
          into number11
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL11
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number11 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL11WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL11
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL11WAGEITEM || ' = ' ||
                 VALIDATE_K || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL11
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL11;
        
        end if;
      
        SELECT count(*)
          into number12
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL12
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number12 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL12WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL12
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL12WAGEITEM || ' = ' ||
                 VALIDATE_L || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL12
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL12;
        
        end if;
        --*************-
        SELECT count(*)
          into number13
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL13
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number13 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL13WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL13
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL13WAGEITEM || ' = ' ||
                 VALIDATE_M || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL13
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL13;
        
        end if;
      
        SELECT count(*)
          into number14
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL14
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number14 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL14WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL14
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL14WAGEITEM || ' = ' ||
                 VALIDATE_N || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL14
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL14;
        
        end if;
      
        SELECT count(*)
          into number15
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL15
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number15 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL15WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL15
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL15WAGEITEM || ' = ' ||
                 VALIDATE_O || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL15
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL15;
        
        end if;
      
        SELECT count(*)
          into number16
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL16
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number16 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL16WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL16
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL16WAGEITEM || ' = ' ||
                 VALIDATE_P || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL16
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL16;
        
        end if;
      
        --------------
        SELECT count(*)
          into number17
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL17
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number17 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL17WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL17
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL17WAGEITEM || ' = ' ||
                 VALIDATE_Q || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL17
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL17;
        
        end if;
      
        SELECT count(*)
          into number18
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL18
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number18 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL18WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL18
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL18WAGEITEM || ' = ' ||
                 VALIDATE_R || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL18
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL18;
        
        end if;
      
        SELECT count(*)
          into number19
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL19
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number19 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL19WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL19
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL19WAGEITEM || ' = ' ||
                 VALIDATE_S || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL19
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL19;
        
        end if;
      
        SELECT count(*)
          into number20
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL20
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number20 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL20WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL20
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL20WAGEITEM || ' = ' ||
                 VALIDATE_T || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL20
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL20;
        
        end if;
      
        SELECT count(*)
          into number21
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL21
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number21 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL21WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL21
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL21WAGEITEM || ' = ' ||
                 VALIDATE_U || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL21
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL21;
        
        end if;
      
        SELECT count(*)
          into number22
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL22
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number22 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL22WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL22
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL22WAGEITEM || ' = ' ||
                 VALIDATE_V || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL22
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL22;
        
        end if;
        ---+++++++++++----
        SELECT count(*)
          into number23
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL23
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number23 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL23WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL23
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL23WAGEITEM || ' = ' ||
                 VALIDATE_W || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL23
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL23;
        
        end if;
      
        SELECT count(*)
          into number24
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL24
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number24 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL24WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL24
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL24WAGEITEM || ' = ' ||
                 VALIDATE_X || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL24
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL24;
        
        end if;
      
        SELECT count(*)
          into number25
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL25
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number25 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL25WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL25
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL25WAGEITEM || ' = ' ||
                 VALIDATE_Y || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL25
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL25;
        
        end if;
      
        SELECT count(*)
          into number26
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL26
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number26 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL26WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL26
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL26WAGEITEM || ' = ' ||
                 VALIDATE_Z || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL26
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL26;
        
        end if;
      
        SELECT count(*)
          into number27
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL27
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number27 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL27WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL27
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL27WAGEITEM || ' = ' ||
                 VALIDATE_AA || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL27
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL27;
        
        end if;
      
        SELECT count(*)
          into number28
          FROM SPM_GZ_WAGETYPEITEMS WT
         WHERE WT.WAGEITEM_CNAME = EXCELCOL28
           AND WT.WAGETYPE_CODE = WAGETYPECODE;
      
        if number28 > 0 then
        
          SELECT WT.WAGEITEM_ENAME
            INTO COL28WAGEITEM
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGEITEM_CNAME = EXCELCOL28
             AND WT.WAGETYPE_CODE = WAGETYPECODE;
        
          SELECT 'update spm_gz_wagedata wa set ' || COL28WAGEITEM || ' = ' ||
                 VALIDATE_AB || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL28
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL28;
        
        end if;
      
      else
      
        if COL03WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL03WAGEITEM || ' = ' ||
                 VALIDATE_C || '  where wa.personname = ''' || VALIDATE_B ||
                 '''  and wa.main_id =' || F_TABLENAME || ' '
            INTO VSQL03
            FROM DUAL;
        
          EXECUTE IMMEDIATE VSQL03;
        
        end if;
      
        if COL04WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL04WAGEITEM || ' = ' ||
                 VALIDATE_D || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL04
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL04;
        
        end if;
      
        if COL05WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL05WAGEITEM || ' = ' ||
                 VALIDATE_E || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL05
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL05;
        
        end if;
      
        if COL06WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL06WAGEITEM || ' = ' ||
                 VALIDATE_F || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL06
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL06;
        
        end if;
      
        if COL07WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL07WAGEITEM || ' = ' ||
                 VALIDATE_G || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL07
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL07;
        
        end if;
      
        if COL08WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL08WAGEITEM || ' = ' ||
                 VALIDATE_H || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL08
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL08;
        
        end if;
      
        if COL09WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL09WAGEITEM || ' = ' ||
                 VALIDATE_I || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL09
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL09;
        
        end if;
      
        if COL10WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL10WAGEITEM || ' = ' ||
                 VALIDATE_J || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL10
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL10;
        
        end if;
      
        if COL11WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL11WAGEITEM || ' = ' ||
                 VALIDATE_K || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL11
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL11;
        
        end if;
      
        if COL12WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL12WAGEITEM || ' = ' ||
                 VALIDATE_L || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL12
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL12;
        
        end if;
      
        if COL13WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL13WAGEITEM || ' = ' ||
                 VALIDATE_M || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL13
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL13;
        
        end if;
      
        if COL14WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL14WAGEITEM || ' = ' ||
                 VALIDATE_N || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL14
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL14;
        
        end if;
      
        if COL15WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL15WAGEITEM || ' = ' ||
                 VALIDATE_O || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL15
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL15;
        
        end if;
      
        if COL16WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL16WAGEITEM || ' = ' ||
                 VALIDATE_P || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL16
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL16;
        
        end if;
      
        if COL17WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL17WAGEITEM || ' = ' ||
                 VALIDATE_Q || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL17
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL17;
        
        end if;
      
        if COL18WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL18WAGEITEM || ' = ' ||
                 VALIDATE_R || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL18
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL18;
        
        end if;
      
        if COL19WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL19WAGEITEM || ' = ' ||
                 VALIDATE_S || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL19
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL19;
        
        end if;
      
        if COL20WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL20WAGEITEM || ' = ' ||
                 VALIDATE_T || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL20
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL20;
        
        end if;
      
        if COL21WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL21WAGEITEM || ' = ' ||
                 VALIDATE_U || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL21
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL21;
        
        end if;
      
        if COL22WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL22WAGEITEM || ' = ' ||
                 VALIDATE_V || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL22
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL22;
        
        end if;
      
        if COL23WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL23WAGEITEM || ' = ' ||
                 VALIDATE_W || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL23
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL23;
        
        end if;
      
        if COL24WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL24WAGEITEM || ' = ' ||
                 VALIDATE_X || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL24
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL24;
        
        end if;
      
        if COL25WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL25WAGEITEM || ' = ' ||
                 VALIDATE_Y || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL25
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL25;
        
        end if;
      
        if COL26WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL26WAGEITEM || ' = ' ||
                 VALIDATE_Z || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL26
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL26;
        
        end if;
      
        if COL27WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL27WAGEITEM || ' = ' ||
                 VALIDATE_AA || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL27
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL27;
        
        end if;
      
        if COL28WAGEITEM is not null then
        
          SELECT 'update spm_gz_wagedata wa set ' || COL28WAGEITEM || ' = ' ||
                 VALIDATE_AB || '  where wa.personname = ''' || VALIDATE_B || '''
                                       and wa.main_id =' ||
                 F_TABLENAME || ' '
            INTO VSQL28
            FROM DUAL;
          EXECUTE IMMEDIATE VSQL28;
        
        end if;
      
      end if;
    
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
             VALIDATE_AB;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --��֤������֯��Ϣ¼��
  PROCEDURE GZORG_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000);
    VALIDATE_B       VARCHAR2(2000);
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
    VALIDATE_E       VARCHAR2(2000);
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
    ORG_CODE         VARCHAR2(200);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
      INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D, VALIDATE_E;
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_B <> '��֯����' OR VALIDATE_C <> '��֯����' OR
         VALIDATE_D <> '��֯���' OR VALIDATE_E <> '��֯���' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
        INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D, VALIDATE_E;
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
        IF VALIDATE_E IS NULL THEN
          IF MSG_E IS NULL THEN
            MSG_E := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_B IS NOT NULL THEN
          SELECT COUNT(O.ORG_CODE)
            INTO VALIDATE_NUMBER1
            FROM SPM_GZ_ORGANIZATION O
           WHERE O.ORG_CODE = VALIDATE_B;
          IF VALIDATE_NUMBER1 > 0 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_B IS NOT NULL THEN
          VALIDATE_NUMBER2 := LENGTH(VALIDATE_B);
          IF VALIDATE_NUMBER2 <> 8 AND VALIDATE_NUMBER2 <> 10 AND
             VALIDATE_NUMBER2 <> 12 THEN
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA%ROWCOUNT;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        FETCH CU_DATA
          INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D, VALIDATE_E;
      END LOOP;
      CLOSE CU_DATA;
    END IF;
    IF MSG_A IS NOT NULL THEN
      MSG_A := MSG_A || '�� ��Ų���Ϊ��;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '�� ��֯���벻��Ϊ��;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '�� ��֯���Ʋ���Ϊ��;  ';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '�� ��֯�����Ϊ��;  ';
    END IF;
    IF MSG_M IS NOT NULL THEN
      MSG_M := MSG_M || '�� ������¼�Ѿ����ڣ������ٴε���;  ';
    END IF;
    IF MSG_N IS NOT NULL THEN
      MSG_N := MSG_N || '��,��֯���볤�Ȳ���ȷ,����˶ԣ�';
    END IF;
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --��֤������֯��Ϣ¼��
  PROCEDURE GZORG_INFO_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2, --ְ��respId
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
    ORG_TYPENAME     VARCHAR2(200);
    RESPID           VARCHAR2(20);
    GETRESPID        VARCHAR2(100);
    V_INFO_ID        NUMBER;
    DEPTPARENTID     NUMBER;
    EMPTYPARENTIDNUM NUMBER;
    USERORGID        NUMBER;
  
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
      --����
      SELECT SPM_GZ_ORGANIZATION_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_E IS NOT NULL THEN
        ORG_TYPENAME := SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_GZ_ORGANIZATION_TYPE',
                                                                VALIDATE_E);
      END IF;
      USERORGID := SPM_SSO_PKG.GETORGID;
      INSERT INTO SPM_GZ_ORGANIZATION
        (ORGANIZATION_ID,
         ORG_CODE,
         ORG_NAME,
         CORP_SHORT,
         ORG_TYPE,
         ORG_ID,
         ATTRIBUTE5)
      VALUES
        (V_INFO_ID,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_D,
         ORG_TYPENAME,
         USERORGID,
         F_TABLENAME);
      IF VALIDATE_E = '��˾' THEN
        UPDATE SPM_GZ_ORGANIZATION O
           SET O.PARENT_ID = 0
         WHERE O.ORG_CODE = VALIDATE_B;
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
    UPDATE SPM_GZ_ORGANIZATION N
       SET N.PARENT_ID =
           (SELECT T.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION T
             WHERE T.ORG_CODE =
                   SUBSTR(N.ORG_CODE, 1, LENGTH(N.ORG_CODE) - 2))
     WHERE LENGTH(N.ORG_CODE) <> 8;
    UPDATE SPM_GZ_ORGANIZATION N
       SET N.PARENT_ID =
           (SELECT T.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION T
             WHERE T.ORG_CODE = '10000616')
     WHERE N.ORG_CODE IN ('0010001437', '0010001438', '0010001440');
    SELECT COUNT(O.ORG_CODE)
      INTO EMPTYPARENTIDNUM
      FROM SPM_GZ_ORGANIZATION O
     WHERE O.PARENT_ID IS NULL;
    IF EMPTYPARENTIDNUM > 0 THEN
      P_MSG := '����Ĳ��Ż��Ҵ������ϼ���λ�������������֯�����Ƿ�����';
      ROLLBACK;
      RETURN;
    END IF;
    IF EMPTYPARENTIDNUM = 0 THEN
      COMMIT;
    END IF;
  END;

  --������Ա������Ϣ��֤validate
  PROCEDURE PERSON_SALARY_VALIDATA(P_TABLENAME VARCHAR2,
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
             TRIM(Q)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
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
           VALIDATE_Q;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '��˾����' OR VALIDATE_B <> '��˾����' OR
         VALIDATE_C <> '���ű���' OR VALIDATE_D <> '��������' OR
         VALIDATE_E <> '���ұ���' OR VALIDATE_F <> '��������' OR
         VALIDATE_G <> 'Ա�����' OR VALIDATE_H <> 'Ա������' OR
         VALIDATE_I <> 'Ա�����' OR VALIDATE_J <> '�ù���ʽ' OR
         VALIDATE_K <> '���֤' OR VALIDATE_L <> '����������' OR
         VALIDATE_M <> '�����˺�' OR VALIDATE_N <> '�뿪����ҵʱ��' OR
         VALIDATE_O <> '�Ա�' OR VALIDATE_P <> 'ְ��' OR
         VALIDATE_Q <> '�Ƿ�Ϊ��˾�쵼' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
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
             VALIDATE_Q;
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
        IF VALIDATE_Q IS NULL THEN
          IF MSG_Q IS NULL THEN
            MSG_Q := CU_DATA%ROWCOUNT;
          ELSE
            MSG_Q := MSG_Q || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(O.ORG_CODE)
            INTO VALIDATE_NUMBER1
            FROM SPM_GZ_ORGANIZATION O
           WHERE O.ORG_CODE = VALIDATE_A
             AND O.ORG_TYPE = 'org';
          IF VALIDATE_NUMBER1 = 0 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_N IS NOT NULL THEN
          VALIDATE_NUMBER4 := SPM_CON_RECEIPT_PKG.FN_ISDATE(REPLACE(VALIDATE_N,
                                                                    '-',
                                                                    ''));
          IF VALIDATE_NUMBER4 = 0 THEN
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA%ROWCOUNT;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_C IS NOT NULL THEN
          SELECT COUNT(O.ORG_CODE)
            INTO VALIDATE_NUMBER2
            FROM SPM_GZ_ORGANIZATION O
           WHERE O.ORG_CODE = VALIDATE_C;
          IF VALIDATE_NUMBER2 = 0 THEN
            IF MSG_E IS NULL THEN
              MSG_E := CU_DATA%ROWCOUNT;
            ELSE
              MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_E IS NOT NULL THEN
          SELECT COUNT(O.ORG_CODE)
            INTO VALIDATE_NUMBER3
            FROM SPM_GZ_ORGANIZATION O
           WHERE O.ORG_CODE = VALIDATE_E;
          IF VALIDATE_NUMBER3 = 0 THEN
            IF MSG_O IS NULL THEN
              MSG_O := CU_DATA%ROWCOUNT;
            ELSE
              MSG_O := MSG_O || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        --�ж���Ա�Ƿ��Ѿ�����  
        /*IF LENGTH(VALIDATE_E) > 1 THEN*/
        IF VALIDATE_H IS NOT NULL AND LENGTH(VALIDATE_E) > 1 THEN
          SELECT COUNT(E.NAME)
            INTO VALIDATE_NUMBER
            FROM SPM_GZ_EMPLOYEE E
           WHERE E.NAME = VALIDATE_H
             AND E.CARD_ID = VALIDATE_G
             AND E.DEPT_ID = (SELECT O.PARENT_ID
                                FROM SPM_GZ_ORGANIZATION O
                               WHERE O.ORG_CODE = VALIDATE_E);
          IF VALIDATE_NUMBER > 0 THEN
            IF MSG_F IS NULL THEN
              MSG_F := CU_DATA%ROWCOUNT;
            ELSE
              MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        ELSE
          SELECT COUNT(E.NAME)
            INTO VALIDATE_NUMBER
            FROM SPM_GZ_EMPLOYEE E
           WHERE E.NAME = VALIDATE_H
             AND E.CARD_ID = VALIDATE_G
             AND E.DEPT_ID = (SELECT N.ORGANIZATION_ID
                                FROM SPM_GZ_ORGANIZATION N
                               WHERE N.ORG_CODE = VALIDATE_C);
          IF VALIDATE_NUMBER > 0 THEN
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
               VALIDATE_H,
               VALIDATE_I,
               VALIDATE_J,
               VALIDATE_K,
               VALIDATE_L,
               VALIDATE_M,
               VALIDATE_N,
               VALIDATE_O,
               VALIDATE_P,
               VALIDATE_Q;
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '�� ��˾���벻��Ϊ��;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '�� ��˾���Ʋ���Ϊ��;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '�� ���ű��벻��Ϊ��;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '�� �������Ʋ���Ϊ��;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '�� Ա����������Ϊ��;  ';
      END IF;
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '�� Ա�������Ϊ��;  ';
      END IF;
      IF MSG_Q IS NOT NULL THEN
        MSG_Q := MSG_Q || '�� �Ƿ�Ϊ��˾�쵼����Ϊ��;  ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '�� ��˾���������ù�˾������;  ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '�� ���ڸ�ʽ��������;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '�� ���ű��������ò��Ų�����;  ';
      END IF;
      IF MSG_O IS NOT NULL THEN
        MSG_O := MSG_O || '�� ���ұ��������ô��Ҳ�����;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '�� ��Ա���Ѿ����ڣ������ظ��ύ; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O || MSG_P || MSG_Q;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --������Ա��Ϣ����
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
             TRIM(Z)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A    VARCHAR2(2000);
    VALIDATE_B    VARCHAR2(2000);
    VALIDATE_C    VARCHAR2(2000);
    VALIDATE_D    VARCHAR2(2000);
    VALIDATE_E    VARCHAR2(2000);
    VALIDATE_F    VARCHAR2(2000);
    VALIDATE_G    VARCHAR2(2000);
    VALIDATE_H    VARCHAR2(2000);
    VALIDATE_I    VARCHAR2(2000);
    VALIDATE_J    VARCHAR2(2000);
    VALIDATE_K    VARCHAR2(2000);
    VALIDATE_L    VARCHAR2(2000);
    VALIDATE_M    VARCHAR2(2000);
    VALIDATE_N    VARCHAR2(2000);
    VALIDATE_O    VARCHAR2(2000);
    VALIDATE_P    VARCHAR2(2000);
    VALIDATE_Q    VARCHAR2(2000);
    VALIDATE_R    VARCHAR2(2000);
    VALIDATE_S    VARCHAR2(2000);
    VALIDATE_T    VARCHAR2(2000);
    VALIDATE_U    VARCHAR2(2000);
    VALIDATE_V    VARCHAR2(2000);
    VALIDATE_W    VARCHAR2(2000);
    VALIDATE_X    VARCHAR2(2000);
    VALIDATE_Y    VARCHAR2(2000);
    VALIDATE_Z    VARCHAR2(2000);
    ATT3          VARCHAR2(200);
    ISLEADER      VARCHAR2(200);
    V_INFO_ID     NUMBER;
    DIMISSIONDATE VARCHAR2(200);
    DIMDATE       VARCHAR2(200);
  
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
    
      IF VALIDATE_I IS NOT NULL THEN
        ATT3 := SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_GZ_PERSONKIND_TYPE',
                                                        VALIDATE_I);
      END IF;
      IF VALIDATE_Q IS NOT NULL THEN
        IF VALIDATE_Q = '��' THEN
          ISLEADER := 'leader';
        END IF;
        IF VALIDATE_Q <> '��' THEN
          ISLEADER := 'no';
        END IF;
      END IF;
      IF LENGTH(VALIDATE_E) > 1 THEN
        ---�����Ҽ�
        INSERT INTO SPM_GZ_EMPLOYEE
          (PERSON_ID,
           CARD_ID,
           NAME,
           PERSON_KIND,
           EMPLOY_KIND,
           IDENTITY_ID,
           WAGE_BANK_NAME,
           WAGE_BANK_ACCOUNT,
           DIMISSION_DATE,
           SEX,
           DUTY, --
           ATTRIBUTE3,
           ATTRIBUTE4, ---
           ATTRIBUTE5,
           ORG_ID,
           DEPT_ID)
        VALUES
          (SPM_GZ_EMPLOYEE_SEQ.NEXTVAL,
           VALIDATE_G,
           VALIDATE_H,
           VALIDATE_I,
           VALIDATE_J,
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           TO_DATE(VALIDATE_N, 'yyyy/mm/dd'),
           VALIDATE_O,
           VALIDATE_P, --ְ��
           ATT3, --att3 ��Ա������
           ISLEADER, --�Ƿ�Ϊ�쵼
           (SELECT O.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION O
             WHERE O.ORG_CODE = VALIDATE_E), --att5
           (SELECT O.PARENT_ID
              FROM SPM_GZ_ORGANIZATION O
             WHERE O.ORG_CODE =
                   SUBSTR(VALIDATE_E, 1, LENGTH(VALIDATE_E) - 2)), --orgid
           (SELECT O.PARENT_ID
              FROM SPM_GZ_ORGANIZATION O
             WHERE O.ORG_CODE = VALIDATE_E)); --deptid
      ELSE
        INSERT INTO SPM_GZ_EMPLOYEE
          (PERSON_ID,
           CARD_ID,
           NAME,
           PERSON_KIND,
           EMPLOY_KIND,
           IDENTITY_ID,
           WAGE_BANK_NAME,
           WAGE_BANK_ACCOUNT,
           DIMISSION_DATE,
           SEX,
           DUTY, --
           ATTRIBUTE3,
           ATTRIBUTE4, ---
           ATTRIBUTE5,
           ORG_ID,
           DEPT_ID)
        VALUES
          (SPM_GZ_EMPLOYEE_SEQ.NEXTVAL,
           VALIDATE_G,
           VALIDATE_H,
           VALIDATE_I,
           VALIDATE_J,
           VALIDATE_K,
           VALIDATE_L,
           VALIDATE_M,
           TO_DATE(VALIDATE_N, 'yyyy-MM-dd'),
           VALIDATE_O,
           VALIDATE_P, --ְ��
           ATT3, --att3 ��Ա������
           ISLEADER, --�Ƿ�Ϊ�쵼
           VALIDATE_E, --att5 ����Ϊ��
           (SELECT N.PARENT_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_C), --orgid
           (SELECT N.ORGANIZATION_ID
              FROM SPM_GZ_ORGANIZATION N
             WHERE N.ORG_CODE = VALIDATE_C)); --deptid
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
    COMMIT;
  END;

  --������Ŀ¼����Ч�� ��֤validate
  PROCEDURE WAGETYPEITEMS_INFO_VALIDATA(P_TABLENAME VARCHAR2,
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
             TRIM(Q)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
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
    MSG_D1           VARCHAR2(4000);
    MSG_D2           VARCHAR2(4000);
    MSG_D3           VARCHAR2(4000);
    MSG_D4           VARCHAR2(4000);
    MSG_D5           VARCHAR2(4000);
    MSG_D6           VARCHAR2(4000);
    MSG_D7           VARCHAR2(4000);
    MSG_E1           VARCHAR2(4000);
    MSG_E2           VARCHAR2(4000);
    MSG_E3           VARCHAR2(4000);
    MSG_E4           VARCHAR2(4000);
    MSG_E5           VARCHAR2(4000);
    MSG_E6           VARCHAR2(4000);
    MSG_E7           VARCHAR2(4000);
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
           VALIDATE_Q;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '���ʷ���������' OR VALIDATE_B <> '���ʷ����������' OR
         VALIDATE_C <> '������Ŀ���' OR VALIDATE_D <> '������ĿӢ����' OR
         VALIDATE_E <> '������Ŀ������' OR VALIDATE_F <> '������Ŀ����' OR
         VALIDATE_G <> '�̳��ϴη���ֵ' OR VALIDATE_H <> '������˾ȫ��' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
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
             VALIDATE_Q;
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
        IF VALIDATE_D = 'GZYF_08' AND VALIDATE_E <> '����' THEN
          IF MSG_D1 IS NULL THEN
            MSG_D1 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D1 := MSG_D1 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_09' AND VALIDATE_E <> '�в�' THEN
          IF MSG_D2 IS NULL THEN
            MSG_D2 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D2 := MSG_D2 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_19' AND VALIDATE_E <> 'ȡů��' AND
           VALIDATE_E <> '��ů����' THEN
          IF MSG_D3 IS NULL THEN
            MSG_D3 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D3 := MSG_D3 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_28' AND VALIDATE_E <> '�꽱' THEN
          IF MSG_D4 IS NULL THEN
            MSG_D4 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D4 := MSG_D4 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZKJ_07' AND VALIDATE_E <> '�۲���' THEN
          IF MSG_D5 IS NULL THEN
            MSG_D5 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D5 := MSG_D5 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZKJ_08' AND VALIDATE_E <> '���¼�' THEN
          IF MSG_D6 IS NULL THEN
            MSG_D6 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D6 := MSG_D6 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '����' AND VALIDATE_D <> 'GZYF_08' THEN
          IF MSG_E1 IS NULL THEN
            MSG_E1 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E1 := MSG_E1 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '�в�' AND VALIDATE_D <> 'GZYF_09' THEN
          IF MSG_E2 IS NULL THEN
            MSG_E2 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E2 := MSG_E2 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = 'ȡů��' AND VALIDATE_D <> 'GZYF_19' THEN
          IF MSG_E3 IS NULL THEN
            MSG_E3 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E3 := MSG_E3 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '��ů����' AND VALIDATE_D <> 'GZYF_19' THEN
          IF MSG_E4 IS NULL THEN
            MSG_E4 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E4 := MSG_E4 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '�꽱' AND VALIDATE_D <> 'GZYF_28' THEN
          IF MSG_E5 IS NULL THEN
            MSG_E5 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E5 := MSG_E5 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '�۲���' AND VALIDATE_D <> 'GZKJ_07' THEN
          IF MSG_E6 IS NULL THEN
            MSG_E6 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E6 := MSG_E6 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '���¼�' AND VALIDATE_D <> 'GZKJ_08' THEN
          IF MSG_E7 IS NULL THEN
            MSG_E7 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E7 := MSG_E7 || ',' || CU_DATA%ROWCOUNT;
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
        /*if validate_q is null then
          if msg_q is null then
            msg_q := cu_data%rowcount;
          else
            msg_q := msg_q || ',' || cu_data%rowcount;
          end if;
        end if;*/
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(WT.WAGETYPE_CODE)
            INTO VALIDATE_NUMBER1
            FROM SPM_GZ_WAGETYPEITEMS WT
           WHERE WT.WAGETYPE_CODE = VALIDATE_A
             AND WT.WAGEITEM_NO = VALIDATE_C
             AND WT.WAGEITEM_ENAME = VALIDATE_D;
          IF VALIDATE_NUMBER1 > 1 THEN
            IF MSG_M IS NULL THEN
              MSG_M := CU_DATA%ROWCOUNT;
            ELSE
              MSG_M := MSG_M || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        /* if validate_n is not null then
           validate_number4:= SPM_CON_RECEIPT_PKG.FN_ISDATE(replace(validate_n,'-',''));
          if validate_number4 = 0 then
            if msg_n is null then
              msg_n := cu_data%rowcount;
            else
              msg_n := msg_n || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;
         if validate_c is not null then
          select count(o.org_code)
            into validate_number2
            from spm_gz_organization o
           where o.org_code = validate_c;
          if validate_number2 = 0 then
            if msg_e is null then
              msg_e := cu_data%rowcount;
            else
              msg_e := msg_e || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;
         if validate_e is not null then
          select count(o.org_code)
            into validate_number3
            from spm_gz_organization o
           where o.org_code = validate_e;
          if validate_number3 = 0 then
            if msg_o is null then
              msg_o := cu_data%rowcount;
            else
              msg_o := msg_o || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;   */
        IF VALIDATE_H IS NOT NULL THEN
          SELECT COUNT(OU.ORGANIZATION_ID)
            INTO VALIDATE_NUMBER
            FROM HR_OPERATING_UNITS OU
           WHERE OU.NAME = VALIDATE_H;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_N IS NULL THEN
              MSG_N := CU_DATA%ROWCOUNT;
            ELSE
              MSG_N := MSG_N || ',' || CU_DATA%ROWCOUNT;
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
               VALIDATE_Q;
      END LOOP;
      CLOSE CU_DATA;
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '�� ���ʷ��������벻��Ϊ��;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '�� ���ʷ���������Ʋ���Ϊ��;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '�� ������Ŀ��Ų���Ϊ��;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '�� ������ĿӢ��������Ϊ��;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '�� ������Ŀ����������Ϊ��;  ';
      END IF;
      IF MSG_D1 IS NOT NULL THEN
        MSG_D1 := MSG_D1 || '�� ��ĿӢ����ΪGZYF_08ʱ����Ŀ����������Ϊ����;  ';
      END IF;
      IF MSG_D2 IS NOT NULL THEN
        MSG_D2 := MSG_D2 || '�� ��ĿӢ����ΪGZYF_09ʱ����Ŀ����������Ϊ�в�;  ';
      END IF;
      IF MSG_D3 IS NOT NULL THEN
        MSG_D3 := MSG_D3 || '�� ��ĿӢ����ΪGZYF_19ʱ����Ŀ����������Ϊȡů�ѻ��ů����;  ';
      END IF;
      IF MSG_D4 IS NOT NULL THEN
        MSG_D4 := MSG_D4 || '�� ��ĿӢ����ΪGZYF_28ʱ����Ŀ����������Ϊ�꽱;  ';
      END IF;
      IF MSG_D5 IS NOT NULL THEN
        MSG_D5 := MSG_D5 || '�� ��ĿӢ����ΪGZKJ_07ʱ����Ŀ����������Ϊ�۲���;  ';
      END IF;
      IF MSG_D6 IS NOT NULL THEN
        MSG_D6 := MSG_D6 || '�� ��ĿӢ����ΪGZKJ_08ʱ����Ŀ����������Ϊ���¼�;  ';
      END IF;
      IF MSG_E1 IS NOT NULL THEN
        MSG_E1 := MSG_E1 || '�� ��Ŀ������Ϊ����ʱ����ĿӢ��������ΪGZYF_08;  ';
      END IF;
      IF MSG_E2 IS NOT NULL THEN
        MSG_E2 := MSG_E2 || '�� ��Ŀ������Ϊ�в�ʱ����ĿӢ��������ΪGZYF_09;  ';
      END IF;
      IF MSG_E3 IS NOT NULL THEN
        MSG_E3 := MSG_E3 || '�� ��Ŀ������Ϊȡů�ѻ��ů����ʱ����ĿӢ��������ΪGZYF_19;  ';
      END IF;
      IF MSG_E4 IS NOT NULL THEN
        MSG_E4 := MSG_E4 || '�� ��Ŀ������Ϊȡů�ѻ��ů����ʱ����ĿӢ��������ΪGZYF_19;  ';
      END IF;
      IF MSG_E5 IS NOT NULL THEN
        MSG_E5 := MSG_E5 || '�� ��Ŀ������Ϊ�꽱ʱ����ĿӢ��������ΪGZYF_28;  ';
      END IF;
      IF MSG_E6 IS NOT NULL THEN
        MSG_E6 := MSG_E6 || '�� ��Ŀ������Ϊ�۲���ʱ����ĿӢ��������ΪGZKJ_07;  ';
      END IF;
      IF MSG_E7 IS NOT NULL THEN
        MSG_E7 := MSG_E7 || '�� ��Ŀ������Ϊ���¼�ʱ����ĿӢ��������ΪGZKJ_08;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '�� ������Ŀ���Բ���Ϊ��;  ';
      END IF;
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '�� �̳��ϴη���ֵ����Ϊ��;  ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '�� �ù�����Ŀ�Ѿ�����,�����ظ��ύ;  ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '�� ������˾�����ڻ�˾ȫ������;  ';
      END IF;
      /* if msg_e is not null then
        msg_e := msg_e || '�� ���ű��������ò��Ų�����;  ';
      end if;
       if msg_o is not null then
        msg_o := msg_o || '�� ���ұ��������ô��Ҳ�����;  ';
      end if;
      if msg_f is not null then
        msg_f:= msg_f ||'�� ��Ա���Ѿ����ڣ������ظ��ύ; ';
      end if;*/
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O || MSG_P || MSG_Q || MSG_D1 || MSG_D2 ||
               MSG_D3 || MSG_D4 || MSG_D5 || MSG_D6 || MSG_E1 || MSG_E2 ||
               MSG_E3 || MSG_E4 || MSG_E5 || MSG_E6 || MSG_E7;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --������Ŀ��Ϣ����
  PROCEDURE WAGETYPEITEMS_INFO_IMPORT(P_TABLENAME VARCHAR2,
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
    VALIDATE_A    VARCHAR2(2000);
    VALIDATE_B    VARCHAR2(2000);
    VALIDATE_C    VARCHAR2(2000);
    VALIDATE_D    VARCHAR2(2000);
    VALIDATE_E    VARCHAR2(2000);
    VALIDATE_F    VARCHAR2(2000);
    VALIDATE_G    VARCHAR2(2000);
    VALIDATE_H    VARCHAR2(2000);
    VALIDATE_I    VARCHAR2(2000);
    VALIDATE_J    VARCHAR2(2000);
    VALIDATE_K    VARCHAR2(2000);
    VALIDATE_L    VARCHAR2(2000);
    VALIDATE_M    VARCHAR2(2000);
    VALIDATE_N    VARCHAR2(2000);
    VALIDATE_O    VARCHAR2(2000);
    VALIDATE_P    VARCHAR2(2000);
    VALIDATE_Q    VARCHAR2(2000);
    VALIDATE_R    VARCHAR2(2000);
    VALIDATE_S    VARCHAR2(2000);
    VALIDATE_T    VARCHAR2(2000);
    VALIDATE_U    VARCHAR2(2000);
    VALIDATE_V    VARCHAR2(2000);
    VALIDATE_W    VARCHAR2(2000);
    VALIDATE_X    VARCHAR2(2000);
    VALIDATE_Y    VARCHAR2(2000);
    VALIDATE_Z    VARCHAR2(2000);
    PROP          VARCHAR2(200);
    INHERITED     VARCHAR2(200);
    ORGID         NUMBER;
    DIMISSIONDATE VARCHAR2(200);
    DIMDATE       VARCHAR2(200);
  
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
    
      IF VALIDATE_F IS NOT NULL THEN
        PROP := SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_GZ_WAGEITEM_PROP',
                                                        VALIDATE_F);
      END IF;
      IF VALIDATE_G IS NOT NULL THEN
        INHERITED := SPM_EAM_COMMON_PKG.GET_DICTCODE_BY_NAME('SPM_GZ_WAGEITEM_INHERITED',
                                                             VALIDATE_G);
      END IF;
      IF VALIDATE_H IS NOT NULL THEN
        SELECT OU.ORGANIZATION_ID
          INTO ORGID
          FROM HR_OPERATING_UNITS OU
         WHERE OU.NAME = VALIDATE_H;
      END IF;
      --wageitemtype := "N";
      INSERT INTO SPM_GZ_WAGETYPEITEMS
        (ID,
         ORG_ID,
         WAGETYPE_CODE,
         WAGETYPE_NAME,
         WAGEITEM_NO,
         WAGEITEM_ENAME,
         WAGEITEM_CNAME,
         WAGEITEM_TYPE,
         WAGEITEM_PROP,
         WAGEITEM_INHERITED,
         WAGEITEM_STATUS)
      VALUES
        (SPM_GZ_WAGETYPEITEMS_SEQ.NEXTVAL,
         ORGID,
         VALIDATE_A,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_D,
         VALIDATE_E,
         'N',
         PROP,
         INHERITED,
         '1');
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

  /**
  * ����spm_gz_wagetype����洢��wagetype_object����code��Ϣ ��ѯ�����Ĳ�������
  * @param operationType 1
  * @param ids wagetype_object����code��Ϣ
  */
  FUNCTION GET_WAGETYPE_OBJECT_NAME( --operationType In NUMBER,
                                    RELATIONIDS IN VARCHAR2) RETURN VARCHAR2 IS
    DEPTNAME             VARCHAR2(4000) := '';
    IDS                  SPM_TYPE_TBL;
    WAGETYPE_OBJECT_NAME VARCHAR2(400);
    AAA                  VARCHAR2(40);
  BEGIN
    SELECT SPM_GZ_INTGZINFO_PKG.SPLIT_STRING_OBJECT(RELATIONIDS)
      INTO IDS
      FROM DUAL;
    /* IF operationType = 1 THEN*/
    FOR I IN 1 .. IDS.COUNT LOOP
      --���ݽ�����Ĳ���code��ѯ����name
      SELECT O.ORG_NAME
        INTO AAA
        FROM SPM_GZ_ORGANIZATION O
       WHERE O.ORG_CODE = IDS(I);
      DEPTNAME := DEPTNAME || ',' || AAA;
    END LOOP;
    /*END IF;  */
    WAGETYPE_OBJECT_NAME := SUBSTR(DEPTNAME, - (LENGTH(DEPTNAME) - 1));
  
    /* EXCEPTION
    WHEN OTHERS THEN
     dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
     dbms_output.put_line('Error Message = ' || SQLERRM);    */
    RETURN WAGETYPE_OBJECT_NAME;
  END GET_WAGETYPE_OBJECT_NAME;

  /**
  * ����spm_gz_createcert����洢��wagetype_code ��Ϣ��to_wageitems ��ѯ�����Ĺ�����Ŀ����
  * @param operationType 1
  * @param ids to_wageitems ������ĿӢ����Ϣ
  */
  FUNCTION GET_WAGEITEMS_NAME(RELATIONIDS  IN VARCHAR2,
                              WAGETYPECODE IN VARCHAR2) RETURN VARCHAR2 IS
    WAGEITEMSNAME  VARCHAR2(4000) := '';
    ITEMS          SPM_TYPE_TBL;
    WAGEITEMS_NAME VARCHAR2(400);
    NAMES          VARCHAR2(40);
  BEGIN
    SELECT SPM_GZ_INTGZINFO_PKG.SPLIT_STRING_OBJECT(RELATIONIDS)
      INTO ITEMS
      FROM DUAL;
    /* IF operationType = 1 THEN*/
    FOR I IN 1 .. ITEMS.COUNT LOOP
      --���ݽ�����Ĺ�����Ŀitems��ѯ������Ŀname
      SELECT WT.WAGEITEM_CNAME
        INTO NAMES
        FROM SPM_GZ_WAGETYPEITEMS WT
       WHERE WT.WAGETYPE_CODE = WAGETYPECODE
         AND WT.WAGEITEM_ENAME = ITEMS(I);
      /*SELECT O.Org_Name
       INTO aaa
       FROM SPM_GZ_ORGANIZATION O
      WHERE O.ORG_CODE= ids(i);*/
      WAGEITEMSNAME := WAGEITEMSNAME || ',' || NAMES;
    END LOOP;
    /*END IF;  */
    WAGEITEMS_NAME := SUBSTR(WAGEITEMSNAME, - (LENGTH(WAGEITEMSNAME) - 1));
  
    /* EXCEPTION
    WHEN OTHERS THEN
     dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
     dbms_output.put_line('Error Message = ' || SQLERRM);    */
    RETURN WAGEITEMS_NAME;
  END GET_WAGEITEMS_NAME;
  ---object������Ϣ�ַ���ת�ɶ��к���(��ȥ'',)
  FUNCTION SPLIT_STRING_OBJECT(SPLIT_OBJECT   VARCHAR2,
                               SPLIT_OPERATOR VARCHAR2 DEFAULT ',')
    RETURN SPM_TYPE_TBL IS
    -- Author  : SpringLee
    -- Created : 2014/08/07 16:05:44
    -- Purpose : �ַ����ָ�
  
    -- Params
    -- SPLIT_OBJECT   : Ҫ������ַ���
    -- SPLIT_OPERATOR ���ַ����ָ��
  
    V_OUT        SPM_TYPE_TBL;
    V_TMP        VARCHAR2(4000);
    V_TMP_OBJECT VARCHAR2(4000);
    V_ELEMENT    VARCHAR2(4000);
  BEGIN
    V_TMP := SPLIT_OBJECT;
    V_OUT := SPM_TYPE_TBL();
  
    --�������ƥ��ķָ��
    WHILE INSTR(V_TMP, SPLIT_OPERATOR) > 0 LOOP
      V_ELEMENT := SUBSTR(V_TMP, 1, INSTR(V_TMP, SPLIT_OPERATOR) - 1);
    
      V_TMP := SUBSTR(V_TMP,
                      INSTR(V_TMP, SPLIT_OPERATOR) + LENGTH(SPLIT_OPERATOR),
                      LENGTH(V_TMP));
      SELECT TRIM(BOTH '''' FROM V_ELEMENT) INTO V_TMP_OBJECT FROM DUAL;
      V_OUT.EXTEND(1);
      V_OUT(V_OUT.COUNT) := V_TMP_OBJECT;
    END LOOP;
    IF V_TMP IS NOT NULL THEN
      SELECT TRIM(BOTH '''' FROM V_TMP) INTO V_TMP_OBJECT FROM DUAL;
      V_OUT.EXTEND(1);
      V_OUT(V_OUT.COUNT) := V_TMP_OBJECT;
    END IF;
    RETURN V_OUT;
  END SPLIT_STRING_OBJECT;

  /**
  * ����spm_gz_employee����attribute5�洢�Ĵ���id��Ϣ ��ѯ��������������
  * @param ids attribute5�洢�Ĵ���id��Ϣ
  */
  FUNCTION GET_EMP_OFFICE_NAME( --operationType In NUMBER,
                               OFFICEID IN VARCHAR2) RETURN VARCHAR2 IS
    OFFICENAME VARCHAR2(400);
  BEGIN
    --���ݴ���id��ѯ����name
    SELECT O.ORG_NAME
      INTO OFFICENAME
      FROM SPM_GZ_ORGANIZATION O
     WHERE O.ORGANIZATION_ID = OFFICEID;
    RETURN OFFICENAME;
  END GET_EMP_OFFICE_NAME;

  -- ���ʹ�����غ���
  --���ʹ���htmlչ��
 FUNCTION SPM_GZ_SP_INFO_HTML(P_KEY IN VARCHAR2, POTYPE_CODE IN VARCHAR2)
   RETURN VARCHAR2 IS
   MSG      VARCHAR2(20000);
   V_BID_ID NUMBER;
   WCODE    VARCHAR2(20);
 
 BEGIN
 
   SELECT W.JOB_ID
     INTO V_BID_ID
     FROM SPM_CON_WF_ACTIVITY W
    WHERE ITEM_KEY = P_KEY;
 
   SELECT M.WAGETYPE_CODE || '$' || M.BUSINESS_YEAR || ',' ||
          M.BUSINESS_MONTH || ',' || M.BUSINESS_NUM || ',' || M.ORG_ID || '!'
     INTO WCODE
     FROM SPM_CON_WF_ACTIVITY S
    INNER JOIN SPM_GZ_WAGEDATA_MAIN M
       ON S.JOB_ID = M.ID
    WHERE S.ITEM_KEY = P_KEY;
 
   MSG := '<a href=''' ||
          SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                               'WF_URL=/spmGzWagedata?ebsWage=' ||
                                               WCODE,
                                               P_KEY) || '''>�鿴����</a><br>';
   RETURN MSG;
 EXCEPTION
   WHEN OTHERS THEN
     MSG := '��������';
     RETURN MSG;
 END;

  --���ʹ������̷���
  PROCEDURE SPM_GZ_SP_INFO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN

    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;

    --���̷����,��ҵ���״̬����Ϊ��Ӧ�ڵ�
    UPDATE SPM_GZ_WAGEDATA_MAIN
       SET STATUS   = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                     PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --���ʹ���������׼�ص�����
  PROCEDURE SPM_GZ_SP_INFO_PZ(P_KEY        IN VARCHAR2,
                              P_OTYPE_CODE IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2) AS
    V_P_POSITION_ID NUMBER;
    V_P_ID          NUMBER;
    V_STATUS        VARCHAR2(20);
  BEGIN
  
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(P_KEY,
                                         P_OTYPE_CODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         'STATUS',
                                         'JOB_ID',
                                         'ID');
  
    --��ȡҵ�������ID,����״̬
    BEGIN
      SELECT S.ID, NVL(S.STATUS, 'A')
        INTO V_P_ID, V_STATUS
        FROM SPM_GZ_WAGEDATA_MAIN S
       WHERE S.ITEM_KEY = P_KEY
         AND ROWNUM < 2;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE;
    END;
  
    -- if v_status='A' or v_status='F' or v_status='G' then
    --������ǩ
    -- wf_engine.SetItemAttrText('SPMWF',
    /* P_Key,
    'ATT_PERCENT',
    100);*/
  
    /**
    ��ָ̬��������Աʱ ��ɾ���ض����õ�������Ա
    ��ָ��������ĳЩ�����ڵ�����Ҫ���ö�̬ѡ��
    ��Ҫ��̬ѡ������Աʱ���ô˴���
    **/
    -- delete ccm_wf_user_group cg
    --   where cg.itemkey = P_Key;
  
    --else
    --ȡ����ǩ
    /*wf_engine.SetItemAttrText('SPMWF',
                             P_Key,
                             'ATT_PERCENT',
                             0.1);
    
    end if;      */
  
  END SPM_GZ_SP_INFO_PZ;

  --���ʹ�������֪ͨ���ɻص�
  PROCEDURE SPM_GZ_SP_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                P_ITEMKEY    IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.GENERATE_HISTORY_INFO(P_NOTIFID,
                                               P_ITEMKEY,
                                               P_OTYPE_CODE,
                                               'SPM_GZ_WAGEDATA_MAIN',
                                               'ID',
                                               'STATUS',
                                               'ITEM_KEY',
                                               'D',
                                               'E');
  END SPM_GZ_SP_INFO_TZSC;

  --���ʹ�������֪ͨ����(��)�ص�
  PROCEDURE SPM_GZ_SP_INFO_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT);
  END SPM_GZ_SP_INFO_TZH;

  --���ʹ������̻�ǩ�ڵ���׼�ص�������֪ͨ�����
  PROCEDURE SPM_GZ_SP_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(P_KEY,
                                         P_OTYPE_CODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         'STATUS',
                                         'JOB_ID',
                                         'ID');
  END SPM_GZ_SP_INFO_TZ_AFTER;

  --���ʹ������̲�����֤�ص�������֪ͨ����ǰ��
  /*PROCEDURE spm_gz_sp_info_TZ_BEFORE(p_Key        In Varchar2,
                                    p_Otype_Code In VARCHAR2,
                                    p_notifid In VARCHAR2,
                                    p_oper_result In VARCHAR2) AS
   l_nid        number;
   v_info       varchar2(1000);
   cou          number;
  begin
      l_nid  := WF_ENGINE.context_nid;
      v_info := wf_notification.GetAttrText(l_nid, 'ATT_AUDIT');
  
      IF p_oper_result = 'N' THEN
          cou :=  SPM_CON_CONTRACT_PKG.spm_con_rebut_reason_wf_vali(v_info);
          IF cou=0 THEN
             FND_MESSAGE.SET_NAME('CUX', '��ʾ');
             FND_MESSAGE.SET_TOKEN('��Ϣ', '����ԭ��ƥ��');
             APP_EXCEPTION.RAISE_EXCEPTION;
          END IF;
  
  
      END IF;
  
  END ;   */

  --���ʹ�������ͨ���ص�
  PROCEDURE SPM_GZ_SP_INFO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'E' WHERE ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  END;

  --���ʹ����ػص�
  PROCEDURE SPM_GZ_SP_INFO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'D' WHERE ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  
  END;

  --��֤���Ԥ����Ϣ¼��
  PROCEDURE PRECONTROL_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D), TRIM(E), TRIM(F)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000);
    VALIDATE_B       VARCHAR2(2000);
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
    VALIDATE_E       VARCHAR2(2000);
    VALIDATE_F       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
    VALIDATE_NUMBER5 NUMBER;
    VALIDATE_NUMBER6 NUMBER;
    VALIDATE_NUMBER7 NUMBER;
    VALIDATE_NUMBER8 NUMBER;
    ISHAS            NUMBER;
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
    ORG_CODE         VARCHAR2(200);
  
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
           VALIDATE_F;
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_A <> '��֯����' OR VALIDATE_B <> '���' OR VALIDATE_C <> '������' OR
         VALIDATE_D <> '��������' OR VALIDATE_E <> 'ְ������' OR
         VALIDATE_F <> '���Ԥ��' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
        INTO VALIDATE_A,
             VALIDATE_B,
             VALIDATE_C,
             VALIDATE_D,
             VALIDATE_E,
             VALIDATE_F;
    
      WHILE CU_DATA%FOUND LOOP
        --У������
        IF VALIDATE_A IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        --��֤�Ƿ���ڸ���֯
      
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(*)
            INTO ISHAS
            FROM SPM_GZ_ORGANIZATION O
           WHERE O.ATTRIBUTE3 = '1'
             AND O.CORP_SHORT = VALIDATE_A;
        
          IF ISHAS = 0 THEN
            IF MSG_C IS NULL THEN
              MSG_C := CU_DATA%ROWCOUNT;
            ELSE
              MSG_C := MSG_C || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        
          --������ڸ���֯��У���Ƿ��Ѿ����ڸ���ȵ�Ԥ��
          IF ISHAS > 0 AND VALIDATE_B IS NOT NULL THEN
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER8
              FROM SPM_GZ_PRECONTROL P
             WHERE P.ORG = (SELECT O.ATTRIBUTE2
                              FROM SPM_GZ_ORGANIZATION O
                             WHERE O.ATTRIBUTE3 = '1'
                               AND O.CORP_SHORT = VALIDATE_A)
               AND P.YEAR = VALIDATE_B;
          
            IF VALIDATE_NUMBER8 > 0 THEN
              IF MSG_G IS NULL THEN
                MSG_G := CU_DATA%ROWCOUNT;
              ELSE
                MSG_G := MSG_G || ',' || CU_DATA%ROWCOUNT;
              END IF;
            END IF;
          END IF;
        
        END IF;
      
        IF VALIDATE_B IS NULL THEN
          IF MSG_B IS NULL THEN
            MSG_B := CU_DATA%ROWCOUNT;
          ELSE
            MSG_B := MSG_B || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        IF VALIDATE_F IS NULL THEN
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
               VALIDATE_F;
      
      END LOOP;
      CLOSE CU_DATA;
    END IF;
    IF MSG_A IS NOT NULL THEN
      MSG_A := MSG_A || '�� ��֯���Ʋ���Ϊ��;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '�� ��ݲ���Ϊ��;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '�� ��֯���ƴ���;  ';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '�� ���Ԥ�㲻��Ϊ��;  ';
    END IF;
    IF MSG_G IS NOT NULL THEN
      MSG_G := MSG_G || '�� �Ѿ����ڸ���֯����ݵ����Ԥ��;  ';
    END IF;
  
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --�������Ԥ������
  PROCEDURE PRECONTROL_IMPORT(P_TABLENAME VARCHAR2,
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
    ORGS       VARCHAR2(40);
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
      --����
      SELECT SPM_GZ_PRECONTROL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_A IS NOT NULL THEN
        SELECT O.ATTRIBUTE2 --�µĶ���
          INTO ORGS
          FROM SPM_GZ_ORGANIZATION O
         WHERE O.ATTRIBUTE3 = '1' --�����һ����֯
           AND O.CORP_SHORT = VALIDATE_A;
      END IF;
      INSERT INTO SPM_GZ_PRECONTROL
        (ID, ORG, YEAR, ALL_NUMBER, ZG_NUMBER, BZ_NUMBER, YEAR_AMOUNT)
      VALUES
        (V_INFO_ID,
         ORGS,
         VALIDATE_B,
         VALIDATE_C,
         VALIDATE_E,
         VALIDATE_D,
         VALIDATE_F);
    
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
  --��֤�쵼����Ԥ����Ϣ¼��
  PROCEDURE LEADER_VALIDATA(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A       VARCHAR2(2000);
    VALIDATE_B       VARCHAR2(2000);
    VALIDATE_C       VARCHAR2(2000);
    VALIDATE_D       VARCHAR2(2000);
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
    ORG_CODE         VARCHAR2(200);
  
    V_DICT_PRO_USE      VARCHAR2(200);
    V_DICT_IS_CHECK     VARCHAR2(200);
    V_DICT_PRO_CLASSIFY VARCHAR2(200);
  
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
      INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_A <> '��֯����' OR VALIDATE_B <> '���' OR VALIDATE_C <> '��˾�쵼' OR
         VALIDATE_D <> '���Ԥ��' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
        INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
    
      WHILE CU_DATA%FOUND LOOP
        --У������
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
      
        IF VALIDATE_C IS NOT NULL THEN
          --�жϸ��쵼�Ƿ����
          SELECT COUNT(P.PERSONID)
            INTO VALIDATE_NUMBER
            FROM SPM_GZ_PERSON_VIEW P
           WHERE P.NAME = VALIDATE_C;
          IF VALIDATE_NUMBER = 0 THEN
            IF MSG_E IS NULL THEN
              MSG_E := CU_DATA%ROWCOUNT;
            ELSE
              MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
          --�ж��Ƿ��Ѿ����ڸ��쵼��Ԥ��
          IF VALIDATE_NUMBER > 0 AND VALIDATE_B IS NOT NULL THEN
            SELECT COUNT(*)
              INTO VALIDATE_NUMBER8
              FROM SPM_GZ_LEADER L
             WHERE L.YEAR = VALIDATE_B
               AND L.LEADER = VALIDATE_C;
          END IF;
          IF VALIDATE_NUMBER8 > 0 THEN
            IF MSG_F IS NULL THEN
              MSG_F := CU_DATA%ROWCOUNT;
            ELSE
              MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
      
        IF VALIDATE_D IS NULL THEN
          IF MSG_D IS NULL THEN
            MSG_D := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
      
        FETCH CU_DATA
          INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
      
      END LOOP;
      CLOSE CU_DATA;
    END IF;
    IF MSG_A IS NOT NULL THEN
      MSG_A := MSG_A || '�� ��֯���Ʋ���Ϊ��;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '�� ��ݲ���Ϊ��;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '�� ��˾�쵼����Ϊ��;  ';
    END IF;
    IF MSG_D IS NOT NULL THEN
      MSG_D := MSG_D || '�� ���Ԥ�㲻��Ϊ��;  ';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '�� �����ڸ��쵼��ȷ��;  ';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '�� ����ݸ��쵼�Ĺ���Ԥ���Ѿ�����;  ';
    END IF;
  
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --�����쵼����Ԥ������
  PROCEDURE LEADER_IMPORT(P_TABLENAME VARCHAR2,
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
    ORGS       VARCHAR2(40);
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
      --����
      SELECT SPM_GZ_LEADER_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_A IS NOT NULL THEN
        --��ȡ��֯code
        SELECT O.ATTRIBUTE2 --�µĶ���
          INTO ORGS
          FROM SPM_GZ_ORGANIZATION O
         WHERE O.ATTRIBUTE3 = '1' --�����һ����֯
           AND O.CORP_SHORT = VALIDATE_A;
        /*select o.org_code
         into orgs
         from spm_gz_organization o
        where o.org_type = 'org'
          and o.corp_short = validate_a;*/
      END IF;
      INSERT INTO SPM_GZ_LEADER
        (ID, ORG, YEAR, LEADER, YEAR_AMOUNT)
      VALUES
        (V_INFO_ID, ORGS, VALIDATE_B, VALIDATE_C, VALIDATE_D);
    
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

  --ר����Ϣ������Ϣ��֤validate   ר����ѯ�ѷ�����ϸҳ��
  PROCEDURE EXPERT_FEE_VALIDATA(P_TABLENAME VARCHAR2,
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
             TRIM(Q)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    NUMBANKACOUNT    NUMBER;
    NUMOPENINGBANK   NUMBER;
    NUMINACOUNTPRO   NUMBER;
    NUMINACOUNTCITY  NUMBER;
    V_EXP_ID         NUMBER;
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
           VALIDATE_Q;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '����' OR VALIDATE_B <> '���֤��' OR VALIDATE_C <> 'ʵ�����' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
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
             VALIDATE_Q;
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
        IF VALIDATE_A IS NOT NULL THEN
          SELECT COUNT(VENDOR_NAME)
            INTO VALIDATE_NUMBER
            FROM SPM_CON_VENDOR_INFO VI
           WHERE VI.VENDOR_NAME = VALIDATE_A
             AND VI.VENDOR_CODE = VALIDATE_B
             AND VI.IS_BIDDING_VENDOR = 'Y';
          IF VALIDATE_NUMBER = 0 THEN
            ---ר������ ���֤�Ų�����
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA%ROWCOUNT;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
            END IF;
          ELSE
            --ר������ ���֤�Ŵ���
            SELECT VI.VENDOR_ID
              INTO V_EXP_ID
              FROM SPM_CON_VENDOR_INFO VI
             WHERE VI.VENDOR_NAME = VALIDATE_A
               AND VI.VENDOR_CODE = VALIDATE_B
               AND VI.IS_BIDDING_VENDOR = 'Y';
            SELECT COUNT(BI.BANK_ACOUNT), --�ж�ר��������Ϣ�Ƿ�����
                   COUNT(BI.OPENING_BANK),
                   COUNT(BI.ATTRIBUTE3),
                   COUNT(BI.ATTRIBUTE4)
              INTO NUMBANKACOUNT,
                   NUMOPENINGBANK,
                   NUMINACOUNTPRO,
                   NUMINACOUNTCITY
              FROM SPM_CON_BANK_ACOUNT_INFO BI
             WHERE BI.VENDOR_ID = V_EXP_ID;
            IF NUMBANKACOUNT = 0 OR NUMOPENINGBANK = 0 OR
               NUMINACOUNTPRO = 0 OR NUMINACOUNTCITY = 0 THEN
              IF MSG_F IS NULL THEN
                MSG_F := CU_DATA%ROWCOUNT;
              ELSE
                MSG_F := MSG_F || ',' || CU_DATA%ROWCOUNT;
              END IF;
            END IF;
          END IF;
        END IF;
        IF VALIDATE_C IS NOT NULL THEN
          SELECT SPM_IMPORT_XLS_PKG.IS_NUMBER(VALIDATE_C)
            INTO VALIDATE_NUMBER1
            FROM DUAL;
          IF VALIDATE_NUMBER1 = 0 THEN
            IF MSG_E IS NULL THEN
              MSG_E := CU_DATA%ROWCOUNT;
            ELSE
              MSG_E := MSG_E || ',' || CU_DATA%ROWCOUNT;
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
               VALIDATE_Q;
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '�� ��������Ϊ��;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '�� ���֤�Ų���Ϊ��;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '�� ʵ������Ϊ��;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '�� ��ר����ר����Ϣ���ﲻ���ڣ�����ά����ר�ҿ�; ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '�� ����ʽ����ȷ;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '�� ��ר�ҵ�������Ϣ�����ƣ����Ȳ�������; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --ר����Ϣ����     ר����ѯ�ѷ�����ϸҳ��
  PROCEDURE EXPERT_FEE_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2) IS
  
    CURSOR CU_DATA IS
      SELECT TRIM(A), TRIM(B), TRIM(C), TRIM(D)
        FROM SPM_IMPORT_TEMP_D
       WHERE TEMP_M_ID = P_BATCHCODE
         AND TO_NUMBER(ROW_NUMBER) >= 2
       ORDER BY TO_NUMBER(ROW_NUMBER);
    VALIDATE_A   VARCHAR2(2000);
    VALIDATE_B   VARCHAR2(2000);
    VALIDATE_C   VARCHAR2(2000);
    VALIDATE_D   VARCHAR2(2000);
    V_EXP_ID     NUMBER;
    FFYEAR       VARCHAR2(40);
    FFMONTH      VARCHAR2(40);
    USERORGID    NUMBER;
    BANKACOUNT   VARCHAR(100);
    OPENINGBANK  VARCHAR(100);
    INACOUNTPRO  VARCHAR(100);
    INACOUNTCITY VARCHAR(100);
  BEGIN
    OPEN CU_DATA;
    FETCH CU_DATA
      INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
    WHILE CU_DATA%FOUND LOOP
    
      IF VALIDATE_A IS NOT NULL THEN
        SELECT VI.VENDOR_ID
          INTO V_EXP_ID
          FROM SPM_CON_VENDOR_INFO VI
         WHERE VI.VENDOR_NAME = VALIDATE_A
           AND VI.VENDOR_CODE = VALIDATE_B
           AND VI.IS_BIDDING_VENDOR = 'Y';
      
        SELECT BI.BANK_ACOUNT,
               BI.OPENING_BANK,
               BI.ATTRIBUTE3,
               BI.ATTRIBUTE4
          INTO BANKACOUNT, OPENINGBANK, INACOUNTPRO, INACOUNTCITY
          FROM SPM_CON_BANK_ACOUNT_INFO BI
         WHERE BI.VENDOR_ID = V_EXP_ID;
      END IF;
      SELECT TO_CHAR(SYSDATE, 'yyyy') INTO FFYEAR FROM DUAL; --��
      SELECT TO_CHAR(SYSDATE, 'MM') INTO FFMONTH FROM DUAL; --�·ݣ�04��
      USERORGID := SPM_SSO_PKG.GETORGID;
      ---����ר��id exp_id����ϸ��
      INSERT INTO SPM_EXPERT_FEE_DETAIL
        (FEE_DETAIL_ID, --��ѯ�ѷ�����ϸ������
         FEE_MAIN_ID,
         EXP_ID, --ר��id
         FACT_AMOUNT, --ʵ�����  
         FF_YEAR,
         FF_MONTH,
         ORG_ID,
         OPENING_BANK,
         BANK_ACOUNT,
         IN_ACOUNT_PRO,
         IN_ACOUNT_CITY)
      VALUES
        (SPM_EXPERT_FEE_DETAIL_SEQ.NEXTVAL,
         F_TABLENAME,
         V_EXP_ID,
         VALIDATE_C,
         FFYEAR,
         FFMONTH,
         USERORGID,
         OPENINGBANK,
         BANKACOUNT,
         INACOUNTPRO,
         INACOUNTCITY);
      FETCH CU_DATA
        INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
    END LOOP;
    CLOSE CU_DATA;
    SPM_EXPERT_FEE_MONEY_AMOUNT(ID => F_TABLENAME);
    COMMIT;
  END;

  -- �ɷѹ��������غ���
  --�ɷѹ���htmlչ��
  FUNCTION SPM_EXPERT_FEE_INFO_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG      VARCHAR2(20000);
    V_BID_ID NUMBER;
    WCODE    VARCHAR2(20);
    V_STATUS VARCHAR2(10);
    V_REC_ID NUMBER(15);
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_BID_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    SELECT T.STATUS
      INTO V_STATUS
      FROM SPM_EXPERT_FEE T, SPM_CON_WF_ACTIVITY W
     WHERE T.FEE_MAIN_ID = W.JOB_ID
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
  
    IF (V_STATUS = 'C' OR V_STATUS = 'H') AND
       V_REC_ID = SPM_SSO_PKG.GETUSERID THEN
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmExpertFee/edit/' ||
                                                       V_BID_ID,
                                                       P_KEY) ||
             '''>�鿴����</a><br>';
    ELSE
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                     'WF_URL=/spmExpertFee/edit/' ||
                                                     V_BID_ID,
                                                     P_KEY) ||
             '''>�鿴����</a><br>';
    END IF;
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�ɷѹ������̷���
  PROCEDURE SPM_EXPERT_FEE_INFO_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̷����,��ҵ���״̬����Ϊ��Ӧ�ڵ�
    UPDATE SPM_EXPERT_FEE
       SET STATUS   = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                     PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE FEE_MAIN_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --�ɷѹ���������׼�ص�����
  PROCEDURE SPM_EXPERT_FEE_INFO_PZ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2) AS
    V_P_POSITION_ID NUMBER;
    V_P_ID          NUMBER;
    V_STATUS        VARCHAR2(20);
  BEGIN
  
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(P_KEY,
                                         P_OTYPE_CODE,
                                         'SPM_EXPERT_FEE',
                                         'STATUS',
                                         'JOB_ID',
                                         'ID');
  
    --��ȡҵ�������ID,����״̬
    BEGIN
      SELECT S.FEE_MAIN_ID, NVL(S.STATUS, 'A')
        INTO V_P_ID, V_STATUS
        FROM SPM_EXPERT_FEE S
       WHERE S.ITEM_KEY = P_KEY
         AND ROWNUM < 2;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE;
    END;
  
    -- if v_status='A' or v_status='F' or v_status='G' then
    --������ǩ
    -- wf_engine.SetItemAttrText('SPMWF',
    /* P_Key,
    'ATT_PERCENT',
    100);*/
  
    /**
    ��ָ̬��������Աʱ ��ɾ���ض����õ�������Ա
    ��ָ��������ĳЩ�����ڵ�����Ҫ���ö�̬ѡ��
    ��Ҫ��̬ѡ������Աʱ���ô˴���
    **/
    -- delete ccm_wf_user_group cg
    --   where cg.itemkey = P_Key;
  
    --else
    --ȡ����ǩ
    /*wf_engine.SetItemAttrText('SPMWF',
                             P_Key,
                             'ATT_PERCENT',
                             0.1);
    
    end if;      */
  
  END SPM_EXPERT_FEE_INFO_PZ;

  --�ɷѹ�������֪ͨ���ɻص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.GENERATE_HISTORY_INFO(P_NOTIFID,
                                               P_ITEMKEY,
                                               P_OTYPE_CODE,
                                               'SPM_EXPERT_FEE',
                                               'FEE_MAIN_ID',
                                               'STATUS',
                                               'ITEM_KEY',
                                               'D',
                                               'E');
  END SPM_EXPERT_FEE_INFO_TZSC;

  --�ɷѹ�������֪ͨ����ǰ���ص�
  PROCEDURE SPM_EXPERT_FEE_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
    L_NID        NUMBER;
    V_BID_ID     NUMBER; --����
    V_INFO       VARCHAR2(1000);
    V_STATUS     VARCHAR2(40);
    V_EBS_STATUS VARCHAR2(40);
    V_ACC_ID     VARCHAR2(40);
    PAYAMOUNT    NUMBER;
  BEGIN
    /*    l_nid  := WF_ENGINE.context_nid;
    v_info := wf_notification.GetAttrText(l_nid, 'ATT_AUDIT');*/
  
    --ͨ��p_key������
    SELECT W.JOB_ID, W.STATUS, F.EBS_STATUS, F.CASH_FLOW_ID
      INTO V_BID_ID, V_STATUS, V_EBS_STATUS, V_ACC_ID
      FROM SPM_CON_WF_ACTIVITY W, SPM_EXPERT_FEE F
     WHERE W.JOB_ID = F.FEE_MAIN_ID
       AND W.ITEM_KEY = P_KEY;
    SELECT SUM(D.PAY_AMOUNT)
      INTO PAYAMOUNT
      FROM SPM_EXPERT_FEE_DETAIL D
     WHERE D.FEE_MAIN_ID = V_BID_ID;
    IF P_OPER_RESULT = 'Y' THEN
      --��׼ʱ                 
      -- ���̴ﵽ��֤�������δ���м����������������׼
      IF V_STATUS = 'C' THEN
        IF PAYAMOUNT = 0 OR V_ACC_ID IS NULL OR V_EBS_STATUS <> 'S' THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ',
                                '�ñ�������δ���м��㡢����¼�롢����ƾ֤�Ȳ���');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      IF V_EBS_STATUS = 'S' THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '�ñ������ѳɹ�ִ������ƾ֤���������ܲ���');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_EXPERT_FEE_WF_TZCL_BEFORE;

  --�ɷѹ�������֪ͨ����(��)�ص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT);
  END SPM_EXPERT_FEE_INFO_TZH;

  --�ɷѹ������̻�ǩ�ڵ���׼�ص�������֪ͨ�����
  PROCEDURE SPM_EXPERT_FEE_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(P_KEY,
                                         P_OTYPE_CODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         'STATUS',
                                         'JOB_ID',
                                         'ID');
  END SPM_EXPERT_FEE_INFO_TZ_AFTER;

  --�ɷѹ�������ͨ���ص�
  PROCEDURE SPM_EXPERT_FEE_INFO_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'E' WHERE ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  END;

  --�ɷѹ����ػص�
  PROCEDURE SPM_EXPERT_FEE_INFO_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'D' WHERE ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  
  END;

  --ר����Ϣ������Ϣ��֤validate    ר����Ϣ�б�ҳ��
  PROCEDURE EXPERT_INFO_VALIDATA(P_TABLENAME VARCHAR2,
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
             TRIM(Q)
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
    VALIDATE_P       VARCHAR2(2000);
    VALIDATE_Q       VARCHAR2(2000);
    V_IDENTITY       VARCHAR2(50);
    VALIDATE_NUMBER  NUMBER;
    VALIDATE_NUMBER1 NUMBER;
    VALIDATE_NUMBER2 NUMBER;
    VALIDATE_NUMBER3 NUMBER;
    VALIDATE_NUMBER4 NUMBER;
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
           VALIDATE_Q;
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '����' OR VALIDATE_B <> '���֤��' OR VALIDATE_C <> '�����˺�' OR
         VALIDATE_D <> '������' OR VALIDATE_E <> '�տ��˺�ʡ��' OR
         VALIDATE_F <> '�տ��˺ŵ���' THEN
        P_MSG := '�������ݵ��ֶ��������ϸ�ʽ';
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
             VALIDATE_Q;
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
        IF VALIDATE_B IS NOT NULL THEN
          SELECT REPLACE(VALIDATE_B, ' ', '') INTO V_IDENTITY FROM DUAL;
          SELECT COUNT(VENDOR_CODE)
            INTO VALIDATE_NUMBER
            FROM SPM_CON_VENDOR_INFO VI
          /*where vi.vendor_name = validate_a and */
           WHERE VI.VENDOR_CODE = V_IDENTITY
             AND VI.IS_BIDDING_VENDOR = 'Y';
          IF VALIDATE_NUMBER > 0 THEN
            IF MSG_H IS NULL THEN
              MSG_H := CU_DATA%ROWCOUNT;
            ELSE
              MSG_H := MSG_H || ',' || CU_DATA%ROWCOUNT;
            END IF;
          END IF;
        END IF;
        /* if validate_c is not null then
          select SPM_IMPORT_XLS_PKG.IS_NUMBER(validate_c)
            into validate_number1
            from DUAL;
          if validate_number1 = 0 then
            if msg_e is null then 
              msg_e := cu_data%rowcount;
            else
              msg_e := msg_e || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;     */
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
               VALIDATE_Q;
      END LOOP;
      CLOSE CU_DATA;
    
      IF MSG_A IS NOT NULL THEN
        MSG_A := MSG_A || '�� ��������Ϊ��;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '�� ���֤�Ų���Ϊ��;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '�� �����˺Ų���Ϊ��;  ';
      END IF;
      /*if msg_d is not null then
        msg_d:= msg_d ||'�� �������Ʋ���Ϊ��; ';
      end if;*/
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '�� �����в���Ϊ��;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '�� �տ��˺�ʡ�ݲ���Ϊ��; ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '�� �տ��˺ŵ��в���Ϊ��;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '�� ��ר����ר�ҿ����Ѵ��ڣ������ظ�����;  ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --ר����Ϣ����    ר����Ϣ�б�ҳ��
  PROCEDURE EXPERT_INFO_IMPORT(P_TABLENAME VARCHAR2,
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
             TRIM(J)
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
    V_EXP_ID    NUMBER;
    FFYEAR      VARCHAR2(40);
    FFMONTH     VARCHAR2(40);
    SETUPDATE   VARCHAR2(50);
    USERORGID   NUMBER;
    USERID      NUMBER;
    SETUPPERSON NUMBER;
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
           VALIDATE_J;
    WHILE CU_DATA%FOUND LOOP
    
      SELECT SPM_CON_VENDOR_INFO_SEQ.NEXTVAL INTO V_EXP_ID FROM DUAL; --��Ӧ������
      SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss')
        INTO SETUPDATE
        FROM DUAL; --��������
      USERID := SPM_SSO_PKG.GETUSERID;
      SELECT T.PERSON_ID
        INTO SETUPPERSON
        FROM SPM_EAM_ALL_PEOPLE_V T
       WHERE T.USER_ID = USERID;
      USERORGID := SPM_SSO_PKG.GETORGID;
      ---����ר��id exp_id����ϸ��       fee_main_id,
    
      INSERT INTO SPM_CON_VENDOR_INFO
        (VENDOR_ID, --��Ӧ����������
         VENDOR_CODE, --���֤��
         SETUP_DATE, --����ʱ��  
         VENDOR_NAME, --����
         SETUP_PERSON, --������
         ORG_ID,
         ATTRIBUTE1, --ͬ��״̬ A
         VENDOR_ADDRESS, --��ַ
         IS_BIDDING_VENDOR --�Ƿ�Ϊר��
         )
      VALUES
        (V_EXP_ID,
         VALIDATE_B,
         TO_DATE(SETUPDATE, 'yyyy/mm/dd hh24:mi:ss'),
         VALIDATE_A,
         SETUPPERSON,
         USERORGID,
         'A',
         'OFFICE',
         'Y');
      INSERT INTO SPM_CON_BANK_ACOUNT_INFO
        (ACOUNT_ID, --����
         VENDOR_ID, --��Ӧ������
         BANK_ACOUNT, --�˻�
         OPENING_BANK, --������  
         ATTRIBUTE1, --�˻�
         --ATTRIBUTE2,--��������
         ATTRIBUTE3, --�տ��˺�ʡ��
         ATTRIBUTE4, --�տ��˺ŵ���
         ORG_ID)
      VALUES
        (SPM_CON_BANK_ACOUNT_INFO_SEQ.NEXTVAL,
         V_EXP_ID,
         VALIDATE_C,
         VALIDATE_D,
         VALIDATE_C,
         --validate_d,
         VALIDATE_E,
         VALIDATE_F,
         USERORGID);
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
             VALIDATE_J;
    END LOOP;
    CLOSE CU_DATA;
    COMMIT;
  END;

  --ר����ѯ����ϸ�������ݲ������븶����
  PROCEDURE SPM_EXPERT_FEE_MONEY_AMOUNT(ID NUMBER) AS
  
    V_AMOUNT NUMBER;
  BEGIN
    --����ܽ��
    SELECT (NVL((SELECT SUM(ROUND(D.FACT_AMOUNT, 2))
                  FROM SPM_EXPERT_FEE_DETAIL D
                 WHERE D.FEE_MAIN_ID = F.FEE_MAIN_ID),
                0))
      INTO V_AMOUNT
      FROM SPM_EXPERT_FEE F
     WHERE F.FEE_MAIN_ID = ID;
  
    --�޸�ר����ѯ�ѵ����븶����
    UPDATE SPM_EXPERT_FEE F
       SET F.MONEY_AMOUNT = V_AMOUNT
     WHERE F.FEE_MAIN_ID = ID;
  END;

  --�ʽ�ƻ���� �Զ�ȡֵ
  PROCEDURE SPM_CAPITAL_GET_VAL(DEPTCODE       VARCHAR2,
                                ORGID          VARCHAR2,
                                CAPITALBALANCE OUT NUMBER, --���¶����ȱ
                                RECEIVEAMOUNT  OUT NUMBER, --�����տ���
                                NONPAYCOST     OUT NUMBER, --���·Ǹ��ֳɱ�
                                REPORTPROFIT   OUT NUMBER, --���±�������
                                TAXAMOUNT      OUT NUMBER) IS
    --����Ӧ��˰
    CAPITALQUOTA      NUMBER; --�ʽ�ƻ����
    PAYAMOUNT         NUMBER; --���¸�����
    THISMONTHBALANCE  NUMBER; --���½����
    SHADDAMOUNT       NUMBER; --�ϻ����Ӷ�
    SYXXAMOUNT        NUMBER; --����������
    SYJXAMOUNT        NUMBER; --���½�����
    EXCHANGEREC       NUMBER; --����Ӧ�ս��
    EXCHANGEPAY       NUMBER; --����Ӧ�����
    REPORTPROFITDF      NUMBER; --�������� ����
    REPORTPROFITJF      NUMBER; --�������� �跽
    V_QUOTAMONTH_LAST VARCHAR2(10); --��һ�� 2018-06
    V_QUOTAMONTH      VARCHAR2(10); --��ǰ�� 2018-07
    V_MONTHLAST       VARCHAR2(10); --��һ�� -06
    V_YEAR            VARCHAR2(10); --��ǰ�� -2018
    FIRSTMONTH        VARCHAR2(20); --�����³� 2018-07-01
    ENDMONTH          VARCHAR2(20);--����ĩ 2018-07-31
    V_NUMBER1         NUMBER;
    V_NUMBER2         NUMBER;
    V_CAPITALID       NUMBER(15);
    V_ORGCODE         VARCHAR2(20);
    V_VALTYPE1        VARCHAR2(50);--ȡֵ������  �Ǹ���
    V_VALTYPEDF        VARCHAR2(50);--ȡֵ������  �������� ����
    V_VALTYPEJF        VARCHAR2(50);--ȡֵ������  �������� �跽
    V_VALTYPE3        VARCHAR2(50);--ȡֵ������  ��������
    V_VALTYPE4        VARCHAR2(50);--ȡֵ������  ���½���
    V_SMALLCODE       SPM_TYPE_TBL := SPM_TYPE_TBL();
    V_KMZH            SPM_TYPE_TBL := SPM_TYPE_TBL(); --�Ǹ��ֳɱ��Ŀ�Ŀ���
    V_KMBBLR          SPM_TYPE_TBL := SPM_TYPE_TBL(); --���±�������Ŀ�Ŀ���
    V_KMBBLRDF        SPM_TYPE_TBL := SPM_TYPE_TBL(); --���±�������Ĵ�����Ŀ���
    V_KMBBLRJF        SPM_TYPE_TBL := SPM_TYPE_TBL(); --���±�������Ľ跽��Ŀ���
    V_KMYNSXX         SPM_TYPE_TBL := SPM_TYPE_TBL(); --����Ӧ��˰�����������Ŀ���
    V_KMYNSJX         SPM_TYPE_TBL := SPM_TYPE_TBL(); --����Ӧ��˰�����½����Ŀ���
  BEGIN
    SELECT TO_CHAR(SYSDATE, 'yyyy-mm') INTO V_QUOTAMONTH FROM DUAL;--��ǰ���� 2018-07
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL;--��һ���� 2018-06
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),-1), 'mm') INTO V_MONTHLAST FROM DUAL;--��һ�� 06*/
    SELECT TO_CHAR(SYSDATE, 'yyyy') INTO V_YEAR FROM DUAL; --��ǰ�� 2018
  
    --add by ruankk  ��������ʱ�����ȡ�ò�׼��bug;
    IF V_MONTHLAST = '12' THEN
      V_YEAR := TO_CHAR(TO_NUMBER(V_YEAR) - 1);
    END IF;
  
    --�����³�  ��ĩ
    SELECT TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -2) + 1, 'yyyy-mm-dd'),
           TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -1), 'yyyy-mm-dd')
     INTO FIRSTMONTH,ENDMONTH
   FROM DUAL;
   
    --�������·�
  /*  SELECT TO_CHAR(TO_DATE(201802, 'yyyymm'), 'yyyy-mm')
      INTO V_QUOTAMONTH
      FROM DUAL; --��ǰ���� 2018-03
    SELECT TO_CHAR(ADD_MONTHS(TO_DATE(201802, 'yyyymm'), -1), 'mm')
      INTO V_MONTHLAST
      FROM DUAL; --3�µ���һ�� 02
    SELECT TO_CHAR(ADD_MONTHS(TO_DATE(201802, 'yyyymm'), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL; --2018-03�µ���һ���� 2018-02*/
  
    SELECT OU.SHORT_CODE
      INTO V_ORGCODE
      FROM HR_OPERATING_UNITS OU
     WHERE OU.ORGANIZATION_ID = ORGID;
    --���ݴ���code ��ѯ���µ�С���Ž����
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    --��ѯ�ò��ű����Ƿ�����ʽ�ƻ�
    SELECT COUNT(P.CAPITAL_ID)
      INTO V_NUMBER2
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.DEPT_CODE = DEPTCODE
       AND P.QUOTA_MONTH = V_QUOTAMONTH;
    IF V_NUMBER2 = 1 THEN
      --�Ѿ����
      RETURN;
    ELSE
      --��ȡ���µ��ʽ�ƻ���ȵı��½���� ���ϻ����ӽ��
      --�����ʽ�ƻ���ȵ����¶����ȱֵ = ���½����ȥ�ϻ�����
      SELECT COUNT(P.THIS_MONTH_BALANCE)
        INTO V_NUMBER1
        FROM SPM_CON_CAPITAL_PLAN P
       WHERE P.QUOTA_MONTH = V_QUOTAMONTH_LAST
         AND P.DEPT_CODE = DEPTCODE;
      IF V_NUMBER1 = 0 THEN
        --�޸ò��ŵ����µı��½����  Ĭ�ϱ���Ϊ0
        THISMONTHBALANCE := 0;
        SHADDAMOUNT :=0;
      ELSE
        SELECT P.THIS_MONTH_BALANCE,P.CAPITAL_ID
          INTO THISMONTHBALANCE,V_CAPITALID
          FROM SPM_CON_CAPITAL_PLAN P
         WHERE P.QUOTA_MONTH = V_QUOTAMONTH_LAST
           AND P.DEPT_CODE = DEPTCODE;
        SELECT COUNT(D.SHADD_AMOUNT) --��ѯ���ʽ�ƻ����Ƿ����ϻ����ӽ��
          INTO V_NUMBER2
          FROM SPM_CON_CAPITAL_PLAN_DEL D
         WHERE D.CAPITAL_ID = V_CAPITALID
           AND D.TYPE_CODE = 'SH';
        IF V_NUMBER2 = 0 THEN
          --���ϻ����Ӷ� Ĭ��Ϊ0
          SHADDAMOUNT := 0;
        ELSE
          SELECT SUM(D.SHADD_AMOUNT)
            INTO SHADDAMOUNT
            FROM SPM_CON_CAPITAL_PLAN_DEL D
           WHERE D.CAPITAL_ID = V_CAPITALID
             AND D.TYPE_CODE = 'SH';
        END IF;
      END IF;
      --���� ���¶����ȱֵ = ���½��� - �ϻ�����
      SELECT THISMONTHBALANCE - SHADDAMOUNT INTO CAPITALBALANCE FROM DUAL;
      --��ѯ �����տ���
      IF ORGID = 81 THEN
        SELECT NVL(SUM(R.MONEY_AMOUNT), 0) --���� ����Ӧ��
          INTO EXCHANGEREC
          FROM SPM_CON_RECEIPT R,SPM_CON_MONEY_REG G 
         WHERE R.MONEY_REG_ID = G.MONEY_REG_ID
           AND R.CREATION_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND R.CREATION_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND G.COLLECTION_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND G.COLLECTION_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND NVL(R.DATA_TYPE, 'YW') = 'YW'
           AND R.DEPT_ID IN (select T.ORGANIZATION_ID
                               from hr_all_organization_units t
                              WHERE T.ATTRIBUTE6 = DEPTCODE)
           --change by ruankk  �޸��ʽ�ƻ������տ�ȡ���߼�
           /*AND R.RECEIPT_DEPT IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
           AND R.EBS_STATUS = 'US'*/;
        SELECT NVL(SUM(I.INVOICE_AMOUNT), 0) --���� ����Ӧ��
          INTO EXCHANGEPAY
          FROM Spm_Con_Input_Invoice I
         WHERE I.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND I.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND I.EBS_DEPT_CODE IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --С���Ŷ�
           AND I.MONEY_REG_ID IS NOT NULL
           AND I.EBS_STATUS = 'US';
        SELECT EXCHANGEREC + EXCHANGEPAY INTO RECEIVEAMOUNT FROM DUAL;
      ELSE
        SELECT NVL(SUM(M.MONEY_ACCOUNT), 0)
        INTO RECEIVEAMOUNT
        FROM SPM_CON_MONEY_REG M
       WHERE M.COLLECTION_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
         AND M.COLLECTION_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
         --AND A.ATTRIBUTE3 IN (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE))
         AND M.ORG_ID =ORGID;
        END IF; 
      IF RECEIVEAMOUNT < 0 THEN 
        RECEIVEAMOUNT :=0;
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
      V_VALTYPE1 :='NONPAYCOST';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMZH,
                                                         V_ORGCODE,
                                                         DEPTCODE,
                                                         V_VALTYPE1,
                                                         ORGID)
        INTO NONPAYCOST
        FROM DUAL;
       IF NONPAYCOST < 0 THEN
         NONPAYCOST :=0;
        END IF;
      --��ѯ���±�������
      -- ����
      FOR I IN 1 .. 6 LOOP
        V_KMBBLRDF.EXTEND;
      END LOOP;         
      V_KMBBLRDF(1) := '410301';
      V_KMBBLRDF(2) := '410304';
      V_KMBBLRDF(3) := '410308';
      V_KMBBLRDF(4) := '410311';
      V_KMBBLRDF(5) := '410312';
      V_KMBBLRDF(6) := '410315';
      V_VALTYPEDF  := 'REPORTPROFITDF';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMBBLR,
                                                         V_ORGCODE,
                                                         DEPTCODE,
                                                         V_VALTYPEDF,
                                                         ORGID)
        INTO REPORTPROFITDF
        FROM DUAL;
        ---- �跽
      FOR I IN 1 .. 8 LOOP
        V_KMBBLRJF.EXTEND;
      END LOOP;         
      V_KMBBLRJF(1) := '410302';
      V_KMBBLRJF(2) := '410303';
      V_KMBBLRJF(3) := '410305';
      V_KMBBLRJF(4) := '410306';
      V_KMBBLRJF(5) := '410307';
      V_KMBBLRJF(6) := '410309';
      /*V_KMBBLRJF(7) := '410310';
      V_KMBBLRJF(8) := '410313';
      V_KMBBLRJF(9) := '410314';*/
      V_KMBBLRJF(7) := '410313';
      V_KMBBLRJF(8) := '410314';
      V_VALTYPEJF  := 'REPORTPROFITJF';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMBBLR,
                                                         V_ORGCODE,
                                                         DEPTCODE,
                                                         V_VALTYPEJF,
                                                         ORGID)
        INTO REPORTPROFITJF
        FROM DUAL;
         SELECT REPORTPROFITDF - REPORTPROFITJF INTO REPORTPROFIT FROM DUAL; --�������±�������
        IF REPORTPROFIT < 0 THEN 
          REPORTPROFIT := 0;
         END IF;
      --��ѯ����Ӧ��˰ 
      --��������      
      V_KMYNSXX.Extend;
      V_KMYNSXX(1) := '22210107';
      V_VALTYPE3   := 'TAXSYXX';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMYNSXX,
                                                         V_ORGCODE,
                                                         DEPTCODE,
                                                         V_VALTYPE3,
                                                         ORGID)
        INTO SYXXAMOUNT
        FROM DUAL;
      --���½���
      V_KMYNSJX.Extend;
      V_KMYNSJX(1) := '2221010101';
      V_VALTYPE4   := 'TAXSHJX';
      SELECT SPM_GZ_GZGL_INS_PKG.SPM_CAPITAL_FIND_AMOUNT(V_YEAR,
                                                         V_MONTHLAST,
                                                         V_MONTHLAST,
                                                         V_KMYNSJX,
                                                         V_ORGCODE,
                                                         DEPTCODE,
                                                         V_VALTYPE4,
                                                         ORGID)
        INTO SYJXAMOUNT
        FROM DUAL;
      SELECT SYXXAMOUNT - SYJXAMOUNT INTO TAXAMOUNT FROM DUAL; --��������Ӧ��˰��
       IF TAXAMOUNT < 0 THEN 
         TAXAMOUNT :=0;
        END IF;
    END IF;
  END SPM_CAPITAL_GET_VAL;

END SPM_GZ_INTGZINFO_PKG;
/
