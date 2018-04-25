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
			var q_name = "trans";
			var q_readonly = ['txtNoa','txtOrdeno','txtWorker','txtWorker2'];
			var bbmNum = [['txtTotal',10,0,1],['txtPrice2',10,0,1],['txtTotal2',10,0,1]];
			var bbmMask = [['txtDatea','999/99/99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 17;

			//['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            //不能彈出瀏覽視窗
            aPop = new Array(
                    ['txtCno', 'lblCno', 'acomp', 'noa,nick', 'txtCno,txtAcomp', 'acomp_b.aspx']
                    , ['txtStraddrno', 'lblStraddrno', 'addr', 'noa,addr', 'txtStraddrno,txtStraddr', 'addr_b.aspx']
                    , ['txtEndaddrno', 'lblEndaddrno_ay',  'addr', 'noa,addr', 'txtEndaddrno,txtEndaddr', 'addr_b.aspx']
                    , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
                    , ['txtCarno', 'lblCarno_ay', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
                    , ['txtBoat', 'lblBoat_ay', 'car2', 'a.noa,driverno,driver', 'txtBoat,txtBoatname,txtShip', 'car2_b.aspx']
			);
            	
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				if(q_getId()[3].length>0)
					q_content = 'where=^^'+q_getId()[3] + '^^ order=^^trandate desc,noa desc^^';
				else
					q_content = 'order=^^trandate desc,noa desc^^';
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				$('#btnIns').val($('#btnIns').val() + "(F8)");
				$('#btnOk').val($('#btnOk').val() + "(F9)");
				q_mask(bbmMask);
                q_cmbParse("cmbCaseend",',北部,中部,南部,回頭車');
				/*$('#txtTrandate').change(function(e){
					getDriverprice();
					getPrice();
				});*/
				
				$('#lblOrdeno_ay').click(function(e){
                    t_custno=$('#txtCustno').val();
                    t_cno=$('#txtCno').val();
                    t_po=$('#cmbCaseend').val();
                    var t_where = "(Cno='"+t_cno+"' or len('"+t_cno+"')=0) and (Custno='"+t_custno+"' or len('"+t_custno+"')=0) and (no2='"+t_po+"' or len('"+t_po+"')=0) and noa in (select noa from view_tranvcce a where isnull(chk1,0)='1' and not exists(select noa from view_trans where ordeno=a.noa))";
                    q_box("tranvcceay_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranvcceay', "100%", "100%", "");
                });
				
			}

			function sum() {
				
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
				    case 'tranvcceay':
                            if (q_cur > 0 && q_cur < 4) {
                                b_ret = getb_ret();
                                if (!b_ret || b_ret.length == 0)
                                    return;
                                    $('#txtOrdeno').val(b_ret[0].noa);
                                    $('#txtCno').val(b_ret[0].cno);
                                    $('#txtAcomp').val(b_ret[0].acomp);
                                    $('#txtCustno').val(b_ret[0].custno);
                                    $('#txtComp').val(b_ret[0].comp);
                                    $('#txtNick').val(b_ret[0].nick);
                                    $('#cmbCaseend').val(b_ret[0].no2);
                                    $('#txtCarno').val(b_ret[0].carno);
                                    $('#txtDriverno').val(b_ret[0].lng);
                                    $('#txtDriver').val(b_ret[0].lat);
                                    $('#txtBoat').val(b_ret[0].timea);
                                    $('#txtBoatname').val(b_ret[0].endlng);
                                    $('#txtShip').val(b_ret[0].endlat);
                                    $('#txtStraddrno').val(b_ret[0].addrno);
                                    $('#txtStraddr').val(b_ret[0].addr);
                                    $('#txtEndaddrno').val(b_ret[0].endaddrno);
                                    $('#txtEndaddr').val(b_ret[0].endaddr);
                                    $('#txtUnit').val(b_ret[0].tranno);
                                    $('#txtAtel').val(b_ret[0].unit);
                                    $('#txtAaddr').val(b_ret[0].carno2);                                 
                             }
                        break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id) {
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('trans_ay_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
			}
			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtTrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
				$('#txtNoq').val('001');
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				sum();
			}
			function btnPrint() {
				q_box('z_tran_ay.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
			function btnOk() {
				Lock(1,{opacity:0});
				
				if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!");
                }
                sum();
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#txtDatea').datepicker('destroy');
				}else{
					$('#txtDatea').datepicker();
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
						<td align="center" style="width:100px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:130px; color:black;">客戶</td>
						<td align="center" style="width:130px; color:black;"><a id="vewAcomp">貨運公司</a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="comp" style="text-align: center;">~comp</td>
						<td id="acomp" style="text-align: center;">~acomp</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
                        <td><span> </span><a id="lblNoa_ay" class="lbl" >單據</a></td>
                        <td><input id="txtNoa" type="text" class="txt c1"/>
                            <input id="txtNoq" type="text" class="txt c1" style="display: none"/>
                        </td>
                        <td><span> </span><a id="lblDatea_ay" class="lbl" >日期</a></td>
                        <td><input id="txtDatea" type="text" class="txt c1" />
                            <input id="txtTrandate" type="text" class="txt c1" style="display: none"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblStatus_ay" class="lbl" >轉運代號</a></td>
                        <td><input id="txtStatus" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >貨運公司</a></td>
                        <td colspan="3"><input id="txtCno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtAcomp" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
                        <td colspan="3"><input id="txtCustno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtComp" type="text" class="txt c1" style="width: 60%;"/>
                            <input id="txtNick" type="text" class="txt c1" style="display: none;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCaseend_ay" class="lbl" >地區</a></td>
                        <td><select id="cmbCaseend" class="txt c1"> </select></td>
                        <td><span> </span><a id="lblOrdeno_ay" class="lbl btn" >派車單號</a></td>
                        <td><input id="txtOrdeno" type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCarno_ay" class="lbl btn" >收件司機</a></td>
                        <td colspan="2"><input id="txtCarno" type="text" class="txt c1" style="width: 30%;"/>
                            <input id="txtDriverno" type="text" class="txt c1" style="width: 30%;"/>
                            <input id="txtDriver" type="text" class="txt c1" style="width: 30%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblBoat_ay" class="lbl btn" >送件司機</a></td>
                        <td colspan="2"><input id="txtBoat" type="text" class="txt c1" style="width: 30%;"/>
                            <input id="txtBoatname" type="text" class="txt c1" style="width: 30%;"/>
                            <input id="txtShip" type="text" class="txt c1" style="width: 30%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblStraddrno" class="lbl btn" >起運點</a></td>
                        <td colspan="3"><input id="txtStraddrno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtStraddr" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblEndaddrno_ay" class="lbl btn" >卸貨點</a></td>
                        <td colspan="3"><input id="txtEndaddrno" type="text" class="txt c1" style="width: 40%;"/>
                            <input id="txtEndaddr" type="text" class="txt c1" style="width: 60%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblSaddr" class="lbl" >公司名稱</a></td>
                        <td colspan="3"><input id="txtSaddr" type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblUnit_ay" class="lbl" >數量</a></td>
                        <td><input id="txtUnit" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAtel_ay" class="lbl" >材積</a></td>
                        <td><input id="txtAtel" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblAaddr_ay" class="lbl" >重量</a></td>
                        <td><input id="txtAaddr" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTotal_ay" class="lbl" >運費</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lblPrice2_ay" class="lbl" >轉運費用</a></td>
                        <td><input id="txtPrice2" type="text" class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTotal2_ay" class="lbl" >司機運費</a></td>
                        <td><input id="txtTotal2" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl" > </a></td>
                        <td colspan="3"><textarea id="txtMemo" style="height:60px;" class="txt c1"> </textarea></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker_ay" class="lbl" >經手人</a></td>
                        <td><input id="txtWorker" type="text" class="txt c1"/></td>
                        <td></td>
                        <td><input id="chkEnda" type="checkbox"/>
                            <span> </span><a id='lblEnda_wj'>結案</a>
                        </td>
                    </tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
