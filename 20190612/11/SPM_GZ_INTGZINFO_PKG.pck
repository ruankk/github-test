CREATE OR REPLACE PACKAGE SPM_GZ_INTGZINFO_PKG IS
  --SPM_GZ_INTGZINFO_PKG为包名

  --验证工资项信息录入有效性  工资编辑页面导入 由陈炼修改
  PROCEDURE WAGE_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);

    --验证工资项信息录入  工资编辑页面导入 由陈炼修改
  PROCEDURE WAGE_INFO_IMPORT(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);

  --验证工资项信息录入有效性  工资编辑页面导入
  PROCEDURE WAGE_INFO_VALIDATA_OLD(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               P_MSG       OUT VARCHAR2);

    --验证工资项信息录入  工资编辑页面导入 
  PROCEDURE WAGE_INFO_IMPORT_OLD(P_TABLENAME VARCHAR2,
                             P_TABLEID   VARCHAR2,
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2,
                             F_TABLEID   VARCHAR2,
                             P_MSG       OUT VARCHAR2);
                             
  --验证工资组织信息录入有效性 组织信息页面
  PROCEDURE GZORG_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);

  --验证工资组织信息录入  组织信息页面
  PROCEDURE GZORG_INFO_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);

  --验证工资员工录入有效性   员工信息页面
  PROCEDURE PERSON_SALARY_VALIDATA(P_TABLENAME VARCHAR2,
                                   P_TABLEID   VARCHAR2,
                                   P_BATCHCODE VARCHAR2,
                                   P_MSG       OUT VARCHAR2);
  -- 导入工资员工信息    员工信息页面
  PROCEDURE PERSON_SALARY_IMPORT(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 F_TABLENAME VARCHAR2,
                                 F_TABLEID   VARCHAR2,
                                 P_MSG       OUT VARCHAR2);

  --验证工资项目录入有效性   工资项目信息页面
  PROCEDURE WAGETYPEITEMS_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                        P_TABLEID   VARCHAR2,
                                        P_BATCHCODE VARCHAR2,
                                        P_MSG       OUT VARCHAR2);
  -- 导入工资项目信息     工资项目页面
  PROCEDURE WAGETYPEITEMS_INFO_IMPORT(P_TABLENAME VARCHAR2,
                                      P_TABLEID   VARCHAR2,
                                      P_BATCHCODE VARCHAR2,
                                      F_TABLENAME VARCHAR2,
                                      F_TABLEID   VARCHAR2,
                                      P_MSG       OUT VARCHAR2);

  FUNCTION GET_WAGETYPE_OBJECT_NAME( /*operationType In NUMBER,*/RELATIONIDS IN VARCHAR2)
    RETURN VARCHAR2;

  /**
  * 根据spm_gz_createcert表里存储的wagetype_code 信息和to_wageitems 查询到中文工资项目名称
  * @param operationType 1
  * @param ids to_wageitems 工资项目英文信息
  */
  FUNCTION GET_WAGEITEMS_NAME(RELATIONIDS  IN VARCHAR2,
                              WAGETYPECODE IN VARCHAR2) RETURN VARCHAR2;
  --字符串转成多行函数
  FUNCTION SPLIT_STRING_OBJECT(SPLIT_OBJECT   VARCHAR2,
                               SPLIT_OPERATOR VARCHAR2 DEFAULT ',')
    RETURN SPM_TYPE_TBL;

  --根据spm_gz_employee表里attribute5存储的处室id信息 查询到处室中文名称
  FUNCTION GET_EMP_OFFICE_NAME( /*operationType In NUMBER,*/OFFICEID IN VARCHAR2)
    RETURN VARCHAR2;
  --工资审批流程相关回调函数

  --工资管理html展现
  FUNCTION SPM_GZ_SP_INFO_HTML(P_KEY IN VARCHAR2, POTYPE_CODE IN VARCHAR2)
    RETURN VARCHAR2;
  --工资管理流程发起
  PROCEDURE SPM_GZ_SP_INFO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER);
  --工资管理流程批准回调函数
  PROCEDURE SPM_GZ_SP_INFO_PZ(P_KEY        IN VARCHAR2,
                              P_OTYPE_CODE IN VARCHAR2,
                              VPOSITOIN_ID IN VARCHAR2);

  --合同作废流程通知生成回调
  PROCEDURE SPM_GZ_SP_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                P_ITEMKEY    IN VARCHAR2,
                                P_OTYPE_CODE IN VARCHAR2);

  --合同作废通知处理(后)回调
  PROCEDURE SPM_GZ_SP_INFO_TZH(P_KEY         IN VARCHAR2,
                               P_OTYPE_CODE  IN VARCHAR2,
                               P_NOTIFID     IN VARCHAR2,
                               P_OPER_RESULT IN VARCHAR2);

  --工资管理流程会签节点批准回调函数（通知处理后）
  PROCEDURE SPM_GZ_SP_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);
  --工资管理流程驳回验证回调函数（通知处理前）
  /*PROCEDURE spm_gz_sp_info_TZ_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --工资管理审批通过回调
  PROCEDURE SPM_GZ_SP_INFO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);

  --工资管理驳回回调
  PROCEDURE SPM_GZ_SP_INFO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2);
  --验证年度预控信息录入
  PROCEDURE PRECONTROL_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);
  --导入年度预控数据                              
  PROCEDURE PRECONTROL_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);
  --验证领导班子预控信息录入
  PROCEDURE LEADER_VALIDATA(P_TABLENAME VARCHAR2,
                            P_TABLEID   VARCHAR2,
                            P_BATCHCODE VARCHAR2,
                            P_MSG       OUT VARCHAR2);
  --导入领导班子预控数据                              
  PROCEDURE LEADER_IMPORT(P_TABLENAME VARCHAR2,
                          P_TABLEID   VARCHAR2,
                          P_BATCHCODE VARCHAR2,
                          F_TABLENAME VARCHAR2,
                          F_TABLEID   VARCHAR2,
                          P_MSG       OUT VARCHAR2);

  --验证专家信息录入有效性   专家咨询费发放明细页面
  PROCEDURE EXPERT_FEE_VALIDATA(P_TABLENAME VARCHAR2,
                                P_TABLEID   VARCHAR2,
                                P_BATCHCODE VARCHAR2,
                                P_MSG       OUT VARCHAR2);
  -- 导入专家信息    专家咨询费发放明细页面
  PROCEDURE EXPERT_FEE_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2,
                              F_TABLEID   VARCHAR2,
                              P_MSG       OUT VARCHAR2);

  --咨费管理html展现
  FUNCTION SPM_EXPERT_FEE_INFO_HTML(P_KEY       IN VARCHAR2,
                                    POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;
  --咨费管理流程发起
  PROCEDURE SPM_EXPERT_FEE_INFO_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER);
  --咨费管理流程批准回调函数
  PROCEDURE SPM_EXPERT_FEE_INFO_PZ(P_KEY        IN VARCHAR2,
                                   P_OTYPE_CODE IN VARCHAR2,
                                   VPOSITOIN_ID IN VARCHAR2);

  --咨费管理流程通知生成回调
  PROCEDURE SPM_EXPERT_FEE_INFO_TZSC(P_NOTIFID    IN VARCHAR2,
                                     P_ITEMKEY    IN VARCHAR2,
                                     P_OTYPE_CODE IN VARCHAR2);
  --咨费管理流程通知处理（前）回调
  PROCEDURE SPM_EXPERT_FEE_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2);
  --咨费管理通知处理(后)回调
  PROCEDURE SPM_EXPERT_FEE_INFO_TZH(P_KEY         IN VARCHAR2,
                                    P_OTYPE_CODE  IN VARCHAR2,
                                    P_NOTIFID     IN VARCHAR2,
                                    P_OPER_RESULT IN VARCHAR2);

  --咨费管理流程会签节点批准回调函数（通知处理后）
  PROCEDURE SPM_EXPERT_FEE_INFO_TZ_AFTER(P_KEY         IN VARCHAR2,
                                         P_OTYPE_CODE  IN VARCHAR2,
                                         P_NOTIFID     IN VARCHAR2,
                                         P_OPER_RESULT IN VARCHAR2);
  --咨费管理流程驳回验证回调函数（通知处理前）
  /*PROCEDURE spm_gz_sp_info_TZ_BEFORE(p_Key        In Varchar2,
  p_Otype_Code In VARCHAR2,
  p_notifid In VARCHAR2,
  p_oper_result In VARCHAR2);*/
  --咨费管理审批通过回调
  PROCEDURE SPM_EXPERT_FEE_INFO_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --咨费管理驳回回调
  PROCEDURE SPM_EXPERT_FEE_INFO_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2);

  --验证专家信息录入有效性   专家信息列表页面
  PROCEDURE EXPERT_INFO_VALIDATA(P_TABLENAME VARCHAR2,
                                 P_TABLEID   VARCHAR2,
                                 P_BATCHCODE VARCHAR2,
                                 P_MSG       OUT VARCHAR2);
  -- 导入专家信息    专家信息列表页面
  PROCEDURE EXPERT_INFO_IMPORT(P_TABLENAME VARCHAR2,
                               P_TABLEID   VARCHAR2,
                               P_BATCHCODE VARCHAR2,
                               F_TABLENAME VARCHAR2,
                               F_TABLEID   VARCHAR2,
                               P_MSG       OUT VARCHAR2);
  --专家咨询费明细保存数据插入申请付款金额                                
  PROCEDURE SPM_EXPERT_FEE_MONEY_AMOUNT(ID NUMBER);
  --资金计划额度 自动取值
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

--工资项信息验证validate-2018-08-24由陈炼修改
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF /*VALIDATE_A <> '部门' OR VALIDATE_B <> '处' OR*/
         VALIDATE_C <> '员工编号' /*OR VALIDATE_D <> '姓名' */OR VALIDATE_E NOT IN  ('基本工资','年奖','工资') OR
         VALIDATE_F NOT IN  ('工龄工资','应发工资','奖金') OR VALIDATE_G NOT IN  ('薪点工资','防暑降温/过节费','纳税工资') 
         OR VALIDATE_H NOT IN  ('奖金','税率','交通补贴') OR VALIDATE_I NOT IN ('医疗基金','其他1','所得税') 
         OR VALIDATE_J NOT IN ('房租补贴','实发工资','其他2') OR VALIDATE_K NOT IN ('独子','其他3') OR
         VALIDATE_L NOT IN ('托补','其他4') OR VALIDATE_M NOT IN ('交通补贴','应发工资') OR VALIDATE_N <> '过节' OR
         VALIDATE_O NOT IN ('法定节假日值班','扣基本养老') OR VALIDATE_P NOT IN ('防暑降温','扣失业') OR
          VALIDATE_Q NOT IN ('产假','扣医疗保险') OR VALIDATE_R NOT IN ('考勤','扣住房公积金') OR 
          VALIDATE_S NOT IN ('其他1','纳税工资') OR VALIDATE_T NOT IN ('其他2','税率') OR
         VALIDATE_U NOT IN ('其他3','所得税') OR VALIDATE_V NOT IN ('其他4','实发工资') OR VALIDATE_W <> '应发工资' OR
         VALIDATE_X <> '扣基本养老' OR VALIDATE_Y <> '扣医疗保险' OR VALIDATE_Z <> '扣大额医疗' OR
         VALIDATE_AA <> '扣失业' OR VALIDATE_AB <> '扣住房公积金' OR VALIDATE_AC <> '扣年金' OR
         VALIDATE_AD <> '扣其他' OR VALIDATE_AE <> '纳税工资' OR VALIDATE_AF <> '速算扣除数' OR
         VALIDATE_AG <> '个税率' OR VALIDATE_AH <> '个人所得税' OR VALIDATE_AI <> '实发工资'  THEN
        P_MSG := '导入数据的列名不符合格式。';
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
             --员工编号不为空 查询员是否存在
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
        MSG_C := MSG_C || '行 员工编号不能为空或员工在SPM系统中不存在;  ';
      END IF;
      P_MSG := P_MSG  || MSG_C;
    
      RETURN;
    END IF;
  END WAGE_INFO_VALIDATA;
  --工资项信息验证validate
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '员工编号' OR VALIDATE_B <> '员工姓名' OR
         VALIDATE_C = '应发工资' OR VALIDATE_C = '纳税工资' OR VALIDATE_C = '所得税' OR
         VALIDATE_C = '实发工资' OR VALIDATE_D = '应发工资' OR VALIDATE_D = '纳税工资' OR
         VALIDATE_D = '所得税' OR VALIDATE_D = '实发工资' OR VALIDATE_E = '应发工资' OR
         VALIDATE_E = '纳税工资' OR VALIDATE_E = '所得税' OR VALIDATE_E = '实发工资' OR
         VALIDATE_F = '应发工资' OR VALIDATE_F = '纳税工资' OR VALIDATE_F = '所得税' OR
         VALIDATE_F = '实发工资' OR VALIDATE_G = '应发工资' OR VALIDATE_G = '纳税工资' OR
         VALIDATE_G = '所得税' OR VALIDATE_G = '实发工资' OR VALIDATE_H = '应发工资' OR
         VALIDATE_H = '纳税工资' OR VALIDATE_H = '所得税' OR VALIDATE_H = '实发工资' OR
         VALIDATE_I = '应发工资' OR VALIDATE_I = '纳税工资' OR VALIDATE_I = '所得税' OR
         VALIDATE_I = '实发工资' OR VALIDATE_J = '应发工资' OR VALIDATE_J = '纳税工资' OR
         VALIDATE_J = '所得税' OR VALIDATE_J = '实发工资' OR VALIDATE_K = '应发工资' OR
         VALIDATE_K = '纳税工资' OR VALIDATE_K = '所得税' OR VALIDATE_K = '实发工资' OR
         VALIDATE_L = '应发工资' OR VALIDATE_L = '纳税工资' OR VALIDATE_L = '所得税' OR
         VALIDATE_L = '实发工资' OR VALIDATE_M = '应发工资' OR VALIDATE_M = '纳税工资' OR
         VALIDATE_M = '所得税' OR VALIDATE_M = '实发工资' OR VALIDATE_N = '应发工资' OR
         VALIDATE_N = '纳税工资' OR VALIDATE_N = '所得税' OR VALIDATE_N = '实发工资' OR
         VALIDATE_O = '应发工资' OR VALIDATE_O = '纳税工资' OR VALIDATE_O = '所得税' OR
         VALIDATE_O = '实发工资' OR VALIDATE_P = '应发工资' OR VALIDATE_P = '纳税工资' OR
         VALIDATE_P = '所得税' OR VALIDATE_P = '实发工资' OR VALIDATE_Q = '应发工资' OR
         VALIDATE_Q = '纳税工资' OR VALIDATE_Q = '所得税' OR VALIDATE_Q = '实发工资' OR
         VALIDATE_R = '应发工资' OR VALIDATE_R = '纳税工资' OR VALIDATE_R = '所得税' OR
         VALIDATE_R = '实发工资' OR VALIDATE_S = '应发工资' OR VALIDATE_S = '纳税工资' OR
         VALIDATE_S = '所得税' OR VALIDATE_S = '实发工资' OR VALIDATE_T = '应发工资' OR
         VALIDATE_T = '纳税工资' OR VALIDATE_T = '所得税' OR VALIDATE_T = '实发工资' OR
         VALIDATE_U = '应发工资' OR VALIDATE_U = '纳税工资' OR VALIDATE_U = '所得税' OR
         VALIDATE_U = '实发工资' OR VALIDATE_V = '应发工资' OR VALIDATE_V = '纳税工资' OR
         VALIDATE_V = '所得税' OR VALIDATE_V = '实发工资' OR VALIDATE_W = '应发工资' OR
         VALIDATE_W = '纳税工资' OR VALIDATE_W = '所得税' OR VALIDATE_W = '实发工资' OR
         VALIDATE_X = '应发工资' OR VALIDATE_X = '纳税工资' OR VALIDATE_X = '所得税' OR
         VALIDATE_X = '实发工资' OR VALIDATE_Y = '应发工资' OR VALIDATE_Y = '纳税工资' OR
         VALIDATE_Y = '所得税' OR VALIDATE_Y = '实发工资' OR VALIDATE_Z = '应发工资' OR
         VALIDATE_Z = '纳税工资' OR VALIDATE_Z = '所得税' OR VALIDATE_Z = '实发工资' OR
         VALIDATE_AA = '应发工资' OR VALIDATE_AA = '纳税工资' OR
         VALIDATE_AA = '所得税' OR VALIDATE_AA = '实发工资' OR
         VALIDATE_AB = '应发工资' OR VALIDATE_AB = '纳税工资' OR
         VALIDATE_AB = '所得税' OR VALIDATE_AB = '实发工资' THEN
        P_MSG := '导入数据的列名不符合格式或存在计算项';
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
        MSG_B := MSG_B || '行 员工姓名不能为空;  ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M;
    
      RETURN;
    END IF;
  END;
 --工资数据导入 2018-08-24由陈炼修改
  PROCEDURE WAGE_INFO_IMPORT(P_TABLENAME VARCHAR2, --
                             P_TABLEID   VARCHAR2, ---
                             P_BATCHCODE VARCHAR2,
                             F_TABLENAME VARCHAR2, ---子表main_id
                             -- f_wagecode  varchar2,--工资发放方案编码
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
    CN_A    VARCHAR2(2000); --中文工资项
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
    V_EN     VARCHAR2(200);--英文工资项
    V_CN     VARCHAR2(200);--中文工资项
    V_I     VARCHAR(3);--列头标识
    V_VAL   NUMBER(20,2);--工资项目值
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
    V_SQL   VARCHAR(200);  --拼接更新语句sql
    
    V_EXEC_SQL   VARCHAR(10000); --执行跟新sql;
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
    --循环从 E~Z
    FOR I IN  101..122 LOOP
      V_I:=UPPER(CHR(I));
      --不知道怎么搞动态变量
      --中文项目名称
      SELECT '''' || DECODE(V_I,'E',CN_E,'F',CN_F,'G',CN_G,'H',CN_H,'I',CN_I,'J',CN_J,'K',CN_K,'L',CN_L,'M',CN_M,'N',CN_N,'O',CN_O,'P',
      CN_P,'Q',CN_Q,'R',CN_R,'S',CN_S,'T',CN_T,'U',CN_U,'V',CN_V,'W',CN_W,'X',CN_X,'Y',CN_Y,'Z',CN_Z) ||'''' INTO V_CN FROM DUAL;
      --单元格值
       SELECT DECODE(V_I,'E',VALIDATE_E,'F',VALIDATE_F,'G',VALIDATE_G,'H',VALIDATE_H,'I',VALIDATE_I,'J',VALIDATE_J,'K',VALIDATE_K,'L',VALIDATE_L,'M',VALIDATE_M,'N',VALIDATE_N,'O',VALIDATE_O,'P',
       VALIDATE_P,'Q',VALIDATE_Q,'R',VALIDATE_R,'S',VALIDATE_S,'T',VALIDATE_T,'U',VALIDATE_U,'V',VALIDATE_V,'W',VALIDATE_W,'X',VALIDATE_X,'Y',VALIDATE_Y,'Z',VALIDATE_Z) INTO V_VAL FROM DUAL;
       
      
      V_SQL:='SELECT  WT.WAGEITEM_ENAME  FROM SPM_GZ_WAGETYPEITEMS WT WHERE WT.WAGETYPE_CODE=''' || WAGETYPECODE || ''' AND WT.WAGEITEM_CNAME=' || V_CN;
     
      EXECUTE IMMEDIATE V_SQL INTO V_EN;
      V_EXEC_SQL:=V_EXEC_SQL || V_EN ||'='|| '' || NVL(V_VAL,0) ||',';
    END LOOP;
    DBMS_OUTPUT.put_line('V_EXEC_SQL:'||V_EXEC_SQL);
    --循环从 A~I
    FOR I IN  97..105 LOOP
      V_I:='A'||UPPER(CHR(I));
      --中文项目名称
       SELECT '''' || DECODE(V_I,'AA',CN_AA,'AB',CN_AB,'AC',CN_AC,'AD',CN_AD,'AE',CN_AE,'AF',CN_AF,'AG',CN_AG,'AH',CN_AH,'AI',CN_AI) || '''' INTO V_CN FROM DUAL;
      
        --单元格值
     SELECT DECODE(V_I,'AA',VALIDATE_AA,'AB',VALIDATE_AB,'AC',VALIDATE_AC,'AD',VALIDATE_AD,'AE',VALIDATE_AE,'AF',VALIDATE_AF,'AG',VALIDATE_AG,'AH',VALIDATE_AH,'AI',VALIDATE_AI) INTO V_VAL FROM DUAL;
      
      V_SQL:='SELECT  WT.WAGEITEM_ENAME  FROM SPM_GZ_WAGETYPEITEMS WT WHERE WT.WAGETYPE_CODE=''' || WAGETYPECODE || ''' AND WT.WAGEITEM_CNAME=' || V_CN;
      EXECUTE IMMEDIATE V_SQL INTO V_EN;
      V_EXEC_SQL:=V_EXEC_SQL || V_EN ||'='|| '' || NVL(V_VAL,0) ||',';
    END LOOP;
   
    --去掉最后一个‘,号’ 
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
    -- P_MSG:='导入工资数据成功。';
   EXCEPTION WHEN OTHERS THEN
     P_MSG:='导入工资数据出错，原因：'||SQLERRM;
   END;
  END;
  --工资数据导入
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
    EXCELCOL03    VARCHAR2(2000); --中文工资项
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
    COL03WAGEITEM VARCHAR2(200); --英文工资项
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
  
    --根据main_id 查询工资发放类编码
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
      --重写,判断工资发放类中的项目只查询一遍,而不是所有的循环都去查询
    
      --1.如果标志为空进行查询
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

  --验证工资组织信息录入
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
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_B <> '组织编码' OR VALIDATE_C <> '组织名称' OR
         VALIDATE_D <> '组织简称' OR VALIDATE_E <> '组织类别' THEN
        P_MSG := '导入数据的字段名不符合格式';
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
      MSG_A := MSG_A || '行 序号不能为空;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '行 组织编码不能为空;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '行 组织名称不能为空;  ';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '行 组织类别不能为空;  ';
    END IF;
    IF MSG_M IS NOT NULL THEN
      MSG_M := MSG_M || '行 该条记录已经存在，不能再次导入;  ';
    END IF;
    IF MSG_N IS NOT NULL THEN
      MSG_N := MSG_N || '行,组织编码长度不正确,请检查核对！';
    END IF;
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --验证工资组织信息录入
  PROCEDURE GZORG_INFO_IMPORT(P_TABLENAME VARCHAR2,
                              P_TABLEID   VARCHAR2,
                              P_BATCHCODE VARCHAR2,
                              F_TABLENAME VARCHAR2, --职责respId
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
      --主键
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
      IF VALIDATE_E = '公司' THEN
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
      P_MSG := '导入的部门或处室存在无上级单位的情况，请检查组织编码是否有误！';
      ROLLBACK;
      RETURN;
    END IF;
    IF EMPTYPARENTIDNUM = 0 THEN
      COMMIT;
    END IF;
  END;

  --工资人员导入信息验证validate
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '公司编码' OR VALIDATE_B <> '公司名称' OR
         VALIDATE_C <> '部门编码' OR VALIDATE_D <> '部门名称' OR
         VALIDATE_E <> '处室编码' OR VALIDATE_F <> '处室名称' OR
         VALIDATE_G <> '员工编号' OR VALIDATE_H <> '员工姓名' OR
         VALIDATE_I <> '员工类别' OR VALIDATE_J <> '用工形式' OR
         VALIDATE_K <> '身份证' OR VALIDATE_L <> '开户行名称' OR
         VALIDATE_M <> '银行账号' OR VALIDATE_N <> '离开本企业时间' OR
         VALIDATE_O <> '性别' OR VALIDATE_P <> '职务' OR
         VALIDATE_Q <> '是否为公司领导' THEN
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
        --判断人员是否已经存在  
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
        MSG_A := MSG_A || '行 公司编码不能为空;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 公司名称不能为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 部门编码不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 部门名称不能为空;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 员工姓名不能为空;  ';
      END IF;
      IF MSG_I IS NOT NULL THEN
        MSG_I := MSG_I || '行 员工类别不能为空;  ';
      END IF;
      IF MSG_Q IS NOT NULL THEN
        MSG_Q := MSG_Q || '行 是否为公司领导不能为空;  ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 公司编码有误或该公司不存在;  ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 日期格式输入有误;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 部门编码有误或该部门不存在;  ';
      END IF;
      IF MSG_O IS NOT NULL THEN
        MSG_O := MSG_O || '行 处室编码有误或该处室不存在;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 该员工已经存在，不能重复提交; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H || MSG_I || MSG_J || MSG_K || MSG_L || MSG_M ||
               MSG_N || MSG_O || MSG_P || MSG_Q;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --工资人员信息导入
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
        IF VALIDATE_Q = '是' THEN
          ISLEADER := 'leader';
        END IF;
        IF VALIDATE_Q <> '是' THEN
          ISLEADER := 'no';
        END IF;
      END IF;
      IF LENGTH(VALIDATE_E) > 1 THEN
        ---到处室级
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
           VALIDATE_P, --职务
           ATT3, --att3 人员类别编码
           ISLEADER, --是否为领导
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
           VALIDATE_P, --职务
           ATT3, --att3 人员类别编码
           ISLEADER, --是否为领导
           VALIDATE_E, --att5 处室为空
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

  --工资项目录入有效性 验证validate
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '工资发放类别编码' OR VALIDATE_B <> '工资发放类别名称' OR
         VALIDATE_C <> '工资项目序号' OR VALIDATE_D <> '工资项目英文名' OR
         VALIDATE_E <> '工资项目中文名' OR VALIDATE_F <> '工资项目属性' OR
         VALIDATE_G <> '继承上次发放值' OR VALIDATE_H <> '所属公司全称' THEN
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
        IF VALIDATE_D = 'GZYF_08' AND VALIDATE_E <> '独子' THEN
          IF MSG_D1 IS NULL THEN
            MSG_D1 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D1 := MSG_D1 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_09' AND VALIDATE_E <> '托补' THEN
          IF MSG_D2 IS NULL THEN
            MSG_D2 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D2 := MSG_D2 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_19' AND VALIDATE_E <> '取暖费' AND
           VALIDATE_E <> '采暖补贴' THEN
          IF MSG_D3 IS NULL THEN
            MSG_D3 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D3 := MSG_D3 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZYF_28' AND VALIDATE_E <> '年奖' THEN
          IF MSG_D4 IS NULL THEN
            MSG_D4 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D4 := MSG_D4 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZKJ_07' AND VALIDATE_E <> '扣病假' THEN
          IF MSG_D5 IS NULL THEN
            MSG_D5 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D5 := MSG_D5 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_D = 'GZKJ_08' AND VALIDATE_E <> '扣事假' THEN
          IF MSG_D6 IS NULL THEN
            MSG_D6 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_D6 := MSG_D6 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '独子' AND VALIDATE_D <> 'GZYF_08' THEN
          IF MSG_E1 IS NULL THEN
            MSG_E1 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E1 := MSG_E1 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '托补' AND VALIDATE_D <> 'GZYF_09' THEN
          IF MSG_E2 IS NULL THEN
            MSG_E2 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E2 := MSG_E2 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '取暖费' AND VALIDATE_D <> 'GZYF_19' THEN
          IF MSG_E3 IS NULL THEN
            MSG_E3 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E3 := MSG_E3 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '采暖补贴' AND VALIDATE_D <> 'GZYF_19' THEN
          IF MSG_E4 IS NULL THEN
            MSG_E4 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E4 := MSG_E4 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '年奖' AND VALIDATE_D <> 'GZYF_28' THEN
          IF MSG_E5 IS NULL THEN
            MSG_E5 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E5 := MSG_E5 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '扣病假' AND VALIDATE_D <> 'GZKJ_07' THEN
          IF MSG_E6 IS NULL THEN
            MSG_E6 := CU_DATA%ROWCOUNT;
          ELSE
            MSG_E6 := MSG_E6 || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        IF VALIDATE_E = '扣事假' AND VALIDATE_D <> 'GZKJ_08' THEN
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
        MSG_A := MSG_A || '行 工资发放类别编码不能为空;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 工资发放类别名称不能为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 工资项目序号不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 工资项目英文名不能为空;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 工资项目中文名不能为空;  ';
      END IF;
      IF MSG_D1 IS NOT NULL THEN
        MSG_D1 := MSG_D1 || '行 项目英文名为GZYF_08时，项目中文名必须为独子;  ';
      END IF;
      IF MSG_D2 IS NOT NULL THEN
        MSG_D2 := MSG_D2 || '行 项目英文名为GZYF_09时，项目中文名必须为托补;  ';
      END IF;
      IF MSG_D3 IS NOT NULL THEN
        MSG_D3 := MSG_D3 || '行 项目英文名为GZYF_19时，项目中文名必须为取暖费或采暖补贴;  ';
      END IF;
      IF MSG_D4 IS NOT NULL THEN
        MSG_D4 := MSG_D4 || '行 项目英文名为GZYF_28时，项目中文名必须为年奖;  ';
      END IF;
      IF MSG_D5 IS NOT NULL THEN
        MSG_D5 := MSG_D5 || '行 项目英文名为GZKJ_07时，项目中文名必须为扣病假;  ';
      END IF;
      IF MSG_D6 IS NOT NULL THEN
        MSG_D6 := MSG_D6 || '行 项目英文名为GZKJ_08时，项目中文名必须为扣事假;  ';
      END IF;
      IF MSG_E1 IS NOT NULL THEN
        MSG_E1 := MSG_E1 || '行 项目中文名为独子时，项目英文名必须为GZYF_08;  ';
      END IF;
      IF MSG_E2 IS NOT NULL THEN
        MSG_E2 := MSG_E2 || '行 项目中文名为托补时，项目英文名必须为GZYF_09;  ';
      END IF;
      IF MSG_E3 IS NOT NULL THEN
        MSG_E3 := MSG_E3 || '行 项目中文名为取暖费或采暖补贴时，项目英文名必须为GZYF_19;  ';
      END IF;
      IF MSG_E4 IS NOT NULL THEN
        MSG_E4 := MSG_E4 || '行 项目中文名为取暖费或采暖补贴时，项目英文名必须为GZYF_19;  ';
      END IF;
      IF MSG_E5 IS NOT NULL THEN
        MSG_E5 := MSG_E5 || '行 项目中文名为年奖时，项目英文名必须为GZYF_28;  ';
      END IF;
      IF MSG_E6 IS NOT NULL THEN
        MSG_E6 := MSG_E6 || '行 项目中文名为扣病假时，项目英文名必须为GZKJ_07;  ';
      END IF;
      IF MSG_E7 IS NOT NULL THEN
        MSG_E7 := MSG_E7 || '行 项目中文名为扣事假时，项目英文名必须为GZKJ_08;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 工资项目属性不能为空;  ';
      END IF;
      IF MSG_G IS NOT NULL THEN
        MSG_G := MSG_G || '行 继承上次发放值不能为空;  ';
      END IF;
      IF MSG_M IS NOT NULL THEN
        MSG_M := MSG_M || '行 该工资项目已经存在,不能重复提交;  ';
      END IF;
      IF MSG_N IS NOT NULL THEN
        MSG_N := MSG_N || '行 所属公司不存在或公司全称有误;  ';
      END IF;
      /* if msg_e is not null then
        msg_e := msg_e || '行 部门编码有误或该部门不存在;  ';
      end if;
       if msg_o is not null then
        msg_o := msg_o || '行 处室编码有误或该处室不存在;  ';
      end if;
      if msg_f is not null then
        msg_f:= msg_f ||'行 该员工已经存在，不能重复提交; ';
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
  --工资项目信息导入
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
  * 根据spm_gz_wagetype表里存储的wagetype_object部门code信息 查询到中文部门名称
  * @param operationType 1
  * @param ids wagetype_object部门code信息
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
      --根据解析后的部门code查询部门name
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
  * 根据spm_gz_createcert表里存储的wagetype_code 信息和to_wageitems 查询到中文工资项目名称
  * @param operationType 1
  * @param ids to_wageitems 工资项目英文信息
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
      --根据解析后的工资项目items查询工资项目name
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
  ---object部门信息字符串转成多行函数(截去'',)
  FUNCTION SPLIT_STRING_OBJECT(SPLIT_OBJECT   VARCHAR2,
                               SPLIT_OPERATOR VARCHAR2 DEFAULT ',')
    RETURN SPM_TYPE_TBL IS
    -- Author  : SpringLee
    -- Created : 2014/08/07 16:05:44
    -- Purpose : 字符串分割
  
    -- Params
    -- SPLIT_OBJECT   : 要处理的字符串
    -- SPLIT_OPERATOR ：字符串分割符
  
    V_OUT        SPM_TYPE_TBL;
    V_TMP        VARCHAR2(4000);
    V_TMP_OBJECT VARCHAR2(4000);
    V_ELEMENT    VARCHAR2(4000);
  BEGIN
    V_TMP := SPLIT_OBJECT;
    V_OUT := SPM_TYPE_TBL();
  
    --如果存在匹配的分割符
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
  * 根据spm_gz_employee表里attribute5存储的处室id信息 查询到处室中文名称
  * @param ids attribute5存储的处室id信息
  */
  FUNCTION GET_EMP_OFFICE_NAME( --operationType In NUMBER,
                               OFFICEID IN VARCHAR2) RETURN VARCHAR2 IS
    OFFICENAME VARCHAR2(400);
  BEGIN
    --根据处室id查询名称name
    SELECT O.ORG_NAME
      INTO OFFICENAME
      FROM SPM_GZ_ORGANIZATION O
     WHERE O.ORGANIZATION_ID = OFFICEID;
    RETURN OFFICENAME;
  END GET_EMP_OFFICE_NAME;

  -- 工资管理相关函数
  --工资管理html展现
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
                                               P_KEY) || '''>查看详情</a><br>';
   RETURN MSG;
 EXCEPTION
   WHEN OTHERS THEN
     MSG := '出错啦！';
     RETURN MSG;
 END;

  --工资管理流程发起
  PROCEDURE SPM_GZ_SP_INFO_TJ(ITEMKEY      IN VARCHAR2,
                              OTYPECODE    IN VARCHAR2,
                              PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN

    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;

    --流程发起后,将业务表状态更改为对应节点
    UPDATE SPM_GZ_WAGEDATA_MAIN
       SET STATUS   = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                     PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --工资管理流程批准回调函数
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
  
    --获取业务表主键ID,流程状态
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
    --开启会签
    -- wf_engine.SetItemAttrText('SPMWF',
    /* P_Key,
    'ATT_PERCENT',
    100);*/
  
    /**
    动态指定审批人员时 先删掉特定配置的审批人员
    可指定在流程某些审批节点下需要采用动态选人
    需要动态选审批人员时调用此代码
    **/
    -- delete ccm_wf_user_group cg
    --   where cg.itemkey = P_Key;
  
    --else
    --取消会签
    /*wf_engine.SetItemAttrText('SPMWF',
                             P_Key,
                             'ATT_PERCENT',
                             0.1);
    
    end if;      */
  
  END SPM_GZ_SP_INFO_PZ;

  --工资管理流程通知生成回调
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

  --工资管理流程通知处理(后)回调
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

  --工资管理流程会签节点批准回调函数（通知处理后）
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

  --工资管理流程驳回验证回调函数（通知处理前）
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
             FND_MESSAGE.SET_NAME('CUX', '提示');
             FND_MESSAGE.SET_TOKEN('信息', '驳回原因不匹配');
             APP_EXCEPTION.RAISE_EXCEPTION;
          END IF;
  
  
      END IF;
  
  END ;   */

  --工资管理审批通过回调
  PROCEDURE SPM_GZ_SP_INFO_TG(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'E' WHERE ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  END;

  --工资管理驳回回调
  PROCEDURE SPM_GZ_SP_INFO_BH(ITEMKEY IN VARCHAR2, OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'D' WHERE ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  
  END;

  --验证年度预控信息录入
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
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_A <> '组织名称' OR VALIDATE_B <> '年份' OR VALIDATE_C <> '总人数' OR
         VALIDATE_D <> '班子人数' OR VALIDATE_E <> '职工人数' OR
         VALIDATE_F <> '年度预算' THEN
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
             VALIDATE_F;
    
      WHILE CU_DATA%FOUND LOOP
        --校验必填项？
        IF VALIDATE_A IS NULL THEN
          IF MSG_A IS NULL THEN
            MSG_A := CU_DATA%ROWCOUNT;
          ELSE
            MSG_A := MSG_A || ',' || CU_DATA%ROWCOUNT;
          END IF;
        END IF;
        --验证是否存在该组织
      
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
        
          --如果存在该组织，校验是否已经存在该年度的预算
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
      MSG_A := MSG_A || '行 组织名称不能为空;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '行 年份不能为空;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '行 组织名称错误;  ';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '行 年度预算不能为空;  ';
    END IF;
    IF MSG_G IS NOT NULL THEN
      MSG_G := MSG_G || '行 已经存在该组织该年份的年度预控;  ';
    END IF;
  
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --导入年度预控数据
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
      --主键
      SELECT SPM_GZ_PRECONTROL_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_A IS NOT NULL THEN
        SELECT O.ATTRIBUTE2 --新的短码
          INTO ORGS
          FROM SPM_GZ_ORGANIZATION O
         WHERE O.ATTRIBUTE3 = '1' --标记是一个组织
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
  --验证领导班子预控信息录入
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
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
    
      IF VALIDATE_A <> '组织名称' OR VALIDATE_B <> '年份' OR VALIDATE_C <> '公司领导' OR
         VALIDATE_D <> '年度预算' THEN
        P_MSG := '导入数据的字段名不符合格式';
        CLOSE CU_DATA;
        RETURN;
      END IF;
      FETCH CU_DATA
        INTO VALIDATE_A, VALIDATE_B, VALIDATE_C, VALIDATE_D;
    
      WHILE CU_DATA%FOUND LOOP
        --校验必填项？
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
          --判断该领导是否存在
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
          --判断是否已经存在该领导的预算
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
      MSG_A := MSG_A || '行 组织名称不能为空;  ';
    END IF;
    IF MSG_B IS NOT NULL THEN
      MSG_B := MSG_B || '行 年份不能为空;  ';
    END IF;
    IF MSG_C IS NOT NULL THEN
      MSG_C := MSG_C || '行 公司领导不能为空;  ';
    END IF;
    IF MSG_D IS NOT NULL THEN
      MSG_D := MSG_D || '行 年度预算不能为空;  ';
    END IF;
    IF MSG_E IS NOT NULL THEN
      MSG_E := MSG_E || '行 不存在该领导请确认;  ';
    END IF;
    IF MSG_F IS NOT NULL THEN
      MSG_F := MSG_F || '行 该年份该领导的工资预控已经存在;  ';
    END IF;
  
    P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
             MSG_G || MSG_H || MSG_I || MSG_J || MSG_L || MSG_M || MSG_N ||
             MSG_O || MSG_P || MSG_Q || MSG_S;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  END;

  --导入领导班子预控数据
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
      --主键
      SELECT SPM_GZ_LEADER_SEQ.NEXTVAL INTO V_INFO_ID FROM DUAL;
      IF VALIDATE_A IS NOT NULL THEN
        --获取组织code
        SELECT O.ATTRIBUTE2 --新的短码
          INTO ORGS
          FROM SPM_GZ_ORGANIZATION O
         WHERE O.ATTRIBUTE3 = '1' --标记是一个组织
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

  --专家信息导入信息验证validate   专家咨询费发放明细页面
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '姓名' OR VALIDATE_B <> '身份证号' OR VALIDATE_C <> '实发金额' THEN
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
            ---专家姓名 身份证号不存在
            IF MSG_D IS NULL THEN
              MSG_D := CU_DATA%ROWCOUNT;
            ELSE
              MSG_D := MSG_D || ',' || CU_DATA%ROWCOUNT;
            END IF;
          ELSE
            --专家姓名 身份证号存在
            SELECT VI.VENDOR_ID
              INTO V_EXP_ID
              FROM SPM_CON_VENDOR_INFO VI
             WHERE VI.VENDOR_NAME = VALIDATE_A
               AND VI.VENDOR_CODE = VALIDATE_B
               AND VI.IS_BIDDING_VENDOR = 'Y';
            SELECT COUNT(BI.BANK_ACOUNT), --判断专家银行信息是否完善
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
        MSG_A := MSG_A || '行 姓名不能为空;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 身份证号不能为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 实发金额不能为空;  ';
      END IF;
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 该专家在专家信息库里不存在，请先维护进专家库; ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 金额格式不正确;  ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 该专家的银行信息不完善，请先补充完善; ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --专家信息导入     专家咨询费发放明细页面
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
      SELECT TO_CHAR(SYSDATE, 'yyyy') INTO FFYEAR FROM DUAL; --年
      SELECT TO_CHAR(SYSDATE, 'MM') INTO FFMONTH FROM DUAL; --月份（04）
      USERORGID := SPM_SSO_PKG.GETORGID;
      ---插入专家id exp_id到明细表
      INSERT INTO SPM_EXPERT_FEE_DETAIL
        (FEE_DETAIL_ID, --咨询费发放明细表主键
         FEE_MAIN_ID,
         EXP_ID, --专家id
         FACT_AMOUNT, --实发金额  
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

  -- 咨费管理管理相关函数
  --咨费管理html展现
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
  
    --查看当前流程代办信息处理人userid
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
             '''>查看详情</a><br>';
    ELSE
      MSG := '<a href=''' ||
             SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT('SPM_R1_WFCALLBACK',
                                                     'WF_URL=/spmExpertFee/edit/' ||
                                                     V_BID_ID,
                                                     P_KEY) ||
             '''>查看详情</a><br>';
    END IF;
  
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
  END;

  --咨费管理流程发起
  PROCEDURE SPM_EXPERT_FEE_INFO_TJ(ITEMKEY      IN VARCHAR2,
                                   OTYPECODE    IN VARCHAR2,
                                   PPOSITION_ID IN NUMBER) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程发起后,将业务表状态更改为对应节点
    UPDATE SPM_EXPERT_FEE
       SET STATUS   = SPM_CON_CONTRACT_PKG.GET_WF_STATUS_BY_POSITION(OTYPECODE,
                                                                     PPOSITION_ID),
           ITEM_KEY = ITEMKEY
     WHERE FEE_MAIN_ID = V_ID;
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  --咨费管理流程批准回调函数
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
  
    --获取业务表主键ID,流程状态
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
    --开启会签
    -- wf_engine.SetItemAttrText('SPMWF',
    /* P_Key,
    'ATT_PERCENT',
    100);*/
  
    /**
    动态指定审批人员时 先删掉特定配置的审批人员
    可指定在流程某些审批节点下需要采用动态选人
    需要动态选审批人员时调用此代码
    **/
    -- delete ccm_wf_user_group cg
    --   where cg.itemkey = P_Key;
  
    --else
    --取消会签
    /*wf_engine.SetItemAttrText('SPMWF',
                             P_Key,
                             'ATT_PERCENT',
                             0.1);
    
    end if;      */
  
  END SPM_EXPERT_FEE_INFO_PZ;

  --咨费管理流程通知生成回调
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

  --咨费管理流程通知处理（前）回调
  PROCEDURE SPM_EXPERT_FEE_WF_TZCL_BEFORE(P_KEY         IN VARCHAR2,
                                          P_OTYPE_CODE  IN VARCHAR2,
                                          P_NOTIFID     IN VARCHAR2,
                                          P_OPER_RESULT IN VARCHAR2) AS
    L_NID        NUMBER;
    V_BID_ID     NUMBER; --主键
    V_INFO       VARCHAR2(1000);
    V_STATUS     VARCHAR2(40);
    V_EBS_STATUS VARCHAR2(40);
    V_ACC_ID     VARCHAR2(40);
    PAYAMOUNT    NUMBER;
  BEGIN
    /*    l_nid  := WF_ENGINE.context_nid;
    v_info := wf_notification.GetAttrText(l_nid, 'ATT_AUDIT');*/
  
    --通过p_key查主键
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
      --批准时                 
      -- 流程达到制证会计且尚未进行计算操作，则不允许批准
      IF V_STATUS = 'C' THEN
        IF PAYAMOUNT = 0 OR V_ACC_ID IS NULL OR V_EBS_STATUS <> 'S' THEN
          FND_MESSAGE.SET_NAME('CUX', '提示');
          FND_MESSAGE.SET_TOKEN('信息',
                                '该报销单尚未进行计算、财务录入、生成凭证等操作');
          APP_EXCEPTION.RAISE_EXCEPTION;
        END IF;
      END IF;
    END IF;
    IF P_OPER_RESULT = 'N' THEN
      IF V_EBS_STATUS = 'S' THEN
        FND_MESSAGE.SET_NAME('CUX', '提示');
        FND_MESSAGE.SET_TOKEN('信息',
                              '该报销单已成功执行生成凭证操作，不能驳回');
        APP_EXCEPTION.RAISE_EXCEPTION;
      END IF;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      APP_EXCEPTION.RAISE_EXCEPTION;
    
  END SPM_EXPERT_FEE_WF_TZCL_BEFORE;

  --咨费管理流程通知处理(后)回调
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

  --咨费管理流程会签节点批准回调函数（通知处理后）
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

  --咨费管理审批通过回调
  PROCEDURE SPM_EXPERT_FEE_INFO_TG(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程通过后,将业务表状态更改为E
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'E' WHERE ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  END;

  --咨费管理驳回回调
  PROCEDURE SPM_EXPERT_FEE_INFO_BH(ITEMKEY   IN VARCHAR2,
                                   OTYPECODE IN VARCHAR2) AS
    V_ID VARCHAR2(40);
  BEGIN
  
    SELECT I.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY I
     WHERE I.ITEM_KEY = ITEMKEY;
  
    --流程驳回后,将业务表状态更改为D
    UPDATE SPM_GZ_WAGEDATA_MAIN SET STATUS = 'D' WHERE ID = V_ID;
    --保存到流程记录表
    SPM_CON_CONTRACT_PKG.SAVE_WF_HISTORY(ITEMKEY,
                                         OTYPECODE,
                                         'SPM_GZ_WAGEDATA_MAIN',
                                         '',
                                         'JOB_ID',
                                         'ID');
  
  END;

  --专家信息导入信息验证validate    专家信息列表页面
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
  
    --验证导入字段名格式是否正确
    IF CU_DATA%FOUND THEN
      IF VALIDATE_A <> '姓名' OR VALIDATE_B <> '身份证号' OR VALIDATE_C <> '银行账号' OR
         VALIDATE_D <> '开户行' OR VALIDATE_E <> '收款账号省份' OR
         VALIDATE_F <> '收款账号地市' THEN
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
        MSG_A := MSG_A || '行 姓名不能为空;  ';
      END IF;
      IF MSG_B IS NOT NULL THEN
        MSG_B := MSG_B || '行 身份证号不能为空;  ';
      END IF;
      IF MSG_C IS NOT NULL THEN
        MSG_C := MSG_C || '行 银行账号不能为空;  ';
      END IF;
      /*if msg_d is not null then
        msg_d:= msg_d ||'行 银行名称不能为空; ';
      end if;*/
      IF MSG_D IS NOT NULL THEN
        MSG_D := MSG_D || '行 开户行不能为空;  ';
      END IF;
      IF MSG_E IS NOT NULL THEN
        MSG_E := MSG_E || '行 收款账号省份不能为空; ';
      END IF;
      IF MSG_F IS NOT NULL THEN
        MSG_F := MSG_F || '行 收款账号地市不能为空;  ';
      END IF;
      IF MSG_H IS NOT NULL THEN
        MSG_H := MSG_H || '行 该专家在专家库里已存在，不能重复导入;  ';
      END IF;
      P_MSG := P_MSG || MSG_A || MSG_B || MSG_C || MSG_D || MSG_E || MSG_F ||
               MSG_G || MSG_H;
      IF P_MSG IS NOT NULL THEN
        RETURN;
      END IF;
    END IF;
  END;
  --专家信息导入    专家信息列表页面
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
    
      SELECT SPM_CON_VENDOR_INFO_SEQ.NEXTVAL INTO V_EXP_ID FROM DUAL; --供应商主键
      SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss')
        INTO SETUPDATE
        FROM DUAL; --建立日期
      USERID := SPM_SSO_PKG.GETUSERID;
      SELECT T.PERSON_ID
        INTO SETUPPERSON
        FROM SPM_EAM_ALL_PEOPLE_V T
       WHERE T.USER_ID = USERID;
      USERORGID := SPM_SSO_PKG.GETORGID;
      ---插入专家id exp_id到明细表       fee_main_id,
    
      INSERT INTO SPM_CON_VENDOR_INFO
        (VENDOR_ID, --供应商主键主键
         VENDOR_CODE, --身份证号
         SETUP_DATE, --建立时间  
         VENDOR_NAME, --姓名
         SETUP_PERSON, --创建人
         ORG_ID,
         ATTRIBUTE1, --同步状态 A
         VENDOR_ADDRESS, --地址
         IS_BIDDING_VENDOR --是否为专家
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
        (ACOUNT_ID, --主键
         VENDOR_ID, --供应商主键
         BANK_ACOUNT, --账户
         OPENING_BANK, --开户行  
         ATTRIBUTE1, --账户
         --ATTRIBUTE2,--银行名称
         ATTRIBUTE3, --收款账号省份
         ATTRIBUTE4, --收款账号地市
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

  --专家咨询费明细保存数据插入申请付款金额
  PROCEDURE SPM_EXPERT_FEE_MONEY_AMOUNT(ID NUMBER) AS
  
    V_AMOUNT NUMBER;
  BEGIN
    --查出总金额
    SELECT (NVL((SELECT SUM(ROUND(D.FACT_AMOUNT, 2))
                  FROM SPM_EXPERT_FEE_DETAIL D
                 WHERE D.FEE_MAIN_ID = F.FEE_MAIN_ID),
                0))
      INTO V_AMOUNT
      FROM SPM_EXPERT_FEE F
     WHERE F.FEE_MAIN_ID = ID;
  
    --修改专家咨询费的申请付款金额
    UPDATE SPM_EXPERT_FEE F
       SET F.MONEY_AMOUNT = V_AMOUNT
     WHERE F.FEE_MAIN_ID = ID;
  END;

  --资金计划额度 自动取值
  PROCEDURE SPM_CAPITAL_GET_VAL(DEPTCODE       VARCHAR2,
                                ORGID          VARCHAR2,
                                CAPITALBALANCE OUT NUMBER, --上月额度余缺
                                RECEIVEAMOUNT  OUT NUMBER, --上月收款金额
                                NONPAYCOST     OUT NUMBER, --上月非付现成本
                                REPORTPROFIT   OUT NUMBER, --上月报表利润
                                TAXAMOUNT      OUT NUMBER) IS
    --上月应纳税
    CAPITALQUOTA      NUMBER; --资金计划额度
    PAYAMOUNT         NUMBER; --本月付款金额
    THISMONTHBALANCE  NUMBER; --本月结余额
    SHADDAMOUNT       NUMBER; --上会增加额
    SYXXAMOUNT        NUMBER; --上月销项金额
    SYJXAMOUNT        NUMBER; --上月进项金额
    EXCHANGEREC       NUMBER; --往来应收金额
    EXCHANGEPAY       NUMBER; --往来应付金额
    REPORTPROFITDF      NUMBER; --报表利润 贷方
    REPORTPROFITJF      NUMBER; --报表利润 借方
    V_QUOTAMONTH_LAST VARCHAR2(10); --上一月 2018-06
    V_QUOTAMONTH      VARCHAR2(10); --当前月 2018-07
    V_MONTHLAST       VARCHAR2(10); --上一月 -06
    V_YEAR            VARCHAR2(10); --当前年 -2018
    FIRSTMONTH        VARCHAR2(20); --上月月初 2018-07-01
    ENDMONTH          VARCHAR2(20);--上月末 2018-07-31
    V_NUMBER1         NUMBER;
    V_NUMBER2         NUMBER;
    V_CAPITALID       NUMBER(15);
    V_ORGCODE         VARCHAR2(20);
    V_VALTYPE1        VARCHAR2(50);--取值的类型  非付现
    V_VALTYPEDF        VARCHAR2(50);--取值的类型  报表利润 贷方
    V_VALTYPEJF        VARCHAR2(50);--取值的类型  报表利润 借方
    V_VALTYPE3        VARCHAR2(50);--取值的类型  上月销项
    V_VALTYPE4        VARCHAR2(50);--取值的类型  上月进项
    V_SMALLCODE       SPM_TYPE_TBL := SPM_TYPE_TBL();
    V_KMZH            SPM_TYPE_TBL := SPM_TYPE_TBL(); --非付现成本的科目组合
    V_KMBBLR          SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月报表利润的科目组合
    V_KMBBLRDF        SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月报表利润的贷方科目组合
    V_KMBBLRJF        SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月报表利润的借方科目组合
    V_KMYNSXX         SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月应纳税的上月销项科目组合
    V_KMYNSJX         SPM_TYPE_TBL := SPM_TYPE_TBL(); --上月应纳税的上月进项科目组合
  BEGIN
    SELECT TO_CHAR(SYSDATE, 'yyyy-mm') INTO V_QUOTAMONTH FROM DUAL;--当前年月 2018-07
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL;--上一年月 2018-06
    SELECT TO_CHAR(ADD_MONTHS(TRUNC(SYSDATE),-1), 'mm') INTO V_MONTHLAST FROM DUAL;--上一月 06*/
    SELECT TO_CHAR(SYSDATE, 'yyyy') INTO V_YEAR FROM DUAL; --当前年 2018
  
    --add by ruankk  解决跨年的时候年份取得不准的bug;
    IF V_MONTHLAST = '12' THEN
      V_YEAR := TO_CHAR(TO_NUMBER(V_YEAR) - 1);
    END IF;
  
    --上月月初  月末
    SELECT TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -2) + 1, 'yyyy-mm-dd'),
           TO_CHAR(ADD_MONTHS(LAST_DAY(SYSDATE), -1), 'yyyy-mm-dd')
     INTO FIRSTMONTH,ENDMONTH
   FROM DUAL;
   
    --测试用月份
  /*  SELECT TO_CHAR(TO_DATE(201802, 'yyyymm'), 'yyyy-mm')
      INTO V_QUOTAMONTH
      FROM DUAL; --当前年月 2018-03
    SELECT TO_CHAR(ADD_MONTHS(TO_DATE(201802, 'yyyymm'), -1), 'mm')
      INTO V_MONTHLAST
      FROM DUAL; --3月的上一月 02
    SELECT TO_CHAR(ADD_MONTHS(TO_DATE(201802, 'yyyymm'), -1), 'yyyy-mm')
      INTO V_QUOTAMONTH_LAST
      FROM DUAL; --2018-03月的上一年月 2018-02*/
  
    SELECT OU.SHORT_CODE
      INTO V_ORGCODE
      FROM HR_OPERATING_UNITS OU
     WHERE OU.ORGANIZATION_ID = ORGID;
    --根据大部门code 查询其下的小部门结果集
    SELECT SPM_CON_INVOICE_PKG.FINANCE_DEPT_PERMISSION_B(DEPTCODE)
      INTO V_SMALLCODE
      FROM DUAL;
    --查询该部门本月是否已填报资金计划
    SELECT COUNT(P.CAPITAL_ID)
      INTO V_NUMBER2
      FROM SPM_CON_CAPITAL_PLAN P
     WHERE P.DEPT_CODE = DEPTCODE
       AND P.QUOTA_MONTH = V_QUOTAMONTH;
    IF V_NUMBER2 = 1 THEN
      --已经填报过
      RETURN;
    ELSE
      --获取上月的资金计划额度的本月结余额 和上会增加金额
      --本次资金计划额度的上月额度余缺值 = 本月结余减去上会增加
      SELECT COUNT(P.THIS_MONTH_BALANCE)
        INTO V_NUMBER1
        FROM SPM_CON_CAPITAL_PLAN P
       WHERE P.QUOTA_MONTH = V_QUOTAMONTH_LAST
         AND P.DEPT_CODE = DEPTCODE;
      IF V_NUMBER1 = 0 THEN
        --无该部门的上月的本月结余额  默认本月为0
        THISMONTHBALANCE := 0;
        SHADDAMOUNT :=0;
      ELSE
        SELECT P.THIS_MONTH_BALANCE,P.CAPITAL_ID
          INTO THISMONTHBALANCE,V_CAPITALID
          FROM SPM_CON_CAPITAL_PLAN P
         WHERE P.QUOTA_MONTH = V_QUOTAMONTH_LAST
           AND P.DEPT_CODE = DEPTCODE;
        SELECT COUNT(D.SHADD_AMOUNT) --查询该资金计划下是否有上会增加金额
          INTO V_NUMBER2
          FROM SPM_CON_CAPITAL_PLAN_DEL D
         WHERE D.CAPITAL_ID = V_CAPITALID
           AND D.TYPE_CODE = 'SH';
        IF V_NUMBER2 = 0 THEN
          --无上会增加额 默认为0
          SHADDAMOUNT := 0;
        ELSE
          SELECT SUM(D.SHADD_AMOUNT)
            INTO SHADDAMOUNT
            FROM SPM_CON_CAPITAL_PLAN_DEL D
           WHERE D.CAPITAL_ID = V_CAPITALID
             AND D.TYPE_CODE = 'SH';
        END IF;
      END IF;
      --计算 上月额度余缺值 = 本月结余 - 上会增加
      SELECT THISMONTHBALANCE - SHADDAMOUNT INTO CAPITALBALANCE FROM DUAL;
      --查询 上月收款金额
      IF ORGID = 81 THEN
        SELECT NVL(SUM(R.MONEY_AMOUNT), 0) --本部 往来应收
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
           --change by ruankk  修改资金计划上月收款取数逻辑
           /*AND R.RECEIPT_DEPT IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
           AND R.EBS_STATUS = 'US'*/;
        SELECT NVL(SUM(I.INVOICE_AMOUNT), 0) --本部 往来应付
          INTO EXCHANGEPAY
          FROM Spm_Con_Input_Invoice I
         WHERE I.GL_DATE >= TO_DATE(FIRSTMONTH, 'yyyy-mm-dd')
           AND I.GL_DATE <= TO_DATE(ENDMONTH, 'yyyy-mm-dd')
           AND I.EBS_DEPT_CODE IN
               (SELECT COLUMN_VALUE FROM TABLE(V_SMALLCODE)) --小部门段
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
      --查询上月非付现成本金额  
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
      --查询上月报表利润
      -- 贷方
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
        ---- 借方
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
         SELECT REPORTPROFITDF - REPORTPROFITJF INTO REPORTPROFIT FROM DUAL; --计算上月报表利润
        IF REPORTPROFIT < 0 THEN 
          REPORTPROFIT := 0;
         END IF;
      --查询上月应纳税 
      --上月销项      
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
      --上月进项
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
      SELECT SYXXAMOUNT - SYJXAMOUNT INTO TAXAMOUNT FROM DUAL; --计算上月应纳税额
       IF TAXAMOUNT < 0 THEN 
         TAXAMOUNT :=0;
        END IF;
    END IF;
  END SPM_CAPITAL_GET_VAL;

END SPM_GZ_INTGZINFO_PKG;
/
