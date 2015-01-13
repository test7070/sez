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
            var q_name = "tax0";
            var q_readonly = ['txtTotal','txtTax'];
            var bbmNum = [['txtMoney',15,0,1],['txtTax',15,0,1],['txtTotal',15,0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 20;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }

            function mainPost() {
            	bbmMask = [['textBdate', r_picd],['textEdate', r_picd],['textMon', r_picm]];
                q_mask(bbmMask);
                
                q_cmbParse("cmbStype", ('').concat(new Array('', '直接外銷')));
                q_cmbParse("cmbOtype", ('').concat(new Array('', '1@1.外銷貨物', '2@2.外銷有關之勞務', '3@3.免稅商店銷售之貨物', '4@4.銷售與免稅事業之貨物','5@5.國際運輸','6@6.國際運輸用之交通器','7@7.國際運輸之貨物與勞務')));
                q_cmbParse("cmbPaper", ('').concat(new Array('', '1@1.非經海關出口應附證明文件', '2@2.經海關出口免附證明文件', '3@3.其他')));
                q_cmbParse("cmbNamea", ('').concat(new Array('', '輸出許可證', '出口報單', '漁業執照', '結匯證實書', '三聯式發票扣抵聯', '佣金計算表')));
                
                $('#txtNoa').change(function(e) {
                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0) {
                        t_where = "where=^^ noa='" + $(this).val() + "'^^";
                        q_gt('tax0', t_where, 0, 0, 0, "checkTax0no_change", r_accy);
                    }
                });
                
				
				$('#btnTax0').click(function() {
					$('#div_tax0').show();
					$('#div_tax0').css('top', $('#btnTax0').offset().top+25);
					$('#div_tax0').css('left', $('#btnTax0').offset().left-$('#div_tax0').width()+$('#btnTax0').width()+10);
				});
				
				$('#btn_div_tax0').click(function() {
					if(emp($('#textMon').val())){
						alert('申報月份禁止空白');
						return;
					}
					if(dec($('#textMon').val().substr(4,2))%2!=1){
						alert('申報月份只能單數月份');
						return;
					}
					var t_mon=!emp($('#textMon').val())?trim($('#textMon').val()):'#non';
					
					q_func('qtxt.query.tax0', 'tax0.txt,tax0,'+t_mon);
				});
				
				$('#btnClose_div_tax0').click(function() {
					$('#div_tax0').hide();
				});
				
				if(dec(q_date().substr(4,2))%2==1)
					$('#textMon').val(q_date().substr(0,6));
				else
					$('#textMon').val(q_cdn(q_date().substr(0,6)+'/01',45).substr(0,6));
				
				$('#textBdate').val(q_cdn($('#textMon').val()+'/01',-45).substr(0,6)+'/01');
				$('#textEdate').val(q_cdn($('#textMon').val()+'/01',-1));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'checkTax0no_change':
                        var as = _q_appendData("tax0", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa);
                        }
                        break;
                    case 'checkTax0no_btnOk':
                        var as = _q_appendData("tax0", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa);
                            Unlock();
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('tax0_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
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
                $('#txtNoa').val($.trim($('#txtNoa').val()));
                /*if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
                 }else{
                 alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
                 Unlock();
                 return;
                 } */
                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('tax0', t_where, 0, 0, 0, "checkTax0no_btnOk", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }

            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
                $('#div_tax0').hide();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
					$('#btnTax0').removeAttr('disabled');
				}else{
					$('#btnTax0').attr('disabled','disabled');
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
            
            function calTax(){
				var t_money=dec($('#txtMoney').val()),t_tax=0,t_total=dec($('#txtTotal').val());
				var t_taxrate = q_div(parseFloat(q_getPara('sys.taxrate')) , 100);
					switch ($('#cmbTaxtype').val()) {
						case '0':
	                    	// 無
							t_tax = 0;
							t_total = q_add(t_money,t_tax);
							break;
	                    case '1':
	                        // 應稅
	                        t_tax = round(q_mul(t_money,t_taxrate), 0);
	                        t_total = q_add(t_money,t_tax);
	                        break;
	                    case '2':
	                        //零稅率
	                        t_tax = 0;
	                        t_total = q_add(t_money,t_tax);
	                        break;
	                    case '3':
	                        // 內含
	                        t_tax = round(q_mul(q_div(t_money,q_add(1,t_taxrate)),t_taxrate), 0);
	                        t_total = t_money;
	                        t_money = q_sub(t_total,t_tax);
	                        break;
	                    case '4':
	                        // 免稅
	                        t_tax = 0;
	                        t_total = q_add(t_money,t_tax);
	                        break;
	                    case '5':
	                        // 自定
	                        $('#txtTax').attr('readonly', false);
	                        $('#txtTax').css('background-color', 'white').css('color', 'black');
	                        t_tax = round(q_float('txtTax'), 0);
	                        t_total = q_add(t_money,t_tax);
	                        break;
	                    case '6':
	                        // 作廢-清空資料
	                        t_money = 0, t_tax = 0, t_total = 0;
	                        break;
	                    default:
					}
				
				$('#txtMoney').val(FormatNumber(t_money));
				$('#txtTax').val(FormatNumber(t_tax));
				$('#txtTotal').val(FormatNumber(t_total));
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
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                	case 'qtxt.query.tax0':
                		alert("資料匯入完成!!");
                		$('#div_tax0').hide();
                		
                		var s2=[];
						s2[0]=q_name + '_s';
						s2[1]="where=^^ datea<='"+q_date()+"' ^^"
						q_boxClose2(s2);
                		break;
                }
			}
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 25%;
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
                width: 73%;
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
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="div_tax0" style="position:absolute; top:0px; left:0px; display:none; width:310px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_tax0" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;width: 110px;text-align: center;">申報月份</td>
					<td style="background-color: #f8d463;"><input id='textMon' type='text' style='text-align:left;width:80px;'/></td>
				</tr>
				<tr id='tax0_close'>
					<td align="center" colspan='2'>
						<input id="btn_div_tax0" type="button" value="匯入零稅率">
						<input id="btnClose_div_tax0" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:30%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:28%"><a id='vewNoa'>發票號碼</a></td>
						<td align="center" style="width:15%"><a id='vewDatea'>發票日期</a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='datea'>~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 68%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl">發票號碼</a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblDatea' class="lbl">發票日期</a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblStype' class="lbl">銷售方式</a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td> </td>
						<td><input id="btnTax0" type="button" value="銷項匯入"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl">買受人</a></td>
						<td><input id="txtCustno"  type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtComp"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblEdate' class="lbl">結匯日期</a></td>
						<td><input id="txtEdate"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProduct' class="lbl">貨品名稱</a></td>
						<td><input id="txtProductno"  type="text" class="txt c1" /></td>
						<td colspan="2"><input id="txtProduct"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblMount' class="lbl">貨品數量</a></td>
						<td><input id="txtMount"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOtype' class="lbl">外銷方式</a></td>
						<td colspan="2"><select id="cmbOtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblMoney' class="lbl">銷售金額</a></td>
						<td><input id="txtMoney"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPaper' class="lbl">外銷文件</a></td>
						<td colspan="2"><select id="cmbPaper" class="txt c1"> </select></td>
						<td><span> </span><a id='lblSerial' class="lbl">統一編號</a></td>
						<td><input id="txtSerial"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl">文件名稱</a></td>
						<td colspan="2"><select id="cmbNamea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPno' class="lbl">文件號碼</a></td>
						<td colspan="2"><input id="txtPno"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblPtype' class="lbl">文件類別</a></td>
						<td><input id="txtPtype"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOdate' class="lbl">報關日期</a></td>
						<td><input id="txtOdate"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
