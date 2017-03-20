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
            var q_name = 'vcca', t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'vcca1';
            t_postname = q_name;
            brwCount = -1;
			brwCount2 = -1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            
            function vcca_b() {}
			vcca_b.prototype = {
				isData : false,
				noa : null
			};
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
        		$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
                var tmp = location.href.split(';');
               
                for(x in tmp)
	                if(tmp[x].substring(0, 7).toUpperCase() == 'VCCANO='){ 
	                  	curVcca_b.isData=true;
	                  	curVcca_b.noa = tmp[x].substring(7).split(',');
	                }
            }

            function bbsAssign() {
                _bbsAssign();
				try{
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
				}catch(e){}
            }

            function q_gtPost() {

            }

            function refresh() {
                _refresh();
                
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
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
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px" ><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:120px;"><a id='lblNoa'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:100px;"><a>統編</a></td>
					<td align="center" style="width:120px;"><a>客戶</a></td>
					<td align="center" style="width:120px;"><a>買受人</a></td>
					<td align="center" style="width:100px;"><a>金額</a></td>
					<td align="center" style="width:100px;"><a>稅額</a></td>
					<td align="center" style="width:100px;"><a>金額</a></td>
					<td align="center" style="width:100px;"><a>備註</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:400px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:120px;"> </td>
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:120px;"> </td>
					<td align="center" style="width:120px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:100px;"> </td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:120px;"><input type="text" id="txtNoa.*" class="txt" style="width:95%;"/></td>
					<td style="width:80px;"><input type="text" id="txtDatea.*" class="txt" style="width:95%;"/></td>
					<td style="width:100px;"><input type="text" id="txtSerial.*" class="txt" style="width:95%;"/></td>
					<td style="width:120px;"><input type="text" id="txtComp.*" class="txt" style="width:95%;"/></td>
					<td style="width:120px;"><input type="text" id="txtBuyer.*" class="txt" style="width:95%;"/></td>
					<td style="width:100px;"><input type="text" id="txtMoney.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:100px;"><input type="text" id="txtTax.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:100px;"><input type="text" id="txtTotal.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:100px;"><input type="text" id="txtMemo.*" class="txt" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	
	</body>
</html>
