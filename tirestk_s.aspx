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
            var q_name = "tirestk_s";
            var aPop = new Array(['txtFixtggno', '', 'tgg', 'noa,comp', 'txtFixtggno,txtFixtgg', 'tgg_b.aspx'],
            ['txtCarplate', 'lblCarplate', 'carplate', 'noa,carplate,driver', 'txtCarplate', 'carplate_b.aspx'],
            ['txtCarno', 'lblCarno', 'car2', 'a.noa','txtCarno', 'car2_b.aspx'],
            ['txtProductno', '', 'fixucc', 'noa,namea', 'txtProductno', 'fixucc_b.aspx']);
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

                /*bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd]];
        
				q_mask(bbmMask);
        		$('#txtBdate').focus();
                bbmMask = [['txtBtrandate', r_picd], ['txtEtrandate', r_picd]];
                q_mask(bbmMask);

                $('#txtBtrandate').focus();*/
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_productno = $('#txtProductno').val();
                t_product = $('#txtProduct').val();
                t_carno = $('#txtCarno').val();
                t_carplate = $('#txtCarplate').val();
                t_fixtggno = $('#txtFixtggno').val();
                t_fixtgg = $('#txtFixtgg').val();

                

                var t_where = " 1=1 " + q_sqlPara2("noa", t_noa)+ q_sqlPara2("productno", t_productno)+ q_sqlPara2("product", t_product) + q_sqlPara2("carno", t_carno) + 
                q_sqlPara2("carplateno", t_carplate) + q_sqlPara2("fixtggno", t_fixtggno) + q_sqlPara2("fixtgg", t_fixtgg);

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
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProductno'></a></td>
					<td>
					<input class="txt" id="txtProductno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblProduct'></a></td>
					<td>
					<input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarno'></a></td>
					<td>
					<input class="txt" id="txtCarno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCarplate'></a></td>
					<td>
					<input class="txt" id="txtCarplate" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblFixtgg'></a></td>
					<td>
					<input class="txt" id="txtFixtggno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtFixtgg" type="text" style="width:115px;font-size:medium;" />
					</td>
				</tr>
				
				
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
