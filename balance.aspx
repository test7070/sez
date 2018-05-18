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
            var q_name = 'balance', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'balance_load';
            t_postname = q_name;
            var isBott = false;
            var afield, t_htm;
            var i, s1;
            var decbbs = ['money'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbmNum_comma = [];
            var bbsNum = [['txtMoney', 15, 0, 1]];
            var bbsNum_comma = [];
            var bbmMask = [];
            var bbsMask = [['txtGetdate', '999/99/99'], ['txtFdate', '999/99/99']];
			//aPop = [['txtCardealno_', 'btnCardeal_', 'cardeal', 'noa,comp', 'txtCardealno_,txtCardeal_', 'cardeal_b.aspx'],['txtLenderno_', 'btnLender_', 'lender', 'noa,comp', 'txtLenderno_,txtLender_', 'lender_b.aspx']];
			
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='A0254'";
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
			}
            function q_gtPost(t_name) {

            }

            function bbsAssign() {
            	for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
            		if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            			
					}
            	} //j
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['asset']) {// Dont Save Condition
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
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
		</script>
		<style type="text/css">
			.dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            td a {
                font-size: medium;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            input[type="text"],input[type="button"] {     
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:15%;"><a id='lblAsset'></a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblTypea'></a></td>
					<td class="td4" align="center" style="width:8%;"><a id='lblGetdate'></a></td>
					<td class="td5" align="center" style="width:10%;"><a id='lblMoney'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblFdate'></a></td>
					<td class="td7" align="center" ><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					<input class="txt" id="txtNoq.*" type="text" style="display:none;"   />
					</td>
					<td class="td2">
					<input class="txt" id="txtAsset.*" type="text" style="width:95%;"  />
					</td>
					<td class="td3">
					<input class="txt" id="txtTypea.*" type="text" style="width:95%;"  />
					</td>
					<td class="td4">
					<input class="txt" id="txtGetdate.*" type="text" style="width:95%;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;" />
					</td>
					<td class="td6">
					<input class="txt" id="txtFdate.*" type="text" style="width:95%;" />
					</td>
					<td class="td7">
					<input class="txt" id="txtMemo.*" type="text" style="width:95%;"  />
					</td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
