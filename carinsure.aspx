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
            var q_name = 'carinsure', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'carinsure_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;

            var decbbs = ['money'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            //var bbmNum_comma = [];
            var bbsNum = [['txtMoney', 10, 0, 1],['txtCmoney', 10, 0, 1],['txtVmoney', 10, 0, 1]];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [['txtBdate', '999/99/99'], ['txtInmon', '999/99'], ['txtEdate', '999/99/99'], ['txtStopdate', '999/99/99']];
            aPop = [['txtInsurerno_', 'btnInsurer_', 'insurer', 'noa,comp', 'txtInsurerno_,txtInsurer_', 'insurer_b.aspx']];

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
				brwCount2 = 0;
            	brwCount = -1;
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

            }

            function bbsAssign() {
            	for(var j = 0; j < (q_bbsCount==0?1:q_bbsCount); j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
           				$('#txtInsurerno_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(b_seq>='1'){
								$('#txtBdate_'+b_seq).val($('#txtEdate_0').val());
								$('#txtEdate_'+b_seq).val((dec($('#txtBdate_'+b_seq).val().substr(0,3))+1)+$('#txtBdate_'+b_seq).val().substr(3,7));
								$('#txtInmon_'+b_seq).val($('#txtBdate_'+b_seq).val().substr(0,6));
							}
           				});
           				$('#txtCmoney_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(q_cur==1 || q_cur==2)
								$('#txtMoney_'+b_seq).val(q_add(q_float('txtCmoney_'+b_seq),q_float('txtVmoney_'+b_seq)));
           				});
           				
           				$('#txtVmoney_'+j).change(function () {
           					t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if(q_cur==1 || q_cur==2)
								$('#txtMoney_'+b_seq).val(q_add(q_float('txtCmoney_'+b_seq),q_float('txtVmoney_'+b_seq)));
           				});
           				
           			}
           		}
                _bbsAssign();//'tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
                for(var j = 0; j < q_bbsCount; j++) {//跳至空白行
                	if(emp($('#txtInsurerno_'+j).val())){
                		$('#txtInsurerno_'+j).focus();
                		break;
                	}
                }
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['bdate']) {// Dont Save Condition
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:15%;"><a id='lblInsurer'> </a></td>
					<td class="td3" align="center" style="width:7%;"><a id='lblBdate'> </a></td>
					<td class="td4" align="center" style="width:7%;"><a id='lblEdate'> </a></td>
					<td class="td5" align="center" style="width:6%;"><a id='lblInmon'> </a></td>
					<td class="td6" align="center" style="width:7%;"><a id='lblCmoney'> </a></td>
					<td class="td6" align="center" style="width:7%;"><a id='lblVmoney'> </a></td>
					<td class="td6" align="center" style="width:7%;"><a id='lblMoney'> </a></td>
					<td class="td7" align="center" style="width:6%;"><a id='lblKind'> </a></td>
					<td class="td9" align="center" style="width:9%;"><a id='lblInsurecard'> </a></td>
					<td class="td8" align="center" style="width:9%;"><a id='lblInsuresheet'> </a></td>
					<td class="td10" align="center" style="width:7%;"><a id='lblStopdate'> </a></td>
					<td class="td11" align="center" ><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center"><input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  /></td>
					<td class="td2">
						<input class="txt"  id="txtInsurerno.*" type="text" style="width:20%;"  />
						<input class="txt" id="txtInsurer.*" type="text" style="width:70%;"   />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
	                    <input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td3"><input class="txt" id="txtBdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td4"><input class="txt" id="txtEdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td5"><input class="txt" id="txtInmon.*" type="text" style="width:95%; text-align:center;"   /></td>
					<td class="td6"><input class="txt" id="txtCmoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td6"><input class="txt" id="txtVmoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td6"><input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;"  /></td>
					<td class="td7"><input class="txt" id="txtKind.*" type="text" style="width:95%;"  /></td>
					<td class="td9"><input class="txt" id="txtInsurecard.*" type="text" style="width:95%;"  /></td>
					<td class="td8"><input class="txt" id="txtInsuresheet.*" type="text" style="width:95%;"  /></td>
					<td class="td10"><input class="txt" id="txtStopdate.*" type="text" style="width:95%; text-align:center;"  /></td>
					<td class="td11"><input class="txt" id="txtMemo.*" type="text" style="width:95%;"  /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
