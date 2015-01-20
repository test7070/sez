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

            q_desc = 1
            var q_name = "tre_accc";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtPaybno', 'txtPayeno', 'txtChkeno', 'txtAccno1', 'txtAccno2', 'txtAccno3', 'txtBdriver', 'txtEdriver', 'txtTotal', 'txtTreno'];
            var bbmNum = [['txtOpay', 11, 0, 1], ['txtUnopay', 11, 0, 1], ['txtTotal', 11, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtBdriverno', 'lblBdriver', 'driver', 'noa,namea', 'txtBdriverno,txtBdriver', 'driver_b.aspx'], ['txtEdriverno', 'lblEdriver', 'driver', 'noa,namea', 'txtEdriverno,txtEdriver', 'driver_b.aspx'], ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }///  end Main()

            function mainPost() {
                q_modiDay = q_getPara('sys.modiday2');
                /// 若未指定， d4=  q_getPara('sys.modiday');
                bbmMask = new Array(['txtDatea', r_picd], ['txtMon', r_picm]);
                q_mask(bbmMask);
                bbmMask2 = new Array(['txtBdate', r_picd], ['txtEdate', r_picd]);
                q_mask(bbmMask2);
                q_gt('carteam', '', 0, 0, 0, "");
                $("#cmbCarteamno").focus(function() {
                    var len = $("#cmbCarteamno").children().length > 0 ? $("#cmbCarteamno").children().length : 1;
                    $("#cmbCarteamno").attr('size', len + "");
                }).blur(function() {
                    $("#cmbCarteamno").attr('size', '1');
                });

                /*$("#cmbCarteamno2").focus(function() {
                 var len = $("#cmbCarteamno2").children().length > 0 ? $("#cmbCarteamno2").children().length : 1;
                 $("#cmbCarteamno2").attr('size', len + "");
                 }).blur(function() {
                 $("#cmbCarteamno2").attr('size', '1');
                 });*/

                $('#lblAccno1').click(function() {
                    q_pop('txtAccno1', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno1').val() + "';" + $('#txtDatea').val().substr(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                    //q_gt('sss',  " field=noa,namea,rank where=^^LEFT(noa,1)='A'^^");
                });
                $('#lblAccno2').click(function() {
                    q_pop('txtAccno2', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno2').val() + "';" + $('#txtDatea').val().substr(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                    //q_gt('sss',  " field=noa,namea,rank where=^^LEFT(noa,1)='A'^^");
                });
                $('#lblAccno3').click(function() {
                    q_pop('txtAccno3', "accc.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";accc3='" + $('#txtAccno3').val() + "';" + $('#txtDatea').val().substr(0, 3) + '_' + r_cno, 'accc', 'accc3', 'accc2', "92%", "1054px", q_getMsg('popAccc'), true);
                    //q_gt('sss',  " field=noa,namea,rank where=^^LEFT(noa,1)='A'^^");
                });

                $('#lblTreno').click(function() {
                    q_box('tre.aspx' + "?;;;charindex(noa,'" + $('#txtTreno').val() + "')>0;" + r_accy, '', "92%", "92%", "支票列印");
                });

                if ((/^.*(tre_accc,1,[0|1],1,[0|1],[0|1],[0|1],[0|1],[0|1]).*$/g).test(q_auth.toString())) {
                    $('#btnAccc').click(function() {
                        show_confirm()
                    });
                }
                $('#btnGqb').click(function() {
                    q_box('z_gqbp.aspx' + "?;;;;" + r_accy + ";noa=" + trim($('#txtChkbno').val()), '', "92%", "92%", "支票列印");
                });

                $('#btnBank').click(function() {
                    q_func('banktran.gen', $('#txtNoa').val() + ',1');
                });

                $('#btnBank2').click(function() {
                    q_func('banktran.gen2', $('#txtNoa').val() + ',1');
                });
                $('#txtAcc1').change(function() {
                    var s1 = trim($(this).val());
                    if (s1.length > 4 && s1.indexOf('.') < 0)
                        $(this).val(s1.substr(0, 4) + '.' + s1.substr(4));
                    if (s1.length == 4)
                        $(this).val(s1 + '.');
                });
                $('#lblChkbno').click(function(e) {
                    if ($('#txtChkbno').val().length > 0 && $('#txtChkeno').val().length > 0)
                        q_pop('', "gqb.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";(gqbno between '" + $('#txtChkbno').val() + "' and '" + $('#txtChkeno').val() + "');" + r_accy + '_' + r_cno, 'gqb', 'gqbno', 'gqbno', "95%", "95%", q_getMsg('popGqb'), true);
                    else
                        alert('無' + q_getMsg('lblChkbno') + '。');
                });
            }

            function show_confirm() {
                var r = confirm("你確定要執行嗎?");
                if (r == true) {
                    alert("確定執行");
                    if ($('#txtNoa').val().length > 0)
                    	Lock(1,{opacity:0});
                        q_func('tre_accc.gen', r_accy + ',' + $('#txtNoa').val());
                } else {
                    alert("取消執行");
                }
            }

            function q_funcPost(t_func, result) {

                var s1 = location.href;
                var t_path = (s1.substr(7, 5) == 'local' ? xlsPath : s1.substr(0, s1.indexOf('/', 10)) + '/htm/');
                if (t_func == 'banktran.gen') {
                    window.open(t_path + 'obtdta.txt', "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
                    return;
                }
                if (t_func == 'banktran.gen2') {
                    window.open(t_path + 'obtdta2.txt', "_blank", 'directories=no,location=no,menubar=no,resizable=1,scrollbars=1,status=0,toolbar=1');
                    return;
                }

                if (result.length > 0) {
                    var s2 = result.split(';');
                    for (var i = 0; i < s2.length; i++) {
                        switch (i) {
                            case 0:
                                $('#txtAccno1').val(s2[i]);
                                abbm[q_recno].accno1 = s2[i];
                                break;
                            case 1:
                                $('#txtAccno2').val(s2[i]);
                                abbm[q_recno].accno2 = s2[i];
                                break;
                            case 2:
                                $('#txtAccno3').val(s2[i]);
                                abbm[q_recno].accno3 = s2[i];
                                break;
                            case 3:
                                $('#txtChkeno').val(s2[i]);
                                abbm[q_recno].checkno = s2[i];
                                break;
                            case 5:
                                $('#txtMemo').val(s2[i]);
                                abbm[q_recno].memo = s2[i];
                                break;
                            case 6:
                                $('#txtTotal').val(s2[i]);
                                abbm[q_recno].total = s2[i];
                                break;
                        } //end switch
                    } //end for
                }//end  if
				Unlock(1);
                alert('功能執行完畢');

            }//endfunction

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function txtCopy(dest, source) {
                var adest = dest.split(',');
                var asource = source.split(',');
                $('#' + adest[0]).focus(function() {
                    if (trim($(this).val()).length == 0)
                        $(this).val(q_getMsg('msgCopy'));
                });
                $('#' + adest[0]).focusout(function() {
                    var t_copy = ($(this).val().substr(0, 1) == '=');
                    var t_clear = ($(this).val().substr(0, 2) == ' =');
                    for (var i = 0; i < adest.length; i++) { {
                            if (t_copy)
                                $('#' + adest[i]).val($('#' + asource[i]).val());

                            if (t_clear)
                                $('#' + adest[i]).val('');
                        }
                    }
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

                    case 'carteam':
                        var as = _q_appendData("carteam", "", true);
                        var t_item = "";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteamno", t_item);
                        //q_cmbParse("cmbCarteamno2", t_item);
                        $("#cmbCarteamno").val(abbm[q_recno].carteamno);

                        //$("#cmbCarteamno2").val(abbm[q_recno].carteamno);
                        q_gridv('tview', browHtm, fbrow, abbm, aindex, brwNowPage, brwCount);
                        refresh(q_recno);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        /* if (q_cur == 1 || q_cur == 2)
                         q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);*/

                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('tre_accc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
                if (q_chkClose())
                    return;

                alert('修改完後，請手動重新產生【會計傳票、支票、銀行轉帳文字檔】');
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                if (!(/^[0-9,A-Z,a-z]*$/).test($('#txtChkbno').val())) {
                    alert(q_getMsg('lblChkbno') + '格式錯誤!\n只允許英文、數字。');
                    return;
                }
                if ($.trim($('#txtChkbno').val()).length > 0 && $.trim($('#txtAccount').val()).length == 0) {
                    alert('請輸入 ' + q_getMsg('lblAccount') + '。');
                    return;
                }
                $('#txtBdate').val($.trim($('#txtBdate').val()));
                if (checkId($('#txtBdate').val()) == 0) {
                    alert(q_getMsg('lblBdate') + '錯誤。');
                    return;
                }
                $('#txtEdate').val($.trim($('#txtEdate').val()));
                if (checkId($('#txtEdate').val()) == 0) {
                    alert(q_getMsg('lblEdate') + '錯誤。');
                    return;
                }
                $('#txtWorker').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tre_accc') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
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

                if (t_para) {
                    $('#btnAccc').removeAttr('disabled');
                    $('#btnGqb').removeAttr('disabled');
                    $('#btnBank').removeAttr('disabled');
                    $('#btnBank2').removeAttr('disabled');
                } else {
                    $('#btnAccc').attr('disabled', 'disabled');
                    $('#btnGqb').attr('disabled', 'disabled');
                    $('#btnBank').attr('disabled', 'disabled');
                    $('#btnBank2').attr('disabled', 'disabled');
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
                if (q_chkClose())
                    return;
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
                width: 350px;
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
                width: 700px;/*650px*/
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 600px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 600px;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px"><a id='vewBdate'> </a></td>
						<td align="center" style="width:60px"><a id='vewCarteamno'> </a></td>
						<td align="center" style="width:60px"><a id='vewTotal'> </a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='bdate edate' style="text-align: center;">~bdate ~edate</td>
						<td id="carteamno=cmbCarteamno" style="text-align: center;">~carteamno=cmbCarteamno</td>
						<td id="total,0,1" style="text-align: center;">~total,0,1</td>
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
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td>
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td>
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td>
						<input id="txtTimea"  type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBdate' class="lbl" title="對應司機立帳的立帳日期，包含符合此日期區間的。"> </a></td>
						<td>
						<input id="txtBdate" type="text"  class="txt c1"/>
						</td>
						<td align="center"><a id="lblSymbol"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td>
						<input id="txtEdate" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td><select id="cmbCarteamno" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblOpay' class="lbl"> </a></td>
						<td>
						<input id="txtOpay"  type="text"  class="txt num c1"/>
						</td>
						<td><span> </span><a id='lblUnopay' class="lbl"> </a></td>
						<td>
						<input id="txtUnopay"  type="text"  class="txt num c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblChkbno' class="lbl btn"> </a></td>
						<td>
						<input id="txtChkbno" type="text"  class="txt c1"/>
						</td>
						<td align="center"><a id="lblChkeno"  style="font-weight: bold;font-size: 24px;"> </a></td>
						<td>
						<input id="txtChkeno" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id='lblTotal' class="lbl"> </a></td>
						<td>
						<input id="txtTotal"  type="text"  class="txt num c1"/>
						</td>
						<td style="display:none;">
						<input id="txtAcc1" style="display:none;"/>
						<input id="txtAcc2" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td>
						<input id="txtAccount"  type="text"  class="txt c1"/>
						</td>
						<td colspan="3"><a id="lblAtype" > </a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAccno1" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno1" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblAccno2" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno2" type="text"  class="txt c1"/>
						</td>
						<td><span> </span><a id="lblAccno3" class="lbl btn"> </a></td>
						<td>
						<input id="txtAccno3" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTreno" class="lbl btn"> </a></td>
						<td colspan="4">
						<input id="txtTreno" type="text"  class="txt c1"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="4">						<textarea id="txtMemo" style="width: 100%;height: 60px;"> </textarea></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2">
						<input id="btnAccc" type="button"/>
						</td>
						<td colspan="2" align="left"><a id="lblPunchline" style="color: #FF55A8;font-weight: bolder;font-size: 18px;"></a></td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2">
						<input id="btnGqb" type="button"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2">
						<input id="btnBank" type="button"/>
						</td>
					</tr>
					<tr>
						<td></td>
						<td colspan="2">
						<input id="btnBank2" type="button"/>
						</td>
						<td></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

