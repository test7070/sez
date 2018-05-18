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

            var q_name = "tirestk";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtBrandno', 'lblBrand', 'carbrand', 'noa,brand', 'txtBrandno,txtBrand', 'carbrand_b.aspx'], 
            ['txtCarplateno', 'lblCarplate', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx'],
            ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
            ['txtProductno', 'lblNamea', 'fixucc', 'noa,namea', 'txtProductno,txtProduct', 'fixucc_b.aspx'], 
            ['txtCarno', 'lblCarno', 'car2', 'a.noa','txtCarno', 'car2_b.aspx'],
            ['txtFixtggno', 'lblFixtgg', 'tgg', 'noa,comp', 'txtFixtggno,txtFixtgg', 'tgg_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            //////////////////   end Ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }///  end Main()

            function mainPost() {
            	bbmMask = [['txtIndate', r_picd],['txtOutdate', r_picd],['txtDeldate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbPosition", q_getPara('tire.position'));
                q_cmbParse("cmbTypea", q_getPara('tire.typea'));
                $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('tirestk', t_where, 0, 0, 0, "checkTirestkno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
            }

            

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkTirestkno_change':
                		var as = _q_appendData("tirestk", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa);
                        }
                		break;
                	case 'checkTirestkno_btnOk':
                		var as = _q_appendData("tirestk", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('tirestk_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnPrint() {

            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
            	Lock();
				//日期檢查
				if( !q_cd($('#txtIndate').val())){
					alert(q_getMsg('lblIndate')+'錯誤。');
            		Unlock();
            		return;
				}
				if(!q_cd($('#txtOutdate').val())){
					alert(q_getMsg('lblOutdate')+'錯誤。');
            		Unlock();
            		return;
				}
				if(!q_cd($('#txtDeldate').val())){
					alert(q_getMsg('lblDeldate')+'錯誤。');
            		Unlock();
            		return;
				}

            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
				if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('tirestk', t_where, 0, 0, 0, "checkTirestkno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
                
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
				refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
                width: 35%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 60%;
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
                width: 10%;
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
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                font-size: medium;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 95%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview"   >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:15%"><a id='vewCarno'> </a></td>
						<td align="center" style="width:15%"><a id='vewCarplate'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='carplateno'>~carplateno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
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
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr class="tr3">
						<td class="td1"><span> </span><a id='lblNamea' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtProductno"  type="text"  class="txt" style="width: 25%;"/>
						<input id="txtProduct"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblBrand' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtBrandno"  type="text"  class="txt" style="width: 25%;"/>
						<input id="txtBrand"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr class="tr5">
						<td class="td1"><span> </span><a id='lblCarno' class="lbl btn"> </a></td>
						<td class="td2" >
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblCarplate' class="lbl btn"> </a></td>
						<td class="td4">
						<input id="txtCarplateno"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblPosition' class="lbl"> </a></td>
						<td class="td2"><select id="cmbPosition" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td class="td4"><input id="txtPrice"  type="text"  class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td class="td2" >
						<input id="txtIndate"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtOutdate"  type="text"  class="txt c1"/>
						</td>
						<td class="td5"><span> </span><a id='lblDeldate' class="lbl"> </a></td>
						<td class="td6">
						<input id="txtDeldate"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtTggno"  type="text"  class="txt" style="width: 25%;"/>
						<input id="txtTgg"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblFixtgg' class="lbl btn"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtFixtggno"  type="text"  class="txt" style="width: 25%;"/>
						<input id="txtFixtgg"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
