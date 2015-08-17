<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
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
            var q_name = "postage";
            var q_readonly = ['txtMount', 'txtMoney','txtBeginmount','txtBeginmoney'];
            var q_readonlys = ['txtMount', 'txtMoney'];
            var bbmNum = [['txtNoa', 5, 1, 1], ['txtMount', 10, 0, 1], ['txtMoney', 15, 1, 1], ['txtBeginmount', 10, 0, 1], ['txtBeginmoney', 15, 1, 1]];
            var bbsNum = [['txtMount', 10, 0, 1], ['txtMoney', 15, 1, 1], ['txtBeginmount', 10, 0, 1], ['txtBeginmoney', 15, 1, 1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 10
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
            
            function sum() {
            	var t_bmount=0,t_bmoney=0;
            	for (var i = 0; i < q_bbsCount; i++) {
            		t_bmount+=q_float('txtBeginmount_'+i);
            		t_bmoney+=q_float('txtBeginmoney_'+i);
            	}
            	q_tr('txtBeginmount',t_bmount);
            	q_tr('txtBeginmoney',t_bmoney);
			}
			
            function mainPost() {
                q_mask(bbmMask);
                $('#btnIns').hide();
                $('#btnDele').hide();
                $('#txtBeginmount').change(function() {
                    if (!emp($('#txtNoa').val()) && !emp($('#txtBeginmount').val()))
                        q_tr('txtBeginmoney', dec($('#txtNoa').val()) * dec($('#txtBeginmount').val()));
                });

                $('#txtMount').change(function() {
                    if (!emp($('#txtNoa').val()) && !emp($('#txtMount').val()))
                        q_tr('txtMoney', dec($('#txtNoa').val()) * dec($('#txtMount').val()));
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

                q_box('postage_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }
            
            function bbsAssign() {
			for (var i = 0; i < q_bbsCount; i++) {
				if (!$('#btnMinus_' + i).hasClass('isAssign')) {
					$('#txtBeginmount_'+i).blur(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(q_cur==1 || q_cur==2){
							if (!emp($('#txtNoa').val()) && !emp($('#txtBeginmount_'+b_seq).val()))
                        		q_tr('txtBeginmoney_'+b_seq, dec($('#txtNoa').val()) * dec($('#txtBeginmount_'+b_seq).val()));
							sum();
						}
					});
				}
			}
			_bbsAssign();
		}

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtBeginmount').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                
                sum();

                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());

                if (t_noa.length == 0)
                    q_gtnoa(q_name, t_noa);
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            	_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
            function bbsSave(as) {
				if (!as['storeno'] && !as['beginmount']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

            function refresh(recno) {
                _refresh(recno);
                 refreshBbm();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 refreshBbm();
            }
            
            function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
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
                width: 315px;
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
                width: 335px;
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
            .dbbs {
                width: 650px;
            }
            .tbbs a {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:35%"><a id='vewMount'> </a></td>
						<td align="center" style="width:35%"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa,1,1'>~noa,1,1</td>
						<td align="center" id='mount,0,1' style="text-align: right;">~mount,0,1</td>
						<td align="center" id='money,1,1' style="text-align: right;">~money,1,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBeginmount" class="lbl"> </a></td>
						<td><input id="txtBeginmount" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBeginmoney" class="lbl"> </a></td>
						<td><input id="txtBeginmoney" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:150px;"><a id='lblStoreno_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblStore_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblBeginmount_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblBeginmoney_s'> </a></td>
					<!--<td align="center" style="width:200px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMoney_s'> </a></td>-->
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td>
						<input type="text" id="txtStoreno.*" style="width:70%;text-align: left;" />
						<input class="btn" id="btnStoreno.*" type="button" value='.' style="font-weight: bold;" />
					</td>
					<td><input type="text" id="txtStore.*" style="width:97%;text-align: left;" /></td>
					<td><input type="text" id="txtBeginmount.*" style="width:97%;text-align: right;" /></td>
					<td><input type="text" id="txtBeginmoney.*" style="width:97%;text-align: right;" /></td>
					<!--<td><input type="text" id="txtMount.*" style="width:97%;text-align: right;" /></td>
					<td><input type="text" id="txtMoney.*" style="width:97%;text-align: right;" /></td>-->
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
