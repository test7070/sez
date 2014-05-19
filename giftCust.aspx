<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_tables = 's';
			//q_desc=1;
            var q_name = "giftcust";
            var q_readonly = ['txtWorker','textAge'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtPartno', 'lblPartno', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
            ['txtCustno', 'lblCustno', 'cust', 'noa,comp,nick,zip_comp,addr_comp,tel', 'txtCustno,txtComp,txtNick,txtZip_cust,txtAddr_cust,txtTel,txtBirthday', 'cust_b.aspx'],
            ['txtSssno_', 'btnSssno_', 'sss', 'noa,namea', 'txtSssno_,txtNamea_', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
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
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtBirthday', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbSex", q_getPara('sss.sex'));
                
                $('#txtBirthday').blur(function() {
                    if(!emp($('#txtBirthday').val()))
                	$('#textAge').val(dec(q_date().substr(0,3))-dec($('#txtBirthday').val().substr(0,3)));
                });
                $('#txtNoa').change(function(e){
                	$(this).val($.trim($(this).val()).toUpperCase());    	
					if($(this).val().length>0){
						//if((/^(\w+|\w+\u002d\w+)$/g).test($(this).val())){
							t_where="where=^^ noa='"+$(this).val()+"'^^";
                    		q_gt('giftcust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
						/*}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}*/
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
            		case 'checkCustno_change':
                		var as = _q_appendData("giftcust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
                        }
                		break;
					case 'checkCustno_btnOk':
                		var as = _q_appendData("giftcust", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].namea);
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
            	/*if((/^(\w+|\w+\u002d\w+)$/g).test($('#txtNoa').val())){
				}else{
					alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
					Unlock();
					return;
				}*/

            	if($.trim($('#txtNick').val()).length==0)
            		$('#txtNick').val($('#txtComp').val());
 
                sum();
                $('#txtWorker').val(r_name);
                
                /*var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0)
		            q_gtnoa(q_name, 'KGC');
		        else
		            wrServer(t_noa);*/
		       
		       if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('giftcust', t_where, 0, 0, 0, "checkCustno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
			
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('giftcust_s.aspx', q_name + '_s', "550px", "400px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
               $('#txtDatea').focus();
               $('#txtDatea').val(q_date());
                refreshBbm();
               //$('#txtNoa').val('AUTO');
               $('#textAge').val('');
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();      
                 refreshBbm();     
                $('#txtNoa').attr('readonly','readonly');
                $('#txtNoa').css('background-color','rgb(237, 237, 238)');
                $('#txtDatea').focus();
            }
            function btnPrint() {
            	//q_box('z_vcctran.aspx'+ "?;;;;"+r_accy+";noa="+trim($('#txtNoa').val()), '', "90%", "650px", m_print);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }
            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                
                	if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
            	t_err = '';
                if (!as['datea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                if (t_err) {
                    alert(t_err)
                    return false;
                }
                return true;
            }

            function sum() {
            	if(!(q_cur==1 || q_cur==2))
					return;
					
            }
            function refresh(recno) {
                _refresh(recno);
                 refreshBbm();  
                if(!emp($('#txtBirthday').val()))
                	$('#textAge').val(dec(q_date().substr(0,3))-dec($('#txtBirthday').val().substr(0,3)));
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
                sum();
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
                width: 30%;
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
                width: 680px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
                width: 70%;
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
                font-size: medium;
                width: 100%;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
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
						<td align="center" style="width:5%; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%;color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:40%;color:black;"><a id='vewNamea'> </a></td>
						<td align="center" style="width:30%;color:black;"><a id='vewNick'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="namea" style="text-align: center;">~namea</td>
						<td id="nick" style="text-align: center;">~nick</td>
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
					<tr class="tr1">
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtNoa" class="txt c1"/>	</td>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtDatea" class="txt c1"/>	</td>	
					</tr>
					<tr class="tr2">
						<td class="td1"><span> </span><a id='lblPartno' class="lbl btn"> </a></td>
						<td class="td2" colspan="2"><input type="text" id="txtPartno" class="txt c2"/>
							<input type="text" id="txtPart" class="txt c3"/>
						</td>	
					</tr>
					<tr class="tr3">
						
						<td class="td3"><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtNamea" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="txtJob" class="txt c1"/></td>	
					</tr>
					<tr class="tr4">
						<td class="td1"><span> </span><a id='lblClass' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtClass" class="txt c1"/>	</td>
						<td class="td3"><span> </span><a id='lblCusttype' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtCusttype" class="txt c1"/>	</td>
					</tr>
					<tr class="tr5">
						<td class="td3"><span> </span><a id='lblCustno' class="lbl btn"> </a></td>
						<td class="td4" colspan="2"><input type="text" id="txtCustno" class="txt c2"/>
							<input type="text" id="txtComp" class="txt c3"/>
							<input type="text" id="txtNick" style="display: none;"/>
							</td>						
					</tr>
					
					<tr class="tr6">
						<td class="td1"><span> </span><a id='lblSex' class="lbl"> </a></td>
						<td class="td2"><select id="cmbSex" class="txt c1"> </select></td>
						<td class="td3"><span> </span><a id='lblBirthday' class="lbl"> </a></td>
						<td class="td4"><input type="text" id="txtBirthday" class="txt c1"/></td>
						<td class="td5"><span> </span><a id='lblAge' class="lbl"> </a></td>
						<td class="td6"><input type="text" id="textAge" class="txt c1"/></td>	
					</tr>
					<tr class="tr7">
						<td class="td1"><span> </span><a id='lblLikes' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtLikes" class="txt c1"/>	</td>
					</tr>
					<tr class="tr8">
						<td class="td1"><span> </span><a id='lblPersonality' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtPersonality" class="txt c1"/></td>	
					</tr>
					<tr class="tr9">
						<td class="td1"><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input type="text" id="txtTel" class="txt c1"/></td>
						<td class="td1"><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtMobile" class="txt c1"/></td>	
					</tr>	
					<tr class="tr10">
						<td class="td1"><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtEmail" class="txt c1"/></td>	
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblAddr_cust' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtZip_cust" class="txt c1"/></td>
						<td class="td3" colspan="4"><input type="text" id="txtAddr_cust" class="txt c1"/></td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblAddr_home' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtZip_home" class="txt c1"/></td>
						<td class="td3" colspan="4"><input type="text" id="txtAddr_home" class="txt c1"/></td>
					</tr>
					<tr class="tr11">
						<td class="td1"><span> </span><a id='lblAddr_other' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtZip_other" class="txt c1"/></td>
						<td class="td3" colspan="4"><input type="text" id="txtAddr_other" class="txt c1"/></td>
					</tr>
					<tr class="tr12">
						<td class="td1"><span> </span><a id='lblSendtype' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtSendtype" class="txt c1"/></td>	
						<td class="td1"><span> </span><a id='lblAccount' class="lbl"> </a></td>
						<td class="td2"colspan="2"><input type="text" id="txtAccount" class="txt c1"/></td>
					</tr>
					<tr class="tr13">
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="5"><input type="text" id="txtMemo" class="txt c1"/></td>
					</tr>
					<tr class="tr14">
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input type="text" id="txtWorker" class="txt c1"/></td>	
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width: 2%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:10%;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblSssno_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblState_s'> </a></td>
					<td align="center" style="width:10%;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" /></td>
					<td><input id="txtDatea.*" type="text" style="width: 95%;"/></td>
					<td><input class="btn"  id="btnSssno.*" type="button" value='.' style=" font-weight: bold;width:1%;float:left;" />
                        <input type="text" id="txtSssno.*"  style="width:85%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtNamea.*"  style="width:85%; float:left;"/>
					</td>
					<td><input id="txtState.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
					
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
