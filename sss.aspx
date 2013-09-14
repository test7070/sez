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
            
            var q_name = "sss";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 15;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtCno','lblAcomp','acomp','noa,acomp','txtCno,txtComp','acomp_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                
                if (r_rank>=7)
					q_content = "";
				else
					q_content = "where=^^noa='" + r_userno + "'^^";

				q_gt(q_name, q_content, q_sqlCount, 1)
                

                //q_gt('authority', "where=^^a.noa='sss' and a.sssno='" + r_userno + "'^^", q_sqlCount, 1)

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
                bbmMask = [['txtBirthday', r_picd], ['txtFt_date', r_picd], ['txtIndate', r_picd], ['txtOutdate', r_picd], ['txtMobile1', '9999999999'], ['txtMobile2', '9999999999'], ['txtHealth_bdate', r_picd], ['txtHealth_edate', r_picd], ['txtLabor1_bdate', r_picd], ['txtLabor1_edate', r_picd], ['txtLabor2_bdate', r_picd], ['txtLabor2_edate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('sss.typea'));
                q_cmbParse("cmbSex", q_getPara('sss.sex'));
                q_cmbParse("cmbPerson", q_getPara('person.typea'));
                //q_cmbParse("cmbRecord", ('').concat(new Array('國小', '國中', '高中', '高職', '大專', '大學', '碩士', '博士')));
                q_cmbParse("cmbBlood", ('').concat(new Array('A', 'B', 'AB', 'O')));
                
                $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('sss', t_where, 0, 0, 0, "checkSssno_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
                
                $("#cmbTypea").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbSex").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbPerson").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbRecord").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbBlood").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                
                q_gt('acomp', '', 0, 0, 0, "");
                q_gt('part', '', 0, 0, 0, "");
                q_gt('salm', '', 0, 0, 0, "");
                /*$("#cmbCno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });*/
                $("#cmbPartno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                $("#cmbJobno").focus(function() {
                    var len = $(this).children().length > 0 ? $(this).children().length : 1;
                    $(this).attr('size', len + "");
                }).blur(function() {
                    $(this).attr('size', '1');
                });
                         
                $('#btnLabases').click(function(e) {
                    q_box("labase.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'labase', "95%", "95%", q_getMsg("popLabase"));
                });
                $('#btnSsspart').click(function(e) {
                    q_box("ssspart_b.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'ssspart', "60%", "95%", q_getMsg("popSsspart"));
                });
                $('#btnSaladjust').click(function(e) {
                    q_box("salAdjust.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'saladjust', "95%", "95%", q_getMsg("popSaladjust"));
                });

                $('#txtIndate').change(function(e) {
                    if (!emp($('#txtIndate').val())) {
                        $('#txtHealth_bdate').val($('#txtIndate').val());
                        $('#txtLabor1_bdate').val($('#txtIndate').val());
                        $('#txtLabor2_bdate').val($('#txtIndate').val());
                    }
                });
                $('#txtOutdate').change(function(e) {
                    if (!emp($('#txtOutdate').val())) {
                        $('#txtHealth_edate').val($('#txtOutdate').val());
                        $('#txtLabor1_edate').val($('#txtOutdate').val());
                        $('#txtLabor2_edate').val($('#txtOutdate').val());
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
                	case 'checkSssno_change':
                		var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                        }
                		break;
                	case 'checkSssno_btnOk':
                		var as = _q_appendData("sss", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case 'authority':
                        var as = _q_appendData('authority', '', true);
                        if (as.length > 0 && as[0]["pr_run"] == "true")
                            q_content = "";
                        else
                            q_content = "where=^^noa='" + r_userno + "'^^";

                        q_gt(q_name, q_content, q_sqlCount, 1)
                        break;
                    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_item);
                            if(abbm[q_recno]!=undefined)
                            	$("#cmbPartno").val(abbm[q_recno].partno);
                        }
                        break;
                    case 'salm':
                        var as = _q_appendData("salm", "", true);
                        if (as[0] != undefined) {
                            var t_item = "";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].job;
                            }
                            q_cmbParse("cmbJobno", t_item);
                            if(abbm[q_recno]!=undefined)
                            	$("#cmbJobno").val(abbm[q_recno].jobno);
                        }
                        break;
                	/*case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_item);
                        $("#cmbCno").val(abbm[q_recno].cno);
                        break;*/
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('sss_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi(1);
                refreshBbm();
                /// 允許修改
                $('#txtNamea').focus();
                $('#txtNoa').attr('disabled', 'disabled');
            }

            function btnPrint() {
            	q_box('z_sssp.aspx', '', "90%", "600px", q_getMsg("popPrint"));
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
            	Lock(); 
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
            	if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}
                if (!q_cd($('#txtBirthday').val())){
                	alert(q_getMsg('lblBirthday')+'錯誤。');
               		 Unlock();
                	return;
                }
                if (!q_cd($('#txtFt_date').val())){
                	alert(q_getMsg('lblFt_date')+'錯誤。');
                	Unlock();
                	return;
                }
                if (!q_cd($('#txtIndate').val())){
                	alert(q_getMsg('lblIndate')+'錯誤。');
                	Unlock();
                	return;
                }
                if (!q_cd($('#txtOutdate').val())){
                	alert(q_getMsg('lblOutdate')+'錯誤。');
                	Unlock();
                	return;
                }
               
            	//$('#txtAcomp').val($('#cmbCno').find(":selected").text());
                $('#txtPart').val($('#cmbPartno').find(":selected").text());
                $('#txtJob').val($('#cmbJobno').find(":selected").text());
                
                if (!emp($('#txtId').val()))
                    $('#txtId').val($('#txtId').val().toUpperCase());
				if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('sss', t_where, 0, 0, 0, "checkSssno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
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
               refreshBbm();
            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
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
                width: 250px; 
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
                width: 700px;
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
                width: 15%;
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
            .txt.c2 {
                width: 30%;
                float: left;
            }
            .txt.c3 {
                width: 69%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:70px; color:black;"><a id='vewNoa'></a></td>
						<td align="center" style="width:150px; color:black;"><a id='vewNamea'></a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='namea' style="text-align: center;">~namea</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td><input id="txtNamea" type="text" class="txt c1" />	</td>
						<td><span> </span><a id="lblPerson" class="lbl"> </a></td>
						<td><select id="cmbPerson" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblId' class="lbl"> </a></td>
						<td><input id="txtId"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblBirthday' class="lbl"> </a></td>
						<td><input id="txtBirthday"  type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblBlood' class="lbl"> </a></td>
						<td><select id="cmbBlood" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSex' class="lbl"> </a></td>
						<td><select id="cmbSex" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text"  class="txt c1"/></td>
						<td><input id="chkMarried" type="checkbox" style="float: right;"/></td>
						<td><a id='vewMarried'> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMobile1' class="lbl"> </a></td>
						<td><input id="txtMobile1" type="text" class="txt c1"/>	</td>
						<td><span> </span><a id='lblMobile2' class="lbl"> </a></td>
						<td><input id="txtMobile2"  type="text"  class="txt c1"/></td>
						<td><input id="chkIswelfare" type="checkbox" style="float: right;"/></td>
						<td><a id='vewIswelfare'> </a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_home" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_home"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAddr_conn" class="lbl"> </a></td>
						<td colspan="5"><input id="txtAddr_conn"  type="text"  class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEmail" class="lbl"> </a></td>
						<td colspan="5"><input id="txtEmail"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRecord' class="lbl"> </a></td>
						<td colspan="2"><input id="txtSchool" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td colspan="2"><input id="txtAccount"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblFt_date' class="lbl"> </a></td>
						<td><input id="txtFt_date" type="text" class="txt c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate" type="text" class="txt c1"/>	</td>
						<td><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td><input id="txtOutdate"  type="text" class="txt c1" /></td>
					</tr>
					<!--<tr>
						<td><span> </span><a id='lblHealth_bdate' class="lbl"> </a></td>
						<td><input id="txtHealth_bdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblHealth_edate' class="lbl"> </a></td>
						<td><input id="txtHealth_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLabor1_bdate' class="lbl"> </a></td>
						<td><input id="txtLabor1_bdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblLabor1_edate' class="lbl"> </a></td>
						<td><input id="txtLabor1_edate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLabor2_bdate' class="lbl"> </a></td>
						<td><input id="txtLabor2_bdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblLabor2_edate' class="lbl"> </a></td>
						<td><input id="txtLabor2_edate" type="text" class="txt c1"/></td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblPart" class="lbl btn"> </a></td>
						<td>
							<select id="cmbPartno" class="txt c1"> </select>
							<input id="txtPart"  type="text" style="display: none;"/>
						</td>
						<td><span> </span><a id="lblJob" class="lbl btn"> </a></td>
						<td>
							<select id="cmbJobno" class="txt c1"> </select>
							<input id="txtJob"  type="text" style="display: none;"/>
						</td>
					</tr>
					<tr style="display: none;"><!--公司-->
						<td><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCno"  type="text" class="txt c2"/>
							<input id="txtComp"  type="text" class="txt c3"/>
						</td>
					</tr>					
					<tr>
						<td><span> </span><a id="lblConn" class="lbl"> </a></td>
						<td><input id="txtConn"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblConntel" class="lbl"> </a></td>
						<td><input id="txtConntel"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td><input id='btnSsspart' type="button"/></td>
						<td><input id='btnSaladjust' type="button"/></td>
						<td><input id='btnLabases' type="button" />	</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

