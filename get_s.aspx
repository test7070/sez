﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "get_s";
            aPop = new Array(['txtStationno', '', 'station', 'noa,station', 'txtStationno,txtStation', 'station_b.aspx']
            , ['txtStoreno', '', 'store', 'noa,store', 'txtStoreno,txtStore', 'store_b.aspx']
            ,['txtCustno', 'lblCustno', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx']);
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

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);

                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_stationno = $('#txtStationno').val();
                t_station = $('#txtStation').val();
                t_storeno = $('#txtStoreno').val();
                t_store = $('#txtStore').val();
                t_custno = $.trim($('#txtCustno').val());
		        t_comp = $.trim($('#txtComp').val());


                var t_where = " 1=1 " 
                + q_sqlPara2("noa", t_noa) 
                + q_sqlPara2("datea", t_bdate, t_edate) 
                + q_sqlPara2("stationno", t_stationno) 
                + q_sqlPara2("station", t_station) 
                + q_sqlPara2("storeno", t_storeno) 
              //  + q_sqlPara2("store", t_store)
                + q_sqlPara2("custno", t_custno);
                
                if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";

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
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStationno'></a></td>
					<td>
					<input class="txt" id="txtStationno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtStation" type="text" disabled="disabled" style="width:115px;font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStoreno'></a></td>
					<td>
					<input class="txt" id="txtStoreno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtStore" type="text" disabled="disabled" style="width:115px;font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
