<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
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
            var q_name = "trans_s";
			aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,nick', 'txtCustno', 'cust_b.aspx'],
		    ['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno', 'driver_b.aspx'], 
		    ['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr', 'txtStraddrno', 'addr_b.aspx'],
            ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']);
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
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);
                q_gt('carteam', '', 0, 0, 0, "");
                q_gt('calctype2', '', 0, 0, 0, "calctypes");
                q_cmbParse("cmbTrd", '@全部,Y@已立帳,N@未立帳');
                q_cmbParse("cmbTre", '@全部,Y@已立帳,N@未立帳');
                $('#txtBdate').datepicker();
				$('#txtEdate').datepicker(); 
				$('#txtBtrandate').datepicker();
				$('#txtEtrandate').datepicker(); 
                $('#txtNoa').focus();
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'carteam':
                        var t_carteam = '@全部';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_cmbParse("cmbCarteam", t_carteam);
                        break;
                    case 'calctypes':
						var as = _q_appendData("calctypes", "", true);
						var t_item = '@全部';
						var item = new Array();
						for ( i = 0; i < as.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
						}
						q_cmbParse("cmbCalctype", t_item);
						break;
                }
            }

            function q_seekStr() {
                t_noa = $.trim($('#txtNoa').val());
		        t_driverno = $.trim($('#txtDriverno').val());
		        t_driver = $.trim($('#txtDriver').val());
		        t_custno = $.trim($('#txtCustno').val());
		        t_comp = $.trim($('#txtComp').val());
		        t_carno = $.trim($('#txtCarno').val());
		        t_po = $.trim($('#txtPo').val());
		        t_caseno = $.trim($('#txtCaseno').val());
		        t_straddrno = $.trim($('#txtStraddrno').val());

		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();
		        t_btrandate = $('#txtBtrandate').val();
		        t_etrandate = $('#txtEtrandate').val();
		        t_trd = $.trim($('#cmbTrd').val());
		        t_tre = $.trim($('#cmbTre').val());
		        t_carteam = $.trim($('#cmbCarteam').val());
		        t_calctype = $.trim($('#cmbCalctype').val());

		        var t_where = " 1=1 " 
		        + q_sqlPara2("carteamno", t_carteam)
		        + q_sqlPara2("calctype", t_calctype)
		        + q_sqlPara2("noa", t_noa) 
		        + q_sqlPara2("datea", t_bdate, t_edate) 
		        + q_sqlPara2("Trandate", t_btrandate, t_etrandate) 
		        + q_sqlPara_or(["caseno", "caseno2"], t_caseno) 
		        + q_sqlPara2("driverno", t_driverno) 
		        + q_sqlPara2("custno", t_custno) 
		        + q_sqlPara2("straddrno", t_straddrno) 
		        + q_sqlPara2("carno", t_carno) 
		        + q_sqlPara2("po", t_po);
		        if (t_comp.length>0)
                    t_where += " and patindex('%" + t_comp + "%',comp)>0";
                if (t_driver.length>0)
                    t_where += " and patindex('%" + t_driver + "%',driver)>0";
		       	if(t_trd=='Y')
		       		t_where += " and exists(select noa from view_trds"+r_accy+" where view_trds"+r_accy+".tranno=trans"+r_accy+".noa)";
		       	if(t_trd=='N')
		       		t_where += " and not exists(select noa from view_trds"+r_accy+" where view_trds"+r_accy+".tranno=trans"+r_accy+".noa)";
		       	if(t_tre=='Y'){
		       		t_where +="and( exists(select view_tres"+r_accy+".noa from view_tres"+r_accy+ 
					" left join calctypes on calctypes.noa+calctypes.noq= trans"+r_accy+".calctype"+
					" where calctypes.isoutside=1 and view_tres"+r_accy+".tranno=trans"+r_accy+".noa)"+
					" or exists(select carsal.noa from carsal"+
					" left join calctypes on calctypes.noa+calctypes.noq= trans"+r_accy+".calctype"+
					" where calctypes.isoutside=0 and carsal.noa=left(trans"+r_accy+".datea,6) and carsal.lock=1) )";
		       	}
		       	if(t_tre=='N'){
		       		t_where +="and not(exists(select view_tres"+r_accy+".noa from view_tres"+r_accy+ 
					" left join calctypes on calctypes.noa+calctypes.noq= trans"+r_accy+".calctype"+
					" where calctypes.isoutside=1 and view_tres"+r_accy+".tranno=trans"+r_accy+".noa)"+
					" or exists(select carsal.noa from carsal"+
					" left join calctypes on calctypes.noa+calctypes.noq= trans"+r_accy+".calctype"+
					" where calctypes.isoutside=0 and carsal.noa=left(trans"+r_accy+".datea,6) and carsal.lock=1) )";
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
					<td class='seek'  style="width:20%;"><a id='lblCarteam'> </a></td>
					<td><select id="cmbCarteam" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCalctype'> </a></td>
					<td><select id="cmbCalctype" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTrd'> </a></td>
					<td><select id="cmbTrd" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTre'> </a></td>
					<td><select id="cmbTre" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
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
					<td   style="width:35%;" ><a id='lblTrandate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBtrandate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEtrandate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriverno'></a></td>
					<td>
					<input class="txt" id="txtDriverno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblDriver'></a></td>
					<td>
					<input class="txt" id="txtDriver" type="text" style="width:215px; font-size:medium;" />
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
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCaseno'></a></td>
					<td>
					<input class="txt" id="txtCaseno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblPo'></a></td>
					<td>
					<input class="txt" id="txtPo" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStraddr'></a></td>
					<td>
					<input class="txt" id="txtStraddrno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>