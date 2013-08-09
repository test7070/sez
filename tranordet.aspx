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
            var q_name = 'tranordet', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa','noq'], as;
            var t_sqlname = 'tranordet_load';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtWeight2',12 , 3, 1],['txtTrannumber',12 , 0, 1]];
            var bbmMask = [];
            var bbsMask = [['txtDatea', '999/99/99']];
			var brwCount2 = 15;
			var brwKey = 'noa';
            $(document).ready(function() {
                if(!q_paraChk())
                    return;
                main();
            });
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
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
                if(!as['datea']) {// Dont Save Condition
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
            
            function btnModi(){
            	if(window.parent.q_cur==0){
            		$('#btnOk')[0].style.visibility='hidden';
            		return;
            	}else{
            		_btnModi()
            	}
            }
            
            function returnparent() {
            	if(window.parent.q_name=='tranorde' && window.parent.q_cur!=0){
				 	var wParent = window.parent.document;
				 	var total_weight = 0;
				 	var total_trannumber = 0;
				 	for(var i = 0;i < q_bbsCount;i++){
				 		total_weight += dec($('#txtWeight2_' + i).val());
				 		total_trannumber += dec($('#txtTrannumber_' + i).val());
				 	}
				 	wParent.getElementById("txtTweight2").value=total_weight;
				 	wParent.getElementById("txtTtrannumber").value=total_trannumber;
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
            }
            .c1{
            	width:95%;
            }
            .num{
            	text-align:right;
            }
		</style>
	</head>
	<body onunload='returnparent();'>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    <input id="txtNoq.*" type="hidden" />

					<td class="td1" align="center" style="width:1%; max-width:20px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td class="td2" align="center" style="width:20%;"><a id='lblDatea_s'></a></td>
					<td class="td8" align="center" style="width:40%;"><a id='lblWeight2_s'></a></td>
					<td class="td8" align="center" style="width:40%;"><a id='lblTrannumber_s'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1" align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
					</td>
					<td class="td2">
					<input class="txt c1" id="txtDatea.*" type="text" />
					</td>
					<td class="td3">
					<input class="txt c1 num" id="txtWeight2.*" type="text"/>
					</td>
					<td class="td4">
					<input class="txt c1 num" id="txtTrannumber.*" type="text"/>
					</td>
				</tr>
			</table>
			
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
