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
            var q_name = "tranvcce";
            var q_readonly = ['txtNoa', 'txtWeight','txtTotal', 'txtWorker', 'txtWorker2','txtAddress'];
            var q_readonlys = ['txtOrdeno', 'txtNo2'];
            var bbmNum = [];
            var bbsNum = [['txtWeight', 10, 3, 1],['txtUweight', 10, 2, 1],['txtMount', 10, 0, 1],['txtVolume', 10, 0, 1],['txtTvolume', 10, 0, 1],['txtTheight', 10, 0, 1],['txtTotal', 10, 0, 1],['txtTotal2', 10, 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtTime3', '999/99/99'],['txtLng', '999/99/99'],['txtBdate', '999/99/99'],['txtEdate', '999/99/99'],['txtTime1', '99:99'],['txtTime2', '99:99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            ,['txtAddrno', 'lblAddr_js', 'addr2_wj', 'custno,cust,address', 'txtAddrno,txtAddr,txtAddress', 'addr2_b2.aspx']
            , ['txtCustno', 'btnCust', 'cust', 'noa,nick', 'txtCustno,txtComp', 'cust_b.aspx']
            , ['txtCustno_', 'btnCust_', 'cust', 'noa,nick', 'txtCustno_,txtCust_', 'cust_b.aspx']
            , ['txtProductno_', 'btnProduct_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
            , ['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtAddrno2_', 'btnAddr2_', 'addr2', 'custno,cust,address,memo', 'txtAddrno2_,txtAddr2_,txtAddress_,txtMemo_', 'addr2_b2.aspx']
            , ['txtAddrno3_', 'btnAddr3_', 'addr2', 'custno,cust', 'txtAddrno3_,txtAddr3_', 'addr2_b2.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']
            , ['txtLng2_', 'btnCarplate_', 'carplate', 'noa', 'txtLng2_', 'carplate_b.aspx']);

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
            }
            var t_weight=0;
            function sum() {
                for(var i=0;i<q_bbsCount;i++){
                    if($('#txtLat').val().length>0){
                        $('#txtConn_'+i).val($('#txtLat').val());
                    }
                    if($('#txtAddrno').val().length>0){
                        $('#txtAddrno_'+i).val($('#txtAddrno').val());
                        $('#txtAddr_'+i).val($('#txtAddr').val());
                        $('#txtMemo2_'+i).val($('#txtAddress').val());
                    }
                    if($('#txtWeight_'+i).val().length>0 && $('#txtMount_'+i).val().length>0){
                        $('#txtUweight_'+i).val(q_div($('#txtWeight_'+i).val(),$('#txtMount_'+i).val()));
                    }
                    $('#txtTotal_'+i).val(q_mul(q_div($('#txtWeight_'+i).val(),1000),$('#txtVolume_' + i).val()));
                    t_weight=q_add(t_weight,q_float('txtWeight_'+i))  
                }
                
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                
                $('#btnOrde').click(function(e){
                    t_custno=$('#txtAddrno').val();
                    t_cno=$('#txtCno').val();
                    t_po=$('#txtLat').val();
                    if (t_po.length>0){
                        var t_where = "addrno3='"+t_cno+"' and Addrno='"+t_custno+"' and (caseno='"+t_po+"') and not exists(select noa,noq from view_tranvcces where ordeno=a.noa and no2=a.noq)";
                    }else{
                        var t_where = "addrno3='"+t_cno+"' and Addrno='"+t_custno+"' and not exists(select noa,noq from view_tranvcces where ordeno=a.noa and no2=a.noq)";
                    }
                    q_box("tranordewj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranorde_tranvcce', "100%", "100%", "");
                });

                $('#btnImport').click(function() {
                    $('#divImport').toggle();
                    $('#textBdate').focus();
                });
                $('#btnCancel_import').click(function() {
                    $('#divImport').toggle();
                });
                $('#txtAddrno').change(function() {
                     var t_where = "where=^^ noa in(select max(noa) from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                     q_gt('addr2', t_where, 0, 0, 0, "addr2");
                });
                $('#txtDatea').change(function() {
                     var t_where = "where=^^ noa in(select max(noa) from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                     q_gt('addr2', t_where, 0, 0, 0, "addr2");
                });
                $('#btnImport_trans').click(function() {
                   if(q_cur != 1 && q_cur != 2){
                       var t_accy = r_accy;
                        var t_key = q_getPara('sys.key_trans');
                        var t_bdate = $('#textBdate').val();
                        var t_edate = $('#textEdate').val();
                        var t_carno = $('#textCarno').val();
                        t_key = (t_key.length==0?'BA':t_key);//一定要有值
                        q_func('qtxt.query.tranvcce2tran_wj', 'tran.txt,tranvccewj2tranwj,' + encodeURI(t_accy) + ';' + encodeURI(t_key) + ';'+ encodeURI(t_bdate) + ';'+ encodeURI(t_edate)+ ';'+ encodeURI(t_carno));
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'tranorde_tranvcce':
                            if (q_cur > 0 && q_cur < 4) {
                                b_ret = getb_ret();
                                if (!b_ret || b_ret.length == 0)
                                    return;
                                    ret = q_gridAddRow(bbsHtm, 'tbbs', 
                                    'txtConn,txtCustno,txtCust,txtBdate,txtTime1,txtEdate,txtTime2,txtTypea,txtProductno,txtProduct,txtUnit,txtWeight,txtMount,txtTvolume,txtTheight,txtCarno,txtDriverno,txtDriver,txtAddrno2,txtAddr2,txtAddress,txtTranno,txtOrdeno,txtNo2,txtMemo', b_ret.length, b_ret, 
                                    'caseno,conn,tel,date1,time1,date2,time2,typea,productno,product,unit,theight,mount,total2,total3,carno,driverno,driver,addrno2,addr2,address,tranno,noa,noq,memo','');
                             }
                             sum();
                             var t_where = "where=^^ noa in(select max(noa)  from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                             q_gt('addr2', t_where, 0, 0, 0, "addr2");
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'addr2':
                            var as = _q_appendData("addr2", "", true);
                            if(as[0]!=undefined){
                                var addr2s = _q_appendData("addr2s", "", true);
                                for (var j = 0; j< q_bbsCount; j++) {
                                    for (var i = 0; i < addr2s.length; i++) {
                                        if(addr2s[i].addrno==$('#txtAddrno').val() && addr2s[i].carno==$('#txtTypea_'+j).val() && dec(addr2s[i].rate)<=dec(q_div(t_weight,1000)) && dec(addr2s[i].rate2)>=dec(q_div(t_weight,1000)) && dec(addr2s[i].lat)<=dec(dec($('#txtAddress_0').val().substring(0,3))) && dec(addr2s[i].lng)>=dec(dec($('#txtAddress_0').val().substring(0,3)))){
                                            $('#txtVolume_'+j).val(addr2s[i].value);
                                            $('#txtTotal_'+j).val(q_mul(q_div($('#txtWeight_'+j).val(),1000),addr2s[i].value));
                                        }
                                    }
                                }
                            }
                            t_weight=0;
                            break;    
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
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranvcce_jr_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                    	continue;
                    $('#txtCustno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCust_'+n).click();
                    })
                    $('#txtProductno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                    });
                    $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr2_'+n).click();
                    });
                    $('#txtCarno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarno_'+n).click();
                    });
                    $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriver_'+n).click();
                    });
                    $('#txtAddrno3_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr3_'+n).click();
                    });
                    $('#txtLng2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnCarplate_'+n).click();
                    });
                    $('#txtTypea_'+i).change(function() {
                        sum();
                        var t_where = "where=^^ noa in(select max(noa)  from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                        q_gt('addr2', t_where, 0, 0, 0, "addr2");
                    });
                    $('#txtAddr2no_'+i).change(function() {
                       sum();
                       var t_where = "where=^^ noa in(select max(noa)  from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                       q_gt('addr2', t_where, 0, 0, 0, "addr2");
                    });
                    $('#txtWeight_' + i).change(function() {
                        sum();
                        var t_where = "where=^^ noa in(select max(noa)  from addr2 where sdate<='"+$('#txtDatea').val()+"' group by custno,cust)^^ stop=999";
                        q_gt('addr2', t_where, 0, 0, 0, "addr2");
                    });
                    $('#txtMount_' + i).change(function() {
                        sum();
                    });
                    $('#txtVolume_' + i).change(function() {
                        sum();
                    })                 
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
            	//q_box("z_tran_jr.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'trans_mul', "95%", "95%", q_getMsg("popPrint"));
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
                if (!as['edate']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                return true;n
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('#txtDatea').datepicker('destroy');
                    $('#btnOrde').attr('disabled','disabled');
                    $('#btnImport_trans').removeAttr('disabled');
                }else{
                    $('#txtDatea').datepicker();
                    $('#btnOrde').removeAttr('disabled');
                    $('#btnImport_trans').attr('disabled','disabled');
                }
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
                q_box('tranvcce_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
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
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranvcce2tran_wj':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
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
                width: 630px;
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
                width: 3000px;
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
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車日期</a></td>
                    <td colspan="4">
                    <input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    <span style="float:left;display:black;height:100%;width:30px;">~</span>
                    <input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車車號</a></td>
                    <td colspan="4">
                    <input id="textCarno"  type="text" style="float:left; width:100px; font-size: medium;"/>
                </tr>
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="匯入"/></td>
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
						<td align="center" style="width:20%"><a>提貨地點</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='addr'>~addr</td>
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
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtCno" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtAcomp" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr_js" class="lbl btn">提貨地點</a></td>
                        <td colspan="3">
                            <input type="text" id="txtAddrno" class="txt" style="width:40%;float: left; " />
                            <input type="text" id="txtAddr" class="txt" style="width:60%;float: left; " />
                        </td>
                        <td colspan="2">
                            <input type="text" id="txtAddress" class="c1 txt"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblPo" class="lbl">運輸單號</a></td>
                        <td colspan="2"><input type="text" id="txtLat" class="c1 txt"/></td>
                    </tr>
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
						<td><input id="btnOrde" type="button" value="訂單匯入" style="width:100%;"/></td>
                        <td><input id="btnImport" type="button" value="匯至出車" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:80px"><a>客戶</a></td>
					<td align="center" style="width:80px"><a>裝貨日期</a></td>
					<td align="center" style="width:80px"><a>卸貨日期</a></td>
					<td align="center" style="width:180px"><a>收貨人/地點</a></td>
					<td align="center" style="width:70px"><a>危險等級</a></td>
					<td align="center" style="width:120px"><a>品名</a></td>
					<td align="center" style="width:150px"><a>批號</a></td>
					<td align="center" style="width:50px"><a>單位</a></td>
					<td align="center" style="width:80px"><a>品重(KG)</a></td>
                    <td align="center" style="width:100px"><a>毛重(KG)</a></td>
					<td align="center" style="width:80px"><a>數量</a></td>
					<td align="center" style="width:80px"><a>單價</a></td>
					<td align="center" style="width:80px"><a>人工裝費</a></td>
                    <td align="center" style="width:80px"><a>管理收入</a></td>
                    <td align="center" style="width:80px"><a>應收金額</a></td>
					<td align="center" style="width:80px"><a>應付金額</a></td>
					<td align="center" style="width:80px"><a>車牌</a></td>
                    <td align="center" style="width:80px"><a>司機</a></td>
                    <td align="center" style="width:80px"><a>板台</a></td>
                    <td align="center" style="width:100px"><a>中繼站</a></td>
                    <td align="center" style="width:100px"><a>送貨單號</a></td>
                    <td align="center" style="width:80px"><a>結關日期</a></td>
                    <td align="center" style="width:60px"><a>車趟<br/>(1去2回)</a></td>
                    <td align="center" style="width:80px"><a>隨車</a></td>
                    <td align="center" style="width:120px"><a>派車狀況</a></td>
                    <td align="center" style="width:30px"><a>提貨</a></td>
                    <td align="center" style="width:30px"><a>卸貨</a></td>
                    <td align="center" style="width:30px"><a>完工</a></td>
                    <td align="center" style="width:120px"><a>訂單編號</a></td>
					<td align="center" style="width:100px"><a>注意事項</a></td>
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					    <input type="text" id="txtConn.*" style="display:none;" />
                        <input type="text" id="txtCustno.*" style="float:left;width:95%;" />
                        <input type="text" id="txtCust.*" style="float:left;width:95%;">
                        <input type="button" id="btnCust.*" style="display:none;">
                    </td>
					<td>
                        <input type="text" id="txtBdate.*" style="width:95%;" />
                        <input type="text" id="txtTime1.*" style="width:95%;" />
                    </td>
                    <td>
                        <input type="text" id="txtEdate.*" style="width:95%;" />
                        <input type="text" id="txtTime2.*" style="width:95%;" />
                    </td>
                    <td>
                        <input type="text" id="txtAddrno.*" style="display:none;" />
                        <input type="text" id="txtAddr.*" style="display:none;" />
                        <input type="text" id="txtMemo2.*" style="display:none;" />
                        <input type="text" id="txtAddrno2.*" style="width:45%;" />
                        <input type="text" id="txtAddr2.*" style="width:45%;" />
                        <input type="text" id="txtAddress.*" style="width:95%;" />
                        <input type="button" id="btnAddr2.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtTypea.*" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtProductno.*" style="width:95%;" />
                        <input type="text" id="txtProduct.*" style="width:95%;" />
                        <input type="button" id="btnProduct.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtUno.*" style="width:95%;"/></td>
                    <td><input type="text" id="txtUnit.*" style="width:95%;"/></td>
					<td><input type="text" id="txtUweight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtWeight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtMount.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtVolume.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTvolume.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTheight.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal.*" class="num" style="width:95%;"/></td>
					<td><input type="text" id="txtTotal2.*" class="num" style="width:95%;"/></td>
					<td>
                        <input type="text" id="txtCarno.*" style="width:95%;"/>
                        <input type="button" id="btnCarno.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtDriverno.*" style="width:95%"/>
                        <input type="text" id="txtDriver.*" style="width:95%"/>
                        <input type="button" id="btnDriver.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtLng2.*" style="width:95%;"/>
                        <input type="button" id="btnCarplate.*" style="display:none;"/>
                    </td>
                    <td>
                        <input type="text" id="txtAddrno3.*" style="width:95%;" />
                        <input type="text" id="txtAddr3.*" style="width:95%;" />
                        <input type="button" id="btnAddr3.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtTranno.*" style="width:95%;"/></td>
					<td><input type="text" id="txtLng.*" style="width:95%;"/></td>
					<td><input type="text" id="txtUnit2.*" style="width:95%;"/></td>
					<td><input type="text" id="txtTel.*" style="width:95%;"/></td>
					<td><input type="text" id="txtAllowcar.*" style="width:95%;"/></td>
					<td align="center"><input id="chkChk1.*" type="checkbox"/></td>
					<td align="center"><input id="chkChk2.*" type="checkbox"/></td>
					<td align="center"><input id="chkChk3.*" type="checkbox"/></td>
					<td align="center">
                        <input type="text" id="txtOrdeno.*" style="width:95%;" />
                        <input type="text" id="txtNo2.*" style="width:30%;" />
                    </td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>