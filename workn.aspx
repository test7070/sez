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
            var q_name = "workn";
            var q_readonly = ['txtNoa','txtDatea','txtWorker','txtWorker2'
            ,'txtCuadate','txtMount','txtProductno','txtWorkdate','txtUnit','txtProduct','txtUindate','txtInmount','txtStationno'
            ,'txtStation','txtEnddate','txtRmount','txtTggno','txtComp','txtRank','txtWmount','txtProcessno','txtProcess'
            ,'txtModelno','txtModel','txtPrice','txtWages','txtMakes','txtHours','txtWages_fee','txtMakes_fee','txtMemo'];
            var q_readonlys = ['txtWorkno'];
            var bbmNum = [];
            var bbsNum = [['txtMount',10,2,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtWorkno', 'lblWorkno', 'work'
            , 'noa,cuadate,mount,productno,workdate,unit,product,uindate,inmount,stationno,station,enddate,rmount,tggno,comp,rank,wmount,processno,process,modelno,model,price,wages,makes,hours,wages_fee,makes_fee,memo'
            , 'txtWorkno,txtCuadate,txtMount,txtProductno,txtWorkdate,txtUnit,txtProduct,txtUindate,txtInmount,txtStationno,txtStation,txtEnddate,txtRmount,txtTggno,txtComp,txtRank,txtWmount,txtProcessno,txtProcess,txtModelno,txtModel,txtPrice,txtWages,txtMakes,txtHours,txtWages_fee,txtMakes_fee,txtMemo'
            , 'work_b.aspx','95%']
            ,['txtStationno_', 'btnStationno_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx']
            ,['txtTggno_', 'btnTggno_', 'tgg', 'noa,comp', 'txtTggno_,txtTgg_', 'tgg_b.aspx']);
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
                bbmMask = [['txtDatea', r_picd]];
                bbsMask = [['txtCuadate', r_picd],['txtUindate', r_picd]];
                q_getFormat();
                q_mask(bbmMask);
                
                $('#btnWork').click(function() {
                	if(q_cur==1 || q_cur==2){
						t_where = "enda !='1' ";
						q_box("work_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'work', "95%", "95%", q_getMsg('btnWork'));
					}
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
						//寫入欄位
						$('#txtWorkno').val(b_ret[0].noa);
						$('#txtCuadate').val(b_ret[0].cuadate);
						$('#txtMount').val(b_ret[0].mount);
						$('#txtProductno').val(b_ret[0].productno);
						$('#txtWorkdate').val(b_ret[0].workdate);
						$('#txtUnit').val(b_ret[0].unit);
						$('#txtProduct').val(b_ret[0].product);
						$('#txtUindate').val(b_ret[0].uindate);
						$('#txtInmount').val(b_ret[0].inmount);
						$('#txtStationno').val(b_ret[0].stationno);
						$('#txtStation').val(b_ret[0].station);
						$('#txtEnddate').val(b_ret[0].enddate);
						$('#txtRmount').val(b_ret[0].rmount);
						$('#txtTggno').val(b_ret[0].tggno);
						$('#txtComp').val(b_ret[0].comp);
						$('#txtRank').val(b_ret[0].rank);
						$('#txtWmount').val(b_ret[0].wmount);
						$('#txtProcessno').val(b_ret[0].processno);
						$('#txtProcess').val(b_ret[0].process);
						$('#txtModelno').val(b_ret[0].modelno);
						$('#txtModel').val(b_ret[0].model);
						$('#txtPrice').val(b_ret[0].price);
						$('#txtWages').val(b_ret[0].wages);
						$('#txtMakes').val(b_ret[0].makes);
						$('#txtHours').val(b_ret[0].hours);
						$('#txtWages_fee').val(b_ret[0].wages_fee);
						$('#txtMakes_fee').val(b_ret[0].makes_fee);
						$('#txtMemo').val(b_ret[0].memo);
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
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtWorkno', q_getMsg('lblWorkno')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                
                //判斷剩餘生產數量=分批數量
                var t_mount=0;
				for (var j = 0; j < q_bbsCount; j++) {
					t_mount+=q_float('txtMount_'+j);
                } // j
                if(t_mount!=q_float('txtMount')-q_float('txtInmount')){
                	alert(q_getMsg('lblMount_s')+'錯誤!!');
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_workn') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('workn_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
                q_box('z_worknp.aspx', '', "95%", "650px", q_getMsg("popPrint"));
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
                    	$('#txtMount_'+i).change(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
                    		if(emp($('#txtWorkno').val())){
                    			alert('請先填寫'+q_getMsg('lblWorkno')+'!!');
                    			$('#txtMount_'+b_seq).val('');
                    			return;
                    		}
                    		
                    		var t_mount=0;
							for (var j = 0; j < q_bbsCount; j++) {
								t_mount+=q_float('txtMount_'+j);
                			} // j
                			
                			if(t_mount>q_float('txtMount')-q_float('txtInmount'))
                				alert(q_getMsg('lblMount_s')+'錯誤!!');
						});
						$('#txtCuadate_'+i).blur(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtWorkno').val())){
                    			alert('請先填寫'+q_getMsg('lblWorkno')+'!!');
                    			$('#txtCuadate_'+b_seq).val('');
                    			return;
                    		}
							if(!emp($('#txtCuadate_'+b_seq).val())&&$('#txtCuadate_'+b_seq).val()<q_date()){
								alert(q_getMsg('lblCuadate_s')+'不能低於今天日期!!');
								$('#txtCuadate_'+b_seq).val(q_date());
							}
						});
						$('#txtUindate_'+i).blur(function() {
                    		t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtWorkno').val())){
                    			alert('請先填寫'+q_getMsg('lblWorkno')+'!!');
                    			$('#txtUindate_'+b_seq).val('');
                    			return;
                    		}
							if(!emp($('#txtUindate_'+b_seq).val())&&$('#txtUindate_'+b_seq).val()<q_date()){
								alert(q_getMsg('lblUindate_s')+'不能低於今天日期!!');
								$('#txtUindate_'+b_seq).val(q_date());
							}
						});
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (dec(as['mount'])<=0) {//不存檔條件
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();

                return true;
            }

            function sum() {
                var t1 = 0, t_unit, t_mount;
                for (var j = 0; j < q_bbsCount; j++) {

                } // j
            }

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
            }
            .dview {
                float: left;
                width: 28%;
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
                width: 70%;
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
                width: 9%;
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
                width: 36%;
                float: right;
            }
            .txt.c3 {
                width: 62%;
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
                width: 100%;
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
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:30%"><a id='vewNoa'> </a></td>
						<td align="center" style="width:30%"><a id='vewStation'> </a></td>
						<td align="center" style="width:30%"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='station'>~station</td>
						<td align="center" id='prodcut'>~prodcut</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td class="td1"><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td class="td2"><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td class="td3"><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td class="td4"><input id="txtDatea"  type="text" class="txt c1"/></td>
						<td class="td5"> <input id="btnWork" type="button" /></td>
					</tr>
					<tr>
				        <td class="td1"><span> </span><a id="lblWorkno" class="lbl"> </a></td>
				        <td class="td2"><input id="txtWorkno" type="text"  class="txt c1"/></td>
				        <td class="td3"><span> </span><a id="lblCuadate" class="lbl"> </a></td>
				        <td class="td4"><input id="txtCuadate" type="text"  class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblMount" class="lbl"> </a></td>
						<td class="td6"><input id="txtMount" type="text"  class="txt num c1"/></td> 
					</tr>
			        <tr>
			        	<td class="td1"><span> </span><a id="lblProductno" class="lbl"> </a></td>
				        <td class="td2"><input id="txtProductno" type="text"  class="txt c1"/></td>
				        <td class="td3"><span> </span><a id="lblWorkdate" class="lbl"> </a></td>
				        <td class="td4"><input id="txtWorkdate" type="text"  class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblUnit" class="lbl"> </a></td>
				        <td class="td6"><input id="txtUnit" type="text"  class="txt c1"/></td>
			        </tr>
			        <tr>
				        <td class="td1"><span> </span><a id="lblProduct" class="lbl"> </a></td>
				        <td class="td2"><input id="txtProduct" type="text"  class="txt c1"/></td>
				        <td class="td3"><span> </span><a id="lblUindate" class="lbl"> </a></td>
				        <td class="td4"><input id="txtUindate" type="text"  class="txt c1"/></td>
				        <td class="td5"><span> </span><a id="lblInmount" class="lbl"> </a></td>
				        <td class="td6"><input id="txtInmount" type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
				         <td class="td1"><span> </span><a id="lblStation" class="lbl"> </a></td>
				        <td class="td2">
				        	<input id="txtStationno" type="text"  class="txt" style="width: 48%"/>
				        	<input id="txtStation" type="text"  class="txt" style="width: 48%"/>
				        </td>
				        <td class="td3"><span> </span><a id="lblEnddate" class="lbl"> </a></td>
				        <td class="td4"><input id="txtEnddate" type="text"  class="txt c1"/></td>
						<td class="td5"><span> </span><a id="lblRmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtRmount" type="text"  class="txt num c1"/></td> 
					</tr>
			        <tr>
				       <td class="td1"><span> </span><a id="lblTggno" class="lbl"> </a></td>
				        <td class="td2">
				        	<input id="txtTggno" type="text"  class="txt" style="width: 48%"/>
				        	<input id="txtComp" type="text"  class="txt" style="width: 48%"/>
				        </td>
				        <td class="td3"><span> </span><a id="lblRank" class="lbl"> </a></td>
				        <td class="td4"><input id="txtRank" type="text"  class="txt c1"/></td>
				        <td class="td5"><span> </span><a id="lblWmount" class="lbl"> </a></td>
						<td class="td6"><input id="txtWmount" type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
				          <td class="td1"><span> </span><a id="lblProcess" class="lbl"> </a></td>
				        <td class="td2">
				        	<input id="txtProcessno" type="text"  class="txt" style="width: 48%"/>
				        	<input id="txtProcess" type="text"  class="txt" style="width: 48%"/>
				        </td>
				        <td class="td3"><span> </span><a id="lblModel" class="lbl"> </a></td>
				        <td class="td4">
				        	<input id="txtModelno" type="text"  class="txt" style="width: 48%"/>
				        	<input id="txtModel" type="text"  class="txt" style="width: 48%"/>
				        </td>
				        <td class="td5"><span> </span><a id="lblPrice" class="lbl"> </a></td>
				        <td class="td6"><input id="txtPrice" type="text"  class="txt num c1"/></td>
					</tr>
			        <tr>
				        <td class="td1"><span> </span><a id="lblWages" class="lbl"> </a></td>
				        <td class="td2"><input id="txtWages" type="text"  class="txt num c1"/></td>
				        <td class="td3"><span> </span><a id="lblMakes" class="lbl"> </a></td>
				        <td class="td4"><input id="txtMakes" type="text"  class="txt num c1"/></td>
				        <td class="td5"><span> </span><a id="lblHours" class="lbl"> </a></td>
				        <td class="td6"><input id="txtHours" type="text"  class="txt num c1"/></td> 
					</tr>
					<tr>
				        <td class="td1"><span> </span><a id="lblWages_fee" class="lbl"> </a></td>
				        <td class="td2"><input id="txtWages_fee" type="text"  class="txt num c1"/></td>
				        <td class="td3"><span> </span><a id="lblMakes_fee" class="lbl"> </a></td>
				        <td class="td4"><input id="txtMakes_fee" type="text"  class="txt num c1"/></td>
					</tr>
					<tr>
				        <td class="td1"><span> </span><a id="lblMemo" class="lbl"> </a></td>
				        <td class="td2" colspan='5'>
				        	<input id="txtMemo" type="text"  class="txt c1 "/>
				        </td>
					</tr>
					<tr>
				        <td class="td1"><span> </span><a id="lblWorker" class="lbl"> </a></td>
				        <td class="td2"><input id="txtWorker" type="text"  class="txt c1"/></td>
				        <td class="td3"><span> </span><a id="lblWorker2" class="lbl"> </a></td>
				        <td class="td4"><input id="txtWorker2" type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 1%;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />	</td>
					<td align="center" style="width:8%;"><a id='lblCuadate_s'> </a></td>
					<td align="center" style="width:8%;"><a id='lblUindate_s'> </a></td>
					<td align="center" style="width:7%;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblStation_s'> </a></td>
					<td align="center" style="width:20%;"><a id='lblTgg_s'> </a></td>
					<td align="center" style="width:15%;"><a id='lblWorkno_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="hidden" class="txt c1"/>
					</td>
					<td><input id="txtCuadate.*" type="text" class="txt c1"/></td>
					<td><input id="txtUindate.*" type="text" class="txt c1"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<td>
						<input id="txtStationno.*" type="text" class="txt c1" style="width: 30%;"/>
						<input class="btn"  id="btnStationno.*" type="button" value='.' style="float:left;font-weight: bold;" />
						<input id="txtStation.*" type="text" class="txt c1" style="width: 55%;"/>
					</td>
					<td>
						<input id="txtTggno.*" type="text" class="txt c1" style="width: 30%;"/>
						<input class="btn"  id="btnTggno.*" type="button" value='.' style="float:left;font-weight: bold;" />
						<input id="txtTgg.*" type="text" class="txt c1" style="width: 55%;"/>
					</td>
					<td><input id="txtWorkno.*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
