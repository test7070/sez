<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "giftin_s";
			var aPop = new Array(
				['txtTggno', '', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']);

			$(document).ready(function() {
				main();
			});
			/// end ready

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();

				bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBindate', r_picd], ['txtEindate', r_picd]];
				q_mask(bbmMask);
				q_gt('acomp', '', 0, 0, 0, "");
				q_gt('part', '', 0, 0, 0, "");
				$('#txtBdate').focus();
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
				case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        var t_stype = "@";
                        for ( i = 0; i < as.length; i++) {
                            t_stype = t_stype + (t_stype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_stype);
                        break;
				
				 case 'part':
		                var as = _q_appendData("part", "", true);
		                var t_stype = " @ ";
		                for (i = 0; i < as.length; i++) {
		                     t_stype = t_stype + (t_stype.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
		                }
						q_cmbParse("cmbPartno", t_stype);
				        break;
				        
				  }
           }
			
			function q_seekStr() {
				t_noa = $.trim($('#txtNoa').val());
				t_cno = $.trim($('#cmbCno').val());
				t_partno = $.trim($('#cmbPartno').val());
				t_bdate = $.trim($('#txtBdate').val());
				t_edate = $.trim($('#txtEdate').val());
				t_bindate = $.trim($('#txtBindate').val());
				t_eindate = $.trim($('#txtEindate').val());
				t_tggno = $.trim($('#txtTggno').val());
				t_tgg = $.trim($('#txtTgg').val());
				
			    t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;  /// 100.  .
        		t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;  /// 100.  .
        		t_bindate = t_bindate.length > 0 && t_bindate.indexOf("_") > -1 ? t_bindate.substr(0, t_bindate.indexOf("_")) : t_bindate;  /// 100.  .
        		t_eindate = t_eindate.length > 0 && t_eindate.indexOf("_") > -1 ? t_eindate.substr(0, t_eindate.indexOf("_")) : t_eindate;  /// 100.  .

				var t_where = " 1=1 "
					+q_sqlPara2("noa", t_noa)
					+q_sqlPara2("datea", t_bdate, t_edate)
					+q_sqlPara2("indate", t_bindate, t_eindate)
					+q_sqlPara2("cno", t_cno)
					+q_sqlPara2("partno", t_partno)					
					+q_sqlPara2("tggno", t_tggno)
					+q_sqlPara2("tgg", t_tgg);

				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblDatea'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblIndate'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBindate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEindate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCno'> </a></td>
					<td><select id="cmbCno" class="txt c1"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPartno'> </a></td>
					<td><select id="cmbPartno" class="txt c1"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTggno'> </a></td>
					<td>
					<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
					<input class="txt" id="txtTgg" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
