<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			// TRD只能匯入一張VCCA
			// VCCA能匯入多張TRD
            var q_name = "vcca2trd", t_content = "where=^^['')^^", bbsKey = ['noa','noq'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
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
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            	t_content = "where=^^['"+t_para.project+"','"+t_para.custno+"','"+t_para.vccano+"','"+t_para.trdno+"')^^";
	            }catch(e){
	            }    
                brwCount = -1;
                mainBrow(0, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						abbs = _q_appendData(q_name, "", true);
						//refresh();
						break;
				}
			}
			var maxAbbsCount = 0;
            function refresh() {
            	//ref ordest_b.aspx
				var w = window.parent;
				
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						if(w.$('#txtVccano').val()==abbs[i].noa){
							abbs[i]['sel'] = "true";
							$('#chkSel_' + abbs[i].rec).attr('checked', true);
						}
					}
					maxAbbsCount = abbs.length;
				}
				_refresh();
				q_bbsCount = abbs.length;

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
					<td align="center" style="width:25px" ><!--<input type="checkbox" id="checkAllCheckbox"/>--></td>
					<td align="center" style="width:25px;"> </td>
					<td align="center" style="width:120px;"><a id='lblNoa'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:100px;"><a>統編</a></td>
					<td align="center" style="width:120px;"><a>客戶</a></td>
					<td align="center" style="width:120px;"><a>買受人</a></td>
					<td align="center" style="width:100px;"><a>金額</a></td>
					<td align="center" style="width:80px;"><a>稅額</a></td>
					<td align="center" style="width:100px;"><a>金額</a></td>
					<td align="center" style="width:100px;"><a>備註</a></td>
					<td align="center" style="width:80px;"><a>已立帳<br>稅額</a></td>
					<td align="center" style="width:80px;"><a>未立帳<br>稅額</a></td>
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
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:100px;"> </td>
					<td align="center" style="width:80px;"> </td>
					<td align="center" style="width:80px;"> </td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:120px;"><input type="text" id="txtNoa.*" class="txt" style="width:95%;"/></td>
					<td style="width:80px;"><input type="text" id="txtDatea.*" class="txt" style="width:95%;"/></td>
					<td style="width:100px;"><input type="text" id="txtSerial.*" class="txt" style="width:95%;"/></td>
					<td style="width:120px;"><input type="text" id="txtCust.*" class="txt" style="width:95%;"/></td>
					<td style="width:120px;"><input type="text" id="txtBuyer.*" class="txt" style="width:95%;"/></td>
					<td style="width:100px;"><input type="text" id="txtMoney.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:80px;"><input type="text" id="txtTax.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:100px;"><input type="text" id="txtTotal.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:100px;"><input type="text" id="txtMemo.*" class="txt" style="width:95%;"/></td>
					<td style="width:80px;"><input type="text" id="txtTax2.*" class="txt" style="width:95%; text-align: right;"/></td>
					<td style="width:80px;"><input type="text" id="txtTax3.*" class="txt" style="width:95%; text-align: right;"/></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	
	</body>
</html>
