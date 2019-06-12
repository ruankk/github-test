CREATE OR REPLACE PACKAGE "SPM_CON_VENDOR_PACKAGE" is
  --��ȡ��Ӧ�̵Ĳ�����Ϊ��¼�Ƿ����  
  function get_bad_action(vendorid number) return varchar2;
  --��Ӧ�̲�����Ϊ��¼����ǰ����֤
  procedure bad_action_validata(p_tablename varchar2,
                                p_tableid   varchar2,
                                p_batchcode varchar2,
                                p_msg       out varchar2);
  --���빩Ӧ�̲�����Ϊ��¼                              
  procedure bad_action_import(p_tablename varchar2,
                              p_tableid   varchar2,
                              p_batchcode varchar2,
                              f_tablename varchar2,
                              f_tableid   varchar2,
                              p_msg       out varchar2);
  --��Ӧ�̵���ǰ�������֤����
  procedure vendor_validata(p_tablename varchar2,
                            p_tableid   varchar2,
                            p_batchcode varchar2,
                            p_msg       out varchar2);
  --���빩Ӧ��                         
  procedure vendor_import(p_tablename varchar2,
                          p_tableid   varchar2,
                          p_batchcode varchar2,
                          f_tablename varchar2,
                          f_tableid   varchar2,
                          p_msg       out varchar2);
  --У�鹩Ӧ�̱����ϵͳ���Ƿ��Ѿ�����
  function is_had(vcode varchar2) return number;
  --У���ֵ����Ƿ����
  function is_had_dict(dict_codee varchar2, dict_namee varchar2)
    return number;
  --�����ֵ�������code��
  Function Get_Dictcode_By_Name(Type_Code_In In Varchar2,
                                Dict_Code_In In Varchar2) Return Varchar2;
  --�����ֵ�������code  �������ࣻ
  Function Get_Dictcode_By_Name_2(Father_Type_Code_In In Varchar2,
                                  Father_Dict_Code_In In Varchar2,
                                  Type_Code_In        In Varchar2,
                                  Dict_Code_In        In Varchar2)
    Return Varchar2;
  --��Ӧ���Ƿ�ͬ��ebs  �������ں�ͬ�½�ѡ��Ӧ��
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2;
  --��ѯ���̹����Ĺ�Ӧ��״̬
  function query_vendor_status(v_id varchar2, v_org_id varchar2)
    return varchar2;

  --��ѯ���̹����Ĺ�Ӧ��״̬  ͨ����֤��һ�������
  function query_vendor_status_by_code(v_codes varchar2) return varchar2;

  --��Ӧ��������ǩ�ڵ�ص�
  PROCEDURE SPM_CON_VENDOR_INFO_WF_HQ(P_KEY        IN VARCHAR2,
                                      P_OTYPE_CODE IN VARCHAR2,
                                      VPOSITOIN_ID IN VARCHAR2);
  --����֪ͨ���鿴����ص�
  FUNCTION SPM_CON_DE_GOODS_INFO(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --����֪ͨ������֪ͨ���ɻص�
  PROCEDURE SPM_CON_DE_GOODS_TZSC(P_NOTIFID IN VARCHAR2,
                                  
                                  P_ITEMKEY    IN VARCHAR2,
                                  P_OTYPE_CODE IN VARCHAR2);

  --����֪ͨ������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_DE_GOODS_TZH(P_KEY         IN VARCHAR2,
                                 P_OTYPE_CODE  IN VARCHAR2,
                                 P_NOTIFID     IN VARCHAR2,
                                 P_OPER_RESULT IN VARCHAR2);
  --����֪ͨ����ϸ����֮ǰУ���ͬ�����ʣ������

  function get_surplus_number(de_id number, paras varchar2) return varchar2;
  --���ݲ���id��ȡ��Ӧ�Ĵ�������
  function get_big_dept_name_by_deptid(deptid number) return varchar2;
  /**
  *   ��ѯӦ����Ʊ�Ѿ�������,��EBS����Ϊ׼
  *    P_INVOICE_ID ��ͬ�෢ƱID
  *    ���ܴ��ڷ�Ʊ�����ظ����µķ�Ʊ��׼��
  *     BY MCQ
  */
  FUNCTION MEW_GET_APINVOICE_PAYMENT(P_INVOICE_ID NUMBER) RETURN NUMBER;

  --��ѯ��ͬ�Ƿ��������
  function query_Ht_Change(ht_id number) return varchar2;

  --��ѯ�����˺�ͬ���ı����ͬ
  function query_Ht_Change2(ht_id number) return varchar2;
  --��ѯ�����ͬ���ӵĽ��
  function get_ht_add_money(ht_id number) return number;
  --ӡ��˰�����ֱ�ʱ��������
  procedure update_stamp_tax(tax_id number);

  --ӡ��˰����ƾ֤
  PROCEDURE SPM_STAMP_TAX_CREATE_CERT(V_MAIN_ID        IN NUMBER,
                                       V_RETURN_CODE    OUT VARCHAR2,
                                       V_RETURN_MESSAGE OUT VARCHAR2);
                                       
  --����������鿴����ص�
  FUNCTION SPM_CON_SP_MATTER_INFO(P_KEY       IN VARCHAR2,
                                 POTYPE_CODE IN VARCHAR2) RETURN VARCHAR2;

  --��������������֪ͨ���ɻص�
  PROCEDURE SPM_CON_SP_MATTER_TZSC(P_NOTIFID IN VARCHAR2,
                                  
                                  P_ITEMKEY    IN VARCHAR2,
                                  P_OTYPE_CODE IN VARCHAR2);

  --��������������֪ͨ����(��)�ص�
  PROCEDURE SPM_CON_SP_MATTER_TZH(P_KEY         IN VARCHAR2,
                                 P_OTYPE_CODE  IN VARCHAR2,
                                 P_NOTIFID     IN VARCHAR2,
                                 P_OPER_RESULT IN VARCHAR2);
  --��������������ͨ���ص�
  PROCEDURE SPM_CON_SP_MATTER_SPTG(P_ITMEKEY IN VARCHAR2,P_OTYPECODE IN VARCHAR2);
  
  FUNCTION MD5(PASSWARD IN VARCHAR2) RETURN VARCHAR2;

end;
/
CREATE OR REPLACE PACKAGE BODY "SPM_CON_VENDOR_PACKAGE" is
  --��ȡ��Ӧ�̵Ĳ�����Ϊ��¼�Ƿ����  
  function get_bad_action(vendorid number) return varchar2 is
    treatment  VARCHAR2(10); --����ʽ
    begaintime date; --������ʼʱ��
    endtime    date; --�������ʱ��
    num2       number; --��¼�������  ֹͣ�ڱ�
    num3       number; --���������    ͨ������
  
    cursor need_data is
      select b.treatment,
             b.treat_start_date as begaintime,
             b.treat_end_date   as endtime
        from spm_con_bad_action b
       where b.own_type = 2
         and b.asso_id = vendorid;
  begin
    num2 := 0; --�ʼ�ı�� �Ƿ�ɹ�  ֹͣ�ڱ�
    num3 := 0; --�ʼ�ı�� �Ƿ�ɹ�  ͨ������
    open need_data;
    --������ȸ�ֵһ�飬������Ӧ�Ĳ�������ѭ��������ʱ���ٴθ�ֵ��ѭ������
    fetch need_data
      into treatment, begaintime, endtime;
    while need_data%found loop
    
      if treatment = 'WX' then
        --������ֹͣ
        if sysdate >= begaintime then
          num2 := num2 + 1;
        end if;
      elsif (treatment = 'YX' or treatment = 'TZ' or treatment = 'YJ') then
        --������ֹͣ
        if (sysdate >= begaintime and sysdate <= endtime) --�������ڣ�˵���ڽ�����
         then
          num2 := num2 + 1;
        end if;
      else
        --ͨ������
        num3 := num3 + 1;
      end if;
    
      fetch need_data
        into treatment, begaintime, endtime;
    
    end loop;
    close need_data;
  
    if num2 > 0 then
      --ֹͣ�ڱ�
      RETURN 'N';
    else
      if num3 > 0 then
        --ͨ������
        RETURN 'F';
      else
        --�����ڱ�
        RETURN 'Y';
      end if;
    end if;
  
    --�Ż�����
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
    
  end get_bad_action;
  --��Ӧ�̲�����Ϊ��¼����ǰ����֤
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
           validate_i; --��һ�θ�ֵ������
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    if cu_data%found then
    
      if validate_a <> '��Ӧ��ȫ��' or validate_b <> '������Ϊ����' or
         validate_c <> '�����ʩ' or validate_d <> '����ʱ����' or
         validate_e <> '����ʱ��ֹ' or validate_f <> '����Χ' or
         validate_g <> '��������' or validate_h <> '�ļ���' or validate_i <> '��ע' then
        p_msg := '�������ݵ��ֶ��������ϸ�ʽ';
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
             validate_i; --�ڶ��θ�ֵ������ֵ
    
      while cu_data%found loop
        --У������
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
        --У�鹩Ӧ���Ƿ����
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
      
        --У�鴦���ʩ�Ƿ���Ϲ淶
        if validate_c is not null then
        
          if validate_c <> 'ͨ������' and validate_c <> '������ȡ���ɹ�������ʸ�' and
             validate_c <> '������ȡ���ɹ�������ʸ�' and validate_c <> 'ֹͣ�ڱ�' then
            if msg_e is null then
              msg_e := cu_data%rowcount;
            else
              msg_e := msg_e || ',' || cu_data%rowcount;
            end if;
          end if;
        
          if (validate_c = '������ȡ���ɹ�������ʸ�' or validate_c = 'ֹͣ�ڱ�') and
             (validate_d is null or validate_e is null) then
            if msg_f is null then
              msg_f := cu_data%rowcount;
            else
              msg_f := msg_f || ',' || cu_data%rowcount;
            end if;
          end if;
        
          if validate_c = '������ȡ���ɹ�������ʸ�' and validate_d is null then
            if msg_g is null then
              msg_g := cu_data%rowcount;
            else
              msg_g := msg_g || ',' || cu_data%rowcount;
            end if;
          end if;
        end if;
        --У��ʱ���ʽ�Ƿ���ȷ
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
               validate_i; --�����θ�ֵ��ѭ��Ϊ���´�
      
      end loop;
      close cu_data;
    end if;
    if msg_a is not null then
      msg_a := msg_a || '�� ��Ӧ��ȫ�Ʋ���Ϊ��;  ';
    end if;
    if msg_b is not null then
      msg_b := msg_b || '�� ������Ϊ��������Ϊ��;  ';
    end if;
    if msg_c is not null then
      msg_c := msg_c || '�� �����ʩ����Ϊ��;  ';
    end if;
    if msg_d is not null then
      msg_d := msg_d || '�� �ù�Ӧ����ϵͳ�в�����;  ';
    end if;
    if msg_e is not null then
      msg_e := msg_e || '�� �����ʩ����;  ';
    end if;
  
    if msg_f is not null then
      msg_f := msg_f || '�� ����ʱ��δ��ȷ��д;  ';
    end if;
    if msg_g is not null then
      msg_g := msg_g || '�� ����ʱ����δ��ȷ��д;  ';
    end if;
    if msg_h is not null then
      msg_h := msg_h || '�� ����ʱ����ʱ���ʽ����ȷ;  ';
    end if;
    if msg_i is not null then
      msg_i := msg_i || '�� ����ʱ��ֹʱ���ʽ����ȷ;  ';
    end if;
  
    p_msg := p_msg || msg_a || msg_b || msg_c || msg_d || msg_e || msg_f ||
             msg_g || msg_h || msg_i || msg_j || msg_l || msg_m || msg_n ||
             msg_o || msg_p || msg_q || msg_s;
    if p_msg is not null then
      return;
    end if;
  end;

  --���빩Ӧ�̲�����Ϊ��¼                           
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
      --����
      select spm_con_bad_action_seq.nextval into bad_id from dual;
      --��Ӧ������
      select v.vendor_id
        into vendor_id
        from spm_con_vendor_info v
       where v.vendor_name = validate_a;
      --�����ʩ
      if validate_c = 'ͨ������' then
        treat := 'TP';
      elsif validate_c = '������ȡ���ɹ�������ʸ�' then
        treat := 'YX';
      elsif validate_c = '������ȡ���ɹ�������ʸ�' then
        treat := 'WX';
      elsif validate_c = 'ֹͣ�ڱ�' then
        treat := 'TZ';
      end if;
    
      insert into spm_con_bad_action
        (ACTION_ID, --����
         asso_id, --���
         action_desc, --����
         treatment, --����ʽ
         treat_start_date, --��ʼʱ��
         treat_end_date, --����ʱ��
         ATTRIBUTE2, --�ļ���
         OWN_TYPE, --����2
         remark, --��ע
         treat_scope, --����Χ
         treat_basis) --��������
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

  --��Ӧ�̵���ǰ�������֤����
  procedure vendor_validata(p_tablename varchar2,
                            p_tableid   varchar2,
                            p_batchcode varchar2,
                            p_msg       out varchar2) is
    --��ϵ����Ϣ�α�                            
    cursor man_data is
      select trim(a), trim(b), trim(c)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '��ϵ����Ϣ'
       order by to_number(row_number);
    --�����˻���Ϣ�α�
    cursor account_data is
      select trim(a), trim(b), trim(c), trim(d), trim(e), trim(f)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '�����˻���Ϣ'
       order by to_number(row_number);
    --��Ӧ������Ϣ�α�
    cursor vendor_data is
      select trim(a), --����
             /* trim(b),*/
             trim(c) /*,--����
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
         and sheet_name = '��Ӧ������Ϣ'
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
  
    p_message1 varchar2(200); --������Ϣ����
    p_message2 varchar2(200); --������Ϣ����
  
  begin
    --��ʼ��֤��ϵ����Ϣ**********************************************************��
    open man_data;
    fetch man_data
      into validate_a, validate_b, validate_c; --��һ�θ�ֵ������
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    if man_data%found then
    
      if validate_a <> '��Ӧ��ͳһ������ô���' or validate_b <> '����' or
         validate_c <> '�ֻ�����' then
        p_msg := '��ϵ��ҳǩ�������ݵ��ֶ��������ϸ�ʽ';
        close man_data;
        return;
      end if;
      fetch man_data
        into validate_a, validate_b, validate_c; --�ڶ��θ�ֵ������ֵ
    
      while man_data%found loop
        --У�������
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
        --У�鹩Ӧ�̱����ϵͳ���Ƿ��Ѿ�����
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
          into validate_a, validate_b, validate_c; --�����θ�ֵ��ѭ��Ϊ���´�
      
      end loop;
      close man_data;
    end if;
    --��֤��ϵ����Ϣ����**********************************************************��
  
    --��ʼ��֤�����˻���Ϣ**********************************************************��
    open account_data;
    fetch account_data
      into validate_d,
           validate_e,
           validate_f,
           validate_g,
           validate_h,
           validate_i; --��һ�θ�ֵ������
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    if account_data%found then
    
      if validate_d <> '��Ӧ��ͳһ������ô���' or validate_e <> '�˻�' or
         validate_f <> '�˺�' or validate_g <> '��������' or validate_h <> '������' or
         validate_i <> '�˻�����' then
        p_message1 := '�����˻�ҳǩ�������ݵ��ֶ��������ϸ�ʽ';
        close account_data;
        return;
      end if;
      fetch account_data
        into validate_d,
             validate_e,
             validate_f,
             validate_g,
             validate_h,
             validate_i; --�ڶ��θ�ֵ������ֵ
    
      while account_data%found loop
        --У�������
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
        --У�鹩Ӧ�̱����ϵͳ���Ƿ��Ѿ�����
        if validate_d is not null then
          if is_had(validate_d) > 0 then
            if msg_k is null then
              msg_k := account_data%rowcount;
            else
              msg_k := msg_k || ',' || account_data%rowcount;
            end if;
          end if;
        end if;
        --У���˻������Ƿ���ȷ
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
               validate_i; --�����θ�ֵ��ѭ��Ϊ���´�
      
      end loop;
      close account_data;
    end if;
    --��֤��ϵ����Ϣ����**********************************************************��
  
    --��ʼ��֤��Ӧ������Ϣ**********************************************************��
    open vendor_data;
    fetch vendor_data
      into validate_name, validate_code; --��һ�θ�ֵ������
  
    --��֤�����ֶ�����ʽ�Ƿ���ȷ
    if vendor_data%found then
    
      fetch vendor_data
        into validate_name, validate_code; --�ڶ��θ�ֵ������ֵ
    
      while vendor_data%found loop
      
        --У�鹩Ӧ�̱����ϵͳ���Ƿ��Ѿ�����
        if validate_code is not null then
          if is_had(validate_code) > 0 then
            if msg_m is null then
              msg_m := vendor_data%rowcount;
            else
              msg_m := msg_m || ',' || vendor_data%rowcount;
            end if;
          end if;
        end if;
      
        --У�鹩Ӧ��������ϵͳ���Ƿ��Ѿ�����
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
          into validate_name, validate_code; --�����θ�ֵ��ѭ��Ϊ���´�
      
      end loop;
      close vendor_data;
    end if;
    --��֤��ϵ����Ϣ����**********************************************************
    if msg_a is not null then
      msg_a := msg_a || '�� ��ϵ��ҳǩ ��Ӧ��ͳһ������ô��벻��Ϊ��;  ';
    end if;
    if msg_b is not null then
      msg_b := msg_b || '�� ��ϵ��ҳǩ ��������Ϊ��;  ';
    end if;
    if msg_c is not null then
      msg_c := msg_c || '�� ��ϵ��ҳǩ �ֻ����벻��Ϊ��;  ';
    end if;
    if msg_d is not null then
      msg_d := msg_d || '�� ��ϵ��ҳǩ �ù�Ӧ�̱����ϵͳ���Ѿ�����;  ';
    end if;
    ----------------------------------------------------------
    if msg_e is not null then
      msg_e := msg_e || '�� �����˻�ҳǩ ��Ӧ��ͳһ������ô��벻��Ϊ��;  ';
    end if;
  
    if msg_f is not null then
      msg_f := msg_f || '�� �����˻�ҳǩ �˻�����Ϊ��;  ';
    end if;
    if msg_g is not null then
      msg_g := msg_g || '�� �����˻�ҳǩ �˺Ų���Ϊ��;  ';
    end if;
    if msg_h is not null then
      msg_h := msg_h || '��  �����˻�ҳǩ �������Ʋ���Ϊ��;  ';
    end if;
    if msg_i is not null then
      msg_i := msg_i || '�� �����˻�ҳǩ �����в���Ϊ��;  ';
    end if;
    if msg_j is not null then
      msg_j := msg_j || '�� �����˻�ҳǩ �˻����Ͳ���Ϊ��;  ';
    end if;
    if msg_k is not null then
      msg_k := msg_k || '�� �����˻�ҳǩ �ù�Ӧ�̱����ϵͳ���Ѿ�����;  ';
    end if;
    if msg_l is not null then
      msg_l := msg_l || '�� �����˻�ҳǩ �˻����Ͳ���ȷ;  ';
    end if;
    -------------------------------
    if msg_m is not null then
      msg_m := msg_m || '�� ��Ӧ������Ϣҳǩ �ù�Ӧ�̱����ϵͳ���Ѿ�����;  ';
    end if;
    if msg_n is not null then
      msg_n := msg_n || '�� ��Ӧ������Ϣҳǩ �ù�Ӧ��������ϵͳ���Ѿ�����;  ';
    end if;
    p_msg := p_msg || p_message1 || p_message2 || msg_a || msg_b || msg_c ||
             msg_d || msg_e || msg_f || msg_g || msg_h || msg_i || msg_j ||
             msg_l || msg_m || msg_n || msg_o || msg_p || msg_q || msg_s;
    if p_msg is not null then
      return;
    end if;
  end;

  --���빩Ӧ��                
  procedure vendor_import(p_tablename varchar2,
                          p_tableid   varchar2,
                          p_batchcode varchar2,
                          f_tablename varchar2,
                          f_tableid   varchar2,
                          p_msg       out varchar2) is
    --��ϵ����Ϣ                            
    cursor man_data is
      select trim(a), trim(b), trim(c)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '��ϵ����Ϣ'
         and to_number(row_number) >= 2
       order by to_number(row_number);
    --�����˻���Ϣ
    cursor account_data is
      select trim(a), trim(b), trim(c), trim(d), trim(e), trim(f)
        from spm_import_temp_d
       where temp_m_id = p_batchcode
         and sheet_name = '�����˻���Ϣ'
         and to_number(row_number) >= 2
       order by to_number(row_number);
    --��Ӧ������Ϣ
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
         and sheet_name = '��Ӧ������Ϣ'
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
    v_id        number; --��Ӧ������
    a_id        number;
    l_id        number;
    test_id     number;
    treat       varchar2(40);
  
  begin
    --��Ӧ������Ϣ���룻
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
         '����',
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
    --�����˻���Ϣ����
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
        (acount_id, --������Ϣ����
         vendor_id, --��Ӧ������
         bank_acount, --�˺�
         opening_bank, --������
         acount_type, --����
         acount_own_type, --����
         attribute2, --����
         attribute1) --�˻�
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
  
    --��ϵ����Ϣ����
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
  --��Ӧ���Ƿ�ͬ��ebs  �������ں�ͬ�½�ѡ��Ӧ��
  FUNCTION SPM_CON_VENDOR_TOEBS(VENDOR_IDR NUMBER) RETURN VARCHAR2 IS
    treatment  VARCHAR2(10); --����ʽ
    begaintime date; --������ʼʱ��
    endtime    date; --�������ʱ��
    num1       number; --��¼ebs���Ƿ����
    num2       number; --��¼�������
  
    cursor need_data is
      select b.treatment,
             b.treat_start_date as begaintime,
             b.treat_end_date   as endtime
        from spm_con_bad_action b
       where b.own_type = 2
         and b.asso_id = VENDOR_IDR;
  
  BEGIN
    num2 := 0; --�ʼ�ı�� �Ƿ�ɹ�
  
    select count(v.VENDOR_ID)
      into num1
      from PO_VENDORS v
     where v.SEGMENT1 = (select ven.vendor_code
                           from spm_con_vendor_info ven
                          where ven.vendor_id = VENDOR_IDR);
  
    if num1 = 0 --���δͬ�� ֱ�ӷ���N
     then
      RETURN 'N';
    end if;
    --�Ż���ʼ
    open need_data;
    --������ȸ�ֵһ�飬������Ӧ�Ĳ�������ѭ��������ʱ���ٴθ�ֵ��ѭ������
    fetch need_data
      into treatment, begaintime, endtime;
    while need_data%found loop
    
      if treatment = 'WX' then
        --������ֹͣ
        if sysdate >= begaintime then
          num2 := num2 + 1;
        end if;
      elsif (treatment = 'YX' or treatment = 'TZ') then
        --������ֹͣ
        if (sysdate >= begaintime and sysdate <= endtime) --�������ڣ�˵���ڽ�����
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
  
    --�Ż�����
  
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 'N';
  END SPM_CON_VENDOR_TOEBS;

  --��ѯ���̹����Ĺ�Ӧ��״̬
  function query_vendor_status(v_id varchar2, v_org_id varchar2)
    return varchar2 is
    return_message varchar2(200); --���ص���Ϣ
    is_had         number; --�Ƿ����
    v_name         varchar2(200); --��Ӧ������
    v_code         varchar2(200); --��Ӧ�̱��
    v_status       varchar2(20); --ҵ���״̬
  begin
    select count(*)
      into is_had
      from spm_con_mq_vendor v
     where (v.operation = 'insert' or v.operation = 'update')
       and v.id = v_id;
    if is_had = 0 then
      return '-1'; --�м������
    else
    
      select v.business_license_no
        into v_code
        from spm_con_mq_vendor v
       where (v.operation = 'insert' or v.operation = 'update')
         and v.mq_id =
             (select max(t.mq_id) from spm_con_mq_vendor t where t.id = v_id); --�м����ڣ��������ֺͱ��
    
      select count(*)
        into is_had
        from spm_con_vendor_info v
       where v.vendor_code = v_code; --ҵ����Ƿ����
    
      if is_had = 0 then
        return '-2'; --�м����ڣ���δ��ҵ���
      else
        select v.status
          into v_status
          from spm_con_vendor_info v
         where v.vendor_code = v_code; --��ѯ����״̬
      
        if v_status <> 'E' then
          return '-3'; --ҵ�����ڣ����δ���
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
            return '-4'; --�����ɣ�δͬ������Ӧ��֯��EBS
          else
            select v.vendor_id
              into return_message
              from spm_con_vendor_info v
             where v.vendor_code = v_code;
          
            return return_message; --�����������
          end if;
        
        end if;
      end if;
    end if;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN '-5';
  end;

  function query_vendor_status_by_code(v_codes varchar2) return varchar2 is
    return_message varchar2(200); --���ص���Ϣ
    is_had         number; --�Ƿ����
    v_name         varchar2(200); --��Ӧ������
    v_code         varchar2(200); --��Ӧ�̱��
    v_status       varchar2(20); --ҵ���״̬
  begin
    select count(*)
      into is_had
      from spm_con_mq_vendor v
     where (v.operation = 'insert' or v.operation = 'update')
       and v.business_license_no = v_codes;
    if is_had = 0 then
      return '-1'; --�м������
    else
      select distinct v.business_license_no
        into v_code
        from spm_con_mq_vendor v
       where (v.operation = 'insert' or v.operation = 'update')
         and v.business_license_no = v_codes; --�м����ڣ��������ֺͱ��
    
      select count(*)
        into is_had
        from spm_con_vendor_info v
       where v.vendor_code = v_code; --ҵ����Ƿ����
    
      if is_had = 0 then
        return '-2'; --�м����ڣ���δ��ҵ���
      else
        select v.status
          into v_status
          from spm_con_vendor_info v
         where v.vendor_code = v_code; --��ѯ����״̬
      
        if v_status <> 'E' then
          return '-3'; --ҵ�����ڣ����δ���
        else
        
          select count(*)
            into is_had
            from po_vendors t
           where t.SEGMENT1 = v_code;
          if is_had = 0 then
            return '-4'; --�����ɣ�δͬ����EBS
          else
            select v.vendor_id
              into return_message
              from spm_con_vendor_info v
             where v.vendor_code = v_code;
          
            return return_message; --�����������
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

  --����֪ͨ������֪ͨ���ɻص�
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
  --����֪ͨ������֪ͨ����(��)�ص�
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

  --����֪ͨ����˹�����HTML��Ϣչ��
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
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_DE_GOODS_INFO;

  --����֪ͨ����ϸ����֮ǰУ���ͬ�����ʣ������

  function get_surplus_number(de_id number, paras varchar2) return varchar2 is
    ht_id            number;
    deliver_child_id number;
    one_paras        SPM_TYPE_TBL;
    code             varchar2(400);
    nnumber          number; --��������
    bnumber          number; --ʣ���������
    htnumber         number; --������
    usenumber        number; --ʹ������
    return_msg       varchar2(2000);
  begin
    --��ȡ��ͬ�����ĺ�ͬ����
    select g.contract_id
      into ht_id
      from spm_con_deliver_goods g
     where g.deliver_goods_id = de_id;
  
    --�ָ����
    SELECT SPM_EAM_COMMON_PKG.SPLIT_STRING(paras) INTO one_paras FROM DUAL;
  
    --����ѭ��
    FOR I IN 1 .. one_paras.COUNT LOOP
      --�������ӱ�����
      select substr(one_paras(I), 0, instr(one_paras(I), '#', 1, 1) - 1)
        into deliver_child_id
        from dual;
      --���ϱ���
      select substr(one_paras(I),
                    instr(one_paras(I), '#', 1, 1) + 1,
                    instr(one_paras(I), '#', 1, 2) -
                    instr(one_paras(I), '#', 1, 1) - 1)
        into code
        from dual;
      --��������
      select substr(one_paras(I),
                    instr(one_paras(I), '#', 1, 2) + 1,
                    length(one_paras(I)) - instr(one_paras(I), '#', 1, 2))
        into nnumber
        from dual;
      --��ȡ������
      select t.target_count
        into htnumber
        from spm_con_ht_target t
       where t.contract_id = ht_id
         and t.material_code = code;
      --��ȡ�Ѿ�ʹ�õ�����
      if deliver_child_id = -1 then
        --������
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
        --�޸ĵ�
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
        return_msg := return_msg || '���ϱ���Ϊ:' || code ||
                      ' ������ʣ��δ�����������㣬��˶Ժ�����¼�룡<br/>';
      end if;
    
    end loop;
    return return_msg;
  
  end get_surplus_number;

  --���ݲ���id��ȡ��Ӧ�Ĵ�������
  function get_big_dept_name_by_deptid(deptid number) return varchar2
  
   is
    name varchar2(200);
  begin
    select nvl((SPM_CON_UTIL_PKG.GET_FLEX_NAME_BY_VALUE(t.attribute6,
                                                        'DT ����')),
               (select m.name
                  from HR_OPERATING_UNITS m
                 where m.short_code = t.attribute6))
      into name
      from HR.HR_ALL_ORGANIZATION_UNITS t
     where t.organization_id = deptid;
    return name;
  end get_big_dept_name_by_deptid;

  /**
  *   ��ѯӦ����Ʊ�Ѿ�������,��EBS����Ϊ׼
  *    P_INVOICE_ID ��ͬ�෢ƱID
  *    ���ܴ��ڷ�Ʊ�����ظ����µķ�Ʊ��׼��
  */
  FUNCTION MEW_GET_APINVOICE_PAYMENT(P_INVOICE_ID NUMBER) RETURN NUMBER IS
    V_INVOICE_AMOUNT           NUMBER;
    V_PAYMENT_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT           NUMBER;
    V_PREPAID_AMOUNT1          NUMBER;
    V_INVOICE_TYPE_LOOKUP_CODE VARCHAR2(30);
    V_FLAG                     VARCHAR2(10);
  
  BEGIN
    --1��Ʊ����Ʊ����
    BEGIN
      SELECT AIA.INVOICE_AMOUNT, AIA.INVOICE_TYPE_LOOKUP_CODE
        INTO V_INVOICE_AMOUNT, V_INVOICE_TYPE_LOOKUP_CODE
        FROM AP_INVOICES_ALL AIA, SPM_CON_INPUT_INVOICE II
       WHERE AIA.INVOICE_NUM = II.INVOICE_CODE
         AND II.INPUT_INVOICE_ID = P_INVOICE_ID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        --������ֲ�ѯ������������������δͬ����EBS��
        RETURN 0;
    END;
    --2.�����Ʊ����ΪԤ�����ֱ��ȥ��Ʊ���
    IF V_INVOICE_TYPE_LOOKUP_CODE = 'PREPAYMENT' THEN
    
      RETURN V_INVOICE_AMOUNT;
    
    ELSE
      --�����Ʊ����Ϊ��׼������Ҫȡ����������+����Ԥ������
      --2.1����������
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
    
      --2.2����Ԥ������
      --��ͨ��Ʊ����Ԥ���Ʊ�Ľ��
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
    --�жϺ�ͬ�Ƿ��������
    --������uuidӦ���Ƕ�����ͬ   
    --uuidΪһ��δ���������
    --�������������
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
      --ֻ�����ڵģ������ĺ�ͬ����֮ǰ�Ĵ�ŷ���N��
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

  --ӡ��˰����ƾ֤
  PROCEDURE SPM_STAMP_TAX_CREATE_CERT(V_MAIN_ID        IN NUMBER,
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
    STAMP_TAX           SPM_CON_STAMP_TAX%ROWTYPE;
  
    CURSOR CUR_1(P_MAIN_ID NUMBER) IS
      select d.hs_dept_id, sum(d.tax_amount) tax_amount
        from spm_con_stamp_tax_detail d
       where d.stamp_tax_id = P_MAIN_ID
       group by d.hs_dept_id;
    REC_1 CUR_1%ROWTYPE;
  
    r_year  varchar2(40); --��
    r_month varchar2(40); --��
  
  BEGIN
    --������Ϣ
    select *
      INTO STAMP_TAX
      from spm_con_stamp_tax t
     where t.stamp_tax_id = V_MAIN_ID;
    --У��ӡ��˰���
    if STAMP_TAX.Tax_Amount <= 0 then
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '��ǰ����Ӧ����ӡ��˰С�ڵ���0';
      return;
    end if;
    --У���Ƿ��Ѿ�
    if STAMP_TAX.Gl_Date is not null then
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '��ǰ����������ƾ֤';
      return;
    end if;
  
    --���ҵ���ɹ��ļ�¼����Ҫ����������
    SELECT COUNT(CD.GL_DATA_ID)
      INTO T_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       and cd.JE_HEADER_NAME = 'ӡ��˰'
       AND CD.DATA_STATUS = 'IMPORT';
  
    --ֱ�ӷ���
    IF T_DATA_ID <> 0 THEN
      --˵���Ѿ������
      V_RETURN_CODE    := 'N';
      V_RETURN_MESSAGE := '��ǰ�����Ѿ�����ƾ֤';
      DBMS_OUTPUT.PUT_LINE(V_RETURN_MESSAGE);
      RETURN;
    END IF;
  
    --���ҵ������ļ�¼����Ҫ����������
    SELECT COUNT(CD.GL_DATA_ID)
      INTO FAIL_DATA_ID
      FROM CUX_GL_INTERFACE_DATA CD
     WHERE 1 = 1
       AND CD.OBJECT_VERSION_NUMBER = V_MAIN_ID
       and cd.JE_HEADER_NAME = 'ӡ��˰'
       AND CD.DATA_STATUS <> 'IMPORT';
  
    IF FAIL_DATA_ID <> 0 THEN
      --˵���д����������м��
      DELETE FROM CUX_GL_INTERFACE_DATA CD
       WHERE CD.OBJECT_VERSION_NUMBER = V_MAIN_ID;
    END IF;
  
    T_NUMLINE := 0;
    BEGIN
      --��ʼѭ��
      --��ȡ������      
      CREATEDBYNAME := SPM_EAM_COMMON_PKG.GET_FULLNAME_BY_USERID(STAMP_TAX.Created_By);
      --��ȡ��˾�� 
      SELECT OU.SHORT_CODE
        INTO T_ORG_CODE
        FROM HR_OPERATING_UNITS OU
       WHERE OU.ORGANIZATION_ID = STAMP_TAX.Org_Id;
    
      -- ��ȡϵͳʱ��
      SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') INTO T_SYSDATE FROM DUAL;
      SELECT TO_CHAR(SYSDATE, 'YYYYMM') INTO V_PERIODNAME FROM DUAL;
      OPEN CUR_1(V_MAIN_ID);
      LOOP
      
        FETCH CUR_1
          INTO REC_1;
        EXIT WHEN CUR_1%NOTFOUND;
      
        -- ��ȡ����ͷ��Ϣ����������id
        SELECT CUX_GL_INTERFACE_DATA_S.NEXTVAL INTO T_HEADERS_ID FROM DUAL;
      
        T_NUMLINE := T_NUMLINE + 1;
      
        V_JE_NAME := T_ORG_CODE || STAMP_TAX.Tax_Year ||
                     STAMP_TAX.Tax_Month || 'ӡ��˰' || V_MAIN_ID;
        IF REC_1.tax_amount <> 0 THEN
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
             LAST_UPDATE_DATE, --�޸�����
             LAST_UPDATED_BY, --�޸���
             LAST_UPDATE_LOGIN, --��¼��id
             CREATION_DATE, --��������
             CREATED_BY) --������
          VALUES
            (T_HEADERS_ID, ----���� ����֮ǰ��ϵͳ����
             'SPMϵͳ',
             V_JE_NAME, -- ������  ������codeΨһ�ı�ʶ?????
             STAMP_TAX.Tax_Year || '��' || STAMP_TAX.Tax_Month || '��' ||
             'ӡ��˰', --����   
             'ӡ��˰', --д��
             '����' || STAMP_TAX.Tax_Code || 'ӡ��˰', --ûɶ�ú���  
             sysdate, -- �������ڡ�ȡĬ��ʱ�䣬����Ҫ����ġ�
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '����' || STAMP_TAX.Tax_Code || 'ӡ��˰', --ժҪ
             REC_1.tax_amount, --�跽���
             0, --�������
             'NEW',
             V_MAIN_ID,
             sysdate, -- �������ڡ�ȡĬ��ʱ�䣬����Ҫ����ġ�
             '�û�',
             '�˹�',
             '����',
             V_PERIODNAME, --�ڼ䡾ȡĬ��ʱ�䣬����Ҫ����ġ�
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
             'SPMϵͳ',
             V_JE_NAME, -- ������
             STAMP_TAX.Tax_Year || '��' || STAMP_TAX.Tax_Month || '��' ||
             'ӡ��˰', --����   
             'ӡ��˰', --
             '����' || STAMP_TAX.Tax_Code || 'ӡ��˰', --ûɶ�ú���  
             sysdate, -- �������ڡ�ȡĬ��ʱ�䣬����Ҫ����ġ�
             'CNY',
             T_NUMLINE,
             CREATEDBYNAME || '����' || STAMP_TAX.Tax_Code || 'ӡ��˰', --ժҪ
             0, --�跽���
             REC_1.TAX_AMOUNT, --�������                      
             'NEW',
             V_MAIN_ID,
             sysdate, -- ��������
             '�û�',
             '�˹�',
             '����',
             V_PERIODNAME, --�ڼ�
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
                           P_DATA_SOURCE   => 'SPMϵͳ',
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
         and cd.JE_HEADER_NAME = 'ӡ��˰';
    END IF;
  
    DBMS_OUTPUT.PUT_LINE(T_RETURN_CODE);
    DBMS_OUTPUT.PUT_LINE(T_RETURN_MESSAGE);
    V_RETURN_CODE    := T_RETURN_CODE;
    V_RETURN_MESSAGE := T_RETURN_MESSAGE;
  
  END SPM_STAMP_TAX_CREATE_CERT;

  --��������������֪ͨ���ɻص�
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
  --��������������֪ͨ����(��)�ص�
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

  --������������˹�����HTML��Ϣչ��
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
           '''>�鿴����</a><br>';
    RETURN MSG;
  EXCEPTION
    WHEN OTHERS THEN
      MSG := '��������';
      RETURN MSG;
    
  END SPM_CON_SP_MATTER_INFO;

  PROCEDURE SPM_CON_SP_MATTER_SPTG(P_ITMEKEY   IN VARCHAR2,
                                   P_OTYPECODE IN VARCHAR2) AS
    V_SP_ID      NUMBER; --����
    V_SP_TYPE    VARCHAR2(40); --ҵ������
    V_SP_USER_ID NUMBER; --������
    V_SP_CODE    VARCHAR2(200); --ҵ�񵥾ݱ���
    V_RE_MSG     VARCHAR2(4000);
    V_TITLE      VARCHAR2(200);
    V_ONECODE     VARCHAR2(200);
    --���ļ��ܸ�ʽ  ҵ������ + ������ + ����ʱ�� + ���ݱ��� ��MD5����
  
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
      V_TITLE := '������ĵ�������ǩ���Ѿ�����ͨ��!<br>  ����ױ�Ŷ�Ӧ����������:<br>  ';
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
                                               '���������������ķ���' || V_ONECODE || '��',
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
