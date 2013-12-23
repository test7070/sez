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
        q_tables = 's';
        var q_name = "ummb";
        var q_readonly = ['txtNoa','txtDatea','txtBkvccno','txtSaleno','txtWorker','txtWorker2'];
        var q_readonlys = ['txtVccno','txtVccnoq','txtMount','txtPrice','txtTotal'];
        var bbmNum = [];  
        var bbsNum = [['txtMount', 15, 0,1], ['txtPrice', 15, 2,1], ['txtTotal', 15, 0,1], ['txtBkmount', 15, 0,1], ['txtBkmoney', 15, 0,1], ['txtSalemount', 15, 0,1], ['txtSalemoney', 15, 0,1]];
        var bbmMask = [];
        var bbsMask = [];
        q_sqlCount = 6; brwCount = 6; brwList = []; brwNowPage = 0; brwKey = 'Datea';
        aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
        ['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx'],
        ['txtPartno2', 'lblPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],
        ['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx'],
        ['txtPartno_', 'btnPart_', 'part', 'noa,part', 'txtPartno_,txtPart_', 'part_b.aspx']);

        $(document).ready(function () {
            bbmKey = ['noa'];
            bbsKey = ['noa', 'noq'];
            q_brwCount();   
           q_gt(q_name, q_content, q_sqlCount, 1)  
           q_gt('acomp', 'stop=1 ', 0, 0, 0, "cno_acomp");
        });

        //////////////////   end Ready
        function main() {
            if (dataErr)  
            {
                dataErr = false;
                return;
            }
            mainForm(1); 
        }
        function mainPost() { 
            q_getFormat();
            bbmMask = [['txtDatea', r_picd],['txtMon', r_picm],['txtBkdate',r_picd],['txtVbdate',r_picd],['txtVedate',r_picd]];
            q_mask(bbmMask);
            q_cmbParse("cmbTypea", q_getPara('ummb.typea')); 
             
             
             $('#btnVccs').click(function () {
                var t_custno = trim($('#txtCustno').val());
                var t_vbdate = trim($('#txtVbdate').val());
                var t_vedate = trim($('#txtVedate').val());
                var t_vccno = trim($('#txtVccno').val());
	            var t_where = "1=1";
	            if($('#cmbTypea').val()=='1'){
					t_where+=(t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara("noa", t_vccno): "")+"&& typea='1' ";
	            }else if($('#cmbTypea').val()=='2'){
	            	t_where+=(t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara("noa", t_vccno) : "")+" && noa in (select noa from view_vcc where isnull(payed,0)=0) && typea='1' ";
	            }else if($('#cmbTypea').val()=='4'){
	            	t_where+=(t_custno.length > 0 ? q_sqlPara("custno", t_custno) : "")
					+q_sqlPara2("datea", t_vbdate,t_vedate)
					+(t_vccno.length > 0 ? q_sqlPara("noa", t_vccno) : "")+" && noa in (select noa from view_vcc where isnull(payed,0)>0) && typea='1' ";
	            }
	            
	            q_box("vccs_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'vccs', "95%", "95%", q_getMsg('popVccs'));
            });
            
            $('#cmbTypea').change(function() {
            	if($('#cmbTypea').val()=='3'){
            		$('#btnVccs').hide()
            	}else{
            		$('#btnVccs').show()
            	}
			});
            
        }

        function q_boxClose(s2) { ///   q_boxClose 2/4 
            var ret;
            switch (b_pop) {   
                case q_name + '_s':
                    q_boxClose2(s2); ///   q_boxClose 3/4
                    break;
            }   /// end Switch
            b_pop = '';
        }

		var z_cno=r_cno,z_acomp=r_comp,z_nick=r_comp.substr(0,2);
        function q_gtPost(t_name) {  
            switch (t_name) {
            	case 'cno_acomp':
                		var as = _q_appendData("acomp", "", true);
                		if (as[0] != undefined) {
	                		z_cno=as[0].noa;
	                		z_acomp=as[0].acomp;
	                		z_nick=as[0].nick;
	                	}
                		break;
                case q_name: 
                	if (q_cur == 4)   
                        q_Seek_gtPost();
                    break;
            }  /// end switch
        }

        function btnOk() {
            t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);  
            if (t_err.length > 0) {
                alert(t_err);
                return;
            }

            $('#txtWorker').val(r_name)
            sum();

            var s1 = $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val();
            if (s1.length == 0 || s1 == "AUTO")   
                q_gtnoa(q_name, replaceAll(q_getPara('sys.key_ummb') + $('#txtDatea').val(), '/', ''));
            else
                wrServer(s1);
        }

        function _btnSeek() {
            if (q_cur > 0 && q_cur < 4)  // 1-3
                return;

            q_box('ummb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
        }

        function combPay_chg() {   
        }

        function bbsAssign() {  
            _bbsAssign();
        }

        function btnIns() {
            _btnIns();
            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
            $('#txtCno').val(z_cno);
            $('#txtAcomp').val(z_acomp);
            $('#txtDatea').val(q_date());
            $('#txtDatea').focus();
        }
        function btnModi() {
            if (emp($('#txtNoa').val()))
                return;
            _btnModi();
            $('#txtProduct').focus();
        }
        function btnPrint() {

        }

        function wrServer(key_value) {
            var i;

            $('#txt' + bbmKey[0].substr( 0,1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
            _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
        }

        function bbsSave(as) {
            if (!as['productno'] ) {  
                as[bbsKey[1]] = '';   
                return;
            }

            q_nowf();
            as['datea'] = abbm2['datea'];
         
            return true;
        }

        function sum() {
            var t1 = 0, t_unit, t_mount, t_weight = 0;
            for (var j = 0; j < q_bbsCount; j++) {

            }  // j

        }

        ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
        function refresh(recno) {
            _refresh(recno);
            
            if($('#cmbTypea').val()=='3'){
            	$('#btnVccs').hide()
            }else{
            	$('#btnVccs').show()
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
                width: 23%;
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
                width: 75%;
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 36%;
                float: left;
            }
            .txt.c3 {
                width: 62%;
                float: left;
            }
            .txt.c4 {
                width: 47%;
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
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs{
            	float:left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
        .tbbs
        {
            FONT-SIZE: medium;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' style="width: 1260px;">
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewCust'></a></td>
            </tr>
             <tr>
                <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                <td align="center" id='datea'>~datea</td>
                <td align="center" id='comp'>~comp</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
            	<td class="td1"><span> </span><a id='lblTypea' class="lbl"> </a></td>
				<td class="td2"><select id="cmbTypea" class="txt c1"> </select></td>
				<td class="td3"><span> </span><a id='lblDatea' class="lbl" > </a></td>
				<td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
				<td class="td5"><span> </span><a id='lblNoa' class="lbl"> </a></td>
				<td class="td6"><input id="txtNoa"   type="text" class="txt c1"/></td> 
            </tr>   
            <tr>
            	<td class="td1"><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                <td class="td2" colspan="2"><input id="txtCustno" type="text" class="txt c2"/>
                <input id="txtComp"  type="text" class="txt c3"/></td>
				<td class="td1"><span> </span><a id="lblAcomp" class="lbl btn"> </a></td>
				<td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c2"/>
				<input id="txtAcomp"    type="text"  class="txt c3"/></td>
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblVdate' class="lbl"> </a></td>
                <td class="td2" colspan="2">
                	<input id="txtVbdate" type="text" class="txt c4" /> <a class="lbl" style="float: left;">~</a>
                	<input id="txtVedate" type="text" class="txt c4"/>
                </td> 
                <td class="td4"><span> </span><a id='lblVccno' class="lbl"> </a></td>
				<td class="td5"><input id="txtVccno"  type="text"  class="txt c1"/></td> 
				<td class="td6"><input id="btnVccs" type="button"/></td>
             </tr>
             <tr>
            	<td class="td5"><span> </span><a id='lblMon' class="lbl"> </a></td>
				<td class="td6"><input id="txtMon"  type="text"  class="txt c1"/></td> 
                <td class="td5"><span> </span><a id='lblBkdate' class="lbl" > </a></td>
				<td class="td6"><input id="txtBkdate"  type="text" class="txt c1"/></td>
				<td class="td5"><span> </span><a id='lblWorker' class="lbl"> </a></td>
				<td class="td6"><input id="txtWorker"  type="text"  class="txt c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblBkvccno' class="lbl" > </a></td>
				<td class="td2"><input id="txtBkvccno"  type="text" class="txt c1"/></td>
				<td class="td3"><span> </span><a id='lblSaleno' class="lbl" > </a></td>
				<td class="td4"><input id="txtSaleno"  type="text" class="txt c1"/></td>	
				<td class="td7"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
				<td class="td8"><input id="txtWorker2"  type="text"  class="txt c1"/></td>
            </tr>
            <tr>
            	<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
                <td class="td2" colspan='5' ><input id="txtMemo"  type="text"  style="width: 98%;"/></td></tr>
        </table>
        </div> 
        </div>       
        <div class='dbbs' style="width: 1260px;">
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center" style="width: 35px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
				<td align="center" style="width: 200px;"><a id='lblProductno_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblMount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblPrice_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblTotal_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblBkmount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblBkmoney_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblSalemount_s'> </a></td>
                <td align="center" style="width: 100px;"><a id='lblSalemoney_s'> </a></td>
                <td align="center"><a id='lblMemo_s'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>             
                <td >
                	<input class="btn"  id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width: 1%;" />
                	<input  id="txtProductno.*" type="text"  class="txt c3" style="width:85%"/>
                	<input  id="txtProduct.*" type="text"  class="txt c1"/>
                </td>
                <td ><input  id="txtMount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtPrice.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtTotal.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtBkmount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtBkmoney.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtSalemount.*" type="text" class="txt num c1"/></td>
                <td ><input  id="txtSalemoney.*" type="text" class="txt num c1"/></td>
                <td ><input id="txtMemo.*" type="text"  class="txt c1"/>
                	<input  id="txtVccno.*" type="text"  class="txt c1" style="width:75%"/>
                	<input  id="txtVccnoq.*" type="text"  class="txt c1" style="width:20%"/>
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
        </div>

        <input id="q_sys" type="hidden" />
</body>
</html>
