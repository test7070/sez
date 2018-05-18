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
    var q_name = 'gets', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
    var t_sqlname = 'gets_load'; t_postname = q_name;
    var isBott = false;  
    var afield, t_htm;
    var i, s1;
    var decbbs = ['mount','weight','dime','width','lengthb','gweight','eweight','mweight','radius'];
    var decbbm = [];
    var q_readonly = [];
    var q_readonlys = [];
    var bbmNum = [];   
    var bbsNum = [];
    var bbmMask = [];
    var bbsMask = [];

    $(document).ready(function () {
        bbmKey = [];
        bbsKey = ['noa', 'noq'];
        if (location.href.indexOf('?') < 0)   
        {
            location.href = location.href + "?;;;noa='11';" + r_accy ;
            return;
        }
        q_paraChk()

        main();
    });   

    function main() {
        if (dataErr)  
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname , r_accy );  ///  r_accy
    }

    function bbsAssign() {  
        _bbsAssign();
 }
 
    function btnOk() {
        sum();

        t_key = q_getHref();

        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }

    function bbsSave(as) {
        if (!as['noa']) {  // Dont Save Condition
            as[bbsKey[0]] = '';   /// noa  empty --> dont save
            return;
        }

        q_getId2('', as);  // write keys to as

        return true;

    }

    function btnModi() {
        var t_key = q_getHref();

        if (!t_key)
            return;

        _btnModi(1);

        for (i = 0; i < abbsDele.length; i++) {
            abbsDele[i][bbsKey[0]] = t_key[1];
        }
    }

    function boxStore() {

    }
    function refresh() {
        _refresh();
    }
    function sum() { }

    function q_gtPost(t_postname) {  
       
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
        if (q_tables == 's')
            bbsAssign();  
    }

</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
        .txt.c1
        {
            width: 95%;
        }
       
        .td1
        {
            width: 6%;
        }
        .td2
        {
            width: 8%;
        }
        .td3
        {
        	width: 4%;
        }
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style="width: 100%;" >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" class="td3"><a id='lblNoa'> </a></td>
                <td align="center" class="td3"><a id='lblUno'> </a></td>
                <td align="center" class="td1"><a id='lblProductno'> </a></td>
                <td align="center" class="td2"><a id='lblProduct'> </a></td>
                <td align="center" class="td2"><a id='lblSpec'> </a></td>
                <td align="center" class="td1"><a id='lblDime'> </a></td>
                <td align="center" class="td1"><a id='lblWidth'> </a></td>
                <td align="center" class="td1"><a id='lblLength'> </a></td>
                <td align="center" class="td3"><a id='lblMount'> </a></td>
                <td align="center" class="td1"><a id='lblGweight'> </a></td>
                <td align="center" class="td3"><a id='lblInvono'> </a></td>
                <td align="center" class="td3"><a id='lblNo2'> </a></td>
                <td align="center" class="td1"><a id='lblEweight'> </a></td>
                <td align="center" class="td1"><a id='lblMweight'> </a></td>
                <td align="center" class="td2"><a id='lblMemo'> </a></td>
                <td align="center" class="td1"><a id='lblRadius'> </a></td>
                <td align="center" class="td1"><a id='lblSize'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
                <td ><input class="txt c1" id="txtNoa.*" type="text" /></td>
                <td ><input class="txt c1" id="txtUno.*" type="text" /></td>
                <td ><input class="txt c1"  id="txtProductno.*" type="text" /></td>
                <td ><input class="txt c1" id="txtProduct.*" type="text" /></td>
                <td ><input class="txt c1" id="txtSpec.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDime.*" type="text" /></td>
                <td ><input class="txt c1" id="txtWidth.*" type="text" style="text-align: right;" /></td>
                <td ><input class="txt c1" id="txtLengthb.*" type="text" /></td>
                <td ><input class="txt c1" id="txtMount.*" type="text"/></td>
                <td ><input class="txt c1" id="txtGweight.*" type="text"/></td>
                <td ><input class="txt c1" id="txtInvono.*" type="text"/></td>
                <td ><input class="txt c1" id="txtNo2.*" type="text"/></td>
                <td ><input class="txt c1" id="txtEweight.*" type="text"/></td>
                <td ><input class="txt c1" id="txtMweight.*" type="text"/></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text"/></td>
                <td ><input class="txt c1" id="txtRadius.*" type="text"/></td>
                <td ><input class="txt c1" id="txtSize.*" type="text"/>
                <input id="txtNoq.*" type="hidden" /></td>
            </tr>
        </table>
    <!--#include file="../inc/pop_modi.inc"--> 
</div>
        <input id="q_sys" type="hidden" />
</body>
</html>
