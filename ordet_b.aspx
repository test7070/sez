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
		    var q_name = 'ordet', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
		    var t_sqlname = 'ordet_load'; t_postname = q_name;
		    var isBott = false;
		    var afield, t_htm;
		    var i, s1;
		    var q_readonly = [];
		    var q_readonlys = [];
		    var bbmNum = [];
		    var bbsNum = [['txtDime', 10, 0, 1],['txtWidth', 10, 0, 1],['txtLengthb', 10, 0, 1],['txtMount', 10, 0, 1],['txtWeight', 10, 0, 1]];
		    var bbmMask = [];
		    var bbsMask = [];
		    var aPop = new Array(
		    				['txtUno_', 'btnUno_', 'uccc', 'uno', 'txtUno_', 'uccc_seek_b.aspx','95%','60%'],
		    				['txtProductno_', 'btnProductno_', 'assignproduct', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
		    				);
		    $(document).ready(function () {
		        bbmKey = [];
		        bbsKey = ['noa', 'no2'];
		        if (location.href.indexOf('?') < 0)   // debug
		        {
		            location.href = location.href + "?;;;noa='0015'";
		            return;
		        }
		        if (!q_paraChk())
		            return;
		
		        main();
		    });            /// end ready
		
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
		
		    }
		    
		    function mainPost() {
				q_getFormat();
				bbsMask = [];
		        q_mask(bbsMask);
			}
		
		    function bbsAssign() {
		        _bbsAssign();
		    }

			function q_gtPost(t_name) {

            }
            
		    function btnOk() {
		        t_key = q_getHref();
		
		        _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);  // (key_value, bbmKey[0], bbsKey[1], '', 2);
		    }
		
		    function bbsSave(as) {
		        if (!as['productno']) {  // Dont Save Condition
		            as[bbsKey[0]] = '';   /// noa  empty --> dont save
		            return;
		        }
		
		        q_getId2('', as);  // write keys to as
		
		        return true;
		
		    }
		
		    function btnModi() {
		        var t_key = q_getHref();
		
		        if (!t_key)
		            return;
		
		        _btnModi(1);
		    }
		
		    function boxStore() {
		
		    }
		    function refresh() {
		        _refresh();
		    }
		
		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		    }
		
		    function btnMinus(id) {
		        _btnMinus(id);
		    }
		
		    function btnPlus(org_htm, dest_tag, afield) {
		        _btnPlus(org_htm, dest_tag, afield);
		        if (q_tables == 's')
		            bbsAssign();
		    }
		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div id="dbbs">
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />

					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:15%;"><a id='lblUno_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblProduct_s'></a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_s'></a></td>
					<td class="td5" align="center" style="width:10%;"><a id='lblDime_s'></a></td>
					<td class="td6" align="center" style="width:10%;"><a id='lblWidth_s'></a></td>
					<td class="td7" align="center" style="width:10%;"><a id='lblLengthb_s'></a></td>
					<td class="td8" align="center" style="width:10%;"><a id='lblMount_s'></a></td>
					<td class="td9" align="center" style="width:10%;"><a id='lblWeight_s'></a></td>
					<td class="td10" align="center" style="width:10%;"><a id='lblSource_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
						<input class="txt c1" id="txtUno.*" type="text" style="width:80%;" />
                		<input class="btn" id="btnUno.*" type="button" value='.' style="width:1%;"/>
					</td>
					<td class="td3">
						<input class="txt" id="txtProduct.*" type="text" style="width:85%;"  />
						<input type="button" id="btnProductno.*" value="." style="width:10%;">
					</td>
					<td class="td4">
						<input class="txt" id="txtProductno.*" type="text" style="width:95%;"  />
					</td>
					<td class="td5">
						<input class="txt" id="txtDime.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td6">
						<input class="txt" id="txtWidth.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td7">
						<input class="txt" id="txtLengthb.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td8">
						<input class="txt" id="txtMount.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td9">
						<input class="txt" id="txtWeight.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td10">
						<input class="txt" id="txtSource.*" type="text" style="width:95%;"  />
					</td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
