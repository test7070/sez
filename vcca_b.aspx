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
            var q_name = 'vcca', t_bbsTag = 'tbbs', t_content = " field=noa,datea,mon,buyer,money,tax,total,memo,trdno ", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'vcca1';
            t_postname = q_name;
            brwCount2 = 0;
			q_bbsFit = 1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            
            function vcca_b() {}
			vcca_b.prototype = {
				isData : false,
				noa : null
			}
            curVcca_b = new  vcca_b();

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
                var tmp = location.href.split(';');
               
                for(x in tmp)
	                if(tmp[x].substring(0, 7).toUpperCase() == 'VCCANO='){ 
	                  	curVcca_b.isData=true;
	                  	curVcca_b.noa = tmp[x].substring(7).split(',');
	                }
            }

            function bbsAssign() {
                _bbsAssign();

                var isCheck = false;
                for(var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {      		
                    $('#chkSel_'+j).prop('checked',$('#txtTrdno_'+j).val().length>0);
                    if(curVcca_b.isData){
                    	isCheck = false;
                    	for(var k=0;k<curVcca_b.noa.length;k++){
                    		if($('#txtNoa_'+j).val()==curVcca_b.noa[k])
                    			isCheck = true;
                    	}
                    	$('#chkSel_'+j).prop('checked',isCheck);
                    }
                }
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
                background-color: #76a2fe;
            }
            tr.select input[type="text"] {
                color: red;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td class="td1" align="center" style="width:25px;">&nbsp;</td>
					<td class="td2" align="center" style="width:120px;"><a id='lblNoa'> </a></td>
					<td class="td3" align="center" style="width:80px;"><a id='lblDatea'> </a></td>
					<td class="td2" align="center" style="width:50px;"><a id='lblMon'> </a></td>
					<td class="td4" align="center" style="width:120px;"><a id='lblBuyer'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblPrice'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblTax'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblTotal'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>
						<input type="checkbox" id="chkSel.*"/>
						<input type="text" id="txtTrdno.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtNoa.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtDatea.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtMon.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtBuyer.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtMoney.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td><input type="text" id="txtTax.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td><input type="text" id="txtTotal.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td><input type="text" id="txtMemo.*" class="txt" style="width:95%;"/></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
