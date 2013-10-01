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
			var q_name = 'orde', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], as;
			//, t_where = '';
			var t_sqlname = 'orde_load';
			t_postname = q_name;
			brwCount = -1;
			brwCount2 = 0;
			var isBott = false;
			var txtfield = [], afield, t_data, t_htm;
			var i, s1;
			q_desc=1;
			$(document).ready(function() {
				if (!q_paraChk())
					return;

				main();
			});

			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				
				var w = window.parent;
				if(w.q_name == 'orde' || emp(w.q_name) ){
					t_content = '';
				}else{
					t_content = "where=^^ ((select isnull(sum(mount),0) from ordes"+r_accy+" b where orde.noa = b.noa)-(select isnull(sum(mount),0) from "+w.q_name+"s"+r_accy+" a where orde.noa=a.ordeno ) >0) ";
					t_content +=" and ((select isnull(sum(weight),0) from ordes"+r_accy+" b where orde.noa = b.noa)-(select isnull(sum(weight),0) from "+w.q_name+"s"+r_accy+" a where orde.noa=a.ordeno) >0) ^^";
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost(){
			}

			function bbsAssign() {
				_bbsAssign();
			}

			function q_gtPost(t_name) {
			}

			var maxAbbsCount = 0;
			function refresh() {
				var w = window.parent;
				if (maxAbbsCount < abbs.length) {
					for (var i = (abbs.length - (abbs.length - maxAbbsCount)); i < abbs.length; i++) {
						for (var j = 0; j < w.q_bbsCount; j++) {
							if (w.$('#txtOrdeno_' + j).val() == abbs[i].noa) {
								abbs[i]['sel'] = "true";
								$('#chkSel_' + abbs[i].rec).attr('checked', true);
							}
						}
					}
					maxAbbsCount = abbs.length;
				}

				abbs.sort(function(a,b){
					var x = (a.sel==true || a.sel=="true"?1:0);
					var y = (b.sel==true || b.sel=="true"?1:0);
					return y-x;
				});
				for(var i=0;i<abbs.length;i++){
					if(abbs[i].kind == ''){
						abbs.splice(i,1);
						i--;
					}
				}
				_refresh();
				q_bbsCount = abbs.length;
				for (var j = 0; j < (q_bbsCount ==0 ?1:q_bbsCount); j++) {
				q_cmbParse("combKind_"+j, q_getPara('sys.stktype'));
				q_cmbParse("combStype_"+j, q_getPara('orde.stype'));
					if(!emp($('#txtKind_'+j).val()))
						$('#combKind_'+j).val($('#txtKind_'+j).val());
					else
						$('#combKind_'+j).text('');
					if(!emp($('#txtStype_'+j).val()))
						$('#combStype_'+j).val($('#txtStype_'+j).val());
					else
						$('#combStype_'+j).text('');
			        $('#combStype_'+j).attr('disabled', 'disabled');
		            $('#combStype_'+j).css('background', t_background2);
			        $('#combKind_'+j).attr('disabled', 'disabled');
		            $('#combKind_'+j).css('background', t_background2);
				}
				$('#checkAllCheckbox').click(function() {
					$('input[type=checkbox][id^=chkSel]').each(function() {
						var t_id = $(this).attr('id').split('_')[1];
						if (!emp($('#txtNoa_' + t_id).val()))
							$(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
					});
				});
				for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
				_readonlys(true);
			}

		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			select {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div  id="dFixedTitle" style="overflow-y: scroll;">
			<table id="tFixedTitle" class='tFixedTitle'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:1%;"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:3%;"><a id='lblNo'></a></td>
					<td align="center" style="width:12%;"><a id='lblNoa'></a></td>
					<td align="center" style="width:8%;"><a id='lblOdate'></a></td>
					<td align="center" style="width:10%;"><a id='lblStype'></a></td>
					<td align="center" style="width:10%;"><a id='lblKind'></a></td>
					<td align="center" style="width:18%;"><a id='lblAcomp'></a></td>
					<td align="center" style="width:20%;"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
			</table>
		</div>
		<div  id="dbbs" style="overflow: scroll;height:550px;" >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;display:none;' >
					<td align="center"><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center"><a id='lblNo'></a></td>
					<td align="center"><a id='lblNoa'></a></td>
					<td align="center"><a id='lblOdate'></a></td>
					<td align="center"><a id='lblStype'></a></td>
					<td align="center"><a id='lblKind'></a></td>
					<td align="center"><a id='lblAcomp'></a></td>
					<td align="center"><a id='lblCust'></a></td>
					<td align="center"><a id='lblMemo'></a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center" style="width:1%;">
						<input id="chkSel.*" type="checkbox"/>
					</td>
					<td style="width:3%;">
						<a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a>
					</td>
					<td style="width:12%;"><input class="txt"  id="txtNoa.*" type="text" style="width:98%;" /></td>
					<td style="width:8%;"><input class="txt"  id="txtOdate.*" type="text" style="width:98%;" /></td>
					<td style="width:10%;">
						<select id="combStype.*" class="txt c1"></select>
						<input class="txt"  id="txtStype.*" type="text" style="display:none;" />
					</td>
					<td style="width:10%;">
						<select id="combKind.*" class="txt c1"></select>
						<input class="txt"  id="txtKind.*" type="text" style="display:none;" />
					</td>
					<td style="width:18%;">
						<input class="txt"  id="txtCno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtAcomp.*" type="text" style="width:70%;" />
					</td>
					<td style="width:20%;">
						<input class="txt"  id="txtCustno.*" type="text" style="width:25%;" />
						<input class="txt"  id="txtComp.*" type="text" style="width:70%;" />
					</td>
					<td align="center"><input class="txt"  id="txtMemo.*" type="text" style="width:98%;" /></td>
				</tr>
			</table>
		</div>
			<!--#include file="../inc/pop_ctrl.inc"-->
	</body>
</html>
