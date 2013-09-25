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
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "cub";
            var q_readonly = ['txtNoa'];
            var q_readonlys = ['txtDate2','txtOrdeno','txtNo2'];
            var q_readonlyt = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 5;
			aPop = new Array(['txtProductno_', 'btnProduct_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
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

            function mainPost() {
            	q_getFormat();
				bbmMask = [['txtDatea',r_picd],['txtBdate',r_picd],['txtEdate',r_picd]];
				bbsMask = [['txtDate2',r_picd],['txtDatea',r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbTypea", q_getPara('cub.typea'));
                $('#btnOrdeImport').click(function() {
                	var t_bdate = trim($('#txtBdate').val());
                	var t_edate = trim($('#txtEdate').val());
                	var t_bdime = dec($('#txtBdime').val());
                	var t_edime = dec($('#txtEdime').val());
                	var t_where = ' 1=1 ';
                	t_bdate = (emp(t_bdate)?'':t_bdate);
                	t_edate = (emp(t_edate)?'char(255)':t_edate);
                	t_where += " and (datea between '" + t_bdate + "' and '" + t_edate + "') ";
                	t_bdime = (emp(t_bdime)?0:t_bdime);
                	t_edime = (t_edime==0?Number.MAX_VALUE:t_edime);
                	t_where += " and (dime between " + t_bdime + " and " + t_edime + ")";
                	t_where += ' and (iscut=1)';
                   q_box("ordests_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ordes', "95%", "95%", q_getMsg('popOrde'));
                });
            }

            function q_gtPost(t_name) {
				switch (t_name) {
				case 'deleUccy':
					var as = _q_appendData("uccy", "", true);
					var err_str = '';
					if(as[0] != undefined){
						for(var i=0;i<as.length;i++){
							if(dec(as[i].gweight) > 0){
								err_str += as[i].uno + '已領料，不能刪除!!\n';
							}
						}
						if(trim(err_str).length > 0){
							alert(err_str);
							return;
						}else{
							_btnDele();
						}
					}else{
						_btnDele();
					}
					break;
				case 'ordet':
					var as = _q_appendData("ordet", "", true);
					for(var j = 0;j < as.length;j++){
						for(var i = 0;i<q_bbtCount;i++){
							var t_uno = $('#txtUno__' + i).val();
							if(as[j] && as[j].noa == t_uno){
								b_ret.splice(j,1);
							}
						}
					}
					if(as[0] != undefined){
						q_gridAddRow(bbtHtm, 'tbbt', 'txtUno',as.length, as,'uno','txtUno','__');   /// 最後 aEmpField 不可以有【數字欄位】
					}				
					break;
				case q_name:
					if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
					case 'ordes':
	                    if (q_cur > 0 && q_cur < 4) {
	                        if (!b_ret || b_ret.length == 0)
	                            return;
							for(var j = 0;j < b_ret.length;j++){
								for(var i = 0;i<q_bbtCount;i++){
									var t_ordeno = $('#txtOrdeno_' + i).val();
									var t_no2 = $('#txtNo2_' + i).val();
									if(b_ret[j] && b_ret[j].noa == t_ordeno && b_ret[j].no2 == t_no2){
										b_ret.splice(j,1);
									}
								}
							}
							if(b_ret[0] != undefined){
	                        	ret = q_gridAddRow(bbsHtm, 'tbbs', 'txtCustno,txtClass,txtProductno,txtProduct,txtUnit,txtDime,txtWidth,txtLengthb,txtSpec,txtOrdeno,txtNo2,txtWeight,txtMount,txtTheory,txtSize,txtUno,txtMemo', b_ret.length, b_ret, 'custno,class,productno,product,unit,dime,width,lengthb,spec,noa,no2,weight,mount,theory,size,uno,memo','txtProductno');   /// 最後 aEmpField 不可以有【數字欄位】
								var t_where = 'where=^^ 1=0 ';
								for(var i = 0;i < ret.length;i++){
									t_where += " or (noa='" + $('#txtOrdeno_' + ret[i]).val()+"' and no3='" + $('#txtNo2_' + ret[i]).val() + "')";
								}
								t_where += ' ^^';
								q_gt('ordet', t_where, 0, 0, 0, '',r_accy);
							}
							sum();
							b_ret = '';
	                    }
						break;
					case 'uccc':
	                    if (!b_ret || b_ret.length == 0)
	                   		return;
	                    if (q_cur > 0 && q_cur < 4) {
							for(var j = 0;j < b_ret.length;j++){
								for(var i = 0;i<q_bbtCount;i++){
									var t_uno = $('#txtUno__' + i).val();
									if(b_ret[j] && b_ret[j].noa == t_uno){
										b_ret.splice(j,1);
									}
								}
							}
							if(b_ret[0] != undefined){
	                        	ret = q_gridAddRow(bbtHtm, 'tbbt', 'txtUno,txtGmount,txtGweight,txtWidth,txtLengthb',
	                        					   b_ret.length, b_ret, 
	                        					   'uno,eordmount,eordweight,width,lengthb',
	                        					   'txtUno','__');   /// 最後 aEmpField 不可以有【數字欄位】
                        	}
							sum();
							b_ret = '';
	                    }
						break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
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
				q_box('z_cub.aspx', '', "95%", "95%", q_getMsg("popPrint"));
            }

            function btnOk() {
            	if ($('#txtDatea').val().length==0 || !q_cd($('#txtDatea').val())){
                	alert(q_getMsg('lblDatea')+'錯誤。');
                	return;
                }
                sum();
                $('#txtWorker').val(r_name);
               
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cub') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['ordeno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['noa'] = abbm2['noa'];
                return true;
            }
            function bbtSave(as) {
                if (!as['uno']) {
                    as[bbtKey[1]] = '';
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

            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtDime_' +i).change(function(){
							t_IdSeq = -1; 
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
            				var t_dime = dec($('#txtDime_' + b_seq).val());
		           			$('#txtBdime_'+b_seq).val(round(t_dime*0.93,2));
		            		$('#txtEdime_'+b_seq).val(round(t_dime*1.07,2));
                    	});
						$('#btnUccc_' + i).click(function(){
							t_IdSeq = -1; 
		                    q_bodyId($(this).attr('id'));
		                    b_seq = t_IdSeq;
		                	var t_where = ' 1=1 and radius=0 ';
							var t_productno = trim($('#txtProductno_' + b_seq).val());
							var t_bdime = dec($('#txtBdime_' + b_seq).val());
		                	var t_edime = dec($('#txtEdime_' + b_seq).val());
		                	var t_width = dec($('#txtWidth_' + b_seq).val());
		                	var t_blengthb = round(dec($('#txtLengthb_' + b_seq).val()) * 0.88,2);
		                	var t_elengthb = round(dec($('#txtLengthb_' + b_seq).val()) * 1.12,2);
		                	if(t_bdime == 0 && t_edime == 0){
		                		t_edime = Number.MAX_VALUE;
		                	}
		                	t_where += " and width >=" + t_width;
		                	t_where += q_sqlPara2('productno',t_productno);
		                	t_where += " and (dime between " + t_bdime + " and " + t_edime + ") ";
		                	if(dec($('#txtLengthb_' + b_seq).val()) > 0)
		                		t_where += " and (lengthb between " + t_blengthb + " and " + t_elengthb + ") ";
		                    q_box("uccc_chk_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uccc', "95%", "95%", q_getMsg('popUccc'));
                		});

                    }
                }
                _bbsAssign();
            }
			function distinct(arr1) {
				for(var i = 0;i<arr1.length;i++){
					if((arr1.indexOf(arr1[i]) != arr1.lastIndexOf(arr1[i])) || arr1[i] == ''){
						arr1.splice(i, 1);
							i--;
					}
				}
				return arr1;
			}
			function getBBTWhere(objname){
				var tempArray = new Array();
				for(var j = 0; j < q_bbtCount;j++){
					tempArray.push($('#txt'+objname+'__'+j).val());
				}
				var TmpStr = distinct(tempArray).sort();
				TmpStr = TmpStr.toString().replace(/,/g,"','").replace(/^/,"'").replace(/$/,"'");
				return TmpStr;
			}

            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    }
                }
                _bbtAssign();
            }

            function sum() {
            	for(var j = 0;j < q_bbsCount;j++){
            		var t_dime = dec($('#txtDime_' + j).val());
           			$('#txtBdime_'+j).val(round(t_dime*0.93,2));
            		$('#txtEdime_'+j).val(round(t_dime*1.07,2));
            	}
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
				var t_where = 'where=^^ uno in('+getBBTWhere('Uno')+') ^^';
				q_gt('uccy',t_where,0,0,0,'deleUccy',r_accy);
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            function q_popPost(id) {
                switch (id) {
                	case 'txtProductno_':
						$('#txtClass_' + b_seq).focus();
                	break;
                    default:
                        break;
                }
            }
		</script>
		<style type="text/css">
            #dmain {
                /*overflow: hidden;*/
            }
            .dview {
                float: left;
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
                width: 70%;
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
                width: 9%;
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
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 95%;
                float: left;
            }

            .num {
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 2500px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 2500px;
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
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblTypea" class="lbl"> </a></td>
						<td>
							<select id="cmbTypea" class="txt c1"> </select>
						</td>
					</tr>
					<tr>
		                <td><span> </span><a id="lblBdate" class="lbl" ></a></td>
		                <td colspan="2">
		                	<input id="txtBdate" type="text" style="width:45%;"/>
		                	<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
		                	<input id="txtEdate" type="text" style="width:45%;"/>
		                </td>
		                <td><span> </span><a id="lblBdime" class="lbl" ></a></td>
		                <td colspan="2">
		                	<input id="txtBdime" type="text" style="width:45%;" class="num"/>
		                	<span style="float:left; display:block; width:20px;"><a> ～ </a></span>
		                	<input id="txtEdime" type="text" style="width:45%;" class="num"/>
		                </td>
						<td><input type="button" id="btnOrdeImport" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblIdime" class="lbl" ></a></td>
						<td>
							<input id="txtIdime"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblOdime" class="lbl" ></a></td>
						<td>
							<input id="txtOdime"  type="text" class="txt c1 num"/>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWaste" class="lbl" ></a></td>
						<td>
							<input id="txtWaste"  type="text" class="txt c1 num"/>
						</td>
						<td><span> </span><a id="lblMo" class="lbl" ></a></td>
						<td>
							<input id="txtMo"  type="text" class="txt c1 num"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" ></a></td>
						<td colspan="4"><input id="txtMemo" type="text" class="txt c1"/></td>  
					</tr>
					
				</table>
			</div>
			<div class='dbbs'>
				<table id="tbbs" class='tbbs'>
					<tr style='color:white; background:#003366;' >
						<td style="width:20px;">
							<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"> </td>
						<td style="width:200px;"><a id='lbl_custno'> </a></td>
						<td style="width:120px;"><a id='lbl_productno'> </a></td>
						<td style="width:60px;"><a id='lbl_class'> </a></td>
						<td style="width:200px;"><a id='lbl_spec'> </a></td>
						<td style="width:120px;"><a id='lbl_dime'> </a></td>
						<td style="width:120px;"><a id='lbl_width'> </a></td>
 						<td style="width:120px;"><a id='lbl_lengthb'> </a></td>
						<td style="width:80px;"><a id='lbl_mount'> </a></td>
						<td style="width:150px;"><a id='lbl_weight'> </a></td>
						<td style="width:120px;"><a id='lbl_bdime'> </a></td>
						<td style="width:120px;"><a id='lbl_edime'> </a></td>
						<td style="width:60px;"><a id='lblOrdet_st'> </a></td>
						<td style="width:150px;"><a id='lbl_hweight'> </a></td>
						<td style="width:200px;"><a id='lbl_size'> </a></td>
						<td style="width:200px;"><a id='lbl_uno'> </a></td>
						<td style="width:200px;"><a id='lbl_need'> </a></td>
						<td style="width:200px;"><a id='lbl_memo'> </a></td>
						<td style="width:150px;"><a id='lbl_date2'> </a></td>
						<td style="width:30px;"><a id='lbl_enda'> </a></td>
						<td style="width:200px;"><a id='lbl_ordeno'> </a></td>
						<td style="width:60px;"><a id='lbl_no2'> </a></td>
						<td style="width:150px;"><a id='lbl_price'> </a></td>
						<td style="width:150px;"><a id='lbl_datea'> </a></td>
						<td style="width:250px;"><a id='lbl_product'> </a></td>
						<td style="width:30px;"><a id='lbl_prt'> </a></td>
						<td style="width:60px;"><a id='lbl_hend'> </a></td>
					</tr>
					<tr  style='background:#cad3ff;'>
						<td align="center">
							<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq.*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtCustno.*" type="text" class="txt c1"/></td>
						<td><input id="txtProductno.*" type="text" class="txt c1"/></td>
						<td><input id="txtClass.*" type="text" class="txt c1"/></td>
						<td><input id="txtSpec.*" type="text" class="txt c1"/></td>
						<td><input id="txtDime.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWidth.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtLengthb.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtMount.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtWeight.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtBdime.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtEdime.*" type="text" class="txt c1 num"/></td>
						<td align="center"><input id="btnUccc.*" type="button" value="選料"/></td>
						<td><input id="txtHweight.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtSize.*" type="text" class="txt c1"/></td>
						<td><input id="txtUno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNeed.*" type="text" class="txt c1"/></td>
						<td><input id="txtMemo.*" type="text" class="txt c1"/></td>
						<td><input id="txtDate2.*" type="text" class="txt c1"/></td>
						<td><input id="chkEnda.*" type="checkbox"/></td>
						<td><input id="txtOrdeno.*" type="text" class="txt c1"/></td>
						<td><input id="txtNo2.*" type="text" class="txt c1"/></td>
						<td><input id="txtPrice.*" type="text" class="txt c1 num"/></td>
						<td><input id="txtDatea.*" type="text" class="txt c1"/></td>
						<td><input id="txtProduct.*" type="text" class="txt c1"/></td>
						<td><input id="chkPrt.*" type="checkbox"/></td>
						<td><input id="chkHend.*" type="checkbox"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt" class='dbbt'>
			<table id="tbbt" class="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;">
					<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:120px; text-align: center;">原批號</td>
					<td style="width:120px; text-align: center;">原批號領料數</td>
					<td style="width:120px; text-align: center;">領料重</td>
					<td style="width:120px; text-align: center;">餘料寬</td>
					<td style="width:120px; text-align: center;">餘料長</td>
					<td style="width:30px; text-align: center;">型</td>
					<td style="width:80px; text-align: center;">數量</td>
					<td style="width:120px; text-align: center;">入庫重</td>
					<td style="width:120px; text-align: center;">餘料編號</td>
					<td style="width:120px; text-align: center;">餘料客戶</td>
					<td style="width:120px; text-align: center;">廢料</td>
					<td style="width:120px; text-align: center;">倉庫</td>
					<td style="width:120px; text-align: center;">儲位</td>
					<td style="width:120px; text-align: center;">餘料備註</td>
					<td style="width:120px; text-align: center;">餘料毛重</td>
					<td style="width:120px; text-align: center;">餘料品名</td>
					<td style="width:120px; text-align: center;">餘料板面</td>
					<td style="width:120px; text-align: center;">餘料硬度</td>
					<td style="width:120px; text-align: center;">裁剪單號</td>
					<td style="width:20px; text-align: center;">印</td>
					<td style="width:120px; text-align: center;">原批號<br>儲位異動</td>
					<td style="width:120px; text-align: center;">外加成本</td>
					<td style="width:120px; text-align: center;">原批號餘毛重</td>
					<td style="width:80px; text-align: center;">成本單價</td>
					<td style="width:120px; text-align: center;">尺寸</td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtUno..*" type="text" class="txt c1"/></td>
					<td><input id="txtGmount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtGweight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWidth..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtLengthb..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtStyle..*" type="text" class="txt c1"/></td>
					<td><input id="txtMount..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtWeight..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtBno..*" type="text" class="txt c1"/></td>
					<td><input id="txtCustno..*" type="text" class="txt c1"/></td>
					<td><input id="txtXbutt..*" type="text" class="txt c1"/></td>
					<td><input id="txtStoreno..*" type="text" class="txt c1"/></td>
					<td><input id="txtPlace..*" type="text" class="txt c1"/></td>
					<td><input id="txtMemo..*" type="text" class="txt c1"/></td>
					<td><input id="txtMweight..*" type="text" class="txt c1"/></td>
					<td><input id="txtProductno..*" type="text" class="txt c1"/></td>
					<td><input id="txtSpec..*" type="text" class="txt c1"/></td>
					<td><input id="txtHard..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtCutno..*" type="text" class="txt c1"/></td>
					<td><input id="chkPrt..*" type="checkbox"/></td>
					<td><input id="txtPlace2..*" type="text" class="txt c1"/></td>
					<td><input id="txtPrice2..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMweight2..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtMprice..*" type="text" class="txt c1 num"/></td>
					<td><input id="txtSize..*" type="text" class="txt c1"/></td>
				</tr>
		</table>
	</div>
</body>
</html>
