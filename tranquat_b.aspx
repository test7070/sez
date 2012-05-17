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
            var q_name = 'tranquats', t_bbsTag = 'tbbs', 
                t_content = " field=noa,noq,stype,datea,cno,acomp,custno,cust,productno,product,straddrno,straddr,endaddrno,endaddr,mount,unit,price,memo  order=b.datea,a.noa,a.noq ", afilter = [], bbsKey = ['noa', 'noq'], as;
            //, t_where = '';
            var t_sqlname = 'tranquat_load2';
            t_postname = q_name;
            brwCount2 = 12;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;

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
            function mainPost() {
                q_cmbParse("cmbStype", q_getPara('vcc.stype'), 's');
            }

            function bbsAssign() {
                _bbsAssign();
            }

            function q_gtPost() {
            	
            }

            function refresh() {
                _refresh();
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color:  #76a2fe;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:1%;">&nbsp;</td>
					<td class="td2" align="center" style="width:10%;"><a id='lblNoa'></a></td>
					<td class="td3" align="center" style="width:4%;"><a id='lblStype'></a></td>
					<td class="td4" align="center" style="width:5%;"><a id='lblDatea'></a></td>
					<td class="td5" align="center" style="width:5%;"><a id='lblAcomp'></a></td>
					<td class="td6" align="center" style="width:10%;"><a id='lblProduct'></a></td>
					<td class="td7" align="center" style="width:7%;"><a id='lblStraddr'></a></td>
					<td class="td8" align="center" style="width:7%;"><a id='lblEndaddr'></a></td>
					<td class="td9" align="center" style="width:5%;"><a id='lblMount'></a></td>
					<td class="tdA" align="center" style="width:3%;"><a id='lblUnit'></a></td>
					<td class="tdB" align="center" style="width:5%;"><a id='lblPrice'></a></td>
					<td class="tdC" align="center" style="width:10%;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td class="td1"><input class="chk"  id="chkSel.*" type="checkbox"/></td>
					<td class="td2"><input class="txt"  id="txtNoa.*" type="text" style="width:80%;" /><input class="txt"  id="txtNoq.*" type="text" style="width:15%;" /></td>
					<td class="td3"><select id="cmbStype.*" style="width:95%;"></select></td>
					<td class="td4"><input class="txt"  id="txtDatea.*" type="text" style="width:95%;" /></td>
					<td class="td5"><input class="txt"  id="txtAcomp.*" type="text" style="width:95%;" /></td>
					<td class="td6"><input class="txt"  id="txtProductno.*" type="text" style="width:25%;" /><input class="txt"  id="txtProduct.*" type="text" style="width:70%;" /></td>
					<td class="td7"><input class="txt"  id="txtStraddr.*" type="text" style="width:95%;" /></td>
					<td class="td8"><input class="txt"  id="txtEndaddr.*" type="text" style="width:95%;" /></td>
					<td class="td9"><input class="txt"  id="txtMount.*" type="text" style="width:95%;" /></td>
					<td class="tdA"><input class="txt"  id="txtUnit.*" type="text" style="width:95%;" /></td>
					<td class="tdB"><input class="txt"  id="txtPrice.*" type="text" style="width:95%;" /></td>
					<td class="tdC"><input class="txt"  id="txtMemo.*" type="text" style="width:95%;" /></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
