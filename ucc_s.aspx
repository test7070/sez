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
		    var q_name = "ucc_s";
			aPop = new Array(['txtNoa', '', 'ucc', 'noa,product', 'txtNoa,txtProduct', "ucc_b.aspx"]);
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
				
				q_cmbParse("cmbTypea", '@全部,' + q_getPara('uca.typea'));
				q_gt('uccga', '', 0, 0, 0, "");
				
		        $('#txtBdate').focus();
		    }
		
		    function q_seekStr() {   
		        t_noa = $('#txtNoa').val();  
				t_product = $('#txtProduct').val();
		
		        var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) +q_sqlPara2("product", t_product);
		
		        t_where = ' where=^^' + t_where + '^^ ';
		        return t_where;
		    }
		    
		    function q_gtPost(s2){
				switch(s2){
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
				}
			}
</script>
<style type="text/css">
    .seek_tr
    {color:white; text-align:center; font-weight:bold;BACKGROUND-COLOR: #76a2fe}
</style>
</head>
<body>
<div style='width:400px; text-align:center;padding:15px;' >
       <table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
            <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
                <td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
            </tr>
             <tr class='seek_tr'>
                <td class='seek'  style="width:20%;"><a id='lblItem'></a></td>
                <td><input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" /></td>
             </tr>
             <tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;" > </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblGroupano'> </a></td>
					<td><select id="cmbGroupano" style="width:215px; font-size:medium;" > </select></td>
				</tr>
        </table>
  <!--#include file="../inc/seek_ctrl.inc"--> 
</div>
</body>
</html>
