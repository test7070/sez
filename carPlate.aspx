<%@ Page Language="C#" AutoEventWireup="true" %>
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

            var q_name = "carplate";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_xchg = 1;
            brwCount2 = 20;
            //ajaxPath = ""; //  execute in Root
			 aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);
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
                q_mask(bbmMask);
                
                var tmp = q_getMsg('carplate.typea').split('&');
                var t_typea = '';
                for(var i in tmp)
                	t_typea += (t_typea.length>0?',':'')+tmp[i];
				q_cmbParse("cmbTypea", t_typea);
                q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
                $('#cmbTypea').focus(function() {
                    var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
                    $("#cmbTypea").attr('size', len + "");
                }).blur(function() {
                    $("#cmbTypea").attr('size', '1');
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('carplate_s.aspx', q_name + '_s', "600px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtNoa').focus();
            }

            function btnPrint() {
				q_box('z_carplate.aspx' + "?;;;;" + r_accy, '', "90%", "600px", q_getMsg("popPrint"));
            }

            function btnOk() {
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);

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
                width: 1000px; 
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
                width: 1000px;
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
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 50%;
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
            .tbbm textarea {
                font-size: medium;
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
			<div class="dview" id="dview"   >
				<table class="tview" id="tview" >
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewTypea'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarplate'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDriver'></a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCardno'></a></td>
						<td align="center" style="width:80x; color:black;"><a id='vewSize'></a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMemo'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td id='typea' style="text-align: center;">~typea</td>
						<td align="center" id='carplate'>~carplate</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='cardno'>~cardno</td>
						<td align="center" id='size'>~size</td>
						<td align="center" id='memo,10'>~memo,10</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
						<td class="td2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCarplate' class="lbl"></a></td>
						<td class="td2">
						<input id="txtCarplate"  type="text"  class="txt c1"/>
						</td>
						<td class="td4"></td>
						<td class="td5"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDriver' class="lbl btn"></a></td>
						<td class="td2" colspan="2">
						<input id="txtDriverno"  type="text"  class="txt c2"/>
						<input id="txtDriver"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCardno' class="lbl btn"></a></td>
						<td><input id="txtCardno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSize' class="lbl"></a></td>
						<td><input id="txtSize"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl btn"></a></td>
						<td colspan="3"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr> </tr>
					<tr> </tr>
					<tr> </tr>
					<tr> </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>