<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = 'custchg', t_bbsTag = 'tbbs', t_content = "", afilter = [], bbsKey = ['noa'], as;
            //, t_where = '';
            var t_sqlname = 'custchg';
            t_postname = q_name;
            brwCount2 = 50;
			brwCount = -1;
			brwCount2 = -1;
			
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            
            function custchg_b() {}
			custchg_b.prototype = {
				isData : false,
				noa : null
			};
            curCustchg_b = new  custchg_b();
			var t_carteam = new Array();
            $(document).ready(function() {
                if(!q_paraChk())
                    return;
                q_gt('carteam', '', 0, 0, 0, "");    
                
            });

            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, 'order=^^ datea desc,noa desc^^', t_sqlname, t_postname, r_accy);
            }

            function mainPost() {
            	$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
				
                var tmp = location.href.split(';');
               	
                for(x in tmp)
	                if(tmp[x].substring(0, 10).toUpperCase() == 'CUSTCHGNO='){ 
	                  	curCustchg_b.isData=true;
	                  	curCustchg_b.noa = tmp[x].substring(10).split(',');
	                }
                
            }

            function bbsAssign() {
                _bbsAssign();

                var isCheck = false;
                for(var j = 0; j < (q_bbsCount == 0 ? 1 : q_bbsCount); j++) {      		
                    $('#chkSel_'+j).prop('checked',$('#txtTrdno_'+j).val().length>0);
                    if(curCustchg_b.isData){
                    	isCheck = false;
                    	for(var k=0;k<curCustchg_b.noa.length;k++){
                    		if($('#txtNoa_'+j).val()==curCustchg_b.noa[k])
                    			isCheck = true;
                    	}
                    	$('#chkSel_'+j).prop('checked',isCheck);
                    }
                    
                    for(var i=0;i<t_carteam.length;i++){
                    	if($('#txtCarteamno_'+j).val()==t_carteam[i].noa){
                    		$('#txtCarteam_'+j).val(t_carteam[i].team);
                    		break;
                    	}
                    }
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'carteam':
						var as = _q_appendData("carteam", "", true);
						t_carteam = new Array();
						if(as[0]!=undefined){
    						for ( i = 0; i < as.length; i++) {
    							t_carteam.push({noa:as[i].noa ,team:as[i].team});
    						}
						}
						main();
						break;
                    default:
                        break;
                } 
            }

            function refresh() {
                _refresh();
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text(i+1);
				}
            }

		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<th align="center" style="width:25px;max-width: 25px;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:30px;max-width: 30px;"><a>　</a></td>
					<td align="center" style="width:120px;max-width: 120px;"><a id='lblNoa'> </a></td>
					<td align="center" style="width:80px;max-width: 80px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:80px;max-width: 80px;"><a id='lblCarteamno'>車隊</a></td>
					<td align="center" style="width:120px;max-width: 120px;"><a id='lblPlusitem'> </a></td>
					<td align="center" style="width:100px;max-width: 100px;"><a id='lblPlusmoney'> </a></td>
					<td align="center" style="width:120px;max-width: 120px;"><a id='lblMinusitem'> </a></td>
					<td align="center" style="width:100px;max-width: 100px;"><a id='lblMinusmoney'> </a></td>
					<td align="center" style="width:100px;max-width: 100px;"><a id='lblMemo'>備註</a></td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<th align="center" style="width:25px;max-width: 25px;"> </th>
					<td align="center" style="width:30px;max-width: 30px;"> </td>
					<td align="center" style="width:120px;max-width: 120px;"> </td>
					<td align="center" style="width:80px;max-width: 80px;"> </td>
					<td align="center" style="width:80px;max-width: 80px;"> </td>
					<td align="center" style="width:120px;max-width: 120px;"> </td>
					<td align="center" style="width:100px;max-width: 100px;"> </td>
					<td align="center" style="width:120px;max-width: 120px;"> </td>
					<td align="center" style="width:100px;max-width: 100px;"> </td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:25px;max-width: 25px;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:30px;max-width: 30px;">
						<a id="lblNo.*" style="font-weight: bold;" readonly="readonly"> </a>
						<input type="text" id="txtTrdno.*" style="display:none;"/>					
					</td>
					<td style="width:120px;max-width: 120px;"><input id="txtNoa.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtDatea.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:80px;max-width: 80px;"><input id="txtCarteamno.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:120px;max-width: 120px;"><input id="txtPlusitem.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:100px;max-width: 100px;"><input id="txtPlusmoney.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:120px;max-width: 120px;"><input id="txtMinusitem.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:100px;max-width: 100px;"><input id="txtMinusmoney.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
					<td style="width:100px;max-width: 100px;"><input id="txtMemo.*" type="text" style="float:left;width:95%;"  readonly="readonly" /></td>
				</tr>
			</table>
		</div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>
