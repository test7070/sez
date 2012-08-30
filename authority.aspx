<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title> </title>
<script src="../script/jquery.min.js" type="text/javascript"> </script>
<script src='../script/qj2.js' type="text/javascript"> </script>
    <script src='qset.js' type="text/javascript"> </script>
<script src='../script/qj_mess.js' type="text/javascript"> </script>
<script src='../script/mask.js' type="text/javascript"> </script>
<script type="text/javascript">
    var q_name = 'authority', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 0;
    var t_sqlname = 'authority_load'; t_postname = q_name ;q_alias = 'a';
    var isBott = false;  /// 是否已按過 最後一頁
    var afield, t_htm;
    var i, s1;
    var decbbs = [];
    var decbbm = [];
    var q_readonly = [];
    var q_readonlys = ['txtSssno','txtNamea'];
    var bbmNum = []; 
    var bbmNum_comma = [];
    var bbsNum = [];
    var bbsNum_comma = [];
    var bbmMask = [];
    var bbsMask = [];

    $(document).ready(function () {
        bbmKey = [];
        bbsKey = ['noa', 'sssno'];
        q_bbsFit = 1;
        if (location.href.indexOf('?') < 0)   // debug
        {
            location.href = location.href + "?;;;a.noa='accc'";
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
    }

    function btnOk() {
        sum();
        _btnOk( '',  bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }

    var t_noa;
    function bbsSave(as) {
        return true;

        if (!as['namea'] ) {  // Dont Save Condition
            as[bbsKey[0]] = '';   /// noa  empty --> dont save
            return;
        }

        if (!t_noa) {
            var s2 = q_getId(), s3, s4, x, y;   ///  write all Para to Array
            if (s2.length > 3) {
                s3 = s2[3].split('and');
                for (x = 0; x < s3.length; x++) {
                    s4 = s3[x].split('=');
                    if (s4[0].indexOf('>') == -1 && s4[0].indexOf('<') == -1) {  /// ignore  > <
                        as[ bbsKey[x]] = replaceAll(s4[1], "'", '');
                    }
                }
            }

            t_noa = as[bbsKey[0]];
        }
        else
            as[bbsKey[0]] = t_noa;


        t_err = '';
        if (t_err) {
            alert(t_err)
            return false;
        }

        return true;
    }

    function btnModi2() {
        var s2 = q_getId(), s3, s4, x, y;   /// 網址篩選 條件
        if (s2.length < 4) {
            alert("Need Parameter  ? ; ; ; noa='bbb'");
            return;
        }
        _btnModi2();

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

    function boxStore() {
            
    }
    function refresh() {
        _refresh();
        if( brwAct == 6)
            _readonlys(  ( q_cur > 0 ? false :true));
    }
    function sum() {    }

    var asss = [], t_key;
    function q_gtPost(t_postname) {  /// 資料下載後 ...
        var t_table = 'sss';
//        var s1 = xmlDoc.getElementsByTagName(t_table)[0];
//        fsssAll = q_xmlToField(xmlDoc.getElementsByTagName(t_table + '_f')[0]);
//        asss = q_xmlToArray(s1, fsssAll);
        var asss = _q_appendData('sss', '', true);
        var i, j, k, t_found, anew = [], s1;
        t_key = q_getHref();
        for (i = 0; i < asss.length; i++) {
               t_found = false;
               for (j = 0; j < abbs.length; j++) {
                   if (abbs[j]['sssno'] == asss[i]['noa']) {
                       t_found = true;
                       break;
                   }
               }
               if (!t_found) {
                   for (k = 0; k < asss['field'].length; k++) {
                       s1 = asss['field'][k];
                       anew[i] = [];
                       anew[i][s1] = '';
                   }
                   anew[i]['sssno'] = asss[i]['noa'];
                   anew[i]['namea'] = asss[i]['namea'];
               }
               else
                   anew[i] = abbs[j];
               
               anew[i]['noa'] = t_key[1];
           }

           abbs = anew;
           refresh();
           _readonlys(true);
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
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div  id="dbbs"  >
        <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><a id='lblSssno'></a></td>
                <td align="center"><a id='lblNamea'></a></td>
                <td align="center"><a id='lblPr_run'></a></td>
                <td align="center"><a id='lblPr_ins'></a></td>
                <td align="center"><a id='lblPr_modi'></a></td>
                <td align="center"><a id='lblPr_dele'></a></td>
                <td align="center"><a id='lblPr_seek'></a></td>
                <td align="center"><a id='lblPr_repo'></a></td>
                <td align="center"><a id='lblPrice_show'></a></td>
                <td align="center"><a id='lblPrice_modi'></a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:20%;"><input class="txt" id="txtSssno.*" type="text" maxlength='90' style="width:98%;"   /></td>
                <td style="width:20%;"><input class="txt"  id="txtNamea.*" maxlength='30'type="text" style="width:98%;" /></td>
                <td style="width:6%;"><input id="chkPr_run.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPr_ins.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPr_modi.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPr_dele.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPr_seek.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPr_repo.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPrice_show.*" type="checkbox" /></td>
                <td style="width:6%;"><input id="chkPrice_modi.*" type="checkbox" />
                <input id="recno.*" type="hidden" /> </td>
            </tr>
        </table>
    <!--#include file="../inc/pop_modi.inc"--> 
</div>
<div  id="dbbtail"  >
        <table id="tbbtail" class='tbbtail'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
            <tr style='color:White; background:#003366;' >
                <td align="center"><a id='lblPrice'> </a></td>
                <td align="center"><a id='lblMemo'> </a></td>
            </tr>
            <tr  style='background:#cad3ff;'>
                <td style="width:20%;"><input class="txt" id="textPrice.*" type="text" style="width:98%;"   /></td>
                <td style="width:80%;"><input class="txt"  id="textMemo.*" type="text" style="width:98%;" />
                	<input id="recno.*" type="hidden" /> </td>
            </tr>
        </table>
    <!--#include file="../inc/pop_modi.inc"--> 
</div>
        <input id="q_sys" type="hidden" />
</body>
</html>
