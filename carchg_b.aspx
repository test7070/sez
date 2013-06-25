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
            var q_name = 'carchg', t_bbsTag = 'tbbs', t_content = " field=noa,datea,plusitem,plusmoney,minusitem,minusmoney,treno ", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'carchg';
            t_postname = q_name;
            brwCount2 = 50;
			q_bbsFit = 1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            
            function carchg_b() {}
			carchg_b.prototype = {
				isData : false,
				noa : null
			}
            curCarchg_b = new carchg_b();

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
				$('#chkAllCheckbox').click(function(){
					$('input[type=checkbox][id^=chkSel]').attr('checked',$('#chkAllCheckbox').is(':checked'));
				});
                
            }

            function mainPost() {
                var tmp = location.href.split(';');         
                for(x in tmp){
	                if(tmp[x].substring(0, 9).toUpperCase() == 'CARCHGNO='){ 
	                  	curCarchg_b.isData=true;
	                  	curCarchg_b.noa = tmp[x].substring(9).split(',');
	                }
	             }
            }

            function bbsAssign() {
                _bbsAssign();

                var isCheck = false;
                for(var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {      		
                    $('#chkSel_'+j).prop('checked',$('#txtTreno_'+j).val().length>0);
                    if(curCarchg_b.isData){
                    	isCheck = false;
                    	for(var k=0;k<curCarchg_b.noa.length;k++){
                    		if($('#txtNoa_'+j).val()==curCarchg_b.noa[k])
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
					<td class="td1" align="center" style="width:25px;">
						<input type="checkbox" id="chkAllCheckbox"/>
					</td>
					<td class="td2" align="center" style="width:120px;"><a id='lblNoa'></a></td>
					<td class="td3" align="center" style="width:80px;"><a id='lblDatea'></a></td>
					<td class="td2" align="center" style="width:120px;"><a id='lblPlusitem'></a></td>
					<td class="td4" align="center" style="width:100px;"><a id='lblPlusmoney'></a></td>
					<td class="td5" align="center" style="width:120px;"><a id='lblMinusitem'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblMinusmoney'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input type="checkbox" id="chkSel.*"/>
						<input type="text" id="txtTreno.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtNoa.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtDatea.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtPlusitem.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtPlusmoney.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtMinusitem.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtMinusmoney.*" class="txt" style="width:95%;"/></td>
				</tr>
			</table>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
