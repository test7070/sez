<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'carsalary', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'carsalary_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;

            var decbbs = [];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            //var bbmNum_comma = [];
            var bbsNum = [['txtJan', 10, 0, 1],['txtFeb', 10, 0, 1],['txtMar', 10, 0, 1],['txtApr', 10, 0, 1],['txtMay', 10, 0, 1],['txtJun', 10, 0, 1],['txtJul', 10, 0, 1],['txtAug', 10, 0, 1],['txtSep', 10, 0, 1],['txtOct', 10, 0, 1],['txtNov', 10, 0, 1],['txtDec', 10, 0, 1],['txtYear', 3, 0, 0]];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [];
            aPop = [['txtNamea_', '', 'carowner_carsalary', 'namea,idno,addr_home', '0txtNamea_,txtId_,txtAddr_', ''],
            ['txtId_', '', 'carowner_carsalary', 'idno,namea,addr_home', '0txtId_,txtNamea_,txtAddr_', '']];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='001-M9'";
                    return;
                }
                if(!q_paraChk())
                    return;
				brwCount2 = 15;
            	brwCount = 15;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                //q_getFormat();
                //q_mask(bbsMask);
            }

            function q_gtPost(t_name) {
				switch (t_name) {
            	  	case 'carsalary':
            	  		if(q_cur==2){
	            			var as = _q_appendData("carsalary", "", true);
	            			if(as[0]!=undefined){
	            				$(txtmon+b_seq).val(0);
	            				alert('此人該月份已投保過薪資!!');
	            			}
	            		}
            		break;
            		case 'carsalary_yeay':
            	  		if(q_cur==2){
	            			var as = _q_appendData("carsalary", "", true);
	            			if(as[0]!=undefined){
	            				for(var i=0;i<as.length;i++){
		            				if(as[i].jan>0) $('#txtJan_'+b_seq).val(0);
		            				if(as[i].feb>0) $('#txtFeb_'+b_seq).val(0);
		            				if(as[i].mar>0) $('#txtMar_'+b_seq).val(0);
		            				if(as[i].apr>0) $('#txtApr_'+b_seq).val(0);
		            				if(as[i].may>0) $('#txtMay_'+b_seq).val(0);
		            				if(as[i].jun>0) $('#txtJun_'+b_seq).val(0);
		            				if(as[i].jul>0) $('#txtJul_'+b_seq).val(0);
		            				if(as[i].aug>0) $('#txtAug_'+b_seq).val(0);
		            				if(as[i].sep>0) $('#txtSep_'+b_seq).val(0);
		            				if(as[i].oct>0) $('#txtOct_'+b_seq).val(0);
		            				if(as[i].nov>0) $('#txtNov_'+b_seq).val(0);
		            				if(as[i].dec>0) $('#txtDec_'+b_seq).val(0);
		            			}
	            				alert('此人該年度已投保過薪資!!');
	            			}
	            		}
            		break;
                  }
            }
			
			var txtmon='';
            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				///1030214 打上年度 複製去年資料
           				$('#txtYear_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(b_seq>'0'){
								for(var k=0;k<fbbs.length;k++){
									if(fbbs[k]!='txtYear')
										$('#'+fbbs[k]+'_'+b_seq).val($('#'+fbbs[k]+'_0').val());
								}
							}
							//搜尋資料庫有重複輸入跳出警告
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"'^^";
							q_gt('carsalary', t_where, 0, 0, 0, "carsalary_yeay");
           				});
           				/////////////////////////////////////////////////
           				$('#txtJan_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtJan_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtJan_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtJan_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and jan !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtFeb_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtFeb_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtFeb_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtFeb_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and feb !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtMar_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtMar_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtMar_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtMar_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and mar !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtApr_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtApr_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtApr_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtApr_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and apr !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtMay_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtMay_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtMay_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtMay_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and may !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtJun_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtJun_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtJun_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtJun_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and jun !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtJul_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtJul_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtJul_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtJul_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and jul !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtAug_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtAug_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtAug_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtAug_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and aug !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtSep_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtSep_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtSep_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtSep_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and sep !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtOct_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtOct_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtOct_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtOct_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and oct !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtNov_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtNov_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtNov_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtNov_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and nov !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           				$('#txtDec_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(emp($('#txtId_'+b_seq).val())){
								$('#txtDec_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblId'));
								$('#txtId_'+b_seq).focus();
								return;
							}
							if(emp($('#txtYear_'+b_seq).val())){
								$('#txtDec_'+b_seq).val(0);
								alert('請先輸入'+q_getMsg('lblYear'));
								$('#txtYear_'+b_seq).focus();
								return;
							}
							//搜尋資料庫有重複輸入跳出警告
							txtmon='#txtDec_';
							var t_where = "where=^^  id='"+$('#txtId_'+b_seq).val()+"' and year='"+$('#txtYear_'+b_seq).val()+"' and dec !=0 ^^";
							q_gt('carsalary', t_where, 0, 0, 0, "");
           				});
           			}
           		}
                _bbsAssign();//'tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['id']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }

            function refresh() {
                _refresh();
            }

            function sum() {
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
                if(q_tables == 's')
                    bbsAssign();
            }
		</script>
		<style type="text/css">
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1800px'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:3%;"><a id='lblYear'></a></td>
					<td class="td3" align="center" style="width:5%;"><a id='lblNamea'></a></td>
					<td class="td4" align="center" style="width:7%;"><a id='lblId'></a></td>
					<td class="td5" align="center" style="width:9%;"><a id='lblAddr'></a></td>
					<td class="td6" align="center" style="width:5%;"><a id='lblJan'></a></td>
					<td class="td7" align="center" style="width:5%;"><a id='lblFeb'></a></td>
					<td class="td8" align="center" style="width:5%;"><a id='lblMar'></a></td>
					<td class="td9" align="center" style="width:5%;"><a id='lblApr'></a></td>
					<td class="td10" align="center" style="width:5%;"><a id='lblMay'></a></td>
					<td class="td11" align="center" style="width:5%;"><a id='lblJun'></a></td>
					<td class="td12" align="center" style="width:5%;"><a id='lblJul'></a></td>
					<td class="td13" align="center" style="width:5%;"><a id='lblAug'></a></td>
					<td class="td14" align="center" style="width:5%;"><a id='lblSep'></a></td>
					<td class="td15" align="center" style="width:5%;"><a id='lblOct'></a></td>
					<td class="td16" align="center" style="width:5%;"><a id='lblNov'></a></td>
					<td class="td17" align="center" style="width:5%;"><a id='lblDec'></a></td>
					<td class="td18" align="center" ><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
						<input class="txt" id="txtYear.*" type="text" style="width:95%; text-align:center;"/>
						<input class="txt"  id="txtNoa.*" type="hidden"  /><input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td3">
						<input class="txt" id="txtNamea.*" type="text" style="width:95%; text-align:center;"  />
					</td>
					<td class="td4">
						<input class="txt" id="txtId.*" type="text" style="width:95%; text-align:center;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtAddr.*" type="text" style="width:95%; text-align:center;"   />
					</td>
					<td class="td6">
					<input class="txt" id="txtJan.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td7">
					<input class="txt" id="txtFeb.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td8">
					<input class="txt" id="txtMar.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td9">
					<input class="txt" id="txtApr.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td10">
					<input class="txt" id="txtMay.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td11">
					<input class="txt" id="txtJun.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td12">
					<input class="txt" id="txtJul.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td13">
					<input class="txt" id="txtAug.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td14">
					<input class="txt" id="txtSep.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td15">
					<input class="txt" id="txtOct.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td16">
					<input class="txt" id="txtNov.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td17">
					<input class="txt" id="txtDec.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td18">
                    	<input class="txt" id="txtMemo.*" type="text" style="width:95%;"  />
                    </td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
