<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "sss_s";
			
			function z_data() {
			}
			z_data.prototype = {
                acomp : '',
                part : '' ,
                salm : ''
            };
            var t_data = new z_data();
            
			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();

				q_gt('acomp', '', 0, 0, 0, "");
				q_gt('part', '', 0, 0, 0, "");
				q_gt('salm', '', 0, 0, 0, "");
				$('#txtNoa').focus();
				q_cmbParse("cmbEnd", ('').concat(new Array('全部','Y@在職', 'N@離職')));
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'part':
                        var as = _q_appendData("part", "", true);
                        if (as[0] != undefined) {
                            t_data.part = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_data.part = t_data.part + (t_data.part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                            }
                            q_cmbParse("cmbPartno", t_data.part);
                        }
                        break;
                    case 'salm':
                        var as = _q_appendData("salm", "", true);
                        if (as[0] != undefined) {
                            t_data.salm = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_data.salm = t_data.salm + (t_data.salm.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].job;
                            }
                            q_cmbParse("cmbJobno", t_data.salm);
                        }
                        break;
                	case 'acomp':
                        var as = _q_appendData("acomp", "", true);
                        t_data.acomp = '@全部';
                        for ( i = 0; i < as.length; i++) {
                            t_data.acomp = t_data.acomp + (t_data.acomp.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].acomp;
                        }
                        q_cmbParse("cmbCno", t_data.acomp);
                        break;
                }
            }

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_namea = $('#txtNamea').val();
				t_partno = $('#cmbPartno').val();
				t_cno = $('#cmbCno').val();
				t_jobno = $('#cmbJobno').val();
				t_end=$('#cmbEnd').val();

				var t_where = " 1=1 " 
				+ q_sqlPara2("noa", t_noa) 
				+ q_sqlPara2("namea", t_namea)
				+ q_sqlPara2("partno", t_partno)
				+ q_sqlPara2("cno", t_cno)
				+ q_sqlPara2("jobno", t_jobno); 
				
				if (t_end=='Y')
					t_where +="and isnull(outdate,'')='' ";
				if (t_end=='N')
					t_where +="and isnull(outdate,'')!='' ";
				
				if(r_rank <7)
					t_where+="and noa = '"+q_getId()[0]+"' ";
			
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblAcomp'> </a></td>
					<td><select id="cmbCno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblPart'> </a></td>
					<td><select id="cmbPartno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblJob'> </a></td>
					<td><select id="cmbJobno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblNoa'> </a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;"><a id='lblNamea'> </a></td>
					<td>
					<input class="txt" id="txtNamea" type="text"  />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:30%;">在職/離職</td>
					<td>	<select id="cmbEnd" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
