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
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "etc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtCurmoney','txtCustno'];
            var bbmNum = new Array(['txtMoney', 10, 0], ['txtCurmoney', 10, 2]);
            var bbmMask = [['txtDatea', '999/99/99'], ['txtMon', '999/99'], ['txtTimea', '99:99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 20;
            //ajaxPath = ""; //  execute in Root

            function currentData() {
            }


            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtCarno', 'txtDriverno', 'txtDriver', 'txtStation', 'txtArrow', 'cmbTypea', 'txtMoney'],
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

            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'], ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], ['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']);

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
            }///  end Main()

            function mainPost() {
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('etc.typea'));
                q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
                $('#cmbTypea').focus(function() {
                    var len = $("#cmbTypea").children().length > 0 ? $("#cmbTypea").children().length : 1;
                    $("#cmbTypea").attr('size', len + "");
                }).blur(function() {
                    $("#cmbTypea").attr('size', '1');
                });

                q_cmbParse("cmbArrow", q_getPara('etc.arrow'));
                $('#cmbArrow').focus(function() {
                    var len = $("#cmbArrow").children().length > 0 ? $("#cmbArrow").children().length : 1;
                    $("#cmbArrow").attr('size', len + "");
                }).blur(function() {
                    $("#cmbArrow").attr('size', '1');
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
                    case 'oilorg':
                        var as = _q_appendData("oilorg", "", true);
                        var t_mount = 0, t_money = 0;
                        for ( i = 0; i < as.length; i++) {
                            t_mount += parseFloat(as[i].mount) * 1000;
                            t_money += parseFloat(as[i].money);
                        }
                        t_mount = t_mount / 1000;
                        $("#txtCurmount").addClass('finish');
                        $("#txtCurmount").val(t_mount);
                        $("#txtCurmoney").addClass('finish');
                        $("#txtCurmoney").val(t_money);
                        sum();
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'conn':

                        break;

                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4)
                            q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                        break;

                    case 'sss':
                        ret = getb_ret();
                        if (q_cur > 0 && q_cur < 4)
                            q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                        break;

                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('etc_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                if ($('#txtDatea').val().length == 0)
                    $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtOrgmoney').val($('#txtMoney').val());
                //if($('#txtOilstationno').val().length>0)
                //q_gt('oilorg', "where=^^oilstationno='"+$.trim($('#txtOilstationno').val())+"'^^", 0, 0, 0, "");
                sum();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                $('#txtDatea').focus();
                $('#txtOrgmoney').val($('#txtMoney').val());
                sum();
            }

            function btnPrint() {
                q_box('z_etc.aspx' + "?;;;;" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
            	$('#txtMon').val($.trim($('#txtMon').val()));
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
					alert(q_getMsg('lblMon')+'錯誤。');   
					return;
				}
            	$('#txtDatea').val($.trim($('#txtDatea').val()));
                if (checkId($('#txtDatea').val())==0){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
            	}
            	
            	if($('#cmbTypea').val()=="DRIVERPAY" && $.trim($('#txtMon').val()).length==0)
            		alert('請輸入付款月份。');
            	
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll((t_date.length == 0 ? q_date() : t_date), '/', ''));
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
                // if($('#txtOilstationno').val().length>0)
                //	q_gt('oilorg', "where=^^oilstationno='"+$.trim($('#txtOilstationno').val())+"'^^", 0, 0, 0, "");
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

            function sum() {
                var t_money = q_float('txtMoney');
                var t_orgmoney = q_float('txtOrgmoney');
                var t_curmoney = q_float('txtCurmoney');
                if ($("#txtCurmoney").hasClass('finish') && (q_cur == 1 || q_cur == 2)) {
                    $('#txtCurmoney').val(t_curmoney + t_orgmoney - t_money);
                    $('#txtOrgmoney').val(t_money);
                }
            }

            function q_popFunc(id, key_value) {
                switch(id) {
                    case 'txtOilstationno':
                        if (key_value.length > 0)
                            //q_gt('oilorg', "where=^^oilstationno='"+$.trim(key_value)+"'^^", 0, 0, 0, "");
                            break;
                }
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
                }else if((/^[0-9]{4}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//西元年
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 3;
                }else if((/^[0-9]{3}\/[0-9]{2}\/[0-9]{2}$/g).test(str)){//民國年
                	str = (parseInt(str.substring(0,3))+1911)+str.substring(3);
                	var regex = new RegExp("^(?:(?:([0-9]{4}(-|\/)(?:(?:0?[1,3-9]|1[0-2])(-|\/)(?:29|30)|((?:0?[13578]|1[02])(-|\/)31)))|([0-9]{4}(-|\/)(?:0?[1-9]|1[0-2])(-|\/)(?:0?[1-9]|1\\d|2[0-8]))|(((?:(\\d\\d(?:0[48]|[2468][048]|[13579][26]))|(?:0[48]00|[2468][048]00|[13579][26]00))(-|\/)0?2(-|\/)29))))$"); 
               		if(regex.test(str))
               			return 4
               	}
               	return 0;//錯誤
            }


		</script>
		<style type="text/css">
             #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 1080px; 
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
                width: 1080px;
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
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTimea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewCarno'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDriver'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewStation'> </a></td>
						<td align="center" style="width:40px; color:black;"><a id='vewArrow'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewTypea'> </a></td>
						<td align="center" style="width:60px; color:black;"><a id='vewMoney'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewMon'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMemo'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='timea' style="text-align: center;">~timea</td>
						<td id='carno' style="text-align: center;">~carno</td>
						<td id='driver' style="text-align: center;">~driver</td>
						<td id='station' style="text-align: center;">~station</td>
						<td id='arrow' style="text-align: center;">~arrow</td>
						<td id='typea=cmbTypea' style="text-align: center;">~typea=cmbTypea</td>
						<td id='money' style="text-align: right;">~money</td>
						<td id='mon' style="text-align: center;">~mon</td>
						<td id='memo' style="text-align: center;">~memo</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"><span> </span><a id='lblCustno' class="lbl"> </a></td>
						<td class="td4"><input id="txtCustno"  type="text"  class="txt c1" tag="ETC電子檔的客戶統編"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td>
						<input id="txtTimea"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2">
						<input id="txtCno"  type="text"  class="txt c4"/>
						<input id="txtAcomp"  type="text"  class="txt c5"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDriver' class="lbl btn"> </a></td>
						<td class="td2" >
						<input id="txtDriverno"  type="text"  class="txt c2"/>
						<input id="txtDriver"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtStation"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblArrow' class="lbl"> </a></td>
						<td class="td2"><select id="cmbArrow" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"></select></td>
						<td><span> </span><a id='lblMon' class="lbl"> </a></td>
						<td>
						<input id="txtMon"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMoney"  type="text"  class="txt num c1"/>
						<input id="txtOrgmoney"  type="text"  style="display: none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCurmoney' class="lbl"> </a></td>
						<td class="td4">
						<input id="txtCurmoney"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3">
						<input id="txtMemo"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtWorker"  type="text"  class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>