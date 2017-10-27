<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4lkDc9H0JanDkP8MUpO-mzXRtmugbiI8&signed_in=true&libraries=drawing&callback=initMap" async defer></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "addr2";
            var q_readonly = ['txtNoa'];
            var bbmNum = [];
            var bbmMask = [];
            var bbsNum = [['txtRate', 10, 2, 1],['txtRate2', 10, 2, 1],['txtValue', 10, 0, 1]];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            q_desc = 1;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_content = ' order=^^datea desc, noa desc ^^';
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '',r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(6, q_content);
				
            }

            function sum() {
                    for(var i=0;i<q_bbsCount;i++){
                        if($('#txtCustno').val().length>0){
                            $('#txtAddrno_'+i).val($('#txtCustno').val());
                        }
                    } 
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtSdate', r_picd]];
                q_mask(bbmMask);
                $('#txtSdate').datepicker();
				$('#txtCustno').change(function(e) {
					var t_where = "where=^^ custno in(select MAX(custno) from addr2 where custno like '"+ $('#txtCustno').val() +"%')^^"
					q_gt('addr2', t_where, 0, 0, 0, "addr2no");
			});
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                case q_name + '_js_s':
                    q_boxClose2(s2);
                    break;
                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
					case "addr2no":
						var as = _q_appendData("addr2", "", true);
						if (as.length > 0 && as[0].custno.indexOf("-")>=0){
							var cno = as[0].custno.substr(as[0].custno.indexOf("-")+1,as[0].custno.length - as[0].custno.indexOf("-"));
							$('#txtCustno').val($('#txtCustno').val() + '-' + right('000' +(parseInt(cno)+1).toString(),3));
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
                q_box(q_name + '_wj_s.aspx', q_name + '_js_s', "500px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').val('AUTO'); 
                $('#txtSdate').val(q_date());
				$('#txtCustno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
            }

            function btnPrint() {
                //q_box('z_ucc_js.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function q_popPost(id) {
                switch(id) {
                case 'txtAddrno_':
                    refreshMarker();
                    break;
                default:
                    break;
                }
            }

            function btnOk() {
                sum();
                $('#txtWorker').val(r_name)
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtSdate').val());
                if (q_cur ==1)
                     q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                     wrServer(t_noa);
		
            }

            function wrServer(key_value) {
                 var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if ($('#btnMinus_' + i).hasClass('isAssign'))
                        continue;
                    $('#txtAddrno_'+i).val($('#txtCustno').val()); 
                }
                _bbsAssign();

            }

            function bbsSave(as) {
                if (!as['carno'] && !as['lat'] && !as['lng'] && !as['rate'] && !as['rate2'] && !as['value'] && !as['memo']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
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
                width: 40%;
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
                width: 40%;
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
                width: 20%;
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
            .dbbs {
                width: 800px;
            }
            .dbbt {
                width: 1000px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
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
				<table class="tview" id="tview"    border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
                    <tr>
                        <td align="center" style="width:20px"><a id='vewChk'> </a></td>               
                        <td align="center" style="width:100px"><a id='vewCustno'>編號</a></td>
                        <td align="center" style="width:150px"><a id='vewCust'>供應商/收貨人</a></td>
                        <td align="center" style="width:300px"><a id='vewAddress'>地址</a></td>
                    </tr>
                     <tr>
                            <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                            <td align="center" id='custno'>~custno</td>
                            <td align="center" id='cust'>~cust</td>
                            <td align="center" id='address'>~address</td>
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
						<td class="tdZ"></td>
					</tr>
					<tr>
                        <td><span> </span><a class="lbl">編號</a></td>
                        <td>
                        <input id="txtCustno"  type="text"  class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">供應商/收貨人</a></td>
                        <td>
                        <input id="txtCust" type="text" class="txt c1"/>
                        </td>
                        <td><span> </span><a class="lbl">簡稱</a></td>
                        <td>
                        <input id="txtAddr" type="text" class="txt c1"/>
                        </td>
                    </tr>
					 <tr>
                        <td><span> </span><a class="lbl">聯絡人</a></td>
                        <td colspan="3">
                        <input id="txtConn" type="text"  class="txt c1"/>
                        </td>
                    </tr>
					<tr>
                        <td><span> </span><a class="lbl">聯絡電話</a></td>
                        <td colspan="3">
                        <input id="txtTel" type="text"  class="txt c1"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a class="lbl">郵遞區號</a></td>
                        <td>
                        <input id="txtSiteno" type="text"  class="txt c1"/>
                        </td>
                    </tr>
					<tr>
						<td><span> </span><a class="lbl">地址</a></td>
						<td colspan="3">
						<input id="txtAddress" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">場區限制</a></td>
						<td>
						<input id="txtfield" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">自裝卸費用</a></td>
						<td>
						<input id="txtchg1" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">堆高機費用</a></td>
						<td>
						<input id="txtchg2" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
                        <td class="td1"><span> </span><a id="lblSdate" class="lbl" >生效日期</a></td>
                        <td class="td2"><input id="txtSdate"  type="text" class="txt c1"/></td>
                        <td class="td2"><input id="txtNoa"  style="display:none;"/></td>
                    </tr>
                    <tr>
                        <td class="td1"><span> </span><a id="lblMemo" class="lbl" >注意事項</a></td>
                        <td colspan="3"><textarea id="txtMemo" cols="10" rows="5" style="height:100px;" class="txt c1"> </textarea></td>
                    </tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:80px;"><a>危險種類</a></td>
					<td align="center" style="width:150px;"><a>郵遞區號</a></td>
					<td align="center" style="width:150px;"><a>噸數(mt)</a></td>
					<td align="center" style="width:100px;"><a>價格</a></td>
					<td align="center" style="width:150px;"><a>備註</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
                        <input type="text" id="txtCarno.*" style="float:left;width:95%;" />
                        <input type="text" id="txtAddrno.*"  style="display:none;"/>
                    </td>
					<td>
    					<input type="text" id="txtLat.*" style="float:left;width:42%;" />
    					<span>~</span>
    					<input type="text" id="txtLng.*" style="float:right;width:42%;" />
					</td>
					<td>
                        <input type="text" id="txtRate.*" style="float:left;width:42%;" class="num"/>
                        <span>~</span>
                        <input type="text" id="txtRate2.*" style="float:right;width:42%;" class="num"/>
                    </td>
                    <td><input type="text" id="txtValue.*" style="float:left;width:95%;" class="num"/></td>
					<td><input type="text" id="txtMemo.*" style="float:left;width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
