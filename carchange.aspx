<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery-1.6.1.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'carchange', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'carchange_load';
            t_postname = q_name;
            q_alias = 'a';
            var isBott = false; 

            var afield, t_htm;
            var i, s1;

            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [['txtChgdate', '999/99/99'],['txtStopdate', '999/99/99'],['txtEnddate', '999/99/99'],['txtDatea', '999/99/99'],['txtWastedate','999/99/99'],['txtCanceldate','999/99/99']];
		
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

            function q_gtPost(t_name) {

            }

            function bbsAssign() {
                _bbsAssign();//_bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:1086px'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:36px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:103px;"><a id='lblCarno'></a></td>
					<td class="td3" align="center" style="width:103px;"><a id='lblOldcarno'></a></td>
					<td class="td4" align="center" style="width:103px;"><a id='lblChgdate'></a></td>
					<td class="td5" align="center" style="width:103px;"><a id='lblStopdate'></a></td>
					<td class="td6" align="center" style="width:103px;"><a id='lblEnddate'></a></td>
					<td class="td7" align="center" style="width:104px;"><a id='lblWastedate'></a></td>
					<td class="td8" align="center" style="width:104px;"><a id='lblCanceldate'></a></td>
					<td class="td9" align="center" style="width:104px;"><a id='lblDatea'></a></td>
					<td class="td10" align="center" style="width:208px;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td2">
					<input class="txt"  id="txtCarno.*" maxlength='30'type="text" style="width:95%;"  />
					</td>
					<td class="td3">
					<input class="txt" id="txtOldcarno.*" type="text" maxlength='90' style="width:95%;"   />
					</td>
					<td class="td4">
					<input class="txt" id="txtChgdate.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtStopdate.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td6">
					<input class="txt" id="txtEnddate.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td7">
					<input class="txt" id="txtWastedate.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td8">
					<input class="txt" id="txtCanceldate.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td9">
					<input class="txt" id="txtDatea.*" type="text" maxlength='10' style="width:95%;"  />
					</td>
					<td class="td10">
					<input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:95%;"   />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
