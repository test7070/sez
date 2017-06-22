<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
<head>
    <title></title>
    <script src="../script/jquery.min.js" type="text/javascript"></script>
    <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
    <script src='../script/qj_mess.js' type="text/javascript"></script>
    <script src="../script/qbox.js" type="text/javascript"></script>
    <script src='../script/mask.js' type="text/javascript"></script>
    <link href="../qbox.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        this.errorHandler = null;
        function onPageError(error) {
            alert("An error occurred:\r\n" + error.Message);
        }
        q_tables = 's';
        var q_name = "salary";
        var q_readonly = ['txtNoa'];
        var q_readonlys = [];
        var bbmNum = [['txtMoney', 15, 0, 1],['txtDaymoney', 15, 0, 1],['txtPubmoney', 15, 0, 1],['txtBo_admin', 15, 0, 1],['txtBo_traffic', 15, 0, 1],['txtBo_special', 15, 0, 1],['txtBo_oth', 15, 0, 1],['txtTax_other', 15, 0, 1],['txtMi_total', 15, 0, 1],['txtMtotal', 15, 0, 1],['txtBo_full', 15, 0, 1],['txtAddmoney', 15, 0, 1],['txtBorrow', 15, 0, 1],['txtCh_labor', 15, 0, 1],['txtCh_health', 15, 0, 1],['txtCh_labor_comp', 15, 0, 1],['txtCh_labor_self', 15, 0, 1],['txtWelfare', 15, 0, 1],['txtTotal3', 15, 0, 1],['txtTotal4', 15, 0, 1],['txtTotal5', 15, 0, 1]];  
        var bbsNum = [['txtMoney', 15, 0, 1],['txtDaymoney', 15, 0, 1],['txtPubmoney', 15, 0, 1],['txtBo_admin', 15, 0, 1],['txtBo_traffic', 15, 0, 1],['txtBo_special', 15, 0, 1],['txtBo_oth', 15, 0, 1],['txtTotal1', 15, 0, 1],['txtCh_labor1', 15, 0, 1],['txtCh_labor2', 15, 0, 1],['txtCh_health_insure', 15, 0, 1],['txtDay', 15, 4, 1],['txtMtotal', 15, 0, 1],['txtBo_born', 15, 0, 1],['txtBo_night', 15, 0, 1],['txtBo_full', 15, 0, 1],['txtBo_duty', 15, 0, 1],['txtTax_other', 15, 0, 1],['txtTotal2', 15, 0, 1],['txtOstand', 15, 2, 1],['txtAddh2_1', 15, 1, 1],['txtAddh2_2', 15, 1, 1],['txtAddmoney', 15, 0, 1],['txtAddh100', 15, 1, 1],['txtAddh46_1', 15, 1, 1],['txtAddh46_2', 15, 1, 1],['txtTax_other2', 15, 0, 1],['txtTotal3', 15, 0, 1],['txtBorrow', 15, 0, 1],['txtCh_labor', 15, 0, 1],['txtChgcash', 15, 0, 1],['txtTax6', 15, 0, 1],['txtStay_tax', 15, 0, 1],['txtTax12', 15, 0, 1],['txtTax18', 15, 0, 1],['txtCh_labor_comp', 15, 0, 1],['txtCh_labor_self', 15, 0, 1],['txtLodging_power_fee', 15, 0, 1],['txtTax', 15, 0, 1],['txtTax5', 15, 0, 1],['txtWelfare', 15, 0, 1],['txtStay_money', 15, 0, 1],['txtRaise_num', 15, 0, 1],['txtCh_health', 15, 0, 1],['txtTotal4', 15, 0, 1],['txtTotal5', 15, 0, 1],['txtLate', 15, 0, 1],['txtHr_sick', 15, 1, 1],['txtMi_sick', 15, 0, 1],['txtHr_person', 15, 1, 1],['txtMi_person', 15, 0, 1],['txtHr_nosalary', 15, 1, 1],['txtMi_nosalary', 15, 0, 1],['txtHr_leave', 15, 1, 1],['txtMi_leave', 15, 0, 1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'noa';
        aPop = new Array(['txtSno_', 'lblSno', 'sss', 'noa,namea', 'txtSno_,txtNamea_', 'sss_b.aspx']);
		q_desc=1;
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

            mainForm(1); 
        }  
        
		//紀錄工作開始日期、結束日期和工作天數(上期、下期、本月)
		var date_1='',date_2='',dtmp=0;
		
        function mainPost() {
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm]];
            q_mask(bbmMask);
            
            q_cmbParse("cmbPerson", q_getPara('person.typea'));
            q_cmbParse("cmbMonkind", ('').concat(new Array( '本月','上期', '下期')));
            q_cmbParse("cmbTypea", ('').concat(new Array('薪資')));
            
            $('#cmbPerson').change(function () {
            	 /*if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
            	 	q_cmbParse("cmbMonkind", ('').concat(new Array('本月')));
            	 }else{
            	 	q_cmbParse("cmbMonkind", ('').concat(new Array('上期', '下期')));
            	 }*/
            	 table_change();
            	 check_insed();
            });
            
            $('#cmbMonkind').change(function () {
            	getdtmp();
            	check_insed();
            });
            
            $('#btnInput').click(function () {
            	var t_where = "where=^^ a.person='"+$('#cmbPerson').find("option:selected").text()+"' ^^";
            	var t_where1 = "where[1]=^^ datea between '"+date_1+"' and '"+date_2+"' ^^";
            	var t_where2 = "where[2]=^^ noa between '"+date_1+"' and '"+date_2+"' and sssno=a.noa ^^";
            	var t_where3 = "where[3]=^^ da.mon='"+$('#txtMon').val()+"' and da.person='"+$('#cmbPerson').find("option:selected").text()+"' and da.monkind='"+$('#cmbMonkind').find("option:selected").text()+"' ^^";
            	var t_where4 = "where[4]=^^ noa between '"+$('#txtMon').val()+"/01' and '"+$('#txtMon').val()+"/15' and sssno=a.noa ^^";
		        q_gt('salary_import', t_where+t_where1+t_where2+t_where3+t_where4 , 0, 0, 0, "", r_accy);
            });
            
        }

        function q_boxClose(s2) { 
           var ret; 
            switch (b_pop) {                   
            	case 'conn':

                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
            switch (t_name) {
                case 'salary_import':  
						var as = _q_appendData("labases", "", true);
						for (var i = 0; i < as.length; i++) {
							//判斷是否哪些員工要計算薪水
		                    if ((!emp(as[i].ft_date) && as[i].ft_date >date_1)||(!emp(as[i].outdate)&&as[i].outdate<date_1||as[i].indate>$('#txtMon').val())) {
		                        as.splice(i, 1);
		                        i--;
		                    }else{
		                    	//判斷勞健保(部份公式再load已計算)
									//健保費：只要離職 就一整個月不算(除離職日=月底最後一天 要算) 新進人員 就整月算
									//勞保費：只要當月新進 或當月離職 就依照在職日數/30 去算	通常都是下期收 除了有離職的
									//福利金：下期收 但新進人員到職未滿90日 不收；離職人員 只要離職當月就不收
									//取扶養人之應繳健保費 AND 健保補助金已在SQL時加入
		                    	if(as[i].indate>=$('#txtMon').val()+'/01'&&date_2>=as[i].indate){//新進日在薪資月份內
		                    		if (($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1)||($('#cmbMonkind').find("option:selected").text().indexOf('本月')>-1)){
		                    			//在職日數
		                    			var indays=parseInt(Math.abs(Date.parse(as[i].indate) -Date.parse(date_2)) /1000/60/60/24);
		                    			//as[i].ch_health//健保費
		                    			as[i].ch_labor=Math.round(as[i].ch_labor*indays/30); //勞保費
		                    			as[i].ch_labor_comp=Math.round(as[i].ch_labor_comp*indays/30);//勞退公司
		                    			as[i].ch_labor_self=Math.round(as[i].ch_labor_self*indays/30);//勞退個人
		                    			as[i].tax=Math.round(as[i].tax*indays/30);//所得稅
		                    		}else{
		                    			as[i].ch_health=0;//健保費
		                    			as[i].ch_labor=0; //勞保費
		                    			as[i].ch_labor_comp=0;//勞退公司
		                    			as[i].ch_labor_self=0;//勞退個人
		                    			as[i].tax=0;//所得稅
		                    		}
		                    	}else if(as[i].outdate>=date_1 && date_2>=as[i].outdate){//離職日在搜尋範圍內
		                    		//在職日數
		                    		var indays=parseInt(Math.abs(Date.parse($('#txtMon').val()+'/01') -Date.parse(as[i].outdate)) /1000/60/60/24);
		                    		//勞保退保日數
		                    		var labor1days=parseInt(Math.abs(Date.parse($('#txtMon').val()+'/01') -Date.parse(as[i].labor1_edate)) /1000/60/60/24);
		                    		//勞退退保日數
		                    		var labor2days=parseInt(Math.abs(Date.parse($('#txtMon').val()+'/01') -Date.parse(as[i].labor2_edate)) /1000/60/60/24);
		                    			
		                    		if(as[i].outdate==date_2)
		                    			as[i].ch_health=Math.round(as[i].ch_health+as[i].as_health);	//健保費
		                    		else
		                    			as[i].ch_health=0;
		                    		as[i].ch_labor=Math.round(as[i].ch_labor*labor1days/30);//勞保費
		                    		as[i].ch_labor_comp=Math.round(as[i].ch_labor_comp*labor2days/30);//勞退公司
		                    		as[i].ch_labor_self=Math.round(as[i].ch_labor_self*labor2days/30);//勞退個人
		                    		as[i].tax=Math.round(as[i].tax*indays/30);//所得稅
		                    	}else{
		                    		if (($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1)||($('#cmbMonkind').find("option:selected").text().indexOf('本月')>-1)){
		                    			//as[i].ch_health//健保費
		                    			//as[i].ch_labor //勞保費
		                    			//as[i].ch_labor_comp//勞退公司
		                    			//as[i].ch_labor_self//勞退個人
		                    			//as[i].tax//所得稅
		                    		}else{
		                    			as[i].ch_health=0;//健保費
		                    			as[i].ch_labor=0; //勞保費
		                    			as[i].ch_labor_comp=0;//勞退公司
		                    			as[i].ch_labor_self=0;//勞退個人
		                    			as[i].tax=0;//所得稅
		                    		}
		                    	}
		                    //請假扣薪
		                    if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
		                    	as[i].day= dec(as[i].inday)-dec(as[i].late);//給薪日數=上班天數-遲到次數
		                    	as[i].mi_saliday=0;
		                    }else{
		                    	as[i].day=0;
		                    	as[i].mi_saliday=(dec(as[i].hr_sick)+dec(as[i].hr_person)+dec(as[i].hr_leave)+dec(as[i].hr_nosalary))/8; //扣薪日數=病假(時)+事假(時)+曠工(時)+無薪(時)/8--->一天工作8小時為基準
		                    }
		                    //全勤獎金
		                    if(($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1)||($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1))
		                    	as[i].bo_full=as[i].bo_full/2;
		                    //只要有請假與遲到一律都沒有全勤獎金
		                    if((dec(as[i].hr_sick)+dec(as[i].hr_person)+dec(as[i].hr_leave)+dec(as[i].late))>0)
		                    	as[i].bo_full=0;
		                    
		                    //其他項目
		                    	//應稅其他=應稅其他+生產獎金+夜班津貼+值班津貼
		                    	if(!($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1))
		                    		as[i].tax_other=dec(as[i].tax_other)+dec(as[i].bo_born)+dec(as[i].bo_night)+dec(as[i].bo_day);
		                   	//加班時數
		                   		var t_fir =46,bef_fir01,bef_fir02;
		                   		as[i].addh21=as[i].addh1;
		                   		as[i].addh22=as[i].addh2;
		                   		as[i].addh46_1=0;
		                   		as[i].addh46_2=0;
		                   		if($('#cmbMonkind').find("option:selected").text().indexOf('本月')>-1){
		                    		if((dec(as[i].addh1)+dec(as[i].addh2))>46){//加班超過46小時
			                    		bef_fir01=Math.min(dec(as[i].addh1),t_fir);
			                    		as[i].addh21=bef_fir01;
			                    		as[i].addh46_1=dec(as[i].addh1)-bef_fir01;
			                    		
			                    		bef_fir02=t_fir-bef_fir01;
			                    		as[i].addh22=bef_fir02;
			                    		as[i].addh46_2=dec(as[i].addh2)-bef_fir02;
		                    		}
		                    	}else{//上下期計算
		                    		if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1){
		                    			if((dec(as[i].addh1)+dec(as[i].addh2)+dec(as[i].addh3)+dec(as[i].addh4))>46){//加班超過46小時
		                    				
		                    				if((dec(as[i].addh3)+dec(as[i].addh4))>46){//上期已超過46小時
		                    					as[i].addh21=0;
						                   		as[i].addh22=0;
						                   		as[i].addh46_1=as[i].addh1;
						                   		as[i].addh46_2=as[i].addh2;
		                    				}else{//下期才超過46小時
			                    				t_fir=t_fir-(dec(as[i].addh3)+dec(as[i].addh4));
					                    		bef_fir01=Math.min(dec(as[i].addh1),t_fir);
					                    		as[i].addh21=bef_fir01;
					                    		as[i].addh46_1=dec(as[i].addh1)-bef_fir01;
					                    		
					                    		bef_fir02=t_fir-bef_fir01;
					                    		as[i].addh22=bef_fir02;
					                    		as[i].addh46_2=dec(as[i].addh2)-bef_fir02;
				                    		}
		                    			}
		                    		}else{
		                    			if((dec(as[i].addh1)+dec(as[i].addh2))>46){//上期加班超過46小時
				                    		bef_fir01=Math.min(dec(as[i].addh1),t_fir);
				                    		as[i].addh21=bef_fir01;
				                    		as[i].addh46_1=dec(as[i].addh1)-bef_fir01;
				                    		
				                    		bef_fir02=t_fir-bef_fir01;
				                    		as[i].addh22=bef_fir02;
				                    		as[i].addh46_2=dec(as[i].addh2)-bef_fir02;
		                    			}	
		                    		}
		                    	}
		                    }
						}//end for
						
						if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
							q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtDaymoney,txtPubmoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtCh_labor1,txtCh_labor2,txtCh_health_insure,txtDay,txtMi_saliday,txtBo_born,txtBo_night,txtBo_full,txtBo_duty,txtTax_other,txtAddh2_1,txtAddh2_2,txtAddh100,txtAddh46_1,txtAddh46_2,txtTax_other2,txtBorrow,txtCh_labor,txtChgcash,txtCh_labor_comp,txtCh_labor_self,txtLodging_power_fee,txtTax,txtStay_money,txtRaise_num,txtCh_health,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo'
															, as.length, as
                                                           , 'sssno,namea,salary,pubmoney,bo_admin,bo_traffic,bo_special,bo_oth,ch_labor1,ch_labor2,ch_health_insure,day,mi_saliday,bo_born,bo_night,bo_full,bo_day,tax_other,addh21,addh22,addh100,addh46_1,addh46_2,tax_other2,chg,ch_labor,chgcash,ch_labor_comp,ch_labor_self,lodging_power_fee,tax,stay_money,raise_num,ch_health,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo'
                                                           , '');
						}else{
                         	q_gridAddRow(bbsHtm, 'tbbs', 'txtSno,txtNamea,txtMoney,txtPubmoney,txtBo_admin,txtBo_traffic,txtBo_special,txtBo_oth,txtCh_labor1,txtCh_labor2,txtCh_health_insure,txtDay,txtMi_saliday,txtBo_born,txtBo_night,txtBo_full,txtBo_duty,txtTax_other,txtAddh2_1,txtAddh2_2,txtAddh100,txtAddh46_1,txtAddh46_2,txtTax_other2,txtBorrow,txtCh_labor,txtChgcash,txtCh_labor_comp,txtCh_labor_self,txtLodging_power_fee,txtTax,txtStay_money,txtRaise_num,txtCh_health,txtLate,txtHr_sick,txtHr_person,txtHr_nosalary,txtHr_leave,txtMemo'
															, as.length, as
                                                           , 'sssno,namea,salary,pubmoney,bo_admin,bo_traffic,bo_special,bo_oth,ch_labor1,ch_labor2,ch_health_insure,day,mi_saliday,bo_born,bo_night,bo_full,bo_day,tax_other,addh21,addh22,addh100,addh46_1,addh46_2,tax_other2,chg,ch_labor,chgcash,ch_labor_comp,ch_labor_self,lodging_power_fee,tax,stay_money,raise_num,ch_health,late,hr_sick,hr_person,hr_nosalary,hr_leave,memo'
                                                           , '');
                        }
                        
                        //福利金	
                        if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1||$('#cmbMonkind').find("option:selected").text().indexOf('本月')>-1)
                        {
	                        for (var j = 0; j < q_bbsCount; j++) {
		                        for (var i = 0; i < as.length; i++) {
				                    	if($('#txtSno_'+j).val()==as[i].sssno){
				                    		$('#chkIswelfare_'+j)[0].checked=as[i].iswelfare;
				                    		break;
				                    	}
		                        }
	                        }
                        }
                         sum();
                    break;

                case q_name:
                	var as = _q_appendData("salary", "", true);
                	if(as[0]!=undefined)
                 		insed=true;
                 	else
                 		insed=false;
                 		
                	if (q_cur == 4)  
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) 
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                    break;
            }  /// end switch
        }

        function btnOk() {
			$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
			} 
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }
            
            if(insed&&q_cur==1){
            	alert('該薪資作業已做過!!!');
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll('S' + $('#txtMon').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('salary_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {  
        }

        function bbsAssign() {  
        	for(var j = 0; j < q_bbsCount; j++) {
           		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           			$('#txtMoney_'+j).change(function () {sum();});
           			$('#txtPubmoney_'+j).change(function () {sum();});
           			$('#txtBo_admin_'+j).change(function () {sum();});
           			$('#txtBo_traffic_'+j).change(function () {sum();});
           			$('#txtBo_special_'+j).change(function () {sum();});
           			$('#txtBo_oth_'+j).change(function () {sum();});
           			$('#txtTotal1_'+j).change(function () {sum();});
           			$('#txtMi_total_'+j).change(function () {sum();});
           			$('#txtMi_saliday_'+j).change(function () {sum();});
           			$('#txtTotal2_'+j).change(function () {sum();});
           			$('#txtBo_full_'+j).change(function () {sum();});
           			$('#txtTax_other_'+j).change(function () {sum();});
           			$('#txtOstand_'+j).change(function () {sum();});
           			$('#txtAddmoney_'+j).change(function () {sum();});
           			$('#txtAddh2_1_'+j).change(function () {sum();});
           			$('#txtAddh2_2_'+j).change(function () {sum();});
           			$('#txtTotal3_'+j).change(function () {sum();});
           			$('#txtTax_other2_'+j).change(function () {sum();});
           			$('#chkIswelfare_'+j).change(function () {sum();});
           			$('#txtWelfare_'+j).change(function () {sum();});
           			$('#txtDaymoney_'+j).change(function () {sum();});
           			$('#txtMtotal_'+j).change(function () {sum();});
           			$('#txtDay_'+j).change(function () {sum();});
           			$('#txtBo_born_'+j).change(function () {sum();});
           			$('#txtBo_night_'+j).change(function () {sum();});
           			$('#txtBo_duty_'+j).change(function () {sum();});
           			$('#txtTax6_'+j).change(function () {sum();});
           			$('#txtAddh46_1_'+j).change(function () {sum();});
           			$('#txtAddh46_2_'+j).change(function () {sum();});
           			$('#txtAddh100_'+j).change(function () {sum();});
           			$('#txtTotal4_'+j).change(function () {sum();});
           			$('#txtBorrow_'+j).change(function () {sum();});
           			$('#txtCh_labor_'+j).change(function () {sum();});
           			$('#txtChgcash_'+j).change(function () {sum();});
           			$('#txtCh_labor_self_'+j).change(function () {sum();});
           			$('#txtLodging_power_fee_'+j).change(function () {sum();});
           			$('#txtTax_'+j).change(function () {sum();});
           			$('#txtTax5_'+j).change(function () {sum();});
           			$('#txtStay_tax_'+j).change(function () {sum();});
           			$('#txtTax12_'+j).change(function () {sum();});
           			$('#txtTax18_'+j).change(function () {sum();});
           			$('#txtStay_money_'+j).change(function () {sum();});
           			$('#txtCh_health_'+j).change(function () {sum();});
            	}
            }
            _bbsAssign();
            table_change();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtDatea').val(q_date());
            $('#txtMon').val(q_date().substr( 0,6));
            $('#txtMon').focus();
            $('#cmbPerson').val("本國");
            $('#cmbMonkind').val("本月");
            $('#cmbTypea').val("薪資");
            table_change();
            check_insed();
        }
        
        var insed=false;
        function check_insed() {
        	if(q_cur==1){
        	 //判斷是否已新增過
           		var t_where = "where=^^ mon='"+$('#txtMon').val()+"' and person='"+$('#cmbPerson').find("option:selected").text()+"' and monkind='"+$('#cmbMonkind').find("option:selected").text()+"' ^^";
		    	q_gt('salary', t_where , 0, 0, 0, "", r_accy);
		    }
        }
        
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtMon').focus();
            $('#txtMon').attr('disabled', 'disabled');
            $('#cmbPerson').attr('disabled', 'disabled');
            $('#cmbMonkind').attr('disabled', 'disabled');
            table_change();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {   
            if (!as['sno']) {  
                as[bbsKey[1]] = '';  
                return;
            }

            q_nowf();
            as['mon'] = abbm2['mon'];

            //            t_err ='';
            //            if (as['total'] != null && (dec(as['total']) > 999999999 || dec(as['total']) < -99999999))
            //                t_err = q_getMsg('msgMoneyErr') + as['total'] + '\n';

            //            
            //            if (t_err) {
            //                alert(t_err)
            //                return false;
            //            }
            //            
            return true;
        }

        function sum() {
        	//bbs計算
        	getdtmp();
        	for (var j = 0; j < q_bbsCount; j++) {
        		//小計=本俸+公費+主管津貼+交通津貼+特別津貼+其他津貼
        		q_tr('txtTotal1_'+j,dec($('#txtMoney_'+j).val())+dec($('#txtPubmoney_'+j).val())+dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_traffic_'+j).val())+dec($('#txtBo_special_'+j).val())+dec($('#txtBo_oth_'+j).val()));
        		
        		if(($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1)||($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1)){
        			q_tr('txtMi_total_'+j,Math.round(dec($('#txtTotal1_'+j).val())/2/dtmp*dec($('#txtMi_saliday_'+j).val())));//扣薪金額
        			q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())/2-dec($('#txtMi_total_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			q_tr('txtOstand_'+j,Math.round((dec($('#txtTotal1_'+j).val())/30/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.67*dec($('#txtAddh2_2_'+j).val())));//加班費
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())+dec($('#txtTax_other2_'+j).val())));//應領總額=給付總額+加班費+免稅其他
        			//福利金
        			if($('#chkIswelfare_'+j)[0].checked)
		        		q_tr('txtWelfare_'+j,Math.round(dec($('#txtMoney_'+j).val())*5/1000));
		        	else
		        		q_tr('txtWelfare_'+j,0);
        		}else if($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
        			q_tr('txtTotal1_'+j,Math.round(dec($('#txtDaymoney_'+j).val())));
        			q_tr('txtMtotal_'+j,Math.round(dec($('#txtDaymoney_'+j).val())*dec($('#txtDay_'+j).val())));//給薪金額
        			q_tr('txtTotal2_'+j,Math.round((dec($('#txtBo_admin_'+j).val())+dec($('#txtBo_traffic_'+j).val())+dec($('#txtBo_special_'+j).val())+dec($('#txtBo_oth_'+j).val()))/2+dec($('#txtMtotal_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			q_tr('txtOstand_'+j,Math.round((dec($('#txtDaymoney_'+j).val())/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.67*dec($('#txtAddh2_2_'+j).val())));//加班費
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())+dec($('#txtTax_other2_'+j).val())));//應領總額=給付總額+加班費+免稅其他
        			//福利金
        			if($('#chkIswelfare_'+j)[0].checked)
		        		q_tr('txtWelfare_'+j,Math.round(dec($('#txtDaymoney_'+j).val())*22*5/1000));
		        	else
		        		q_tr('txtWelfare_'+j,0);
        		}else{
        			q_tr('txtMi_total_'+j,Math.round(dec($('#txtTotal1_'+j).val())/dtmp*dec($('#txtMi_saliday_'+j).val())));//扣薪金額
        			q_tr('txtTotal2_'+j,Math.round(dec($('#txtTotal1_'+j).val())-dec($('#txtMi_total_'+j).val())+dec($('#txtBo_full_'+j).val())+dec($('#txtBo_born_'+j).val())+dec($('#txtBo_night_'+j).val())+dec($('#txtBo_duty_'+j).val())+dec($('#txtTax_other_'+j).val())));//給付總額
        			q_tr('txtOstand_'+j,Math.round((dec($('#txtTotal1_'+j).val())/30/8)*100)/100);//加班費基數(取小數點兩位並四捨五入)
        			q_tr('txtAddmoney_'+j,Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh2_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.67*dec($('#txtAddh2_2_'+j).val())));//加班費
        			//q_tr('txtTax6_'+j,Math.round((dec($('#txtTotal2_'+j).val())+Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh46_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.67*dec($('#txtAddh46_2_'+j).val())))*0.06));//所得稅
        			q_tr('txtTotal3_'+j,Math.round(dec($('#txtTotal2_'+j).val())+dec($('#txtAddmoney_'+j).val())+dec($('#txtTax_other2_'+j).val())+Math.round(dec($('#txtOstand_'+j).val())*1.33*dec($('#txtAddh46_1_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1.67*dec($('#txtAddh46_2_'+j).val()))+Math.round(dec($('#txtOstand_'+j).val())*1*dec($('#txtAddh100_'+j).val()))));//應領總額
        			//福利金
        			if($('#chkIswelfare_'+j)[0].checked)
		        		q_tr('txtWelfare_'+j,Math.round(dec($('#txtMoney_'+j).val())*5/1000));
		        	else
		        		q_tr('txtWelfare_'+j,0);
        		}
        		//應扣總額=借支+勞保費+零用金+勞退個人提繳+住宿電費+所得稅+所得稅5%+所得稅6%(外勞)+暫留稅10%(外勞)+所得稅12%(外勞)+所得稅18%(外勞)+福利金+暫留款+健保費
				q_tr('txtTotal4_'+j,Math.round(dec($('#txtBorrow_'+j).val())+dec($('#txtCh_labor_'+j).val())+dec($('#txtChgcash_'+j).val())+dec($('#txtCh_labor_self_'+j).val())+dec($('#txtLodging_power_fee_'+j).val())+dec($('#txtTax_'+j).val())+dec($('#txtTax5_'+j).val())+dec($('#txtTax6_'+j).val())+dec($('#txtStay_tax_'+j).val())+dec($('#txtTax12_'+j).val())+dec($('#txtTax18_'+j).val())+dec($('#txtWelfare_'+j).val())+dec($('#txtStay_money_'+j).val())+dec($('#txtCh_health_'+j).val())));
				//實發金額=應領總額-應扣總額
        		q_tr('txtTotal5_'+j,Math.round(dec($('#txtTotal3_'+j).val())-dec($('#txtTotal4_'+j).val())));
        		
        	}
        	//bbm計算
            var monkind=0,t_money=0,t_daymoney=0,t_pubmoney=0,t_bo_admin=0,t_bo_traffic=0,t_bo_special=0,t_bo_oth=0,t_bo_full=0,t_tax_other=0
            ,t_mtotal=0,t_mitotal=0,t_addmoney=0,t_borrow=0,t_ch_labor=0,t_ch_health=0,t_ch_labor_comp=0,t_ch_labor_self=0
            ,t_welfare=0,t_total3=0,t_total4=0,t_total5=0;
            //結算方式，一個月結算，所以*1，上下期計算薪資，因此*0.5
            if($('#cmbMonkind').find("option:selected").text().indexOf('本月')>-1)
            	monkind=1;
            else
            	monkind=0.5;
            
            for (var j = 0; j < q_bbsCount; j++) {
				t_money+=dec($('#txtMoney_'+j).val());//本俸
				t_daymoney+=dec($('#txtDaymoney_'+j).val());//日薪
				t_pubmoney+=dec($('#txtPubmoney_'+j).val());//公費
				t_bo_admin+=dec($('#txtBo_admin_'+j).val())*monkind;//主管津貼
				t_bo_traffic+=dec($('#txtBo_traffic_'+j).val())*monkind;//交通津貼
				t_bo_full+=dec($('#txtBo_full_'+j).val());//全勤
				t_bo_special+=dec($('#txtBo_special_'+j).val())*monkind;//特別津貼
				t_bo_oth+=dec($('#txtBo_oth_'+j).val())*monkind;//其他津貼
				t_tax_other+=dec($('#txtTax_other_'+j).val());//應稅其他
				t_mtotal+=dec($('#txtMtotal_'+j).val());//給薪金額
				t_mitotal+=dec($('#txtMi_total_'+j).val());//扣薪金額
				t_addmoney+=dec($('#txtAddmoney_'+j).val());//加班費
				t_borrow+=dec($('#txtBorrow_'+j).val());//借支
				t_ch_labor+=dec($('#txtCh_labor_'+j).val());//勞保費
				t_ch_health+=dec($('#txtCh_health_'+j).val());//健保費
				t_ch_labor_comp+=dec($('#txtCh_labor_comp_'+j).val());//勞退提繳
				t_ch_labor_self+=dec($('#txtCh_labor_self_'+j).val());//勞退個人
				t_welfare+=dec($('#txtWelfare_'+j).val());//福利金
				t_total3+=dec($('#txtTotal3_'+j).val());//應領總額
				t_total4+=dec($('#txtTotal4_'+j).val());//應扣總額
				t_total5+=dec($('#txtTotal5_'+j).val());//實發金額
            } 
            
            q_tr('txtMoney',t_money);//本俸
            q_tr('txtDaymoney',t_daymoney);//日薪
            q_tr('txtPubmoney',t_pubmoney);//公費
            q_tr('txtBo_admin',t_bo_admin);//主管津貼
            q_tr('txtBo_traffic',t_bo_traffic);//交通津貼
            q_tr('txtBo_full',t_bo_full);//全勤
            q_tr('txtBo_special',t_bo_special);//特別津貼
            q_tr('txtBo_oth',t_bo_oth);//其他津貼
            q_tr('txtTax_other',t_tax_other);//應稅其他         
            q_tr('txtMtotal',Math.round(t_mtotal));//給薪金額
            q_tr('txtMi_total',Math.round(t_mitotal));//扣薪金額
            q_tr('txtAddmoney',t_addmoney);//加班費
            q_tr('txtBorrow',t_borrow);//借支
            q_tr('txtCh_labor',t_ch_labor);//勞保費
            q_tr('txtCh_health',t_ch_health);//健保費
            q_tr('txtCh_labor_comp',t_ch_labor_comp);//勞退提繳
            q_tr('txtCh_labor_self',t_ch_labor_self);//勞退個人
            q_tr('txtWelfare',Math.round(t_welfare));//福利金
            q_tr('txtTotal3',Math.round(t_total3));//應領總額
            q_tr('txtTotal4',Math.round(t_total4));//應扣總額
            q_tr('txtTotal5',Math.round(t_total5));//實發金額
        }
        
        function refresh(recno) {
            _refresh(recno);
            table_change();
            $('#txtNoa').focus();
        }

        function readonly(t_para, empty) {
            _readonly(t_para, empty);
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
        
        function getdtmp() {
        	var myDate = new Date(dec($('#txtMon').val().substr( 0,3))+1911,dec($('#txtMon').val().substr( 4,5)),0);
        	var lastday=myDate.getDate();	//取當月最後一天
        	if($('#cmbMonkind').find("option:selected").text().indexOf('上期')>-1){
        		date_1=$('#txtMon').val()+'/01';
        		date_2=$('#txtMon').val()+'/15';
        		dtmp=15;
        	}else if($('#cmbMonkind').find("option:selected").text().indexOf('下期')>-1){
        		date_1=$('#txtMon').val()+'/16';
        		date_2=$('#txtMon').val()+'/'+lastday;
        		dtmp=lastday-16+1;
        	}else{
        		date_1=$('#txtMon').val()+'/01';
        		date_2=$('#txtMon').val()+'/'+lastday;
        		if($('#txtMon').val().substr( 4,5)=="02")
        			dtmp=lastday;
        		else
        			dtmp=30;
        	}
        }
        
        function table_change() {
        	getdtmp();
        	/*if(q_cur==1||q_cur==2){
	        	if ($('#cmbPerson').find("option:selected").text().indexOf('外勞')>-1){
	            	 q_cmbParse("cmbMonkind", ('').concat(new Array('本月')));
	            }else{
	             	q_cmbParse("cmbMonkind", ('').concat(new Array('上期', '下期')));
	            }
        	}*/
             if ($('#cmbPerson').find("option:selected").text().indexOf('本國')>-1){
             	//bbm
            	 $('#lblDaymoney').hide();
            	 $('#txtDaymoney').hide();
            	 $('#lblMtotal').hide();
            	 $('#txtMtotal').hide();
            	 $('#lblMoney').show();
            	 $('#txtMoney').show();
            	 $('#lblMi_total').show();
            	 $('#txtMi_total').show();
            	 //bbs
            	 $('#hid_money').show();
            	 $('#hid_daymoney').hide();
            	 $('#hid_day').hide();
	             $('#hid_mtotal').hide();
	             $('#hid_mi_saliday').show();
	             $('#hid_mi_total').show();
            	 $('#hid_chgcash').hide();
            	 $('#hid_stay_tax').hide();
            	 $('#hid_tax6').hide();
            	 $('#hid_tax12').hide();
            	 $('#hid_tax18').hide();
            	 $('#hid_stay_money').hide();
            	 $('#hid_bo_born').hide();
            	 $('#hid_bo_night').hide();
            	 $('#hid_bo_duty').hide();
            	 $('#hid_ch_labor_comp').show();
            	 $('#hid_ch_labor_self').show();
            	 $('#hid_lodging_power_fee').show();
            	 $('#hid_tax').show();
            	 $('#hid_tax5').show();
            	 for (var j = 0; j < q_bbsCount; j++) {
            	 	 $('#hid_money_'+j).show();
            		 $('#hid_daymoney_'+j).hide();
	            	 $('#hid_day_'+j).hide();
		             $('#hid_mtotal_'+j).hide();
		             $('#hid_mi_saliday_'+j).show();
		             $('#hid_mi_total_'+j).show();
	            	 $('#hid_chgcash_'+j).hide();
	            	 $('#hid_stay_tax_'+j).hide();
	            	 $('#hid_tax6_'+j).hide();
	            	 $('#hid_tax12_'+j).hide();
	            	 $('#hid_tax18_'+j).hide();
	            	 $('#hid_stay_money_'+j).hide();
	            	 $('#hid_bo_born_'+j).hide();
	            	 $('#hid_bo_night_'+j).hide();
	            	 $('#hid_bo_duty_'+j).hide();
	            	 $('#hid_ch_labor_comp_'+j).show();
	            	 $('#hid_ch_labor_self_'+j).show();
	            	 $('#hid_lodging_power_fee_'+j).show();
	            	 $('#hid_tax_'+j).show();
	            	 $('#hid_tax5_'+j).show();
            	 }
            }else if ($('#cmbPerson').find("option:selected").text().indexOf('日薪')>-1){
            		//bbm
            	 	$('#lblDaymoney').show();
	            	 $('#txtDaymoney').show();
	            	 $('#lblMtotal').show();
	            	 $('#txtMtotal').show();
	            	 $('#lblMoney').hide();
	            	 $('#txtMoney').hide();
	            	 $('#lblMi_total').hide();
	            	 $('#txtMi_total').hide();
	            	 //bbs
	            	 $('#hid_money').hide();
            	 	 $('#hid_daymoney').show();
	            	 $('#hid_day').show();
	            	 $('#hid_mtotal').show();
	            	 $('#hid_mi_saliday').hide();
	            	 $('#hid_mi_total').hide();
	            	 $('#hid_chgcash').hide();
	            	 $('#hid_stay_tax').hide();
	            	 $('#hid_tax6').hide();
	            	 $('#hid_tax12').hide();
	            	 $('#hid_tax18').hide();
	            	 $('#hid_stay_money').hide();
	            	 $('#hid_bo_born').hide();
	            	 $('#hid_bo_night').hide();
	            	 $('#hid_bo_duty').hide();
	            	 $('#hid_ch_labor_comp').show();
	            	 $('#hid_ch_labor_self').show();
	            	 $('#hid_lodging_power_fee').show();
	            	 $('#hid_tax').show();
	            	 $('#hid_tax5').show();
            	 	for (var j = 0; j < q_bbsCount; j++) {
            	 		 $('#hid_money_'+j).hide();
            			 $('#hid_daymoney_'+j).show();
            	 		 $('#hid_day_'+j).show();
		            	 $('#hid_mtotal_'+j).show();
		            	 $('#hid_mi_saliday_'+j).hide();
		            	 $('#hid_mi_total_'+j).hide();
		            	 $('#hid_chgcash_'+j).hide();
		            	 $('#hid_stay_tax_'+j).hide();
		            	 $('#hid_tax6_'+j).hide();
		            	 $('#hid_tax12_'+j).hide();
		            	 $('#hid_tax18_'+j).hide();
		            	 $('#hid_stay_money_'+j).hide();
		            	 $('#hid_bo_born_'+j).hide();
		            	 $('#hid_bo_night_'+j).hide();
		            	 $('#hid_bo_duty_'+j).hide();
		            	 $('#hid_ch_labor_comp_'+j).show();
		            	 $('#hid_ch_labor_self_'+j).show();
		            	 $('#hid_lodging_power_fee_'+j).show();
		            	 $('#hid_tax_'+j).show();
		            	 $('#hid_tax5_'+j).show();
            	 	}
            }else{
            		//bbm
            	 	$('#lblDaymoney').hide();
	            	 $('#txtDaymoney').hide();
	            	 $('#lblMtotal').hide();
	            	 $('#txtMtotal').hide();
	            	 $('#lblMoney').show();
	            	 $('#txtMoney').show();
	            	 $('#lblMi_total').show();
	            	 $('#txtMi_total').show();
	            	 //bbs
	            	 $('#hid_money').show();
            		 $('#hid_daymoney').hide();
	            	 $('#hid_day').hide();
		             $('#hid_mtotal').hide();
		             $('#hid_mi_saliday').show();
		             $('#hid_mi_total').show();
	            	 $('#hid_chgcash').show();
	            	 $('#hid_stay_tax').show();
	            	 $('#hid_tax6').show();
	            	 $('#hid_tax12').show();
	            	 $('#hid_tax18').show();
	            	 $('#hid_stay_money').show();
	            	 $('#hid_bo_born').show();
	            	 $('#hid_bo_night').show();
	            	 $('#hid_bo_duty').show();
	            	 $('#hid_ch_labor_comp').hide();
	            	 $('#hid_ch_labor_self').hide();
	            	 $('#hid_lodging_power_fee').hide();
	            	 $('#hid_tax').hide();
	            	 $('#hid_tax5').hide();
            	 	for (var j = 0; j < q_bbsCount; j++) {
            	 		 $('#hid_money_'+j).show();
            			 $('#hid_daymoney_'+j).hide();
            	 		 $('#hid_day_'+j).hide();
			             $('#hid_mtotal_'+j).hide();
			             $('#hid_mi_saliday_'+j).show();
			             $('#hid_mi_total_'+j).show();
		            	 $('#hid_chgcash_'+j).show();
		            	 $('#hid_stay_tax_'+j).show();
		            	 $('#hid_tax6_'+j).show();
		            	 $('#hid_tax12_'+j).show();
		            	 $('#hid_tax18_'+j).show();
		            	 $('#hid_stay_money_'+j).show();
		            	 $('#hid_bo_born_'+j).show();
		            	 $('#hid_bo_night_'+j).show();
		            	 $('#hid_bo_duty_'+j).show();
		            	 $('#hid_ch_labor_comp_'+j).hide();
		            	 $('#hid_ch_labor_self_'+j).hide();
		            	 $('#hid_lodging_power_fee_'+j).hide();
		            	 $('#hid_tax_'+j).hide();
		            	 $('#hid_tax5_'+j).hide();
            	 	}
            }
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
                width: 50%;
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
                float: left;
            }
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
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
        <div class="dview" id="dview" style="float: left;  width:20%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:20%"><a id='vewMon'></a></td>
            </tr>
             <tr>   
                  <td><input id="chkBrow.*" type="checkbox" style=' '/></td>                
                  <td align="center" id='mon'>~mon</td>                                     
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width:78%;float:left">
        <table class="tbbm"  id="tbbm"  border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class="td1"><span> </span><a id="lblMon" class="lbl"></a></td>
            <td class="td2"><input id="txtMon"  type="text" class="txt c1"/></td>
            <td class="td3"><span> </span><a id="lblPerson" class="lbl"></a></td>
            <td class="td4"><select id="cmbPerson" class="txt c1"></select></td>
            <td class="td5"><span> </span><a id="lblMonkind" class="lbl"></a></td>
            <td class="td6"><select id="cmbMonkind" class="txt c1"></select></td>
            <td class="td7"><span> </span><a id="lblType" class="lbl"></a></td>
            <td class="td8"><select id="cmbTypea" class="txt c1"></select></td>
            <td class="td9"><span> </span><a id="lblNoa" class="lbl"></a></td>
            <td class="td10"><input id="txtNoa"  type="text" class="txt c1"/></td>
            <td class="td11"><input id="btnInput" type="button" style="width: auto;font-size: medium;"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblMoney" class="lbl"></a><a id="lblDaymoney" class="lbl"></a></td>
            <td class="td2"><input id="txtMoney"  type="text" class="txt num c1" /><input id="txtDaymoney"  type="text" class="txt num c1" /></td>
            <td class="td3"><span> </span><a id="lblPubmoney" class="lbl"></a></td>
            <td class="td4"><input id="txtPubmoney"  type="text" class="txt num c1" /></td>
            <td class="td5"><span> </span><a id="lblBo_admin" class="lbl"></a></td>
            <td class="td6"><input id="txtBo_admin"  type="text" class="txt num c1" /></td>
            <td class="td7"><span> </span><a id="lblBo_traffic" class="lbl"></a></td>
            <td class="td8"><input id="txtBo_traffic"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
            <td class="td1"><span> </span><a id="lblBo_special" class="lbl"></a></td>
            <td class="td2"><input id="txtBo_special"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblBo_oth" class="lbl"></a></td>
            <td class="td4"><input id="txtBo_oth"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblTax_other" class="lbl"></a></td>
            <td class="td6"><input id="txtTax_other"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblMi_total" class="lbl"></a><a id="lblMtotal" class="lbl"></a></td>
            <td class="td8"><input id="txtMi_total"  type="text" class="txt num c1"/><input id="txtMtotal"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
        	<td class="td1"><span> </span><a id="lblBo_full" class="lbl"></a></td>
            <td class="td2"><input id="txtBo_full"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblAddmoney" class="lbl"></a></td>
            <td class="td4"><input id="txtAddmoney"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblBorrow" class="lbl"></a></td>
            <td class="td6"><input id="txtBorrow"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblCh_labor" class="lbl"></a></td>
            <td class="td8"><input id="txtCh_labor"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
           	<td class="td5"><span> </span><a id="lblCh_health" class="lbl"></a></td>
            <td class="td6"><input id="txtCh_health"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblCh_labor_comp" class="lbl"></a></td>
            <td class="td8"><input id="txtCh_labor_comp"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblCh_labor_self" class="lbl"></a></td>
            <td class="td8"><input id="txtCh_labor_self"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblWelfare" class="lbl"></a></td>
            <td class="td8"><input id="txtWelfare"  type="text" class="txt num c1"/></td>
        </tr>
        <tr>
        	<td class="td1"><span> </span><a id="lblTotal3" class="lbl"></a></td>
            <td class="td2"><input id="txtTotal3"  type="text" class="txt num c1"/></td>
            <td class="td3"><span> </span><a id="lblTotal4" class="lbl"></a></td>
            <td class="td4"><input id="txtTotal4"  type="text" class="txt num c1"/></td>
            <td class="td5"><span> </span><a id="lblTotal5" class="lbl"></a></td>
            <td class="td6"><input id="txtTotal5"  type="text" class="txt num c1"/></td>
            <td class="td7"><span> </span><a id="lblWorker" class="lbl"></a></td>
            <td class="td8"><input id="txtWorker" type="text" class="txt c1"/><input id="txtDatea" type="hidden" class="txt c1"/></td>
        </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1' style="width: 5000px;">
            <tr style='color:White; background:#003366;' >
                <td align="center" class="td1"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;font-size: 16px;"  /> </td>
                <td align="center" class="td1"><a id='lblSno'></a></td>
                <td align="center" class="td2"><a id='lblNamea'></a></td>
                <td align="center" class="td2" id='hid_money'><a id='lblMoneys'></a></td>
                <td align="center" class="td2" id='hid_daymoney'><a id='lblDaymoneys'></a></td>
                <td align="center" class="td2"><a id='lblPubmoneys'></a></td>
                <td align="center" class="td2"><a id='lblBo_admins'></a></td>
                <td align="center" class="td2"><a id='lblBo_traffics'></a></td>
                <td align="center" class="td2"><a id='lblBo_specials'></a></td>
                <td align="center" class="td2"><a id='lblBo_oths'></a></td>
                <td align="center" class="td2"><a id='lblTotal1s'></a></td>
                <td align="center" class="td2"><a id='lblCh_labor1s'></a></td>
                <td align="center" class="td2"><a id='lblCh_labor2s'></a></td>
                <td align="center" class="td2"><a id='lblCh_health_insures'></a></td>
                <td align="center" class="td2" id='hid_day'><a id='lblDays'></a></td>
                <td align="center" class="td2" id='hid_mtotal'><a id='lblMtotals'></a></td>
                <td align="center" class="td2" id='hid_mi_saliday'><a id='lblMi_salidays'></a></td>
                <td align="center" class="td2" id='hid_mi_total'><a id='lblMi_totals'></a></td>
                <td align="center" class="td2" id='hid_bo_born'><a id='lblBo_borns'></a></td>
                <td align="center" class="td2" id='hid_bo_night'><a id='lblBo_nights'></a></td>
                <td align="center" class="td2" ><a id='lblBo_fulls'></a></td>
                <td align="center" class="td2" id='hid_bo_duty'><a id='lblBo_dutys'></a></td>
                <td align="center" class="td2" ><a id='lblTax_others'></a></td>
                <td align="center" class="td2"><a id='lblTotal2s'></a></td>
                <td align="center" class="td2"><a id='lblOstands'></a></td>
                <td align="center" class="td2"><a id='lblAddh2_1s'></a></td>
                <td align="center" class="td2"><a id='lblAddh2_2s'></a></td>
                <td align="center" class="td2"><a id='lblAddmoneys'></a></td>
                <td align="center" class="td2"><a id='lblAddh100s'></a></td>
                <td align="center" class="td2"><a id='lblAddh46_1s'></a></td>
                <td align="center" class="td2"><a id='lblAddh46_2s'></a></td>
                <td align="center" class="td2" ><a id='lblTax_other2s'></a></td>
                <td align="center" class="td2"><a id='lblTotal3s'></a></td>
                <td align="center" class="td2"><a id='lblBorrows'></a></td>
                <td align="center" class="td2"><a id='lblCh_labors'></a></td>
                <td align="center" class="td2" id='hid_chgcash'><a id='lblChgcashs'></a></td>
                <td align="center" class="td2" id='hid_tax6'><a id='lblTax6s'></a></td>
                <td align="center" class="td2" id='hid_stay_tax'><a id='lblStay_taxs'></a></td>
                <td align="center" class="td2" id='hid_tax12'><a id='lblTax12s'></a></td>
                <td align="center" class="td2" id='hid_tax18'><a id='lblTax18s'></a></td>
                <td align="center" class="td2" id='hid_ch_labor_comp'><a id='lblCh_labor_comps'></a></td>
                <td align="center" class="td2" id='hid_ch_labor_self'><a id='lblCh_labor_selfs'></a></td>
                <td align="center" class="td2" id='hid_lodging_power_fee'><a id='lblLodging_power_fees'></a></td>
                <td align="center" class="td1" id='hid_tax'><a id='lblTaxs'></a></td>
                <td align="center" class="td1" id='hid_tax5'><a id='lblTax5s'></a></td>
                <td align="center" class="td1"><a id='lblWelfares'></a></td>
                <td align="center" class="td1"><a id='vewIswelfare'></a></td>
                <td align="center" class="td2" id='hid_stay_money'><a id='lblStay_moneys'></a></td>
                <td align="center" class="td1"><a id='lblRaise_nums'></a></td>
                <td align="center" class="td2"><a id='lblCh_healths'></a></td>
                <td align="center" class="td2"><a id='lblTotal4s'></a></td>
                <td align="center" class="td2"><a id='lblTotal5s'></a></td>
                <td align="center" class="td2"><a id='lblLate'></a></td>
                <td align="center"colspan="2"><a id='lblHr_sick'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_person'></a></td>
                <td align="center"colspan="2" ><a id='lblHr_nosalary'></a></td>
                <td align="center"colspan="2"><a id='lblHr_leave'></a></td>
                <td align="center" class="td2"><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td ><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;font-size: 16px;float: center;" /></td>
                <td ><input class="txt c1" id="txtSno.*" type="text" /><input id="txtNoq.*" type="hidden" /></td>
                <td ><input class="txt c1" id="txtNamea.*" type="text" /></td>
                <td id='hid_money.*'><input class="txt num c1" id="txtMoney.*" type="text" /></td>
                <td id='hid_daymoney.*'><input class="txt num c1" id="txtDaymoney.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtPubmoney.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_admin.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_traffic.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_special.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtBo_oth.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal1.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_labor1.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_labor2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_health_insure.*" type="text" /></td>
                <td id='hid_day.*'><input class="txt num c1" id="txtDay.*" type="text" /></td>
                <td id='hid_mtotal.*'><input class="txt num c1" id="txtMtotal.*" type="text" /></td>
                <td id='hid_mi_saliday.*'><input class="txt num c1" id="txtMi_saliday.*" type="text" /></td>
                <td id='hid_mi_total.*'><input class="txt num c1" id="txtMi_total.*" type="text" /></td>
                <td id='hid_bo_born.*'><input class="txt num c1" id="txtBo_born.*" type="text" /></td>
                <td id='hid_bo_night.*'><input class="txt num c1" id="txtBo_night.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBo_full.*" type="text"/></td>
                <td id='hid_bo_duty.*'><input class="txt num c1" id="txtBo_duty.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTax_other.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtTotal2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtOstand.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddh2_1.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddh2_2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddmoney.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddh100.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddh46_1.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtAddh46_2.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTax_other2.*" type="text"/></td>
                <td ><input class="txt num c1" id="txtTotal3.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtBorrow.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_labor.*" type="text" /></td>
                <td id='hid_chgcash.*'><input class="txt num c1" id="txtChgcash.*" type="text" /></td>
                <td id='hid_tax6.*'><input class="txt num c1" id="txtTax6.*" type="text" /></td>
                <td id='hid_stay_tax.*'><input class="txt num c1" id="txtStay_tax.*" type="text" /></td>
                <td id='hid_tax12.*'><input class="txt num c1" id="txtTax12.*" type="text" /></td>
                <td id='hid_tax18.*'><input class="txt num c1" id="txtTax18.*" type="text" /></td>
                <td id='hid_ch_labor_comp.*'><input class="txt num c1" id="txtCh_labor_comp.*" type="text" /></td>
                <td id='hid_ch_labor_self.*'><input class="txt num c1" id="txtCh_labor_self.*" type="text" /></td>
                <td id='hid_lodging_power_fee.*'><input class="txt num c1" id="txtLodging_power_fee.*" type="text" /></td>
                <td id='hid_tax.*'><input class="txt num c1" id="txtTax.*" type="text" /></td>
                <td id='hid_tax5.*'><input class="txt num c1" id="txtTax5.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtWelfare.*" type="text" /></td>
                <td ><input id="chkIswelfare.*" type="checkbox"/></td>
                <td id='hid_stay_money.*'><input class="txt num c1" id="txtStay_money.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtRaise_num.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtCh_health.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal4.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtTotal5.*" type="text" /></td>
                <td ><input class="txt num c1" id="txtLate.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_sick.*" type="text" />HR</td> 
                <td class="td2">&#36; <input class="txt num c2" id="txtMi_sick.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_person.*" type="text" />HR</td>
                <td class="td2">&#36; <input class="txt num c2" id="txtMi_person.*" type="text"/></td>
                <td class="td2"><input class="txt num c3" id="txtHr_nosalary.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt num c2" id="txtMi_nosalary.*" type="text" /></td>
                <td class="td2"><input class="txt num c3" id="txtHr_leave.*" type="text" />HR</td>
                <td class="td2">&#36;<input class="txt c2" id="txtMi_leave.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text" /></td>
           </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
