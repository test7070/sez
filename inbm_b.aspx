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
		    var q_name = 'inbm', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
		    var t_sqlname = 'inbm_load'; t_postname = q_name;
		    var isBott = false;
		    var afield, t_htm;
		    var i, s1;
		    var q_readonly = [];
		    var q_readonlys = [];
		    var bbmNum = [];
		    var bbsNum = [['txtWeight', 10, 2, 1],['txtPrice', 10, 2, 1],['txtMoney', 10, 2, 1]];
		    var bbmMask = [];
		    var bbsMask = [];
            aPop = new Array(
            	['txtProductno_', 'btnProductno_', 'ucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucc_b.aspx']
			);
		
		    $(document).ready(function () {
		        bbmKey = [];
		        bbsKey = ['noa', 'noq'];
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
		    		for(var j = 0; j < q_bbsCount; j++) {
		            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
		            		$('#txtWeight_' + j).change(function(){
		            			var b_seq = $(this).attr('id').split('_')[1];
		            			var weight = q_float('txtWeight_' + b_seq);
		            			var price = q_float('txtPrice_' + b_seq);
		            			$('#txtMoney_' + b_seq).val((weight*price));
		            		});
		            		$('#txtPrice_' + j).change(function(){
		            			var b_seq = $(this).attr('id').split('_')[1];
		            			var weight = q_float('txtWeight_' + b_seq);
		            			var price = q_float('txtPrice_' + b_seq);
		            			$('#txtMoney_' + b_seq).val((weight*price));
		            		});
						}
					}
		        _bbsAssign();
		    }
		
		    function btnOk() {
		        sum();
		
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
		    function sum() { }
		
		    function q_gtPost(t_postname) {
		
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
		<div id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />

					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:30%;"><a id='lblProduct_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblGweight_s'></a></td>
					<td class="td3" align="center" style="width:15%;"><a id='lblWeight_s'></a></td>
					<td class="td4" align="center" style="width:20%;"><a id='lblPrice_s'></a></td>
					<td class="td5" align="center" style="width:20%;"><a id='lblMoney_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
                        <input type="text" id="txtProductno.*"  style="width:30%; float:left;"/>
                        <span style="display:block; width:1%;float:left;"> </span>
						<input type="text" id="txtProduct.*"  class="txt" style="width:60%;"/>
						<input class="btn"  id="btnProductno.*" type="button" value='.' style="width:1%;" />
					</td>
					<td class="td3">
						<input class="txt" id="txtGweight.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td3">
						<input class="txt" id="txtWeight.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td4">
						<input class="txt" id="txtPrice.*" type="text" style="width:95%; text-align: right;"  />
					</td>
					<td class="td5">
						<input class="txt" id="txtMoney.*" type="text" style="width:95%; text-align: right;"  />
					</td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
