<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
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
			aPop = new Array(['txtXcarno', 'lblXcarno', 'car2', 'a.noa,driverno,driver', 'txtXcarno', 'car2_b.aspx'], ['txtXaddr', 'lblXaddr', 'addr', 'noa,addr', 'txtXaddr', 'addr_b.aspx']);
			if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
			function z_tran() {
			}
			z_tran.prototype = {
				data : {
					cartram : null,
					calctypes : null,
					carkind : null,
					calctype : null,
					acomp : null
				},
				isLoad : function(){
					var isLoad = true;
					for(var x in this.data){
						alert(x+' : '+this.data[x]);
						isLoad = isLoad && (this.data[x]!=null);
					}
					return isLoad;
				}
			};
			t_data = new z_tran();

			$(document).ready(function() {
				_q_boxClose();
				q_getId();
				q_gf('', 'z_tran');
			});
			function q_gfPost() {
				q_gt('carteam', '', 0, 0, 0, "");
				q_gt('calctype2', '', 0, 0, 0, "calctypes");
				q_gt('carkind', '', 0, 0, 0, "");
				q_gt('calctype', '', 0, 0, 0);
				q_gt('acomp', '', 0, 0, 0);
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'carkind':
						t_data.data['carkind'] = '';
						var as = _q_appendData("carkind", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carkind'] = t_data.data['carkind'] + (t_data.data['carkind'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].kind;
						}
						break;
					case 'carteam':
						t_data.data['carteam'] = '';
						var as = _q_appendData("carteam", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['carteam'] = t_data.data['carteam'] + (t_data.data['carteam'].length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
						}
						break;
					case 'calctypes':
						t_data.data['calctypes'] = '';
						var as = _q_appendData("calctypes", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctypes'] = t_data.data['calctypes'] + (t_data.data['calctypes'].length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
						}
						break;
					case 'calctype':
						t_data.data['calctype'] = '';
						var as = _q_appendData("calctype", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['calctype'] = t_data.data['calctype'] + (t_data.data['calctype'].length > 0 ? ',' : '') + 'calctype_' + as[i].noa + '@' + as[i].namea;
						}
						break;
					case 'acomp':
						t_data.data['acomp'] = '';
						var as = _q_appendData("acomp", "", true);
						for ( i = 0; i < as.length; i++) {
							t_data.data['acomp'] = t_data.data['acomp'] + (t_data.data['acomp'].length > 0 ? ',' : '') + as[i].acomp;
						}
						break;
				}
				alert(t_data.isLoad());

			}

			function q_boxClose(t_name) {
			}

		</script>
	</head>
	<body>
		<div id="q_menu"></div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"></div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>