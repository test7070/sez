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

		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			
			q_tables = 's';
            var q_name = "process";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [['txtHours',10,1,1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 9
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
			aPop = new Array(['txtTggno', 'lblTggno', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
							['txtStationno', 'lblStationno', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx'],
							['txtStationgno', 'lblStationgno', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
							['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx']
			);
							 
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);          
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').change(function(e){
					if($(this).val().length>0){
						t_where="where=^^ noa='"+$(this).val()+"'^^";
                    	q_gt('process', t_where, 0, 0, 0, "checkProcessno_change", r_accy);
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
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkProcessno_change':
                		var as = _q_appendData("process", "", true);
                        if (as[0] != undefined){
                        	alert('已存在'+as[0].noa+' '+as[0].process);
                        }
                		break;
                	case 'checkProcessno_btnOk':
                		var as = _q_appendData("process", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].process);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('process_s.aspx', q_name + '_s', "500px", "400px", q_getMsg("popSeek"));
            }
            
            function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            }
		        }
		        _bbsAssign();
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
                $('#txtProduct').focus();
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
				if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('process', t_where, 0, 0, 0, "checkProcessno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            
            function bbsSave(as) {
		        if (!as['tggno']&& !as['tgg']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
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
                width: 550px;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 25%;
                float: left;
            }
            .txt.c3 {
                width: 74%;
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
		<div id='dmain'>
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:280px; color:black;"><a id='vewProcess'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='process' style="text-align: left;">~process</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblProcess' class="lbl"> </a></td>
						<td colspan="2"><input id="txtProcess"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDescribe' class="lbl"> </a></td>
						<td colspan="3"><input id="txtDescribe" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><input id="txtTypea"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblHours' class="lbl"> </a></td>
						<td><input id="txtHours"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTggno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtTggno"  type="text" class="txt c2" />
							<input id="txtTgg"  type="text" class="txt c3" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStationno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtStationno"  type="text" class="txt c2" />
							<input id="txtStation"  type="text" class="txt c3" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStationgno' class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtStationgno"  type="text" class="txt c2" />
							<input id="txtStationg"  type="text" class="txt c3" />
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSales' class="lbl"> </a></td>
						<td><input id="txtSales"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:80px;"><a id='lblTggno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblTgg_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td >
						<input type="text" id="txtTggno.*" style="width:80%;" />
						<input class="btn"  id="btnTggno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td><input type="text" id="txtTgg.*" style="width:95%;" /></td>

				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
