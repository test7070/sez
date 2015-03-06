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
			q_desc=1;
            q_tables = 's';
            var q_name = "lab_accc";
            var q_readonly = ['txtNoa', 'txtSales','txtPart', 'txtWorker', 'txtAccno', 'txtBvccno', 'txtEvccno','txtMemo'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtSalesno', 'lblSalesno', 'sss', 'noa,namea,partno,part', 'txtSalesno,txtSales,txtPartno,txtPart', 'sss_b.aspx']
            , ['txtBcustno', '', 'cust', 'noa,comp', 'txtBcustno,txtBcust', 'cust_b.aspx']
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            , ['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']);
            brwCount2 = 8;

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
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
                bbmMask = [['txtDatea', r_picd], ['txtBdate', r_picd], ['txtEdate', r_picd],['txtMon', r_picm]];
                q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('lab_accc.typea')); //20130601

                $('#lblAccno').click(function() {
                    q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtMon').val().substr( 0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAcc'), true);
                });
                $('#lblVccno').click(function() {
			        t_bvccno = $('#txtBvccno').val();
			        t_evccno = $('#txtEvccno').val();
        			var t_where = " 1=1 " + q_sqlPara2("noa", t_bvccno,t_evccno);
					q_pop('txtBvccno', "vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";"+ t_where +";" + r_accy + '_' + r_cno, 'vcc', 'noa', 'datea', "95%", "95%", q_getMsg('popVcc'), true);
                });
                $('#txtDatea').focusout(function() {
                    q_cd($(this).val(), $(this));
                });
                $('#txtBdate').focusout(function() {
                    q_cd($(this).val(), $(this));
                });
                $('#txtEdate').focusout(function() {
                    q_cd($(this).val(), $(this));
                });
                $('#txtEdate').focusout(function() {
                		$('#txtMon').val($(this).val().substr(0,6));
                });
                $('#txtAcc1').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
                });
		      if(r_rank <= 8)
		      	{if ((/^.*(lab_accc,1,[0|1],1,[0|1],[0|1],[0|1],[0|1],[0|1]).*$/g).test(q_auth.toString())){
		       	$('#btnGen').click(function() {show_confirm()});}}
            else
            	{$('#btnGen').click(function() {show_confirm()});}

				/*
				$('#lblPaybno').click(function(){
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
					q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "650px", q_getMsg('popPaytran'));
				});
				*/
				//hiddenField();
				$('#cmbTypea').change(function(){
					hiddenField();
				});
            }
            function show_confirm(){
				var r=confirm("你確定要執行嗎?");
				if (r==true){
  					//alert("確定執行");
  					if(!emp($('#txtNoa').val()))
						q_func('lab_accc.gen', $('#txtNoa').val());
				}else{
					alert("取消執行");
				}
			}
            function q_funcPost(t_func, result) {	//後端傳回
            	abbm[q_recno]['accno'] = result.split(';')[0];
				$('#txtAccno').val(result.split(';')[0]);
				abbm[q_recno]['bvccno'] = result.split(';')[1];
				$('#txtBvccno').val(result.split(';')[1]);
				abbm[q_recno]['evccno'] = result.split(';')[2];
				$('#txtEvccno').val(result.split(';')[2]);
				abbm[q_recno]['memo'] = result.split(';')[4];
				$('#txtMemo').val(result.split(';')[4]);
				alert('作業完畢');
		    }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {/// 重要：不可以直接 return ，最後需執行 originalClose();
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }
            }
						
            function btnOk() {
                $('#txtWorker').val(r_name);
                if($('#txtSalesno').val().length==0){
                    alert(q_getMsg('lblSalesno') + '錯誤。');
                    return;
                }
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon')+'錯誤。'); 
                    return;
                }
	            if (!q_cd($('#txtBdate').val())){
                	alert(q_getMsg('lblDate')+'錯誤。');
                	return;
	            }
	            if (!q_cd($('#txtEdate').val())){
	                alert(q_getMsg('lblDate')+'錯誤。');
                	return;
	            }
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_lab_accc')+(t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('lab_accc_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {/// 表身運算式
                for (var j = 0; j < q_bbsCount; j++) {
                    $('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                      
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                hiddenField();
                $('#txtMon').val(q_date().substring(0,6));
                $('#txtDatea').focus();
            }

            function btnModi() {
                 if (emp($('#txtNoa').val()))
                    return;
                 if($('#txtDatea').val()<='102/05/31'){
                	alert('已關帳!!');
                	return;
                }
                 
                _btnModi(1);
                hiddenField();
                $('#txtBcustno').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                $('#txtBcust').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if (!as['productno'] && !as['product']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
            }

			function hiddenField(){
				if($('#cmbTypea').val() == '發票'){
					$('#hiddenCust').show();
				}else{
					$('#hiddenCust').hide();
				}
			}
			function GetBcust(){
				if(q_cur == 0 || q_cur == 2){
					var Custno = $('#txtBcustno').val();
					var Cust = $('#txtBcust').val();
					var NowRecno = q_recno;
					if(Custno.length > 0 && Cust == ''){
						q_popChange($('#txtBcustno'));
						$('#txtBcust').unbind("focus");
					}
				}
			}
			
            function refresh(recno) {
                _refresh(recno);                
				hiddenField();
				GetBcust();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if ((q_cur == 1 || q_cur == 2)) {
					$('#btnGen').attr('disabled', 'disabled');
					
		        }
		        else {
		        	$('#btnGen').removeAttr('disabled');
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
                width: 250px;
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
                width: 700px;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
            	visibility:hidden;
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
            	visibility:hidden;
                width: 950px;
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:130px; color:black;"><a id='vewTypea'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='typea'>~typea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
						<input id="txtMon"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSalesno' class="lbl btn"> </a></td>
						<td colspan="2">
						<input id="txtSalesno"  type="text" style="float:left; width:40%;"/>
						<input id="txtSales"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr id="hiddenCust">
						<td><span> </span><a id='lblBcustno' class="lbl"> </a></td>
						<td colspan="2">
							<input id="txtBcustno"  type="text" style="float:left; width:40%;"/>
							<input id="txtBcust"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPart' class="lbl"> </a></td>
						<td>
							<input id="txtPartno"  type="text" style="display:none;"/>
							<input id="txtPart"  type="text" class="txt c1"/>
						</td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblAcc1' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtAcc1"  type="text" style="float:left; width:30%;"/>
						<input id="txtAcc2"  type="text" style="float:left; width:70%;"/>
						</td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblDate' class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtBdate"  type="text" style="float:left; width:45%;"/>
						<span style="float:left; width:5px;"> </span><span style="float:left; width:20px; font-weight: bold;font-size: 20px;">～</span><span style="float:left; width:5px;"> </span>
						<input id="txtEdate"  type="text" style="float:left; width:45%;"/>
						</td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td colspan="3">
						<input id="txtBcustno"  type="text" style="float:left; width:45%;"/>
						<span style="float:left; width:5px;"> </span><span style="float:left; width:20px; font-weight: bold;font-size: 20px;">～</span><span style="float:left; width:5px;"> </span>
						<input id="txtEcustno"  type="text" style="float:left; width:45%;"/>
						</td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblVccno' class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtBvccno"  type="text" style="float:left; width:45%;"/>
						<span style="float:left; width:5px;"> </span><span style="float:left; width:20px; font-weight: bold;font-size: 20px;">～</span><span style="float:left; width:5px;"> </span>
						<input id="txtEvccno"  type="text" style="float:left; width:45%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
						<!--<td colspan="2"><span> </span><a id='lblPaybno' class="lbl btn"> </a></td>-->
						<!--<td><input id="txtPaybno" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><input id="btnGen" type="button" /></td>
						<td colspan="2" align="left"><a id="lblPunchline" style="color: #FF55A8;font-weight: bolder;font-size:medium;"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center;visibility:hidden;'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"/></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input id="btnProductno.*" type="button" value=".." style="float:left;width: 5%;"/>
						<input id="txtProductno.*" type="text" style="float:left;width: 35%;"/>
						<input id="txtProduct.*" type="text" style="float:left;width: 55%;"/>					
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
