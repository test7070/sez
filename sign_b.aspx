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
    var q_name = 'sign', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 12;
    var t_sqlname = 'sign_load'; t_postname = q_name;
    var isBott = false;  
    var afield, t_htm;
    var i, s1;

    var decbbs = [];
    var decbbm = [];
    var q_readonly = [];
    var q_readonlys = [];
    var bbmNum = [];
    var bbsNum = [];
    var bbmMask = [];
    var bbsMask = [];
    var colorNotselect = '#cad3ff';
    var colorSelect = 'yellow';
    $(document).ready(function () {
        bbmKey = [];
        bbsKey = ['noa'];
        q_desc = 1;
        //        if (location.href.indexOf('?') < 0)   // debug
        //        {
        //            location.href = location.href + "?;;;noa='0015'";
        //            return;
        //        }
        //        if (!q_paraChk())
        //            return;

        main();
    });             /// end ready

    function main() {
        if (dataErr)   
        {
            dataErr = false;
            return;
        }
        t_content = ' where=^^handle=0^^ ';
        mainBrow(6, t_content, t_sqlname, t_postname);
    }
    function mainPost() {
        fbbs[fbbs.length] = 'txtMemo';


        
    }
    function bbsAssign() {
        _bbsAssign();
//        for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
//            $('#btnDetail_' + j).click(function () {
//                alert('detail');
//            });
//        } //j
        //
    }

    function btnOk() {
        sum();

        t_key = q_getHref();

        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
    }

    function bbsSave(as) {
        if (!as['noa'] ) {  // Dont Save Condition
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

        $('.detail.select').siblings().css('background', 'yellow');
        $('.detail').siblings().css('background', 'gray');

        $('.chekSel').click(function () {
            t_IdSeq = -1;  /// �n��  �~��ϥ� q_bodyId()
            q_bodyId($(this).attr('id'));
            b_seq = t_IdSeq;

            var obj = $('#detail_' + b_seq);
            obj.css('background', 'yellow');
        });

        $('#btnDetail_0').click(function () {
            alert('detail');
        });

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
    .tbbm
        {
            FONT-SIZE: 14pt;
            COLOR: blue;
            TEXT-ALIGN: left;
            border-color: white; 
            width:100%; border-collapse: collapse; 
        } 
        
        .tbbs
        {
            FONT-SIZE: 12pt;
            COLOR: blue ;
            TEXT-ALIGN: left;
             BORDER:1PX LIGHTGREY SOLID;
             width:100% ; height:100% ;  
        } 
		.td1, .td3, .td5
		{ 
			width: 12%;
			text-align:right;
		}
		.td2, .td4, .td6
		{
			width: 15%;
		} 
		 td input[type="button"] {
                width: auto;
                font-size: medium;
                float: right;
            }      
        .txt.c1
        {
            width: 98%;
        }
        .th1
        {
            width: 8%;
        }
        .th2
        {
           width: 6%;
        }
    
</style>
</head>
<body>
        <div class='dbbm' style="width: 68%;">
        <table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
        <tr>
            <td class="td1"><a id="lblMess"></a></td>
            <td class="td2"><input id="textMess" type="text" class="txt c1" /></td>
            <td class="td3"><a id="lblDate1"></a></td>
            <td class="td4"><input id="textDate1" type="text" class="txt c1" /></td>
            <td align="center"><a id="lblSymbol" style="font-weight: bolder;font-size: 18px;"></a></td>
            <td class="td6"><input id="textDate2" type="text" class="txt c1" /></td>
        </tr>
        <tr>
            <td class="td1"><a id="lblCount"></a></td>
            <td class="td2" colspan="3"><input id="textCount" type="text" style="width: 99%;" /></td>
            <td class="td5"><input id="btnSeek" type="button" /></td>
            <td class="td6"></td>
            </tr>      
        <tr>
            <td class="td1"><a id="lblMemo"></a></td>
            <td colspan="3" align="left"><textarea id="textMemo" cols="10" rows="5" style="width: 99%; height: 50px;"></textarea></td>
            <td class="td5"><input id="btnApproveb" type="button"/></td>
            <td class="td6"></td>
            </tr>                            
       </table>
        </div>

        <div class='dbbs' > 
        <table id="tbbs" class='tbbs'  border="1"  cellpadding='2' cellspacing='1'  >
            <tr style='color:White; background:#003366;' >
                <td style="width: 5%;"><input id="chekIsall" type="checkbox" /><a id="lblIsall"></a></td>  
                <td align="center" style="width: 3%;"><a id="lblDetail"></a></td>
                <td align="center" class="th1"><a id='lblForm'></a></td>
                <td align="center" class="th2"><a id='lblNoa'></a></td>
                <td align="center" style="width: 22%;"><a id='lblMemos'></a></td>
                <td align="center" class="th2"><a id='lblWorker'></a></td>
                <td align="center" class="th1"><a id='lblChecker'></a></td>
                <td align="center" class="th1"><a id='lblApprov'></a></td>
                <td align="center" class="th1"><a id='lblApprove'></a></td>
                <td align="center" class="th1"><a id='lblApprove2'></a></td>
                            
            </tr>
            <tr class='detail' id='detail.*'>
                <td ><input id="chekSel.*" type="checkbox" class='chekSel' /><a id="lblSel"></a></td> 
                <td ><input id="btnDetail.*" type="button" class="btnDetail" style="font-size: medium;"/></td>
                <td ><input class="txt c1" id="txtForm.*"type="text" />
                <input class="txt c1" id="txtPart.*" type="text" /></td>
                <td ><input class="txt c1" id="txtDatea.*" type="text" />
                <input class="txt c1" id="txtNoa.*" type="text" /></td>
                <td ><textarea class="txt c1" id="txtMemo.*"  rows='3' cols='10' style="width:99%; "></textarea></td>                
                <td ><input class="txt c1" id="txtWorker.*" type="text" /></td>
                <td ><input class="txt c1" id="txtChecker.*" type="text" />
                     <input class="txt c1" id="txtMemochecker.*" type="text" />
                </td>
                <td ><input class="txt c1" id="txtApprov.*" type="text" />
                     <input class="txt c1" id="txtMemoapprov.*" type="text" />
                </td>
                <td ><input class="txt c1" id="txtApprove.*" type="text" />
                     <input class="txt c1" id="txtMemoapprove.*" type="text" />
                </td>
                <td ><input class="txt c1" id="txtApprove2.*" type="text" />
                    <input class="txt c1" id="txtMemoapprove2.*" type="text" />
                </td>
                               
            </tr>
        </table>
        </div>
        <input id="q_sys" type="hidden" />
    <!--#include file="../inc/pop_modi.inc"-->
</body>

</html>
