<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_tables = 's';
            var q_name = "assignwork";
            var q_readonly = ['txtWorker','txtNoa','txtVccno','txtPaybno','txtAccno','txtMoney','txtCost'];
            var q_readonlys = [];
            var bbmNum = [['txtMoney',14, 0, 1],['txtCost',14, 0, 1]];
            var bbsNum = [['txtMoney',14, 0, 1],['txtCost',14, 0, 1],['txtRealcost',14, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2= 13;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,conn,conntel', 'txtCustno,txtComp,txtCustnick,txtConn,txtConntel', 'cust_b.aspx'],
            ['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtComp_', 'tgg_b.aspx'],
            ['txtItemno', 'lblItem', 'assignment', 'noa,item', 'txtItemno,txtItem', 'assignment_b.aspx'],
            ['txtSalesno', 'lblSales', 'sss', 'noa,namea', 'txtSalesno,txtSales', 'sss_b.aspx'],
            ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea,partno', 'txtSalesno2,txtSales2,cmbPartno2', 'sss_b.aspx'],
            ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
            	q_getFormat();
                bbmMask = [['txtOdate', r_picd], ['txtWdate', r_picd], ['txtPaydate', r_picd], ['txtEnddate', r_picd]];
            	q_mask(bbmMask);
            	bbsMask = [['txtSenddate', r_picd], ['txtApprdate', r_picd], ['txtRepdate', r_picd]];
            	q_cmbParse("cmbProject", ('').concat(new Array( '設立','預查','負責人','公司名稱','股東變更','遷址','董監改選','董監補選','董監持股變動','董監解任','變更印鑑','增資','減資','增減資','營業項目','停業','復業','抄錄','公司證明','資格證明','歇業','遺產稅','贈產稅','修章')));
            	q_cmbParse("cmbProduct", ('').concat(new Array( '','行號預查規費','公司預查規費','銀行手續費','會計師簽證費','營利規費','公司規費','特許規費','建管規費','運輸執照規費','代刻印章','代登報紙','雜項規費','代辦費')),'s');
            	
                q_gt('part', '', 0, 0, 0, "");
                 q_cmbParse("cmbKind", ('').concat(new Array( '工商','土地')));
                
            	$('#btnInput').click(function () {
            		if(emp($('#txtItemno').val())){
            			alert('請先輸入項目!!');
            		return;
            	}
		           	t_where = "where=^^ noa=(select noa from assignment where noa ='"+$('#txtItemno').val()+"') ^^"
		           	q_gt('assignment', t_where , 0, 0, 0, "", r_accy);
	        	});
             	$('#lblVccno').click(function() {
		     		t_where = "noa='" + $('#txtVccno').val() + "'";
            		q_box("vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vcc', "95%", "95%", q_getMsg('popVcctran'));
             	});
             	$('#lblPaybno').click(function() {
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "95%", q_getMsg('popPaytran'));
             	});
                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substring(0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAccc'), true);
                });
                
                $('#cmbKind').change(function() {
                	if ($('#cmbKind').find("option:selected").text().indexOf('工商')>-1){
                		if(q_bbsCount<=10)
                			$('#btnPlus'+j).click();
                		for (var j = 0; j < q_bbsCount; j++) {
                			$('#btnMinus_'+j).click();	
                		}
                		//工商自動帶產品內容與費用
	            		autoicins();
	            		$(".land").hide();
                	}
                	if ($('#cmbKind').find("option:selected").text().indexOf('土地')>-1){
                		for (var j = 0; j < q_bbsCount; j++) {
                			$('#btnMinus_'+j).click();	
                		}
                		$(".land").show();
                	}
                });
                
                $('#btnAssignpaper').click(function (e) {
		            q_box("assignpaper.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'assignpaper', "95%", "95%", q_getMsg("popAssignpaper"));
		        });
            }
			function cmbpaybno(id){
					t_where = "noa='" + $('#txtPaybno' + id).val() + "'";
            		q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'payb', "95%", "650px", q_getMsg('popPayb'));
			}
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
            	switch (t_name) {
            		case 'assignment':
	            	var as = _q_appendData("assignments", "", true);
	            	q_gridAddRow(bbsHtm, 'tbbs', 'txtTggno,txtComp,txtProduct,txtDays,txtMoney,txtCost,txtMemo', as.length, as, 'tggno,comp,product,days,money,cost,memo', '');
	            	sum();
            	break;
                	case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno2", t_item);
                             if (abbm[q_recno] != undefined) {
	                        	$("#cmbPartno2").val(abbm[q_recno].partno2);
	                        }
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
				var s2 = xmlString.split(';');
                abbm[q_recno]['accno'] = s2[0];
                abbm[q_recno]['vccno'] = s2[1];
                abbm[q_recno]['paybno'] = s2[2];
                $('#txtAccno').val(s2[0]);
                $('#txtVccno').val(s2[1]);
                $('#txtPaybno').val(s2[2]);
            }
            
            function btnOk() {
            	var t_err = '';
            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
 
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                $('#txtPronick').val($('#cmbProject').val().substr(0,15));
                
                sum();
                $('#txtWorker').val(r_name);
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll('F' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('assignwork_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
           
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtItemno').focus();
                $('#txtDatea').val(q_date());
                $('#txtOdate').val(q_date());
                $('#txtWdate').val(q_date());
				t_date = new Date(dec(q_date().substring(0,3))+1911 + q_date().substring(3));
	            t_date.setDate(t_date.getDate()+4);
	            t_year = t_date.getUTCFullYear()-1911;
	            t_year = t_year>99?t_year+'':'0'+t_year;
	            t_month = t_date.getUTCMonth()+1;
	            t_month = t_month>9?t_month+'':'0'+t_month;
	            t_day = t_date.getUTCDate();
	            t_day = t_day>9?t_day+'':'0'+t_day;
	            $('#txtPaydate').val(t_year+'/'+t_month+'/'+t_day);
	            //$('#cmbPartno2').val('06');
	            $('#txtSalesno').val(r_userno);
	            $('#txtSales').val(r_name);
	            
	            //工商自動帶產品內容與費用
	            //autoicins();
            }
            
            function autoicins() {
            	/*$('#txtProduct_0').val('行號預查規費');
	            q_tr('txtCost_0',300);
	            q_tr('txtRealcost_0',310);
	            $('#txtProduct_1').val('公司預查規費');
	            q_tr('txtCost_1',150);
	            q_tr('txtRealcost_1',160);
	            $('#txtProduct_2').val('銀行手續費');
	            q_tr('txtCost_2',10);
	            $('#txtProduct_2').val('會計師簽證費');
	            q_tr('txtCost_2',400);
	            q_tr('txtRealcost_2',400);
	            $('#txtProduct_3').val('營利規費');
	            q_tr('txtCost_3',1000);
	            q_tr('txtRealcost_3',1000);
	            $('#txtProduct_4').val('公司規費');
	            q_tr('txtCost_4',1000);
	            q_tr('txtRealcost_4',1000);
	            $('#txtProduct_5').val('特許規費');
	            $('#txtProduct_6').val('運輸執照規費');
	            $('#txtProduct_7').val('代刻印章');
	            $('#txtProduct_8').val('代登報紙');
	            $('#txtProduct_9').val('雜項規費');*/
            }
            
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();           
                $('#txtNoa').attr('readonly','readonly');
                $('#txtItemno').focus();
            }
            function btnPrint() {
            	q_box('z_assignwork.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
             
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtMoney_'+i).blur(function () {
			            	sum();
			       		});
			       		$('#txtCost_'+i).blur(function () {
			            	sum();
			       		});
			       		$('#chkIsprepay_'+i).change(function () {
			            	sum();
			       		});
                    }
                }
                _bbsAssign();
                	if ($('#cmbKind').find("option:selected").text().indexOf('工商')>-1){
	            		$(".land").hide();
                	}
                	if ($('#cmbKind').find("option:selected").text().indexOf('土地')>-1){
                		$(".land").show();
                	}
            }

            function bbsSave(as) {
                if (!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                
                return true;
            }

            function sum() {
            	var t1 = 0,t_money = 0,t_cost=0;
            	for (var j = 0; j < q_bbsCount; j++) {
					t_money+=dec($('#txtMoney_'+j).val());
					if($('#chkIsprepay_'+j)[0].checked){
						if(dec($('#txtRealcost_'+j).val())!=0)
							t_cost+=dec($('#txtRealcost_'+j).val());
						else
							t_cost+=dec($('#txtCost_'+j).val());
					}
            	}  // j
				q_tr('txtMoney',t_money);
				q_tr('txtCost',t_cost);
            }
            
            function refresh(recno) {
                _refresh(recno);
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
				if (q_cur != 1 && q_cur != 2) {
                  $('#btnInput').attr('disabled', 'disabled');
                } else {
                    $('#btnInput').removeAttr('disabled');
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
                width: 30%;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 20%;
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
                font-size: medium;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
                width: 100%;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
						<td align="center" style="width:5%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="color:black;" width="40%"><a id='vewProject'> </a></td>
						<td align="center" style="color:black;" width="35%"><a id='vewCustnick'> </a></td>
						<td align="center" style="color:black;" width="20%"><a id='vewKind'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="pronick" style="text-align: center;">~pronick</td>
						<td id="custnick" style="text-align: center;">~custnick</td>
						<td id="kind" style="text-align: center;">~kind</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtDatea" class="txt c1"/>	</td>	
						<td class="td3"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtNoa" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblProject' class="lbl"> </a></td>
						<td class="td2" colspan="2"><select id="cmbProject" class="txt c1"> </select>	
						<input type="text" id="txtPronick" style="display: none;"/>	
						</td>	
						<td class="td3"><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td class="td4"><select id="cmbKind" class="txt c1"> </select></td>	
					</tr>
					<tr class="land">
						<td class="td1"><span> </span><a id='lblItem' class="lbl btn"> </a></td>
						<td class="td2"colspan="2"><input type="text" id="txtItemno" style="width: 30%;"/>
							<input type="text" id="txtItem" style="width: 70%;"/></td>
							<td class="td3"><input type="button" id="btnInput" /></td>		
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td2"colspan="2">
							<input type="text" id="txtCustno" style="width: 30%;"/>
							<input type="text" id="txtComp" style="width: 70%;"/>
							<input id="txtCustnick"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblSales' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
							<input id="txtSalesno" type="text"  style="float:left; width:30%;"/>
							<input id="txtSales" type="text"  style="float:left; width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales2' class="lbl btn"> </a></td>
						<td colspan="2">
							<input type="text" id="txtSalesno2" style="float:left;width:30%;"/>
							<input type="text" id="txtSales2" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblPart2" class="lbl"> </a></td>
						<td>
							<select id="cmbPartno2" class="txt c1"> </select>
							<input id="txtPart2"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtConn" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblConntel' class="lbl"> </a></td>
						<td class="td4" colspan="2"><input type="text" id="txtConntel" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblOdate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtOdate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblWdate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtWdate" class="txt c1"/>	</td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblEnddate' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtEnddate" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblPaydate' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtPaydate" class="txt c1"/>	</td>							
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtMoney" class="txt num c1"/></td>
						<td class="td3"><span> </span><a id='lblCost' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCost" class="txt num c1"/></td>	
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblVccno' class="lbl btn"> </a></td>
						<td class="td2"><input type="text" id="txtVccno" class="txt c1"/></td>	
						<td class="td3">
							<input id="chkIscombine" type="checkbox" style="float: left;"/><a id="lblIscombine" class="lbl" style="float: left;"></a>
						</td>
						<td class="td3"><input id="btnAssignpaper" type="button" class="txt c1" /></td>
					</tr>
					<tr>
			            <td class='td1'><span> </span><a id="lblPaybno" class="lbl btn"></a></td>
			            <td class='td2'><input id="txtPaybno"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td class="td2"><input type="text" id="txtAccno" class="txt c1"/></td>	
						<td class="td3">
							<input id="chkEnda" type="checkbox" style="float: left;"/><a id="lblEnda" class="lbl" style="float: left;"></a>
						</td>
						<td class="td4"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker" class="txt c1"/></td>	
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:6%;"><a id='lblDays_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblCost_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblRealcost_s'> </a></td>
					<td align="center" style="width:3%;"><a id='lblIsprepay_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblSenddate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblApprdate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblRepdate_s'> </a></td>
					<td align="center" ><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><!--<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtProductno.*"  style="width:30%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct.*"  class="txt c1"/>-->
						<select id="cmbProduct.*" class="txt c1" style="font-size: medium;"> </select>
					</td>
					<td><input id="txtDays.*" type="text" class="txt c1"/></td>
					<td><input id="txtMoney.*" type="text" class="txt num c1"/></td>
					<td><input id="txtCost.*" type="text" class="txt num c1"/></td>
					<td><input id="txtRealcost.*" type="text" class="txt num c1"/></td>
					<td align="center"><input id="chkIsprepay.*" type="checkbox"/></td>
					<td><input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtTggno.*"  style="width:30%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtComp.*"  style="width:60%; float:left;"/>
					</td>
					<td><input id="txtSenddate.*" type="text" class="txt c1"/></td>
					<td><input id="txtApprdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtRepdate.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
