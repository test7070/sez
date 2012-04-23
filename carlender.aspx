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
            var q_name = 'carlender', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'carlender_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
            var decbbs = ['money', 'installment'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            //var bbmNum_comma = [];
            var bbsNum = [['txtMoney', 10, 0, 1], ['txtInstallment', 10, 0, 1]];
            //var bbsNum_comma = ['txtMoney'];
            var bbmMask = [];
            var bbsMask = [['txtBdate', '999/99/99'], ['txtEdate', '999/99/99']];
			aPop = [['txtLenderno_', 'btnLender_', 'lender', 'noa,comp', 'txtLenderno_,txtLender_', 'lender_b.aspx']];
			
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='098-KM'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
            }
			function mainPost(){
				q_cmbParse("cmbIsin" , q_getPara('sys.yn'), 's');  
			}
            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                _bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['lender']) {// Dont Save Condition
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
			.dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: 16px;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            td a {
                font-size: 14px;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:25%;"><a id='lblLender'></a></td>
					<td class="td3" align="center" style="width:9%;"><a id='lblBdate'></a></td>
					<td class="td4" align="center" style="width:9%;"><a id='lblEdate'></a></td>
					<td class="td5" align="center" style="width:9%;"><a id='lblMoney'></a></td>
					<td class="td6" align="center" style="width:9%;"><a id='lblInstallment'></a></td>
					<td class="td7" align="center" style="width:3%;"><a id='lblIsin'></a></td>
					<td class="td8" align="center" style="width:15%;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					<input class="txt" id="txtNoq.*" type="text" style="display:none;"   />
					</td>
					<td class="td2" style="width:3%;">
					<input class="txt"  id="txtLenderno.*" type="text" style="width:20%;"  />
					<input class="txt" id="txtLender.*" type="text" style="width:73%;"   />
					</td>
					<td class="td3">
					<input class="txt" id="txtBdate.*" type="text" style="width:95%; text-align: center;"  />
					</td>
					<td class="td4">
					<input class="txt" id="txtEdate.*" type="text" style="width:95%; text-align: center;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td6">
					<input class="txt" id="txtInstallment.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td7">
					<select id="cmbIsin.*" style="width:95%; text-align: center;"></select>
					</td>
					<td class="td8">
					<input class="txt" id="txtMemo.*" type="text" style="width:95%;"  />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
