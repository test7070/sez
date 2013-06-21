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
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_tables = 's';
            var q_name = "transvcce2tran";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            
            q_desc = 1;
            aPop = new Array();

            $(document).ready(function() {
                q_bbsShow = -1;
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
                mainForm(0);
            }

            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
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
			function q_stPost() {
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtDatea').val().substring(0,3)!=r_accy){
					alert('年度異常錯誤，請切換到【'+$('#txtDatea').val().substring(0,3)+'】年度再作業。');
					Unlock(1);
            		return;
				}
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }         
                sum();
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_transvcce2tran') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('transvcce2tran_s.aspx', q_name + '_s', "600px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                _bbsAssign();
                for (var ix = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
            	if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box('z_transvcce2tran.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtNoa').val()), '', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['transvcceno'] || !as['transvccenoq'] ) {
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
			function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
			}
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 150px;
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
                width: 800px;
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
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
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
                width: 1900px;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewDatea"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
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
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td><input id="txtMount" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount2" class="lbl"> </a></td>
						<td><input id="txtMount2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTotal2" class="lbl"> </a></td>
						<td><input id="txtTotal2" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a> 登錄日期<br>交運日期</a></td>
					<td align="center" style="width:100px;"><a> 車牌</a></td>
					<td align="center" style="width:100px;"><a> 司機</a></td>
					<td align="center" style="width:100px;"><a> 客戶</a></td>
					<td align="center" style="width:100px;"><a> 計算類別<br>車隊 </a></td>
					<td align="center" style="width:100px;"><a> 起迄地點</a></td>
					<td align="center" style="width:100px;"><a> 產品</a></td>
					<td align="center" style="width:100px;"><a> 收數量</a></td>
					<td align="center" style="width:100px;"><a> 客戶單價</a></td>
					<td align="center" style="width:100px;"><a> 收金額</a></td>
					<td align="center" style="width:100px;"><a> 發數量</a></td>
					<td align="center" style="width:100px;"><a> 司機單價</a></td>
					<td align="center" style="width:100px;"><a> 外車單價</a></td>
					<td align="center" style="width:100px;"><a> 折扣</a></td>
					<td align="center" style="width:100px;"><a> 發金額</a></td>
					
					<td align="center" style="width:100px;"><a> 通行費<br>寄櫃費 </a></td>
					<td align="center" style="width:100px;"><a> 總重<br>淨重 </a></td>
					<td align="center" style="width:100px;"><a> 櫃號</a></td>
					<td align="center" style="width:100px;"><a> PO<br>憑單</a></td>
					<td align="center" style="width:100px;"><a> 里程數</a></td>
					<td align="center" style="width:100px;"><a> 外務</a></td>
					<td align="center" style="width:100px;"><a> 備註</a></td>
					<td align="center" style="width:100px;"><a> 派車單</a></td>
					<td align="center" style="width:100px;"><a> 出車單</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtDatea.*" style="width:95%;" />
						<input type="text" id="txtMon.*" style="display:none;" />
						<input type="text" id="txtTrandate.*" style="width:95%;" />
						<input type="text" id="txtMon2.*" style="display:none;" />
					</td>
					<td><input type="text" id="txtCarno.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtDriverno.*" style="width:95%;float:left;" />
						<input type="text" id="txtDriver.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtCustno.*" style="width:95%;float:left;" />
						<input type="text" id="txtComp.*" style="width:95%;float:left;" />
						<input type="text" id="txtNick.*" style="display:none;" />
					</td>
					<td>
						<select id="cmbCalctype.*" style="width:95%;float:left;"> </select>
						<select id="cmbCarteamno.*" style="width:95%;float:left;"> </select>
					</td>
					<td>
						<input type="text" id="txtStraddrno.*" style="width:95%;float:left;" />
						<input type="text" id="txtStraddr.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtUccno.*" style="width:95%;float:left;" />
						<input type="text" id="txtProduct.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtInmount.*" style="width:95%;" />
						<input type="text" id="txtPton.*" style="display:none;" />
						<input type="text" id="txtMount.*" style="display:none;" />
					</td>
					<td><input type="text" id="txtPrice.*" style="width:95%;" /></td>
					<td><input type="text" id="txtTotal.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtOutmount.*" style="width:95%;" />
						<input type="text" id="txtPton2.*" style="display:none;" />
						<input type="text" id="txtMount2.*" style="display:none;" />
					</td>
					<td><input type="text" id="txtPrice2.*" style="width:95%;" /></td>
					<td><input type="text" id="txtPrice3.*" style="width:95%;" /></td>
					<td><input type="text" id="txtDiscount.*" style="width:95%;" /></td>
					<td><input type="text" id="txtTotal2.*" style="width:95%;" /></td>					
					<td>
						<input type="text" id="txtTolls.*" style="width:95%;" />
						<input type="text" id="txtReserve.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtGross.*" style="width:95%;" />
						<input type="text" id="txtWeight.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtCaseno.*" style="width:95%;float:left;" />
						<input type="text" id="txtCaseno2.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtPo.*" style="width:95%;float:left;" />
						<input type="text" id="txtCustorde.*" style="width:95%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtBmiles.*" style="width:20%;float:left;" />
						<input type="text" id="txtEmiles.*" style="width:20%;float:left;" />
						<input type="text" id="txtMiles.*" style="width:20%;float:left;" />
						<input type="text" id="txtGps.*" style="width:20%;float:left;" />
					</td>
					<td>
						<input type="text" id="txtSalesno.*" style="width:95%;float:left;" />
						<input type="text" id="txtSales.*" style="width:95%;float:left;" />
					</td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td>
						<input type="text" id="txtTransvcceno.*" style="width:95%;" />
						<input type="text" id="txtTransvccenoq.*" style="display:none;" />
						<input type="text" id="txtCommandid.*" style="display:none;" />
						<input type="text" id="txtTaskcontent.*" style="width:95%;" />
					</td>
					<td>
						<input type="text" id="txtTranno.*" style="width:95%;" />
						<input type="text" id="txtTrannoq.*" style="display:none;" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
