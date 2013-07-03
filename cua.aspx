<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>

		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            q_tables = 's';
            var q_name = "cua";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtOrdemount', 10, 0, 1],['txtCuamount', 10, 0, 1],['txtInmount', 10, 0, 1],['txtWmount', 15, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea', r_picd],['txtUindate', r_picd],['txtEdate',r_picd]];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 5;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
			q_desc = 1;
            aPop = new Array(
            	['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx'],
            	['txtStationno_', 'btnStationno_', 'station', 'noa,station', 'txtStationno_,txtStation_', 'station_b.aspx']
           	);

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
			var public_stationInfo = '';
            function mainPost() {
                q_getFormat();
                q_mask(bbmMask);
            	bbsMask = [['txtDatea', r_picd],['txtUindate', r_picd]];
                q_mask(bbsMask);
                q_gt('station', '' , 0, 0, 0, "", r_accy);
                $('#btnWork').click(function() {
                    q_func('cua.genWork', r_accy+','+$('#txtNoa').val()+','+r_name);
                });
                $('#btnOrdewindow').click(function() {
                	t_where = '';
                    q_box("ordes_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
					case 'ordes':
	                    if (q_cur > 0 && q_cur < 4) {
	                        b_ret = getb_ret();
	                        if (!b_ret || b_ret.length == 0)
	                            return;
	                        var i, j = 0;
	                        ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtProductno,txtProduct,txtUnit,txtOrdemount,txtEdate,txtOrdeno,txtNo2', b_ret.length, b_ret
	                                                           , 'productno,product,unit,mount,datea,noa,no2'
	                                                           , 'txtProductno,txtNo2');   /// 最後 aEmpField 不可以有【數字欄位】
	                        bbsAssign();
	                        for (i = 0; i < ret.length; i++) {
	                            k = ret[i];  ///ret[i]  儲存 tbbs 指標
	                            if (!b_ret[i]['unit'] || b_ret[i]['unit'].toUpperCase() == 'KG') {
	                                $('#txtMount_' + k).val(b_ret[i]['notv']);
	                                $('#txtWeight_' + k).val(divide0(b_ret[i]['weight'] * b_ret[i]['notv'], b_ret[i]['mount']));
	                            }
	                            else {
	                                $('#txtWeight_' + k).val(b_ret[i]['notv2']);
	                                $('#txtMount_' + k).val(divide0(b_ret[i]['mount'] * b_ret[i]['notv2'], b_ret[i]['weight']));
	                            }
	
	                        }  /// for i
	                        UcaCatch(0,ret);
	                    }
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
            var public_ret = "";
            function UcaCatch(want_do,data,id){
            	if(want_do == 0){		//Call GT for get data;
            		public_ret = data;
            		for(var i = 0;i < data.length;i++){
            			t_noa = $.trim($('#txtProductno_' + data[i]).val());
            			t_where = "where=^^ noa ='"+t_noa+"' ^^";           	
	            		q_gt('uca', t_where , 0, 0, 0, "", r_accy);
            		}
            	}else if(want_do == 1){	//Input Data
            		if(data[0]!=undefined){
            			$('input[id *="txtProductno_"]').each(function(){
            				if($(this).val() == data[0].noa){
            					var bbs_id = $(this).attr('id').split('_')[1];
            					$('#txtStationno_' + bbs_id).val(data[0].stationno);
            					$('#txtStation_' + bbs_id).val(data[0].station);
            					UcaCatch('CountDay',data[0].hours,bbs_id);
            				}
            			})
            		}
            	}else if(want_do == 'CountDay'){	//Get Date
            		var thisStationno = '',thisEdate = '',thisOrdemount = '';
            		thisStationno = $('#txtStationno_' + id).val();
            		thisEdate = $('#txtEdate_' + id).val();
            		thisOrdemount = dec($('#txtOrdemount_' + id).val());
            		var days = 0,s_gen = 0,s_hours = 0;
            		if(!emp(thisEdate)){
	            		for(var i = 0;i<public_stationInfo.length;i++){
	            			if(public_stationInfo[i].noa == thisStationno){
	            				s_gen = dec(public_stationInfo[i].gen);
	            				s_hours = dec(public_stationInfo[i].hours);
	            				days = Math.ceil((data*thisOrdemount)/(s_gen*s_hours));
	            				$('#txtDatea_' + id).val(DateDiff(thisEdate,days));
	            			}
	            		}
            		}
            	}
            }
            
            function DateDiff(date,diff){ //date format 102/06/10
            	var w_year = dec(date.split('/')[0]);
            	var w_mon = dec(date.split('/')[1]);
            	var w_day = dec(date.split('/')[2]);
            	if((w_day-diff) <=0){
            		if(w_mon == 1){
            			w_year = w_year-1;
            			w_mon = 12;
            		}else{
            			w_mon = w_mon-1;
            		}
            		w_day = $.datepicker._getDaysInMonth(w_year,w_mon-1)+(w_day-diff);
            	}else{
            		w_day = (w_day-diff);
            	}
            	w_year = (w_year<100 ? padL(w_year,'0',3):w_year);
            	w_mon = (w_mon<10 ? padL(w_mon,'0',2):w_mon);
            	w_day = (w_day<10 ? padL(w_day,'0',2):w_day);
            	return w_year + '/' + w_mon + '/' + w_day;
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {
					case 'uca':
						var as = _q_appendData("uca", "", true);
						if(as[0]!=undefined){
							UcaCatch(1,as);
		                }
	                	break;
					case 'station':
						var as = _q_appendData("station", "", true);
						if(as[0]!=undefined){
							public_stationInfo = as;
		                }
	                	break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function btnOk() {
				t_err = '';
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
				if(q_cur==1)
	            	$('#txtWorker').val(r_name);
	            else
	            	$('#txtWorker2').val(r_name);
            	var t_noa = trim($('#txtNoa').val());
		        var t_date = trim($('#txtDatea').val());
		        if (t_noa.length == 0 || t_noa == "AUTO")
		            q_gtnoa(q_name, replaceAll('C' + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
           }
            function bbsAssign() {
                for (var j = 0; j < q_bbsCount; j++) {
                }
                _bbsAssign();
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
                $('#txtDatea').focus();
            }

			function btnPrint() {
				q_box('z_cua.aspx', '', "95%", "95%", q_getMsg("popPrint"));
			}

            function wrServer(key_value) {
                var i;

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['productno'] && !as['product']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();     
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
                width: 300px;
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
                width: 700px;
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
                width: 10%;
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
            .txt.c2 {
                width: 95%;
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
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"],select {
                font-size: medium;
            }
            .num {
                text-align: right;
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
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="noa" style="text-align: center;">~noa</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:7px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEnddatea' class="lbl"> </a></td>
						<td><input id="txtEnddatea" type="text" class="txt c1"/></td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3">
							<textarea id="txtMemo" rows="5" cols="10" style="width: 98%; height: 50px;"></textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>	
					<tr>
						<td></td>
						<td colspan="2">
							<input id="btnOrdewindow" type="button" />
							<input id="btnWork" type="button" />
						</td>
						<td></td>
					</tr>	
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:1%;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:8%;"><a id='lblOrdeno_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblNo2_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblDatea_s'></a></td>
					<td colspan="2" align="center" style="width:15%;"><a id='lblProductno_s'></a></td>
					<td align="center" style="width:3%;"><a id='lblUnit_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblOrdemount_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblCuamount_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblInmount_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblWmount_s'></a></td>
					<td colspan="2" align="center" style="width:12%;"><a id='lblStationno_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblUindate_s'></a></td>
					<td align="center" style="width:5%;"><a id='lblEdate_s'></a></td>
					<td align="center" style="width:6%;"><a id='lblTotalhours_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input id="txtOrdeno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtNo2.*" type="text" style="width: 90%;" /></td>
					<td><input id="txtDatea.*" type="text" style="width: 95%;" /></td>
					<td colspan="2">
						<input id="txtProductno.*" type="text" style="width: 30%;"/>
						<input id="txtProduct.*" type="text" style="width: 50%;"/>
						<input id="btnProductno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td><input id="txtUnit.*" type="text" style="width: 95%;text-align: center;"/></td>
					<td><input id="txtOrdemount.*" type="text" class="txt num c2"/></td>
					<td><input id="txtCuamount.*" type="text" class="txt num c2"/></td>
					<td><input id="txtInmount.*" type="text" class="txt num c2"/></td>
					<td><input id="txtWmount.*" type="text" class="txt num c2"/></td>
					<td colspan="2">
						<input id="txtStationno.*" type="text" style="width: 30%;"/>
						<input id="txtStation.*" type="text" style="width: 50%;"/>
						<input id="btnStationno.*" type="button" value='.' style=" font-weight: bold;width:1%;" />
					</td>
					<td><input id="txtUindate.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtEdate.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtTotalhours.*" type="text" class="txt num c1" style="width: 95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
