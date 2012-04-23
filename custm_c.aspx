<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
<script src='../script/qj.js' type="text/javascript"></script>
    <script src='qset.js' type="text/javascript"></script>
<script src='../script/qj_mess.js' type="text/javascript"></script>
<script src='../script/mask.js' type="text/javascript"></script>
<script type="text/javascript">
    var q_name = 'custm', t_bbsTag = '', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
    var t_sqlname = 'custm_load'; t_postname = q_name;
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
        bbmKey = ['noa'];
        bbsKey = [];

        if (location.href.indexOf('?') < 0)   // debug
        {
            location.href = location.href + "?;;;noa='0015'";
            return;
        }

        if (!q_paraChk()) {
            return;
        }

        main();
    });                 /// end ready

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

    function q_gtPost(t_postname) {  /// 資料下載後 ...
        q_cmbParse("cmbTaxtype", q_getPara('sys.taxtype'));
        q_cmbParse("cmbWtype", q_getPara('custm.wtype'));
        q_cmbParse("cmbQtype", q_getPara('custm.qtype'));  
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
        <div class='dbbm' style="width: 68%;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class='label1'><a id="lblStype" ></a></td>
            <td class="column1"><input id="txtStype" maxlength='14' type="text" style='width:98%;'/></td>
            <td class='label2' ><input id="chkStypefix" type="checkbox" style=' '/><a id="vewChkstype"></a></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
            </tr>
        <tr>            
            <td class='label1'><a id="lblTaxtype"></a></td>
            <td class="column1"><select id="cmbTaxtype"  style='width:98%;'></select></td>
            <td class='label2'></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
       </tr>              
        <tr>            
            <td class='label1'><a id="lblQtype"></a></td>
            <td class="column1"><select id="cmbQtype" style='width:98%;'></select></td>
            <td class='label2'></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
        </tr>
        <tr>
            <td class='label1'><a id="lblWtype"></a></td>
            <td class="column1"><select id="cmbWtype"   style='width:98%;'></select></td>
            <td class='label2'></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td> 
       </tr>
        <tr>
            <td class='label1'><a id="lblVccad" ></a></td>
            <td class="column1"><input id="txtVccad" type="text" style='width:98%;'/></td>
            <td class='label2'><input id="txtP23"maxlength="10" type="text" style="width:98%;" /><a id="lblP23"></a></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
        </tr>
        <tr>
            <td class='label1'><a id="lblBcomp" ></a></td>
            <td class="column1"><input id="txtBcomp" maxlength='40' type="text" style='width:98%;'/></td>
            <td class='label2'></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
        </tr>
        <tr>
            <td class='label1'><a id="lblBoat" ></a></td>
            <td class="column1"><input id="txtBoat" maxlength='20' type="text" style='width:98%;'/></td>
            <td class='label2'></td>
            <td class="column2"></td>
            <td class="label3"></td>
            <td class="column3"></td>
        </tr>                
       </table>
        </div>

        <input id="q_sys" type="hidden" />
    <!--#include file="../inc/pop_modi.inc"-->
</body>

</html>
