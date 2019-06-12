CREATE OR REPLACE PACKAGE SPM_CON_HT_PKG
/**
 * @author 张龙龙
 * @date 2017.08.23
 * @desc 处理合同相关事项
 */
 AS
  /**
  * Todo : 获取汇率
  */
  FUNCTION GET_EXCHANGE_RATE(TCURRENCYCODE IN VARCHAR2) RETURN NUMBER;

  /**
  * 获取合同差异表
  */
  FUNCTION GET_CONTRACT_DIFF(CONID IN NUMBER, WFTYPE VARCHAR2)
    RETURN VARCHAR2;

  /**
  * 生成合同编号
  */
  FUNCTION GENERATE_CONTRACT_CODE(CONID NUMBER) RETURN VARCHAR2;

  /**
  * 合同修改时重新生成合同编号
  */
  FUNCTION GET_NEW_CONTRACT_CODE(CONID NUMBER, CATEGORYID NUMBER)
    RETURN VARCHAR2;

  /**
  * 当关联合同信息有修改、删除操作时,调用存储过程更新相互关联的合同信息
  * @param operationType 1修改 2删除
  * @param ids 要修改或者删除的ID
  */
  PROCEDURE MERGE_HT_RELATION_INFO(OPERATIONTYPE IN NUMBER,
                                   RELATIONIDS   IN VARCHAR2);

  /**
  * 合同新建时判断流程等级
  * D流程代码为11 SPM_CON_PROCESS_TYPE
  * 1:是否目录范围内产品,是:D 结束
  * 2:已关联合同是否已经审批完毕 是:D 结束
  * 3:能否提供合同差异性说明 是:按照差异说明判断;否:实质性差异
  */
  FUNCTION GET_CREATION_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2;

  /**
  * 合同变更时判断流程等级
  * D流程代码为11 SPM_CON_PROCESS_TYPE
  * 合同变更时,不允许无差异
  * 如果是非实质性变更,走D流程
  * 如果是实质性变更,按原流程走
  */
  FUNCTION GET_CHANGE_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2;

  /**
  * 合同保存后,自动生成合同差异表和合同类型信息
  * operation SAVE:合同保存,UPDATE:合同修改
  **/
  PROCEDURE GENERATE_OTHER_INFO(CONID IN NUMBER, OPERATION IN VARCHAR2);

  /**
  * 合同关闭时，生成关闭评价
  **/
  PROCEDURE GENERATE_CLOSE_EVALUATE(CONID IN NUMBER);

  /**
  * 假删除
  **/
  PROCEDURE FALSE_DELETION(TABLENAME IN VARCHAR2,
                           DELIDS    IN VARCHAR2,
                           COLNAME   IN VARCHAR2,
                           COLVAL    IN VARCHAR2);

  /**
  * 合同变更保存时,复制子表信息
  **/
  PROCEDURE SAVE_CONTRACT_CHANGE_INFO(OLDID IN NUMBER, NEWID IN NUMBER);

  /**
  * 变更的合同生效时,交换新旧合同信息
  **/
  PROCEDURE EXCHANGE_CONTRACT_CHANGE_INFO(NEWID IN NUMBER);

  --订单合同验证
  PROCEDURE ORDER_CONTRACT_VALIDATE(P_TABLENAME VARCHAR2,
                                    P_TABLEID   VARCHAR2,
                                    P_BATCHCODE VARCHAR2,
                                    P_MSG       OUT VARCHAR2);
  --订单合同导入
  PROCEDURE ORDER_CONTRACT_IMPORT(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  F_TABLENAME VARCHAR2,
                                  F_TABLEID   VARCHAR2,
                                  P_MSG       OUT VARCHAR2);

  --判断订单合同是否已关联框架协议
  FUNCTION ORDER_CONTRACT_KJXY(CONID NUMBER) RETURN NUMBER;

  /*
  * 获取订单关联的框架协议ID和编号
  * 返回格式为'ID,CODE'。获取不到返回'-1,-1'
  */
  FUNCTION GET_ORDER_KJXY(CONID NUMBER) RETURN VARCHAR2;

  FUNCTION GET_CHANGE_WF_CONTRACT_ID(P_ID NUMBER) RETURN VARCHAR2;

  /*
    根据合同ID获取最新的物料流水码
    BY MCQ
    20180910
    BUG 001
    重构下补充当合同类型为订单合同时，需要根据订单类型（销售和采购）来拼接
    订单流水号规则： 采购订单编号（截取掉前十位，取剩余部分）+ 全局流水号（入库、出库、合同明细）
    销售订单编号（截取掉前十位，取剩余部分）+ -1 + 全局流水号（入库、出库、合同明细）
    20181120 BY MCQ
  */
  FUNCTION GET_TARGET_CODE(P_ID NUMBER) RETURN VARCHAR2;
  /*
   合同审批历史获得正确的合同主键  (关键词:正向排序,版本号)
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
  * 获取合同差异表
  * 返回合同ID
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

  /**生成合同编号*/
  FUNCTION GENERATE_CONTRACT_CODE(CONID NUMBER) RETURN VARCHAR2 AS
    A         VARCHAR2(32); --年份(4位)
    B         VARCHAR2(32) := 'CWEME'; --物资集团标识(5位)
    C         VARCHAR2(32) := '0000'; --经办单位标识(4位)
    D         VARCHAR2(32); --合同业务类型
    E         VARCHAR2(32); --流水号
    F         VARCHAR2(32) := 'CN'; --国家码
    MAXCODE   VARCHAR2(32);
    IS_EXISTS NUMBER; -- 符合条件的条数
  BEGIN
    --a年份
    SELECT TO_CHAR(SYSDATE, 'YYYY') INTO A FROM DUAL;
    --c经办单位标识
    SELECT SUBSTR(S.SHORT_CODE, 5)
      INTO C
      FROM HR_OPERATING_UNITS S
     WHERE S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID;
    --d合同业务类型
    SELECT SUBSTR(C.CATEGORY_CODE, 0, 4)
      INTO D
      FROM SPM_CON_CONTRACT_CATEGORY C, SPM_CON_HT_INFO I
     WHERE C.CATEGORY_ID = I.CONTRACT_CATEGORY
       AND I.CONTRACT_ID = CONID;
  
    --e流水号
    E := A || B || C || D;
  
    --添加异常处理，如果未查询出对应数据，则动态流水号默认从00001开始
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
  * 当关联合同信息有修改、删除操作时,调用存储过程更新相互关联的合同信息
  * @param operationType 1修改 2删除
  * @param ids 要修改或者删除的ID
  */
  PROCEDURE MERGE_HT_RELATION_INFO(OPERATIONTYPE IN NUMBER,
                                   RELATIONIDS   IN VARCHAR2) AS
    IDS      SPM_TYPE_TBL;
    CONID    NUMBER(15);
    CONIDR   NUMBER(15);
    RELASHIP VARCHAR2(40);
    RELABUSS VARCHAR2(40);
    CHANGE   VARCHAR2(40);
    OCONID   NUMBER(15); --老合同id
  BEGIN
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(RELATIONIDS) INTO IDS FROM DUAL;
    IF OPERATIONTYPE = 1 THEN
      FOR I IN 1 .. IDS.COUNT LOOP
        --根据relationID查询出当前关联的合同
        SELECT S.CONTRACT_ID,
               S.CONTRACT_ID_R,
               S.RELATION_SHIP,
               S.RELATION_BUSINESS
          INTO CONIDR, CONID, RELASHIP, RELABUSS
          FROM SPM_CON_HT_RELATION S
         WHERE S.RELATION_ID = IDS(I);
        --修改信息
        UPDATE SPM_CON_HT_RELATION S
           SET S.RELATION_SHIP     = DECODE(RELASHIP, 1, 3, 2, 2, 3, 1),
               S.RELATION_BUSINESS = RELABUSS
         WHERE S.CONTRACT_ID = CONID
           AND S.CONTRACT_ID_R = CONIDR;
      END LOOP;
      --COMMIT;
    ELSIF OPERATIONTYPE = 2 THEN
      FOR I IN 1 .. IDS.COUNT LOOP
        --根据relationID查询出当前关联的合同
        SELECT S.CONTRACT_ID, S.CONTRACT_ID_R
          INTO CONIDR, CONID
          FROM SPM_CON_HT_RELATION S
         WHERE S.RELATION_ID = IDS(I);
        --修改信息
        DELETE FROM SPM_CON_HT_RELATION
         WHERE CONTRACT_ID = CONID
           AND CONTRACT_ID_R = CONIDR;
        --add by ruankk 2018/11/13 解决变更合同删除关联关系时有一条关联关系未删除的bug
        SELECT F.STATUS_CHANGE
          INTO CHANGE
          FROM SPM_CON_HT_INFO F
         WHERE F.CONTRACT_ID = CONIDR;
        --变更中的
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
      -- 回滚事务
      ROLLBACK;
  END MERGE_HT_RELATION_INFO;

  /**
  * 合同修改时重新生成合同编号
  */
  FUNCTION GET_NEW_CONTRACT_CODE(CONID NUMBER, CATEGORYID NUMBER)
    RETURN VARCHAR2 IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    OLDCATEGORYID NUMBER;
    OLDCODE       VARCHAR2(32);
    NEWCODE       VARCHAR2(32) := '';
    A             VARCHAR2(32); --年份(4位)
    B             VARCHAR2(32) := 'CWEME'; --物资集团标识(5位)
    C             VARCHAR2(32) := '0000'; --经办单位标识(4位)
    D             VARCHAR2(32); --合同业务类型
    E             VARCHAR2(32); --流水号
    F             VARCHAR2(32) := 'CN'; --国家码
    MAXCODE       VARCHAR2(32);
    VCOU          NUMBER;
    IS_EXISTS     NUMBER; -- 符合条件的条数
    TYPE SPM_CON_HT_FILE_TYPE IS TABLE OF SPM_CON_HT_FILE%ROWTYPE INDEX BY BINARY_INTEGER;
    OLDFILE SPM_CON_HT_FILE_TYPE;
    TYPE SPM_CON_CONTRACT_BASIS_TYPE IS TABLE OF NUMBER;
    NEWFILE SPM_CON_CONTRACT_BASIS_TYPE;
  BEGIN
    --先判断合同修改后，前后ID是否发生变化
    SELECT S.CONTRACT_CODE, S.CONTRACT_CATEGORY
      INTO OLDCODE, OLDCATEGORYID
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID;
  
    /**
    * 如果:
    * 1.合同编号非平台生成
    * 2.合同类型前后未发生变化
    * 3.方法未传入合同类型
    * 则直接返回原合同编号
    */
    IF LENGTH(OLDCODE) < 24 OR CATEGORYID = OLDCATEGORYID OR
       CATEGORYID IS NULL THEN
      NEWCODE := OLDCODE;
    END IF;
    IF NEWCODE IS NULL THEN
      --根据新的合同类型重新生成编号
      --a年份
      SELECT TO_CHAR(SYSDATE, 'YYYY') INTO A FROM DUAL;
      --c经办单位标识
      SELECT SUBSTR(S.SHORT_CODE, 5)
        INTO C
        FROM HR_OPERATING_UNITS S
       WHERE S.ORGANIZATION_ID = SPM_SSO_PKG.GETORGID;
      --d合同业务类型
      SELECT SUBSTR(C.CATEGORY_CODE, 0, 4)
        INTO D
        FROM SPM_CON_CONTRACT_CATEGORY C
       WHERE C.CATEGORY_ID = CATEGORYID;
    
      --合同类型发生变化后,重新生成附件表,已经上传过附件的,不再删除
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
          --还未上传附件的类型,删除
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
        --判断要新增的附件类型,是否在原合同类型中已经存在并且已上传过附件
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
      --e流水号
      E := A || B || C || D;
    
      --添加异常处理，如果未查询出对应数据，则动态流水号默认从00001开始
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
  * 合同新建时判断流程等级
  * D流程代码为11 SPM_CON_PROCESS_TYPE
  * 1:是否目录范围内产品,是:D 结束
  * 2:已关联合同是否已经审批完毕 是:D 结束
  * 3:能否提供合同差异性说明 是:按照差异说明判断;否:实质性差异
  */
  FUNCTION GET_CREATION_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2 AS
  
    DIFFLEVEL  NUMBER := -1;
    WFLEVELSTR VARCHAR2(100);
    VSTATUS    VARCHAR2(32);
    COU        NUMBER;
    ISWFEXIST  NUMBER := 1;
    DLEVEL     NUMBER := 11; --D类流程代码
  
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
    * 返回值最多由5部分组成,顺序如下
    * 0 判断依据
    * 1 判断结果(能否查询到对应的审批流程) 1存在,0不存在
    * 2 流程等级
    * 3 流程名称
    * 4 合同差异级别
    */
  
    SELECT * INTO HT FROM SPM_CON_HT_INFO S WHERE S.CONTRACT_ID = CONID;
  
    IF HT.IS_PRODUCT_CATALOG = 1 THEN
      --如果“系统外专项管控目录””这个原来“是”改成“否”按照“否”处理，如果原来是“否”变更为“是”按照“否”处理。
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
        --Step1.是否目录范围内产品,是:D流程 结束
        WFLEVELSTR := 'PRODUCT,';
      END IF;
    
    END IF;
  
    --Step2.已关联的合同是否审批完毕，是D流程
    /* 暂时取消Step2
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
    2018=11-01 欧榕
    --Step3.查询合同类型的流程配置,按金额匹配
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
            --配置了金额
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
          
            --不看差异
            /*
            * 2018-11-05 欧榕
              金额不取合同金额，取人民币金额
            */
            IF V_WF_CONF1 = 'W' THEN
              IF HT.RMB_TOTAL / 10000 > V_WF_CONF2 THEN
                IF V_WF_CONF3 IS NULL THEN
                  --金额匹配
                  WFLEVELSTR := 'JE_W,';
                  DLEVEL     := WF_CONF(I).PROCESS_TYPE;
                ELSE
                  IF HT.RMB_TOTAL / 10000 <= V_WF_CONF3 THEN
                    --金额匹配
                    WFLEVELSTR := 'JE_W,';
                    DLEVEL     := WF_CONF(I).PROCESS_TYPE;
                  END IF;
                END IF;
              END IF;
            
            ELSE
              --看差异
              NULL;
            END IF;
          END IF;
        END LOOP;
      
      END IF;
    END IF;
  
    IF WFLEVELSTR IS NULL THEN
      --Step4.能否提供差异性说明
      IF HT.NO_DIFF_REMARKS = 1 THEN
        --否:实质性差异,实质性差异代码为3
        DIFFLEVEL  := 3;
        WFLEVELSTR := 'DIFF_N,';
      ELSE
        --是:根据合同差异表判断合同差异
        SELECT * BULK COLLECT
          INTO DIFF
          FROM SPM_CON_HT_DIFF S
         WHERE S.CONTRACT_ID = CONID;
      
        FOR I IN 1 .. DIFF.COUNT LOOP
          IF SPM_CON_UTIL_PKG.IS_NUMBER(DIFF(I).DIFF_LEVEL, 'I') = 1 THEN
            /*判断是否整数*/
            IF TO_NUMBER(DIFF(I).DIFF_LEVEL) > DIFFLEVEL THEN
              DIFFLEVEL := TO_NUMBER(DIFF(I).DIFF_LEVEL);
            END IF;
          END IF;
        END LOOP;
        WFLEVELSTR := 'DIFF_Y,';
      END IF;
      --获取该差异类型是否配置流程
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
          WFLEVELSTR := WFLEVELSTR || '1,Y0,-,' || DIFFLEVEL; --查询不到
        ELSIF COU > 1 THEN
          WFLEVELSTR := WFLEVELSTR || '1,Y1,-,' || DIFFLEVEL; --配置信息过多
        END IF;
        RETURN WFLEVELSTR;
      END IF;
    END IF;
    --判断isWfExist,流程配置信息是否存在
  
    --已经判断出流程等级,接下来判断该等级流程是否有对应方案
    WFLEVELSTR := WFLEVELSTR || ISWFEXIST || ',' || DLEVEL || ',' ||
                  SPM_EAM_COMMON_PKG.GET_DICTNAME_BY_CODE('SPM_CON_PROCESS_TYPE',
                                                          DLEVEL) || ',' ||
                  DIFFLEVEL;
  
    RETURN WFLEVELSTR;
  END GET_CREATION_WF_LEVEL;

  /**
  * 合同变更时判断流程等级
  * D流程代码为11 SPM_CON_PROCESS_TYPE
  * 合同变更时,不允许无差异
  * 如果是非实质性变更,走D流程
  * 如果是实质性变更,按原流程走
  */
  FUNCTION GET_CHANGE_WF_LEVEL(CONID IN NUMBER) RETURN VARCHAR2 AS
    DIFFLEVEL  NUMBER := -1;
    WFLEVELSTR VARCHAR2(100);
    VSTATUS    VARCHAR2(32);
    COU        NUMBER;
    ISWFEXIST  NUMBER := 1;
    DLEVEL     NUMBER := 11; --D类流程代码
  
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
    * 2018=11-01 欧榕
    * 合同变更时,不允许无差异
    * 如果是非实质性变更,走D流程
    * 如果是实质性变更,按原流程走
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
      --Step1.是否目录范围内产品,是:D流程 结束
      SELECT * BULK COLLECT
        INTO ht
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_ID = conId;
    
      IF ht(1).IS_PRODUCT_CATALOG = 1 THEN
        wfLevelStr := 'PRODUCT,';
      ELSE
        --Step2.已关联的合同是否审批完毕
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
          --Step3.实质性差异
          --获取该差异类型是否配置流程
    
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
              wfLevelStr := wfLevelStr || '1,Y0,-,' || diffLevel; --查询不到
            ELSIF cou > 1 THEN
              wfLevelStr := wfLevelStr || '1,Y1,-,' || diffLevel; --配置信息过多
            END IF;
            RETURN wfLevelStr;
          END IF;
        END IF;
      END IF;
    END IF;
    
    --判断isWfExist,流程配置信息是否存在
    
    --已经判断出流程等级,接下来判断该等级流程是否有对应方案
    SELECT wfLevelStr || isWfExist || ',' || dLevel || ',' ||
           SPM_EAM_COMMON_PKG.Get_Dictname_By_Code('SPM_CON_PROCESS_TYPE',
                                                   dLevel) || ',' ||
           diffLevel
      INTO wfLevelStr
      FROM DUAL;
    
    RETURN wfLevelStr;*/
  
  END GET_CHANGE_WF_LEVEL;

  /**
  * 合同保存后,自动生成合同差异表,合同类型信息,合同归档资料表
  * operation SAVE:合同保存,UPDATE:合同修改
  **/
  PROCEDURE GENERATE_OTHER_INFO(CONID IN NUMBER, OPERATION IN VARCHAR2) AS
    SV      NUMBER;
    CC      NUMBER;
    V_CCODE VARCHAR2(100);
    DICT    SPM_TYPE_TBL;
    ARCH    SPM_TYPE_TBL;
    --这种方式可以获取表的全部信息，当然也可以用多个SPM_TYPE_TBL去存储各列信息
    TYPE BASIC_TABLE_TYPE IS TABLE OF SPM_CON_CONTRACT_BASIS%ROWTYPE INDEX BY BINARY_INTEGER;
    BT BASIC_TABLE_TYPE;
  BEGIN
    --获取新增合同的合同类型
    SELECT S.CONTRACT_CATEGORY
      INTO CC
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_ID = CONID;
  
    --从数据字典表获取合同差异类型
    SELECT D.DICT_NAME BULK COLLECT
      INTO DICT
      FROM SPM_DICT D, SPM_DICT_TYPE T
     WHERE T.TYPE_CODE = 'SPM_CON_HT_DIFF_ITEM'
       AND D.DICT_TYPE_ID = T.DICT_TYPE_ID
     ORDER BY D.DISPLAY_ORDER;
  
    --从数据字典表获取要归档的资料类型
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
    
      --生成合同编号
    
      SELECT GENERATE_CONTRACT_CODE(CONID) INTO V_CCODE FROM DUAL;
    
      UPDATE SPM_CON_HT_INFO S
         SET S.CONTRACT_CODE = V_CCODE
       WHERE S.CONTRACT_ID = CONID;
    
      --创建合同差异表
      FOR I IN 1 .. DICT.COUNT LOOP
        SELECT SPM_CON_HT_DIFF_SEQ.NEXTVAL INTO SV FROM DUAL;
        INSERT INTO SPM_CON_HT_DIFF
          (DIFF_ID, CONTRACT_ID, DIFF_ITEM)
          SELECT SV, CONID, DICT(I) FROM DUAL;
      END LOOP;
    
      --创建合同附件表
      FOR I IN 1 .. BT.COUNT LOOP
        SELECT SPM_CON_HT_FILE_SEQ.NEXTVAL INTO SV FROM DUAL;
        INSERT INTO SPM_CON_HT_FILE
          (FILE_ID, CONTRACT_ID, CATEGORY_ID, BASIS_TYPE)
          SELECT SV, CONID, CC,BT(I).BASIS_TYPE FROM DUAL;
      END LOOP;
    
      /*
      * 创建合同归档资料表
      *  ATTRIBUTE5代表通过数据字典建立的,无法删除
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
      -- 回滚事务
      ROLLBACK;
    
  END GENERATE_OTHER_INFO;

  /**
  * 合同关闭时，生成关闭评价
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
      --保存主表信息
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
      --生成评价详情
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
  * 假删除
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
  * 合同变更保存时,复制子表信息
  * 项目
  * 标的物
  * 收付款条款
  * 交货计划
  * 多方主体
  * 关联合同
  * 合同差异表
  * 客户供应商
  * 合同文本及附件
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
    --Step1.复制项目
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
  
    --Step2.复制标的物
    /*2018-10-26 欧榕
    修复变更的合同，在删除标的物时，对应的交货计划不自动删除的BUG：
    1、标的物和交货计划有关联，需要一起复制。
    2、其中交货计划表中的TAGET_ID是交货计划对应的标的物的ID，在删除标的物时会删除对应的交货计划。
    3、所以在复制标的物和交货计划时，需要重新建立关联。
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
        --Step4.复制交货计划
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
    --Step3.复制收付款条款
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
  
    --复制收付款条款附件
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
  
    --Step5.复制多方主体
    INSERT INTO SPM_CON_HT_SUBJECT
      (SUBJECT_ID, CONTRACT_ID, SUBJECT_DEPT_ID, ORG_ID, CREATED_BY)
      SELECT SPM_CON_HT_SUBJECT_SEQ.NEXTVAL,
             NEWID,
             SUBJECT_DEPT_ID,
             ORG_ID,
             CREATED_BY
        FROM SPM_CON_HT_SUBJECT
       WHERE CONTRACT_ID = OLDID;
  
    --Step6.复制关联合同
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
  
    --Step7.新增变更用的合同差异表
    INSERT INTO SPM_CON_HT_DIFF
      (DIFF_ID, CONTRACT_ID, DIFF_ITEM, ORG_ID, CREATED_BY)
      SELECT SPM_CON_HT_DIFF_SEQ.NEXTVAL,
             NEWID,
             DIFF_ITEM,
             ORG_ID,
             CREATED_BY
        FROM SPM_CON_HT_DIFF
       WHERE CONTRACT_ID = OLDID;
  
    --Step8.复制客户/供应商
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
  
    --Step9.复制合同文本及附件
  
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
  * 变更的合同生效时,交换新旧合同信息
  **/
  PROCEDURE EXCHANGE_CONTRACT_CHANGE_INFO(NEWID IN NUMBER) AS
    OLDID   NUMBER;
    CONFLAG VARCHAR2(40);
  BEGIN
    --获取合同标识
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
  
    --Step1.交换主表信息(交换ID，同时交换"不可变的信息”)
    --STATUS_CHANGE 1可用合同 2变更(进行中) 3变更(历史)
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
  
    --Step2.交换项目信息
    UPDATE SPM_CON_HT_PROJECT S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step3.交换标的物信息
    UPDATE SPM_CON_HT_TARGET S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step4.交换收付款条款信息
    UPDATE SPM_CON_HT_CLAUSE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
    --交换收付款条款附件信息
    UPDATE SPM_CON_HT_CLAUSE_FILE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step5.交换交货计划信息
    UPDATE SPM_CON_HT_GOODS_PLAN S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step6.交换多方主体信息
    UPDATE SPM_CON_HT_SUBJECT S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step7.交换关联合同信息
    UPDATE SPM_CON_HT_RELATION S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
    --add by ruankk 2018/11/13 解决变更中的合同关联合同时出现的bug
    UPDATE SPM_CON_HT_RELATION S
       SET S.CONTRACT_ID_R = OLDID
     WHERE S.CONTRACT_ID_R = NEWID;
  
    --Step8.交换合同差异表信息
    UPDATE SPM_CON_HT_DIFF S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step9.交换客户/供应商信息
    UPDATE SPM_CON_HT_MERCHANTS S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step10.交换合同文本及附件信息
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
  
    --Step11.交换盖章信息 (增补信息不需要交换)
    UPDATE SPM_CON_HT_EFFECTIVE S
       SET S.CONTRACT_ID = (CASE
                             WHEN CONTRACT_ID = OLDID THEN
                              NEWID
                             ELSE
                              OLDID
                           END)
     WHERE S.CONTRACT_ID = OLDID
        OR S.CONTRACT_ID = NEWID;
  
    --Step12.交换审批历史
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

  --订单合同验证
  PROCEDURE ORDER_CONTRACT_VALIDATE(P_TABLENAME VARCHAR2,
                                    P_TABLEID   VARCHAR2,
                                    P_BATCHCODE VARCHAR2,
                                    P_MSG       OUT VARCHAR2) AS
    COU       NUMBER;
    TC        NUMBER;
    TP        NUMBER;
    IDEN      NUMBER := 1;
    ORDERTYPE NUMBER := 0; --1采购0订单
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
    --采购比销售订单多一个采购订单编号
    XSARR      SPM_TYPE_TBL := SPM_TYPE_TBL('销售订单编号',
                                            '订单名称',
                                            '供应商名称',
                                            '采购组织',
                                            '采购部门',
                                            '采购员',
                                            '采购员电话',
                                            '税率',
                                            '币种',
                                            '总金额',
                                            '制单时间',
                                            '订单备注');
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
    CGARR      SPM_TYPE_TBL := SPM_TYPE_TBL('采购订单编号',
                                            '销售订单编号',
                                            '订单名称',
                                            '供应商名称',
                                            '采购组织',
                                            '采购部门',
                                            '采购员',
                                            '采购员电话',
                                            '税率',
                                            '币种',
                                            '总金额',
                                            '制单时间',
                                            '订单备注');
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
    SHRARR     SPM_TYPE_TBL := SPM_TYPE_TBL('收货人',
                                            '收货单位',
                                            '收货人电话',
                                            '收货人地址');
    SHRCOLARR  SPM_TYPE_TBL := SPM_TYPE_TBL('RECEIVE_USER',
                                            'RECEIVE_ORG',
                                            'RECEIVE_TEL',
                                            'RECEIVE_ADDRESS');
    KPARR      SPM_TYPE_TBL := SPM_TYPE_TBL('开票银行',
                                            '开票账号',
                                            '开票税号',
                                            '开票电话',
                                            '开票联系人',
                                            '开票类型',
                                            '开票地址',
                                            '开票备注');
    KPCOLARR   SPM_TYPE_TBL := SPM_TYPE_TBL('INVOICE_BANK',
                                            'INVOICE_ACCOUNT',
                                            'INVOICE_RATE_NUMBER',
                                            'INVOICE_TEL',
                                            'INVOICE_USER',
                                            'INVOICE_TYPE',
                                            'INVOICE_ADDRESS',
                                            'REMARK');
    WLARR      SPM_TYPE_TBL := SPM_TYPE_TBL('序号',
                                            '商品小类',
                                            '供应商商品编码',
                                            '商品编码',
                                            '商品名称',
                                            '商品参数',
                                            '规格型号',
                                            '包装规格',
                                            '生产厂商',
                                            '图号',
                                            '材质',
                                            '供货单位',
                                            '订购数量',
                                            '单价（元）',
                                            '合计（元）',
                                            '备注');
    INFOARR    SPM_TYPE_TBL;
    INFOCOLARR SPM_TYPE_TBL;
  BEGIN
  
    --Step1.判断导入的信息是否与电商平台导出的一致
    --判断导入的xls是采购还是销售订单
    SELECT COUNT(1)
      INTO ORDERTYPE
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购订单编号'
     ORDER BY S.TEMP_D_ID;
    IF ORDERTYPE > 0 THEN
      INFOARR    := CGARR;
      INFOCOLARR := CGCOLARR;
    ELSE
      INFOARR    := XSARR;
      INFOCOLARR := XSCOLARR;
    END IF;
    --判断订单信息是否缺少信息
    FOR I IN 1 .. INFOARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = INFOARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '【订单信息】中缺少[' || INFOARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '【订单信息】中[' || INFOARR(I) || ']存在多项\n';
      END IF;
    END LOOP;
  
    --判断收货人信息是否缺少信息
    FOR I IN 1 .. SHRARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = SHRARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '【收货人信息】中缺少[' || SHRARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '【收货人信息】中[' || SHRARR(I) || ']存在多项\n';
      END IF;
    END LOOP;
    --判断开票信息师傅缺少信息
    FOR I IN 1 .. KPARR.COUNT LOOP
      SELECT COUNT(1)
        INTO COU
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = KPARR(I);
      IF COU = 0 THEN
        P_MSG := P_MSG || '【开票信息】中缺少[' || KPARR(I) || ']\n';
      ELSIF COU > 1 THEN
        P_MSG := P_MSG || '【开票信息】中[' || KPARR(I) || ']存在多项\n';
      END IF;
    END LOOP;
    --判断采购物料信息是否缺少信息
    COU := WLARR.COUNT + 2;
    SELECT 'SELECT ' || LISTAGG(COLUMN_NAME, '||'',''||') WITHIN GROUP(ORDER BY S.COLUMN_ID) || ' FROM SPM_IMPORT_TEMP_D WHERE TEMP_M_ID = ' || P_BATCHCODE || ' AND A = ''序号'''
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
          P_MSG := P_MSG || '【采购物料信息】与电子超市导出的不一致;\n';
          EXIT;
        END IF;
      END LOOP;
    ELSE
      P_MSG := P_MSG || '【采购物料信息】与电子超市导出的不一致;\n';
    END IF;
    IF P_MSG IS NOT NULL THEN
      RETURN;
    END IF;
  
    --Step2.验证导入的数据是否符合SPM侧的业务要求
    /**
    * 因订单导入时需要导入关联关系
    * 所以存在一个先后导入的问题
    * 因为关联订单还未导入,所以先导入的订单找不到关联订单的ID
    * 所以,在导入订单时,除了导入订单的全部信息外,
    * 还需额外生成关联订单,保存CONTRACT_ID和CONTARCT_CODE
    * 不生成CONTRACT_NAME
    */
    --验证订单信息-订单编号
    IF ORDERTYPE = 1 THEN
      SELECT B
        INTO CGCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '采购订单编号';
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = CGCODE
         AND S.CONTRACT_NAME IS NOT NULL;
      IF COU > 0 THEN
        P_MSG := P_MSG || '【订单信息】[采购订单编号]' || CGCODE || '已存在,请勿重复导入;\n';
        RETURN;
      ELSE
        IF TRIM(CGCODE) IS NULL THEN
          P_MSG := P_MSG || '【订单信息】[采购订单编号]不允许为空;\n';
        ELSE
          COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                       'SPM_CON_HT_INFO',
                                                       'CONTRACT_CODE');
          IF LENGTH(CGCODE) > FLOOR(COLLEN / 2) THEN
            P_MSG := P_MSG || '【订单信息】[采购订单编号]允许的最长字符为' || FLOOR(COLLEN / 2) ||
                     ';\n';
          ELSIF REGEXP_REPLACE(CGCODE, '[0-9]|[a-z]|[A-Z]|[-]', '') IS NOT NULL THEN
            P_MSG := P_MSG || '【订单信息】[采购订单编号]只允许由数字、字母和\"-\"组成;\n';
          END IF;
        END IF;
      END IF;
      --判断采购订单编号和销售订单编号是否有对应关系
      SELECT B
        INTO XSCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '销售订单编号';
    
      IF XSCODE || '-1' <> CGCODE THEN
        P_MSG := P_MSG || '【订单信息】中[销售订单编号]和[采购订单编号]不构成对应关系;\n';
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
          P_MSG := '【订单信息】中[销售订单编号]' || XSCODE ||
                   '正在申请作废或者已作废,无法导入其关联订单;\n';
        END IF;
      END IF;
    ELSIF ORDERTYPE = 0 THEN
      SELECT B
        INTO XSCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '销售订单编号';
    
      SELECT COUNT(1)
        INTO COU
        FROM SPM_CON_HT_INFO S
       WHERE S.CONTRACT_CODE = XSCODE
         AND S.CONTRACT_NAME IS NOT NULL;
      IF COU > 0 THEN
        P_MSG := P_MSG || '【订单信息】[销售订单编号]' || XSCODE || '已存在,请勿重复导入;\n';
        RETURN;
      ELSE
        IF TRIM(XSCODE) IS NULL THEN
          P_MSG := P_MSG || '【订单信息】[销售订单编号]不允许为空;\n';
        ELSE
          COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                       'SPM_CON_HT_INFO',
                                                       'CONTRACT_CODE');
          IF LENGTH(XSCODE) > FLOOR(COLLEN / 2) THEN
            P_MSG := P_MSG || '【订单信息】[销售订单编号]允许的最长字符为' || FLOOR(COLLEN / 2) ||
                     ';\n';
          ELSIF REGEXP_REPLACE(XSCODE, '[0-9]|[a-z]|[A-Z]|[-]', '') IS NOT NULL THEN
            P_MSG := P_MSG || '【订单信息】[销售订单编号]只允许由数字、字母和\"-\"组成;\n';
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
              P_MSG := '【订单信息】中[销售订单编号]' || XSCODE ||
                       '所关联的采购订单正在申请作废或者已作废,无法导入其关联订单;\n';
            END IF;
          END IF;
        END IF;
      END IF;
    END IF;
    --验证剩余信息
    FOR I IN 1 .. INFOARR.COUNT LOOP
      SELECT B
        INTO VSTR
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = INFOARR(I);
      --订单名称:非空验证
      IF INFOARR(I) = '订单名称' THEN
        IF VSTR IS NULL THEN
          P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']不允许为空;\n';
        END IF;
      END IF;
      --供应商名称:必须存在
      IF INFOARR(I) = '供应商信息' THEN
        IF ORDERTYPE = 1 THEN
          --客户
          SELECT COUNT(1)
            INTO COU
            FROM AR_CUSTOMERS S
           WHERE S.CUSTOMER_NAME = VSTR;
          IF COU = 0 THEN
            P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']在EBS中不存在;\n';
          END IF;
        ELSE
          SELECT COUNT(1)
            INTO COU
            FROM AP_SUPPLIERS S
           WHERE S.VENDOR_NAME = VSTR;
          IF COU = 0 THEN
            P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']在EBS中不存在;\n';
          END IF;
        END IF;
      END IF;
      --税率必须是数字
      IF INFOARR(I) = '税率' THEN
        IF VSTR IS NOT NULL THEN
          IF SPM_CON_UTIL_PKG.IS_NUMBER(VSTR, '') = 0 THEN
            P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']只允许输入数字;\n';
          END IF;
        END IF;
      END IF;
      --金额必填，且必须为数字
      IF INFOARR(I) = '总金额' THEN
        IF VSTR IS NULL THEN
          P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']不允许为空;\n';
        ELSE
          IF SPM_CON_UTIL_PKG.IS_NUMBER(SUBSTR(VSTR, 0, LENGTH(VSTR) - 1),
                                        '') = 0 THEN
            P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']只允许输入数字;\n';
          END IF;
        END IF;
      END IF;
      --验证日期是否符合要求
    
      --验证长度
      IF INFOARR(I) = '制单时间' THEN
        IF SPM_CON_UTIL_PKG.IS_DATE(VSTR, 'YYYY-MM-DD') = 0 THEN
          P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']不符合要求' ||
                   FLOOR(COLLEN / 2) || ';\n';
        END IF;
      ELSE
        COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                     'SPM_CON_HT_INFO',
                                                     INFOCOLARR(I));
        IF LENGTH(VSTR) > FLOOR(COLLEN / 2) THEN
          P_MSG := P_MSG || '【订单信息】[' || INFOARR(I) || ']允许的最长字符为' ||
                   FLOOR(COLLEN / 2) || ';\n';
        END IF;
      END IF;
    END LOOP;
  
    --收货人信息
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
        P_MSG := P_MSG || '【收货人信息】[' || SHRARR(I) || ']允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  
    --开票信息
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
        P_MSG := P_MSG || '【开票信息】[' || KPARR(I) || ']允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  
    --采购物料信息
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
        P_MSG := P_MSG || '【采购物料信息】[商品小类](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'MATERIAL_CODE');
      IF LENGTH(ST(I).D) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[商品编码](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'MATERIAL_NAME');
      IF LENGTH(ST(I).E) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[商品名称](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_PARAMS');
      IF LENGTH(ST(I).F) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[商品参数](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'SPECIFICATION_MODEL');
      IF LENGTH(ST(I).G) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[规格型号](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'SPECIFICATION_PACKING');
      IF LENGTH(ST(I).H) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[包装规格](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_UNIT');
      IF LENGTH(ST(I).L) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[供货单位](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_COUNT');
      IF LENGTH(ST(I).M) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[订购数量](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).M, '') = 0 THEN
          P_MSG := P_MSG || '【采购物料信息】[订购数量](序号' || I || ')只允许输入数字;\n';
        ELSE
          TC := TO_NUMBER(ST(I).M);
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'UNIT_PRICE');
      IF LENGTH(ST(I).N) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[单价（元）](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).N, '') = 0 THEN
          P_MSG := P_MSG || '【采购物料信息】[单价（元）](序号' || I || ')只允许输入数字;\n';
        ELSE
          TP := TO_NUMBER(ST(I).N);
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'TARGET_AMOUNT');
      IF LENGTH(ST(I).O) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[合计（元）](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      ELSE
        IF SPM_CON_UTIL_PKG.IS_NUMBER(ST(I).O, '') = 0 THEN
          P_MSG := P_MSG || '【采购物料信息】[合计（元）](序号' || I || ')只允许输入数字;\n';
        ELSE
          IF TC * TP <> TO_NUMBER(ST(I).O) THEN
            P_MSG := P_MSG || '【采购物料信息】[合计（元）](序号' || I ||
                     ') ≠ 数量×单价（元）;\n';
          END IF;
        END IF;
      END IF;
      COLLEN := SPM_CON_UTIL_PKG.GET_COLUMN_LENGTH('SPM',
                                                   'SPM_CON_HT_TARGET',
                                                   'REMARK');
      IF LENGTH(ST(I).P) > FLOOR(COLLEN / 2) THEN
        P_MSG := P_MSG || '【采购物料信息】[备注](序号' || I || ')允许的最长字符为' ||
                 FLOOR(COLLEN / 2) || ';\n';
      END IF;
    END LOOP;
  END ORDER_CONTRACT_VALIDATE;

  --订单合同导入
  PROCEDURE ORDER_CONTRACT_IMPORT(P_TABLENAME VARCHAR2,
                                  P_TABLEID   VARCHAR2,
                                  P_BATCHCODE VARCHAR2,
                                  F_TABLENAME VARCHAR2,
                                  F_TABLEID   VARCHAR2,
                                  P_MSG       OUT VARCHAR2) AS
    CONID            NUMBER;
    COU              NUMBER;
    CONCODE          VARCHAR2(100);
    RELACODE         VARCHAR2(100); --关联合同编号
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
    * 因订单导入时需要导入关联关系
    * 所以存在一个先后导入的问题
    * 因为关联订单还未导入,所以先导入的订单找不到关联订单的ID
    * 所以,在导入订单时,除了导入订单的全部信息外,
    * 还需额外生成关联订单,保存CONTRACT_ID和CONTARCT_CODE
    * 不生成CONTRACT_NAME
    */
  
    --Step1.判断是采购订单还是销售订单
    SELECT COUNT(1)
      INTO ORDERTYPE
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购订单编号'
     ORDER BY S.TEMP_D_ID;
    IF ORDERTYPE = 1 THEN
      SELECT S.B
        INTO CONCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '采购订单编号'
       ORDER BY S.TEMP_D_ID;
      RELACODE := SUBSTR(CONCODE, 1, LENGTH(CONCODE) - 2);
    ELSE
      SELECT S.B
        INTO CONCODE
        FROM SPM_IMPORT_TEMP_D S
       WHERE S.TEMP_M_ID = P_BATCHCODE
         AND S.A = '销售订单编号'
       ORDER BY S.TEMP_D_ID;
      RELACODE := CONCODE || '-1';
    END IF;
  
    --Step2.导入订单信息
    --判断关联订单是否已经预导入
    SELECT COUNT(1)
      INTO ISREALORDEREXIST
      FROM SPM_CON_HT_INFO S
     WHERE S.CONTRACT_CODE = RELACODE;
    --获取导入信息
    SELECT S.B, S.Q
      INTO A, L
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '订单名称';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '供应商名称';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购组织';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购部门';
    SELECT S.B
      INTO E
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购员';
    SELECT S.B
      INTO F
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '采购员电话';
    SELECT S.B
      INTO G
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '税率';
    SELECT S.B
      INTO H
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '币种';
    SELECT S.B
      INTO I
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '总金额';
    SELECT S.B
      INTO J
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '制单时间';
    SELECT S.B
      INTO K
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '订单备注';
    TAXRATE := TO_NUMBER(NVL(G, 0)) * 100;
    DEPTID  := TO_NUMBER(L);
    IF ISREALORDEREXIST = 0 THEN
      --关联订单未导入,说明这一对关联订单是第1顺序导入
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
      --说明是采购/销售订单是第2顺序导入的
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
    --Step.M导入供应商客户信息(暂)
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
    --Step.P导入供应商客户信息(暂)
    SELECT S.PROJECT_ID
      INTO MERID
      FROM SPM_CON_PROJECT S
     WHERE S.ORG_ID = SPM_SSO_PKG.GETORGID
       AND S.PROJECT_NAME LIKE '无工程%';
    INSERT INTO SPM_CON_HT_PROJECT
      (CON_PRO_RELATION_ID, PROJECT_ID, CONTRACT_ID)
    VALUES
      (SPM_CON_HT_PROJECT_SEQ.NEXTVAL, MERID, CONID);
  
    --Step3.导入收货人信息
    SELECT S.B
      INTO A
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '收货人';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '收货单位';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '收货人电话';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '收货人地址';
  
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
  
    --Step4.导入开票信息
    SELECT S.B
      INTO A
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票银行';
    SELECT S.B
      INTO B
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票账号';
    SELECT S.B
      INTO C
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票税号';
    SELECT S.B
      INTO D
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票电话';
    SELECT S.B
      INTO E
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票联系人';
    SELECT S.B
      INTO F
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票类型';
    SELECT S.B
      INTO G
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票地址';
    SELECT S.B
      INTO H
      FROM SPM_IMPORT_TEMP_D S
     WHERE S.TEMP_M_ID = P_BATCHCODE
       AND S.A = '开票备注';
  
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
  
    --Step5.导入采购物料信息
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
  
    --Step6.设置采购/销售订单的关联关系
    IF ISREALORDEREXIST = 0 THEN
      /**
      * 当订单的关联订单不存在时,创建关联订单,只生成ID和编号
      * 被关联的订单导入时,需要进行UPDATE操作,而不是INSERT
      * 生成关联订单时,导入的销售/采购订单,那么关联的是采购/销售订单
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
  
    --销售/采购订单关系ID
    SELECT SPM_CON_HT_RELATION_SEQ.NEXTVAL INTO CHILDID FROM DUAL;
  
    --导入关联订单关系
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
                                               '购销成对'),
       SPM_SSO_PKG.GETORGID,
       DEPTID,
       FND_GLOBAL.USER_ID,
       SYSDATE);
  
  END ORDER_CONTRACT_IMPORT;

  --判断订单合同是否已关联框架协议
  FUNCTION ORDER_CONTRACT_KJXY(CONID NUMBER) RETURN NUMBER AS
    TYPE HT_RELATION_TYPE IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    R HT_RELATION_TYPE;
  
    KJXYCOU NUMBER := 0;
  BEGIN
  
    --获取当前合同已关联的ID信息
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
  * 获取订单关联的框架协议ID和编号
  * 返回格式为'ID,CODE'。获取不到返回'-1,-1'
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
    --获取当前合同已关联的ID信息
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
    根据合同ID获取最新的物料流水码
    BY MCQ
    20180910
    重构下补充当合同类型为订单合同时，需要根据订单类型（销售和采购）来拼接
    订单流水号规则： 采购订单编号（截取掉前十位，取剩余部分）+ 'CWEME' + 全局流水号（入库、出库、合同明细）
    销售订单编号（截取掉前十位，取剩余部分）+ '-1CWEME' + 全局流水号（入库、出库、合同明细）
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
    --补充订单合同情况
  
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
               AND HT.CODE_TYPE = '流水码'
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
    --如果不存在，则创建新的流水码   
    --如果已经存在，则需要根据流水码进行自增
    IF IS_EXISTS <> 0 THEN
    
      --取最大的流水号
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
                 AND HT.CODE_TYPE = '流水码'
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
    
      --如果流水号小于100，则格式化为3位流水,即长度大于2，自动根据字符长度进行遍历
      IF LENGTH(P_MAX_CODE) > 2 THEN
      
        FOR I IN 4 .. LENGTH(P_MAX_CODE) LOOP
          P_FORMAT_CODE := P_FORMAT_CODE || '0';
        END LOOP;
      
      END IF;
    
      --格式化数字流水号
      SELECT TRIM(TO_CHAR(P_MAX_NUM, P_FORMAT_CODE))
        INTO P_SERIAL_CODE
        FROM DUAL;
    
    END IF;
  
    P_TARGET_CODE := P_CON_CODE || P_SERIAL_CODE;
  
    RETURN P_TARGET_CODE;
  END GET_TARGET_CODE;
  
  
  /*
   合同审批历史获得正确的合同主键  (关键词:正向排序,版本号)
   rkk
   20190607
  */
  FUNCTION GET_WF_HISTORY_ID(NOW_HT_ID NUMBER) RETURN NUMBER IS
    HT_FLAG    VARCHAR2(40); --UUID
    HT_VERSION NUMBER; --版本号
    RE_ID      NUMBER; --待返回的主键
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
