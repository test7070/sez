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
		<script type="text/javascript">
            var q_name = "ucc_s";
            aPop = new Array(
            	['txtNoa', '', 'ucc', 'noa,product,spec', 'txtNoa,txtProduct', "ucc_b.aspx"],
            	['txtTggno', 'lblTgg', 'tgg', 'noa,nick', 'txtTggno', 'tgg_b.aspx']
            );
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

                q_cmbParse("cmbTypea", '@全部,' + q_getPara('uca.typea'));
                
                if(q_getPara('sys.project').toUpperCase()=='AD' || q_getPara('sys.project').toUpperCase()=='JO'){
					q_gt('uccga', "where=^^noa >= '50' ^^", 0, 0, 0, "");
					q_gt('uccgb', "where=^^noa >= '50' ^^", 0, 0, 0, "");
				}else{
	                q_gt('uccga', '', 0, 0, 0, "");
	                q_gt('uccgb', '', 0, 0, 0, "");
	             }
	             q_gt('uccgc', '', 0, 0, 0, "");

                $('#txtBdate').focus();
                
                if (q_getPara('sys.project').toUpperCase()=='XY'){
                	$('#txtStyle').hide();
                	$('#cmbStyle').show();
                	q_cmbParse("cmbStyle",'@全部,便品,空白,公版,加工,印刷,私-空白,新版,改版,新版數位樣,新版正式樣,改版數位樣,改版正式樣');
                }
            }

            function q_seekStr() {
                var t_noa = $('#txtNoa').val();
                var t_product = $('#txtProduct').val();
                var t_style = $('#txtStyle').val();
                var t_spec = $('#txtSpec').val();
                var t_typea = $('#cmbTypea').val();
                var t_groupano = $('#cmbGroupano').val();
                var t_groupbno = $('#cmbGroupbno').val();
                var t_groupcno = $('#cmbGroupcno').val();
                var t_tggno = $('#txtTggno').val();
				var t_tgg = $('#txtTgg').val();

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("style", t_style) + q_sqlPara2("typea", t_typea) 
                + q_sqlPara2("groupano", t_groupano)+ q_sqlPara2("groupbno", t_groupbno)+ q_sqlPara2("groupcno", t_groupcno)
                + q_sqlPara2("tggno", t_tggno);
                
                if (t_product.length > 0)
                    t_where = t_where + " and charindex(N'" + t_product + "',product)>0 ";
                if (t_spec.length > 0)
                    t_where = t_where + " and charindex(N'" + t_spec + "',spec)>0 ";
                if (t_tgg.length > 0)
					t_where += " and charindex(N'" + t_tgg + "',tgg)>0";
                
                if (q_getPara('sys.project').toUpperCase()=='XY' && $('#cmbStyle').val().length>0){
                	t_where = t_where + " and style='"+$('#cmbStyle').val()+"' ";
                }

                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }

            function q_gtPost(s2) {
                switch(s2) {
                    case 'uccga':
                        var as = _q_appendData("uccga", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                            }
                            q_cmbParse("cmbGroupano", t_item);
                        }
                        break;
					case 'uccgb':
                        var as = _q_appendData("uccgb", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                            }
                            q_cmbParse("cmbGroupbno", t_item);
                        }
                        break;
					case 'uccgc':
                        var as = _q_appendData("uccgc", "", true);
                        if (as[0] != undefined) {
                            var t_item = "@";
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].noa + ' . ' + as[i].namea;
                            }
                            q_cmbParse("cmbGroupcno", t_item);
                        }
                        break;
                }
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProduct'> </a></td>
					<td><input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSpec'> </a></td>
					<td><input class="txt" id="txtSpec" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblStyle'> </a></td>
					<td>
						<input class="txt" id="txtStyle" type="text" style="width:215px; font-size:medium;" />
						<select id="cmbStyle" style="width:215px; font-size:medium;display: none;"> </select>
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupano'> </a></td>
					<td><select id="cmbGroupano" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupbno'> </a></td>
					<td><select id="cmbGroupbno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupcno'> </a></td>
					<td><select id="cmbGroupcno" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'><a id='lblTggno'> </a></td>
					<td>
						<input class="txt" id="txtTggno" type="text" style="width:80px; font-size:medium;" />
						<input class="txt" id="txtTgg" type="text" style="width:105px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
