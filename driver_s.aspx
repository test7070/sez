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
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            var q_name = "driver_s";
			aPop = new Array(['txtNoa', 'lblDriver', 'driver', 'noa,namea', 'txtNoa', 'driver_b.aspx']); 
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

                bbmMask = [['txtBtakeofficedate', r_picd], ['txtEtakeofficedate', r_picd]];
                q_mask(bbmMask);
                $('#txtBtakeofficedate').datepicker();
                $('#txtEtakeofficedate').datepicker();
				q_cmbParse("cmbCartype",'@全部,'+q_getPara('driver.cartype'));
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_btakeofficedate = $('#txtBtakeofficedate').val();
                t_etakeofficedate = $('#txtEtakeofficedate').val();
                t_namea = $('#txtNamea').val();
                t_guild = $('#txtGuild').val();
				t_cartype = $('#cmbCartype').val();
				t_memo = $.trim($('#txtMemo').val());
				
				t_carno = $.trim($('#txtCarno').val());
				
                var t_where = " 1=1 " 
                	+ q_sqlPara2("noa", t_noa) 
                	+ q_sqlPara2("namea", t_namea) 
                	+ q_sqlPara2("takeofficedate", t_btakeofficedate, t_etakeofficedate) 
                	+ q_sqlPara2("guild", t_guild)
                	+ q_sqlPara2("cartype", t_cartype);
                
                if(t_memo.length>0){
                	t_where += " and (charindex('"+t_memo+"',tel)>0 or charindex('"+t_memo+"',mobile)>0 or charindex('"+t_memo+"',idno)>0 or charindex('"+t_memo+"',memo)>0)"; 
                }
                
                if(t_carno.length>0){
                	t_where+= " and exists(select noa from car2 where driverno=driver.noa and charindex('"+t_carno+"',carno)>0)";
                }	

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
					<td class='seek'  style="width:20%;"><a id='lblCartype'></a></td>
					<td>
					<select id="cmbCartype" style="width:215px; font-size:medium;" > </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtakeofficedate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtakeofficedate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNamea'></a></td>
					<td>
					<input class="txt" id="txtNamea" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGuild'></a></td>
					<td>
					<input class="txt" id="txtGuild" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'>車牌</a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMemo'>電話、備註</a></td>
					<td><input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" title="電話、手機、身份證、備註"/></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
