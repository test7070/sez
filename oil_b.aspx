<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src="../script/qj2.js" type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src="../script/qj_mess.js" type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
    	<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'oil', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 15;
            var t_sqlname = 'oil_load';
            t_postname = q_name;
            q_alias = 'a';
            var isBott = false; 

            var afield, t_htm;
            var i, s1;

            var decbbs = ['mount','price','money'];
            var decbbm = [];
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            //var bbmNum_comma = [];
            var bbsNum = [['txtMoney',10,0],['txtPrice',10,3],['txtMount',10,2]];
            //var bbsNum_comma = [];
            var bbmMask = [];
            var bbsMask = [['txtDatea', '999/99/99']];
			aPop = [['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea', 'txtDriverno_,txtDriver_', 'driver_b.aspx']];
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;a.noa='001-M9'";
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
                _bbsAssign('tbbs', bbsHtm, fbbs, '_', bbsMask, bbsNum, q_readonlys, 'btnPlus');
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['driver']) {// Dont Save Condition
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
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:20%;"><a id='lblDriver'></a></td>
					<td class="td3" align="center" style="width:5%;"><a id='lblOilstation'></a></td>
					<td class="td4" align="center" style="width:7%;"><a id='lblDatea'></a></td>
					<td class="td5" align="center" style="width:5%;"><a id='lblProduct'></a></td>
					<td class="td6" align="center" style="width:8%;"><a id='lblPrice'></a></td>
					<td class="td7" align="center" style="width:8%;"><a id='lblMount'></a></td>
					<td class="td8" align="center" style="width:12%;"><a id='lblMoney'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold;"  />
					</td>
					<td class="td2">
					<input class="txt"  id="txtDriverno.*" maxlength='30'type="text" style="width:40%;"  />
					<input class="txt"  id="txtDriver.*" maxlength='30'type="text" style="width:53%;"  />
					</td>
					<td class="td3">
					<input class="txt" id="txtOilstation.*" type="text" maxlength='90' style="width:95%; text-align: center;"   />
					</td>
					<td class="td4">
					<input class="txt" id="txtDatea.*" type="text" maxlength='10' style="width:95%; text-align: center;"  />
					</td>
					<td class="td5">
					<input class="txt" id="txtProduct.*" type="text" maxlength='10' style="width:95%; text-align: center;"  />
					</td>
					<td class="td6">
					<input class="txt" id="txtPrice.*" type="text" maxlength='10' style="width:95%; text-align: right;"  />
					</td>
					<td class="td7">
					<input class="txt" id="txtMount.*" type="text" maxlength='10' style="width:95%; text-align: right;"  />
					</td>
					<td class="td8">
					<input class="txt" id="txtMoney.*" type="text" maxlength='90' style="width:95%; text-align: right;"   />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
