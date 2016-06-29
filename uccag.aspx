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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_desc=1;
            var q_name = "uccag";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtAccno'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Noa';
            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno', 'tgg_b.aspx']);
            brwCount2 = 8;

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
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
                q_cmbParse("cmbTypea", q_getPara('uccag.typea'));
                $('#lblAccno').click(function() {
                	if(!emp($('#txtNoa').val())){
                		var t_accy=r_accy;
                		if(!emp($('#txtMon').val())){
                			t_accy=$('#txtMon').val();
                		}else if (!emp($('#txtBdate').val())){
                			t_accy=$('#txtBdate').val();
                		}else if (!emp($('#txtDatea').val())){
                			t_accy=$('#txtDatea').val();
                		}
                		//20160217
                		if($('#cmbTypea').val()=='4'){
                			t_accy=$('#txtDatea').val();
                		}
                		
                		if(r_len==4){
                			q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex('" + $('#txtNoa').val() + "',zno)>0;" + (t_accy.substr(0,4)-1911) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAcc'), true);
                		}else{
                			q_pop('txtAccno', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";charindex('" + $('#txtNoa').val() + "',zno)>0;" + t_accy.substr( 0,3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "95%", "95%", q_getMsg('popAcc'), true);
                		}
                	}
                    
                });
				if(r_rank <= 8){
					if ((/^.*(uccag,1,[0|1],1,[0|1],[0|1],[0|1],[0|1],[0|1]).*$/g).test(q_auth.toString())){
		       			$('#btnGen').click(function() {show_confirm();});
		       		}
		       	}else{
		       		$('#btnGen').click(function() {show_confirm();});
		       	}
		       	if(q_getPara('sys.comp').substring(0,3)=='裕承隆'){
		       	   $('.tgg').show();
		       	}else{
		       		$('.tgg').hide();
		       	}
		       	
		       	if(q_getPara('sys.project').toUpperCase()=='PK' || q_getPara('sys.project').toUpperCase()=='RK'){
		       	   $('.edate').show();
		       	}else{
		       		$('.edate').hide();
		       	}
		       	
		       	/*$('#txtMon').focusout(function(){
		       		var t_Mon = trim($(this).val());
		        	var myDate = new Date(dec(t_Mon.substr( 0,3))+1911,dec(t_Mon.substr( 4,5)),0);
		        	var lastday=myDate.getDate();	//取當月最後一天
		       		if(t_Mon.length == 6){
		       			$('#txtBdate').val(t_Mon+'/01');
		       			$('#txtEdate').val(t_Mon+'/'+lastday);
		       		}
		       	});*/
            }
            function show_confirm(){
                if($.trim($('#txtBdate').val()).length>0 || $.trim($('#txtMon').val()).length>0){
					var r=confirm("你確定要執行嗎?");
					if (!r){
						return;
					}
  					if(!emp($('#txtNoa').val()))
						q_func('uccag.gen', $('#txtNoa').val());
					}
			}
            function q_funcPost(t_func, result) {	//後端傳回
				$('#txtAccno').val(result.split(';')[0]);
				$('#txtMemo').val(result.split(';')[1]);
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
                	case 'rbcheckbdate':
                		var as = _q_appendData("uccag", "", true);
						if (as[0] != undefined) {
							alert('立帳日期與類別已存在【'+as[0].noa+'】!!');
						}else{
							rbcheck=true;
							btnOk();
						}
                		break;
                    case q_name:
                        if (q_cur == 4)// 查詢
                            q_Seek_gtPost();
                        break;
                }
            }
			
			var rbcheck=false;
            function btnOk() {
            	if($('#txtMon').val().length>0){
            		$('#txtBdate').val('');        
            	}
            	
            	if(!rbcheck && q_getPara('sys.project').toUpperCase()=='RB'){
            		q_gt('uccag', "where=^^ bdate='"+$('#txtBdate').val()+"' and noa!='"+$('#txtNoa').val()+"' and typea='"+$('#cmbTypea').val()+"' ^^", 0, 0, 0, "rbcheckbdate");
            		return;
            	}
            	
            	rbcheck=false;
            	
                $('#txtWorker').val(r_name);
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_uccag')+(t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
				q_box('uccag_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
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
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0],'', '', 2);
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
                if ((q_cur == 1 || q_cur == 2)) {
					$('#btnGen').attr('disabled', 'disabled');
					
		        }
		        else {
		        	$('#btnGen').removeAttr('disabled');
		        }
            }

            function btnMinus(id) {
                _btnMinus(id);
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
                width: 320px;
                border-width: 0px;
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
				padding: 5px;
				text-align: center;
				border: 1px black solid;
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
                color: black;
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
		<div style="overflow: auto;display:block;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTypea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDate'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='typea=uccag.typea'>~typea=uccag.typea</td>
						<td align="center" id='mon'>~mon</td>
						<td align="center" id='bdate'>~bdate</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
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
						<td><span> </span><a id='lblMon' class="lbl" style="font-size:13px;"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1" > </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDate' class="lbl" style="font-size:13px;"> </a></td>
						<td colspan="2">
							<input id="txtBdate" type="text" class="txt c1" style="width: 45%;" />
							<a class="lbl edate" style="float: left;">~</a>
							<input id="txtEdate" type="text" class="txt c1 edate" style="width: 45%;"/>
						</td>
					</tr>
					<tr class="tgg">
						<td><span> </span><a id='lblTgg' class="lbl tgg"> </a></td>
                        <td><input id="txtTggno" type="text" class="txt c1 tgg"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccno' class="lbl btn"> </a></td>
						<td><input id="txtAccno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td><input id="btnGen" type="button" /></td>
						<td colspan="2" align="left"><a id="lblPunchline" style="color: #FF55A8;font-weight: bolder;font-size:medium;"> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtMemo" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
