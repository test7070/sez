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

            var q_name = "ucch";
            var q_readonly = []
            /*
            var q_readonly = ['txtNoa','txtUno2','txtCustno','txtCust','txtCustno2','txtCust2','txtProductno',
            				  'txtProduct','txtSpec','txtClass','txtRadius','txtWidth','txtDime','txtLengthb',
            				  'txtMount','txtWeight','txtWeight2'
            				 ];
            */
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 12;

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
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
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", ','+q_getPara('ucch.typea'));
                q_cmbParse("cmbTypea2", ','+q_getPara('ucch.typea2'));
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
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
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

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtDatea', q_getMsg('lblDatea')]]);

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll($('#txtDatea').val(), '/', ''));
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
                $('#cmbTypea').attr('disabled','disabled').css('background-color',t_background2);
                $('#cmbTypea2').attr('disabled','disabled').css('background-color',t_background2);
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
                width: 300px;
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
            .num {
                text-align: right;
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
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewProductno'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=' '/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='productno' style="text-align: left;">~productno</td>
						<td id='product' style="text-align: left;">~product</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUno' class="lbl"> </a></td>
						<td><input id="txtUno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblUno2' class="lbl"> </a></td>
						<td><input id="txtUno2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td>
							<input id="txtCustno" type="text" class="txt" style="width:30%;"/>
							<input id="txtCust" type="text" class="txt" style="width:70%;"/>
						</td>
						<td><span> </span><a id='lblCustno2' class="lbl"> </a></td>
						<td>
							<input id="txtCustno2" type="text" class="txt" style="width:30%;"/>
							<input id="txtCust2" type="text" class="txt" style="width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOrdeno' class="lbl"> </a></td>
						<td>
							<input id="txtOrdeno" type="text" class="txt" style="width:70%;"/>
							<input id="txtNo2" type="text" class="txt" style="width:30%;"/>
						</td>
						<td><span> </span><a id='lblOrdeno2' class="lbl"> </a></td>
						<td>
							<input id="txtOrdeno2" type="text" class="txt" style="width:70%;"/>
							<input id="txtNo22" type="text" class="txt" style="width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProductno' class="lbl"> </a></td>
						<td>
							<input id="txtProductno" type="text" class="txt" style="width:30%;"/>
							<input id="txtProduct" type="text" class="txt" style="width:70%;"/>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSpec' class="lbl"> </a></td>
						<td><input id="txtSpec" type="text" class="txt c1" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblClass' class="lbl"> </a></td>
						<td><input id="txtClass" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblClass2' class="lbl"> </a></td>
						<td><input id="txtClass2" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRadius' class="lbl"> </a></td>
						<td><input id="txtRadius" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblStoreno' class="lbl"> </a></td>
						<td>
							<input id="txtStoreno" type="text" class="txt" style="width:30%;"/>
							<input id="txtStore" type="text" class="txt" style="width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWidth' class="lbl"> </a></td>
						<td><input id="txtWidth" type="text" class="txt c1 num" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDime' class="lbl"> </a></td>
						<td><input id="txtDime" type="text" class="txt c1 num" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLengthb' class="lbl"> </a></td>
						<td><input id="txtLengthb" type="text" class="txt c1 num" /></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMount' class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblMount2' class="lbl"> </a></td>
						<td><input id="txtMount2" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></td>
						<td><span> </span><a id='lblWeight2' class="lbl"> </a></td>
						<td><input id="txtWeight2" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea"  class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypea2' class="lbl"> </a></td>
						<td><select id="cmbTypea2"  class="txt c1"> </select></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
