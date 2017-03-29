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
			q_bbsFit = 1;
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
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
            }

            function mainPost() {
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
					<td class="td2" align="center" style="width:120px;"><a id='lblNoa'></a></td>
					<td class="td3" align="center" style="width:80px;"><a id='lblDatea'></a></td>
					<td class="td3" align="center" style="width:80px;"><a id='lblCarteamno'>車隊</a></td>
					<td class="td2" align="center" style="width:120px;"><a id='lblPlusitem'></a></td>
					<td class="td4" align="center" style="width:100px;"><a id='lblPlusmoney'></a></td>
					<td class="td5" align="center" style="width:120px;"><a id='lblMinusitem'></a></td>
					<td class="td6" align="center" style="width:100px;"><a id='lblMinusmoney'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td>
						<input type="checkbox" id="chkSel.*"/>
						<input type="text" id="txtTrdno.*" style="display:none;"/>
					</td>
					<td><input type="text" id="txtNoa.*" class="txt" style="width:95%;"/></td>
					<td><input type="text" id="txtDatea.*" class="txt" style="width:95%;"/></td>
					<td>
						<input type="text" id="txtCarteamno.*" class="txt" style="display:none;"/>
						<input type="text" id="txtCarteam.*" class="txt" style="width:95%;"/>
					</td>
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
