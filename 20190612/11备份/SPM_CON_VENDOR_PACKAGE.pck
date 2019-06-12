CREATE OR REPLACE PACKAGE "SPM_CON_VENDOR_PACKAGE" is
  --获取供应商的不良行为记录是否可用  
  function get_bad_action(vendorid number) return varchar2;
  --供应商不良行为记录导入前的验证
  procedure bad_action_validata(p_tablename varchar2,
                                p_tableid   varchar2,
                                p_batchcode varchar2,
                                p_msg       out varchar2);
  --导入供应商不良行为记录                              
  procedure bad_action_import(p_tablename varchar2,
                              p_tableid   varchar2,
                              p_batchcode varchar2,
                              f_tablename varchar2,
                              f_tableid   varchar2,
                              p_msg       out varchar2);
  --供应商导入前导入的验证过程
  procedure vendor_validata(p_tablename varchar2,
                            p_tableid   varchar2,
                            p_batchcode varchar2,
                            p_msg       out varchar2);
  --导入供应商                         
  procedure vendor_import(p_tablename varchar2,
                          p_tableid   varchar2,
                          p_batchcode varchar2,
                          f_tablename varchar2,
                          f_tableid   varchar2,
                          p_msg       out varchar2);
  --校验供应商编号在系统中是否已经存在
  function is_had(vcode varchar2) return number;
  --校验字典项是否存在
  function is_had_dict(dict_codee varchar2, dict_namee varchar2)
    return number;
  --根据字典名称找code；
  Function Get_Dictcode_By_Name(Type_Code_In In Varchar2,
                                Dict_Code_In In Varchar2) Return Varchar2;
  --根据字典名称找code  关联父类；
  Function Get_Dictcode_By_Name_2(Father_Type_Code_In In Varchar2,
                                  Father_Dict_Code_In In Varchar2,
                                  Type_Code_In        In Varchar2,
                                  Dict_Code_In        In Varchar2)
    Return Varchar2;
  --供应商是否同步ebs  仅适用于合同新建选择供应商
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2;
  --查询电商过来的供应商状态
  function query_vendor_status(v_id varchar2, v_org_id varchar2)
    return varchar2;

  --查询电商过来的供应商状态  通过三证合一编码查找
  function query_vendor_status_by_code(v_codes varchar2) return varchar2;

  --供应商审批会签节点回调
  PROCEDURE SPM_CON_VENDOR_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);
  --发货通知单查看详情回调
  FUNCTION SPM_CON_DE_GOODS_INFO(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --发货通知单流程通知生成回调
  PROCEDURE SPM_CON_DE_GOODS_TZSC(P_NOTIFID IN VARCHAR2,
                                  
                                  P_ITEMKEY    IN VARCHAR2,
                                  P_OTYPE_CODE IN VARCHAR2);

  --发货通知单流程通知处理(后)回调
  PROCEDURE SPM_CON_DE_GOODS_TZH(P_KEY         IN VARCHAR2,
                                 P_OTYPE_CODE  IN VARCHAR2,
                                 P_NOTIFID     IN VARCHAR2,
                                 P_OPER_RESULT IN VARCHAR2);
  --发货通知单明细保存之前校验合同标的物剩余数量

  function get_surplus_number(de_id number, paras varchar2) return varchar2;
  --根据部门id获取相应的大部门名称
  function get_big_dept_name_by_deptid(deptid number) return varchar2;
  /**
  *   查询应付发票已经付款金额,以EBS入账为准
  *    P_INVOICE_ID 合同侧发票ID
  *    可能存在发票号码重复导致的发票金额不准的
  *     BY MCQ
  */
  FUNCTION MEW_GET_APINVOICE_PAYMENT(P_INVOICE_ID NUMBER) RETURN NUMBER;

  --查询合同是否发生过变更
  function query_Ht_Change(ht_id number) return varchar2;

  --查询增加了合同金额的变更合同
  function query_Ht_Change2(ht_id number) return varchar2;
  --查询变更合同增加的金额
  function get_ht_add_money(ht_id number) return number;
  --印花税保存字表时更新主表
  procedure update_stamp_tax(tax_id number);

  --印花税生成凭证
  PROCEDURE SPM_STAMP_TAX_CREATE_CERT(V_MAIN_ID        IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);
                                       
  --特殊事务处理查看详情回调
  FUNCTION SPM_CON_SP_MATTER_INFO(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --特殊事务处理流程通知生成回调
  PROCEDURE SPM_CON_SP_MATTER_TZSC(P_NOTIFID IN VARCHAR2,
                                  
                                  P_ITEMKEY    IN VARCHAR2,
                                  P_OTYPE_CODE IN VARCHAR2);

  --特殊事务处理流程通知处理(后)回调
  PROCEDURE SPM_CON_SP_MATTER_TZH(P_KEY         IN VARCHAR2,
                                 P_OTYPE_CODE  IN VARCHAR2,
                                 P_NOTIFID     IN VARCHAR2,
                                 P_OPER_RESULT IN VARCHAR2);
  --特殊事务处理审批通过回调
  PROCEDURE SPM_CON_SP_MATTER_SPTG(P_ITMEKEY IN VARCHAR2,P_OTYPECODE IN VARCHAR2);
  
  FUNCTION MD5(PASSWARD IN VARCHAR2) RETURN VARCHAR2;

end;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_VENDOR_PACKAGE" is
  --获取供应商的不良行为记录是否可用  
  function get_bad_action(vendorid number) return varchar2 is
    treatment  VARCHAR2(10); --处理方式
    begaintime date; --处理起始时间
    endtime    date; --处理结束时间
    num2       number; --记录不良结果  停止授标
    num3       number; --处理不良结果    通报批评
  
    cursor need_data is
      select b.treatment,
             b.treat_start_date as begaintime,
             b.treat_end_date   as endtime
        from spm_con_bad_action b
       where b.own_type = 2
         and b.asso_id = vendorid;
  begin
    num2 := 0; --最开始的标记 是否成功  停止授标
    num3 := 0; --最开始的标记 是否成功  通报批评
    open need_data;
    --大概是先赋值一遍，进行相应的操作；在循环结束的时候再次赋值；循环操作
    fetch need_data
      into treatment, begaintime, endtime;
    while need_data%found loop
    
      if treatment = 'WX' then
        --无限期停止
        if sysdate >= begaintime then
          num2 := num2 + 1;
        end if;
      elsif (treatment = 'YX' or treatment = 'TZ' or treatment = 'YJ') then
        --有限期停止
        if (sysdate >= begaintime and sysdate <= endtime) --在区间内，说明在禁用中
         then
          num2 := num2 + 1;
        end if;
      else
        --通报批评
        num3 := num3 + 1;
      end if;
    
      fetch need_data
        into treatment, begaintime, endtime;
    
    end loop;
    close need_data;
  
    if num2 > 0 then
      --停止授标
      RETURN 'N';
    else
      if num3 > 0 then
        --通报批评
        RETURN 'F';
      else
        --正常授标
        RETURN 'Y';
      end if;
    end if;
  
    --优化结束
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
    
  end get_bad_action;
  --供应商不良行为记录导入前的验证
  procedure bad_action_validata(p_tablename varchar2,
                                p_tableid   varchar2,
                                p_batchcode varchar2,
                                p_msg       out varchar2) is
    cursor cu_data is
      select trim(a),
             trim(b),
             trim(c),
             trim(d),
             trim(e),
             trim(f),
             trim(g),
             trim(h),
             trim(i)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
       order by to_number(row_number);
    validate_a       varchar2(2000);
    validate_b       varchar2(2000);
    validate_c       varchar2(2000);
    validate_d       varchar2(2000);
    validate_e       varchar2(2000);
    validate_f       varchar2(2000);
    validate_g       varchar2(2000);
    validate_h       varchar2(2000);
    validate_i       varchar2(2000);
    validate_number  number;
    validate_number1 number;
    validate_number2 number;
    validate_number3 number;
    validate_number4 number;
    validate_number5 number;
    validate_number6 number;
    validate_number7 number;
    validate_number8 number;
    ishas            number;
    msg_a            varchar2(4000);
    msg_b            varchar2(4000);
    msg_c            varchar2(4000);
    msg_d            varchar2(4000);
    msg_e            varchar2(4000);
    msg_f            varchar2(4000);
    msg_g            varchar2(4000);
    msg_h            varchar2(4000);
    msg_i            varchar2(4000);
    msg_j            varchar2(4000);
    msg_k            varchar2(4000);
    msg_l            varchar2(4000);
    msg_m            varchar2(4000);
    msg_n            varchar2(4000);
    msg_o            varchar2(4000);
    msg_p            varchar2(4000);
    msg_q            varchar2(4000);
    msg_r            varchar2(4000);
    msg_s            varchar2(4000);
    org_code         varchar2(200);
  
    v_dict_pro_use      varchar2(200);
    v_dict_is_check     varchar2(200);
    v_dict_pro_classify varchar2(200);
  
  begin
    open cu_data;
    fetch cu_data
      into validate_a,
           validate_b,
           validate_c,
           validate_d,
           validate_e,
           validate_f,
           validate_g,
           validate_h,
           validate_i; --第一次赋值，标题
  
    --验证导入字段名格式是否正确
    if cu_data%found then
    
      if validate_a <> '供应商全称' or validate_b <> '不良行为描述' or
         validate_c <> '处理措施' or validate_d <> '处理时长起' or
         validate_e <> '处理时长止' or validate_f <> '处理范围' or
         validate_g <> '处理依据' or validate_h <> '文件号' or validate_i <> '备注' then
        p_msg := '导入数据的字段名不符合格式';
        close cu_data;
        return;
      end if;
      fetch cu_data
        into validate_a,
             validate_b,
             validate_c,
             validate_d,
             validate_e,
             validate_f,
             validate_g,
             validate_h,
             validate_i; --第二次赋值，内容值
    
      while cu_data%found loop
        --校验必填项？
        if validate_a is null then
          if msg_a is null then
            msg_a := cu_data%rowcount;
          else
            msg_a := msg_a || ',' || cu_data%rowcount;
          end if;
        end if;
      
        if validate_b is null then
          if msg_b is null then
            msg_b := cu_data%rowcount;
          else
            msg_b := msg_b || ',' || cu_data%rowcount;
          end if;
        end if;
      
        if validate_c is null then
          if msg_c is null then
            msg_c := cu_data%rowcount;
          else
            msg_c := msg_c || ',' || cu_data%rowcount;
          end if;
        end if;
        --校验供应商是否存在
        if validate_a is not null then
          select count(v.vendor_id)
            into validate_number
            from spm_con_vendor_info v
           where v.vendor_name = validate_a;
          if validate_number = 0 then
            if msg_d is null then
              msg_d := cu_data%rowcount;
            else
              msg_d := msg_d || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;
      
        --校验处理措施是否符合规范
        if validate_c is not null then
        
          if validate_c <> '通报批评' and validate_c <> '有限期取消采购活动参与资格' and
             validate_c <> '无限期取消采购活动参与资格' and validate_c <> '停止授标' then
            if msg_e is null then
              msg_e := cu_data%rowcount;
            else
              msg_e := msg_e || ',' || cu_data%rowcount;
            end if;
          end if;
        
          if (validate_c = '有限期取消采购活动参与资格' or validate_c = '停止授标') and
             (validate_d is null or validate_e is null) then
            if msg_f is null then
              msg_f := cu_data%rowcount;
            else
              msg_f := msg_f || ',' || cu_data%rowcount;
            end if;
          end if;
        
          if validate_c = '无限期取消采购活动参与资格' and validate_d is null then
            if msg_g is null then
              msg_g := cu_data%rowcount;
            else
              msg_g := msg_g || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;
        --校验时间格式是否正确
        if validate_d is not null then
          select SPM_CON_UTIL_PKG.IS_DATE(substr2(validate_d, 1, 10),
                                          'yy-mm-dd')
            into validate_number1
            from dual;
          if validate_number1 = 0 then
            if msg_h is null then
              msg_h := cu_data%rowcount;
            else
              msg_h := msg_h || ',' || cu_data%rowcount;
            end if;
          end if;
        
        end if;
      
        if validate_e is not null then
          select SPM_CON_UTIL_PKG.IS_DATE(substr2(validate_e, 1, 10),
                                          'yy-mm-dd')
            into validate_number2
            from dual;
          if validate_number2 = 0 then
            if msg_i is null then
              msg_i := cu_data%rowcount;
            else
              msg_i := msg_i || ',' || cu_data%rowcount;
            end if;
          end if;
        
        end if;
      
        fetch cu_data
          into validate_a,
               validate_b,
               validate_c,
               validate_d,
               validate_e,
               validate_f,
               validate_g,
               validate_h,
               validate_i; --第三次赋值，循环为了下次
      
      end loop;
      close cu_data;
    end if;
    if msg_a is not null then
      msg_a := msg_a || '行 供应商全称不能为空;  ';
    end if;
    if msg_b is not null then
      msg_b := msg_b || '行 不良行为描述不能为空;  ';
    end if;
    if msg_c is not null then
      msg_c := msg_c || '行 处理措施不能为空;  ';
    end if;
    if msg_d is not null then
      msg_d := msg_d || '行 该供应商在系统中不存在;  ';
    end if;
    if msg_e is not null then
      msg_e := msg_e || '行 处理措施错误;  ';
    end if;
  
    if msg_f is not null then
      msg_f := msg_f || '行 处理时间未正确填写;  ';
    end if;
    if msg_g is not null then
      msg_g := msg_g || '行 处理时长起未正确填写;  ';
    end if;
    if msg_h is not null then
      msg_h := msg_h || '行 处理时长起时间格式不正确;  ';
    end if;
    if msg_i is not null then
      msg_i := msg_i || '行 处理时长止时间格式不正确;  ';
    end if;
  
    p_msg := p_msg || msg_a || msg_b || msg_c || msg_d || msg_e || msg_f ||
             msg_g || msg_h || msg_i || msg_j || msg_l || msg_m || msg_n ||
             msg_o || msg_p || msg_q || msg_s;
    if p_msg is not null then
      return;
    end if;
  end;

  --导入供应商不良行为记录                           
  procedure bad_action_import(p_tablename varchar2,
                              p_tableid   varchar2,
                              p_batchcode varchar2,
                              f_tablename varchar2,
                              f_tableid   varchar2,
                              p_msg       out varchar2) is
    cursor cu_data is
      select trim(a),
             trim(b),
             trim(c),
             trim(d),
             trim(e),
             trim(f),
             trim(g),
             trim(h),
             trim(i),
             trim(j),
             trim(k),
             trim(l),
             trim(m),
             trim(n)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and to_number(row_number) >= 2
       order by to_number(row_number);
    validate_a varchar2(2000);
    validate_b varchar2(2000);
    validate_c varchar2(2000);
    validate_d varchar2(2000);
    validate_e varchar2(2000);
    validate_f varchar2(2000);
    validate_g varchar2(2000);
    validate_h varchar2(2000);
    validate_i varchar2(2000);
    validate_j varchar2(2000);
    validate_k varchar2(2000);
    validate_l varchar2(2000);
    validate_m varchar2(2000);
    validate_n varchar2(2000);
    validate_o varchar2(2000);
    orgs       varchar2(40);
    bad_id     number;
    vendor_id  number;
    treat      varchar2(40);
  
  begin
    open cu_data;
    fetch cu_data
      into validate_a,
           validate_b,
           validate_c,
           validate_d,
           validate_e,
           validate_f,
           validate_g,
           validate_h,
           validate_i,
           validate_j,
           validate_k,
           validate_l,
           validate_m,
           validate_n;
    while cu_data%found loop
      --主键
      select spm_con_bad_action_seq.nextval into bad_id from dual;
      --供应商主键
      select v.vendor_id
        into vendor_id
        from spm_con_vendor_info v
       where v.vendor_name = validate_a;
      --处理措施
      if validate_c = '通报批评' then
        treat := 'TP';
      elsif validate_c = '有限期取消采购活动参与资格' then
        treat := 'YX';
      elsif validate_c = '无限期取消采购活动参与资格' then
        treat := 'WX';
      elsif validate_c = '停止授标' then
        treat := 'TZ';
      end if;
    
      insert into spm_con_bad_action
        (ACTION_ID, --主键
         asso_id, --外键
         action_desc, --描述
         treatment, --处理方式
         treat_start_date, --开始时间
         treat_end_date, --结束时间
         ATTRIBUTE2, --文件号
         OWN_TYPE, --类型2
         remark, --备注
         treat_scope, --处理范围
         treat_basis) --处理依据
      values
        (bad_id,
         vendor_id,
         validate_b,
         treat,
         to_date(substr2(validate_d, 1, 10), 'yy-mm-dd'),
         to_date(substr2(validate_e, 1, 10), 'yy-mm-dd'),
         validate_h,
         '2',
         validate_i,
         validate_f,
         validate_g);
    
      fetch cu_data
        into validate_a,
             validate_b,
             validate_c,
             validate_d,
             validate_e,
             validate_f,
             validate_g,
             validate_h,
             validate_i,
             validate_j,
             validate_k,
             validate_l,
             validate_m,
             validate_n;
    end loop;
    close cu_data;
    commit;
  end;

  --供应商导入前导入的验证过程
  procedure vendor_validata(p_tablename varchar2,
                            p_tableid   varchar2,
                            p_batchcode varchar2,
                            p_msg       out varchar2) is
    --联系人信息游标                            
    cursor man_data is
      select trim(a), trim(b), trim(c)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '联系人信息'
       order by to_number(row_number);
    --银行账户信息游标
    cursor account_data is
      select trim(a), trim(b), trim(c), trim(d), trim(e), trim(f)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '银行账户信息'
       order by to_number(row_number);
    --供应商主信息游标
    cursor vendor_data is
      select trim(a), --名称
             /* trim(b),*/
             trim(c) /*,--编码
                               trim(d),
                               trim(e),
                               trim(f),
                               trim(g),
                               trim(h),
                               trim(i),
                               trim(j),
                               trim(k),
                               trim(l),
                               trim(m),
                               trim(n),
                               trim(o),
                               trim(p),
                               trim(q),
                               trim(r)*/
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '供应商主信息'
       order by to_number(row_number);
    --     
    validate_a varchar2(2000);
    validate_b varchar2(2000);
    validate_c varchar2(2000);
    --
    validate_d varchar2(2000);
    validate_e varchar2(2000);
    validate_f varchar2(2000);
    validate_g varchar2(2000);
    validate_h varchar2(2000);
    validate_i varchar2(2000);
    --
    validate_name varchar2(2000);
    validate_code varchar2(2000);
    --
    v_name  varchar2(2000);
    v_zname varchar2(2000);
    v_dm    varchar2(2000);
    v_dz    varchar2(2000);
    v_sf    varchar2(2000);
    v_cs    varchar2(2000);
    v_fr    varchar2(2000);
    v_sj    varchar2(2000);
    v_zj    varchar2(2000);
    v_cdate varchar2(2000);
    v_jdate varchar2(2000);
    v_type  varchar2(2000);
    v_fl    varchar2(2000);
    v_flz   varchar2(2000);
    v_fw    varchar2(2000);
    v_jtnw  varchar2(2000);
    v_jt    varchar2(2000);
    v_jtf   varchar2(2000);
  
    validate_number  number;
    validate_number1 number;
    validate_number2 number;
    validate_number3 number;
    validate_number4 number;
    validate_number5 number;
    validate_number6 number;
    validate_number7 number;
    validate_number8 number;
    ishas            number;
    msg_a            varchar2(4000);
    msg_b            varchar2(4000);
    msg_c            varchar2(4000);
    msg_d            varchar2(4000);
    msg_e            varchar2(4000);
    msg_f            varchar2(4000);
    msg_g            varchar2(4000);
    msg_h            varchar2(4000);
    msg_i            varchar2(4000);
    msg_j            varchar2(4000);
    msg_k            varchar2(4000);
    msg_l            varchar2(4000);
    msg_m            varchar2(4000);
    msg_n            varchar2(4000);
    msg_o            varchar2(4000);
    msg_p            varchar2(4000);
    msg_q            varchar2(4000);
    msg_r            varchar2(4000);
    msg_s            varchar2(4000);
  
    msg_t    varchar2(4000);
    msg_u    varchar2(4000);
    msg_v    varchar2(4000);
    msg_w    varchar2(4000);
    msg_x    varchar2(4000);
    msg_y    varchar2(4000);
    msg_z    varchar2(4000);
    org_code varchar2(200);
  
    number2 number;
  
    v_dict_pro_use      varchar2(200);
    v_dict_is_check     varchar2(200);
    v_dict_pro_classify varchar2(200);
  
    p_message1 varchar2(200); --列名信息错误
    p_message2 varchar2(200); --列名信息错误
  
  begin
    --开始验证联系人信息**********************************************************；
    open man_data;
    fetch man_data
      into validate_a, validate_b, validate_c; --第一次赋值，标题
  
    --验证导入字段名格式是否正确
    if man_data%found then
    
      if validate_a <> '供应商统一社会信用代码' or validate_b <> '姓名' or
         validate_c <> '手机号码' then
        p_msg := '联系人页签导入数据的字段名不符合格式';
        close man_data;
        return;
      end if;
      fetch man_data
        into validate_a, validate_b, validate_c; --第二次赋值，内容值
    
      while man_data%found loop
        --校验必填项
        if validate_a is null then
          if msg_a is null then
            msg_a := man_data%rowcount;
          else
            msg_a := msg_a || ',' || man_data%rowcount;
          end if;
        end if;
      
        if validate_b is null then
          if msg_b is null then
            msg_b := man_data%rowcount;
          else
            msg_b := msg_b || ',' || man_data%rowcount;
          end if;
        end if;
      
        if validate_c is null then
          if msg_c is null then
            msg_c := man_data%rowcount;
          else
            msg_c := msg_c || ',' || man_data%rowcount;
          end if;
        end if;
        --校验供应商编号在系统中是否已经存在
        if validate_a is not null then
          if is_had(validate_a) > 0 then
            if msg_d is null then
              msg_d := man_data%rowcount;
            else
              msg_d := msg_d || ',' || man_data%rowcount;
            end if;
          end if;
        end if;
      
        fetch man_data
          into validate_a, validate_b, validate_c; --第三次赋值，循环为了下次
      
      end loop;
      close man_data;
    end if;
    --验证联系人信息结束**********************************************************；
  
    --开始验证银行账户信息**********************************************************；
    open account_data;
    fetch account_data
      into validate_d,
           validate_e,
           validate_f,
           validate_g,
           validate_h,
           validate_i; --第一次赋值，标题
  
    --验证导入字段名格式是否正确
    if account_data%found then
    
      if validate_d <> '供应商统一社会信用代码' or validate_e <> '账户' or
         validate_f <> '账号' or validate_g <> '银行名称' or validate_h <> '开户行' or
         validate_i <> '账户类型' then
        p_message1 := '银行账户页签导入数据的字段名不符合格式';
        close account_data;
        return;
      end if;
      fetch account_data
        into validate_d,
             validate_e,
             validate_f,
             validate_g,
             validate_h,
             validate_i; --第二次赋值，内容值
    
      while account_data%found loop
        --校验必填项
        if validate_d is null then
          if msg_e is null then
            msg_e := account_data%rowcount;
          else
            msg_e := msg_e || ',' || account_data%rowcount;
          end if;
        end if;
      
        if validate_e is null then
          if msg_f is null then
            msg_f := account_data%rowcount;
          else
            msg_f := msg_f || ',' || account_data%rowcount;
          end if;
        end if;
      
        if validate_f is null then
          if msg_g is null then
            msg_g := account_data%rowcount;
          else
            msg_g := msg_g || ',' || account_data%rowcount;
          end if;
        end if;
      
        if validate_g is null then
          if msg_h is null then
            msg_h := account_data%rowcount;
          else
            msg_h := msg_h || ',' || account_data%rowcount;
          end if;
        end if;
      
        if validate_h is null then
          if msg_i is null then
            msg_i := account_data%rowcount;
          else
            msg_i := msg_i || ',' || account_data%rowcount;
          end if;
        end if;
      
        if validate_i is null then
          if msg_j is null then
            msg_j := account_data%rowcount;
          else
            msg_j := msg_j || ',' || account_data%rowcount;
          end if;
        end if;
        --校验供应商编号在系统中是否已经存在
        if validate_d is not null then
          if is_had(validate_d) > 0 then
            if msg_k is null then
              msg_k := account_data%rowcount;
            else
              msg_k := msg_k || ',' || account_data%rowcount;
            end if;
          end if;
        end if;
        --校验账户类型是否正确
        if validate_i is not null then
          if (is_had_dict('SPM_CON_ACOUNT_TYPE', validate_i) = 0) then
            if msg_l is null then
              msg_l := account_data%rowcount;
            else
              msg_l := msg_l || ',' || account_data%rowcount;
            end if;
          end if;
        
        end if;
      
        fetch account_data
          into validate_d,
               validate_e,
               validate_f,
               validate_g,
               validate_h,
               validate_i; --第三次赋值，循环为了下次
      
      end loop;
      close account_data;
    end if;
    --验证联系人信息结束**********************************************************；
  
    --开始验证供应商主信息**********************************************************；
    open vendor_data;
    fetch vendor_data
      into validate_name, validate_code; --第一次赋值，标题
  
    --验证导入字段名格式是否正确
    if vendor_data%found then
    
      fetch vendor_data
        into validate_name, validate_code; --第二次赋值，内容值
    
      while vendor_data%found loop
      
        --校验供应商编号在系统中是否已经存在
        if validate_code is not null then
          if is_had(validate_code) > 0 then
            if msg_m is null then
              msg_m := vendor_data%rowcount;
            else
              msg_m := msg_m || ',' || vendor_data%rowcount;
            end if;
          end if;
        end if;
      
        --校验供应商名称在系统中是否已经存在
        if validate_name is not null then
        
          select count(f.vendor_id)
            into number2
            from spm_con_vendor_info f
           where f.vendor_name = validate_name
             and nvl(f.is_bidding_vendor, 'N') <> 'Y';
        
          if number2 > 0 then
            if msg_n is null then
              msg_n := vendor_data%rowcount;
            else
              msg_n := msg_n || ',' || vendor_data%rowcount;
            end if;
          
          end if;
        
        end if;
      
        fetch vendor_data
          into validate_name, validate_code; --第三次赋值，循环为了下次
      
      end loop;
      close vendor_data;
    end if;
    --验证联系人信息结束**********************************************************
    if msg_a is not null then
      msg_a := msg_a || '行 联系人页签 供应商统一社会信用代码不能为空;  ';
    end if;
    if msg_b is not null then
      msg_b := msg_b || '行 联系人页签 姓名不能为空;  ';
    end if;
    if msg_c is not null then
      msg_c := msg_c || '行 联系人页签 手机号码不能为空;  ';
    end if;
    if msg_d is not null then
      msg_d := msg_d || '行 联系人页签 该供应商编号在系统中已经存在;  ';
    end if;
    ----------------------------------------------------------
    if msg_e is not null then
      msg_e := msg_e || '行 银行账户页签 供应商统一社会信用代码不能为空;  ';
    end if;
  
    if msg_f is not null then
      msg_f := msg_f || '行 银行账户页签 账户不能为空;  ';
    end if;
    if msg_g is not null then
      msg_g := msg_g || '行 银行账户页签 账号不能为空;  ';
    end if;
    if msg_h is not null then
      msg_h := msg_h || '行  银行账户页签 银行名称不能为空;  ';
    end if;
    if msg_i is not null then
      msg_i := msg_i || '行 银行账户页签 开户行不能为空;  ';
    end if;
    if msg_j is not null then
      msg_j := msg_j || '行 银行账户页签 账户类型不能为空;  ';
    end if;
    if msg_k is not null then
      msg_k := msg_k || '行 银行账户页签 该供应商编号在系统中已经存在;  ';
    end if;
    if msg_l is not null then
      msg_l := msg_l || '行 银行账户页签 账户类型不正确;  ';
    end if;
    -------------------------------
    if msg_m is not null then
      msg_m := msg_m || '行 供应商主信息页签 该供应商编号在系统中已经存在;  ';
    end if;
    if msg_n is not null then
      msg_n := msg_n || '行 供应商主信息页签 该供应商名称在系统中已经存在;  ';
    end if;
    p_msg := p_msg || p_message1 || p_message2 || msg_a || msg_b || msg_c ||
             msg_d || msg_e || msg_f || msg_g || msg_h || msg_i || msg_j ||
             msg_l || msg_m || msg_n || msg_o || msg_p || msg_q || msg_s;
    if p_msg is not null then
      return;
    end if;
  end;

  --导入供应商                
  procedure vendor_import(p_tablename varchar2,
                          p_tableid   varchar2,
                          p_batchcode varchar2,
                          f_tablename varchar2,
                          f_tableid   varchar2,
                          p_msg       out varchar2) is
    --联系人信息                            
    cursor man_data is
      select trim(a), trim(b), trim(c)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '联系人信息'
         and to_number(row_number) >= 2
       order by to_number(row_number);
    --银行账户信息
    cursor account_data is
      select trim(a), trim(b), trim(c), trim(d), trim(e), trim(f)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '银行账户信息'
         and to_number(row_number) >= 2
       order by to_number(row_number);
    --供应商主信息
    cursor vendor_data is
      select trim(a),
             trim(b),
             trim(c),
             trim(d),
             trim(e),
             trim(f),
             trim(g),
             trim(h),
             trim(i),
             trim(j),
             trim(k),
             trim(l),
             trim(m),
             trim(n),
             trim(o),
             trim(p),
             trim(q),
             trim(r),
             trim(t)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '供应商主信息'
         and to_number(row_number) >= 2
       order by to_number(row_number);
    ---------------
    validate_a varchar2(2000);
    validate_b varchar2(2000);
    validate_c varchar2(2000);
    validate_d varchar2(2000);
    validate_e varchar2(2000);
    validate_f varchar2(2000);
    validate_g varchar2(2000);
    validate_h varchar2(2000);
    validate_i varchar2(2000);
    validate_j varchar2(2000);
    validate_k varchar2(2000);
    validate_l varchar2(2000);
    validate_m varchar2(2000);
    validate_n varchar2(2000);
    validate_o varchar2(2000);
    validate_p varchar2(2000);
    validate_q varchar2(2000);
    validate_r varchar2(2000);
    validate_t varchar2(2000);
    ----------------------
    validate_1 varchar2(2000);
    validate_2 varchar2(2000);
    validate_3 varchar2(2000);
    validate_4 varchar2(2000);
    validate_5 varchar2(2000);
    validate_6 varchar2(2000);
    -------------------------
    validate_11 varchar2(2000);
    validate_22 varchar2(2000);
    validate_33 varchar2(2000);
    validate_44 varchar2(2000);
    province    varchar2(40);
    bad_id      number;
    v_id        number; --供应商主键
    a_id        number;
    l_id        number;
    test_id     number;
    treat       varchar2(40);
  
  begin
    --供应商主信息导入；
    open vendor_data;
    fetch vendor_data
      into validate_a,
           validate_b,
           validate_c,
           validate_d,
           validate_e,
           validate_f,
           validate_g,
           validate_h,
           validate_i,
           validate_j,
           validate_k,
           validate_l,
           validate_m,
           validate_n,
           validate_o,
           validate_p,
           validate_q,
           validate_r,
           validate_t;
  
    while vendor_data%found loop
      select spm_con_vendor_info_seq.nextval into v_id from dual;
    
      insert into spm_con_vendor_info
        (vendor_id,
         vendor_name,
         vendor_name_zhs,
         vendor_code,
         taxpayer_code,
         vendor_address,
         area_code,
         city_code,
         country_code,
         legal_man,
         actual_control_man,
         registered_capital,
         setup_date,
         bus_license_date,
         vendor_type,
         vendor_kind,
         vendor_kind_branch,
         business_scope,
         wz_in_out,
         own_group,
         own_group_branch,
         is_from_e_biz,
         status,
         last_update_date,
         attribute2,
         vendor_GROUP_LEVEL,
         found_date,
         setup_person,
         vendor_level,
         vendor_use)
      values
        (v_id,
         validate_a,
         validate_b,
         validate_c,
         validate_c,
         validate_d,
         Get_Dictcode_By_Name('SPM_CON_AREA', validate_e),
         Get_Dictcode_By_Name_2('SPM_CON_AREA',
                                validate_e,
                                'SPM_CON_CITY',
                                validate_f),
         /* Get_Dictcode_By_Name('SPM_CON_CITY', validate_f),*/
         'CN',
         validate_g,
         validate_h,
         validate_i,
         to_date(substr2(validate_j, 1, 10), 'yy-mm-dd'),
         to_date(substr2(validate_k, 1, 10), 'yy-mm-dd'),
         Get_Dictcode_By_Name('SPM_CON_VENDOR_TYPE', validate_l),
         Get_Dictcode_By_Name('SPM_CON_CUST_KIND', validate_m),
         Get_Dictcode_By_Name_2('SPM_CON_CUST_KIND',
                                validate_m,
                                'SPM_CON_CUST_KIND_BRANCH',
                                validate_n),
         validate_o,
         Get_Dictcode_By_Name('SPM_CON_WZ_IN_OUT', validate_p),
         Get_Dictcode_By_Name('SPM_CON_VENDOR_OWN_GROUP', validate_q),
         Get_Dictcode_By_Name_2('SPM_CON_VENDOR_OWN_GROUP',
                                validate_q,
                                'SPM_CON_VENDOR_OWN_GROUP_BRANCH',
                                validate_r),
         'Y',
         'A',
         sysdate,
         '导入',
         'zc',
         sysdate,
         (select v.person_id
            from spm_eam_all_people_v v
           where v.user_id = validate_t),
         'f',
         'bx');
    
      fetch vendor_data
        into validate_a,
             validate_b,
             validate_c,
             validate_d,
             validate_e,
             validate_f,
             validate_g,
             validate_h,
             validate_i,
             validate_j,
             validate_k,
             validate_l,
             validate_m,
             validate_n,
             validate_o,
             validate_p,
             validate_q,
             validate_r,
             validate_t;
    end loop;
    close vendor_data;
    commit;
    --银行账户信息导入
    open account_data;
    fetch account_data
      into validate_1,
           validate_2,
           validate_3,
           validate_4,
           validate_5,
           validate_6;
  
    while account_data%found loop
    
      select spm_con_bank_acount_info_seq.nextval into a_id from dual;
      select v.vendor_id
        into test_id
        from spm_con_vendor_info v
       where v.vendor_code = validate_1;
    
      insert into spm_con_bank_acount_info
        (acount_id, --银行信息主键
         vendor_id, --供应商主键
         bank_acount, --账号
         opening_bank, --开户行
         acount_type, --类型
         acount_own_type, --所属
         attribute2, --主行
         attribute1) --账户
      values
        (a_id,
         test_id,
         validate_3,
         validate_5,
         Get_Dictcode_By_Name('SPM_CON_ACOUNT_TYPE', validate_6),
         '2',
         validate_4,
         validate_2);
    
      fetch account_data
        into validate_1,
             validate_2,
             validate_3,
             validate_4,
             validate_5,
             validate_6;
    end loop;
    close account_data;
    commit;
  
    --联系人信息导入
    open man_data;
    fetch man_data
      into validate_11, validate_22, validate_33;
  
    while man_data%found loop
      select spm_con_vendor_linkman_seq.nextval into l_id from dual;
      insert into spm_con_linkman
        (linkman_id, name, mobilephone, vendor_id, own_type)
      values
        (l_id,
         validate_22,
         validate_33,
         (select vendor_id
            from spm_con_vendor_info
           where vendor_code = validate_11),
         '2');
    
      fetch man_data
        into validate_11, validate_22, validate_33;
    end loop;
    close man_data;
    commit;
  end;

  function is_had(vcode varchar2) return number is
    num number;
  begin
    select count(vendor_id)
      into num
      from spm_con_vendor_info
     where vendor_code = vcode;
    return num;
  end;

  function is_had_dict(dict_codee varchar2, dict_namee varchar2)
    return number is
    num1 number;
  begin
    select count(d.dict_id)
      into num1
      from spm_dict d
     where d.dict_type_id =
           (select t.dict_type_id
              from spm_dict_type t
             where t.type_code = dict_codee)
       and d.dict_name = dict_namee;
    return num1;
  end;

  Function Get_Dictcode_By_Name(Type_Code_In In Varchar2,
                                Dict_Code_In In Varchar2) Return Varchar2 Is
    Result Varchar2(400);
  
  Begin
    Select d.Dict_Code
      Into Result
      From Spm_Dict d
      Left Join Spm_Dict_Type Dt
        On D.Dict_Type_Id = Dt.Dict_Type_Id
     Where D.Dict_NAME = Dict_Code_In
       And Dt.Type_code = Type_Code_In;
    Return(Result);
  End Get_Dictcode_By_Name;

  Function Get_Dictcode_By_Name_2(Father_Type_Code_In In Varchar2,
                                  Father_Dict_Code_In In Varchar2,
                                  Type_Code_In        In Varchar2,
                                  Dict_Code_In        In Varchar2)
    Return Varchar2 Is
    Result      Varchar2(400);
    father_code varchar2(40);
  
  Begin
    father_code := Get_Dictcode_By_Name(Father_Type_Code_In,
                                        Father_Dict_Code_In);
    Select d.Dict_Code
      Into Result
      From Spm_Dict d
      Left Join Spm_Dict_Type Dt
        On D.Dict_Type_Id = Dt.Dict_Type_Id
     Where D.Dict_NAME = Dict_Code_In
       And Dt.Type_code = Type_Code_In
       and d.dict_code like father_code || '%';
    Return(Result);
  End Get_Dictcode_By_Name_2;
  --供应商是否同步ebs  仅适用于合同新建选择供应商
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2 IS
    treatment  VARCHAR2(10); --处理方式
    begaintime date; --处理起始时间
    endtime    date; --处理结束时间
    num1       number; --记录ebs侧是否存在
    num2       number; --记录不良结果
  
    cursor need_data is
      select b.treatment,
             b.treat_start_date as begaintime,
             b.treat_end_date   as endtime
        from spm_con_bad_action b
       where b.own_type = 2
         and b.asso_id = VENDOR_IDR;
  
  BEGIN
    num2 := 0; --最开始的标记 是否成功
  
    select count(v.VENDOR_ID)
      into num1
      from PO_VENDORS v
     where v.SEGMENT1 = (select ven.vendor_code
                           from spm_con_vendor_info ven
                          where ven.vendor_id = VENDOR_IDR);
  
    if num1 = 0 --如果未同步 直接返回N
     then
      RETURN 'N';
    end if;
    --优化开始
    open need_data;
    --大概是先赋值一遍，进行相应的操作；在循环结束的时候再次赋值；循环操作
    fetch need_data
      into treatment, begaintime, endtime;
    while need_data%found loop
    
      if treatment = 'WX' then
        --无限期停止
        if sysdate >= begaintime then
          num2 := num2 + 1;
        end if;
      elsif (treatment = 'YX' or treatment = 'TZ') then
        --有限期停止
        if (sysdate >= begaintime and sysdate <= endtime) --在区间内，说明在禁用中
         then
          num2 := num2 + 1;
        end if;
      end if;
    
      fetch need_data
        into treatment, begaintime, endtime;
    
    end loop;
    close need_data;
  
    if num2 = 0 then
      RETURN 'Y';
    else
      RETURN 'N';
    end if;
  
    --优化结束
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END SPM_CON_VENDOR_TOEBS;

  --查询电商过来的供应商状态
  function query_vendor_status(v_id varchar2, v_org_id varchar2)
    return varchar2 is
    return_message varchar2(200); --返回的信息
    is_had         number; --是否存在
    v_name         varchar2(200); --供应商名字
    v_code         varchar2(200); --供应商编号
    v_status       varchar2(20); --业务表状态
  begin
    select count(*)
      into is_had
      from spm_con_mq_vendor v
     where (v.operation = 'insert' or v.operation = 'update')
       and v.id = v_id;
    if is_had = 0 then
      return '-1'; --中间表不存在
    else
    
      select v.business_license_no
        into v_code
        from spm_con_mq_vendor v
       where (v.operation = 'insert' or v.operation = 'update')
         and v.mq_id =
             (select max(t.mq_id) from spm_con_mq_vendor t where t.id = v_id); --中间表存在，查找名字和编号
    
      select count(*)
        into is_had
        from spm_con_vendor_info v
       where v.vendor_code = v_code; --业务表是否存在
    
      if is_had = 0 then
        return '-2'; --中间表存在，还未到业务表
      else
        select v.status
          into v_status
          from spm_con_vendor_info v
         where v.vendor_code = v_code; --查询审批状态
      
        if v_status <> 'E' then
          return '-3'; --业务表存在，审核未完成
        else
        
          select count(s.VENDOR_ID)
            into is_had
            from PO_VENDORS v
           inner join po_vendor_sites_all s
              on v.VENDOR_ID = s.VENDOR_ID
           where v.SEGMENT1 = v_code
             and s.ORG_ID = v_org_id;
        
          /*select count(*)
           into is_had
           from po_vendors t
          where t.SEGMENT1 = v_code;*/
          if is_had = 0 then
            return '-4'; --审核完成，未同步到对应组织下EBS
          else
            select v.vendor_id
              into return_message
              from spm_con_vendor_info v
             where v.vendor_code = v_code;
          
            return return_message; --返回正常结果
          end if;
        
        end if;
      end if;
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '-5';
  end;

  function query_vendor_status_by_code(v_codes varchar2) return varchar2 is
    return_message varchar2(200); --返回的信息
    is_had         number; --是否存在
    v_name         varchar2(200); --供应商名字
    v_code         varchar2(200); --供应商编号
    v_status       varchar2(20); --业务表状态
  begin
    select count(*)
      into is_had
      from spm_con_mq_vendor v
     where (v.operation = 'insert' or v.operation = 'update')
       and v.business_license_no = v_codes;
    if is_had = 0 then
      return '-1'; --中间表不存在
    else
      select distinct v.business_license_no
        into v_code
        from spm_con_mq_vendor v
       where (v.operation = 'insert' or v.operation = 'update')
         and v.business_license_no = v_codes; --中间表存在，查找名字和编号
    
      select count(*)
        into is_had
        from spm_con_vendor_info v
       where v.vendor_code = v_code; --业务表是否存在
    
      if is_had = 0 then
        return '-2'; --中间表存在，还未到业务表
      else
        select v.status
          into v_status
          from spm_con_vendor_info v
         where v.vendor_code = v_code; --查询审批状态
      
        if v_status <> 'E' then
          return '-3'; --业务表存在，审核未完成
        else
        
          select count(*)
            into is_had
            from po_vendors t
           where t.SEGMENT1 = v_code;
          if is_had = 0 then
            return '-4'; --审核完成，未同步到EBS
          else
            select v.vendor_id
              into return_message
              from spm_con_vendor_info v
             where v.vendor_code = v_code;
          
            return return_message; --返回正常结果
          end if;
        
        end if;
      end if;
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '-5';
  end;

  PROCEDURE SPM_CON_VENDOR_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2) AS
  BEGIN
  
    SPM_CON_CONTRACT_PKG.SPM_CON_START_HQ(P_KEY, VPOSITOIN_ID);
  
  END SPM_CON_VENDOR_INFO_WF_HQ;

  --发货通知单流程通知生成回调
  PROCEDURE SPM_CON_DE_GOODS_TZSC(P_NOTIFID IN VARCHAR2,
                                  P_ITEMKEY IN VARCHAR2,
                                  
                                  P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.GENERATE_HISTORY_INFO(P_NOTIFID,
                                               P_ITEMKEY,
                                               P_OTYPE_CODE,
                                               'SPM_CON_DELIVER_GOODS',
                                               'DELIVER_GOODS_ID',
                                               'STATUS',
                                               'ITEM_KEY',
                                               'D',
                                               'E');
  END SPM_CON_DE_GOODS_TZSC;
  --发货通知单流程通知处理(后)回调
  PROCEDURE SPM_CON_DE_GOODS_TZH(P_KEY         IN VARCHAR2,
                                 P_OTYPE_CODE  IN VARCHAR2,
                                 P_NOTIFID     IN VARCHAR2,
                                 P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT);
  END SPM_CON_DE_GOODS_TZH;

  --发货通知单审核工作流HTML信息展现
  FUNCTION SPM_CON_DE_GOODS_INFO(P_KEY       IN VARCHAR2,
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
                                                   'WF_URL=/spmConDeliverGoods/edit/' || V_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_DE_GOODS_INFO;

  --发货通知单明细保存之前校验合同标的物剩余数量

  function get_surplus_number(de_id number, paras varchar2) return varchar2 is
    ht_id            number;
    deliver_child_id number;
    one_paras        SPM_TYPE_TBL;
    code             varchar2(400);
    nnumber          number; --申请数量
    bnumber          number; --剩余可用数量
    htnumber         number; --总数量
    usenumber        number; --使用数量
    return_msg       varchar2(2000);
  begin
    --获取合同关联的合同主键
    select g.contract_id
      into ht_id
      from spm_con_deliver_goods g
     where g.deliver_goods_id = de_id;
  
    --分割参数
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(paras) INTO one_paras FROM DUAL;
  
    --开启循环
    FOR I IN 1 .. one_paras.COUNT LOOP
      --发货单子表主键
      select substr(one_paras(I), 0, instr(one_paras(I), '#', 1, 1) - 1)
        into deliver_child_id
        from dual;
      --物料编码
      select substr(one_paras(I),
                    instr(one_paras(I), '#', 1, 1) + 1,
                    instr(one_paras(I), '#', 1, 2) -
                    instr(one_paras(I), '#', 1, 1) - 1)
        into code
        from dual;
      --申请数量
      select substr(one_paras(I),
                    instr(one_paras(I), '#', 1, 2) + 1,
                    length(one_paras(I)) - instr(one_paras(I), '#', 1, 2))
        into nnumber
        from dual;
      --获取总数量
      select t.target_count
        into htnumber
        from spm_con_ht_target t
       where t.contract_id = ht_id
         and t.material_code = code;
      --获取已经使用的数量
      if deliver_child_id = -1 then
        --新增的
        begin
          select sum(c.item_amount)
            into usenumber
            from spm_con_deliver_goods_child c
           where c.deliver_goods_id in
                 (select g.deliver_goods_id
                    from spm_con_deliver_goods g
                   where g.contract_id = ht_id)
             and c.item_code = code;
          if usenumber is null then
            usenumber := 0;
          end if;
        
        EXCEPTION
          WHEN OTHERS THEN
            usenumber := 0;
        end;
      else
        --修改的
        begin
          select sum(c.item_amount)
            into usenumber
            from spm_con_deliver_goods_child c
           where c.deliver_goods_id in
                 (select g.deliver_goods_id
                    from spm_con_deliver_goods g
                   where g.contract_id = ht_id)
             and c.item_code = code
             and c.child_id <> deliver_child_id;
        
          if usenumber is null then
            usenumber := 0;
          end if;
        EXCEPTION
          WHEN OTHERS THEN
            usenumber := 0;
        end;
      end if;
    
      if htnumber - usenumber < nnumber then
        return_msg := return_msg || '物料编码为:' || code ||
                      ' 的物料剩余未发货数量不足，请核对后重新录入！<br/>';
      end if;
    
    end loop;
    return return_msg;
  
  end get_surplus_number;

  --根据部门id获取相应的大部门名称
  function get_big_dept_name_by_deptid(deptid number) return varchar2
  
   is
    name varchar2(200);
  begin
    select nvl((SPM_CON_UTIL_PKG.GET_FLEX_NAME_BY_VALUE(t.attribute6,
                                                        'DT 部门')),
               (select m.name
                  from HR_OPERATING_UNITS m
                 where m.short_code = t.attribute6))
      into name
      from HR.HR_ALL_ORGANIZATION_UNITS t
     where t.organization_id = deptid;
    return name;
  end get_big_dept_name_by_deptid;

  /**
  *   查询应付发票已经付款金额,以EBS入账为准
  *    P_INVOICE_ID 合同侧发票ID
  *    可能存在发票号码重复导致的发票金额不准的
  */
  FUNCTION MEW_GET_APINVOICE_PAYMENT(P_INVOICE_ID NUMBER) RETURN NUMBER IS
    V_INVOICE_AMOUNT           NUMBER;
    V_PAYMENT_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT1          NUMBER;
    V_INVOICE_TYPE_LOOKUP_CODE VARCHAR2(30);
    V_FLAG                     VARCHAR2(10);
  
  BEGIN
    --1发票金额及发票类型
    BEGIN
      SELECT AIA.INVOICE_AMOUNT, AIA.INVOICE_TYPE_LOOKUP_CODE
        INTO V_INVOICE_AMOUNT, V_INVOICE_TYPE_LOOKUP_CODE
        FROM AP_INVOICES_ALL AIA, SPM_CON_INPUT_INVOICE II
       WHERE AIA.INVOICE_NUM = II.INVOICE_CODE
         AND II.INPUT_INVOICE_ID = P_INVOICE_ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        --如果出现查询不到的情况，则代表尚未同步到EBS中
        RETURN 0;
    END;
    --2.如果发票类型为预付款，则直接去发票金额
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      RETURN V_INVOICE_AMOUNT;
    
    ELSE
      --如果发票类型为标准，则需要取正常付款金额+核销预付款金额
      --2.1正常付款金额
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
    
      --2.2核销预付款金额
      --普通发票核销预付款发票的金额
      BEGIN
      
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
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_PREPAID_AMOUNT := 0;
        
      END;
      --2.3
      RETURN V_PAYMENT_AMOUNT + V_PREPAID_AMOUNT;
    END IF;
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END MEW_GET_APINVOICE_PAYMENT;

  function query_Ht_Change(ht_id number) return varchar2 is
    uuid   varchar2(40);
    amount number;
    --判断合同是否发生过变更
    --不存在uuid应该是订单合同   
    --uuid为一个未发生过变更
    --否则则发生过变更
  begin
  
    begin
      select f.contract_flag
        into uuid
        from spm_con_ht_info f
       where f.contract_id = ht_id;
    
    exception
      when others then
        return 'Y';
    end;
  
    select count(f.contract_id)
      into amount
      from spm_con_ht_info f
     where f.contract_flag = uuid;
  
    if amount = 1 then
      return 'Y';
    else
      return 'N';
    end if;
  
  end query_Ht_Change;

  function query_Ht_Change2(ht_id number) return varchar2 is
    uuid   varchar2(40);
    amount number;
    bmoney number; --before money
    nmoney number; --now money
  
  begin
  
    begin
      select f.contract_flag
        into uuid
        from spm_con_ht_info f
       where f.contract_id = ht_id;
    
    exception
      when others then
        return 'Y';
    end;
  
    select count(f.contract_id)
      into amount
      from spm_con_ht_info f
     where f.contract_flag = uuid;
  
    if amount = 1 then
      return 'Y';
    else
    
      begin
        select rmb_total
          into bmoney
          from (select t.*, rownum rnum
                  from (select f.rmb_total
                          from spm_con_ht_info f
                         where f.status = 'E'
                           and f.contract_flag = uuid
                         order by f.contract_id desc) t)
         where rnum = 1;
      exception
        when others then
          bmoney := 0;
      end;
    
      begin
        select rmb_total
          into nmoney
          from (select t.*, rownum rnum
                  from (select f.rmb_total
                          from spm_con_ht_info f
                         where f.status = 'E'
                           and f.contract_flag = uuid
                         order by f.contract_id desc) t)
         where rnum = 2;
      exception
        when others then
          nmoney := 0;
      end;
      --只有现在的（变更后的合同金额比之前的大才返回N）
      if nmoney > bmoney then
        return 'N';
      else
        return 'Y';
      end if;
    end if;
  
  end query_Ht_Change2;

  function get_ht_add_money(ht_id number) return number is
    bmoney number; --before money
    nmoney number; --now money
  begin
    select f.rmb_total
      into nmoney
      from spm_con_ht_info f
     where f.contract_id = ht_id;
  
    select rmb_total
      into bmoney
      from (select t.*, rownum rnum
              from (select f.rmb_total
                      from spm_con_ht_info f
                     where f.status = 'E'
                       and f.contract_flag =
                           (select ht.contract_flag
                              from spm_con_ht_info ht
                             where ht.contract_id = ht_id)
                     order by f.contract_id desc) t)
     where rnum = 1;
  
    return nmoney - bmoney;
  exception
    when others then
      return 0;
  end get_ht_add_money;

  procedure update_stamp_tax(tax_id number) is
    r_ht_number        number;
    r_ht_amount        number;
    r_should_ht_amount number;
    r_tax_amount       number;
  begin
  
    begin
      select count(d.detail_id),
             sum(f.rmb_total),
             sum(d.should_ht_amount),
             sum(d.tax_amount)
        into r_ht_number, r_ht_amount, r_should_ht_amount, r_tax_amount
        from spm_con_stamp_tax_detail d, spm_con_ht_info f
       where d.stamp_tax_id = tax_id
         and d.contract_id = f.contract_id;
    exception
      when others then
        r_ht_number        := 0;
        r_ht_amount        := 0;
        r_should_ht_amount := 0;
        r_tax_amount       := 0;
    end;
  
    update spm_con_stamp_tax t
       set t.ht_number        = r_ht_number,
           t.ht_amount        = r_ht_amount,
           t.should_ht_amount = r_should_ht_amount,
           t.tax_amount       = r_tax_amount
     where t.stamp_tax_id = tax_id;
  end update_stamp_tax;

  --印花税生成凭证
  PROCEDURE SPM_STAMP_TAX_CREATE_CERT(V_MAIN_ID        IN NUMBER,
                                      V_RETURN_CODE    OUT VARCHAR2,
                                      V_RETURN_MESSAGE OUT VARCHAR2) IS
    T_HEADERS_ID        NUMBER;
    T_NUMLINE           NUMBER;
    T_RETURN_CODE       VARCHAR2(40);
    T_RETURN_MESSAGE    VARCHAR2(4000);
    T_SYSDATE           VARCHAR2(20);
    V_GLDATE            VARCHAR2(40); --总账日期
    V_PERIODNAME        VARCHAR2(40); --期间
    T_ORG_CODE          VARCHAR2(20);
    V_DEPTCODE          VARCHAR2(20);
    T_CON_NAME          VARCHAR2(90);
    T_CREATED_BY        NUMBER; --经办人
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
    STAMP_TAX           SPM_CON_STAMP_TAX%ROWTYPE;
  
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
      select d.hs_dept_id, sum(d.tax_amount) tax_amount
        from spm_con_stamp_tax_detail d
       where d.stamp_tax_id = P_MAIN_ID
       group by d.hs_dept_id;
    REC_1 CUR_1%ROWTYPE;
  
    r_year  varchar2(40); --年
    r_month varchar2(40); --月
  
  BEGIN
    --主表信息
    select *
      INTO STAMP_TAX
      from spm_con_stamp_tax t
     where t.stamp_tax_id = V_MAIN_ID;
    --校验印花税金额
    if STAMP_TAX.Tax_Amount <= 0 then
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '当前数据应缴纳印花税小于等于0';
      return;
    end if;
    --校验是否已经
    if STAMP_TAX.Gl_Date is not null then
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '当前数据已生成凭证';
      return;
    end if;
  
    --查找导入成功的记录【需要增加条件】
    SELECT COUNT(CD.GL_DATA_ID)
      INTO T_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       and cd.JE_HEADER_NAME = '印花税'
       AND CD.DATA_STATUS = 'IMPORT';
  
    --直接返回
    IF T_DATA_ID <> 0 THEN
      --说明已经导入过
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '当前数据已经生成凭证';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    --查找导入错误的记录【需要增加条件】
    SELECT COUNT(CD.GL_DATA_ID)
      INTO FAIL_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       and cd.JE_HEADER_NAME = '印花税'
       AND CD.DATA_STATUS <> 'IMPORT';
  
    IF FAIL_DATA_ID <> 0 THEN
      --说明有错误数据在中间表
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID;
    END IF;
  
    T_NUMLINE := 0;
    BEGIN
      --开始循环
      --获取经办人      
      CREATEDBYNAME := SPM_EAM_COMMON_PKG.GET_FULLNAME_BY_USERID(STAMP_TAX.Created_By);
      --获取公司段 
      SELECT OU.SHORT_CODE
        INTO T_ORG_CODE
        FROM HR_OPERATING_UNITS OU
       WHERE OU.ORGANIZATION_ID = STAMP_TAX.Org_Id;
    
      -- 获取系统时间
      SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      SELECT TO_CHAR(SYSDATE, 'YYYYMM') INTO V_PERIODNAME FROM DUAL;
      OPEN CUR_1(V_MAIN_ID);
      LOOP
      
        FETCH CUR_1
          INTO REC_1;
        EXIT WHEN CUR_1%NOTFOUND;
      
        -- 获取本次头信息的主键数据id
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
      
        T_NUMLINE := T_NUMLINE + 1;
      
        V_JE_NAME := T_ORG_CODE || STAMP_TAX.Tax_Year ||
                     STAMP_TAX.Tax_Month || '印花税' || V_MAIN_ID;
        IF REC_1.tax_amount <> 0 THEN
          --插入中间表  咨询服务费第一列
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
             LAST_UPDATE_DATE, --修改日期
             LAST_UPDATED_BY, --修改人
             LAST_UPDATE_LOGIN, --登录人id
             CREATION_DATE, --创建日期
             CREATED_BY) --创建人
          VALUES
            (T_HEADERS_ID, ----主键 沿用之前的系统生成
             'SPM系统',
             V_JE_NAME, -- 账批号  类似于code唯一的标识?????
             STAMP_TAX.Tax_Year || '年' || STAMP_TAX.Tax_Month || '月' ||
             '印花税', --描述   
             '印花税', --写死
             '报销' || STAMP_TAX.Tax_Code || '印花税', --没啥用好像  
             sysdate, -- 总账日期【取默认时间，后期要求更改】
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '报销' || STAMP_TAX.Tax_Code || '印花税', --摘要
             REC_1.tax_amount, --借方金额
             0, --贷方金额
             'NEW',
             V_MAIN_ID,
             sysdate, -- 导入日期【取默认时间，后期要求更改】
             '用户',
             '人工',
             '记账',
             V_PERIODNAME, --期间【取默认时间，后期要求更改】
             2021,
             null,
             T_ORG_CODE,
             REC_1.Hs_Dept_Id,
             '640304',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             STAMP_TAX.Created_By,
             STAMP_TAX.Last_Update_Login,
             TO_DATE(T_SYSDATE, 'YYYY-MM-DD'),
             STAMP_TAX.Created_By);
        END IF;
      
        IF REC_1.Tax_Amount <> 0 THEN
          --插入中间表  应交税费第二列       
          T_NUMLINE := T_NUMLINE + 1;
          -- 获取本次头信息的主键数据id
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
          VALUES
            (T_HEADERS_ID,
             'SPM系统',
             V_JE_NAME, -- 账批号
             STAMP_TAX.Tax_Year || '年' || STAMP_TAX.Tax_Month || '月' ||
             '印花税', --描述   
             '印花税', --
             '报销' || STAMP_TAX.Tax_Code || '印花税', --没啥用好像  
             sysdate, -- 总账日期【取默认时间，后期要求更改】
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '报销' || STAMP_TAX.Tax_Code || '印花税', --摘要
             0, --借方金额
             REC_1.TAX_AMOUNT, --贷方金额                      
             'NEW',
             V_MAIN_ID,
             sysdate, -- 导入日期
             '用户',
             '人工',
             '记账',
             V_PERIODNAME, --期间
             2021,
             null,
             T_ORG_CODE,
             REC_1.Hs_Dept_Id,
             '222119',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             '00',
             sysdate,
             STAMP_TAX.Created_By,
             STAMP_TAX.Last_Update_Login,
             sysdate,
             STAMP_TAX.Created_By);
        END IF;
        COMMIT;
      END LOOP;
      CLOSE CUR_1;
    END;
    CUX_GL_IMPORT_PKG.MAIN(ERRBUF          => T_RETURN_CODE,
                           RETCODE         => T_RETURN_MESSAGE,
                           P_DATA_SOURCE   => 'SPM系统',
                           P_JE_BATCH_NAME => V_JE_NAME,
                           P_REPEANT       => 'Y');
    IF T_RETURN_CODE = 'S' THEN
      V_RETURN_CODE := T_RETURN_CODE;
      update spm_con_stamp_tax t
         set t.gl_date = sysdate
       where t.stamp_tax_id = V_MAIN_ID;
    
    ELSE
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
         and cd.JE_HEADER_NAME = '印花税';
    END IF;
  
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);
    V_RETURN_CODE    := T_RETURN_CODE;
    V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  
  END SPM_STAMP_TAX_CREATE_CERT;

  --特殊事务处理流程通知生成回调
  PROCEDURE SPM_CON_SP_MATTER_TZSC(P_NOTIFID IN VARCHAR2,
                                   P_ITEMKEY IN VARCHAR2,
                                   
                                   P_OTYPE_CODE IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.GENERATE_HISTORY_INFO(P_NOTIFID,
                                               P_ITEMKEY,
                                               P_OTYPE_CODE,
                                               'SPM_CON_SPECIAL_MATTER',
                                               'SPECIAL_MATTER_ID',
                                               'STATUS',
                                               'ITEM_KEY',
                                               'D',
                                               'E');
  END SPM_CON_SP_MATTER_TZSC;
  --特殊事务处理流程通知处理(后)回调
  PROCEDURE SPM_CON_SP_MATTER_TZH(P_KEY         IN VARCHAR2,
                                  P_OTYPE_CODE  IN VARCHAR2,
                                  P_NOTIFID     IN VARCHAR2,
                                  P_OPER_RESULT IN VARCHAR2) AS
  
  BEGIN
    SPM_CON_CONTRACT_PKG.UPDATE_HISTORY_INFO(P_KEY,
                                             P_OTYPE_CODE,
                                             P_NOTIFID,
                                             P_OPER_RESULT);
  END SPM_CON_SP_MATTER_TZH;

  --特殊事务处理审核工作流HTML信息展现
  FUNCTION SPM_CON_SP_MATTER_INFO(P_KEY       IN VARCHAR2,
                                  POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2 IS
    MSG  VARCHAR2(10000);
    V_ID NUMBER;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE ITEM_KEY = P_KEY;
  
    MSG := '<a href=''' ||
           SPM_SSO_PKG.GET_WF_CALL_FUN_URL_DEFAULT_R('SPM_R1_WFCALLBACK',
                                                   'WF_URL=/spmConSpecialMatter/edit/' || V_ID,
                                                   P_KEY) ||
           '''>查看详情</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '出错啦！';
      RETURN MSG;
    
  END SPM_CON_SP_MATTER_INFO;

  PROCEDURE SPM_CON_SP_MATTER_SPTG(P_ITMEKEY   IN VARCHAR2,
                                   P_OTYPECODE IN VARCHAR2) AS
    V_SP_ID      NUMBER; --主键
    V_SP_TYPE    VARCHAR2(40); --业务类型
    V_SP_USER_ID NUMBER; --创建人
    V_SP_CODE    VARCHAR2(200); --业务单据编码
    V_RE_MSG     VARCHAR2(4000);
    V_TITLE      VARCHAR2(200);
    V_ONECODE     VARCHAR2(200);
    --密文加密格式  业务类型 + 创建人 + 申请时间 + 单据编码 的MD5加密
  
    CURSOR DETIAL_RECEIPT(V_ID NUMBER) IS
      SELECT M.SERIAL_NUMBER, DL.CREATION_DATE
        FROM SPM.SPM_CON_SPECIAL_MATTER_DTL DL, SPM_CON_MONEY_REG M
       WHERE DL.SPECIAL_MATTER_ID = V_ID
         AND M.MONEY_REG_ID = DL.BUSSINESS_ID;
  BEGIN
  
    SELECT W.JOB_ID
      INTO V_SP_ID
      FROM SPM_CON_WF_ACTIVITY W
     WHERE W.ITEM_KEY = P_ITMEKEY;
  
    SELECT M.BUSSINESS_TYPE, M.CREATED_BY
      INTO V_SP_TYPE, V_SP_USER_ID
      FROM SPM.SPM_CON_SPECIAL_MATTER M
     WHERE M.SPECIAL_MATTER_ID = V_SP_ID;
  
    IF V_SP_TYPE = 'receipt' THEN
      V_TITLE := '你申请的到款重新签收已经审批通过!<br>  到款交易编号对应的密文如下:<br>  ';
      FOR DD IN DETIAL_RECEIPT(V_SP_ID) LOOP
        V_RE_MSG := V_RE_MSG || DD.SERIAL_NUMBER || ':' ||
                    MD5(V_SP_TYPE || V_SP_USER_ID ||
                        TO_CHAR(DD.CREATION_DATE, 'yyyyMMdd') ||
                        DD.SERIAL_NUMBER) || ';  ';
       IF  V_ONECODE IS NULL THEN 
         V_ONECODE := DD.SERIAL_NUMBER;
       END IF;
      END LOOP;
    
      SPM_WF_COMMON_PKG.SENDNOTIFICATIONTOUSER(SPM_COMMON_PKG.GET_EMPNUM_BY_PERSONID(SPM_COMMON_PKG.GET_PERSONID_BY_USERID(V_SP_USER_ID)),
                                               '特殊事务审批密文发送' || V_ONECODE || '等',
                                               V_TITLE || V_RE_MSG,
                                               NULL,
                                               NULL,
                                               'MTL_SETUP');
    END IF;
  
    IF V_SP_TYPE = 'payment' THEN
      UPDATE SPM_CON_PAYMENT P
         SET P.STATUS = 'E'
       WHERE P.PAYMENT_ID IN
             (select D.BUSSINESS_ID
                from SPM.SPM_CON_SPECIAL_MATTER_DTL D
               WHERE D.SPECIAL_MATTER_ID = V_SP_ID);
    END IF;
  
  END SPM_CON_SP_MATTER_SPTG;
  
  FUNCTION MD5(PASSWARD IN VARCHAR2) RETURN VARCHAR2 IS
    REURN VARCHAR2(200);
  BEGIN
    REURN  := UTL_RAW.CAST_TO_RAW(DBMS_OBFUSCATION_TOOLKIT.MD5(INPUT_STRING => PASSWARD));
    RETURN REURN;
  END;

end;
/
