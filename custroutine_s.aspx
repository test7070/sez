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
            var q_name = "custroutine_s";
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']);
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
                q_gt('part', '', 0, 0, 0, "");
                q_cmbParse("cmbTypea", '@全部,'+q_getPara('lab_accc.typea'));
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'part':
                        var t_part = '@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbPart", t_part);
                        break;
                }
            }

            function q_seekStr() {
            	t_partno = $.trim($('#cmbPart').val());
            	t_typea = $.trim($('#cmbTypea').val());
                t_custno = $.trim($('#txtCustno').val());
                t_cust = $.trim($('#txtCust').val());
                
                
                var t_where = " 1=1 " 
                + q_sqlPara2("custno", t_custno)
                + q_sqlPara2("partno", t_partno)
                + q_sqlPara2("typea", t_typea);
				if (t_cust.length > 0)
                    t_where += " and patindex('%" + t_cust + "%',comp)>0";
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                background-color: #76a2fe;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPart'> </a></td>
					<td><select id="cmbPart" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblCustno'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblCust'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtCust" type="text" style="width:215px; font-size:medium;" />
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
