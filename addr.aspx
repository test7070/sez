<%@ Page Language="C#" AutoEventWireup="true" %>
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
			isEditTotal = false;
            q_tables = 's';
            var q_name = "addr";
            var q_readonly = ['txtNoa','txtCustprice','txtDriverprice','txtDriverprice2','txtCommission'];
            var q_readonlys = [];
            var bbmNum = [['txtCustprice', 10, 3],['txtDriverprice', 10, 3],['txtDriverprice2', 10, 3],['txtCommission', 10, 3]];
            var bbsNum = [['txtCustprice', 10, 3],['txtDriverprice', 10, 3],['txtDriverprice2', 10, 3],['txtCommission', 10, 3]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            q_desc = 1;
            
            aPop =  new Array(['txtProductno', 'lblProductno', 'ucc', 'noa,product', 'txtProductno,txtProduct', 'ucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
            	
                q_getFormat();
                q_mask(bbmMask);
                bbsMask = [['txtDatea', r_picd]];
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'tre.import':
						if(result.length==0)
							alert('No data!');
						else
							location.reload();
                        break;
                }

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
                    
                    case q_name:
                        if(q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
            	var t_date=''
                for(var i = 0; i < q_bbsCount; i++) {
                	if($('#txtDatea_'+i).val()>=t_date){
                		t_date = $('#txtDatea_'+i).val();
                		$('#txtCustprice').val($('#txtCustprice_'+i).val());
                		$('#txtDriverprice').val($('#txtDriverprice_'+i).val());
                		$('#txtDriverprice2').val($('#txtDriverprice2_'+i).val());
                		$('#txtCommission').val($('#txtCommission_'+i).val());
                	}
                }
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                var t_noa = trim($('#txtNoa').val());
                wrServer(t_noa);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)
                    return;

                q_box('addr_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
                for(var i = 0; i < q_bbsCount; i++) {
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtNoa').focus();
            }

            function btnPrint() {
            	q_box('z_addr.aspx'+ "?;;;;"+r_accy, '', "800px", "600px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['datea']) {
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
                width: 40%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: 16px;
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
                width: 50%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                /*border: 1px white double;
                 border-spacing: 0;
                 border-collapse: collapse;*/
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
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
                font-size: 16px;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .tbbm tr td .txt.c1 {
                width: 100%;
                float: left;
            }
            .tbbm tr td .txt.c2 {
                width: 45%;
                float: left;
            }
            .tbbm tr td .txt.c3 {
                width: 55%;
                float: left;
            }
            .tbbm tr td .txt.c4 {
                width: 60%;
                float: left;
            }
            .tbbm tr td .txt.c5 {
                width: 40%;
                float: left;
            }
            .tbbm tr td .txt.num {
                text-align: right;
            }
          	
            .txt.num {
                text-align: right;
            }
            td {
                margin: 0px -1px;
                padding: 0;
            }
            td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            input[type="text"],input[type="button"] {
                font-size:medium;
            }
            input[readonly="readonly"]#txtMiles{
            	color:green;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
        <div class="dview" id="dview" >
           <table class="tview" id="tview">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>                
                <td align="center" style="width:15%"><a id='vewNoa'></a></td>
                <td align="center" style="width:30%"><a id='vewAddr'></a></td>
                <td align="center" style="width:40%"><a id='vewProductno'></a></td>                                
            </tr>
             <tr>
                   <td ><input id="chkBrow.*" type="checkbox" style=''/> </td>
                   <td align="center" id='noa'>~noa</td>
                   <td align="center" id='addr'>~addr</td>
                   <td align="center" id='productno product'>~productno ~product</td>                  
            </tr>
        </table>
        </div>
        <div class='dbbm'>
        <table class="tbbm"  id="tbbm">            
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl">  </a></td>
               <td class="td2"><input id="txtNoa" type="text" class="txt c1" /></td>
               <td> </td>
               <td> </td>
               <td> </td>
               <td> </td>
               <td class="tdZ">  </td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblAddr' class="lbl"></a></td>
               <td class="td2"><input id="txtAddr" type="text" class="txt c1" /></td>
               <td class="td3"></td>
            </tr>
            <tr>
               <td class="td1"><span> </span><a id='lblProductno' class="lbl btn"></a></td>
               <td class="td2"  colspan="3"><input id="txtProductno" type="text"  class="txt c2"/>
               				   <input id="txtProduct" type="text"  class="txt c3"/>
               </td>
            </tr>  
			<tr>
               <td class="td1"><span> </span><a id='lblCurrent' class="lbl"></a></td>
            </tr> 
			<tr>
               <td class="td1"><span> </span><a id='lblCustprice' class="lbl"></a></td>
               <td class="td2"><input id="txtCustprice" type="text"  class="txt c1  num"/></td>
            </tr> 
    		<tr>
               <td class="td1"><span> </span><a id='lblDriverprice' class="lbl"></a></td>
               <td class="td2"><input id="txtDriverprice" type="text"  class="txt c1  num"/></td>
            </tr> 
            <tr>
               <td class="td1"><span> </span><a id='lblDriverprice2' class="lbl"></a></td>
               <td class="td2"><input id="txtDriverprice2" type="text"  class="txt c1  num"/></td>
            </tr> 
            <tr>
               <td class="td1"><span> </span><a id='lblCommission' class="lbl"></a></td>
               <td class="td2"><input id="txtCommission" type="text"  class="txt c1  num"/></td>
            </tr>
            <tr> </tr>
        </table>
        </div>
        </div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:100px;"><a id='lblDatea_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCustprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDriverprice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDriverprice2_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblCommission_s'> </a></td>
					<td align="center" style="width:300px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td ><input type="text" id="txtDatea.*" style="width:95%;" />  </td>
					<td ><input type="text" id="txtCustprice.*" style="width:95%;text-align:right;" />  </td>
					<td ><input type="text" id="txtDriverprice.*" style="width:95%;text-align:right;" />  </td>
					<td ><input type="text" id="txtDriverprice2.*" style="width:95%;text-align:right;" />  </td>
					<td ><input type="text" id="txtCommission.*" style="width:95%;text-align:right;" />  </td>
					<td ><input type="text" id="txtMemo.*" style="width:95%;" />  </td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
