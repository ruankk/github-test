CREATE OR REPLACE PACKAGE "SPM_CON_CONTRACT_PKG"
/**
 * @author 张龙龙
 * @date 2017.08.23
 * @desc 处理合同相关事项
 */
 AS

  /**
  * @author: 张龙龙
  * @date:2017.09.24
  * @desc : 流程审批,将审批历史插入流程历史记录表 暂时能用,后续优化异常处理
  * @param p_item_key ITEM_KEY
  * @param p_Otype_Code 流程CODE
  * @param ass_table_name
  *        业务表名称
  * @param ass_table_status
  *        业务表STATUS字段名称,填写此字段名称后,在活动表审批进行过程中,会回填该字段的状态
  * @param fk_name
  *        活动表存储业务表主键的字段,没有活动表不填
  * @param ass_table_pkname
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
  * @author : 张龙龙
  * @date : 2017.12.05
  * @desc : 通知生成后触发的回调函数(公用)
  * @param p_notifid 通知ID
  * @param p_itemkey 流程itemKey
  * @param p_Otype_Code 流程Code
  * @param ass_table 业务表名称,在活动表审批进行过程中,会回填该字段的状态
  * @param ass_col_pkname 业务表主键名
  * @param ass_col_status 业务表状态字段名称
  * @param ass_col_itemkey 业务表ITEM_KEY字段名称
  * @param status_reject 驳回后流程状态
  * @param status_passed 通过后的流程状态
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
  --获取生效合同
  FUNCTION GET_EFFECTIVE_CONTRACT(CONID IN NUMBER) RETURN VARCHAR2;

  --获取生效框架协议合同
  FUNCTION GET_EFFECTIVE_KJXY(CONID IN NUMBER) RETURN VARCHAR2;

  --获取流程节点对应的状态编码
  FUNCTION GET_WF_STATUS_BY_POSITION(P_OTYPE_CODE IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) RETURN VARCHAR2;
  --开启会签
  PROCEDURE SPM_CON_START_HQ(P_KEY IN VARCHAR2, VPOSITOIN_ID IN NUMBER);
  --驳回原因html展现
  FUNCTION SPM_CON_REBUT_REASON_WF_HTML RETURN VARCHAR2;

  --驳回原因字符串截取
  FUNCTION SUBSTR_STR_FOR_HT(V_STR VARCHAR2) RETURN VARCHAR2;

  --驳回原因验证
  FUNCTION SPM_CON_REBUT_REASON_WF_VALI(V_STR VARCHAR2) RETURN VARCHAR2;

  --合同新建流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_CREATION_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同建立流程启动回调
  PROCEDURE SPM_CON_HT_WF_CREATION_START(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --合同新建流程必填验证(通知处理(前)回调)
  PROCEDURE SPM_CON_HT_WF_CREATION_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --合同作废流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_CREATION_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --合同作废通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CREATION_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  /**
      通用流程HTML展现（审批记录表格）
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_WF_CREATION_DIYHTML(P_KEY IN VARCHAR2,
                                          
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  /**
      通用流程HTML展现（子表表格）
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --合同新建流程会签控制
  PROCEDURE SPM_CON_HT_WF_CREATION_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);

  --合同紧急审核流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_URGENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同建立流程启动回调
  PROCEDURE SPM_CON_HT_WF_URGENT_START(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --合同紧急流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_URGENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --合同紧急流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_URGENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);

  --合同紧急新建流程会签控制
  PROCEDURE SPM_CON_HT_WF_URGENT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  --合同盖章流程HTML展现的回调
  FUNCTION SPM_CON_HT_WF_EFFECTIVE_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同盖章流程必填验证(通知回调)
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_VALID(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);

  --合同盖章流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);

  --合同盖章流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --合同盖章流程会签控制
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_RYSZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --合同生效流程HTML展现的回调
  FUNCTION SPM_CON_HT_WF_EFFECT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同生效流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --合同生效流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);
  --合同生效流程会签控制
  PROCEDURE SPM_CON_HT_WF_EFFECT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  ----合同变更作废流程HTML展现的回调
  FUNCTION SPM_CON_HT_WF_CHANGE_VOID_HTML(P_KEY        IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同变更作废流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);

  --合同变更作废流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_TZH(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --合同变更作废流程会签控制
  PROCEDURE SPM_CON_HT_WF_CHANGE_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                           OTYPECODE    IN VARCHAR2,
                                           PPOSITION_ID IN NUMBER);

  --合同增补盖章流程HTML展现的回调
  FUNCTION SPM_CON_HT_WF_SEAL_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --合同增补盖章流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_SEAL_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --合同增补盖章流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_SEAL_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);
  --合同增补盖章流程会签控制
  PROCEDURE SPM_CON_HT_WF_SEAL_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER);

  --合同作废流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_VOID_HTML(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --合同作废流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --合同作废通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_VOID_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --合同作废流程会签控制
  PROCEDURE SPM_CON_HT_WF_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER);

  --订单合同作废流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_ORDER_VOID_HTML(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --订单合同作废流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);

  --订单合同作废通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZH(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --合同变更流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_CHANGE_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同变更流程必填验证(通知回调)
  PROCEDURE SPM_CON_HT_WF_CHANGE_VALID(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --合同变更流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --合同变更通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);

  --合同变更流程会签控制
  PROCEDURE SPM_CON_HT_WF_CHANGE_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --合同中止流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_SUSPEND_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同中止流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);

  --合同中止通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);

  --合同中止流程会签控制
  PROCEDURE SPM_CON_HT_WF_SUSPEND_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);
  --合同恢复流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_RECOVERY_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同恢复流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --合同恢复通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --合同恢复流程会签控制
  PROCEDURE SPM_CON_HT_WF_RECOVERY_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);
  --合同归档流程HTML展现回调
  FUNCTION SPM_CON_HT_WF_ARCHIVED_HTML(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --合同归档流程启动回调函数
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_START(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);
  --合同归档流程接收验证(通知回调)
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_VALID(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --合同归档流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --合同归档流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);

  --合同归档流程会签控制
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER);
  --合同关闭流程HTML展现的回调函数
  FUNCTION SPM_CON_HT_WF_CLOSING_HTML(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --合同关闭流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);

  --合同关闭流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --合同变更流程会签控制
  PROCEDURE SPM_CON_HT_WF_CLOSING_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);
  --数据权限的函数(项目)
  FUNCTION SPM_CON_DATAPERMISSION_PROJECT(CID NUMBER) RETURN VARCHAR2;

  --数据权限的函数(部门)
  FUNCTION SPM_CON_DATAPERMISSION_DEPT(CID NUMBER) RETURN VARCHAR2;

  --判断当前itemkey下审批历史是否插入SPM审批历史表，避免重复插入的情况
  FUNCTION JUDGE_IS_EXIST_HISTORY(P_KEY IN VARCHAR2, P_DATE IN DATE)
    RETURN VARCHAR2;

  --供应商查看详情回调
  FUNCTION SPM_CON_VENDOR_VIEW_INFO(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --供应商提交（注册，准入，战略）审核时，将供应商状态转变为：审核中“AP ”
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);

  --供应商审核通过后，将供应商的状态更新为：已审核“E ”
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);

  --供应商审核被驳回后，更新供应商状态为：驳回“D ”
  PROCEDURE SPM_CON_VENDOR_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);

  --供应商年度审核工作流HTML信息展现
  FUNCTION SPM_CON_VENDOR_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --供应商年审通过后，更新供应商的等级
  PROCEDURE SPM_CON_VENDOR_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                        OTYPECODE IN VARCHAR2);
  --供应商流程通知生成回调
  PROCEDURE SPM_CON_VENDOR_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                     
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);

  --供应商流程通知处理(后)回调
  PROCEDURE SPM_CON_VENDOR_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --供应商年度审核流程通知生成回调
  PROCEDURE SPM_CON_VENDOR_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                     
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);

  --供应商年度审核流程通知处理(后)回调
  PROCEDURE SPM_CON_VENDOR_YEAR_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --客户年度审核流程通知生成回调
  PROCEDURE SPM_CON_CUST_YEAR_TZSC(P_NOTIFID IN VARCHAR2,
                                   
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --客户年度审核流程通知处理(后)回调
  PROCEDURE SPM_CON_CUST_YEAR_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);

  --客户审核“查看详情”回调
  FUNCTION SPM_CON_CUST_VIEW_INFO(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --客户提交（注册，准入，战略）审核时，将客户状态转变为：审核中“AP ”
  PROCEDURE SPM_CON_CUST_SET_STATUS_AP(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER);

  --客户审核通过后，将客户的状态更新为：已审核“E ”
  PROCEDURE SPM_CON_CUST_SET_STATUS_E(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);

  --客户审核被驳回后，更新客户状态为：驳回“D ”
  PROCEDURE SPM_CON_CUST_SET_STATUS_D(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);

  --客户年度审核工作流HTML信息展现
  FUNCTION SPM_CON_CUST_VIEW_YEAR(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --客户年审通过后，更新客户的等级
  PROCEDURE SPM_CON_CUST_UPDATE_LEVEL(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --定期生成供应商年度审核
  PROCEDURE SPM_CON_PRODUCE_YEAR_REVIEW;

  --收款审批工作流HTML信息展现
  FUNCTION CLS_RECEIPT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
  PROCEDURE SET_GOODS_WF_STATUS_TO_1(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER);

  --工程管理审批html展现
  FUNCTION CLS_CON_ENG_WF_HTML(P_KEY IN VARCHAR2, POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --工程流程通知生成回调
  PROCEDURE SPM_CON_ENG_TZSC(P_NOTIFID    IN VARCHAR2,
                             P_ITEMKEY    IN VARCHAR2,
                             P_OTYPE_CODE IN VARCHAR2);

  --工程流程通知处理(后)回调
  PROCEDURE SPM_CON_ENG_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2);
  --工程管理审批流程发起
  PROCEDURE SPM_CON_WF_ENG_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER);
  --工程驳回回调
  PROCEDURE SPM_CON_WF_ENG_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);
  --工程审批批准回调
  PROCEDURE SPM_CON_WF_ENG_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2);
  --工程审批通过回调
  PROCEDURE SPM_CON_WF_ENG_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --项目管理审批html展现
  FUNCTION CLS_CON_PROJECT_WF_HTML(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --项目流程通知生成回调
  PROCEDURE SPM_CON_PROJECT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);
  --项目流程通知处理(后)回调
  PROCEDURE SPM_CON_PROJECT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --项目管理审批流程发起
  PROCEDURE SPM_CON_WF_PROJECT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER);
  --项目驳回回调
  PROCEDURE SPM_CON_WF_PROJECT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --项目审批批准回调
  PROCEDURE SPM_CON_WF_PROJECT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2);
  --项目审批通过回调
  PROCEDURE SPM_CON_WF_PROJECT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2);
  --发票退票管理html展现
  FUNCTION SPM_CON_RETURN_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --发票退票管理流程审批通过后，将对应发票的状态更新为：已退回“R”
  PROCEDURE SET_INVOICE_STATUS_TO_R(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);

  --预付款发票流程审批html展现
  FUNCTION SPM_CON_IMP_INVOICE_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --查询预付款可用金额（剩余金额 - 锁定状态的预付款核销金额）
  FUNCTION SPM_CON_QUERY_LOCKED_MONEY(RECEIPT_ID IN NUMBER) RETURN NUMBER;

  --销项发票通过审核后，将该条数据核销的预收款回写到预收款剩余金额中
  PROCEDURE SET_RESIDUAL_AMOUNT(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --投标保证金流程审批html展现
  FUNCTION SPM_CON_BID_DEPOSIT_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --投标保证金流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_BID_DEPOSIT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --投标保证金流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_BID_DEPOSIT_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --投标保证金提交流程时，
  /*procedure spm_con_bid_deposit_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/

  --投标保证金审批流程批准回调函数
  /*PROCEDURE spm_con_bid_deposit_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/

  --投标保证金管理流程审批通过回调
  /*procedure spm_con_bid_deposit_wf_TG(itemkey   in varchar2,
  otypecode in varchar2);*/
  --投标保证金审批流程驳回时
  /*procedure spm_con_bid_deposit_wf_BH(itemkey   in varchar2,
  otypecode in varchar2); */

  --月度收付款计划管理html展现
  FUNCTION SPM_CON_MONTH_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --月度收付款计划管理流程发起
  /*procedure spm_con_month_plan_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --月度收付款计划管理流程批准回调函数
  PROCEDURE SPM_CON_MONTH_PLAN_WF_PZ(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --月度收付款计划管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_MONTH_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);
  --月度收付款计划管理流程通知回调函数（通知处理前）
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --月度收付款计划管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --月度收付款计划管理审批通过回调
  /*procedure spm_con_month_plan_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --月度收付款计划管理驳回回调
  PROCEDURE SPM_CON_MONTH_PLAN_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);

  --月度计划汇总管理html展现
  FUNCTION SPM_CON_MONTHGATHER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --月度计划汇总管理流程批准回调函数
  PROCEDURE SPM_CON_MONTHGATHER_WF_PZ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --月度计划汇总管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_MONTHGATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --月度计划汇总管理流程通知回调函数（通知处理前）
  PROCEDURE SPM_CON_MONTHGATH_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --月度计划汇总管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_MONTHGATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --月度计划汇总管理驳回回调
  PROCEDURE SPM_CON_MONTHGATHER_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --周度收付款计划管理html展现
  FUNCTION SPM_CON_WEEK_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --周度收付款计划管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_WEEK_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);
  --周度收付款计划管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_WEEK_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);
  --周度收付款计划管理流程发起
  /*procedure spm_con_week_plan_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --周度收付款计划管理流程批准回调函数
  /*PROCEDURE spm_con_week_plan_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --周度收付款计划管理审批通过回调
  /*procedure spm_con_week_plan_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --周度收付款计划管理驳回回调
  /*procedure spm_con_week_plan_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --周度计划汇总管理html展现
  FUNCTION SPM_CON_WEEK_GATHER_WF_HTML(P_KEY IN VARCHAR2,
                                       
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --周度计划汇总管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_WEEK_GATHER_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --周度计划汇总管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_WEEK_GATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --投标管理html展现
  FUNCTION SPM_CON_BID_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --投标管理流程发起
  /*procedure spm_con_bid_info_wf_TJ(itemkey      in varchar2,
  otypecode    in varchar2,
  pPosition_id in number);*/
  --投标管理流程会签回调函数
  PROCEDURE SPM_CON_BID_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);
  --投标管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_BID_INFO_WF_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --投标管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_BID_INFO_WF_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --投标管理流程驳回验证回调函数（通知处理前）
  /*PROCEDURE spm_con_bid_info_wf_TZCL_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --投标管理审批通过回调
  PROCEDURE SPM_CON_BID_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --投标管理驳回回调
  /*procedure spm_con_bid_info_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --投标管理紧急流程通知回调函数(通知生成后)
  PROCEDURE SPM_CON_BID_URGENT_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2);
  --投标管理紧急流程通知回调函数（通知处理后）
  /*PROCEDURE spm_con_bid_urgent_TZCL_AFTER(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);  */

  --投标管理紧急审批通过回调
  PROCEDURE SPM_CON_BID_URGENT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --投标管理紧急驳回回调
  /*procedure spm_con_bid_urgent_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2); */
  --投标管理中标确认流程发起
  PROCEDURE SPM_CON_BID_CONFIRM_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);

  --投标管理中标确认流程通知回调函数(通知生成后)
  PROCEDURE SPM_CON_BID_CONFIRM_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --投标管理中标确认流程批准回调函数
  /*PROCEDURE spm_con_bid_confirm_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --投标管理审批中标确认通过回调
  /*procedure spm_con_bid_confirm_wf_TG(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/
  --投标管理中标确认驳回回调
  PROCEDURE SPM_CON_BID_CONFIRM_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --收付款计划维护管理html展现
  FUNCTION SPM_CON_CLAUSE_PLAN_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --收付款计划维护管理流程发起
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --收付款计划维护管理流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);
  --收付款计划维护管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --收付款计划维护管理流程批准回调函数
  /* PROCEDURE spm_con_clause_plan_wf_PZ(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  vPositoin_id in VARCHAR2);*/
  --收付款计划维护管理审批通过回调
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --收付款计划维护管理驳回回调
  /*procedure spm_con_clause_plan_wf_BH(itemkey   IN VARCHAR2,
  otypecode In VARCHAR2);*/

  --工作交接管理html展现
  FUNCTION SPM_CON_HANDOV_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --工作交接流程通知回调函数（通知生成后）
  PROCEDURE SPM_CON_HANDOV_INFO_TZSC_AFTER(P_NOTIFID    IN VARCHAR2,
                                           P_ITEMKEY    IN VARCHAR2,
                                           P_OTYPE_CODE IN VARCHAR2);

  --工作交接流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_HANDOV_INFO_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);

  --工作交接管理流程会签回调函数
  PROCEDURE SPM_CON_HANDOV_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);

  --付款审批流程
  FUNCTION CLS_PAYMENT_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                     POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  PROCEDURE SALES_ORDER_PERSON_PR(P_KEY                  VARCHAR2,
                                  POTYPE_CODE            VARCHAR2,
                                  VGROUP_ID              NUMBER,
                                  VPOSITION_STRUCTURE_ID NUMBER,
                                  VPOSITOIN_ID           VARCHAR2);

  FUNCTION SPM_GET_FIRST_POSITION_ID(P_TABLE_NAME VARCHAR2,
                                     P_OTYPE_CODE VARCHAR2) RETURN VARCHAR2;

  --获取审批流程的第一个环节positionid
  FUNCTION SPM_CON_GET_FIRST_POSITION_ID(P_KEY       IN VARCHAR2,
                                         POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --检查planid
  FUNCTION GET_CHECK_POSITION_STRU(POTYPE_CODE       IN VARCHAR2,
                                   PPOSITION_STRU_ID IN NUMBER,
                                   PITEMKEY          IN VARCHAR2,
                                   PITEMKEYNAME      IN VARCHAR2)
    RETURN VARCHAR2;
  --销售订单设置会签
  PROCEDURE SETISCOUNTERSIGNFORPROREPORT(P_KEY        IN VARCHAR2,
                                         POTYPE_CODE  IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2);
  --合同模板审批流程发起
  PROCEDURE SPM_CON_WF_TEMPLATE_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER);
  --合同模板审批html展现
  FUNCTION CLS_CON_TEMPLATE_WF_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --合同模板驳回回调
  PROCEDURE SPM_CON_WF_TEMPLATE_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);
  --合同模板审批批准回调
  PROCEDURE SPM_CON_WF_TEMPLATE_PZ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);
  --合同模板审批通过回调
  PROCEDURE SPM_CON_WF_TEMPLATE_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);
  --新建保函审批流程
  FUNCTION CLS_BACKLETTER_INFO_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --新建保函审批流程发起
  PROCEDURE CLS_BACKLETTER_INFO_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER);
  --新建保函驳回回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --新建保函审批批准回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_PZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);
  --新建保函审批通过回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --收到保函审批流程
  FUNCTION CLS_BACKLETTER_RECEIVE_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --收到保函管理审批流程发起
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER);
  --收到保函驳回回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --收到保函审批批准回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2);
  --收到保函审批通过回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2);
  --信用证审批流程
  FUNCTION CLS_CON_CREDIT_WF_HTML(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --信用证审批流程发起
  PROCEDURE CLS_CON_CREDIT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER);
  --信用证驳回回调
  PROCEDURE CLS_CON_CREDIT_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --信用证审批批准回调
  PROCEDURE CLS_CON_CREDIT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2);
  --信用证审批通过回调
  PROCEDURE CLS_CON_CREDIT_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --信用证付款审批流程
  FUNCTION CLS_CREDIT_PAY_WF_HTML(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --信用证付款审批流程发起
  PROCEDURE CLS_CREDIT_PAY_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER);
  --信用证付款驳回回调
  PROCEDURE CLS_CREDIT_PAY_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --信用证付款审批批准回调
  PROCEDURE CLS_CREDIT_PAY_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2);
  --信用证付款审批通过回调
  PROCEDURE CLS_CREDIT_PAY_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2);
  --补充收款单审批流程
  FUNCTION CLS_CREDIT_RECEIPT_WF_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --补充收款单审批流程发起
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER);
  --补充收款单驳回回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);
  --补充收款单审批批准回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2);
  --补充收款单审批通过回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2);

  --入库单审批html展现
  FUNCTION CLS_WAREHOUSE_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                       POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --出库单审批html展现
  FUNCTION CLS_ODO_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --交货计划审批html展现
  FUNCTION CLS_GOODS_PLAN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                        POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --退货单审批html展现
  FUNCTION CLS_SALES_RETURN_ORDER_WF_HTML(P_KEY       IN VARCHAR2,
                                          POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --客户流程通知生成回调
  PROCEDURE SPM_CON_CUST_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                   P_ITEMKEY    IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2);

  --客户流程通知处理(后)回调
  PROCEDURE SPM_CON_CUST_INFO_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2);
  --保函新建流程通知生成回调
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZSC(P_NOTIFID IN VARCHAR2,
                                         
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);

  --保函新建流程通知处理(后)回调
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --保函收到流程通知生成回调
  PROCEDURE SPM_CON_RECEIVE_TZSC(P_NOTIFID IN VARCHAR2,
                                 
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);

  --保函收到流程通知处理(后)回调
  PROCEDURE SPM_CON_RECEIVE_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --信用证流程通知生成回调
  PROCEDURE SPM_CON_CREDIT_TZSC(P_NOTIFID IN VARCHAR2,
                                
                                P_ITEMKEY    IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2);

  --信用证流程通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2);
  --信用证付款流程通知生成回调
  PROCEDURE SPM_CON_CREDIT_PAY_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --信用证流程通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_PAY_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);
  --补充收款单流程通知生成回调
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZSC(P_NOTIFID IN VARCHAR2,
                                        
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);

  --补充收款单流程通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
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

  --出库单流程通知处理(前)回调
  PROCEDURE SPM_CON_ODO_TZCL(P_KEY         IN VARCHAR2,
                             P_OTYPE_CODE  IN VARCHAR2,
                             P_NOTIFID     IN VARCHAR2,
                             P_OPER_RESULT IN VARCHAR2);

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
  --预付款发票流程通知生成回调
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                         P_ITEMKEY    IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2);
  --预付款发票流程通知处理(后)回调
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2);
  --付款流程审批通过回调
  PROCEDURE SPM_CON_PAYMENT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --付款流程审批驳回回调
  PROCEDURE SPM_CON_PAYMENT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --付款流程通知生成回调
  PROCEDURE SPM_CON_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                 P_ITEMKEY    IN VARCHAR2,
                                 P_OTYPE_CODE IN VARCHAR2);
  --付款流程通知处理(后)回调
  PROCEDURE SPM_CON_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2);
  --付款流程通知处理（前）回调
  PROCEDURE SPM_CON_PAYMENT_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2);
  --销项发票流程流程通知生成回调
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);
  --销项发票流程通知处理(后)回调
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  --销项发票退票流程流程通知生成回调
  PROCEDURE SPM_CON_RETURN_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2);
  --销项发票退票流程通知处理(后)回调
  PROCEDURE SPM_CON_RETURN_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
  --合同交接流程必填验证(通知回调)
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

  PROCEDURE SPM_CON_OUTPUT_INVOICE_RY(V_P_KEY                 VARCHAR2,
                                      P_OTYPE_CODE            VARCHAR2,
                                      V_GROUP_ID              NUMBER,
                                      V_POSITION_STRUCTURE_ID NUMBER,
                                      V_POSITION_ID           VARCHAR2);
  --供应商是否同步ebs
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2;

  --定向账户流程通知生成回调
  PROCEDURE SPM_CON_OR_ACCOUNT_TZSC(P_NOTIFID IN VARCHAR2,
                                    
                                    P_ITEMKEY    IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);

  --定向账户流程通知处理(后)回调
  PROCEDURE SPM_CON_OR_ACCOUNT_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2);

  --销项发票审批通过回调
  PROCEDURE SPM_CON_OUTPUT_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --定向账户查看详情回调
  FUNCTION SPM_CON_OR_ACCOUNT_INFO(P_KEY       IN VARCHAR2,
                                   POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  /*销项发票审批驳回回调*/
  PROCEDURE SPM_CON_OUTPUT_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --资金管理办法付款申请HTML展现
  FUNCTION SPM_CON_PLAN_PAYMENT_WF_HTML(P_KEY        IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  --资金管理办法付款流程启动回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_QD(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    V_POSITION_ID IN VARCHAR2);

  --资金管理办法付款流程驳回回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_BH(P_KEY        IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2);
  --资金管理办法付款流程审批通过回调事件
  PROCEDURE SPM_CON_PLAN_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2);

  --资金管理办法付款流程通知生成回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZSC(P_NOTIFID    IN VARCHAR2,
                                      P_ITEMKEY    IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --资金管理办法付款流程通知处理（前）回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_WF_TZCL(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);

  --资金管理办法付款流程通知处理(后)回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2);
  /**
      付款流程HTML展现回调事件
      by mcq
      20180810
  */
  FUNCTION SPM_CON_PLAN_PAYMENT_HTML(P_KEY        IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;

  /**
      通用流程HTML展现（审批记录表格）
      by mcq
      20180810
  */
  FUNCTION SPM_WF_RECORD_HTML(P_KEY IN VARCHAR2, P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  /**
      通用流程HTML展现（业务个性化区域）
      by mcq
      20180810
  */
  FUNCTION SPM_WF_TEMPLATE_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  /**
      通用流程HTML展现（子表表格）
      by mcq
      20180810
  */
  FUNCTION SPM_CON_WF_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --退票流程启动回调
  PROCEDURE SPM_CON_RETURN_INVOICE_QD(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      V_POSITION_ID IN VARCHAR2);

  --退票流程驳回回调
  PROCEDURE SPM_CON_RETURN_INVOICE_BH(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2);

  --退票流程审批通过回调事件
  PROCEDURE SPM_CON_RETURN_INVOICE_TG(P_KEY     IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2);
  --进项发票查看详情回调
  FUNCTION SPM_CON_INPUT_INVOICE_HTML(P_KEY       IN VARCHAR2,
                                      POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --进项发票流程通知生成回调
  PROCEDURE SPM_CON_INPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                       P_ITEMKEY    IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2);
  --进项发票流程通知处理(后)回调
  PROCEDURE SPM_CON_INPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2);
  --进项发票流程通知处理（前）回调
  PROCEDURE SPM_CON_INPUT_INVOICE_TZCL(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2);
END SPM_CON_CONTRACT_PKG;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_CONTRACT_PKG" AS

  /**
  * @author: 张龙龙
  * @date:2017.09.24
  * @desc : 流程审批,将审批历史插入流程历史记录表 暂时能用,后续优化异常处理
  * @param p_item_key ITEM_KEY
  * @param p_Otype_Code 流程CODE
  * @param ass_table_name
  *        业务表名称
  * @param ass_table_status
  *        业务表STATUS字段名称,填写此字段名称后,在活动表审批进行过程中,会回填该字段的状态
  * @param fk_name
  *        活动表存储业务表主键的字段,没有活动表不填
  * @param ass_table_pkname
  *        业务表主键字段名称
  * @version V1.1 ON 2018.11.25 by 欧榕 增加增补盖章4个方法
             V1.2 ON 2018.11.30 by 欧榕 生效驳回从BD改为DD
             V1.3 ON 2018.12.14 BY 欧榕 增加变更作废4个方法
             V1.4 ON 2018.1.3 BY 马传奇 添加合同审批及合同变更审批页面展现回调事件
             V1.5 ON 2018.1.4 BY 欧榕 生效时，回写主表生效时间
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
    SV           NUMBER; --sequenceValue存储序列值
    NR           NUMBER; --new Record 新审批记录的WF_ID
    PKVAL        NUMBER; --参与流程的主键ID
    PKNAME       VARCHAR2(32); --参与流程的主键列名
    VSQL         VARCHAR2(2000);
    VSTATUS      VARCHAR2(40);
    RECEVIEDATE  DATE; --接收时间
    VCOU         NUMBER;
    V_UP_POSITON NUMBER; --当前流程所处的审批节点
    IS_EXIST     VARCHAR2(1);
  BEGIN
    --Step1.根据流程CODE获取流程的配置信息
    SELECT * BULK COLLECT
      INTO WFRI
      FROM SPM_WF_REGINFO S
     WHERE S.WF_CODE = P_OTYPE_CODE;
    --Step2.组装SQL，查询pkVal
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
  
    --Step3.获取序列
    SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
  
    --Step4.获取新审批记录的WF_ID
    SELECT MAX(WF_ID)
      INTO NR
      FROM CUX_WF_HISTORY_INFO S
     WHERE S.AUDIT_INFO IS NOT NULL
       AND WF_ITEMKEY = P_ITEM_KEY;
  
    --Step5.获取接收时间
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
  
    --Step6.插入历史表
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
    --Step7.获得当前流程所处的父节点，如果是首个节点，则为空
    SELECT P.UP_WF_PLAN_POSITION_ID
      INTO V_UP_POSITON
      FROM CUX_WF_HISTORY_INFO S, CCM_WF_PLAN_POSITION P
     WHERE S.WF_POSITION_ID = P.WF_PLAN_POSITION_ID
       AND S.WF_ITEMKEY = P_ITEM_KEY
       AND S.WF_ID = NR;
    --Step8.更改业务表STATUS字段
    IF ASS_TABLE_STATUS IS NOT NULL AND ASS_TABLE_PKNAME IS NOT NULL AND
       V_UP_POSITON IS NOT NULL THEN
      VSQL := 'UPDATE ' || ASS_TABLE_NAME || ' SET ' || ASS_TABLE_STATUS ||
              ' = ''' || VSTATUS || '''' || ' WHERE ' || ASS_TABLE_PKNAME ||
              ' = ''' || PKVAL || '''';
      EXECUTE IMMEDIATE VSQL;
    END IF;
  
  END SAVE_WF_HISTORY;

  /**
  * @author : 张龙龙
  * @date : 2017.12.05
  * @desc : 通知生成后触发的回调函数(公用)
  * @param p_notifid 通知ID
  * @param p_itemkey 流程itemKey
  * @param p_Otype_Code 流程Code
  * @param ass_table 业务表名称,在活动表审批进行过程中,会回填该字段的状态
  * @param ass_col_pkname 业务表主键名
  * @param ass_col_status 业务表状态字段名称
  * @param ass_col_itemkey 业务表ITEM_KEY字段名称
  * @param status_reject 驳回后流程状态
  * @param status_passed 通过后的流程状态
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
    SV              NUMBER; --sequenceValue存储序列值
    PKVAL           NUMBER; --参与流程的主键ID
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
  
    --获取通知信息
    SELECT * BULK COLLECT
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
      
        --Step1.根据流程CODE获取流程的配置信息
        SELECT * BULK COLLECT
          INTO WFRI
          FROM SPM_WF_REGINFO S
         WHERE S.WF_CODE = P_OTYPE_CODE;
      
        --Step2.获取序列
        SELECT SPM_CON_WF_HISTORY_SEQ.NEXTVAL INTO SV FROM DUAL;
      
        --Step3.获取审批节点信息
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
        * Step4.判断是否存在流程委托信息,如果有,加标识
        * 被委托人不在当前节点:显示代XX审批
        * 被委托人在当前节点: 显示同时代XX审批
        */
        --判断当前通知接收人是否是被委托人(生效期内)
        SELECT COUNT(1)
          INTO A
          FROM SPM_WF_ENTRUST S
         WHERE S.WF_CODE = P_OTYPE_CODE
           AND S.TO_USER_ID = WN(1).RECIPIENT_ROLE
           AND TRUNC(SYSDATE) <= TRUNC(S.END_DATE)
           AND TRUNC(SYSDATE) >= TRUNC(S.START_DATE);
      
        IF A > 0 THEN
        
          --获取委托人信息
          SELECT S.FROM_USER_ID BULK COLLECT
            INTO EU
            FROM SPM_WF_ENTRUST S
           WHERE S.WF_CODE = P_OTYPE_CODE
             AND S.TO_USER_ID = WN(1).RECIPIENT_ROLE
             AND TRUNC(SYSDATE) <= TRUNC(S.END_DATE)
             AND TRUNC(SYSDATE) >= TRUNC(S.START_DATE);
        
          --判断当前通知接收人是否原本就处于当前节点的审批流程中
          SELECT COUNT(1)
            INTO B
            FROM CCM_WF_PLAN_POSITION_USER A, FND_USER B
           WHERE A.USER_ID = B.USER_ID
             AND A.WF_PLAN_POSITION_ID = V_POSITION_ID
             AND B.USER_NAME = WN(1).RECIPIENT_ROLE
             AND NVL(B.END_DATE, SYSDATE + 1) > SYSDATE;
        
          /*
          * 判断委托人是否在当前节点
          *
          * 因为流程委托是整个流程的委托,委托人不一定在当前节点,但所有节点均可以查询到委托信息
          * 假设流程有 P1-P2(A)-P3(B)-P4 4个点
          * P2审批人为A,P3审批人为B,B委托给了A
          * 当流程处于P2点实,A能查询到自己成为被委托人
          * 但当前节点P2却并不是委托节点(P3才是)
          * 当前节点不是委托节点,就没必要在生成审批历史记录时显示委托信息
          * 所以才要查询委托人是否处于当前节点
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
              CU := '（同时代 ' || SUBSTR(CU, 0, LENGTH(CU) - 1) || ' 审批）';
            ELSE
              CU := '（代 ' || SUBSTR(CU, 0, LENGTH(CU) - 1) || ' 审批）';
            END IF;
          END IF;
        
        END IF;
        CU := SPM_COMMON_PKG.GET_FULLNAME_BY_USERNAME(WN(1).RECIPIENT_ROLE) || CU;
        --Step5.生成审批历史
      
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
      
        --Step6.修改主表状态
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
  
    --批准后修改审批信息
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
  
    --如果非会签节点还有其他人收到通知，删除
    --查询是否会签节点
  
    BEGIN
      --针对删节点情况，添加异常处理
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
        DBMS_OUTPUT.PUT_LINE('节点被删除，所以此处捕获异常!');
    END;
  
  END UPDATE_HISTORY_INFO;

  --获取生效合同
  FUNCTION GET_EFFECTIVE_CONTRACT(CONID IN NUMBER) RETURN VARCHAR2 AS
    V_RESULT  VARCHAR2(32);
    V_STATUS  VARCHAR2(32);
    V_CHANGE  VARCHAR2(32);
    V_CONNAME VARCHAR2(1000); --防止选择预导入的订单合同
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

  --获取生效框架协议(只要不是草稿,新建驳回或者作废流程就认为是生效)
  FUNCTION GET_EFFECTIVE_KJXY(CONID IN NUMBER) RETURN VARCHAR2 AS
    V_RESULT VARCHAR2(32);
    V_STATUS VARCHAR2(32);
  BEGIN
  
    SELECT S.STATUS
      INTO V_STATUS
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID
       AND S.STATUS_CHANGE = 1; --非变更过程中合同
    --A草稿,D驳回,I作废
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

  --获取流程节点对应的状态编码
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

  --开启会签
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
      --取消会签
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 0.1);
    
    END IF;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Code = ' || TO_CHAR(SQLCODE));
      DBMS_OUTPUT.PUT_LINE('Error Message = ' || SQLERRM);
      -- 回滚事务
      ROLLBACK;
  END;

  --驳回原因html展现
  FUNCTION SPM_CON_REBUT_REASON_WF_HTML RETURN VARCHAR2 IS
    V_MSG        VARCHAR2(20000);
    V_MSG_REASON VARCHAR2(20000);
    V_DICT_CODE  VARCHAR2(40);
    V_DICT_NAME  VARCHAR2(400);
  
    --类型定义
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
      --循环开始
      LOOP
        FETCH REASON
          INTO V_DICT_CODE, V_DICT_NAME;
        EXIT WHEN REASON%NOTFOUND; --当没有记录时退出循环
        V_MSG_REASON := V_MSG_REASON || '<option value=''' || V_DICT_CODE ||
                        '''>' || V_DICT_NAME || '</option>';
      END LOOP;
      CLOSE REASON;
    END;
  
    V_MSG := '<font>驳回原因 ：</font>
       <select id="rebutReason" onchange="rebutCheck();">
             <option value="0" selected="selected">---请选择---</option>' ||
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
      V_MSG := '出错啦！';
      RETURN V_MSG;
  END;

  --驳回原因字符串截取
  FUNCTION SUBSTR_STR_FOR_HT(V_STR VARCHAR2) RETURN VARCHAR2 IS
    V_A NUMBER;
    V_B NUMBER;
    V_C VARCHAR2(200);
  BEGIN
    SELECT INSTR(V_STR, '【'), INSTR(V_STR, '】') INTO V_A, V_B FROM DUAL;
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

  --驳回原因验证
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

  --合同新建流程HTML展现回调
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
           '''>查看详情</a><br>';
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CREATION_HTML;

  --合同建立流程启动回调
  PROCEDURE SPM_CON_HT_WF_CREATION_START(P_KEY        IN VARCHAR2,
                                         P_OTYPE_CODE IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    PKVAL NUMBER;
  BEGIN
    --启动后，所有附件禁止删除
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
  --合同新建流程必填验证(通知回调)
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
      --点击批准时,需要验证是否已经签名
    
      SELECT JOB_ID
        INTO CONID
        FROM SPM_CON_WF_ACTIVITY
       WHERE ITEM_KEY = P_KEY;
    
      SELECT SIGNER_CLAUSE, SIGNER_DIFF
        INTO SIGNER_CLAUSE, SIGNER_DIFF
        FROM SPM_CON_HT_INFO
       WHERE CONTRACT_ID = CONID;
    
      IF SIGNER_CLAUSE IS NULL OR SIGNER_DIFF IS NULL THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '收付款条款、合同差异表需要您签名');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    ELSIF P_OPER_RESULT = 'N' THEN
      L_NID  := WF_ENGINE.CONTEXT_NID;
      V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
      COU    := SPM_CON_REBUT_REASON_WF_VALI(V_INFO);
      IF COU = 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '驳回原因不匹配');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_CREATION_VALID;

  --合同新建流程通知生成回调
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

  --合同新建流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CREATION_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CREATION_TZH;

  /**
      通用流程HTML展现（审批记录表格）
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
      MSG := '出错啦！';
      RETURN MSG;
  END SPM_CON_HT_WF_CREATION_DIYHTML;

  /**
      通用流程HTML展现（子表表格）
      by mcq
      20180810
  */
  FUNCTION SPM_CON_HT_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    L_DOCUMENT VARCHAR2(10000);
    V_ID       NUMBER(15); --业务数据ID
  
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
             DECODE(S.MERCHANTS_FLAG, '1', '客户', 2, '供应商', 3, '') MERCHANTS_FLAG_NAME,
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
             DECODE(S.MERCHANTS_FLAG, '1', '客户', 2, '供应商', 3, '') MERCHANTS_FLAG_NAME,
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
    --获取业务数据ID
    SELECT A.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY A
     WHERE A.ITEM_KEY = P_KEY;
  
    L_DOCUMENT := '<tr> <td colspan =8 align="center"> 供应商/客户信息</td> </tr>' ||
                  '<tr>' || 
                  '<td class="wf-label" colspan =4>对方名称</td>' ||
                  '<td class="wf-label" colspan =3>对方编号</td>' ||
                  '<td class="wf-label">类型</td>' || '</tr>';
  
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

  --合同新建流程会签控制
  PROCEDURE SPM_CON_HT_WF_CREATION_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CREATION_RYSZ;

  --合同新建紧急流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_URGENT_HTML;

  --合同建立流程启动回调
  PROCEDURE SPM_CON_HT_WF_URGENT_START(P_KEY        IN VARCHAR2,
                                       P_OTYPE_CODE IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
    PKVAL NUMBER;
  BEGIN
    --启动后，所有附件禁止删除
    --启动后，所有附件禁止删除
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

  --合同新建流程通知生成回调
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

  --合同新建流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_URGENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_URGENT_TZH;

  --合同紧急新建流程会签控制
  PROCEDURE SPM_CON_HT_WF_URGENT_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_URGENT_RYSZ;

  --合同盖章流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_EFFECTIVE_HTML;

  --合同盖章流程必填验证(通知回调)
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
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '请填写合同盖章信息');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_EFFECTIVE_VALID;

  --合同盖章流程通知生成回调
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

  --合同盖章流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 100);
  END SPM_CON_HT_WF_EFFECTIVE_TZH;

  --合同盖章流程会签控制
  PROCEDURE SPM_CON_HT_WF_EFFECTIVE_RYSZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_EFFECTIVE_RYSZ;

  --合同生效流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_EFFECT_HTML;

  --合同生效流程通知生成回调
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
      --V1.5生效时，回写主表生效时间
      UPDATE SPM_CON_HT_INFO T SET T.EFFECTIVE_DATE = SYSDATE WHERE T.CONTRACT_ID = VCONID;
      IF TO_NUMBER(VVERSION) > 1 THEN
        --变更的合同生效后交换新旧合同信息
        SPM_CON_HT_PKG.EXCHANGE_CONTRACT_CHANGE_INFO(VCONID);
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_EFFECT_TZSC;

  --合同生效流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_EFFECT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_EFFECT_TZH;

  --合同生效流程会签控制
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
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

  --合同增补盖章流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_SEAL_HTML;

  --合同增补盖章流程通知生成回调
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

  --合同增补盖章流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_SEAL_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_SEAL_TZH;

  --合同增补盖章流程会签控制
  PROCEDURE SPM_CON_HT_WF_SEAL_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_SEAL_RYSZ;

  --合同作废流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_VOID_HTML;

  --合同作废流程通知生成回调
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

  --合同作废流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_VOID_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_VOID_TZH;

  --合同作废流程会签控制
  PROCEDURE SPM_CON_HT_WF_VOID_RYSZ(ITEMKEY      IN VARCHAR2,
                                    OTYPECODE    IN VARCHAR2,
                                    PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_VOID_RYSZ;

  --订单合同作废流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_ORDER_VOID_HTML;

  --订单合同作废流程通知生成回调
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZSC(P_NOTIFID    IN VARCHAR2,
                                          P_ITEMKEY    IN VARCHAR2,
                                          P_OTYPE_CODE IN VARCHAR2) AS
    V_MSG     VARCHAR2(100);
    CONID     NUMBER; --当前订单ID
    CONIDR    NUMBER; --关联订单ID
    CONNAMER  VARCHAR2(200);
    COU       NUMBER;
    ORDERTYPE NUMBER; --当前订单订单类型1销售2采购
    ORDERCODE VARCHAR2(200); --当前订单编号
    OC        VARCHAR2(200); --关联订单编号
  BEGIN
    /**
    * 订单作废后
    * 如果关联订单已导入,作废
    * 如果关联订单未导入,删除
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
  
    --作废审批通过
    IF V_MSG = 'MES_OK' THEN
      --判断关联订单编号
      IF ORDERTYPE = 1 THEN
        OC := ORDERCODE || '-1';
      ELSIF ORDERTYPE = 2 THEN
        OC := SUBSTR(ORDERCODE, 1, LENGTH(ORDERCODE) - 2);
      END IF;
    
      SELECT CONTRACT_ID, CONTRACT_NAME
        INTO CONIDR, CONNAMER
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = OC;
      --删除或者作废 关联订单
      IF CONNAMER IS NOT NULL THEN
        UPDATE SPM_CON_HT_INFO SET STATUS = 'IZ' WHERE CONTRACT_CODE = OC;
      ELSE
        --删除订单
        DELETE SPM_CON_HT_INFO S WHERE S.CONTRACT_CODE = OC;
        --删除关联关系
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

  --订单合同作废流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_ORDER_VOID_TZH(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_ORDER_VOID_TZH;

  --合同变更流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CHANGE_HTML;

  --合同变更流程必填验证(通知回调)
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
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '收付款条款、合同差异表需要您签名');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
      /*
      * 新增 2018-11-12 欧榕
      * 变更驳回，必须选驳回原因
      */
    ELSIF P_OPER_RESULT = 'N' THEN
      L_NID  := WF_ENGINE.CONTEXT_NID;
      V_INFO := WF_NOTIFICATION.GETATTRTEXT(L_NID, 'ATT_AUDIT');
      COU    := SPM_CON_REBUT_REASON_WF_VALI(V_INFO);
      IF COU = 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '驳回原因不匹配');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  END SPM_CON_HT_WF_CHANGE_VALID;

  --合同变更流程通知生成回调
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

  --合同变更流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CHANGE_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CHANGE_TZH;

  --合同变更流程会签控制
  PROCEDURE SPM_CON_HT_WF_CHANGE_RYSZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CHANGE_RYSZ;

  --合同中止流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_SUSPEND_HTML;

  --合同中止流程通知生成回调
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

  --合同中止流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_SUSPEND_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_SUSPEND_TZH;

  --合同中止流程会签控制
  PROCEDURE SPM_CON_HT_WF_SUSPEND_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_SUSPEND_RYSZ;

  --合同恢复流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_RECOVERY_HTML;

  --合同恢复流程通知生成回调
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

  --合同恢复流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_RECOVERY_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_RECOVERY_TZH;

  --合同恢复流程会签控制
  PROCEDURE SPM_CON_HT_WF_RECOVERY_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_RECOVERY_RYSZ;

  --合同归档流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_ARCHIVED_HTML;

  --合同归档流程启动回调函数
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_START(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    CONID NUMBER;
  BEGIN
    SELECT JOB_ID
      INTO CONID
      FROM SPM_CON_WF_ACTIVITY
     WHERE ITEM_KEY = ITEMKEY;
  
    --设置归档时间
    UPDATE SPM_CON_HT_ARCHIVED S
       SET S.TRANSFER_BY   = FND_GLOBAL.USER_ID,
           S.TRANSFER_DATE = TRUNC(SYSDATE, 'MI')
     WHERE CONTRACT_ID = CONID
       AND S.IS_TRANSFER = 1;
  
    --设置归档编号
    UPDATE SPM_CON_HT_INFO S
       SET S.ARCHIVED_CODE = SPM_SERIAL_PKG.VALUE('SPM_CON_HT_ARCHIVED_CODE')
     WHERE S.CONTRACT_ID = CONID;
  
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END SPM_CON_HT_WF_ARCHIVED_START;

  --合同归档流程必填验证(通知回调)
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
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息', '您未接收任何归档资料');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END SPM_CON_HT_WF_ARCHIVED_VALID;

  --合同归档流程通知生成回调
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
  
    --审批通过时,修改归档信息
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

  --合同归档流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_ARCHIVED_TZH;

  --合同归档流程会签控制
  PROCEDURE SPM_CON_HT_WF_ARCHIVED_RYSZ(ITEMKEY      IN VARCHAR2,
                                        OTYPECODE    IN VARCHAR2,
                                        PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_ARCHIVED_RYSZ;

  --合同关闭流程HTML展现回调
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
      RETURN MSG;
  END SPM_CON_HT_WF_CLOSING_HTML;

  --合同关闭流程通知生成回调
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

  --合同关闭流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_CLOSING_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_HT_WF_CLOSING_TZH;

  --合同关闭流程会签控制
  PROCEDURE SPM_CON_HT_WF_CLOSING_RYSZ(ITEMKEY      IN VARCHAR2,
                                       OTYPECODE    IN VARCHAR2,
                                       PPOSITION_ID IN NUMBER) AS
  BEGIN
    SPM_CON_START_HQ(ITEMKEY, PPOSITION_ID);
  END SPM_CON_HT_WF_CLOSING_RYSZ;

  --数据权限的函数(项目)
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

  --数据权限的函数(部门)
  -- @param cid 部门ID
  -- 检查当前操作员的当前职责与输入的部门是否存在对应关系
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

  --判断当前itemkey下审批历史是否插入SPM审批历史表，避免重复插入的情况
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

  --供应商审核工作流HTML信息展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_VENDOR_VIEW_INFO;
  --供应商提交（注册，准入，战略）审核时，将供应商状态转变为：审核中“AP ”
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
  --供应商审核通过后，将供应商的状态更新为：已审核“E ”
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

  --供应商审核被驳回后，更新供应商状态为：驳回“D ”
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

  --供应商年度审核工作流HTML信息展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END;

  --供应商年审通过后，更新供应商的等级
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

  --供应商流程通知生成回调
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
  --供应商流程通知处理(后)回调
  PROCEDURE SPM_CON_VENDOR_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_VENDOR_INFO_TZH;

  --客户审核工作流HTML信息展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_CUST_VIEW_INFO;
  --客户提交（注册，准入，战略）审核时，将客户状态转变为：审核中“AP ”
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
  --客户审核通过后，将客户的状态更新为：已审核“E ”
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
      -- 回滚事务
      ROLLBACK;
  END;
  --客户审核被驳回后，更新客户状态为：驳回“D ”
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

  --客户流程通知生成回调
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

  --客户流程通知处理(后)回调
  PROCEDURE SPM_CON_CUST_INFO_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CUST_INFO_TZH;
  --供应商年度审核流程通知生成回调
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
  --供应商年度审核流程通知处理(后)回调
  PROCEDURE SPM_CON_VENDOR_YEAR_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_VENDOR_YEAR_TZH;

  --供应商年度审核流程通知生成回调
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
  --客户年度审核流程通知处理(后)回调
  PROCEDURE SPM_CON_CUST_YEAR_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CUST_YEAR_TZH;

  --客户年度审核工作流HTML信息展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END;

  --客户年审通过后，更新供应商的等级
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

  --定期生成供应商年度审核,状态为J,表示为job自动生成数据。
  PROCEDURE SPM_CON_PRODUCE_YEAR_REVIEW IS
    CREATE_DATE DATE;
    COUNTALL    NUMBER;
    --获取创建日期等于今天的客户游标
    CURSOR C_CUST IS
      SELECT C.CUST_ID, C.ORG_ID
        FROM SPM_CON_CUST_INFO C
       WHERE C.STATUS = 'E'
         AND TO_CHAR(C.SETUP_DATE, 'mmdd') = TO_CHAR(SYSDATE, 'mmdd');
    --获取创建日期（月日）等于今天的供应商游标
    CURSOR C_VENDOR IS
      SELECT I.VENDOR_ID, I.ORG_ID
        FROM SPM_CON_VENDOR_INFO I
       WHERE I.STATUS = 'E'
         AND TO_CHAR(I.SETUP_DATE, 'mmdd') = TO_CHAR(SYSDATE, 'mmdd');
  BEGIN
    FOR C_ROW IN C_CUST LOOP
      --countAll:判断客户今日是否有生成的年审记录
      --没有，则直接插入一条年审记录
      SELECT COUNT(*)
        INTO COUNTALL
        FROM (SELECT R.CREATION_DATE
                FROM SPM_CON_YEAR_REVIEW R
               WHERE R.ASSO_ID = C_ROW.CUST_ID
                 AND R.OWN_TYPE = '1'
                 AND TRUNC(R.CREATION_DATE) = TRUNC(SYSDATE))
       WHERE ROWNUM = 1;
      --countAll = 0 表示客户今天没有生成年审记录
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
      --countAll:判断供应商今日是否有生成的年审记录
      --没有，则直接插入一条年审记录
      SELECT COUNT(*)
        INTO COUNTALL
        FROM (SELECT R.CREATION_DATE
                FROM SPM_CON_YEAR_REVIEW R
               WHERE R.ASSO_ID = C_ROW.VENDOR_ID
                 AND R.OWN_TYPE = '2'
                 AND TRUNC(R.CREATION_DATE) = TRUNC(SYSDATE))
       WHERE ROWNUM = 1;
      --countAll = 0 表示供应商今天没有生成年审记录
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

  --工程审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --工程流程通知生成回调
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

  --工程流程通知处理(后)回调
  PROCEDURE SPM_CON_ENG_TZH(P_KEY         IN VARCHAR2,
                            P_OTYPE_CODE  IN VARCHAR2,
                            P_NOTIFID     IN VARCHAR2,
                            P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_ENG_TZH;

  --工程管理审批流程发起
  PROCEDURE SPM_CON_WF_ENG_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_ENG SET STATUS = 'C' WHERE ENG_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --工程驳回回调
  PROCEDURE SPM_CON_WF_ENG_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_ENG SET STATUS = 'D' WHERE ENG_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         '',
                                         'JOB_ID',
                                         'ENG_ID');
  
  END;
  --工程审批批准回调
  PROCEDURE SPM_CON_WF_ENG_PZ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         'STATUS',
                                         'JOB_ID',
                                         'ENG_ID');
  
  END;
  --工程审批通过回调
  PROCEDURE SPM_CON_WF_ENG_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_ENG SET STATUS = 'E' WHERE ENG_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_ENG',
                                         '',
                                         'JOB_ID',
                                         'ENG_ID');
  END;

  --项目审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --项目流程通知生成回调
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

  --项目流程通知处理(后)回调
  PROCEDURE SPM_CON_PROJECT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PROJECT_TZH;

  --项目管理审批流程发起
  PROCEDURE SPM_CON_WF_PROJECT_TJ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    /*UPDATE Spm_Con_project SET STATUS = 'C' WHERE project_id = v_Id;*/
    UPDATE SPM_CON_PROJECT
       SET STATUS   = GET_WF_STATUS_BY_POSITION(OTYPECODE, PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE PROJECT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --项目驳回回调
  PROCEDURE SPM_CON_WF_PROJECT_BH(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_PROJECT SET STATUS = 'D' WHERE PROJECT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         '',
                                         'JOB_ID',
                                         'PROJECT_ID');
  
  END;
  --项目审批批准回调
  PROCEDURE SPM_CON_WF_PROJECT_PZ(ITEMKEY      IN VARCHAR2,
                                  OTYPECODE    IN VARCHAR2,
                                  VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         'STATUS',
                                         'JOB_ID',
                                         'PROJECT_ID');
  END;
  --项目审批通过回调
  PROCEDURE SPM_CON_WF_PROJECT_TG(ITEMKEY   IN VARCHAR2,
                                  OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_PROJECT SET STATUS = 'E' WHERE PROJECT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_PROJECT',
                                         '',
                                         'JOB_ID',
                                         'PROJECT_ID');
  END;
  --发票退票管理html展现
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
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --发票退票管理流程审批通过后，将对应发票的状态更新为：已退回“R”
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
      -- 回滚事务
      ROLLBACK;
  END;

  --预付款发票管理html展现
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
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --查询预付款可用金额（剩余金额 - 锁定状态的预付款核销金额）
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

  --销项发票通过审核后，将该条数据核销的预收款回写到预收款剩余金额中
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
    
      --执行更新语句
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
      -- 回滚事务
      ROLLBACK;
  END;

  --投标保证金管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --投标保证金流程通知回调函数（通知生成后）
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

  --投标保证金流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_BID_DEPOSIT_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BID_DEPOSIT_TZCL_AFTER;

  --投标保证金提交流程时，
  /*  procedure spm_con_bid_deposit_wf_TJ(itemkey      in varchar2,
                                    otypecode    in varchar2,
                                    pPosition_id in number) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE DEPOSIT_ID = v_Id;
    --将投标保证金状态转变为：评审中“B”
    \*update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'B'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- 回滚事务
      ROLLBACK;
  end;*/

  --投标保证金审批流程批准回调函数
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

  --投标保证金管理流程审批通过回调
  /*procedure spm_con_bid_deposit_wf_TG(itemkey   in varchar2,
                                    otypecode in varchar2) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = 'E' WHERE DEPOSIT_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_DEPOSIT',
                                         '',
                                         'JOB_ID',
                                         'DEPOSIT_ID');
  
    --将对应的投标保证金状态更新为审批通过：审批通过“C”
    \*update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'C'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- 回滚事务
      ROLLBACK;
  end;*/

  --投标保证金审批流程驳回时
  /*procedure spm_con_bid_deposit_wf_BH(itemkey   in varchar2,
                                    otypecode in varchar2) is
    v_Id VARCHAR2(40);
  begin
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BID_DEPOSIT SET STATUS = 'D' WHERE DEPOSIT_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_DEPOSIT',
                                         '',
                                         'JOB_ID',
                                         'DEPOSIT_ID');
  
    --将投标保证金状态转变为：未通过“D”
   \* update SPM_CON_BID_DEPOSIT v
       set v.DEPOSIT_STATUS = 'D'
     where v.DEPOSIT_ID = v_Id;*\
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('Error Code = ' || TO_CHAR(SQLCODE));
      dbms_output.put_line('Error Message = ' || SQLERRM);
      -- 回滚事务
      ROLLBACK;
  end;*/

  --月度收付款计划管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --月度收付款计划管理流程发起
  /*procedure spm_con_month_plan_wf_TJ(itemkey      in varchar2,
                                     otypecode    in varchar2,
                                     pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程发起后,将业务表状态更改为C 第一个节点状态
    UPDATE SPM_CON_MONTH_PLAN SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE MONTH_PLAN_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/
  --月度收付款计划管理流程批准回调函数
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

  --月度收付款计划管理流程通知回调函数（通知生成后）
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

  --月度收付款计划管理流程通知回调函数（通知处理前）
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
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '' || V_STATUS_NAME || '意见不允许为空');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END;

  --月度收付款计划管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_MONTH_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_MONTH_PLAN_TZCL_AFTER;

  --月度收付款计划管理审批通过回调
  /*procedure spm_con_month_plan_wf_TG(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_MONTH_PLAN SET STATUS = 'E' WHERE MONTH_PLAN_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_MONTH_PLAN',
                                         '',
                                         'JOB_ID',
                                         'MONTH_PLAN_ID');
  END;*/
  --月度收付款计划管理驳回回调
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

  --月度计划汇总管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --月度计划汇总管理流程批准回调函数
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

  --月度计划汇总管理流程通知回调函数（通知生成后）
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

  --月度计划汇总管理流程通知回调函数（通知处理前）
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
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '' || V_STATUS_NAME || '意见不允许为空');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  END;

  --月度计划汇总管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_MONTHGATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --月度计划汇总管理驳回回调
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

  --周度收付款计划管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --周度收付款计划管理流程通知回调函数（通知生成后）
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

  --周度收付款计划管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_WEEK_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_WEEK_PLAN_TZCL_AFTER;

  --周度收付款计划管理流程发起
  /*procedure spm_con_week_plan_wf_TJ(itemkey      in varchar2,
                                     otypecode    in varchar2,
                                     pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程发起后,将业务表状态更改为C 第一个节点状态
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE WEEK_PLAN_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/
  --周度收付款计划管理流程批准回调函数
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
  --周度收付款计划管理审批通过回调
  /*procedure spm_con_week_plan_wf_TG(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = 'E' WHERE WEEK_PLAN_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_WEEK_PLAN',
                                         '',
                                         'JOB_ID',
                                         'WEEK_PLAN_ID');
  END;*/
  --周度收付款计划管理驳回回调
  /*procedure spm_con_week_plan_wf_BH(itemkey   IN VARCHAR2,
                                     otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_WEEK_PLAN SET STATUS = 'D' WHERE WEEK_PLAN_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_WEEK_PLAN',
                                         '',
                                         'JOB_ID',
                                         'WEEK_PLAN_ID');
  
  END;*/

  --周度计划汇总管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --周度计划汇总管理流程通知回调函数（通知生成后）
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

  --周度计划汇总管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_WEEK_GATHER_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --投标管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --投标管理流程发起
  /*procedure spm_con_bid_info_wf_TJ(itemkey      in varchar2,
                                   otypecode    in varchar2,
                                   pPosition_id in number) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程发起后,将业务表状态更改为对应节点
    UPDATE SPM_CON_BID_INFO SET STATUS = GET_WF_STATUS_BY_POSITION(otypecode,pPosition_id) ,
        ITEM_KEY = itemkey WHERE BID_ID = v_Id;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
  
  END;*/

  --投标管理流程会签回调函数
  PROCEDURE SPM_CON_BID_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
  
    SPM_CON_START_HQ(P_KEY, VPOSITOIN_ID);
  
  END SPM_CON_BID_INFO_WF_HQ;

  --投标管理流程通知回调函数（通知生成后）
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

  --投标管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_BID_INFO_WF_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BID_INFO_WF_TZCL_AFTER;

  --投标管理流程驳回验证回调函数（通知处理前）
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
             FND_MESSAGE.SET_NAME('CUX', '提示');
             FND_MESSAGE.SET_TOKEN('信息', '驳回原因不匹配');
             APP_EXCEPTION.RAISE_EXCEPTION;
          END IF;
  
  
      END IF;
  
  END ;  */

  --投标管理审批通过回调
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
  
    --如果是紧急流程已通过补充标准流程时跟改是否补充标准流程状态
  
    IF V_IS_URGENT_END = 'Y' THEN
      UPDATE SPM_CON_BID_INFO SET IS_ADD_PROCESS = 'Y' WHERE BID_ID = V_ID;
    END IF;
  
  END;

  --投标管理驳回回调
  /*  procedure spm_con_bid_info_wf_BH(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BID_INFO SET STATUS = 'D' WHERE BID_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  
  END;*/
  --投标管理紧急流程通知回调函数(通知生成后)
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

  --投标管理紧急流程通知回调函数（通知处理后）
  /*  PROCEDURE spm_con_bid_urgent_TZCL_AFTER(p_Key        In Varchar2,
                                  p_Otype_Code In VARCHAR2,
                                  p_notifid In VARCHAR2,
                                  p_oper_result In VARCHAR2) AS
  begin
      UPDATE_HISTORY_INFO(p_Key,p_Otype_Code,p_notifid,p_oper_result);
  END spm_con_bid_urgent_TZCL_AFTER; */

  --投标管理紧急审批通过回调
  PROCEDURE SPM_CON_BID_URGENT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_BID_INFO SET IS_URGENT_END = 'Y' WHERE BID_ID = V_ID;
  
  END;
  --投标管理紧急驳回回调
  /*procedure spm_con_bid_urgent_wf_BH(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BID_INFO SET STATUS = 'UD' WHERE BID_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  
  END;*/

  --投标管理中标确认流程发起
  PROCEDURE SPM_CON_BID_CONFIRM_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为对应节点
    UPDATE SPM_CON_BID_INFO SET BID_RESULT = '已中标' WHERE BID_ID = V_ID;
  
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --投标管理中标确认流程通知回调函数(通知生成后)
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

  --投标管理中标确认流程批准回调函数
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
  --投标管理中标确认通过回调
  /* procedure spm_con_bid_confirm_wf_TG(itemkey   IN VARCHAR2,
                                   otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_CON_BID_INFO SET STATUS = 'CE' WHERE BID_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_BID_INFO',
                                         '',
                                         'JOB_ID','BID_ID');
  END;*/
  --投标管理中标确认驳回回调
  PROCEDURE SPM_CON_BID_CONFIRM_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BID_INFO SET BID_RESULT = NULL WHERE BID_ID = V_ID;
  
  END;

  --收款单审批HTML展现
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
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --交货计划维护流程审批启动后，将对应标的物的状态更新为：goods_wf_status 为1
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
      -- 回滚事务
      ROLLBACK;
  END;

  --收付款计划维护管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --收付款计划维护管理流程发起
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --如果条款再次申请将上次审批状态设为null
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

  --收付款计划维护管理流程通知回调函数（通知生成后）
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

  --收付款计划维护管理流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_CLAUSE_PLAN_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CLAUSE_PLAN_TZCL_AFTER;

  --收付款计划维护管理流程批准回调函数
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
  --收付款计划维护管理审批通过回调
  PROCEDURE SPM_CON_CLAUSE_PLAN_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --审批通过将条款状态设为E
  
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

  --收付款计划维护管理驳回回调
  /*procedure spm_con_clause_plan_wf_BH(itemkey   IN VARCHAR2,
                                      otypecode In VARCHAR2) AS
    v_Id VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO v_Id
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = itemkey;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_CLAUSE_PLAN
       SET STATUS = 'D'
     WHERE CLAUSE_PLAN_ID = v_Id;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(itemkey,
                                         otypecode,
                                         'SPM_CON_CLAUSE_PLAN',
                                         '',
                                         'JOB_ID',
                                         'CLAUSE_PLAN_ID');
  
  END;*/

  --工作交接管理html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --工作交接流程通知回调函数（通知生成后）
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

  --工作交接流程通知回调函数（通知处理后）
  PROCEDURE SPM_CON_HANDOV_INFO_TZCL_AFTER(P_KEY         IN VARCHAR2,
                                           P_OTYPE_CODE  IN VARCHAR2,
                                           P_NOTIFID     IN VARCHAR2,
                                           P_OPER_RESULT IN VARCHAR2) AS
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END;

  --工作交接管理流程会签回调函数
  PROCEDURE SPM_CON_HANDOV_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
  
    SPM_CON_START_HQ(P_KEY, VPOSITOIN_ID);
  
  END;

  --付款审批流程
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
                                                P_KEY) || '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --选择审核人员回调方法
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
    --检查是否为第一环节*/
  
    --只针对第一个节点进行处理
    SELECT COUNT(*)
      INTO V_NUMBER
      FROM (SELECT COUNT(*), S.GROUP_ID
              FROM CCM_WF_USER_GROUP S
             WHERE S.ITEMKEY = P_KEY
             GROUP BY S.GROUP_ID);
  
    IF V_NUMBER = 1 THEN
      /**
      动态指定审批人员时 先删掉特定配置的审批人员
      可指定在流程某些审批节点下需要采用动态选人
      动态选审批人员时调用此代码
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
         WHERE 1 = 1 --t.position_id = vPositoin_id
           AND T.RECEIVER_ID = (SELECT S.JOB_ID
                                  FROM SPM_CON_WF_ACTIVITY S
                                 WHERE S.ITEM_KEY = P_KEY)
           AND T.OTYPE_CODE = POTYPE_CODE
           AND T.ITEM_KEY IS NULL;
    
    END IF;
    COMMIT;
  END;
  ---得到工作流的初始职位ID------
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
  
    ----得到审批职位ID
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

  --得到工作流的初始职位ID------第二个方法（通过启动工作流的前期获取positonId）
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
    V_EAMWF       VARCHAR2(40); /*与eam模块标识，2017年07月20日*/
    VWF_PROCESS   VARCHAR2(100) := 'PRO_AUDITE';
  BEGIN
    /*初始化连接
    declare
    
         l_resp_id number;
         l_resp_app_id number;
         l_user_id number;
        begin
            select t.application_id,t.responsibility_id into l_resp_app_id,l_resp_id from fnd_responsibility_vl t where t.RESPONSIBILITY_NAME='532002_PA_黄岛发电项目超级用户';
            select t.user_id into l_user_id from spm_eam_all_people_v t where t.USER_name='MTL_SETUP';
            fnd_global.APPS_INITIALIZE(l_user_id,l_resp_id,l_resp_app_id);
            DBMS_OUTPUT.put_line('respId,respAppId,userId,orgId:'||l_resp_id||','||l_resp_app_id||','||l_user_id||','||spm_sso_pkg.getOrgId);
        end;
    */
    /* fnd_global.apps_initialize(2188,51640,20003);*/
  
    P_ORG_ID := NVL(FND_PROFILE.VALUE('CCM:WF_ORG'), 5068);
    BEGIN
      --得到走工作流记录表，表主键字段名，主键字段，状态字段，回调ORACLE过程
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
    
      --判断在SPM的流程注册表中是否注册
      --得到流程主键
      /*
            Select 'CCM' || Ltrim(To_Char(Ccm_Wf_Itemkey_Seq.Nextval))
              Into Vitem_Key
              From Dual;
      */
      --把CCM_ID写到表中
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
      --执行回调，可以重新输出流程标题
      --If Trim(Cuspro) Is Not Null and v_eamwf = 'N' Then
      /*朱杰 2017年07月20日 增加条件，只处理财务共享流程,spm eam流程启动回调在spm_wf_p中 */
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
      --判断是否是自审批
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
        
          --取登录人部门ID（包括处室）
          SELECT T.ORGANIZATION_ID
            INTO P_DEPT_ID
            FROM SPM_CON_HT_PEOPLE_V T
           WHERE ROWNUM < 2
             AND T.BELONGORGID = SPM_SSO_PKG.GETORGID
             AND T.USER_ID = SPM_SSO_PKG.GETUSERID;
        
          IF P_DEPT_ID IS NOT NULL THEN
            BEGIN
              --取审批方案
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
          --取审批职位
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
      FND_MESSAGE.SET_NAME('CUX', '异常');
      FND_MESSAGE.SET_TOKEN('错误信息', '没有注册工作流');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR1 THEN
      FND_MESSAGE.SET_NAME('CUX', '异常');
      FND_MESSAGE.SET_TOKEN('错误信息', '无适合的工作流审批方案');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR2 THEN
      FND_MESSAGE.SET_NAME('CUX', '异常');
      FND_MESSAGE.SET_TOKEN('错误信息', '无适合的工作流审批职位');
      APP_EXCEPTION.RAISE_EXCEPTION;
    WHEN V_ERROR3 THEN
      FND_MESSAGE.SET_NAME('CUX', '异常');
      FND_MESSAGE.SET_TOKEN('错误信息', '回调自定义过程失败');
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

  --销售订单设置会签
  PROCEDURE SETISCOUNTERSIGNFORPROREPORT(P_KEY        IN VARCHAR2,
                                         POTYPE_CODE  IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2) IS
    V_P_POSITION_ID NUMBER;
    V_P_ID          NUMBER;
    V_STATUS        VARCHAR2(20);
  BEGIN
    --获取业务表主键ID,流程状态
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
      --开启会签
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 100);
    
      /**
      动态指定审批人员时 先删掉特定配置的审批人员
      可指定在流程某些审批节点下需要采用动态选人
      需要动态选审批人员时调用此代码
      **/
      -- delete ccm_wf_user_group cg
      --   where cg.itemkey = P_Key;
    
    ELSE
      --取消会签
      WF_ENGINE.SETITEMATTRTEXT('SPMWF', P_KEY, 'ATT_PERCENT', 0.1);
    
    END IF;
  END;

  --合同模板审批流程发起
  PROCEDURE SPM_CON_WF_TEMPLATE_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为当前节点状态
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS   = GET_WF_STATUS_BY_POSITION(OTYPECODE, PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE TEMPLATE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --合同模板审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --合同模板驳回回调
  PROCEDURE SPM_CON_WF_TEMPLATE_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS = 'D'
     WHERE TEMPLATE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         '',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  
  END;
  --合同模板审批批准回调
  PROCEDURE SPM_CON_WF_TEMPLATE_PZ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         'STATUS',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  END;
  --合同模板审批通过回调
  PROCEDURE SPM_CON_WF_TEMPLATE_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_CONTRACT_TEMPLATE
       SET STATUS = 'E'
     WHERE TEMPLATE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CONTRACT_TEMPLATE',
                                         '',
                                         'JOB_ID',
                                         'TEMPLATE_ID');
  END;

  --信用证审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;
  --信用证审批流程发起
  PROCEDURE CLS_CON_CREDIT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_CREDIT SET STATUS = 'C' WHERE CREDIT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --信用证驳回回调
  PROCEDURE CLS_CON_CREDIT_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_CREDIT SET STATUS = 'D' WHERE CREDIT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_ID');
  
  END;
  --信用证审批批准回调
  PROCEDURE CLS_CON_CREDIT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_ID');
  END;
  --信用证审批通过回调
  PROCEDURE CLS_CON_CREDIT_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_CREDIT SET STATUS = 'E' WHERE CREDIT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_ID');
  END;

  --信用证流程通知生成回调
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

  --信用证通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_TZH;

  --信用证付款审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --信用证付款审批流程发起
  PROCEDURE CLS_CREDIT_PAY_WF_TJ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'C' WHERE CREDIT_PAY_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --信用证付款驳回回调
  PROCEDURE CLS_CREDIT_PAY_WF_BH(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'D' WHERE CREDIT_PAY_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  
  END;
  --信用证付款付款审批批准回调
  PROCEDURE CLS_CREDIT_PAY_WF_PZ(ITEMKEY      IN VARCHAR2,
                                 OTYPECODE    IN VARCHAR2,
                                 VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  END;
  --信用证审批通过回调
  PROCEDURE CLS_CREDIT_PAY_WF_TG(ITEMKEY   IN VARCHAR2,
                                 OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_CREDIT_PAY SET STATUS = 'E' WHERE CREDIT_PAY_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_PAY',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_PAY_ID');
  END;

  --信用证付款流程通知生成回调
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

  --信用证付款通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_PAY_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_PAY_TZH;

  --补充收款单审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --补充收款单审批流程发起
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TJ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'C'
     WHERE CREDIT_RECEIPT_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --补充收款单证驳回回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_BH(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'D'
     WHERE CREDIT_RECEIPT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  
  END;
  --补充收款单审批批准回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_PZ(ITEMKEY      IN VARCHAR2,
                                     OTYPECODE    IN VARCHAR2,
                                     VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         'STATUS',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  END;
  --补充收款单审批通过回调
  PROCEDURE CLS_CREDIT_RECEIPT_WF_TG(ITEMKEY   IN VARCHAR2,
                                     OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_CREDIT_RECEIPT
       SET STATUS = 'E'
     WHERE CREDIT_RECEIPT_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_CREDIT_RECEIPT',
                                         '',
                                         'JOB_ID',
                                         'CREDIT_RECEIPT_ID');
  END;

  --补充收款单流程通知生成回调
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

  --补充收款单通知处理(后)回调
  PROCEDURE SPM_CON_CREDIT_RECEIPT_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_CREDIT_RECEIPT_TZH;

  --新建保函审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --新建保函审批流程发起
  PROCEDURE CLS_BACKLETTER_INFO_WF_TJ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'C'
     WHERE BACKLETTER_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --新建保函驳回回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_BH(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'D'
     WHERE BACKLETTER_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  
  END;
  --新建保函审批批准回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_PZ(ITEMKEY      IN VARCHAR2,
                                      OTYPECODE    IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         'STATUS',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  END;
  --新建保函审批通过回调
  PROCEDURE CLS_BACKLETTER_INFO_WF_TG(ITEMKEY   IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_BACKLETTER_INFO
       SET STATUS = 'E'
     WHERE BACKLETTER_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_INFO',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_ID');
  END;

  --保函新建流程通知生成回调
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

  --保函新建通知处理(后)回调
  PROCEDURE SPM_CON_BACKLETTER_INFO_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_BACKLETTER_INFO_TZH;

  --收到保函审批html展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --收到保函审批流程发起
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TJ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
    --流程发起后,将业务表状态更改为C 发起状态
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'C'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --收到保函驳回回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_BH(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'D'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  
  END;
  --收到保函审批批准回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_PZ(ITEMKEY      IN VARCHAR2,
                                         OTYPECODE    IN VARCHAR2,
                                         VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         'STATUS',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  END;
  --收到保函审批通过回调
  PROCEDURE CLS_BACKLETTER_RECEIVE_WF_TG(ITEMKEY   IN VARCHAR2,
                                         OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程同过后,将业务表状态更改为E
    UPDATE SPM_CON_BACKLETTER_RECEIVE
       SET STATUS = 'E'
     WHERE BACKLETTER_RECEIVE_ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_CON_BACKLETTER_RECEIVE',
                                         '',
                                         'JOB_ID',
                                         'BACKLETTER_RECEIVE_ID');
  END;

  --保函收到流程通知生成回调
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

  --保函收到流程通知处理(后)回调
  PROCEDURE SPM_CON_RECEIVE_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_RECEIVE_TZH;

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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConSalesReturn/edit/' ||
                                                   V_SALES_RETURN_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConWarehouse/edit/' ||
                                                   V_WAREHOUE_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConOdo/edit/' ||
                                                   V_ODO_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
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
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConGoodsPlan/edit/' ||
                                                   V_GOODS_PLAN_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
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

  --出库单流程通知处理(前)回调
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
      FND_MESSAGE.SET_NAME('CUX', '提示');
      FND_MESSAGE.SET_TOKEN('信息', '请首先同步出库单数据');
      APP_EXCEPTION.RAISE_EXCEPTION;
    END IF;
  END SPM_CON_ODO_TZCL;

  --出库单流程通知处理(后)回调
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
    COMMIT;
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
  
    V_DD NUMBER;
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
    /*   select f.odo_id into v_dd  from spm_con_sales_return f where f.item_key=p_Key;
    UPDATE SPM_CON_ODO SET OUTPUT_OR_RETURN='1' WHERE  ODO_ID=v_dd;
    commit;*/
  END SPM_CON_SALES_RETURN_TZH;

  --预付款发票流程通知生成回调
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

  --预付款发票流程通知处理(后)回调
  PROCEDURE SPM_CON_IMPREST_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                        P_OTYPE_CODE  IN VARCHAR2,
                                        P_NOTIFID     IN VARCHAR2,
                                        P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_IMPREST_INVOICE_TZH;

  --付款流程审批通过回调
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

  --付款流程审批驳回回调
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

  --付款流程通知生成回调
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

  --付款流程通知处理（前）回调
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
      -- 流程达到制证会计且付款方式、付款日期、付款银行为空则不允许批准
      IF V_STATUS = 'C' THEN
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
         WHERE W.JOB_ID = P.PAYMENT_ID
           AND W.ITEM_KEY = P_KEY
           AND (P.PAY_METHODS IS NULL OR P.PAY_DATE IS NULL OR
               P.PAY_BANK_ACCOUNT_ID IS NULL);
      
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '请完善付款申请单财务录入界面信息');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
        --如果付款来源非仅流程，则付款必须创建会计科目才允许批准
        IF V_EBS_STATUS <> 'US' AND V_P_SOURCE <> 'TR' THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '该付款尚未成功创建会计分录');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --驳回时如果付款单已经创建会计科目 则不允许被驳回
      IF V_EBS_STATUS = 'US' THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '该付款已成功创建会计分录，不能执行驳回操作');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_CON_PAYMENT_WF_TZCL_BEFORE;

  --付款流程通知处理(后)回调
  PROCEDURE SPM_CON_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                P_OTYPE_CODE  IN VARCHAR2,
                                P_NOTIFID     IN VARCHAR2,
                                P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PAYMENT_TZH;

  --销项发票流程流程通知生成回调
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZSC(P_NOTIFID    IN VARCHAR2,
                                        P_ITEMKEY    IN VARCHAR2,
                                        P_OTYPE_CODE IN VARCHAR2) AS
    V_STATUS_PASSED VARCHAR2(40);
    V_INVOICE_ID    NUMBER(15);
  BEGIN
    SELECT DECODE(O.INVOICE_TYPE, '主营业务暂估', 'N', 'E'),
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

  --销项发票流程通知处理(后)回调
  PROCEDURE SPM_CON_OUTPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_OUTPUT_INVOICE_TZH;

  --销项发票退票流程流程通知生成回调
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

  --销项发票退票流程通知处理(后)回调
  PROCEDURE SPM_CON_RETURN_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                       P_OTYPE_CODE  IN VARCHAR2,
                                       P_NOTIFID     IN VARCHAR2,
                                       P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_RETURN_INVOICE_TZH;
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
  
  END SPM_CON_HT_WF_TRANS_TZSC;

  --合同交接流程通知处理(后)回调
  PROCEDURE SPM_CON_HT_WF_TRANS_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT); --修改流程
  
  END SPM_CON_HT_WF_TRANS_TZH;
  --合同交接流程必填验证(通知回调)
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
    NUM1 NUMBER; --记录ebs侧是否存在
  
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

  --定向账户流程通知生成回调
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
  --供应商流程通知处理(后)回调
  PROCEDURE SPM_CON_OR_ACCOUNT_TZH(P_KEY         IN VARCHAR2,
                                   P_OTYPE_CODE  IN VARCHAR2,
                                   P_NOTIFID     IN VARCHAR2,
                                   P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_OR_ACCOUNT_TZH;

  --定向账户审核工作流HTML信息展现
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
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_OR_ACCOUNT_INFO;

  --销项发票审批通过回调
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
      --插入信息表
      SPM_CON_MQ_PKG.BID_FEE_SEND(V_ID           => V_ID,
                                  V_AUDIT_STATUS => '01',
                                  V_AUDIT_REASON => '');
    
      --生成中转数据
      SPM_CON_MQ_PKG.GENERATE_BIDFEE_DATA(V_INVOICE_ID => V_ID);
    END IF;
  END SPM_CON_OUTPUT_TG;

  /*销项发票审批驳回回调*/
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

  --资金管理办法付款申请HTML展现
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
  
    --查看当前流程代办信息处理人userid
    SELECT V.USER_ID
      INTO V_REC_ID
      FROM WF_NOTIFICATIONS WF, SPM_EAM_ALL_PEOPLE_V V
     WHERE WF.RECIPIENT_ROLE = V.USER_NAME
       AND WF.NOTIFICATION_ID =
           (SELECT MAX(N.NOTIFICATION_ID)
              FROM WF_NOTIFICATIONS N
             WHERE N.ITEM_KEY = P_KEY);
    /*AND WF.STATUS = 'OPEN'*/
  
    -- 根据是否是新付款判断跳转逻辑
    IF V_PLAN_FLAG = 'Y' THEN
      --状态是c选默认职责的时候默认选该条记录org_id 对应的职责
      --并且当前操作人就是代办信息处理人
      IF (V_STATUS = 'C' )AND V_REC_ID = SPM_SSO_PKG.GETUSERID THEN
      
        MSG := '<a href=''' ||
               SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                         'WF_URL=/spmConPlanPayment/edit/' ||
                                                         V_ACTIVITY_ID,
                                                         P_KEY) ||
               '''>查看详情</a><br>';
      ELSE
        --其余情况随便选
        MSG := '<a href=''' ||
               SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConPlanPayment/edit/' ||
                                                       V_ACTIVITY_ID,
                                                       P_KEY) ||
               '''>查看详情</a><br>';
      END IF;
    ELSE
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUNCTION_URL('SPM_R1_WFCALLBACK',
                                                  'WF_URL=/spmConPayment/edit/' ||
                                                  V_ACTIVITY_ID,
                                                  P_KEY) ||
             '''>查看详情</a><br>';
    END IF;
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := P_KEY || '-' || P_OTYPE_CODE || '出错啦！';
      RETURN MSG;
  END SPM_CON_PLAN_PAYMENT_WF_HTML;

  --资金管理办法付款流程启动回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_QD(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    V_POSITION_ID IN VARCHAR2) IS
  
    V_PAYMENT_ID         NUMBER(15);
    V_PLAN_FLAG          VARCHAR2(40);
    V_SYS_PAYABLE_AMOUNT NUMBER;
    P_CAPITAL_ID         NUMBER(15);
    P_OCCUPY_AMOUNT      NUMBER(15);--占用金额
  BEGIN
    --查询流程活动表 获得对应付款申请单ID
    SELECT W.JOB_ID, NVL(P.PLAN_FLAG, 'N')
      INTO V_PAYMENT_ID, V_PLAN_FLAG
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = P.PAYMENT_ID;
  
    --就流程，结束
    IF V_PLAN_FLAG = 'N' THEN
      RETURN;
    END IF;
    V_SYS_PAYABLE_AMOUNT := SPM_CON_INVOICE_PKG.GET_PAYABLE_UNPAYABLE_BY_ID(V_PAYMENT_ID,
                                                                            3);
    --查询当前提交阶段资金计划及占用金额
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
  
    --更新付款单核销金额
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
    /*    --调用刷新资金剩余额度过程20190416移至创建会计科目事件
    SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'A');*/
  
  END SPM_CON_PLAN_PAYMENT_QD;

  --资金管理办法付款流程驳回回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_BH(P_KEY        IN VARCHAR2,
                                    P_OTYPE_CODE IN VARCHAR2) IS
  
    V_PAYMENT_ID NUMBER(15);
    V_START_DATE DATE;
    V_DATE_DIFF  NUMBER;
    V_PLAN_FLAG  VARCHAR2(40);
  BEGIN
    --查询流程活动表 获得对应付款申请单ID
    SELECT W.JOB_ID, W.CREATION_DATE, NVL(P.PLAN_FLAG, 'N')
      INTO V_PAYMENT_ID, V_START_DATE, V_PLAN_FLAG
      FROM SPM_CON_WF_ACTIVITY W, SPM_CON_PAYMENT P
     WHERE W.ITEM_KEY = P_KEY
       AND W.JOB_ID = P.PAYMENT_ID;
  
    SPM_CON_PAYMENT_BH(ITEMKEY => P_KEY, OTYPECODE => P_OTYPE_CODE);
    -- 旧付款驳回
    IF V_PLAN_FLAG = 'N' THEN
      RETURN;
    END IF;
  
    --将两个持久化字段清空 add by ruankk 2018-07-20
    UPDATE SPM_CON_PAYMENT P
       SET P.THIS_MONTH_BALANCE = NULL, P.SYS_PAYABLE_AMOUNT = NULL
     WHERE P.PAYMENT_ID = V_PAYMENT_ID;
  
    -- 计算当前时间与起始时间的月份差值
    SELECT MONTHS_BETWEEN(TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM'), 'YYYY-MM'),
                          TO_DATE(TO_CHAR(V_START_DATE, 'YYYY-MM'),
                                  'YYYY-MM'))
      INTO V_DATE_DIFF
      FROM DUAL;
  
    IF V_DATE_DIFF = 0 THEN
      /*--调用刷新资金剩余额度过程20190417移至取消付款动作中
      SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'D');*/
      --更新付款单核销金额
      UPDATE SPM_CON_PAYMENT P
         SET P.CANCEL_AMOUNT = 0
       WHERE P.PAYMENT_ID = V_PAYMENT_ID;
    END IF;
  END SPM_CON_PLAN_PAYMENT_BH;

  --资金管理办法付款流程审批通过回调事件
  PROCEDURE SPM_CON_PLAN_PAYMENT_TG(ITEMKEY   IN VARCHAR2,
                                    OTYPECODE IN VARCHAR2) IS
    P_PAYMENT_ID NUMBER(15);
    V_PLAN_FLAG  VARCHAR2(40);
  
  BEGIN
  
    --1.根据ITEMKEY找到对应付款单
  
    SELECT P.PAYMENT_ID, NVL(P.PLAN_FLAG, 'N')
      INTO P_PAYMENT_ID, V_PLAN_FLAG
      FROM SPM_CON_PAYMENT P, SPM_CON_WF_ACTIVITY W
     WHERE P.PAYMENT_ID = W.JOB_ID
       AND W.ITEM_KEY = ITEMKEY;
  
    IF V_PLAN_FLAG = 'Y' THEN
      --2.调用生成付款指令过程
      SPM_CON_INVOICE_PKG.CREATE_INSTRUCT_BY_PAYMENT_NEW(V_PAYMENT_ID => P_PAYMENT_ID);
    END IF;
    SPM_CON_PAYMENT_TG(ITEMKEY => ITEMKEY, OTYPECODE => OTYPECODE);
  END SPM_CON_PLAN_PAYMENT_TG;

  --资金管理办法付款流程通知生成回调
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

  --资金管理办法付款流程通知处理（前）回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_WF_TZCL(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2) AS
    L_NID          NUMBER;
    V_INFO         VARCHAR2(1000);
    V_STATUS       VARCHAR2(40);
    V_P_SOURCE     VARCHAR2(40);
    IS_EXISTS      NUMBER;
    V_PAYMENT_ID   NUMBER(15); --付款单主键
    V_MONEY_AMOUNT NUMBER; --付款申请单主表金额
    V_CHILD_AMOUNT NUMBER; --付款申请子表金额
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
      -- 流程达到制证会计
      IF V_STATUS = 'C' THEN
        --1.校验付款单金额是否为零
        IF V_MONEY_AMOUNT = NULL OR V_MONEY_AMOUNT = 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '付款申请单总金额不允许为零');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --2.校验付款子表金额与付款申请单金额是否一致
        SELECT SUM(P.MONEY_AMOUNT)
          INTO V_CHILD_AMOUNT
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;
        IF V_MONEY_AMOUNT <> V_CHILD_AMOUNT THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息',
                                '财务录入行信息支付总金额与付款单申请总金额必须一致');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --4.校验付款单子表是否已经全部同步成功
        SELECT COUNT(1)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;
      
        IF IS_EXISTS = 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '该付款申请单尚未录入财务信息');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --5.校验付款单子表是否已经全部同步成功
        SELECT COUNT(1)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT_CHILD P
         WHERE P.STATUS <> 'US'
           AND P.PAYMENT_ID = V_PAYMENT_ID;
      
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '该付款申请单尚未完全同步到EBS');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
        --更新核销资金额度
/*      
        UPDATE SPM_CON_PAYMENT P
           SET P.CANCEL_AMOUNT = P.MONEY_AMOUNT, P.CANCEL_DATE = SYSDATE
         WHERE P.PAYMENT_ID = V_PAYMENT_ID;*/
        /*  
         --调用刷新资金剩余额度过程 取消更新金额20190417
        SPM_CON_INVOICE_PKG.REFRESH_CAPITAL_QUOTA(V_PAYMENT_ID, 'C');*/
      ELSIF V_STATUS = 'H' THEN
        --校验需要上会的是否已经上会
        SELECT COUNT(*)
          INTO IS_EXISTS
          FROM SPM_CON_PAYMENT P
         WHERE ((P.IS_MEETING = 'Y' AND P.HAS_MEETING = 'N') OR
               (P.IS_MEETING = 'N' AND P.HAS_MEETING = 'Y'))
           AND P.PAYMENT_ID = V_PAYMENT_ID;
        IF IS_EXISTS <> 0 THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '请完善付款申请上会流程状态信息');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --驳回时如果付款单已经创建会计科目 则不允许被驳回
      SELECT COUNT(*)
        INTO IS_EXISTS
        FROM SPM_CON_PAYMENT_CHILD P
       WHERE P.STATUS = 'US'
         AND P.PAYMENT_ID = V_PAYMENT_ID;
      IF IS_EXISTS <> 0 THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '该付款已成功创建会计分录，不能执行驳回操作');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
  END SPM_CON_PLAN_PAYMENT_WF_TZCL;

  --资金管理办法付款流程通知处理(后)回调
  PROCEDURE SPM_CON_PLAN_PAYMENT_TZH(P_KEY         IN VARCHAR2,
                                     P_OTYPE_CODE  IN VARCHAR2,
                                     P_NOTIFID     IN VARCHAR2,
                                     P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_PLAN_PAYMENT_TZH;

  /**
      通用流程HTML展现（审批记录表格）
      by mcq
      20180810
  */
  FUNCTION SPM_WF_RECORD_HTML(P_KEY IN VARCHAR2, P_OTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2 AS
    L_DOCUMENT  VARCHAR2(10000);
    VWFPLANNAME VARCHAR2(200);
    V_WF_CODE   VARCHAR2(200); --流程编码
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
    --获取审批方案名称
    BEGIN
      VWFPLANNAME := WF_ENGINE.GETITEMATTRTEXT(P_OTYPE_CODE,
                                               P_KEY,
                                               'ATT_WF_PLAN_NAME');
    EXCEPTION
      WHEN OTHERS THEN
        VWFPLANNAME := '';
    END;
  
    L_DOCUMENT := '<table class="wf-table"> ' || '<tr>' ||
                  '<td class="wf-label">审批方案</td>' ||
                  '<td class="wf-label" colspan =7 align="center">' ||
                  VWFPLANNAME || '</td>' || '<tr>' ||
                  '<td class="wf-label" width="10%">审批环节</td>' ||
                  '<td class="wf-label" width="10%">审批人员</td>' ||
                  '<td class="wf-label" width="10%">审批结果</td>' ||
                  '<td class="wf-label" colspan =2 width="40%">审批意见</td>' ||
                  '<td class="wf-label" width="10%">收到时间</td>' ||
                  '<td class="wf-label" width="10%">处理时间</td>' ||
                  '<td class="wf-label" width="10%">效率</td>' || '</tr>';
  
    --GET ID
    SELECT W.WF_CODE
      INTO V_WF_CODE
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
    --针对付款业务，增加一个的业务代码
  
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
      通用流程HTML展现（业务个性化区域）
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
      L_DOCUMENT := '出错啦！';
      RETURN L_DOCUMENT;
  END SPM_WF_TEMPLATE_HTML;
  /**
      通用流程HTML展现（审批记录表格）
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
      MSG := '出错啦！';
      RETURN MSG;
  END SPM_CON_PLAN_PAYMENT_HTML;

  /**
      通用流程HTML展现（子表表格）
      by mcq
      20180810
  */
  FUNCTION SPM_CON_WF_GRID_HTML(P_KEY        IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 AS
    L_DOCUMENT VARCHAR2(10000);
    V_ID       NUMBER(15); --业务数据ID
  
    CURSOR CUR(P_ID NUMBER) IS
      SELECT * FROM SPM_CON_PAYMENT_INVOICE_V WHERE JOB_ID = P_ID;
    REC CUR%ROWTYPE;
  BEGIN
    --获取业务数据ID
    SELECT A.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY A
     WHERE A.ITEM_KEY = P_KEY;
  
    L_DOCUMENT := '<tr> <td colspan =8 align="center"> 关联发票信息''</td> </tr>' ||
                  '<tr>' || '<td class="wf-label">发票号码</td>' ||
                  '<td class="wf-label">摘要</td>' ||
                  '<td class="wf-label" colspan =2>合同名称</td>' ||
                  '<td class="wf-label" colspan =2>项目名称</td>' ||
                  '<td class="wf-label">发票金额</td>' ||
                  '<td class="wf-label">剩余金额</td>' || '</tr>';
  
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

  --退票流程启动回调
  PROCEDURE SPM_CON_RETURN_INVOICE_QD(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      V_POSITION_ID IN VARCHAR2) IS
  
    P_INVOICE_ID NUMBER(15);
  BEGIN
    --查询流程活动表 获取对应退票ID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CM_VERIFIC_OUTPUT_INVOICE(P_INVOICE_ID, 'TJ');
  
  END SPM_CON_RETURN_INVOICE_QD;

  --退票流程驳回回调
  PROCEDURE SPM_CON_RETURN_INVOICE_BH(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2) IS
  
    P_INVOICE_ID NUMBER(15);
  
  BEGIN
    --查询流程活动表 获取对应退票ID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CM_VERIFIC_OUTPUT_INVOICE(P_INVOICE_ID, 'BH');
  END SPM_CON_RETURN_INVOICE_BH;

  --退票流程审批通过回调事件
  PROCEDURE SPM_CON_RETURN_INVOICE_TG(P_KEY     IN VARCHAR2,
                                      OTYPECODE IN VARCHAR2) IS
    P_INVOICE_ID NUMBER(15);
  BEGIN
  
    --查询流程活动表 获取对应退票ID
    SELECT W.JOB_ID
      INTO P_INVOICE_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_KEY;
  
    SPM_CON_INVOICE_PKG.CREATE_SERIAL_CODE_FOR_CM(P_INVOICE_ID);
  END SPM_CON_RETURN_INVOICE_TG;

  --进项发票审核工作流HTML信息展现
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
      --无合同
    
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConInputInvoiceNoContract/edit/' || V_ID,
                                                       P_KEY) ||
             '''>查看详情</a><br>';
    ELSE
      --有合同
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                       'WF_URL=/spmConInputInvoice/edit/' || V_ID,
                                                       P_KEY) ||
             '''>查看详情</a><br>';
    END IF;
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_INPUT_INVOICE_HTML;

  --进项发票流程通知生成回调
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

  --进项发票流程通知处理(后)回调
  PROCEDURE SPM_CON_INPUT_INVOICE_TZH(P_KEY         IN VARCHAR2,
                                      P_OTYPE_CODE  IN VARCHAR2,
                                      P_NOTIFID     IN VARCHAR2,
                                      P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    UPDATE_HISTORY_INFO(P_KEY, P_OTYPE_CODE, P_NOTIFID, P_OPER_RESULT);
  END SPM_CON_INPUT_INVOICE_TZH;

  --进项发票流程通知处理（前）回调
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
      
        --如果付款来源非仅流程，则付款必须创建会计科目才允许批准
        IF V_EBS_STATUS = 'N' OR V_EBS_STATUS = 'E' THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息', '该进项发票尚未执行同步财务操作');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      --驳回时如果付款单已经创建会计科目 则不允许被驳回
      IF V_EBS_STATUS <> 'N' AND V_EBS_STATUS <> 'E' THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '该进项发票已执行同步财务操作，不能执行驳回操作');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_CON_INPUT_INVOICE_TZCL;
END SPM_CON_CONTRACT_PKG;
/
