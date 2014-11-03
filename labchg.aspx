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
            var q_name = "labchg";
            var q_readonly = ['txtDatea','txtNoa','txtAccno','txtPaybno','txtWorker','txtWorker2'];
            var q_readonlys = ['txtVccno'];
            var bbmNum = [];
            var bbsNum = [['txtLabplus', 15, 0, 1],['txtLabminus', 15, 0, 1],['txtHeplus', 15, 0, 1],['txtHeminus', 15, 0, 1],['txtReplus', 15, 0, 1],['txtReminus', 15, 0, 1],['txtDisasterplus', 15, 0, 1],['txtDisasterminus', 15, 0, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 4;
            q_desc = 1;
            aPop = new Array(['txtSssno_', 'btnSssno_', 'sssall', 'noa,namea,partno,part,namea', 'txtSssno_,txtNamea_,,,txtMemo_', 'sssall_b.aspx']);

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
                bbmMask = [['txtDatea',r_picd]];
                bbsMask = [['txtMon',r_picm]];
                q_mask(bbmMask);
                q_mask(bbsMask);
                $('#lblAccno').click(function() {
                	if(!emp($('#txtDatea').val()))
                    	q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno').val() + "';" + $('#txtDatea').val().substr( 0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAcc'), true);
                });
				$('#lblPaybno').click(function(){
		     		t_where = "noa='" + $('#txtPaybno').val() + "'";
					q_box("payb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pay', "95%", "650px", q_getMsg('popPaytran'));
				});
            }
            function q_funcPost(t_func, result) {	//後端傳回
				$('#txtAccno').val(result.split(';')[0]);
				$('#txtPaybno').val(result.split(';')[1]);
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
            	 if(q_cur==1)
	           	$('#txtWorker').val(r_name);
	        else
	           	$('#txtWorker2').val(r_name);
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_labchg')+(t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('labchg_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function bbsAssign() {/// 表身運算式
                for (var j = 0; j < q_bbsCount; j++) {
                	$('#lblNo_' + j).text(j + 1);
                    if (!$('#btnMinus_' + j).hasClass('isAssign')) {
                      $('#btnVccno_' + j).click(function(){
	                    t_IdSeq = -1; 
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
	                    if($('#txtVccno_' + b_seq).val().substr(0,2)=='BK')
	                    	q_box("carchg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno_' + b_seq).val() + "';" + r_accy + '_' + r_cno, 'vcc', "95%", "95%", q_getMsg('popCarchg'));
	                    else if($('#txtVccno_' + b_seq).val().substr(0,2)=='FA')
	                    	q_box("vcctran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno_' + b_seq).val() + "';" + r_accy + '_' + r_cno, 'vcc', "95%", "95%", q_getMsg('popVcc'));	                    
	                    else if($('#txtVccno_' + b_seq).val().indexOf("-")>-1)
	                    	q_box("cara.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno_' + b_seq).val() + "';" + r_accy + '_' + r_cno, 'vcc', "95%", "95%", q_getMsg('popCara'));
	                    else
                    		q_box("salchg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtVccno_' + b_seq).val() + "';" + r_accy + '_' + r_cno, 'vcc', "95%", "95%", q_getMsg('popSalchg'));
                      });
                      
                      $('#txtMon_' + j).change(function(){
	                    t_IdSeq = -1; 
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
                    	$('#txtMemo_' + b_seq).val($('#txtMon_' + b_seq).val()+$('#txtMemo_' + b_seq).val())
                      });
                      /*
                      $('#txtMemo_' + j).change(function() {
                      	t_IdSeq = -1; 
	                    q_bodyId($(this).attr('id'));
	                    b_seq = t_IdSeq;
	                    var str = $('#txtMemo_' + b_seq).val();
	                    var strindex = str.indexOf('月份');
	                    var nowyear = new Date().getUTCFullYear()-1911;
	                    if(!isNaN(str.substring(strindex-2,strindex))){
	                    	$('#txtMon_' + b_seq).val(nowyear + '/' + str.substring(strindex-2,strindex));
	                    }else if(!isNaN(str.substring(strindex-1,strindex))){
	                    	$('#txtMon_' + b_seq).val(nowyear + '/0' + str.substring(strindex-1,strindex));
	                    }
                      });
                      */
                    }
                }
                _bbsAssign();
                if(q_cur==2){
	                for(var j = 0; j < q_bbsCount; j++) {
						if($('#txtVccno_'+j).val()!=''){
							$('#txtSssno_'+j).attr('disabled', 'disabled');
							$('#txtNamea_'+j).attr('disabled', 'disabled');
							$('#btnSssno_'+j).attr('disabled', 'disabled');
						}
					}
                }
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
                 if (q_chkClose())
             		    return;
                if($('#txtDatea').val()<='102/05/31'){
                	alert('已關帳!!');
                	return;
                }
                
                _btnModi(1);
                $('#txtDatea').focus();
                
				for(var j = 0; j < q_bbsCount; j++) {
					if($('#txtVccno_'+j).val()!=''){
						$('#txtSssno_'+j).attr('disabled', 'disabled');
						$('#txtNamea_'+j).attr('disabled', 'disabled');
						$('#btnSssno_'+j).attr('disabled', 'disabled');
					}
				}
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                abbm[q_recno]['accno'] = xmlString.split(";")[0];
                abbm[q_recno]['paybno'] = xmlString.split(";")[1];
                $('#txtAccno').val(xmlString.split(";")[0]);
                $('#txtPaybno').val(xmlString.split(";")[1]);
                var t_noa = abbm[q_recno]['noa'];
                var i = 0;
				for (var j = 0; j < abbs.length; j++) {
					if(abbs[j]['noa'] == t_noa){
						abbs[j]['vccno'] = xmlString.split(";")[2 + i];
						$('#txtVccno_' + i).val(xmlString.split(";")[2 + i]);
						i++;
					}
				}
			}
            function btnPrint() {
				q_box('z_labchg.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {/// 表身 寫入資料庫前，寫入需要欄位
                if (!as['sssno']) {
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

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                
                $('#txtSssno_'+id.split('_')[1]).removeAttr('disabled');
				$('#txtNamea_'+id.split('_')[1]).removeAttr('disabled');
				$('#btnSssno_'+id.split('_')[1]).removeAttr('disabled');
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
            	if (q_chkClose())
             	return;
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
                width: 98%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .txt.col {
                color: #FA0300;
            }
            .tbbs .X{
            	background: #FFC991;
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
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                width: 100%;
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
						<td align="center" style="width:130px; color:black;"><a id='vewWorker'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='worker'>~worker</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<!--
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					-->
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
							<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblPaybno' class="lbl btn"> </a></td>
						<td><input id="txtPaybno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
            			<td colspan="3"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td colspan="2"><span> </span><a id='lblNotice' class="lbl"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:2%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"/></td>
					<td align="center" style="width:2%;"> </td>
					<td align="center" style="width:200px;"><a id='lblSss_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMon_s'> </a></td>
					<td align="center" colspan="2" style="width:100px;"><a id='lblHe_s'> </a></td>
					<td align="center" colspan="2" style="width:100px;"><a id='lblLab_s'> </a></td>
					<td align="center" colspan="2" style="width:100px;"><a id='lblRe_s'> </a></td>
					<td align="center" colspan="2" style="width:100px;"><a id='lblDisaster_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblVccno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<input id="txtSssno.*" type="text" style="float:left;width: 30%;"/>
						<input id="txtNamea.*" type="text" style="float:left;width: 55%;"/>	
						<input id="btnSssno.*" type="button" value="." style="float:left;width: 5%;"/>				
					</td>
					<td><input id="txtMon.*" class="txt c1" type="text" style="float:left;width: 95%;"/></td>
					<td ><input id="txtHeplus.*" class="txt num c1" type="text" style="float:left;width: 95%;"/></td>
					<td class="X"><input id="txtHeminus.*" class="txt num c1 col" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtLabplus.*" class="txt num c1" type="text" style="float:left;width: 95%;"/></td>
					<td class="X"><input id="txtLabminus.*" class="txt num c1 col" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtReplus.*" class="txt num c1" type="text" style="float:left;width: 95%;"/></td>
					<td class="X"><input id="txtReminus.*" class="txt num c1 col" type="text" style="float:left;width: 95%;"/></td>
					<td><input id="txtDisasterplus.*" class="txt num c1" type="text" style="float:left;width: 95%;"/></td>
					<td class="X"><input id="txtDisasterminus.*" class="txt num c1 col" type="text" style="float:left;width: 95%;"/></td>
					<td>
						<input id="txtVccno.*" class="txt c1" type="text" style="float:left;width: 85%;"/>
						<input id="btnVccno.*" type="button" value="." style="float:left;width: 5%;"/>			
					</td>
					<td><input id="txtMemo.*" class="txt c1" type="text" style="float:left;width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
