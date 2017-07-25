<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
            $(document).ready(function() {

                q_getId();
                q_gf('', 'z_acbe2');

                $('.year3').hide();

                $('#btnOk').click(function() {
                    var t_byear = $('#txtByear').val();
                    var t_eyear = $('#txtEyear').val();

                    var t_part1 = $('#combPart1').val();
                    var t_part2 = $('#combPart2').val();

                    var t_bmon1 = $('#txtBmon1').val();
                    var t_emon1 = $('#txtEmon1').val();

                    var t_bmon2 = $('#txtBmon2').val();
                    var t_emon2 = $('#txtEmon2').val();

                    var part1 = $('#combPart1').val();
                    var t_part1 = (part1 == 'zzz' ? '' : document.getElementById('combPart1')[document.getElementById('combPart1').selectedIndex].outerText);

                    var proj1 = $('#combProj1').val();
                    var t_proj1 = (proj1 == 'zzz' ? '' : document.getElementById('combProj1')[document.getElementById('combProj1').selectedIndex].outerText);

                    var part2 = $('#combPart2').val();
                    var t_part2 = (part2 == 'zzz' ? '' : document.getElementById('combPart2')[document.getElementById('combPart2').selectedIndex].outerText);

                    var proj2 = $('#combProj2').val();
                    var t_proj2 = (proj2 == 'zzz' ? '' : document.getElementById('combProj2')[document.getElementById('combProj2').selectedIndex].outerText);

                    var t_year3 = ' ',
                        t_part3 = ' ',
                        t_bmon3 = ' ',
                        t_emon3 = ' ',
                        part3 = ' ',
                        proj3 = ' ',
                        t_part3 = ' ',
                        t_proj3 = ' ';
                    if ($('#chk3')[0].checked) {
                        t_year3 = $('#txtYear3').val();
                        t_part3 = $('#combPart3').val();
                        t_bmon3 = $('#txtBmon3').val();
                        t_emon3 = $('#txtEmon3').val();
                        part3 = $('#combPart3').val();
                        t_part3 = (part3 == 'zzz' ? '' : document.getElementById('combPart3')[document.getElementById('combPart3').selectedIndex].outerText);

                        proj3 = $('#combProj3').val();
                        t_proj3 = (proj3 == 'zzz' ? '' : document.getElementById('combProj3')[document.getElementById('combProj3').selectedIndex].outerText);
                    }

                    if (q_getPara('sys.project') == 'dc') {
                        //     $('#chkXpart input:checkbox:checked').click(function () {
                        var cbxAcpart1 = new Array(),
                            cbxAcpart2 = new Array(),
                            cbxAcpart3 = new Array();
                        t_part1 = '';
                        t_part2 = '';
                        t_part3 = '';
                        $('#chkXpart1 input:checkbox:checked').each(function(i) {
                            cbxAcpart1[i] = this.value;
                        });
                        for (var i = 0; i < cbxAcpart1.length; i++) {
                            t_part1 = t_part1 + '^' + cbxAcpart1[i];
                        }
                        $('#chkXpart2 input:checkbox:checked').each(function(i) {
                            cbxAcpart2[i] = this.value;
                        });
                        for (var i = 0; i < cbxAcpart2.length; i++) {
                            t_part2 = t_part2 + '^' + cbxAcpart2[i];
                        }
                        $('#chkXpart3 input:checkbox:checked').each(function(i) {
                            cbxAcpart3[i] = this.value;
                        });
                        for (var i = 0; i < cbxAcpart3.length; i++) {
                            t_part3 = t_part3 + '^' + cbxAcpart3[i];
                        }
                        //       });
                    }

                    if (q_getPara('sys.project') == 'dc') {
                        t_part1 = t_part1.substr(1);
                        t_part2 = t_part2.substr(1);
                        t_part3 = t_part3.substr(1);
                    } else {
                        t_part = t_part
                    }

                    var t_detail = $('#chkDetail')[0].checked;
                    t_detail = ( t_detail ? 1 : 0);

                    var t_para = "r_comp=" + q_getPara('sys.comp') + ",r_accy=" + q_date().substr(0, r_len) + ",r_cno=" + r_cno + ",year1=" + t_byear + ",bmon1=" + t_bmon1 + ",bmon2=" + t_bmon2 + ",partp1=" + t_part1 + ",proj1=" + t_proj1 + ",year2=" + t_eyear + ",emon1=" + t_emon1 + ",emon2=" + t_emon2 + ",partp2=" + t_part2 + ",proj2=" + t_proj2 + ",year3=" + t_year3 + ",bmon3=" + t_bmon3 + ",emon3=" + t_emon3 + ",partp3=" + t_part3 + ",proj3=" + t_proj3;
                    if (r_len == 4) {
                        t_byear = padL("" + (parseFloat(t_byear) - 1911), "0", 3);
                        t_eyear = padL("" + (parseFloat(t_eyear) - 1911), "0", 3);
                        if ($('#chk3')[0].checked)
                            t_year3 = padL("" + (parseFloat(t_year3) - 1911), "0", 3);
                    }

                    var t_where = r_accy + ';' + r_cno + ';' + t_byear + ';' + t_bmon1 + ';' + t_emon1 + ';' + t_part1 + ';' + proj1 + ';' + t_eyear + ';' + t_bmon2 + ';' + t_emon2 + ';' + t_part2 + ';' + proj2 + ';' + t_year3 + ';' + t_bmon3 + ';' + t_emon3 + ';' + t_part3 + ';' + proj3 + ';' + t_detail;

                    //ret = qExec.z_acbe2a("101", "1", "101", "01", "12", "", "101", "01", "12", "", "0");  /// z_acbe2

                    q_gtx(($('#chk3')[0].checked ? "z_acbe2b" : "z_acbe2a"), t_where + ";;" + t_para + ";;z_acbe2;;" + q_getMsg('qTitle'));
                });
            });
            function q_gfPost() {
                q_popAssign();
                //q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
                q_gt('ssspart', "where=^^ noa='" + r_userno + "' ^^", 0, 0, 0, "", r_accy + '_' + r_cno);
                q_gt('proj', '', 0, 0, 0, "", '');

                t_accy = q_date().substr(0, r_len);

                if (q_getPara('sys.project') == 'dc')
                    $('#combPart').hide();
                else
                    $('.chkXpart').hide();

                $('#txtByear').val(parseFloat(t_accy) - 1);
                $('#txtEyear').val(t_accy);
                $('#txtBmon1').val('01');
                $('#txtEmon1').val('12');
                $('#txtBmon2').val('01');
                $('#txtEmon2').val('12');
                $('#txtBmon3').val('01');
                $('#txtEmon3').val('12');
                var sys_proj = q_getPara('accc.proj');
                if (sys_proj == 1)
                    $('.proj').show();
                else
                    $('.proj').hide();

                $('#chk3').change(function() {
                    if ($('#chk3')[0].checked == 1) {
                        $('#txtByear').val(parseFloat(t_accy) - 3);
                        $('#txtEyear').val(parseFloat(t_accy) - 2);
                        $('#txtYear3').val(parseFloat(t_accy) - 1);
                        $('.year3').show();
                    } else
                        $('.year3').hide();
                });
            }

            function q_boxClose(t_name) {
            }

            var ssspart;
            function q_gtPost(t_name) {
                switch (t_name) {
                case 'ssspart':
                    ssspart = _q_appendData("ssspart", "", true);
                    q_gt('acpart', '', 0, 0, 0, "", r_accy + '_' + r_cno);
                    break;
                case 'acpart':
                    t_acpart = '<input type="checkbox" value="xxxxx" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">全選</span>' + '<input type="checkbox" value="yyyyy" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">全取消</span>' + '<input type="checkbox" value="zzzzz" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">無部門</span>'

                    t_part = "zzz@全部";
                    var as = _q_appendData("acpart", "", true);
                    if (q_getPara('acc.lockPart') == '1' && r_rank < 8) {
                        t_part = "";
                        for ( i = 0; i < as.length; i++) {
                            if (r_partno == as[i].noa) {
                                t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                                t_acpart = t_acpart + ('<input type="checkbox" value="' + as[i].noa + '" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">' + as[i].part + '</span>');
                            }

                            for ( j = 0; j < ssspart.length; j++) {
                                if (as[i].noa == ssspart[j].partno) {
                                    t_acpart = t_acpart + ('<input type="checkbox" value="' + as[i].noa + '" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">' + as[i].part + '</span>');
                                    t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                                }
                            }
                        }
                    } else {
                        for ( i = 0; i < as.length; i++) {
                            t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            t_acpart = t_acpart + ('<input type="checkbox" value="' + as[i].noa + '" style="width:25px;height:15px;float:left;"><span style="width:100px;height:25px;display:block;float:left;">' + as[i].part + '</span>');
                        }
                    }
                    q_cmbParse("combPart1", t_part);
                    q_cmbParse("combPart2", t_part);
                    q_cmbParse("combPart3", t_part);

                    $('.chkXpart').html(t_acpart);

                    if (q_getPara('sys.project') == 'dc') {
                        $('#combPart1').hide();
                        $('#combPart2').hide();
                        $('#combPart3').hide();
                    } else
                        $('.chkXpart').hide();

                    checkPart1();
                    checkPart2();
                    checkPart3();
                    //全選
                    $("#chkXpart1").children('input').eq(0).click(function(e) {
                        $("#chkXpart1").children('input').eq(0).prop('checked', false);
                        $("#chkXpart1").children('input').eq(1).prop('checked', false);
                        $("#chkXpart1").children('input').eq(2).prop('checked', true);
                        checkPart1();
                    });
                    $("#chkXpart2").children('input').eq(0).click(function(e) {
                        $("#chkXpart2").children('input').eq(0).prop('checked', false);
                        $("#chkXpart2").children('input').eq(1).prop('checked', false);
                        $("#chkXpart2").children('input').eq(2).prop('checked', true);
                        checkPart2();
                    });
                    $("#chkXpart3").children('input').eq(0).click(function(e) {
                        $("#chkXpart3").children('input').eq(0).prop('checked', false);
                        $("#chkXpart3").children('input').eq(1).prop('checked', false);
                        $("#chkXpart3").children('input').eq(2).prop('checked', true);
                        checkPart3();
                    });
                    //全取消
                    $("#chkXpart1").children('input').eq(1).click(function(e) {
                        $("#chkXpart1").children('input').prop('checked', false);
                    });
                    $("#chkXpart2").children('input').eq(1).click(function(e) {
                        $("#chkXpart2").children('input').prop('checked', false);
                    });
                    $("#chkXpart3").children('input').eq(1).click(function(e) {
                        $("#chkXpart3").children('input').prop('checked', false);
                    });
                    break;
                case 'proj':
                    t_part = "zzz@全部";
                    var as = _q_appendData("proj", "", true);
                    for ( i = 0; i < as.length; i++) {
                        t_part = t_part + (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].proj;
                    }
                    q_cmbParse("combProj1", t_part);
                    q_cmbParse("combProj2", t_part);
                    q_cmbParse("combProj3", t_part);
                    break;
                }
            }

            function checkPart1() {
                if (q_getPara('acc.lockPart') == '1' && r_rank <= 8) {
                    $("#chkXpart1").children('input').attr('Disabled', 'Disabled');
                    $("#chkXpart1").children('input')[0].disabled = false;
                    $("#chkXpart1").children('input')[1].disabled = false;
                    $("#chkXpart1").children('input')[2].disabled = false;
                    $('#chkXpart1').children('input').prop('checked', false);
                    for (var i = 0; i < $('#chkXpart1').children('input').length; i++) {
                        if ($('#chkXpart1').children('input')[i].value == r_partno || i == 2) {
                            $('#chkXpart1').children('input')[i].checked = true;
                            $("#chkXpart1").children('input')[i].disabled = false;
                            continue;
                        }
                        for (var j = 0; j < ssspart.length; j++) {
                            if ($('#chkXpart1').children('input')[i].value == ssspart[j].partno) {
                                $('#chkXpart1').children('input')[i].checked = true;
                                $("#chkXpart1").children('input')[i].disabled = false;
                                break;
                            }
                        }
                    }
                } else {
                    for (var i = 2; i < $('#chkXpart1').children('input').length; i++) {
                        $('#chkXpart1').children('input').eq(i).prop('checked', true);
                    }
                }
            }

            function checkPart2() {
                if (q_getPara('acc.lockPart') == '1' && r_rank <= 8) {
                    $("#chkXpart2").children('input').attr('Disabled', 'Disabled');
                    $("#chkXpart2").children('input')[0].disabled = false;
                    $("#chkXpart2").children('input')[1].disabled = false;
                    $("#chkXpart2").children('input')[2].disabled = false;
                    $('#chkXpart2').children('input').prop('checked', false);
                    for (var i = 0; i < $('#chkXpart2').children('input').length; i++) {
                        if ($('#chkXpart2').children('input')[i].value == r_partno || i == 2) {
                            $('#chkXpart2').children('input')[i].checked = true;
                            $("#chkXpart2").children('input')[i].disabled = false;
                            continue;
                        }
                        for (var j = 0; j < ssspart.length; j++) {
                            if ($('#chkXpart2').children('input')[i].value == ssspart[j].partno) {
                                $('#chkXpart2').children('input')[i].checked = true;
                                $("#chkXpart2").children('input')[i].disabled = false;
                                break;
                            }
                        }
                    }
                } else {
                    for (var i = 2; i < $('#chkXpart2').children('input').length; i++) {
                        $('#chkXpart2').children('input').eq(i).prop('checked', true);
                    }
                }
            }

            function checkPart3() {
                if (q_getPara('acc.lockPart') == '1' && r_rank <= 8) {
                    $("#chkXpart3").children('input').attr('Disabled', 'Disabled');
                    $("#chkXpart3").children('input')[0].disabled = false;
                    $("#chkXpart3").children('input')[1].disabled = false;
                    $("#chkXpart3").children('input')[2].disabled = false;
                    $('#chkXpart3').children('input').prop('checked', false);
                    for (var i = 0; i < $('#chkXpart3').children('input').length; i++) {
                        if ($('#chkXpart3').children('input')[i].value == r_partno || i == 2) {
                            $('#chkXpart3').children('input')[i].checked = true;
                            $("#chkXpart3").children('input')[i].disabled = false;
                            continue;
                        }
                        for (var j = 0; j < ssspart.length; j++) {
                            if ($('#chkXpart3').children('input')[i].value == ssspart[j].partno) {
                                $('#chkXpart3').children('input')[i].checked = true;
                                $("#chkXpart3").children('input')[i].disabled = false;
                                break;
                            }
                        }
                    }
                } else {
                    for (var i = 2; i < $('#chkXpart3').children('input').length; i++) {
                        $('#chkXpart3').children('input').eq(i).prop('checked', true);
                    }
                }
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="dview" id="dview" style="float: left;  width:15%; "  >
				<table class="tview" id="tview"   border="0" cellpadding='2'  cellspacing='0'>
					<tr>
						<td class="td1"><a id='lblAcbe2' class="lbl" style="font-size: xx-large;font-family:dfkai-sb;"></a></td>
					</tr>
				</table>
			</div>
			<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
				<tr>
					<td class="td1"><a id="lblByear"></a></td>
					<td class="td2"  style='width: 70px;'>
					<input id="txtByear"   type="text"  style='width: 50px;'/>
					</td>
					<td class="td3" ><a id="lblBmon1"></a></td>
					<td class="td4">
					<input id="txtBmon1"   type="text" style='width: 50px;'/>
					～
					<input id="txtEmon1"   type="text" style='width: 50px;'/>
					</td>
					<td class="td5 isDC" style='width: 150px;'><a id='lblPart1'></a><select id="combPart1" style="width: 90px;" value=" "></select><div id="chkXpart1" style="width: 280px; display: block; float: left;" class="chkXpart isDC"></div></td>
					<td class="proj" style='width:150px;'><a id='lblProj1'></a><select id="combProj1" style="width: 90px;" value=" "></select></td>
					<td class="td8"><a id='lblDetail'></a>
					<input id="chkDetail" type="checkbox" style=" "/>
					</td>
				</tr>
				<tr>
					<td class="td1"><a id="lblEyear"></a></td>
					<td class="td2" style='width: 70px;'>
					<input id="txtEyear"   type="text" style='width: 50px;'/>
					</td>
					<td class="td3"><a id="lblBmon2"></a></td>
					<td class="td4">
					<input id="txtBmon2"   type="text" style='width: 50px;'/>
					～
					<input id="txtEmon2"   type="text" style='width: 50px;'/>
					</td>
					<td class="td5 isDC"style='width: 150px;'><a id='lblPart2'></a><select id="combPart2" style="width: 90px;" value=" "></select><div id="chkXpart2" style="width: 280px; display: block; float: left;" class="chkXpart isDC"></div></td>
					<td class="proj"style='width: 150px;'><a id='lblProj2'></a><select id="combProj2" style="width: 90px;" value=" "></select></td>
					<td class="td8"><a id='lbl3year'></a>
					<input id="chk3" type="checkbox" style=" "/>
					</td>
				</tr>
				<tr class="year3">
					<td class="td1"><a id="lblYear3"></a></td>
					<td class="td2" style='width: 70px;'>
					<input id="txtYear3"   type="text" style='width: 50px;'/>
					</td>
					<td class="td3"><a id="lblBmon3"></a></td>
					<td class="td4">
					<input id="txtBmon3"   type="text" style='width: 50px;'/>
					～
					<input id="txtEmon3"   type="text" style='width: 50px;'/>
					</td>
					<td class="td5 isDC"style='width: 150px;'><a id='lblPart3'></a><select id="combPart3" style="width: 90px;" value=" "></select><div id="chkXpart3" style="width: 280px; display: block; float: left;" class="chkXpart isDC"></div></td>
					<td class="proj"style='width: 150px;'><a id='lblProj3'></a><select id="combProj3" style="width: 90px;" value=" "></select></td>

				</tr>
			</table>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>

