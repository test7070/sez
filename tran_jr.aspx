<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "tran";
            var q_readonly = ['txtNoa', 'txtMount', 'txtVolume', 'txtWeight','txtTotal','txtTotal2', 'txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMount', 10, 2, 1],['txtWeight', 10, 2, 1],['txtTotal', 10, 0, 1]];
            var bbsNum = [['txtWeight', 10, 2, 1],['txtWeight2', 10, 2, 1],['txtPrice', 10, 0, 1],['txtPrice2', 10, 0, 1],['txtPrice3', 10, 0, 1],['txtTotal', 10, 2, 1],['txtTotal2', 10, 2, 1]];
            var bbmMask = [['txtDatea','999/99/99'],['textMon','999/99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            aPop = new Array(['txtDriverno', 'lblDriverno', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtAddrno', 'lblAddr', 'cust', 'noa,comp', 'txtAddrno,txtAddr', 'cust_b.aspx']
            , ['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtUccno_', 'btnProduct_', 'ucc', 'noa,product', 'txtUccno_,txtProduct_', 'ucc_b.aspx']
            , ['txtStraddrno_', 'btnStraddr_', 'addr', 'noa,addr', 'txtStraddrno_,txtStraddr_', 'addr_b.aspx']
            , ['txtEndaddrno_', 'btnEndaddr_', 'addr', 'noa,addr', 'txtEndaddrno_,txtEndaddr_', 'addr_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,comp,nick', 'txtCustno_,txtComp_,txtNick_', 'cust_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);

            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                window.parent.document.title='出車作業'
            }

            function sum() {
            	var t_tweight=0,t_tweight2=0,t_tweight3=0,t_total=0,t_total2=0,t_total3=0
             	for(var i=0;i<q_bbsCount;i++){
					t_tweight = q_add(t_tweight,q_float('txtWeight_'+i));
					t_tweight2 = q_add(t_tweight2,q_float('txtWeight2_'+i));
					t_tweight3 = q_add(t_tweight3,q_float('txtWeight3_'+i));
					$('#txtTotal_'+i).val(q_mul(q_float('txtWeight_'+i),q_float('txtPrice_'+i)));
					$('#txtPrice3_'+i).val(q_mul(q_float('txtWeight2_'+i),q_float('txtPrice2_'+i)));
					if($('#txtMount3_'+i).val()!=0){
					   $('#txtTotal2_'+i).val(round(q_mul(q_float('txtWeight_'+i),q_float('txtMount3_'+i)),0)); 
					}
					t_total = round(q_add(t_total,q_float('txtTotal_'+i)),0);
					t_total2 = round(q_add(t_total2,q_float('txtTotal2_'+i)),0);
             	}
             	$('#txtMount').val(t_tweight);
             	$('#txtWeight').val(t_tweight2);
             	$('#txtVolume').val(t_tweight3);
             	$('#txtTotal').val(t_total);
             	$('#txtTotal2').val(t_total2);
            }

            function mainPost() {
                q_mask(bbmMask);
                bbsMask = [['txtDatea', r_picd],['txtTrandate', r_picd],['txtLtime','99:99'],['txtStime','99:99'],['txtDtime','99:99']];
                $('#txtDatea').datepicker();
                
                $('#btnOrde').click(function(e){
                    t_custno=$('#txtAddrno').val();
                    t_cno=$('#txtCno').val();
                    var t_where = "chk1=1 and cno='"+t_cno+"' and custno='"+t_custno+"' and not exists(select noa,noq from view_trans where view_tranvcces.noa=ordeno and view_tranvcces.noq=caseno)";
                    q_box("tranvcce_jr_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranvcce_tran', "95%", "650px");
                });
                
                $('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#textBdate').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                
                $('#btnImport_trans').click(function() {
                   if(q_cur != 1 && q_cur != 2){
                        var t_key = q_getPara('sys.key_payb');
                        var t_mon = $('#textMon').val();
                        t_key = (t_key.length==0?'FC':t_key);//一定要有值
                        if(t_mon.length==0){
                            alert('請先輸入月份'+q_getMsg('lblMon')+'!!');
                            return;
                        }else{
                            q_func('qtxt.query.tranpayb_jr', 'tran.txt,tranpaybjr,' + encodeURI(t_key) + ';'+ encodeURI(t_mon)); 
                        }    
                   }
                });
                
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranpayb_jr':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
            }

            function q_boxClose(s2) {
                 var ret;
                switch (b_pop) {
                    case 'tranvcce_tran':
                        if (q_cur > 0 && q_cur < 4) {
                            b_ret = getb_ret();
                            if (!b_ret || b_ret.length == 0)
                                return;
                                ret = q_gridAddRow(bbsHtm, 'tbbs', 
                                'txtOrdeno,txtCaseno,txtDatea,txtTrandate,txtCustno,txtNick,txtUccno,txtProduct,txtWeight,txtWeight3,txtWeight2,txtUnit,txtPrice,txtTotal,txtPo,txtCarno,txtDriverno,txtDriver,txtMemo,txtStraddrno,txtStraddr,txtCardealno,txtCardeal,txtPrice2,txtPrice3', b_ret.length, b_ret, 
                                'noa,noq,time1,time2,custno,cust,productno,product,weight,weight,uweight,unit,volume,total,memo2,carno,driverno,driver,memo,addrno,addr,addrno2,addr2,height,tvolume', 'txtUccno,txtProduct');
                            }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop='';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                case q_name:
                    if (q_cur == 4)
                        q_Seek_gtPost();
                    break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {
            	sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtOdate').val());
                if (q_cur ==1)
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tran_jr_s.aspx', q_name + '_s', "500px", "600px", '查詢視窗');
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#txtWeight_' + i).change(function() {
                        sum();
                    });
                    $('#txtWeight2_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice_' + i).change(function() {
                        sum();
                    });
                    $('#txtPrice2_' + i).change(function() {
                        sum();
                    });
                    $('#txtMount3_' + i).change(function() {
                        sum();
                    });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
					$(this).parent().css('background','#F2F5A9');
				},function(e){
					$(this).parent().css('background','#cad3ff');
				});
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txttrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	q_box("z_tran_jr.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'trans_mul', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['straddrno'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['date'] = abbm2['date'];
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
                q_box('tran_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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
            #dmain {
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
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
                width: 680px;
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
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 2200px;
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
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
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
	<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:150px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a id="lblMon" style="float:right; color: blue; font-size: medium;">月份</a></td>
                    <td colspan="4">
                    <input id="textMon"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>               
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="付款"/></td>
                    <td></td>
                    <td></td>
                    <td><input id="btnCancel_import" type="button" value="關閉"/></td>
                </tr>
            </table>
        </div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>出車單號</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
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
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>
						<td><span> </span><a id="lbl" class="lbl" >發票號碼</a></td>
                        <td>
                        <input id="txtDeparture" type="text" class="txt c1" />
                        </td>
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr" class="lbl btn" >客戶</a></td>
                        <td colspan="3">
                            <input type="text" id="txtAddrno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAddr" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
					<tr>
						<td><span> </span><a id="lbl" class="lbl" >請款總噸數</a></td>
						<td>
						<input id="txtMount" type="text" class="txt c1 num" />
						</td>
						<td><span> </span><a id="lbl" class="lbl" >事業總噸數</a></td>
                        <td>
                        <input id="txtVolume" type="text" class="txt c1 num" />
                        </td>
						<td><span> </span><a id="lbl" class="lbl" >處理廠總噸數</a></td>
						<td><input id="txtWeight" type="text" class="txt c1 num" /></td>
					</tr>
					<tr>
                        <td><span> </span><a id="lbl" class="lbl" >應收金額</a></td>
                        <td><input id="txtTotal" type="text" class="txt c1 num" /></td>
                        <td><span> </span><a id="lbl" class="lbl" >應付金額</a></td>
                        <td><input id="txtTotal2" type="text" class="txt c1 num" /></td>
                    </tr>
					<!--<tr>
						<td><span> </span><a id="lbl" class="lbl" >稅金</a></td>
						<td>
						<input id="txtTotal2" type="text" class="txt c1 num" />
						</td>
					</tr>-->
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
						<td><input id="btnOrde" type="button" value="派車匯入" style="width:100%;"/></td>
						<td><input id="btnImport" type="button" value="處理廠付款立帳" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:90px"><a>出車日期</a></td>
					<td align="center" style="width:90px"><a>進場日期</a></td>
					<td align="center" style="width:150px"><a>常態事業單位</a></td>
					<td align="center" style="width:150px"><a>廢棄物</a></td>
					<td align="center" style="width:90px"><a>請款噸數</a></td>
					<td align="center" style="width:90px"><a>事業噸數</a></td>
					<td align="center" style="width:90px"><a>處理廠噸數</a></td>
					<td align="center" style="width:60px"><a>單位</a></td>
					<td align="center" style="width:90px"><a>請款單價</a></td>
					<td align="center" style="width:90px"><a>應收運費</a></td>
					<td align="center" style="width:90px"><a>處理單價</a></td>
					<td align="center" style="width:90px"><a>處理金額</a></td>
					<td align="center" style="width:90px"><a>司機單價</a></td>
					<td align="center" style="width:90px"><a>應付運費</a></td>
					<td align="center" style="width:160px"><a>聯單編號</a></td>
					<td align="center" style="width:100px"><a>出車車號</a></td>
					<td align="center" style="width:100px"><a>板台</a></td>
					<td align="center" style="width:150px"><a>處理廠</a></td>
					<td align="center" style="width:200px"><a>派車單號</a></td>
					<!--<td align="center" style="width:60px"><a>已申報</a></td>-->
					<td align="center" style="width:150px"><a>備註</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input type="text" id="txtDatea.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCustno.*" style="float:left;width:39%;" />
						<input type="text" id="txtComp.*" style="display:none;">
						<input type="text" id="txtNick.*" style="float:left;width:40%;">
						<input type="button" id="btnCust.*" value='.' style=" font-weight: bold;">
					</td>
					<td>
						<input type="text" id="txtUccno.*" style="float:left;width:39%;"/>
						<input type="text" id="txtProduct.*" style="float:left;width:40%;"/>
						<input type="button" id="btnProduct.*" value='.' style=" font-weight: bold;"/>
					</td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight3.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice3.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtMount3.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtPo.*" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarno.*" style="width:65%;"/>
						<input type="text" id="txtDriverno.*" style="display:none;"/>
						<input type="text" id="txtDriver.*" style="display:none;"/>
						<input type="button" id="btnCarno.*" value='.' style=" font-weight: bold;"/>
					</td>
					<td>
                        <input type="text" id="txtCardealno.*" style="float:left;width:69%;"/>
                        <input type="text" id="txtCardeal.*" style="display:none;"/>
                        <input type="button" id="btnCardealno.*" value='.' style=" font-weight: bold;"/>
                    </td>
					<td>
						<input type="text" id="txtStraddrno.*" style="float:left;width:39%;"/>
						<input type="text" id="txtStraddr.*" style="float:left;width:40%;"/>
						<input type="button" id="btnStraddr.*" value='.' style=" font-weight: bold;"/>
					</td>
					<td>
					    <input type="text" id="txtOrdeno.*" style="width:65%;"/>
					    <input type="text" id="txtCaseno.*" style="width:25%;"/>
					</td>
					<!--<td align="center"><input id="chkChk1.*" type="checkbox"/></td>-->
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>