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
            var q_name = 'cicar', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as;
            var t_sqlname = 'cicar_load';
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
            var bbsNum = [];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [];
            

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'carno'];
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
            	for(var j = 0; j < q_bbsCount; j++) {
           			if (!$('#btnMinus_' + j).hasClass('isAssign')) {
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
                if(!as['carno']) {// Dont Save Condition
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
				<td align="center" style="width:8%;" class="td2"><a id='lblCarno'> </a></td>
                <td align="center" style="width:20%;" class="td1"><a id='lblInsurer'> </a></td>
                <td align="center" style="width:12%;" class="td1"><a id='lblCardno'> </a></td>
                <td align="center" style="width:8%;" class="td1"><a id='lblBdate'> </a></td>
                <td align="center" style="width:8%;" class="td1"><a id='lblEdate'> </a></td>
                <td align="center" style="width:12%;" class="td1"><a id='lblInsurancenum'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td >
                	<input id="txtCarno.*" type="text"   readonly="readonly" />
                	<input id="txtNoa.*" type="hidden"   readonly="readonly" />
                </td>
                <td ><input  id="txtInsurerno.*"  type="text"  readonly="readonly" style="width: 25%;"/>
                	<input  id="txtInsurer.*"  type="text"  readonly="readonly" style="width: 70%;"/></td>
                <td ><input id="txtCardno.*"  type="text"  readonly="readonly" /></td>
                <td ><input id="txtBdate.*"  type="text"   readonly="readonly" /></td>
                <td ><input id="txtEdate.*"  type="text"   readonly="readonly" /></td>
                <td ><input id="txtInsurancenum.*"  type="text"   readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
