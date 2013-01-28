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
		    var q_name = "bcce_s";
		    aPop = new Array(['txtPartno', '', 'part', 'noa,part', 'txtPartno,txtPart', 'part_b.aspx'],
		    				 ['txtSname', '', 'sss', 'namea,partno,part', 'txtSname', 'sss_b.aspx']
		    				);
		    $(document).ready(function () {
		        main();
		    });         /// end ready
		
		    function main() {
		        mainSeek();
		        q_gf('', q_name);
		    }
            function q_gfPost() {
                q_getFormat();
                q_langShow();
                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
                q_mask(bbmMask);
                q_gt('part', '', 0, 0, 0, "");
				q_gt('store', '', 0, 0, 0, "");
                $('#txtBdate').focus();
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
                    case 'store':
                        var t_store = '@全部';
                        var as = _q_appendData("store", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_store += (t_store.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].part;
                        }
                        q_cmbParse("cmbStore", t_store);
                        break;
                }
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
		        t_driverno = $('#txtDriverno').val();
		        t_driver = $('#txtDriver').val();
		        t_custno = $('#txtCustno').val();
		        t_comp = $('#txtComp').val();
		        t_carno = $('#txtCarno').val();
		        t_po = $('#txtPo').val();
		        t_caseno = $('#txtCaseno').val();
		        t_straddrno = $('#txtStraddrno').val();

		        t_bdate = $('#txtBdate').val();
		        t_edate = $('#txtEdate').val();
		        ;
		        t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
		        /// 100.  .
		        t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;
		        /// 100.  .
		        t_btrandate = $('#txtBtrandate').val();
		        t_etrandate = $('#txtEtrandate').val();
		        t_btrandate = t_btrandate.length > 0 && t_btrandate.indexOf("_") > -1 ? t_btrandate.substr(0, t_btrandate.indexOf("_")) : t_btrandate;
		        /// 100.  .
		        t_etrandate = t_etrandate.length > 0 && t_etrandate.indexOf("_") > -1 ? t_etrandate.substr(0, t_etrandate.indexOf("_")) : t_etrandate;
		        /// 100.  .
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
		        + q_sqlPara_or(["caseno", "caseno2"], t_caseno) + q_sqlPara2("driverno", t_driverno) + q_sqlPara2("driver", t_driver) + q_sqlPara2("custno", t_custno) + q_sqlPara2("straddrno", t_straddrno) + q_sqlPara2("comp", t_comp) + q_sqlPara2("carno", t_carno) + q_sqlPara2("po", t_po);
		       	if(t_trd=='Y')
		       		t_where += " and len(trdno)>0"
		       	if(t_trd=='N')
		       		t_where += " and len(trdno)=0"
		       	if(t_tre=='Y')
		       		t_where += " and len(treno)>0"
		       	if(t_tre=='N')
		       		t_where += " and len(treno)=0"	
		       		
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
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
					<input class="txt" id="txtDriverno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtDriver" type="text" style="width:115px;font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtComp" type="text" style="width:115px;font-size:medium;" />
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
