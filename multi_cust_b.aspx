<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = "cust", t_content = "", bbsKey = ['noa'], as;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
       		brwCount = -1;
			brwCount2 = -1;
            $(document).ready(function() {
                main();
            });
			
			var _custno = new Array();
			var _condition = "";
			var _first = true;
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                $('#btnSearch').click(function() {
					var custno = new Array();
					for(var i=0;i<q_bbsCount;i++){
						if($('#chkSel_'+i).prop('checked')){
							custno.push($('#txtNoa_'+i).val());
						}
					}
					var condition = $.trim($('#txtCondition').val());
					var item = JSON.stringify({custno:custno,condition:condition});
					
					//+ ";" + r_name + ";" + q_time + ";" + "" +";"+";"+JSON.stringify({ordcno:t_ordcno,kind:t_kind,tggno:t_tggno,page:'ordc_rk'})
					//location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+item+";"+r_accy;
					location.href = "http://"+location.host +location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+item+";"+r_accy+";"+JSON.stringify({custno:custno,condition:condition});
				});
				
				t_content = "";
                var t_para = new Array();
                _custno = new Array();
				_condition = "";
	            try{
	            	t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
	            		if(t_para.custno!=undefined && t_para.custno.length>0){
	            			_custno = t_para.custno;
	            			t_content = " 1=0 ";
	            			for(var i=0;i<t_para.custno.length;i++){
	            				t_content += " or noa='"+t_para.custno[i]+"'";
	            			}
	            		}
	            		if(t_para.condition!=undefined && t_para.condition.length>0){
	            			_condition = t_para.condition;
	            			t_content = t_content.length==0?"1=0":t_content;
	            			t_content += " or charindex('"+t_para.condition+"',noa)>0";
	            			t_content += " or charindex('"+t_para.condition+"',comp)>0";
	            			t_content += " or charindex('"+t_para.condition+"',nick)>0";
	            			t_content += " or charindex('"+t_para.condition+"',serial)>0";
	            			t_content += " or charindex('"+t_para.condition+"',tel)>0";
	            			t_content += " or charindex('"+t_para.condition+"',fax)>0";
	            			t_content += " or charindex('"+t_para.condition+"',memo)>0";
	            		}
	            }catch(e){
	            }    
	            t_content = "where=^^"+t_content+"^^";
                brwCount = -1;
                brwCount2 = 500;  //避免讀太久
                mainBrow(6, t_content);
            }
			function mainPost() {
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
				
				$('#checkAllCheckbox').click(function(e){
					$('.ccheck').prop('checked',$(this).prop('checked'));
				});
			}
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						if(!_first){
							abbs = _q_appendData(q_name, "", true);
						}else{
							_first = false;
						}
						refresh();
						break;
				}
			}
			function bbsAssign() { 
                for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
                    if($('#chkSel_' + i).hasClass('isAssign'))
                    	continue;
                	$('#chkSel_' + i).addClass('isAssign');
                    $('#txtNoa_'+i).bind('contextmenu',function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        var t_noa = $(this).val();
                        if(t_noa.length==0)
                        	return;
                        switch(q_getPara('sys.project').toUpperCase()){
                        	case 'ES':
                        		q_box("custtran.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + r_accy, 'cust', "95%", "95%", q_getMsg("popCust"));
                        		break;
                    		case 'DS':
                        		q_box("custtran.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + r_accy, 'cust', "95%", "95%", q_getMsg("popCust"));
                        		break;
                    		case 'DC':
                        		q_box("custtran.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + r_accy, 'cust', "95%", "95%", q_getMsg("popCust"));
                        		break;
                        	default:
                        		q_box("cust.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; noa='" + t_noa + "';" + r_accy, 'cust', "95%", "95%", q_getMsg("popCust"));
                        		break;
                        }
                    });	
            	}      
                _bbsAssign();
                $('#txtCondition').val(_condition);
                for(var i=0;i<_custno.length;i++){
                	for(var j=0;j<q_bbsCount;j++){
                		if(_custno[i]==$('#txtNoa_'+j).val()){
                			$('#chkSel_'+j).prop('checked',true);
                			break;
                		}
                	}	
                } 
            }

            function refresh() {
                _refresh();
            }
		</script>
		<style type="text/css">
		</style>
	</head>


		
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:5%;"> </td>
					<th align="center" style="width:2%;"><input type="checkbox" id="checkAllCheckbox"/></th>
					<td align="center" style="width:10%;">編號</td>
					<td align="center" style="width:30%;">名稱</td>
					<td align="center" style="width:10%;">統編</td>
					<td align="center" style="width:10%;">電話</td>
					<td align="center" style="width:10%;">傳真</td>
				</tr>
			</table>
		</div>
		<div id="dbbs" style="overflow: scroll;height:450px;" >
			<table id="tbbs" class='tbbs' border="2" cellpadding='2' cellspacing='1' style='width:100%;' >
				<tr style="display:none;">
					<td align="center" style="width:5%;"> </td>
					<th align="center" style="width:2%;"> </th>
					<td align="center" style="width:10%;">編號</td>
					<td align="center" style="width:30%;">名稱</td>
					<td align="center" style="width:10%;">統編</td>
					<td align="center" style="width:10%;">電話</td>
					<td align="center" style="width:10%;">傳真</td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td style="width:5%;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:2%;"><input type="checkbox" class="ccheck" id="chkSel.*"/></td>
					<td style="width:10%;"><input type="text" style="float:left;width:100%;" readonly="readonly" id="txtNoa.*" /></td>
					<td style="width:30%;"><input type="text" style="float:left;width:100%;" readonly="readonly" id="txtComp.*" /></td>
					<td style="width:10%;"><input type="text" style="float:left;width:100%;" readonly="readonly" id="txtSerial.*" /></td>
					<td style="width:10%;"><input type="text" style="float:left;width:100%;" readonly="readonly" id="txtTel.*" /></td>
					<td style="width:10%;"><input type="text" style="float:left;width:100%;" readonly="readonly" id="txtFax.*" /></td>
				</tr>
			</table>
		</div>
		<div>
			<a>編號、名稱 、統編、電話、傳真、備註</a>
			<input class="txt" id="txtCondition" type="text" style="width:130px;" />
			<input type="button" id="btnSearch" style="border-style: none; width: 26px; height: 26px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;background-size: 100%;">
		 </div>
		<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>

