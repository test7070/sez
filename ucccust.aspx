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
            var q_name = 'ucccust', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = [], t_count = 0, as, brwCount2 = 10;
            var t_sqlname = 'ucccust_load';
            t_postname = q_name;
            
            aPop = new Array(['txtCustno_', '', 'cust', 'noa,comp', 'txtCustno_,txtComp_', 'cust_b.aspx']	);
            
            var isBott = false; 
            var afield, t_htm;
            var i, s1;

            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtPrice',10,2,1]];
            var bbmMask = [];
            var bbsMask = [];
		
            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='A001'";
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
            	for (var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
            			$('#btnPackway_'+j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							var t_key = q_getHref();
							t_where = "noa='" + t_key[1] + "'";
							q_box("pack2_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'pack2', "95%", "95%", '包裝方式');
						});
					}
				}
                _bbsAssign();
                if(q_getPara('sys.isport')=='1') //外銷
                	$('.isport').show();
                else
                	$('.isport').hide();
            }

            function btnOk() {
                sum();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if(!as['custno']) {// Dont Save Condition
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
					case 'pack2':
						ret = getb_ret();
						if (ret != undefined) {
							$('#txtPackwayno_'+b_seq).val(ret[0].packway);
							$('#txtPackway_'+b_seq).val(ret[0].pack);
						}
						break;
				}
				b_pop = '';
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
					<td class="td1" align="center" style="width:1%; max-width:20px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td class="td2" align="center" style="width:10%;"><a id='lblCustno'> </a></td>
					<td class="td3" align="center" style="width:20%;"><a id='lblComp'> </a></td>
					<td class="td4" align="center" style="width:15%;"><a id='lblProductno'> </a></td>
					<td class="isport" align="center" style="width:10%;display: none;"><a id='lblPackwayno'> </a></td>
					<td class="isport" align="center" style="width:15%;display: none;"><a id='lblPackway'> </a></td>
					<!--<td class="td4" align="center" style="width:10%;"><a id='lblPrice'> </a></td>-->
					<td class="td5" align="center" ><a id='lblMemo'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  /><input id="txtNoq.*" type="hidden" />
					</td>
					<td class="td2"><input class="txt"  id="txtCustno.*" maxlength='30'type="text" style="width:95%;"  /></td>
					<td class="td3"><input class="txt" id="txtComp.*" type="text" maxlength='90' style="width:95%;"   /></td>
					<td class="td4"><input class="txt" id="txtProductno.*" type="text" style="width:95%;"  /></td>
					<td class="isport" style="display: none;">
						<input class="txt" id="txtPackwayno.*" type="text" style="width:65%;"  />
						<input class="btn" id="btnPackway.*" type="button" value='.' style=" font-weight: bold;"/>
					</td>
					<td class="isport" style="display: none;"><input class="txt" id="txtPackway.*" type="text" style="width:95%;"  /></td>
					<!--<td class="td4"><input class="txt" id="txtPrice.*" type="text" maxlength='10' style="text-align: right ;width:95%;"  /></td>-->
					<td class="td5"><input class="txt" id="txtMemo.*" type="text" maxlength='90' style="width:95%;"   /></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
