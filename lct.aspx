<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
            var q_name = 'lct', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'lct_load';
            t_postname = q_name;
            var isBott = false;

            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtPay', 15, 0, 1],['txtInterest', 15, 0, 1],['txtFloata', 15, 4, 1]];
            var bbmMask = [];
            var bbsMask = [];

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;1=1 order by noq desc";
                    return;
                }
                if(!q_paraChk())
                    return;
				
				brwCount2 = 12;
            	brwCount = 10;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                bbsMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                
            }

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                for(var i = 0; i < q_bbsCount; i++) {
                }
                _bbsAssign();
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0],bbsKey[1],'', 2);
            }

            function bbsSave(as) {
                if(!as['datea'] && !as['pay'] && !as['interest']) {// Dont Save Condition
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td class="td2" align="center" style="width:20%;"><a id='lblDatea'> </a></td>
					<td class="td8" align="center" style="width:40%;"><a id='lblPay'> </a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblInterest'> </a></td>
					<td class="td4" align="center" style="width:15%;"><a id='lblFloata'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt" id="txtNoa.*" type="hidden"/>
						<input class="txt" id="txtNoq.*" type="hidden"/>
					</td>
					<td class="td2"><input class="txt" id="txtDatea.*" type="text" style="width:95%; text-align: center;"  /></td>
					<td class="td8"><input class="txt" id="txtPay.*" type="text" style="width:95%; text-align:right;"   /></td>
					<td class="td3"><input class="txt" id="txtInterest.*" type="text" style="width:95%; text-align:right;"  /></td>
					<td class="td4"><input class="txt" id="txtFloata.*" type="text" style="width:95%; text-align:right"  /></td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
