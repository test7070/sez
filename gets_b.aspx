<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="../script/jquery.min.js" type="text/javascript"></script>
<script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>

<script type="text/javascript">
    var q_name = 'family', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
    var t_sqlname = 'family_load'; t_postname = q_name;
    var isBott = false;  /// �O�_�w���L �̫�@��
    var afield, t_htm;
    var i, s1;
    var decbbs = ['ch_health'];
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
        if (location.href.indexOf('?') < 0)   // debug
        {
            location.href = location.href + "?;;;noa='0015'";
            return;
        }
        if (!q_paraChk())
            return;

        main();
    });            /// end ready

    function main() {
        if (dataErr)  /// ���J��ƿ��~
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname);
    }

    function bbsAssign() {  /// ���B�⦡
        _bbsAssign();
 }
 
    function btnOk() {
        sum();

        t_key = q_getHref();

        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }

    function bbsSave(as) {
        if (!as['namea']) {  // Dont Save Condition
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

        _btnModi();

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

    function q_gtPost(t_postname) {  /// ��ƤU���� ...
       
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
            bbsAssign();  /// ���B�⦡ 
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
            width: 10%;
        }
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style="width: 100%;" >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /> </td>
                <td align="center" style="width: 5%;"><a id='lblNoq'></a></td>
                <td align="center" class="td1"><a id='lblPrefix'></a></td>
                <td align="center" class="td1"><a id='lblNamea'></a></td>
                <td align="center" class="td1"><a id='lblBirthday'></a></td>
                <td align="center" class="td1"><a id='lblId'></a></td>
                <td align="center" class="td1"><a id='lblCh_health'></a></td>
                <td align="center" class="td1"><a id='lblIndate'></a></td>
                <td align="center" class="td1"><a id='lblOutdate'></a></td>
                <td align="center" ><a id='lblMemo'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
                <td ><input class="txt c1" id="txtNoq.*" type="text" /></td>
                <td ><input class="txt c1"  id="txtPrefix.*" type="text" /></td>
                <td ><input class="txt c1" id="txtNamea.*" type="text" /></td>
                <td ><input class="txt c1" id="txtBirthday.*" type="text" /></td>
                <td ><input class="txt c1" id="txtId.*" type="text" /></td>
                <td ><input class="txt c1" id="txtCh_health.*" type="text" style="text-align: right;" /></td>
                <td ><input class="txt c1" id="txtIndate.*" type="text" /></td>
                <td ><input class="txt c1" id="txtOutdate.*" type="text"/></td>
                <td ><input class="txt c1" id="txtMemo.*" type="text"/>
                <input id="txtNoa.*" type="hidden" /></td>
            </tr>
        </table>
    <!--#include file="../inc/pop_save.inc"--> 
</div>
        <input id="q_sys" type="hidden" />
</body>
</html>
