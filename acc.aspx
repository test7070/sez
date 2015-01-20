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

            var decbbm = [];
            var q_name = "acc";
            var q_readonly = [];
            var bbmNum = [];
            var bbmMask = [];

            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'acc1';
            //ajaxPath = ""; //  execute in Root
			brwCount2 = 10;
			
            $(document).ready(function() {
                bbmKey = ['acc1'];
                q_brwCount();
                q_gt(q_name, q_content, brwCount2+1, 1, 0, '', r_accy + '_' + r_cno)
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
                $('#txtAcc1').change(function() {
                	var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                    var t_acc1 = $.trim($(this).val());
                    if (t_acc1.length>0){
                    	Lock(1,{opacity:0});
                        var t_where = "where=^^ acc1='" + t_acc1 + "' ^^";
                        q_gt('acc', t_where, 0, 0, 0, JSON.stringify({action:'change'}), r_accy + '_' + r_cno);
                    }
                });
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
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		t_para = JSON.parse(t_name);
                    		if(t_para.action=='change'){
                    			var as = _q_appendData('acc', "", true);
                    			if(as[0]!=undefined){
                    				alert('【'+as[0].acc1+' '+as[0].acc2 +'】 已存在!');
                    			}
                    			Unlock(1);
                    		}else{t_para.action=='save'
                    			var t_acc1 = t_para.acc1;
                    			var as = _q_appendData('acc', "", true);
                    			if(as[0]!=undefined){
                    				alert('【'+as[0].acc1+' '+as[0].acc2 +'】 已存在!');
                    				Unlock(1);
                    				return;
                    			}else{
                    				wrServer(t_acc1);
                    			}
                    		}
                    	}catch(e){}
                    	break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('acc_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtAcc1').focus();
            }

            function btnModi() {
                if (emp($('#txtAcc1').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box("z_accp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";;" + r_accy + "_" + r_cno, 'z_accc1', "95%", "90%", q_getMsg('popZ_accc1'));
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	
            	var t_acc1 = $.trim($('#txtAcc1').val());
            	if(t_acc1.length==0){
            		alert('請輸入'+q_getMsg('lblAcc1'));
            		Unlock(1);
            		return;
            	}
            	if(q_cur==1){
            		var t_where = "where=^^ acc1='" + t_acc1 + "' ^^";
                	q_gt('acc', t_where, 0, 0, 0, JSON.stringify({action:'save',acc1:t_acc1}), r_accy + '_' + r_cno);
            	}else{
            		wrServer(t_acc1);
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
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1){
                	$('#txtAcc1').removeAttr('disabled').css('color','black');
                }else{
                	$('#txtAcc1').attr('disabled','disabled').css('color','green');
                	
                }
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
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
                width: 500px;
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
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewAcc1"> </a></td>
						<td align="center" style="width:260px; color:black;"><a id="vewAcc2"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="acc1" style="text-align: center;">~acc1</td>
						<td id="acc2" style="text-align: left;">~acc2</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblAcc1" class="lbl"> </a></td>
						<td colspan="3"><input id="txtAcc1" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblAcc2" class="lbl"> </a></td>
						<td colspan="3"><input id="txtAcc2" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblOacc" class="lbl"> </a></td>
						<td colspan="3"><input id="txtOacc" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td colspan="2"><span> </span><a id="lblLok" class="lbl"> </a></td>
						<td colspan="3"><input id="txtLok" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>

