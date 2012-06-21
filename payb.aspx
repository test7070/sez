<%@ Page Language="C#" AutoEventWireup="true" %>
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
			q_desc = 1
            q_tables = 's';
            var q_name = "payb";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
			aPop = new Array(['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx'],
			['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'],
			['txtPartno2', 'lblPart2', 'part', 'noa,part', 'txtPartno2,txtPart2', 'part_b.aspx'],
			['txtSalesno2', 'lblSales2', 'sss', 'noa,namea', 'txtSalesno2,txtSales2', 'sss_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)

            });
            //////////////////   end Ready
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);

            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
            }

            function q_boxClose(s2) {
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

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if(t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                sum();

                var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
                if(s1.length == 0 || s1 == "AUTO")
                    q_gtnoa(q_name, replaceAll('A' + $('#txtDatea').val(), '/', ''));
                else
                    wrServer(s1);
            }

            function _btnSeek() {
                if(q_cur > 0 && q_cur < 4)// 1-3
                    return;

                q_box('payb_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }

            function combPay_chg() {
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if(emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtProductno').focus();
            }

            function btnPrint() {

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['invono']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for(var j = 0; j < q_bbsCount; j++) {

                }// j
            }

            function refresh(recno) {
                _refresh(recno);

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
  			#dmain 
  			{
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 28%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 70%;
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
                width: 48%;
                float: left;
            }
            .txt.c3 {
                width: 50%;
                float: left;
            }
            .txt.c4 {
                width: 23%;
                float: left;
            }
            .txt.c5 {
                width: 75%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
                
            }
            .txt.c7 {
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
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
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
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
       .tbbs .td1
        {
            width: 10%;
        }
        .tbbs .td2
        {
            width: 8%;
        }
       
      
    </style>
</head>
<body>
<!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
        <div class="dview" id="dview" style="float: left;  width:32%;"  >
           <table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
            <tr>
                <td align="center" style="width:5%"><a id='vewChk'></a></td>
                <td align="center" style="width:25%"><a id='vewDatea'></a></td>
                <td align="center" style="width:40%"><a id='vewComp'></a></td>
            </tr>
             <tr>
                <td ><input id="chkBrow.*" type="checkbox" style=''/></td>
                <td align="center" id='datea'>~datea</td>
                <td align="center" id='cno acomp,4'>~cno ~acomp,4</td>
            </tr>
        </table>
        </div>
        <div class='dbbm' style="width: 68%;float: left;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
            <tr>
               <td class="td1"><span> </span><a id='lblNoa' class="lbl"></a></td>
               <td class="td2"colspan="2"><input id="txtNoa"   type="text"  class="txt c1"/></td> 
               <td class="td4"><span> </span><a id='lblDatea' class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtDatea"  type="text" class="txt c1"/></td>
               <td class="td7"><span> </span><a id='lblMon' class="lbl"></a></td>
               <td class="td8"><input id="txtMon"  type="text"  class="txt c1" /></td> 
            </tr>
            <tr>
               <td class="td1"><span> </span><a id="lblAcomp" class="lbl btn" ></a></td>
               <td class="td2" colspan="2"><input id="txtCno"  type="text"  class="txt c4" />
               <input id="txtAcomp"    type="text" class="txt c5"/></td>
               <td class="td4"><span> </span><a id='lblVccno' class="lbl"></a></td>
               <td class="td5" colspan="2"><input id="txtVccno"  type="text" class="txt c1"/></td> 
               <td class="td7"><span> </span><a id='lblPic' class="lbl"></a></td>
               <td class="td8"><input id="txtPic"  type="text" class="txt c1"/></td> 
            </tr>
           <tr>
                <td class="td1"><span> </span><a id="lblTgg"  class="lbl btn"></a></td>
                <td class="td2" colspan="2"><input id="txtTggno" type="text" class="txt c4"/>
                <input id="txtTgg"  type="text" class="txt c5"/></td>
                <td class="td4"><span> </span><a id='lblPayc' class="lbl"></a></td>
                <td class="td5"  colspan='2'><input id="txtPayc" type="text" class="txt c1"/></td> 
                <td class="td7"><span> </span><a id='lblInvono' class="lbl"></a></td>
                <td class="td8"><input id="txtInvono" type="text" class="txt c1"/></td> 
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblVdate'class="lbl" ></a></td>
                <td class="td2"><input id="txtVbdate" type="text"  class="txt c1"/></td> 
                <td class="td3"><input id="txtVedate" type="text"  class="txt c1"/></td> 
                <td class="td4"><span> </span><a id='lblCno2' class="lbl"></a></td>
                <td class="td5"><input id="txtCno2"    type="text"  class="txt c1" /></td>
                <td class="td6"><input id="txtAccno2"    type="text"  class="txt c1"/></td>
             </tr>
            <tr>
                <td class="td1"><span> </span><a id="lblPart2" class="lbl btn" ></a></td>
                <td class="td2" colspan="2"><input id="txtPartno2"  type="text"  class="txt c4"/> 
                <input id="txtPart2"   type="text" class="txt c5"/></td> 
                <td class="td4"><span> </span><a id="lblSales2" class="lbl btn" ></a></td>
                <td class="td5" colspan="2"><input id="txtSalesno2" type="text" class="txt c4"/>
                <input id="txtSales2"    type="text" class="txt c5"/></td>
            </tr>
            <tr>
                <td class="td1"><span> </span><a id='lblMoney' class="lbl"></a></td>
                <td class="td2" colspan="2"><input id="txtMoney" type="text" class="txt num c1" /></td> 
                <td class="td4"><span> </span><a id='lblTax' class="lbl"></a></td>
                <td class="td5" colspan="2"><input id="txtTax" type="text"  class="txt num c1" /></td>
                <td class="td7"><span> </span><a id='lblTotal' class="lbl"></a></td>
                <td class="td8"><input id="txtTotal" type="text" class="txt num c1"/></td>  
            </tr>
            <tr><td class="td1"><span> </span><a id='lblMemo' class="lbl"></a></td>
                <td class="td2" colspan='7' ><textarea id="txtMemo" cols="10" rows="5" style="width: 99%; height:50px;"></textarea></td>
                </tr>
            <tr>
                <td class="td1"></td>
                <td class="td2" colspan="2"></td>
                <td class="td4"></td>
                <td class="td5" colspan="2"></td>
                <td class="td7"><span> </span><a id='lblWorker' class="lbl"></a></td>
                <td class="td8"><input id="txtWorker"  type="text" class="txt c1"/></td> 
            </tr>
        </table>
        </div>
        </div>
        <div class='dbbs' > <%--style="overflow-x: hidden; overflow-y: scroll; height:200px"  --%>
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
              <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td2"><a id='lblNoas'></a></td>
                <td align="center" class="td1"><a id='lblKind'></a></td>
                <td align="center" style="width: 4%;"><a id='lblType'></a></td>
                <td align="center" class="td2"><a id='lblInvonos'></a></td>
                <td align="center" class="td1"><a id='lblPart'></a></td>
                <td align="center" class="td2"><a id='lblMoneys'></a></td>
                <td align="center" style="width: 5%;"><a id='lblTaxs'></a></td>
                <td align="center" class="td1"><a id='lblTotals'></a></td>
                <td align="center" style="width: 15%;"><a id='lblProduct'></a></td>
                <td align="center"><a id='lblMemos'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" /></td>
                <td><input id="txtNoq.*" type="text"  class="txt c1"/></td>
                <td><input id="txtKind.*" type="text"class="txt c1"/></td>
                <td><input id="txtTypea.*" type="text"  class="txt c1"/></td>
                <td><input id="txtInvono.*" type="text" class="txt c1"/></td>
                <td><input id="txtPartno.*" type="text" class="txt c1"/>
                    <input id="txtPart.*" type="text" class="txt c1"/></td>
                <td><input id="txtMoney.*" type="text" class="txt num c1"/></td>
                <td><input id="txtTax.*" type="text" class="txt num c1" /></td>
                <td><input id="txtTotal.*" type="text"  class="txt num c1" /></td>
                <td><input id="txtProduct.*" type="text" class="txt c1"/></td>
                <td ><input id="txtMemo.*" type="text" class="txt c1"/></td>
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
</body>
</html>
