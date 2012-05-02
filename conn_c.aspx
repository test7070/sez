<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
<script src='../script/qj2.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>

<script type="text/javascript">
    var q_name = 'conn', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2=15;
    var t_sqlname = 'conn_load'; t_postname = q_name ; 
    var isBott = false;  /// 是否已按過 最後一頁
    var afield, t_htm;
    var i, s1;

    var decbbs = [];
    var decbbm = [];
    var q_readonly = [];
    var q_readonlys = [];
    var bbmNum = []; 
    var bbmNum_comma = [];
    var bbsNum = [];
    var bbsNum_comma = [];
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
    });             /// end ready

    function main() {
        if (dataErr)  /// 載入資料錯誤
        {
            dataErr = false;
            return;
        }
        mainBrow(6, t_content, t_sqlname, t_postname);
    }

    function bbsAssign() {  /// 表身運算式
        _bbsAssign();
        for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
            $('#btnMinus_' + j).click(function () { btnMinus($(this).attr('id')); });
        } //j
    }

    function btnOk() {
        sum();

        t_key = q_getHref();

        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }

    function bbsSave(as) {
        if (!as['namea'] && !as['tel'] && !as['addr'] && !as['mobile'] && !as['memo']) {  // Dont Save Condition
            as[bbsKey[0]] = '';   /// noa  empty --> dont save
            return;
        }

        q_getId2('', as);  // write keys to as

        return true;

    }

    function btnModi2() {
        var t_key = q_getHref();

        if (!t_key)
            return;

        _btnModi2();

        for (i = 0; i < abbsDele.length; i++) {
            abbsDele[i][bbsKey[0]] = t_key[1];
        }
    }

    function boxStore() {
            
    }
    function refresh() {
        refresh2();
    }
    function sum() {    }

    function q_gtPost(t_postname) {  /// 資料下載後 ...
        q_gtPost2(t_postname);
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
            bbsAssign();  /// 表身運算式 
    }

</script>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblNamea'></a></td>
                <td align="center"><a id='lblPart'></a></td>
                <td align="center"><a id='lblTel'></a></td>
                <td align="center"><a id='lblExt'></a></td>
                <td align="center"><a id='lblMobile'></a></td>
                <td align="center"><a id='lblAddr'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold; "  /></td>
                <td style="width:6%;"><input class="txt"  id="txtNamea.*" maxlength='30'type="text" style="width:98%;"  /></td>
                <td style="width:6%;"><input class="txt" id="txtPart.*" type="text" maxlength='90' style="width:98%;"   /></td>
                <td style="width:12%;"><input class="txt" id="txtTel.*" type="text" maxlength='10' style="width:94%;"  /></td>
                <td style="width:5%;"><input class="txt" id="txtExt.*" type="text" maxlength='10' style="width:94%; text-align:right"  /></td>
                <td style="width:12%;"><input class="txt" id="txtMobile.*" type="text" maxlength='90' style="width:98%;"   /></td>
                <td style="width:25%;"><input class="txt" id="txtAddr.*" type="text" maxlength='90' style="width:98%;"  />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
    <!--#include file="../inc/pop_modi.inc"--> 
</div>
        <input id="q_sys" type="hidden" />
</body>
</html>
