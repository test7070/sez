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
            var q_name = "store_s";
			//var aPop = new Array(
				//['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno', 'tgg_b.aspx']);
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

                bbmMask = [['txtBstart', r_picd], ['txtEstart', r_picd]];
                q_mask(bbmMask);

                $('#txtBstart').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
              //  t_bstart = $('#txtBstart').val();
               // t_estart = $('#txtEstart').val();

                t_store = $('#txtStore').val();
             //   t_tggno = $('#txtTggno').val();
               // t_tgg = $('#txtTgg').val();

               // t_bstart = t_bstart.length > 0 && t_bstart.indexOf("_") > -1 ? t_bstart.substr(0, t_bstart.indexOf("_")) : t_bstart;
                /// 100.  .
             //   t_estart = t_estart.length > 0 && t_estart.indexOf("_") > -1 ? t_estart.substr(0, t_estart.indexOf("_")) : t_estart;
                /// 100.  .

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("store", t_store) 
                //+ q_sqlPara2("start", t_bstart, t_estart) + q_sqlPara2("tggno", t_tggno) + q_sqlPara2("tgg", t_tgg)
                ;

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
				<!--<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBstart" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEstart" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>-->
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStore'></a></td>
					<td>
					<input class="txt" id="txtStore" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<!--<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTggno'></a></td>
					<td>
					<input class="txt" id="txtTggno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtTgg" type="text" style="width:115px; font-size:medium;" />
					</td>-->
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
