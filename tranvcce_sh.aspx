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
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "tranvcce";
            var q_readonly = ['txtNoa', 'txtWeight','txtTotal', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtWeight', 10, 2, 1],['txtUweight', 10, 2, 1],['txtHeight', 10, 3, 1],['txtVolume', 10, 3, 1],['txtTvolume', 10, 0, 1],['txtTotal', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtTime1','999/99/99'],];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,nick', 'txtCustno_,txtCust_', 'cust_b.aspx']
            , ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtAddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr_b.aspx']
            , ['txtAddrno2_', 'btnEndaddr_',  'addr', 'noa,addr', 'txtAddrno2_,txtAddr2_', 'addr_b.aspx']
            , ['txtAddrno3_', 'btnAddr3_', 'cust', 'noa,nick', 'txtAddrno3_,txtAddr3_', 'cust_b.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function sum() {
                for(var i=0;i<q_bbsCount;i++){
                }
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
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
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {
            	sum();
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('z_tran_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                  $('#txtTime1_' + i).focusout(function (){
                        var s1 = $(this).val();
                            if (s1.length == 1 && s1 == "=") {
                                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (b_seq > 0) {
                                    var i = b_seq - 1;
                                    var s1 = $('#txtTime1_' + i).val();
                                    $('#txtTime1_' + b_seq).val(s1);
                                    var s2 = $('#txtCustno_' + i).val();
                                    $('#txtCustno_' + b_seq).val(s2); 
                                    var s3 = $('#txtCust_' + i).val();
                                    $('#txtCust_' + b_seq).val(s3);
                                    var s4 = $('#txtMount_' + i).val();
                                    $('#txtMount_' + b_seq).val(s4);
                                    var s5 = $('#txtUnit_' + i).val();
                                    $('#txtUnit_' + b_seq).val(s5); 
                                    var s6 = $('#txtAddrno_' + i).val();
                                    $('#txtAddrno_' + b_seq).val(s6);
                                    var s7 = $('#txtAddr_' + i).val();
                                    $('#txtAddr_' + b_seq).val(s7);
                                    var s8 = $('#txtAddrno2_' + i).val();
                                    $('#txtAddrno2_' + b_seq).val(s8); 
                                    var s9 = $('#txtAddr2_' + i).val();
                                    $('#txtAddr2_' + b_seq).val(s9);
                                    var s10 = $('#txtVolume_' + i).val();
                                    $('#txtVolume_' + b_seq).val(s10);
                                    var s11 = $('#txtTranno_' + i).val();
                                    $('#txtTranno_' + b_seq).val(s11); 
                                    var s12 = $('#txtProductno2_' + i).val();
                                    $('#txtProductno2_' + b_seq).val(s12);
                                    var s13 = $('#txtProductno_' + i).val();
                                    $('#txtProductno_' + b_seq).val(s13); 
                                    var s14 = $('#txtProduct_' + i).val();
                                    $('#txtProduct_' + b_seq).val(s14);
                                    var s15 = $('#txtAddrno3_' + i).val();
                                    $('#txtAddrno3_' + b_seq).val(s15); 
                                    var s16 = $('#txtAddr3_' + i).val();
                                    $('#txtAddr3_' + b_seq).val(s16);                                      
                                }
                            }
                  });
                  $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                  });
                  $('#txtProductno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                  });
                  $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnStraddr_'+n).click();
                  });
                  $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnEndaddr_'+n).click();
                  });
                  $('#txtAddrno3_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr3_'+n).click();
                  });
                  $('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                  });
                  $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
                  });
                  $('#txtTime1_' + i).focus(function () {
                            if (!$(this).val())
                                q_msg($(this), '=號複製上一筆資料');
                  });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txttrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	q_box('z_tran_sh.aspx' + "?;;;noa=" + trim($('#txtNoa').val()) + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['time1'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                return true;n
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
                q_box('tranvcce_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
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
                width: 630px;
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
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
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
                width: 1500px;
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
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>電腦編號</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>
					</tr>
					<!--<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>-->      
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="3"><textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!--2017/10/31 于小姐討論後 數量跟材積都是數字 貨櫃的櫃型打在品名 多櫃號、S/O、貨主-->
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:90px"><a>出車日期</a></td>
					<td align="center" style="width:90px"><a>客戶</a></td>
					<td align="center" style="width:100px"><a>品項</a></td>
					<td align="center" style="width:75px"><a>數量</a></td>
					<td align="center" style="width:50px"><a>單位</a></td>
					<td align="center" style="width:75px"><a>材積</a></td>
					<td align="center" style="width:100px"><a>起點</a></td>
					<td align="center" style="width:100px"><a>迄點</a></td>
					<td align="center" style="width:120px"><a>櫃號</a></td>
					<td align="center" style="width:120px"><a>S/O</a></td>
					<td align="center" style="width:100px"><a>貨主</a></td>
					<td align="center" style="width:80px"><a>金額</a></td>
					<td align="center" style="width:100px"><a>車牌</a></td>
					<td align="center" style="width:80px"><a>司機</a></td>
					<td align="center" style="width:80px"><a>司機運費</a></td>
					<td align="center" style="width:20px"><a>登錄</a></td>
					<td align="center" style="width:20px"><a>確認</a></td>
					<td align="center" style="width:100px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtTime1.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:95%;" />
						<input type="text" id="txtCust.*" style="float:left;width:95%;">
						<input type="button" id="btnCust.*" style="display:none;">
					</td>
					<td>
                        <input type="text" id="txtProductno.*" style="float:left;width:95%;" />
                        <input type="text" id="txtProduct.*" style="float:left;width:95%;">
                        <input type="button" id="btnProduct.*" style="display:none;">
                    </td>
					<td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtVolume.*" class="num" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtAddrno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnStraddr.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtAddrno2.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr2.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnEndaddr.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtTranno.*" style="float:left;width:95%;"/></td>
                    <td><input type="text" id="txtProductno2.*" style="float:left;width:95%;"/></td>
                    <td>
                        <input type="text" id="txtAddrno3.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtAddr3.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnAddr3.*" style="display:none;"/>
                    </td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="width:95%;"/>
						<input type="button" id="btnCarno.*" style="display:none;"/>
					</td>
					<td>
					    <input type="text" id="txtDriverno.*" style="float:left;width:95%;"/>
                        <input type="text" id="txtDriver.*" style="float:left;width:95%;"/>
                        <input type="button" id="btnDriver.*" style="display:none;"/>
                    </td>
                    <td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td align="center"><input id="chkChk1.*" type="checkbox"/></td>
					<td align="center"><input id="chkChk2.*" type="checkbox"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>