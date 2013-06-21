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
            q_tables = 's';
            var q_name = "pack2";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [['txtWeight', 10, 2,1]];
            var bbsNum = [['txtInmount', 10, 2,1],['txtOutmount', 10, 2,1],['txtInweight', 10, 2,1],['txtOutweight', 10, 2,1],['txtWeight', 10, 2,1],['txtGweight', 10, 2,1],['txtLengthb', 10, 2,1],['txtWidth', 10, 2,1],['txtHigh', 10, 2,1],['txtCuft', 10, 2,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtNoa', 'lblNoa', 'ucaucc', 'noa,product', 'txtNoa,txtProduct', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
                q_getFormat();
                 $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('pack2', t_where, 0, 0, 0, "checkPack2no_change", r_accy);
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
                });
                $('#txtWeight').change(function () {
	           	//分配室內金額
	           	if(dec($('#txtWeight').val())>0){
		           	for(var j = 0; j < q_bbsCount; j++) {
		           		if(!emp($('#txtInmount_'+j).val()) && !emp($('#txtOutmount_'+j).val()))
		           			q_tr('txtWeight_'+b_seq,q_float('txtInmount_'+b_seq)*q_float('txtOutmount_'+b_seq)*q_float('txtWeight'))
		           	}
		           	sum();
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
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'checkPack2no_change':
                		var as = _q_appendData("pack2", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                        }
                		break;
                	case 'checkPack2no_btnOk':
                		var as = _q_appendData("pack2", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
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
        	if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('pack2', t_where, 0, 0, 0, "checkPack2no_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;

                q_box('pack2_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for(var j = 0; j < q_bbsCount; j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#txtInmount_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtWeight_'+b_seq,q_float('txtInmount_'+b_seq)*q_float('txtOutmount_'+b_seq)*q_float('txtWeight'))
						});
						$('#txtOutmount_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtWeight_'+b_seq,q_float('txtInmount_'+b_seq)*q_float('txtOutmount_'+b_seq)*q_float('txtWeight'))
			                q_tr('txtGweight_'+b_seq,q_float('txtWeight_'+b_seq) + (q_float('txtOutmount_'+b_seq) * q_float('txtInweight_'+b_seq)) + q_float('txtOutweight_'+b_seq))
						});
						$('#txtWeight_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtGweight_'+b_seq,q_float('txtWeight_'+b_seq) + (q_float('txtOutmount_'+b_seq) * q_float('txtInweight_'+b_seq)) + q_float('txtOutweight_'+b_seq))
						});
						$('#txtInweight_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			              q_tr('txtGweight_'+b_seq,q_float('txtWeight_'+b_seq) + (q_float('txtOutmount_'+b_seq) * q_float('txtInweight_'+b_seq)) + q_float('txtOutweight_'+b_seq))
						});
						$('#txtOutweight_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtGweight_'+b_seq,q_float('txtWeight_'+b_seq) + (q_float('txtOutmount_'+b_seq) * q_float('txtInweight_'+b_seq)) + q_float('txtOutweight_'+b_seq))
						});
						$('#txtLengthb_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtCuft_'+b_seq,q_float('txtLengthb_'+b_seq)*q_float('txtWidth_'+b_seq)*q_float('txtHigh_'+b_seq)*(0.032808*0.032808*0.032808))
						});
						$('#txtWidth_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtCuft_'+b_seq,q_float('txtLengthb_'+b_seq)*q_float('txtWidth_'+b_seq)*q_float('txtHigh_'+b_seq)*(0.032808*0.032808*0.032808))
						});
						$('#txtHigh_' + j).change(function () {
			            	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                q_bodyId($(this).attr('id'));
			                b_seq = t_IdSeq;
			                q_tr('txtCuft_'+b_seq,q_float('txtLengthb_'+b_seq)*q_float('txtWidth_'+b_seq)*q_float('txtHigh_'+b_seq)*(0.032808*0.032808*0.032808))
						});
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
                $('#txtNoa').attr('readonly', 'readonly');
                $('#txtAddr').focus();
            }

            function btnPrint() {
              //  q_box('z_addr.aspx' + "?;;;;" + r_accy, '', "800px", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['pack']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }

            function sum() {
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
                width: 300px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
                width: 100%;
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
                width: 600px;
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
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                width: 95%;
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
                font-size:medium;
            }
            .dbbs {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
			input[type="text"],input[type="button"] {
                font-size:medium;
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
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%; color:black;"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td style="text-align: center;" id='noa'>~noa</td>
						<td style="text-align: left;" id='product'>~product</td>
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
						<td><input id="txtNoa" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblProduct' class="lbl"> </a></td>
						<td colspan="3"><input id="txtProduct" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit' class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblSpec' class="lbl"> </a></td>
						<td colspan="3"><input id="txtSpec" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeight' class="lbl"> </a></td>
						<td><input id="txtWeight" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
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
					<td align="center" style="width:80px;"><a id='lblPackway_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPack_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblInmount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutmount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblInweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblOutweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWeight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblGweight_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLengthb_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblWidth_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblHigh_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblCuft_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" /></td>
					<td><input type="text" id="txtPackway.*" class="txt c2" /> </td>
					<td><input type="text" id="txtPack.*" class="txt c2" /> </td>
					<td><input type="text" id="txtInmount.*" class="txt num c2" /> </td>
					<td><input type="text" id="txtOutmount.*" class="txt num c2" /> </td>
					<td><input type="text" id="txtInweight.*" class="txt num c2" /></td>
					<td><input type="text" id="txtOutweight.*" class="txt num c2" /></td>
					<td><input type="text" id="txtWeight.*" class="txt num c2" /></td>
					<td><input type="text" id="txtGweight.*" class="txt num c2" /></td>
					<td><input type="text" id="txtLengthb.*" class="txt num c2" /></td>
					<td><input type="text" id="txtWidth.*" class="txt num c2" /></td>
					<td><input type="text" id="txtHigh.*" class="txt num c2"/></td>
					<td><input type="text" id="txtCuft.*" class="txt num c2"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
