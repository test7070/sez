<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
	    var q_name = 'salinsures', t_content = ' ', bbsKey = ['noa,mon'], afilter = [] , as; 
	    var t_postname = q_name;
        var t_sqlname = 'salinsures_load';
	    var isBott = false;  /// 是否已按過 最後一頁
	    var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
	    var i,s1;
		var afield, t_htm;
	    var q_readonly = [];
	    var q_readonlys = [];
	    var bbmNum = [];
	    var bbsNum = [];
	    var bbmMask = [];
	    var bbsMask = [];
	    aPop = new Array(['txtCno_', 'btnCno_', 'acomp', 'noa,acomp', 'txtCno_,txtComp_', 'acomp_b.aspx']);
	    
        $(document).ready(function () {
			bbmKey = [];
			bbsKey = ['noa', 'mon','cno'];
            main();
        });         /// end ready

        function main() {
            if (dataErr)  /// 載入資料錯誤
            {
                dataErr = false;
                return;
            }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
         }
        function btnOk() {
			t_key = q_getHref();
			_btnOk(t_key[1], bbsKey[0], bbsKey[1], bbsKey[2], '', 2);
		}
		function bbsSave(as) {
			if(!as['noa']) {// Dont Save Condition
				as[bbsKey[0]] = '';
				return;
			}
			q_getId2('', as);
			return true;
		}
		function bbsAssign() {
			_bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
		}
		function readonly(t_para, empty) {
			_readonly(t_para, empty);
		}
		
		function btnMinus(id) {
			_btnMinus(id);
		}
		
		function btnPlus(org_htm, dest_tag, afield) {
			_btnPlus(org_htm, dest_tag, afield);
			if(q_tables == 's')
				bbsAssign();
		}
        function q_gtPost() {  
        }

        function refresh() {
            _refresh();
        }
    </script>
    <style type="text/css">
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:150% ; height:100% ;  
        }      
        .txt.c1
        {
            width: 95%;
        }
        .td1
        {
            width: 3%;
        }
        .td2
        {
            width: 2%;
        }
        .num {
                text-align: center;
            }
    </style>
</head>

<body> 
<div  id="dbbs"  style="width: 3000px;">
       <table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style="width: 3000px;">
            <tr>
				<td class="td1" align="center" style="width:36px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
				</td>
                <!--<td align="center" style="color:Blue; width:36px;" class="td2"><a id='lblNoa'></a></td>-->
                <td align="center" style="color:Blue;width:80px;" class="td2"><a id='lblMon'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblHe_person'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblHe_comp'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblLa_person'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblLa_comp'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblRe_person'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td1"><a id='lblRe_comp'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblDisaster'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblTotal1'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblTotal2'></a></td>
                <!--<td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblPayc'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblPay'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblUnpay'></a></td>-->
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblSalary'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblSa_retire'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblSa_labor'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblSa_health'></a></td>
                <td align="center" style="color:Blue;width:120px;" class="td2"><a id='lblMount'></a></td>
                <td align="center" style="color:Blue;width:300px;" class="td1"><a id='lblComp'></a></td>
                <td align="center" style="color:Blue;width:300px;" class="td1"><a id='lblMemo'></a></td>
            </tr>
            <tr>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
                <td >
                	<input class="txt c1" id="txtMon.*" type="text"   readonly="readonly" />
                	<input class="txt c1" id="txtNoa.*" type="hidden"   readonly="readonly" />
                </td>
                <td ><input class="txt num c1" id="txtHe_person.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtHe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtLa_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtLa_comp.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtRe_person.*"  type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtRe_comp.*"  type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtDisaster.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtTotal1.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtTotal2.*" type="text"   readonly="readonly" /></td>
                <!--<td ><input class="txt c1" id="txtPayc.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtPay.*" type="text"   readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtUnpay.*" type="text"  readonly="readonly" /></td>-->
                <td ><input class="txt num c1" id="txtSalary.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_retire.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_labor.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtSa_health.*" type="text"  readonly="readonly" /></td>
                <td ><input class="txt num c1" id="txtMount.*" type="text"  readonly="readonly" /></td>
                <td >
                	<input class="txt c1" id="txtCno.*" type="text"  readonly="readonly"  style="width: 20%;"/>
                	<input id="btnCno.*" type="button" value="." style="width: 1%;" />
                	<input class="txt c1" id="txtComp.*" type="text"  readonly="readonly"  style="width: 70%;"/>
                </td>
                <td ><input class="txt c1" id="txtMemo.*" type="text"  readonly="readonly" /></td>
            </tr>
        </table>
			<!--#include file="../inc/pop_modi.inc"-->
</div>
</body>
</html> 

