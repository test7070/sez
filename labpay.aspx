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
            var q_name = "labpay";
            var q_readonly = ['txtNoa', 'txtApprover','txtAccno','txtBvccno','txtEvccno','txtDatea'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtMoney', 14, 0, 1], ['txtPlusmoney', 14, 0, 1], ['txtMinusmoney', 14, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_desc = 1;
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtSalesno', 'lblSalesno', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            				 ['txtProductno', 'lblProduct', 'ucc', 'noa,product,vccacc1,vccacc2', 'txtProductno,txtProduct,txtAcc1,txtAcc2', 'ucc_b.aspx'],
            				 ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
							 ['txtUcc3', 'lblUcc3', 'ucc', 'noa,product,vccacc1,vccacc2', 'txtUcc3,txtUcc4,txtAcc3,txtAcc4', 'ucc_b.aspx'],
            				 ['txtAcc3', 'lblAcc3', 'acc', 'acc1,acc2', 'txtAcc3,txtAcc4', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
             				 ['txtCustno_', 'btnCustno_', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx'],
            				 ['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx'],
							 ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx'],
							 ['txtAcc1_', 'btnAcc_', 'acc', 'acc1,acc2', 'txtAcc1_,txtAcc2_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno],
							 ['txtProductno2_', 'btnProductno2_', 'ucc', 'noa,product,vccacc1,vccacc2', 'txtProductno2_,txtProduct2_,txtAcc3_,txtAcc4_', 'ucc_b.aspx'],
							 ['txtAcc3_', 'btnAcc1_', 'acc', 'acc1,acc2', 'txtAcc3_,txtAcc4_', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);


            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd],['txtPaydate', r_picd]];
                q_mask(bbmMask);
                $('#txtAcc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
                $('#btnGenvcc').click(function() {
                    q_func('labpay.genVcc', $('#txtNoa').val());
                });
                $('#lblAccno').click(function() {
                	if(!emp($('#txtDatea').val()))
                    	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr( 0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAcc'), true);
                });
                $('#lblVccno').click(function() {
			        t_bvccno = $('#txtBvccno').val();
			        t_evccno = $('#txtEvccno').val();
			        t_noa = $('#txtNoa').val();
        			//var t_where = " 1=1 " + q_sqlPara2("noa", t_bvccno,t_evccno);
        			var t_where = " 1=1 " + q_sqlPara2("ordeno", t_noa);
					//q_pop('txtBvccno', "vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where +";" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
					q_pop('txtNoa', "vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where +";" + $('#txtDatea').val().substr( 0,3) + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
                
                });
				/*$('#lblPaybno').click(function() {
					t_where = "noa='" + $('#txtPaybno').val() + "'";
					q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPaytran'));
				});*/
				$('#btnImport').click(function () {
                	if(emp($('#txtSalesno').val()) || emp($('#txtSales').val())){
                		alert('請先輸入[業務]!!');
                		$('#txtSalesno').focus();
                		return;
                	}
                	if(emp($('#txtProductno').val()) || emp($('#txtProduct').val())){
                		alert('請先輸入[收入品名]!!');
                		$('#txtProductno').focus();
                		return;
                	}
                	
                	if(emp($('#txtDatea').val()))
                		$('#txtDatea').val(q_date());
                	
		            var t_where = "where=^^ salesno ='"+$('#txtSalesno').val()+"' ";
		            //t_where+= "and sales ='"+$('#txtSales').val()+"' ";
		            t_where+= "and productno ='"+$('#txtProductno').val()+"' ";
		            //t_where+= "and product ='"+$('#txtProduct').val()+"' ";
		            t_where+=" ^^";
			        q_gt('custroutine', t_where , 0, 0, 0, "", r_accy);
		     	});

            }

            function q_popPost(s1) {
                switch (s1) {
                    case 'txtProductno':
                        $('#txtAcc1').focus();
                        break;
                    case 'txtProductno_':
                        $('#txtMoney_' + b_seq).focus();
                        break;
                    case 'txtProductno2_':
                        $('#txtPlusmoney_' + b_seq).focus();
                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'holiday':
	            		holiday = _q_appendData("holiday", "", true);
	            		endacheck($('#txtDatea').val(),3);//單據日期,幾天後關帳
	            	break;
                	case 'payaccs':
                		t_payaccs = _q_appendData("payaccs", "", true);
                	break;
                	case 'vcc':
                		t_vcc = _q_appendData("vcc", "", true);
                	break;
                    case 'custroutine':
                    
                    	var custroutine = _q_appendData("custroutine", "", true);
		            	var custroutines = _q_appendData("custroutines", "", true);
		            	
		            	for(var i = 0;i < custroutines.length;i++){
		            		var inrange=false;
		            		for(var j = 0;j < custroutine.length;j++){
		            			if(custroutines[i].noa==custroutine[j].noa)
		            				inrange=true;
		            		}
		            		if(!inrange){
		            			custroutines.splice(i, 1);
	                            i--;
		            		}
		            	}
		            	
		            	//判斷是否在區間內
		            	for(var i = 0;i < custroutines.length;i++){
		            		if(!($('#txtDatea').val()>=custroutines[i].bdate && $('#txtDatea').val()<=custroutines[i].edate)){
				            	custroutines.splice(i, 1);
	                            i--;
                           }
		            	}
		            	
		            	for(var i = 0;i < custroutines.length;i++){
			            	custroutines[i].productno=$('#txtProductno').val();
			            	custroutines[i].product=$('#txtProduct').val();
		            	}

		            	q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtComp,txtMount,txtProduct,txtProductno,txtMoney'
		            								, custroutines.length, custroutines, 'custno,comp,mount,product,productno,money', 'txtCustno,txtComp,txtProductno,txtProduct');
		            	
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function btnOk() {
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                $('#txtWorker').val(r_name)
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_labpay') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('labpay_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                        $('#txtAcc1_' + j).change(function() {
                            var s1 = trim($(this).val());
                            if (s1.length > 4 && s1.indexOf('.') < 0)
                                $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                            if (s1.length == 4)
                                $(this).val(s1 + '.');
                        });
                        $('#txtCustno_' + j).focusout(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            $('#txtAcc1_' + b_seq).val($('#txtAcc1').val());
                            $('#txtAcc2_' + b_seq).val($('#txtAcc2').val());
                        });

                    }
                }
                _bbsAssign();
                if(q_cur==2){
                	if(t_payaccs[0] != undefined){
	                	for (var i = 0; i < q_bbsCount; i++) {
		                	for (var j = 0; j < t_payaccs.length; j++) {
		                		if($("#txtCustno_"+i).val()==t_payaccs[j].custno && $("#txtProductno_"+i).val()==t_payaccs[j].productno && $("#txtMemo_"+i).val()==t_payaccs[j].memo2){
		                			$('#btnMinus_'+j).attr('disabled', 'disabled');
									$('#btnCustno_'+j).attr('disabled', 'disabled');
									$('#txtCustno_'+j).attr('disabled', 'disabled');
		                			$('#txtComp_'+j).attr('disabled', 'disabled');
		                			$('#btnProductno_'+j).attr('disabled', 'disabled');
		                			$('#txtProductno_'+j).attr('disabled', 'disabled');
		                			$('#txtProduct_'+j).attr('disabled', 'disabled');
		                			$('#txtMount_'+j).attr('disabled', 'disabled');
		                			$('#txtMoney_'+j).attr('disabled', 'disabled');
		                			$('#btnProductno2_'+j).attr('disabled', 'disabled');
		                			$('#txtProductno2_'+j).attr('disabled', 'disabled');
		                			$('#txtProduct2_'+j).attr('disabled', 'disabled');
		                			$('#txtPlusmoney_'+j).attr('disabled', 'disabled');
		                			$('#txtMinusmoney_'+j).attr('disabled', 'disabled');
		                			$('#btnAcc1_'+j).attr('disabled', 'disabled');
		                			$('#txtAcc3_'+j).attr('disabled', 'disabled');
		                			$('#txtAcc4_'+j).attr('disabled', 'disabled');
		                			$('#txtMemo_'+j).attr('disabled', 'disabled');
		                		}	                		
		                	}
	                	}
	                }
                }
            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
				var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['bvccno'] = s2[1];
                abbm[q_recno]['evccno'] = s2[2];
               // abbm[q_recno]['paybno'] = s2[3];
                $('#txtAccno').val(s2[0]);
                //$('#txtBvccno').val(s2[0]);
                //$('#txtEvccno').val(s2[1]);
                $('#txtBvccno').val(s2[1]);
                $('#txtEvccno').val(s2[2]);
               // $('#txtPaybno').val(s2[3]);
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
				if($('#txtDatea').val().substring(0,6) < '102/04'){
					alert('禁止修改!!');
					return;
				}
				if (checkenda){
	                alert('已關帳!!');
	                return;
				}
                _btnModi();
                $('#txtDatea').focus();
                
                if(t_payaccs[0] != undefined){
                	for (var i = 0; i < q_bbsCount; i++) {
	                	for (var j = 0; j < t_payaccs.length; j++) {
	                		if($("#txtCustno_"+i).val()==t_payaccs[j].custno && $("#txtProductno_"+i).val()==t_payaccs[j].productno && $("#txtMemo_"+i).val()==t_payaccs[j].memo2){
	                			$('#btnMinus_'+j).attr('disabled', 'disabled');
								$('#btnCustno_'+j).attr('disabled', 'disabled');
								$('#txtCustno_'+j).attr('disabled', 'disabled');
	                			$('#txtComp_'+j).attr('disabled', 'disabled');
	                			$('#btnProductno_'+j).attr('disabled', 'disabled');
	                			$('#txtProductno_'+j).attr('disabled', 'disabled');
	                			$('#txtProduct_'+j).attr('disabled', 'disabled');
	                			$('#txtMount_'+j).attr('disabled', 'disabled');
	                			$('#txtMoney_'+j).attr('disabled', 'disabled');
	                			$('#btnProductno2_'+j).attr('disabled', 'disabled');
	                			$('#txtProductno2_'+j).attr('disabled', 'disabled');
	                			$('#txtProduct2_'+j).attr('disabled', 'disabled');
	                			$('#txtPlusmoney_'+j).attr('disabled', 'disabled');
	                			$('#txtMinusmoney_'+j).attr('disabled', 'disabled');
	                			$('#btnAcc1_'+j).attr('disabled', 'disabled');
	                			$('#txtAcc3_'+j).attr('disabled', 'disabled');
	                			$('#txtAcc4_'+j).attr('disabled', 'disabled');
	                			$('#txtMemo_'+j).attr('disabled', 'disabled');
	                		}	                		
	                	}
                	}
                }
            }

            function btnPrint() {
                //q_box('z_labpay.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0, t_total = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j
            }
			
			var t_payaccs,t_vcc;
            function refresh(recno) {
                _refresh(recno);
                if(r_rank<=8)
	            	q_gt('holiday', "where=^^ noa>='"+$('#txtDatea').val()+"'^^" , 0, 0, 0, "", r_accy);//單據日期之後的假日
	            else
	            	checkenda=false;
	            	
                if(q_cur==0||q_cur==4){
                	var t_where = "where=^^ rc2no ='"+$('#txtNoa').val()+"' ^^";
                	q_gt('payaccs', t_where , 0, 0, 0, "", r_accy);
                	var t_where = "where=^^ ordeno ='"+$('#txtNoa').val()+"' and payed!=0 ^^";
                	q_gt('vcc', t_where , 0, 0, 0, "", r_accy);
                }
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
            	if(t_payaccs[0]!= undefined || t_vcc[0]!=undefined){
            		alert('該單據內已收款或代付，無法刪除!!');
            		return;
            	}
            	
	            if (checkenda){
	                alert('已關帳!!');
	                return;
				}
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            
		var checkenda=false;
		var holiday;//存放holiday的資料
		function endacheck(x_datea,x_day) {
			//102/06/21 7月份開始資料3日後不能在處理
			var t_date=x_datea,t_day=1;
                
			while(t_day<x_day){
				var nextdate=new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2)));
				nextdate.setDate(nextdate.getDate() +1)
				t_date=''+(nextdate.getFullYear()-1911)+'/';
				//月份
				t_date=t_date+((nextdate.getMonth()+1)<10?('0'+(nextdate.getMonth()+1)+'/'):((nextdate.getMonth()+1)+'/'));
				//日期
				t_date=t_date+(nextdate.getDate()<10?('0'+(nextdate.getDate())):(nextdate.getDate()));
	                	
				//六日跳過
				if(new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==0 //日
				||new Date(dec(t_date.substr(0,3))+1911,dec(t_date.substr(4,2))-1,dec(t_date.substr(7,2))).getDay()==6 //六
				){continue;}
	                	
				//假日跳過
				if(holiday){
					var isholiday=false;
					for(var i=0;i<holiday.length;i++){
						if(holiday[i].noa==t_date){
							isholiday=true;
							break;
						}
					}
					if(isholiday) continue;
				}
	                	
				t_day++;
			}
                
			if (t_date<q_date()){
				checkenda=true;
			}else{
				checkenda=false;
			}
		}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 30%;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 70%;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 50%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 20%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
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
            input[type="text"], input[type="button"], select {
                font-size: medium;
            }
            .num {
                text-align: right;
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
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'></a></td>
						<td align="center" style="width:25%"><a id='vewNoa'></a></td>
						<td align="center" style="width:20%"><a id='vewDatea'></a></td>
						<td align="center" style="width:25%"><a id='vewSales'></a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='sales'>~sales</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2">	<input id="txtDatea"  type="text" class="txt c1" /></td>
						<td class="td3"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4">	<input id="txtNoa" type="text" class="txt c1" /></td>
						<td class="td5"></td>
						<td class="td6"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSalesno' class="lbl btn"></a></td>
						<td class="td2"><input id="txtSalesno"  type="text" class="txt c1" /></td>
						<td class="td3" colspan="2"><input id="txtSales" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblProduct' class="lbl btn"></a></td>
						<td class="td2"><input id="txtProductno"  type="text" class="txt c1" /></td>
						<td class="td3"><input id="txtProduct" type="text" class="txt c1" /></td>
						<td class="td4"><input id="btnImport" type="button" /></td>
						<!--
						<td class="td4"><span> </span><a id='lblMoney' class="lbl"></a></td>
						<td class="td5"><input id="txtMoney"  type="text" class="txt num c1" /></td>
						-->
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAcc1' class="lbl btn"></a></td>
						<td class="td2"><input id="txtAcc1"  type="text" class="txt c1" /></td>
						<td class="td3" colspan="2"><input id="txtAcc2" type="text" class="txt c1" /></td>
					</tr>
					<!--
					<tr>
						<td class="td1"><span> </span><a id='lblAcc3' class="lbl btn"></a></td>
						<td class="td2">
						<input id="txtAcc3"  type="text" class="txt c1" />
						</td>
						<td class="td3" colspan="2">
						<input id="txtAcc4" type="text" class="txt c1" />
						</td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblUcc3' class="lbl btn"></a></td>
						<td class="td2">
						<input id="txtUcc3"  type="text" class="txt c1" />
						</td>
						<td class="td3" colspan="2">
						<input id="txtUcc4" type="text" class="txt c1" />
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					-->
					<tr>
						<td class="td1"><span> </span><a id="lblMemo" class="lbl"></a></td>
						<td class="td2" colspan="3"><input id="txtMemo"  type="text"  style="width: 99%;"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblVccno" class="lbl btn"></a></td>
						<td class="td2" colspan="2">
							<input id="txtBvccno"  type="text" style="float:left; width:45%;"/>
							<span style="float:left; width:5px;"> </span><span style="float:left; width:15px; font-weight: bold;font-size: 15px;">～</span><span style="float:left; width:5px;"> </span>
							<input id="txtEvccno"  type="text" style="float:left; width:45%;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id="lblAccno" class="lbl btn"></a></td>
						<td class="td2"><input id="txtAccno" type="text" class="txt c1" /></td>
					</tr>
					<!--
					<tr>
						<td></td>
						<td>
						<input id="btnGenvcc"  type="button"  />
						</td>
					</tr>
					-->
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:1%;"></td>
					<td align="center" style="width:12%;"><a id='lblCustno_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblProductno_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblMount_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblMoney_s'></a></td>
					<!--<td align="center" style="width:12%;"><a id='lblAcc1_s'></a></td>-->
					<td align="center" style="width:12%;"><a id='lblProductno2_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblPlusmoney_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblMinusmoney_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblAcc2_s'></a></td>
					<td align="center" style="width:8%;"><a id='lblMemo_s'></a></td>
					<!--
					<td align="center" style="width:8%;"><a id='lblCost_s'></a></td>
					<td align="center" style="width:12%;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblPaybno_s'> </a></td>
					-->
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn"  id="btnCustno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtCustno.*"  style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtComp.*"  style="width:85%; float:left;"/>
					</td>
					<td>
						<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtProductno.*"  style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct.*"  style="width:85%; float:left;"/>
					</td>
					<td >
						<input id="txtMount.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
					<td >
						<input id="txtMoney.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
					<!--
					<td>
						<input class="btn"  id="btnAcc.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtAcc1.*"  style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtAcc2.*"  style="width:85%; float:left;"/>
					</td>
					-->
					<td>
						<input class="btn"  id="btnProductno2.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtProductno2.*"  style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct2.*"  style="width:85%; float:left;"/>
					</td>
					<td >
						<input id="txtPlusmoney.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
					<td >
						<input id="txtMinusmoney.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
					<td>
						<input class="btn"  id="btnAcc1.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
						<input type="text" id="txtAcc3.*"  style="width:85%; float:left;"/>
						<span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtAcc4.*"  style="width:85%; float:left;"/>
					</td>
					<td >
						<input id="txtMemo.*" type="text" style="width:95%;float:left;"/>
					</td>
					<!--
					<td>
					<input id="txtCost.*" type="text" style="width:95%;float:left;text-align: right;"/>
					</td>
					<td>
					<input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
					<input type="text" id="txtTggno.*"  style="width:85%; float:left;"/>
					<span style="display:block; width:1%;float:left;"> </span>
					<input type="text" id="txtTgg.*"  style="width:85%; float:left;"/>
					</td>
					<td>
					<input id="txtPaybno.*" type="text"/>
					</td>
					-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
