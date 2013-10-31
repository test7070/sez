<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title> </title>
    <script src="../script/jquery.min.js" type="text/javascript"> </script>
    <script src='../script/qj2.js' type="text/javascript"> </script>
        <script src='qset.js' type="text/javascript"> </script>
    <script src='../script/qj_mess.js' type="text/javascript"> </script>
    <script src="../script/qbox.js" type="text/javascript"> </script>
    <script src='../script/mask.js' type="text/javascript"> </script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "labase";
        var q_readonly = ['txtWorker','txtWorker2'];
        var q_readonlys = [];
        var bbmNum = [['txtSalary', 15, 0, 1],['txtSa_retire', 15, 0, 1],['txtRe_comp', 15, 0, 1],['txtRe_person', 15, 0, 1],['txtSa_labor', 15, 0, 1],['txtAs_labor', 15, 0, 1],['txtLa_person', 15, 0, 1],['txtLa_comp', 15, 0, 1],['txtSa_health', 15, 0, 1],['txtAs_health', 15, 0, 1],['txtHe_person', 15, 0, 1],['txtHe_comp', 15, 0, 1],['txtTax', 15, 0, 1],['txtMount', 15, 0, 1],['txtDisaster', 15, 0, 1],['txtPlus2', 15, 0, 1]];  
        var bbsNum = [['txtCh_money', 15, 0, 1],['txtAs_health', 15, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];

        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
         aPop = new Array(['txtNoa', 'lblNoa', 'sssall', 'noa,namea', 'txtNoa,txtNamea,txtBdate', 'sssall_b.aspx'],
         ['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']);
         //aPop = new Array(['txtNoa', 'lblNoa', 'sss', 'noa,namea', 'txtNoa,txtNamea,txtBdate', 'sssall_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            
            q_brwCount();   

            q_gt(q_name, q_content, q_sqlCount, 1)  

        });

        //////////////////   end Ready
        function main() {
            if (dataErr) 
            {
                dataErr = false;
                return;
            }

            mainForm(0); 
        }  
		var t_la_person=0,t_he_person=0,z_he_person=0;
		var cal=false;//判斷計算各自投保金額
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtBdate', r_picd]];
            q_mask(bbmMask);
            bbsMask = [['txtBirthday', r_picd],['txtIndate', r_picd],['txtOutdate', r_picd]];
            q_mask(bbsMask);

             $('#btnSalinsures').click(function (e) {
		            q_box("salinsures_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'salinsures', "95%", "95%", q_getMsg("popSalinsures"));
		        });
             $('#btnLabased').click(function (e) {
		            q_box("labased.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labased', "80%", "95%", q_getMsg("popLabased"));
		        });
		     $('#btnUmmb').click(function () {
		            if ($('#txtNoa').val().length > 0)
		                q_func('labase.gen', r_accy + ',' + $('#txtNoa').val());
		        });
            $('#txtNoa').change(function () {
            	 if(!emp($('#txtNoa').val())){
            	 	//取得健勞保退保日期
	            	var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^ top=1";
	            	q_gt('labased', t_where, 0, 0, 0, "", r_accy);
            	 		//判斷員工是否是外勞
			           var t_where = "where=^^ noa ='"+$('#txtNoa').val()+"' ^^";
			           q_gt('sss', t_where , 0, 0, 0, "", r_accy);
			           
			           //判斷員工家屬
			           var t_where = "where=^^noa='"+$('#txtNoa').val()+"'^^";
            			q_gt('labases_sum', t_where, 0, 0, 0, "", r_accy);
            			
			           $('#txtInsur_fund').val(0.025);
			     	if(q_getPara('sys.comp').indexOf('大昌')>-1){
			     		if($('#txtNoa').val().substr(0,1)=='G'){
			     			$('#chkIssssp')[0].checked=true;
			     		}else{
			     			$('#chkIssssp')[0].checked=false;
			     		}
			     	}
			     }
            });
            
            $('#txtBdate').blur(function () {
            	if(emp($('#txtNoa').val())){
            		alert('請先輸入員工編號!!!');
            		q_tr('txtSalary',0);
            		$('#txtNoa').focus();
            		return;
            	}
            	if(emp($('#txtSalary').val())||dec($('#txtSalary').val())==0){
            		return;
            	}
            	
            	//取得勞退薪資等級表
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labretire', t_where, 0, 0, 0, "", r_accy);
            	//取得勞保薪資等級表
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
            	if(q_cur!=1)
            		sum();//計算家屬
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
            });
            
            $('#txtSalary').change(function () {
            	if(emp($('#txtNoa').val())){
            		alert('請先輸入員工編號!!!');
            		q_tr('txtSalary',0);
            		$('#txtNoa').focus();
            		return;
            	}
            	if(emp($('#txtSalary').val())||dec($('#txtSalary').val())==0){
            		return;
            	}
            	
            	//取得勞退薪資等級表
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labretire', t_where, 0, 0, 0, "", r_accy);
            	//取得勞保薪資等級表
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
            	if(q_cur!=1)
            		sum();//計算家屬
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
            });
            
            $('#txtMount').change(function () {
            	//取得健保薪資等級表
            	//sum();//計算家屬
            	var t_where = "where=^^ 1=1 ^^ top=1";
            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
            });
            
			
			$('#txtAs_labor').change(function () {
            	$('#txtLa_person').val(t_la_person-dec($('#txtAs_labor').val()));
            });
			$('#txtAs_health').change(function () {
            	$('#txtHe_person').val(t_he_person-dec($('#txtAs_health').val()));
            });
            
            $('#txtInsur_fund').change(function () {
	            	if(emp($('#txtSalary').val())||dec($('#txtSalary').val())==0){
	            		return;
	            	}
	            	//重新計算取得勞保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
	          });
	            
	          $('#txtInsur_disaster').change(function () {
	            	if(emp($('#txtSalary').val())||dec($('#txtSalary').val())==0){
	            		return;
	            	}
	            	//重新計算取得勞保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	          		q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
	          });
	          //---------------------各自判斷投保新增----------------------
	          $('#txtSa_retire').change(function () {
	            	if(emp($('#txtSa_retire').val())||dec($('#txtSa_retire').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	//取得勞退薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labretire', t_where, 0, 0, 0, "", r_accy);
	          });
	          $('#lblSa_retire').click(function () {
	            	if(emp($('#txtSa_retire').val())||dec($('#txtSa_retire').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	//取得勞退薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labretire', t_where, 0, 0, 0, "", r_accy);
	          });
	          
	          $('#txtSa_labor').change(function () {
	            	if(emp($('#txtSa_labor').val())||dec($('#txtSa_labor').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	//重新計算取得勞保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	          		q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
	          });
	          $('#lblSa_labor').click(function () {
	            	if(emp($('#txtSa_labor').val())||dec($('#txtSa_labor').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	//重新計算取得勞保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	          		q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
	          });
	          $('#txtSa_health').change(function () {
	            	if(emp($('#txtSa_health').val())||dec($('#txtSa_health').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	sum();//計算家屬
	            	//取得健保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
	          });
	          $('#lblSa_health').click(function () {
	            	if(emp($('#txtSa_health').val())||dec($('#txtSa_health').val())==0){
	            		return;
	            	}
	            	cal=true;
	            	sum();//計算家屬
	            	//取得健保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
	          });
            //----------------------------------------
                $('#chkIssssp').hide();
            	$('#lblIssssp').hide();
            	$('#lblCustno').hide();
            	$('#txtCustno').hide();
            	$('#txtComp').hide();
            	
            if(q_getPara('sys.comp').indexOf('大昌')>-1){ 
            	$('#chkIssssp').show();
            	$('#lblIssssp').show();
            	$('#lblCustno').show();
            	$('#txtCustno').show();
            	$('#txtComp').show();

	            $('#chkIssssp').change(function () {
	            	if($('#chkIssssp')[0].checked){//寄保人員
	            		$('#txtInsur_fund').val(0.025);
	            	}else{//一般員工
	            		$('#txtInsur_fund').val(0.025);
	            	}
	            	
	            	if(emp($('#txtSalary').val())||dec($('#txtSalary').val())==0){
	            		return;
	            	}
	            	//重新計算取得勞保薪資等級表
	            	var t_where = "where=^^ 1=1 ^^ top=1";
	            	q_gt('labsal', t_where, 0, 0, 0, "", r_accy);
	            });
	            
	            //計算職災
	            $('#lblDisaster').click(function () {
	            	if(q_cur==1||q_cur==2){
		            	q_tr('txtDisaster',Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_fund').val())/100)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_disaster').val())/100));
		            	q_tr('txtSa_labor',0);
		            	q_tr('txtAs_labor',0);
		            	q_tr('txtLa_person',0);
		            	q_tr('txtLa_comp',0);
	            	}
	            });
			}
        }

        function q_boxClose(s2) { 
            var ret;
            if(s2[0]=='sss'){
            	if(q_getPara('sys.comp').indexOf('大昌')>-1){
				  	if($('#txtNoa').val().substr(0,1)=='G'){
				   		$('#chkIssssp')[0].checked=true;
				   	}else{
				   		$('#chkIssssp')[0].checked=false;
					}
				}
            }
            
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var labases_sum;
		var health_bdate='',health_edate='',labor1_bdate='',labor1_edate='',labor2_bdate='',labor2_edate='';
		var insur_disaster=0.13;
        function q_gtPost(t_name) {
            switch (t_name) {
            	case 'labased':
            		var as = _q_appendData("labased", "", true);
            		if(as[0]!=undefined){
            			health_bdate=as[0].health_bdate;
            			health_edate=as[0].health_edate;
            			labor1_bdate=as[0].labor_bdate;
            			labor1_edate=as[0].labor_edate;
            			labor2_bdate=as[0].retire_bdate;
            			labor2_edate=as[0].retire_edate;
            			
            			//取得健勞保退保日期
	            		var t_where = "where=^^ a.noa='"+$('#txtNoa').val()+"' ^^ top=1";
	            		q_gt('labase_insur', t_where, 0, 0, 0, "", r_accy);
            		}
            	break;
            	case 'labase_insur':
            		var as = _q_appendData("acomp", "", true);
            		if(as[0]!=undefined){
						insur_disaster=as[0].insur_disaster;
            			$('#txtInsur_disaster').val(insur_disaster);
            		}
            	break;
            	case 'labases_sum':
            		labases_sum = _q_appendData("labases", "", true);
            		if(labases_sum[0]!=undefined){
            			$('#txtMount').val(labases_sum[0].total);
            		}else{
            			$('#txtMount').val(0);
            		}
            	break;
            	case 'sss':
            		var as = _q_appendData("sss", "", true);
            		if(as[0]!=undefined){
            			if(as[0].person=='外勞')
            				$('#chkIsforeign')[0].checked=true;
            			else
            				$('#chkIsforeign')[0].checked=false;	
            		}
            	break;
            	case 'carowner':
            		var as = _q_appendData("carowner", "", true);
            		if(as[0]!=undefined){
            			alert('車主的車子有異動，請與監理部核對資料!!!');
            		}
            	break;
            	case 'labretire':
            		var as = _q_appendData("labretire", "", true);
            			if(as[0]!=undefined){
            				var labretires = _q_appendData("labretires", "", true);
            				if(!cal){//正常薪資各自投保金額
            					for (var i = 0; i < labretires.length; i++) {
	            					if(dec(labretires[i].salary1)<=dec($('#txtSalary').val())&&dec(labretires[i].salary2)>=dec($('#txtSalary').val())){
	            						q_tr('txtSa_retire',labretires[i].pmoney);//勞退提繳金額
	            						if(q_getPara('sys.comp').indexOf('大昌')>-1&&$('#chkIssssp')[0].checked){//寄保
	            							if(labor2_edate!=''){//退保
            									_tr('txtRe_person',0);//個人提繳
            								}else{
	            								q_tr('txtRe_person',labretires[i].pcomp);//個人提繳
	            							}
	            						}else{//一般員工
	            							if(labor2_edate!=''){//退保
	            								q_tr('txtRe_comp',0);//勞保公司提繳
	            							}else{
	            								q_tr('txtRe_comp',labretires[i].pcomp);//勞保公司提繳
	            							}
	            						}
	            						break;	
	            					}
	            				}
            				}else{//各自設定投保金額
            					for (var i = 0; i < labretires.length; i++) {
	            					if(dec(labretires[i].salary1)<=dec($('#txtSa_retire').val())&&dec(labretires[i].salary2)>=dec($('#txtSa_retire').val())){
	            						//q_tr('txtSa_retire',labretires[i].pmoney);//勞退提繳金額
	            						if(q_getPara('sys.comp').indexOf('大昌')>-1&&$('#chkIssssp')[0].checked){//寄保
	            							if(labor2_edate!=''){//退保
            									q_tr('txtRe_person',0);//個人提繳
            								}else{
	            								q_tr('txtRe_person',labretires[i].pcomp);//個人提繳
	            							}
	            						}else{//一般員工
	            							if(labor2_edate!=''){//退保
	            								q_tr('txtRe_comp',0);//勞保公司提繳
	            							}else{
	            								q_tr('txtRe_comp',labretires[i].pcomp);//勞保公司提繳
	            							}
	            						}
	            						break;	
	            					}
	            				}
            				}
            			}
            		break;
            	case 'labsal':
            			var as = _q_appendData("labsal", "", true);
            			if(as[0]!=undefined){
            				var labsals = _q_appendData("labsals", "", true);
            				if(!cal){//正常薪資各自投保金額
            					for (var i = 0; i < labsals.length; i++) {
	            					if(dec(labsals[i].salary1)<=dec($('#txtSalary').val())&&dec(labsals[i].salary2)>=dec($('#txtSalary').val())){
	            						q_tr('txtSa_labor',labsals[i].lmoney);//勞保薪資
	            						if($('#chkIsforeign')[0].checked){//外勞
	            							q_tr('txtLa_person',labsals[i].flself);//勞保自付額
	            							t_la_person=dec(labsals[i].flself);
	            							q_tr('txtLa_comp',labsals[i].flcomp);//勞保公司負擔
	            						}else{
		            							//--------大昌工資墊償基金提繳費與勞保職災一般員工由公司負擔，寄保人員自己負擔-------
		            							if($('#chkIssssp')[0].checked){//寄保人員
		            								if(labor1_edate!=''){//退保
		            									q_tr('txtLa_person',0);
		            								}else{//還在加保
		            									q_tr('txtLa_person',dec(labsals[i].lself)+dec(labsals[i].lcomp)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_fund').val())/100)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_disaster').val())/100));
		            								}
		            								t_la_person=dec($('#txtLa_person').val());
		            								q_tr('txtLa_comp',0);
		            							}else{//一般員工
		            								if(labor1_edate!=''){//退保
		            									q_tr('txtLa_person',0);
			            								t_la_person=0;
			            								q_tr('txtLa_comp',0);
		            								}else{//還在加保
			            								q_tr('txtLa_person',labsals[i].lself);
			            								t_la_person=dec(labsals[i].lself);
			            								q_tr('txtLa_comp',dec(labsals[i].lcomp)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_fund').val())/100)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_disaster').val())/100));
		            								}
		            							}
	            						}
	            						break;	
	            					}
	            				}
            				}else{//各自設定投保金額
            					for (var i = 0; i < labsals.length; i++) {
	            					if(dec(labsals[i].salary1)<=dec($('#txtSa_labor').val())&&dec(labsals[i].salary2)>=dec($('#txtSa_labor').val())){
	            						//q_tr('txtSa_labor',labsals[i].lmoney);//勞保薪資
	            						if($('#chkIsforeign')[0].checked){
	            							q_tr('txtLa_person',labsals[i].flself);//勞保自付額
	            							t_la_person=dec(labsals[i].flself);
	            							q_tr('txtLa_comp',labsals[i].flcomp);//勞保公司負擔
	            						}else{
		            							//--------大昌工資墊償基金提繳費與勞保職災一般員工由公司負擔，寄保人員自己負擔-------
		            							if($('#chkIssssp')[0].checked){//寄保人員
		            								if(labor1_edate!=''){//退保
		            									q_tr('txtLa_person',0);
		            								}else{//還在加保
		            									q_tr('txtLa_person',dec(labsals[i].lself)+dec(labsals[i].lcomp)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_fund').val())/100)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_disaster').val())/100));
		            								}
		            								t_la_person=dec($('#txtLa_person').val());
		            								q_tr('txtLa_comp',0);
		            								
		            							}else{//一般員工
		            								if(labor1_edate!=''){//退保
		            										q_tr('txtLa_person',0);
			            									t_la_person=0;
			            									q_tr('txtLa_comp',0);
		            								}else{//還在加保
			            								q_tr('txtLa_person',labsals[i].lself);
			            								t_la_person=dec(labsals[i].lself);
			            								q_tr('txtLa_comp',dec(labsals[i].lcomp)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_fund').val())/100)+Math.round(dec($('#txtSalary').val())*dec($('#txtInsur_disaster').val())/100));
		            								}
		            							}
	            							}
	            						break;	
	            					}
	            				}
            				}
            			}
            		break;
            		case 'labhealth':
            			var as = _q_appendData("labhealth", "", true);
            			if(as[0]!=undefined){
            				var labhealths = _q_appendData("labhealths", "", true);
            				if(!cal){//正常薪資各自投保金額
            					for (var i = 0; i < labhealths.length; i++) {
	            					if(dec(labhealths[i].salary1)<=dec($('#txtSalary').val())&&dec(labhealths[i].salary2)>=dec($('#txtSalary').val())){
	            						q_tr('txtSa_health',labhealths[i].lmoney);//健保薪資
	            						if(health_edate!=''&&q_date().substr(0,6)>=health_edate.substr(0,6))
	            						{
	            							q_tr('txtHe_person',0);//健保自付額
		            						t_he_person=0;
		            						z_he_person=0;
		            						q_tr('txtHe_comp',0);//健保公司負擔
	            						}else{
		            						if(dec($('#txtMount').val())>3){
		            							q_tr('txtHe_person',dec(labhealths[i].he_person)*(1+3));//健保自付額
		            							t_he_person=dec(labhealths[i].he_person)*(1+3);
		            						}else{
		            							q_tr('txtHe_person',dec(labhealths[i].he_person)*(1+dec($('#txtMount').val())));
		            							t_he_person=dec(labhealths[i].he_person)*(1+dec($('#txtMount').val()));
		            						}
		            						z_he_person=labhealths[i].he_person;
		            						q_tr('txtHe_comp',labhealths[i].he_comp);//健保公司負擔
		            						
		            						if(q_getPara('sys.comp').indexOf('大昌')>-1&&$('#chkIssssp')[0].checked){
		            							q_tr('txtHe_person',q_float('txtHe_person')+q_float('txtHe_comp'));//健保自付額
		            							t_he_person=q_float('txtHe_person');
		            							q_tr('txtHe_comp',0);//健保公司負擔
		            						}
	            						}
	            						break;	
	            					}
	            				}
            				}else{//各自設定投保金額
            					for (var i = 0; i < labhealths.length; i++) {
	            					if(dec(labhealths[i].salary1)<=dec($('#txtSa_health').val())&&dec(labhealths[i].salary2)>=dec($('#txtSa_health').val())){
	            						//q_tr('txtSa_health',labhealths[i].lmoney);//健保薪資
	            						if(health_edate!=''&&q_date().substr(0,6)>=health_edate.substr(0,6))
	            						{
	            							q_tr('txtHe_person',0);//健保自付額
		            						t_he_person=0;
		            						z_he_person=0;
		            						q_tr('txtHe_comp',0);//健保公司負擔
	            						}else{
		            						if(dec($('#txtMount').val())>3){
		            							q_tr('txtHe_person',dec(labhealths[i].he_person)*(1+3));//健保自付額
		            							t_he_person=dec(labhealths[i].he_person)*(1+3);
		            						}else{
		            							q_tr('txtHe_person',dec(labhealths[i].he_person)*(1+dec($('#txtMount').val())));
		            							t_he_person=dec(labhealths[i].he_person)*(1+dec($('#txtMount').val()));
		            						}
		            						z_he_person=labhealths[i].he_person;
		            						q_tr('txtHe_comp',labhealths[i].he_comp);//健保公司負擔
		            						
		            						if(q_getPara('sys.comp').indexOf('大昌')>-1&&$('#chkIssssp')[0].checked){
		            							q_tr('txtHe_person',q_float('txtHe_person')+q_float('txtHe_comp'));//健保自付額
		            							t_he_person=q_float('txtHe_person');
		            							q_tr('txtHe_comp',0);//健保公司負擔
		            						}
	            						}
	            						break;	
	            					}
	            				}
	            				cal=false;
            				}
            			}
            			q_tr('txtHe_person',q_float('txtHe_person')-q_float('txtAs_health'))
            		break;
                case q_name: 
                	
                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }
        
        function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtNoa':
		                if(!emp($('#txtNoa').val())){
		                	//取得健勞保退保日期
	            			var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^ top=1";
	            			q_gt('labased', t_where, 0, 0, 0, "", r_accy);
			           		//判斷員工是否重覆儲存
			           		var t_where = "where=^^ noa ='"+$('#txtNoa').val()+"' ^^";
			           		q_gt('labase', t_where , 0, 0, 0, "", r_accy);
	            			//判斷員工是否是外勞
			           		var t_where = "where=^^ noa ='"+$('#txtNoa').val()+"' ^^";
			           		q_gt('sss', t_where , 0, 0, 0, "", r_accy);
			           		//判斷員工家屬
			           		var t_where = "where=^^noa='"+$('#txtNoa').val()+"'^^";
            				q_gt('labases_sum', t_where, 0, 0, 0, "", r_accy);
			        	}
			        	$('#txtInsur_fund').val(0.025);
			        	if(q_getPara('sys.comp').indexOf('大昌')>-1){
				     		if($('#txtNoa').val().substr(0,1)=='G'){
				     			$('#chkIssssp')[0].checked=true;
			            		//$('#txtInsur_disaster').val(0.11);
				     		}else{
				     			$('#chkIssssp')[0].checked=false;
		            			//$('#txtInsur_disaster').val(0.34);
				     		}
				     	}
			            break;
		    	}
			}
        
		//var insed=false;//判斷是否重覆輸入員工
        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
			
			
              if(q_cur==1)
	           	$('#txtWorker').val(r_name);
	        else
	           	$('#txtWorker2').val(r_name);
            //sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('labase_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            		$('#txtAs_health_' + j).change(function () {
            			var total_as_health=0;
            			for(var i = 0; i < q_bbsCount; i++) {
            				total_as_health+=dec($('#txtAs_health_' + i).val());
            			}
            			$('#txtAs_health').val(total_as_health);
				    	$('#txtHe_person').val(t_he_person-dec($('#txtAs_health').val()));
				    });
            		
            		$('#txtId_' + j).change(function () {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(!emp($('#txtId_'+b_seq).val()))
               				$('#txtId_'+b_seq).val($('#txtId_'+b_seq).val().toUpperCase());
				    });
				    
				    $('#txtNamea_' + j).change(function () {
				    	t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
				    	if(emp($('#txtSa_health').val())||dec($('#txtSa_health').val())==0){
		            		return;
		            	}
		            	$('#txtCh_money_'+b_seq).val(z_he_person);
		            	
	            		cal=true;
	            		sum();//計算家屬
		            	//取得健保薪資等級表
		            	var t_where = "where=^^ 1=1 ^^ top=1";
		            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
				    });
				    
				    $('#btnMinus_' + j).click(function () {
						if(emp($('#txtSa_health').val())||dec($('#txtSa_health').val())==0){
		            		return;
		            	}
	            		cal=true;
	            		sum();//計算家屬
		            	//取得健保薪資等級表
		            	var t_where = "where=^^ 1=1 ^^ top=1";
		            	q_gt('labhealth', t_where, 0, 0, 0, "", r_accy);
				    });
				}
			}
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txtBdate').val(q_date());
            $('#txtNoa').focus();
            //$('#txtMon').attr('readonly',true);
		    //$('#txtMon').attr('disabled', 'disabled');
		    $('#txtInsur_fund').val(0.025);
			//$('#txtInsur_disaster').val(0.34);
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtNoa').attr('disabled', 'disabled');
            $('#txtNamea').attr('disabled', 'disabled');
            $('#chkIsforeign').attr('disabled', 'disabled');
            $('#txtSalary').focus();
		    t_la_person=dec($('#txtLa_person').val())+dec($('#txtAs_labor').val())
		    t_he_person=dec($('#txtHe_person').val())+dec($('#txtAs_health').val())
		    //取得健勞保退保日期
            	var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' ^^ top=1";
            	q_gt('labased', t_where, 0, 0, 0, "", r_accy);
            
            //判斷車主是否有異動資料	
            if($('#txtNoa').val().substr(0,1)=='H'){
            	var t_where = "where=^^ noa='"+$('#txtNoa').val()+"' and noa in (select  a.noa from carOwner a left join car2 b on a.noa=b.carownerno where (b.outdate!='' and left(b.outdate,6)='"+q_date().substr(0,6)+"') or (b.enddate!='' and left(b.enddate,6)='"+q_date().substr(0,6)+"') or (b.wastedate!='' and left(b.wastedate,6)='"+q_date().substr(0,6)+"') or (b.suspdate!='' and left(b.suspdate,6)='"+q_date().substr(0,6)+"') group by a.noa) ^^";
            	q_gt('carowner', t_where, 0, 0, 0, "", r_accy);
            }
        }
        function btnPrint() {
		q_box('z_labase.aspx', '', "95%", "95%", q_getMsg("popPrint"));
        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {  
            if (!as['namea']) {  
                as[bbsKey[1]] = ''; 
                return;
            }

            q_nowf();
            as['date'] = abbm2['date'];

            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount=0, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {
            	if(!emp($('#txtNamea_'+j).val()))
					t_mount++;
            }  // j
            $('#txtMount').val(t_mount);
        }
        
        function refresh(recno) {
            _refresh(recno);
			
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
            
            if (t_para) {
		            $('#btnUmmb').removeAttr('disabled');	          
		        }
		        else {
		        	$('#btnUmmb').attr('disabled', 'disabled');	 
		        }
		        
        }

        function btnMinus(id) {
            _btnMinus(id);
            sum();
        }

        function btnPlus(org_htm, dest_tag, afield) {
            _btnPlus(org_htm, dest_tag, afield);
        }

        function q_appendData(t_Table) {
            return _q_appendData(t_Table);
        }

        function btnSeek() {
            _btnSeek();
        }

        function btnTop() {
            _btnTop();
        }
        function btnPrev() {
            _btnPrev();
        }
        function btnPrevPage() {
            _btnPrevPage();
        }

        function btnNext() {
            _btnNext();
        }
        function btnNextPage() {
            _btnNextPage();
        }

        function btnBott() {
            _btnBott();
        }
        function q_brwAssign(s1) {
            _q_brwAssign(s1);
        }

        function btnDele() {
            _btnDele();
        }

        function btnCancel() {
            _btnCancel();
        }
        
    </script>
    <style type="text/css">
        #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 70%;
                float: right;
            }
            .txt.c3 {
                width: 47%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
                width: 95%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:98% ;  
        }  
      
    </style>
</head>
<body ondragstart="return false" draggable="false"
        ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"  
        ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewNoa'></a></td>
                <td align="center" style="width:20%"><a id='vewNamea'></a></td>
                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='namea'>~namea</td>
                  
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 66%;float:left">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr class="tr1">
            <td class='td1'><span> </span><a id="lblNoa" class="lbl btn" > </a></td>
            <td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class='td3'><span> </span><a id="lblNamea" class="lbl" > </a></td>
            <td class="td4"><input id="txtNamea" type="text" class="txt c1" /></td> 
            <td class='td5'><input id="chkIsforeign" type="checkbox" style=' '/><span> </span><a id="lblIsforeign"> </a></td>
            <td class='td5'><input id="chkIssssp" type="checkbox" style=' '/><span> </span><a id="lblIssssp"> </a></td>
            <td class="td6" colspan="2"><span> </span><input id="btnSalinsures" type="button"/></td> 
        </tr>
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblInsur_fund" class="lbl"> </a></td>
            <td class="td2"><input id="txtInsur_fund" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblInsur_disaster" class="lbl"> </a></td>
            <td class="td4"><input id="txtInsur_disaster" type="text" class="txt num c1" /></td>
            <td class='td5'  colspan="2" ></td>
            <td class="td6" colspan="2"><span> </span><input id="btnLabased" type="button"/></td> 
        </tr>
        <tr class="tr2">
            <td class='td1'  colspan="8" style="background-color: #FFEC8B;color: red;">  　 　※ 請填入整月的金額，系統立帳時會自動換算!!!</br>
            	  　 　※ 健保當月退保(不含當月加保或滿一個月)，請清除健保相關金額!!!
            </td>
        </tr>
        <tr class="tr3">
            <!--<td class='td1'><span> </span><a id="lblTypea" class="lbl" > </a></td>
            <td class="td2"><input id="txtTypea" type="text" class="txt  c1" /></td>-->
            <td class='td1'><span> </span><a id="lblBdate" class="lbl"> </a></td>
            <td class="td2"><input id="txtBdate" type="text" class="txt  c1" /></td>
            <td class='td3'><span> </span><a id="lblSalary" class="lbl"> </a></td>
            <td class="td4"><input id="txtSalary" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
            <td class="td6"><input id="txtCustno" type="text" class="txt c1" /></td>
            <td class="td7"><input id="txtComp" type="text" class="txt c1" /></td>
            <!--<td class="td5" colspan="2"><span> </span><input id="btnUmmb" type="button" style="float: right;"/></td>
            <td class="td7"><span> </span><a id="lblMon" class="lbl"> </a></td>
            <td class="td8"><input id="txtMon" type="text" class="txt c1" /></td>-->
        </tr>
        <tr class="tr4">
            <td class='td1'><span> </span><a id="lblSa_retire" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_retire" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblRe_comp" class="lbl"> </a></td>
            <td class="td4"><input id="txtRe_comp" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblRe_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtRe_person" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblPlus2" class="lbl"> </a></td>
            <td class="td6"><input id="txtPlus2" type="text" class="txt num c1" /></td>
        </tr>
        <tr class="tr5">
            <td class='td1'><span> </span><a id="lblSa_labor" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_labor" type="text" class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblLa_comp" class="lbl"> </a></td>
            <td class="td8"><input id="txtLa_comp" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblLa_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtLa_person" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblAs_labor" class="lbl"> </a></td>
            <td class="td4"><input id="txtAs_labor" type="text" class="txt num c1" /></td>
        </tr>
        <tr class="tr6">
            <td class='td1'><span> </span><a id="lblSa_health" class="lbl" > </a></td>
            <td class="td2"><input id="txtSa_health" type="text" class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblHe_comp" class="lbl"> </a></td>
            <td class="td8"><input id="txtHe_comp" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblHe_person" class="lbl"> </a></td>
            <td class="td6"><input id="txtHe_person" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblAs_health" class="lbl"> </a></td>
            <td class="td4"><input id="txtAs_health" type="text" class="txt num c1" /></td>
        </tr>                               
        <tr class="tr7">
            <td class='td1'><span> </span><a id="lblTax" class="lbl" > </a></td>
            <td class="td2"><input id="txtTax" type="text" class="txt num c1" /></td>
            <td class='td3'><span> </span><a id="lblMount" class="lbl"> </a></td>
            <td class="td4"><input id="txtMount" type="text" class="txt num c1" /></td>
            <td class='td5'><span> </span><a id="lblDisaster" class="lbl btn"> </a></td>
            <td class="td6"><input id="txtDisaster" type="text" class="txt num c1" /></td>
            <td class='td7'><span> </span><a id="lblWorker" class="lbl"> </a></td>
            <td class="td8"><input id="txtWorker" type="text" class="txt c1" /></td>
        </tr>  
        <tr class="tr2">
            <td class='td1'><span> </span><a id="lblMemo" class="lbl" > </a></td>
            <td class="td2" colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
            <td class='td7'><span> </span><a id="lblWorker2" class="lbl"> </a></td>
            <td class="td8"><input id="txtWorker2" type="text" class="txt c1" /></td>
        </tr>                                                            
        </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width: 7%;"><a id='lblPrefix_s'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblNamea_s'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblBirthday_s'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblId_s'> </a></td>
                <td align="center" style="width: 9%;"><a id='lblCh_money_s'> </a></td>
                <td align="center" style="width: 9%;"><a id='lblAs_health_s'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblIndate_s'> </a></td>
                <td align="center" style="width: 10%;"><a id='lblOutdate_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td ><input class="txt c1" id="txtPrefix.*"type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*"type="text" /></td>
                <td ><input class="txt c1" id="txtBirthday.*"type="text" /></td>
                <td ><input class="txt c1" id="txtId.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_money.*"type="text" /></td>
                <td ><input class="txt num c1" id="txtAs_health.*"type="text" /></td>
                <td ><input class="txt c1" id="txtIndate.*"type="text" /></td>
                <td ><input class="txt c1" id="txtOutdate.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input class="txt c1" id="txtMemo.*"type="text" /></td>
            </tr>
        </table>
        </div>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
