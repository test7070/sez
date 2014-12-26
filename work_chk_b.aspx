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
		var q_name = 'work' , t_content = ' field=noa,style,kdate,workdate,uindate,cuadate,ordeno,no2,enddate,mount,rmount,inmount,wmount,memo,productno,product,process,station,processno,stationno,unit,modelno,model,hours,tggno,comp,cuano,cuanoq', bbsKey = ['noa'], as, t_where = '';
		var t_sqlname = 'work_load'; t_postname = q_name;
		var isBott = false;  /// 是否已按過 最後一頁
		var txtfield=[],afield,t_data,t_htm, t_bbsTag = 'tbbs';
		var i, s1;
		brwCount = -1;
		//brwCount2 = 10;
		q_desc=1;
		$(document).ready(function () {
			 if (!q_paraChk())
				return;
			
			main();
		});		 /// end ready

		function main() {
			if (dataErr)  /// 載入資料錯誤
			{
				dataErr = false;
				return;
			}
			mainBrow(6, t_content, t_sqlname, t_postname , r_accy );
		
		 }
		 
		 //1030325 應流程由入庫產生領料所以不判斷是否以領料才能匯入
		 function bbsAssign() {  
		 	for (var j = 0; j < q_bbsCount; j++) {
		 		$('#chkSel_'+j).click(function() {
		 			sum_thours();
				});
		 	}
			_bbsAssign();
			for (var j = 0; j < q_bbsCount; j++) {
				if(!emp($('#txtNoa_'+j).val())){
					if(dec($('#txtMount_'+j).val())<=0){
						$('#txtState_'+j).val('數量錯誤');
					}else if(dec($('#txtInmount_'+j).val())>=dec($('#txtMount_'+j).val())){
						$('#txtState_'+j).val('入庫完成');
					}
				}
				var aspxnamea=window.parent.q_name;
				
				if(!emp($('#txtState_'+j).val())){
					if(!(aspxnamea=='workb' || aspxnamea=='workd')){
						$('#chkSel_'+j).attr('disabled','disabled');
					}
				}
				//else
				//	q_gt('view_works', "noa='"+$('#txtNoa_'+j).val()+"'", 0, 0, 0, "view_works", r_accy);
			}
			
			if (window.parent.q_name == 'workb') 
				$('.tgg').hide();
				
			if (window.parent.q_name == 'workd') 
				$('.station').hide();	
		}

		function q_gtPost(t_name) {  ///  for   store2 
			var aspxnamea=window.parent.q_name;
			switch (t_name) {
				/*case 'view_works':
				var works = _q_appendData("view_works", "", true);
			 	if(works[0]==undefined)
			 		return;
			 	if(aspxnamea=='workb' || aspxnamea=='workd'){
			 		for (var j = 0; j < q_bbsCount; j++) {
			 			if(!emp($('#txtNoa_'+j).val()) && emp($('#txtState_'+j).val())){
			 				var t_gmount=0;//領料數
				 			for (var i = 0; i < works.length; i++) {
				 				if($('#txtNoa_'+j).val()==works[i].noa)
				 					t_gmount+=dec(works[i].gmount);
				 			}
				 			if(t_gmount==0){
				 				$('#txtState_'+j).val('未領料');
								$('#chkSel_'+j).attr('disabled','disabled');
				 			}
				 		}
					}
				}
				break;*/
			}
		}
		
		function refresh() {
			_refresh();
			$('#checkAllCheckbox').click(function(){
				$('input[type=checkbox][id^=chkSel]').each(function(){
					var t_id = $(this).attr('id').split('_')[1];
					if(emp($('#txtState_'+t_id).val()) && !emp($('#txtNoa_'+t_id).val()))
						$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
				});
				sum_thours();
			});
			
			$('#btnAhours').click(function() {
				if(dec($('#textAhours').val())>0){
					var t_ahours=dec($('#textAhours').val());
					for (var j = 0; j < q_bbsCount; j++) {
						$('#chkSel_'+j).prop('checked',true);
						t_ahours=q_sub(t_ahours,q_float('txtHours_'+j));
						if(t_ahours<0)
							break;
					}
				}
				sum_thours();
			});
			
			$('#btnTop').hide();
			$('#btnPrev').hide();
			$('#btnNext').hide();
			$('#btnBott').hide();
	    }
	    
	    function sum_thours() {
	    	var thours=0;
			for (var j = 0; j < q_bbsCount; j++) {
				if($('#chkSel_'+j).prop('checked')){
					thours=q_add(thours,q_float('txtHours_'+j))
				}
			}
			$('#textThours').val(thours);
	    }
	</script>
	<style type="text/css">
	.seek_tr {
		color:white;
		text-align:center;
		font-weight:bold;
		BACKGROUND-COLOR: #76a2fe
	}
	input[type="text"], input[type="button"] {
		font-size: medium;
	}
	</style>
</head>

<body> 
	<div style="float: right;">
		<a>自動選取工時 </a>
		<input class="txt" id="textAhours" type="text" style="width:70px;" />
		<input class="btn" id="btnAhours" type="button" value='自動選取' style=" font-weight: bold;" />
		<a>累計工時 </a>
		<input class="txt" id="textThours" type="text" style="width:70px;" disabled="disabled"/>
	</div>
<div id="dbbs">
	   <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'>
			<tr style='color:White; background:#003366;'>
				<th align="center"><input type="checkbox" id="checkAllCheckbox"/></th>
				<th align="center"><a id='lblState'> </a></th>
				<th align="center"><a id='lblNoa'> </a> <BR><a id='lblCuadate'> </a>/ <a id='lblUindate'> </a></th>
				<!--<th align="center"  ><a id='lblDatea'></a></th>-->
				<th align="center"><a id='lblProductno'> </a> / <a id='lblProduct'> </a></th>
				<th align="center"><a id='lblMount'> </a></th>
				<!--<th align="center"  ><a id='lblWorkdate'></a></th>
				<th align="center"  ><a id='lblUindate'></a></th>-->
				<th align="center" class="station"><a id='lblStation'> </a></th>
				<th align="center"><a id='lblInmount'> </a></th>
				<!--<th align="center"><a id='lblRmount'></a></th>
				<th align="center"><a id='lblWmount'></a></th>-->
				<th align="center"><a id='lblOrdeno'> </a></th>
				<th align="center" class="tgg"><a id='lblTggno'> </a></th>
				<th align="center"><a id='lblProcess'> </a></th>
				<th align="center"><a id='lblHours'> </a></th>
				<th align="center"><a id='lblMemo'> </a></th>
			</tr>
			<tr style='background:#cad3ff;'>
				<td style="width:1%;">
					<input class="chk" id="chkSel.*" type="checkbox"/>
					<input id="txtDatea.*" type="hidden" />
					<input id="txtWorkdate.*" type="hidden" />
					<input id="txtRmount.*" type="hidden" />
					<input id="txtWmount.*" type="hidden" />
					<input id="txtWsgmount.*" type="hidden" />
					<input id="txtCuano.*" type="hidden" />
					<input id="txtCuanoq.*" type="hidden" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtState.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				<td style="width:16%;">
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtCuadate.*" type="text" style="width:48%;"  readonly="readonly" />
					<input class="txt" id="txtUindate.*" type="text" style="width:48%;"  readonly="readonly" />
				</td>
				<!--<td style="width:6%;"><input class="txt" id="txtDatea.*" type="text" style="width:98%;"  readonly="readonly" /></td>-->
				<td style="width:14%;">
					<input class="txt" id="txtProductno.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtProduct.*" type="text" style="width:98%;"  readonly="readonly" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
				<!--<td style="width:6%;"><input class="txt" id="txtWorkdate.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				<td style="width:6%;"><input class="txt" id="txtUindate.*" type="text" style="width:98%;"  readonly="readonly" /></td>-->
				<td class="station" style="width:9%;">
					<input class="txt" id="txtStationno.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtStation.*" type="text" style="width:98%;"  readonly="readonly" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtInmount.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
				<!--<td style="width:5%;"><input class="txt" id="txtRmount.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
				<td style="width:5%;"><input class="txt" id="txtWmount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>-->
				<td style="width:10%;">
					<input class="txt" id="txtOrdeno.*" type="text" style="width:98%;"  readonly="readonly" />
					<!--<input class="txt" id="txtNo2.*" type="text" style="width:98%;"  readonly="readonly" />-->
				</td>
				<td class="tgg" style="width:9%;">
					<input class="txt" id="txtTggno.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtProcess.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				<td style="width:5%;"><input class="txt" id="txtHours.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
				<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;"  readonly="readonly" /></td>
			</tr>
		</table>
  	<!--#include file="../inc/pop_ctrl.inc"--> 
	</div>
</body>
</html> 

