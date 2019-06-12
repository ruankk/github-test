CREATE OR REPLACE PACKAGE "SPM_CON_CONTRACT_PKG"
/**
 * @author ������
 * @date 2017.08.23
 * @desc �����ͬ�������
 */
 AS

  /**
  * @author: ������
  * @date:2017.09.24
  * @desc : ��������,��������ʷ����������ʷ��¼�� ��ʱ����,�����Ż��쳣����
  * @param p_item_key ITEM_KEY
  * @param p_Otype_Code ����CODE
  * @param ass_table_name
  *        ҵ�������
  * @param ass_table_status
  *        ҵ���STATUS�ֶ�����,��д���ֶ����ƺ�,�ڻ���������й�����,�������ֶε�״̬
  * @param fk_name
  *        ���洢ҵ����������ֶ�,û�л����
  * @param ass_table_pkname
  *        ҵ��������ֶ�����
  */
  PROCEDURE SAVE_WF_HISTORY(P_ITEM_KEY       IN VARCHAR2,
                            P_OTYPE_CODE     VARCHAR2,
                            ASS_TABLE_NAME   IN VARCHAR2,
                            ASS_TABLE_STATUS IN VARCHAR2,
                            FK_NAME          IN VARCHAR2,
                            ASS_TABLE_PKNAME IN VARCHAR2,
                            CREDATE          IN VARCHAR2 DEFAULT 'CREATION_DATE');

  /**
  * @author : ������
  * @date : 2017.12.05
  * @desc : ֪ͨ���ɺ󴥷��Ļص�����(����)
  * @param p_notifid ֪ͨID
  * @param p_itemkey ����itemKey
  * @param p_Otype_Code ����Code
  * @param ass_table ҵ�������,�ڻ���������й�����,�������ֶε�״̬
  * @param ass_col_pkname ҵ���������
  * @param ass_col_status ҵ���״̬�ֶ�����
  * @param ass_col_itemkey ҵ���ITEM_KEY�ֶ�����
  * @param status_reject ���غ�����״̬
  * @param status_passed ͨ���������״̬
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
  --֪ͨ����󴥷��Ļص�����(����)
  PROCEDURE UPDATE_HISTORY_INFO(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --��ȡ��Ч��ͬ
  FUNCTION GET_EFFECTIVE_CONTRACT(CONID IN NUMBER) RETURN VARCHAR2;

  --��ȡ��Ч���Э���ͬ
  FUNCTION GET_EFFECTIVE_KJXY(CONID IN NUMBER) RETURN VARCHAR2;

  --��ȡ���̽ڵ��Ӧ��״̬����
  FUNCTION GET_WF_STATUS_BY_POSITION(P_OTYPE_CODE IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) RETURN VARCHAR2;
  --������ǩ
  PROCEDURE SPM_CON_START_HQ(P_KEY IN VARCHAR2, VPOSITOIN_ID IN NUMBER);
  --����ԭ��htmlչ��
  FUNCTION SPM_CON_REBUT_REASON_WF_HTML RETURN VARCHAR2;

  --����ԭ���ַ�����ȡ
  FUNCTION SUBSTR_STR_FOR_HT(V_STR VARCHAR2) RETURN VARCHAR2;

  --����ԭ����֤
  FUNCTION SPM_CON_REBUT_REASON_WF_VALI(V_STR VARCHAR2) RETURN VARCHAR2;

  --��ͬ�½�����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_CREATION_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�������������ص�
  PROCEDURE SPM_CON_HT_WF_CREATION_START(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --��ͬ�½����̱�����֤(֪ͨ����(ǰ)�ص�)
  PROCEDURE SPM_CON_HT_WF_CREATION_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CREATION_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --��ͬ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CREATION_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  /**
      ͨ������HTMLչ�֣�������¼���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_WF_CREATION_DIYHTML(P_KEY IN VARCHAR2,
                                          
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  /**
      ͨ������HTMLչ�֣��ӱ���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --��ͬ�½����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CREATION_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);

  --��ͬ�����������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_URGENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�������������ص�
  PROCEDURE SPM_CON_HT_WF_URGENT_START(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_URGENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_URGENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);

  --��ͬ�����½����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_URGENT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  --��ͬ��������HTMLչ�ֵĻص�
  FUNCTION SPM_CON_HT_WF_EFFECTIVE_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�������̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_VALID(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);

  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --��ͬ�������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_RYSZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --��ͬ��Ч����HTMLչ�ֵĻص�
  FUNCTION SPM_CON_HT_WF_EFFECT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ��Ч����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --��ͬ��Ч����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);
  --��ͬ��Ч���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_EFFECT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  ----��ͬ�����������HTMLչ�ֵĻص�
  FUNCTION SPM_CON_HT_WF_CHANGE_VOID_HTML(P_KEY        IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�����������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);

  --��ͬ�����������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZH(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --��ͬ����������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                           OTYPECODE    IN VARCHAR2,
                                           PPOSITION_ID IN NUMBER);

  --��ͬ������������HTMLչ�ֵĻص�
  FUNCTION SPM_CON_HT_WF_SEAL_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --��ͬ������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_SEAL_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --��ͬ������������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_SEAL_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);
  --��ͬ�����������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_SEAL_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER);

  --��ͬ��������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_VOID_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --��ͬ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_VOID_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --��ͬ�������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER);

  --������ͬ��������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_ORDER_VOID_HTML(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --������ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);

  --������ͬ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZH(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --��ͬ�������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_CHANGE_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ������̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_CHANGE_VALID(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --��ͬ�������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --��ͬ���֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);

  --��ͬ������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CHANGE_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --��ͬ��ֹ����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_SUSPEND_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ��ֹ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);

  --��ͬ��ֹ֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);

  --��ͬ��ֹ���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_SUSPEND_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);
  --��ͬ�ָ�����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_RECOVERY_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�ָ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --��ͬ�ָ�֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --��ͬ�ָ����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_RECOVERY_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);
  --��ͬ�鵵����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_ARCHIVED_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --��ͬ�鵵���������ص�����
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_START(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);
  --��ͬ�鵵���̽�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --��ͬ�鵵����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --��ͬ�鵵����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --��ͬ�鵵���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);
  --��ͬ�ر�����HTMLչ�ֵĻص�����
  FUNCTION SPM_CON_HT_WF_CLOSING_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ͬ�ر�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);

  --��ͬ�ر�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --��ͬ������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CLOSING_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);
  --����Ȩ�޵ĺ���(��Ŀ)
  FUNCTION SPM_CON_DATAPERMISSION_PROJECT(CID NUMBER) RETURN VARCHAR2;

  --����Ȩ�޵ĺ���(����)
  FUNCTION SPM_CON_DATAPERMISSION_DEPT(CID NUMBER) RETURN VARCHAR2;

  --�жϵ�ǰitemkey��������ʷ�Ƿ����SPM������ʷ�������ظ���������
  FUNCTION JUDGE_IS_EXIST_HISTORY(P_KEY IN VARCHAR2, P_DATE IN DATE)
    RETURN VARCHAR2;

  --��Ӧ�̲鿴����ص�
  FUNCTION SPM_CON_VENDOR_VIEW_INFO(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --��Ӧ���ύ��ע�ᣬ׼�룬ս�ԣ����ʱ������Ӧ��״̬ת��Ϊ������С�AP ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --��Ӧ�����ͨ���󣬽���Ӧ�̵�״̬����Ϊ������ˡ�E ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);

  --��Ӧ����˱����غ󣬸��¹�Ӧ��״̬Ϊ�����ء�D ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);

  --��Ӧ�������˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_VENDOR_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --��Ӧ������ͨ���󣬸��¹�Ӧ�̵ĵȼ�
  PROCEDURE SPM_CON_VENDOR_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);
  --��Ӧ������֪ͨ���ɻص�
  PROCEDURE SPM_CON_VENDOR_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                     
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);

  --��Ӧ������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_VENDOR_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --��Ӧ������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_VENDOR_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                     
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);

  --��Ӧ������������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_VENDOR_YEAR_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --�ͻ�����������֪ͨ���ɻص�
  PROCEDURE SPM_CON_CUST_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                   
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --�ͻ�����������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CUST_YEAR_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);

  --�ͻ���ˡ��鿴���顱�ص�
  FUNCTION SPM_CON_CUST_VIEW_INFO(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --�ͻ��ύ��ע�ᣬ׼�룬ս�ԣ����ʱ�����ͻ�״̬ת��Ϊ������С�AP ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --�ͻ����ͨ���󣬽��ͻ���״̬����Ϊ������ˡ�E ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);

  --�ͻ���˱����غ󣬸��¿ͻ�״̬Ϊ�����ء�D ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);

  --�ͻ������˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_CUST_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --�ͻ�����ͨ���󣬸��¿ͻ��ĵȼ�
  PROCEDURE SPM_CON_CUST_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�������ɹ�Ӧ��������
  PROCEDURE SPM_CON_PRODUCE_YEAR_REVIEW;

  --�տ�����������HTML��Ϣչ��
  FUNCTION CLS_RECEIPT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --�����ƻ�ά���������������󣬽���Ӧ������״̬����Ϊ��goods_wf_status Ϊ1
  PROCEDURE SET_GOODS_WF_STATUS_TO_1(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER);

  --���̹�������htmlչ��
  FUNCTION CLS_CON_ENG_WF_HTML(P_KEY IN VARCHAR2, POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_ENG_TZSC(P_NOTIFID    IN VARCHAR2,
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2);

  --��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_ENG_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2);
  --���̹����������̷���
  PROCEDURE SPM_CON_WF_ENG_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER);
  --���̲��ػص�
  PROCEDURE SPM_CON_WF_ENG_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);
  --����������׼�ص�
  PROCEDURE SPM_CON_WF_ENG_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2);
  --��������ͨ���ص�
  PROCEDURE SPM_CON_WF_ENG_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --��Ŀ��������htmlչ��
  FUNCTION CLS_CON_PROJECT_WF_HTML(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --��Ŀ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_PROJECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);
  --��Ŀ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PROJECT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --��Ŀ�����������̷���
  PROCEDURE SPM_CON_WF_PROJECT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER);
  --��Ŀ���ػص�
  PROCEDURE SPM_CON_WF_PROJECT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --��Ŀ������׼�ص�
  PROCEDURE SPM_CON_WF_PROJECT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2);
  --��Ŀ����ͨ���ص�
  PROCEDURE SPM_CON_WF_PROJECT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --��Ʊ��Ʊ����htmlչ��
  FUNCTION SPM_CON_RETURN_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --��Ʊ��Ʊ������������ͨ���󣬽���Ӧ��Ʊ��״̬����Ϊ�����˻ء�R��
  PROCEDURE SET_INVOICE_STATUS_TO_R(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);

  --Ԥ���Ʊ��������htmlչ��
  FUNCTION SPM_CON_IMP_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --��ѯԤ������ý�ʣ���� - ����״̬��Ԥ���������
  FUNCTION SPM_CON_QUERY_LOCKED_MONEY(RECEIPT_ID IN NUMBER) RETURN NUMBER;

  --���Ʊͨ����˺󣬽��������ݺ�����Ԥ�տ��д��Ԥ�տ�ʣ������
  PROCEDURE SET_RESIDUAL_AMOUNT(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --Ͷ�걣֤����������htmlչ��
  FUNCTION SPM_CON_BID_DEPOSIT_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --Ͷ�걣֤������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_BID_DEPOSIT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --Ͷ�걣֤������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_BID_DEPOSIT_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --Ͷ�걣֤���ύ����ʱ��
  /*procedure spm_con_bid_deposit_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/

  --Ͷ�걣֤������������׼�ص�����
  /*PROCEDURE spm_con_bid_deposit_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/

  --Ͷ�걣֤�������������ͨ���ص�
  /*procedure spm_con_bid_deposit_wf_TG(itemkey   in varchar2,
  otypecode in varchar2);*/
  --Ͷ�걣֤���������̲���ʱ
  /*procedure spm_con_bid_deposit_wf_BH(itemkey   in varchar2,
  otypecode in varchar2); */

  --�¶��ո���ƻ�����htmlչ��
  FUNCTION SPM_CON_MONTH_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�¶��ո���ƻ��������̷���
  /*procedure spm_con_month_plan_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --�¶��ո���ƻ�����������׼�ص�����
  PROCEDURE SPM_CON_MONTH_PLAN_WF_PZ(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_MONTH_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);
  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ����ǰ��
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --�¶��ո���ƻ���������ͨ���ص�
  /*procedure spm_con_month_plan_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --�¶��ո���ƻ������ػص�
  PROCEDURE SPM_CON_MONTH_PLAN_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);

  --�¶ȼƻ����ܹ���htmlչ��
  FUNCTION SPM_CON_MONTHGATHER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�¶ȼƻ����ܹ���������׼�ص�����
  PROCEDURE SPM_CON_MONTHGATHER_WF_PZ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_MONTHGATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ����ǰ��
  PROCEDURE SPM_CON_MONTHGATH_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_MONTHGATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --�¶ȼƻ����ܹ����ػص�
  PROCEDURE SPM_CON_MONTHGATHER_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�ܶ��ո���ƻ�����htmlչ��
  FUNCTION SPM_CON_WEEK_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --�ܶ��ո���ƻ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_WEEK_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);
  --�ܶ��ո���ƻ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_WEEK_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);
  --�ܶ��ո���ƻ��������̷���
  /*procedure spm_con_week_plan_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --�ܶ��ո���ƻ�����������׼�ص�����
  /*PROCEDURE spm_con_week_plan_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --�ܶ��ո���ƻ���������ͨ���ص�
  /*procedure spm_con_week_plan_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --�ܶ��ո���ƻ������ػص�
  /*procedure spm_con_week_plan_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --�ܶȼƻ����ܹ���htmlչ��
  FUNCTION SPM_CON_WEEK_GATHER_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�ܶȼƻ����ܹ�������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_WEEK_GATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --�ܶȼƻ����ܹ�������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_WEEK_GATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --Ͷ�����htmlչ��
  FUNCTION SPM_CON_BID_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --Ͷ��������̷���
  /*procedure spm_con_bid_info_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --Ͷ��������̻�ǩ�ص�����
  PROCEDURE SPM_CON_BID_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);
  --Ͷ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_BID_INFO_WF_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --Ͷ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_BID_INFO_WF_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --Ͷ��������̲�����֤�ص�������֪ͨ����ǰ��
  /*PROCEDURE spm_con_bid_info_wf_TZCL_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --Ͷ���������ͨ���ص�
  PROCEDURE SPM_CON_BID_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --Ͷ������ػص�
  /*procedure spm_con_bid_info_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --Ͷ������������֪ͨ�ص�����(֪ͨ���ɺ�)
  PROCEDURE SPM_CON_BID_URGENT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);
  --Ͷ������������֪ͨ�ص�������֪ͨ�����
  /*PROCEDURE spm_con_bid_urgent_TZCL_AFTER(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);  */

  --Ͷ������������ͨ���ص�
  PROCEDURE SPM_CON_BID_URGENT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --Ͷ�����������ػص�
  /*procedure spm_con_bid_urgent_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2); */
  --Ͷ������б�ȷ�����̷���
  PROCEDURE SPM_CON_BID_CONFIRM_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  --Ͷ������б�ȷ������֪ͨ�ص�����(֪ͨ���ɺ�)
  PROCEDURE SPM_CON_BID_CONFIRM_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --Ͷ������б�ȷ��������׼�ص�����
  /*PROCEDURE spm_con_bid_confirm_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --Ͷ����������б�ȷ��ͨ���ص�
  /*procedure spm_con_bid_confirm_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --Ͷ������б�ȷ�ϲ��ػص�
  PROCEDURE SPM_CON_BID_CONFIRM_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�ո���ƻ�ά������htmlչ��
  FUNCTION SPM_CON_CLAUSE_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�ո���ƻ�ά���������̷���
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --�ո���ƻ�ά����������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --�ո���ƻ�ά����������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --�ո���ƻ�ά������������׼�ص�����
  /* PROCEDURE spm_con_clause_plan_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --�ո���ƻ�ά����������ͨ���ص�
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�ո���ƻ�ά�������ػص�
  /*procedure spm_con_clause_plan_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/

  --�������ӹ���htmlչ��
  FUNCTION SPM_CON_HANDOV_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --������������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_HANDOV_INFO_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);

  --������������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_HANDOV_INFO_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);

  --�������ӹ������̻�ǩ�ص�����
  PROCEDURE SPM_CON_HANDOV_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);

  --������������
  FUNCTION CLS_PAYMENT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE SALES_ORDER_PERSON_PR(P_KEY                  VARCHAR2,
                                  POTYPE_CODE            VARCHAR2,
                                  VGROUP_ID              NUMBER,
                                  VPOSITION_STRUCTURE_ID NUMBER,
                                  VPOSITOIN_ID           VARCHAR2);

  FUNCTION SPM_GET_FIRST_POSITION_ID(P_TABLE_NAME VARCHAR2,
                                     P_OTYPE_CODE VARCHAR2) RETURN VARCHAR2;

  --��ȡ�������̵ĵ�һ������positionid
  FUNCTION SPM_CON_GET_FIRST_POSITION_ID(P_KEY       IN VARCHAR2,
                                         POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --���planid
  FUNCTION GET_CHECK_POSITION_STRU(POTYPE_CODE       IN VARCHAR2,
                                   PPOSITION_STRU_ID IN NUMBER,
                                   PITEMKEY          IN VARCHAR2,
                                   PITEMKEYNAME      IN VARCHAR2)
    RETURN VARCHAR2;
  --���۶������û�ǩ
  PROCEDURE SETISCOUNTERSIGNFORPROREPORT(P_KEY        IN VARCHAR2,
                                         POTYPE_CODE  IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2);
  --��ͬģ���������̷���
  PROCEDURE SPM_CON_WF_TEMPLATE_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER);
  --��ͬģ������htmlչ��
  FUNCTION CLS_CON_TEMPLATE_WF_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --��ͬģ�岵�ػص�
  PROCEDURE SPM_CON_WF_TEMPLATE_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);
  --��ͬģ��������׼�ص�
  PROCEDURE SPM_CON_WF_TEMPLATE_PZ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);
  --��ͬģ������ͨ���ص�
  PROCEDURE SPM_CON_WF_TEMPLATE_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);
  --�½�������������
  FUNCTION CLS_BACKLETTER_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�½������������̷���
  PROCEDURE CLS_BACKLETTER_INFO_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --�½��������ػص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�½�����������׼�ص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_PZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);
  --�½���������ͨ���ص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --�յ�������������
  FUNCTION CLS_BACKLETTER_RECEIVE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�յ����������������̷���
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);
  --�յ��������ػص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --�յ�����������׼�ص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2);
  --�յ���������ͨ���ص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --����֤��������
  FUNCTION CLS_CON_CREDIT_WF_HTML(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --����֤�������̷���
  PROCEDURE CLS_CON_CREDIT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER);
  --����֤���ػص�
  PROCEDURE CLS_CON_CREDIT_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --����֤������׼�ص�
  PROCEDURE CLS_CON_CREDIT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2);
  --����֤����ͨ���ص�
  PROCEDURE CLS_CON_CREDIT_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --����֤������������
  FUNCTION CLS_CREDIT_PAY_WF_HTML(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --����֤�����������̷���
  PROCEDURE CLS_CREDIT_PAY_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER);
  --����֤����ػص�
  PROCEDURE CLS_CREDIT_PAY_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --����֤����������׼�ص�
  PROCEDURE CLS_CREDIT_PAY_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2);
  --����֤��������ͨ���ص�
  PROCEDURE CLS_CREDIT_PAY_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --�����տ��������
  FUNCTION CLS_CREDIT_RECEIPT_WF_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�����տ�������̷���
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER);
  --�����տ���ػص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --�����տ������׼�ص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2);
  --�����տ����ͨ���ص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);

  --��ⵥ����htmlչ��
  FUNCTION CLS_WAREHOUSE_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --���ⵥ����htmlչ��
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --�����ƻ�����htmlչ��
  FUNCTION CLS_GOODS_PLAN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                        POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --�˻�������htmlչ��
  FUNCTION CLS_SALES_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --�ͻ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CUST_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --�ͻ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CUST_INFO_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);
  --�����½�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                         
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);

  --�����½�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --�����յ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_RECEIVE_TZSC(P_NOTIFID IN VARCHAR2,
                                 
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);

  --�����յ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_RECEIVE_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --����֤����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_TZSC(P_NOTIFID IN VARCHAR2,
                                
                                P_ITEMKEY    IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2);

  --����֤����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2);
  --����֤��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_PAY_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --����֤����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_PAY_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);
  --�����տ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZSC(P_NOTIFID IN VARCHAR2,
                                        
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --�����տ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  --��ⵥ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_WAREHOUSE_TZSC(P_NOTIFID IN VARCHAR2,
                                   
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --��ⵥ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_WAREHOUSE_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);

  --���ⵥ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_ODO_TZSC(P_NOTIFID IN VARCHAR2,
                             
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2);

  --���ⵥ����֪ͨ����(ǰ)�ص�
  PROCEDURE SPM_CON_ODO_TZCL(P_KEY         IN VARCHAR2,
                             P_OTYPE_CODE  IN VARCHAR2,
                             P_NOTIFID     IN VARCHAR2,
                             P_OPER_RESULT IN VARCHAR2);

  --���ⵥ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_ODO_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2);

  --�����ƻ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_GOODS_PLAN_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --�����ƻ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_GOODS_PLAN_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --�˻�������֪ͨ���ɻص�
  PROCEDURE SPM_CON_SALES_RETURN_TZSC(P_NOTIFID IN VARCHAR2,
                                      
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --�˻�������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_SALES_RETURN_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);
  --Ԥ���Ʊ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);
  --Ԥ���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --������������ͨ���ص�
  PROCEDURE SPM_CON_PAYMENT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --���������������ػص�
  PROCEDURE SPM_CON_PAYMENT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);
  --��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --��������֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_PAYMENT_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --���Ʊ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);
  --���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  --���Ʊ��Ʊ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_RETURN_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);
  --���Ʊ��Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_RETURN_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  --��ͬ�������̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_TRANS_VALID(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --��ͬ�����½�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_TRANS_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_TRANS_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  PROCEDURE SPM_CON_OUTPUT_INVOICE_RY(V_P_KEY                 VARCHAR2,
                                      P_OTYPE_CODE            VARCHAR2,
                                      V_GROUP_ID              NUMBER,
                                      V_POSITION_STRUCTURE_ID NUMBER,
                                      V_POSITION_ID           VARCHAR2);
  --��Ӧ���Ƿ�ͬ��ebs
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2;

  --�����˻�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_OR_ACCOUNT_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --�����˻�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_OR_ACCOUNT_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --���Ʊ����ͨ���ص�
  PROCEDURE SPM_CON_OUTPUT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --�����˻��鿴����ص�
  FUNCTION SPM_CON_OR_ACCOUNT_INFO(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  /*���Ʊ�������ػص�*/
  PROCEDURE SPM_CON_OUTPUT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --�ʽ����취��������HTMLչ��
  FUNCTION SPM_CON_PLAN_PAYMENT_WF_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --�ʽ����취�������������ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_QD(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    V_POSITION_ID IN VARCHAR2);

  --�ʽ����취�������̲��ػص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_BH(P_KEY        IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);
  --�ʽ����취������������ͨ���ص��¼�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);

  --�ʽ����취��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --�ʽ����취��������֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_WF_TZCL(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --�ʽ����취��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);
  /**
      ��������HTMLչ�ֻص��¼�
      by mcq
      20180810
  */
  FUNCTION SPM_CON_PLAN_PAYMENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  /**
      ͨ������HTMLչ�֣�������¼���
      by mcq
      20180810
  */
  FUNCTION SPM_WF_RECORD_HTML(P_KEY IN VARCHAR2, P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  /**
      ͨ������HTMLչ�֣�ҵ����Ի�����
      by mcq
      20180810
  */
  FUNCTION SPM_WF_TEMPLATE_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  /**
      ͨ������HTMLչ�֣��ӱ���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_WF_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --��Ʊ���������ص�
  PROCEDURE SPM_CON_RETURN_INVOICE_QD(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      V_POSITION_ID IN VARCHAR2);

  --��Ʊ���̲��ػص�
  PROCEDURE SPM_CON_RETURN_INVOICE_BH(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --��Ʊ��������ͨ���ص��¼�
  PROCEDURE SPM_CON_RETURN_INVOICE_TG(P_KEY     IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --���Ʊ�鿴����ص�
  FUNCTION SPM_CON_INPUT_INVOICE_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --���Ʊ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);
  --���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --���Ʊ����֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZCL(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
END SPM_CON_CONTRACT_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_CONTRACT_PKG" AS

  /**
  * @author: ������
  * @date:2017.09.24
  * @desc : ��������,��������ʷ����������ʷ��¼�� ��ʱ����,�����Ż��쳣����
  * @param p_item_key ITEM_KEY
  * @param p_Otype_Code ����CODE
  * @param ass_table_name
  *        ҵ�������
  * @param ass_table_status
  *        ҵ���STATUS�ֶ�����,��д���ֶ����ƺ�,�ڻ���������й�����,�������ֶε�״̬
  * @param fk_name
  *        ���洢ҵ����������ֶ�,û�л����
  * @param ass_table_pkname
  *        ҵ��������ֶ�����
  * @version V1.1 ON 2018.11.25 by ŷ�� ������������4������
             V1.2 ON 2018.11.30 by ŷ�� ��Ч���ش�BD��ΪDD
             V1.3 ON 2018.12.14 BY ŷ�� ���ӱ������4������
             V1.4 ON 2018.1.3 BY ���� ��Ӻ�ͬ��������ͬ�������ҳ��չ�ֻص��¼�
             V1.5 ON 2018.1.4 BY ŷ�� ��Чʱ����д������Чʱ��
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
    SV           NUMBER; --sequenceValue�洢����ֵ
    NR           NUMBER; --new Record ��������¼��WF_ID
    PKVAL        NUMBER; --�������̵�����ID
    PKNAME       VARCHAR2(32); --�������̵���������
    VSQL         VARCHAR2(2000);
    VSTATUS      VARCHAR2(40);
    RECEVIEDATE  DATE; --����ʱ��
    VCOU         NUMBER;
    V_UP_POSITON NUMBER; --��ǰ���������������ڵ�
    IS_EXIST     VARCHAR2(1);
  BEGIN
    --Step1.��������CODE��ȡ���̵�������Ϣ
    SELECT * BULK COLLECT
      INTO WFRI
      FROM SPM_WF_REGINFO S
     WHERE S.WF_CODE = P_OTYPE_CODE;
    --Step2.��װSQL����ѯpkVal
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
  
    --Step3.��ȡ����
    SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
  
    --Step4.��ȡ��������¼��WF_ID
    SELECT MAX(WF_ID)
      INTO NR
      FROM CUX_WF_HISTORY_INFO S
     WHERE S.AUDIT_INFO IS NOT NULL
       AND WF_ITEMKEY = P_ITEM_KEY;
  
    --Step5.��ȡ����ʱ��
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
  
    --Step6.������ʷ��
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
    --Step7.��õ�ǰ���������ĸ��ڵ㣬������׸��ڵ㣬��Ϊ��
    SELECT P.UP_WF_PLAN_POSITION_ID
      INTO V_UP_POSITON
      FROM CUX_WF_HISTORY_INFO S, CCM_WF_PLAN_POSITION P
     WHERE S.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
       AND S.WF_ITEMKEY = P_ITEM_KEY
       AND S.WF_ID = NR;
    --Step8.����ҵ���STATUS�ֶ�
    IF ASS_TABLE_STATUS IS NOT NULL AND ASS_TABLE_PKNAME IS NOT NULL AND
       V_UP_POSITON IS NOT NULL THEN
      VSQL := 'UPDATE ' || ASS_TABLE_NAME || ' SET ' || ASS_TABLE_STATUS ||
              ' = ''' || VSTATUS || '''' || ' WHERE ' || ASS_TABLE_PKNAME ||
              ' = ''' || PKVAL || '''';
      EXECUTE IMMEDIATE VSQL;
    END IF;
  
  END SAVE_WF_HISTORY;

  /**
  * @author : ������
  * @date : 2017.12.05
  * @desc : ֪ͨ���ɺ󴥷��Ļص�����(����)
  * @param p_notifid ֪ͨID
  * @param p_itemkey ����itemKey
  * @param p_Otype_Code ����Code
  * @param ass_table ҵ�������,�ڻ���������й�����,�������ֶε�״̬
  * @param ass_col_pkname ҵ���������
  * @param ass_col_status ҵ���״̬�ֶ�����
  * @param ass_col_itemkey ҵ���ITEM_KEY�ֶ�����
  * @param status_reject ���غ�����״̬
  * @param status_passed ͨ���������״̬
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
    WN WF_NOTIFICATIONS_TYPE;
    TYPE ENTRUST_USER IS TABLE OF SPM_WF_ENTRUST.FROM_USER_ID%TYPE;
    EU              ENTRUST_USER;
    SV              NUMBER; --sequenceValue�洢����ֵ
    PKVAL           NUMBER; --�������̵�����ID
    VSQL            VARCHAR2(2000);
    V_STATUS        VARCHAR2(40);
    V_POSITION_ID   NUMBER;
    V_POSITION_NAME VARCHAR2(100);
    V_MSG_NAME      VARCHAR2(32);
    V_MSG_STATUS    VARCHAR2(32);
    A               NUMBER;
    B               NUMBER;
    C               NUMBER := 0;
    D               NUMBER;
    CP              NUMBER;
    CU              VARCHAR2(32);
    FROMUSER        VARCHAR2(32);
  BEGIN
  
    --��ȡ֪ͨ��Ϣ
    SELECT * BULK COLLECT
      INTO WN
      FROM WF_NOTIFICATIONS S
     WHERE S.NOTIFICATION_ID = P_NOTIFID;
  
    --��ȡҵ�������ֵ
    SELECT S.JOB_ID
      INTO PKVAL
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_ITEMKEY;
  
    IF WN(1).STATUS = 'OPEN' THEN
      /**
      * MESSAGE_NAME ֵ����
      * MES_MEETING : ��׼
      * MES_OK : ͨ��
      * MES_NO : ����
      */
      IF WN(1).MESSAGE_NAME = 'MES_MEETING' THEN
      
        --Step1.��������CODE��ȡ���̵�������Ϣ
        SELECT * BULK COLLECT
          INTO WFRI
          FROM SPM_WF_REGINFO S
         WHERE S.WF_CODE = P_OTYPE_CODE;
      
        --Step2.��ȡ����
        SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
      
        --Step3.��ȡ�����ڵ���Ϣ
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
      
        /**
        * Step4.�ж��Ƿ��������ί����Ϣ,�����,�ӱ�ʶ
        * ��ί���˲��ڵ�ǰ�ڵ�:��ʾ��XX����
        * ��ί�����ڵ�ǰ�ڵ�: ��ʾͬʱ��XX����
        */
        --�жϵ�ǰ֪ͨ�������Ƿ��Ǳ�ί����(��Ч����)
        SELECT COUNT(1)
          INTO A
          FROM SPM_WF_ENTRUST S
         WHERE S.WF_CODE = P_OTYPE_CODE
           AND S.TO_USER_ID = WN(1).RECIPIENT_ROLE
           AND TRUNC(SYSDATE) <= TRUNC(S.END_DATE)
           AND TRUNC(SYSDATE) >= TRUNC(S.START_DATE);
      
        IF A > 0 THEN
        
          --��ȡί������Ϣ
          SELECT S.FROM_USER_ID BULK COLLECT
            INTO EU
            FROM SPM_WF_ENTRUST S
           WHERE S.WF_CODE = P_OTYPE_CODE
             AND S.TO_USER_ID = WN(1).RECIPIENT_ROLE
             AND TRUNC(SYSDATE) <= TRUNC(S.END_DATE)
             AND TRUNC(SYSDATE) >= TRUNC(S.START_DATE);
        
          --�жϵ�ǰ֪ͨ�������Ƿ�ԭ���ʹ��ڵ�ǰ�ڵ������������
          SELECT COUNT(1)
            INTO B
            FROM CCM_WF_PLAN_POSITION_USER A, FND_USER B
           WHERE A.USER_ID = B.USER_ID
             AND A.WF_PLAN_POSITION_ID = V_POSITION_ID
             AND B.USER_NAME = WN(1).RECIPIENT_ROLE
             AND NVL(B.END_DATE, SYSDATE + 1) > SYSDATE;
        
          /*
          * �ж�ί�����Ƿ��ڵ�ǰ�ڵ�
          *
          * ��Ϊ����ί�����������̵�ί��,ί���˲�һ���ڵ�ǰ�ڵ�,�����нڵ�����Բ�ѯ��ί����Ϣ
          * ���������� P1-P2(A)-P3(B)-P4 4����
          * P2������ΪA,P3������ΪB,Bί�и���A
          * �����̴���P2��ʵ,A�ܲ�ѯ���Լ���Ϊ��ί����
          * ����ǰ�ڵ�P2ȴ������ί�нڵ�(P3����)
          * ��ǰ�ڵ㲻��ί�нڵ�,��û��Ҫ������������ʷ��¼ʱ��ʾί����Ϣ
          * ���Բ�Ҫ��ѯί�����Ƿ��ڵ�ǰ�ڵ�
          */
          FOR I IN 1 .. EU.COUNT LOOP
            SELECT COUNT(1)
              INTO C
              FROM CCM_WF_PLAN_POSITION_USER A, FND_USER B
             WHERE A.USER_ID = B.USER_ID
               AND A.WF_PLAN_POSITION_ID = V_POSITION_ID
               AND B.USER_NAME = EU(I)
               AND NVL(B.END_DATE, SYSDATE + 1) > SYSDATE;
            IF C > 0 THEN
              CU := CU || SPM_COMMON_PKG.GET_FULLNAME_BY_USERNAME(EU(I)) || ',';
            END IF;
          END LOOP;
        
          IF CU IS NOT NULL THEN
            IF B > 0 THEN
              CU := '��ͬʱ�� ' || SUBSTR(CU, 0, LENGTH(CU) - 1) || ' ������';
            ELSE
              CU := '���� ' || SUBSTR(CU, 0, LENGTH(CU) - 1) || ' ������';
            END IF;
          END IF;
        
        END IF;
        CU := SPM_COMMON_PKG.GET_FULLNAME_BY_USERNAME(WN(1).RECIPIENT_ROLE) || CU;
        --Step5.����������ʷ
      
        INSERT INTO SPM_CON_WF_HISTORY
          (WF_HISTORY_ID,
           NOTIFICATION_ID,
           ASS_TABLE_NAME,
           ASS_TABLE_PRIKEY_ID,
           ACT_TABLE_NAME,
           WF_ITEMKEY,
           USER_ID,
           USER_NAME,
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
                 (SELECT USER_ID
                    FROM FND_USER
                   WHERE USER_NAME = WN(1).RECIPIENT_ROLE),
                 WN(1).RECIPIENT_ROLE,
                 A.WF_CODE,
                 A.WF_NAME,
                 V_POSITION_ID,
                 V_POSITION_NAME,
                 CU,
                 SYSDATE
            FROM SPM_CON_WF_ACTIVITY A
           WHERE A.ITEM_KEY = P_ITEMKEY;
      
        --Step6.�޸�����״̬
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || V_STATUS || ''',' || ASS_COL_ITEMKEY || ' = ''' ||
                P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME || ' = ''' ||
                PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      ELSIF WN(1).MESSAGE_NAME = 'MES_NO' THEN
        --���̲���
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || STATUS_REJECT || ''',' || ASS_COL_ITEMKEY ||
                ' = ''' || P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME ||
                ' = ''' || PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      ELSIF WN(1).MESSAGE_NAME = 'MES_OK' THEN
        --����ͨ��
        VSQL := ' UPDATE ' || ASS_TABLE || ' SET ' || ASS_COL_STATUS ||
                ' = ''' || STATUS_PASSED || ''',' || ASS_COL_ITEMKEY ||
                ' = ''' || P_ITEMKEY || '''' || ' WHERE ' || ASS_COL_PKNAME ||
                ' = ''' || PKVAL || '''';
        EXECUTE IMMEDIATE VSQL;
      
      END IF;
    
    END IF;
  END GENERATE_HISTORY_INFO;

  --֪ͨ����󴥷��Ļص�����(����)
  PROCEDURE UPDATE_HISTORY_INFO(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
    TYPE CUX_WF_HISTORY_INFO_TYPE IS TABLE OF CUX_WF_HISTORY_INFO%ROWTYPE INDEX BY BINARY_INTEGER;
    CUX          CUX_WF_HISTORY_INFO_TYPE;
    POSITIONNAME VARCHAR2(2000);
    ISHQ         VARCHAR2(32);
  BEGIN
  
    SELECT * BULK COLLECT
      INTO CUX
      FROM CUX_WF_HISTORY_INFO S
     WHERE S.WF_ID = (SELECT MAX(WF_ID)
                        FROM CUX_WF_HISTORY_INFO
                       WHERE WF_ITEMKEY = P_KEY);
  
    /*SELECT P.WF_PLAN_POSITION_NAME
     INTO POSITIONNAME
     FROM CUX_WF_HISTORY_INFO I, CCM_WF_PLAN_POSITION P
    WHERE I.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
      AND I.OTYE_CODE = P_OTYPE_CODE
      AND I.WF_ITEMKEY = P_KEY
      AND I.WF_ID = CUX(1).WF_ID;*/
  
    --��׼���޸�������Ϣ
    UPDATE SPM_CON_WF_HISTORY S
       SET S.WF_POSITION_ID = CUX(1).WF_POSITION_ID,
           --S.WF_POSITION_NAME = POSITIONNAME,
           S.AUDIT_RESULT     = CUX(1).AUDIT_RESULT,
           S.AUDIT_INFO       = CUX(1).AUDIT_INFO,
           S.AUDIT_DATE       = CUX(1).AUDIT_DATE,
           S.AUDIT_EFFICIENCY = SPM_CON_UTIL_PKG.GET_FORMAT_DATE(S.RECEIVE_DATE,
                                                                 CUX(1)
                                                                 .AUDIT_DATE,
                                                                 'CN')
     WHERE S.WF_ITEMKEY = P_KEY
       AND S.NOTIFICATION_ID = P_NOTIFID;
  
    --����ǻ�ǩ�ڵ㻹���������յ�֪ͨ��ɾ��
    --��ѯ�Ƿ��ǩ�ڵ�
  
    BEGIN
      --���ɾ�ڵ����������쳣����
      SELECT NVL(S.ATTRIBUTE5, 'N')
        INTO ISHQ
        FROM CCM_WF_PLAN_POSITION S
       WHERE S.WF_PLAN_POSITION_ID = CUX(1).WF_POSITION_ID;
    
      IF ISHQ = 'N' THEN
        DELETE SPM_CON_WF_HISTORY S
         WHERE S.WF_ITEMKEY = P_KEY
           AND S.WF_POSITION_ID = CUX(1).WF_POSITION_ID
           AND S.NOTIFICATION_ID <> P_NOTIFID;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('�ڵ㱻ɾ�������Դ˴������쳣!');
    END;
  
  END UPDATE_HISTORY_INFO;

  --��ȡ��Ч��ͬ
  FUNCTION GET_EFFECTIVE_CONTRACT(CONID IN NUMBER) RETURN VARCHAR2 AS
    V_RESULT  VARCHAR2(32);
    V_STATUS  VARCHAR2(32);
    V_CHANGE  VARCHAR2(32);
    V_CONNAME VARCHAR2(1000); --��ֹѡ��Ԥ����Ķ�����ͬ
  BEGIN
  
    SELECT CONTRACT_NAME, STATUS, STATUS_CHANGE
      INTO V_CONNAME, V_STATUS, V_CHANGE
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_ID = CONID;
  
    IF V_CHANGE = 1 THEN
      IF V_STATUS = 'E' OR V_STATUS LIKE 'H%' OR
         (V_STATUS LIKE 'F%' AND V_STATUS <> 'FZ') THEN
        IF V_CONNAME IS NULL THEN
          V_RESULT := 'N';
        ELSE
          V_RESULT := 'Y';
        END IF;
      ELSE
        V_RESULT := 'N';
      END IF;
    ELSE
      V_RESULT := 'N';
    END IF;
  
    RETURN V_RESULT;
  
  END;

  --��ȡ��Ч���Э��(ֻҪ���ǲݸ�,�½����ػ����������̾���Ϊ����Ч)
  FUNCTION GET_EFFECTIVE_KJXY(CONID IN NUMBER) RETURN VARCHAR2 AS
    V_RESULT VARCHAR2(32);
    V_STATUS VARCHAR2(32);
  BEGIN
  
    SELECT S.STATUS
      INTO V_STATUS
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID
       AND S.STATUS_CHANGE = 1; --�Ǳ�������к�ͬ
    --A�ݸ�,D����,I����
    IF V_STATUS = 'A' OR V_STATUS = 'D' OR V_STATUS LIKE 'I%' THEN
      V_RESULT := 'N';
    ELSE
      V_RESULT := 'Y';
    END IF;
    RETURN V_RESULT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END;

  --��ȡ���̽ڵ��Ӧ��״̬����
  FUNCTION GET_WF_STATUS_BY_POSITION(P_OTYPE_CODE IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) RETURN VARCHAR2 AS
    V_STATUS VARCHAR2(40);
  BEGIN
    SELECT SD.DICT_CODE
      INTO V_STATUS
      FROM CCM_WF_OTYPE_POSITION OP,
           CCM_WF_PLAN_POSITION  PP,
           SPM_WF_PLAN_CAN_M     CM,
           SPM_DICT              SD
     WHERE OP.POSITION_STRUCTURE_ID = PP.WF_PLAN_ID
       AND PP.WF_PLAN_POSITION_ID = CM.PLAN_ID
       AND CM.STATUS = SD.DICT_ID
       AND OP.OTYPE_CODE = P_OTYPE_CODE
       AND PP.WF_PLAN_POSITION_ID = PPOSITION_ID;
  
    RETURN V_STATUS;
  END;

  --������ǩ
  PROCEDURE SPM_CON_START_HQ(P_KEY IN VARCHAR2, VPOSITOIN_ID IN NUMBER) IS
    V_IS_COUNTERSIGN VARCHAR2(150);
  BEGIN
    SELECT T.ATTRIBUTE5
      INTO V_IS_COUNTERSIGN
      FROM CCM_WF_PLAN_POSITION T
     WHERE T.WF_PLAN_POSITION_ID = VPOSITOIN_ID;
  
    IF V_IS_COUNTERSIGN = 'Y' THEN
    
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 100);
    
    ELSE
      --ȡ����ǩ
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 0.1);
    
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;

  --����ԭ��htmlչ��
  FUNCTION SPM_CON_REBUT_REASON_WF_HTML RETURN VARCHAR2 IS
    V_MSG        VARCHAR2(20000);
    V_MSG_REASON VARCHAR2(20000);
    V_DICT_CODE  VARCHAR2(40);
    V_DICT_NAME  VARCHAR2(400);
  
    --���Ͷ���
    CURSOR REASON IS
      SELECT D.DICT_CODE, D.DICT_NAME
        FROM SPM_DICT D
        LEFT JOIN SPM_DICT_TYPE DT
          ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
       WHERE DT.TYPE_CODE = 'SPM_CON_REBUT_REASON'
       ORDER BY D.DISPLAY_ORDER;
  
  BEGIN
  
    BEGIN
      OPEN REASON;
      --ѭ����ʼ
      LOOP
        FETCH REASON
          INTO V_DICT_CODE, V_DICT_NAME;
        EXIT WHEN REASON%NOTFOUND; --��û�м�¼ʱ�˳�ѭ��
        V_MSG_REASON := V_MSG_REASON || '<option value=''' || V_DICT_CODE ||
                        '''>' || V_DICT_NAME || '</option>';
      END LOOP;
      CLOSE REASON;
    END;
  
    V_MSG := '<font>����ԭ�� ��</font>
       <select id="rebutReason" onchange="rebutCheck();">
             <option value="0" selected="selected">---��ѡ��---</option>' ||
             V_MSG_REASON || '
       </select>' || '<script>
             function rebutCheck(values){
               var obj = document.getElementById("rebutReason");
               var index =  obj.selectedIndex;
               var text = obj.options[index].text;
               var value = obj.options[index].value;
               var result = document.getElementsByTagName("textarea");
               if(value == 0){
                  result[0].innerText="";
                  result[0].value="";
               }else{
                  result[0].innerText=text;
                  result[0].value=text;
               }
             };
       </script>' || '<br/>';
    RETURN V_MSG;
  EXCEPTION
    WHEN OTHERS THEN
      V_MSG := '��������';
      RETURN V_MSG;
  END;

  --����ԭ���ַ�����ȡ
  FUNCTION SUBSTR_STR_FOR_HT(V_STR VARCHAR2) RETURN VARCHAR2 IS
    V_A NUMBER;
    V_B NUMBER;
    V_C VARCHAR2(200);
  BEGIN
    SELECT INSTR(V_STR, '��'), INSTR(V_STR, '��') INTO V_A, V_B FROM DUAL;
    IF V_A = 1 THEN
      V_B := (V_B - V_A) + 1;
      SELECT SUBSTR(V_STR, V_A, V_B) INTO V_C FROM DUAL;
    ELSE
      V_C := V_STR;
    END IF;
    RETURN V_C;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN V_STR;
  END SUBSTR_STR_FOR_HT;

  --����ԭ����֤
  FUNCTION SPM_CON_REBUT_REASON_WF_VALI(V_STR VARCHAR2) RETURN VARCHAR2 IS
    V_A VARCHAR2(200);
    COU NUMBER;
  BEGIN
    V_A := SUBSTR_STR_FOR_HT(V_STR);
    SELECT COUNT(*)
      INTO COU
      FROM SPM_DICT D
      LEFT JOIN SPM_DICT_TYPE DT
        ON D.DICT_TYPE_ID = DT.DICT_TYPE_ID
     WHERE DT.TYPE_CODE = 'SPM_CON_REBUT_REASON'
       AND D.DICT_NAME = V_A;
    RETURN COU;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '0';
  END;

  --��ͬ�½�����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_CREATION_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := SPM_CON_REBUT_REASON_WF_HTML || '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtInfo/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CREATION_HTML;

  --��ͬ�������������ص�
  PROCEDURE SPM_CON_HT_WF_CREATION_START(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    PKVAL NUMBER;
  BEGIN
    --���������и�����ֹɾ��
    SELECT S.JOB_ID
      INTO PKVAL
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_KEY;
  
    UPDATE SPM_UPLOAD_FILE S
       SET S.ASS_ID4 = 1
     WHERE S.ASS_TABLE_PRIKEY_ID IN
           (SELECT F.FILE_ID
              FROM SPM_CON_HT_FILE F
             WHERE F.CONTRACT_ID = PKVAL);
  END;
  --��ͬ�½����̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_CREATION_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
    CONID         NUMBER;
    COU           NUMBER;
    SIGNER_DIFF   NUMBER;
    SIGNER_CLAUSE NUMBER;
    L_NID         NUMBER;
    V_INFO        VARCHAR2(1000);
  BEGIN
    IF P_OPER_RESULT = 'Y' THEN
      --�����׼ʱ,��Ҫ��֤�Ƿ��Ѿ�ǩ��
    
      SELECT JOB_ID
        INTO CONID
        FROM SPM_CON_WF_ACTIVITY
       WHERE ITEM_KEY = P_KEY;
    
      SELECT SIGNER_CLAUSE, SIGNER_DIFF
        INTO SIGNER_CLAUSE, SIGNER_DIFF
        FROM SPM_CON_HT_INFO
       WHERE CONTRACT_ID = CONID;
    
      IF SIGNER_CLAUSE IS NULL OR SIGNER_DIFF IS NULL THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '�ո��������ͬ�������Ҫ��ǩ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    ELSIF P_OPER_RESULT = 'N' THEN
      L_NID  := WF_ENGINE.CONTEXT_NID;
      V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
      COU    := SPM_CON_REBUT_REASON_WF_VALI(V_INFO);
      IF COU = 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '����ԭ��ƥ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_CREATION_VALID;

  --��ͬ�½�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CREATION_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'AZ');
  END SPM_CON_HT_WF_CREATION_TZSC;

  --��ͬ�½�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CREATION_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CREATION_TZH;

  /**
      ͨ������HTMLչ�֣�������¼���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_WF_CREATION_DIYHTML(P_KEY        IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG VARCHAR2(20000);
  
  BEGIN
    --1.CREATE TABLE 
    MSG := MSG || '<table class="wf-table">';
  
    --2.GET BUSINESS INFO COMMON FUN 
    MSG := MSG || SPM_WF_TEMPLATE_HTML(P_KEY, P_OTYPE_CODE);
  
    --3.GET GRID INFO 
    MSG := MSG || SPM_CON_HT_GRID_HTML(P_KEY, P_OTYPE_CODE);
    MSG := MSG || '</table>';
  
    MSG := MSG || '<br/> <br/>';
    --4.GET WF HISTORY INFO COMMON FUN
    MSG := MSG || SPM_WF_RECORD_HTML(P_KEY, P_OTYPE_CODE);
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END SPM_CON_HT_WF_CREATION_DIYHTML;

  /**
      ͨ������HTMLչ�֣��ӱ���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    L_DOCUMENT VARCHAR2(10000);
    V_ID       NUMBER(15); --ҵ������ID
  
    CURSOR CUR(P_ID NUMBER) IS
      SELECT CON_MERCHANTS_ID,
             MERCHANTS_ID,
             (SELECT V.VENDOR_CODE
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) MERCHANTS_CODE,
             (SELECT V.VENDOR_NAME
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) MERCHANTS_NAME,
             S.MERCHANTS_FLAG,
             DECODE(S.MERCHANTS_FLAG, '1', '�ͻ�', 2, '��Ӧ��', 3, '') MERCHANTS_FLAG_NAME,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_VENDOR_RANK',
                                                             V.VENDOR_LEVEL)
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) MERCHANTS_LEVEL,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_VENDOR_GROUP_LEVEL',
                                                             V.VENDOR_GROUP_LEVEL)
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) MERCHANTS_TYPE,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_VENDOR_TYPE',
                                                             V.VENDOR_TYPE)
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) ENTERPRISE_TYPE,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_WZ_IN_OUT',
                                                             V.WZ_IN_OUT)
                FROM SPM_CON_VENDOR_INFO V
               WHERE V.VENDOR_ID = S.MERCHANTS_ID) WZ_IN_OUT,
             ORG_ID,
             CONTRACT_ID
        FROM SPM_CON_HT_MERCHANTS S
       WHERE 1 = 1
         AND MERCHANTS_FLAG = 2
         AND CONTRACT_ID = P_ID
      UNION
      SELECT CON_MERCHANTS_ID,
             MERCHANTS_ID,
             (SELECT V.CUST_CODE
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) MERCHANTS_CODE,
             (SELECT V.CUST_NAME
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) MERCHANTS_NAME,
             S.MERCHANTS_FLAG,
             DECODE(S.MERCHANTS_FLAG, '1', '�ͻ�', 2, '��Ӧ��', 3, '') MERCHANTS_FLAG_NAME,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_CUST_LEVEL',
                                                             V.CUST_LEVEL)
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) MERCHANTS_LEVEL,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_VENDOR_GROUP_LEVEL',
                                                             V.CUST_GROUP_LEVEL)
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) MERCHANTS_TYPE,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_VENDOR_TYPE',
                                                             V.CUST_TYPE)
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) ENTERPRISE_TYPE,
             (SELECT SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_WZ_IN_OUT',
                                                             V.WZ_IN_OUT)
                FROM SPM_CON_CUST_INFO V
               WHERE V.CUST_ID = S.MERCHANTS_ID) WZ_IN_OUT,
             ORG_ID,
             CONTRACT_ID
        FROM SPM_CON_HT_MERCHANTS S
       WHERE 1 = 1
         AND MERCHANTS_FLAG = 1
         AND CONTRACT_ID = P_ID;
    REC CUR%ROWTYPE;
  BEGIN
    --��ȡҵ������ID
    SELECT A.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY A
     WHERE A.ITEM_KEY = P_KEY;
  
    L_DOCUMENT := '<tr> <td colspan =8 align="center"> ��Ӧ��/�ͻ���Ϣ</td> </tr>' ||
                  '<tr>' || 
                  '<td class="wf-label" colspan =4>�Է�����</td>' ||
                  '<td class="wf-label" colspan =3>�Է����</td>' ||
                  '<td class="wf-label">����</td>' || '</tr>';
  
    OPEN CUR(V_ID);
    FETCH CUR
      INTO REC;
    WHILE CUR%FOUND LOOP
      L_DOCUMENT := L_DOCUMENT || '<tr>' || '<td colspan =4>' || REC.MERCHANTS_NAME || '</td>' ||
                    '<td colspan =3>' || REC.MERCHANTS_CODE || '</td>' || '<td >' ||
                    REC.MERCHANTS_FLAG_NAME || '</td>' || '</tr>';
      FETCH CUR
        INTO REC;
    END LOOP;
  
    RETURN L_DOCUMENT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN L_DOCUMENT;
  END SPM_CON_HT_GRID_HTML;

  --��ͬ�½����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CREATION_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CREATION_RYSZ;

  --��ͬ�½���������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_URGENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtInfo/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_URGENT_HTML;

  --��ͬ�������������ص�
  PROCEDURE SPM_CON_HT_WF_URGENT_START(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
    PKVAL NUMBER;
  BEGIN
    --���������и�����ֹɾ��
    --���������и�����ֹɾ��
    SELECT S.JOB_ID
      INTO PKVAL
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_KEY;
  
    UPDATE SPM_UPLOAD_FILE S
       SET S.ASS_ID4 = 1
     WHERE S.ASS_TABLE_PRIKEY_ID IN
           (SELECT F.FILE_ID
              FROM SPM_CON_HT_FILE F
             WHERE F.CONTRACT_ID = PKVAL);
  END;

  --��ͬ�½�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_URGENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'AZ');
  END SPM_CON_HT_WF_URGENT_TZSC;

  --��ͬ�½�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_URGENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_URGENT_TZH;

  --��ͬ�����½����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_URGENT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_URGENT_RYSZ;

  --��ͬ��������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_EFFECTIVE_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtEffective/showEffective/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_EFFECTIVE_HTML;

  --��ͬ�������̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_VALID(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
    CONID       NUMBER;
    SEALREMARKS VARCHAR2(2000);
  BEGIN
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
  
    SELECT SEAL_REMARKS
      INTO SEALREMARKS
      FROM SPM_CON_HT_EFFECTIVE
     WHERE CONTRACT_ID = CONID;
    IF P_OPER_RESULT = 'Y' THEN
      IF SEALREMARKS IS NULL THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '����д��ͬ������Ϣ');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_EFFECTIVE_VALID;

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'BD',
                          'BZ');
  END SPM_CON_HT_WF_EFFECTIVE_TZSC;

  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 100);
  END SPM_CON_HT_WF_EFFECTIVE_TZH;

  --��ͬ�������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_RYSZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_EFFECTIVE_RYSZ;

  --��ͬ��Ч����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_EFFECT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtEffective/showEffective/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_EFFECT_HTML;

  --��ͬ��Ч����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
    VSTATUS  VARCHAR2(32);
    VCONID   NUMBER;
    VVERSION VARCHAR2(40);
  BEGIN
    /*
      GENERATE_HISTORY_INFO(P_NOTIFID,
                            P_ITEMKEY,
                            P_OTYPE_CODE,
                            'SPM_CON_HT_INFO',
                            'CONTRACT_ID',
                            'STATUS',
                            'ITEM_KEY',
                            'BD',
                            'E');
    */
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'DD',
                          'E');
    SELECT S.JOB_ID, S.STATUS
      INTO VCONID, VSTATUS
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_ITEMKEY;
    IF VSTATUS = 'E' THEN
      SELECT S.CONTRACT_VERSION
        INTO VVERSION
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_ID = VCONID;
      --V1.5��Чʱ����д������Чʱ��
      UPDATE SPM_CON_HT_INFO T SET T.EFFECTIVE_DATE = SYSDATE WHERE T.CONTRACT_ID = VCONID;
      IF TO_NUMBER(VVERSION) > 1 THEN
        --����ĺ�ͬ��Ч�󽻻��¾ɺ�ͬ��Ϣ
        SPM_CON_HT_PKG.EXCHANGE_CONTRACT_CHANGE_INFO(VCONID);
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_EFFECT_TZSC;

  --��ͬ��Ч����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_EFFECT_TZH;

  --��ͬ��Ч���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_EFFECT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_EFFECT_RYSZ;

  FUNCTION SPM_CON_HT_WF_CHANGE_VOID_HTML(P_KEY        IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtChangeVoid/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CHANGE_VOID_HTML;

  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
    VSTATUS  VARCHAR2(32);
    VCONID   NUMBER;
    VVERSION VARCHAR2(40);
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'CVB',
                          'CVE');
    SELECT S.JOB_ID, S.STATUS
      INTO VCONID, VSTATUS
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_ITEMKEY;
    IF VSTATUS = 'CVE' THEN
      UPDATE SPM_CON_HT_INFO
         SET STATUS_CHANGE = '5'
       WHERE CONTRACT_ID = VCONID;
    END IF;
  
  END SPM_CON_HT_WF_CHANGE_VOID_TZSC;

  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZH(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CHANGE_VOID_TZH;

  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                           OTYPECODE    IN VARCHAR2,
                                           PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CHANGE_VOID_RYSZ;

  --��ͬ������������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_SEAL_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    
     SELECT HT.CONTRACT_ID
       INTO V_ACTIVITY_ID
       FROM SPM_CON_WF_ACTIVITY S, SPM_CON_HT_INFO HT, SPM_CON_HT_SEALED D
      WHERE D.SEAL_ID = S.JOB_ID
        AND D.CONTRACT_ID = HT.CONTRACT_ID
        AND S.ITEM_KEY = P_KEY;
    
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtEffective/showEffective/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_SEAL_HTML;

  --��ͬ������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_SEAL_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2) AS
    VSTATUS  VARCHAR2(32);
    VCONID   NUMBER;
    VVERSION VARCHAR2(40);
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_SEALED',
                          'SEAL_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_HT_WF_SEAL_TZSC;

  --��ͬ������������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_SEAL_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_SEAL_TZH;

  --��ͬ�����������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_SEAL_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_SEAL_RYSZ;

  --��ͬ��������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_VOID_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtVoid/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_VOID_HTML;

  --��ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'ID',
                          'IZ');
  END SPM_CON_HT_WF_VOID_TZSC;

  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_VOID_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_VOID_TZH;

  --��ͬ�������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_VOID_RYSZ;

  --������ͬ��������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_ORDER_VOID_HTML(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtOrder/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_ORDER_VOID_HTML;

  --������ͬ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2) AS
    V_MSG     VARCHAR2(100);
    CONID     NUMBER; --��ǰ����ID
    CONIDR    NUMBER; --��������ID
    CONNAMER  VARCHAR2(200);
    COU       NUMBER;
    ORDERTYPE NUMBER; --��ǰ������������1����2�ɹ�
    ORDERCODE VARCHAR2(200); --��ǰ�������
    OC        VARCHAR2(200); --�����������
  BEGIN
    /**
    * �������Ϻ�
    * ������������ѵ���,����
    * �����������δ����,ɾ��
    */
    SELECT S.MESSAGE_NAME
      INTO V_MSG
      FROM WF_NOTIFICATIONS S
     WHERE S.NOTIFICATION_ID = P_NOTIFID;
  
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_ITEMKEY;
  
    SELECT ORDER_TYPE, CONTRACT_CODE
      INTO ORDERTYPE, ORDERCODE
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID;
  
    --��������ͨ��
    IF V_MSG = 'MES_OK' THEN
      --�жϹ����������
      IF ORDERTYPE = 1 THEN
        OC := ORDERCODE || '-1';
      ELSIF ORDERTYPE = 2 THEN
        OC := SUBSTR(ORDERCODE, 1, LENGTH(ORDERCODE) - 2);
      END IF;
    
      SELECT CONTRACT_ID, CONTRACT_NAME
        INTO CONIDR, CONNAMER
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = OC;
      --ɾ���������� ��������
      IF CONNAMER IS NOT NULL THEN
        UPDATE SPM_CON_HT_INFO SET STATUS = 'IZ' WHERE CONTRACT_CODE = OC;
      ELSE
        --ɾ������
        DELETE SPM_CON_HT_INFO S WHERE S.CONTRACT_CODE = OC;
        --ɾ��������ϵ
        DELETE SPM_CON_HT_RELATION S
         WHERE S.CONTRACT_ID = CONID
           AND S.CONTRACT_ID_R = CONIDR;
      END IF;
    END IF;
  
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'ID',
                          'IZ');
  END SPM_CON_HT_WF_ORDER_VOID_TZSC;

  --������ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZH(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_ORDER_VOID_TZH;

  --��ͬ�������HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_CHANGE_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := SPM_CON_REBUT_REASON_WF_HTML || '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtChange/showChange/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CHANGE_HTML;

  --��ͬ������̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_CHANGE_VALID(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
    CONID         NUMBER;
    SIGNER_DIFF   NUMBER;
    SIGNER_CLAUSE NUMBER;
    L_NID         NUMBER;
    V_INFO        VARCHAR2(1000);
    COU           NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
  
    SELECT SIGNER_CLAUSE, SIGNER_DIFF
      INTO SIGNER_CLAUSE, SIGNER_DIFF
      FROM SPM_CON_HT_INFO
     WHERE CONTRACT_ID = CONID;
    IF P_OPER_RESULT = 'Y' THEN
      IF SIGNER_CLAUSE IS NULL OR SIGNER_DIFF IS NULL THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '�ո��������ͬ�������Ҫ��ǩ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
      /*
      * ���� 2018-11-12 ŷ��
      * ������أ�����ѡ����ԭ��
      */
    ELSIF P_OPER_RESULT = 'N' THEN
      L_NID  := WF_ENGINE.CONTEXT_NID;
      V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
      COU    := SPM_CON_REBUT_REASON_WF_VALI(V_INFO);
      IF COU = 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '����ԭ��ƥ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_CHANGE_VALID;

  --��ͬ�������֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'CD',
                          'AZ');
  END SPM_CON_HT_WF_CHANGE_TZSC;

  --��ͬ�������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CHANGE_TZH;

  --��ͬ������̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CHANGE_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CHANGE_RYSZ;

  --��ͬ��ֹ����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_SUSPEND_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtSuspend/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_SUSPEND_HTML;

  --��ͬ��ֹ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'FD',
                          'FZ');
  END SPM_CON_HT_WF_SUSPEND_TZSC;

  --��ͬ��ֹ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_SUSPEND_TZH;

  --��ͬ��ֹ���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_SUSPEND_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_SUSPEND_RYSZ;

  --��ͬ�ָ�����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_RECOVERY_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtSuspend/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_RECOVERY_HTML;

  --��ͬ�ָ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'GD',
                          'E');
  END SPM_CON_HT_WF_RECOVERY_TZSC;

  --��ͬ�ָ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_RECOVERY_TZH;

  --��ͬ�ָ����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_RECOVERY_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_RECOVERY_RYSZ;

  --��ͬ�鵵����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_ARCHIVED_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtArchived/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_ARCHIVED_HTML;

  --��ͬ�鵵���������ص�����
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_START(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    CONID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = ITEMKEY;
  
    --���ù鵵ʱ��
    UPDATE SPM_CON_HT_ARCHIVED S
       SET S.TRANSFER_BY   = FND_GLOBAL.USER_ID,
           S.TRANSFER_DATE = TRUNC(SYSDATE, 'MI')
     WHERE CONTRACT_ID = CONID
       AND S.IS_TRANSFER = 1;
  
    --���ù鵵���
    UPDATE SPM_CON_HT_INFO S
       SET S.ARCHIVED_CODE = SPM_SERIAL_PKG.VALUE('SPM_CON_HT_ARCHIVED_CODE')
     WHERE S.CONTRACT_ID = CONID;
  
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END SPM_CON_HT_WF_ARCHIVED_START;

  --��ͬ�鵵���̱�����֤(֪ͨ�ص�)
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
    CONID NUMBER;
    COU   NUMBER;
  BEGIN
    IF P_OPER_RESULT = 'Y' THEN
      SELECT JOB_ID
        INTO CONID
        FROM SPM_CON_WF_ACTIVITY
       WHERE ITEM_KEY = P_KEY;
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_HT_ARCHIVED
       WHERE CONTRACT_ID = CONID
         AND IS_RECEIVE = 1
         AND IS_TRANSFER = 1
         AND IS_ARCHIVED = 0;
    
      IF COU = 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '��δ�����κι鵵����');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END SPM_CON_HT_WF_ARCHIVED_VALID;

  --��ͬ�鵵����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
    COU             NUMBER;
    CONID           NUMBER;
    V_PASSED_STATUS VARCHAR2(32);
    V_MSG           VARCHAR2(32);
  BEGIN
  
    SELECT S.MESSAGE_NAME
      INTO V_MSG
      FROM WF_NOTIFICATIONS S
     WHERE S.NOTIFICATION_ID = P_NOTIFID;
  
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_ITEMKEY;
  
    --����ͨ��ʱ,�޸Ĺ鵵��Ϣ
    IF V_MSG = 'MES_OK' THEN
      UPDATE SPM_CON_HT_ARCHIVED S
         SET S.IS_ARCHIVED  = 1,
             S.RECEIVE_BY   = FND_GLOBAL.USER_ID,
             S.RECEIVE_DATE = TRUNC(SYSDATE, 'MI')
       WHERE S.IS_RECEIVE = 1
         AND S.CONTRACT_ID = CONID
         AND S.RECEIVE_BY IS NULL;
    END IF;
  
    SELECT COUNT(1)
      INTO COU
      FROM SPM_CON_HT_ARCHIVED S
     WHERE S.CONTRACT_ID = CONID
       AND S.IS_RECEIVE = 0;
  
    SELECT DECODE(COU, 0, 'JZ', 'JY') INTO V_PASSED_STATUS FROM DUAL;
  
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS_ARCHIVED',
                          'ITEM_KEY_ARCHIVED',
                          'JD',
                          V_PASSED_STATUS);
  END SPM_CON_HT_WF_ARCHIVED_TZSC;

  --��ͬ�鵵����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_ARCHIVED_TZH;

  --��ͬ�鵵���̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_ARCHIVED_RYSZ;

  --��ͬ�ر�����HTMLչ�ֻص�
  FUNCTION SPM_CON_HT_WF_CLOSING_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHtClosing/edit/' ||
                                                   V_ACTIVITY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CLOSING_HTML;

  --��ͬ�ر�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HT_INFO',
                          'CONTRACT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'HD',
                          'Z');
  END SPM_CON_HT_WF_CLOSING_TZSC;

  --��ͬ�ر�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CLOSING_TZH;

  --��ͬ�ر����̻�ǩ����
  PROCEDURE SPM_CON_HT_WF_CLOSING_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CLOSING_RYSZ;

  --����Ȩ�޵ĺ���(��Ŀ)
  FUNCTION SPM_CON_DATAPERMISSION_PROJECT(CID NUMBER) RETURN VARCHAR2 IS
    V_RESULT  VARCHAR2(200);
    V_RESULT1 NUMBER(5);
    V_RESULT2 NUMBER(5);
  
  BEGIN
    SELECT COUNT(*)
      INTO V_RESULT1
      FROM SPM_CON_HT_PROJECT C
     WHERE C.CONTRACT_ID = CID;
    IF V_RESULT1 >= 1 THEN
      SELECT COUNT(*)
        INTO V_RESULT2
        FROM SPM_CON_OBJECT_PERMISSION T
       WHERE T.RESPONSE_ID = SPM_SSO_PKG.GETRESPID
         AND EXISTS (SELECT *
                FROM SPM_CON_HT_PROJECT C
               WHERE C.PROJECT_ID = T.OBJECT_ID
                 AND C.PROJECT_ID IS NOT NULL
                 AND C.CONTRACT_ID = CID);
    
      IF V_RESULT2 >= 1 THEN
        V_RESULT := 'Y';
      ELSE
        V_RESULT := 'N';
      END IF;
    
    ELSE
      V_RESULT := 'Y';
    END IF;
  
    RETURN V_RESULT;
  END;

  --����Ȩ�޵ĺ���(����)
  -- @param cid ����ID
  -- ��鵱ǰ����Ա�ĵ�ǰְ��������Ĳ����Ƿ���ڶ�Ӧ��ϵ
  FUNCTION SPM_CON_DATAPERMISSION_DEPT(CID NUMBER) RETURN VARCHAR2 IS
    V_RESULT VARCHAR2(200);
    V_COUNT  NUMBER(5);
  
  BEGIN
    SELECT COUNT(*)
      INTO V_COUNT
      FROM SPM_CON_OBJECT_PERMISSION C
     WHERE C.OBJECT_ID = CID
       AND C.OBJECT_TYPE = 'dept'
       AND C.RESPONSE_ID = SPM_SSO_PKG.GETRESPID;
    IF V_COUNT >= 1 THEN
      V_RESULT := 'Y';
    ELSE
      V_RESULT := 'N';
    END IF;
  
    RETURN V_RESULT;
  END;

  --�жϵ�ǰitemkey��������ʷ�Ƿ����SPM������ʷ�������ظ���������
  FUNCTION JUDGE_IS_EXIST_HISTORY(P_KEY IN VARCHAR2, P_DATE IN DATE)
    RETURN VARCHAR2 IS
    IS_EXIST NUMBER;
    R_FLAG   VARCHAR2(200);
  BEGIN
  
    SELECT COUNT(*)
      INTO IS_EXIST
      FROM SPM_CON_WF_HISTORY H
     WHERE 1 = 1
       AND H.WF_ITEMKEY = P_KEY
       AND H.AUDIT_DATE = P_DATE;
    IF IS_EXIST <> 0 THEN
      R_FLAG := 'N';
    ELSE
      R_FLAG := 'Y';
    END IF;
    RETURN R_FLAG;
  END JUDGE_IS_EXIST_HISTORY;

  --��Ӧ����˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_VENDOR_VIEW_INFO(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConVendorInfo/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_VENDOR_VIEW_INFO;
  --��Ӧ���ύ��ע�ᣬ׼�룬ս�ԣ����ʱ������Ӧ��״̬ת��Ϊ������С�AP ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) IS
  
  BEGIN
    UPDATE SPM_CON_VENDOR_INFO V
       SET V.STATUS = 'AP'
     WHERE V.VENDOR_ID = (SELECT I.VENDOR_ID
                            FROM SPM_CON_VENDOR_REG_REVIEW R
                           INNER JOIN SPM_CON_VENDOR_INFO I
                              ON R.VENDOR_ID = I.VENDOR_ID
                             AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
  END;
  --��Ӧ�����ͨ���󣬽���Ӧ�̵�״̬����Ϊ������ˡ�E ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_VENDOR_INFO V
       SET V.STATUS = 'E'
     WHERE V.VENDOR_ID = (SELECT I.VENDOR_ID
                            FROM SPM_CON_VENDOR_REG_REVIEW R
                           INNER JOIN SPM_CON_VENDOR_INFO I
                              ON R.VENDOR_ID = I.VENDOR_ID
                             AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
  END;

  --��Ӧ����˱����غ󣬸��¹�Ӧ��״̬Ϊ�����ء�D ��
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_VENDOR_INFO V
       SET V.STATUS = 'D'
     WHERE V.VENDOR_ID = (SELECT I.VENDOR_ID
                            FROM SPM_CON_VENDOR_REG_REVIEW R
                           INNER JOIN SPM_CON_VENDOR_INFO I
                              ON R.VENDOR_ID = I.VENDOR_ID
                             AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
  END;

  --��Ӧ�������˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_VENDOR_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConVendorYearReview/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END;

  --��Ӧ������ͨ���󣬸��¹�Ӧ�̵ĵȼ�
  PROCEDURE SPM_CON_VENDOR_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2) IS
    NEW_LEVEL VARCHAR2(40);
    OLD_LEVEL VARCHAR2(40);
    SUG_LEVEL VARCHAR2(40);
  BEGIN
    SELECT I.VENDOR_LEVEL
      INTO OLD_LEVEL
      FROM SPM_CON_VENDOR_INFO I
     INNER JOIN SPM_CON_YEAR_REVIEW R
        ON I.VENDOR_ID = R.ASSO_ID
     WHERE R.ITEM_KEY = ITEMKEY;
    SELECT R.RATING_SUGGEST
      INTO SUG_LEVEL
      FROM SPM_CON_YEAR_REVIEW R
     WHERE R.ITEM_KEY = ITEMKEY;
    IF SUG_LEVEL = 'asc' THEN
      IF OLD_LEVEL = 's' THEN
        NEW_LEVEL := 'f';
      ELSIF OLD_LEVEL = 't' THEN
        NEW_LEVEL := 's';
      ELSIF OLD_LEVEL = 'z' THEN
        NEW_LEVEL := 't';
      END IF;
    ELSIF SUG_LEVEL = 'des' THEN
      IF OLD_LEVEL = 'f' THEN
        NEW_LEVEL := 's';
      ELSIF OLD_LEVEL = 's' THEN
        NEW_LEVEL := 't';
      ELSIF OLD_LEVEL = 't' THEN
        NEW_LEVEL := 'z';
      END IF;
    ELSIF SUG_LEVEL = 'exit' THEN
      UPDATE SPM_CON_VENDOR_INFO I
         SET I.VENDOR_LEVEL = 'z'
       WHERE I.VENDOR_ID = (SELECT R.ASSO_ID
                              FROM SPM_CON_YEAR_REVIEW R
                             WHERE R.ITEM_KEY = ITEMKEY);
    END IF;
    IF NEW_LEVEL IS NOT NULL THEN
      UPDATE SPM_CON_VENDOR_INFO I SET I.VENDOR_LEVEL = NEW_LEVEL;
    END IF;
  
  END;

  --��Ӧ������֪ͨ���ɻص�
  PROCEDURE SPM_CON_VENDOR_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                     P_ITEMKEY IN VARCHAR2,
                                     
                                     P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_VENDOR_INFO',
                          'VENDOR_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_VENDOR_INFO_TZSC;
  --��Ӧ������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_VENDOR_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_VENDOR_INFO_TZH;

  --�ͻ���˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_CUST_VIEW_INFO(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
  
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConCustInfo/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_CUST_VIEW_INFO;
  --�ͻ��ύ��ע�ᣬ׼�룬ս�ԣ����ʱ�����ͻ�״̬ת��Ϊ������С�AP ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) IS
  
  BEGIN
    UPDATE SPM_CON_CUST_INFO V
       SET V.STATUS = 'AP'
     WHERE V.CUST_ID = (SELECT I.CUST_ID
                          FROM SPM_CON_CUST_REG_REVIEW R
                         INNER JOIN SPM_CON_CUST_INFO I
                            ON R.CUST_ID = I.CUST_ID
                           AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
  END;
  --�ͻ����ͨ���󣬽��ͻ���״̬����Ϊ������ˡ�E ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_CUST_INFO V
       SET V.STATUS = 'E'
     WHERE V.CUST_ID = (SELECT I.CUST_ID
                          FROM SPM_CON_CUST_REG_REVIEW R
                         INNER JOIN SPM_CON_CUST_INFO I
                            ON R.CUST_ID = I.CUST_ID
                           AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;
  --�ͻ���˱����غ󣬸��¿ͻ�״̬Ϊ�����ء�D ��
  PROCEDURE SPM_CON_CUST_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_CUST_INFO V
       SET V.STATUS = 'D'
     WHERE V.CUST_ID = (SELECT I.CUST_ID
                          FROM SPM_CON_CUST_REG_REVIEW R
                         INNER JOIN SPM_CON_CUST_INFO I
                            ON R.CUST_ID = I.CUST_ID
                           AND R.ITEM_KEY = ITEMKEY);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
  END;

  --�ͻ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CUST_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                   P_ITEMKEY IN VARCHAR2,
                                   
                                   P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_CUST_INFO',
                          'CUST_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CUST_INFO_TZSC;

  --�ͻ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CUST_INFO_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CUST_INFO_TZH;
  --��Ӧ������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_VENDOR_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                     P_ITEMKEY IN VARCHAR2,
                                     
                                     P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_YEAR_REVIEW',
                          'REVIEW_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_VENDOR_YEAR_TZSC;
  --��Ӧ������������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_VENDOR_YEAR_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_VENDOR_YEAR_TZH;

  --��Ӧ������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_CUST_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                   P_ITEMKEY IN VARCHAR2,
                                   
                                   P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_YEAR_REVIEW',
                          'REVIEW_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CUST_YEAR_TZSC;
  --�ͻ�����������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CUST_YEAR_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CUST_YEAR_TZH;

  --�ͻ������˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_CUST_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConCustYearReview/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END;

  --�ͻ�����ͨ���󣬸��¹�Ӧ�̵ĵȼ�
  PROCEDURE SPM_CON_CUST_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) IS
    NEW_LEVEL VARCHAR2(40);
    OLD_LEVEL VARCHAR2(40);
    SUG_LEVEL VARCHAR2(40);
  BEGIN
    SELECT R.RATING_SUGGEST, I.CUST_LEVEL
      INTO SUG_LEVEL, OLD_LEVEL
      FROM SPM_CON_CUST_INFO I
     INNER JOIN SPM_CON_YEAR_REVIEW R
        ON I.CUST_ID = R.ASSO_ID
     WHERE R.ITEM_KEY = ITEMKEY;
    IF SUG_LEVEL = 'asc' THEN
      IF OLD_LEVEL = 's' THEN
        NEW_LEVEL := 'f';
      ELSIF OLD_LEVEL = 't' THEN
        NEW_LEVEL := 's';
      ELSIF OLD_LEVEL = 'z' THEN
        NEW_LEVEL := 't';
      END IF;
    ELSIF SUG_LEVEL = 'des' THEN
      IF OLD_LEVEL = 'f' THEN
        NEW_LEVEL := 's';
      ELSIF OLD_LEVEL = 's' THEN
        NEW_LEVEL := 't';
      ELSIF OLD_LEVEL = 't' THEN
        NEW_LEVEL := 'z';
      END IF;
    ELSIF SUG_LEVEL = 'exit' THEN
      UPDATE SPM_CON_CUST_INFO I
         SET I.CUST_LEVEL = 'z'
       WHERE I.CUST_ID = (SELECT R.ASSO_ID
                            FROM SPM_CON_YEAR_REVIEW R
                           WHERE R.ITEM_KEY = ITEMKEY);
    END IF;
    IF NEW_LEVEL IS NOT NULL THEN
      UPDATE SPM_CON_CUST_INFO I SET I.CUST_LEVEL = NEW_LEVEL;
    END IF;
  
  END;

  --�������ɹ�Ӧ��������,״̬ΪJ,��ʾΪjob�Զ��������ݡ�
  PROCEDURE SPM_CON_PRODUCE_YEAR_REVIEW IS
    CREATE_DATE DATE;
    COUNTALL    NUMBER;
    --��ȡ�������ڵ��ڽ���Ŀͻ��α�
    CURSOR C_CUST IS
      SELECT C.CUST_ID, C.ORG_ID
        FROM SPM_CON_CUST_INFO C
       WHERE C.STATUS = 'E'
         AND TO_CHAR(C.SETUP_DATE, 'mmdd') = TO_CHAR(SYSDATE, 'mmdd');
    --��ȡ�������ڣ����գ����ڽ���Ĺ�Ӧ���α�
    CURSOR C_VENDOR IS
      SELECT I.VENDOR_ID, I.ORG_ID
        FROM SPM_CON_VENDOR_INFO I
       WHERE I.STATUS = 'E'
         AND TO_CHAR(I.SETUP_DATE, 'mmdd') = TO_CHAR(SYSDATE, 'mmdd');
  BEGIN
    FOR C_ROW IN C_CUST LOOP
      --countAll:�жϿͻ������Ƿ������ɵ������¼
      --û�У���ֱ�Ӳ���һ�������¼
      SELECT COUNT(*)
        INTO COUNTALL
        FROM (SELECT R.CREATION_DATE
                FROM SPM_CON_YEAR_REVIEW R
               WHERE R.ASSO_ID = C_ROW.CUST_ID
                 AND R.OWN_TYPE = '1'
                 AND TRUNC(R.CREATION_DATE) = TRUNC(SYSDATE))
       WHERE ROWNUM = 1;
      --countAll = 0 ��ʾ�ͻ�����û�����������¼
      IF COUNTALL = 0 THEN
        INSERT INTO SPM_CON_YEAR_REVIEW
          (REVIEW_ID,
           ASSO_ID,
           OWN_TYPE,
           RATING_SUGGEST,
           YEAR,
           STATUS,
           ITEM_KEY,
           ATTRIBUTE1,
           ATTRIBUTE2,
           ATTRIBUTE3,
           ATTRIBUTE4,
           ATTRIBUTE5,
           CREATED_BY,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           LAST_UPDATE_LOGIN,
           LAST_UPDATED_BY,
           REMARK,
           ORG_ID,
           SETUP_DATE,
           HANDLER,
           HAND_DEPT)
        VALUES
          (SPM_CON_YEAR_REVIEW_SEQ.NEXTVAL,
           C_ROW.CUST_ID,
           '1',
           '',
           TO_CHAR(SYSDATE, 'yyyy'),
           'J',
           '',
           '',
           '',
           '',
           '',
           '',
           '',
           SYSDATE,
           SYSDATE,
           '',
           '',
           '',
           C_ROW.ORG_ID,
           SYSDATE,
           '',
           '');
      END IF;
    END LOOP;
    FOR C_ROW IN C_VENDOR LOOP
      --countAll:�жϹ�Ӧ�̽����Ƿ������ɵ������¼
      --û�У���ֱ�Ӳ���һ�������¼
      SELECT COUNT(*)
        INTO COUNTALL
        FROM (SELECT R.CREATION_DATE
                FROM SPM_CON_YEAR_REVIEW R
               WHERE R.ASSO_ID = C_ROW.VENDOR_ID
                 AND R.OWN_TYPE = '2'
                 AND TRUNC(R.CREATION_DATE) = TRUNC(SYSDATE))
       WHERE ROWNUM = 1;
      --countAll = 0 ��ʾ��Ӧ�̽���û�����������¼
      IF COUNTALL = 0 THEN
        INSERT INTO SPM_CON_YEAR_REVIEW
          (REVIEW_ID,
           ASSO_ID,
           OWN_TYPE,
           RATING_SUGGEST,
           YEAR,
           STATUS,
           ITEM_KEY,
           ATTRIBUTE1,
           ATTRIBUTE2,
           ATTRIBUTE3,
           ATTRIBUTE4,
           ATTRIBUTE5,
           CREATED_BY,
           CREATION_DATE,
           LAST_UPDATE_DATE,
           LAST_UPDATE_LOGIN,
           LAST_UPDATED_BY,
           REMARK,
           ORG_ID,
           SETUP_DATE,
           HANDLER,
           HAND_DEPT)
        VALUES
          (SPM_CON_YEAR_REVIEW_SEQ.NEXTVAL,
           C_ROW.VENDOR_ID,
           '2',
           '',
           TO_CHAR(SYSDATE, 'yyyy'),
           'J',
           '',
           '',
           '',
           '',
           '',
           '',
           '',
           SYSDATE,
           SYSDATE,
           '',
           '',
           '',
           C_ROW.ORG_ID,
           SYSDATE,
           '',
           '');
      END IF;
    END LOOP;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      ROLLBACK;
  END SPM_CON_PRODUCE_YEAR_REVIEW;

  --��������htmlչ��
  FUNCTION CLS_CON_ENG_WF_HTML(P_KEY IN VARCHAR2,
                               
                               POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(20000);
    V_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConEng/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_ENG_TZSC(P_NOTIFID    IN VARCHAR2,
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_ENG',
                          'ENG_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_ENG_TZSC;

  --��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_ENG_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_ENG_TZH;

  --���̹����������̷���
  PROCEDURE SPM_CON_WF_ENG_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_ENG SET STATUS = 'C' WHERE ENG_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --���̲��ػص�
  PROCEDURE SPM_CON_WF_ENG_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_ENG SET STATUS = 'D' WHERE ENG_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         '',
                                         'JOB_ID',
                                         'ENG_ID');
  
  END;
  --����������׼�ص�
  PROCEDURE SPM_CON_WF_ENG_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         'STATUS',
                                         'JOB_ID',
                                         'ENG_ID');
  
  END;
  --��������ͨ���ص�
  PROCEDURE SPM_CON_WF_ENG_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_ENG SET STATUS = 'E' WHERE ENG_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         '',
                                         'JOB_ID',
                                         'ENG_ID');
  END;

  --��Ŀ����htmlչ��
  FUNCTION CLS_CON_PROJECT_WF_HTML(P_KEY IN VARCHAR2,
                                   
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(20000);
    V_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConProject/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��Ŀ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_PROJECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_PROJECT',
                          'PROJECT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_PROJECT_TZSC;

  --��Ŀ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PROJECT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PROJECT_TZH;

  --��Ŀ�����������̷���
  PROCEDURE SPM_CON_WF_PROJECT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    /*UPDATE Spm_Con_project SET STATUS = 'C' WHERE project_id = v_Id;*/
    UPDATE SPM_CON_PROJECT
       SET STATUS   = GET_WF_STATUS_BY_POSITION(OTYPECODE, PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE PROJECT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --��Ŀ���ػص�
  PROCEDURE SPM_CON_WF_PROJECT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_PROJECT SET STATUS = 'D' WHERE PROJECT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         '',
                                         'JOB_ID',
                                         'PROJECT_ID');
  
  END;
  --��Ŀ������׼�ص�
  PROCEDURE SPM_CON_WF_PROJECT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PROJECT_ID');
  END;
  --��Ŀ����ͨ���ص�
  PROCEDURE SPM_CON_WF_PROJECT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_PROJECT SET STATUS = 'E' WHERE PROJECT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         '',
                                         'JOB_ID',
                                         'PROJECT_ID');
  END;
  --��Ʊ��Ʊ����htmlչ��
  FUNCTION SPM_CON_RETURN_INVOICE_WF_HTML(P_KEY IN VARCHAR2,
                                          
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG  VARCHAR2(20000);
    P_ID NUMBER;
  BEGIN
    SELECT OUTPUT_INVOICE_ID
      INTO P_ID
      FROM SPM_CON_OUTPUT_INVOICE
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConReturnInvoice/edit/' || P_ID,
                                                P_KEY) || '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��Ʊ��Ʊ������������ͨ���󣬽���Ӧ��Ʊ��״̬����Ϊ�����˻ء�R��
  PROCEDURE SET_INVOICE_STATUS_TO_R(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) IS
  BEGIN
    UPDATE SPM_CON_OUTPUT_INVOICE V
       SET V.STATUS = 'R'
     WHERE V.OUTPUT_INVOICE_ID =
           (SELECT I.OUTPUT_INVOICE_ID
              FROM SPM_CON_OUTPUT_INVOICE I
             INNER JOIN SPM_CON_RETURN_INVOICE R
                ON I.OUTPUT_INVOICE_ID = R.OUTPUT_INVOICE_ID
               AND R.RETURN_INVOICE_ID =
                   (SELECT A.JOB_ID
                      FROM SPM_CON_WF_ACTIVITY A
                     WHERE A.ITEM_KEY = ITEMKEY));
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;

  --Ԥ���Ʊ����htmlչ��
  FUNCTION SPM_CON_IMP_INVOICE_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG                  VARCHAR2(20000);
    V_IMPREST_INVOICE_ID NUMBER;
  BEGIN
    SELECT IMPREST_INVOICE_ID
      INTO V_IMPREST_INVOICE_ID
      FROM SPM_CON_IMPREST_INVOICE
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmConImprestInvoice/edit/' ||
                                                V_IMPREST_INVOICE_ID,
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

  --���Ʊͨ����˺󣬽��������ݺ�����Ԥ�տ��д��Ԥ�տ�ʣ������
  PROCEDURE SET_RESIDUAL_AMOUNT(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) IS
    V_OUTPUT_INVOICE_ID NUMBER;
    CURSOR C_JOB IS
      SELECT *
        FROM SPM_CON_OUTPUT_VERIFIC V
       WHERE V.OUTPUT_INVOICE_ID = V_OUTPUT_INVOICE_ID;
    VERIFIC SPM_CON_OUTPUT_VERIFIC%ROWTYPE;
  BEGIN
    SELECT I.OUTPUT_INVOICE_ID
      INTO V_OUTPUT_INVOICE_ID
      FROM SPM_CON_OUTPUT_INVOICE I
     INNER JOIN SPM_CON_RETURN_INVOICE R
        ON I.OUTPUT_INVOICE_ID = R.OUTPUT_INVOICE_ID
       AND R.ITEM_KEY = ITEMKEY;
    OPEN C_JOB;
    LOOP
      FETCH C_JOB
        INTO VERIFIC;
    
      --ִ�и������
      UPDATE SPM_CON_RECEIPT C
         SET C.RESIDUAL_AMOUNT =
             (NVL(C.RESIDUAL_AMOUNT, 0) -
             NVL(VERIFIC.MATCH_IMPREST_AMOUNT, 0))
       WHERE C.RECEIPT_ID = VERIFIC.RECEIPT_ID;
      EXIT WHEN C_JOB%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(VERIFIC.RECEIPT_ID || '  ' ||
                           VERIFIC.MATCH_IMPREST_AMOUNT);
    END LOOP;
    CLOSE C_JOB;
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;

  --Ͷ�걣֤�����htmlչ��
  FUNCTION SPM_CON_BID_DEPOSIT_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG              VARCHAR2(20000);
    V_BID_DEPOSIT_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_BID_DEPOSIT_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConBidDeposit/edit/' ||
                                                   V_BID_DEPOSIT_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --Ͷ�걣֤������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_BID_DEPOSIT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BID_DEPOSIT',
                          'DEPOSIT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_BID_DEPOSIT_TZSC_AFTER;

  --Ͷ�걣֤������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_BID_DEPOSIT_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BID_DEPOSIT_TZCL_AFTER;

  --Ͷ�걣֤���ύ����ʱ��
  /*  procedure spm_con_bid_deposit_wf_TJ(itemkey      in varchar2,
                                    otypecode    in varchar2,
                                    pPosition_id in number) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE DEPOSIT_ID = v_Id;
    --��Ͷ�걣֤��״̬ת��Ϊ�������С�B��
    \*update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'B'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  end;*/

  --Ͷ�걣֤������������׼�ص�����
  /*PROCEDURE spm_con_bid_deposit_wf_PZ(p_Key        In Varchar2,
                                     p_Otype_Code In VARCHAR2,
                                     vPositoin_id in VARCHAR2) AS
  BEGIN
    SAVE_WF_HISTORY(p_Key,
                    p_Otype_Code,
                    'SPM_CON_BID_DEPOSIT',
                    'STATUS',
                    'JOB_ID',
                    'DEPOSIT_ID');
  END spm_con_bid_deposit_wf_PZ;*/

  --Ͷ�걣֤�������������ͨ���ص�
  /*procedure spm_con_bid_deposit_wf_TG(itemkey   in varchar2,
                                    otypecode in varchar2) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = 'E' WHERE DEPOSIT_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_DEPOSIT',
                                         '',
                                         'JOB_ID',
                                         'DEPOSIT_ID');
  
    --����Ӧ��Ͷ�걣֤��״̬����Ϊ����ͨ��������ͨ����C��
    \*update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'C'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  end;*/

  --Ͷ�걣֤���������̲���ʱ
  /*procedure spm_con_bid_deposit_wf_BH(itemkey   in varchar2,
                                    otypecode in varchar2) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = 'D' WHERE DEPOSIT_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_DEPOSIT',
                                         '',
                                         'JOB_ID',
                                         'DEPOSIT_ID');
  
    --��Ͷ�걣֤��״̬ת��Ϊ��δͨ����D��
   \* update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'D'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  end;*/

  --�¶��ո���ƻ�����htmlչ��
  FUNCTION SPM_CON_MONTH_PLAN_WF_HTML(P_KEY IN VARCHAR2,
                                      
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG             VARCHAR2(20000);
    V_MONTH_PLAN_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_MONTH_PLAN_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConMonthPlan/edit/' ||
                                                   V_MONTH_PLAN_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  --�¶��ո���ƻ��������̷���
  /*procedure spm_con_month_plan_wf_TJ(itemkey      in varchar2,
                                     otypecode    in varchar2,
                                     pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̷����,��ҵ���״̬����ΪC ��һ���ڵ�״̬
    UPDATE SPM_CON_MONTH_PLAN SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE MONTH_PLAN_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/
  --�¶��ո���ƻ�����������׼�ص�����
  PROCEDURE SPM_CON_MONTH_PLAN_WF_PZ(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = P_KEY;
  
    UPDATE SPM_CON_MONTH_DETAIL T
       SET T.GROUP_OFFICE_COMMENT = 3, T.BUDGET_OFFICE_COMMENT = 3
     WHERE T.MONTH_DETAIL_ID IN
           (SELECT S.MONTH_DETAIL_ID
              FROM SPM_CON_MONTH_DETAIL S
             WHERE S.DEPARTMENT_COMMENT = 3
               AND S.MONTH_PLAN_ID = V_ID);
  
  END SPM_CON_MONTH_PLAN_WF_PZ;

  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_MONTH_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = P_ITEMKEY;
  
    UPDATE SPM_CON_MONTH_DETAIL T
       SET T.GROUP_OFFICE_COMMENT = 3, T.BUDGET_OFFICE_COMMENT = 3
     WHERE T.MONTH_DETAIL_ID IN
           (SELECT S.MONTH_DETAIL_ID
              FROM SPM_CON_MONTH_DETAIL S
             WHERE S.DEPARTMENT_COMMENT = 3
               AND S.MONTH_PLAN_ID = V_ID);
  
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_MONTH_PLAN',
                          'MONTH_PLAN_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_MONTH_PLAN_TZSC_AFTER;

  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ����ǰ��
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
    V_ID          VARCHAR2(40);
    COU           NUMBER;
    V_STATUS      VARCHAR2(40);
    V_STATUS_NAME VARCHAR2(40);
  BEGIN
    SELECT S.JOB_ID, S.STATUS
      INTO V_ID, V_STATUS
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_KEY;
  
    COU := 0;
  
    IF V_STATUS = 'BM' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.DEPARTMENT_COMMENT IS NULL
         AND S.MONTH_PLAN_ID = V_ID;
    ELSIF V_STATUS = 'YS' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.BUDGET_OFFICE_COMMENT IS NULL
         AND S.MONTH_PLAN_ID = V_ID;
    ELSIF V_STATUS = 'JT' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.GROUP_OFFICE_COMMENT IS NULL
         AND S.MONTH_PLAN_ID = V_ID;
    ELSIF V_STATUS = 'CW' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.MATCH_PROJECT IS NULL
         AND S.MONTH_PLAN_ID = V_ID;
    
    END IF;
  
    V_STATUS_NAME := SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_MONTH_PLAN_STATUS',
                                                             V_STATUS);
  
    IF P_OPER_RESULT = 'Y' THEN
      IF COU > 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '' || V_STATUS_NAME || '���������Ϊ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END;

  --�¶��ո���ƻ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_MONTH_PLAN_TZCL_AFTER;

  --�¶��ո���ƻ���������ͨ���ص�
  /*procedure spm_con_month_plan_wf_TG(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_MONTH_PLAN SET STATUS = 'E' WHERE MONTH_PLAN_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_MONTH_PLAN',
                                         '',
                                         'JOB_ID',
                                         'MONTH_PLAN_ID');
  END;*/
  --�¶��ո���ƻ������ػص�
  PROCEDURE SPM_CON_MONTH_PLAN_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    UPDATE SPM_CON_MONTH_DETAIL T
       SET T.DEPARTMENT_COMMENT = NULL,
           /* t.budget_office_comment = null,
           t.group_office_comment  = null,*/
           T.MATCH_PROJECT = NULL
     WHERE T.MONTH_PLAN_ID = V_ID;
  
  END;

  --�¶ȼƻ����ܹ���htmlչ��
  FUNCTION SPM_CON_MONTHGATHER_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG                    VARCHAR2(20000);
    V_MONTH_PLAN_GATHER_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_MONTH_PLAN_GATHER_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConMonthPlanGather/edit/' ||
                                                   V_MONTH_PLAN_GATHER_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  --�¶ȼƻ����ܹ���������׼�ص�����
  PROCEDURE SPM_CON_MONTHGATHER_WF_PZ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = P_KEY;
  
    UPDATE SPM_CON_MONTH_DETAIL T
       SET T.GROUP_OFFICE_COMMENT = 3
     WHERE T.MONTH_DETAIL_ID IN
           (SELECT S.MONTH_DETAIL_ID
              FROM SPM_CON_MONTH_DETAIL S
             WHERE S.BUDGET_OFFICE_COMMENT = 3
               AND S.MONTH_PLAN_ID IN
                   (SELECT W.MONTH_PLAN_ID
                      FROM SPM_CON_MONTH_PLAN W
                     WHERE W.MONTH_PLAN_GATHER_ID = V_ID));
  END;

  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_MONTHGATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_MONTH_PLAN_GATHER',
                          'MONTH_PLAN_GATHER_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END;

  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ����ǰ��
  PROCEDURE SPM_CON_MONTHGATH_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
    V_ID          VARCHAR2(40);
    COU           NUMBER;
    V_STATUS      VARCHAR2(40);
    V_STATUS_NAME VARCHAR2(40);
  BEGIN
    SELECT S.JOB_ID, S.STATUS
      INTO V_ID, V_STATUS
      FROM SPM_CON_WF_ACTIVITY S
     WHERE S.ITEM_KEY = P_KEY;
  
    COU := 0;
  
    IF V_STATUS = 'BM' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.DEPARTMENT_COMMENT IS NULL
         AND S.MONTH_PLAN_ID IN
             (SELECT W.MONTH_PLAN_ID
                FROM SPM_CON_MONTH_PLAN W
               WHERE W.MONTH_PLAN_GATHER_ID = V_ID)
         AND S.DEPARTMENT_COMMENT != 3;
    ELSIF V_STATUS = 'YS' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.BUDGET_OFFICE_COMMENT IS NULL
         AND S.MONTH_PLAN_ID IN
             (SELECT W.MONTH_PLAN_ID
                FROM SPM_CON_MONTH_PLAN W
               WHERE W.MONTH_PLAN_GATHER_ID = V_ID)
         AND S.DEPARTMENT_COMMENT != 3;
    ELSIF V_STATUS = 'JT' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.GROUP_OFFICE_COMMENT IS NULL
         AND S.MONTH_PLAN_ID IN
             (SELECT W.MONTH_PLAN_ID
                FROM SPM_CON_MONTH_PLAN W
               WHERE W.MONTH_PLAN_GATHER_ID = V_ID)
         AND S.DEPARTMENT_COMMENT != 3;
    ELSIF V_STATUS = 'CW' THEN
      SELECT COUNT(*)
        INTO COU
        FROM SPM_CON_MONTH_DETAIL S
       WHERE S.MATCH_PROJECT IS NULL
         AND S.MONTH_PLAN_ID IN
             (SELECT W.MONTH_PLAN_ID
                FROM SPM_CON_MONTH_PLAN W
               WHERE W.MONTH_PLAN_GATHER_ID = V_ID)
         AND S.DEPARTMENT_COMMENT != 3;
    
    END IF;
  
    V_STATUS_NAME := SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_MONTH_PLAN_STATUS',
                                                             V_STATUS);
  
    IF P_OPER_RESULT = 'Y' THEN
      IF COU > 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '' || V_STATUS_NAME || '���������Ϊ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END;

  --�¶ȼƻ����ܹ�������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_MONTHGATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --�¶ȼƻ����ܹ����ػص�
  PROCEDURE SPM_CON_MONTHGATHER_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    UPDATE SPM_CON_MONTH_DETAIL T
       SET T.BUDGET_OFFICE_COMMENT = NULL, T.GROUP_OFFICE_COMMENT = NULL /*,
                                                                                                                           t.match_project         = null*/
     WHERE T.MONTH_PLAN_ID IN
           (SELECT S.MONTH_PLAN_ID
              FROM SPM_CON_MONTH_PLAN S
             WHERE S.MONTH_PLAN_GATHER_ID = V_ID);
  
  END;

  --�ܶ��ո���ƻ�����htmlչ��
  FUNCTION SPM_CON_WEEK_PLAN_WF_HTML(P_KEY IN VARCHAR2,
                                     
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG            VARCHAR2(20000);
    V_WEEK_PLAN_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_WEEK_PLAN_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConWeekPlan/edit/' ||
                                                   V_WEEK_PLAN_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�ܶ��ո���ƻ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_WEEK_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_WEEK_PLAN',
                          'WEEK_PLAN_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_WEEK_PLAN_TZSC_AFTER;

  --�ܶ��ո���ƻ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_WEEK_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_WEEK_PLAN_TZCL_AFTER;

  --�ܶ��ո���ƻ��������̷���
  /*procedure spm_con_week_plan_wf_TJ(itemkey      in varchar2,
                                     otypecode    in varchar2,
                                     pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̷����,��ҵ���״̬����ΪC ��һ���ڵ�״̬
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE WEEK_PLAN_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/
  --�ܶ��ո���ƻ�����������׼�ص�����
  /*PROCEDURE spm_con_week_plan_wf_PZ(p_Key        In Varchar2,
                                     p_Otype_Code In VARCHAR2,
                                     vPositoin_id in VARCHAR2) AS
  BEGIN
    SAVE_WF_HISTORY(p_Key,
                    p_Otype_Code,
                    'SPM_CON_WEEK_PLAN',
                    'STATUS',
                    'JOB_ID',
                    'WEEK_PLAN_ID');
  END spm_con_week_plan_wf_PZ;*/
  --�ܶ��ո���ƻ���������ͨ���ص�
  /*procedure spm_con_week_plan_wf_TG(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = 'E' WHERE WEEK_PLAN_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_WEEK_PLAN',
                                         '',
                                         'JOB_ID',
                                         'WEEK_PLAN_ID');
  END;*/
  --�ܶ��ո���ƻ������ػص�
  /*procedure spm_con_week_plan_wf_BH(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = 'D' WHERE WEEK_PLAN_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_WEEK_PLAN',
                                         '',
                                         'JOB_ID',
                                         'WEEK_PLAN_ID');
  
  END;*/

  --�ܶȼƻ����ܹ���htmlչ��
  FUNCTION SPM_CON_WEEK_GATHER_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG  VARCHAR2(20000);
    V_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConWeekPlanGather/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�ܶȼƻ����ܹ�������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_WEEK_GATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_WEEK_PLAN_GATHER',
                          'WEEK_PLAN_GATHER_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END;

  --�ܶȼƻ����ܹ�������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_WEEK_GATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --Ͷ�����htmlչ��
  FUNCTION SPM_CON_BID_INFO_WF_HTML(P_KEY IN VARCHAR2,
                                    
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG      VARCHAR2(20000);
    V_BID_ID NUMBER;
  
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_BID_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConBidInfo/edit/' ||
                                                   V_BID_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --Ͷ��������̷���
  /*procedure spm_con_bid_info_wf_TJ(itemkey      in varchar2,
                                   otypecode    in varchar2,
                                   pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̷����,��ҵ���״̬����Ϊ��Ӧ�ڵ�
    UPDATE SPM_CON_BID_INFO SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE BID_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/

  --Ͷ��������̻�ǩ�ص�����
  PROCEDURE SPM_CON_BID_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
  
    SPM_CON_START_HQ(P_KEY, VPOSITOIN_ID);
  
  END SPM_CON_BID_INFO_WF_HQ;

  --Ͷ���������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_BID_INFO_WF_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BID_INFO',
                          'BID_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_BID_INFO_WF_TZSC_AFTER;

  --Ͷ���������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_BID_INFO_WF_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BID_INFO_WF_TZCL_AFTER;

  --Ͷ��������̲�����֤�ص�������֪ͨ����ǰ��
  /*PROCEDURE spm_con_bid_info_wf_TZCL_BEFORE(p_Key        In Varchar2,
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
          cou := spm_con_rebut_reason_wf_vali(v_info);
          IF cou=0 THEN
             FND_MESSAGE.SET_NAME('CUX', '��ʾ');
             FND_MESSAGE.SET_TOKEN('��Ϣ', '����ԭ��ƥ��');
             APP_EXCEPTION.RAISE_EXCEPTION;
          END IF;
  
  
      END IF;
  
  END ;  */

  --Ͷ���������ͨ���ص�
  PROCEDURE SPM_CON_BID_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID            VARCHAR2(40);
    V_IS_URGENT_END CHAR(1);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT S.IS_URGENT_END
      INTO V_IS_URGENT_END
      FROM SPM_CON_BID_INFO S
     WHERE S.BID_ID = V_ID;
  
    --����ǽ���������ͨ�������׼����ʱ�����Ƿ񲹳��׼����״̬
  
    IF V_IS_URGENT_END = 'Y' THEN
      UPDATE SPM_CON_BID_INFO SET IS_ADD_PROCESS = 'Y' WHERE BID_ID = V_ID;
    END IF;
  
  END;

  --Ͷ������ػص�
  /*  procedure spm_con_bid_info_wf_BH(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BID_INFO SET STATUS = 'D' WHERE BID_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  
  END;*/
  --Ͷ������������֪ͨ�ص�����(֪ͨ���ɺ�)
  PROCEDURE SPM_CON_BID_URGENT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BID_INFO',
                          'BID_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'UD',
                          'UE');
  END SPM_CON_BID_URGENT_TZSC_AFTER;

  --Ͷ������������֪ͨ�ص�������֪ͨ�����
  /*  PROCEDURE spm_con_bid_urgent_TZCL_AFTER(p_Key        In Varchar2,
                                  p_Otype_Code In VARCHAR2,
                                  p_notifid In VARCHAR2,
                                  p_oper_result In VARCHAR2) AS
  begin
      UPDATE_HISTORY_INFO(p_Key,p_Otype_Code,p_notifid,p_oper_result);
  END spm_con_bid_urgent_TZCL_AFTER; */

  --Ͷ������������ͨ���ص�
  PROCEDURE SPM_CON_BID_URGENT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_BID_INFO SET IS_URGENT_END = 'Y' WHERE BID_ID = V_ID;
  
  END;
  --Ͷ�����������ػص�
  /*procedure spm_con_bid_urgent_wf_BH(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BID_INFO SET STATUS = 'UD' WHERE BID_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  
  END;*/

  --Ͷ������б�ȷ�����̷���
  PROCEDURE SPM_CON_BID_CONFIRM_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̷����,��ҵ���״̬����Ϊ��Ӧ�ڵ�
    UPDATE SPM_CON_BID_INFO SET BID_RESULT = '���б�' WHERE BID_ID = V_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --Ͷ������б�ȷ������֪ͨ�ص�����(֪ͨ���ɺ�)
  PROCEDURE SPM_CON_BID_CONFIRM_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BID_INFO',
                          'BID_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'CDE',
                          'CE');
  END SPM_CON_BID_CONFIRM_TZSC_AFTER;

  --Ͷ������б�ȷ��������׼�ص�����
  /*PROCEDURE spm_con_bid_confirm_wf_PZ(p_Key        In Varchar2,
                                     p_Otype_Code In VARCHAR2,
                                     vPositoin_id in VARCHAR2) AS
     v_p_position_id number;
     v_p_Id number;
     v_status varchar2(20);
     begin
  
       SAVE_WF_HISTORY(p_Key,
                    p_Otype_Code,
                    'SPM_CON_BID_INFO',
                    'STATUS',
                    'JOB_ID',
                    'BID_ID');
  
  END ;*/
  --Ͷ������б�ȷ��ͨ���ص�
  /* procedure spm_con_bid_confirm_wf_TG(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --����ͨ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_BID_INFO SET STATUS = 'CE' WHERE BID_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  END;*/
  --Ͷ������б�ȷ�ϲ��ػص�
  PROCEDURE SPM_CON_BID_CONFIRM_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BID_INFO SET BID_RESULT = NULL WHERE BID_ID = V_ID;
  
  END;

  --�տ����HTMLչ��
  FUNCTION CLS_RECEIPT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG          VARCHAR2(20000);
    V_RECEIPT_ID NUMBER;
  BEGIN
    SELECT RECEIPT_ID
      INTO V_RECEIPT_ID
      FROM SPM_CON_RECEIPT
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmEmWorkOrder/edit/' ||
                                                V_RECEIPT_ID,
                                                P_KEY) || '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  --�����ƻ�ά���������������󣬽���Ӧ������״̬����Ϊ��goods_wf_status Ϊ1
  PROCEDURE SET_GOODS_WF_STATUS_TO_1(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) IS
  BEGIN
  
    UPDATE SPM_CON_HT_TARGET T
       SET T.GOODS_WF_STATUS = '1'
     WHERE T.MATERIAL_CODE = (SELECT R.MATERIAL_CODE
                                FROM SPM_CON_HT_TARGET R
                               INNER JOIN SPM_CON_GOODS_PLAN I
                                  ON I.CONTRACT_ID = R.CONTRACT_ID
                                 AND I.ITEM_KEY = ITEMKEY
                              
                              );
  
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- �ع�����
      ROLLBACK;
  END;

  --�ո���ƻ�ά������htmlչ��
  FUNCTION SPM_CON_CLAUSE_PLAN_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG              VARCHAR2(20000);
    V_CLAUSE_PLAN_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_CLAUSE_PLAN_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConClausePlan/edit/' ||
                                                   V_CLAUSE_PLAN_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�ո���ƻ�ά���������̷���
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --��������ٴ����뽫�ϴ�����״̬��Ϊnull
    UPDATE SPM_CON_HT_CLAUSE A
       SET A.STATUS = NULL
     WHERE A.CLAUSE_ID IN
           (SELECT S.CLAUSE_ID
              FROM SPM_CON_HT_CLAUSE S
             WHERE S.CONTRACT_ID =
                   (SELECT T.CONTRACT_ID
                      FROM SPM_CON_CLAUSE_PLAN T
                     WHERE T.CLAUSE_PLAN_ID = V_ID));
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --�ո���ƻ�ά����������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_CLAUSE_PLAN',
                          'CLAUSE_PLAN_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CLAUSE_PLAN_TZSC_AFTER;

  --�ո���ƻ�ά����������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CLAUSE_PLAN_TZCL_AFTER;

  --�ո���ƻ�ά������������׼�ص�����
  /*PROCEDURE spm_con_clause_plan_wf_PZ(p_Key        In Varchar2,
                                     p_Otype_Code In VARCHAR2,
                                     vPositoin_id in VARCHAR2) AS
  BEGIN
    SAVE_WF_HISTORY(p_Key,
                    p_Otype_Code,
                    'SPM_CON_CLAUSE_PLAN',
                    'STATUS',
                    'JOB_ID',
                    'CLAUSE_PLAN_ID');
  END spm_con_clause_plan_wf_PZ;*/
  --�ո���ƻ�ά����������ͨ���ص�
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͨ��������״̬��ΪE
  
    UPDATE SPM_CON_HT_CLAUSE A
       SET A.STATUS = 'E'
     WHERE A.CLAUSE_ID IN
           (SELECT S.CLAUSE_ID
              FROM SPM_CON_HT_CLAUSE S
             WHERE S.CLAUSE_DATE IS NOT NULL
               AND S.CONTRACT_ID =
                   (SELECT T.CONTRACT_ID
                      FROM SPM_CON_CLAUSE_PLAN T
                     WHERE T.CLAUSE_PLAN_ID = V_ID));
  
  END;

  --�ո���ƻ�ά�������ػص�
  /*procedure spm_con_clause_plan_wf_BH(itemkey   IN VARCHAR2,
                                      otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_CLAUSE_PLAN
       SET STATUS = 'D'
     WHERE CLAUSE_PLAN_ID = v_Id;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_CLAUSE_PLAN',
                                         '',
                                         'JOB_ID',
                                         'CLAUSE_PLAN_ID');
  
  END;*/

  --�������ӹ���htmlչ��
  FUNCTION SPM_CON_HANDOV_INFO_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG                VARCHAR2(20000);
    V_HANDOVER_INFO_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_HANDOVER_INFO_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConHandoverInfo/edit/' ||
                                                   V_HANDOVER_INFO_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --������������֪ͨ�ص�������֪ͨ���ɺ�
  PROCEDURE SPM_CON_HANDOV_INFO_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2) AS
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_HANDOVER_INFO',
                          'HANDOVER_INFO_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END;

  --������������֪ͨ�ص�������֪ͨ�����
  PROCEDURE SPM_CON_HANDOV_INFO_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --�������ӹ������̻�ǩ�ص�����
  PROCEDURE SPM_CON_HANDOV_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
  
    SPM_CON_START_HQ(P_KEY, VPOSITOIN_ID);
  
  END;

  --������������
  FUNCTION CLS_PAYMENT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG          VARCHAR2(20000);
    V_PAYMENT_ID NUMBER;
  BEGIN
    SELECT PAYMENT_ID
      INTO V_PAYMENT_ID
      FROM SPM_CON_PAYMENT
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                'WF_URL=/spmEmWorkOrder/edit/' ||
                                                V_PAYMENT_ID,
                                                P_KEY) || '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --ѡ�������Ա�ص�����
  PROCEDURE SALES_ORDER_PERSON_PR(P_KEY                  VARCHAR2,
                                  POTYPE_CODE            VARCHAR2,
                                  VGROUP_ID              NUMBER,
                                  VPOSITION_STRUCTURE_ID NUMBER,
                                  VPOSITOIN_ID           VARCHAR2) IS
    /*    statusFlag Varchar2(10);
    tableName  Varchar2(50);
    keyName    Varchar2(50);
    vSql       VARCHAR2(2000);
    cSql       varchar2(2000);
    q_id       number;
    job_id     number;
    cou        number;*/
    V_NUMBER   NUMBER;
    V_USERNAME VARCHAR2(40);
  BEGIN
    /*select wf_tab_name, wf_tab_keyname
      into tableName, keyName
      from Spm_Wf_Reginfo
     where wf_code = potype_code;
    -- insert into spm_debug values('888#',tableName,sysdate);
    -- insert into spm_debug values('999#',keyName,sysdate);
    vSql := 'SELECT ' || keyName || ', nvl(status,''A''),job_id  FROM ' ||
            tableName || ' WHERE item_key=' || '''' || p_key || '''';
    -- insert into spm_debug values('000#',vSql,sysdate);
    Execute Immediate Vsql
      INTO q_id, statusFlag, job_id;
    
    cSql := 'select count(1) from ' || tableName || ' where job_id=' ||
            job_id || ' and wf_code=' || '''' || potype_code || '''';
    Execute Immediate cSql
      INTO cou;
    -- select t.sales_order_id,nvl(t.status,'A') into q_id,statusFlag from spm_con_sales_order t where t.item_key = p_key;
    --insert into spm_debug values('1#1',statusFlag,sysdate);
    --����Ƿ�Ϊ��һ����*/
  
    --ֻ��Ե�һ���ڵ���д���
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM (SELECT COUNT(*), S.GROUP_ID
              FROM CCM_WF_USER_GROUP S
             WHERE S.ITEMKEY = P_KEY
             GROUP BY S.GROUP_ID);
  
    IF V_NUMBER = 1 THEN
      /**
      ��ָ̬��������Աʱ ��ɾ���ض����õ�������Ա
      ��ָ��������ĳЩ�����ڵ�����Ҫ���ö�̬ѡ��
      ��̬ѡ������Աʱ���ô˴���
      **/
      SELECT SPM_EAM_COMMON_PKG.GET_USERNAME_BY_PERSONID(T.ASS_ID)
        INTO V_USERNAME
        FROM SPM_WF_RECEIVER T
       WHERE 1 = 1 --t.position_id = vPositoin_id
         AND T.RECEIVER_ID = (SELECT S.JOB_ID
                                FROM SPM_CON_WF_ACTIVITY S
                               WHERE S.ITEM_KEY = P_KEY)
         AND T.OTYPE_CODE = POTYPE_CODE
         AND T.ITEM_KEY IS NULL;
    
      IF V_USERNAME IS NULL THEN
        RETURN;
      END IF;
      DELETE CCM_WF_USER_GROUP CG WHERE CG.GROUP_ID = VGROUP_ID;
      --д����Ա
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
         WHERE 1 = 1 --t.position_id = vPositoin_id
           AND T.RECEIVER_ID = (SELECT S.JOB_ID
                                  FROM SPM_CON_WF_ACTIVITY S
                                 WHERE S.ITEM_KEY = P_KEY)
           AND T.OTYPE_CODE = POTYPE_CODE
           AND T.ITEM_KEY IS NULL;
    
    END IF;
    COMMIT;
  END;
  ---�õ��������ĳ�ʼְλID------
  FUNCTION SPM_GET_FIRST_POSITION_ID(P_TABLE_NAME VARCHAR2,
                                     P_OTYPE_CODE VARCHAR2) RETURN VARCHAR2 IS
    VRETURN   VARCHAR2(100);
    VPLANCODE VARCHAR2(100);
    V_PLAN_ID NUMBER;
  BEGIN
    -- if p_otype_code = 'SPM_TASK_WF' then
    SELECT SR.OTYPE_NAME
      INTO VPLANCODE
      FROM SPM_WF_REGINFO SR
     WHERE SR.WF_CODE = P_OTYPE_CODE
       AND SR.WF_TAB_NAME = P_TABLE_NAME
       AND ROWNUM < 2;
  
    SELECT CP.WF_PLAN_ID
      INTO V_PLAN_ID
      FROM CCM_WF_PLAN CP
     WHERE CP.WF_PLAN_CODE = VPLANCODE;
  
    ----�õ�����ְλID
    SELECT WF_PLAN_POSITION_ID
      INTO VRETURN
      FROM CCM_WF_PLAN_POSITION D
     WHERE D.WF_PLAN_ID = V_PLAN_ID
       AND ROWNUM < 2
       AND D.WF_PLAN_POSITION_ID NOT IN
           (SELECT UP_WF_PLAN_POSITION_ID
              FROM CCM_WF_PLAN_POSITION
             WHERE UP_WF_PLAN_POSITION_ID IS NOT NULL);
  
    --end if;
    RETURN VRETURN;
  END;

  --�õ��������ĳ�ʼְλID------�ڶ���������ͨ��������������ǰ�ڻ�ȡpositonId��
  FUNCTION SPM_CON_GET_FIRST_POSITION_ID(P_KEY       IN VARCHAR2,
                                         POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
  
    P_ORG_ID      NUMBER;
    P_DEPT_ID     NUMBER;
    P_PLAN_ID     NUMBER;
    P_POSITION_ID NUMBER;
  
    PISIMMECHEK VARCHAR2(20);
    VITEM_KEY   VARCHAR2(20);
  
    V_ERROR0 EXCEPTION;
    V_ERROR1 EXCEPTION;
    V_ERROR2 EXCEPTION;
    V_ERROR3 EXCEPTION;
  
    V_POCESS_STATUS VARCHAR2(100);
  
    VIEWTABLE SPM_WF_REGINFO.WF_TAB_NAME%TYPE;
    VIEWKEY   SPM_WF_REGINFO.WF_TAB_KEYNAME%TYPE;
    VIEWID    SPM_WF_REGINFO.WF_ID_NAME%TYPE;
    VIEWSTATE SPM_WF_REGINFO.WF_STATE_NAME%TYPE;
    VIEWTITLE SPM_WF_REGINFO.TITLE_WF_SHOW%TYPE;
    CUSPRO    SPM_WF_REGINFO.WF_START_PR%TYPE;
    EBSFUN    SPM_WF_REGINFO.WF_MGS_FORM_PR%TYPE;
  
    D_SQL         VARCHAR2(1000);
    V_WFTITLE_SQL VARCHAR2(4000);
    V_WFTITLE     VARCHAR2(400);
    V_EAMWF       VARCHAR2(40); /*��eamģ���ʶ��2017��07��20��*/
    VWF_PROCESS   VARCHAR2(100) := 'PRO_AUDITE';
  BEGIN
    /*��ʼ������
    declare
    
         l_resp_id number;
         l_resp_app_id number;
         l_user_id number;
        begin
            select t.application_id,t.responsibility_id into l_resp_app_id,l_resp_id from fnd_responsibility_vl t where t.RESPONSIBILITY_NAME='532002_PA_�Ƶ�������Ŀ�����û�';
            select t.user_id into l_user_id from spm_eam_all_people_v t where t.USER_name='MTL_SETUP';
            fnd_global.APPS_INITIALIZE(l_user_id,l_resp_id,l_resp_app_id);
            DBMS_OUTPUT.put_line('respId,respAppId,userId,orgId:'||l_resp_id||','||l_resp_app_id||','||l_user_id||','||spm_sso_pkg.getOrgId);
        end;
    */
    /* fnd_global.apps_initialize(2188,51640,20003);*/
  
    P_ORG_ID := NVL(FND_PROFILE.VALUE('CCM:WF_ORG'), 5068);
    BEGIN
      --�õ��߹�������¼���������ֶ����������ֶΣ�״̬�ֶΣ��ص�ORACLE����
      SELECT WF_TAB_NAME,
             WF_TAB_KEYNAME,
             WF_ID_NAME,
             WF_STATE_NAME,
             TITLE_WF_SHOW,
             WF_START_PR,
             NVL(WF_MGS_FORM_PR, ''),
             WF_TITLE_SQL,
             NVL(EAM_WF, 'N')
        INTO VIEWTABLE,
             VIEWKEY,
             VIEWID,
             VIEWSTATE,
             VIEWTITLE,
             CUSPRO,
             EBSFUN,
             V_WFTITLE_SQL,
             V_EAMWF
        FROM SPM_WF_REGINFO
       WHERE WF_CODE = POTYPE_CODE;
    
      --�ж���SPM������ע������Ƿ�ע��
      --�õ���������
      /*
            Select 'CCM' || Ltrim(To_Char(Ccm_Wf_Itemkey_Seq.Nextval))
              Into Vitem_Key
              From Dual;
      */
      --��CCM_IDд������
      /* D_Sql := 'update ' || Viewtable || ' set ' || Viewid || '=:v1 where ' ||
                     Viewkey || '=:v2';
            Execute Immediate D_Sql
              Using Vitem_Key, P_Key;
      
            if nvl(v_wftitle_sql, 'none') <> 'none' then
              begin
                execute immediate v_wftitle_sql
                  into v_wftitle
                  using in vItem_key;
                Viewtitle := Viewtitle || '-' || v_wftitle;
              exception
                when others then
                  null;
              end;
            end if;
      */
      --ִ�лص�����������������̱���
      --If Trim(Cuspro) Is Not Null and v_eamwf = 'N' Then
      /*��� 2017��07��20�� ����������ֻ�������������,spm eam���������ص���spm_wf_p�� */
      /* Begin
          D_Sql := 'begin ' || Cuspro || '(:v1, :v2, :v3, :v4); end;';
          Execute Immediate D_Sql
            Using In Vitem_Key, In P_Key, In Potype_Code, In Out Viewtitle;
        Exception
          When Others Then
            Raise V_Error3;
        End;
      End If;
      commit;*/
      --�ж��Ƿ���������
      SELECT DECODE(COUNT(OP_ID), 0, 'N', 'Y')
        INTO PISIMMECHEK
        FROM CCM_WF_AUTO_AUDITE CWOP
       WHERE CWOP.OTYPE_CODE = POTYPE_CODE
         AND SPM_WF_P.GET_CHECK_IS_AUTO_CHECK(CWOP.OTYPE_CODE,
                                              CWOP.OP_ID,
                                              VITEM_KEY,
                                              VIEWID) = 'Y'
         AND CWOP.WF_ORG_ID = P_ORG_ID;
    
      IF PISIMMECHEK = 'N' THEN
        BEGIN
        
          --ȡ��¼�˲���ID���������ң�
          SELECT T.ORGANIZATION_ID
            INTO P_DEPT_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE ROWNUM < 2
             AND T.BELONGORGID = SPM_SSO_PKG.GETORGID
             AND T.USER_ID = SPM_SSO_PKG.GETUSERID;
        
          IF P_DEPT_ID IS NOT NULL THEN
            BEGIN
              --ȡ��������
              SELECT CWOP.POSITION_STRUCTURE_ID
                INTO P_PLAN_ID
                FROM CCM_WF_PLAN CWP, CCM_WF_OTYPE_POSITION CWOP
                LEFT JOIN CCM_WF_OTYPE_POSITION_DTL CWOPD
                  ON CWOP.OP_ID = CWOPD.OP_ID
               WHERE CWP.WF_PLAN_ID = CWOP.POSITION_STRUCTURE_ID
                 AND CWOP.OTYPE_CODE = POTYPE_CODE
                 AND CWOPD.COLUMN_VALUES = '' || P_DEPT_ID || ''
                 AND CWOP.WF_ORG_ID = P_ORG_ID
                 AND SPM_CON_CONTRACT_PKG.GET_CHECK_POSITION_STRU(CWOP.OTYPE_CODE,
                                                                  CWOP.POSITION_STRUCTURE_ID,
                                                                  VITEM_KEY,
                                                                  VIEWID) = 'Y'
                 AND ROWNUM < 2;
            
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                RAISE V_ERROR1;
            END;
          END IF;
          --ȡ����ְλ
          BEGIN
            SELECT WF_PLAN_POSITION_ID
              INTO P_POSITION_ID
              FROM CCM_WF_PLAN_POSITION D
             WHERE D.WF_PLAN_ID = P_PLAN_ID
               AND ROWNUM < 2
               AND D.WF_PLAN_POSITION_ID NOT IN
                   (SELECT UP_WF_PLAN_POSITION_ID
                      FROM CCM_WF_PLAN_POSITION
                     WHERE UP_WF_PLAN_POSITION_ID IS NOT NULL)
               AND D.WF_PLAN_POSITION_ID IN
                   (SELECT WF_PLAN_POSITION_ID
                      FROM CCM_WF_PLAN_POSITION_USER);
          
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              RAISE V_ERROR2;
          END;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            RAISE V_ERROR1;
        END;
        BEGIN
          SELECT SD.DICT_CODE
            INTO V_POCESS_STATUS
            FROM SPM_WF_PLAN_CAN_M SM, SPM_DICT SD
           WHERE SM.STATUS = SD.DICT_ID
             AND SM.PLAN_ID = P_POSITION_ID;
        EXCEPTION
          WHEN OTHERS THEN
            V_POCESS_STATUS := 'C';
        END;
      
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE V_ERROR0;
      
    END;
    RETURN P_POSITION_ID;
  EXCEPTION
    WHEN V_ERROR0 THEN
      FND_MESSAGE.SET_NAME('CUX', '�쳣');
      FND_MESSAGE.SET_TOKEN('������Ϣ', 'û��ע�Ṥ����');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR1 THEN
      FND_MESSAGE.SET_NAME('CUX', '�쳣');
      FND_MESSAGE.SET_TOKEN('������Ϣ', '���ʺϵĹ�������������');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR2 THEN
      FND_MESSAGE.SET_NAME('CUX', '�쳣');
      FND_MESSAGE.SET_TOKEN('������Ϣ', '���ʺϵĹ���������ְλ');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR3 THEN
      FND_MESSAGE.SET_NAME('CUX', '�쳣');
      FND_MESSAGE.SET_TOKEN('������Ϣ', '�ص��Զ������ʧ��');
      APP_EXCEPTION.RAISE_EXCEPTION;
  END;

  FUNCTION GET_CHECK_POSITION_STRU(POTYPE_CODE       IN VARCHAR2,
                                   PPOSITION_STRU_ID IN NUMBER,
                                   PITEMKEY          IN VARCHAR2,
                                   PITEMKEYNAME      IN VARCHAR2)
    RETURN VARCHAR2 IS
    VI       NUMBER(15);
    P_ORG_ID NUMBER;
    CURSOR CURGETSQL(POTYPE_CODE IN VARCHAR2, PPOSITION_STRU_ID IN NUMBER) IS
      SELECT CWROD.COLUMN_NAME,
             CWROD.OTYPE_CODE,
             CWROD.COLUMN_TYPE,
             CWOPD.COLUMN_VALUES,
             CWOPD.RULE_SIGN,
             CWRO1.VIEW_NAME
        FROM CCM_WF_OTYPE_POSITION     CWOP,
             CCM_WF_OTYPE_POSITION_DTL CWOPD,
             CCM_WF_REG_OTYPE_DTL      CWROD,
             CCM_WF_REG_OTYPE_V        CWRO,
             CCM_WF_REG_OTYPE_V        CWRO1
       WHERE CWOP.OP_ID = CWOPD.OP_ID(+)
         AND CWROD.OTYPE_CODE = CWRO.OTYPE_CODE(+)
         AND CWOPD.COLUMN_DTL_ID = CWROD.DTL_ID(+)
         AND CWOP.OTYPE_CODE = CWRO1.OTYPE_CODE
         AND CWOP.OTYPE_CODE = POTYPE_CODE
         AND CWOP.POSITION_STRUCTURE_ID = PPOSITION_STRU_ID
         AND CWOP.WF_ORG_ID = P_ORG_ID;
    VGETSQL CURGETSQL%ROWTYPE;
    VWHERE  VARCHAR2(4000) := ' where 1=1';
    VSQL    VARCHAR(4000);
    VRECNUM NUMBER(15);
  BEGIN
  
    P_ORG_ID := NVL(FND_PROFILE.VALUE('CCM:WF_ORG'), 5002);
    SELECT COUNT(*)
      INTO VI
      FROM CCM_WF_OTYPE_POSITION CWOP
     WHERE CWOP.OTYPE_CODE = POTYPE_CODE
       AND WF_ORG_ID = P_ORG_ID
       AND CWOP.POSITION_STRUCTURE_ID = PPOSITION_STRU_ID;
    IF VI = 0 THEN
      RETURN 'N';
    END IF;
  
    OPEN CURGETSQL(POTYPE_CODE, PPOSITION_STRU_ID);
    FETCH CURGETSQL
      INTO VGETSQL;
    WHILE CURGETSQL%FOUND LOOP
      IF VGETSQL.COLUMN_TYPE = 'NUMBER' THEN
        VWHERE := VWHERE || ' and ' || VGETSQL.COLUMN_NAME || ' ' ||
                  VGETSQL.RULE_SIGN || ' ' || VGETSQL.COLUMN_VALUES;
      END IF;
    
      IF VGETSQL.COLUMN_TYPE IN ('VARCHAR2', 'CHAR') AND
         VGETSQL.RULE_SIGN <> 'IN' THEN
        VWHERE := VWHERE || ' and ' || VGETSQL.COLUMN_NAME || ' ' ||
                  VGETSQL.RULE_SIGN || ' ' || '''' || VGETSQL.COLUMN_VALUES || '''';
      END IF;
    
      IF VGETSQL.COLUMN_TYPE IN ('VARCHAR2', 'CHAR') AND
         VGETSQL.RULE_SIGN = 'IN' THEN
        VWHERE := VWHERE || ' and ' || VGETSQL.COLUMN_NAME || ' ' ||
                  VGETSQL.RULE_SIGN || ' ' ||
                  REPLACE(VGETSQL.COLUMN_VALUES, '"', '''');
        --vGetsql.column_values;
      END IF;
      FETCH CURGETSQL
        INTO VGETSQL;
    END LOOP;
    CLOSE CURGETSQL;
  
    VSQL := 'begin' || ' select count(*) into :a from ' ||
            VGETSQL.VIEW_NAME || VWHERE || ';' || 'end;';
    BEGIN
      EXECUTE IMMEDIATE VSQL
        USING OUT VRECNUM;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(VSQL);
        RETURN 'N';
    END;
    -- dbms_output.put_line(vSql);
    IF VRECNUM = 0 THEN
      RETURN 'N';
    END IF;
    /* dbms_output.put_line(vSql);
    dbms_output.put_line ('pPosition_stru_id='||pPosition_stru_id);
    dbms_output.put_line ('pOtype_code='||pOtype_code);
    dbms_output.put_line ('P_ORG_ID='||P_ORG_ID);*/
    RETURN 'Y';
  END;

  --���۶������û�ǩ
  PROCEDURE SETISCOUNTERSIGNFORPROREPORT(P_KEY        IN VARCHAR2,
                                         POTYPE_CODE  IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2) IS
    V_P_POSITION_ID NUMBER;
    V_P_ID          NUMBER;
    V_STATUS        VARCHAR2(20);
  BEGIN
    --��ȡҵ�������ID,����״̬
    BEGIN
      SELECT SST.SALES_ORDER_ID, NVL(SST.STATUS, 'A')
        INTO V_P_ID, V_STATUS
        FROM SPM_CON_SALES_ORDER SST
       WHERE SST.ITEM_KEY = P_KEY
         AND ROWNUM < 2;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RAISE;
    END;
  
    IF V_STATUS = 'A' OR V_STATUS = 'D' THEN
      --������ǩ
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 100);
    
      /**
      ��ָ̬��������Աʱ ��ɾ���ض����õ�������Ա
      ��ָ��������ĳЩ�����ڵ�����Ҫ���ö�̬ѡ��
      ��Ҫ��̬ѡ������Աʱ���ô˴���
      **/
      -- delete ccm_wf_user_group cg
      --   where cg.itemkey = P_Key;
    
    ELSE
      --ȡ����ǩ
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 0.1);
    
    END IF;
  END;

  --��ͬģ���������̷���
  PROCEDURE SPM_CON_WF_TEMPLATE_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����Ϊ��ǰ�ڵ�״̬
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS   = GET_WF_STATUS_BY_POSITION(OTYPECODE, PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE TEMPLATE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --��ͬģ������htmlչ��
  FUNCTION CLS_CON_TEMPLATE_WF_HTML(P_KEY IN VARCHAR2,
                                    
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(20000);
    V_ID NUMBER;
  BEGIN
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConContractTemplate/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��ͬģ�岵�ػص�
  PROCEDURE SPM_CON_WF_TEMPLATE_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS = 'D'
     WHERE TEMPLATE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         '',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  
  END;
  --��ͬģ��������׼�ص�
  PROCEDURE SPM_CON_WF_TEMPLATE_PZ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         'STATUS',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  END;
  --��ͬģ������ͨ���ص�
  PROCEDURE SPM_CON_WF_TEMPLATE_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS = 'E'
     WHERE TEMPLATE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         '',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  END;

  --����֤����htmlչ��
  FUNCTION CLS_CON_CREDIT_WF_HTML(P_KEY IN VARCHAR2,
                                  
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG         VARCHAR2(20000);
    V_CREDIT_ID NUMBER;
  
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_CREDIT_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConCredit/edit/' ||
                                                   V_CREDIT_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;
  --����֤�������̷���
  PROCEDURE CLS_CON_CREDIT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_CREDIT SET STATUS = 'C' WHERE CREDIT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --����֤���ػص�
  PROCEDURE CLS_CON_CREDIT_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_CREDIT SET STATUS = 'D' WHERE CREDIT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_ID');
  
  END;
  --����֤������׼�ص�
  PROCEDURE CLS_CON_CREDIT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_ID');
  END;
  --����֤����ͨ���ص�
  PROCEDURE CLS_CON_CREDIT_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_CREDIT SET STATUS = 'E' WHERE CREDIT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_ID');
  END;

  --����֤����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_TZSC(P_NOTIFID IN VARCHAR2,
                                P_ITEMKEY IN VARCHAR2,
                                
                                P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_CREDIT',
                          'CREDIT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CREDIT_TZSC;

  --����֤֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_TZH;

  --����֤��������htmlչ��
  FUNCTION CLS_CREDIT_PAY_WF_HTML(P_KEY IN VARCHAR2,
                                  
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG            VARCHAR2(20000);
    V_CREDITPAY_ID NUMBER;
  
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_CREDITPAY_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConCreditPay/edit/' ||
                                                   V_CREDITPAY_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --����֤�����������̷���
  PROCEDURE CLS_CREDIT_PAY_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'C' WHERE CREDIT_PAY_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --����֤����ػص�
  PROCEDURE CLS_CREDIT_PAY_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'D' WHERE CREDIT_PAY_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  
  END;
  --����֤�����������׼�ص�
  PROCEDURE CLS_CREDIT_PAY_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  END;
  --����֤����ͨ���ص�
  PROCEDURE CLS_CREDIT_PAY_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'E' WHERE CREDIT_PAY_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  END;

  --����֤��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_PAY_TZSC(P_NOTIFID IN VARCHAR2,
                                    P_ITEMKEY IN VARCHAR2,
                                    
                                    P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_CREDIT_PAY',
                          'CREDIT_PAY_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CREDIT_PAY_TZSC;

  --����֤����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_PAY_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_PAY_TZH;

  --�����տ����htmlչ��
  FUNCTION CLS_CREDIT_RECEIPT_WF_HTML(P_KEY IN VARCHAR2,
                                      
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG           VARCHAR2(20000);
    CHECKCANCELID NUMBER;
  BEGIN
    SELECT CHECKCANCELID
      INTO CHECKCANCELID
      FROM SPM_CON_CREDIT_PAY
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/SpmConBackletterReceive/edit/' ||
                                                   CHECKCANCELID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�����տ�������̷���
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'C'
     WHERE CREDIT_RECEIPT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --�����տ֤���ػص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'D'
     WHERE CREDIT_RECEIPT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  
  END;
  --�����տ������׼�ص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  END;
  --�����տ����ͨ���ص�
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'E'
     WHERE CREDIT_RECEIPT_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  END;

  --�����տ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZSC(P_NOTIFID IN VARCHAR2,
                                        P_ITEMKEY IN VARCHAR2,
                                        
                                        P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_CREDIT_RECEIPT',
                          'CREDIT_RECEIPT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_CREDIT_RECEIPT_TZSC;

  --�����տ֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_RECEIPT_TZH;

  --�½���������htmlչ��
  FUNCTION CLS_BACKLETTER_INFO_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG           VARCHAR2(20000);
    BACKLETTER_ID NUMBER;
  BEGIN
    SELECT BACKLETTER_ID
      INTO BACKLETTER_ID
      FROM SPM_CON_BACKLETTER_INFO
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConBackletterInfo/edit/' ||
                                                   BACKLETTER_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�½������������̷���
  PROCEDURE CLS_BACKLETTER_INFO_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'C'
     WHERE BACKLETTER_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --�½��������ػص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'D'
     WHERE BACKLETTER_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  
  END;
  --�½�����������׼�ص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_PZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         'STATUS',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  END;
  --�½���������ͨ���ص�
  PROCEDURE CLS_BACKLETTER_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'E'
     WHERE BACKLETTER_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  END;

  --�����½�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                         P_ITEMKEY IN VARCHAR2,
                                         
                                         P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BACKLETTER_INFO',
                          'BACKLETTER_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_BACKLETTER_INFO_TZSC;

  --�����½�֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BACKLETTER_INFO_TZH;

  --�յ���������htmlչ��
  FUNCTION CLS_BACKLETTER_RECEIVE_WF_HTML(P_KEY IN VARCHAR2,
                                          
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG                   VARCHAR2(20000);
    BACKLETTER_RECEIVE_ID NUMBER;
  BEGIN
    SELECT BACKLETTER_RECEIVE_ID
      INTO BACKLETTER_RECEIVE_ID
      FROM SPM_CON_BACKLETTER_INFO
     WHERE ITEM_KEY = P_KEY;
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConBackletterReceive/edit/' ||
                                                   BACKLETTER_RECEIVE_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�յ������������̷���
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --���̷����,��ҵ���״̬����ΪC ����״̬
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'C'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --�յ��������ػص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --���̲��غ�,��ҵ���״̬����ΪD
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'D'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  
  END;
  --�յ�����������׼�ص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         'STATUS',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  END;
  --�յ���������ͨ���ص�
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --����ͬ����,��ҵ���״̬����ΪE
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'E'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
    --���浽���̼�¼��
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  END;

  --�����յ�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_RECEIVE_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_BACKLETTER_RECEIVE',
                          'BACKLETTER_RECEIVE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_RECEIVE_TZSC;

  --�����յ�����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_RECEIVE_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_RECEIVE_TZH;

  --�˻�������htmlչ��
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConSalesReturn/edit/' ||
                                                   V_SALES_RETURN_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��ⵥ����htmlչ��
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConWarehouse/edit/' ||
                                                   V_WAREHOUE_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --���ⵥ����htmlչ��
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConOdo/edit/' ||
                                                   V_ODO_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --�����ƻ�ά������htmlչ��
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConGoodsPlan/edit/' ||
                                                   V_GOODS_PLAN_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END;

  --��ⵥ����֪ͨ���ɻص�
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

  --��ⵥ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_WAREHOUSE_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_WAREHOUSE_TZH;

  --���ⵥ����֪ͨ���ɻص�
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

  --���ⵥ����֪ͨ����(ǰ)�ص�
  PROCEDURE SPM_CON_ODO_TZCL(P_KEY         IN VARCHAR2,
                             P_OTYPE_CODE  IN VARCHAR2,
                             P_NOTIFID     IN VARCHAR2,
                             P_OPER_RESULT IN VARCHAR2) AS
    V_STATUS     VARCHAR2(40);
    V_EBS_STATUS VARCHAR2(40);
  BEGIN
    SELECT NVL(O.STATUS, 'A'), NVL(O.ATTRIBUTE5, 'N')
      INTO V_STATUS, V_EBS_STATUS
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_ODO O
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = O.ODO_ID
       AND W.JOB_TABLE = 'SPM_CON_ODO';
  
    IF V_STATUS = 'N' AND V_EBS_STATUS = 'N' AND P_OPER_RESULT = 'Y' THEN
      FND_MESSAGE.SET_NAME('CUX', '��ʾ');
      FND_MESSAGE.SET_TOKEN('��Ϣ', '������ͬ�����ⵥ����');
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
  END SPM_CON_ODO_TZCL;

  --���ⵥ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_ODO_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    /*    UPDATE SPM_CON_ODO t
      SET OUTPUT_OR_RETURN = '2'
    WHERE t.item_key = p_Key;*/
  END SPM_CON_ODO_TZH;

  --�����ƻ�����֪ͨ���ɻص�
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

  --�����ƻ���֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_GOODS_PLAN_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    COMMIT;
  END SPM_CON_GOODS_PLAN_TZH;

  --�˻�������֪ͨ���ɻص�
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

  --�˻�������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_SALES_RETURN_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
    V_DD NUMBER;
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    /*   select f.odo_id into v_dd  from spm_con_sales_return f where f.item_key=p_Key;
    UPDATE SPM_CON_ODO SET OUTPUT_OR_RETURN='1' WHERE  ODO_ID=v_dd;
    commit;*/
  END SPM_CON_SALES_RETURN_TZH;

  --Ԥ���Ʊ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_INPUT_INVOICE',
                          'INPUT_INVOICE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_IMPREST_INVOICE_TZSC;

  --Ԥ���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_IMPREST_INVOICE_TZH;

  --������������ͨ���ص�
  PROCEDURE SPM_CON_PAYMENT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_PAYMENT_ID    NUMBER(15);
    V_AUDIT_STATUS  VARCHAR2(2) := '01';
    V_CREATION_DATE DATE;
    V_ORG_ID        NUMBER(15);
    V_DEPT_ID       NUMBER(15);
    V_CREATED_BY    NUMBER(15);
    V_AUDIT_INFO    VARCHAR2(400) := '';
    V_PAY_TYPE      VARCHAR2(40);
  
    CURSOR CU_DATA IS
      SELECT T.INPUT_INVOICE_ID, T.ATTRIBUTE5, T.INVOICE_CODE
        FROM SPM_CON_PAYMENT_INVOICE S, SPM_CON_INPUT_INVOICE T
       WHERE S.PAYMENT_ID = V_PAYMENT_ID
         AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID;
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_PAYMENT_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT S.CREATION_DATE, S.ORG_ID, S.DEPT_ID, S.CREATED_BY, S.ATTRIBUTE5
      INTO V_CREATION_DATE, V_ORG_ID, V_DEPT_ID, V_CREATED_BY, V_PAY_TYPE
      FROM SPM_CON_PAYMENT S
     WHERE S.PAYMENT_ID = V_PAYMENT_ID;
  
    FOR V_CURROW IN CU_DATA LOOP
      IF V_CURROW.ATTRIBUTE5 = 'BZJ' AND V_PAY_TYPE = 'BZJ' THEN
        SPM_CON_MQ_PKG.SPM_CON_MARGIN_APPROVAL(O_INPUT_INVOICE_ID => V_CURROW.INPUT_INVOICE_ID,
                                               O_INVOICE_CODE     => V_CURROW.INVOICE_CODE,
                                               O_AUDIT_STATUS     => V_AUDIT_STATUS,
                                               O_AUDIT_INFO       => V_AUDIT_INFO,
                                               O_CREATED_BY       => V_CREATED_BY,
                                               O_CREATION_DATE    => V_CREATION_DATE,
                                               O_ORG_ID           => V_ORG_ID,
                                               O_DEPT_ID          => V_DEPT_ID);
      END IF;
    END LOOP;
  END;

  --���������������ػص�
  PROCEDURE SPM_CON_PAYMENT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_PAYMENT_ID    NUMBER(15);
    V_AUDIT_STATUS  VARCHAR2(2) := '02';
    V_CREATION_DATE DATE;
    V_ORG_ID        NUMBER(15);
    V_DEPT_ID       NUMBER(15);
    V_CREATED_BY    NUMBER(15);
    V_AUDIT_INFO    VARCHAR2(400);
    V_PAY_TYPE      VARCHAR2(40);
  
    CURSOR CU_DATA IS
      SELECT T.INPUT_INVOICE_ID, T.ATTRIBUTE5, T.INVOICE_CODE
        FROM SPM_CON_PAYMENT_INVOICE S, SPM_CON_INPUT_INVOICE T
       WHERE S.PAYMENT_ID = V_PAYMENT_ID
         AND S.INPUT_INVOICE_ID = T.INPUT_INVOICE_ID;
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_PAYMENT_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT AUDIT_INFO
      INTO V_AUDIT_INFO
      FROM (SELECT S.AUDIT_INFO
              FROM SPM_CON_WF_HISTORY S
             WHERE S.WF_ITEMKEY = ITEMKEY
             ORDER BY S.WF_HISTORY_ID DESC)
     WHERE ROWNUM = 1;
  
    SELECT S.CREATION_DATE, S.ORG_ID, S.DEPT_ID, S.CREATED_BY, S.ATTRIBUTE5
      INTO V_CREATION_DATE, V_ORG_ID, V_DEPT_ID, V_CREATED_BY, V_PAY_TYPE
      FROM SPM_CON_PAYMENT S
     WHERE S.PAYMENT_ID = V_PAYMENT_ID;
  
    FOR V_CURROW IN CU_DATA LOOP
      IF V_CURROW.ATTRIBUTE5 = 'BZJ' AND V_PAY_TYPE = 'BZJ' THEN
        SPM_CON_MQ_PKG.SPM_CON_MARGIN_APPROVAL(O_INPUT_INVOICE_ID => V_CURROW.INPUT_INVOICE_ID,
                                               O_INVOICE_CODE     => V_CURROW.INVOICE_CODE,
                                               O_AUDIT_STATUS     => V_AUDIT_STATUS,
                                               O_AUDIT_INFO       => V_AUDIT_INFO,
                                               O_CREATED_BY       => V_CREATED_BY,
                                               O_CREATION_DATE    => V_CREATION_DATE,
                                               O_ORG_ID           => V_ORG_ID,
                                               O_DEPT_ID          => V_DEPT_ID);
      END IF;
    END LOOP;
  END;

  --��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_PAYMENT',
                          'PAYMENT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_PAYMENT_TZSC;

  --��������֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_PAYMENT_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
    L_NID        NUMBER;
    V_INFO       VARCHAR2(1000);
    V_STATUS     VARCHAR2(40);
    V_EBS_STATUS VARCHAR2(40);
    V_P_SOURCE   VARCHAR2(40);
    IS_EXISTS    NUMBER;
  BEGIN
    L_NID  := WF_ENGINE.CONTEXT_NID;
    V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
  
    SELECT W.STATUS, P.EBS_STATUS, P.PAYMENT_SOURCE
      INTO V_STATUS, V_EBS_STATUS, V_P_SOURCE
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.JOB_ID = P.PAYMENT_ID
       AND W.ITEM_KEY = P_KEY;
    IF P_OPER_RESULT = 'Y' THEN
      -- ���̴ﵽ��֤����Ҹ��ʽ���������ڡ���������Ϊ����������׼
      IF V_STATUS = 'C' THEN
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
         WHERE W.JOB_ID = P.PAYMENT_ID
           AND W.ITEM_KEY = P_KEY
           AND (P.PAY_METHODS IS NULL OR P.PAY_DATE IS NULL OR
               P.PAY_BANK_ACCOUNT_ID IS NULL);
      
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�����Ƹ������뵥����¼�������Ϣ');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
        --���������Դ�ǽ����̣��򸶿���봴����ƿ�Ŀ��������׼
        IF V_EBS_STATUS <> 'US' AND V_P_SOURCE <> 'TR' THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�ø�����δ�ɹ�������Ʒ�¼');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --����ʱ�������Ѿ�������ƿ�Ŀ ����������
      IF V_EBS_STATUS = 'US' THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '�ø����ѳɹ�������Ʒ�¼������ִ�в��ز���');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_CON_PAYMENT_WF_TZCL_BEFORE;

  --��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PAYMENT_TZH;

  --���Ʊ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
    V_STATUS_PASSED VARCHAR2(40);
    V_INVOICE_ID    NUMBER(15);
  BEGIN
    SELECT DECODE(O.INVOICE_TYPE, '��Ӫҵ���ݹ�', 'N', 'E'),
           O.OUTPUT_INVOICE_ID
      INTO V_STATUS_PASSED, V_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY A, SPM_CON_OUTPUT_INVOICE O
     WHERE A.JOB_ID = O.OUTPUT_INVOICE_ID
       AND A.JOB_TABLE = 'SPM_CON_OUTPUT_INVOICE'
       AND A.ITEM_KEY = P_ITEMKEY;
  
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_OUTPUT_INVOICE',
                          'OUTPUT_INVOICE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          V_STATUS_PASSED);
    IF V_STATUS_PASSED = 'N' THEN
      UPDATE SPM_CON_OUTPUT_INVOICE O
         SET O.INVOICE_CODE = 'ZG' || SUBSTR(O.INVOICE_SERIAL_NUMBER, 2)
       WHERE O.OUTPUT_INVOICE_ID = V_INVOICE_ID;
    END IF;
  END SPM_CON_OUTPUT_INVOICE_TZSC;

  --���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_OUTPUT_INVOICE_TZH;

  --���Ʊ��Ʊ��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_RETURN_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_OUTPUT_INVOICE',
                          'OUTPUT_INVOICE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_RETURN_INVOICE_TZSC;

  --���Ʊ��Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_RETURN_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_RETURN_INVOICE_TZH;
  --��ͬ�����½�����֪ͨ���ɻص�
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
  
  END SPM_CON_HT_WF_TRANS_TZSC;

  --��ͬ��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_HT_WF_TRANS_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT); --�޸�����
  
  END SPM_CON_HT_WF_TRANS_TZH;
  --��ͬ�������̱�����֤(֪ͨ�ص�)
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
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ', '��ͬ������Ҫ����Ҫ��ǩ��');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_TRANS_VALID;

  PROCEDURE SPM_CON_OUTPUT_INVOICE_RY(V_P_KEY                 VARCHAR2,
                                      P_OTYPE_CODE            VARCHAR2,
                                      V_GROUP_ID              NUMBER,
                                      V_POSITION_STRUCTURE_ID NUMBER,
                                      V_POSITION_ID           VARCHAR2) AS
    V_STATUS_FLAG VARCHAR2(10);
    V_USER_NAME   VARCHAR2(40);
    TABLENAME     VARCHAR2(40);
    VSQL          VARCHAR2(100);
    V_USER_ID     NUMBER;
    V_COST_TYPE   VARCHAR2(40);
  BEGIN
  
    SELECT WF_TAB_NAME
      INTO TABLENAME
      FROM SPM_WF_REGINFO
     WHERE WF_CODE = P_OTYPE_CODE;
    VSQL := 'SELECT ' || ' nvl(status,''A''), CREATED_BY,ATTRIBUTE4  FROM ' ||
            TABLENAME || ' WHERE item_key=' || '''' || V_P_KEY || '''';
    -- insert into spm_debug values('000#',vSql,sysdate);
    EXECUTE IMMEDIATE VSQL
      INTO V_STATUS_FLAG, V_USER_ID, V_COST_TYPE;
  
    IF V_COST_TYPE = 'Y' THEN
      SELECT V.USER_NAME
        INTO V_USER_NAME
        FROM SPM_EAM_ALL_PEOPLE_V V
       WHERE V.USER_ID = V_USER_ID
         AND ROWNUM = 1;
      UPDATE CCM_WF_USER_GROUP G
         SET G.USER_NAME = V_USER_NAME
       WHERE G.ITEMKEY = V_P_KEY
         AND G.GROUP_ID = V_GROUP_ID;
    
    ELSE
      IF V_STATUS_FLAG = 'K' THEN
        SELECT V.USER_NAME
          INTO V_USER_NAME
          FROM SPM_EAM_ALL_PEOPLE_V V
         WHERE V.USER_ID = V_USER_ID
           AND ROWNUM = 1;
        UPDATE CCM_WF_USER_GROUP G
           SET G.USER_NAME = V_USER_NAME
         WHERE G.ITEMKEY = V_P_KEY
           AND G.GROUP_ID = V_GROUP_ID;
        COMMIT;
      END IF;
    END IF;
  
    SALES_ORDER_PERSON_PR(P_KEY                  => V_P_KEY,
                          POTYPE_CODE            => P_OTYPE_CODE,
                          VGROUP_ID              => V_GROUP_ID,
                          VPOSITION_STRUCTURE_ID => V_POSITION_STRUCTURE_ID,
                          VPOSITOIN_ID           => V_POSITION_ID);
  
  END SPM_CON_OUTPUT_INVOICE_RY;

  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2 IS
    NUM1 NUMBER; --��¼ebs���Ƿ����
  
  BEGIN
  
    SELECT COUNT(V.VENDOR_ID)
      INTO NUM1
      FROM PO_VENDORS V
     WHERE V.SEGMENT1 = (SELECT VEN.VENDOR_CODE
                           FROM SPM_CON_VENDOR_INFO VEN
                          WHERE VEN.VENDOR_ID = VENDOR_IDR);
    IF NUM1 = 0 THEN
      RETURN 'N';
    ELSE
      RETURN 'Y';
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END SPM_CON_VENDOR_TOEBS;

  --�����˻�����֪ͨ���ɻص�
  PROCEDURE SPM_CON_OR_ACCOUNT_TZSC(P_NOTIFID IN VARCHAR2,
                                    P_ITEMKEY IN VARCHAR2,
                                    
                                    P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_ORIENTATION_ACCOUNT',
                          'ACCOUNT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_OR_ACCOUNT_TZSC;
  --��Ӧ������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_OR_ACCOUNT_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_OR_ACCOUNT_TZH;

  --�����˻���˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_OR_ACCOUNT_INFO(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConOrientationAccount/edit/' || V_ID,
                                                   P_KEY) ||
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_OR_ACCOUNT_INFO;

  --���Ʊ����ͨ���ص�
  PROCEDURE SPM_CON_OUTPUT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID     NUMBER(15);
    V_NUMBER NUMBER;
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT COUNT(O.SERVICE_CODE)
      INTO V_NUMBER
      FROM SPM_CON_OUTPUT_INVOICE O
     WHERE O.OUTPUT_INVOICE_ID = V_ID;
  
    IF V_NUMBER <> 0 THEN
      --������Ϣ��
      SPM_CON_MQ_PKG.BID_FEE_SEND(V_ID           => V_ID,
                                  V_AUDIT_STATUS => '01',
                                  V_AUDIT_REASON => '');
    
      --������ת����
      SPM_CON_MQ_PKG.GENERATE_BIDFEE_DATA(V_INVOICE_ID => V_ID);
    END IF;
  END SPM_CON_OUTPUT_TG;

  /*���Ʊ�������ػص�*/
  PROCEDURE SPM_CON_OUTPUT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_PAYMENT_ID        NUMBER(15);
    V_AUDIT_INFO        VARCHAR2(400);
    V_COUNT             NUMBER;
    V_OUTPUT_INVOICE_ID NUMBER;
  
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_OUTPUT_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    SELECT COUNT(O.SERVICE_CODE)
      INTO V_COUNT
      FROM SPM_CON_OUTPUT_INVOICE O
     WHERE O.OUTPUT_INVOICE_ID = V_OUTPUT_INVOICE_ID;
  
    IF V_COUNT > 0 THEN
      SELECT AUDIT_INFO
        INTO V_AUDIT_INFO
        FROM (SELECT S.AUDIT_INFO
                FROM SPM_CON_WF_HISTORY S
               WHERE S.WF_ITEMKEY = ITEMKEY
               ORDER BY S.WF_HISTORY_ID DESC)
       WHERE ROWNUM = 1;
    
      SPM_CON_MQ_PKG.BID_FEE_SEND(V_ID           => V_OUTPUT_INVOICE_ID,
                                  V_AUDIT_STATUS => '02',
                                  V_AUDIT_REASON => V_AUDIT_INFO);
    END IF;
  
  END SPM_CON_OUTPUT_BH;

  --�ʽ����취��������HTMLչ��
  FUNCTION SPM_CON_PLAN_PAYMENT_WF_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG           VARCHAR2(20000);
    V_ACTIVITY_ID NUMBER;
    V_STATUS      VARCHAR2(10);
    V_REC_ID      NUMBER(15);
    V_PLAN_FLAG   VARCHAR2(40);
  BEGIN
    SELECT JOB_ID
      INTO V_ACTIVITY_ID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = P_KEY;
  
    SELECT T.STATUS, NVL(T.PLAN_FLAG, 'N')
      INTO V_STATUS, V_PLAN_FLAG
      FROM SPM_CON_PAYMENT T, SPM_CON_WF_ACTIVITY W
     WHERE T.PAYMENT_ID = W.JOB_ID
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
    /*AND WF.STATUS = 'OPEN'*/
  
    -- �����Ƿ����¸����ж���ת�߼�
    IF V_PLAN_FLAG = 'Y' THEN
      --״̬��cѡĬ��ְ���ʱ��Ĭ��ѡ������¼org_id ��Ӧ��ְ��
      --���ҵ�ǰ�����˾��Ǵ�����Ϣ������
      IF (V_STATUS = 'C' )AND V_REC_ID = SPM_SSO_PKG.GETUSERID THEN
      
        MSG := '<a href=''' ||
               SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                         'WF_URL=/spmConPlanPayment/edit/' ||
                                                         V_ACTIVITY_ID,
                                                         P_KEY) ||
               '''>�鿴����</a><br>';
      ELSE
        --����������ѡ
        MSG := '<a href=''' ||
               SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConPlanPayment/edit/' ||
                                                       V_ACTIVITY_ID,
                                                       P_KEY) ||
               '''>�鿴����</a><br>';
      END IF;
    ELSE
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                  'WF_URL=/spmConPayment/edit/' ||
                                                  V_ACTIVITY_ID,
                                                  P_KEY) ||
             '''>�鿴����</a><br>';
    END IF;
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := P_KEY || '-' || P_OTYPE_CODE || '��������';
      RETURN MSG;
  END SPM_CON_PLAN_PAYMENT_WF_HTML;

  --�ʽ����취�������������ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_QD(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    V_POSITION_ID IN VARCHAR2) IS
  
    V_PAYMENT_ID         NUMBER(15);
    V_PLAN_FLAG          VARCHAR2(40);
    V_SYS_PAYABLE_AMOUNT NUMBER;
    P_CAPITAL_ID         NUMBER(15);
    P_OCCUPY_AMOUNT      NUMBER(15);--ռ�ý��
  BEGIN
    --��ѯ���̻�� ��ö�Ӧ�������뵥ID
    SELECT W.JOB_ID, NVL(P.PLAN_FLAG, 'N')
      INTO V_PAYMENT_ID, V_PLAN_FLAG
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = P.PAYMENT_ID;
  
    --�����̣�����
    IF V_PLAN_FLAG = 'N' THEN
      RETURN;
    END IF;
    V_SYS_PAYABLE_AMOUNT := SPM_CON_INVOICE_PKG.GET_PAYABLE_UNPAYABLE_BY_ID(V_PAYMENT_ID,
                                                                            3);
    --��ѯ��ǰ�ύ�׶��ʽ�ƻ���ռ�ý��
    SELECT SP.MONTH_DETAIL_ID, SUM(SP.MONEY_AMOUNT)
      INTO P_CAPITAL_ID, P_OCCUPY_AMOUNT
      FROM SPM_CON_PAYMENT SP
     WHERE NVL(SP.PAY_PURPOSE, '1') <> '24'
       AND SP.MONTH_DETAIL_ID =
           SPM_GZ_GZGL_INS_PKG.GET_CAPITAL_ID(SP.DEPT_ID)
       AND SP.PAYMENT_ID <> V_PAYMENT_ID
       AND SP.STATUS NOT IN ('A', 'D')
       AND NVL(SP.EBS_STATUS, 'N') NOT IN ('R','US')
     GROUP BY SP.MONTH_DETAIL_ID;
  
    --���¸���������
    UPDATE SPM_CON_PAYMENT P
       SET P.CANCEL_AMOUNT      = P.MONEY_AMOUNT,
           P.CANCEL_DATE        = SYSDATE,
           P.SYS_PAYABLE_AMOUNT = V_SYS_PAYABLE_AMOUNT,
           P.MONTH_DETAIL_ID = P_CAPITAL_ID,
           
           P.THIS_MONTH_BALANCE =
           (SELECT NVL(C.CAPITAL_QUOTA,0) - NVL(C.PAY_AMOUNT,0) - NVL(P_OCCUPY_AMOUNT,0)
              FROM SPM_CON_CAPITAL_PLAN C
             WHERE C.CAPITAL_ID = P_CAPITAL_ID)
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
    /*    --����ˢ���ʽ�ʣ���ȹ���20190416����������ƿ�Ŀ�¼�
    SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'A');*/
  
  END SPM_CON_PLAN_PAYMENT_QD;

  --�ʽ����취�������̲��ػص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_BH(P_KEY        IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2) IS
  
    V_PAYMENT_ID NUMBER(15);
    V_START_DATE DATE;
    V_DATE_DIFF  NUMBER;
    V_PLAN_FLAG  VARCHAR2(40);
  BEGIN
    --��ѯ���̻�� ��ö�Ӧ�������뵥ID
    SELECT W.JOB_ID, W.CREATION_DATE, NVL(P.PLAN_FLAG, 'N')
      INTO V_PAYMENT_ID, V_START_DATE, V_PLAN_FLAG
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = P.PAYMENT_ID;
  
    SPM_CON_PAYMENT_BH(ITEMKEY => P_KEY, OTYPECODE => P_OTYPE_CODE);
    -- �ɸ����
    IF V_PLAN_FLAG = 'N' THEN
      RETURN;
    END IF;
  
    --�������־û��ֶ���� add by ruankk 2018-07-20
    UPDATE SPM_CON_PAYMENT P
       SET P.THIS_MONTH_BALANCE = NULL, P.SYS_PAYABLE_AMOUNT = NULL
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    -- ���㵱ǰʱ������ʼʱ����·ݲ�ֵ
    SELECT MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM'), 'YYYY-MM'),
                          TO_DATE(TO_CHAR(V_START_DATE, 'YYYY-MM'),
                                  'YYYY-MM'))
      INTO V_DATE_DIFF
      FROM DUAL;
  
    IF V_DATE_DIFF = 0 THEN
      /*--����ˢ���ʽ�ʣ���ȹ���20190417����ȡ���������
      SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'D');*/
      --���¸���������
      UPDATE SPM_CON_PAYMENT P
         SET P.CANCEL_AMOUNT = 0
       WHERE P.PAYMENT_ID = V_PAYMENT_ID;
    END IF;
  END SPM_CON_PLAN_PAYMENT_BH;

  --�ʽ����취������������ͨ���ص��¼�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) IS
    P_PAYMENT_ID NUMBER(15);
    V_PLAN_FLAG  VARCHAR2(40);
  
  BEGIN
  
    --1.����ITEMKEY�ҵ���Ӧ���
  
    SELECT P.PAYMENT_ID, NVL(P.PLAN_FLAG, 'N')
      INTO P_PAYMENT_ID, V_PLAN_FLAG
      FROM SPM_CON_PAYMENT P, SPM_CON_WF_ACTIVITY W
     WHERE P.PAYMENT_ID = W.JOB_ID
       AND W.ITEM_KEY = ITEMKEY;
  
    IF V_PLAN_FLAG = 'Y' THEN
      --2.�������ɸ���ָ�����
      SPM_CON_INVOICE_PKG.CREATE_INSTRUCT_BY_PAYMENT_NEW(V_PAYMENT_ID => P_PAYMENT_ID);
    END IF;
    SPM_CON_PAYMENT_TG(ITEMKEY => ITEMKEY, OTYPECODE => OTYPECODE);
  END SPM_CON_PLAN_PAYMENT_TG;

  --�ʽ����취��������֪ͨ���ɻص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_PAYMENT',
                          'PAYMENT_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_PLAN_PAYMENT_TZSC;

  --�ʽ����취��������֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_WF_TZCL(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
    L_NID          NUMBER;
    V_INFO         VARCHAR2(1000);
    V_STATUS       VARCHAR2(40);
    V_P_SOURCE     VARCHAR2(40);
    IS_EXISTS      NUMBER;
    V_PAYMENT_ID   NUMBER(15); --�������
    V_MONEY_AMOUNT NUMBER; --�������뵥������
    V_CHILD_AMOUNT NUMBER; --���������ӱ���
    V_PLAN_FLAG    VARCHAR2(40);
  
  BEGIN
    /*L_NID  := WF_ENGINE.CONTEXT_NID;
    V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');*/
  
    SELECT W.STATUS, P.PAYMENT_ID, P.MONEY_AMOUNT, NVL(P.PLAN_FLAG, 'N')
      INTO V_STATUS, V_PAYMENT_ID, V_MONEY_AMOUNT, V_PLAN_FLAG
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.JOB_ID = P.PAYMENT_ID
       AND W.ITEM_KEY = P_KEY;
  
    IF V_PLAN_FLAG = 'N' THEN
      SPM_CON_PAYMENT_WF_TZCL_BEFORE(P_KEY         => P_KEY,
                                     P_OTYPE_CODE  => P_OTYPE_CODE,
                                     P_NOTIFID     => P_NOTIFID,
                                     P_OPER_RESULT => P_OPER_RESULT);
      RETURN;
    END IF;
  
    IF P_OPER_RESULT = 'Y' THEN
      -- ���̴ﵽ��֤���
      IF V_STATUS = 'C' THEN
        --1.У�鸶�����Ƿ�Ϊ��
        IF V_MONEY_AMOUNT = NULL OR V_MONEY_AMOUNT = 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�������뵥�ܽ�����Ϊ��');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --2.У�鸶���ӱ����븶�����뵥����Ƿ�һ��
        SELECT SUM(P.MONEY_AMOUNT)
          INTO V_CHILD_AMOUNT
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;
        IF V_MONEY_AMOUNT <> V_CHILD_AMOUNT THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ',
                                '����¼������Ϣ֧���ܽ���븶������ܽ�����һ��');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --4.У�鸶��ӱ��Ƿ��Ѿ�ȫ��ͬ���ɹ�
        SELECT COUNT(1)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;
      
        IF IS_EXISTS = 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�ø������뵥��δ¼�������Ϣ');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --5.У�鸶��ӱ��Ƿ��Ѿ�ȫ��ͬ���ɹ�
        SELECT COUNT(1)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.STATUS <> 'US'
           AND P.PAYMENT_ID = V_PAYMENT_ID;
      
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�ø������뵥��δ��ȫͬ����EBS');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --���º����ʽ���
/*      
        UPDATE SPM_CON_PAYMENT P
           SET P.CANCEL_AMOUNT = P.MONEY_AMOUNT, P.CANCEL_DATE = SYSDATE
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;*/
        /*  
         --����ˢ���ʽ�ʣ���ȹ��� ȡ�����½��20190417
        SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'C');*/
      ELSIF V_STATUS = 'H' THEN
        --У����Ҫ�ϻ���Ƿ��Ѿ��ϻ�
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT P
         WHERE ((P.IS_MEETING = 'Y' AND P.HAS_MEETING = 'N') OR
               (P.IS_MEETING = 'N' AND P.HAS_MEETING = 'Y'))
           AND P.PAYMENT_ID = V_PAYMENT_ID;
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�����Ƹ��������ϻ�����״̬��Ϣ');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --����ʱ�������Ѿ�������ƿ�Ŀ ����������
      SELECT COUNT(*)
        INTO IS_EXISTS
        FROM SPM_CON_PAYMENT_CHILD P
       WHERE P.STATUS = 'US'
         AND P.PAYMENT_ID = V_PAYMENT_ID;
      IF IS_EXISTS <> 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '�ø����ѳɹ�������Ʒ�¼������ִ�в��ز���');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
  END SPM_CON_PLAN_PAYMENT_WF_TZCL;

  --�ʽ����취��������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PLAN_PAYMENT_TZH;

  /**
      ͨ������HTMLչ�֣�������¼���
      by mcq
      20180810
  */
  FUNCTION SPM_WF_RECORD_HTML(P_KEY IN VARCHAR2, P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    L_DOCUMENT  VARCHAR2(10000);
    VWFPLANNAME VARCHAR2(200);
    V_WF_CODE   VARCHAR2(200); --���̱���
    IDS         SPM_TYPE_TBL := SPM_TYPE_TBL();
  
    CURSOR CUR(V_P_KEY VARCHAR2, V_IDS SPM_TYPE_TBL) IS
      SELECT H.WF_HISTORY_ID,
             H.WF_CODE,
             H.WF_NAME,
             H.WF_POSITION_NAME,
             H.AUDIT_NAME,
             H.AUDIT_RESULT,
             H.AUDIT_INFO,
             TO_CHAR(H.RECEIVE_DATE, 'yyyy-MM-dd HH24:mm:ss') RECEIVE_DATE_TOCHAR,
             TO_CHAR(H.AUDIT_DATE, 'yyyy-MM-dd HH24:mm:ss') AUDIT_DATE_TOCHAR,
             H.AUDIT_EFFICIENCY
        FROM SPM_CON_WF_HISTORY H
       WHERE 1 = 1
         AND H.WF_ITEMKEY = P_KEY
         AND EXISTS
       (SELECT * FROM TABLE(IDS) WHERE COLUMN_VALUE = H.WF_CODE)
      --AND H.WF_CODE IN ('SPM_CON_PAYMENT','SPM_CON_PLAN_PAYMENT')
       ORDER BY H.WF_HISTORY_ID;
    REC CUR%ROWTYPE;
  BEGIN
    --��ȡ������������
    BEGIN
      VWFPLANNAME := WF_ENGINE.GETITEMATTRTEXT(P_OTYPE_CODE,
                                               P_KEY,
                                               'ATT_WF_PLAN_NAME');
    EXCEPTION
      WHEN OTHERS THEN
        VWFPLANNAME := '';
    END;
  
    L_DOCUMENT := '<table class="wf-table"> ' || '<tr>' ||
                  '<td class="wf-label">��������</td>' ||
                  '<td class="wf-label" colspan =7 align="center">' ||
                  VWFPLANNAME || '</td>' || '<tr>' ||
                  '<td class="wf-label" width="10%">��������</td>' ||
                  '<td class="wf-label" width="10%">������Ա</td>' ||
                  '<td class="wf-label" width="10%">�������</td>' ||
                  '<td class="wf-label" colspan =2 width="40%">�������</td>' ||
                  '<td class="wf-label" width="10%">�յ�ʱ��</td>' ||
                  '<td class="wf-label" width="10%">����ʱ��</td>' ||
                  '<td class="wf-label" width="10%">Ч��</td>' || '</tr>';
  
    --GET ID
    SELECT W.WF_CODE
      INTO V_WF_CODE
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    --��Ը���ҵ������һ����ҵ�����
  
    IF INSTR(V_WF_CODE, 'PAYMENT') > 0 THEN
      IDS.EXTEND;
      IDS(1) := 'SPM_CON_PAYMENT';
      IDS.EXTEND;
      IDS(2) := 'SPM_CON_PLAN_PAYMENT';
    ELSE
      IDS.EXTEND;
      IDS(1) := V_WF_CODE;
    END IF;
  
    OPEN CUR(P_KEY, IDS);
    FETCH CUR
      INTO REC;
    WHILE CUR%FOUND LOOP
      L_DOCUMENT := L_DOCUMENT || '<tr>' || '<td >' || REC.WF_POSITION_NAME ||
                    '</td>' || '<td >' || REC.AUDIT_NAME || '</td>' ||
                    '<td>' || REC.AUDIT_RESULT || '</td>' ||
                    '<td colspan =2>' || REC.AUDIT_INFO || ' &nbsp;' ||
                    '</td>' || '<td >' || REC.RECEIVE_DATE_TOCHAR ||
                    '</td>' || '<td >' || REC.AUDIT_DATE_TOCHAR || '</td>' ||
                    '<td >' || REC.AUDIT_EFFICIENCY || '</td>' || '</tr>';
      FETCH CUR
        INTO REC;
    END LOOP;
    L_DOCUMENT := L_DOCUMENT || '</table>';
  
    RETURN L_DOCUMENT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN L_DOCUMENT;
  END SPM_WF_RECORD_HTML;
  /**
      ͨ������HTMLչ�֣�ҵ����Ի�����
      by mcq
      20180810
  */
  FUNCTION SPM_WF_TEMPLATE_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    L_DOCUMENT    VARCHAR2(10000) DEFAULT '';
    T_CONTENT     VARCHAR2(5000) DEFAULT '';
    V_SQL         VARCHAR2(400);
    SQL_VALUE     VARCHAR2(400);
    V_JOB_ID      NUMBER(15);
    V_COLUMN_NAME VARCHAR2(40);
    --Template Content
    CURSOR CUR_TEMPLATE IS
      SELECT T.*, R.TEMPLATE_FIELD_ID, F.SOURCE_NAME
        FROM SPM_WF_TEMPLATE          T,
             SPM_WF_TEMPLATE_RELATION R,
             SPM_WF_REGINFO           WR,
             SPM_CON_WF_ACTIVITY      A,
             SPM_WF_TEMPLATE_FIELD    F
       WHERE T.TEMPLATE_ID = R.TEMPLATE_ID
         AND WR.WFTYPE_ID = R.WFTYPE_ID
         AND T.ENABLE_FLAG = 'Y'
         AND WR.WF_CODE = A.WF_CODE
         AND R.TEMPLATE_FIELD_ID = F.TEMPLATE_FIELD_ID
         AND A.ITEM_KEY = P_KEY;
    --field label cur     
    CURSOR CUR_LABEL IS
      SELECT U.COLUMN_NAME
        FROM ALL_TAB_COLUMNS U
       WHERE U.TABLE_NAME = 'SPM_WF_TEMPLATE_FIELD'
         AND U.COLUMN_NAME LIKE 'LABEL%';
    --field value cur     
    CURSOR CUR_VALUE IS
      SELECT U.COLUMN_NAME
        FROM ALL_TAB_COLUMNS U
       WHERE U.TABLE_NAME = 'SPM_WF_TEMPLATE_FIELD'
         AND U.COLUMN_NAME LIKE 'VALUE%';
  BEGIN
  
    SELECT A.JOB_ID
      INTO V_JOB_ID
      FROM SPM_CON_WF_ACTIVITY A
     WHERE A.ITEM_KEY = P_KEY;
    --1.get Template Content
    FOR REC_TEMPLATE IN CUR_TEMPLATE LOOP
      T_CONTENT := REC_TEMPLATE.TEMPLATE_CONTENT;
      --2.replace Param 
      FOR REC_LABEL IN CUR_LABEL LOOP
        V_SQL := 'select ' || REC_LABEL.COLUMN_NAME ||
                 ' from SPM_WF_TEMPLATE_FIELD F WHERE F.TEMPLATE_FIELD_ID = ' ||
                 REC_TEMPLATE.TEMPLATE_FIELD_ID;
      
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO SQL_VALUE;
        EXCEPTION
          WHEN OTHERS THEN
            SQL_VALUE := '';
        END;
        IF SQL_VALUE IS NOT NULL THEN
          T_CONTENT := REPLACE(T_CONTENT,
                               '${' || REC_LABEL.COLUMN_NAME || '}',
                               SQL_VALUE);
        END IF;
        L_DOCUMENT := T_CONTENT;
      
      END LOOP;
    
      FOR REC_VALUE IN CUR_VALUE LOOP
        V_SQL := 'select ' || REC_VALUE.COLUMN_NAME ||
                 ' from SPM_WF_TEMPLATE_FIELD F WHERE F.TEMPLATE_FIELD_ID = ' ||
                 REC_TEMPLATE.TEMPLATE_FIELD_ID;
      
        BEGIN
          EXECUTE IMMEDIATE V_SQL
            INTO SQL_VALUE;
        EXCEPTION
          WHEN OTHERS THEN
            SQL_VALUE := '';
        END;
        IF SQL_VALUE IS NOT NULL THEN
        
          V_SQL := 'SELECT ' || REC_VALUE.COLUMN_NAME ||
                   ' FROM SPM_WF_TEMPLATE_FIELD WHERE TEMPLATE_FIELD_ID = ' ||
                   REC_TEMPLATE.TEMPLATE_FIELD_ID;
          BEGIN
            EXECUTE IMMEDIATE V_SQL
              INTO V_COLUMN_NAME;
          EXCEPTION
            WHEN OTHERS THEN
              V_COLUMN_NAME := '';
          END;
        
          IF REC_VALUE.COLUMN_NAME <> 'VALUE_TITLE' THEN
          
            V_SQL := 'select ' || V_COLUMN_NAME || ' from ' ||
                     REC_TEMPLATE.SOURCE_NAME || ' R WHERE JOB_ID = ' ||
                     V_JOB_ID;
            BEGIN
              EXECUTE IMMEDIATE V_SQL
                INTO SQL_VALUE;
            EXCEPTION
              WHEN OTHERS THEN
                SQL_VALUE := '';
            END;
          ELSE
            SQL_VALUE := V_COLUMN_NAME;
          END IF;
        
          T_CONTENT := REPLACE(T_CONTENT,
                               '${' || REC_VALUE.COLUMN_NAME || '}',
                               SQL_VALUE);
        END IF;
        L_DOCUMENT := T_CONTENT;
      
      END LOOP;
    
    END LOOP;
  
    RETURN L_DOCUMENT;
  EXCEPTION
    WHEN OTHERS THEN
      L_DOCUMENT := '��������';
      RETURN L_DOCUMENT;
  END SPM_WF_TEMPLATE_HTML;
  /**
      ͨ������HTMLչ�֣�������¼���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_PLAN_PAYMENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    MSG VARCHAR2(20000);
  
  BEGIN
    --1.CREATE TABLE 
    MSG := MSG || '<table class="wf-table">';
  
    --2.GET CSS
    /*SELECT T.TEMPLATE_CONTENT
     INTO MSG
     FROM SPM_WF_TEMPLATE T
    WHERE T.TEMPLATE_NAME = 'CSS';*/
  
    --3.head 
    --MSG := '<html>' || MSG || '<table class="wf-table">';
    /* MSG := '<html>' || '<head>' || '<style>' || '</style>' || '</head>' || '<body>' || '<style type="text/css">' || '  .wf-table{' ||
    ' font-size: 12;' || '  width:100%;' ||
    '  border-collapse:collapse;' ||  '  }' ||
    ' .wf-title, .wf-label{' || ' text-align:center;' ||
    ' font-weight:bold;' || '  }' || '  .wf-table td{' ||
    '  border:1px solid #000;' ||
    '  padding-top:3px; padding-right:7px; padding-bottom:2px; padding-left:7px;' || '  }</style>';*/
  
    --2.GET BUSINESS INFO COMMON FUN 
    MSG := MSG || SPM_WF_TEMPLATE_HTML(P_KEY, P_OTYPE_CODE);
  
    --3.GET GRID INFO 
    --MSG := MSG || SPM_CON_WF_GRID_HTML(P_KEY, P_OTYPE_CODE);
    MSG := MSG || '</table>';
  
    MSG := MSG || '<br/> <br/>';
    --4.GET WF HISTORY INFO COMMON FUN
    MSG := MSG || SPM_WF_RECORD_HTML(P_KEY, P_OTYPE_CODE);
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
  END SPM_CON_PLAN_PAYMENT_HTML;

  /**
      ͨ������HTMLչ�֣��ӱ���
      by mcq
      20180810
  */
  FUNCTION SPM_CON_WF_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    L_DOCUMENT VARCHAR2(10000);
    V_ID       NUMBER(15); --ҵ������ID
  
    CURSOR CUR(P_ID NUMBER) IS
      SELECT * FROM SPM_CON_PAYMENT_INVOICE_V WHERE JOB_ID = P_ID;
    REC CUR%ROWTYPE;
  BEGIN
    --��ȡҵ������ID
    SELECT A.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY A
     WHERE A.ITEM_KEY = P_KEY;
  
    L_DOCUMENT := '<tr> <td colspan =8 align="center"> ������Ʊ��Ϣ''</td> </tr>' ||
                  '<tr>' || '<td class="wf-label">��Ʊ����</td>' ||
                  '<td class="wf-label">ժҪ</td>' ||
                  '<td class="wf-label" colspan =2>��ͬ����</td>' ||
                  '<td class="wf-label" colspan =2>��Ŀ����</td>' ||
                  '<td class="wf-label">��Ʊ���</td>' ||
                  '<td class="wf-label">ʣ����</td>' || '</tr>';
  
    OPEN CUR(V_ID);
    FETCH CUR
      INTO REC;
    WHILE CUR%FOUND LOOP
      L_DOCUMENT := L_DOCUMENT || '<tr>' || '<td >' || REC.INVOICE_CODE ||
                    '</td>' || '<td >' || REC.INVOICE_CONTENT || '</td>' ||
                    '<td colspan =2>' || REC.CONTRACT_NAME || ' &nbsp;' ||
                    '</td>' || '<td colspan =2>' || REC.PROJECT_NAME ||
                    '</td>' || '<td >' || REC.MONEY_AMOUNT || '</td>' ||
                    '<td >' || REC.RESIDUAL_AMOUNT || '</td>' || '</tr>';
      FETCH CUR
        INTO REC;
    END LOOP;
  
    RETURN L_DOCUMENT;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN L_DOCUMENT;
  END SPM_CON_WF_GRID_HTML;

  --��Ʊ���������ص�
  PROCEDURE SPM_CON_RETURN_INVOICE_QD(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      V_POSITION_ID IN VARCHAR2) IS
  
    P_INVOICE_ID NUMBER(15);
  BEGIN
    --��ѯ���̻�� ��ȡ��Ӧ��ƱID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CM_VERIFIC_OUTPUT_INVOICE(P_INVOICE_ID, 'TJ');
  
  END SPM_CON_RETURN_INVOICE_QD;

  --��Ʊ���̲��ػص�
  PROCEDURE SPM_CON_RETURN_INVOICE_BH(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) IS
  
    P_INVOICE_ID NUMBER(15);
  
  BEGIN
    --��ѯ���̻�� ��ȡ��Ӧ��ƱID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CM_VERIFIC_OUTPUT_INVOICE(P_INVOICE_ID, 'BH');
  END SPM_CON_RETURN_INVOICE_BH;

  --��Ʊ��������ͨ���ص��¼�
  PROCEDURE SPM_CON_RETURN_INVOICE_TG(P_KEY     IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) IS
    P_INVOICE_ID NUMBER(15);
  BEGIN
  
    --��ѯ���̻�� ��ȡ��Ӧ��ƱID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CREATE_SERIAL_CODE_FOR_CM(P_INVOICE_ID);
  END SPM_CON_RETURN_INVOICE_TG;

  --���Ʊ��˹�����HTML��Ϣչ��
  FUNCTION SPM_CON_INPUT_INVOICE_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 IS
    MSG     VARCHAR2(10000);
    V_ID    NUMBER;
    V_HT_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID, NVL(I.CONTRACT_ID, 0)
      INTO V_ID, V_HT_ID
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_INPUT_INVOICE I
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = I.INPUT_INVOICE_ID;
  
    IF V_HT_ID = 0 THEN
      --�޺�ͬ
    
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConInputInvoiceNoContract/edit/' || V_ID,
                                                       P_KEY) ||
             '''>�鿴����</a><br>';
    ELSE
      --�к�ͬ
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConInputInvoice/edit/' || V_ID,
                                                       P_KEY) ||
             '''>�鿴����</a><br>';
    END IF;
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_INPUT_INVOICE_HTML;

  --���Ʊ����֪ͨ���ɻص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    GENERATE_HISTORY_INFO(P_NOTIFID,
                          P_ITEMKEY,
                          P_OTYPE_CODE,
                          'SPM_CON_INPUT_INVOICE',
                          'INPUT_INVOICE_ID',
                          'STATUS',
                          'ITEM_KEY',
                          'D',
                          'E');
  END SPM_CON_INPUT_INVOICE_TZSC;

  --���Ʊ����֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_INPUT_INVOICE_TZH;

  --���Ʊ����֪ͨ����ǰ���ص�
  PROCEDURE SPM_CON_INPUT_INVOICE_TZCL(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
    L_NID        NUMBER;
    V_INFO       VARCHAR2(1000);
    V_STATUS     VARCHAR2(40);
    V_EBS_STATUS VARCHAR2(40);
    V_P_SOURCE   VARCHAR2(40);
    IS_EXISTS    NUMBER;
  BEGIN
    L_NID  := WF_ENGINE.CONTEXT_NID;
    V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
  
    SELECT W.STATUS, P.EBS_STATUS
      INTO V_STATUS, V_EBS_STATUS
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_INPUT_INVOICE P
     WHERE W.JOB_ID = P.INPUT_INVOICE_ID
       AND W.ITEM_KEY = P_KEY;
    IF P_OPER_RESULT = 'Y' THEN
    
      IF V_STATUS = 'C' THEN
      
        --���������Դ�ǽ����̣��򸶿���봴����ƿ�Ŀ��������׼
        IF V_EBS_STATUS = 'N' OR V_EBS_STATUS = 'E' THEN
          FND_MESSAGE.SET_NAME('CUX', '��ʾ');
          FND_MESSAGE.SET_TOKEN('��Ϣ', '�ý��Ʊ��δִ��ͬ���������');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --����ʱ�������Ѿ�������ƿ�Ŀ ����������
      IF V_EBS_STATUS <> 'N' AND V_EBS_STATUS <> 'E' THEN
        FND_MESSAGE.SET_NAME('CUX', '��ʾ');
        FND_MESSAGE.SET_TOKEN('��Ϣ',
                              '�ý��Ʊ��ִ��ͬ���������������ִ�в��ز���');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_CON_INPUT_INVOICE_TZCL;
END SPM_CON_CONTRACT_PKG;
/
