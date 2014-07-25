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
		    var q_name = 'packing', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
		    var t_sqlname = 'packing_load'; t_postname = q_name;
		    var isBott = false;
		    var afield, t_htm;
		    var i, s1;
		    var q_readonly = [];
		    var q_readonlys = [];
		    var bbmNum = [];
		    var bbsNum = [['txtDime', 15, 2, 1],['txtWidth', 15, 2, 1],['txtHeight', 15, 2, 1],
					      ['txtMount', 15, 0, 1],['txtPrice', 15, 2, 1],['txtWeight', 15, 2, 1],['txtGweight', 15, 2, 1]];
		    var bbmMask = [];
		    var bbsMask = [];
            aPop = new Array(
            	['txtProductno_', '', 'ucaucc', 'noa,product,spec', 'txtProductno_,txtProduct_,txtSpec_', 'ucaucc_b.aspx']
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
		        
		        var t_key = q_getHref();
		        t_where="where=^^ noa=(select top 1 noa from view_vcc where invo='"+t_key[1]+"' order by datea desc)^^";
                q_gt('view_vccs', t_where, 0, 0, 0, "", r_accy);
			}
		
		    function bbsAssign() {
		    		for(var j = 0; j < q_bbsCount; j++) {
		            	if (!$('#btnMinus_' + j).hasClass('isAssign')) {
		            		$('#txtNo2_'+j).change(function() {
		            			t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
			                    q_bodyId($(this).attr('id'));
			                    b_seq = t_IdSeq;
			                    
			                     for(var j = 0; j < vccs.length; j++) {
			                     	if(vccs[j].no2==$('#txtNo2_'+b_seq).val()){
			                     		$('#txtUno_'+b_seq).val(vccs[j].uno);
			                     		$('#txtProductno_'+b_seq).val(vccs[j].productno);
			                     		$('#txtProduct_'+b_seq).val(vccs[j].product);
			                     		$('#txtSpec_'+b_seq).val(vccs[j].spec);
			                     		$('#txtSize_'+b_seq).val(vccs[j].size);
			                     		$('#txtDime_'+b_seq).val(vccs[j].dime);
			                     		$('#txtWidth_'+b_seq).val(vccs[j].width);
			                     		$('#txtHeight_'+b_seq).val(vccs[j].lengthb);
			                     		$('#txtMount_'+b_seq).val(vccs[j].mount);
			                     		$('#txtWeight_'+b_seq).val(vccs[j].weight);
			                     		$('#txtPrice_'+b_seq).val(vccs[j].price);
			                     		$('#txtMemo_'+b_seq).val(vccs[j].memo);
			                     		break;	
			                     	}
			                     }
							});
						}
					}
		        _bbsAssign();
		        /*for(var j = 0; j < q_bbsCount; j++) {
		    		$('#lblNo_' + j).text(j + 1);
				}*/
		    }
		    
		    function q_boxClose(s2) { ///   q_boxClose 2/4 
				var ret;
				switch (b_pop) { 
					
				}   /// end Switch
				b_pop = '';
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

		    function refresh() {
		        _refresh();
		    }
		    
		    var vccs;
		    function q_gtPost(t_name) {
				switch (t_name) {
					case 'vccs':
						vcces=_q_appendData("vccs", "", true);
						break;
				}  /// end switch
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
		    
		    function q_popPost(s1) {
		    	switch (s1) {
			        
		    	}
			}
		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
            .txt{
            	float:left;
            	width:98%;
            }
            .num{
            	text-align: right;
            }
		</style>
	</head>
	<body>
		<div id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:120%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%; max-width:20px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td class="td2" align="center" style="width:1%;"><a id='lblNo_s'> </a></td>
					<td class="td3" align="center" style="width:10%;"><a id='lblUno_s'> </a></td>
					<td class="td4" align="center" style="width:10%;"><a id='lblProductno_s'> </a> /<a id='lblProduct_s'> </a></td>
					<td class="td5" align="center" style="width:8%;"><a id='lblSpec_s'> </a></td>
					<td class="td6" align="center" style="width:12%;"><a id='lblSize_s'> </a></td>
					<td class="td7" align="center" style="width:7%;"><a id='lblDime_s'> </a></td>
					<td class="td8" align="center" style="width:7%;"><a id='lblWidth_s'> </a></td>
					<td class="td9" align="center" style="width:7%;"><a id='lblHeight_s'> </a></td>
					<td class="td10" align="center" style="width:7%;"><a id='lblMount_s'> </a></td>
					<td class="td11" align="center" style="width:7%;"><a id='lblNweight_s'> </a></td>
					<td class="td11" align="center" style="width:7%;"><a id='lblGweight_s'> </a></td>
					<td class="td12" align="center" style="width:7%;"><a id='lblPrice_s'> </a></td>
					<td class="td13" align="center"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    	<input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td2" style="text-align: center;">
						<!--<a id='lblNo.*'> </a>-->
						<input class="txt" id="txtNo2.*" type="text" />
					</td>
					<td class="td3"><input class="txt" id="txtUno.*" type="text" /></td>
					<td class="td4">
						<input class="txt" id="txtProductno.*" type="text" />
						<input class="txt" id="txtProduct.*" type="text" />
					</td>
					<td class="td5"><input class="txt" id="txtSpec.*" type="text" /></td>
					<td class="td6"><input class="txt" id="txtSize.*" type="text" /></td>
					<td class="td7"><input class="txt num" id="txtDime.*" type="text" /></td>
					<td class="td8"><input class="txt num" id="txtWidth.*" type="text" /></td>
					<td class="td9"><input class="txt num" id="txtHeight.*" type="text" /></td>
					<td class="td10"><input class="txt num" id="txtMount.*" type="text" /></td>
					<td class="td11"><input class="txt num" id="txtWeight.*" type="text" /></td>
					<td class="td11"><input class="txt num" id="txtGweight.*" type="text" /></td>
					<td class="td12"><input class="txt num" id="txtPrice.*" type="text" /></td>
					<td class="td13"><input class="txt" id="txtMemo.*" type="text" /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
