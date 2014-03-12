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
		<script type="text/javascript">
            this.errorHandler = null;

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_desc = 1;
            q_tables = 's';
            var q_name = "workk";
            var q_readonly = ['txtNoa','txtDatea','txtWorker','txtWorker2','txtCngno','txtWorkano'];
            var q_readonlys = ['txtWorkno'];
            var bbmNum = [];
            var bbsNum = [['txtMount',12,2,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(
            ['txtStoreno', 'lblStoreno', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
            ,['txtStoreinno', 'lblStoreinno', 'store', 'noa,store', 'txtStoreinno,txtStorein', 'store_b.aspx']
            ,['txtStationno', 'lblStation', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx']
            ,['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy)
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }

                mainForm(1);
            }

            function mainPost() {
                bbmMask = [['txtDatea', r_picd],['txtCuadate', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('workk.typea'));
                
                $('#lblWorkno').click(function() {
					if(!emp($('#txtWorkno').val())){
						t_where = "noa='"+$('#txtWorkno').val()+"'";
						q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
					}
                });
                
                $('#btnWork').click(function() {
                	if(q_cur==1 || q_cur==2){
                		var t_err = '';
                		t_err = q_chkEmpField([['txtProductno', q_getMsg('lblProduct')]]);
	                	if (t_err.length > 0) {
		                    alert(t_err);
	    	                return;
	        	        }
	        	        if(!emp($('#txtProcessno').val()))
	        	        	t_where = "productno='"+$('#txtProductno').val()+"' and processno='"+$('#txtProcessno').val()+"' and enda!='1' ";
	        	        else
							t_where = "productno='"+$('#txtProductno').val()+"' and enda!='1' ";
						q_box("work_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('btnWork'));
					}
                });
                
                $('#btnClose_div_stk').click(function() {
					$('#div_stk').toggle();
				});
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'work':
                		if (q_cur > 0 && q_cur < 4) {
							b_ret = getb_ret();
							if (!b_ret || b_ret.length == 0)
	                            return;
							var mindate='999/99/99';
	                        for (i = 0; i < b_ret.length; i++) {
	                        	if(mindate>b_ret[i].cuadate)
	                        		mindate=b_ret[i].cuadate;
	                        }
	                        if(mindate<q_date())
	                        	$('#txtCuadate').val(q_date());
	                        else
	                        	$('#txtCuadate').val(mindate);
	                        
                	  		ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtWorkno,txtProductno,txtProduct,txtStationno,txtStation,txtProcessno,txtProcess,txtMount,txtHours,txtCuadate,txtUindate,txtTggno,txtComp', b_ret.length, b_ret
	                        , 'noa,productno,product,stationno,station,processno,process,mount,hours,cuadate,uindate,tggno,comp'
	                        , 'txtProductno');
	                        sum();
						}
                	break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength=document.getElementById("table_stk").rows.length-3;
							for (var j = 1; j < rowslength; j++) {
								document.getElementById("table_stk").deleteRow(3);
							}
						var stk_row=0;
						
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if(dec(as[i].mount)!=0){
								var tr = document.createElement("tr");
								tr.id = "bbs_"+j;
								tr.innerHTML = "<td id='stk_tdStoreno_"+stk_row+"'><input id='stk_txtStoreno_"+stk_row+"' type='text' class='txt c1' value='"+as[i].storeno+"' disabled='disabled'/></td>";
								tr.innerHTML+="<td id='stk_tdStore_"+stk_row+"'><input id='stk_txtStore_"+stk_row+"' type='text' class='txt c1' value='"+as[i].store+"' disabled='disabled' /></td>";
								tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><input id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' value='"+as[i].mount+"' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr,tmp);
								stk_row++;
							}
							//庫存總計
							stkmount = stkmount + dec(as[i].mount);
						}
						var tr = document.createElement("tr");
						tr.id = "bbs_"+j;
						tr.innerHTML="<td colspan='2' id='stk_tdStore_"+stk_row+"' style='text-align: right;'><span id='stk_txtStore_"+stk_row+"' class='txt c1' >倉庫總計：</span></td>";
						tr.innerHTML+="<td id='stk_tdMount_"+stk_row+"'><span id='stk_txtMount_"+stk_row+"' type='text' class='txt c1 num' > "+stkmount+"</span></td>";
						var tmp = document.getElementById("stk_close");
						tmp.parentNode.insertBefore(tr,tmp);
						stk_row++;
						
						$('#div_stk').css('top',mouse_point.pageY-parseInt($('#div_stk').css('height')));
						$('#div_stk').css('left',mouse_point.pageX-parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function btnOk() {
                var t_err = '';
                t_err = q_chkEmpField([['txtProcessno', q_getMsg('lblProcess')], ['txtProductno', q_getMsg('lblProduct')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                                
                sum();
                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                else
                    $('#txtWorker2').val(r_name);

                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());

                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workk') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('workk_s.aspx', q_name + '_s', "500px", "420px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtProductno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box('z_workkp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtWorkno_'+i).click(function() {
		                	t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtWorkno_' + b_seq).val())){
								t_where = "noa='"+$('#txtWorkno_' + b_seq).val()+"'";
								q_box("work.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('PopWork'));
							}
		                });
		                $('#btnStk_' + i).mousedown(function(e) {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtProductno_' + b_seq).val()) && $("#div_stk").is(":hidden")) {
								mouse_point=e;
								document.getElementById("stk_productno").innerHTML = $('#txtProductno_' + b_seq).val();
								document.getElementById("stk_product").innerHTML = $('#txtProduct_' + b_seq).val();
								//庫存
								var t_where = "where=^^ ['" + q_date() + "','','" + $('#txtProductno_' + b_seq).val() + "') ^^";
								q_gt('calstk', t_where, 0, 0, 0, "msg_stk_all", r_accy);
							}
						});
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['txtWorkno']) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount=0,t_hours=0;
                for (var j = 0; j < q_bbsCount; j++) {
					t_mount+=q_float('txtMount_'+j);
					t_hours+=q_float('txtHours_'+j);
                } // j
                q_tr('txtMount',t_mount);
                q_tr('txtHours',t_hours);
            }

            function refresh(recno) {
                _refresh(recno);
                $('#div_stk').hide();
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
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
                width: 1260px;
            }
            .dview {
                float: left;
                width: 360px;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
                width: 100%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 900px;
                margin: -1px;
                border: 1px black solid;
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
                /*width: 9%;*/
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: right;
            }
            .txt.c3 {
                width: 59%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 98%;
                float: left;
            }
            .txt.c6 {
                width: 25%;
            }
            .txt.c7 {
                width: 95%;
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
            .tbbm td input[type="button"] {
                float: left;
                width: auto;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .tbbm select {
                font-size: medium;
            }
            .dbbs {
                width: 1260px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品編號</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">產品名稱</td>
					<td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
				</tr>
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
						<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:20%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:40%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='station'>~station</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height: 1px;">
						<td width="130px"> </td>
						<td width="255px"> </td>
						<td width="130px"> </td>
						<td width="255px"> </td>
						<td width="130px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblType' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"></select></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td2"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td4"><input id="txtNoa"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStation' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStationno"  type="text" class="txt c2"/>
							<input id="txtStation"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblCuadate' class="lbl"> </a></td>
						<td class="td4"><input id="txtCuadate"  type="text" class="txt c1"/></td>
						<td class="td4"><input type="button" id="btnWork"></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblStoreno' class="lbl btn"> </a></td>
						<td class="td2">
							<input id="txtStoreno"  type="text" class="txt c2"/>
							<input id="txtStore"  type="text" class="txt c3"/>
						</td>
						<td class="td3"><span> </span><a id='lblStoreinno' class="lbl btn"> </a></td>
						<td class="td4">
							<input id="txtStoreinno"  type="text" class="txt c2"/>
							<input id="txtStorein"  type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td class="td2" colspan="3"><input id="txtMemo"  type="text" class="txt c5"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblCngno' class="lbl"> </a></td>
						<td class="td2"><input id="txtCngno"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorkano' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorkano"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td class="td1"><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td class="td2"><input id="txtWorker"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td class="td4"><input id="txtWorker2"  type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%;"><input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  /></td>
					<td align="center" style="width:19%;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:25%;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:4%;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblWorkno_s'> </a></td>
					<td align="center" style="width:4%;"><a id='lblStk_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>	<input class="btn"  id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td>
						<input class="txt"  id="txtProductno.*" type="text" style="width:85%;" />
						<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:1%;"  />
					</td>
					<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
					<td><input id="txtUnit.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt c1" style="text-align:right"/></td>
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td align="center"><input class="btn"  id="btnStk.*" type="button" value='.' style="width:1%;"  /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
