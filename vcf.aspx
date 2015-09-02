<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
        <script src="css/jquery/ui/jquery.ui.core.js"></script>
        <script src="css/jquery/ui/jquery.ui.widget.js"></script>
        <script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
        <script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            q_desc=1;
            q_tables = 't';
            var q_name = "vcf";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtMoney','txtTotal'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [['txtMoney', 10, 0, 1],['txtTotal', 10, 0, 1]];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [['txtDatea', '999/99/99']];
            var bbsMask = [['txtDatea', '999/99/99']];
            var bbtMask = [['txtDatea', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            brwCount2 = 8;

            aPop = new Array(['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick,tel,fax', 'txtTggno,txtTgg,txtNick,txtTel,txtFax', 'Tgg_b.aspx']
            , ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', "ucc_b.aspx?" ]
            , ['txtProductno__', 'btnProduct__', 'ucc', 'noa,product', 'txtProductno__,txtProduct__', "ucc_b.aspx?" ]
            , ['txtStoreno_', 'btnStore_', 'store', 'noa,store', 'txtStoreno_', "store_b.aspx?" ]
            , ['txtStoreno__', 'btnStore__', 'store', 'noa,store', 'txtStoreno__', "store_b.aspx?" ]);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function btnOk() {
                sum();
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if(q_cur==1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
	
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_vcf') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('vcf_s.aspx', q_name + '_s', "550px", "450px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtProductno_', '');
							$('#btnProduct_'+n).click();
						});
						$('#txtStoreno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtStoreno_', '');
							$('#btnStore_'+n).click();
						});
                        $('#txtMount_'+i).change(function(e){
                            sum();
                        });
                        $('#txtWeight_'+i).change(function(e){
                            sum();
                        });
                    }
                }
                _bbsAssign();
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	$('#txtProductno__' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtProductno__', '');
							$('#btnProduct__'+n).click();
						});
						$('#txtStoreno__' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtStoreno__', '');
							$('#btnStore__'+n).click();
						});
                        $('#txtMount__'+i).change(function(e){
                            sum();
                        });
                        $('#txtWeight__'+i).change(function(e){
                            sum();
                        });
                    }
                }
                _bbtAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
               if (q_chkClose())
                        return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_vcfp.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'vcf', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
            	var t_imount=0,t_iweight=0,t_omount=0,t_oweight=0;
            	
                for (var i = 0; i < q_bbsCount; i++) {
                    t_imount = q_add(t_imount,q_float('txtMount_'+i));
                    t_iweight = q_add(t_iweight,q_float('txtWeight_'+i));
                }
                for (var i = 0; i < q_bbtCount; i++) {
                    t_omount = q_add(t_omount,q_float('txtMount__'+i));
                    t_oweight = q_add(t_oweight,q_float('txtWeight__'+i));
                }
                
                $('#txtImount').val(t_imount);
                $('#txtIweight').val(t_iweight);
                $('#txtOmount').val(t_omount);
                $('#txtOweight').val(t_oweight);
            }
            function q_stPost() {
                if (q_cur == 1 || q_cur == 2) {
                }
                Unlock();
            }
            ///////////////////////////////////////////////////  以下提供事件程式，有需要時修改
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
                if (q_tables == 's')
                    bbsAssign();
                /// 表身運算式
            }
            function btnPlut(org_htm, dest_tag, afield) {
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
                 if (q_chkClose())
                        return;
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
                width: 200px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 750px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 15%;
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
                width: 100%;
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
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            tr.sel td {
                background-color: yellow;
            }
            tr.chksel td {
                background-color: bisque;
            }
            #dbbt {
                width: 950px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
        </style>
    </head>
    <body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:80px; color:black;"><a id='vewDatea'></a></td>
                        <td align="center" style="width:80px; color:black;"><a id='vewNick'></a></td>
                    </tr>
                    <tr>
                        <td>
                        <input id="chkBrow.*" type="checkbox" style=''/>
                        </td>
                        <td align="center" id='datea'>~datea</td>
                        <td id='nick' style="text-align: right;" >~nick</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr class="tr0" style="height:1px;">
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="tdZ"></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl" > </a></td>
                        <td><input id="txtNoa"type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input id="txtDatea"  type="text" class="txt c1"/></td>
                        <td><span> </span><a id='lblEnda' class="lbl"> </a></td>
                    	<td>
                    		<input id="chkEnda" type="checkbox"/>
                    		<span> </span><a id='lblCancel'> </a>
							<input id="chkCancel" type="checkbox"/>
                    	</td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblTgg" class="lbl"> </a></td>
                        <td colspan="2">
                        	<input id="txtTggno"  type="text" class="txt" style="width:45%;"/>
                        	<input id="txtTgg"  type="text" class="txt" style="width:55%;"/>
                        	<input id="txtNick"  type="text" class="txt" style="display:none;"/>
                    	</td>
                    	<td><span> </span><a id="lblManu" class="lbl" > </a></td>
                        <td colspan="2"><input id="txtManu"type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id="lblTel" class="lbl" > </a></td>
                        <td colspan="2"><input id="txtTel"type="text" class="txt c1"/></td>
                    	<td><span> </span><a id="lblFax" class="lbl" > </a></td>
                        <td colspan="2"><input id="txtFax"type="text" class="txt c1"/></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblTax' class="lbl"> </a></td>
                        <td><input id="txtTax" type="text" class="txt c1 num" /></td>
                        <td><select id="cmbTaxtype" class="txt c1" > </select></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
                        <td><input id="txtMoney" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id='lblTotal' class="lbl"> </a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblImount' class="lbl"> </a></td>
                        <td><input id="txtImount" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id='lblIweight' class="lbl"> </a></td>
                        <td><input id="txtIweight" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                    	<td><span> </span><a id='lblOmount' class="lbl"> </a></td>
                        <td><input id="txtOmount" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id='lblOweight' class="lbl"> </a></td>
                        <td><input id="txtOweight" type="text" class="txt c1 num" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo"  class="lbl"> </a></td>
                        <td colspan="5"><input id="txtMemo"  type="text" class="txt c1" /></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl" > </a></td>
                        <td><input id="txtWorker"  type="text" class="txt c1" /></td>
                        <td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
                        <td><input id="txtWorker2"  type="text" class="txt c1" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="dbbt">
            <table id="tbbt">
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:30px;">
                        <input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="+"/>
                        </td>
                        <td style="width:20px;"> </td>
                        <td style="width:150px; text-align: center;">物品編號</td>
                        <td style="width:200px; text-align: center;">物品名稱</td>
                        <td style="width:80px; text-align: center;">倉庫</td>
                        <td style="width:80px; text-align: center;">米</td>
                        <td style="width:80px; text-align: center;">單位</td>
                        <td style="width:120px; text-align: center;">進貨日</td>
                        <td style="width:100px; text-align: center;">進貨數量</td>
                        <td style="width:100px; text-align: center;">進貨重量</td>
                        <td style="width:200px; text-align: center;">備註</td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="-"/>
                            <input id="txtNoq..*" type="text" style="display:none;"/>
                        </td>
                        <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                        <td>
                        	<input id="btnProduct..*" type="button" style="display:none;"/>
                        	<input id="txtProductno..*" type="text" style="float:left;width:95%;"/>
                    	</td>
                        <td><input id="txtProduct..*" type="text" style="float:left;width:95%;"/></td>
                        <td>
                        	<input id="txtStoreno..*" type="text" style="float:left;width:95%;"/>
                    		<input id="btnStore..*" type="button" style="display:none;"/>
                    	</td>
                        <td><input id="txtLengthb..*"  type="text" style="width:95%; text-align: right;"/></td>
                        <td><input id="txtUnit..*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtDatea..*" type="text" style="float:left;width:95%;"/></td>
                        <td><input id="txtMount..*"  type="text" style="width:95%; text-align: right;"/></td>
                        <td><input id="txtWeight..*"  type="text" style="width:95%; text-align: right;"/></td>
                    	<td><input id="txtMemo..*" type="text" style="float:left;width:95%;"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class='dbbs'>
            <table id="tbbs" class='tbbs' style=' text-align:center'>
                <tr style='color:white; background:#003366;' >
                    <td  align="center" style="width:30px;">
                    <input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
                    </td>
                    <td align="center" style="width:20px;"></td>
                    <td style="width:150px; text-align: center;">物品編號</td>
                    <td style="width:200px; text-align: center;">物品名稱</td>
                    <td style="width:80px; text-align: center;">倉庫</td>
                    <td style="width:80px; text-align: center;">米</td>
                    <td style="width:80px; text-align: center;">單位</td>
                    <td style="width:120px; text-align: center;">借出日</td>
                    <td style="width:100px; text-align: center;">出貨數量</td>
                    <td style="width:100px; text-align: center;">出貨重量</td>
                    <td style="width:200px; text-align: center;">備註</td>
                </tr>
                <tr id="trSel.*" style='background:#cad3ff;'>
                    <td style="width:1%;">
                    <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                    <input id="txtNoq.*" type="text" style="display: none;" />
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                    	<input id="btnProduct.*" type="button" style="display:none;"/>
                    	<input id="txtProductno.*" type="text" style="float:left;width:95%;"/>
                	</td>
                	<td><input id="txtProduct.*" type="text" style="float:left;width:95%;"/></td>
                    <td>
                    	<input id="txtStoreno.*" type="text" style="float:left;width:95%;"/>
                    	<input id="btnStore.*" type="button" style="display:none;"/>
                    </td>
                    <td><input id="txtLengthb.*"  type="text" style="width:95%; text-align: right;"/></td>
                    <td><input id="txtUnit.*" type="text" style="float:left;width:95%;"/></td>
                    <td><input id="txtDatea.*" type="text" style="float:left;width:95%;"/></td>
                    <td><input id="txtMount.*"  type="text" style="width:95%; text-align: right;"/></td>
                    <td><input id="txtWeight.*"  type="text" style="width:95%; text-align: right;"/></td>
                	<td><input id="txtMemo.*" type="text" style="float:left;width:95%;"/></td>
                </tr>
            </table>
        </div>
        <input id="q_sys" type="hidden" />
        
    </body>
</html>
