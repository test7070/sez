<%@ Page Language="C#" AutoEventWireup="true" %>
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
            var q_readonly = ['txtNoa','txtWorker','txtMoney','txtCurmoney'];
            var bbmNum = new Array(['txtMoney',10,0],['txtCurmoney',10,2]);
            var bbmMask = [['txtDatea','999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(
            	['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver','txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'],
            	['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']);

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
				$('#cmbTypea').focus(function(){
                	var len = $("#cmbTypea").children().length>0?$("#cmbTypea").children().length:1;
                	$("#cmbTypea").attr('size',len+"");
                }).blur(function(){
                	$("#cmbTypea").attr('size','1');
                });
                
                q_cmbParse("cmbArrow", q_getPara('etc.arrow'));
				$('#cmbArrow').focus(function(){
                	var len = $("#cmbArrow").children().length>0?$("#cmbArrow").children().length:1;
                	$("#cmbArrow").attr('size',len+"");
                }).blur(function(){
                	$("#cmbArrow").attr('size','1');
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
						var t_mount = 0,t_money=0;
                        for( i = 0; i < as.length; i++) {
                            t_mount += parseFloat(as[i].mount)*1000;
                            t_money += parseFloat(as[i].money);
                        }
                        t_mount = t_mount/1000;
                        $("#txtCurmount").addClass('finish');
                        $("#txtCurmount").val( t_mount);   
                        $("#txtCurmoney").addClass('finish');
                        $("#txtCurmoney").val( t_money); 
                        sum();             
                        break;
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();

                        if(q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }
<<<<<<< HEAD
            });
        }
        
        function q_boxClose( s2) {
             var ret; 
            switch (b_pop) {  
                case 'conn':

                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtSalesno,txtSales', ret, 'noa,namea');
                    break;

                case 'sss':
                    ret = getb_ret();
                    if (q_cur > 0 && q_cur < 4) q_browFill('txtGrpno,txtGrpname', ret, 'noa,comp');
                    break;
                
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
        }


        function q_gtPost(t_name) {  
           switch (t_name) {
                case 'sss': 
                    q_changeFill(t_name, ['txtSalesno', 'txtSales'], ['noa', 'namea']);
                    break;

                case q_name: if (q_cur == 4)  
                        q_Seek_gtPost();

                    if (q_cur == 1 || q_cur == 2) 
                        q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                    break;
            }  /// end switch
        }
        
        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('etc_s.aspx', q_name + '_s', "500px", "330px", q_getMsg( "popSeek"));
        }

        function combPay_chg() {   
            var cmb = document.getElementById("combPay")
            if (!q_cur) 
                cmb.value = '';
            else
                $('#txtPay').val(cmb.value);
            cmb.value = '';
        }

        function btnIns() {
            _btnIns();
            $('#txtNoa').val('AUTO');
            $('#txtNoa').focus();
        }

        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;

            _btnModi();
            $('#txtComp').focus();
        }

        function btnPrint() {
 
        }
        function btnOk() {
            var t_err = '';

            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);

            if ( dec( $('#txtCredit').val()) > 9999999999)
                t_err = t_err + q_getMsg('msgCreditErr ') + '\r';

            if ( dec( $('#txtStartn').val()) > 31)
                t_err = t_err + q_getMsg( "lblStartn")+q_getMsg( "msgErr")+'\r';
            if (dec( $('#txtGetdate').val()) > 31)
                t_err = t_err + q_getMsg("lblGetdate") + q_getMsg("msgErr") + '\r'

            if( t_err.length > 0) {
                alert(t_err);
                return;
            }
          

			    var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll( (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
           /* if ( t_noa.length==0 )  
                q_gtnoa(q_name, t_noa);
            else
                wrServer(  t_noa);*/
        }

        function wrServer( key_value) {
            var i;

            xmlSql = '';
            if (q_cur == 2)   /// popSave
                xmlSql = q_preXml();

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], '','',2);
        }
=======
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('etc_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
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
				q_box('z_etc.aspx'+ "?;;;;"+r_accy,  '', "800px", "600px", q_getMsg("popPrint"));
            }

            function btnOk() {
                $('#txtWorker').val(r_name);
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }         
                sum();
                
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if(t_noa.length == 0 || t_noa == "AUTO")
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
            function sum(){       	            	
            	var t_money = q_float('txtMoney');
	            var t_orgmoney = q_float('txtOrgmoney');
	            var t_curmoney = q_float('txtCurmoney');
	            if($("#txtCurmoney").hasClass('finish')  &&  (q_cur==1 || q_cur==2)){
            		$('#txtCurmoney').val(t_curmoney+t_orgmoney-t_money);
            		$('#txtOrgmoney').val(t_money);
            	}
            }
            function q_popFunc(id,key_value){
            	switch(id) {
                    case 'txtOilstationno':
                    	if(key_value.length>0)
<<<<<<< HEAD
                			q_gt('oilorg', "where=^^oilstationno='"+$.trim(key_value)+"'^^", 0, 0, 0, "");
>>>>>>> 73408e51bb8e1fb777c2abeeebd172527937a210
=======
                			//q_gt('oilorg', "where=^^oilstationno='"+$.trim(key_value)+"'^^", 0, 0, 0, "");
>>>>>>> a1
       
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
                width: 98%;
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
                width: 98%;
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
		<div id='dmain' >
			<div class="dview" id="dview" style="float: left;  width:40%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:20%"><a id='vewCarno'> </a></td>
						<td align="center" style="width:20%"><a id='vewDriver'> </a></td>
						<td align="center" style="width:25%"><a id='vewStation'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>

						<td align="center" id='datea'>~datea</td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='driver'>~driver</td>
						<td align="center" id='station'>~station</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 55%;float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtNoa"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"> </td>
						<td class="td4"> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtDatea"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtCarno"  type="text"  class="txt c1"/>
						</td>
						<td class="td3"> </td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDriver' class="lbl btn"> </a></td>
						<td class="td2" >
						<input id="txtDriverno"  type="text"  class="txt c2"/>
						<input id="txtDriver"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td class="td2"><input id="txtStation"  type="text"  class="txt c1"/></td>					
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblArrow' class="lbl"> </a></td>
						<td class="td2"><select id="cmbArrow" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td class="td2">
						<input id="txtMoney"  type="text"  class="txt num c1"/>
						<input id="txtOrgmoney"  type="text"  style="display: none;"/>
						</td>
						<td class="td3"><span> </span><a id='lblCurmoney' class="lbl"> </a></td>
						<td class="td4"><input id="txtCurmoney"  type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
