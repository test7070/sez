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

            var q_name = "carcsc";
            var q_readonly = ['txtNoa','txtInmoney','txtOutmoney','txtWorker','txtTranno'];
            var bbmNum = [['txtWeight', 14, 3, 1], ['txtInprice', 14, 3, 1], ['txtInmount', 14, 3, 1], ['txtInmoney', 14, 0, 1], ['txtOutprice', 14, 3, 1], ['txtOutmount', 14, 3, 1], ['txtOutmoney', 14, 0, 1]];
            // master 允許 key 小數  [物件,整數位數,小數位數, comma Display]
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount = 8;
			q_desc = 1;
			
            aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            , ['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtBoatno', 'lblBoatno', 'boat', 'noa,boat', 'txtBoatno,txtBoat', 'boat_b.aspx']
            ,['txtAddrno', 'lblAddr', 'addr', 'noa,addr,productno,product', 'txtAddrno,txtAddr,txtUccno,txtProduct', 'addr_b.aspx']);
			
			var calctypeItem = new Array();
			function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea','txtMon','txtCustno','txtComp','txtNick','txtAddrno','txtAddr','txtBoatno','txtBoat','txtUccno','txtProduct'],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in curData.include) {
							if (fbbm[i] == curData.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			var curData = new currentData();
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
				q_gt('calctype2', '', 0, 0, 0, "calctypes");
				
				$("#txtAddrno").focus(function() {
					var input = document.getElementById ("txtAddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart = 5;
		                input.selectionEnd =8;
		            }
				});
				$('#cmbCalctype').change(function(e){
        			$('#txtDiscount').val(calctypeItem[$(this)[0].selectedIndex].discount);
        			sum();
        		});
                		
                $('#txtDatea').focusout(function() {
                    q_cd($(this).val(), $(this));
                });
                $('#txtInprice').change(function() {
                    sum();
                });
                $('#txtInmount').change(function() {
                    sum();
                });
                $('#txtOutprice').change(function() {
                    sum();
                });
                $('#txtOutmount').change(function() {
                    sum();
                });
                $('#txtDiscount').change(function() {
                    sum();
                });
            }

            function sum() {
            	$('#txtInmoney').val(round(q_float('txtInprice') * q_float('txtInmount'),0));
                $('#txtOutmoney').val(round(q_float('txtOutprice') * q_float('txtDiscount') * q_float('txtOutmount'),0));
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
			function q_popPost(id) {
				switch(id) {
					case 'txtCustno':
						if ($("#txtCustno").val().length > 0) {
							var t_addrno = $('#txtCustno').val()+'-002';
							var t_where = "where=^^ noa='"+t_addrno+"' ^^";
	                		q_gt('addr', t_where, 0, 0, 0, "");
						}
						break;
				}
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'addr':
                        var as = _q_appendData("addr", "", true);
                        if (as[0] != undefined) {
	                        $('#txtAddrno').val(as[0].noa);
	                        $('#txtAddr').val(as[0].addr);
	                        $('#txtUccno').val(as[0].productno);
	                        $('#txtProduct').val(as[0].product);
                        }
                        break;
                	case 'calctypes':
						var as = _q_appendData("calctypes", "", true);
						var t_item = "@";
						var item = new Array({
								noa : '',
								typea : '',
								discount : 0,
								isOutside : false
							});
						for ( i = 0; i < as.length; i++) {
							if(!(as[i].noa=='D' || as[i].noa=='E'))
								continue;
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
							item.push({
								noa : as[i].noa + as[i].noq,
								typea : as[i].typea,
								discount : as[i].discount,
								isOutside : as[i].isoutside.length == 0 ? false : (as[i].isoutside == "false" || as[i].isoutside == "0" || as[i].isoutside == "undefined" ? false : true)
							});
						}
						q_cmbParse("cmbCalctype", t_item);
						calctypeItem = item;
						if(abbm[q_recno]!=undefined)
							$("#cmbCalctype").val(abbm[q_recno].calctype);
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

                q_box('carcsc_s.aspx', q_name + '_s', "520px", "500px", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
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
                q_box('z_carcs.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
                if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
					return;
				}
				$('#txtWorker').val(r_name);
                sum();
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_carcsc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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
                if (q_tables == 's')
                    bbsAssign();
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

            function checkId(str) {
                if ((/^[a-z,A-Z][0-9]{9}$/g).test(str)) {//身分證字號
                    var key = 'ABCDEFGHJKLMNPQRSTUVWXYZIO';
                    var s = (key.indexOf(str.substring(0, 1)) + 10) + str.substring(1, 10);
                    var n = parseInt(s.substring(0, 1)) * 1 + parseInt(s.substring(1, 2)) * 9 + parseInt(s.substring(2, 3)) * 8 + parseInt(s.substring(3, 4)) * 7 + parseInt(s.substring(4, 5)) * 6 + parseInt(s.substring(5, 6)) * 5 + parseInt(s.substring(6, 7)) * 4 + parseInt(s.substring(7, 8)) * 3 + parseInt(s.substring(8, 9)) * 2 + parseInt(s.substring(9, 10)) * 1 + parseInt(s.substring(10, 11)) * 1;
                    if ((n % 10) == 0)
                        return 1;
                } else if ((/^[0-9]{8}$/g).test(str)) {//統一編號
                    var key = '12121241';
                    var n = 0;
                    var m = 0;
                    for (var i = 0; i < 8; i++) {
                        n = parseInt(str.substring(i, i + 1)) * parseInt(key.substring(i, i + 1));
                        m += Math.floor(n / 10) + n % 10;
                    }
                    if ((m % 10) == 0 || ((str.substring(6, 7) == '7' ? m + 1 : m) % 10) == 0)
                        return 2;
                } else if ((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//西元年
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 3;
                } else if ((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)) {//民國年
                    str = (parseInt(str.substring(0, 3)) + 1911) + str.substring(3);
                    var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$");
                    if (regex.test(str))
                        return 4
                }
                return 0;
                //錯誤
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 95%; 
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
                width: 95%;
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
                font-size: medium;
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

		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();" 
	    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"  
        ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
     >
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td style="width: 20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewDatea'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewCarno'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewDriver'> </a></td>
						<td style="width: 150px; color:black;"><a id='vewAddr'> </a></td>
						<td style="width: 100px; color:black;"><a id='vewNick'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewBoatno'> </a></td>
						<td style="width: 80px; color:black;"><a id='vewBoat'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='carno' style="text-align: center;">~carno</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='addr' style="text-align: left;">~addr</td>
						<td id='nick' style="text-align: center;">~nick</td>
						<td id='boatno' style="text-align: left;">~boatno</td>
						<td id='boat' style="text-align: left;">~boat</td>
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
						<td> </td>
						<td> </td>
						<td class='tdZ'> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/> </td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/> </td>
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon"  type="text"  class="txt c1"/></td>
						<td><input id="btnExport" type="button" style="float:left; width:80%;" value="匯出"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblBoatno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtBoatno"  type="text" style="float:left; width:40%;"/>
							<input id="txtBoat"  type="text" style="float:left; width:60%;"/>
						</td>					
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td><input id="txtCarno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan='2'>
							<input id="txtDriverno"  type="text" style="float:left; width:40%;"/>
							<input id="txtDriver"  type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id="lblCalctype" class="lbl"> </a></td>
						<td><select id="cmbCalctype" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCustno" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtCustno"  type="text" style="float:left; width:40%;"/>
							<input id="txtComp"  type="text" style="float:left; width:60%;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblAddr" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtAddrno"  type="text" style="float:left; width:40%;"/>
							<input id="txtAddr"  type="text" style="float:left; width:60%;"/>
						</td>
						<td><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
						<td>
							<input id="txtUccno"  type="text" style="float:left; width:40%;"/>
							<input id="txtProduct"  type="text" style="float:left; width:60%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWeight" class="lbl"> </a></td>
						<td><input id="txtWeight"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblInprice" class="lbl"> </a></td>
						<td><input id="txtInprice"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblInmount" class="lbl"> </a></td>
						<td><input id="txtInmount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblInmoney" class="lbl"> </a></td>
						<td><input id="txtInmoney"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td><input id="txtDiscount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblOutprice" class="lbl"> </a></td>
						<td><input id="txtOutprice"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblOutmount" class="lbl"> </a></td>
						<td><input id="txtOutmount"  type="text"  class="txt num c1"/></td>
						<td><span> </span><a id="lblOutmoney" class="lbl"> </a></td>
						<td><input id="txtOutmoney"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTranno" class="lbl"> </a></td>
						<td><input id="txtTranno"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
