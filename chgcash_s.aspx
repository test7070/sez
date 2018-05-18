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
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            var q_name = "chgcash_s";
			aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno', 'sss_b.aspx']);
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
               // q_gt('part', '', 0, 0, 0, "");
                q_gt('chgpart', '', 0, 0, 0, "");
                q_cmbParse("cmbDc", '@全部,' + q_getPara('chgcash.typea'));
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
                $('#txtBdate').focus();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    /*case 'part':
                        var t_part = '@全部';
                        var as = _q_appendData("part", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_part += (t_part.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbPart", t_part);
                        break;*/
                    case 'chgpart':
                        var t_chgpart = '@全部';
                        var as = _q_appendData("chgpart", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_chgpart += (t_chgpart.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbChgpart", t_chgpart);
                        break;
                }
            }

            function q_seekStr() {
            	t_noa = $.trim($('#txtNoa').val());
                t_sssno = $.trim($('#txtSssno').val());
                t_namea = $.trim($('#txtNamea').val());
                t_bdate = $.trim($('#txtBdate').val());
                t_edate = $.trim($('#txtEdate').val());
                t_accno = $.trim($('#txtAccno').val());
                t_chgpart = $.trim($('#cmbChgpart').val());
                t_dc = $.trim($('#cmbDc').val());

                var t_where = " 1=1 "  
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("sssno", t_sssno) 
                + q_sqlPara2("datea", t_bdate, t_edate)
                + q_sqlPara2("accno", t_accno) 
                + q_sqlPara2("chgpartno", t_chgpart) 
                + q_sqlPara2("dc", t_dc);
				
				if(t_namea.length>0)
					t_where += ' patindex("%'+t_namea+'%",namea)>0 ';
                t_where = ' where=^^' + t_where + '^^ ';
               // alert(t_where);
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
					<td class='seek'  style="width:20%;"><a id='lblChgpart'></a></td>
					<td><select id="cmbChgpart" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDc'></a></td>
					<td><select id="cmbDc" style="width:215px; font-size:medium;" ></select></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblSssno'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtSssno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblNamea'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr> 
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblNoa'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td style="width:35%;" ><a id='lblAccno'> </a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtAccno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>