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
    var q_name = 'ordem', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2=15;
    var t_sqlname = 'ordem_load'; t_postname = q_name ; 
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
    bbmKey = ['noa'];
    bbsKey = ['noa', 'noq'];
    q_tables = 's';
    $(document).ready(function () {

        if (!q_paraChk())
            return;

        main();
    });            /// end ready

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
            $('#btnManu_' + j).click(function () {
                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                q_bodyId($(this).attr('id'));
                b_seq = t_IdSeq;
                pop('manu');
            });
            $('#txtManuno__' + j).change(function () {
                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                q_bodyId($(this).attr('id'));
                b_seq = t_IdSeq;
                q_change($(this), 'manu', 'noa', 'noa,manu');  /// 接 q_gtPost()
            });
        } //j
    }

    function btnOk() {
        sum();
        _btnOk( '', '', bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }


    
    function bbsSave(as,table) {
        var t_key = bbmKey[0];
        var t_noa = $('#txtNoa').val();

        switch (table) {
            case 'ordemt':
                if (!as['pack']) {  // Dont Save Condition
                    as[t_key] = '';   /// noa  empty --> dont save
                    return false;
                    break;
                }
                as[t_key] = t_noa;
                break;

            default:
                if (!as['manu']) {  // Dont Save Condition
                    as[t_key] = '';   /// noa  empty --> dont save
                    return false;
                    break;
                }
                as[t_key] = t_noa;
        }
        
//        t_err = '';
//        if (t_err) {
//            alert(t_err)
//            return false;
//        }

        return true;
    }

    function btnModi() {
        var s2 = q_getId(), s3, s4, x, y;   /// 網址篩選 條件
        if (s2.length < 4) {
            alert("Need Parameter  ? ; ; ; noa='bbb'");
            return;
        }
        _btnModi();

        s3 = s2[3].split('and');
        for (x = 0; x < s3.length; x++) {
            s4 = s3[x].split('=');
            break;
        }

        s4[1] = replaceAll(s4[1], "'", '');
        for (i = 0; i < abbsDele.length; i++) {
            abbsDele[i][bbsKey[0]] = s4[1];
        }
    }

    function bbtAssign() {
        for (var j = 0; j < (q_bbtCount == 0 ? 1 : q_bbtCount); j++) {
            $('#btnMinus__' + j).click(function () { btnMinus($(this).attr('id'), '__'); });
            $('#btnPackno__' + j).click(function () {
                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                q_bodyId($(this).attr('id'));
                b_seq = t_IdSeq;
                pop('pack');
            });
            $('#txtPackno__' + j).change(function () {
                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                q_bodyId($(this).attr('id'));
                b_seq = t_IdSeq;
                q_change($(this), 'pack', 'noa', 'noa,pack');  /// 接 q_gtPost()
            });

        } //j

        _bbsAssign('tbbt', bbtHtm, fbbt, '__', bbtMask, bbtNum, bbtReadonly, 'btnPlust');
     }

    function sum() {    }

    function q_gtPost() {
        _q_appendData(q_name);     ////  no Next Bott..
        _q_appendData(q_name + 's');
        _q_appendData(q_name + 't');
        main();
    }

    function combUsage_chg() {   /// 只有 comb 開頭，才需要寫 onChange()   ，其餘 cmb 連結資料庫
        var cmb = document.getElementById("combUsage")
        if (!q_cur)
            cmb.value = '';
        else
            $('#txtUsage').val(cmb.value);

        cmb.value = '';
    }

    var abbt, abbt2, abbtDele, fbbt,  fbbtAll, bbtHtm, bbtMask, q_bbtCount, bbtReadonly, bbtNum=['txtPrice'], bbtTag = 'tbbt', bbtTable ;   /// refresh() 需加入 q_grids()   bbt
    var decbbt = ['weight', 'mount', 'gmount', 'emount'];
    function bbt() {
        if (!bbtHtm) {
            bbtTable = q_name + 't';
            if (xmlDoc) {
                fbbtAll = q_xmlToField(xmlDoc.getElementsByTagName(bbtTable + '_f')[0]);
                q_storeHtm(bbtTag, '..*');
                bbtHtm = q_getHtm(bbtTag)['htm'];
                fbbt = q_getHtm(bbtTag)['field'];
                abbt = q_getData(bbtTable);
            }
            else {
                var as = parent.$.fn.colorbox.settings.data2[2];
                fbbtAll = as['field'];
                bbtHtm = as['htm'];
                fbbt = as['atxt'];
                abbt = as;
            }
        }

        if( abbt)
            q_bbtCount = abbt.length;
    }

    function refresh() {
        _refresh();

        if (!bbtHtm) {
            q_cmbParse("combUsage", q_getPara('ordem.usage'));
            bbt();
        }

        if (abbm && abbm.length > 0) {
            q_grids(bbtTag, bbtHtm, fbbt, abbt, bbmKey[0], abbm[0][bbmKey[0]], null, 0, 0, '..*');
            bbtAssign();   /// Assign btnPlust()
        }
        readonly((q_cur > 0 && q_cur < 4 ? false : true));
    }

    function btnClose2(k) {

        k++;
        abbt2 = q_assNoq('ordemt', 'noq', fbbt, fbbtAll, '__');
        adata[k] = abbt2;
        adata[k]['htm'] = bbtHtm;
        adata[k]['atxt'] = fbbt;
        parent.$.fn.colorbox.settings.data2[k] = adata[k];
    }


    function readonly(t_para, empty) {
        _readonly(t_para, empty);
        _readonlys(t_para, empty, 'tbbt', '__', bbtMask, bbtReadonly);
    }

    function btnMinus(id) {
        _btnMinus(id);
        sum();
    }

    function btnPlus(org_htm, dest_tag, afield) {
        if (dest_tag == 'tbbs') {
            _btnPlus(org_htm, dest_tag, afield, 10, '.*');
            bbsAssign();  /// 表身運算式
        }
        if (dest_tag == 'tbbt') {
            _btnPlus(org_htm, dest_tag, afield, 10, '..*');
            bbtAssign();  /// 表身運算式 
        }
    }

</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
            .column1
        {           width: 18%;        }
        .column2
        {            width: 15%;        }      
        .column3
        {            width: 33%;        }   
        .label1
        {            width: 10%;text-align:right;        }       
        .label2
        {            width: 10%;text-align:right;        }
        .label3
        {            width: 10%;text-align:right;        }
</style>
</head>
<body>
<div class='dbbm' style="width: 68%;float: left;">
<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
    <tr>
        <td class="lable1"  align="right"><a id='lblUsage'></a></td>
        <td class="column1" ><input id="txtUsage" maxlength='30' type="text"  style='width:50%;'/><select id="combUsage" style='width:45%;'  onchange='combUsage_chg()' /></td>
        <td class="label2" align="right" ><a id='lblProductno'></a></td>
        <td class="column2"><input id="txtProductno" maxlength='30' type="text"  style='width:100%;'/></td>
        <td class="label3" align="right"><a id='lblOrdcno'></a></td>
        <td class="column3" ><input id="txtOrdcno"   type="text"  maxlength='30'   style='width:85%;'/></td> 
    </tr>
    <tr>
        <td class="label1"  align="right"><a id='lblModel'></a></td>
        <td class="column1" ><input id="txtModel" maxlength='30' type="text"  style='width:100%;'/></td>
        <td class="label2" align="right" ><a id='lblRdate'></a></td>
        <td class="column2"><input id="txtRdate" maxlength='30' type="text"  style='width:100%;'/></td>
        <td class="label3" align="right"><a id='lblPacks'></a></td>
        <td class="column3" ><input id="txtPacks"   type="text"  maxlength='30'   style='width:85%;'/>
         <input id="txtNoa" type="text"  style='visibility: hidden;width:5%;'/></td>
    </tr>
</table>
</div>
<div  id="dbbs"  style="float: left;  width:45%;"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100% '  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;" /> </td>
                <td align="center"><a id='lblManuno'></a></td>
                <td align="center"><a id='lblManu'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value='－' style="font-weight: bold; "  /></td>
                <td style="width:6%;"><input class="txt"  id="txtManuno.*" maxlength='30'type="text" style="width:98%;"   /></td>
                <td style="width:6%;"><input class="txt" id="txtManu.*" type="text" maxlength='90' style="width:98%;"   />
                <input id="txtNoq.*" type="hidden" /><input id="recno.*" type="hidden" /></td>
            </tr>
        </table>
</div>
<div  id="dbbt"  style="float: left;  width:45%;"  >
        <table id="tbbt" class='tbbt'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr  style='color:White; background:#009999;' >
                <td align="center"><input class="btn"  id="btnPlust" type="button" value='＋' style="font-weight: bold;"  /> </td>
                <td align="center"><a id='lblPackno'></a></td>
                <td align="center"><a id='lblPack'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:1%;"><input class="btn"  id="btnMinus..*" type="button" value='－' style="font-weight: bold; "  /></td>
                <td style="width:6%;"><input class="txt"  id="txtPackno..*" maxlength='30'type="text" style="width:98%;"  /></td>
                <td style="width:6%;"><input class="txt" id="txtPack..*" type="text" maxlength='90' style="width:98%;" />
                <input id="txtNoq..*" type="hidden" /><input id="recno..*" type="hidden" /></td>
            </tr>
        </table>
</div>

<!--#include file="../inc/pop_close.inc"--> 

<input id="q_sys" type="hidden" />
</body>
</html>
