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
		var q_name = 'view_work' , t_content = ' field=noa,kdate,rank,workdate,uindate,cuadate,ordeno,no2,enddate,mount,rmount,inmount,wmount,memo,productno,product,process,station,processno,stationno,unit,modelno,model,hours,tggno,comp', bbsKey = ['noa'], as, t_where = '';
		var t_sqlname = 'work_f_load'; t_postname = q_name;
		var isBott = false;  /// 是否已按過 最後一頁
		var txtfield=[],afield,t_data,t_htm, t_bbsTag = 'tbbs';
		var bbsNum = [['textBorn2', 15, 0, 1]];
		var i, s1;
		brwCount = -1;
		//brwCount2 = -1;
		//q_desc=1;
		
		aPop = new Array(['textStoreno2_', 'btnStore2_', 'store', 'noa,store', 'textStoreno2_,textStore2_', 'store_b.aspx']);
		
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
		 //1030401改網頁為委外用 ref.work_chk_b.aspx
		 //1030325 應流程由入庫產生領料所以不判斷是否以領料才能匯入
		 function bbsAssign() {  
			_bbsAssign();
			for (var j = 0; j < q_bbsCount; j++) {
				q_gt('view_workfs', "where=^^workno='"+$('#txtNoa_'+j).val()+"'^^", 0, 0, 0, "view_workfs_"+j, r_accy);
				$('#textUnborn2_'+j).val(q_float('txtMount_'+j)-q_float('txtInmount_'+j));
				
				$('#textBorn2_' + j).change(function() {
					t_IdSeq = -1;
					q_bodyId($(this).attr('id'));
					b_seq = t_IdSeq;
					if(q_float('textBorn2_'+b_seq)>q_float('textUnborn2_'+b_seq)){
						alert('【'+q_getMsg('lblBorn2_f')+'】大於【'+q_getMsg('lblUnborn2_f')+'】');
						$('#textBorn2_'+b_seq).val(q_float('textUnborn2_'+b_seq));
					}
				});
			}
		}
		var t_storeno='',t_store='';
		function q_gtPost(t_name) {  ///  for   store2 
			if(t_name=='store'){
				var as = _q_appendData("store", "", true);
				if (as[0] != undefined) {
					t_storeno=as[0].noa;
					t_store=as[0].store;
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textStoreno2_'+j).val(t_storeno).attr('disabled', 'disabled');
						$('#textStore2_'+j).val(t_store).attr('disabled', 'disabled');
						$('#btnStore2_'+j).hide();
					}
				}else{
					for (var j = 0; j < q_bbsCount; j++) {
						$('#textStoreno2_'+j).val('').attr('disabled', 'disabled');
						$('#textStore2_'+j).val('').attr('disabled', 'disabled');
						$('#btnStore2_'+j).hide();
					}
				}
			}
			
			if(t_name.substring(0,12)=='view_workfs_'){
				var seq = t_name.split('_')[2];
				var as = _q_appendData("view_workfs", "", true);
				var t_born=0
				for (i = 0; i < as.length; i++) {
					t_born+=dec(as[i].born)-dec(as[i].bkmount)-dec(as[i].wmount);
				}
				$('#textInmount2_'+seq).val(t_born);
				$('#textUnborn2_'+seq).val(q_float('txtMount_'+seq)-q_float('textInmount2_'+seq));
			}
		}
		
		function refresh() {
			_refresh();
			/*$('#checkAllCheckbox').click(function(){
				$('input[type=checkbox][id^=chkSel]').each(function(){
					var t_id = $(this).attr('id').split('_')[1];
					if(emp($('#txtState_'+t_id).val()) && !emp($('#txtNoa_'+t_id).val()))
						$(this).attr('checked',$('#checkAllCheckbox').is(':checked'));
				});
			});*/
			
			if(!emp($('#txtTggno_0').val()) && r_outs=='1'){
				q_gt('store', "where=^^tggno='"+$('#txtTggno_0').val()+"'^^", 0, 0, 0, "store", r_accy);
			}
						
			$('#btnTop').hide();
			$('#btnPrev').hide();
			$('#btnNext').hide();
			$('#btnBott').hide();
	    }
	    
		function readonly(t_para) {
			_readonly(t_para);
			for (var j = 0; j < q_bbsCount; j++) {
				$('#textBorn2_'+j).removeAttr('readonly').css('background-color','');
				if(r_outs!='1'){
					$('#textStoreno2_'+j).removeAttr('readonly').css('background-color','');
					$('#textStore2_'+j).removeAttr('readonly').css('background-color','');
				}
				
				$('#chkSel_'+j).attr('checked','true');
			}
			q_cur=2;
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
<div id="dbbs">
	   <table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'>
			<tr style='color:White; background:#003366;'>
				<!--<th align="center"><input type="checkbox" id="checkAllCheckbox"/></th>-->
				<th align="center"><a id='lblTggno'></a></th>
				<th align="center"><a id='lblProcess'></a></th>
				<th align="center"><a id='lblNoa'></a> <BR><a id='lblCuadate'></a>/ <a id='lblUindate'></a></th>
				<th align="center"><a id='lblProductno'></a> / <a id='lblProduct'></a></th>
				<th align="center"><a id='lblRank'></a></th>
				<th align="center"><a id='lblMount'></a></th>
				<th align="center"><a id='lblInmount2_f'></a></th>
				<th align="center"><a id='lblUnborn2_f'></a></th>
				<th align="center"><a id='lblBorn2_f' style="color: red;"></a></th>
				<th align="center"><a id='lblStore2_f' style="color: red;"></a></th>
				<th align="center"><a id='lblMemo'></a></th>
			</tr>
			<tr style='background:#cad3ff;'>
				<td style="width:10%;">
					<input class="txt" id="txtTggno.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtProcess.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				<td style="width:15%;">
					<input class="chk" id="chkSel.*" type="checkbox" style="display: none;"/>
					<input id="txtDatea.*" type="hidden" />
					<input id="txtWorkdate.*" type="hidden" />
					<input id="txtRmount.*" type="hidden" />
					<input id="txtWmount.*" type="hidden" />
					<input id="txtWsgmount.*" type="hidden" />
					<input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtCuadate.*" type="text" style="width:48%;"  readonly="readonly" />
					<input class="txt" id="txtUindate.*" type="text" style="width:48%;"  readonly="readonly" />
				</td>
				<td style="width:14%;">
					<input class="txt" id="txtProductno.*" type="text" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtProduct.*" type="text" style="width:98%;"  readonly="readonly" />
				</td>
				<td style="width:4%;">
					<input class="txt" id="txtRank.*" type="text" style="width:98%;text-align: center;"  readonly="readonly" />
				</td>
				<td style="width:7%;"><input class="txt" id="txtMount.*" type="text" style="width:98%;text-align: right;"  readonly="readonly" /></td>
				<td style="width:7%;"><input class="txt" id="textInmount2.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
				<td style="width:7%;"><input class="txt" id="textUnborn2.*" type="text" style="width:98%; text-align: right;"  readonly="readonly" /></td>
				<td style="width:9%;"><input class="txt" id="textBorn2.*" type="text" style="width:98%; text-align: right;"  /></td>
				<td style="width:10%;">
					<input class="txt" id="textStoreno2.*" type="text" style="width:78%;"  />
					<input class="btn" id="btnStore2.*" type="button" value='.' style="width:1%;float: left;" />
					<input class="txt" id="textStore2.*" type="text" style="width:98%;"/>
				</td>
				<td><input class="txt" id="txtMemo.*" type="text" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtStationno.*" type="hidden" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtStation.*" type="hidden" style="width:98%;"  readonly="readonly" />
						<input class="txt" id="txtOrdeno.*" type="hidden" style="width:98%;"  readonly="readonly" />
					<input class="txt" id="txtNo2.*" type="hidden" style="width:98%;"  readonly="readonly" />
				</td>
			</tr>
		</table>
  	<!--#include file="../inc/pop_ctrl.inc"--> 
	</div>
</body>
</html> 

